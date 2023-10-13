Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B767C8F97
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjJMVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjJMVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:53:06 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AABB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:53:00 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7af20c488so30874857b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697233979; x=1697838779; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OzfNMlqm5LipCHIHJ9AotV2+iG0K+seIseTfiMNXzdg=;
        b=Sst7vbBo7gQD7YT9dTuDAddxDex41I++96OEa0WK+y4uHYQjTUk2g/x2/30tGSgYnP
         tNodmG0rs/4rTviUBc8H3rnRGP8+9AKr0jH/7aGnW+D+o5CjccfG+85YpflU9jSfgAAS
         1Dt5kgej8xtXbzH1exs9+VN3ikryH1TLbq7qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233979; x=1697838779;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzfNMlqm5LipCHIHJ9AotV2+iG0K+seIseTfiMNXzdg=;
        b=IZJnqo/NnDkNT1hmWRRx6CwQE76/ywH7eix84YevgyGZjlI1bT2MEmPiyUnrxrwChp
         Lxc9S8antWddEy8M92HlEM4rN9cXFiH19RmWtLDzu3FvFFqynBFek91ib9vEx4iI1mri
         pOTM8e+VWSwvNgGJbzjQj7cK6VXZXz8O8pxrzeZyASy592IfO86orjatiF3PotNiFEoj
         PItSBCHLaycZY/QPl8fKf1C7tsFEbY3ju/jdGwCQQU0Jy+D8XO1dKyl8+uMq1aFPiAtu
         DUAKYsNR+MHKP/jlqJ8rjLSFHkBxet48ljv100UUaF8Q+FktwExMcO4RKXba3YoJ+/r/
         Wxxw==
X-Gm-Message-State: AOJu0YyditryyrmGr+AmB3MsCpKjcA8HffsqFZthc+SwyggNURjZs+2q
        oTtbsE40vhbZvtgsiAr4SF8bAg==
X-Google-Smtp-Source: AGHT+IHM6PspW8IADioVkx+0lB5e3VRdOwhbtTa4mzW6wnQCm80IRmZf5roJHly4+jB0BRVpTbF7mg==
X-Received: by 2002:a81:ad5f:0:b0:5a7:ab31:f4e2 with SMTP id l31-20020a81ad5f000000b005a7ab31f4e2mr15245891ywk.13.1697233977770;
        Fri, 13 Oct 2023 14:52:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y11-20020a0cf14b000000b0066d0621bb67sm1005295qvl.114.2023.10.13.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:52:56 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH net-next v3 1/2] net: dsa: Use conduit and user terms
Date:   Fri, 13 Oct 2023 14:52:50 -0700
Message-Id: <20231013215251.152912-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013215251.152912-1-florian.fainelli@broadcom.com>
References: <20231013215251.152912-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000741bad0607a0144b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000741bad0607a0144b
Content-Transfer-Encoding: 8bit

Use more inclusive terms throughout the DSA subsystem by moving away
from "master" which is replaced by "conduit" and "slave" which is
replaced by "user". No functional changes.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../bindings/net/dsa/mediatek,mt7530.yaml     |    2 +-
 Documentation/networking/dsa/b53.rst          |   14 +-
 Documentation/networking/dsa/bcm_sf2.rst      |    2 +-
 .../networking/dsa/configuration.rst          |  100 +-
 Documentation/networking/dsa/dsa.rst          |  156 +-
 Documentation/networking/dsa/lan9303.rst      |    2 +-
 Documentation/networking/dsa/sja1105.rst      |    6 +-
 .../dts/marvell/armada-3720-espressobin.dtsi  |    2 +-
 drivers/net/dsa/b53/b53_common.c              |    4 +-
 drivers/net/dsa/b53/b53_mdio.c                |    2 +-
 drivers/net/dsa/bcm_sf2.c                     |   36 +-
 drivers/net/dsa/bcm_sf2.h                     |    2 +-
 drivers/net/dsa/bcm_sf2_cfp.c                 |    4 +-
 drivers/net/dsa/lan9303-core.c                |    4 +-
 drivers/net/dsa/lantiq_gswip.c                |   34 +-
 drivers/net/dsa/microchip/ksz9477.c           |    6 +-
 drivers/net/dsa/microchip/ksz_common.c        |   20 +-
 drivers/net/dsa/microchip/ksz_ptp.c           |    2 +-
 drivers/net/dsa/mt7530.c                      |   16 +-
 drivers/net/dsa/mv88e6xxx/chip.c              |    2 +-
 drivers/net/dsa/ocelot/felix.c                |   68 +-
 drivers/net/dsa/ocelot/felix.h                |    6 +-
 drivers/net/dsa/qca/qca8k-8xxx.c              |   50 +-
 drivers/net/dsa/qca/qca8k-common.c            |    2 +-
 drivers/net/dsa/qca/qca8k-leds.c              |    6 +-
 drivers/net/dsa/qca/qca8k.h                   |    2 +-
 drivers/net/dsa/realtek/realtek-smi.c         |   28 +-
 drivers/net/dsa/realtek/realtek.h             |    2 +-
 drivers/net/dsa/sja1105/sja1105_main.c        |    4 +-
 drivers/net/dsa/xrs700x/xrs700x.c             |   12 +-
 drivers/net/ethernet/broadcom/bcmsysport.c    |    2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |    2 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |    2 +-
 include/linux/dsa/sja1105.h                   |    2 +-
 include/net/dsa.h                             |   56 +-
 include/net/dsa_stubs.h                       |   22 +-
 net/core/dev_ioctl.c                          |    2 +-
 net/dsa/Makefile                              |    6 +-
 net/dsa/{master.c => conduit.c}               |  118 +-
 net/dsa/conduit.h                             |   22 +
 net/dsa/dsa.c                                 |  222 +--
 net/dsa/dsa.h                                 |   12 +-
 net/dsa/master.h                              |   22 -
 net/dsa/netlink.c                             |   14 +-
 net/dsa/port.c                                |  124 +-
 net/dsa/port.h                                |    4 +-
 net/dsa/slave.h                               |   69 -
 net/dsa/switch.c                              |   18 +-
 net/dsa/switch.h                              |    4 +-
 net/dsa/tag.c                                 |   10 +-
 net/dsa/tag.h                                 |   26 +-
 net/dsa/tag_8021q.c                           |   22 +-
 net/dsa/tag_8021q.h                           |    2 +-
 net/dsa/tag_ar9331.c                          |    4 +-
 net/dsa/tag_brcm.c                            |   14 +-
 net/dsa/tag_dsa.c                             |    6 +-
 net/dsa/tag_gswip.c                           |    4 +-
 net/dsa/tag_hellcreek.c                       |    4 +-
 net/dsa/tag_ksz.c                             |   12 +-
 net/dsa/tag_lan9303.c                         |    4 +-
 net/dsa/tag_mtk.c                             |    4 +-
 net/dsa/tag_none.c                            |    6 +-
 net/dsa/tag_ocelot.c                          |   22 +-
 net/dsa/tag_ocelot_8021q.c                    |   12 +-
 net/dsa/tag_qca.c                             |    6 +-
 net/dsa/tag_rtl4_a.c                          |    6 +-
 net/dsa/tag_rtl8_4.c                          |    6 +-
 net/dsa/tag_rzn1_a5psw.c                      |    4 +-
 net/dsa/tag_sja1105.c                         |   30 +-
 net/dsa/tag_trailer.c                         |    4 +-
 net/dsa/tag_xrs700x.c                         |    4 +-
 net/dsa/{slave.c => user.c}                   | 1462 ++++++++---------
 net/dsa/user.h                                |   69 +
 73 files changed, 1531 insertions(+), 1531 deletions(-)
 rename net/dsa/{master.c => conduit.c} (76%)
 create mode 100644 net/dsa/conduit.h
 delete mode 100644 net/dsa/master.h
 delete mode 100644 net/dsa/slave.h
 rename net/dsa/{slave.c => user.c} (62%)
 create mode 100644 net/dsa/user.h

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index e532c6b795f4..6ff5b944f5a8 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -60,7 +60,7 @@ description: |
 
       Check out example 6.
 
-    - Port 5 can be wired to an external phy. Port 5 becomes a DSA slave.
+    - Port 5 can be wired to an external phy. Port 5 becomes a DSA user port.
 
       For the multi-chip module MT7530, the external phy must be wired TX to TX
       to gmac1 of the SoC for this to work. Ubiquiti EdgeRouter X SFP is wired
diff --git a/Documentation/networking/dsa/b53.rst b/Documentation/networking/dsa/b53.rst
index b41637cdb82b..1cb3ff648f88 100644
--- a/Documentation/networking/dsa/b53.rst
+++ b/Documentation/networking/dsa/b53.rst
@@ -52,7 +52,7 @@ VLAN programming would basically change the CPU port's default PVID and make
 it untagged, undesirable.
 
 In difference to the configuration described in :ref:`dsa-vlan-configuration`
-the default VLAN 1 has to be removed from the slave interface configuration in
+the default VLAN 1 has to be removed from the user interface configuration in
 single port and gateway configuration, while there is no need to add an extra
 VLAN configuration in the bridge showcase.
 
@@ -68,13 +68,13 @@ By default packages are tagged with vid 1:
   ip link add link eth0 name eth0.2 type vlan id 2
   ip link add link eth0 name eth0.3 type vlan id 3
 
-  # The master interface needs to be brought up before the slave ports.
+  # The conduit interface needs to be brought up before the user ports.
   ip link set eth0 up
   ip link set eth0.1 up
   ip link set eth0.2 up
   ip link set eth0.3 up
 
-  # bring up the slave interfaces
+  # bring up the user interfaces
   ip link set wan up
   ip link set lan1 up
   ip link set lan2 up
@@ -113,11 +113,11 @@ bridge
   # tag traffic on CPU port
   ip link add link eth0 name eth0.1 type vlan id 1
 
-  # The master interface needs to be brought up before the slave ports.
+  # The conduit interface needs to be brought up before the user ports.
   ip link set eth0 up
   ip link set eth0.1 up
 
-  # bring up the slave interfaces
+  # bring up the user interfaces
   ip link set wan up
   ip link set lan1 up
   ip link set lan2 up
@@ -149,12 +149,12 @@ gateway
   ip link add link eth0 name eth0.1 type vlan id 1
   ip link add link eth0 name eth0.2 type vlan id 2
 
-  # The master interface needs to be brought up before the slave ports.
+  # The conduit interface needs to be brought up before the user ports.
   ip link set eth0 up
   ip link set eth0.1 up
   ip link set eth0.2 up
 
-  # bring up the slave interfaces
+  # bring up the user interfaces
   ip link set wan up
   ip link set lan1 up
   ip link set lan2 up
diff --git a/Documentation/networking/dsa/bcm_sf2.rst b/Documentation/networking/dsa/bcm_sf2.rst
index dee234039e1e..d2571435696f 100644
--- a/Documentation/networking/dsa/bcm_sf2.rst
+++ b/Documentation/networking/dsa/bcm_sf2.rst
@@ -67,7 +67,7 @@ MDIO indirect accesses
 ----------------------
 
 Due to a limitation in how Broadcom switches have been designed, external
-Broadcom switches connected to a SF2 require the use of the DSA slave MDIO bus
+Broadcom switches connected to a SF2 require the use of the DSA user MDIO bus
 in order to properly configure them. By default, the SF2 pseudo-PHY address, and
 an external switch pseudo-PHY address will both be snooping for incoming MDIO
 transactions, since they are at the same address (30), resulting in some kind of
diff --git a/Documentation/networking/dsa/configuration.rst b/Documentation/networking/dsa/configuration.rst
index d2934c40f0f1..e6c9719874b0 100644
--- a/Documentation/networking/dsa/configuration.rst
+++ b/Documentation/networking/dsa/configuration.rst
@@ -31,38 +31,38 @@ at https://www.kernel.org/pub/linux/utils/net/iproute2/
 
 Through DSA every port of a switch is handled like a normal linux Ethernet
 interface. The CPU port is the switch port connected to an Ethernet MAC chip.
-The corresponding linux Ethernet interface is called the master interface.
-All other corresponding linux interfaces are called slave interfaces.
+The corresponding linux Ethernet interface is called the conduit interface.
+All other corresponding linux interfaces are called user interfaces.
 
-The slave interfaces depend on the master interface being up in order for them
-to send or receive traffic. Prior to kernel v5.12, the state of the master
+The user interfaces depend on the conduit interface being up in order for them
+to send or receive traffic. Prior to kernel v5.12, the state of the conduit
 interface had to be managed explicitly by the user. Starting with kernel v5.12,
 the behavior is as follows:
 
-- when a DSA slave interface is brought up, the master interface is
+- when a DSA user interface is brought up, the conduit interface is
   automatically brought up.
-- when the master interface is brought down, all DSA slave interfaces are
+- when the conduit interface is brought down, all DSA user interfaces are
   automatically brought down.
 
 In this documentation the following Ethernet interfaces are used:
 
 *eth0*
-  the master interface
+  the conduit interface
 
 *eth1*
-  another master interface
+  another conduit interface
 
 *lan1*
-  a slave interface
+  a user interface
 
 *lan2*
-  another slave interface
+  another user interface
 
 *lan3*
-  a third slave interface
+  a third user interface
 
 *wan*
-  A slave interface dedicated for upstream traffic
+  A user interface dedicated for upstream traffic
 
 Further Ethernet interfaces can be configured similar.
 The configured IPs and networks are:
@@ -96,11 +96,11 @@ without using a VLAN based configuration.
     ip addr add 192.0.2.5/30 dev lan2
     ip addr add 192.0.2.9/30 dev lan3
 
-    # For kernels earlier than v5.12, the master interface needs to be
-    # brought up manually before the slave ports.
+    # For kernels earlier than v5.12, the conduit interface needs to be
+    # brought up manually before the user ports.
     ip link set eth0 up
 
-    # bring up the slave interfaces
+    # bring up the user interfaces
     ip link set lan1 up
     ip link set lan2 up
     ip link set lan3 up
@@ -108,11 +108,11 @@ without using a VLAN based configuration.
 *bridge*
   .. code-block:: sh
 
-    # For kernels earlier than v5.12, the master interface needs to be
-    # brought up manually before the slave ports.
+    # For kernels earlier than v5.12, the conduit interface needs to be
+    # brought up manually before the user ports.
     ip link set eth0 up
 
-    # bring up the slave interfaces
+    # bring up the user interfaces
     ip link set lan1 up
     ip link set lan2 up
     ip link set lan3 up
@@ -134,11 +134,11 @@ without using a VLAN based configuration.
 *gateway*
   .. code-block:: sh
 
-    # For kernels earlier than v5.12, the master interface needs to be
-    # brought up manually before the slave ports.
+    # For kernels earlier than v5.12, the conduit interface needs to be
+    # brought up manually before the user ports.
     ip link set eth0 up
 
-    # bring up the slave interfaces
+    # bring up the user interfaces
     ip link set wan up
     ip link set lan1 up
     ip link set lan2 up
@@ -178,14 +178,14 @@ configuration.
     ip link add link eth0 name eth0.2 type vlan id 2
     ip link add link eth0 name eth0.3 type vlan id 3
 
-    # For kernels earlier than v5.12, the master interface needs to be
-    # brought up manually before the slave ports.
+    # For kernels earlier than v5.12, the conduit interface needs to be
+    # brought up manually before the user ports.
     ip link set eth0 up
     ip link set eth0.1 up
     ip link set eth0.2 up
     ip link set eth0.3 up
 
-    # bring up the slave interfaces
+    # bring up the user interfaces
     ip link set lan1 up
     ip link set lan2 up
     ip link set lan3 up
@@ -221,12 +221,12 @@ configuration.
     # tag traffic on CPU port
     ip link add link eth0 name eth0.1 type vlan id 1
 
-    # For kernels earlier than v5.12, the master interface needs to be
-    # brought up manually before the slave ports.
+    # For kernels earlier than v5.12, the conduit interface needs to be
+    # brought up manually before the user ports.
     ip link set eth0 up
     ip link set eth0.1 up
 
-    # bring up the slave interfaces
+    # bring up the user interfaces
     ip link set lan1 up
     ip link set lan2 up
     ip link set lan3 up
@@ -261,13 +261,13 @@ configuration.
     ip link add link eth0 name eth0.1 type vlan id 1
     ip link add link eth0 name eth0.2 type vlan id 2
 
-    # For kernels earlier than v5.12, the master interface needs to be
-    # brought up manually before the slave ports.
+    # For kernels earlier than v5.12, the conduit interface needs to be
+    # brought up manually before the user ports.
     ip link set eth0 up
     ip link set eth0.1 up
     ip link set eth0.2 up
 
-    # bring up the slave interfaces
+    # bring up the user interfaces
     ip link set wan up
     ip link set lan1 up
     ip link set lan2 up
@@ -380,22 +380,22 @@ affinities according to the available CPU ports.
 
 Secondly, it is possible to perform load balancing between CPU ports on a per
 packet basis, rather than statically assigning user ports to CPU ports.
