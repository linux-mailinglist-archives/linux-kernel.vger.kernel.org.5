Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2642A7C7A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443066AbjJLXKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443024AbjJLXKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:10:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A85CA;
        Thu, 12 Oct 2023 16:10:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so15859655e9.1;
        Thu, 12 Oct 2023 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697152233; x=1697757033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQsJgsOhUnGq1lc4pv+AlfufoXeGee30iTtKnLN7FOs=;
        b=Mz7WpNmoRfNDD7n7/f99AX3OY2g+H1QX/YqORq7It2acmiAfRIPAV8r43QXLL671Fa
         T4OJjNNbLcz8+hWvx+ahfg7A403vOHKAQxkzhrlpKxDMrRjrOAFYWnxmAcCNY0Ze5uxO
         85Jot1I6ewZyeF7XiiEhoNcexA0HK/uoNmGifslLuPgf0rIyxdOxKBy9kfEEIE7ZPM5c
         CGEgDdKn9orBcu5lDLchf/fVLGKjnxT0ndfKw/5N9bZt3fAQZf9UDtHBKdfKXpwi1Bwb
         RfcqIsmXUz4wYBwaZf5pyYM8Bdd7hjUwzAF/mnMy1u7qeLqELpE5rWyx1sJcsp4MI5G0
         aoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697152233; x=1697757033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQsJgsOhUnGq1lc4pv+AlfufoXeGee30iTtKnLN7FOs=;
        b=ZkT5aBHEEgi0wfO4wCbf3MRkcDJT4F/0G/+Z6CZJClnZ5ua2k+A+72dPCYYezfbV5m
         GWVCd9nw1WSvIz0dvpAcQukuajbrb9Ph/86AH3/yaieATn2t1nwomGWBJnYrX4iPCXlh
         DMjLutO7zCYroj5btnU3G9izdPvZ1TLF5dp+sw6iSZHZuSrkrMIarBsIcIXedK/bGjcT
         a79qnpxBfanFt4eNdIYb3XItOk1qfvWXXCPXsRS4GutInjuGzESTcSsNltC3PW1VzYBl
         26ER6VVg6uDJnlS6aZ3k0U1B5s413x3NPHGq0XTvkAhAwXwJw1W1jvKFwWi6z1c1Uf0L
         IjcQ==
X-Gm-Message-State: AOJu0Yy+EwPzr6Eyw7gYllgRJLplngXz7AonbT+A1DZ9eIHmV3QoxY/d
        yLt2KWinMLwgPQ6POIj5SIo=
X-Google-Smtp-Source: AGHT+IGgfJAsiycNUXwpXTa5pZoH6T+jOAPd8S26XB/OuH3abDelVCbRyWgxo7P8dA19vbA9dvneDw==
X-Received: by 2002:a7b:cb89:0:b0:406:54e4:359c with SMTP id m9-20020a7bcb89000000b0040654e4359cmr22122192wmi.19.1697152231691;
        Thu, 12 Oct 2023 16:10:31 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d644e000000b003231ca246b6sm3598884wrw.95.2023.10.12.16.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:10:31 -0700 (PDT)
Date:   Fri, 13 Oct 2023 02:10:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231012231029.tqz3e5dnlvbmcmja@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
 <20231011222026.4181654-1-florian.fainelli@broadcom.com>
 <20231011222026.4181654-2-florian.fainelli@broadcom.com>
 <20231011222026.4181654-2-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011222026.4181654-2-florian.fainelli@broadcom.com>
 <20231011222026.4181654-2-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:20:25PM -0700, Florian Fainelli wrote:
> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> diff --git a/Documentation/networking/dsa/bcm_sf2.rst b/Documentation/networking/dsa/bcm_sf2.rst
> index dee234039e1e..ed8582841561 100644
> --- a/Documentation/networking/dsa/bcm_sf2.rst
> +++ b/Documentation/networking/dsa/bcm_sf2.rst
> @@ -67,7 +67,7 @@ MDIO indirect accesses
>  ----------------------
>  
>  Due to a limitation in how Broadcom switches have been designed, external
> -Broadcom switches connected to a SF2 require the use of the DSA slave MDIO bus
> +Broadcom switches connected to a SF2 require the use of the DSA  MDIO bus

replacement word went missing here

