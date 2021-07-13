#!/bin/bash
if [ $LIBP2P_PORT != "" ];then
        sed -i '/AnnounceAddresses/d' /data/miner/config.toml
        VALID_CHECK=$(echo $LIBP2P_IP|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
	if [ ! $VALID_CHECK ];then
                        echo "$LIBP2P_IP"|awk -F "." '{print $NF}'|grep [a-zA-Z] >/dev/null && sed -i '/Libp2p/!b;n;c\   ListenAddresses = ["/ip4/0.0.0.0/tcp/2458"]\n   AnnounceAddresses = ["/dnsaddr/'${LIBP2P_IP}'/tcp/'${LIBP2P_PORT}'"]' /data/miner/config.toml||echo "IP ERROR"
        fi
        if echo $LIBP2P_IP|grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$">/dev/null; then
                if [ ${VALID_CHECK:-no} == "yes" ]; then
                        sed -i '/Libp2p/!b;n;c\   ListenAddresses = ["/ip4/0.0.0.0/tcp/2458"]\n   AnnounceAddresses = ["/ip4/'${LIBP2P_IP}'/tcp/'${LIBP2P_PORT}'"]' /data/miner/config.toml

                fi
        fi
fi
/usr/local/bin/epik-miner run --nosync