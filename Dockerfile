FROM python:3.7.13-alpine3.16

LABEL maintainer="verybadsoldier"
LABEL description="Gather statistics from iptables and ipset and publish via MQTT"
LABEL vcs-url="https://github.com/verybadsoldier/docker-iptables_stats"


COPY . /app

RUN apk add --virtual mypackages build-base libc6-compat iptables iptables-dev ipset bash && \
    cd /app && pip install . && rm -rf /app && \
    apk del mypackages && \
    rm -rf /var/cache/apk/*

# some vars to also support loading correct dynamic libraries
ENV XTABLES_LIBDIR=/usr/lib/xtables
ENV PYTHON_IPTABLES_XTABLES_VERSION=12
ENV IPTABLES_LIBDIR=/usr/lib

CMD iptables_stats