>  in order to properly configure them. By default, the SF2 pseudo-PHY address, and
>  an external switch pseudo-PHY address will both be snooping for incoming MDIO
>  transactions, since they are at the same address (30), resulting in some kind of
> diff --git a/Documentation/networking/dsa/configuration.rst b/Documentation/networking/dsa/configuration.rst
> index d2934c40f0f1..a5a38c31736d 100644
> --- a/Documentation/networking/dsa/configuration.rst
> +++ b/Documentation/networking/dsa/configuration.rst
> @@ -380,30 +380,30 @@ affinities according to the available CPU ports.
>  
>  Secondly, it is possible to perform load balancing between CPU ports on a per
>  packet basis, rather than statically assigning user ports to CPU ports.
> -This can be achieved by placing the DSA masters under a LAG interface (bonding
> +This can be achieved by placing the DSA conduits under a LAG interface (bonding
>  or team). DSA monitors this operation and creates a mirror of this software LAG
> -on the CPU ports facing the physical DSA masters that constitute the LAG slave
> +on the CPU ports facing the physical DSA conduits that constitute the LAG user

Replacing "LAG slave devices" with "LAG user devices" wasn't warranted,
and it alters the meaning.

>  devices.
>  
>  To make use of multiple CPU ports, the firmware (device tree) description of
> -the switch must mark all the links between CPU ports and their DSA masters
> +the switch must mark all the links between CPU ports and their DSA conduits
>  using the ``ethernet`` reference/phandle. At startup, only a single CPU port
> -and DSA master will be used - the numerically first port from the firmware
> +and DSA conduit will be used - the numerically first port from the firmware
>  description which has an ``ethernet`` property. It is up to the user to
> -configure the system for the switch to use other masters.
> +configure the system for the switch to use other conduits.
>  
>  DSA uses the ``rtnl_link_ops`` mechanism (with a "dsa" ``kind``) to allow
> -changing the DSA master of a user port. The ``IFLA_DSA_MASTER`` u32 netlink
> -attribute contains the ifindex of the master device that handles each slave
> -device. The DSA master must be a valid candidate based on firmware node
> -information, or a LAG interface which contains only slaves which are valid
> +changing the DSA conduit of a user port. The ``IFLA_DSA_MASTER`` u32 netlink
> +attribute contains the ifindex of the conduit device that handles each user
> +device. The DSA conduit must be a valid candidate based on firmware node
> +information, or a LAG interface which contains only users which are valid

Again, "LAG interface which contains only slaves" wasn't the subject of
this change, since it refers to the bond/team lower devices.

>  candidates.
>  
>  Using iproute2, the following manipulations are possible:
>  
>    .. code-block:: sh
>  
> -    # See the DSA master in current use
> +    # See the DSA conduit in current use
>      ip -d link show dev swp0
>          (...)
>          dsa master eth0
> @@ -414,7 +414,7 @@ Using iproute2, the following manipulations are possible:
>      ip link set swp2 type dsa master eth1
>      ip link set swp3 type dsa master eth0
>  
> -    # CPU ports in LAG, using explicit assignment of the DSA master
> +    # CPU ports in LAG, using explicit assignment of the DSA conduit
>      ip link add bond0 type bond mode balance-xor && ip link set bond0 up
>      ip link set eth1 down && ip link set eth1 master bond0
>      ip link set swp0 type dsa master bond0
> @@ -426,7 +426,7 @@ Using iproute2, the following manipulations are possible:
>          (...)
>          dsa master bond0
>  
> -    # CPU ports in LAG, relying on implicit migration of the DSA master
> +    # CPU ports in LAG, relying on implicit migration of the DSA conduit
>      ip link add bond0 type bond mode balance-xor && ip link set bond0 up
>      ip link set eth0 down && ip link set eth0 master bond0
>      ip link set eth1 down && ip link set eth1 master bond0
> @@ -436,23 +436,23 @@ Using iproute2, the following manipulations are possible:
>  
>  Notice that in the case of CPU ports under a LAG, the use of the
>  ``IFLA_DSA_MASTER`` netlink attribute is not strictly needed, but rather, DSA
> -reacts to the ``IFLA_MASTER`` attribute change of its present master (``eth0``)
> +reacts to the ``IFLA_MASTER`` attribute change of its present conduit (``eth0``)
>  and migrates all user ports to the new upper of ``eth0``, ``bond0``. Similarly,
>  when ``bond0`` is destroyed using ``RTM_DELLINK``, DSA migrates the user ports
> -that were assigned to this interface to the first physical DSA master which is
> +that were assigned to this interface to the first physical DSA conduit which is
>  eligible, based on the firmware description (it effectively reverts to the
>  startup configuration).
>  
>  In a setup with more than 2 physical CPU ports, it is therefore possible to mix
> -static user to CPU port assignment with LAG between DSA masters. It is not
> -possible to statically assign a user port towards a DSA master that has any
> -upper interfaces (this includes LAG devices - the master must always be the LAG
> +static user to CPU port assignment with LAG between DSA conduits. It is not
> +possible to statically assign a user port towards a DSA conduit that has any
> +upper interfaces (this includes LAG devices - the conduit must always be the LAG
>  in this case).
>  
> -Live changing of the DSA master (and thus CPU port) affinity of a user port is
> +Live changing of the DSA conduit (and thus CPU port) affinity of a user port is
>  permitted, in order to allow dynamic redistribution in response to traffic.
>  
> -Physical DSA masters are allowed to join and leave at any time a LAG interface
> -used as a DSA master; however, DSA will reject a LAG interface as a valid
> -candidate for being a DSA master unless it has at least one physical DSA master
> -as a slave device.
> +Physical DSA conduits are allowed to join and leave at any time a LAG interface
> +used as a DSA conduit; however, DSA will reject a LAG interface as a valid
> +candidate for being a DSA conduit unless it has at least one physical DSA conduit
> +as a user device.

Again, please restore this to "LAG interface (...) has (...) a slave device".

> diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
> index a94ddf83348a..64e169060ca8 100644
> --- a/Documentation/networking/dsa/dsa.rst
> +++ b/Documentation/networking/dsa/dsa.rst
> @@ -25,7 +25,7 @@ presence of a management port connected to an Ethernet controller capable of
>  receiving Ethernet frames from the switch. This is a very common setup for all
>  kinds of Ethernet switches found in Small Home and Office products: routers,
>  gateways, or even top-of-rack switches. This host Ethernet controller will
> -be later referred to as "master" and "cpu" in DSA terminology and code.
> +be later referred to as "conduit" and "cpu" in DSA terminology and code.
>  
>  The D in DSA stands for Distributed, because the subsystem has been designed
>  with the ability to configure and manage cascaded switches on top of each other
> @@ -35,7 +35,7 @@ of multiple switches connected to each other is called a "switch tree".
>  
>  For each front-panel port, DSA creates specialized network devices which are
>  used as controlling and data-flowing endpoints for use by the Linux networking
> -stack. These specialized network interfaces are referred to as "slave" network
> +stack. These specialized network interfaces are referred to as "user" network
>  interfaces in DSA terminology and code.
>  
>  The ideal case for using DSA is when an Ethernet switch supports a "switch tag"
> @@ -56,7 +56,7 @@ Note that DSA does not currently create network interfaces for the "cpu" and
>  
>  - the "cpu" port is the Ethernet switch facing side of the management
>    controller, and as such, would create a duplication of feature, since you
> -  would get two interfaces for the same conduit: master netdev, and "cpu" netdev
> +  would get two interfaces for the same conduit: conduit netdev, and "cpu" netdev
>  
>  - the "dsa" port(s) are just conduits between two or more switches, and as such
>    cannot really be used as proper network interfaces either, only the
> @@ -80,14 +80,14 @@ methods of the ``struct dsa_device_ops`` structure, which are detailed below.
>  Tagging protocols generally fall in one of three categories:
>  
>  1. The switch-specific frame header is located before the Ethernet header,
> -   shifting to the right (from the perspective of the DSA master's frame
> +   shifting to the right (from the perspective of the DSA conduit's frame
>     parser) the MAC DA, MAC SA, EtherType and the entire L2 payload.
>  2. The switch-specific frame header is located before the EtherType, keeping
> -   the MAC DA and MAC SA in place from the DSA master's perspective, but
> +   the MAC DA and MAC SA in place from the DSA conduit's perspective, but
>     shifting the 'real' EtherType and L2 payload to the right.
>  3. The switch-specific frame header is located at the tail of the packet,
>     keeping all frame headers in place and not altering the view of the packet
> -   that the DSA master's frame parser has.
> +   that the DSA conduit's frame parser has.
>  
>  A tagging protocol may tag all packets with switch tags of the same length, or
>  the tag length might vary (for example packets with PTP timestamps might
> @@ -95,7 +95,7 @@ require an extended switch tag, or there might be one tag length on TX and a
>  different one on RX). Either way, the tagging protocol driver must populate the
>  ``struct dsa_device_ops::needed_headroom`` and/or ``struct dsa_device_ops::needed_tailroom``
>  with the length in octets of the longest switch frame header/trailer. The DSA
> -framework will automatically adjust the MTU of the master interface to
> +framework will automatically adjust the MTU of the conduit interface to
>  accommodate for this extra size in order for DSA user ports to support the
>  standard MTU (L2 payload length) of 1500 octets. The ``needed_headroom`` and
>  ``needed_tailroom`` properties are also used to request from the network stack,
> @@ -140,18 +140,18 @@ adding or removing the ``ETH_P_EDSA`` EtherType and some padding octets).
>  It is possible to construct cascaded setups of DSA switches even if their
>  tagging protocols are not compatible with one another. In this case, there are
>  no DSA links in this fabric, and each switch constitutes a disjoint DSA switch
> -tree. The DSA links are viewed as simply a pair of a DSA master (the out-facing
> +tree. The DSA links are viewed as simply a pair of a DSA conduit (the out-facing
>  port of the upstream DSA switch) and a CPU port (the in-facing port of the
>  downstream DSA switch).
>  
>  The tagging protocol of the attached DSA switch tree can be viewed through the
> -``dsa/tagging`` sysfs attribute of the DSA master::
> +``dsa/tagging`` sysfs attribute of the DSA conduit::
>  
>      cat /sys/class/net/eth0/dsa/tagging
>  
>  If the hardware and driver are capable, the tagging protocol of the DSA switch
>  tree can be changed at runtime. This is done by writing the new tagging
> -protocol name to the same sysfs device attribute as above (the DSA master and
> +protocol name to the same sysfs device attribute as above (the DSA conduit and
>  all attached switch ports must be down while doing this).
>  
>  It is desirable that all tagging protocols are testable with the ``dsa_loop``
> @@ -159,7 +159,7 @@ mockup driver, which can be attached to any network interface. The goal is that
>  any network interface should be capable of transmitting the same packet in the
>  same way, and the tagger should decode the same received packet in the same way
>  regardless of the driver used for the switch control path, and the driver used
> -for the DSA master.
> +for the DSA conduit.
>  
>  The transmission of a packet goes through the tagger's ``xmit`` function.
>  The passed ``struct sk_buff *skb`` has ``skb->data`` pointing at
> @@ -183,44 +183,44 @@ virtual DSA user network interface corresponding to the physical front-facing
>  switch port that the packet was received on.
>  
>  Since tagging protocols in category 1 and 2 break software (and most often also
> -hardware) packet dissection on the DSA master, features such as RPS (Receive
> -Packet Steering) on the DSA master would be broken. The DSA framework deals
> +hardware) packet dissection on the DSA conduit, features such as RPS (Receive
> +Packet Steering) on the DSA conduit would be broken. The DSA framework deals
>  with this by hooking into the flow dissector and shifting the offset at which
> -the IP header is to be found in the tagged frame as seen by the DSA master.
> +the IP header is to be found in the tagged frame as seen by the DSA conduit.
>  This behavior is automatic based on the ``overhead`` value of the tagging
>  protocol. If not all packets are of equal size, the tagger can implement the
>  ``flow_dissect`` method of the ``struct dsa_device_ops`` and override this
>  default behavior by specifying the correct offset incurred by each individual
>  RX packet. Tail taggers do not cause issues to the flow dissector.
>  
> -Checksum offload should work with category 1 and 2 taggers when the DSA master
> +Checksum offload should work with category 1 and 2 taggers when the DSA conduit
>  driver declares NETIF_F_HW_CSUM in vlan_features and looks at csum_start and
>  csum_offset. For those cases, DSA will shift the checksum start and offset by
> -the tag size. If the DSA master driver still uses the legacy NETIF_F_IP_CSUM
> +the tag size. If the DSA conduit driver still uses the legacy NETIF_F_IP_CSUM
>  or NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
>  offload hardware already expects that specific tag (perhaps due to matching
> -vendors). DSA slaves inherit those flags from the master port, and it is up to
> +vendors). DSA users inherit those flags from the conduit port, and it is up to

I know this would no longer be a straight replacement, but instead of
"DSA users" and "conduit port" I would say "DSA user ports" and "conduit".

>  the driver to correctly fall back to software checksum when the IP header is not
>  where the hardware expects. If that check is ineffective, the packets might go
>  to the network without a proper checksum (the checksum field will have the
>  pseudo IP header sum). For category 3, when the offload hardware does not
>  already expect the switch tag in use, the checksum must be calculated before any
> -tag is inserted (i.e. inside the tagger). Otherwise, the DSA master would
> +tag is inserted (i.e. inside the tagger). Otherwise, the DSA conduit would
>  include the tail tag in the (software or hardware) checksum calculation. Then,
>  when the tag gets stripped by the switch during transmission, it will leave an
>  incorrect IP checksum in place.
>  
>  Due to various reasons (most common being category 1 taggers being associated
> -with DSA-unaware masters, mangling what the master perceives as MAC DA), the
> -tagging protocol may require the DSA master to operate in promiscuous mode, to
> +with DSA-unaware conduits, mangling what the conduit perceives as MAC DA), the
> +tagging protocol may require the DSA conduit to operate in promiscuous mode, to
>  receive all frames regardless of the value of the MAC DA. This can be done by
> -setting the ``promisc_on_master`` property of the ``struct dsa_device_ops``.
> -Note that this assumes a DSA-unaware master driver, which is the norm.
> +setting the ``promisc_on_conduit`` property of the ``struct dsa_device_ops``.
> +Note that this assumes a DSA-unaware conduit driver, which is the norm.
>  
> -Master network devices
> +Conduit network devices
>  ----------------------
>  
> -Master network devices are regular, unmodified Linux network device drivers for
> +Conduit network devices are regular, unmodified Linux network device drivers for
>  the CPU/management Ethernet interface. Such a driver might occasionally need to
>  know whether DSA is enabled (e.g.: to enable/disable specific offload features),
>  but the DSA subsystem has been proven to work with industry standard drivers:
> @@ -232,14 +232,14 @@ Ethernet switch.
>  Networking stack hooks
>  ----------------------
>  
> -When a master netdev is used with DSA, a small hook is placed in the
> +When a conduit netdev is used with DSA, a small hook is placed in the
>  networking stack is in order to have the DSA subsystem process the Ethernet
>  switch specific tagging protocol. DSA accomplishes this by registering a
>  specific (and fake) Ethernet type (later becoming ``skb->protocol``) with the
>  networking stack, this is also known as a ``ptype`` or ``packet_type``. A typical
>  Ethernet Frame receive sequence looks like this:
>  
> -Master network device (e.g.: e1000e):
> +Conduit network device (e.g.: e1000e):
>  
>  1. Receive interrupt fires:
>  
> @@ -269,16 +269,16 @@ Master network device (e.g.: e1000e):
>  
>          - inspect and strip switch tag protocol to determine originating port
>          - locate per-port network device
> -        - invoke ``eth_type_trans()`` with the DSA slave network device
> +        - invoke ``eth_type_trans()`` with the DSA user network device
>          - invoked ``netif_receive_skb()``
>  
> -Past this point, the DSA slave network devices get delivered regular Ethernet
> +Past this point, the DSA user network devices get delivered regular Ethernet
>  frames that can be processed by the networking stack.
>  
> -Slave network devices
> +User network devices
>  ---------------------
>  
> -Slave network devices created by DSA are stacked on top of their master network
> +User network devices created by DSA are stacked on top of their conduit network
>  device, each of these network interfaces will be responsible for being a
>  controlling and data-flowing end-point for each front-panel port of the switch.
>  These interfaces are specialized in order to:
> @@ -289,31 +289,31 @@ These interfaces are specialized in order to:
>    Wake-on-LAN, register dumps...
>  - manage external/internal PHY: link, auto-negotiation, etc.
>  
> -These slave network devices have custom net_device_ops and ethtool_ops function
> +These user network devices have custom net_device_ops and ethtool_ops function
>  pointers which allow DSA to introduce a level of layering between the networking
>  stack/ethtool and the switch driver implementation.
>  
> -Upon frame transmission from these slave network devices, DSA will look up which
> +Upon frame transmission from these user network devices, DSA will look up which
>  switch tagging protocol is currently registered with these network devices and
>  invoke a specific transmit routine which takes care of adding the relevant
>  switch tag in the Ethernet frames.
>  
> -These frames are then queued for transmission using the master network device
> +These frames are then queued for transmission using the conduit network device
>  ``ndo_start_xmit()`` function. Since they contain the appropriate switch tag, the
>  Ethernet switch will be able to process these incoming frames from the
>  management interface and deliver them to the physical switch port.
>  
>  When using multiple CPU ports, it is possible to stack a LAG (bonding/team)
> -device between the DSA slave devices and the physical DSA masters. The LAG
> -device is thus also a DSA master, but the LAG slave devices continue to be DSA
> -masters as well (just with no user port assigned to them; this is needed for
> -recovery in case the LAG DSA master disappears). Thus, the data path of the LAG
> -DSA master is used asymmetrically. On RX, the ``ETH_P_XDSA`` handler, which
> -calls ``dsa_switch_rcv()``, is invoked early (on the physical DSA master;
> -LAG slave). Therefore, the RX data path of the LAG DSA master is not used.
> -On the other hand, TX takes place linearly: ``dsa_slave_xmit`` calls
> -``dsa_enqueue_skb``, which calls ``dev_queue_xmit`` towards the LAG DSA master.
> -The latter calls ``dev_queue_xmit`` towards one physical DSA master or the
> +device between the DSA user devices and the physical DSA conduits. The LAG
> +device is thus also a DSA conduit, but the LAG user devices continue to be DSA

"LAG slave devices" remain that way, sorry.

> +conduits as well (just with no user port assigned to them; this is needed for
> +recovery in case the LAG DSA conduit disappears). Thus, the data path of the LAG
> +DSA conduit is used asymmetrically. On RX, the ``ETH_P_XDSA`` handler, which
> +calls ``dsa_switch_rcv()``, is invoked early (on the physical DSA conduit;
> +LAG user). Therefore, the RX data path of the LAG DSA conduit is not used.

"LAG slave"

> +On the other hand, TX takes place linearly: ``dsa_user_xmit`` calls
> +``dsa_enqueue_skb``, which calls ``dev_queue_xmit`` towards the LAG DSA conduit.
> +The latter calls ``dev_queue_xmit`` towards one physical DSA conduit or the
>  other, and in both cases, the packet exits the system through a hardware path
>  towards the switch.
>  
> @@ -352,11 +352,11 @@ perspective::
>             || swp0 | | swp1 | | swp2 | | swp3 ||
>             ++------+-+------+-+------+-+------++
>  
> -Slave MDIO bus
> +User MDIO bus
>  --------------
>  
> -In order to be able to read to/from a switch PHY built into it, DSA creates a
> -slave MDIO bus which allows a specific switch driver to divert and intercept
> +In order to be able to read to/from a switch PHY built into it, DSA creates an
> +user MDIO bus which allows a specific switch driver to divert and intercept
>  MDIO reads/writes towards specific PHY addresses. In most MDIO-connected
>  switches, these functions would utilize direct or indirect PHY addressing mode
>  to return standard MII registers from the switch builtin PHYs, allowing the PHY
> @@ -364,7 +364,7 @@ library and/or to return link status, link partner pages, auto-negotiation
>  results, etc.
>  
>  For Ethernet switches which have both external and internal MDIO buses, the
> -slave MII bus can be utilized to mux/demux MDIO reads and writes towards either
> +user MII bus can be utilized to mux/demux MDIO reads and writes towards either
>  internal or external MDIO devices this switch might be connected to: internal
>  PHYs, external PHYs, or even external switches.
>  
> @@ -381,10 +381,10 @@ DSA data structures are defined in ``include/net/dsa.h`` as well as
>  
>  - ``dsa_platform_data``: platform device configuration data which can reference
>    a collection of dsa_chip_data structures if multiple switches are cascaded,
> -  the master network device this switch tree is attached to needs to be
> +  the conduit network device this switch tree is attached to needs to be
>    referenced
>  
> -- ``dsa_switch_tree``: structure assigned to the master network device under
> +- ``dsa_switch_tree``: structure assigned to the conduit network device under
>    ``dsa_ptr``, this structure references a dsa_platform_data structure as well as
>    the tagging protocol supported by the switch tree, and which receive/transmit
>    function hooks should be invoked, information about the directly attached
> @@ -392,7 +392,7 @@ DSA data structures are defined in ``include/net/dsa.h`` as well as
>    referenced to address individual switches in the tree.
>  
>  - ``dsa_switch``: structure describing a switch device in the tree, referencing
> -  a ``dsa_switch_tree`` as a backpointer, slave network devices, master network
> +  a ``dsa_switch_tree`` as a backpointer, user network devices, conduit network
>    device, and a reference to the backing``dsa_switch_ops``
>  
>  - ``dsa_switch_ops``: structure referencing function pointers, see below for a
> @@ -404,7 +404,7 @@ Design limitations
>  Lack of CPU/DSA network devices
>  -------------------------------
>  
> -DSA does not currently create slave network devices for the CPU or DSA ports, as
> +DSA does not currently create user network devices for the CPU or DSA ports, as
>  described before. This might be an issue in the following cases:
>  
>  - inability to fetch switch CPU port statistics counters using ethtool, which
> @@ -419,7 +419,7 @@ described before. This might be an issue in the following cases:
>  Common pitfalls using DSA setups
>  --------------------------------
>  
> -Once a master network device is configured to use DSA (dev->dsa_ptr becomes
> +Once a conduit network device is configured to use DSA (dev->dsa_ptr becomes
>  non-NULL), and the switch behind it expects a tagging protocol, this network
>  interface can only exclusively be used as a conduit interface. Sending packets
>  directly through this interface (e.g.: opening a socket using this interface)
> @@ -440,7 +440,7 @@ DSA currently leverages the following subsystems:
>  MDIO/PHY library
>  ----------------
>  
> -Slave network devices exposed by DSA may or may not be interfacing with PHY
> +User network devices exposed by DSA may or may not be interfacing with PHY
>  devices (``struct phy_device`` as defined in ``include/linux/phy.h)``, but the DSA
>  subsystem deals with all possible combinations:
>  
> @@ -450,7 +450,7 @@ subsystem deals with all possible combinations:
>  - special, non-autonegotiated or non MDIO-managed PHY devices: SFPs, MoCA; a.k.a
>    fixed PHYs
>  
> -The PHY configuration is done by the ``dsa_slave_phy_setup()`` function and the
> +The PHY configuration is done by the ``dsa_user_phy_setup()`` function and the
>  logic basically looks like this:
>  
>  - if Device Tree is used, the PHY device is looked up using the standard
> @@ -463,7 +463,7 @@ logic basically looks like this:
>    and connected transparently using the special fixed MDIO bus driver
>  
>  - finally, if the PHY is built into the switch, as is very common with
> -  standalone switch packages, the PHY is probed using the slave MII bus created
> +  standalone switch packages, the PHY is probed using the user MII bus created
>    by DSA
>  
>  
> @@ -472,7 +472,7 @@ SWITCHDEV
>  
>  DSA directly utilizes SWITCHDEV when interfacing with the bridge layer, and
>  more specifically with its VLAN filtering portion when configuring VLANs on top
> -of per-port slave network devices. As of today, the only SWITCHDEV objects
> +of per-port user network devices. As of today, the only SWITCHDEV objects
>  supported by DSA are the FDB and VLAN objects.
>  
>  Devlink
> @@ -589,8 +589,8 @@ is torn down when the first switch unregisters.
>  It is mandatory for DSA switch drivers to implement the ``shutdown()`` callback
>  of their respective bus, and call ``dsa_switch_shutdown()`` from it (a minimal
>  version of the full teardown performed by ``dsa_unregister_switch()``).
> -The reason is that DSA keeps a reference on the master net device, and if the
> -driver for the master device decides to unbind on shutdown, DSA's reference
> +The reason is that DSA keeps a reference on the conduit net device, and if the
> +driver for the conduit device decides to unbind on shutdown, DSA's reference
>  will block that operation from finalizing.
>  
>  Either ``dsa_switch_shutdown()`` or ``dsa_unregister_switch()`` must be called,
> @@ -615,7 +615,7 @@ Switch configuration
>    tag formats.
>  
>  - ``change_tag_protocol``: when the default tagging protocol has compatibility
> -  problems with the master or other issues, the driver may support changing it
> +  problems with the conduit or other issues, the driver may support changing it
>    at runtime, either through a device tree property or through sysfs. In that
>    case, further calls to ``get_tag_protocol`` should report the protocol in
>    current use.
> @@ -643,22 +643,22 @@ Switch configuration
>    PHY cannot be found. In this case, probing of the DSA switch continues
>    without that particular port.
>  
> -- ``port_change_master``: method through which the affinity (association used
> +- ``port_change_conduit``: method through which the affinity (association used
>    for traffic termination purposes) between a user port and a CPU port can be
>    changed. By default all user ports from a tree are assigned to the first
>    available CPU port that makes sense for them (most of the times this means
>    the user ports of a tree are all assigned to the same CPU port, except for H
>    topologies as described in commit 2c0b03258b8b). The ``port`` argument
> -  represents the index of the user port, and the ``master`` argument represents
> -  the new DSA master ``net_device``. The CPU port associated with the new
> -  master can be retrieved by looking at ``struct dsa_port *cpu_dp =
> -  master->dsa_ptr``. Additionally, the master can also be a LAG device where
> -  all the slave devices are physical DSA masters. LAG DSA masters also have a
> -  valid ``master->dsa_ptr`` pointer, however this is not unique, but rather a
> -  duplicate of the first physical DSA master's (LAG slave) ``dsa_ptr``. In case
> -  of a LAG DSA master, a further call to ``port_lag_join`` will be emitted
> +  represents the index of the user port, and the ``conduit`` argument represents
> +  the new DSA conduit ``net_device``. The CPU port associated with the new
> +  conduit can be retrieved by looking at ``struct dsa_port *cpu_dp =
> +  conduit->dsa_ptr``. Additionally, the conduit can also be a LAG device where
> +  all the user devices are physical DSA conduits. LAG DSA conduits also have a

"all the slave devices"

> +  valid ``conduit->dsa_ptr`` pointer, however this is not unique, but rather a
> +  duplicate of the first physical DSA conduit's (LAG user) ``dsa_ptr``. In case

"LAG slave"

> +  of a LAG DSA conduit, a further call to ``port_lag_join`` will be emitted
>    separately for the physical CPU ports associated with the physical DSA
> -  masters, requesting them to create a hardware LAG associated with the LAG
> +  conduits, requesting them to create a hardware LAG associated with the LAG
>    interface.
>  
>  PHY devices and link management
> @@ -670,16 +670,16 @@ PHY devices and link management
>    should return a 32-bit bitmask of "flags" that is private between the switch
>    driver and the Ethernet PHY driver in ``drivers/net/phy/\*``.
>  
> -- ``phy_read``: Function invoked by the DSA slave MDIO bus when attempting to read
> +- ``phy_read``: Function invoked by the DSA user MDIO bus when attempting to read
>    the switch port MDIO registers. If unavailable, return 0xffff for each read.
>    For builtin switch Ethernet PHYs, this function should allow reading the link
>    status, auto-negotiation results, link partner pages, etc.
>  
> -- ``phy_write``: Function invoked by the DSA slave MDIO bus when attempting to write
> +- ``phy_write``: Function invoked by the DSA user MDIO bus when attempting to write
>    to the switch port MDIO registers. If unavailable return a negative error
>    code.
>  
> -- ``adjust_link``: Function invoked by the PHY library when a slave network device
> +- ``adjust_link``: Function invoked by the PHY library when a user network device
>    is attached to a PHY device. This function is responsible for appropriately
>    configuring the switch port link parameters: speed, duplex, pause based on
>    what the ``phy_device`` is providing.
> @@ -698,14 +698,14 @@ Ethtool operations
>    typically return statistics strings, private flags strings, etc.
>  
>  - ``get_ethtool_stats``: ethtool function used to query per-port statistics and
> -  return their values. DSA overlays slave network devices general statistics:
> +  return their values. DSA overlays user network devices general statistics:
>    RX/TX counters from the network device, with switch driver specific statistics
>    per port
>  
>  - ``get_sset_count``: ethtool function used to query the number of statistics items
>  
>  - ``get_wol``: ethtool function used to obtain Wake-on-LAN settings per-port, this
> -  function may for certain implementations also query the master network device
> +  function may for certain implementations also query the conduit network device
>    Wake-on-LAN settings if this interface needs to participate in Wake-on-LAN
>  
>  - ``set_wol``: ethtool function used to configure Wake-on-LAN settings per-port,
> @@ -747,13 +747,13 @@ Power management
>    should resume all Ethernet switch activities and re-configure the switch to be
>    in a fully active state
>  
> -- ``port_enable``: function invoked by the DSA slave network device ndo_open
> +- ``port_enable``: function invoked by the DSA user network device ndo_open
>    function when a port is administratively brought up, this function should
>    fully enable a given switch port. DSA takes care of marking the port with
>    ``BR_STATE_BLOCKING`` if the port is a bridge member, or ``BR_STATE_FORWARDING`` if it
>    was not, and propagating these changes down to the hardware
>  
> -- ``port_disable``: function invoked by the DSA slave network device ndo_close
> +- ``port_disable``: function invoked by the DSA user network device ndo_close
>    function when a port is administratively brought down, this function should
>    fully disable a given switch port. DSA takes care of marking the port with
>    ``BR_STATE_DISABLED`` and propagating changes to the hardware if this port is
> diff --git a/Documentation/networking/dsa/lan9303.rst b/Documentation/networking/dsa/lan9303.rst
> index e3c820db28ad..ab81b4e0139e 100644
> --- a/Documentation/networking/dsa/lan9303.rst
> +++ b/Documentation/networking/dsa/lan9303.rst
> @@ -4,7 +4,7 @@ LAN9303 Ethernet switch driver
>  
>  The LAN9303 is a three port 10/100 Mbps ethernet switch with integrated phys for
>  the two external ethernet ports. The third port is an RMII/MII interface to a
> -host master network interface (e.g. fixed link).
> +host conduit network interface (e.g. fixed link).
>  
>  
>  Driver details
> diff --git a/Documentation/networking/dsa/sja1105.rst b/Documentation/networking/dsa/sja1105.rst
> index e0219c1452ab..aeebfff595f7 100644
> --- a/Documentation/networking/dsa/sja1105.rst
> +++ b/Documentation/networking/dsa/sja1105.rst
> @@ -79,7 +79,7 @@ The hardware tags all traffic internally with a port-based VLAN (pvid), or it
>  decodes the VLAN information from the 802.1Q tag. Advanced VLAN classification
>  is not possible. Once attributed a VLAN tag, frames are checked against the
>  port's membership rules and dropped at ingress if they don't match any VLAN.
> -This behavior is available when switch ports are enslaved to a bridge with
> +This behavior is available when switch ports are enuserd to a bridge with

"are enuserd to"? How about "switch ports join a bridge"?

>  ``vlan_filtering 1``.
>  
>  Normally the hardware is not configurable with respect to VLAN awareness, but
> @@ -122,7 +122,7 @@ on egress. Using ``vlan_filtering=1``, the behavior is the other way around:
>  offloaded flows can be steered to TX queues based on the VLAN PCP, but the DSA
>  net devices are no longer able to do that. To inject frames into a hardware TX
>  queue with VLAN awareness active, it is necessary to create a VLAN
> -sub-interface on the DSA master port, and send normal (0x8100) VLAN-tagged
> +sub-interface on the DSA conduit port, and send normal (0x8100) VLAN-tagged
>  towards the switch, with the VLAN PCP bits set appropriately.
>  
>  Management traffic (having DMAC 01-80-C2-xx-xx-xx or 01-19-1B-xx-xx-xx) is the
> @@ -389,11 +389,11 @@ MDIO bus and PHY management
>  The SJA1105 does not have an MDIO bus and does not perform in-band AN either.
>  Therefore there is no link state notification coming from the switch device.
>  A board would need to hook up the PHYs connected to the switch to any other
> -MDIO bus available to Linux within the system (e.g. to the DSA master's MDIO
> +MDIO bus available to Linux within the system (e.g. to the DSA conduit's MDIO
>  bus). Link state management then works by the driver manually keeping in sync
>  (over SPI commands) the MAC link speed with the settings negotiated by the PHY.
>  
> -By comparison, the SJA1110 supports an MDIO slave access point over which its
> +By comparison, the SJA1110 supports an MDIO user access point over which its

Please keep this "MDIO slave access point". It has nothing to do with
the DSA master/slave hierarchy.

>  internal 100base-T1 PHYs can be accessed from the host. This is, however, not
>  used by the driver, instead the internal 100base-T1 and 100base-TX PHYs are
>  accessed through SPI commands, modeled in Linux as virtual MDIO buses.
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 5fc613d24151..49cbdb55b4b3 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -13,7 +13,7 @@
>  / {
>  	aliases {
>  		ethernet0 = &eth0;
> -		/* for dsa slave device */
> +		/* for DSA user port device */
>  		ethernet1 = &switch0port1;
>  		ethernet2 = &switch0port2;
>  		ethernet3 = &switch0port3;
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 4e27dc913cf7..0d628b35fd5c 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -757,7 +757,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
>  
>  	/* Create an untagged VLAN entry for the default PVID in case
>  	 * CONFIG_VLAN_8021Q is disabled and there are no calls to
> -	 * dsa_slave_vlan_rx_add_vid() to create the default VLAN
> +	 * dsa_user_vlan_rx_add_vid() to create the default VLAN
>  	 * entry. Do this only when the tagging protocol is not
>  	 * DSA_TAG_PROTO_NONE
>  	 */
> @@ -958,7 +958,7 @@ static struct phy_device *b53_get_phy_device(struct dsa_switch *ds, int port)
>  		return NULL;
>  	}
>  
> -	return mdiobus_get_phy(ds->slave_mii_bus, port);
> +	return mdiobus_get_phy(ds->user_mii_bus, port);
>  }
>  
>  void b53_get_strings(struct dsa_switch *ds, int port, u32 stringset,
> diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
> index 4d55d8d18376..897e5e8b3d69 100644
> --- a/drivers/net/dsa/b53/b53_mdio.c
> +++ b/drivers/net/dsa/b53/b53_mdio.c
> @@ -329,7 +329,7 @@ static int b53_mdio_probe(struct mdio_device *mdiodev)
>  	 * layer setup
>  	 */
>  	if (of_machine_is_compatible("brcm,bcm7445d0") &&
> -	    strcmp(mdiodev->bus->name, "sf2 slave mii"))
> +	    strcmp(mdiodev->bus->name, "sf2 user mii"))
>  		return -EPROBE_DEFER;
>  
>  	dev = b53_switch_alloc(&mdiodev->dev, &b53_mdio_ops, mdiodev->bus);
> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index 0b62bd78ac50..f2ece68bdd67 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -624,19 +624,19 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  	get_device(&priv->master_mii_bus->dev);
>  	priv->master_mii_dn = dn;
>  
> -	priv->slave_mii_bus = mdiobus_alloc();
> -	if (!priv->slave_mii_bus) {
> +	priv->user_mii_bus = mdiobus_alloc();
> +	if (!priv->user_mii_bus) {
>  		of_node_put(dn);
>  		return -ENOMEM;
>  	}
>  
> -	priv->slave_mii_bus->priv = priv;
> -	priv->slave_mii_bus->name = "sf2 slave mii";
> -	priv->slave_mii_bus->read = bcm_sf2_sw_mdio_read;
> -	priv->slave_mii_bus->write = bcm_sf2_sw_mdio_write;
> -	snprintf(priv->slave_mii_bus->id, MII_BUS_ID_SIZE, "sf2-%d",
> +	priv->user_mii_bus->priv = priv;
> +	priv->user_mii_bus->name = "sf2 user mii";
> +	priv->user_mii_bus->read = bcm_sf2_sw_mdio_read;
> +	priv->user_mii_bus->write = bcm_sf2_sw_mdio_write;
> +	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "sf2-%d",
>  		 index++);
> -	priv->slave_mii_bus->dev.of_node = dn;
> +	priv->user_mii_bus->dev.of_node = dn;
>  
>  	/* Include the pseudo-PHY address to divert reads towards our
>  	 * workaround. This is only required for 7445D0, since 7445E0
> @@ -654,9 +654,9 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  		priv->indir_phy_mask = 0;
>  
>  	ds->phys_mii_mask = priv->indir_phy_mask;
> -	ds->slave_mii_bus = priv->slave_mii_bus;
> -	priv->slave_mii_bus->parent = ds->dev->parent;
> -	priv->slave_mii_bus->phy_mask = ~priv->indir_phy_mask;
> +	ds->user_mii_bus = priv->user_mii_bus;
> +	priv->user_mii_bus->parent = ds->dev->parent;
> +	priv->user_mii_bus->phy_mask = ~priv->indir_phy_mask;
>  
>  	/* We need to make sure that of_phy_connect() will not work by
>  	 * removing the 'phandle' and 'linux,phandle' properties and
> @@ -683,9 +683,9 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  			phy_device_remove(phydev);
>  	}
>  
> -	err = mdiobus_register(priv->slave_mii_bus);
> +	err = mdiobus_register(priv->user_mii_bus);
>  	if (err && dn) {
> -		mdiobus_free(priv->slave_mii_bus);
> +		mdiobus_free(priv->user_mii_bus);
>  		of_node_put(dn);
>  	}
>  
> @@ -694,8 +694,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
>  
>  static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
>  {
> -	mdiobus_unregister(priv->slave_mii_bus);
> -	mdiobus_free(priv->slave_mii_bus);
> +	mdiobus_unregister(priv->user_mii_bus);
> +	mdiobus_free(priv->user_mii_bus);
>  	of_node_put(priv->master_mii_dn);
>  }
>  
> @@ -909,7 +909,7 @@ static void bcm_sf2_sw_fixed_state(struct dsa_switch *ds, int port,
>  		 * state machine and make it go in PHY_FORCING state instead.
>  		 */
>  		if (!status->link)
> -			netif_carrier_off(dsa_to_port(ds, port)->slave);
> +			netif_carrier_off(dsa_to_port(ds, port)->user);
>  		status->duplex = DUPLEX_FULL;
>  	} else {
>  		status->link = true;
> @@ -983,7 +983,7 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
>  static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
>  			       struct ethtool_wolinfo *wol)
>  {
> -	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
> +	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
>  	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
>  	struct ethtool_wolinfo pwol = { };
>  
> @@ -1007,7 +1007,7 @@ static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
>  static int bcm_sf2_sw_set_wol(struct dsa_switch *ds, int port,
>  			      struct ethtool_wolinfo *wol)
>  {
> -	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
> +	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
>  	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
>  	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
>  	struct ethtool_wolinfo pwol =  { };
> diff --git a/drivers/net/dsa/bcm_sf2.h b/drivers/net/dsa/bcm_sf2.h
> index 00afc94ce522..424f896b5a6f 100644
> --- a/drivers/net/dsa/bcm_sf2.h
> +++ b/drivers/net/dsa/bcm_sf2.h
> @@ -108,7 +108,7 @@ struct bcm_sf2_priv {
>  	/* Master and slave MDIO bus controller */
>  	unsigned int			indir_phy_mask;
>  	struct device_node		*master_mii_dn;
> -	struct mii_bus			*slave_mii_bus;
> +	struct mii_bus			*user_mii_bus;
>  	struct mii_bus			*master_mii_bus;
>  
>  	/* Bitmask of ports needing BRCM tags */
> diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
> index c4010b7bf089..c88ee3dd4299 100644
> --- a/drivers/net/dsa/bcm_sf2_cfp.c
> +++ b/drivers/net/dsa/bcm_sf2_cfp.c
> @@ -1102,7 +1102,7 @@ static int bcm_sf2_cfp_rule_get_all(struct bcm_sf2_priv *priv,
>  int bcm_sf2_get_rxnfc(struct dsa_switch *ds, int port,
>  		      struct ethtool_rxnfc *nfc, u32 *rule_locs)
>  {
> -	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
> +	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
>  	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
>  	int ret = 0;
>  
> @@ -1145,7 +1145,7 @@ int bcm_sf2_get_rxnfc(struct dsa_switch *ds, int port,
>  int bcm_sf2_set_rxnfc(struct dsa_switch *ds, int port,
>  		      struct ethtool_rxnfc *nfc)
>  {
> -	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
> +	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
>  	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
>  	int ret = 0;
>  
> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
> index ee67adeb2cdb..fcb20eac332a 100644
> --- a/drivers/net/dsa/lan9303-core.c
> +++ b/drivers/net/dsa/lan9303-core.c
> @@ -1084,7 +1084,7 @@ static int lan9303_port_enable(struct dsa_switch *ds, int port,
>  	if (!dsa_port_is_user(dp))
>  		return 0;
>  
> -	vlan_vid_add(dsa_port_to_master(dp), htons(ETH_P_8021Q), port);
> +	vlan_vid_add(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
>  
>  	return lan9303_enable_processing_port(chip, port);
>  }
> @@ -1097,7 +1097,7 @@ static void lan9303_port_disable(struct dsa_switch *ds, int port)
>  	if (!dsa_port_is_user(dp))
>  		return;
>  
> -	vlan_vid_del(dsa_port_to_master(dp), htons(ETH_P_8021Q), port);
> +	vlan_vid_del(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
>  
>  	lan9303_disable_processing_port(chip, port);
>  	lan9303_phy_write(ds, chip->phy_addr_base + port, MII_BMCR, BMCR_PDOWN);
> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
> index 25abf2caf5fb..95fc42ba2d74 100644
> --- a/drivers/net/dsa/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq_gswip.c
> @@ -510,22 +510,22 @@ static int gswip_mdio(struct gswip_priv *priv, struct device_node *mdio_np)
>  	struct dsa_switch *ds = priv->ds;
>  	int err;
>  
> -	ds->slave_mii_bus = mdiobus_alloc();
> -	if (!ds->slave_mii_bus)
> +	ds->user_mii_bus = mdiobus_alloc();
> +	if (!ds->user_mii_bus)
>  		return -ENOMEM;
>  
> -	ds->slave_mii_bus->priv = priv;
> -	ds->slave_mii_bus->read = gswip_mdio_rd;
> -	ds->slave_mii_bus->write = gswip_mdio_wr;
> -	ds->slave_mii_bus->name = "lantiq,xrx200-mdio";
> -	snprintf(ds->slave_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
> +	ds->user_mii_bus->priv = priv;
> +	ds->user_mii_bus->read = gswip_mdio_rd;
> +	ds->user_mii_bus->write = gswip_mdio_wr;
> +	ds->user_mii_bus->name = "lantiq,xrx200-mdio";
> +	snprintf(ds->user_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
>  		 dev_name(priv->dev));
> -	ds->slave_mii_bus->parent = priv->dev;
> -	ds->slave_mii_bus->phy_mask = ~ds->phys_mii_mask;
> +	ds->user_mii_bus->parent = priv->dev;
> +	ds->user_mii_bus->phy_mask = ~ds->phys_mii_mask;
>  
> -	err = of_mdiobus_register(ds->slave_mii_bus, mdio_np);
> +	err = of_mdiobus_register(ds->user_mii_bus, mdio_np);
>  	if (err)
> -		mdiobus_free(ds->slave_mii_bus);
> +		mdiobus_free(ds->user_mii_bus);
>  
>  	return err;
>  }
> @@ -2197,8 +2197,8 @@ static int gswip_probe(struct platform_device *pdev)
>  	dsa_unregister_switch(priv->ds);
>  mdio_bus:
>  	if (mdio_np) {
> -		mdiobus_unregister(priv->ds->slave_mii_bus);
> -		mdiobus_free(priv->ds->slave_mii_bus);
> +		mdiobus_unregister(priv->ds->user_mii_bus);
> +		mdiobus_free(priv->ds->user_mii_bus);
>  	}
>  put_mdio_node:
>  	of_node_put(mdio_np);
> @@ -2220,10 +2220,10 @@ static void gswip_remove(struct platform_device *pdev)
>  
>  	dsa_unregister_switch(priv->ds);
>  
> -	if (priv->ds->slave_mii_bus) {
> -		mdiobus_unregister(priv->ds->slave_mii_bus);
> -		of_node_put(priv->ds->slave_mii_bus->dev.of_node);
> -		mdiobus_free(priv->ds->slave_mii_bus);
> +	if (priv->ds->user_mii_bus) {
> +		mdiobus_unregister(priv->ds->user_mii_bus);
> +		of_node_put(priv->ds->user_mii_bus->dev.of_node);
> +		mdiobus_free(priv->ds->user_mii_bus);
>  	}
>  
>  	for (i = 0; i < priv->num_gphy_fw; i++)
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index cde8ef33d029..a8b0e528b804 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -1170,7 +1170,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
>  void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
>  {
>  	struct ksz_device *dev = ds->priv;
> -	struct net_device *slave;
> +	struct net_device *user;
>  	struct dsa_port *hsr_dp;
>  	u8 data, hsr_ports = 0;
>  
> @@ -1202,8 +1202,8 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
>  	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
>  
>  	/* Setup HW supported features for lan HSR ports */
> -	slave = dsa_to_port(ds, port)->slave;
> -	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
> +	user = dsa_to_port(ds, port)->user;
> +	user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
>  }
>  
>  void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index b800ace40ce1..a8025ff988ec 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1945,14 +1945,14 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
>  				ret = irq;
>  				goto out;
>  			}
> -			ds->slave_mii_bus->irq[phy] = irq;
> +			ds->user_mii_bus->irq[phy] = irq;
>  		}
>  	}
>  	return 0;
>  out:
>  	while (phy--)
>  		if (BIT(phy) & ds->phys_mii_mask)
> -			irq_dispose_mapping(ds->slave_mii_bus->irq[phy]);
> +			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
>  
>  	return ret;
>  }
> @@ -1964,7 +1964,7 @@ static void ksz_irq_phy_free(struct ksz_device *dev)
>  
>  	for (phy = 0; phy < KSZ_MAX_NUM_PORTS; phy++)
>  		if (BIT(phy) & ds->phys_mii_mask)
> -			irq_dispose_mapping(ds->slave_mii_bus->irq[phy]);
> +			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
>  }
>  
>  static int ksz_mdio_register(struct ksz_device *dev)
> @@ -1987,12 +1987,12 @@ static int ksz_mdio_register(struct ksz_device *dev)
>  	bus->priv = dev;
>  	bus->read = ksz_sw_mdio_read;
>  	bus->write = ksz_sw_mdio_write;
> -	bus->name = "ksz slave smi";
> +	bus->name = "ksz user smi";
>  	snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
>  	bus->parent = ds->dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;
>  
> -	ds->slave_mii_bus = bus;
> +	ds->user_mii_bus = bus;
>  
>  	if (dev->irq > 0) {
>  		ret = ksz_irq_phy_setup(dev);
> @@ -2344,7 +2344,7 @@ static void ksz_mib_read_work(struct work_struct *work)
>  		if (!p->read) {
>  			const struct dsa_port *dp = dsa_to_port(dev->ds, i);
>  
> -			if (!netif_carrier_ok(dp->slave))
> +			if (!netif_carrier_ok(dp->user))
>  				mib->cnt_ptr = dev->info->reg_mib_cnt;
>  		}
>  		port_r_cnt(dev, i);
> @@ -2464,7 +2464,7 @@ static void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
>  	mutex_lock(&mib->cnt_mutex);
>  
>  	/* Only read dropped counters if no link. */
> -	if (!netif_carrier_ok(dp->slave))
> +	if (!netif_carrier_ok(dp->user))
>  		mib->cnt_ptr = dev->info->reg_mib_cnt;
>  	port_r_cnt(dev, port);
>  	memcpy(buf, mib->counters, dev->info->mib_cnt * sizeof(u64));
> @@ -2574,7 +2574,7 @@ static int ksz_port_setup(struct dsa_switch *ds, int port)
>  	if (!dsa_is_user_port(ds, port))
>  		return 0;
>  
> -	/* setup slave port */
> +	/* setup user port */
>  	dev->dev_ops->port_setup(dev, port, false);
>  
>  	/* port_stp_state_set() will be called after to enable the port so
> @@ -3567,8 +3567,8 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
>  static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
>  				  struct netlink_ext_ack *extack)
>  {
> -	struct net_device *slave = dsa_to_port(ds, port)->slave;
> -	const unsigned char *addr = slave->dev_addr;
> +	struct net_device *user = dsa_to_port(ds, port)->user;
> +	const unsigned char *addr = user->dev_addr;
>  	struct ksz_switch_macaddr *switch_macaddr;
>  	struct ksz_device *dev = ds->priv;
>  	const u16 *regs = dev->info->regs;
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 4e22a695a64c..1fe105913c75 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -557,7 +557,7 @@ static void ksz_ptp_txtstamp_skb(struct ksz_device *dev,
>  	struct skb_shared_hwtstamps hwtstamps = {};
>  	int ret;
>  
> -	/* timeout must include DSA master to transmit data, tstamp latency,
> +	/* timeout must include DSA conduit to transmit data, tstamp latency,
>  	 * IRQ latency and time for reading the time stamp.
>  	 */
>  	ret = wait_for_completion_timeout(&prt->tstamp_msg_comp,
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 0d62c69dfbb6..d2a92ee64f8e 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2070,7 +2070,7 @@ mt7530_setup_mdio_irq(struct mt7530_priv *priv)
>  			unsigned int irq;
>  
>  			irq = irq_create_mapping(priv->irq_domain, p);
> -			ds->slave_mii_bus->irq[p] = irq;
> +			ds->user_mii_bus->irq[p] = irq;
>  		}
>  	}
>  }
> @@ -2164,7 +2164,7 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
>  	if (!bus)
>  		return -ENOMEM;
>  
> -	ds->slave_mii_bus = bus;
> +	ds->user_mii_bus = bus;
>  	bus->priv = priv;
>  	bus->name = KBUILD_MODNAME "-mii";
>  	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
> @@ -2201,20 +2201,20 @@ mt7530_setup(struct dsa_switch *ds)
>  	u32 id, val;
>  	int ret, i;
>  
> -	/* The parent node of master netdev which holds the common system
> +	/* The parent node of conduit netdev which holds the common system
>  	 * controller also is the container for two GMACs nodes representing
>  	 * as two netdev instances.
>  	 */
>  	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
> -		dn = cpu_dp->master->dev.of_node->parent;
> +		dn = cpu_dp->conduit->dev.of_node->parent;
>  		/* It doesn't matter which CPU port is found first,
> -		 * their masters should share the same parent OF node
> +		 * their conduits should share the same parent OF node
>  		 */
>  		break;
>  	}
>  
>  	if (!dn) {
> -		dev_err(ds->dev, "parent OF node of DSA master not found");
> +		dev_err(ds->dev, "parent OF node of DSA conduit not found");
>  		return -EINVAL;
>  	}
>  
> @@ -2489,7 +2489,7 @@ mt7531_setup(struct dsa_switch *ds)
>  	if (mt7531_dual_sgmii_supported(priv)) {
>  		priv->p5_intf_sel = P5_INTF_SEL_GMAC5_SGMII;
>  
> -		/* Let ds->slave_mii_bus be able to access external phy. */
> +		/* Let ds->user_mii_bus be able to access external phy. */
>  		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO11_RG_RXD2_MASK,
>  			   MT7531_EXT_P_MDC_11);
>  		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO12_RG_RXD3_MASK,
> @@ -2718,7 +2718,7 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  		dp = dsa_to_port(ds, port);
> -		phydev = dp->slave->phydev;
> +		phydev = dp->user->phydev;
>  		return mt7531_rgmii_setup(priv, port, interface, phydev);
>  	case PHY_INTERFACE_MODE_SGMII:
>  	case PHY_INTERFACE_MODE_NA:
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index ab434a77b059..be2491de173d 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3719,7 +3719,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
>  		return err;
>  
>  	chip->ds = ds;
> -	ds->slave_mii_bus = mv88e6xxx_default_mdio_bus(chip);
> +	ds->user_mii_bus = mv88e6xxx_default_mdio_bus(chip);
>  
>  	/* Since virtual bridges are mapped in the PVT, the number we support
>  	 * depends on the physical switch topology. We need to let DSA figure
> diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
> index 9a3e5ec16972..7a8a3e249454 100644
> --- a/drivers/net/dsa/ocelot/felix.c
> +++ b/drivers/net/dsa/ocelot/felix.c
> @@ -42,22 +42,22 @@ static struct net_device *felix_classify_db(struct dsa_db db)
>  	}
>  }
>  
> -static int felix_cpu_port_for_master(struct dsa_switch *ds,
> -				     struct net_device *master)
> +static int felix_cpu_port_for_conduit(struct dsa_switch *ds,
> +				     struct net_device *conduit)

Please realign.

>  {
>  	struct ocelot *ocelot = ds->priv;
>  	struct dsa_port *cpu_dp;
>  	int lag;
>  
> -	if (netif_is_lag_master(master)) {
> +	if (netif_is_lag_master(conduit)) {
>  		mutex_lock(&ocelot->fwd_domain_lock);
> -		lag = ocelot_bond_get_id(ocelot, master);
> +		lag = ocelot_bond_get_id(ocelot, conduit);
>  		mutex_unlock(&ocelot->fwd_domain_lock);
>  
>  		return lag;
>  	}
>  
> -	cpu_dp = master->dsa_ptr;
> +	cpu_dp = conduit->dsa_ptr;
>  	return cpu_dp->index;
>  }
>  
> @@ -366,7 +366,7 @@ static int felix_update_trapping_destinations(struct dsa_switch *ds,
>   * is the mode through which frames can be injected from and extracted to an
>   * external CPU, over Ethernet. In NXP SoCs, the "external CPU" is the ARM CPU
>   * running Linux, and this forms a DSA setup together with the enetc or fman
> - * DSA master.
> + * DSA conduit.
>   */
>  static void felix_npi_port_init(struct ocelot *ocelot, int port)
>  {
> @@ -441,16 +441,16 @@ static unsigned long felix_tag_npi_get_host_fwd_mask(struct dsa_switch *ds)
>  	return BIT(ocelot->num_phys_ports);
>  }
>  
> -static int felix_tag_npi_change_master(struct dsa_switch *ds, int port,
> -				       struct net_device *master,
> +static int felix_tag_npi_change_conduit(struct dsa_switch *ds, int port,
> +				       struct net_device *conduit,
>  				       struct netlink_ext_ack *extack)

Please realign.

>  {
>  	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
>  	struct ocelot *ocelot = ds->priv;
>  
> -	if (netif_is_lag_master(master)) {
> +	if (netif_is_lag_master(conduit)) {
>  		NL_SET_ERR_MSG_MOD(extack,
> -				   "LAG DSA master only supported using ocelot-8021q");
> +				   "LAG DSA conduit only supported using ocelot-8021q");
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -459,24 +459,24 @@ static int felix_tag_npi_change_master(struct dsa_switch *ds, int port,
>  	 * come back up until they're all changed to the new one.
>  	 */
>  	dsa_switch_for_each_user_port(other_dp, ds) {
> -		struct net_device *slave = other_dp->slave;
> +		struct net_device *user = other_dp->user;
>  
> -		if (other_dp != dp && (slave->flags & IFF_UP) &&
> -		    dsa_port_to_master(other_dp) != master) {
> +		if (other_dp != dp && (user->flags & IFF_UP) &&
> +		    dsa_port_to_conduit(other_dp) != conduit) {
>  			NL_SET_ERR_MSG_MOD(extack,
> -					   "Cannot change while old master still has users");
> +					   "Cannot change while old conduit still has users");
>  			return -EOPNOTSUPP;
>  		}
>  	}
>  
>  	felix_npi_port_deinit(ocelot, ocelot->npi);
> -	felix_npi_port_init(ocelot, felix_cpu_port_for_master(ds, master));
> +	felix_npi_port_init(ocelot, felix_cpu_port_for_conduit(ds, conduit));
>  
>  	return 0;
>  }
>  
>  /* Alternatively to using the NPI functionality, that same hardware MAC
> - * connected internally to the enetc or fman DSA master can be configured to
> + * connected internally to the enetc or fman DSA conduit can be configured to
>   * use the software-defined tag_8021q frame format. As far as the hardware is
>   * concerned, it thinks it is a "dumb switch" - the queues of the CPU port
>   * module are now disconnected from it, but can still be accessed through
> @@ -486,7 +486,7 @@ static const struct felix_tag_proto_ops felix_tag_npi_proto_ops = {
>  	.setup			= felix_tag_npi_setup,
>  	.teardown		= felix_tag_npi_teardown,
>  	.get_host_fwd_mask	= felix_tag_npi_get_host_fwd_mask,
> -	.change_master		= felix_tag_npi_change_master,
> +	.change_conduit		= felix_tag_npi_change_conduit,
>  };
>  
>  static int felix_tag_8021q_setup(struct dsa_switch *ds)
> @@ -561,11 +561,11 @@ static unsigned long felix_tag_8021q_get_host_fwd_mask(struct dsa_switch *ds)
>  	return dsa_cpu_ports(ds);
>  }
>  
> -static int felix_tag_8021q_change_master(struct dsa_switch *ds, int port,
> -					 struct net_device *master,
> +static int felix_tag_8021q_change_conduit(struct dsa_switch *ds, int port,
> +					 struct net_device *conduit,
>  					 struct netlink_ext_ack *extack)

Please realign.

>  {
> -	int cpu = felix_cpu_port_for_master(ds, master);
> +	int cpu = felix_cpu_port_for_conduit(ds, conduit);
>  	struct ocelot *ocelot = ds->priv;
>  
>  	ocelot_port_unassign_dsa_8021q_cpu(ocelot, port);
> @@ -578,7 +578,7 @@ static const struct felix_tag_proto_ops felix_tag_8021q_proto_ops = {
>  	.setup			= felix_tag_8021q_setup,
>  	.teardown		= felix_tag_8021q_teardown,
>  	.get_host_fwd_mask	= felix_tag_8021q_get_host_fwd_mask,
> -	.change_master		= felix_tag_8021q_change_master,
> +	.change_conduit		= felix_tag_8021q_change_conduit,
>  };
>  
>  static void felix_set_host_flood(struct dsa_switch *ds, unsigned long mask,
> @@ -741,14 +741,14 @@ static void felix_port_set_host_flood(struct dsa_switch *ds, int port,
>  			     !!felix->host_flood_mc_mask, true);
>  }
>  
> -static int felix_port_change_master(struct dsa_switch *ds, int port,
> -				    struct net_device *master,
> +static int felix_port_change_conduit(struct dsa_switch *ds, int port,
> +				    struct net_device *conduit,
>  				    struct netlink_ext_ack *extack)

Please realign.

>  {
>  	struct ocelot *ocelot = ds->priv;
>  	struct felix *felix = ocelot_to_felix(ocelot);
>  
> -	return felix->tag_proto_ops->change_master(ds, port, master, extack);
> +	return felix->tag_proto_ops->change_conduit(ds, port, conduit, extack);
>  }
>  
>  static int felix_set_ageing_time(struct dsa_switch *ds,
> @@ -953,7 +953,7 @@ static int felix_lag_join(struct dsa_switch *ds, int port,
>  	if (!dsa_is_cpu_port(ds, port))
>  		return 0;
>  
> -	return felix_port_change_master(ds, port, lag.dev, extack);
> +	return felix_port_change_conduit(ds, port, lag.dev, extack);
>  }
>  
>  static int felix_lag_leave(struct dsa_switch *ds, int port,
> @@ -967,7 +967,7 @@ static int felix_lag_leave(struct dsa_switch *ds, int port,
>  	if (!dsa_is_cpu_port(ds, port))
>  		return 0;
>  
> -	return felix_port_change_master(ds, port, lag.dev, NULL);
> +	return felix_port_change_conduit(ds, port, lag.dev, NULL);
>  }
>  
>  static int felix_lag_change(struct dsa_switch *ds, int port)
> @@ -1116,10 +1116,10 @@ static int felix_port_enable(struct dsa_switch *ds, int port,
>  		return 0;
>  
>  	if (ocelot->npi >= 0) {
> -		struct net_device *master = dsa_port_to_master(dp);
> +		struct net_device *conduit = dsa_port_to_conduit(dp);
>  
> -		if (felix_cpu_port_for_master(ds, master) != ocelot->npi) {
> -			dev_err(ds->dev, "Multiple masters are not allowed\n");
> +		if (felix_cpu_port_for_conduit(ds, conduit) != ocelot->npi) {
> +			dev_err(ds->dev, "Multiple conduits are not allowed\n");
>  			return -EINVAL;
>  		}
>  	}
> @@ -2164,7 +2164,7 @@ const struct dsa_switch_ops felix_switch_ops = {
>  	.port_add_dscp_prio		= felix_port_add_dscp_prio,
>  	.port_del_dscp_prio		= felix_port_del_dscp_prio,
>  	.port_set_host_flood		= felix_port_set_host_flood,
> -	.port_change_master		= felix_port_change_master,
> +	.port_change_conduit		= felix_port_change_conduit,
>  };
>  EXPORT_SYMBOL_GPL(felix_switch_ops);
>  
> @@ -2176,7 +2176,7 @@ struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port)
>  	if (!dsa_is_user_port(ds, port))
>  		return NULL;
>  
> -	return dsa_to_port(ds, port)->slave;
> +	return dsa_to_port(ds, port)->user;
>  }
>  EXPORT_SYMBOL_GPL(felix_port_to_netdev);
>  
> diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
> index 1d4befe7cfe8..288d37aaf4bd 100644
> --- a/drivers/net/dsa/ocelot/felix.h
> +++ b/drivers/net/dsa/ocelot/felix.h
> @@ -77,8 +77,8 @@ struct felix_tag_proto_ops {
>  	int (*setup)(struct dsa_switch *ds);
>  	void (*teardown)(struct dsa_switch *ds);
>  	unsigned long (*get_host_fwd_mask)(struct dsa_switch *ds);
> -	int (*change_master)(struct dsa_switch *ds, int port,
> -			     struct net_device *master,
> +	int (*change_conduit)(struct dsa_switch *ds, int port,
> +			     struct net_device *conduit,
>  			     struct netlink_ext_ack *extack);

Please realign.

>  };
>  
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index de1dc22cf683..765df4640782 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -323,14 +323,14 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	mutex_lock(&mgmt_eth_data->mutex);
>  
> -	/* Check mgmt_master if is operational */
> -	if (!priv->mgmt_master) {
> +	/* Check mgmt_conduit if is operational */

Can you also squash another change here, to "check if mgmt_conduit is operational"?

> +	if (!priv->mgmt_conduit) {
>  		kfree_skb(skb);
>  		mutex_unlock(&mgmt_eth_data->mutex);
>  		return -EINVAL;
>  	}
>  
> -	skb->dev = priv->mgmt_master;
> +	skb->dev = priv->mgmt_conduit;
>  
>  	reinit_completion(&mgmt_eth_data->rw_done);
>  
> @@ -375,14 +375,14 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
>  
>  	mutex_lock(&mgmt_eth_data->mutex);
>  
> -	/* Check mgmt_master if is operational */
> -	if (!priv->mgmt_master) {
> +	/* Check mgmt_conduit if is operational */

Same comment here.

> +	if (!priv->mgmt_conduit) {
>  		kfree_skb(skb);
>  		mutex_unlock(&mgmt_eth_data->mutex);
>  		return -EINVAL;
>  	}
>  
> -	skb->dev = priv->mgmt_master;
> +	skb->dev = priv->mgmt_conduit;
>  
>  	reinit_completion(&mgmt_eth_data->rw_done);
>  
> @@ -508,7 +508,7 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
>  	u32 reg = *(u32 *)reg_buf & U16_MAX;
>  	struct qca8k_priv *priv = ctx;
>  
> -	if (priv->mgmt_master &&
> +	if (priv->mgmt_conduit &&
>  	    !qca8k_read_eth(priv, reg, val_buf, val_len))
>  		return 0;
>  
> @@ -531,7 +531,7 @@ qca8k_bulk_gather_write(void *ctx, const void *reg_buf, size_t reg_len,
>  	struct qca8k_priv *priv = ctx;
>  	u32 *val = (u32 *)val_buf;
>  
> -	if (priv->mgmt_master &&
> +	if (priv->mgmt_conduit &&
>  	    !qca8k_write_eth(priv, reg, val, val_len))
>  		return 0;
>  
> @@ -626,7 +626,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	struct sk_buff *write_skb, *clear_skb, *read_skb;
>  	struct qca8k_mgmt_eth_data *mgmt_eth_data;
>  	u32 write_val, clear_val = 0, val;
> -	struct net_device *mgmt_master;
> +	struct net_device *mgmt_conduit;
>  	int ret, ret1;
>  	bool ack;
>  
> @@ -674,17 +674,17 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	 */
>  	mutex_lock(&mgmt_eth_data->mutex);
>  
> -	/* Check if mgmt_master is operational */
> -	mgmt_master = priv->mgmt_master;
> -	if (!mgmt_master) {
> +	/* Check if mgmt_conduit is operational */
> +	mgmt_conduit = priv->mgmt_conduit;
> +	if (!mgmt_conduit) {
>  		mutex_unlock(&mgmt_eth_data->mutex);
>  		ret = -EINVAL;
> -		goto err_mgmt_master;
> +		goto err_mgmt_conduit;
>  	}
>  
> -	read_skb->dev = mgmt_master;
> -	clear_skb->dev = mgmt_master;
> -	write_skb->dev = mgmt_master;
> +	read_skb->dev = mgmt_conduit;
> +	clear_skb->dev = mgmt_conduit;
> +	write_skb->dev = mgmt_conduit;
>  
>  	reinit_completion(&mgmt_eth_data->rw_done);
>  
> @@ -769,7 +769,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
>  	return ret;
>  
>  	/* Error handling before lock */
> -err_mgmt_master:
> +err_mgmt_conduit:
>  	kfree_skb(read_skb);
>  err_read_skb:
>  	kfree_skb(clear_skb);
> @@ -948,12 +948,12 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>  		 ds->dst->index, ds->index);
>  	bus->parent = ds->dev;
>  	bus->phy_mask = ~ds->phys_mii_mask;
> -	ds->slave_mii_bus = bus;
> +	ds->user_mii_bus = bus;
>  
>  	/* Check if the devicetree declare the port:phy mapping */
>  	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
>  	if (of_device_is_available(mdio)) {
> -		bus->name = "qca8k slave mii";
> +		bus->name = "qca8k user mii";
>  		bus->read = qca8k_internal_mdio_read;
>  		bus->write = qca8k_internal_mdio_write;
>  		return devm_of_mdiobus_register(priv->dev, bus, mdio);
> @@ -962,7 +962,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
>  	/* If a mapping can't be found the legacy mapping is used,
>  	 * using the qca8k_port_to_phy function
>  	 */
> -	bus->name = "qca8k-legacy slave mii";
> +	bus->name = "qca8k-legacy user mii";
>  	bus->read = qca8k_legacy_mdio_read;
>  	bus->write = qca8k_legacy_mdio_write;
>  	return devm_mdiobus_register(priv->dev, bus);
> @@ -1717,10 +1717,10 @@ qca8k_get_tag_protocol(struct dsa_switch *ds, int port,
>  }
>  
>  static void
> -qca8k_master_change(struct dsa_switch *ds, const struct net_device *master,
> +qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
>  		    bool operational)

Please realign.

>  {
> -	struct dsa_port *dp = master->dsa_ptr;
> +	struct dsa_port *dp = conduit->dsa_ptr;
>  	struct qca8k_priv *priv = ds->priv;
>  
>  	/* Ethernet MIB/MDIO is only supported for CPU port 0 */
> @@ -1730,7 +1730,7 @@ qca8k_master_change(struct dsa_switch *ds, const struct net_device *master,
>  	mutex_lock(&priv->mgmt_eth_data.mutex);
>  	mutex_lock(&priv->mib_eth_data.mutex);
>  
> -	priv->mgmt_master = operational ? (struct net_device *)master : NULL;
> +	priv->mgmt_conduit = operational ? (struct net_device *)conduit : NULL;
>  
>  	mutex_unlock(&priv->mib_eth_data.mutex);
>  	mutex_unlock(&priv->mgmt_eth_data.mutex);
> @@ -2005,7 +2005,7 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
>  	.get_phy_flags		= qca8k_get_phy_flags,
>  	.port_lag_join		= qca8k_port_lag_join,
>  	.port_lag_leave		= qca8k_port_lag_leave,
> -	.master_state_change	= qca8k_master_change,
> +	.conduit_state_change	= qca8k_conduit_change,
>  	.connect_tag_protocol	= qca8k_connect_tag_protocol,
>  };
>  
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 9ff0a3c1cb91..d203e4a84441 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -499,7 +499,7 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
>  	u32 hi = 0;
>  	int ret;
>  
> -	if (priv->mgmt_master && priv->info->ops->autocast_mib &&
> +	if (priv->mgmt_conduit && priv->info->ops->autocast_mib &&
>  	    priv->info->ops->autocast_mib(ds, port, data) > 0)
>  		return;
>  
> diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
> index e8c16e76e34b..90e30c2909e4 100644
> --- a/drivers/net/dsa/qca/qca8k-leds.c
> +++ b/drivers/net/dsa/qca/qca8k-leds.c
> @@ -356,8 +356,8 @@ static struct device *qca8k_cled_hw_control_get_device(struct led_classdev *ldev
>  	dp = dsa_to_port(priv->ds, qca8k_phy_to_port(led->port_num));
>  	if (!dp)
>  		return NULL;
> -	if (dp->slave)
> -		return &dp->slave->dev;
> +	if (dp->user)
> +		return &dp->user->dev;
>  	return NULL;
>  }
>  
> @@ -429,7 +429,7 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
>  		init_data.default_label = ":port";
>  		init_data.fwnode = led;
>  		init_data.devname_mandatory = true;
> -		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d", ds->slave_mii_bus->id,
> +		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d", ds->user_mii_bus->id,
>  						 port_num);
>  		if (!init_data.devicename)
>  			return -ENOMEM;
> diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> index 8f88b7db384d..2ac7e88f8da5 100644
> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/drivers/net/dsa/qca/qca8k.h
> @@ -458,7 +458,7 @@ struct qca8k_priv {
>  	struct mutex reg_mutex;
>  	struct device *dev;
>  	struct gpio_desc *reset_gpio;
> -	struct net_device *mgmt_master; /* Track if mdio/mib Ethernet is available */
> +	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
>  	struct qca8k_mgmt_eth_data mgmt_eth_data;
>  	struct qca8k_mib_eth_data mib_eth_data;
>  	struct qca8k_mdio_cache mdio_cache;
> diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
> index bfd11591faf4..755546ed8db6 100644
> --- a/drivers/net/dsa/realtek/realtek-smi.c
> +++ b/drivers/net/dsa/realtek/realtek-smi.c
> @@ -378,25 +378,25 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
>  		return -ENODEV;
>  	}
>  
> -	priv->slave_mii_bus = devm_mdiobus_alloc(priv->dev);
> -	if (!priv->slave_mii_bus) {
> +	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
> +	if (!priv->user_mii_bus) {
>  		ret = -ENOMEM;
>  		goto err_put_node;
>  	}
> -	priv->slave_mii_bus->priv = priv;
> -	priv->slave_mii_bus->name = "SMI slave MII";
> -	priv->slave_mii_bus->read = realtek_smi_mdio_read;
> -	priv->slave_mii_bus->write = realtek_smi_mdio_write;
> -	snprintf(priv->slave_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
> +	priv->user_mii_bus->priv = priv;
> +	priv->user_mii_bus->name = "SMI user MII";
> +	priv->user_mii_bus->read = realtek_smi_mdio_read;
> +	priv->user_mii_bus->write = realtek_smi_mdio_write;
> +	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
>  		 ds->index);
> -	priv->slave_mii_bus->dev.of_node = mdio_np;
> -	priv->slave_mii_bus->parent = priv->dev;
> -	ds->slave_mii_bus = priv->slave_mii_bus;
> +	priv->user_mii_bus->dev.of_node = mdio_np;
> +	priv->user_mii_bus->parent = priv->dev;
> +	ds->user_mii_bus = priv->user_mii_bus;
>  
> -	ret = devm_of_mdiobus_register(priv->dev, priv->slave_mii_bus, mdio_np);
> +	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
>  	if (ret) {
>  		dev_err(priv->dev, "unable to register MDIO bus %s\n",
> -			priv->slave_mii_bus->id);
> +			priv->user_mii_bus->id);
>  		goto err_put_node;
>  	}
>  
> @@ -514,8 +514,8 @@ static void realtek_smi_remove(struct platform_device *pdev)
>  		return;
>  
>  	dsa_unregister_switch(priv->ds);
> -	if (priv->slave_mii_bus)
> -		of_node_put(priv->slave_mii_bus->dev.of_node);
> +	if (priv->user_mii_bus)
> +		of_node_put(priv->user_mii_bus->dev.of_node);
>  
>  	/* leave the device reset asserted */
>  	if (priv->reset)
> diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
> index 4fa7c6ba874a..790488e9c667 100644
> --- a/drivers/net/dsa/realtek/realtek.h
> +++ b/drivers/net/dsa/realtek/realtek.h
> @@ -54,7 +54,7 @@ struct realtek_priv {
>  	struct regmap		*map;
>  	struct regmap		*map_nolock;
>  	struct mutex		map_lock;
> -	struct mii_bus		*slave_mii_bus;
> +	struct mii_bus		*user_mii_bus;
>  	struct mii_bus		*bus;
>  	int			mdio_addr;
>  
> diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
> index 1a367e64bc3b..74cee39d73df 100644
> --- a/drivers/net/dsa/sja1105/sja1105_main.c
> +++ b/drivers/net/dsa/sja1105/sja1105_main.c
> @@ -2688,7 +2688,7 @@ static int sja1105_mgmt_xmit(struct dsa_switch *ds, int port, int slot,
>  	}
>  
>  	/* Transfer skb to the host port. */
> -	dsa_enqueue_skb(skb, dsa_to_port(ds, port)->slave);
> +	dsa_enqueue_skb(skb, dsa_to_port(ds, port)->user);
>  
>  	/* Wait until the switch has processed the frame */
>  	do {
> @@ -3081,7 +3081,7 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
>   * ref_clk pin. So port clocking needs to be initialized early, before
>   * connecting to PHYs is attempted, otherwise they won't respond through MDIO.
>   * Setting correct PHY link speed does not matter now.
> - * But dsa_slave_phy_setup is called later than sja1105_setup, so the PHY
> + * But dsa_user_phy_setup is called later than sja1105_setup, so the PHY
>   * bindings are not yet parsed by DSA core. We need to parse early so that we
>   * can populate the xMII mode parameters table.
>   */
> diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
> index 5b02e9e426fd..96db032b478f 100644
> --- a/drivers/net/dsa/xrs700x/xrs700x.c
> +++ b/drivers/net/dsa/xrs700x/xrs700x.c
> @@ -554,7 +554,7 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
>  	unsigned int val = XRS_HSR_CFG_HSR_PRP;
>  	struct dsa_port *partner = NULL, *dp;
>  	struct xrs700x *priv = ds->priv;
> -	struct net_device *slave;
> +	struct net_device *user;
>  	int ret, i, hsr_pair[2];
>  	enum hsr_version ver;
>  	bool fwd = false;
> @@ -638,8 +638,8 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
>  	hsr_pair[0] = port;
>  	hsr_pair[1] = partner->index;
>  	for (i = 0; i < ARRAY_SIZE(hsr_pair); i++) {
> -		slave = dsa_to_port(ds, hsr_pair[i])->slave;
> -		slave->features |= XRS7000X_SUPPORTED_HSR_FEATURES;
> +		user = dsa_to_port(ds, hsr_pair[i])->user;
> +		user->features |= XRS7000X_SUPPORTED_HSR_FEATURES;
>  	}
>  
>  	return 0;
> @@ -650,7 +650,7 @@ static int xrs700x_hsr_leave(struct dsa_switch *ds, int port,
>  {
>  	struct dsa_port *partner = NULL, *dp;
>  	struct xrs700x *priv = ds->priv;
> -	struct net_device *slave;
> +	struct net_device *user;
>  	int i, hsr_pair[2];
>  	unsigned int val;
>  
> @@ -692,8 +692,8 @@ static int xrs700x_hsr_leave(struct dsa_switch *ds, int port,
>  	hsr_pair[0] = port;
>  	hsr_pair[1] = partner->index;
>  	for (i = 0; i < ARRAY_SIZE(hsr_pair); i++) {
> -		slave = dsa_to_port(ds, hsr_pair[i])->slave;
> -		slave->features &= ~XRS7000X_SUPPORTED_HSR_FEATURES;
> +		user = dsa_to_port(ds, hsr_pair[i])->user;
> +		user->features &= ~XRS7000X_SUPPORTED_HSR_FEATURES;
>  	}
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index ab096795e805..c9faa8540859 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2430,7 +2430,7 @@ static int bcm_sysport_netdevice_event(struct notifier_block *nb,
>  		if (dev->netdev_ops != &bcm_sysport_netdev_ops)
>  			return NOTIFY_DONE;
>  
> -		if (!dsa_slave_dev_check(info->upper_dev))
> +		if (!dsa_user_dev_check(info->upper_dev))
>  			return NOTIFY_DONE;
>  
>  		if (info->linking)
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 60d49b0f595f..3cf6589cfdac 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -3329,7 +3329,7 @@ static int mtk_device_event(struct notifier_block *n, unsigned long event, void
>  	return NOTIFY_DONE;
>  
>  found:
> -	if (!dsa_slave_dev_check(dev))
> +	if (!dsa_user_dev_check(dev))
>  		return NOTIFY_DONE;
>  
>  	if (__ethtool_get_link_ksettings(dev, &s))
> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index e073d2b5542c..fbb5e9d5af13 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> @@ -175,7 +175,7 @@ mtk_flow_get_dsa_port(struct net_device **dev)
>  	if (dp->cpu_dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
>  		return -ENODEV;
>  
> -	*dev = dsa_port_to_master(dp);
> +	*dev = dsa_port_to_conduit(dp);
>  
>  	return dp->index;
>  #else
> diff --git a/include/linux/dsa/sja1105.h b/include/linux/dsa/sja1105.h
> index c177322f793d..b9dd35d4b8f5 100644
> --- a/include/linux/dsa/sja1105.h
> +++ b/include/linux/dsa/sja1105.h
> @@ -28,7 +28,7 @@
>  /* Source and Destination MAC of follow-up meta frames.
>   * Whereas the choice of SMAC only affects the unique identification of the
>   * switch as sender of meta frames, the DMAC must be an address that is present
> - * in the DSA master port's multicast MAC filter.
> + * in the DSA conduit port's multicast MAC filter.
>   * 01-80-C2-00-00-0E is a good choice for this, as all profiles of IEEE 1588
>   * over L2 use this address for some purpose already.
>   */
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index d98439ea6146..9e6c6a610e4b 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -102,11 +102,11 @@ struct dsa_device_ops {
>  	const char *name;
>  	enum dsa_tag_protocol proto;
>  	/* Some tagging protocols either mangle or shift the destination MAC
> -	 * address, in which case the DSA master would drop packets on ingress
> +	 * address, in which case the DSA conduit would drop packets on ingress
>  	 * if what it understands out of the destination MAC address is not in
>  	 * its RX filter.
>  	 */
> -	bool promisc_on_master;
> +	bool promisc_on_conduit;
>  };
>  
>  struct dsa_lag {
> @@ -236,12 +236,12 @@ struct dsa_bridge {
>  };
>  
>  struct dsa_port {
> -	/* A CPU port is physically connected to a master device.
> -	 * A user port exposed to userspace has a slave device.
> +	/* A CPU port is physically connected to a conduit device.
> +	 * A user port exposed to userspace has a user device.

The explanation for the user port now sounds tautological. How about
"a user port exposes a net device to userspace, called 'user' here"?

>  	 */
>  	union {
> -		struct net_device *master;
> -		struct net_device *slave;
> +		struct net_device *conduit;
> +		struct net_device *user;
>  	};
>  
>  	/* Copy of the tagging protocol operations, for quicker access
> @@ -249,7 +249,7 @@ struct dsa_port {
>  	 */
>  	const struct dsa_device_ops *tag_ops;
>  
> -	/* Copies for faster access in master receive hot path */
> +	/* Copies for faster access in conduit receive hot path */
>  	struct dsa_switch_tree *dst;
>  	struct sk_buff *(*rcv)(struct sk_buff *skb, struct net_device *dev);
>  
> @@ -281,9 +281,9 @@ struct dsa_port {
>  
>  	u8			lag_tx_enabled:1;
>  
> -	/* Master state bits, valid only on CPU ports */
> -	u8			master_admin_up:1;
> -	u8			master_oper_up:1;
> +	/* conduit state bits, valid only on CPU ports */
> +	u8			conduit_admin_up:1;
> +	u8			conduit_oper_up:1;
>  
>  	/* Valid only on user ports */
>  	u8			cpu_port_in_lag:1;
> @@ -303,7 +303,7 @@ struct dsa_port {
>  	struct list_head list;
>  
>  	/*
> -	 * Original copy of the master netdev ethtool_ops
> +	 * Original copy of the conduit netdev ethtool_ops
>  	 */
>  	const struct ethtool_ops *orig_ethtool_ops;
>  
> @@ -452,10 +452,10 @@ struct dsa_switch {
>  	const struct dsa_switch_ops	*ops;
>  
>  	/*
> -	 * Slave mii_bus and devices for the individual ports.
> +	 * user mii_bus and devices for the individual ports.

Preserve capital U?

>  	 */
>  	u32			phys_mii_mask;
> -	struct mii_bus		*slave_mii_bus;
> +	struct mii_bus		*user_mii_bus;
>  
>  	/* Ageing Time limits in msecs */
>  	unsigned int ageing_time_min;
> @@ -520,10 +520,10 @@ static inline bool dsa_port_is_unused(struct dsa_port *dp)
>  	return dp->type == DSA_PORT_TYPE_UNUSED;
>  }
>  
> -static inline bool dsa_port_master_is_operational(struct dsa_port *dp)
> +static inline bool dsa_port_conduit_is_operational(struct dsa_port *dp)
>  {
> -	return dsa_port_is_cpu(dp) && dp->master_admin_up &&
> -	       dp->master_oper_up;
> +	return dsa_port_is_cpu(dp) && dp->conduit_admin_up &&
> +	       dp->conduit_oper_up;
>  }
>  
>  static inline bool dsa_is_unused_port(struct dsa_switch *ds, int p)
> @@ -713,12 +713,12 @@ static inline bool dsa_port_offloads_lag(struct dsa_port *dp,
>  	return dsa_port_lag_dev_get(dp) == lag->dev;
>  }
>  
> -static inline struct net_device *dsa_port_to_master(const struct dsa_port *dp)
> +static inline struct net_device *dsa_port_to_conduit(const struct dsa_port *dp)
>  {
>  	if (dp->cpu_port_in_lag)
>  		return dsa_port_lag_dev_get(dp->cpu_dp);
>  
> -	return dp->cpu_dp->master;
> +	return dp->cpu_dp->conduit;
>  }
>  
>  static inline
> @@ -732,7 +732,7 @@ struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
>  	else if (dp->hsr_dev)
>  		return dp->hsr_dev;
>  
> -	return dp->slave;
> +	return dp->user;
>  }
>  
>  static inline struct net_device *
> @@ -834,8 +834,8 @@ struct dsa_switch_ops {
>  	int	(*connect_tag_protocol)(struct dsa_switch *ds,
>  					enum dsa_tag_protocol proto);
>  
> -	int	(*port_change_master)(struct dsa_switch *ds, int port,
> -				      struct net_device *master,
> +	int	(*port_change_conduit)(struct dsa_switch *ds, int port,
> +				      struct net_device *conduit,
>  				      struct netlink_ext_ack *extack);

Please realign.

>  
>  	/* Optional switch-wide initialization and destruction methods */
> @@ -1233,11 +1233,11 @@ struct dsa_switch_ops {
>  	int	(*tag_8021q_vlan_del)(struct dsa_switch *ds, int port, u16 vid);
>  
>  	/*
> -	 * DSA master tracking operations
> +	 * DSA conduit tracking operations
>  	 */
> -	void	(*master_state_change)(struct dsa_switch *ds,
> -				       const struct net_device *master,
> -				       bool operational);
> +	void	(*conduit_state_change)(struct dsa_switch *ds,
> +					const struct net_device *conduit,
> +					bool operational);

Please realign.

>  };
>  
>  #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
> @@ -1374,9 +1374,9 @@ static inline int dsa_switch_resume(struct dsa_switch *ds)
>  #endif /* CONFIG_PM_SLEEP */
>  
>  #if IS_ENABLED(CONFIG_NET_DSA)
> -bool dsa_slave_dev_check(const struct net_device *dev);
> +bool dsa_user_dev_check(const struct net_device *dev);
>  #else
> -static inline bool dsa_slave_dev_check(const struct net_device *dev)
> +static inline bool dsa_user_dev_check(const struct net_device *dev)
>  {
>  	return false;
>  }
> diff --git a/include/net/dsa_stubs.h b/include/net/dsa_stubs.h
> index 361811750a54..45f80661bbe1 100644
> --- a/include/net/dsa_stubs.h
> +++ b/include/net/dsa_stubs.h
> @@ -13,12 +13,12 @@
>  extern const struct dsa_stubs *dsa_stubs;
>  
>  struct dsa_stubs {
> -	int (*master_hwtstamp_validate)(struct net_device *dev,
> +	int (*conduit_hwtstamp_validate)(struct net_device *dev,
>  					const struct kernel_hwtstamp_config *config,
>  					struct netlink_ext_ack *extack);

Please realign.

>  };
>  
> -static inline int dsa_master_hwtstamp_validate(struct net_device *dev,
> +static inline int dsa_conduit_hwtstamp_validate(struct net_device *dev,
>  					       const struct kernel_hwtstamp_config *config,
>  					       struct netlink_ext_ack *extack)

Please realign.

>  {
> @@ -29,16 +29,16 @@ static inline int dsa_master_hwtstamp_validate(struct net_device *dev,
>  	 * netdev_uses_dsa() returns true, the dsa_core module is still
>  	 * registered, and so, dsa_unregister_stubs() couldn't have run.
>  	 * For netdev_uses_dsa() to start returning false, it would imply that
> -	 * dsa_master_teardown() has executed, which requires rtnl_lock().
> +	 * dsa_conduit_teardown() has executed, which requires rtnl_lock().
>  	 */
>  	ASSERT_RTNL();
>  
> -	return dsa_stubs->master_hwtstamp_validate(dev, config, extack);
> +	return dsa_stubs->conduit_hwtstamp_validate(dev, config, extack);
>  }
>  
>  #else
>  
> -static inline int dsa_master_hwtstamp_validate(struct net_device *dev,
> +static inline int dsa_conduit_hwtstamp_validate(struct net_device *dev,
>  					       const struct kernel_hwtstamp_config *config,
>  					       struct netlink_ext_ack *extack)

Please realign.

>  {
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index b46aedc36939..feeddf95f450 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -382,7 +382,7 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
>  	if (err)
>  		return err;
>  
> -	err = dsa_master_hwtstamp_validate(dev, &kernel_cfg, &extack);
> +	err = dsa_conduit_hwtstamp_validate(dev, &kernel_cfg, &extack);
>  	if (err) {
>  		if (extack._msg)
>  			netdev_err(dev, "%s\n", extack._msg);
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index 12e305824a96..009053962c63 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -10,10 +10,10 @@ obj-$(CONFIG_NET_DSA) += dsa_core.o
>  dsa_core-y += \
>  	devlink.o \
>  	dsa.o \
> -	master.o \
> +	conduit.o \
>  	netlink.o \
>  	port.o \
> -	slave.o \
> +	user.o \
>  	switch.o \
>  	tag.o \
>  	tag_8021q.o \

These used to be sorted alphabetically.

> diff --git a/net/dsa/master.c b/net/dsa/conduit.c
> similarity index 79%
> rename from net/dsa/master.c
> rename to net/dsa/conduit.c
> index 6be89ab0cc01..4963debd2bb9 100644
> --- a/net/dsa/master.c
> +++ b/net/dsa/conduit.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Handling of a master device, switching frames via its switch fabric CPU port
> + * Handling of a conduit device, switching frames via its switch fabric CPU port
>   *
>   * Copyright (c) 2017 Savoir-faire Linux Inc.
>   *	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> @@ -12,11 +12,11 @@
>  #include <net/dsa.h>
>  
>  #include "dsa.h"
> -#include "master.h"
> +#include "conduit.h"

These too.

>  #include "port.h"
>  #include "tag.h"
>  
> -static int dsa_master_get_regs_len(struct net_device *dev)
> +static int dsa_conduit_get_regs_len(struct net_device *dev)
>  {
>  	struct dsa_port *cpu_dp = dev->dsa_ptr;
>  	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
> @@ -45,7 +45,7 @@ static int dsa_master_get_regs_len(struct net_device *dev)
>  	return ret;
>  }
>  
> -static void dsa_master_get_regs(struct net_device *dev,
> +static void dsa_conduit_get_regs(struct net_device *dev,
>  				struct ethtool_regs *regs, void *data)

Please preserve argument alignment to open bracket.

>  {
>  	struct dsa_port *cpu_dp = dev->dsa_ptr;
> @@ -80,7 +80,7 @@ static void dsa_master_get_regs(struct net_device *dev,
>  	}
>  }
>  
> -static void dsa_master_get_ethtool_stats(struct net_device *dev,
> +static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
>  					 struct ethtool_stats *stats,
>  					 uint64_t *data)

Alignment.

>  {
> @@ -99,7 +99,7 @@ static void dsa_master_get_ethtool_stats(struct net_device *dev,
>  		ds->ops->get_ethtool_stats(ds, port, data + count);
>  }
>  
> -static void dsa_master_get_ethtool_phy_stats(struct net_device *dev,
> +static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
>  					     struct ethtool_stats *stats,
>  					     uint64_t *data)

Alignment.

>  {
> @@ -125,7 +125,7 @@ static void dsa_master_get_ethtool_phy_stats(struct net_device *dev,
>  		ds->ops->get_ethtool_phy_stats(ds, port, data + count);
>  }
>  
> -static int dsa_master_get_sset_count(struct net_device *dev, int sset)
> +static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
>  {
>  	struct dsa_port *cpu_dp = dev->dsa_ptr;
>  	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
> @@ -147,7 +147,7 @@ static int dsa_master_get_sset_count(struct net_device *dev, int sset)
>  	return count;
>  }
>  
> -static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
> +static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
>  				   uint8_t *data)

Alignment.

>  {
>  	struct dsa_port *cpu_dp = dev->dsa_ptr;
> @@ -195,10 +195,10 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
>  	}
>  }
>  
> -/* Deny PTP operations on master if there is at least one switch in the tree
> +/* Deny PTP operations on conduit if there is at least one switch in the tree
>   * that is PTP capable.
>   */
> -int __dsa_master_hwtstamp_validate(struct net_device *dev,
> +int __dsa_conduit_hwtstamp_validate(struct net_device *dev,
>  				   const struct kernel_hwtstamp_config *config,
>  				   struct netlink_ext_ack *extack)

Alignment.

Sorry, I'm stopping here.
