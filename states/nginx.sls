{% set release = salt['grains.get']('lsb_distrib_codename', 'yakkety') %}
{% set nginxver = salt['pillar.get']('versions:nginx') %}

NGINX Package Repository:
  pkgrepo.managed:
    - humanname: NGINX Package Repository
    - name: deb http://nginx.org/packages/mainline/ubuntu {{ release }} nginx
    - dist: {{ release }}
    - file: /etc/apt/sources.list.d/nginx-oss.list
    - clean_file: True
    - gpgcheck: 1
    - keyid: '0xABF5BD827BD9BF62'
    - keyserver: hkps.pool.sks-keyservers.net

NGINX Package:
  pkg.installed:
    - name: nginx
    - version: {{ nginxver }}-1~{{ release }}
    - require:
      - pkgrepo: NGINX Package Repository

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://files/etc/nginx/nginx.conf

/etc/nginx/modsec/main.conf:
  file.managed:
    - source: salt://files/etc/nginx/modsec/main.conf

/etc/nginx/modsec/modsecurity.conf:
  file.managed:
    - source: salt://files/etc/nginx/modsec/modsecurity.conf