-This can be achieved by placing the DSA masters under a LAG interface (bonding
+This can be achieved by placing the DSA conduits under a LAG interface (bonding
 or team). DSA monitors this operation and creates a mirror of this software LAG
-on the CPU ports facing the physical DSA masters that constitute the LAG slave
+on the CPU ports facing the physical DSA conduits that constitute the LAG slave
 devices.
 
 To make use of multiple CPU ports, the firmware (device tree) description of
-the switch must mark all the links between CPU ports and their DSA masters
+the switch must mark all the links between CPU ports and their DSA conduits
 using the ``ethernet`` reference/phandle. At startup, only a single CPU port
-and DSA master will be used - the numerically first port from the firmware
+and DSA conduit will be used - the numerically first port from the firmware
 description which has an ``ethernet`` property. It is up to the user to
-configure the system for the switch to use other masters.
+configure the system for the switch to use other conduits.
 
 DSA uses the ``rtnl_link_ops`` mechanism (with a "dsa" ``kind``) to allow
-changing the DSA master of a user port. The ``IFLA_DSA_MASTER`` u32 netlink
-attribute contains the ifindex of the master device that handles each slave
-device. The DSA master must be a valid candidate based on firmware node
+changing the DSA conduit of a user port. The ``IFLA_DSA_MASTER`` u32 netlink
+attribute contains the ifindex of the conduit device that handles each user
+device. The DSA conduit must be a valid candidate based on firmware node
 information, or a LAG interface which contains only slaves which are valid
 candidates.
 
@@ -403,7 +403,7 @@ Using iproute2, the following manipulations are possible:
 
   .. code-block:: sh
 
-    # See the DSA master in current use
+    # See the DSA conduit in current use
     ip -d link show dev swp0
         (...)
         dsa master eth0
@@ -414,7 +414,7 @@ Using iproute2, the following manipulations are possible:
     ip link set swp2 type dsa master eth1
     ip link set swp3 type dsa master eth0
 
-    # CPU ports in LAG, using explicit assignment of the DSA master
+    # CPU ports in LAG, using explicit assignment of the DSA conduit
     ip link add bond0 type bond mode balance-xor && ip link set bond0 up
     ip link set eth1 down && ip link set eth1 master bond0
     ip link set swp0 type dsa master bond0
@@ -426,7 +426,7 @@ Using iproute2, the following manipulations are possible:
         (...)
         dsa master bond0
 
-    # CPU ports in LAG, relying on implicit migration of the DSA master
+    # CPU ports in LAG, relying on implicit migration of the DSA conduit
     ip link add bond0 type bond mode balance-xor && ip link set bond0 up
     ip link set eth0 down && ip link set eth0 master bond0
     ip link set eth1 down && ip link set eth1 master bond0
@@ -436,23 +436,23 @@ Using iproute2, the following manipulations are possible:
 
 Notice that in the case of CPU ports under a LAG, the use of the
 ``IFLA_DSA_MASTER`` netlink attribute is not strictly needed, but rather, DSA
-reacts to the ``IFLA_MASTER`` attribute change of its present master (``eth0``)
+reacts to the ``IFLA_MASTER`` attribute change of its present conduit (``eth0``)
 and migrates all user ports to the new upper of ``eth0``, ``bond0``. Similarly,
 when ``bond0`` is destroyed using ``RTM_DELLINK``, DSA migrates the user ports
-that were assigned to this interface to the first physical DSA master which is
+that were assigned to this interface to the first physical DSA conduit which is
 eligible, based on the firmware description (it effectively reverts to the
 startup configuration).
 
 In a setup with more than 2 physical CPU ports, it is therefore possible to mix
-static user to CPU port assignment with LAG between DSA masters. It is not
-possible to statically assign a user port towards a DSA master that has any
-upper interfaces (this includes LAG devices - the master must always be the LAG
+static user to CPU port assignment with LAG between DSA conduits. It is not
+possible to statically assign a user port towards a DSA conduit that has any
+upper interfaces (this includes LAG devices - the conduit must always be the LAG
 in this case).
 
-Live changing of the DSA master (and thus CPU port) affinity of a user port is
+Live changing of the DSA conduit (and thus CPU port) affinity of a user port is
 permitted, in order to allow dynamic redistribution in response to traffic.
 
-Physical DSA masters are allowed to join and leave at any time a LAG interface
-used as a DSA master; however, DSA will reject a LAG interface as a valid
-candidate for being a DSA master unless it has at least one physical DSA master
+Physical DSA conduits are allowed to join and leave at any time a LAG interface
+used as a DSA conduit; however, DSA will reject a LAG interface as a valid
+candidate for being a DSA conduit unless it has at least one physical DSA conduit
 as a slave device.
diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index a94ddf83348a..52c5521a0f6a 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -25,7 +25,7 @@ presence of a management port connected to an Ethernet controller capable of
 receiving Ethernet frames from the switch. This is a very common setup for all
 kinds of Ethernet switches found in Small Home and Office products: routers,
 gateways, or even top-of-rack switches. This host Ethernet controller will
-be later referred to as "master" and "cpu" in DSA terminology and code.
+be later referred to as "conduit" and "cpu" in DSA terminology and code.
 
 The D in DSA stands for Distributed, because the subsystem has been designed
 with the ability to configure and manage cascaded switches on top of each other
@@ -35,7 +35,7 @@ of multiple switches connected to each other is called a "switch tree".
 
 For each front-panel port, DSA creates specialized network devices which are
 used as controlling and data-flowing endpoints for use by the Linux networking
-stack. These specialized network interfaces are referred to as "slave" network
+stack. These specialized network interfaces are referred to as "user" network
 interfaces in DSA terminology and code.
 
 The ideal case for using DSA is when an Ethernet switch supports a "switch tag"
@@ -56,7 +56,7 @@ Note that DSA does not currently create network interfaces for the "cpu" and
 
 - the "cpu" port is the Ethernet switch facing side of the management
   controller, and as such, would create a duplication of feature, since you
-  would get two interfaces for the same conduit: master netdev, and "cpu" netdev
+  would get two interfaces for the same conduit: conduit netdev, and "cpu" netdev
 
 - the "dsa" port(s) are just conduits between two or more switches, and as such
   cannot really be used as proper network interfaces either, only the
@@ -80,14 +80,14 @@ methods of the ``struct dsa_device_ops`` structure, which are detailed below.
 Tagging protocols generally fall in one of three categories:
 
 1. The switch-specific frame header is located before the Ethernet header,
-   shifting to the right (from the perspective of the DSA master's frame
+   shifting to the right (from the perspective of the DSA conduit's frame
    parser) the MAC DA, MAC SA, EtherType and the entire L2 payload.
 2. The switch-specific frame header is located before the EtherType, keeping
-   the MAC DA and MAC SA in place from the DSA master's perspective, but
+   the MAC DA and MAC SA in place from the DSA conduit's perspective, but
    shifting the 'real' EtherType and L2 payload to the right.
 3. The switch-specific frame header is located at the tail of the packet,
    keeping all frame headers in place and not altering the view of the packet
-   that the DSA master's frame parser has.
+   that the DSA conduit's frame parser has.
 
 A tagging protocol may tag all packets with switch tags of the same length, or
 the tag length might vary (for example packets with PTP timestamps might
@@ -95,7 +95,7 @@ require an extended switch tag, or there might be one tag length on TX and a
 different one on RX). Either way, the tagging protocol driver must populate the
 ``struct dsa_device_ops::needed_headroom`` and/or ``struct dsa_device_ops::needed_tailroom``
 with the length in octets of the longest switch frame header/trailer. The DSA
-framework will automatically adjust the MTU of the master interface to
+framework will automatically adjust the MTU of the conduit interface to
 accommodate for this extra size in order for DSA user ports to support the
 standard MTU (L2 payload length) of 1500 octets. The ``needed_headroom`` and
 ``needed_tailroom`` properties are also used to request from the network stack,
@@ -140,18 +140,18 @@ adding or removing the ``ETH_P_EDSA`` EtherType and some padding octets).
 It is possible to construct cascaded setups of DSA switches even if their
 tagging protocols are not compatible with one another. In this case, there are
 no DSA links in this fabric, and each switch constitutes a disjoint DSA switch
-tree. The DSA links are viewed as simply a pair of a DSA master (the out-facing
+tree. The DSA links are viewed as simply a pair of a DSA conduit (the out-facing
 port of the upstream DSA switch) and a CPU port (the in-facing port of the
 downstream DSA switch).
 
 The tagging protocol of the attached DSA switch tree can be viewed through the
-``dsa/tagging`` sysfs attribute of the DSA master::
+``dsa/tagging`` sysfs attribute of the DSA conduit::
 
     cat /sys/class/net/eth0/dsa/tagging
 
 If the hardware and driver are capable, the tagging protocol of the DSA switch
 tree can be changed at runtime. This is done by writing the new tagging
-protocol name to the same sysfs device attribute as above (the DSA master and
+protocol name to the same sysfs device attribute as above (the DSA conduit and
 all attached switch ports must be down while doing this).
 
 It is desirable that all tagging protocols are testable with the ``dsa_loop``
@@ -159,7 +159,7 @@ mockup driver, which can be attached to any network interface. The goal is that
 any network interface should be capable of transmitting the same packet in the
 same way, and the tagger should decode the same received packet in the same way
 regardless of the driver used for the switch control path, and the driver used
-for the DSA master.
+for the DSA conduit.
 
 The transmission of a packet goes through the tagger's ``xmit`` function.
 The passed ``struct sk_buff *skb`` has ``skb->data`` pointing at
@@ -183,44 +183,44 @@ virtual DSA user network interface corresponding to the physical front-facing
 switch port that the packet was received on.
 
 Since tagging protocols in category 1 and 2 break software (and most often also
-hardware) packet dissection on the DSA master, features such as RPS (Receive
-Packet Steering) on the DSA master would be broken. The DSA framework deals
+hardware) packet dissection on the DSA conduit, features such as RPS (Receive
+Packet Steering) on the DSA conduit would be broken. The DSA framework deals
 with this by hooking into the flow dissector and shifting the offset at which
-the IP header is to be found in the tagged frame as seen by the DSA master.
+the IP header is to be found in the tagged frame as seen by the DSA conduit.
 This behavior is automatic based on the ``overhead`` value of the tagging
 protocol. If not all packets are of equal size, the tagger can implement the
 ``flow_dissect`` method of the ``struct dsa_device_ops`` and override this
 default behavior by specifying the correct offset incurred by each individual
 RX packet. Tail taggers do not cause issues to the flow dissector.
 
-Checksum offload should work with category 1 and 2 taggers when the DSA master
+Checksum offload should work with category 1 and 2 taggers when the DSA conduit
 driver declares NETIF_F_HW_CSUM in vlan_features and looks at csum_start and
 csum_offset. For those cases, DSA will shift the checksum start and offset by
-the tag size. If the DSA master driver still uses the legacy NETIF_F_IP_CSUM
+the tag size. If the DSA conduit driver still uses the legacy NETIF_F_IP_CSUM
 or NETIF_F_IPV6_CSUM in vlan_features, the offload might only work if the
 offload hardware already expects that specific tag (perhaps due to matching
-vendors). DSA slaves inherit those flags from the master port, and it is up to
+vendors). DSA user ports inherit those flags from the conduit, and it is up to
 the driver to correctly fall back to software checksum when the IP header is not
 where the hardware expects. If that check is ineffective, the packets might go
 to the network without a proper checksum (the checksum field will have the
 pseudo IP header sum). For category 3, when the offload hardware does not
 already expect the switch tag in use, the checksum must be calculated before any
-tag is inserted (i.e. inside the tagger). Otherwise, the DSA master would
+tag is inserted (i.e. inside the tagger). Otherwise, the DSA conduit would
 include the tail tag in the (software or hardware) checksum calculation. Then,
 when the tag gets stripped by the switch during transmission, it will leave an
 incorrect IP checksum in place.
 
 Due to various reasons (most common being category 1 taggers being associated
-with DSA-unaware masters, mangling what the master perceives as MAC DA), the
-tagging protocol may require the DSA master to operate in promiscuous mode, to
+with DSA-unaware conduits, mangling what the conduit perceives as MAC DA), the
+tagging protocol may require the DSA conduit to operate in promiscuous mode, to
 receive all frames regardless of the value of the MAC DA. This can be done by
-setting the ``promisc_on_master`` property of the ``struct dsa_device_ops``.
-Note that this assumes a DSA-unaware master driver, which is the norm.
+setting the ``promisc_on_conduit`` property of the ``struct dsa_device_ops``.
+Note that this assumes a DSA-unaware conduit driver, which is the norm.
 
-Master network devices
-----------------------
+Conduit network devices
+-----------------------
 
-Master network devices are regular, unmodified Linux network device drivers for
+Conduit network devices are regular, unmodified Linux network device drivers for
 the CPU/management Ethernet interface. Such a driver might occasionally need to
 know whether DSA is enabled (e.g.: to enable/disable specific offload features),
 but the DSA subsystem has been proven to work with industry standard drivers:
@@ -232,14 +232,14 @@ Ethernet switch.
 Networking stack hooks
 ----------------------
 
-When a master netdev is used with DSA, a small hook is placed in the
+When a conduit netdev is used with DSA, a small hook is placed in the
 networking stack is in order to have the DSA subsystem process the Ethernet
 switch specific tagging protocol. DSA accomplishes this by registering a
 specific (and fake) Ethernet type (later becoming ``skb->protocol``) with the
 networking stack, this is also known as a ``ptype`` or ``packet_type``. A typical
 Ethernet Frame receive sequence looks like this:
 
-Master network device (e.g.: e1000e):
+Conduit network device (e.g.: e1000e):
 
 1. Receive interrupt fires:
 
@@ -269,16 +269,16 @@ Master network device (e.g.: e1000e):
 
         - inspect and strip switch tag protocol to determine originating port
         - locate per-port network device
-        - invoke ``eth_type_trans()`` with the DSA slave network device
+        - invoke ``eth_type_trans()`` with the DSA user network device
         - invoked ``netif_receive_skb()``
 
-Past this point, the DSA slave network devices get delivered regular Ethernet
+Past this point, the DSA user network devices get delivered regular Ethernet
 frames that can be processed by the networking stack.
 
-Slave network devices
+User network devices
 ---------------------
 
-Slave network devices created by DSA are stacked on top of their master network
+User network devices created by DSA are stacked on top of their conduit network
 device, each of these network interfaces will be responsible for being a
 controlling and data-flowing end-point for each front-panel port of the switch.
 These interfaces are specialized in order to:
@@ -289,31 +289,31 @@ These interfaces are specialized in order to:
   Wake-on-LAN, register dumps...
 - manage external/internal PHY: link, auto-negotiation, etc.
 
-These slave network devices have custom net_device_ops and ethtool_ops function
+These user network devices have custom net_device_ops and ethtool_ops function
 pointers which allow DSA to introduce a level of layering between the networking
 stack/ethtool and the switch driver implementation.
 
-Upon frame transmission from these slave network devices, DSA will look up which
+Upon frame transmission from these user network devices, DSA will look up which
 switch tagging protocol is currently registered with these network devices and
 invoke a specific transmit routine which takes care of adding the relevant
 switch tag in the Ethernet frames.
 
-These frames are then queued for transmission using the master network device
+These frames are then queued for transmission using the conduit network device
 ``ndo_start_xmit()`` function. Since they contain the appropriate switch tag, the
 Ethernet switch will be able to process these incoming frames from the
 management interface and deliver them to the physical switch port.
 
 When using multiple CPU ports, it is possible to stack a LAG (bonding/team)
-device between the DSA slave devices and the physical DSA masters. The LAG
-device is thus also a DSA master, but the LAG slave devices continue to be DSA
-masters as well (just with no user port assigned to them; this is needed for
-recovery in case the LAG DSA master disappears). Thus, the data path of the LAG
-DSA master is used asymmetrically. On RX, the ``ETH_P_XDSA`` handler, which
-calls ``dsa_switch_rcv()``, is invoked early (on the physical DSA master;
-LAG slave). Therefore, the RX data path of the LAG DSA master is not used.
-On the other hand, TX takes place linearly: ``dsa_slave_xmit`` calls
-``dsa_enqueue_skb``, which calls ``dev_queue_xmit`` towards the LAG DSA master.
-The latter calls ``dev_queue_xmit`` towards one physical DSA master or the
+device between the DSA user devices and the physical DSA conduits. The LAG
+device is thus also a DSA conduit, but the LAG slave devices continue to be DSA
+conduits as well (just with no user port assigned to them; this is needed for
+recovery in case the LAG DSA conduit disappears). Thus, the data path of the LAG
+DSA conduit is used asymmetrically. On RX, the ``ETH_P_XDSA`` handler, which
+calls ``dsa_switch_rcv()``, is invoked early (on the physical DSA conduit;
+LAG slave). Therefore, the RX data path of the LAG DSA conduit is not used.
+On the other hand, TX takes place linearly: ``dsa_user_xmit`` calls
+``dsa_enqueue_skb``, which calls ``dev_queue_xmit`` towards the LAG DSA conduit.
+The latter calls ``dev_queue_xmit`` towards one physical DSA conduit or the
 other, and in both cases, the packet exits the system through a hardware path
 towards the switch.
 
@@ -352,11 +352,11 @@ perspective::
            || swp0 | | swp1 | | swp2 | | swp3 ||
            ++------+-+------+-+------+-+------++
 
-Slave MDIO bus
---------------
+User MDIO bus
+-------------
 
-In order to be able to read to/from a switch PHY built into it, DSA creates a
-slave MDIO bus which allows a specific switch driver to divert and intercept
+In order to be able to read to/from a switch PHY built into it, DSA creates an
+user MDIO bus which allows a specific switch driver to divert and intercept
 MDIO reads/writes towards specific PHY addresses. In most MDIO-connected
 switches, these functions would utilize direct or indirect PHY addressing mode
 to return standard MII registers from the switch builtin PHYs, allowing the PHY
@@ -364,7 +364,7 @@ library and/or to return link status, link partner pages, auto-negotiation
 results, etc.
 
 For Ethernet switches which have both external and internal MDIO buses, the
-slave MII bus can be utilized to mux/demux MDIO reads and writes towards either
+user MII bus can be utilized to mux/demux MDIO reads and writes towards either
 internal or external MDIO devices this switch might be connected to: internal
 PHYs, external PHYs, or even external switches.
 
@@ -381,10 +381,10 @@ DSA data structures are defined in ``include/net/dsa.h`` as well as
 
 - ``dsa_platform_data``: platform device configuration data which can reference
   a collection of dsa_chip_data structures if multiple switches are cascaded,
-  the master network device this switch tree is attached to needs to be
+  the conduit network device this switch tree is attached to needs to be
   referenced
 
-- ``dsa_switch_tree``: structure assigned to the master network device under
+- ``dsa_switch_tree``: structure assigned to the conduit network device under
   ``dsa_ptr``, this structure references a dsa_platform_data structure as well as
   the tagging protocol supported by the switch tree, and which receive/transmit
   function hooks should be invoked, information about the directly attached
@@ -392,7 +392,7 @@ DSA data structures are defined in ``include/net/dsa.h`` as well as
   referenced to address individual switches in the tree.
 
 - ``dsa_switch``: structure describing a switch device in the tree, referencing
-  a ``dsa_switch_tree`` as a backpointer, slave network devices, master network
+  a ``dsa_switch_tree`` as a backpointer, user network devices, conduit network
   device, and a reference to the backing``dsa_switch_ops``
 
 - ``dsa_switch_ops``: structure referencing function pointers, see below for a
@@ -404,7 +404,7 @@ Design limitations
 Lack of CPU/DSA network devices
 -------------------------------
 
-DSA does not currently create slave network devices for the CPU or DSA ports, as
+DSA does not currently create user network devices for the CPU or DSA ports, as
 described before. This might be an issue in the following cases:
 
 - inability to fetch switch CPU port statistics counters using ethtool, which
@@ -419,7 +419,7 @@ described before. This might be an issue in the following cases:
 Common pitfalls using DSA setups
 --------------------------------
 
-Once a master network device is configured to use DSA (dev->dsa_ptr becomes
+Once a conduit network device is configured to use DSA (dev->dsa_ptr becomes
 non-NULL), and the switch behind it expects a tagging protocol, this network
 interface can only exclusively be used as a conduit interface. Sending packets
 directly through this interface (e.g.: opening a socket using this interface)
@@ -440,7 +440,7 @@ DSA currently leverages the following subsystems:
 MDIO/PHY library
 ----------------
 
-Slave network devices exposed by DSA may or may not be interfacing with PHY
+User network devices exposed by DSA may or may not be interfacing with PHY
 devices (``struct phy_device`` as defined in ``include/linux/phy.h)``, but the DSA
 subsystem deals with all possible combinations:
 
@@ -450,7 +450,7 @@ subsystem deals with all possible combinations:
 - special, non-autonegotiated or non MDIO-managed PHY devices: SFPs, MoCA; a.k.a
   fixed PHYs
 
-The PHY configuration is done by the ``dsa_slave_phy_setup()`` function and the
+The PHY configuration is done by the ``dsa_user_phy_setup()`` function and the
 logic basically looks like this:
 
 - if Device Tree is used, the PHY device is looked up using the standard
@@ -463,7 +463,7 @@ logic basically looks like this:
   and connected transparently using the special fixed MDIO bus driver
 
 - finally, if the PHY is built into the switch, as is very common with
-  standalone switch packages, the PHY is probed using the slave MII bus created
+  standalone switch packages, the PHY is probed using the user MII bus created
   by DSA
 
 
@@ -472,7 +472,7 @@ SWITCHDEV
 
 DSA directly utilizes SWITCHDEV when interfacing with the bridge layer, and
 more specifically with its VLAN filtering portion when configuring VLANs on top
-of per-port slave network devices. As of today, the only SWITCHDEV objects
+of per-port user network devices. As of today, the only SWITCHDEV objects
 supported by DSA are the FDB and VLAN objects.
 
 Devlink
@@ -589,8 +589,8 @@ is torn down when the first switch unregisters.
 It is mandatory for DSA switch drivers to implement the ``shutdown()`` callback
 of their respective bus, and call ``dsa_switch_shutdown()`` from it (a minimal
 version of the full teardown performed by ``dsa_unregister_switch()``).
-The reason is that DSA keeps a reference on the master net device, and if the
-driver for the master device decides to unbind on shutdown, DSA's reference
+The reason is that DSA keeps a reference on the conduit net device, and if the
+driver for the conduit device decides to unbind on shutdown, DSA's reference
 will block that operation from finalizing.
 
 Either ``dsa_switch_shutdown()`` or ``dsa_unregister_switch()`` must be called,
@@ -615,7 +615,7 @@ Switch configuration
   tag formats.
 
 - ``change_tag_protocol``: when the default tagging protocol has compatibility
-  problems with the master or other issues, the driver may support changing it
+  problems with the conduit or other issues, the driver may support changing it
   at runtime, either through a device tree property or through sysfs. In that
   case, further calls to ``get_tag_protocol`` should report the protocol in
   current use.
@@ -643,22 +643,22 @@ Switch configuration
   PHY cannot be found. In this case, probing of the DSA switch continues
   without that particular port.
 
-- ``port_change_master``: method through which the affinity (association used
+- ``port_change_conduit``: method through which the affinity (association used
   for traffic termination purposes) between a user port and a CPU port can be
   changed. By default all user ports from a tree are assigned to the first
   available CPU port that makes sense for them (most of the times this means
   the user ports of a tree are all assigned to the same CPU port, except for H
   topologies as described in commit 2c0b03258b8b). The ``port`` argument
-  represents the index of the user port, and the ``master`` argument represents
-  the new DSA master ``net_device``. The CPU port associated with the new
-  master can be retrieved by looking at ``struct dsa_port *cpu_dp =
-  master->dsa_ptr``. Additionally, the master can also be a LAG device where
-  all the slave devices are physical DSA masters. LAG DSA masters also have a
-  valid ``master->dsa_ptr`` pointer, however this is not unique, but rather a
-  duplicate of the first physical DSA master's (LAG slave) ``dsa_ptr``. In case
-  of a LAG DSA master, a further call to ``port_lag_join`` will be emitted
+  represents the index of the user port, and the ``conduit`` argument represents
+  the new DSA conduit ``net_device``. The CPU port associated with the new
+  conduit can be retrieved by looking at ``struct dsa_port *cpu_dp =
+  conduit->dsa_ptr``. Additionally, the conduit can also be a LAG device where
+  all the slave devices are physical DSA conduits. LAG DSA  also have a
+  valid ``conduit->dsa_ptr`` pointer, however this is not unique, but rather a
+  duplicate of the first physical DSA conduit's (LAG slave) ``dsa_ptr``. In case
+  of a LAG DSA conduit, a further call to ``port_lag_join`` will be emitted
   separately for the physical CPU ports associated with the physical DSA
-  masters, requesting them to create a hardware LAG associated with the LAG
+  conduits, requesting them to create a hardware LAG associated with the LAG
   interface.
 
 PHY devices and link management
@@ -670,16 +670,16 @@ PHY devices and link management
   should return a 32-bit bitmask of "flags" that is private between the switch
   driver and the Ethernet PHY driver in ``drivers/net/phy/\*``.
 
-- ``phy_read``: Function invoked by the DSA slave MDIO bus when attempting to read
+- ``phy_read``: Function invoked by the DSA user MDIO bus when attempting to read
   the switch port MDIO registers. If unavailable, return 0xffff for each read.
   For builtin switch Ethernet PHYs, this function should allow reading the link
   status, auto-negotiation results, link partner pages, etc.
 
-- ``phy_write``: Function invoked by the DSA slave MDIO bus when attempting to write
+- ``phy_write``: Function invoked by the DSA user MDIO bus when attempting to write
   to the switch port MDIO registers. If unavailable return a negative error
   code.
 
-- ``adjust_link``: Function invoked by the PHY library when a slave network device
+- ``adjust_link``: Function invoked by the PHY library when a user network device
   is attached to a PHY device. This function is responsible for appropriately
   configuring the switch port link parameters: speed, duplex, pause based on
   what the ``phy_device`` is providing.
@@ -698,14 +698,14 @@ Ethtool operations
   typically return statistics strings, private flags strings, etc.
 
 - ``get_ethtool_stats``: ethtool function used to query per-port statistics and
-  return their values. DSA overlays slave network devices general statistics:
+  return their values. DSA overlays user network devices general statistics:
   RX/TX counters from the network device, with switch driver specific statistics
   per port
 
 - ``get_sset_count``: ethtool function used to query the number of statistics items
 
 - ``get_wol``: ethtool function used to obtain Wake-on-LAN settings per-port, this
-  function may for certain implementations also query the master network device
+  function may for certain implementations also query the conduit network device
   Wake-on-LAN settings if this interface needs to participate in Wake-on-LAN
 
 - ``set_wol``: ethtool function used to configure Wake-on-LAN settings per-port,
@@ -747,13 +747,13 @@ Power management
   should resume all Ethernet switch activities and re-configure the switch to be
   in a fully active state
 
-- ``port_enable``: function invoked by the DSA slave network device ndo_open
+- ``port_enable``: function invoked by the DSA user network device ndo_open
   function when a port is administratively brought up, this function should
   fully enable a given switch port. DSA takes care of marking the port with
   ``BR_STATE_BLOCKING`` if the port is a bridge member, or ``BR_STATE_FORWARDING`` if it
   was not, and propagating these changes down to the hardware
 
-- ``port_disable``: function invoked by the DSA slave network device ndo_close
+- ``port_disable``: function invoked by the DSA user network device ndo_close
   function when a port is administratively brought down, this function should
   fully disable a given switch port. DSA takes care of marking the port with
   ``BR_STATE_DISABLED`` and propagating changes to the hardware if this port is
diff --git a/Documentation/networking/dsa/lan9303.rst b/Documentation/networking/dsa/lan9303.rst
index e3c820db28ad..ab81b4e0139e 100644
--- a/Documentation/networking/dsa/lan9303.rst
+++ b/Documentation/networking/dsa/lan9303.rst
@@ -4,7 +4,7 @@ LAN9303 Ethernet switch driver
 
 The LAN9303 is a three port 10/100 Mbps ethernet switch with integrated phys for
 the two external ethernet ports. The third port is an RMII/MII interface to a
-host master network interface (e.g. fixed link).
+host conduit network interface (e.g. fixed link).
 
 
 Driver details
diff --git a/Documentation/networking/dsa/sja1105.rst b/Documentation/networking/dsa/sja1105.rst
index e0219c1452ab..8ab60eef07d4 100644
--- a/Documentation/networking/dsa/sja1105.rst
+++ b/Documentation/networking/dsa/sja1105.rst
@@ -79,7 +79,7 @@ The hardware tags all traffic internally with a port-based VLAN (pvid), or it
 decodes the VLAN information from the 802.1Q tag. Advanced VLAN classification
 is not possible. Once attributed a VLAN tag, frames are checked against the
 port's membership rules and dropped at ingress if they don't match any VLAN.
-This behavior is available when switch ports are enslaved to a bridge with
+This behavior is available when switch ports join a bridge with
 ``vlan_filtering 1``.
 
 Normally the hardware is not configurable with respect to VLAN awareness, but
@@ -122,7 +122,7 @@ on egress. Using ``vlan_filtering=1``, the behavior is the other way around:
 offloaded flows can be steered to TX queues based on the VLAN PCP, but the DSA
 net devices are no longer able to do that. To inject frames into a hardware TX
 queue with VLAN awareness active, it is necessary to create a VLAN
-sub-interface on the DSA master port, and send normal (0x8100) VLAN-tagged
+sub-interface on the DSA conduit port, and send normal (0x8100) VLAN-tagged
 towards the switch, with the VLAN PCP bits set appropriately.
 
 Management traffic (having DMAC 01-80-C2-xx-xx-xx or 01-19-1B-xx-xx-xx) is the
@@ -389,7 +389,7 @@ MDIO bus and PHY management
 The SJA1105 does not have an MDIO bus and does not perform in-band AN either.
 Therefore there is no link state notification coming from the switch device.
 A board would need to hook up the PHYs connected to the switch to any other
-MDIO bus available to Linux within the system (e.g. to the DSA master's MDIO
+MDIO bus available to Linux within the system (e.g. to the DSA conduit's MDIO
 bus). Link state management then works by the driver manually keeping in sync
 (over SPI commands) the MAC link speed with the settings negotiated by the PHY.
 
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 5fc613d24151..49cbdb55b4b3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -13,7 +13,7 @@
 / {
 	aliases {
 		ethernet0 = &eth0;
-		/* for dsa slave device */
+		/* for DSA user port device */
 		ethernet1 = &switch0port1;
 		ethernet2 = &switch0port2;
 		ethernet3 = &switch0port3;
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 4e27dc913cf7..0d628b35fd5c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -757,7 +757,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
 
 	/* Create an untagged VLAN entry for the default PVID in case
 	 * CONFIG_VLAN_8021Q is disabled and there are no calls to
-	 * dsa_slave_vlan_rx_add_vid() to create the default VLAN
+	 * dsa_user_vlan_rx_add_vid() to create the default VLAN
 	 * entry. Do this only when the tagging protocol is not
 	 * DSA_TAG_PROTO_NONE
 	 */
@@ -958,7 +958,7 @@ static struct phy_device *b53_get_phy_device(struct dsa_switch *ds, int port)
 		return NULL;
 	}
 
-	return mdiobus_get_phy(ds->slave_mii_bus, port);
+	return mdiobus_get_phy(ds->user_mii_bus, port);
 }
 
 void b53_get_strings(struct dsa_switch *ds, int port, u32 stringset,
diff --git a/drivers/net/dsa/b53/b53_mdio.c b/drivers/net/dsa/b53/b53_mdio.c
index 4d55d8d18376..897e5e8b3d69 100644
--- a/drivers/net/dsa/b53/b53_mdio.c
+++ b/drivers/net/dsa/b53/b53_mdio.c
@@ -329,7 +329,7 @@ static int b53_mdio_probe(struct mdio_device *mdiodev)
 	 * layer setup
 	 */
 	if (of_machine_is_compatible("brcm,bcm7445d0") &&
-	    strcmp(mdiodev->bus->name, "sf2 slave mii"))
+	    strcmp(mdiodev->bus->name, "sf2 user mii"))
 		return -EPROBE_DEFER;
 
 	dev = b53_switch_alloc(&mdiodev->dev, &b53_mdio_ops, mdiodev->bus);
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 0b62bd78ac50..f2ece68bdd67 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -624,19 +624,19 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	get_device(&priv->master_mii_bus->dev);
 	priv->master_mii_dn = dn;
 
-	priv->slave_mii_bus = mdiobus_alloc();
-	if (!priv->slave_mii_bus) {
+	priv->user_mii_bus = mdiobus_alloc();
+	if (!priv->user_mii_bus) {
 		of_node_put(dn);
 		return -ENOMEM;
 	}
 
-	priv->slave_mii_bus->priv = priv;
-	priv->slave_mii_bus->name = "sf2 slave mii";
-	priv->slave_mii_bus->read = bcm_sf2_sw_mdio_read;
-	priv->slave_mii_bus->write = bcm_sf2_sw_mdio_write;
-	snprintf(priv->slave_mii_bus->id, MII_BUS_ID_SIZE, "sf2-%d",
+	priv->user_mii_bus->priv = priv;
+	priv->user_mii_bus->name = "sf2 user mii";
+	priv->user_mii_bus->read = bcm_sf2_sw_mdio_read;
+	priv->user_mii_bus->write = bcm_sf2_sw_mdio_write;
+	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "sf2-%d",
 		 index++);
-	priv->slave_mii_bus->dev.of_node = dn;
+	priv->user_mii_bus->dev.of_node = dn;
 
 	/* Include the pseudo-PHY address to divert reads towards our
 	 * workaround. This is only required for 7445D0, since 7445E0
@@ -654,9 +654,9 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 		priv->indir_phy_mask = 0;
 
 	ds->phys_mii_mask = priv->indir_phy_mask;
-	ds->slave_mii_bus = priv->slave_mii_bus;
-	priv->slave_mii_bus->parent = ds->dev->parent;
-	priv->slave_mii_bus->phy_mask = ~priv->indir_phy_mask;
+	ds->user_mii_bus = priv->user_mii_bus;
+	priv->user_mii_bus->parent = ds->dev->parent;
+	priv->user_mii_bus->phy_mask = ~priv->indir_phy_mask;
 
 	/* We need to make sure that of_phy_connect() will not work by
 	 * removing the 'phandle' and 'linux,phandle' properties and
@@ -683,9 +683,9 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 			phy_device_remove(phydev);
 	}
 
-	err = mdiobus_register(priv->slave_mii_bus);
+	err = mdiobus_register(priv->user_mii_bus);
 	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
+		mdiobus_free(priv->user_mii_bus);
 		of_node_put(dn);
 	}
 
@@ -694,8 +694,8 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 
 static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
 {
-	mdiobus_unregister(priv->slave_mii_bus);
-	mdiobus_free(priv->slave_mii_bus);
+	mdiobus_unregister(priv->user_mii_bus);
+	mdiobus_free(priv->user_mii_bus);
 	of_node_put(priv->master_mii_dn);
 }
 
@@ -909,7 +909,7 @@ static void bcm_sf2_sw_fixed_state(struct dsa_switch *ds, int port,
 		 * state machine and make it go in PHY_FORCING state instead.
 		 */
 		if (!status->link)
-			netif_carrier_off(dsa_to_port(ds, port)->slave);
+			netif_carrier_off(dsa_to_port(ds, port)->user);
 		status->duplex = DUPLEX_FULL;
 	} else {
 		status->link = true;
@@ -983,7 +983,7 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
 			       struct ethtool_wolinfo *wol)
 {
-	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
+	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	struct ethtool_wolinfo pwol = { };
 
@@ -1007,7 +1007,7 @@ static void bcm_sf2_sw_get_wol(struct dsa_switch *ds, int port,
 static int bcm_sf2_sw_set_wol(struct dsa_switch *ds, int port,
 			      struct ethtool_wolinfo *wol)
 {
-	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
+	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 	struct ethtool_wolinfo pwol =  { };
diff --git a/drivers/net/dsa/bcm_sf2.h b/drivers/net/dsa/bcm_sf2.h
index 00afc94ce522..424f896b5a6f 100644
--- a/drivers/net/dsa/bcm_sf2.h
+++ b/drivers/net/dsa/bcm_sf2.h
@@ -108,7 +108,7 @@ struct bcm_sf2_priv {
 	/* Master and slave MDIO bus controller */
 	unsigned int			indir_phy_mask;
 	struct device_node		*master_mii_dn;
-	struct mii_bus			*slave_mii_bus;
+	struct mii_bus			*user_mii_bus;
 	struct mii_bus			*master_mii_bus;
 
 	/* Bitmask of ports needing BRCM tags */
diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index c4010b7bf089..c88ee3dd4299 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -1102,7 +1102,7 @@ static int bcm_sf2_cfp_rule_get_all(struct bcm_sf2_priv *priv,
 int bcm_sf2_get_rxnfc(struct dsa_switch *ds, int port,
 		      struct ethtool_rxnfc *nfc, u32 *rule_locs)
 {
-	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
+	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	int ret = 0;
 
@@ -1145,7 +1145,7 @@ int bcm_sf2_get_rxnfc(struct dsa_switch *ds, int port,
 int bcm_sf2_set_rxnfc(struct dsa_switch *ds, int port,
 		      struct ethtool_rxnfc *nfc)
 {
-	struct net_device *p = dsa_port_to_master(dsa_to_port(ds, port));
+	struct net_device *p = dsa_port_to_conduit(dsa_to_port(ds, port));
 	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
 	int ret = 0;
 
diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index ee67adeb2cdb..fcb20eac332a 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1084,7 +1084,7 @@ static int lan9303_port_enable(struct dsa_switch *ds, int port,
 	if (!dsa_port_is_user(dp))
 		return 0;
 
-	vlan_vid_add(dsa_port_to_master(dp), htons(ETH_P_8021Q), port);
+	vlan_vid_add(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
 
 	return lan9303_enable_processing_port(chip, port);
 }
@@ -1097,7 +1097,7 @@ static void lan9303_port_disable(struct dsa_switch *ds, int port)
 	if (!dsa_port_is_user(dp))
 		return;
 
-	vlan_vid_del(dsa_port_to_master(dp), htons(ETH_P_8021Q), port);
+	vlan_vid_del(dsa_port_to_conduit(dp), htons(ETH_P_8021Q), port);
 
 	lan9303_disable_processing_port(chip, port);
 	lan9303_phy_write(ds, chip->phy_addr_base + port, MII_BMCR, BMCR_PDOWN);
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 1a2d5797bf98..9c185c9f0963 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -510,22 +510,22 @@ static int gswip_mdio(struct gswip_priv *priv, struct device_node *mdio_np)
 	struct dsa_switch *ds = priv->ds;
 	int err;
 
-	ds->slave_mii_bus = mdiobus_alloc();
-	if (!ds->slave_mii_bus)
+	ds->user_mii_bus = mdiobus_alloc();
+	if (!ds->user_mii_bus)
 		return -ENOMEM;
 
-	ds->slave_mii_bus->priv = priv;
-	ds->slave_mii_bus->read = gswip_mdio_rd;
-	ds->slave_mii_bus->write = gswip_mdio_wr;
-	ds->slave_mii_bus->name = "lantiq,xrx200-mdio";
-	snprintf(ds->slave_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
+	ds->user_mii_bus->priv = priv;
+	ds->user_mii_bus->read = gswip_mdio_rd;
+	ds->user_mii_bus->write = gswip_mdio_wr;
+	ds->user_mii_bus->name = "lantiq,xrx200-mdio";
+	snprintf(ds->user_mii_bus->id, MII_BUS_ID_SIZE, "%s-mii",
 		 dev_name(priv->dev));
-	ds->slave_mii_bus->parent = priv->dev;
-	ds->slave_mii_bus->phy_mask = ~ds->phys_mii_mask;
+	ds->user_mii_bus->parent = priv->dev;
+	ds->user_mii_bus->phy_mask = ~ds->phys_mii_mask;
 
-	err = of_mdiobus_register(ds->slave_mii_bus, mdio_np);
+	err = of_mdiobus_register(ds->user_mii_bus, mdio_np);
 	if (err)
-		mdiobus_free(ds->slave_mii_bus);
+		mdiobus_free(ds->user_mii_bus);
 
 	return err;
 }
@@ -2196,8 +2196,8 @@ static int gswip_probe(struct platform_device *pdev)
 	dsa_unregister_switch(priv->ds);
 mdio_bus:
 	if (mdio_np) {
-		mdiobus_unregister(priv->ds->slave_mii_bus);
-		mdiobus_free(priv->ds->slave_mii_bus);
+		mdiobus_unregister(priv->ds->user_mii_bus);
+		mdiobus_free(priv->ds->user_mii_bus);
 	}
 put_mdio_node:
 	of_node_put(mdio_np);
@@ -2219,10 +2219,10 @@ static void gswip_remove(struct platform_device *pdev)
 
 	dsa_unregister_switch(priv->ds);
 
-	if (priv->ds->slave_mii_bus) {
-		mdiobus_unregister(priv->ds->slave_mii_bus);
-		of_node_put(priv->ds->slave_mii_bus->dev.of_node);
-		mdiobus_free(priv->ds->slave_mii_bus);
+	if (priv->ds->user_mii_bus) {
+		mdiobus_unregister(priv->ds->user_mii_bus);
+		of_node_put(priv->ds->user_mii_bus->dev.of_node);
+		mdiobus_free(priv->ds->user_mii_bus);
 	}
 
 	for (i = 0; i < priv->num_gphy_fw; i++)
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index cde8ef33d029..a8b0e528b804 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1170,7 +1170,7 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 {
 	struct ksz_device *dev = ds->priv;
-	struct net_device *slave;
+	struct net_device *user;
 	struct dsa_port *hsr_dp;
 	u8 data, hsr_ports = 0;
 
@@ -1202,8 +1202,8 @@ void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
 	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
 
 	/* Setup HW supported features for lan HSR ports */
-	slave = dsa_to_port(ds, port)->slave;
-	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+	user = dsa_to_port(ds, port)->user;
+	user->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
 }
 
 void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b800ace40ce1..a8025ff988ec 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1945,14 +1945,14 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 				ret = irq;
 				goto out;
 			}
-			ds->slave_mii_bus->irq[phy] = irq;
+			ds->user_mii_bus->irq[phy] = irq;
 		}
 	}
 	return 0;
 out:
 	while (phy--)
 		if (BIT(phy) & ds->phys_mii_mask)
-			irq_dispose_mapping(ds->slave_mii_bus->irq[phy]);
+			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
 
 	return ret;
 }
@@ -1964,7 +1964,7 @@ static void ksz_irq_phy_free(struct ksz_device *dev)
 
 	for (phy = 0; phy < KSZ_MAX_NUM_PORTS; phy++)
 		if (BIT(phy) & ds->phys_mii_mask)
-			irq_dispose_mapping(ds->slave_mii_bus->irq[phy]);
+			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
 }
 
 static int ksz_mdio_register(struct ksz_device *dev)
@@ -1987,12 +1987,12 @@ static int ksz_mdio_register(struct ksz_device *dev)
 	bus->priv = dev;
 	bus->read = ksz_sw_mdio_read;
 	bus->write = ksz_sw_mdio_write;
-	bus->name = "ksz slave smi";
+	bus->name = "ksz user smi";
 	snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
 	bus->parent = ds->dev;
 	bus->phy_mask = ~ds->phys_mii_mask;
 
-	ds->slave_mii_bus = bus;
+	ds->user_mii_bus = bus;
 
 	if (dev->irq > 0) {
 		ret = ksz_irq_phy_setup(dev);
@@ -2344,7 +2344,7 @@ static void ksz_mib_read_work(struct work_struct *work)
 		if (!p->read) {
 			const struct dsa_port *dp = dsa_to_port(dev->ds, i);
 
-			if (!netif_carrier_ok(dp->slave))
+			if (!netif_carrier_ok(dp->user))
 				mib->cnt_ptr = dev->info->reg_mib_cnt;
 		}
 		port_r_cnt(dev, i);
@@ -2464,7 +2464,7 @@ static void ksz_get_ethtool_stats(struct dsa_switch *ds, int port,
 	mutex_lock(&mib->cnt_mutex);
 
 	/* Only read dropped counters if no link. */
-	if (!netif_carrier_ok(dp->slave))
+	if (!netif_carrier_ok(dp->user))
 		mib->cnt_ptr = dev->info->reg_mib_cnt;
 	port_r_cnt(dev, port);
 	memcpy(buf, mib->counters, dev->info->mib_cnt * sizeof(u64));
@@ -2574,7 +2574,7 @@ static int ksz_port_setup(struct dsa_switch *ds, int port)
 	if (!dsa_is_user_port(ds, port))
 		return 0;
 
-	/* setup slave port */
+	/* setup user port */
 	dev->dev_ops->port_setup(dev, port, false);
 
 	/* port_stp_state_set() will be called after to enable the port so
@@ -3567,8 +3567,8 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 				  struct netlink_ext_ack *extack)
 {
-	struct net_device *slave = dsa_to_port(ds, port)->slave;
-	const unsigned char *addr = slave->dev_addr;
+	struct net_device *user = dsa_to_port(ds, port)->user;
+	const unsigned char *addr = user->dev_addr;
 	struct ksz_switch_macaddr *switch_macaddr;
 	struct ksz_device *dev = ds->priv;
 	const u16 *regs = dev->info->regs;
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 4e22a695a64c..1fe105913c75 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -557,7 +557,7 @@ static void ksz_ptp_txtstamp_skb(struct ksz_device *dev,
 	struct skb_shared_hwtstamps hwtstamps = {};
 	int ret;
 
-	/* timeout must include DSA master to transmit data, tstamp latency,
+	/* timeout must include DSA conduit to transmit data, tstamp latency,
 	 * IRQ latency and time for reading the time stamp.
 	 */
 	ret = wait_for_completion_timeout(&prt->tstamp_msg_comp,
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ecf5d3deb36e..d117e9b1a465 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2069,7 +2069,7 @@ mt7530_setup_mdio_irq(struct mt7530_priv *priv)
 			unsigned int irq;
 
 			irq = irq_create_mapping(priv->irq_domain, p);
-			ds->slave_mii_bus->irq[p] = irq;
+			ds->user_mii_bus->irq[p] = irq;
 		}
 	}
 }
@@ -2163,7 +2163,7 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	if (!bus)
 		return -ENOMEM;
 
-	ds->slave_mii_bus = bus;
+	ds->user_mii_bus = bus;
 	bus->priv = priv;
 	bus->name = KBUILD_MODNAME "-mii";
 	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d", idx++);
@@ -2200,20 +2200,20 @@ mt7530_setup(struct dsa_switch *ds)
 	u32 id, val;
 	int ret, i;
 
-	/* The parent node of master netdev which holds the common system
+	/* The parent node of conduit netdev which holds the common system
 	 * controller also is the container for two GMACs nodes representing
 	 * as two netdev instances.
 	 */
 	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		dn = cpu_dp->master->dev.of_node->parent;
+		dn = cpu_dp->conduit->dev.of_node->parent;
 		/* It doesn't matter which CPU port is found first,
-		 * their masters should share the same parent OF node
+		 * their conduits should share the same parent OF node
 		 */
 		break;
 	}
 
 	if (!dn) {
-		dev_err(ds->dev, "parent OF node of DSA master not found");
+		dev_err(ds->dev, "parent OF node of DSA conduit not found");
 		return -EINVAL;
 	}
 
@@ -2488,7 +2488,7 @@ mt7531_setup(struct dsa_switch *ds)
 	if (mt7531_dual_sgmii_supported(priv)) {
 		priv->p5_intf_sel = P5_INTF_SEL_GMAC5_SGMII;
 
-		/* Let ds->slave_mii_bus be able to access external phy. */
+		/* Let ds->user_mii_bus be able to access external phy. */
 		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO11_RG_RXD2_MASK,
 			   MT7531_EXT_P_MDC_11);
 		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO12_RG_RXD3_MASK,
@@ -2717,7 +2717,7 @@ mt7531_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		dp = dsa_to_port(ds, port);
-		phydev = dp->slave->phydev;
+		phydev = dp->user->phydev;
 		return mt7531_rgmii_setup(priv, port, interface, phydev);
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_NA:
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ab434a77b059..be2491de173d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3719,7 +3719,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 		return err;
 
 	chip->ds = ds;
-	ds->slave_mii_bus = mv88e6xxx_default_mdio_bus(chip);
+	ds->user_mii_bus = mv88e6xxx_default_mdio_bus(chip);
 
 	/* Since virtual bridges are mapped in the PVT, the number we support
 	 * depends on the physical switch topology. We need to let DSA figure
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 9a3e5ec16972..61e95487732d 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -42,22 +42,22 @@ static struct net_device *felix_classify_db(struct dsa_db db)
 	}
 }
 
-static int felix_cpu_port_for_master(struct dsa_switch *ds,
-				     struct net_device *master)
+static int felix_cpu_port_for_conduit(struct dsa_switch *ds,
+				      struct net_device *conduit)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct dsa_port *cpu_dp;
 	int lag;
 
-	if (netif_is_lag_master(master)) {
+	if (netif_is_lag_master(conduit)) {
 		mutex_lock(&ocelot->fwd_domain_lock);
-		lag = ocelot_bond_get_id(ocelot, master);
+		lag = ocelot_bond_get_id(ocelot, conduit);
 		mutex_unlock(&ocelot->fwd_domain_lock);
 
 		return lag;
 	}
 
-	cpu_dp = master->dsa_ptr;
+	cpu_dp = conduit->dsa_ptr;
 	return cpu_dp->index;
 }
 
@@ -366,7 +366,7 @@ static int felix_update_trapping_destinations(struct dsa_switch *ds,
  * is the mode through which frames can be injected from and extracted to an
  * external CPU, over Ethernet. In NXP SoCs, the "external CPU" is the ARM CPU
  * running Linux, and this forms a DSA setup together with the enetc or fman
- * DSA master.
+ * DSA conduit.
  */
 static void felix_npi_port_init(struct ocelot *ocelot, int port)
 {
@@ -441,16 +441,16 @@ static unsigned long felix_tag_npi_get_host_fwd_mask(struct dsa_switch *ds)
 	return BIT(ocelot->num_phys_ports);
 }
 
-static int felix_tag_npi_change_master(struct dsa_switch *ds, int port,
-				       struct net_device *master,
-				       struct netlink_ext_ack *extack)
+static int felix_tag_npi_change_conduit(struct dsa_switch *ds, int port,
+					struct net_device *conduit,
+					struct netlink_ext_ack *extack)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port), *other_dp;
 	struct ocelot *ocelot = ds->priv;
 
-	if (netif_is_lag_master(master)) {
+	if (netif_is_lag_master(conduit)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "LAG DSA master only supported using ocelot-8021q");
+				   "LAG DSA conduit only supported using ocelot-8021q");
 		return -EOPNOTSUPP;
 	}
 
@@ -459,24 +459,24 @@ static int felix_tag_npi_change_master(struct dsa_switch *ds, int port,
 	 * come back up until they're all changed to the new one.
 	 */
 	dsa_switch_for_each_user_port(other_dp, ds) {
-		struct net_device *slave = other_dp->slave;
+		struct net_device *user = other_dp->user;
 
-		if (other_dp != dp && (slave->flags & IFF_UP) &&
-		    dsa_port_to_master(other_dp) != master) {
+		if (other_dp != dp && (user->flags & IFF_UP) &&
+		    dsa_port_to_conduit(other_dp) != conduit) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Cannot change while old master still has users");
+					   "Cannot change while old conduit still has users");
 			return -EOPNOTSUPP;
 		}
 	}
 
 	felix_npi_port_deinit(ocelot, ocelot->npi);
-	felix_npi_port_init(ocelot, felix_cpu_port_for_master(ds, master));
+	felix_npi_port_init(ocelot, felix_cpu_port_for_conduit(ds, conduit));
 
 	return 0;
 }
 
 /* Alternatively to using the NPI functionality, that same hardware MAC
- * connected internally to the enetc or fman DSA master can be configured to
+ * connected internally to the enetc or fman DSA conduit can be configured to
  * use the software-defined tag_8021q frame format. As far as the hardware is
  * concerned, it thinks it is a "dumb switch" - the queues of the CPU port
  * module are now disconnected from it, but can still be accessed through
@@ -486,7 +486,7 @@ static const struct felix_tag_proto_ops felix_tag_npi_proto_ops = {
 	.setup			= felix_tag_npi_setup,
 	.teardown		= felix_tag_npi_teardown,
 	.get_host_fwd_mask	= felix_tag_npi_get_host_fwd_mask,
-	.change_master		= felix_tag_npi_change_master,
+	.change_conduit		= felix_tag_npi_change_conduit,
 };
 
 static int felix_tag_8021q_setup(struct dsa_switch *ds)
@@ -561,11 +561,11 @@ static unsigned long felix_tag_8021q_get_host_fwd_mask(struct dsa_switch *ds)
 	return dsa_cpu_ports(ds);
 }
 
-static int felix_tag_8021q_change_master(struct dsa_switch *ds, int port,
-					 struct net_device *master,
-					 struct netlink_ext_ack *extack)
+static int felix_tag_8021q_change_conduit(struct dsa_switch *ds, int port,
+					  struct net_device *conduit,
+					  struct netlink_ext_ack *extack)
 {
-	int cpu = felix_cpu_port_for_master(ds, master);
+	int cpu = felix_cpu_port_for_conduit(ds, conduit);
 	struct ocelot *ocelot = ds->priv;
 
 	ocelot_port_unassign_dsa_8021q_cpu(ocelot, port);
@@ -578,7 +578,7 @@ static const struct felix_tag_proto_ops felix_tag_8021q_proto_ops = {
 	.setup			= felix_tag_8021q_setup,
 	.teardown		= felix_tag_8021q_teardown,
 	.get_host_fwd_mask	= felix_tag_8021q_get_host_fwd_mask,
-	.change_master		= felix_tag_8021q_change_master,
+	.change_conduit		= felix_tag_8021q_change_conduit,
 };
 
 static void felix_set_host_flood(struct dsa_switch *ds, unsigned long mask,
@@ -741,14 +741,14 @@ static void felix_port_set_host_flood(struct dsa_switch *ds, int port,
 			     !!felix->host_flood_mc_mask, true);
 }
 
-static int felix_port_change_master(struct dsa_switch *ds, int port,
-				    struct net_device *master,
-				    struct netlink_ext_ack *extack)
+static int felix_port_change_conduit(struct dsa_switch *ds, int port,
+				     struct net_device *conduit,
+				     struct netlink_ext_ack *extack)
 {
 	struct ocelot *ocelot = ds->priv;
 	struct felix *felix = ocelot_to_felix(ocelot);
 
-	return felix->tag_proto_ops->change_master(ds, port, master, extack);
+	return felix->tag_proto_ops->change_conduit(ds, port, conduit, extack);
 }
 
 static int felix_set_ageing_time(struct dsa_switch *ds,
@@ -953,7 +953,7 @@ static int felix_lag_join(struct dsa_switch *ds, int port,
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	return felix_port_change_master(ds, port, lag.dev, extack);
+	return felix_port_change_conduit(ds, port, lag.dev, extack);
 }
 
 static int felix_lag_leave(struct dsa_switch *ds, int port,
@@ -967,7 +967,7 @@ static int felix_lag_leave(struct dsa_switch *ds, int port,
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	return felix_port_change_master(ds, port, lag.dev, NULL);
+	return felix_port_change_conduit(ds, port, lag.dev, NULL);
 }
 
 static int felix_lag_change(struct dsa_switch *ds, int port)
@@ -1116,10 +1116,10 @@ static int felix_port_enable(struct dsa_switch *ds, int port,
 		return 0;
 
 	if (ocelot->npi >= 0) {
-		struct net_device *master = dsa_port_to_master(dp);
+		struct net_device *conduit = dsa_port_to_conduit(dp);
 
-		if (felix_cpu_port_for_master(ds, master) != ocelot->npi) {
-			dev_err(ds->dev, "Multiple masters are not allowed\n");
+		if (felix_cpu_port_for_conduit(ds, conduit) != ocelot->npi) {
+			dev_err(ds->dev, "Multiple conduits are not allowed\n");
 			return -EINVAL;
 		}
 	}
@@ -2164,7 +2164,7 @@ const struct dsa_switch_ops felix_switch_ops = {
 	.port_add_dscp_prio		= felix_port_add_dscp_prio,
 	.port_del_dscp_prio		= felix_port_del_dscp_prio,
 	.port_set_host_flood		= felix_port_set_host_flood,
-	.port_change_master		= felix_port_change_master,
+	.port_change_conduit		= felix_port_change_conduit,
 };
 EXPORT_SYMBOL_GPL(felix_switch_ops);
 
@@ -2176,7 +2176,7 @@ struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port)
 	if (!dsa_is_user_port(ds, port))
 		return NULL;
 
-	return dsa_to_port(ds, port)->slave;
+	return dsa_to_port(ds, port)->user;
 }
 EXPORT_SYMBOL_GPL(felix_port_to_netdev);
 
diff --git a/drivers/net/dsa/ocelot/felix.h b/drivers/net/dsa/ocelot/felix.h
index 1d4befe7cfe8..dbf5872fe367 100644
--- a/drivers/net/dsa/ocelot/felix.h
+++ b/drivers/net/dsa/ocelot/felix.h
@@ -77,9 +77,9 @@ struct felix_tag_proto_ops {
 	int (*setup)(struct dsa_switch *ds);
 	void (*teardown)(struct dsa_switch *ds);
 	unsigned long (*get_host_fwd_mask)(struct dsa_switch *ds);
-	int (*change_master)(struct dsa_switch *ds, int port,
-			     struct net_device *master,
-			     struct netlink_ext_ack *extack);
+	int (*change_conduit)(struct dsa_switch *ds, int port,
+			      struct net_device *conduit,
+			      struct netlink_ext_ack *extack);
 };
 
 extern const struct dsa_switch_ops felix_switch_ops;
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 4ce68e655a63..ec57d9d52072 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -323,14 +323,14 @@ static int qca8k_read_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	mutex_lock(&mgmt_eth_data->mutex);
 
-	/* Check mgmt_master if is operational */
-	if (!priv->mgmt_master) {
+	/* Check if the mgmt_conduit if is operational */
+	if (!priv->mgmt_conduit) {
 		kfree_skb(skb);
 		mutex_unlock(&mgmt_eth_data->mutex);
 		return -EINVAL;
 	}
 
-	skb->dev = priv->mgmt_master;
+	skb->dev = priv->mgmt_conduit;
 
 	reinit_completion(&mgmt_eth_data->rw_done);
 
@@ -375,14 +375,14 @@ static int qca8k_write_eth(struct qca8k_priv *priv, u32 reg, u32 *val, int len)
 
 	mutex_lock(&mgmt_eth_data->mutex);
 
-	/* Check mgmt_master if is operational */
-	if (!priv->mgmt_master) {
+	/* Check if the mgmt_conduit if is operational */
+	if (!priv->mgmt_conduit) {
 		kfree_skb(skb);
 		mutex_unlock(&mgmt_eth_data->mutex);
 		return -EINVAL;
 	}
 
-	skb->dev = priv->mgmt_master;
+	skb->dev = priv->mgmt_conduit;
 
 	reinit_completion(&mgmt_eth_data->rw_done);
 
@@ -508,7 +508,7 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
 	struct qca8k_priv *priv = ctx;
 	u32 reg = *(u16 *)reg_buf;
 
-	if (priv->mgmt_master &&
+	if (priv->mgmt_conduit &&
 	    !qca8k_read_eth(priv, reg, val_buf, val_len))
 		return 0;
 
@@ -531,7 +531,7 @@ qca8k_bulk_gather_write(void *ctx, const void *reg_buf, size_t reg_len,
 	u32 reg = *(u16 *)reg_buf;
 	u32 *val = (u32 *)val_buf;
 
-	if (priv->mgmt_master &&
+	if (priv->mgmt_conduit &&
 	    !qca8k_write_eth(priv, reg, val, val_len))
 		return 0;
 
@@ -626,7 +626,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	struct sk_buff *write_skb, *clear_skb, *read_skb;
 	struct qca8k_mgmt_eth_data *mgmt_eth_data;
 	u32 write_val, clear_val = 0, val;
-	struct net_device *mgmt_master;
+	struct net_device *mgmt_conduit;
 	int ret, ret1;
 	bool ack;
 
@@ -683,18 +683,18 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	 */
 	mutex_lock(&mgmt_eth_data->mutex);
 
-	/* Check if mgmt_master is operational */
-	mgmt_master = priv->mgmt_master;
-	if (!mgmt_master) {
+	/* Check if mgmt_conduit is operational */
+	mgmt_conduit = priv->mgmt_conduit;
+	if (!mgmt_conduit) {
 		mutex_unlock(&mgmt_eth_data->mutex);
 		mutex_unlock(&priv->bus->mdio_lock);
 		ret = -EINVAL;
-		goto err_mgmt_master;
+		goto err_mgmt_conduit;
 	}
 
-	read_skb->dev = mgmt_master;
-	clear_skb->dev = mgmt_master;
-	write_skb->dev = mgmt_master;
+	read_skb->dev = mgmt_conduit;
+	clear_skb->dev = mgmt_conduit;
+	write_skb->dev = mgmt_conduit;
 
 	reinit_completion(&mgmt_eth_data->rw_done);
 
@@ -780,7 +780,7 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
 	return ret;
 
 	/* Error handling before lock */
-err_mgmt_master:
+err_mgmt_conduit:
 	kfree_skb(read_skb);
 err_read_skb:
 	kfree_skb(clear_skb);
@@ -959,12 +959,12 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 		 ds->dst->index, ds->index);
 	bus->parent = ds->dev;
 	bus->phy_mask = ~ds->phys_mii_mask;
-	ds->slave_mii_bus = bus;
+	ds->user_mii_bus = bus;
 
 	/* Check if the devicetree declare the port:phy mapping */
 	mdio = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (of_device_is_available(mdio)) {
-		bus->name = "qca8k slave mii";
+		bus->name = "qca8k user mii";
 		bus->read = qca8k_internal_mdio_read;
 		bus->write = qca8k_internal_mdio_write;
 		return devm_of_mdiobus_register(priv->dev, bus, mdio);
@@ -973,7 +973,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 	/* If a mapping can't be found the legacy mapping is used,
 	 * using the qca8k_port_to_phy function
 	 */
-	bus->name = "qca8k-legacy slave mii";
+	bus->name = "qca8k-legacy user mii";
 	bus->read = qca8k_legacy_mdio_read;
 	bus->write = qca8k_legacy_mdio_write;
 	return devm_mdiobus_register(priv->dev, bus);
@@ -1728,10 +1728,10 @@ qca8k_get_tag_protocol(struct dsa_switch *ds, int port,
 }
 
 static void
-qca8k_master_change(struct dsa_switch *ds, const struct net_device *master,
-		    bool operational)
+qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
+		     bool operational)
 {
-	struct dsa_port *dp = master->dsa_ptr;
+	struct dsa_port *dp = conduit->dsa_ptr;
 	struct qca8k_priv *priv = ds->priv;
 
 	/* Ethernet MIB/MDIO is only supported for CPU port 0 */
@@ -1741,7 +1741,7 @@ qca8k_master_change(struct dsa_switch *ds, const struct net_device *master,
 	mutex_lock(&priv->mgmt_eth_data.mutex);
 	mutex_lock(&priv->mib_eth_data.mutex);
 
-	priv->mgmt_master = operational ? (struct net_device *)master : NULL;
+	priv->mgmt_conduit = operational ? (struct net_device *)conduit : NULL;
 
 	mutex_unlock(&priv->mib_eth_data.mutex);
 	mutex_unlock(&priv->mgmt_eth_data.mutex);
@@ -2016,7 +2016,7 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_phy_flags		= qca8k_get_phy_flags,
 	.port_lag_join		= qca8k_port_lag_join,
 	.port_lag_leave		= qca8k_port_lag_leave,
-	.master_state_change	= qca8k_master_change,
+	.conduit_state_change	= qca8k_conduit_change,
 	.connect_tag_protocol	= qca8k_connect_tag_protocol,
 };
 
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 9ff0a3c1cb91..d203e4a84441 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -499,7 +499,7 @@ void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
 	u32 hi = 0;
 	int ret;
 
-	if (priv->mgmt_master && priv->info->ops->autocast_mib &&
+	if (priv->mgmt_conduit && priv->info->ops->autocast_mib &&
 	    priv->info->ops->autocast_mib(ds, port, data) > 0)
 		return;
 
diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index e8c16e76e34b..90e30c2909e4 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -356,8 +356,8 @@ static struct device *qca8k_cled_hw_control_get_device(struct led_classdev *ldev
 	dp = dsa_to_port(priv->ds, qca8k_phy_to_port(led->port_num));
 	if (!dp)
 		return NULL;
-	if (dp->slave)
-		return &dp->slave->dev;
+	if (dp->user)
+		return &dp->user->dev;
 	return NULL;
 }
 
@@ -429,7 +429,7 @@ qca8k_parse_port_leds(struct qca8k_priv *priv, struct fwnode_handle *port, int p
 		init_data.default_label = ":port";
 		init_data.fwnode = led;
 		init_data.devname_mandatory = true;
-		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d", ds->slave_mii_bus->id,
+		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d", ds->user_mii_bus->id,
 						 port_num);
 		if (!init_data.devicename)
 			return -ENOMEM;
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index 8f88b7db384d..2ac7e88f8da5 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -458,7 +458,7 @@ struct qca8k_priv {
 	struct mutex reg_mutex;
 	struct device *dev;
 	struct gpio_desc *reset_gpio;
-	struct net_device *mgmt_master; /* Track if mdio/mib Ethernet is available */
+	struct net_device *mgmt_conduit; /* Track if mdio/mib Ethernet is available */
 	struct qca8k_mgmt_eth_data mgmt_eth_data;
 	struct qca8k_mib_eth_data mib_eth_data;
 	struct qca8k_mdio_cache mdio_cache;
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index bfd11591faf4..755546ed8db6 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -378,25 +378,25 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 		return -ENODEV;
 	}
 
-	priv->slave_mii_bus = devm_mdiobus_alloc(priv->dev);
-	if (!priv->slave_mii_bus) {
+	priv->user_mii_bus = devm_mdiobus_alloc(priv->dev);
+	if (!priv->user_mii_bus) {
 		ret = -ENOMEM;
 		goto err_put_node;
 	}
-	priv->slave_mii_bus->priv = priv;
-	priv->slave_mii_bus->name = "SMI slave MII";
-	priv->slave_mii_bus->read = realtek_smi_mdio_read;
-	priv->slave_mii_bus->write = realtek_smi_mdio_write;
-	snprintf(priv->slave_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
+	priv->user_mii_bus->priv = priv;
+	priv->user_mii_bus->name = "SMI user MII";
+	priv->user_mii_bus->read = realtek_smi_mdio_read;
+	priv->user_mii_bus->write = realtek_smi_mdio_write;
+	snprintf(priv->user_mii_bus->id, MII_BUS_ID_SIZE, "SMI-%d",
 		 ds->index);
-	priv->slave_mii_bus->dev.of_node = mdio_np;
-	priv->slave_mii_bus->parent = priv->dev;
-	ds->slave_mii_bus = priv->slave_mii_bus;
+	priv->user_mii_bus->dev.of_node = mdio_np;
+	priv->user_mii_bus->parent = priv->dev;
+	ds->user_mii_bus = priv->user_mii_bus;
 
-	ret = devm_of_mdiobus_register(priv->dev, priv->slave_mii_bus, mdio_np);
+	ret = devm_of_mdiobus_register(priv->dev, priv->user_mii_bus, mdio_np);
 	if (ret) {
 		dev_err(priv->dev, "unable to register MDIO bus %s\n",
-			priv->slave_mii_bus->id);
+			priv->user_mii_bus->id);
 		goto err_put_node;
 	}
 
@@ -514,8 +514,8 @@ static void realtek_smi_remove(struct platform_device *pdev)
 		return;
 
 	dsa_unregister_switch(priv->ds);
-	if (priv->slave_mii_bus)
-		of_node_put(priv->slave_mii_bus->dev.of_node);
+	if (priv->user_mii_bus)
+		of_node_put(priv->user_mii_bus->dev.of_node);
 
 	/* leave the device reset asserted */
 	if (priv->reset)
diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 4fa7c6ba874a..790488e9c667 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -54,7 +54,7 @@ struct realtek_priv {
 	struct regmap		*map;
 	struct regmap		*map_nolock;
 	struct mutex		map_lock;
-	struct mii_bus		*slave_mii_bus;
+	struct mii_bus		*user_mii_bus;
 	struct mii_bus		*bus;
 	int			mdio_addr;
 
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 1a367e64bc3b..74cee39d73df 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2688,7 +2688,7 @@ static int sja1105_mgmt_xmit(struct dsa_switch *ds, int port, int slot,
 	}
 
 	/* Transfer skb to the host port. */
-	dsa_enqueue_skb(skb, dsa_to_port(ds, port)->slave);
+	dsa_enqueue_skb(skb, dsa_to_port(ds, port)->user);
 
 	/* Wait until the switch has processed the frame */
 	do {
@@ -3081,7 +3081,7 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
  * ref_clk pin. So port clocking needs to be initialized early, before
  * connecting to PHYs is attempted, otherwise they won't respond through MDIO.
  * Setting correct PHY link speed does not matter now.
- * But dsa_slave_phy_setup is called later than sja1105_setup, so the PHY
+ * But dsa_user_phy_setup is called later than sja1105_setup, so the PHY
  * bindings are not yet parsed by DSA core. We need to parse early so that we
  * can populate the xMII mode parameters table.
  */
diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 5b02e9e426fd..96db032b478f 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -554,7 +554,7 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 	unsigned int val = XRS_HSR_CFG_HSR_PRP;
 	struct dsa_port *partner = NULL, *dp;
 	struct xrs700x *priv = ds->priv;
-	struct net_device *slave;
+	struct net_device *user;
 	int ret, i, hsr_pair[2];
 	enum hsr_version ver;
 	bool fwd = false;
@@ -638,8 +638,8 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 	hsr_pair[0] = port;
 	hsr_pair[1] = partner->index;
 	for (i = 0; i < ARRAY_SIZE(hsr_pair); i++) {
-		slave = dsa_to_port(ds, hsr_pair[i])->slave;
-		slave->features |= XRS7000X_SUPPORTED_HSR_FEATURES;
+		user = dsa_to_port(ds, hsr_pair[i])->user;
+		user->features |= XRS7000X_SUPPORTED_HSR_FEATURES;
 	}
 
 	return 0;
@@ -650,7 +650,7 @@ static int xrs700x_hsr_leave(struct dsa_switch *ds, int port,
 {
 	struct dsa_port *partner = NULL, *dp;
 	struct xrs700x *priv = ds->priv;
-	struct net_device *slave;
+	struct net_device *user;
 	int i, hsr_pair[2];
 	unsigned int val;
 
@@ -692,8 +692,8 @@ static int xrs700x_hsr_leave(struct dsa_switch *ds, int port,
 	hsr_pair[0] = port;
 	hsr_pair[1] = partner->index;
 	for (i = 0; i < ARRAY_SIZE(hsr_pair); i++) {
-		slave = dsa_to_port(ds, hsr_pair[i])->slave;
-		slave->features &= ~XRS7000X_SUPPORTED_HSR_FEATURES;
+		user = dsa_to_port(ds, hsr_pair[i])->user;
+		user->features &= ~XRS7000X_SUPPORTED_HSR_FEATURES;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index ab096795e805..c9faa8540859 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2430,7 +2430,7 @@ static int bcm_sysport_netdevice_event(struct notifier_block *nb,
 		if (dev->netdev_ops != &bcm_sysport_netdev_ops)
 			return NOTIFY_DONE;
 
-		if (!dsa_slave_dev_check(info->upper_dev))
+		if (!dsa_user_dev_check(info->upper_dev))
 			return NOTIFY_DONE;
 
 		if (info->linking)
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 60d49b0f595f..3cf6589cfdac 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3329,7 +3329,7 @@ static int mtk_device_event(struct notifier_block *n, unsigned long event, void
 	return NOTIFY_DONE;
 
 found:
-	if (!dsa_slave_dev_check(dev))
+	if (!dsa_user_dev_check(dev))
 		return NOTIFY_DONE;
 
 	if (__ethtool_get_link_ksettings(dev, &s))
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index e073d2b5542c..fbb5e9d5af13 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -175,7 +175,7 @@ mtk_flow_get_dsa_port(struct net_device **dev)
 	if (dp->cpu_dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
 		return -ENODEV;
 
-	*dev = dsa_port_to_master(dp);
+	*dev = dsa_port_to_conduit(dp);
 
 	return dp->index;
 #else
diff --git a/include/linux/dsa/sja1105.h b/include/linux/dsa/sja1105.h
index c177322f793d..b9dd35d4b8f5 100644
--- a/include/linux/dsa/sja1105.h
+++ b/include/linux/dsa/sja1105.h
@@ -28,7 +28,7 @@
 /* Source and Destination MAC of follow-up meta frames.
  * Whereas the choice of SMAC only affects the unique identification of the
  * switch as sender of meta frames, the DMAC must be an address that is present
- * in the DSA master port's multicast MAC filter.
+ * in the DSA conduit port's multicast MAC filter.
  * 01-80-C2-00-00-0E is a good choice for this, as all profiles of IEEE 1588
  * over L2 use this address for some purpose already.
  */
diff --git a/include/net/dsa.h b/include/net/dsa.h
index d98439ea6146..82135fbdb1e6 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -102,11 +102,11 @@ struct dsa_device_ops {
 	const char *name;
 	enum dsa_tag_protocol proto;
 	/* Some tagging protocols either mangle or shift the destination MAC
-	 * address, in which case the DSA master would drop packets on ingress
+	 * address, in which case the DSA conduit would drop packets on ingress
 	 * if what it understands out of the destination MAC address is not in
 	 * its RX filter.
 	 */
-	bool promisc_on_master;
+	bool promisc_on_conduit;
 };
 
 struct dsa_lag {
@@ -236,12 +236,12 @@ struct dsa_bridge {
 };
 
 struct dsa_port {
-	/* A CPU port is physically connected to a master device.
-	 * A user port exposed to userspace has a slave device.
+	/* A CPU port is physically connected to a conduit device. A user port
+	 * exposes a network device to user-space, called 'user' here.
 	 */
 	union {
-		struct net_device *master;
-		struct net_device *slave;
+		struct net_device *conduit;
+		struct net_device *user;
 	};
 
 	/* Copy of the tagging protocol operations, for quicker access
@@ -249,7 +249,7 @@ struct dsa_port {
 	 */
 	const struct dsa_device_ops *tag_ops;
 
-	/* Copies for faster access in master receive hot path */
+	/* Copies for faster access in conduit receive hot path */
 	struct dsa_switch_tree *dst;
 	struct sk_buff *(*rcv)(struct sk_buff *skb, struct net_device *dev);
 
@@ -281,9 +281,9 @@ struct dsa_port {
 
 	u8			lag_tx_enabled:1;
 
-	/* Master state bits, valid only on CPU ports */
-	u8			master_admin_up:1;
-	u8			master_oper_up:1;
+	/* conduit state bits, valid only on CPU ports */
+	u8			conduit_admin_up:1;
+	u8			conduit_oper_up:1;
 
 	/* Valid only on user ports */
 	u8			cpu_port_in_lag:1;
@@ -303,7 +303,7 @@ struct dsa_port {
 	struct list_head list;
 
 	/*
-	 * Original copy of the master netdev ethtool_ops
+	 * Original copy of the conduit netdev ethtool_ops
 	 */
 	const struct ethtool_ops *orig_ethtool_ops;
 
@@ -452,10 +452,10 @@ struct dsa_switch {
 	const struct dsa_switch_ops	*ops;
 
 	/*
-	 * Slave mii_bus and devices for the individual ports.
+	 * User mii_bus and devices for the individual ports.
 	 */
 	u32			phys_mii_mask;
-	struct mii_bus		*slave_mii_bus;
+	struct mii_bus		*user_mii_bus;
 
 	/* Ageing Time limits in msecs */
 	unsigned int ageing_time_min;
@@ -520,10 +520,10 @@ static inline bool dsa_port_is_unused(struct dsa_port *dp)
 	return dp->type == DSA_PORT_TYPE_UNUSED;
 }
 
-static inline bool dsa_port_master_is_operational(struct dsa_port *dp)
+static inline bool dsa_port_conduit_is_operational(struct dsa_port *dp)
 {
-	return dsa_port_is_cpu(dp) && dp->master_admin_up &&
-	       dp->master_oper_up;
+	return dsa_port_is_cpu(dp) && dp->conduit_admin_up &&
+	       dp->conduit_oper_up;
 }
 
 static inline bool dsa_is_unused_port(struct dsa_switch *ds, int p)
@@ -713,12 +713,12 @@ static inline bool dsa_port_offloads_lag(struct dsa_port *dp,
 	return dsa_port_lag_dev_get(dp) == lag->dev;
 }
 
-static inline struct net_device *dsa_port_to_master(const struct dsa_port *dp)
+static inline struct net_device *dsa_port_to_conduit(const struct dsa_port *dp)
 {
 	if (dp->cpu_port_in_lag)
 		return dsa_port_lag_dev_get(dp->cpu_dp);
 
-	return dp->cpu_dp->master;
+	return dp->cpu_dp->conduit;
 }
 
 static inline
@@ -732,7 +732,7 @@ struct net_device *dsa_port_to_bridge_port(const struct dsa_port *dp)
 	else if (dp->hsr_dev)
 		return dp->hsr_dev;
 
-	return dp->slave;
+	return dp->user;
 }
 
 static inline struct net_device *
@@ -834,9 +834,9 @@ struct dsa_switch_ops {
 	int	(*connect_tag_protocol)(struct dsa_switch *ds,
 					enum dsa_tag_protocol proto);
 
-	int	(*port_change_master)(struct dsa_switch *ds, int port,
-				      struct net_device *master,
-				      struct netlink_ext_ack *extack);
+	int	(*port_change_conduit)(struct dsa_switch *ds, int port,
+				       struct net_device *conduit,
+				       struct netlink_ext_ack *extack);
 
 	/* Optional switch-wide initialization and destruction methods */
 	int	(*setup)(struct dsa_switch *ds);
@@ -1233,11 +1233,11 @@ struct dsa_switch_ops {
 	int	(*tag_8021q_vlan_del)(struct dsa_switch *ds, int port, u16 vid);
 
 	/*
-	 * DSA master tracking operations
+	 * DSA conduit tracking operations
 	 */
-	void	(*master_state_change)(struct dsa_switch *ds,
-				       const struct net_device *master,
-				       bool operational);
+	void	(*conduit_state_change)(struct dsa_switch *ds,
+					const struct net_device *conduit,
+					bool operational);
 };
 
 #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
@@ -1374,9 +1374,9 @@ static inline int dsa_switch_resume(struct dsa_switch *ds)
 #endif /* CONFIG_PM_SLEEP */
 
 #if IS_ENABLED(CONFIG_NET_DSA)
-bool dsa_slave_dev_check(const struct net_device *dev);
+bool dsa_user_dev_check(const struct net_device *dev);
 #else
-static inline bool dsa_slave_dev_check(const struct net_device *dev)
+static inline bool dsa_user_dev_check(const struct net_device *dev)
 {
 	return false;
 }
diff --git a/include/net/dsa_stubs.h b/include/net/dsa_stubs.h
index 361811750a54..6f384897f287 100644
--- a/include/net/dsa_stubs.h
+++ b/include/net/dsa_stubs.h
@@ -13,14 +13,14 @@
 extern const struct dsa_stubs *dsa_stubs;
 
 struct dsa_stubs {
-	int (*master_hwtstamp_validate)(struct net_device *dev,
-					const struct kernel_hwtstamp_config *config,
-					struct netlink_ext_ack *extack);
+	int (*conduit_hwtstamp_validate)(struct net_device *dev,
+					 const struct kernel_hwtstamp_config *config,
+					 struct netlink_ext_ack *extack);
 };
 
-static inline int dsa_master_hwtstamp_validate(struct net_device *dev,
-					       const struct kernel_hwtstamp_config *config,
-					       struct netlink_ext_ack *extack)
+static inline int dsa_conduit_hwtstamp_validate(struct net_device *dev,
+						const struct kernel_hwtstamp_config *config,
+						struct netlink_ext_ack *extack)
 {
 	if (!netdev_uses_dsa(dev))
 		return 0;
@@ -29,18 +29,18 @@ static inline int dsa_master_hwtstamp_validate(struct net_device *dev,
 	 * netdev_uses_dsa() returns true, the dsa_core module is still
 	 * registered, and so, dsa_unregister_stubs() couldn't have run.
 	 * For netdev_uses_dsa() to start returning false, it would imply that
-	 * dsa_master_teardown() has executed, which requires rtnl_lock().
+	 * dsa_conduit_teardown() has executed, which requires rtnl_lock().
 	 */
 	ASSERT_RTNL();
 
-	return dsa_stubs->master_hwtstamp_validate(dev, config, extack);
+	return dsa_stubs->conduit_hwtstamp_validate(dev, config, extack);
 }
 
 #else
 
-static inline int dsa_master_hwtstamp_validate(struct net_device *dev,
-					       const struct kernel_hwtstamp_config *config,
-					       struct netlink_ext_ack *extack)
+static inline int dsa_conduit_hwtstamp_validate(struct net_device *dev,
+						const struct kernel_hwtstamp_config *config,
+						struct netlink_ext_ack *extack)
 {
 	return 0;
 }
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b46aedc36939..feeddf95f450 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -382,7 +382,7 @@ static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
 	if (err)
 		return err;
 
-	err = dsa_master_hwtstamp_validate(dev, &kernel_cfg, &extack);
+	err = dsa_conduit_hwtstamp_validate(dev, &kernel_cfg, &extack);
 	if (err) {
 		if (extack._msg)
 			netdev_err(dev, "%s\n", extack._msg);
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 12e305824a96..8a1894a42552 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -8,16 +8,16 @@ endif
 # the core
 obj-$(CONFIG_NET_DSA) += dsa_core.o
 dsa_core-y += \
+	conduit.o \
 	devlink.o \
 	dsa.o \
-	master.o \
 	netlink.o \
 	port.o \
-	slave.o \
 	switch.o \
 	tag.o \
 	tag_8021q.o \
-	trace.o
+	trace.o \
+	user.o
 
 # tagging formats
 obj-$(CONFIG_NET_DSA_TAG_AR9331) += tag_ar9331.o
diff --git a/net/dsa/master.c b/net/dsa/conduit.c
similarity index 76%
rename from net/dsa/master.c
rename to net/dsa/conduit.c
index 6be89ab0cc01..3dfdb3cb47dc 100644
--- a/net/dsa/master.c
+++ b/net/dsa/conduit.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Handling of a master device, switching frames via its switch fabric CPU port
+ * Handling of a conduit device, switching frames via its switch fabric CPU port
  *
  * Copyright (c) 2017 Savoir-faire Linux Inc.
  *	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
@@ -11,12 +11,12 @@
 #include <linux/netlink.h>
 #include <net/dsa.h>
 
+#include "conduit.h"
 #include "dsa.h"
-#include "master.h"
 #include "port.h"
 #include "tag.h"
 
-static int dsa_master_get_regs_len(struct net_device *dev)
+static int dsa_conduit_get_regs_len(struct net_device *dev)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -45,8 +45,8 @@ static int dsa_master_get_regs_len(struct net_device *dev)
 	return ret;
 }
 
-static void dsa_master_get_regs(struct net_device *dev,
-				struct ethtool_regs *regs, void *data)
+static void dsa_conduit_get_regs(struct net_device *dev,
+				 struct ethtool_regs *regs, void *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -80,9 +80,9 @@ static void dsa_master_get_regs(struct net_device *dev,
 	}
 }
 
-static void dsa_master_get_ethtool_stats(struct net_device *dev,
-					 struct ethtool_stats *stats,
-					 uint64_t *data)
+static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
+					  struct ethtool_stats *stats,
+					  uint64_t *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -99,9 +99,9 @@ static void dsa_master_get_ethtool_stats(struct net_device *dev,
 		ds->ops->get_ethtool_stats(ds, port, data + count);
 }
 
-static void dsa_master_get_ethtool_phy_stats(struct net_device *dev,
-					     struct ethtool_stats *stats,
-					     uint64_t *data)
+static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
+					      struct ethtool_stats *stats,
+					      uint64_t *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -125,7 +125,7 @@ static void dsa_master_get_ethtool_phy_stats(struct net_device *dev,
 		ds->ops->get_ethtool_phy_stats(ds, port, data + count);
 }
 
-static int dsa_master_get_sset_count(struct net_device *dev, int sset)
+static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -147,8 +147,8 @@ static int dsa_master_get_sset_count(struct net_device *dev, int sset)
 	return count;
 }
 
-static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
-				   uint8_t *data)
+static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
+				    uint8_t *data)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
@@ -195,12 +195,12 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
 	}
 }
 
-/* Deny PTP operations on master if there is at least one switch in the tree
+/* Deny PTP operations on conduit if there is at least one switch in the tree
  * that is PTP capable.
  */
-int __dsa_master_hwtstamp_validate(struct net_device *dev,
-				   const struct kernel_hwtstamp_config *config,
-				   struct netlink_ext_ack *extack)
+int __dsa_conduit_hwtstamp_validate(struct net_device *dev,
+				    const struct kernel_hwtstamp_config *config,
+				    struct netlink_ext_ack *extack)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	struct dsa_switch *ds = cpu_dp->ds;
@@ -212,7 +212,7 @@ int __dsa_master_hwtstamp_validate(struct net_device *dev,
 	list_for_each_entry(dp, &dst->ports, list) {
 		if (dsa_port_supports_hwtstamp(dp)) {
 			NL_SET_ERR_MSG(extack,
-				       "HW timestamping not allowed on DSA master when switch supports the operation");
+				       "HW timestamping not allowed on DSA conduit when switch supports the operation");
 			return -EBUSY;
 		}
 	}
@@ -220,7 +220,7 @@ int __dsa_master_hwtstamp_validate(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_master_ethtool_setup(struct net_device *dev)
+static int dsa_conduit_ethtool_setup(struct net_device *dev)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	struct dsa_switch *ds = cpu_dp->ds;
@@ -237,19 +237,19 @@ static int dsa_master_ethtool_setup(struct net_device *dev)
 	if (cpu_dp->orig_ethtool_ops)
 		memcpy(ops, cpu_dp->orig_ethtool_ops, sizeof(*ops));
 
-	ops->get_regs_len = dsa_master_get_regs_len;
-	ops->get_regs = dsa_master_get_regs;
-	ops->get_sset_count = dsa_master_get_sset_count;
-	ops->get_ethtool_stats = dsa_master_get_ethtool_stats;
-	ops->get_strings = dsa_master_get_strings;
-	ops->get_ethtool_phy_stats = dsa_master_get_ethtool_phy_stats;
+	ops->get_regs_len = dsa_conduit_get_regs_len;
+	ops->get_regs = dsa_conduit_get_regs;
+	ops->get_sset_count = dsa_conduit_get_sset_count;
+	ops->get_ethtool_stats = dsa_conduit_get_ethtool_stats;
+	ops->get_strings = dsa_conduit_get_strings;
+	ops->get_ethtool_phy_stats = dsa_conduit_get_ethtool_phy_stats;
 
 	dev->ethtool_ops = ops;
 
 	return 0;
 }
 
-static void dsa_master_ethtool_teardown(struct net_device *dev)
+static void dsa_conduit_ethtool_teardown(struct net_device *dev)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 
@@ -260,16 +260,16 @@ static void dsa_master_ethtool_teardown(struct net_device *dev)
 	cpu_dp->orig_ethtool_ops = NULL;
 }
 
-/* Keep the master always promiscuous if the tagging protocol requires that
+/* Keep the conduit always promiscuous if the tagging protocol requires that
  * (garbles MAC DA) or if it doesn't support unicast filtering, case in which
  * it would revert to promiscuous mode as soon as we call dev_uc_add() on it
  * anyway.
  */
-static void dsa_master_set_promiscuity(struct net_device *dev, int inc)
+static void dsa_conduit_set_promiscuity(struct net_device *dev, int inc)
 {
 	const struct dsa_device_ops *ops = dev->dsa_ptr->tag_ops;
 
-	if ((dev->priv_flags & IFF_UNICAST_FLT) && !ops->promisc_on_master)
+	if ((dev->priv_flags & IFF_UNICAST_FLT) && !ops->promisc_on_conduit)
 		return;
 
 	ASSERT_RTNL();
@@ -336,17 +336,17 @@ static ssize_t tagging_store(struct device *d, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(tagging);
 
-static struct attribute *dsa_slave_attrs[] = {
+static struct attribute *dsa_user_attrs[] = {
 	&dev_attr_tagging.attr,
 	NULL
 };
 
 static const struct attribute_group dsa_group = {
 	.name	= "dsa",
-	.attrs	= dsa_slave_attrs,
+	.attrs	= dsa_user_attrs,
 };
 
-static void dsa_master_reset_mtu(struct net_device *dev)
+static void dsa_conduit_reset_mtu(struct net_device *dev)
 {
 	int err;
 
@@ -356,7 +356,7 @@ static void dsa_master_reset_mtu(struct net_device *dev)
 			   "Unable to reset MTU to exclude DSA overheads\n");
 }
 
-int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
+int dsa_conduit_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 {
 	const struct dsa_device_ops *tag_ops = cpu_dp->tag_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
@@ -365,7 +365,7 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 
 	mtu = ETH_DATA_LEN + dsa_tag_protocol_overhead(tag_ops);
 
-	/* The DSA master must use SET_NETDEV_DEV for this to work. */
+	/* The DSA conduit must use SET_NETDEV_DEV for this to work. */
 	if (!netif_is_lag_master(dev)) {
 		consumer_link = device_link_add(ds->dev, dev->dev.parent,
 						DL_FLAG_AUTOREMOVE_CONSUMER);
@@ -376,7 +376,7 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 	}
 
 	/* The switch driver may not implement ->port_change_mtu(), case in
-	 * which dsa_slave_change_mtu() will not update the master MTU either,
+	 * which dsa_user_change_mtu() will not update the conduit MTU either,
 	 * so we need to do that here.
 	 */
 	ret = dev_set_mtu(dev, mtu);
@@ -392,9 +392,9 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 
 	dev->dsa_ptr = cpu_dp;
 
-	dsa_master_set_promiscuity(dev, 1);
+	dsa_conduit_set_promiscuity(dev, 1);
 
-	ret = dsa_master_ethtool_setup(dev);
+	ret = dsa_conduit_ethtool_setup(dev);
 	if (ret)
 		goto out_err_reset_promisc;
 
@@ -405,18 +405,18 @@ int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 	return ret;
 
 out_err_ethtool_teardown:
-	dsa_master_ethtool_teardown(dev);
+	dsa_conduit_ethtool_teardown(dev);
 out_err_reset_promisc:
-	dsa_master_set_promiscuity(dev, -1);
+	dsa_conduit_set_promiscuity(dev, -1);
 	return ret;
 }
 
-void dsa_master_teardown(struct net_device *dev)
+void dsa_conduit_teardown(struct net_device *dev)
 {
 	sysfs_remove_group(&dev->dev.kobj, &dsa_group);
-	dsa_master_ethtool_teardown(dev);
-	dsa_master_reset_mtu(dev);
-	dsa_master_set_promiscuity(dev, -1);
+	dsa_conduit_ethtool_teardown(dev);
+	dsa_conduit_reset_mtu(dev);
+	dsa_conduit_set_promiscuity(dev, -1);
 
 	dev->dsa_ptr = NULL;
 
@@ -427,40 +427,40 @@ void dsa_master_teardown(struct net_device *dev)
 	wmb();
 }
 
-int dsa_master_lag_setup(struct net_device *lag_dev, struct dsa_port *cpu_dp,
-			 struct netdev_lag_upper_info *uinfo,
-			 struct netlink_ext_ack *extack)
+int dsa_conduit_lag_setup(struct net_device *lag_dev, struct dsa_port *cpu_dp,
+			  struct netdev_lag_upper_info *uinfo,
+			  struct netlink_ext_ack *extack)
 {
-	bool master_setup = false;
+	bool conduit_setup = false;
 	int err;
 
 	if (!netdev_uses_dsa(lag_dev)) {
-		err = dsa_master_setup(lag_dev, cpu_dp);
+		err = dsa_conduit_setup(lag_dev, cpu_dp);
 		if (err)
 			return err;
 
-		master_setup = true;
+		conduit_setup = true;
 	}
 
 	err = dsa_port_lag_join(cpu_dp, lag_dev, uinfo, extack);
 	if (err) {
 		NL_SET_ERR_MSG_WEAK_MOD(extack, "CPU port failed to join LAG");
-		goto out_master_teardown;
+		goto out_conduit_teardown;
 	}
 
 	return 0;
 
-out_master_teardown:
-	if (master_setup)
-		dsa_master_teardown(lag_dev);
+out_conduit_teardown:
+	if (conduit_setup)
+		dsa_conduit_teardown(lag_dev);
 	return err;
 }
 
-/* Tear down a master if there isn't any other user port on it,
+/* Tear down a conduit if there isn't any other user port on it,
  * optionally also destroying LAG information.
  */
-void dsa_master_lag_teardown(struct net_device *lag_dev,
-			     struct dsa_port *cpu_dp)
+void dsa_conduit_lag_teardown(struct net_device *lag_dev,
+			      struct dsa_port *cpu_dp)
 {
 	struct net_device *upper;
 	struct list_head *iter;
@@ -468,8 +468,8 @@ void dsa_master_lag_teardown(struct net_device *lag_dev,
 	dsa_port_lag_leave(cpu_dp, lag_dev);
 
 	netdev_for_each_upper_dev_rcu(lag_dev, upper, iter)
-		if (dsa_slave_dev_check(upper))
+		if (dsa_user_dev_check(upper))
 			return;
 
-	dsa_master_teardown(lag_dev);
+	dsa_conduit_teardown(lag_dev);
 }
diff --git a/net/dsa/conduit.h b/net/dsa/conduit.h
new file mode 100644
index 000000000000..31f8834f54bb
--- /dev/null
+++ b/net/dsa/conduit.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __DSA_CONDUIT_H
+#define __DSA_CONDUIT_H
+
+struct dsa_port;
+struct net_device;
+struct netdev_lag_upper_info;
+struct netlink_ext_ack;
+
+int dsa_conduit_setup(struct net_device *dev, struct dsa_port *cpu_dp);
+void dsa_conduit_teardown(struct net_device *dev);
+int dsa_conduit_lag_setup(struct net_device *lag_dev, struct dsa_port *cpu_dp,
+			  struct netdev_lag_upper_info *uinfo,
+			  struct netlink_ext_ack *extack);
+void dsa_conduit_lag_teardown(struct net_device *lag_dev,
+			      struct dsa_port *cpu_dp);
+int __dsa_conduit_hwtstamp_validate(struct net_device *dev,
+				    const struct kernel_hwtstamp_config *config,
+				    struct netlink_ext_ack *extack);
+
+#endif
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ccbdb98109f8..267dd175c1b4 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -20,14 +20,14 @@
 #include <net/dsa_stubs.h>
 #include <net/sch_generic.h>
 
+#include "conduit.h"
 #include "devlink.h"
 #include "dsa.h"
-#include "master.h"
 #include "netlink.h"
 #include "port.h"
-#include "slave.h"
 #include "switch.h"
 #include "tag.h"
+#include "user.h"
 
 #define DSA_MAX_NUM_OFFLOADING_BRIDGES		BITS_PER_LONG
 
@@ -365,18 +365,18 @@ static struct dsa_port *dsa_tree_find_first_cpu(struct dsa_switch_tree *dst)
 	return NULL;
 }
 
-struct net_device *dsa_tree_find_first_master(struct dsa_switch_tree *dst)
+struct net_device *dsa_tree_find_first_conduit(struct dsa_switch_tree *dst)
 {
 	struct device_node *ethernet;
-	struct net_device *master;
+	struct net_device *conduit;
 	struct dsa_port *cpu_dp;
 
 	cpu_dp = dsa_tree_find_first_cpu(dst);
 	ethernet = of_parse_phandle(cpu_dp->dn, "ethernet", 0);
-	master = of_find_net_device_by_node(ethernet);
+	conduit = of_find_net_device_by_node(ethernet);
 	of_node_put(ethernet);
 
-	return master;
+	return conduit;
 }
 
 /* Assign the default CPU port (the first one in the tree) to all ports of the
@@ -517,7 +517,7 @@ static int dsa_port_setup(struct dsa_port *dp)
 		break;
 	case DSA_PORT_TYPE_USER:
 		of_get_mac_address(dp->dn, dp->mac);
-		err = dsa_slave_create(dp);
+		err = dsa_user_create(dp);
 		break;
 	}
 
@@ -554,9 +554,9 @@ static void dsa_port_teardown(struct dsa_port *dp)
 			dsa_shared_port_link_unregister_of(dp);
 		break;
 	case DSA_PORT_TYPE_USER:
-		if (dp->slave) {
-			dsa_slave_destroy(dp->slave);
-			dp->slave = NULL;
+		if (dp->user) {
+			dsa_user_destroy(dp->user);
+			dp->user = NULL;
 		}
 		break;
 	}
@@ -632,9 +632,9 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	if (ds->setup)
 		return 0;
 
-	/* Initialize ds->phys_mii_mask before registering the slave MDIO bus
+	/* Initialize ds->phys_mii_mask before registering the user MDIO bus
 	 * driver and before ops->setup() has run, since the switch drivers and
-	 * the slave MDIO bus driver rely on these values for probing PHY
+	 * the user MDIO bus driver rely on these values for probing PHY
 	 * devices or not
 	 */
 	ds->phys_mii_mask |= dsa_user_ports(ds);
@@ -657,21 +657,21 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	if (err)
 		goto teardown;
 
-	if (!ds->slave_mii_bus && ds->ops->phy_read) {
-		ds->slave_mii_bus = mdiobus_alloc();
-		if (!ds->slave_mii_bus) {
+	if (!ds->user_mii_bus && ds->ops->phy_read) {
+		ds->user_mii_bus = mdiobus_alloc();
+		if (!ds->user_mii_bus) {
 			err = -ENOMEM;
 			goto teardown;
 		}
 
-		dsa_slave_mii_bus_init(ds);
+		dsa_user_mii_bus_init(ds);
 
 		dn = of_get_child_by_name(ds->dev->of_node, "mdio");
 
-		err = of_mdiobus_register(ds->slave_mii_bus, dn);
+		err = of_mdiobus_register(ds->user_mii_bus, dn);
 		of_node_put(dn);
 		if (err < 0)
-			goto free_slave_mii_bus;
+			goto free_user_mii_bus;
 	}
 
 	dsa_switch_devlink_register(ds);
@@ -679,9 +679,9 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	ds->setup = true;
 	return 0;
 
-free_slave_mii_bus:
-	if (ds->slave_mii_bus && ds->ops->phy_read)
-		mdiobus_free(ds->slave_mii_bus);
+free_user_mii_bus:
+	if (ds->user_mii_bus && ds->ops->phy_read)
+		mdiobus_free(ds->user_mii_bus);
 teardown:
 	if (ds->ops->teardown)
 		ds->ops->teardown(ds);
@@ -699,10 +699,10 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
 
 	dsa_switch_devlink_unregister(ds);
 
-	if (ds->slave_mii_bus && ds->ops->phy_read) {
-		mdiobus_unregister(ds->slave_mii_bus);
-		mdiobus_free(ds->slave_mii_bus);
-		ds->slave_mii_bus = NULL;
+	if (ds->user_mii_bus && ds->ops->phy_read) {
+		mdiobus_unregister(ds->user_mii_bus);
+		mdiobus_free(ds->user_mii_bus);
+		ds->user_mii_bus = NULL;
 	}
 
 	dsa_switch_teardown_tag_protocol(ds);
@@ -793,7 +793,7 @@ static int dsa_tree_setup_switches(struct dsa_switch_tree *dst)
 	return err;
 }
 
-static int dsa_tree_setup_master(struct dsa_switch_tree *dst)
+static int dsa_tree_setup_conduit(struct dsa_switch_tree *dst)
 {
 	struct dsa_port *cpu_dp;
 	int err = 0;
@@ -801,18 +801,18 @@ static int dsa_tree_setup_master(struct dsa_switch_tree *dst)
 	rtnl_lock();
 
 	dsa_tree_for_each_cpu_port(cpu_dp, dst) {
-		struct net_device *master = cpu_dp->master;
-		bool admin_up = (master->flags & IFF_UP) &&
-				!qdisc_tx_is_noop(master);
+		struct net_device *conduit = cpu_dp->conduit;
+		bool admin_up = (conduit->flags & IFF_UP) &&
+				!qdisc_tx_is_noop(conduit);
 
-		err = dsa_master_setup(master, cpu_dp);
+		err = dsa_conduit_setup(conduit, cpu_dp);
 		if (err)
 			break;
 
-		/* Replay master state event */
-		dsa_tree_master_admin_state_change(dst, master, admin_up);
-		dsa_tree_master_oper_state_change(dst, master,
-						  netif_oper_up(master));
+		/* Replay conduit state event */
+		dsa_tree_conduit_admin_state_change(dst, conduit, admin_up);
+		dsa_tree_conduit_oper_state_change(dst, conduit,
+						   netif_oper_up(conduit));
 	}
 
 	rtnl_unlock();
@@ -820,22 +820,22 @@ static int dsa_tree_setup_master(struct dsa_switch_tree *dst)
 	return err;
 }
 
-static void dsa_tree_teardown_master(struct dsa_switch_tree *dst)
+static void dsa_tree_teardown_conduit(struct dsa_switch_tree *dst)
 {
 	struct dsa_port *cpu_dp;
 
 	rtnl_lock();
 
 	dsa_tree_for_each_cpu_port(cpu_dp, dst) {
-		struct net_device *master = cpu_dp->master;
+		struct net_device *conduit = cpu_dp->conduit;
 
 		/* Synthesizing an "admin down" state is sufficient for
-		 * the switches to get a notification if the master is
+		 * the switches to get a notification if the conduit is
 		 * currently up and running.
 		 */
-		dsa_tree_master_admin_state_change(dst, master, false);
+		dsa_tree_conduit_admin_state_change(dst, conduit, false);
 
-		dsa_master_teardown(master);
+		dsa_conduit_teardown(conduit);
 	}
 
 	rtnl_unlock();
@@ -894,13 +894,13 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 	if (err)
 		goto teardown_switches;
 
-	err = dsa_tree_setup_master(dst);
+	err = dsa_tree_setup_conduit(dst);
 	if (err)
 		goto teardown_ports;
 
 	err = dsa_tree_setup_lags(dst);
 	if (err)
-		goto teardown_master;
+		goto teardown_conduit;
 
 	dst->setup = true;
 
@@ -908,8 +908,8 @@ static int dsa_tree_setup(struct dsa_switch_tree *dst)
 
 	return 0;
 
-teardown_master:
-	dsa_tree_teardown_master(dst);
+teardown_conduit:
+	dsa_tree_teardown_conduit(dst);
 teardown_ports:
 	dsa_tree_teardown_ports(dst);
 teardown_switches:
@@ -929,7 +929,7 @@ static void dsa_tree_teardown(struct dsa_switch_tree *dst)
 
 	dsa_tree_teardown_lags(dst);
 
-	dsa_tree_teardown_master(dst);
+	dsa_tree_teardown_conduit(dst);
 
 	dsa_tree_teardown_ports(dst);
 
@@ -978,7 +978,7 @@ static int dsa_tree_bind_tag_proto(struct dsa_switch_tree *dst,
 	return err;
 }
 
-/* Since the dsa/tagging sysfs device attribute is per master, the assumption
+/* Since the dsa/tagging sysfs device attribute is per conduit, the assumption
  * is that all DSA switches within a tree share the same tagger, otherwise
  * they would have formed disjoint trees (different "dsa,member" values).
  */
@@ -999,10 +999,10 @@ int dsa_tree_change_tag_proto(struct dsa_switch_tree *dst,
 	 * restriction, there needs to be another mutex which serializes this.
 	 */
 	dsa_tree_for_each_user_port(dp, dst) {
-		if (dsa_port_to_master(dp)->flags & IFF_UP)
+		if (dsa_port_to_conduit(dp)->flags & IFF_UP)
 			goto out_unlock;
 
-		if (dp->slave->flags & IFF_UP)
+		if (dp->user->flags & IFF_UP)
 			goto out_unlock;
 	}
 
@@ -1028,62 +1028,62 @@ int dsa_tree_change_tag_proto(struct dsa_switch_tree *dst,
 	return err;
 }
 
-static void dsa_tree_master_state_change(struct dsa_switch_tree *dst,
-					 struct net_device *master)
+static void dsa_tree_conduit_state_change(struct dsa_switch_tree *dst,
+					  struct net_device *conduit)
 {
-	struct dsa_notifier_master_state_info info;
-	struct dsa_port *cpu_dp = master->dsa_ptr;
+	struct dsa_notifier_conduit_state_info info;
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 
-	info.master = master;
-	info.operational = dsa_port_master_is_operational(cpu_dp);
+	info.conduit = conduit;
+	info.operational = dsa_port_conduit_is_operational(cpu_dp);
 
 	dsa_tree_notify(dst, DSA_NOTIFIER_MASTER_STATE_CHANGE, &info);
 }
 
-void dsa_tree_master_admin_state_change(struct dsa_switch_tree *dst,
-					struct net_device *master,
-					bool up)
+void dsa_tree_conduit_admin_state_change(struct dsa_switch_tree *dst,
+					 struct net_device *conduit,
+					 bool up)
 {
-	struct dsa_port *cpu_dp = master->dsa_ptr;
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	bool notify = false;
 
-	/* Don't keep track of admin state on LAG DSA masters,
-	 * but rather just of physical DSA masters
+	/* Don't keep track of admin state on LAG DSA conduits,
+	 * but rather just of physical DSA conduits
 	 */
-	if (netif_is_lag_master(master))
+	if (netif_is_lag_master(conduit))
 		return;
 
-	if ((dsa_port_master_is_operational(cpu_dp)) !=
-	    (up && cpu_dp->master_oper_up))
+	if ((dsa_port_conduit_is_operational(cpu_dp)) !=
+	    (up && cpu_dp->conduit_oper_up))
 		notify = true;
 
-	cpu_dp->master_admin_up = up;
+	cpu_dp->conduit_admin_up = up;
 
 	if (notify)
-		dsa_tree_master_state_change(dst, master);
+		dsa_tree_conduit_state_change(dst, conduit);
 }
 
-void dsa_tree_master_oper_state_change(struct dsa_switch_tree *dst,
-				       struct net_device *master,
-				       bool up)
+void dsa_tree_conduit_oper_state_change(struct dsa_switch_tree *dst,
+					struct net_device *conduit,
+					bool up)
 {
-	struct dsa_port *cpu_dp = master->dsa_ptr;
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	bool notify = false;
 
-	/* Don't keep track of oper state on LAG DSA masters,
-	 * but rather just of physical DSA masters
+	/* Don't keep track of oper state on LAG DSA conduits,
+	 * but rather just of physical DSA conduits
 	 */
-	if (netif_is_lag_master(master))
+	if (netif_is_lag_master(conduit))
 		return;
 
-	if ((dsa_port_master_is_operational(cpu_dp)) !=
-	    (cpu_dp->master_admin_up && up))
+	if ((dsa_port_conduit_is_operational(cpu_dp)) !=
+	    (cpu_dp->conduit_admin_up && up))
 		notify = true;
 
-	cpu_dp->master_oper_up = up;
+	cpu_dp->conduit_oper_up = up;
 
 	if (notify)
-		dsa_tree_master_state_change(dst, master);
+		dsa_tree_conduit_state_change(dst, conduit);
 }
 
 static struct dsa_port *dsa_port_touch(struct dsa_switch *ds, int index)
@@ -1129,7 +1129,7 @@ static int dsa_port_parse_dsa(struct dsa_port *dp)
 }
 
 static enum dsa_tag_protocol dsa_get_tag_protocol(struct dsa_port *dp,
-						  struct net_device *master)
+						  struct net_device *conduit)
 {
 	enum dsa_tag_protocol tag_protocol = DSA_TAG_PROTO_NONE;
 	struct dsa_switch *mds, *ds = dp->ds;
@@ -1140,21 +1140,21 @@ static enum dsa_tag_protocol dsa_get_tag_protocol(struct dsa_port *dp,
 	 * happens the switch driver may want to know if its tagging protocol
 	 * is going to work in such a configuration.
 	 */
-	if (dsa_slave_dev_check(master)) {
-		mdp = dsa_slave_to_port(master);
+	if (dsa_user_dev_check(conduit)) {
+		mdp = dsa_user_to_port(conduit);
 		mds = mdp->ds;
 		mdp_upstream = dsa_upstream_port(mds, mdp->index);
 		tag_protocol = mds->ops->get_tag_protocol(mds, mdp_upstream,
 							  DSA_TAG_PROTO_NONE);
 	}
 
-	/* If the master device is not itself a DSA slave in a disjoint DSA
+	/* If the conduit device is not itself a DSA user in a disjoint DSA
 	 * tree, then return immediately.
 	 */
 	return ds->ops->get_tag_protocol(ds, dp->index, tag_protocol);
 }
 
-static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master,
+static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *conduit,
 			      const char *user_protocol)
 {
 	const struct dsa_device_ops *tag_ops = NULL;
@@ -1163,7 +1163,7 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master,
 	enum dsa_tag_protocol default_proto;
 
 	/* Find out which protocol the switch would prefer. */
-	default_proto = dsa_get_tag_protocol(dp, master);
+	default_proto = dsa_get_tag_protocol(dp, conduit);
 	if (dst->default_proto) {
 		if (dst->default_proto != default_proto) {
 			dev_err(ds->dev,
@@ -1218,7 +1218,7 @@ static int dsa_port_parse_cpu(struct dsa_port *dp, struct net_device *master,
 		dst->tag_ops = tag_ops;
 	}
 
-	dp->master = master;
+	dp->conduit = conduit;
 	dp->type = DSA_PORT_TYPE_CPU;
 	dsa_port_set_tag_protocol(dp, dst->tag_ops);
 	dp->dst = dst;
@@ -1248,16 +1248,16 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 	dp->dn = dn;
 
 	if (ethernet) {
-		struct net_device *master;
+		struct net_device *conduit;
 		const char *user_protocol;
 
-		master = of_find_net_device_by_node(ethernet);
+		conduit = of_find_net_device_by_node(ethernet);
 		of_node_put(ethernet);
-		if (!master)
+		if (!conduit)
 			return -EPROBE_DEFER;
 
 		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
-		return dsa_port_parse_cpu(dp, master, user_protocol);
+		return dsa_port_parse_cpu(dp, conduit, user_protocol);
 	}
 
 	if (link)
@@ -1412,15 +1412,15 @@ static int dsa_port_parse(struct dsa_port *dp, const char *name,
 			  struct device *dev)
 {
 	if (!strcmp(name, "cpu")) {
-		struct net_device *master;
+		struct net_device *conduit;
 
-		master = dsa_dev_to_net_device(dev);
-		if (!master)
+		conduit = dsa_dev_to_net_device(dev);
+		if (!conduit)
 			return -EPROBE_DEFER;
 
-		dev_put(master);
+		dev_put(conduit);
 
-		return dsa_port_parse_cpu(dp, master, NULL);
+		return dsa_port_parse_cpu(dp, conduit, NULL);
 	}
 
 	if (!strcmp(name, "dsa"))
@@ -1566,14 +1566,14 @@ void dsa_unregister_switch(struct dsa_switch *ds)
 }
 EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 
-/* If the DSA master chooses to unregister its net_device on .shutdown, DSA is
+/* If the DSA conduit chooses to unregister its net_device on .shutdown, DSA is
  * blocking that operation from completion, due to the dev_hold taken inside
- * netdev_upper_dev_link. Unlink the DSA slave interfaces from being uppers of
- * the DSA master, so that the system can reboot successfully.
+ * netdev_upper_dev_link. Unlink the DSA user interfaces from being uppers of
+ * the DSA conduit, so that the system can reboot successfully.
  */
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
-	struct net_device *master, *slave_dev;
+	struct net_device *conduit, *user_dev;
 	struct dsa_port *dp;
 
 	mutex_lock(&dsa2_mutex);
@@ -1584,17 +1584,17 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	rtnl_lock();
 
 	dsa_switch_for_each_user_port(dp, ds) {
-		master = dsa_port_to_master(dp);
-		slave_dev = dp->slave;
+		conduit = dsa_port_to_conduit(dp);
+		user_dev = dp->user;
 
-		netdev_upper_dev_unlink(master, slave_dev);
+		netdev_upper_dev_unlink(conduit, user_dev);
 	}
 
-	/* Disconnect from further netdevice notifiers on the master,
+	/* Disconnect from further netdevice notifiers on the conduit,
 	 * since netdev_uses_dsa() will now return false.
 	 */
 	dsa_switch_for_each_cpu_port(dp, ds)
-		dp->master->dsa_ptr = NULL;
+		dp->conduit->dsa_ptr = NULL;
 
 	rtnl_unlock();
 out:
@@ -1605,7 +1605,7 @@ EXPORT_SYMBOL_GPL(dsa_switch_shutdown);
 #ifdef CONFIG_PM_SLEEP
 static bool dsa_port_is_initialized(const struct dsa_port *dp)
 {
-	return dp->type == DSA_PORT_TYPE_USER && dp->slave;
+	return dp->type == DSA_PORT_TYPE_USER && dp->user;
 }
 
 int dsa_switch_suspend(struct dsa_switch *ds)
@@ -1613,12 +1613,12 @@ int dsa_switch_suspend(struct dsa_switch *ds)
 	struct dsa_port *dp;
 	int ret = 0;
 
-	/* Suspend slave network devices */
+	/* Suspend user network devices */
 	dsa_switch_for_each_port(dp, ds) {
 		if (!dsa_port_is_initialized(dp))
 			continue;
 
-		ret = dsa_slave_suspend(dp->slave);
+		ret = dsa_user_suspend(dp->user);
 		if (ret)
 			return ret;
 	}
@@ -1641,12 +1641,12 @@ int dsa_switch_resume(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Resume slave network devices */
+	/* Resume user network devices */
 	dsa_switch_for_each_port(dp, ds) {
 		if (!dsa_port_is_initialized(dp))
 			continue;
 
-		ret = dsa_slave_resume(dp->slave);
+		ret = dsa_user_resume(dp->user);
 		if (ret)
 			return ret;
 	}
@@ -1658,10 +1658,10 @@ EXPORT_SYMBOL_GPL(dsa_switch_resume);
 
 struct dsa_port *dsa_port_from_netdev(struct net_device *netdev)
 {
-	if (!netdev || !dsa_slave_dev_check(netdev))
+	if (!netdev || !dsa_user_dev_check(netdev))
 		return ERR_PTR(-ENODEV);
 
-	return dsa_slave_to_port(netdev);
+	return dsa_user_to_port(netdev);
 }
 EXPORT_SYMBOL_GPL(dsa_port_from_netdev);
 
@@ -1726,7 +1726,7 @@ bool dsa_mdb_present_in_other_db(struct dsa_switch *ds, int port,
 EXPORT_SYMBOL_GPL(dsa_mdb_present_in_other_db);
 
 static const struct dsa_stubs __dsa_stubs = {
-	.master_hwtstamp_validate = __dsa_master_hwtstamp_validate,
+	.conduit_hwtstamp_validate = __dsa_conduit_hwtstamp_validate,
 };
 
 static void dsa_register_stubs(void)
@@ -1748,7 +1748,7 @@ static int __init dsa_init_module(void)
 	if (!dsa_owq)
 		return -ENOMEM;
 
-	rc = dsa_slave_register_notifier();
+	rc = dsa_user_register_notifier();
 	if (rc)
 		goto register_notifier_fail;
 
@@ -1763,7 +1763,7 @@ static int __init dsa_init_module(void)
 	return 0;
 
 netlink_register_fail:
-	dsa_slave_unregister_notifier();
+	dsa_user_unregister_notifier();
 	dev_remove_pack(&dsa_pack_type);
 register_notifier_fail:
 	destroy_workqueue(dsa_owq);
@@ -1778,7 +1778,7 @@ static void __exit dsa_cleanup_module(void)
 
 	rtnl_link_unregister(&dsa_link_ops);
 
-	dsa_slave_unregister_notifier();
+	dsa_user_unregister_notifier();
 	dev_remove_pack(&dsa_pack_type);
 	destroy_workqueue(dsa_owq);
 }
diff --git a/net/dsa/dsa.h b/net/dsa/dsa.h
index b7e17ae1094d..3cc7823e9ef3 100644
--- a/net/dsa/dsa.h
+++ b/net/dsa/dsa.h
@@ -21,16 +21,16 @@ void dsa_lag_map(struct dsa_switch_tree *dst, struct dsa_lag *lag);
 void dsa_lag_unmap(struct dsa_switch_tree *dst, struct dsa_lag *lag);
 struct dsa_lag *dsa_tree_lag_find(struct dsa_switch_tree *dst,
 				  const struct net_device *lag_dev);
-struct net_device *dsa_tree_find_first_master(struct dsa_switch_tree *dst);
+struct net_device *dsa_tree_find_first_conduit(struct dsa_switch_tree *dst);
 int dsa_tree_change_tag_proto(struct dsa_switch_tree *dst,
 			      const struct dsa_device_ops *tag_ops,
 			      const struct dsa_device_ops *old_tag_ops);
-void dsa_tree_master_admin_state_change(struct dsa_switch_tree *dst,
-					struct net_device *master,
+void dsa_tree_conduit_admin_state_change(struct dsa_switch_tree *dst,
+					 struct net_device *conduit,
+					 bool up);
+void dsa_tree_conduit_oper_state_change(struct dsa_switch_tree *dst,
+					struct net_device *conduit,
 					bool up);
-void dsa_tree_master_oper_state_change(struct dsa_switch_tree *dst,
-				       struct net_device *master,
-				       bool up);
 unsigned int dsa_bridge_num_get(const struct net_device *bridge_dev, int max);
 void dsa_bridge_num_put(const struct net_device *bridge_dev,
 			unsigned int bridge_num);
diff --git a/net/dsa/master.h b/net/dsa/master.h
deleted file mode 100644
index 76e39d3ec909..000000000000
--- a/net/dsa/master.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#ifndef __DSA_MASTER_H
-#define __DSA_MASTER_H
-
-struct dsa_port;
-struct net_device;
-struct netdev_lag_upper_info;
-struct netlink_ext_ack;
-
-int dsa_master_setup(struct net_device *dev, struct dsa_port *cpu_dp);
-void dsa_master_teardown(struct net_device *dev);
-int dsa_master_lag_setup(struct net_device *lag_dev, struct dsa_port *cpu_dp,
-			 struct netdev_lag_upper_info *uinfo,
-			 struct netlink_ext_ack *extack);
-void dsa_master_lag_teardown(struct net_device *lag_dev,
-			     struct dsa_port *cpu_dp);
-int __dsa_master_hwtstamp_validate(struct net_device *dev,
-				   const struct kernel_hwtstamp_config *config,
-				   struct netlink_ext_ack *extack);
-
-#endif
diff --git a/net/dsa/netlink.c b/net/dsa/netlink.c
index bd4bbaf851de..f56f90a25b99 100644
--- a/net/dsa/netlink.c
+++ b/net/dsa/netlink.c
@@ -5,7 +5,7 @@
 #include <net/rtnetlink.h>
 
 #include "netlink.h"
-#include "slave.h"
+#include "user.h"
 
 static const struct nla_policy dsa_policy[IFLA_DSA_MAX + 1] = {
 	[IFLA_DSA_MASTER]	= { .type = NLA_U32 },
@@ -22,13 +22,13 @@ static int dsa_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	if (data[IFLA_DSA_MASTER]) {
 		u32 ifindex = nla_get_u32(data[IFLA_DSA_MASTER]);
-		struct net_device *master;
+		struct net_device *conduit;
 
-		master = __dev_get_by_index(dev_net(dev), ifindex);
-		if (!master)
+		conduit = __dev_get_by_index(dev_net(dev), ifindex);
+		if (!conduit)
 			return -EINVAL;
 
-		err = dsa_slave_change_master(dev, master, extack);
+		err = dsa_user_change_conduit(dev, conduit, extack);
 		if (err)
 			return err;
 	}
@@ -44,9 +44,9 @@ static size_t dsa_get_size(const struct net_device *dev)
 
 static int dsa_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
 
-	if (nla_put_u32(skb, IFLA_DSA_MASTER, master->ifindex))
+	if (nla_put_u32(skb, IFLA_DSA_MASTER, conduit->ifindex))
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 6e0d000a97c4..82a30d67086b 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -14,9 +14,9 @@
 
 #include "dsa.h"
 #include "port.h"
-#include "slave.h"
 #include "switch.h"
 #include "tag_8021q.h"
+#include "user.h"
 
 /**
  * dsa_port_notify - Notify the switching fabric of changes to a port
@@ -289,7 +289,7 @@ static void dsa_port_reset_vlan_filtering(struct dsa_port *dp,
 	}
 
 	/* If the bridge was vlan_filtering, the bridge core doesn't trigger an
-	 * event for changing vlan_filtering setting upon slave ports leaving
+	 * event for changing vlan_filtering setting upon user ports leaving
 	 * it. That is a good thing, because that lets us handle it and also
 	 * handle the case where the switch's vlan_filtering setting is global
 	 * (not per port). When that happens, the correct moment to trigger the
@@ -489,7 +489,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 		.dp = dp,
 		.extack = extack,
 	};
-	struct net_device *dev = dp->slave;
+	struct net_device *dev = dp->user;
 	struct net_device *brport_dev;
 	int err;
 
@@ -514,8 +514,8 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 	dp->bridge->tx_fwd_offload = info.tx_fwd_offload;
 
 	err = switchdev_bridge_port_offload(brport_dev, dev, dp,
-					    &dsa_slave_switchdev_notifier,
-					    &dsa_slave_switchdev_blocking_notifier,
+					    &dsa_user_switchdev_notifier,
+					    &dsa_user_switchdev_blocking_notifier,
 					    dp->bridge->tx_fwd_offload, extack);
 	if (err)
 		goto out_rollback_unbridge;
@@ -528,8 +528,8 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
 
 out_rollback_unoffload:
 	switchdev_bridge_port_unoffload(brport_dev, dp,
-					&dsa_slave_switchdev_notifier,
-					&dsa_slave_switchdev_blocking_notifier);
+					&dsa_user_switchdev_notifier,
+					&dsa_user_switchdev_blocking_notifier);
 	dsa_flush_workqueue();
 out_rollback_unbridge:
 	dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
@@ -547,8 +547,8 @@ void dsa_port_pre_bridge_leave(struct dsa_port *dp, struct net_device *br)
 		return;
 
 	switchdev_bridge_port_unoffload(brport_dev, dp,
-					&dsa_slave_switchdev_notifier,
-					&dsa_slave_switchdev_blocking_notifier);
+					&dsa_user_switchdev_notifier,
+					&dsa_user_switchdev_blocking_notifier);
 
 	dsa_flush_workqueue();
 }
@@ -741,10 +741,10 @@ static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
 	 */
 	if (vlan_filtering && dsa_port_is_user(dp)) {
 		struct net_device *br = dsa_port_bridge_dev_get(dp);
-		struct net_device *upper_dev, *slave = dp->slave;
+		struct net_device *upper_dev, *user = dp->user;
 		struct list_head *iter;
 
-		netdev_for_each_upper_dev_rcu(slave, upper_dev, iter) {
+		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
 			struct bridge_vlan_info br_info;
 			u16 vid;
 
@@ -803,9 +803,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 	if (!ds->ops->port_vlan_filtering)
 		return -EOPNOTSUPP;
 
-	/* We are called from dsa_slave_switchdev_blocking_event(),
+	/* We are called from dsa_user_switchdev_blocking_event(),
 	 * which is not under rcu_read_lock(), unlike
-	 * dsa_slave_switchdev_event().
+	 * dsa_user_switchdev_event().
 	 */
 	rcu_read_lock();
 	apply = dsa_port_can_apply_vlan_filtering(dp, vlan_filtering, extack);
@@ -827,24 +827,24 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 		ds->vlan_filtering = vlan_filtering;
 
 		dsa_switch_for_each_user_port(other_dp, ds) {
-			struct net_device *slave = other_dp->slave;
+			struct net_device *user = other_dp->user;
 
 			/* We might be called in the unbind path, so not
-			 * all slave devices might still be registered.
+			 * all user devices might still be registered.
 			 */
-			if (!slave)
+			if (!user)
 				continue;
 
-			err = dsa_slave_manage_vlan_filtering(slave,
-							      vlan_filtering);
+			err = dsa_user_manage_vlan_filtering(user,
+							     vlan_filtering);
 			if (err)
 				goto restore;
 		}
 	} else {
 		dp->vlan_filtering = vlan_filtering;
 
-		err = dsa_slave_manage_vlan_filtering(dp->slave,
-						      vlan_filtering);
+		err = dsa_user_manage_vlan_filtering(dp->user,
+						     vlan_filtering);
 		if (err)
 			goto restore;
 	}
@@ -863,7 +863,7 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 }
 
 /* This enforces legacy behavior for switch drivers which assume they can't
- * receive VLAN configuration when enslaved to a bridge with vlan_filtering=0
+ * receive VLAN configuration when enuserd to a bridge with vlan_filtering=0
  */
 bool dsa_port_skip_vlan_configuration(struct dsa_port *dp)
 {
@@ -1047,7 +1047,7 @@ int dsa_port_standalone_host_fdb_add(struct dsa_port *dp,
 int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
 				 const unsigned char *addr, u16 vid)
 {
-	struct net_device *master = dsa_port_to_master(dp);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
 		.bridge = *dp->bridge,
@@ -1057,12 +1057,12 @@ int dsa_port_bridge_host_fdb_add(struct dsa_port *dp,
 	if (!dp->ds->fdb_isolation)
 		db.bridge.num = 0;
 
-	/* Avoid a call to __dev_set_promiscuity() on the master, which
+	/* Avoid a call to __dev_set_promiscuity() on the conduit, which
 	 * requires rtnl_lock(), since we can't guarantee that is held here,
 	 * and we can't take it either.
 	 */
-	if (master->priv_flags & IFF_UNICAST_FLT) {
-		err = dev_uc_add(master, addr);
+	if (conduit->priv_flags & IFF_UNICAST_FLT) {
+		err = dev_uc_add(conduit, addr);
 		if (err)
 			return err;
 	}
@@ -1098,7 +1098,7 @@ int dsa_port_standalone_host_fdb_del(struct dsa_port *dp,
 int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 				 const unsigned char *addr, u16 vid)
 {
-	struct net_device *master = dsa_port_to_master(dp);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
 		.bridge = *dp->bridge,
@@ -1108,8 +1108,8 @@ int dsa_port_bridge_host_fdb_del(struct dsa_port *dp,
 	if (!dp->ds->fdb_isolation)
 		db.bridge.num = 0;
 
-	if (master->priv_flags & IFF_UNICAST_FLT) {
-		err = dev_uc_del(master, addr);
+	if (conduit->priv_flags & IFF_UNICAST_FLT) {
+		err = dev_uc_del(conduit, addr);
 		if (err)
 			return err;
 	}
@@ -1229,7 +1229,7 @@ int dsa_port_standalone_host_mdb_add(const struct dsa_port *dp,
 int dsa_port_bridge_host_mdb_add(const struct dsa_port *dp,
 				 const struct switchdev_obj_port_mdb *mdb)
 {
-	struct net_device *master = dsa_port_to_master(dp);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
 		.bridge = *dp->bridge,
@@ -1239,7 +1239,7 @@ int dsa_port_bridge_host_mdb_add(const struct dsa_port *dp,
 	if (!dp->ds->fdb_isolation)
 		db.bridge.num = 0;
 
-	err = dev_mc_add(master, mdb->addr);
+	err = dev_mc_add(conduit, mdb->addr);
 	if (err)
 		return err;
 
@@ -1273,7 +1273,7 @@ int dsa_port_standalone_host_mdb_del(const struct dsa_port *dp,
 int dsa_port_bridge_host_mdb_del(const struct dsa_port *dp,
 				 const struct switchdev_obj_port_mdb *mdb)
 {
-	struct net_device *master = dsa_port_to_master(dp);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_db db = {
 		.type = DSA_DB_BRIDGE,
 		.bridge = *dp->bridge,
@@ -1283,7 +1283,7 @@ int dsa_port_bridge_host_mdb_del(const struct dsa_port *dp,
 	if (!dp->ds->fdb_isolation)
 		db.bridge.num = 0;
 
-	err = dev_mc_del(master, mdb->addr);
+	err = dev_mc_del(conduit, mdb->addr);
 	if (err)
 		return err;
 
@@ -1318,7 +1318,7 @@ int dsa_port_host_vlan_add(struct dsa_port *dp,
 			   const struct switchdev_obj_port_vlan *vlan,
 			   struct netlink_ext_ack *extack)
 {
-	struct net_device *master = dsa_port_to_master(dp);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_notifier_vlan_info info = {
 		.dp = dp,
 		.vlan = vlan,
@@ -1330,7 +1330,7 @@ int dsa_port_host_vlan_add(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	vlan_vid_add(master, htons(ETH_P_8021Q), vlan->vid);
+	vlan_vid_add(conduit, htons(ETH_P_8021Q), vlan->vid);
 
 	return err;
 }
@@ -1338,7 +1338,7 @@ int dsa_port_host_vlan_add(struct dsa_port *dp,
 int dsa_port_host_vlan_del(struct dsa_port *dp,
 			   const struct switchdev_obj_port_vlan *vlan)
 {
-	struct net_device *master = dsa_port_to_master(dp);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_notifier_vlan_info info = {
 		.dp = dp,
 		.vlan = vlan,
@@ -1349,7 +1349,7 @@ int dsa_port_host_vlan_del(struct dsa_port *dp,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	vlan_vid_del(master, htons(ETH_P_8021Q), vlan->vid);
+	vlan_vid_del(conduit, htons(ETH_P_8021Q), vlan->vid);
 
 	return err;
 }
@@ -1398,24 +1398,24 @@ int dsa_port_mrp_del_ring_role(const struct dsa_port *dp,
 	return ds->ops->port_mrp_del_ring_role(ds, dp->index, mrp);
 }
 
-static int dsa_port_assign_master(struct dsa_port *dp,
-				  struct net_device *master,
-				  struct netlink_ext_ack *extack,
-				  bool fail_on_err)
+static int dsa_port_assign_conduit(struct dsa_port *dp,
+				   struct net_device *conduit,
+				   struct netlink_ext_ack *extack,
+				   bool fail_on_err)
 {
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index, err;
 
-	err = ds->ops->port_change_master(ds, port, master, extack);
+	err = ds->ops->port_change_conduit(ds, port, conduit, extack);
 	if (err && !fail_on_err)
-		dev_err(ds->dev, "port %d failed to assign master %s: %pe\n",
-			port, master->name, ERR_PTR(err));
+		dev_err(ds->dev, "port %d failed to assign conduit %s: %pe\n",
+			port, conduit->name, ERR_PTR(err));
 
 	if (err && fail_on_err)
 		return err;
 
-	dp->cpu_dp = master->dsa_ptr;
-	dp->cpu_port_in_lag = netif_is_lag_master(master);
+	dp->cpu_dp = conduit->dsa_ptr;
+	dp->cpu_port_in_lag = netif_is_lag_master(conduit);
 
 	return 0;
 }
@@ -1428,12 +1428,12 @@ static int dsa_port_assign_master(struct dsa_port *dp,
  * the old CPU port before changing it, and restore it on errors during the
  * bringup of the new one.
  */
-int dsa_port_change_master(struct dsa_port *dp, struct net_device *master,
-			   struct netlink_ext_ack *extack)
+int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
+			    struct netlink_ext_ack *extack)
 {
 	struct net_device *bridge_dev = dsa_port_bridge_dev_get(dp);
-	struct net_device *old_master = dsa_port_to_master(dp);
-	struct net_device *dev = dp->slave;
+	struct net_device *old_conduit = dsa_port_to_conduit(dp);
+	struct net_device *dev = dp->user;
 	struct dsa_switch *ds = dp->ds;
 	bool vlan_filtering;
 	int err, tmp;
@@ -1454,7 +1454,7 @@ int dsa_port_change_master(struct dsa_port *dp, struct net_device *master,
 	 */
 	vlan_filtering = dsa_port_is_vlan_filtering(dp);
 	if (vlan_filtering) {
-		err = dsa_slave_manage_vlan_filtering(dev, false);
+		err = dsa_user_manage_vlan_filtering(dev, false);
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Failed to remove standalone VLANs");
@@ -1465,16 +1465,16 @@ int dsa_port_change_master(struct dsa_port *dp, struct net_device *master,
 	/* Standalone addresses, and addresses of upper interfaces like
 	 * VLAN, LAG, HSR need to be migrated.
 	 */
-	dsa_slave_unsync_ha(dev);
+	dsa_user_unsync_ha(dev);
 
-	err = dsa_port_assign_master(dp, master, extack, true);
+	err = dsa_port_assign_conduit(dp, conduit, extack, true);
 	if (err)
 		goto rewind_old_addrs;
 
-	dsa_slave_sync_ha(dev);
+	dsa_user_sync_ha(dev);
 
 	if (vlan_filtering) {
-		err = dsa_slave_manage_vlan_filtering(dev, true);
+		err = dsa_user_manage_vlan_filtering(dev, true);
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Failed to restore standalone VLANs");
@@ -1495,19 +1495,19 @@ int dsa_port_change_master(struct dsa_port *dp, struct net_device *master,
 
 rewind_new_vlan:
 	if (vlan_filtering)
-		dsa_slave_manage_vlan_filtering(dev, false);
+		dsa_user_manage_vlan_filtering(dev, false);
 
 rewind_new_addrs:
-	dsa_slave_unsync_ha(dev);
+	dsa_user_unsync_ha(dev);
 
-	dsa_port_assign_master(dp, old_master, NULL, false);
+	dsa_port_assign_conduit(dp, old_conduit, NULL, false);
 
 /* Restore the objects on the old CPU port */
 rewind_old_addrs:
-	dsa_slave_sync_ha(dev);
+	dsa_user_sync_ha(dev);
 
 	if (vlan_filtering) {
-		tmp = dsa_slave_manage_vlan_filtering(dev, true);
+		tmp = dsa_user_manage_vlan_filtering(dev, true);
 		if (tmp) {
 			dev_err(ds->dev,
 				"port %d failed to restore standalone VLANs: %pe\n",
@@ -1620,7 +1620,7 @@ static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
 	struct dsa_switch *ds = dp->ds;
 
 	if (dsa_port_is_user(dp))
-		phydev = dp->slave->phydev;
+		phydev = dp->user->phydev;
 
 	if (!ds->ops->phylink_mac_link_down) {
 		if (ds->ops->adjust_link && phydev)
@@ -1808,7 +1808,7 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
  * their type.
  *
  * User ports with no phy-handle or fixed-link are expected to connect to an
- * internal PHY located on the ds->slave_mii_bus at an MDIO address equal to
+ * internal PHY located on the ds->user_mii_bus at an MDIO address equal to
  * the port number. This description is still actively supported.
  *
  * Shared (CPU and DSA) ports with no phy-handle or fixed-link are expected to
@@ -1829,7 +1829,7 @@ static int dsa_shared_port_phylink_register(struct dsa_port *dp)
  * a fixed-link, a phy-handle, or a managed = "in-band-status" property.
  * It becomes the responsibility of the driver to ensure that these ports
  * operate at the maximum speed (whatever this means) and will interoperate
- * with the DSA master or other cascade port, since phylink methods will not be
+ * with the DSA conduit or other cascade port, since phylink methods will not be
  * invoked for them.
  *
  * If you are considering expanding this table for newly introduced switches,
diff --git a/net/dsa/port.h b/net/dsa/port.h
index 334879964e2c..6bc3291573c0 100644
--- a/net/dsa/port.h
+++ b/net/dsa/port.h
@@ -109,7 +109,7 @@ void dsa_port_hsr_leave(struct dsa_port *dp, struct net_device *hsr);
 int dsa_port_tag_8021q_vlan_add(struct dsa_port *dp, u16 vid, bool broadcast);
 void dsa_port_tag_8021q_vlan_del(struct dsa_port *dp, u16 vid, bool broadcast);
 void dsa_port_set_host_flood(struct dsa_port *dp, bool uc, bool mc);
-int dsa_port_change_master(struct dsa_port *dp, struct net_device *master,
-			   struct netlink_ext_ack *extack);
+int dsa_port_change_conduit(struct dsa_port *dp, struct net_device *conduit,
+			    struct netlink_ext_ack *extack);
 
 #endif
diff --git a/net/dsa/slave.h b/net/dsa/slave.h
deleted file mode 100644
index d0abe609e00d..000000000000
--- a/net/dsa/slave.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#ifndef __DSA_SLAVE_H
-#define __DSA_SLAVE_H
-
-#include <linux/if_bridge.h>
-#include <linux/if_vlan.h>
-#include <linux/list.h>
-#include <linux/netpoll.h>
-#include <linux/types.h>
-#include <net/dsa.h>
-#include <net/gro_cells.h>
-
-struct net_device;
-struct netlink_ext_ack;
-
-extern struct notifier_block dsa_slave_switchdev_notifier;
-extern struct notifier_block dsa_slave_switchdev_blocking_notifier;
-
-struct dsa_slave_priv {
-	/* Copy of CPU port xmit for faster access in slave transmit hot path */
-	struct sk_buff *	(*xmit)(struct sk_buff *skb,
-					struct net_device *dev);
-
-	struct gro_cells	gcells;
-
-	/* DSA port data, such as switch, port index, etc. */
-	struct dsa_port		*dp;
-
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	struct netpoll		*netpoll;
-#endif
-
-	/* TC context */
-	struct list_head	mall_tc_list;
-};
-
-void dsa_slave_mii_bus_init(struct dsa_switch *ds);
-int dsa_slave_create(struct dsa_port *dp);
-void dsa_slave_destroy(struct net_device *slave_dev);
-int dsa_slave_suspend(struct net_device *slave_dev);
-int dsa_slave_resume(struct net_device *slave_dev);
-int dsa_slave_register_notifier(void);
-void dsa_slave_unregister_notifier(void);
-void dsa_slave_sync_ha(struct net_device *dev);
-void dsa_slave_unsync_ha(struct net_device *dev);
-void dsa_slave_setup_tagger(struct net_device *slave);
-int dsa_slave_change_mtu(struct net_device *dev, int new_mtu);
-int dsa_slave_change_master(struct net_device *dev, struct net_device *master,
-			    struct netlink_ext_ack *extack);
-int dsa_slave_manage_vlan_filtering(struct net_device *dev,
-				    bool vlan_filtering);
-
-static inline struct dsa_port *dsa_slave_to_port(const struct net_device *dev)
-{
-	struct dsa_slave_priv *p = netdev_priv(dev);
-
-	return p->dp;
-}
-
-static inline struct net_device *
-dsa_slave_to_master(const struct net_device *dev)
-{
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-
-	return dsa_port_to_master(dp);
-}
-
-#endif
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 1a42f9317334..308e3d589934 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -15,10 +15,10 @@
 #include "dsa.h"
 #include "netlink.h"
 #include "port.h"
-#include "slave.h"
 #include "switch.h"
 #include "tag_8021q.h"
 #include "trace.h"
+#include "user.h"
 
 static unsigned int dsa_switch_fastest_ageing_time(struct dsa_switch *ds,
 						   unsigned int ageing_time)
@@ -894,12 +894,12 @@ static int dsa_switch_change_tag_proto(struct dsa_switch *ds,
 	 * bits that depend on the tagger, such as the MTU.
 	 */
 	dsa_switch_for_each_user_port(dp, ds) {
-		struct net_device *slave = dp->slave;
+		struct net_device *user = dp->user;
 
-		dsa_slave_setup_tagger(slave);
+		dsa_user_setup_tagger(user);
 
 		/* rtnl_mutex is held in dsa_tree_change_tag_proto */
-		dsa_slave_change_mtu(slave, slave->mtu);
+		dsa_user_change_mtu(user, user->mtu);
 	}
 
 	return 0;
@@ -960,13 +960,13 @@ dsa_switch_disconnect_tag_proto(struct dsa_switch *ds,
 }
 
 static int
-dsa_switch_master_state_change(struct dsa_switch *ds,
-			       struct dsa_notifier_master_state_info *info)
+dsa_switch_conduit_state_change(struct dsa_switch *ds,
+				struct dsa_notifier_conduit_state_info *info)
 {
-	if (!ds->ops->master_state_change)
+	if (!ds->ops->conduit_state_change)
 		return 0;
 
-	ds->ops->master_state_change(ds, info->master, info->operational);
+	ds->ops->conduit_state_change(ds, info->conduit, info->operational);
 
 	return 0;
 }
@@ -1057,7 +1057,7 @@ static int dsa_switch_event(struct notifier_block *nb,
 		err = dsa_switch_tag_8021q_vlan_del(ds, info);
 		break;
 	case DSA_NOTIFIER_MASTER_STATE_CHANGE:
-		err = dsa_switch_master_state_change(ds, info);
+		err = dsa_switch_conduit_state_change(ds, info);
 		break;
 	default:
 		err = -EOPNOTSUPP;
diff --git a/net/dsa/switch.h b/net/dsa/switch.h
index ea034677da15..4a9cc941b340 100644
--- a/net/dsa/switch.h
+++ b/net/dsa/switch.h
@@ -106,8 +106,8 @@ struct dsa_notifier_tag_8021q_vlan_info {
 };
 
 /* DSA_NOTIFIER_MASTER_STATE_CHANGE */
-struct dsa_notifier_master_state_info {
-	const struct net_device *master;
+struct dsa_notifier_conduit_state_info {
+	const struct net_device *conduit;
 	bool operational;
 };
 
diff --git a/net/dsa/tag.c b/net/dsa/tag.c
index 5105a5ff58fa..6e402d49afd3 100644
--- a/net/dsa/tag.c
+++ b/net/dsa/tag.c
@@ -13,8 +13,8 @@
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 
-#include "slave.h"
 #include "tag.h"
+#include "user.h"
 
 static LIST_HEAD(dsa_tag_drivers_list);
 static DEFINE_MUTEX(dsa_tag_drivers_lock);
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(dsa_tag_drivers_lock);
  * switch, the DSA driver owning the interface to which the packet is
  * delivered is never notified unless we do so here.
  */
-static bool dsa_skb_defer_rx_timestamp(struct dsa_slave_priv *p,
+static bool dsa_skb_defer_rx_timestamp(struct dsa_user_priv *p,
 				       struct sk_buff *skb)
 {
 	struct dsa_switch *ds = p->dp->ds;
@@ -57,7 +57,7 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	struct sk_buff *nskb = NULL;
-	struct dsa_slave_priv *p;
+	struct dsa_user_priv *p;
 
 	if (unlikely(!cpu_dp)) {
 		kfree_skb(skb);
@@ -75,7 +75,7 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 		if (!skb_has_extensions(skb))
 			skb->slow_gro = 0;
 
-		skb->dev = dsa_master_find_slave(dev, 0, port);
+		skb->dev = dsa_conduit_find_user(dev, 0, port);
 		if (likely(skb->dev)) {
 			dsa_default_offload_fwd_mark(skb);
 			nskb = skb;
@@ -94,7 +94,7 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 	skb->pkt_type = PACKET_HOST;
 	skb->protocol = eth_type_trans(skb, skb->dev);
 
-	if (unlikely(!dsa_slave_dev_check(skb->dev))) {
+	if (unlikely(!dsa_user_dev_check(skb->dev))) {
 		/* Packet is to be injected directly on an upper
 		 * device, e.g. a team/bond, so skip all DSA-port
 		 * specific actions.
diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index 32d12f4a9d73..f6b9c73718df 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -9,7 +9,7 @@
 #include <net/dsa.h>
 
 #include "port.h"
-#include "slave.h"
+#include "user.h"
 
 struct dsa_tag_driver {
 	const struct dsa_device_ops *ops;
@@ -29,7 +29,7 @@ static inline int dsa_tag_protocol_overhead(const struct dsa_device_ops *ops)
 	return ops->needed_headroom + ops->needed_tailroom;
 }
 
-static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
+static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
 						       int device, int port)
 {
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
@@ -39,7 +39,7 @@ static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
 	list_for_each_entry(dp, &dst->ports, list)
 		if (dp->ds->index == device && dp->index == port &&
 		    dp->type == DSA_PORT_TYPE_USER)
-			return dp->slave;
+			return dp->user;
 
 	return NULL;
 }
@@ -49,7 +49,7 @@ static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
  */
 static inline struct sk_buff *dsa_untag_bridge_pvid(struct sk_buff *skb)
 {
-	struct dsa_port *dp = dsa_slave_to_port(skb->dev);
+	struct dsa_port *dp = dsa_user_to_port(skb->dev);
 	struct net_device *br = dsa_port_bridge_dev_get(dp);
 	struct net_device *dev = skb->dev;
 	struct net_device *upper_dev;
@@ -107,12 +107,12 @@ static inline struct sk_buff *dsa_untag_bridge_pvid(struct sk_buff *skb)
  * to support termination through the bridge.
  */
 static inline struct net_device *
-dsa_find_designated_bridge_port_by_vid(struct net_device *master, u16 vid)
+dsa_find_designated_bridge_port_by_vid(struct net_device *conduit, u16 vid)
 {
-	struct dsa_port *cpu_dp = master->dsa_ptr;
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct bridge_vlan_info vinfo;
-	struct net_device *slave;
+	struct net_device *user;
 	struct dsa_port *dp;
 	int err;
 
@@ -134,13 +134,13 @@ dsa_find_designated_bridge_port_by_vid(struct net_device *master, u16 vid)
 		if (dp->cpu_dp != cpu_dp)
 			continue;
 
-		slave = dp->slave;
+		user = dp->user;
 
-		err = br_vlan_get_info_rcu(slave, vid, &vinfo);
+		err = br_vlan_get_info_rcu(user, vid, &vinfo);
 		if (err)
 			continue;
 
-		return slave;
+		return user;
 	}
 
 	return NULL;
@@ -155,7 +155,7 @@ dsa_find_designated_bridge_port_by_vid(struct net_device *master, u16 vid)
  */
 static inline void dsa_default_offload_fwd_mark(struct sk_buff *skb)
 {
-	struct dsa_port *dp = dsa_slave_to_port(skb->dev);
+	struct dsa_port *dp = dsa_user_to_port(skb->dev);
 
 	skb->offload_fwd_mark = !!(dp->bridge);
 }
@@ -215,9 +215,9 @@ static inline void dsa_alloc_etype_header(struct sk_buff *skb, int len)
 	memmove(skb->data, skb->data + len, 2 * ETH_ALEN);
 }
 
-/* On RX, eth_type_trans() on the DSA master pulls ETH_HLEN bytes starting from
+/* On RX, eth_type_trans() on the DSA conduit pulls ETH_HLEN bytes starting from
  * skb_mac_header(skb), which leaves skb->data pointing at the first byte after
- * what the DSA master perceives as the EtherType (the beginning of the L3
+ * what the DSA conduit perceives as the EtherType (the beginning of the L3
  * protocol). Since DSA EtherType header taggers treat the EtherType as part of
  * the DSA tag itself, and the EtherType is 2 bytes in length, the DSA header
  * is located 2 bytes behind skb->data. Note that EtherType in this context
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index cbdfc392f7e0..71b26ae6db39 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -73,7 +73,7 @@ struct dsa_tag_8021q_vlan {
 struct dsa_8021q_context {
 	struct dsa_switch *ds;
 	struct list_head vlans;
-	/* EtherType of RX VID, used for filtering on master interface */
+	/* EtherType of RX VID, used for filtering on conduit interface */
 	__be16 proto;
 };
 
@@ -338,7 +338,7 @@ static int dsa_tag_8021q_port_setup(struct dsa_switch *ds, int port)
 	struct dsa_8021q_context *ctx = ds->tag_8021q_ctx;
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	u16 vid = dsa_tag_8021q_standalone_vid(dp);
-	struct net_device *master;
+	struct net_device *conduit;
 	int err;
 
 	/* The CPU port is implicitly configured by
@@ -347,7 +347,7 @@ static int dsa_tag_8021q_port_setup(struct dsa_switch *ds, int port)
 	if (!dsa_port_is_user(dp))
 		return 0;
 
-	master = dsa_port_to_master(dp);
+	conduit = dsa_port_to_conduit(dp);
 
 	err = dsa_port_tag_8021q_vlan_add(dp, vid, false);
 	if (err) {
@@ -357,8 +357,8 @@ static int dsa_tag_8021q_port_setup(struct dsa_switch *ds, int port)
 		return err;
 	}
 
-	/* Add the VLAN to the master's RX filter. */
-	vlan_vid_add(master, ctx->proto, vid);
+	/* Add the VLAN to the conduit's RX filter. */
+	vlan_vid_add(conduit, ctx->proto, vid);
 
 	return err;
 }
@@ -368,7 +368,7 @@ static void dsa_tag_8021q_port_teardown(struct dsa_switch *ds, int port)
 	struct dsa_8021q_context *ctx = ds->tag_8021q_ctx;
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	u16 vid = dsa_tag_8021q_standalone_vid(dp);
-	struct net_device *master;
+	struct net_device *conduit;
 
 	/* The CPU port is implicitly configured by
 	 * configuring the front-panel ports
@@ -376,11 +376,11 @@ static void dsa_tag_8021q_port_teardown(struct dsa_switch *ds, int port)
 	if (!dsa_port_is_user(dp))
 		return;
 
-	master = dsa_port_to_master(dp);
+	conduit = dsa_port_to_conduit(dp);
 
 	dsa_port_tag_8021q_vlan_del(dp, vid, false);
 
-	vlan_vid_del(master, ctx->proto, vid);
+	vlan_vid_del(conduit, ctx->proto, vid);
 }
 
 static int dsa_tag_8021q_setup(struct dsa_switch *ds)
@@ -468,10 +468,10 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 }
 EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
+struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 						   int vbid)
 {
-	struct dsa_port *cpu_dp = master->dsa_ptr;
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct dsa_port *dp;
 
@@ -490,7 +490,7 @@ struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
 			continue;
 
 		if (dsa_port_bridge_num_get(dp) == vbid)
-			return dp->slave;
+			return dp->user;
 	}
 
 	return NULL;
diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
index b75cbaa028ef..41f7167ac520 100644
--- a/net/dsa/tag_8021q.h
+++ b/net/dsa/tag_8021q.h
@@ -16,7 +16,7 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		   int *vbid);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
+struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 						   int vbid);
 
 int dsa_switch_tag_8021q_vlan_add(struct dsa_switch *ds,
diff --git a/net/dsa/tag_ar9331.c b/net/dsa/tag_ar9331.c
index 7f3b7d730b85..92ce67b93a58 100644
--- a/net/dsa/tag_ar9331.c
+++ b/net/dsa/tag_ar9331.c
@@ -29,7 +29,7 @@
 static struct sk_buff *ar9331_tag_xmit(struct sk_buff *skb,
 				       struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	__le16 *phdr;
 	u16 hdr;
 
@@ -74,7 +74,7 @@ static struct sk_buff *ar9331_tag_rcv(struct sk_buff *skb,
 	/* Get source port information */
 	port = FIELD_GET(AR9331_HDR_PORT_NUM_MASK, hdr);
 
-	skb->dev = dsa_master_find_slave(ndev, 0, port);
+	skb->dev = dsa_conduit_find_user(ndev, 0, port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index cacdafb41200..83d283a5d27e 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -85,7 +85,7 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
 					struct net_device *dev,
 					unsigned int offset)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	u16 queue = skb_get_queue_mapping(skb);
 	u8 *brcm_tag;
 
@@ -96,7 +96,7 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
 	 * (including FCS and tag) because the length verification is done after
 	 * the Broadcom tag is stripped off the ingress packet.
 	 *
-	 * Let dsa_slave_xmit() free the SKB
+	 * Let dsa_user_xmit() free the SKB
 	 */
 	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_TAG_LEN, false))
 		return NULL;
@@ -119,7 +119,7 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff *skb,
 		brcm_tag[2] = BRCM_IG_DSTMAP2_MASK;
 	brcm_tag[3] = (1 << dp->index) & BRCM_IG_DSTMAP1_MASK;
 
-	/* Now tell the master network device about the desired output queue
+	/* Now tell the conduit network device about the desired output queue
 	 * as well
 	 */
 	skb_set_queue_mapping(skb, BRCM_TAG_SET_PORT_QUEUE(dp->index, queue));
@@ -164,7 +164,7 @@ static struct sk_buff *brcm_tag_rcv_ll(struct sk_buff *skb,
 	/* Locate which port this is coming from */
 	source_port = brcm_tag[3] & BRCM_EG_PID_MASK;
 
-	skb->dev = dsa_master_find_slave(dev, 0, source_port);
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
 	if (!skb->dev)
 		return NULL;
 
@@ -216,7 +216,7 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM, BRCM_NAME);
 static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *brcm_tag;
 
 	/* The Ethernet switch we are interfaced with needs packets to be at
@@ -226,7 +226,7 @@ static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 	 * (including FCS and tag) because the length verification is done after
 	 * the Broadcom tag is stripped off the ingress packet.
 	 *
-	 * Let dsa_slave_xmit() free the SKB
+	 * Let dsa_user_xmit() free the SKB
 	 */
 	if (__skb_put_padto(skb, ETH_ZLEN + BRCM_LEG_TAG_LEN, false))
 		return NULL;
@@ -264,7 +264,7 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 
 	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
 
-	skb->dev = dsa_master_find_slave(dev, 0, source_port);
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index 1fd7fa26db64..8ed52dd663ab 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -129,7 +129,7 @@ enum dsa_code {
 static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 				   u8 extra)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct net_device *br_dev;
 	u8 tag_dev, tag_port;
 	enum dsa_cmd cmd;
@@ -267,14 +267,14 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 		lag = dsa_lag_by_id(cpu_dp->dst, source_port + 1);
 		skb->dev = lag ? lag->dev : NULL;
 	} else {
-		skb->dev = dsa_master_find_slave(dev, source_device,
+		skb->dev = dsa_conduit_find_user(dev, source_device,
 						 source_port);
 	}
 
 	if (!skb->dev)
 		return NULL;
 
-	/* When using LAG offload, skb->dev is not a DSA slave interface,
+	/* When using LAG offload, skb->dev is not a DSA user interface,
 	 * so we cannot call dsa_default_offload_fwd_mark and we need to
 	 * special-case it.
 	 */
diff --git a/net/dsa/tag_gswip.c b/net/dsa/tag_gswip.c
index e279cd9057b0..3539141b5350 100644
--- a/net/dsa/tag_gswip.c
+++ b/net/dsa/tag_gswip.c
@@ -61,7 +61,7 @@
 static struct sk_buff *gswip_tag_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *gswip_tag;
 
 	skb_push(skb, GSWIP_TX_HEADER_LEN);
@@ -89,7 +89,7 @@ static struct sk_buff *gswip_tag_rcv(struct sk_buff *skb,
 
 	/* Get source port information */
 	port = (gswip_tag[7] & GSWIP_RX_SPPID_MASK) >> GSWIP_RX_SPPID_SHIFT;
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/tag_hellcreek.c b/net/dsa/tag_hellcreek.c
index 03a1fb9c87a9..6e233cd0aa38 100644
--- a/net/dsa/tag_hellcreek.c
+++ b/net/dsa/tag_hellcreek.c
@@ -20,7 +20,7 @@
 static struct sk_buff *hellcreek_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *tag;
 
 	/* Calculate checksums (if required) before adding the trailer tag to
@@ -45,7 +45,7 @@ static struct sk_buff *hellcreek_rcv(struct sk_buff *skb,
 	u8 *tag = skb_tail_pointer(skb) - HELLCREEK_TAG_LEN;
 	unsigned int port = tag[0] & 0x03;
 
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev) {
 		netdev_warn_once(dev, "Failed to get source port: %d\n", port);
 		return NULL;
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 3632e47dea9e..9be341fa88f0 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -87,7 +87,7 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 				      struct net_device *dev,
 				      unsigned int port, unsigned int len)
 {
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev)
 		return NULL;
 
@@ -119,7 +119,7 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 
 static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct ethhdr *hdr;
 	u8 *tag;
 
@@ -256,7 +256,7 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
 		return NULL;
 
 	kthread_init_work(&xmit_work->work, xmit_work_fn);
-	/* Increase refcount so the kfree_skb in dsa_slave_xmit
+	/* Increase refcount so the kfree_skb in dsa_user_xmit
 	 * won't really free the packet.
 	 */
 	xmit_work->dp = dp;
@@ -272,7 +272,7 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 {
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct ethhdr *hdr;
 	__be16 *tag;
 	u16 val;
@@ -344,7 +344,7 @@ static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
 {
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct ethhdr *hdr;
 	u8 *tag;
 
@@ -410,7 +410,7 @@ static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
 {
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	const struct ethhdr *hdr = eth_hdr(skb);
 	__be16 *tag;
 	u16 val;
diff --git a/net/dsa/tag_lan9303.c b/net/dsa/tag_lan9303.c
index c25f5536706b..1ed8ee24855d 100644
--- a/net/dsa/tag_lan9303.c
+++ b/net/dsa/tag_lan9303.c
@@ -56,7 +56,7 @@ static int lan9303_xmit_use_arl(struct dsa_port *dp, u8 *dest_addr)
 
 static struct sk_buff *lan9303_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 *lan9303_tag;
 	u16 tag;
 
@@ -99,7 +99,7 @@ static struct sk_buff *lan9303_rcv(struct sk_buff *skb, struct net_device *dev)
 
 	source_port = lan9303_tag1 & 0x3;
 
-	skb->dev = dsa_master_find_slave(dev, 0, source_port);
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
 	if (!skb->dev) {
 		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
 		return NULL;
diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index 40af80452747..2483785f6ab1 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -23,7 +23,7 @@
 static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 xmit_tpid;
 	u8 *mtk_tag;
 
@@ -85,7 +85,7 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	/* Get source port information */
 	port = (hdr & MTK_HDR_RECV_SOURCE_PORT_MASK);
 
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/tag_none.c b/net/dsa/tag_none.c
index d2fd179c4227..9a473624db50 100644
--- a/net/dsa/tag_none.c
+++ b/net/dsa/tag_none.c
@@ -12,8 +12,8 @@
 
 #define NONE_NAME	"none"
 
-static struct sk_buff *dsa_slave_notag_xmit(struct sk_buff *skb,
-					    struct net_device *dev)
+static struct sk_buff *dsa_user_notag_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
 {
 	/* Just return the original SKB */
 	return skb;
@@ -22,7 +22,7 @@ static struct sk_buff *dsa_slave_notag_xmit(struct sk_buff *skb,
 static const struct dsa_device_ops none_ops = {
 	.name	= NONE_NAME,
 	.proto	= DSA_TAG_PROTO_NONE,
-	.xmit	= dsa_slave_notag_xmit,
+	.xmit	= dsa_user_notag_xmit,
 };
 
 module_dsa_tag_driver(none_ops);
diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index 20bf7074d5a6..ef2f8fffb2c7 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -45,7 +45,7 @@ static void ocelot_xmit_get_vlan_info(struct sk_buff *skb, struct dsa_port *dp,
 static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 			       __be32 ifh_prefix, void **ifh)
 {
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	struct dsa_switch *ds = dp->ds;
 	u64 vlan_tci, tag_type;
 	void *injection;
@@ -79,7 +79,7 @@ static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	void *injection;
 
 	ocelot_xmit_common(skb, netdev, cpu_to_be32(0x8880000a), &injection);
@@ -91,7 +91,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *seville_xmit(struct sk_buff *skb,
 				    struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	void *injection;
 
 	ocelot_xmit_common(skb, netdev, cpu_to_be32(0x88800005), &injection);
@@ -111,12 +111,12 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	u16 vlan_tpid;
 	u64 rew_val;
 
-	/* Revert skb->data by the amount consumed by the DSA master,
+	/* Revert skb->data by the amount consumed by the DSA conduit,
 	 * so it points to the beginning of the frame.
 	 */
 	skb_push(skb, ETH_HLEN);
 	/* We don't care about the short prefix, it is just for easy entrance
-	 * into the DSA master's RX filter. Discard it now by moving it into
+	 * into the DSA conduit's RX filter. Discard it now by moving it into
 	 * the headroom.
 	 */
 	skb_pull(skb, OCELOT_SHORT_PREFIX_LEN);
@@ -141,12 +141,12 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	ocelot_xfh_get_vlan_tci(extraction, &vlan_tci);
 	ocelot_xfh_get_rew_val(extraction, &rew_val);
 
-	skb->dev = dsa_master_find_slave(netdev, 0, src_port);
+	skb->dev = dsa_conduit_find_user(netdev, 0, src_port);
 	if (!skb->dev)
 		/* The switch will reflect back some frames sent through
-		 * sockets opened on the bare DSA master. These will come back
+		 * sockets opened on the bare DSA conduit. These will come back
 		 * with src_port equal to the index of the CPU port, for which
-		 * there is no slave registered. So don't print any error
+		 * there is no user registered. So don't print any error
 		 * message here (ignore and drop those frames).
 		 */
 		return NULL;
@@ -170,7 +170,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	 * equal to the pvid of the ingress port and should not be used for
 	 * processing.
 	 */
-	dp = dsa_slave_to_port(skb->dev);
+	dp = dsa_user_to_port(skb->dev);
 	vlan_tpid = tag_type ? ETH_P_8021AD : ETH_P_8021Q;
 
 	if (dsa_port_is_vlan_filtering(dp) &&
@@ -192,7 +192,7 @@ static const struct dsa_device_ops ocelot_netdev_ops = {
 	.xmit			= ocelot_xmit,
 	.rcv			= ocelot_rcv,
 	.needed_headroom	= OCELOT_TOTAL_TAG_LEN,
-	.promisc_on_master	= true,
+	.promisc_on_conduit	= true,
 };
 
 DSA_TAG_DRIVER(ocelot_netdev_ops);
@@ -204,7 +204,7 @@ static const struct dsa_device_ops seville_netdev_ops = {
 	.xmit			= seville_xmit,
 	.rcv			= ocelot_rcv,
 	.needed_headroom	= OCELOT_TOTAL_TAG_LEN,
-	.promisc_on_master	= true,
+	.promisc_on_conduit	= true,
 };
 
 DSA_TAG_DRIVER(seville_netdev_ops);
diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index 1f0b8c20eba5..210039320888 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -37,8 +37,8 @@ static struct sk_buff *ocelot_defer_xmit(struct dsa_port *dp,
 		return NULL;
 
 	/* PTP over IP packets need UDP checksumming. We may have inherited
-	 * NETIF_F_HW_CSUM from the DSA master, but these packets are not sent
-	 * through the DSA master, so calculate the checksum here.
+	 * NETIF_F_HW_CSUM from the DSA conduit, but these packets are not sent
+	 * through the DSA conduit, so calculate the checksum here.
 	 */
 	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
 		return NULL;
@@ -49,7 +49,7 @@ static struct sk_buff *ocelot_defer_xmit(struct dsa_port *dp,
 
 	/* Calls felix_port_deferred_xmit in felix.c */
 	kthread_init_work(&xmit_work->work, xmit_work_fn);
-	/* Increase refcount so the kfree_skb in dsa_slave_xmit
+	/* Increase refcount so the kfree_skb in dsa_user_xmit
 	 * won't really free the packet.
 	 */
 	xmit_work->dp = dp;
@@ -63,7 +63,7 @@ static struct sk_buff *ocelot_defer_xmit(struct dsa_port *dp,
 static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
@@ -83,7 +83,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL);
 
-	skb->dev = dsa_master_find_slave(netdev, switch_id, src_port);
+	skb->dev = dsa_conduit_find_user(netdev, switch_id, src_port);
 	if (!skb->dev)
 		return NULL;
 
@@ -130,7 +130,7 @@ static const struct dsa_device_ops ocelot_8021q_netdev_ops = {
 	.connect		= ocelot_connect,
 	.disconnect		= ocelot_disconnect,
 	.needed_headroom	= VLAN_HLEN,
-	.promisc_on_master	= true,
+	.promisc_on_conduit	= true,
 };
 
 MODULE_LICENSE("GPL v2");
diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index e5ff7c34e577..6514aa7993ce 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -14,7 +14,7 @@
 
 static struct sk_buff *qca_tag_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 *phdr;
 	u16 hdr;
 
@@ -78,7 +78,7 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	/* Get source port information */
 	port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, hdr);
 
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev)
 		return NULL;
 
@@ -116,7 +116,7 @@ static const struct dsa_device_ops qca_netdev_ops = {
 	.xmit	= qca_tag_xmit,
 	.rcv	= qca_tag_rcv,
 	.needed_headroom = QCA_HDR_LEN,
-	.promisc_on_master = true,
+	.promisc_on_conduit = true,
 };
 
 MODULE_LICENSE("GPL");
diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index c327314b95e3..4da5bad1a7aa 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -36,7 +36,7 @@
 static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 *p;
 	u8 *tag;
 	u16 out;
@@ -97,9 +97,9 @@ static struct sk_buff *rtl4a_tag_rcv(struct sk_buff *skb,
 	}
 	port = protport & 0xff;
 
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev) {
-		netdev_dbg(dev, "could not find slave for port %d\n", port);
+		netdev_dbg(dev, "could not find user for port %d\n", port);
 		return NULL;
 	}
 
diff --git a/net/dsa/tag_rtl8_4.c b/net/dsa/tag_rtl8_4.c
index 4f67834fd121..07e857debabf 100644
--- a/net/dsa/tag_rtl8_4.c
+++ b/net/dsa/tag_rtl8_4.c
@@ -103,7 +103,7 @@
 static void rtl8_4_write_tag(struct sk_buff *skb, struct net_device *dev,
 			     void *tag)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 tag16[RTL8_4_TAG_LEN / 2];
 
 	/* Set Realtek EtherType */
@@ -180,10 +180,10 @@ static int rtl8_4_read_tag(struct sk_buff *skb, struct net_device *dev,
 
 	/* Parse TX (switch->CPU) */
 	port = FIELD_GET(RTL8_4_TX, ntohs(tag16[3]));
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev) {
 		dev_warn_ratelimited(&dev->dev,
-				     "could not find slave for port %d\n",
+				     "could not find user for port %d\n",
 				     port);
 		return -ENOENT;
 	}
diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index 437a6820ac42..2ce866b45615 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -39,7 +39,7 @@ struct a5psw_tag {
 
 static struct sk_buff *a5psw_tag_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct a5psw_tag *ptag;
 	u32 data2_val;
 
@@ -90,7 +90,7 @@ static struct sk_buff *a5psw_tag_rcv(struct sk_buff *skb,
 
 	port = FIELD_GET(A5PSW_CTRL_DATA_PORT, ntohs(tag->ctrl_data));
 
-	skb->dev = dsa_master_find_slave(dev, 0, port);
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index ade3eeb2f3e6..1fffe8c2b589 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -157,7 +157,7 @@ static struct sk_buff *sja1105_defer_xmit(struct dsa_port *dp,
 		return NULL;
 
 	kthread_init_work(&xmit_work->work, xmit_work_fn);
-	/* Increase refcount so the kfree_skb in dsa_slave_xmit
+	/* Increase refcount so the kfree_skb in dsa_user_xmit
 	 * won't really free the packet.
 	 */
 	xmit_work->dp = dp;
@@ -210,7 +210,7 @@ static u16 sja1105_xmit_tpid(struct dsa_port *dp)
 static struct sk_buff *sja1105_imprecise_xmit(struct sk_buff *skb,
 					      struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	unsigned int bridge_num = dsa_port_bridge_num_get(dp);
 	struct net_device *br = dsa_port_bridge_dev_get(dp);
 	u16 tx_vid;
@@ -235,7 +235,7 @@ static struct sk_buff *sja1105_imprecise_xmit(struct sk_buff *skb,
 
 /* Transform untagged control packets into pvid-tagged control packets so that
  * all packets sent by this tagger are VLAN-tagged and we can configure the
- * switch to drop untagged packets coming from the DSA master.
+ * switch to drop untagged packets coming from the DSA conduit.
  */
 static struct sk_buff *sja1105_pvid_tag_control_pkt(struct dsa_port *dp,
 						    struct sk_buff *skb, u8 pcp)
@@ -266,7 +266,7 @@ static struct sk_buff *sja1105_pvid_tag_control_pkt(struct dsa_port *dp,
 static struct sk_buff *sja1105_xmit(struct sk_buff *skb,
 				    struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
@@ -294,7 +294,7 @@ static struct sk_buff *sja1110_xmit(struct sk_buff *skb,
 				    struct net_device *netdev)
 {
 	struct sk_buff *clone = SJA1105_SKB_CB(skb)->clone;
-	struct dsa_port *dp = dsa_slave_to_port(netdev);
+	struct dsa_port *dp = dsa_user_to_port(netdev);
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
@@ -383,7 +383,7 @@ static struct sk_buff
 	 * Buffer it until we get its meta frame.
 	 */
 	if (is_link_local) {
-		struct dsa_port *dp = dsa_slave_to_port(skb->dev);
+		struct dsa_port *dp = dsa_user_to_port(skb->dev);
 		struct sja1105_tagger_private *priv;
 		struct dsa_switch *ds = dp->ds;
 
@@ -396,7 +396,7 @@ static struct sk_buff
 		if (priv->stampable_skb) {
 			dev_err_ratelimited(ds->dev,
 					    "Expected meta frame, is %12llx "
-					    "in the DSA master multicast filter?\n",
+					    "in the DSA conduit multicast filter?\n",
 					    SJA1105_META_DMAC);
 			kfree_skb(priv->stampable_skb);
 		}
@@ -417,7 +417,7 @@ static struct sk_buff
 	 * frame, which serves no further purpose).
 	 */
 	} else if (is_meta) {
-		struct dsa_port *dp = dsa_slave_to_port(skb->dev);
+		struct dsa_port *dp = dsa_user_to_port(skb->dev);
 		struct sja1105_tagger_private *priv;
 		struct dsa_switch *ds = dp->ds;
 		struct sk_buff *stampable_skb;
@@ -550,7 +550,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	}
 
 	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
 	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
 	else
@@ -573,16 +573,16 @@ static struct sk_buff *sja1110_rcv_meta(struct sk_buff *skb, u16 rx_header)
 	int switch_id = SJA1110_RX_HEADER_SWITCH_ID(rx_header);
 	int n_ts = SJA1110_RX_HEADER_N_TS(rx_header);
 	struct sja1105_tagger_data *tagger_data;
-	struct net_device *master = skb->dev;
+	struct net_device *conduit = skb->dev;
 	struct dsa_port *cpu_dp;
 	struct dsa_switch *ds;
 	int i;
 
-	cpu_dp = master->dsa_ptr;
+	cpu_dp = conduit->dsa_ptr;
 	ds = dsa_switch_find(cpu_dp->dst->index, switch_id);
 	if (!ds) {
 		net_err_ratelimited("%s: cannot find switch id %d\n",
-				    master->name, switch_id);
+				    conduit->name, switch_id);
 		return NULL;
 	}
 
@@ -649,7 +649,7 @@ static struct sk_buff *sja1110_rcv_inband_control_extension(struct sk_buff *skb,
 
 		/* skb->len counts from skb->data, while start_of_padding
 		 * counts from the destination MAC address. Right now skb->data
-		 * is still as set by the DSA master, so to trim away the
+		 * is still as set by the DSA conduit, so to trim away the
 		 * padding and trailer we need to account for the fact that
 		 * skb->data points to skb_mac_header(skb) + ETH_HLEN.
 		 */
@@ -698,7 +698,7 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	else if (source_port == -1 || switch_id == -1)
 		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
@@ -778,7 +778,7 @@ static const struct dsa_device_ops sja1105_netdev_ops = {
 	.disconnect = sja1105_disconnect,
 	.needed_headroom = VLAN_HLEN,
 	.flow_dissect = sja1105_flow_dissect,
-	.promisc_on_master = true,
+	.promisc_on_conduit = true,
 };
 
 DSA_TAG_DRIVER(sja1105_netdev_ops);
diff --git a/net/dsa/tag_trailer.c b/net/dsa/tag_trailer.c
index 7361b9106382..1ebb25a8b140 100644
--- a/net/dsa/tag_trailer.c
+++ b/net/dsa/tag_trailer.c
@@ -14,7 +14,7 @@
 
 static struct sk_buff *trailer_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	u8 *trailer;
 
 	trailer = skb_put(skb, 4);
@@ -41,7 +41,7 @@ static struct sk_buff *trailer_rcv(struct sk_buff *skb, struct net_device *dev)
 
 	source_port = trailer[1] & 7;
 
-	skb->dev = dsa_master_find_slave(dev, 0, source_port);
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/tag_xrs700x.c b/net/dsa/tag_xrs700x.c
index af19969f9bc4..c9c163598ef2 100644
--- a/net/dsa/tag_xrs700x.c
+++ b/net/dsa/tag_xrs700x.c
@@ -13,7 +13,7 @@
 
 static struct sk_buff *xrs700x_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *partner, *dp = dsa_slave_to_port(dev);
+	struct dsa_port *partner, *dp = dsa_user_to_port(dev);
 	u8 *trailer;
 
 	trailer = skb_put(skb, 1);
@@ -39,7 +39,7 @@ static struct sk_buff *xrs700x_rcv(struct sk_buff *skb, struct net_device *dev)
 	if (source_port < 0)
 		return NULL;
 
-	skb->dev = dsa_master_find_slave(dev, 0, source_port);
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
 	if (!skb->dev)
 		return NULL;
 
diff --git a/net/dsa/slave.c b/net/dsa/user.c
similarity index 62%
rename from net/dsa/slave.c
rename to net/dsa/user.c
index 4c3e502d7e16..c03e41e4e660 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/user.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * net/dsa/slave.c - Slave device handling
+ * net/dsa/user.c - user device handling
  * Copyright (c) 2008-2009 Marvell Semiconductor
  */
 
@@ -23,13 +23,13 @@
 #include <linux/netpoll.h>
 #include <linux/string.h>
 
+#include "conduit.h"
 #include "dsa.h"
-#include "port.h"
-#include "master.h"
 #include "netlink.h"
-#include "slave.h"
+#include "port.h"
 #include "switch.h"
 #include "tag.h"
+#include "user.h"
 
 struct dsa_switchdev_event_work {
 	struct net_device *dev;
@@ -79,13 +79,13 @@ static bool dsa_switch_supports_mc_filtering(struct dsa_switch *ds)
 	       !ds->needs_standalone_vlan_filtering;
 }
 
-static void dsa_slave_standalone_event_work(struct work_struct *work)
+static void dsa_user_standalone_event_work(struct work_struct *work)
 {
 	struct dsa_standalone_event_work *standalone_work =
 		container_of(work, struct dsa_standalone_event_work, work);
 	const unsigned char *addr = standalone_work->addr;
 	struct net_device *dev = standalone_work->dev;
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_mdb mdb;
 	struct dsa_switch *ds = dp->ds;
 	u16 vid = standalone_work->vid;
@@ -140,10 +140,10 @@ static void dsa_slave_standalone_event_work(struct work_struct *work)
 	kfree(standalone_work);
 }
 
-static int dsa_slave_schedule_standalone_work(struct net_device *dev,
-					      enum dsa_standalone_event event,
-					      const unsigned char *addr,
-					      u16 vid)
+static int dsa_user_schedule_standalone_work(struct net_device *dev,
+					     enum dsa_standalone_event event,
+					     const unsigned char *addr,
+					     u16 vid)
 {
 	struct dsa_standalone_event_work *standalone_work;
 
@@ -151,7 +151,7 @@ static int dsa_slave_schedule_standalone_work(struct net_device *dev,
 	if (!standalone_work)
 		return -ENOMEM;
 
-	INIT_WORK(&standalone_work->work, dsa_slave_standalone_event_work);
+	INIT_WORK(&standalone_work->work, dsa_user_standalone_event_work);
 	standalone_work->event = event;
 	standalone_work->dev = dev;
 
@@ -163,18 +163,18 @@ static int dsa_slave_schedule_standalone_work(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_host_vlan_rx_filtering(void *arg, int vid)
+static int dsa_user_host_vlan_rx_filtering(void *arg, int vid)
 {
 	struct dsa_host_vlan_rx_filtering_ctx *ctx = arg;
 
-	return dsa_slave_schedule_standalone_work(ctx->dev, ctx->event,
+	return dsa_user_schedule_standalone_work(ctx->dev, ctx->event,
 						  ctx->addr, vid);
 }
 
-static int dsa_slave_vlan_for_each(struct net_device *dev,
-				   int (*cb)(void *arg, int vid), void *arg)
+static int dsa_user_vlan_for_each(struct net_device *dev,
+				  int (*cb)(void *arg, int vid), void *arg)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_vlan *v;
 	int err;
 
@@ -193,99 +193,99 @@ static int dsa_slave_vlan_for_each(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_sync_uc(struct net_device *dev,
-			     const unsigned char *addr)
+static int dsa_user_sync_uc(struct net_device *dev,
+			    const unsigned char *addr)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_host_vlan_rx_filtering_ctx ctx = {
 		.dev = dev,
 		.addr = addr,
 		.event = DSA_UC_ADD,
 	};
 
-	dev_uc_add(master, addr);
+	dev_uc_add(conduit, addr);
 
 	if (!dsa_switch_supports_uc_filtering(dp->ds))
 		return 0;
 
-	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
 				       &ctx);
 }
 
-static int dsa_slave_unsync_uc(struct net_device *dev,
-			       const unsigned char *addr)
+static int dsa_user_unsync_uc(struct net_device *dev,
+			      const unsigned char *addr)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_host_vlan_rx_filtering_ctx ctx = {
 		.dev = dev,
 		.addr = addr,
 		.event = DSA_UC_DEL,
 	};
 
-	dev_uc_del(master, addr);
+	dev_uc_del(conduit, addr);
 
 	if (!dsa_switch_supports_uc_filtering(dp->ds))
 		return 0;
 
-	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
 				       &ctx);
 }
 
-static int dsa_slave_sync_mc(struct net_device *dev,
-			     const unsigned char *addr)
+static int dsa_user_sync_mc(struct net_device *dev,
+			    const unsigned char *addr)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_host_vlan_rx_filtering_ctx ctx = {
 		.dev = dev,
 		.addr = addr,
 		.event = DSA_MC_ADD,
 	};
 
-	dev_mc_add(master, addr);
+	dev_mc_add(conduit, addr);
 
 	if (!dsa_switch_supports_mc_filtering(dp->ds))
 		return 0;
 
-	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
 				       &ctx);
 }
 
-static int dsa_slave_unsync_mc(struct net_device *dev,
-			       const unsigned char *addr)
+static int dsa_user_unsync_mc(struct net_device *dev,
+			      const unsigned char *addr)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_host_vlan_rx_filtering_ctx ctx = {
 		.dev = dev,
 		.addr = addr,
 		.event = DSA_MC_DEL,
 	};
 
-	dev_mc_del(master, addr);
+	dev_mc_del(conduit, addr);
 
 	if (!dsa_switch_supports_mc_filtering(dp->ds))
 		return 0;
 
-	return dsa_slave_vlan_for_each(dev, dsa_slave_host_vlan_rx_filtering,
+	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
 				       &ctx);
 }
 
-void dsa_slave_sync_ha(struct net_device *dev)
+void dsa_user_sync_ha(struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct netdev_hw_addr *ha;
 
 	netif_addr_lock_bh(dev);
 
 	netdev_for_each_synced_mc_addr(ha, dev)
-		dsa_slave_sync_mc(dev, ha->addr);
+		dsa_user_sync_mc(dev, ha->addr);
 
 	netdev_for_each_synced_uc_addr(ha, dev)
-		dsa_slave_sync_uc(dev, ha->addr);
+		dsa_user_sync_uc(dev, ha->addr);
 
 	netif_addr_unlock_bh(dev);
 
@@ -294,19 +294,19 @@ void dsa_slave_sync_ha(struct net_device *dev)
 		dsa_flush_workqueue();
 }
 
-void dsa_slave_unsync_ha(struct net_device *dev)
+void dsa_user_unsync_ha(struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct netdev_hw_addr *ha;
 
 	netif_addr_lock_bh(dev);
 
 	netdev_for_each_synced_uc_addr(ha, dev)
-		dsa_slave_unsync_uc(dev, ha->addr);
+		dsa_user_unsync_uc(dev, ha->addr);
 
 	netdev_for_each_synced_mc_addr(ha, dev)
-		dsa_slave_unsync_mc(dev, ha->addr);
+		dsa_user_unsync_mc(dev, ha->addr);
 
 	netif_addr_unlock_bh(dev);
 
@@ -315,8 +315,8 @@ void dsa_slave_unsync_ha(struct net_device *dev)
 		dsa_flush_workqueue();
 }
 
-/* slave mii_bus handling ***************************************************/
-static int dsa_slave_phy_read(struct mii_bus *bus, int addr, int reg)
+/* user mii_bus handling ***************************************************/
+static int dsa_user_phy_read(struct mii_bus *bus, int addr, int reg)
 {
 	struct dsa_switch *ds = bus->priv;
 
@@ -326,7 +326,7 @@ static int dsa_slave_phy_read(struct mii_bus *bus, int addr, int reg)
 	return 0xffff;
 }
 
-static int dsa_slave_phy_write(struct mii_bus *bus, int addr, int reg, u16 val)
+static int dsa_user_phy_write(struct mii_bus *bus, int addr, int reg, u16 val)
 {
 	struct dsa_switch *ds = bus->priv;
 
@@ -336,35 +336,35 @@ static int dsa_slave_phy_write(struct mii_bus *bus, int addr, int reg, u16 val)
 	return 0;
 }
 
-void dsa_slave_mii_bus_init(struct dsa_switch *ds)
+void dsa_user_mii_bus_init(struct dsa_switch *ds)
 {
-	ds->slave_mii_bus->priv = (void *)ds;
-	ds->slave_mii_bus->name = "dsa slave smi";
-	ds->slave_mii_bus->read = dsa_slave_phy_read;
-	ds->slave_mii_bus->write = dsa_slave_phy_write;
-	snprintf(ds->slave_mii_bus->id, MII_BUS_ID_SIZE, "dsa-%d.%d",
+	ds->user_mii_bus->priv = (void *)ds;
+	ds->user_mii_bus->name = "dsa user smi";
+	ds->user_mii_bus->read = dsa_user_phy_read;
+	ds->user_mii_bus->write = dsa_user_phy_write;
+	snprintf(ds->user_mii_bus->id, MII_BUS_ID_SIZE, "dsa-%d.%d",
 		 ds->dst->index, ds->index);
-	ds->slave_mii_bus->parent = ds->dev;
-	ds->slave_mii_bus->phy_mask = ~ds->phys_mii_mask;
+	ds->user_mii_bus->parent = ds->dev;
+	ds->user_mii_bus->phy_mask = ~ds->phys_mii_mask;
 }
 
 
-/* slave device handling ****************************************************/
-static int dsa_slave_get_iflink(const struct net_device *dev)
+/* user device handling ****************************************************/
+static int dsa_user_get_iflink(const struct net_device *dev)
 {
-	return dsa_slave_to_master(dev)->ifindex;
+	return dsa_user_to_conduit(dev)->ifindex;
 }
 
-static int dsa_slave_open(struct net_device *dev)
+static int dsa_user_open(struct net_device *dev)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int err;
 
-	err = dev_open(master, NULL);
+	err = dev_open(conduit, NULL);
 	if (err < 0) {
-		netdev_err(dev, "failed to open master %s\n", master->name);
+		netdev_err(dev, "failed to open conduit %s\n", conduit->name);
 		goto out;
 	}
 
@@ -374,8 +374,8 @@ static int dsa_slave_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr)) {
-		err = dev_uc_add(master, dev->dev_addr);
+	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr)) {
+		err = dev_uc_add(conduit, dev->dev_addr);
 		if (err < 0)
 			goto del_host_addr;
 	}
@@ -387,8 +387,8 @@ static int dsa_slave_open(struct net_device *dev)
 	return 0;
 
 del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
-		dev_uc_del(master, dev->dev_addr);
+	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
+		dev_uc_del(conduit, dev->dev_addr);
 del_host_addr:
 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
@@ -396,16 +396,16 @@ static int dsa_slave_open(struct net_device *dev)
 	return err;
 }
 
-static int dsa_slave_close(struct net_device *dev)
+static int dsa_user_close(struct net_device *dev)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	dsa_port_disable_rt(dp);
 
-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
-		dev_uc_del(master, dev->dev_addr);
+	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
+		dev_uc_del(conduit, dev->dev_addr);
 
 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
@@ -413,43 +413,43 @@ static int dsa_slave_close(struct net_device *dev)
 	return 0;
 }
 
-static void dsa_slave_manage_host_flood(struct net_device *dev)
+static void dsa_user_manage_host_flood(struct net_device *dev)
 {
 	bool mc = dev->flags & (IFF_PROMISC | IFF_ALLMULTI);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	bool uc = dev->flags & IFF_PROMISC;
 
 	dsa_port_set_host_flood(dp, uc, mc);
 }
 
-static void dsa_slave_change_rx_flags(struct net_device *dev, int change)
+static void dsa_user_change_rx_flags(struct net_device *dev, int change)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (change & IFF_ALLMULTI)
-		dev_set_allmulti(master,
+		dev_set_allmulti(conduit,
 				 dev->flags & IFF_ALLMULTI ? 1 : -1);
 	if (change & IFF_PROMISC)
-		dev_set_promiscuity(master,
+		dev_set_promiscuity(conduit,
 				    dev->flags & IFF_PROMISC ? 1 : -1);
 
 	if (dsa_switch_supports_uc_filtering(ds) &&
 	    dsa_switch_supports_mc_filtering(ds))
-		dsa_slave_manage_host_flood(dev);
+		dsa_user_manage_host_flood(dev);
 }
 
-static void dsa_slave_set_rx_mode(struct net_device *dev)
+static void dsa_user_set_rx_mode(struct net_device *dev)
 {
-	__dev_mc_sync(dev, dsa_slave_sync_mc, dsa_slave_unsync_mc);
-	__dev_uc_sync(dev, dsa_slave_sync_uc, dsa_slave_unsync_uc);
+	__dev_mc_sync(dev, dsa_user_sync_mc, dsa_user_unsync_mc);
+	__dev_uc_sync(dev, dsa_user_sync_uc, dsa_user_unsync_uc);
 }
 
-static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
+static int dsa_user_set_mac_address(struct net_device *dev, void *a)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct sockaddr *addr = a;
 	int err;
@@ -465,7 +465,7 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 	}
 
 	/* If the port is down, the address isn't synced yet to hardware or
-	 * to the DSA master, so there is nothing to change.
+	 * to the DSA conduit, so there is nothing to change.
 	 */
 	if (!(dev->flags & IFF_UP))
 		goto out_change_dev_addr;
@@ -476,14 +476,14 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 			return err;
 	}
 
-	if (!ether_addr_equal(addr->sa_data, master->dev_addr)) {
-		err = dev_uc_add(master, addr->sa_data);
+	if (!ether_addr_equal(addr->sa_data, conduit->dev_addr)) {
+		err = dev_uc_add(conduit, addr->sa_data);
 		if (err < 0)
 			goto del_unicast;
 	}
 
-	if (!ether_addr_equal(dev->dev_addr, master->dev_addr))
-		dev_uc_del(master, dev->dev_addr);
+	if (!ether_addr_equal(dev->dev_addr, conduit->dev_addr))
+		dev_uc_del(conduit, dev->dev_addr);
 
 	if (dsa_switch_supports_uc_filtering(ds))
 		dsa_port_standalone_host_fdb_del(dp, dev->dev_addr, 0);
@@ -500,7 +500,7 @@ static int dsa_slave_set_mac_address(struct net_device *dev, void *a)
 	return err;
 }
 
-struct dsa_slave_dump_ctx {
+struct dsa_user_dump_ctx {
 	struct net_device *dev;
 	struct sk_buff *skb;
 	struct netlink_callback *cb;
@@ -508,10 +508,10 @@ struct dsa_slave_dump_ctx {
 };
 
 static int
-dsa_slave_port_fdb_do_dump(const unsigned char *addr, u16 vid,
-			   bool is_static, void *data)
+dsa_user_port_fdb_do_dump(const unsigned char *addr, u16 vid,
+			  bool is_static, void *data)
 {
-	struct dsa_slave_dump_ctx *dump = data;
+	struct dsa_user_dump_ctx *dump = data;
 	u32 portid = NETLINK_CB(dump->cb->skb).portid;
 	u32 seq = dump->cb->nlh->nlmsg_seq;
 	struct nlmsghdr *nlh;
@@ -552,12 +552,12 @@ dsa_slave_port_fdb_do_dump(const unsigned char *addr, u16 vid,
 }
 
 static int
-dsa_slave_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
-		   struct net_device *dev, struct net_device *filter_dev,
-		   int *idx)
+dsa_user_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
+		  struct net_device *dev, struct net_device *filter_dev,
+		  int *idx)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct dsa_slave_dump_ctx dump = {
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_user_dump_ctx dump = {
 		.dev = dev,
 		.skb = skb,
 		.cb = cb,
@@ -565,15 +565,15 @@ dsa_slave_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	};
 	int err;
 
-	err = dsa_port_fdb_dump(dp, dsa_slave_port_fdb_do_dump, &dump);
+	err = dsa_port_fdb_dump(dp, dsa_user_port_fdb_do_dump, &dump);
 	*idx = dump.idx;
 
 	return err;
 }
 
-static int dsa_slave_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int dsa_user_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_switch *ds = p->dp->ds;
 	int port = p->dp->index;
 
@@ -592,11 +592,11 @@ static int dsa_slave_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	return phylink_mii_ioctl(p->dp->pl, ifr, cmd);
 }
 
-static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
-				   const struct switchdev_attr *attr,
-				   struct netlink_ext_ack *extack)
+static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
+				  const struct switchdev_attr *attr,
+				  struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	int ret;
 
 	if (ctx && ctx != dp)
@@ -663,13 +663,13 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
 
 /* Must be called under rcu_read_lock() */
 static int
-dsa_slave_vlan_check_for_8021q_uppers(struct net_device *slave,
-				      const struct switchdev_obj_port_vlan *vlan)
+dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
+				     const struct switchdev_obj_port_vlan *vlan)
 {
 	struct net_device *upper_dev;
 	struct list_head *iter;
 
-	netdev_for_each_upper_dev_rcu(slave, upper_dev, iter) {
+	netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
 		u16 vid;
 
 		if (!is_vlan_dev(upper_dev))
@@ -683,11 +683,11 @@ dsa_slave_vlan_check_for_8021q_uppers(struct net_device *slave,
 	return 0;
 }
 
-static int dsa_slave_vlan_add(struct net_device *dev,
-			      const struct switchdev_obj *obj,
-			      struct netlink_ext_ack *extack)
+static int dsa_user_vlan_add(struct net_device *dev,
+			     const struct switchdev_obj *obj,
+			     struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_vlan *vlan;
 	int err;
 
@@ -703,7 +703,7 @@ static int dsa_slave_vlan_add(struct net_device *dev,
 	 */
 	if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
 		rcu_read_lock();
-		err = dsa_slave_vlan_check_for_8021q_uppers(dev, vlan);
+		err = dsa_user_vlan_check_for_8021q_uppers(dev, vlan);
 		rcu_read_unlock();
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
@@ -718,11 +718,11 @@ static int dsa_slave_vlan_add(struct net_device *dev,
 /* Offload a VLAN installed on the bridge or on a foreign interface by
  * installing it as a VLAN towards the CPU port.
  */
-static int dsa_slave_host_vlan_add(struct net_device *dev,
-				   const struct switchdev_obj *obj,
-				   struct netlink_ext_ack *extack)
+static int dsa_user_host_vlan_add(struct net_device *dev,
+				  const struct switchdev_obj *obj,
+				  struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_vlan vlan;
 
 	/* Do nothing if this is a software bridge */
@@ -744,11 +744,11 @@ static int dsa_slave_host_vlan_add(struct net_device *dev,
 	return dsa_port_host_vlan_add(dp, &vlan, extack);
 }
 
-static int dsa_slave_port_obj_add(struct net_device *dev, const void *ctx,
-				  const struct switchdev_obj *obj,
-				  struct netlink_ext_ack *extack)
+static int dsa_user_port_obj_add(struct net_device *dev, const void *ctx,
+				 const struct switchdev_obj *obj,
+				 struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	int err;
 
 	if (ctx && ctx != dp)
@@ -769,9 +769,9 @@ static int dsa_slave_port_obj_add(struct net_device *dev, const void *ctx,
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		if (dsa_port_offloads_bridge_port(dp, obj->orig_dev))
-			err = dsa_slave_vlan_add(dev, obj, extack);
+			err = dsa_user_vlan_add(dev, obj, extack);
 		else
-			err = dsa_slave_host_vlan_add(dev, obj, extack);
+			err = dsa_user_host_vlan_add(dev, obj, extack);
 		break;
 	case SWITCHDEV_OBJ_ID_MRP:
 		if (!dsa_port_offloads_bridge_dev(dp, obj->orig_dev))
@@ -794,10 +794,10 @@ static int dsa_slave_port_obj_add(struct net_device *dev, const void *ctx,
 	return err;
 }
 
-static int dsa_slave_vlan_del(struct net_device *dev,
-			      const struct switchdev_obj *obj)
+static int dsa_user_vlan_del(struct net_device *dev,
+			     const struct switchdev_obj *obj)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_vlan *vlan;
 
 	if (dsa_port_skip_vlan_configuration(dp))
@@ -808,10 +808,10 @@ static int dsa_slave_vlan_del(struct net_device *dev,
 	return dsa_port_vlan_del(dp, vlan);
 }
 
-static int dsa_slave_host_vlan_del(struct net_device *dev,
-				   const struct switchdev_obj *obj)
+static int dsa_user_host_vlan_del(struct net_device *dev,
+				  const struct switchdev_obj *obj)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_vlan *vlan;
 
 	/* Do nothing if this is a software bridge */
@@ -826,10 +826,10 @@ static int dsa_slave_host_vlan_del(struct net_device *dev,
 	return dsa_port_host_vlan_del(dp, vlan);
 }
 
-static int dsa_slave_port_obj_del(struct net_device *dev, const void *ctx,
-				  const struct switchdev_obj *obj)
+static int dsa_user_port_obj_del(struct net_device *dev, const void *ctx,
+				 const struct switchdev_obj *obj)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	int err;
 
 	if (ctx && ctx != dp)
@@ -850,9 +850,9 @@ static int dsa_slave_port_obj_del(struct net_device *dev, const void *ctx,
 		break;
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		if (dsa_port_offloads_bridge_port(dp, obj->orig_dev))
-			err = dsa_slave_vlan_del(dev, obj);
+			err = dsa_user_vlan_del(dev, obj);
 		else
-			err = dsa_slave_host_vlan_del(dev, obj);
+			err = dsa_user_host_vlan_del(dev, obj);
 		break;
 	case SWITCHDEV_OBJ_ID_MRP:
 		if (!dsa_port_offloads_bridge_dev(dp, obj->orig_dev))
@@ -875,11 +875,11 @@ static int dsa_slave_port_obj_del(struct net_device *dev, const void *ctx,
 	return err;
 }
 
-static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
-						     struct sk_buff *skb)
+static inline netdev_tx_t dsa_user_netpoll_send_skb(struct net_device *dev,
+						    struct sk_buff *skb)
 {
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 
 	return netpoll_send_skb(p->netpoll, skb);
 #else
@@ -888,7 +888,7 @@ static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
 #endif
 }
 
-static void dsa_skb_tx_timestamp(struct dsa_slave_priv *p,
+static void dsa_skb_tx_timestamp(struct dsa_user_priv *p,
 				 struct sk_buff *skb)
 {
 	struct dsa_switch *ds = p->dp->ds;
@@ -908,12 +908,12 @@ netdev_tx_t dsa_enqueue_skb(struct sk_buff *skb, struct net_device *dev)
 	 * tag to be successfully transmitted
 	 */
 	if (unlikely(netpoll_tx_running(dev)))
-		return dsa_slave_netpoll_send_skb(dev, skb);
+		return dsa_user_netpoll_send_skb(dev, skb);
 
 	/* Queue the SKB for transmission on the parent interface, but
 	 * do not modify its EtherType
 	 */
-	skb->dev = dsa_slave_to_master(dev);
+	skb->dev = dsa_user_to_conduit(dev);
 	dev_queue_xmit(skb);
 
 	return NETDEV_TX_OK;
@@ -927,7 +927,7 @@ static int dsa_realloc_skb(struct sk_buff *skb, struct net_device *dev)
 
 	/* For tail taggers, we need to pad short frames ourselves, to ensure
 	 * that the tail tag does not fail at its role of being at the end of
-	 * the packet, once the master interface pads the frame. Account for
+	 * the packet, once the conduit interface pads the frame. Account for
 	 * that pad length here, and pad later.
 	 */
 	if (unlikely(needed_tailroom && skb->len < ETH_ZLEN))
@@ -944,9 +944,9 @@ static int dsa_realloc_skb(struct sk_buff *skb, struct net_device *dev)
 				GFP_ATOMIC);
 }
 
-static netdev_tx_t dsa_slave_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t dsa_user_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct sk_buff *nskb;
 
 	dev_sw_netstats_tx_add(dev, 1, skb->len);
@@ -981,17 +981,17 @@ static netdev_tx_t dsa_slave_xmit(struct sk_buff *skb, struct net_device *dev)
 
 /* ethtool operations *******************************************************/
 
-static void dsa_slave_get_drvinfo(struct net_device *dev,
-				  struct ethtool_drvinfo *drvinfo)
+static void dsa_user_get_drvinfo(struct net_device *dev,
+				 struct ethtool_drvinfo *drvinfo)
 {
 	strscpy(drvinfo->driver, "dsa", sizeof(drvinfo->driver));
 	strscpy(drvinfo->fw_version, "N/A", sizeof(drvinfo->fw_version));
 	strscpy(drvinfo->bus_info, "platform", sizeof(drvinfo->bus_info));
 }
 
-static int dsa_slave_get_regs_len(struct net_device *dev)
+static int dsa_user_get_regs_len(struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_regs_len)
@@ -1001,25 +1001,25 @@ static int dsa_slave_get_regs_len(struct net_device *dev)
 }
 
 static void
-dsa_slave_get_regs(struct net_device *dev, struct ethtool_regs *regs, void *_p)
+dsa_user_get_regs(struct net_device *dev, struct ethtool_regs *regs, void *_p)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_regs)
 		ds->ops->get_regs(ds, dp->index, regs, _p);
 }
 
-static int dsa_slave_nway_reset(struct net_device *dev)
+static int dsa_user_nway_reset(struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 
 	return phylink_ethtool_nway_reset(dp->pl);
 }
 
-static int dsa_slave_get_eeprom_len(struct net_device *dev)
+static int dsa_user_get_eeprom_len(struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->cd && ds->cd->eeprom_len)
@@ -1031,10 +1031,10 @@ static int dsa_slave_get_eeprom_len(struct net_device *dev)
 	return 0;
 }
 
-static int dsa_slave_get_eeprom(struct net_device *dev,
-				struct ethtool_eeprom *eeprom, u8 *data)
+static int dsa_user_get_eeprom(struct net_device *dev,
+			       struct ethtool_eeprom *eeprom, u8 *data)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_eeprom)
@@ -1043,10 +1043,10 @@ static int dsa_slave_get_eeprom(struct net_device *dev,
 	return -EOPNOTSUPP;
 }
 
-static int dsa_slave_set_eeprom(struct net_device *dev,
-				struct ethtool_eeprom *eeprom, u8 *data)
+static int dsa_user_set_eeprom(struct net_device *dev,
+			       struct ethtool_eeprom *eeprom, u8 *data)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->set_eeprom)
@@ -1055,10 +1055,10 @@ static int dsa_slave_set_eeprom(struct net_device *dev,
 	return -EOPNOTSUPP;
 }
 
-static void dsa_slave_get_strings(struct net_device *dev,
-				  uint32_t stringset, uint8_t *data)
+static void dsa_user_get_strings(struct net_device *dev,
+				 uint32_t stringset, uint8_t *data)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (stringset == ETH_SS_STATS) {
@@ -1077,11 +1077,11 @@ static void dsa_slave_get_strings(struct net_device *dev,
 
 }
 
-static void dsa_slave_get_ethtool_stats(struct net_device *dev,
-					struct ethtool_stats *stats,
-					uint64_t *data)
+static void dsa_user_get_ethtool_stats(struct net_device *dev,
+				       struct ethtool_stats *stats,
+				       uint64_t *data)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct pcpu_sw_netstats *s;
 	unsigned int start;
@@ -1107,9 +1107,9 @@ static void dsa_slave_get_ethtool_stats(struct net_device *dev,
 		ds->ops->get_ethtool_stats(ds, dp->index, data + 4);
 }
 
-static int dsa_slave_get_sset_count(struct net_device *dev, int sset)
+static int dsa_user_get_sset_count(struct net_device *dev, int sset)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (sset == ETH_SS_STATS) {
@@ -1129,20 +1129,20 @@ static int dsa_slave_get_sset_count(struct net_device *dev, int sset)
 	return -EOPNOTSUPP;
 }
 
-static void dsa_slave_get_eth_phy_stats(struct net_device *dev,
-					struct ethtool_eth_phy_stats *phy_stats)
+static void dsa_user_get_eth_phy_stats(struct net_device *dev,
+				       struct ethtool_eth_phy_stats *phy_stats)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_eth_phy_stats)
 		ds->ops->get_eth_phy_stats(ds, dp->index, phy_stats);
 }
 
-static void dsa_slave_get_eth_mac_stats(struct net_device *dev,
-					struct ethtool_eth_mac_stats *mac_stats)
+static void dsa_user_get_eth_mac_stats(struct net_device *dev,
+				       struct ethtool_eth_mac_stats *mac_stats)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_eth_mac_stats)
@@ -1150,10 +1150,10 @@ static void dsa_slave_get_eth_mac_stats(struct net_device *dev,
 }
 
 static void
-dsa_slave_get_eth_ctrl_stats(struct net_device *dev,
-			     struct ethtool_eth_ctrl_stats *ctrl_stats)
+dsa_user_get_eth_ctrl_stats(struct net_device *dev,
+			    struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_eth_ctrl_stats)
@@ -1161,21 +1161,21 @@ dsa_slave_get_eth_ctrl_stats(struct net_device *dev,
 }
 
 static void
-dsa_slave_get_rmon_stats(struct net_device *dev,
-			 struct ethtool_rmon_stats *rmon_stats,
-			 const struct ethtool_rmon_hist_range **ranges)
+dsa_user_get_rmon_stats(struct net_device *dev,
+			struct ethtool_rmon_stats *rmon_stats,
+			const struct ethtool_rmon_hist_range **ranges)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_rmon_stats)
 		ds->ops->get_rmon_stats(ds, dp->index, rmon_stats, ranges);
 }
 
-static void dsa_slave_net_selftest(struct net_device *ndev,
-				   struct ethtool_test *etest, u64 *buf)
+static void dsa_user_net_selftest(struct net_device *ndev,
+				  struct ethtool_test *etest, u64 *buf)
 {
-	struct dsa_port *dp = dsa_slave_to_port(ndev);
+	struct dsa_port *dp = dsa_user_to_port(ndev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->self_test) {
@@ -1186,10 +1186,10 @@ static void dsa_slave_net_selftest(struct net_device *ndev,
 	net_selftest(ndev, etest, buf);
 }
 
-static int dsa_slave_get_mm(struct net_device *dev,
-			    struct ethtool_mm_state *state)
+static int dsa_user_get_mm(struct net_device *dev,
+			   struct ethtool_mm_state *state)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->get_mm)
@@ -1198,10 +1198,10 @@ static int dsa_slave_get_mm(struct net_device *dev,
 	return ds->ops->get_mm(ds, dp->index, state);
 }
 
-static int dsa_slave_set_mm(struct net_device *dev, struct ethtool_mm_cfg *cfg,
-			    struct netlink_ext_ack *extack)
+static int dsa_user_set_mm(struct net_device *dev, struct ethtool_mm_cfg *cfg,
+			   struct netlink_ext_ack *extack)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->set_mm)
@@ -1210,19 +1210,19 @@ static int dsa_slave_set_mm(struct net_device *dev, struct ethtool_mm_cfg *cfg,
 	return ds->ops->set_mm(ds, dp->index, cfg, extack);
 }
 
-static void dsa_slave_get_mm_stats(struct net_device *dev,
-				   struct ethtool_mm_stats *stats)
+static void dsa_user_get_mm_stats(struct net_device *dev,
+				  struct ethtool_mm_stats *stats)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_mm_stats)
 		ds->ops->get_mm_stats(ds, dp->index, stats);
 }
 
-static void dsa_slave_get_wol(struct net_device *dev, struct ethtool_wolinfo *w)
+static void dsa_user_get_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	phylink_ethtool_get_wol(dp->pl, w);
@@ -1231,9 +1231,9 @@ static void dsa_slave_get_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 		ds->ops->get_wol(ds, dp->index, w);
 }
 
-static int dsa_slave_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
+static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int ret = -EOPNOTSUPP;
 
@@ -1245,9 +1245,9 @@ static int dsa_slave_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
 	return ret;
 }
 
-static int dsa_slave_set_eee(struct net_device *dev, struct ethtool_eee *e)
+static int dsa_user_set_eee(struct net_device *dev, struct ethtool_eee *e)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
@@ -1265,9 +1265,9 @@ static int dsa_slave_set_eee(struct net_device *dev, struct ethtool_eee *e)
 	return phylink_ethtool_set_eee(dp->pl, e);
 }
 
-static int dsa_slave_get_eee(struct net_device *dev, struct ethtool_eee *e)
+static int dsa_user_get_eee(struct net_device *dev, struct ethtool_eee *e)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int ret;
 
@@ -1285,54 +1285,54 @@ static int dsa_slave_get_eee(struct net_device *dev, struct ethtool_eee *e)
 	return phylink_ethtool_get_eee(dp->pl, e);
 }
 
-static int dsa_slave_get_link_ksettings(struct net_device *dev,
-					struct ethtool_link_ksettings *cmd)
+static int dsa_user_get_link_ksettings(struct net_device *dev,
+				       struct ethtool_link_ksettings *cmd)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 
 	return phylink_ethtool_ksettings_get(dp->pl, cmd);
 }
 
-static int dsa_slave_set_link_ksettings(struct net_device *dev,
-					const struct ethtool_link_ksettings *cmd)
+static int dsa_user_set_link_ksettings(struct net_device *dev,
+				       const struct ethtool_link_ksettings *cmd)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 
 	return phylink_ethtool_ksettings_set(dp->pl, cmd);
 }
 
-static void dsa_slave_get_pause_stats(struct net_device *dev,
-				  struct ethtool_pause_stats *pause_stats)
+static void dsa_user_get_pause_stats(struct net_device *dev,
+				     struct ethtool_pause_stats *pause_stats)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_pause_stats)
 		ds->ops->get_pause_stats(ds, dp->index, pause_stats);
 }
 
-static void dsa_slave_get_pauseparam(struct net_device *dev,
-				     struct ethtool_pauseparam *pause)
+static void dsa_user_get_pauseparam(struct net_device *dev,
+				    struct ethtool_pauseparam *pause)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 
 	phylink_ethtool_get_pauseparam(dp->pl, pause);
 }
 
-static int dsa_slave_set_pauseparam(struct net_device *dev,
-				    struct ethtool_pauseparam *pause)
+static int dsa_user_set_pauseparam(struct net_device *dev,
+				   struct ethtool_pauseparam *pause)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 
 	return phylink_ethtool_set_pauseparam(dp->pl, pause);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-static int dsa_slave_netpoll_setup(struct net_device *dev,
-				   struct netpoll_info *ni)
+static int dsa_user_netpoll_setup(struct net_device *dev,
+				  struct netpoll_info *ni)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct netpoll *netpoll;
 	int err = 0;
 
@@ -1340,7 +1340,7 @@ static int dsa_slave_netpoll_setup(struct net_device *dev,
 	if (!netpoll)
 		return -ENOMEM;
 
-	err = __netpoll_setup(netpoll, master);
+	err = __netpoll_setup(netpoll, conduit);
 	if (err) {
 		kfree(netpoll);
 		goto out;
@@ -1351,9 +1351,9 @@ static int dsa_slave_netpoll_setup(struct net_device *dev,
 	return err;
 }
 
-static void dsa_slave_netpoll_cleanup(struct net_device *dev)
+static void dsa_user_netpoll_cleanup(struct net_device *dev)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct netpoll *netpoll = p->netpoll;
 
 	if (!netpoll)
@@ -1364,15 +1364,15 @@ static void dsa_slave_netpoll_cleanup(struct net_device *dev)
 	__netpoll_free(netpoll);
 }
 
-static void dsa_slave_poll_controller(struct net_device *dev)
+static void dsa_user_poll_controller(struct net_device *dev)
 {
 }
 #endif
 
 static struct dsa_mall_tc_entry *
-dsa_slave_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
+dsa_user_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_mall_tc_entry *mall_tc_entry;
 
 	list_for_each_entry(mall_tc_entry, &p->mall_tc_list, list)
@@ -1383,13 +1383,13 @@ dsa_slave_mall_tc_entry_find(struct net_device *dev, unsigned long cookie)
 }
 
 static int
-dsa_slave_add_cls_matchall_mirred(struct net_device *dev,
-				  struct tc_cls_matchall_offload *cls,
-				  bool ingress)
+dsa_user_add_cls_matchall_mirred(struct net_device *dev,
+				 struct tc_cls_matchall_offload *cls,
+				 bool ingress)
 {
 	struct netlink_ext_ack *extack = cls->common.extack;
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_mall_mirror_tc_entry *mirror;
 	struct dsa_mall_tc_entry *mall_tc_entry;
 	struct dsa_switch *ds = dp->ds;
@@ -1409,7 +1409,7 @@ dsa_slave_add_cls_matchall_mirred(struct net_device *dev,
 	if (!act->dev)
 		return -EINVAL;
 
-	if (!dsa_slave_dev_check(act->dev))
+	if (!dsa_user_dev_check(act->dev))
 		return -EOPNOTSUPP;
 
 	mall_tc_entry = kzalloc(sizeof(*mall_tc_entry), GFP_KERNEL);
@@ -1420,7 +1420,7 @@ dsa_slave_add_cls_matchall_mirred(struct net_device *dev,
 	mall_tc_entry->type = DSA_PORT_MALL_MIRROR;
 	mirror = &mall_tc_entry->mirror;
 
-	to_dp = dsa_slave_to_port(act->dev);
+	to_dp = dsa_user_to_port(act->dev);
 
 	mirror->to_local_port = to_dp->index;
 	mirror->ingress = ingress;
@@ -1437,13 +1437,13 @@ dsa_slave_add_cls_matchall_mirred(struct net_device *dev,
 }
 
 static int
-dsa_slave_add_cls_matchall_police(struct net_device *dev,
-				  struct tc_cls_matchall_offload *cls,
-				  bool ingress)
+dsa_user_add_cls_matchall_police(struct net_device *dev,
+				 struct tc_cls_matchall_offload *cls,
+				 bool ingress)
 {
 	struct netlink_ext_ack *extack = cls->common.extack;
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_mall_policer_tc_entry *policer;
 	struct dsa_mall_tc_entry *mall_tc_entry;
 	struct dsa_switch *ds = dp->ds;
@@ -1497,31 +1497,31 @@ dsa_slave_add_cls_matchall_police(struct net_device *dev,
 	return err;
 }
 
-static int dsa_slave_add_cls_matchall(struct net_device *dev,
-				      struct tc_cls_matchall_offload *cls,
-				      bool ingress)
+static int dsa_user_add_cls_matchall(struct net_device *dev,
+				     struct tc_cls_matchall_offload *cls,
+				     bool ingress)
 {
 	int err = -EOPNOTSUPP;
 
 	if (cls->common.protocol == htons(ETH_P_ALL) &&
 	    flow_offload_has_one_action(&cls->rule->action) &&
 	    cls->rule->action.entries[0].id == FLOW_ACTION_MIRRED)
-		err = dsa_slave_add_cls_matchall_mirred(dev, cls, ingress);
+		err = dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
 	else if (flow_offload_has_one_action(&cls->rule->action) &&
 		 cls->rule->action.entries[0].id == FLOW_ACTION_POLICE)
-		err = dsa_slave_add_cls_matchall_police(dev, cls, ingress);
+		err = dsa_user_add_cls_matchall_police(dev, cls, ingress);
 
 	return err;
 }
 
-static void dsa_slave_del_cls_matchall(struct net_device *dev,
-				       struct tc_cls_matchall_offload *cls)
+static void dsa_user_del_cls_matchall(struct net_device *dev,
+				      struct tc_cls_matchall_offload *cls)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_mall_tc_entry *mall_tc_entry;
 	struct dsa_switch *ds = dp->ds;
 
-	mall_tc_entry = dsa_slave_mall_tc_entry_find(dev, cls->cookie);
+	mall_tc_entry = dsa_user_mall_tc_entry_find(dev, cls->cookie);
 	if (!mall_tc_entry)
 		return;
 
@@ -1544,29 +1544,29 @@ static void dsa_slave_del_cls_matchall(struct net_device *dev,
 	kfree(mall_tc_entry);
 }
 
-static int dsa_slave_setup_tc_cls_matchall(struct net_device *dev,
-					   struct tc_cls_matchall_offload *cls,
-					   bool ingress)
+static int dsa_user_setup_tc_cls_matchall(struct net_device *dev,
+					  struct tc_cls_matchall_offload *cls,
+					  bool ingress)
 {
 	if (cls->common.chain_index)
 		return -EOPNOTSUPP;
 
 	switch (cls->command) {
 	case TC_CLSMATCHALL_REPLACE:
-		return dsa_slave_add_cls_matchall(dev, cls, ingress);
+		return dsa_user_add_cls_matchall(dev, cls, ingress);
 	case TC_CLSMATCHALL_DESTROY:
-		dsa_slave_del_cls_matchall(dev, cls);
+		dsa_user_del_cls_matchall(dev, cls);
 		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-static int dsa_slave_add_cls_flower(struct net_device *dev,
-				    struct flow_cls_offload *cls,
-				    bool ingress)
+static int dsa_user_add_cls_flower(struct net_device *dev,
+				   struct flow_cls_offload *cls,
+				   bool ingress)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
 
@@ -1576,11 +1576,11 @@ static int dsa_slave_add_cls_flower(struct net_device *dev,
 	return ds->ops->cls_flower_add(ds, port, cls, ingress);
 }
 
-static int dsa_slave_del_cls_flower(struct net_device *dev,
-				    struct flow_cls_offload *cls,
-				    bool ingress)
+static int dsa_user_del_cls_flower(struct net_device *dev,
+				   struct flow_cls_offload *cls,
+				   bool ingress)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
 
@@ -1590,11 +1590,11 @@ static int dsa_slave_del_cls_flower(struct net_device *dev,
 	return ds->ops->cls_flower_del(ds, port, cls, ingress);
 }
 
-static int dsa_slave_stats_cls_flower(struct net_device *dev,
-				      struct flow_cls_offload *cls,
-				      bool ingress)
+static int dsa_user_stats_cls_flower(struct net_device *dev,
+				     struct flow_cls_offload *cls,
+				     bool ingress)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
 
@@ -1604,24 +1604,24 @@ static int dsa_slave_stats_cls_flower(struct net_device *dev,
 	return ds->ops->cls_flower_stats(ds, port, cls, ingress);
 }
 
-static int dsa_slave_setup_tc_cls_flower(struct net_device *dev,
-					 struct flow_cls_offload *cls,
-					 bool ingress)
+static int dsa_user_setup_tc_cls_flower(struct net_device *dev,
+					struct flow_cls_offload *cls,
+					bool ingress)
 {
 	switch (cls->command) {
 	case FLOW_CLS_REPLACE:
-		return dsa_slave_add_cls_flower(dev, cls, ingress);
+		return dsa_user_add_cls_flower(dev, cls, ingress);
 	case FLOW_CLS_DESTROY:
-		return dsa_slave_del_cls_flower(dev, cls, ingress);
+		return dsa_user_del_cls_flower(dev, cls, ingress);
 	case FLOW_CLS_STATS:
-		return dsa_slave_stats_cls_flower(dev, cls, ingress);
+		return dsa_user_stats_cls_flower(dev, cls, ingress);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-static int dsa_slave_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
-				       void *cb_priv, bool ingress)
+static int dsa_user_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+				      void *cb_priv, bool ingress)
 {
 	struct net_device *dev = cb_priv;
 
@@ -1630,46 +1630,46 @@ static int dsa_slave_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 
 	switch (type) {
 	case TC_SETUP_CLSMATCHALL:
-		return dsa_slave_setup_tc_cls_matchall(dev, type_data, ingress);
+		return dsa_user_setup_tc_cls_matchall(dev, type_data, ingress);
 	case TC_SETUP_CLSFLOWER:
-		return dsa_slave_setup_tc_cls_flower(dev, type_data, ingress);
+		return dsa_user_setup_tc_cls_flower(dev, type_data, ingress);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-static int dsa_slave_setup_tc_block_cb_ig(enum tc_setup_type type,
-					  void *type_data, void *cb_priv)
+static int dsa_user_setup_tc_block_cb_ig(enum tc_setup_type type,
+					 void *type_data, void *cb_priv)
 {
-	return dsa_slave_setup_tc_block_cb(type, type_data, cb_priv, true);
+	return dsa_user_setup_tc_block_cb(type, type_data, cb_priv, true);
 }
 
-static int dsa_slave_setup_tc_block_cb_eg(enum tc_setup_type type,
-					  void *type_data, void *cb_priv)
+static int dsa_user_setup_tc_block_cb_eg(enum tc_setup_type type,
+					 void *type_data, void *cb_priv)
 {
-	return dsa_slave_setup_tc_block_cb(type, type_data, cb_priv, false);
+	return dsa_user_setup_tc_block_cb(type, type_data, cb_priv, false);
 }
 
-static LIST_HEAD(dsa_slave_block_cb_list);
+static LIST_HEAD(dsa_user_block_cb_list);
 
-static int dsa_slave_setup_tc_block(struct net_device *dev,
-				    struct flow_block_offload *f)
+static int dsa_user_setup_tc_block(struct net_device *dev,
+				   struct flow_block_offload *f)
 {
 	struct flow_block_cb *block_cb;
 	flow_setup_cb_t *cb;
 
 	if (f->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
-		cb = dsa_slave_setup_tc_block_cb_ig;
+		cb = dsa_user_setup_tc_block_cb_ig;
 	else if (f->binder_type == FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS)
-		cb = dsa_slave_setup_tc_block_cb_eg;
+		cb = dsa_user_setup_tc_block_cb_eg;
 	else
 		return -EOPNOTSUPP;
 
-	f->driver_block_list = &dsa_slave_block_cb_list;
+	f->driver_block_list = &dsa_user_block_cb_list;
 
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
-		if (flow_block_cb_is_busy(cb, dev, &dsa_slave_block_cb_list))
+		if (flow_block_cb_is_busy(cb, dev, &dsa_user_block_cb_list))
 			return -EBUSY;
 
 		block_cb = flow_block_cb_alloc(cb, dev, dev, NULL);
@@ -1677,7 +1677,7 @@ static int dsa_slave_setup_tc_block(struct net_device *dev,
 			return PTR_ERR(block_cb);
 
 		flow_block_cb_add(block_cb, f);
-		list_add_tail(&block_cb->driver_list, &dsa_slave_block_cb_list);
+		list_add_tail(&block_cb->driver_list, &dsa_user_block_cb_list);
 		return 0;
 	case FLOW_BLOCK_UNBIND:
 		block_cb = flow_block_cb_lookup(f->block, cb, dev);
@@ -1692,28 +1692,28 @@ static int dsa_slave_setup_tc_block(struct net_device *dev,
 	}
 }
 
-static int dsa_slave_setup_ft_block(struct dsa_switch *ds, int port,
-				    void *type_data)
+static int dsa_user_setup_ft_block(struct dsa_switch *ds, int port,
+				   void *type_data)
 {
-	struct net_device *master = dsa_port_to_master(dsa_to_port(ds, port));
+	struct net_device *conduit = dsa_port_to_conduit(dsa_to_port(ds, port));
 
-	if (!master->netdev_ops->ndo_setup_tc)
+	if (!conduit->netdev_ops->ndo_setup_tc)
 		return -EOPNOTSUPP;
 
-	return master->netdev_ops->ndo_setup_tc(master, TC_SETUP_FT, type_data);
+	return conduit->netdev_ops->ndo_setup_tc(conduit, TC_SETUP_FT, type_data);
 }
 
-static int dsa_slave_setup_tc(struct net_device *dev, enum tc_setup_type type,
-			      void *type_data)
+static int dsa_user_setup_tc(struct net_device *dev, enum tc_setup_type type,
+			     void *type_data)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	switch (type) {
 	case TC_SETUP_BLOCK:
-		return dsa_slave_setup_tc_block(dev, type_data);
+		return dsa_user_setup_tc_block(dev, type_data);
 	case TC_SETUP_FT:
-		return dsa_slave_setup_ft_block(ds, dp->index, type_data);
+		return dsa_user_setup_ft_block(ds, dp->index, type_data);
 	default:
 		break;
 	}
@@ -1724,10 +1724,10 @@ static int dsa_slave_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	return ds->ops->port_setup_tc(ds, dp->index, type, type_data);
 }
 
-static int dsa_slave_get_rxnfc(struct net_device *dev,
-			       struct ethtool_rxnfc *nfc, u32 *rule_locs)
+static int dsa_user_get_rxnfc(struct net_device *dev,
+			      struct ethtool_rxnfc *nfc, u32 *rule_locs)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->get_rxnfc)
@@ -1736,10 +1736,10 @@ static int dsa_slave_get_rxnfc(struct net_device *dev,
 	return ds->ops->get_rxnfc(ds, dp->index, nfc, rule_locs);
 }
 
-static int dsa_slave_set_rxnfc(struct net_device *dev,
-			       struct ethtool_rxnfc *nfc)
+static int dsa_user_set_rxnfc(struct net_device *dev,
+			      struct ethtool_rxnfc *nfc)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->set_rxnfc)
@@ -1748,10 +1748,10 @@ static int dsa_slave_set_rxnfc(struct net_device *dev,
 	return ds->ops->set_rxnfc(ds, dp->index, nfc);
 }
 
-static int dsa_slave_get_ts_info(struct net_device *dev,
-				 struct ethtool_ts_info *ts)
+static int dsa_user_get_ts_info(struct net_device *dev,
+				struct ethtool_ts_info *ts)
 {
-	struct dsa_slave_priv *p = netdev_priv(dev);
+	struct dsa_user_priv *p = netdev_priv(dev);
 	struct dsa_switch *ds = p->dp->ds;
 
 	if (!ds->ops->get_ts_info)
@@ -1760,10 +1760,10 @@ static int dsa_slave_get_ts_info(struct net_device *dev,
 	return ds->ops->get_ts_info(ds, p->dp->index, ts);
 }
 
-static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
-				     u16 vid)
+static int dsa_user_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
+				    u16 vid)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_vlan vlan = {
 		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
 		.vid = vid,
@@ -1810,15 +1810,15 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 
 	if (dsa_switch_supports_mc_filtering(ds)) {
 		netdev_for_each_synced_mc_addr(ha, dev) {
-			dsa_slave_schedule_standalone_work(dev, DSA_MC_ADD,
-							   ha->addr, vid);
+			dsa_user_schedule_standalone_work(dev, DSA_MC_ADD,
+							  ha->addr, vid);
 		}
 	}
 
 	if (dsa_switch_supports_uc_filtering(ds)) {
 		netdev_for_each_synced_uc_addr(ha, dev) {
-			dsa_slave_schedule_standalone_work(dev, DSA_UC_ADD,
-							   ha->addr, vid);
+			dsa_user_schedule_standalone_work(dev, DSA_UC_ADD,
+							  ha->addr, vid);
 		}
 	}
 
@@ -1835,10 +1835,10 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 	return ret;
 }
 
-static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
-				      u16 vid)
+static int dsa_user_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
+				     u16 vid)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct switchdev_obj_port_vlan vlan = {
 		.vid = vid,
 		/* This API only allows programming tagged, non-PVID VIDs */
@@ -1874,15 +1874,15 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 
 	if (dsa_switch_supports_mc_filtering(ds)) {
 		netdev_for_each_synced_mc_addr(ha, dev) {
-			dsa_slave_schedule_standalone_work(dev, DSA_MC_DEL,
-							   ha->addr, vid);
+			dsa_user_schedule_standalone_work(dev, DSA_MC_DEL,
+							  ha->addr, vid);
 		}
 	}
 
 	if (dsa_switch_supports_uc_filtering(ds)) {
 		netdev_for_each_synced_uc_addr(ha, dev) {
-			dsa_slave_schedule_standalone_work(dev, DSA_UC_DEL,
-							   ha->addr, vid);
+			dsa_user_schedule_standalone_work(dev, DSA_UC_DEL,
+							  ha->addr, vid);
 		}
 	}
 
@@ -1893,18 +1893,18 @@ static int dsa_slave_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	return 0;
 }
 
-static int dsa_slave_restore_vlan(struct net_device *vdev, int vid, void *arg)
+static int dsa_user_restore_vlan(struct net_device *vdev, int vid, void *arg)
 {
 	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
 
-	return dsa_slave_vlan_rx_add_vid(arg, proto, vid);
+	return dsa_user_vlan_rx_add_vid(arg, proto, vid);
 }
 
-static int dsa_slave_clear_vlan(struct net_device *vdev, int vid, void *arg)
+static int dsa_user_clear_vlan(struct net_device *vdev, int vid, void *arg)
 {
 	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
 
-	return dsa_slave_vlan_rx_kill_vid(arg, proto, vid);
+	return dsa_user_vlan_rx_kill_vid(arg, proto, vid);
 }
 
 /* Keep the VLAN RX filtering list in sync with the hardware only if VLAN
@@ -1938,26 +1938,26 @@ static int dsa_slave_clear_vlan(struct net_device *vdev, int vid, void *arg)
  *     - the bridge VLANs
  *     - the 8021q upper VLANs
  */
-int dsa_slave_manage_vlan_filtering(struct net_device *slave,
-				    bool vlan_filtering)
+int dsa_user_manage_vlan_filtering(struct net_device *user,
+				   bool vlan_filtering)
 {
 	int err;
 
 	if (vlan_filtering) {
-		slave->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
-		err = vlan_for_each(slave, dsa_slave_restore_vlan, slave);
+		err = vlan_for_each(user, dsa_user_restore_vlan, user);
 		if (err) {
-			vlan_for_each(slave, dsa_slave_clear_vlan, slave);
-			slave->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+			vlan_for_each(user, dsa_user_clear_vlan, user);
+			user->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
 			return err;
 		}
 	} else {
-		err = vlan_for_each(slave, dsa_slave_clear_vlan, slave);
+		err = vlan_for_each(user, dsa_user_clear_vlan, user);
 		if (err)
 			return err;
 
-		slave->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+		user->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
 	}
 
 	return 0;
@@ -2028,7 +2028,7 @@ static void dsa_bridge_mtu_normalization(struct dsa_port *dp)
 	list_for_each_entry(dst, &dsa_tree_list, list) {
 		list_for_each_entry(other_dp, &dst->ports, list) {
 			struct dsa_hw_port *hw_port;
-			struct net_device *slave;
+			struct net_device *user;
 
 			if (other_dp->type != DSA_PORT_TYPE_USER)
 				continue;
@@ -2039,17 +2039,17 @@ static void dsa_bridge_mtu_normalization(struct dsa_port *dp)
 			if (!other_dp->ds->mtu_enforcement_ingress)
 				continue;
 
-			slave = other_dp->slave;
+			user = other_dp->user;
 
-			if (min_mtu > slave->mtu)
-				min_mtu = slave->mtu;
+			if (min_mtu > user->mtu)
+				min_mtu = user->mtu;
 
 			hw_port = kzalloc(sizeof(*hw_port), GFP_KERNEL);
 			if (!hw_port)
 				goto out;
 
-			hw_port->dev = slave;
-			hw_port->old_mtu = slave->mtu;
+			hw_port->dev = user;
+			hw_port->old_mtu = user->mtu;
 
 			list_add(&hw_port->list, &hw_port_list);
 		}
@@ -2059,7 +2059,7 @@ static void dsa_bridge_mtu_normalization(struct dsa_port *dp)
 	 * interface's MTU first, regardless of whether the intention of the
 	 * user was to raise or lower it.
 	 */
-	err = dsa_hw_port_list_set_mtu(&hw_port_list, dp->slave->mtu);
+	err = dsa_hw_port_list_set_mtu(&hw_port_list, dp->user->mtu);
 	if (!err)
 		goto out;
 
@@ -2073,16 +2073,16 @@ static void dsa_bridge_mtu_normalization(struct dsa_port *dp)
 	dsa_hw_port_list_free(&hw_port_list);
 }
 
-int dsa_slave_change_mtu(struct net_device *dev, int new_mtu)
+int dsa_user_change_mtu(struct net_device *dev, int new_mtu)
 {
-	struct net_device *master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_port *cpu_dp = dp->cpu_dp;
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_port *other_dp;
 	int largest_mtu = 0;
-	int new_master_mtu;
-	int old_master_mtu;
+	int new_conduit_mtu;
+	int old_conduit_mtu;
 	int mtu_limit;
 	int overhead;
 	int cpu_mtu;
@@ -2092,44 +2092,44 @@ int dsa_slave_change_mtu(struct net_device *dev, int new_mtu)
 		return -EOPNOTSUPP;
 
 	dsa_tree_for_each_user_port(other_dp, ds->dst) {
-		int slave_mtu;
+		int user_mtu;
 
-		/* During probe, this function will be called for each slave
+		/* During probe, this function will be called for each user
 		 * device, while not all of them have been allocated. That's
 		 * ok, it doesn't change what the maximum is, so ignore it.
 		 */
-		if (!other_dp->slave)
+		if (!other_dp->user)
 			continue;
 
 		/* Pretend that we already applied the setting, which we
 		 * actually haven't (still haven't done all integrity checks)
 		 */
 		if (dp == other_dp)
-			slave_mtu = new_mtu;
+			user_mtu = new_mtu;
 		else
-			slave_mtu = other_dp->slave->mtu;
+			user_mtu = other_dp->user->mtu;
 
-		if (largest_mtu < slave_mtu)
-			largest_mtu = slave_mtu;
+		if (largest_mtu < user_mtu)
+			largest_mtu = user_mtu;
 	}
 
 	overhead = dsa_tag_protocol_overhead(cpu_dp->tag_ops);
-	mtu_limit = min_t(int, master->max_mtu, dev->max_mtu + overhead);
-	old_master_mtu = master->mtu;
-	new_master_mtu = largest_mtu + overhead;
-	if (new_master_mtu > mtu_limit)
+	mtu_limit = min_t(int, conduit->max_mtu, dev->max_mtu + overhead);
+	old_conduit_mtu = conduit->mtu;
+	new_conduit_mtu = largest_mtu + overhead;
+	if (new_conduit_mtu > mtu_limit)
 		return -ERANGE;
 
-	/* If the master MTU isn't over limit, there's no need to check the CPU
+	/* If the conduit MTU isn't over limit, there's no need to check the CPU
 	 * MTU, since that surely isn't either.
 	 */
 	cpu_mtu = largest_mtu;
 
 	/* Start applying stuff */
-	if (new_master_mtu != old_master_mtu) {
-		err = dev_set_mtu(master, new_master_mtu);
+	if (new_conduit_mtu != old_conduit_mtu) {
+		err = dev_set_mtu(conduit, new_conduit_mtu);
 		if (err < 0)
-			goto out_master_failed;
+			goto out_conduit_failed;
 
 		/* We only need to propagate the MTU of the CPU port to
 		 * upstream switches, so emit a notifier which updates them.
@@ -2150,19 +2150,19 @@ int dsa_slave_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 
 out_port_failed:
-	if (new_master_mtu != old_master_mtu)
-		dsa_port_mtu_change(cpu_dp, old_master_mtu - overhead);
+	if (new_conduit_mtu != old_conduit_mtu)
+		dsa_port_mtu_change(cpu_dp, old_conduit_mtu - overhead);
 out_cpu_failed:
-	if (new_master_mtu != old_master_mtu)
-		dev_set_mtu(master, old_master_mtu);
-out_master_failed:
+	if (new_conduit_mtu != old_conduit_mtu)
+		dev_set_mtu(conduit, old_conduit_mtu);
+out_conduit_failed:
 	return err;
 }
 
 static int __maybe_unused
-dsa_slave_dcbnl_set_default_prio(struct net_device *dev, struct dcb_app *app)
+dsa_user_dcbnl_set_default_prio(struct net_device *dev, struct dcb_app *app)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	unsigned long mask, new_prio;
 	int err, port = dp->index;
@@ -2187,9 +2187,9 @@ dsa_slave_dcbnl_set_default_prio(struct net_device *dev, struct dcb_app *app)
 }
 
 static int __maybe_unused
-dsa_slave_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
+dsa_user_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	unsigned long mask, new_prio;
 	int err, port = dp->index;
@@ -2220,29 +2220,29 @@ dsa_slave_dcbnl_add_dscp_prio(struct net_device *dev, struct dcb_app *app)
 	return 0;
 }
 
-static int __maybe_unused dsa_slave_dcbnl_ieee_setapp(struct net_device *dev,
-						      struct dcb_app *app)
+static int __maybe_unused dsa_user_dcbnl_ieee_setapp(struct net_device *dev,
+						     struct dcb_app *app)
 {
 	switch (app->selector) {
 	case IEEE_8021QAZ_APP_SEL_ETHERTYPE:
 		switch (app->protocol) {
 		case 0:
-			return dsa_slave_dcbnl_set_default_prio(dev, app);
+			return dsa_user_dcbnl_set_default_prio(dev, app);
 		default:
 			return -EOPNOTSUPP;
 		}
 		break;
 	case IEEE_8021QAZ_APP_SEL_DSCP:
-		return dsa_slave_dcbnl_add_dscp_prio(dev, app);
+		return dsa_user_dcbnl_add_dscp_prio(dev, app);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
 static int __maybe_unused
-dsa_slave_dcbnl_del_default_prio(struct net_device *dev, struct dcb_app *app)
+dsa_user_dcbnl_del_default_prio(struct net_device *dev, struct dcb_app *app)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	unsigned long mask, new_prio;
 	int err, port = dp->index;
@@ -2267,9 +2267,9 @@ dsa_slave_dcbnl_del_default_prio(struct net_device *dev, struct dcb_app *app)
 }
 
 static int __maybe_unused
-dsa_slave_dcbnl_del_dscp_prio(struct net_device *dev, struct dcb_app *app)
+dsa_user_dcbnl_del_dscp_prio(struct net_device *dev, struct dcb_app *app)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int err, port = dp->index;
 	u8 dscp = app->protocol;
@@ -2290,20 +2290,20 @@ dsa_slave_dcbnl_del_dscp_prio(struct net_device *dev, struct dcb_app *app)
 	return 0;
 }
 
-static int __maybe_unused dsa_slave_dcbnl_ieee_delapp(struct net_device *dev,
-						      struct dcb_app *app)
+static int __maybe_unused dsa_user_dcbnl_ieee_delapp(struct net_device *dev,
+						     struct dcb_app *app)
 {
 	switch (app->selector) {
 	case IEEE_8021QAZ_APP_SEL_ETHERTYPE:
 		switch (app->protocol) {
 		case 0:
-			return dsa_slave_dcbnl_del_default_prio(dev, app);
+			return dsa_user_dcbnl_del_default_prio(dev, app);
 		default:
 			return -EOPNOTSUPP;
 		}
 		break;
 	case IEEE_8021QAZ_APP_SEL_DSCP:
-		return dsa_slave_dcbnl_del_dscp_prio(dev, app);
+		return dsa_user_dcbnl_del_dscp_prio(dev, app);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2312,9 +2312,9 @@ static int __maybe_unused dsa_slave_dcbnl_ieee_delapp(struct net_device *dev,
 /* Pre-populate the DCB application priority table with the priorities
  * configured during switch setup, which we read from hardware here.
  */
-static int dsa_slave_dcbnl_init(struct net_device *dev)
+static int dsa_user_dcbnl_init(struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	int port = dp->index;
 	int err;
@@ -2362,49 +2362,49 @@ static int dsa_slave_dcbnl_init(struct net_device *dev)
 	return 0;
 }
 
-static const struct ethtool_ops dsa_slave_ethtool_ops = {
-	.get_drvinfo		= dsa_slave_get_drvinfo,
-	.get_regs_len		= dsa_slave_get_regs_len,
-	.get_regs		= dsa_slave_get_regs,
-	.nway_reset		= dsa_slave_nway_reset,
+static const struct ethtool_ops dsa_user_ethtool_ops = {
+	.get_drvinfo		= dsa_user_get_drvinfo,
+	.get_regs_len		= dsa_user_get_regs_len,
+	.get_regs		= dsa_user_get_regs,
+	.nway_reset		= dsa_user_nway_reset,
 	.get_link		= ethtool_op_get_link,
-	.get_eeprom_len		= dsa_slave_get_eeprom_len,
-	.get_eeprom		= dsa_slave_get_eeprom,
-	.set_eeprom		= dsa_slave_set_eeprom,
-	.get_strings		= dsa_slave_get_strings,
-	.get_ethtool_stats	= dsa_slave_get_ethtool_stats,
-	.get_sset_count		= dsa_slave_get_sset_count,
-	.get_eth_phy_stats	= dsa_slave_get_eth_phy_stats,
-	.get_eth_mac_stats	= dsa_slave_get_eth_mac_stats,
-	.get_eth_ctrl_stats	= dsa_slave_get_eth_ctrl_stats,
-	.get_rmon_stats		= dsa_slave_get_rmon_stats,
-	.set_wol		= dsa_slave_set_wol,
-	.get_wol		= dsa_slave_get_wol,
-	.set_eee		= dsa_slave_set_eee,
-	.get_eee		= dsa_slave_get_eee,
-	.get_link_ksettings	= dsa_slave_get_link_ksettings,
-	.set_link_ksettings	= dsa_slave_set_link_ksettings,
-	.get_pause_stats	= dsa_slave_get_pause_stats,
-	.get_pauseparam		= dsa_slave_get_pauseparam,
-	.set_pauseparam		= dsa_slave_set_pauseparam,
-	.get_rxnfc		= dsa_slave_get_rxnfc,
-	.set_rxnfc		= dsa_slave_set_rxnfc,
-	.get_ts_info		= dsa_slave_get_ts_info,
-	.self_test		= dsa_slave_net_selftest,
-	.get_mm			= dsa_slave_get_mm,
-	.set_mm			= dsa_slave_set_mm,
-	.get_mm_stats		= dsa_slave_get_mm_stats,
+	.get_eeprom_len		= dsa_user_get_eeprom_len,
+	.get_eeprom		= dsa_user_get_eeprom,
+	.set_eeprom		= dsa_user_set_eeprom,
+	.get_strings		= dsa_user_get_strings,
+	.get_ethtool_stats	= dsa_user_get_ethtool_stats,
+	.get_sset_count		= dsa_user_get_sset_count,
+	.get_eth_phy_stats	= dsa_user_get_eth_phy_stats,
+	.get_eth_mac_stats	= dsa_user_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= dsa_user_get_eth_ctrl_stats,
+	.get_rmon_stats		= dsa_user_get_rmon_stats,
+	.set_wol		= dsa_user_set_wol,
+	.get_wol		= dsa_user_get_wol,
+	.set_eee		= dsa_user_set_eee,
+	.get_eee		= dsa_user_get_eee,
+	.get_link_ksettings	= dsa_user_get_link_ksettings,
+	.set_link_ksettings	= dsa_user_set_link_ksettings,
+	.get_pause_stats	= dsa_user_get_pause_stats,
+	.get_pauseparam		= dsa_user_get_pauseparam,
+	.set_pauseparam		= dsa_user_set_pauseparam,
+	.get_rxnfc		= dsa_user_get_rxnfc,
+	.set_rxnfc		= dsa_user_set_rxnfc,
+	.get_ts_info		= dsa_user_get_ts_info,
+	.self_test		= dsa_user_net_selftest,
+	.get_mm			= dsa_user_get_mm,
+	.set_mm			= dsa_user_set_mm,
+	.get_mm_stats		= dsa_user_get_mm_stats,
 };
 
-static const struct dcbnl_rtnl_ops __maybe_unused dsa_slave_dcbnl_ops = {
-	.ieee_setapp		= dsa_slave_dcbnl_ieee_setapp,
-	.ieee_delapp		= dsa_slave_dcbnl_ieee_delapp,
+static const struct dcbnl_rtnl_ops __maybe_unused dsa_user_dcbnl_ops = {
+	.ieee_setapp		= dsa_user_dcbnl_ieee_setapp,
+	.ieee_delapp		= dsa_user_dcbnl_ieee_delapp,
 };
 
-static void dsa_slave_get_stats64(struct net_device *dev,
-				  struct rtnl_link_stats64 *s)
+static void dsa_user_get_stats64(struct net_device *dev,
+				 struct rtnl_link_stats64 *s)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 
 	if (ds->ops->get_stats64)
@@ -2413,43 +2413,43 @@ static void dsa_slave_get_stats64(struct net_device *dev,
 		dev_get_tstats64(dev, s);
 }
 
-static int dsa_slave_fill_forward_path(struct net_device_path_ctx *ctx,
-				       struct net_device_path *path)
+static int dsa_user_fill_forward_path(struct net_device_path_ctx *ctx,
+				      struct net_device_path *path)
 {
-	struct dsa_port *dp = dsa_slave_to_port(ctx->dev);
-	struct net_device *master = dsa_port_to_master(dp);
+	struct dsa_port *dp = dsa_user_to_port(ctx->dev);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
 	struct dsa_port *cpu_dp = dp->cpu_dp;
 
 	path->dev = ctx->dev;
 	path->type = DEV_PATH_DSA;
 	path->dsa.proto = cpu_dp->tag_ops->proto;
 	path->dsa.port = dp->index;
-	ctx->dev = master;
+	ctx->dev = conduit;
 
 	return 0;
 }
 
-static const struct net_device_ops dsa_slave_netdev_ops = {
-	.ndo_open	 	= dsa_slave_open,
-	.ndo_stop		= dsa_slave_close,
-	.ndo_start_xmit		= dsa_slave_xmit,
-	.ndo_change_rx_flags	= dsa_slave_change_rx_flags,
-	.ndo_set_rx_mode	= dsa_slave_set_rx_mode,
-	.ndo_set_mac_address	= dsa_slave_set_mac_address,
-	.ndo_fdb_dump		= dsa_slave_fdb_dump,
-	.ndo_eth_ioctl		= dsa_slave_ioctl,
-	.ndo_get_iflink		= dsa_slave_get_iflink,
+static const struct net_device_ops dsa_user_netdev_ops = {
+	.ndo_open		= dsa_user_open,
+	.ndo_stop		= dsa_user_close,
+	.ndo_start_xmit		= dsa_user_xmit,
+	.ndo_change_rx_flags	= dsa_user_change_rx_flags,
+	.ndo_set_rx_mode	= dsa_user_set_rx_mode,
+	.ndo_set_mac_address	= dsa_user_set_mac_address,
+	.ndo_fdb_dump		= dsa_user_fdb_dump,
+	.ndo_eth_ioctl		= dsa_user_ioctl,
+	.ndo_get_iflink		= dsa_user_get_iflink,
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_netpoll_setup	= dsa_slave_netpoll_setup,
-	.ndo_netpoll_cleanup	= dsa_slave_netpoll_cleanup,
-	.ndo_poll_controller	= dsa_slave_poll_controller,
+	.ndo_netpoll_setup	= dsa_user_netpoll_setup,
+	.ndo_netpoll_cleanup	= dsa_user_netpoll_cleanup,
+	.ndo_poll_controller	= dsa_user_poll_controller,
 #endif
-	.ndo_setup_tc		= dsa_slave_setup_tc,
-	.ndo_get_stats64	= dsa_slave_get_stats64,
-	.ndo_vlan_rx_add_vid	= dsa_slave_vlan_rx_add_vid,
-	.ndo_vlan_rx_kill_vid	= dsa_slave_vlan_rx_kill_vid,
-	.ndo_change_mtu		= dsa_slave_change_mtu,
-	.ndo_fill_forward_path	= dsa_slave_fill_forward_path,
+	.ndo_setup_tc		= dsa_user_setup_tc,
+	.ndo_get_stats64	= dsa_user_get_stats64,
+	.ndo_vlan_rx_add_vid	= dsa_user_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= dsa_user_vlan_rx_kill_vid,
+	.ndo_change_mtu		= dsa_user_change_mtu,
+	.ndo_fill_forward_path	= dsa_user_fill_forward_path,
 };
 
 static struct device_type dsa_type = {
@@ -2465,8 +2465,8 @@ void dsa_port_phylink_mac_change(struct dsa_switch *ds, int port, bool up)
 }
 EXPORT_SYMBOL_GPL(dsa_port_phylink_mac_change);
 
-static void dsa_slave_phylink_fixed_state(struct phylink_config *config,
-					  struct phylink_link_state *state)
+static void dsa_user_phylink_fixed_state(struct phylink_config *config,
+					 struct phylink_link_state *state)
 {
 	struct dsa_port *dp = container_of(config, struct dsa_port, pl_config);
 	struct dsa_switch *ds = dp->ds;
@@ -2477,33 +2477,33 @@ static void dsa_slave_phylink_fixed_state(struct phylink_config *config,
 	ds->ops->phylink_fixed_state(ds, dp->index, state);
 }
 
-/* slave device setup *******************************************************/
-static int dsa_slave_phy_connect(struct net_device *slave_dev, int addr,
-				 u32 flags)
+/* user device setup *******************************************************/
+static int dsa_user_phy_connect(struct net_device *user_dev, int addr,
+				u32 flags)
 {
-	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
+	struct dsa_port *dp = dsa_user_to_port(user_dev);
 	struct dsa_switch *ds = dp->ds;
 
-	slave_dev->phydev = mdiobus_get_phy(ds->slave_mii_bus, addr);
-	if (!slave_dev->phydev) {
-		netdev_err(slave_dev, "no phy at %d\n", addr);
+	user_dev->phydev = mdiobus_get_phy(ds->user_mii_bus, addr);
+	if (!user_dev->phydev) {
+		netdev_err(user_dev, "no phy at %d\n", addr);
 		return -ENODEV;
 	}
 
-	slave_dev->phydev->dev_flags |= flags;
+	user_dev->phydev->dev_flags |= flags;
 
-	return phylink_connect_phy(dp->pl, slave_dev->phydev);
+	return phylink_connect_phy(dp->pl, user_dev->phydev);
 }
 
-static int dsa_slave_phy_setup(struct net_device *slave_dev)
+static int dsa_user_phy_setup(struct net_device *user_dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
+	struct dsa_port *dp = dsa_user_to_port(user_dev);
 	struct device_node *port_dn = dp->dn;
 	struct dsa_switch *ds = dp->ds;
 	u32 phy_flags = 0;
 	int ret;
 
-	dp->pl_config.dev = &slave_dev->dev;
+	dp->pl_config.dev = &user_dev->dev;
 	dp->pl_config.type = PHYLINK_NETDEV;
 
 	/* The get_fixed_state callback takes precedence over polling the
@@ -2511,7 +2511,7 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
 	 * this if the switch provides such a callback.
 	 */
 	if (ds->ops->phylink_fixed_state) {
-		dp->pl_config.get_fixed_state = dsa_slave_phylink_fixed_state;
+		dp->pl_config.get_fixed_state = dsa_user_phylink_fixed_state;
 		dp->pl_config.poll_fixed_state = true;
 	}
 
@@ -2523,14 +2523,14 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
 		phy_flags = ds->ops->get_phy_flags(ds, dp->index);
 
 	ret = phylink_of_phy_connect(dp->pl, port_dn, phy_flags);
-	if (ret == -ENODEV && ds->slave_mii_bus) {
+	if (ret == -ENODEV && ds->user_mii_bus) {
 		/* We could not connect to a designated PHY or SFP, so try to
 		 * use the switch internal MDIO bus instead
 		 */
-		ret = dsa_slave_phy_connect(slave_dev, dp->index, phy_flags);
+		ret = dsa_user_phy_connect(user_dev, dp->index, phy_flags);
 	}
 	if (ret) {
-		netdev_err(slave_dev, "failed to connect to PHY: %pe\n",
+		netdev_err(user_dev, "failed to connect to PHY: %pe\n",
 			   ERR_PTR(ret));
 		dsa_port_phylink_destroy(dp);
 	}
@@ -2538,42 +2538,42 @@ static int dsa_slave_phy_setup(struct net_device *slave_dev)
 	return ret;
 }
 
-void dsa_slave_setup_tagger(struct net_device *slave)
+void dsa_user_setup_tagger(struct net_device *user)
 {
-	struct dsa_port *dp = dsa_slave_to_port(slave);
-	struct net_device *master = dsa_port_to_master(dp);
-	struct dsa_slave_priv *p = netdev_priv(slave);
+	struct dsa_port *dp = dsa_user_to_port(user);
+	struct net_device *conduit = dsa_port_to_conduit(dp);
+	struct dsa_user_priv *p = netdev_priv(user);
 	const struct dsa_port *cpu_dp = dp->cpu_dp;
 	const struct dsa_switch *ds = dp->ds;
 
-	slave->needed_headroom = cpu_dp->tag_ops->needed_headroom;
-	slave->needed_tailroom = cpu_dp->tag_ops->needed_tailroom;
-	/* Try to save one extra realloc later in the TX path (in the master)
-	 * by also inheriting the master's needed headroom and tailroom.
+	user->needed_headroom = cpu_dp->tag_ops->needed_headroom;
+	user->needed_tailroom = cpu_dp->tag_ops->needed_tailroom;
+	/* Try to save one extra realloc later in the TX path (in the conduit)
+	 * by also inheriting the conduit's needed headroom and tailroom.
 	 * The 8021q driver also does this.
 	 */
-	slave->needed_headroom += master->needed_headroom;
-	slave->needed_tailroom += master->needed_tailroom;
+	user->needed_headroom += conduit->needed_headroom;
+	user->needed_tailroom += conduit->needed_tailroom;
 
 	p->xmit = cpu_dp->tag_ops->xmit;
 
-	slave->features = master->vlan_features | NETIF_F_HW_TC;
-	slave->hw_features |= NETIF_F_HW_TC;
-	slave->features |= NETIF_F_LLTX;
-	if (slave->needed_tailroom)
-		slave->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
+	user->features = conduit->vlan_features | NETIF_F_HW_TC;
+	user->hw_features |= NETIF_F_HW_TC;
+	user->features |= NETIF_F_LLTX;
+	if (user->needed_tailroom)
+		user->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
 	if (ds->needs_standalone_vlan_filtering)
-		slave->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+		user->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 }
 
-int dsa_slave_suspend(struct net_device *slave_dev)
+int dsa_user_suspend(struct net_device *user_dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
+	struct dsa_port *dp = dsa_user_to_port(user_dev);
 
-	if (!netif_running(slave_dev))
+	if (!netif_running(user_dev))
 		return 0;
 
-	netif_device_detach(slave_dev);
+	netif_device_detach(user_dev);
 
 	rtnl_lock();
 	phylink_stop(dp->pl);
@@ -2582,14 +2582,14 @@ int dsa_slave_suspend(struct net_device *slave_dev)
 	return 0;
 }
 
-int dsa_slave_resume(struct net_device *slave_dev)
+int dsa_user_resume(struct net_device *user_dev)
 {
-	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
+	struct dsa_port *dp = dsa_user_to_port(user_dev);
 
-	if (!netif_running(slave_dev))
+	if (!netif_running(user_dev))
 		return 0;
 
-	netif_device_attach(slave_dev);
+	netif_device_attach(user_dev);
 
 	rtnl_lock();
 	phylink_start(dp->pl);
@@ -2598,12 +2598,12 @@ int dsa_slave_resume(struct net_device *slave_dev)
 	return 0;
 }
 
-int dsa_slave_create(struct dsa_port *port)
+int dsa_user_create(struct dsa_port *port)
 {
-	struct net_device *master = dsa_port_to_master(port);
+	struct net_device *conduit = dsa_port_to_conduit(port);
 	struct dsa_switch *ds = port->ds;
-	struct net_device *slave_dev;
-	struct dsa_slave_priv *p;
+	struct net_device *user_dev;
+	struct dsa_user_priv *p;
 	const char *name;
 	int assign_type;
 	int ret;
@@ -2619,55 +2619,55 @@ int dsa_slave_create(struct dsa_port *port)
 		assign_type = NET_NAME_ENUM;
 	}
 
-	slave_dev = alloc_netdev_mqs(sizeof(struct dsa_slave_priv), name,
-				     assign_type, ether_setup,
-				     ds->num_tx_queues, 1);
-	if (slave_dev == NULL)
+	user_dev = alloc_netdev_mqs(sizeof(struct dsa_user_priv), name,
+				    assign_type, ether_setup,
+				    ds->num_tx_queues, 1);
+	if (user_dev == NULL)
 		return -ENOMEM;
 
-	slave_dev->rtnl_link_ops = &dsa_link_ops;
-	slave_dev->ethtool_ops = &dsa_slave_ethtool_ops;
+	user_dev->rtnl_link_ops = &dsa_link_ops;
+	user_dev->ethtool_ops = &dsa_user_ethtool_ops;
 #if IS_ENABLED(CONFIG_DCB)
-	slave_dev->dcbnl_ops = &dsa_slave_dcbnl_ops;
+	user_dev->dcbnl_ops = &dsa_user_dcbnl_ops;
 #endif
 	if (!is_zero_ether_addr(port->mac))
-		eth_hw_addr_set(slave_dev, port->mac);
+		eth_hw_addr_set(user_dev, port->mac);
 	else
-		eth_hw_addr_inherit(slave_dev, master);
-	slave_dev->priv_flags |= IFF_NO_QUEUE;
+		eth_hw_addr_inherit(user_dev, conduit);
+	user_dev->priv_flags |= IFF_NO_QUEUE;
 	if (dsa_switch_supports_uc_filtering(ds))
-		slave_dev->priv_flags |= IFF_UNICAST_FLT;
-	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
+		user_dev->priv_flags |= IFF_UNICAST_FLT;
+	user_dev->netdev_ops = &dsa_user_netdev_ops;
 	if (ds->ops->port_max_mtu)
-		slave_dev->max_mtu = ds->ops->port_max_mtu(ds, port->index);
-	SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
-
-	SET_NETDEV_DEV(slave_dev, port->ds->dev);
-	SET_NETDEV_DEVLINK_PORT(slave_dev, &port->devlink_port);
-	slave_dev->dev.of_node = port->dn;
-	slave_dev->vlan_features = master->vlan_features;
-
-	p = netdev_priv(slave_dev);
-	slave_dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!slave_dev->tstats) {
-		free_netdev(slave_dev);
+		user_dev->max_mtu = ds->ops->port_max_mtu(ds, port->index);
+	SET_NETDEV_DEVTYPE(user_dev, &dsa_type);
+
+	SET_NETDEV_DEV(user_dev, port->ds->dev);
+	SET_NETDEV_DEVLINK_PORT(user_dev, &port->devlink_port);
+	user_dev->dev.of_node = port->dn;
+	user_dev->vlan_features = conduit->vlan_features;
+
+	p = netdev_priv(user_dev);
+	user_dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!user_dev->tstats) {
+		free_netdev(user_dev);
 		return -ENOMEM;
 	}
 
-	ret = gro_cells_init(&p->gcells, slave_dev);
+	ret = gro_cells_init(&p->gcells, user_dev);
 	if (ret)
 		goto out_free;
 
 	p->dp = port;
 	INIT_LIST_HEAD(&p->mall_tc_list);
-	port->slave = slave_dev;
-	dsa_slave_setup_tagger(slave_dev);
+	port->user = user_dev;
+	dsa_user_setup_tagger(user_dev);
 
-	netif_carrier_off(slave_dev);
+	netif_carrier_off(user_dev);
 
-	ret = dsa_slave_phy_setup(slave_dev);
+	ret = dsa_user_phy_setup(user_dev);
 	if (ret) {
-		netdev_err(slave_dev,
+		netdev_err(user_dev,
 			   "error %d setting up PHY for tree %d, switch %d, port %d\n",
 			   ret, ds->dst->index, ds->index, port->index);
 		goto out_gcells;
@@ -2675,23 +2675,23 @@ int dsa_slave_create(struct dsa_port *port)
 
 	rtnl_lock();
 
-	ret = dsa_slave_change_mtu(slave_dev, ETH_DATA_LEN);
+	ret = dsa_user_change_mtu(user_dev, ETH_DATA_LEN);
 	if (ret && ret != -EOPNOTSUPP)
 		dev_warn(ds->dev, "nonfatal error %d setting MTU to %d on port %d\n",
 			 ret, ETH_DATA_LEN, port->index);
 
-	ret = register_netdevice(slave_dev);
+	ret = register_netdevice(user_dev);
 	if (ret) {
-		netdev_err(master, "error %d registering interface %s\n",
-			   ret, slave_dev->name);
+		netdev_err(conduit, "error %d registering interface %s\n",
+			   ret, user_dev->name);
 		rtnl_unlock();
 		goto out_phy;
 	}
 
 	if (IS_ENABLED(CONFIG_DCB)) {
-		ret = dsa_slave_dcbnl_init(slave_dev);
+		ret = dsa_user_dcbnl_init(user_dev);
 		if (ret) {
-			netdev_err(slave_dev,
+			netdev_err(user_dev,
 				   "failed to initialize DCB: %pe\n",
 				   ERR_PTR(ret));
 			rtnl_unlock();
@@ -2699,7 +2699,7 @@ int dsa_slave_create(struct dsa_port *port)
 		}
 	}
 
-	ret = netdev_upper_dev_link(master, slave_dev, NULL);
+	ret = netdev_upper_dev_link(conduit, user_dev, NULL);
 
 	rtnl_unlock();
 
@@ -2709,7 +2709,7 @@ int dsa_slave_create(struct dsa_port *port)
 	return 0;
 
 out_unregister:
-	unregister_netdev(slave_dev);
+	unregister_netdev(user_dev);
 out_phy:
 	rtnl_lock();
 	phylink_disconnect_phy(p->dp->pl);
@@ -2718,122 +2718,122 @@ int dsa_slave_create(struct dsa_port *port)
 out_gcells:
 	gro_cells_destroy(&p->gcells);
 out_free:
-	free_percpu(slave_dev->tstats);
-	free_netdev(slave_dev);
-	port->slave = NULL;
+	free_percpu(user_dev->tstats);
+	free_netdev(user_dev);
+	port->user = NULL;
 	return ret;
 }
 
-void dsa_slave_destroy(struct net_device *slave_dev)
+void dsa_user_destroy(struct net_device *user_dev)
 {
-	struct net_device *master = dsa_slave_to_master(slave_dev);
-	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
-	struct dsa_slave_priv *p = netdev_priv(slave_dev);
+	struct net_device *conduit = dsa_user_to_conduit(user_dev);
+	struct dsa_port *dp = dsa_user_to_port(user_dev);
+	struct dsa_user_priv *p = netdev_priv(user_dev);
 
-	netif_carrier_off(slave_dev);
+	netif_carrier_off(user_dev);
 	rtnl_lock();
-	netdev_upper_dev_unlink(master, slave_dev);
-	unregister_netdevice(slave_dev);
+	netdev_upper_dev_unlink(conduit, user_dev);
+	unregister_netdevice(user_dev);
 	phylink_disconnect_phy(dp->pl);
 	rtnl_unlock();
 
 	dsa_port_phylink_destroy(dp);
 	gro_cells_destroy(&p->gcells);
-	free_percpu(slave_dev->tstats);
-	free_netdev(slave_dev);
+	free_percpu(user_dev->tstats);
+	free_netdev(user_dev);
 }
 
-int dsa_slave_change_master(struct net_device *dev, struct net_device *master,
+int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 			    struct netlink_ext_ack *extack)
 {
-	struct net_device *old_master = dsa_slave_to_master(dev);
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct net_device *old_conduit = dsa_user_to_conduit(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct net_device *upper;
 	struct list_head *iter;
 	int err;
 
-	if (master == old_master)
+	if (conduit == old_conduit)
 		return 0;
 
-	if (!ds->ops->port_change_master) {
+	if (!ds->ops->port_change_conduit) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Driver does not support changing DSA master");
+				   "Driver does not support changing DSA conduit");
 		return -EOPNOTSUPP;
 	}
 
-	if (!netdev_uses_dsa(master)) {
+	if (!netdev_uses_dsa(conduit)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Interface not eligible as DSA master");
+				   "Interface not eligible as DSA conduit");
 		return -EOPNOTSUPP;
 	}
 
-	netdev_for_each_upper_dev_rcu(master, upper, iter) {
-		if (dsa_slave_dev_check(upper))
+	netdev_for_each_upper_dev_rcu(conduit, upper, iter) {
+		if (dsa_user_dev_check(upper))
 			continue;
 		if (netif_is_bridge_master(upper))
 			continue;
-		NL_SET_ERR_MSG_MOD(extack, "Cannot join master with unknown uppers");
+		NL_SET_ERR_MSG_MOD(extack, "Cannot join conduit with unknown uppers");
 		return -EOPNOTSUPP;
 	}
 
-	/* Since we allow live-changing the DSA master, plus we auto-open the
-	 * DSA master when the user port opens => we need to ensure that the
-	 * new DSA master is open too.
+	/* Since we allow live-changing the DSA conduit, plus we auto-open the
+	 * DSA conduit when the user port opens => we need to ensure that the
+	 * new DSA conduit is open too.
 	 */
 	if (dev->flags & IFF_UP) {
-		err = dev_open(master, extack);
+		err = dev_open(conduit, extack);
 		if (err)
 			return err;
 	}
 
-	netdev_upper_dev_unlink(old_master, dev);
+	netdev_upper_dev_unlink(old_conduit, dev);
 
-	err = netdev_upper_dev_link(master, dev, extack);
+	err = netdev_upper_dev_link(conduit, dev, extack);
 	if (err)
-		goto out_revert_old_master_unlink;
+		goto out_revert_old_conduit_unlink;
 
-	err = dsa_port_change_master(dp, master, extack);
+	err = dsa_port_change_conduit(dp, conduit, extack);
 	if (err)
-		goto out_revert_master_link;
+		goto out_revert_conduit_link;
 
 	/* Update the MTU of the new CPU port through cross-chip notifiers */
-	err = dsa_slave_change_mtu(dev, dev->mtu);
+	err = dsa_user_change_mtu(dev, dev->mtu);
 	if (err && err != -EOPNOTSUPP) {
 		netdev_warn(dev,
-			    "nonfatal error updating MTU with new master: %pe\n",
+			    "nonfatal error updating MTU with new conduit: %pe\n",
 			    ERR_PTR(err));
 	}
 
 	/* If the port doesn't have its own MAC address and relies on the DSA
-	 * master's one, inherit it again from the new DSA master.
+	 * conduit's one, inherit it again from the new DSA conduit.
 	 */
 	if (is_zero_ether_addr(dp->mac))
-		eth_hw_addr_inherit(dev, master);
+		eth_hw_addr_inherit(dev, conduit);
 
 	return 0;
 
-out_revert_master_link:
-	netdev_upper_dev_unlink(master, dev);
-out_revert_old_master_unlink:
-	netdev_upper_dev_link(old_master, dev, NULL);
+out_revert_conduit_link:
+	netdev_upper_dev_unlink(conduit, dev);
+out_revert_old_conduit_unlink:
+	netdev_upper_dev_link(old_conduit, dev, NULL);
 	return err;
 }
 
-bool dsa_slave_dev_check(const struct net_device *dev)
+bool dsa_user_dev_check(const struct net_device *dev)
 {
-	return dev->netdev_ops == &dsa_slave_netdev_ops;
+	return dev->netdev_ops == &dsa_user_netdev_ops;
 }
-EXPORT_SYMBOL_GPL(dsa_slave_dev_check);
+EXPORT_SYMBOL_GPL(dsa_user_dev_check);
 
-static int dsa_slave_changeupper(struct net_device *dev,
-				 struct netdev_notifier_changeupper_info *info)
+static int dsa_user_changeupper(struct net_device *dev,
+				struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
 
-	if (!dsa_slave_dev_check(dev))
+	if (!dsa_user_dev_check(dev))
 		return err;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
@@ -2885,12 +2885,12 @@ static int dsa_slave_changeupper(struct net_device *dev,
 	return err;
 }
 
-static int dsa_slave_prechangeupper(struct net_device *dev,
-				    struct netdev_notifier_changeupper_info *info)
+static int dsa_user_prechangeupper(struct net_device *dev,
+				   struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 
-	if (!dsa_slave_dev_check(dev))
+	if (!dsa_user_dev_check(dev))
 		return NOTIFY_DONE;
 
 	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
@@ -2898,15 +2898,15 @@ static int dsa_slave_prechangeupper(struct net_device *dev,
 	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
 		dsa_port_pre_lag_leave(dp, info->upper_dev);
 	/* dsa_port_pre_hsr_leave is not yet necessary since hsr cannot be
-	 * meaningfully enslaved to a bridge yet
+	 * meaningfully enuserd to a bridge yet
 	 */
 
 	return NOTIFY_DONE;
 }
 
 static int
-dsa_slave_lag_changeupper(struct net_device *dev,
-			  struct netdev_notifier_changeupper_info *info)
+dsa_user_lag_changeupper(struct net_device *dev,
+			 struct netdev_notifier_changeupper_info *info)
 {
 	struct net_device *lower;
 	struct list_head *iter;
@@ -2917,15 +2917,15 @@ dsa_slave_lag_changeupper(struct net_device *dev,
 		return err;
 
 	netdev_for_each_lower_dev(dev, lower, iter) {
-		if (!dsa_slave_dev_check(lower))
+		if (!dsa_user_dev_check(lower))
 			continue;
 
-		dp = dsa_slave_to_port(lower);
+		dp = dsa_user_to_port(lower);
 		if (!dp->lag)
 			/* Software LAG */
 			continue;
 
-		err = dsa_slave_changeupper(lower, info);
+		err = dsa_user_changeupper(lower, info);
 		if (notifier_to_errno(err))
 			break;
 	}
@@ -2933,12 +2933,12 @@ dsa_slave_lag_changeupper(struct net_device *dev,
 	return err;
 }
 
-/* Same as dsa_slave_lag_changeupper() except that it calls
- * dsa_slave_prechangeupper()
+/* Same as dsa_user_lag_changeupper() except that it calls
+ * dsa_user_prechangeupper()
  */
 static int
-dsa_slave_lag_prechangeupper(struct net_device *dev,
-			     struct netdev_notifier_changeupper_info *info)
+dsa_user_lag_prechangeupper(struct net_device *dev,
+			    struct netdev_notifier_changeupper_info *info)
 {
 	struct net_device *lower;
 	struct list_head *iter;
@@ -2949,15 +2949,15 @@ dsa_slave_lag_prechangeupper(struct net_device *dev,
 		return err;
 
 	netdev_for_each_lower_dev(dev, lower, iter) {
-		if (!dsa_slave_dev_check(lower))
+		if (!dsa_user_dev_check(lower))
 			continue;
 
-		dp = dsa_slave_to_port(lower);
+		dp = dsa_user_to_port(lower);
 		if (!dp->lag)
 			/* Software LAG */
 			continue;
 
-		err = dsa_slave_prechangeupper(lower, info);
+		err = dsa_user_prechangeupper(lower, info);
 		if (notifier_to_errno(err))
 			break;
 	}
@@ -2970,7 +2970,7 @@ dsa_prevent_bridging_8021q_upper(struct net_device *dev,
 				 struct netdev_notifier_changeupper_info *info)
 {
 	struct netlink_ext_ack *ext_ack;
-	struct net_device *slave, *br;
+	struct net_device *user, *br;
 	struct dsa_port *dp;
 
 	ext_ack = netdev_notifier_info_to_extack(&info->info);
@@ -2978,11 +2978,11 @@ dsa_prevent_bridging_8021q_upper(struct net_device *dev,
 	if (!is_vlan_dev(dev))
 		return NOTIFY_DONE;
 
-	slave = vlan_dev_real_dev(dev);
-	if (!dsa_slave_dev_check(slave))
+	user = vlan_dev_real_dev(dev);
+	if (!dsa_user_dev_check(user))
 		return NOTIFY_DONE;
 
-	dp = dsa_slave_to_port(slave);
+	dp = dsa_user_to_port(user);
 	br = dsa_port_bridge_dev_get(dp);
 	if (!br)
 		return NOTIFY_DONE;
@@ -2991,7 +2991,7 @@ dsa_prevent_bridging_8021q_upper(struct net_device *dev,
 	if (br_vlan_enabled(br) &&
 	    netif_is_bridge_master(info->upper_dev) && info->linking) {
 		NL_SET_ERR_MSG_MOD(ext_ack,
-				   "Cannot enslave VLAN device into VLAN aware bridge");
+				   "Cannot enuser VLAN device into VLAN aware bridge");
 		return notifier_from_errno(-EINVAL);
 	}
 
@@ -2999,10 +2999,10 @@ dsa_prevent_bridging_8021q_upper(struct net_device *dev,
 }
 
 static int
-dsa_slave_check_8021q_upper(struct net_device *dev,
-			    struct netdev_notifier_changeupper_info *info)
+dsa_user_check_8021q_upper(struct net_device *dev,
+			   struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct net_device *br = dsa_port_bridge_dev_get(dp);
 	struct bridge_vlan_info br_info;
 	struct netlink_ext_ack *extack;
@@ -3030,17 +3030,17 @@ dsa_slave_check_8021q_upper(struct net_device *dev,
 }
 
 static int
-dsa_slave_prechangeupper_sanity_check(struct net_device *dev,
-				      struct netdev_notifier_changeupper_info *info)
+dsa_user_prechangeupper_sanity_check(struct net_device *dev,
+				     struct netdev_notifier_changeupper_info *info)
 {
 	struct dsa_switch *ds;
 	struct dsa_port *dp;
 	int err;
 
-	if (!dsa_slave_dev_check(dev))
+	if (!dsa_user_dev_check(dev))
 		return dsa_prevent_bridging_8021q_upper(dev, info);
 
-	dp = dsa_slave_to_port(dev);
+	dp = dsa_user_to_port(dev);
 	ds = dp->ds;
 
 	if (ds->ops->port_prechangeupper) {
@@ -3050,17 +3050,17 @@ dsa_slave_prechangeupper_sanity_check(struct net_device *dev,
 	}
 
 	if (is_vlan_dev(info->upper_dev))
-		return dsa_slave_check_8021q_upper(dev, info);
+		return dsa_user_check_8021q_upper(dev, info);
 
 	return NOTIFY_DONE;
 }
 
-/* To be eligible as a DSA master, a LAG must have all lower interfaces be
- * eligible DSA masters. Additionally, all LAG slaves must be DSA masters of
+/* To be eligible as a DSA conduit, a LAG must have all lower interfaces be
+ * eligible DSA conduits. Additionally, all LAG users must be DSA conduits of
  * switches in the same switch tree.
  */
-static int dsa_lag_master_validate(struct net_device *lag_dev,
-				   struct netlink_ext_ack *extack)
+static int dsa_lag_conduit_validate(struct net_device *lag_dev,
+				    struct netlink_ext_ack *extack)
 {
 	struct net_device *lower1, *lower2;
 	struct list_head *iter1, *iter2;
@@ -3070,7 +3070,7 @@ static int dsa_lag_master_validate(struct net_device *lag_dev,
 			if (!netdev_uses_dsa(lower1) ||
 			    !netdev_uses_dsa(lower2)) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "All LAG ports must be eligible as DSA masters");
+						   "All LAG ports must be eligible as DSA conduits");
 				return notifier_from_errno(-EINVAL);
 			}
 
@@ -3080,7 +3080,7 @@ static int dsa_lag_master_validate(struct net_device *lag_dev,
 			if (!dsa_port_tree_same(lower1->dsa_ptr,
 						lower2->dsa_ptr)) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "LAG contains DSA masters of disjoint switch trees");
+						   "LAG contains DSA conduits of disjoint switch trees");
 				return notifier_from_errno(-EINVAL);
 			}
 		}
@@ -3090,41 +3090,41 @@ static int dsa_lag_master_validate(struct net_device *lag_dev,
 }
 
 static int
-dsa_master_prechangeupper_sanity_check(struct net_device *master,
-				       struct netdev_notifier_changeupper_info *info)
+dsa_conduit_prechangeupper_sanity_check(struct net_device *conduit,
+					struct netdev_notifier_changeupper_info *info)
 {
 	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(&info->info);
 
-	if (!netdev_uses_dsa(master))
+	if (!netdev_uses_dsa(conduit))
 		return NOTIFY_DONE;
 
 	if (!info->linking)
 		return NOTIFY_DONE;
 
 	/* Allow DSA switch uppers */
-	if (dsa_slave_dev_check(info->upper_dev))
+	if (dsa_user_dev_check(info->upper_dev))
 		return NOTIFY_DONE;
 
-	/* Allow bridge uppers of DSA masters, subject to further
+	/* Allow bridge uppers of DSA conduits, subject to further
 	 * restrictions in dsa_bridge_prechangelower_sanity_check()
 	 */
 	if (netif_is_bridge_master(info->upper_dev))
 		return NOTIFY_DONE;
 
 	/* Allow LAG uppers, subject to further restrictions in
-	 * dsa_lag_master_prechangelower_sanity_check()
+	 * dsa_lag_conduit_prechangelower_sanity_check()
 	 */
 	if (netif_is_lag_master(info->upper_dev))
-		return dsa_lag_master_validate(info->upper_dev, extack);
+		return dsa_lag_conduit_validate(info->upper_dev, extack);
 
 	NL_SET_ERR_MSG_MOD(extack,
-			   "DSA master cannot join unknown upper interfaces");
+			   "DSA conduit cannot join unknown upper interfaces");
 	return notifier_from_errno(-EBUSY);
 }
 
 static int
-dsa_lag_master_prechangelower_sanity_check(struct net_device *dev,
-					   struct netdev_notifier_changeupper_info *info)
+dsa_lag_conduit_prechangelower_sanity_check(struct net_device *dev,
+					    struct netdev_notifier_changeupper_info *info)
 {
 	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(&info->info);
 	struct net_device *lag_dev = info->upper_dev;
@@ -3139,14 +3139,14 @@ dsa_lag_master_prechangelower_sanity_check(struct net_device *dev,
 
 	if (!netdev_uses_dsa(dev)) {
 		NL_SET_ERR_MSG(extack,
-			       "Only DSA masters can join a LAG DSA master");
+			       "Only DSA conduits can join a LAG DSA conduit");
 		return notifier_from_errno(-EINVAL);
 	}
 
 	netdev_for_each_lower_dev(lag_dev, lower, iter) {
 		if (!dsa_port_tree_same(dev->dsa_ptr, lower->dsa_ptr)) {
 			NL_SET_ERR_MSG(extack,
-				       "Interface is DSA master for a different switch tree than this LAG");
+				       "Interface is DSA conduit for a different switch tree than this LAG");
 			return notifier_from_errno(-EINVAL);
 		}
 
@@ -3156,13 +3156,13 @@ dsa_lag_master_prechangelower_sanity_check(struct net_device *dev,
 	return NOTIFY_DONE;
 }
 
-/* Don't allow bridging of DSA masters, since the bridge layer rx_handler
+/* Don't allow bridging of DSA conduits, since the bridge layer rx_handler
  * prevents the DSA fake ethertype handler to be invoked, so we don't get the
  * chance to strip off and parse the DSA switch tag protocol header (the bridge
  * layer just returns RX_HANDLER_CONSUMED, stopping RX processing for these
  * frames).
  * The only case where that would not be an issue is when bridging can already
- * be offloaded, such as when the DSA master is itself a DSA or plain switchdev
+ * be offloaded, such as when the DSA conduit is itself a DSA or plain switchdev
  * port, and is bridged only with other ports from the same hardware device.
  */
 static int
@@ -3188,7 +3188,7 @@ dsa_bridge_prechangelower_sanity_check(struct net_device *new_lower,
 
 		if (!netdev_port_same_parent_id(lower, new_lower)) {
 			NL_SET_ERR_MSG(extack,
-				       "Cannot do software bridging with a DSA master");
+				       "Cannot do software bridging with a DSA conduit");
 			return notifier_from_errno(-EINVAL);
 		}
 	}
@@ -3196,45 +3196,45 @@ dsa_bridge_prechangelower_sanity_check(struct net_device *new_lower,
 	return NOTIFY_DONE;
 }
 
-static void dsa_tree_migrate_ports_from_lag_master(struct dsa_switch_tree *dst,
-						   struct net_device *lag_dev)
+static void dsa_tree_migrate_ports_from_lag_conduit(struct dsa_switch_tree *dst,
+						    struct net_device *lag_dev)
 {
-	struct net_device *new_master = dsa_tree_find_first_master(dst);
+	struct net_device *new_conduit = dsa_tree_find_first_conduit(dst);
 	struct dsa_port *dp;
 	int err;
 
 	dsa_tree_for_each_user_port(dp, dst) {
-		if (dsa_port_to_master(dp) != lag_dev)
+		if (dsa_port_to_conduit(dp) != lag_dev)
 			continue;
 
-		err = dsa_slave_change_master(dp->slave, new_master, NULL);
+		err = dsa_user_change_conduit(dp->user, new_conduit, NULL);
 		if (err) {
-			netdev_err(dp->slave,
-				   "failed to restore master to %s: %pe\n",
-				   new_master->name, ERR_PTR(err));
+			netdev_err(dp->user,
+				   "failed to restore conduit to %s: %pe\n",
+				   new_conduit->name, ERR_PTR(err));
 		}
 	}
 }
 
-static int dsa_master_lag_join(struct net_device *master,
-			       struct net_device *lag_dev,
-			       struct netdev_lag_upper_info *uinfo,
-			       struct netlink_ext_ack *extack)
+static int dsa_conduit_lag_join(struct net_device *conduit,
+				struct net_device *lag_dev,
+				struct netdev_lag_upper_info *uinfo,
+				struct netlink_ext_ack *extack)
 {
-	struct dsa_port *cpu_dp = master->dsa_ptr;
+	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct dsa_port *dp;
 	int err;
 
-	err = dsa_master_lag_setup(lag_dev, cpu_dp, uinfo, extack);
+	err = dsa_conduit_lag_setup(lag_dev, cpu_dp, uinfo, extack);
 	if (err)
 		return err;
 
 	dsa_tree_for_each_user_port(dp, dst) {
-		if (dsa_port_to_master(dp) != master)
+		if (dsa_port_to_conduit(dp) != conduit)
 			continue;
 
-		err = dsa_slave_change_master(dp->slave, lag_dev, extack);
+		err = dsa_user_change_conduit(dp->user, lag_dev, extack);
 		if (err)
 			goto restore;
 	}
@@ -3243,24 +3243,24 @@ static int dsa_master_lag_join(struct net_device *master,
 
 restore:
 	dsa_tree_for_each_user_port_continue_reverse(dp, dst) {
-		if (dsa_port_to_master(dp) != lag_dev)
+		if (dsa_port_to_conduit(dp) != lag_dev)
 			continue;
 
-		err = dsa_slave_change_master(dp->slave, master, NULL);
+		err = dsa_user_change_conduit(dp->user, conduit, NULL);
 		if (err) {
-			netdev_err(dp->slave,
-				   "failed to restore master to %s: %pe\n",
-				   master->name, ERR_PTR(err));
+			netdev_err(dp->user,
+				   "failed to restore conduit to %s: %pe\n",
+				   conduit->name, ERR_PTR(err));
 		}
 	}
 
-	dsa_master_lag_teardown(lag_dev, master->dsa_ptr);
+	dsa_conduit_lag_teardown(lag_dev, conduit->dsa_ptr);
 
 	return err;
 }
 
-static void dsa_master_lag_leave(struct net_device *master,
-				 struct net_device *lag_dev)
+static void dsa_conduit_lag_leave(struct net_device *conduit,
+				  struct net_device *lag_dev)
 {
 	struct dsa_port *dp, *cpu_dp = lag_dev->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
@@ -3277,10 +3277,10 @@ static void dsa_master_lag_leave(struct net_device *master,
 
 	if (new_cpu_dp) {
 		/* Update the CPU port of the user ports still under the LAG
-		 * so that dsa_port_to_master() continues to work properly
+		 * so that dsa_port_to_conduit() continues to work properly
 		 */
 		dsa_tree_for_each_user_port(dp, dst)
-			if (dsa_port_to_master(dp) == lag_dev)
+			if (dsa_port_to_conduit(dp) == lag_dev)
 				dp->cpu_dp = new_cpu_dp;
 
 		/* Update the index of the virtual CPU port to match the lowest
@@ -3289,20 +3289,20 @@ static void dsa_master_lag_leave(struct net_device *master,
 		lag_dev->dsa_ptr = new_cpu_dp;
 		wmb();
 	} else {
-		/* If the LAG DSA master has no ports left, migrate back all
+		/* If the LAG DSA conduit has no ports left, migrate back all
 		 * user ports to the first physical CPU port
 		 */
-		dsa_tree_migrate_ports_from_lag_master(dst, lag_dev);
+		dsa_tree_migrate_ports_from_lag_conduit(dst, lag_dev);
 	}
 
-	/* This DSA master has left its LAG in any case, so let
+	/* This DSA conduit has left its LAG in any case, so let
 	 * the CPU port leave the hardware LAG as well
 	 */
-	dsa_master_lag_teardown(lag_dev, master->dsa_ptr);
+	dsa_conduit_lag_teardown(lag_dev, conduit->dsa_ptr);
 }
 
-static int dsa_master_changeupper(struct net_device *dev,
-				  struct netdev_notifier_changeupper_info *info)
+static int dsa_conduit_changeupper(struct net_device *dev,
+				   struct netdev_notifier_changeupper_info *info)
 {
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
@@ -3314,11 +3314,11 @@ static int dsa_master_changeupper(struct net_device *dev,
 
 	if (netif_is_lag_master(info->upper_dev)) {
 		if (info->linking) {
-			err = dsa_master_lag_join(dev, info->upper_dev,
-						  info->upper_info, extack);
+			err = dsa_conduit_lag_join(dev, info->upper_dev,
+						   info->upper_info, extack);
 			err = notifier_from_errno(err);
 		} else {
-			dsa_master_lag_leave(dev, info->upper_dev);
+			dsa_conduit_lag_leave(dev, info->upper_dev);
 			err = NOTIFY_OK;
 		}
 	}
@@ -3326,8 +3326,8 @@ static int dsa_master_changeupper(struct net_device *dev,
 	return err;
 }
 
-static int dsa_slave_netdevice_event(struct notifier_block *nb,
-				     unsigned long event, void *ptr)
+static int dsa_user_netdevice_event(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 
@@ -3336,15 +3336,15 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 		struct netdev_notifier_changeupper_info *info = ptr;
 		int err;
 
-		err = dsa_slave_prechangeupper_sanity_check(dev, info);
+		err = dsa_user_prechangeupper_sanity_check(dev, info);
 		if (notifier_to_errno(err))
 			return err;
 
-		err = dsa_master_prechangeupper_sanity_check(dev, info);
+		err = dsa_conduit_prechangeupper_sanity_check(dev, info);
 		if (notifier_to_errno(err))
 			return err;
 
-		err = dsa_lag_master_prechangelower_sanity_check(dev, info);
+		err = dsa_lag_conduit_prechangelower_sanity_check(dev, info);
 		if (notifier_to_errno(err))
 			return err;
 
@@ -3352,11 +3352,11 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 		if (notifier_to_errno(err))
 			return err;
 
-		err = dsa_slave_prechangeupper(dev, ptr);
+		err = dsa_user_prechangeupper(dev, ptr);
 		if (notifier_to_errno(err))
 			return err;
 
-		err = dsa_slave_lag_prechangeupper(dev, ptr);
+		err = dsa_user_lag_prechangeupper(dev, ptr);
 		if (notifier_to_errno(err))
 			return err;
 
@@ -3365,15 +3365,15 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	case NETDEV_CHANGEUPPER: {
 		int err;
 
-		err = dsa_slave_changeupper(dev, ptr);
+		err = dsa_user_changeupper(dev, ptr);
 		if (notifier_to_errno(err))
 			return err;
 
-		err = dsa_slave_lag_changeupper(dev, ptr);
+		err = dsa_user_lag_changeupper(dev, ptr);
 		if (notifier_to_errno(err))
 			return err;
 
-		err = dsa_master_changeupper(dev, ptr);
+		err = dsa_conduit_changeupper(dev, ptr);
 		if (notifier_to_errno(err))
 			return err;
 
@@ -3384,13 +3384,13 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 		struct dsa_port *dp;
 		int err = 0;
 
-		if (dsa_slave_dev_check(dev)) {
-			dp = dsa_slave_to_port(dev);
+		if (dsa_user_dev_check(dev)) {
+			dp = dsa_user_to_port(dev);
 
 			err = dsa_port_lag_change(dp, info->lower_state_info);
 		}
 
-		/* Mirror LAG port events on DSA masters that are in
+		/* Mirror LAG port events on DSA conduits that are in
 		 * a LAG towards their respective switch CPU ports
 		 */
 		if (netdev_uses_dsa(dev)) {
@@ -3403,28 +3403,28 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 	}
 	case NETDEV_CHANGE:
 	case NETDEV_UP: {
-		/* Track state of master port.
-		 * DSA driver may require the master port (and indirectly
+		/* Track state of conduit port.
+		 * DSA driver may require the conduit port (and indirectly
 		 * the tagger) to be available for some special operation.
 		 */
 		if (netdev_uses_dsa(dev)) {
 			struct dsa_port *cpu_dp = dev->dsa_ptr;
 			struct dsa_switch_tree *dst = cpu_dp->ds->dst;
 
-			/* Track when the master port is UP */
-			dsa_tree_master_oper_state_change(dst, dev,
-							  netif_oper_up(dev));
+			/* Track when the conduit port is UP */
+			dsa_tree_conduit_oper_state_change(dst, dev,
+							   netif_oper_up(dev));
 
-			/* Track when the master port is ready and can accept
+			/* Track when the conduit port is ready and can accept
 			 * packet.
 			 * NETDEV_UP event is not enough to flag a port as ready.
 			 * We also have to wait for linkwatch_do_dev to dev_activate
 			 * and emit a NETDEV_CHANGE event.
-			 * We check if a master port is ready by checking if the dev
+			 * We check if a conduit port is ready by checking if the dev
 			 * have a qdisc assigned and is not noop.
 			 */
-			dsa_tree_master_admin_state_change(dst, dev,
-							   !qdisc_tx_is_noop(dev));
+			dsa_tree_conduit_admin_state_change(dst, dev,
+							    !qdisc_tx_is_noop(dev));
 
 			return NOTIFY_OK;
 		}
@@ -3442,7 +3442,7 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 		cpu_dp = dev->dsa_ptr;
 		dst = cpu_dp->ds->dst;
 
-		dsa_tree_master_admin_state_change(dst, dev, false);
+		dsa_tree_conduit_admin_state_change(dst, dev, false);
 
 		list_for_each_entry(dp, &dst->ports, list) {
 			if (!dsa_port_is_user(dp))
@@ -3451,7 +3451,7 @@ static int dsa_slave_netdevice_event(struct notifier_block *nb,
 			if (dp->cpu_dp != cpu_dp)
 				continue;
 
-			list_add(&dp->slave->close_list, &close_list);
+			list_add(&dp->user->close_list, &close_list);
 		}
 
 		dev_close_many(&close_list, true);
@@ -3477,7 +3477,7 @@ dsa_fdb_offload_notify(struct dsa_switchdev_event_work *switchdev_work)
 				 switchdev_work->orig_dev, &info.info, NULL);
 }
 
-static void dsa_slave_switchdev_event_work(struct work_struct *work)
+static void dsa_user_switchdev_event_work(struct work_struct *work)
 {
 	struct dsa_switchdev_event_work *switchdev_work =
 		container_of(work, struct dsa_switchdev_event_work, work);
@@ -3488,7 +3488,7 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 	struct dsa_port *dp;
 	int err;
 
-	dp = dsa_slave_to_port(dev);
+	dp = dsa_user_to_port(dev);
 	ds = dp->ds;
 
 	switch (switchdev_work->event) {
@@ -3530,7 +3530,7 @@ static void dsa_slave_switchdev_event_work(struct work_struct *work)
 static bool dsa_foreign_dev_check(const struct net_device *dev,
 				  const struct net_device *foreign_dev)
 {
-	const struct dsa_port *dp = dsa_slave_to_port(dev);
+	const struct dsa_port *dp = dsa_user_to_port(dev);
 	struct dsa_switch_tree *dst = dp->ds->dst;
 
 	if (netif_is_bridge_master(foreign_dev))
@@ -3543,13 +3543,13 @@ static bool dsa_foreign_dev_check(const struct net_device *dev,
 	return true;
 }
 
-static int dsa_slave_fdb_event(struct net_device *dev,
-			       struct net_device *orig_dev,
-			       unsigned long event, const void *ctx,
-			       const struct switchdev_notifier_fdb_info *fdb_info)
+static int dsa_user_fdb_event(struct net_device *dev,
+			      struct net_device *orig_dev,
+			      unsigned long event, const void *ctx,
+			      const struct switchdev_notifier_fdb_info *fdb_info)
 {
 	struct dsa_switchdev_event_work *switchdev_work;
-	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_port *dp = dsa_user_to_port(dev);
 	bool host_addr = fdb_info->is_local;
 	struct dsa_switch *ds = dp->ds;
 
@@ -3598,7 +3598,7 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 		   orig_dev->name, fdb_info->addr, fdb_info->vid,
 		   host_addr ? " as host address" : "");
 
-	INIT_WORK(&switchdev_work->work, dsa_slave_switchdev_event_work);
+	INIT_WORK(&switchdev_work->work, dsa_user_switchdev_event_work);
 	switchdev_work->event = event;
 	switchdev_work->dev = dev;
 	switchdev_work->orig_dev = orig_dev;
@@ -3613,8 +3613,8 @@ static int dsa_slave_fdb_event(struct net_device *dev,
 }
 
 /* Called under rcu_read_lock() */
-static int dsa_slave_switchdev_event(struct notifier_block *unused,
-				     unsigned long event, void *ptr)
+static int dsa_user_switchdev_event(struct notifier_block *unused,
+				    unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	int err;
@@ -3622,15 +3622,15 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	switch (event) {
 	case SWITCHDEV_PORT_ATTR_SET:
 		err = switchdev_handle_port_attr_set(dev, ptr,
-						     dsa_slave_dev_check,
-						     dsa_slave_port_attr_set);
+						     dsa_user_dev_check,
+						     dsa_user_port_attr_set);
 		return notifier_from_errno(err);
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		err = switchdev_handle_fdb_event_to_device(dev, event, ptr,
-							   dsa_slave_dev_check,
+							   dsa_user_dev_check,
 							   dsa_foreign_dev_check,
-							   dsa_slave_fdb_event);
+							   dsa_user_fdb_event);
 		return notifier_from_errno(err);
 	default:
 		return NOTIFY_DONE;
@@ -3639,8 +3639,8 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 	return NOTIFY_OK;
 }
 
-static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
-					      unsigned long event, void *ptr)
+static int dsa_user_switchdev_blocking_event(struct notifier_block *unused,
+					     unsigned long event, void *ptr)
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	int err;
@@ -3648,52 +3648,52 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
 	switch (event) {
 	case SWITCHDEV_PORT_OBJ_ADD:
 		err = switchdev_handle_port_obj_add_foreign(dev, ptr,
-							    dsa_slave_dev_check,
+							    dsa_user_dev_check,
 							    dsa_foreign_dev_check,
-							    dsa_slave_port_obj_add);
+							    dsa_user_port_obj_add);
 		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_OBJ_DEL:
 		err = switchdev_handle_port_obj_del_foreign(dev, ptr,
-							    dsa_slave_dev_check,
+							    dsa_user_dev_check,
 							    dsa_foreign_dev_check,
-							    dsa_slave_port_obj_del);
+							    dsa_user_port_obj_del);
 		return notifier_from_errno(err);
 	case SWITCHDEV_PORT_ATTR_SET:
 		err = switchdev_handle_port_attr_set(dev, ptr,
-						     dsa_slave_dev_check,
-						     dsa_slave_port_attr_set);
+						     dsa_user_dev_check,
+						     dsa_user_port_attr_set);
 		return notifier_from_errno(err);
 	}
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block dsa_slave_nb __read_mostly = {
-	.notifier_call  = dsa_slave_netdevice_event,
+static struct notifier_block dsa_user_nb __read_mostly = {
+	.notifier_call  = dsa_user_netdevice_event,
 };
 
-struct notifier_block dsa_slave_switchdev_notifier = {
-	.notifier_call = dsa_slave_switchdev_event,
+struct notifier_block dsa_user_switchdev_notifier = {
+	.notifier_call = dsa_user_switchdev_event,
 };
 
-struct notifier_block dsa_slave_switchdev_blocking_notifier = {
-	.notifier_call = dsa_slave_switchdev_blocking_event,
+struct notifier_block dsa_user_switchdev_blocking_notifier = {
+	.notifier_call = dsa_user_switchdev_blocking_event,
 };
 
-int dsa_slave_register_notifier(void)
+int dsa_user_register_notifier(void)
 {
 	struct notifier_block *nb;
 	int err;
 
-	err = register_netdevice_notifier(&dsa_slave_nb);
+	err = register_netdevice_notifier(&dsa_user_nb);
 	if (err)
 		return err;
 
-	err = register_switchdev_notifier(&dsa_slave_switchdev_notifier);
+	err = register_switchdev_notifier(&dsa_user_switchdev_notifier);
 	if (err)
 		goto err_switchdev_nb;
 
-	nb = &dsa_slave_switchdev_blocking_notifier;
+	nb = &dsa_user_switchdev_blocking_notifier;
 	err = register_switchdev_blocking_notifier(nb);
 	if (err)
 		goto err_switchdev_blocking_nb;
@@ -3701,27 +3701,27 @@ int dsa_slave_register_notifier(void)
 	return 0;
 
 err_switchdev_blocking_nb:
-	unregister_switchdev_notifier(&dsa_slave_switchdev_notifier);
+	unregister_switchdev_notifier(&dsa_user_switchdev_notifier);
 err_switchdev_nb:
-	unregister_netdevice_notifier(&dsa_slave_nb);
+	unregister_netdevice_notifier(&dsa_user_nb);
 	return err;
 }
 
-void dsa_slave_unregister_notifier(void)
+void dsa_user_unregister_notifier(void)
 {
 	struct notifier_block *nb;
 	int err;
 
-	nb = &dsa_slave_switchdev_blocking_notifier;
+	nb = &dsa_user_switchdev_blocking_notifier;
 	err = unregister_switchdev_blocking_notifier(nb);
 	if (err)
 		pr_err("DSA: failed to unregister switchdev blocking notifier (%d)\n", err);
 
-	err = unregister_switchdev_notifier(&dsa_slave_switchdev_notifier);
+	err = unregister_switchdev_notifier(&dsa_user_switchdev_notifier);
 	if (err)
 		pr_err("DSA: failed to unregister switchdev notifier (%d)\n", err);
 
-	err = unregister_netdevice_notifier(&dsa_slave_nb);
+	err = unregister_netdevice_notifier(&dsa_user_nb);
 	if (err)
-		pr_err("DSA: failed to unregister slave notifier (%d)\n", err);
+		pr_err("DSA: failed to unregister user notifier (%d)\n", err);
 }
diff --git a/net/dsa/user.h b/net/dsa/user.h
new file mode 100644
index 000000000000..425ed9257858
--- /dev/null
+++ b/net/dsa/user.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __DSA_OPERATIVE_H
+#define __DSA_OPERATIVE_H
+
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
+#include <linux/list.h>
+#include <linux/netpoll.h>
+#include <linux/types.h>
+#include <net/dsa.h>
+#include <net/gro_cells.h>
+
+struct net_device;
+struct netlink_ext_ack;
+
+extern struct notifier_block dsa_user_switchdev_notifier;
+extern struct notifier_block dsa_user_switchdev_blocking_notifier;
+
+struct dsa_user_priv {
+	/* Copy of CPU port xmit for faster access in user transmit hot path */
+	struct sk_buff *	(*xmit)(struct sk_buff *skb,
+					struct net_device *dev);
+
+	struct gro_cells	gcells;
+
+	/* DSA port data, such as switch, port index, etc. */
+	struct dsa_port		*dp;
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	struct netpoll		*netpoll;
+#endif
+
+	/* TC context */
+	struct list_head	mall_tc_list;
+};
+
+void dsa_user_mii_bus_init(struct dsa_switch *ds);
+int dsa_user_create(struct dsa_port *dp);
+void dsa_user_destroy(struct net_device *user_dev);
+int dsa_user_suspend(struct net_device *user_dev);
+int dsa_user_resume(struct net_device *user_dev);
+int dsa_user_register_notifier(void);
+void dsa_user_unregister_notifier(void);
+void dsa_user_sync_ha(struct net_device *dev);
+void dsa_user_unsync_ha(struct net_device *dev);
+void dsa_user_setup_tagger(struct net_device *user);
+int dsa_user_change_mtu(struct net_device *dev, int new_mtu);
+int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
+			    struct netlink_ext_ack *extack);
+int dsa_user_manage_vlan_filtering(struct net_device *dev,
+				   bool vlan_filtering);
+
+static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
+{
+	struct dsa_user_priv *p = netdev_priv(dev);
+
+	return p->dp;
+}
+
+static inline struct net_device *
+dsa_user_to_conduit(const struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+
+	return dsa_port_to_conduit(dp);
+}
+
+#endif
-- 
2.34.1


--000000000000741bad0607a0144b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQeQYJKoZIhvcNAQcCoIIQajCCEGYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3QMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJxnccd7Ya9cOnvY
PKxw/ge3tQL7qBTrckoReOYazVmLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAxMzIxNTI1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBzWmVYoUbiq38J7LJaI9WCu6gKY/MpVxG5
b5cqawuR8NiXmBBHQUKs2zca3aOSVZVHoG6r+lZ86DL3/L9LW6p4mQuBVxVummxQkpsO9dwE1WCu
OturtHCHrvAz/81ijjOuXNUI6fSOlK8hx2Ndi63jmeWqTu123jLM0X+7eQHDOQChofrMmEO6nctM
U7GzCxw1xhnwsSdBS22LvSWOcTIUj1IInV/lGXqn15bqprcPsGA6IY1cHs0kzoGTnO+goOLlCuEQ
eEAjJge/UBys/buLQfRhD52jyktJvh8/AriMzaIpYwFt8mxH6YrZzghkU8EPsqeSldBN4DpSi83X
jFh+
--000000000000741bad0607a0144b--
