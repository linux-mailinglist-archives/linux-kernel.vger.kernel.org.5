Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26337A7AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjITLoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjITLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:44:14 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C9A3;
        Wed, 20 Sep 2023 04:44:07 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2420886B71;
        Wed, 20 Sep 2023 13:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695210241;
        bh=uiJK38QTpw7WM8uiJwTHDQJJXfroiX/8d6izBt4p75U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrqFRrTcXmEYeDYHILvPtziWsfzTW2XPLny3c1aazhq1AHLub+85O1qQfW+6ruK3N
         xKZj2y9gQt8jie+x+KpgwDQ/ZslLD4aaUfyz8xHMel1MB3qSvrsW+i0Qxd8Cletj76
         Gmq+7ry7TTcWOc+bdPDNfpKdIac3WpRaPNKYcxVq8MPew8k7kV64c8/hRWu34oTDOE
         34LfTgoC7KMsczh2Nrq3L8GWypPo2OulC4UX9ckT8qkJv4Q66+n6Z+y0S2bKsvkalB
         9IsuHAZwd8u+ZCf52ShoviB+AUaMEByFFnofXVegVKhJs17Vjnp7H6bj/LrL7vnUfU
         M8kIhGPzbRxiQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v5 net-next 5/5] net: dsa: microchip: Enable HSR offloading for KSZ9477
Date:   Wed, 20 Sep 2023 13:43:43 +0200
Message-Id: <20230920114343.1979843-6-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230920114343.1979843-1-lukma@denx.de>
References: <20230920114343.1979843-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds functions for providing in KSZ9477 switch HSR
(High-availability Seamless Redundancy) hardware offloading.

According to AN3474 application note following features are provided:
- TX packet duplication from host to switch (NETIF_F_HW_HSR_DUP)
- RX packet duplication discarding
- Prevention of packet loop

For last two ones - there is a probability that some packets will not
be filtered in HW (in some special cases - described in AN3474).
Hence, the HSR core code shall be used to discard those not caught frames.

Moreover, some switch registers adjustments are required - like setting
MAC address of HSR network interface.

Additionally, the KSZ9477 switch has been configured to forward frames
between HSR ports (e.g. 1,2) members to provide support for
NETIF_F_HW_HSR_FWD flag.

Join and leave functions are written in a way, that are executed with
single port - i.e. configuration is NOT done only when second HSR port
is configured.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>

---
Changes for v2:
- Use struct ksz_device to store hsr ports information (not struct dsa)

Changes for v3:
- Enable in-switch forwarding of frames between HSR ports (i.e. enable
  bridging of those two ports)

- The NETIF_F_HW_HSR_FWD flag has been marked as supported by the HSR
  network device

- Remove ETH MAC address validity check as it is done earlier in the net
  driver

- Add comment regarding adding support for NETIF_F_HW_HSR_FWD flag

Changes for v4:
- Merge patches for ksz_common.c and ksz9477.c

- Remove code to set global self-address filtering as this bit has
  already been set at ksz9477_reset_switch() function. Update also
  comment.

- Use already available ksz9477_cfg_port_member() instead of ksz_prmw32()

- Add description about chip limitations

- Allow having only one offloaded hsr interface (e.g. hsr0). Other ones
  (like hsr1) will have only SW HSR support

- Add check if MAC address of HSR device is equal to one from DSA master

- Rewrite the code to support per port join (i.e. not making init only
  when second HSR port is join)

- Add check to allow only one HSR port HW offloading

- Add hsr_ports to ksz_device struct to allow clean removal of network
  interfaces composing hsr device

Changes for v5:
- Add implementation of .port_set_mac_address callback for KSZ switch
  to prevent MAC address change when HSR HW offloading is used

- Use NL_SET_ERR_MSG_MOD() to propagate error messages to user

- Implement functions to use reference counter to allow in-HW MAC
  address change only when no other functionality requires it.
---
 drivers/net/dsa/microchip/ksz9477.c    |  70 ++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |   2 +
 drivers/net/dsa/microchip/ksz_common.c | 147 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |   9 ++
 4 files changed, 228 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 83b7f2d5c1ea..c4da8dc7638e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1141,6 +1141,76 @@ int ksz9477_tc_cbs_set_cinc(struct ksz_device *dev, int port, u32 val)
 	return ksz_pwrite16(dev, port, REG_PORT_MTI_CREDIT_INCREMENT, val);
 }
 
+/* The KSZ9477 provides following HW features to accelerate
+ * HSR frames handling:
+ *
+ * 1. TX PACKET DUPLICATION FROM HOST TO SWITCH
+ * 2. RX PACKET DUPLICATION DISCARDING
+ * 3. PREVENTING PACKET LOOP IN THE RING BY SELF-ADDRESS FILTERING
+ *
+ * Only one from point 1. has the NETIF_F* flag available.
+ *
+ * Ones from point 2 and 3 are "best effort" - i.e. those will
+ * work correctly most of the time, but it may happen that some
+ * frames will not be caught - to be more specific; there is a race
+ * condition in hardware such that, when duplicate packets are received
+ * on member ports very close in time to each other, the hardware fails
+ * to detect that they are duplicates.
+ *
+ * Hence, the SW needs to handle those special cases. However, the speed
+ * up gain is considerable when above features are used.
+ *
+ * Moreover, the NETIF_F_HW_HSR_FWD feature is also enabled, as HSR frames
+ * can be forwarded in the switch fabric between HSR ports.
+ */
+#define KSZ9477_SUPPORTED_HSR_FEATURES (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_FWD)
+
+void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr)
+{
+	struct ksz_device *dev = ds->priv;
+	struct net_device *slave;
+	u8 data;
+
+	/* Program which port(s) shall support HSR */
+	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), BIT(port));
+
+	/* Forward frames between HSR ports (i.e. bridge together HSR ports) */
+	ksz9477_cfg_port_member(dev, port,
+				BIT(dsa_upstream_port(ds, port)) | BIT(port));
+
+	if (!dev->hsr_ports) {
+		/* Enable discarding of received HSR frames */
+		ksz_read8(dev, REG_HSR_ALU_CTRL_0__1, &data);
+		data |= HSR_DUPLICATE_DISCARD;
+		data &= ~HSR_NODE_UNICAST;
+		ksz_write8(dev, REG_HSR_ALU_CTRL_0__1, data);
+	}
+
+	/* Enable per port self-address filtering.
+	 * The global self-address filtering has already been enabled in the
+	 * ksz9477_reset_switch() function.
+	 */
+	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, true);
+
+	/* Setup HW supported features for lan HSR ports */
+	slave = dsa_to_port(ds, port)->slave;
+	slave->features |= KSZ9477_SUPPORTED_HSR_FEATURES;
+}
+
+void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr)
+{
+	struct ksz_device *dev = ds->priv;
+
+	/* Clear port HSR support */
+	ksz_rmw32(dev, REG_HSR_PORT_MAP__4, BIT(port), 0);
+
+	/* Disable forwarding frames between HSR ports */
+	ksz9477_cfg_port_member(dev, port, BIT(dsa_upstream_port(ds, port)));
+
+	/* Disable per port self-address filtering */
+	ksz_port_cfg(dev, port, REG_PORT_LUE_CTRL, PORT_SRC_ADDR_FILTER, false);
+}
+
 int ksz9477_switch_init(struct ksz_device *dev)
 {
 	u8 data8;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index a6f425866a29..8625bf474764 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -56,5 +56,7 @@ int ksz9477_reset_switch(struct ksz_device *dev);
 int ksz9477_switch_init(struct ksz_device *dev);
 void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
+void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
+void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c67ad0f6e1fa..0a8d99ae1132 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -16,6 +16,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/if_hsr.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
@@ -3421,6 +3422,149 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
+				    const unsigned char *addr)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+
+	if (dp->hsr_dev) {
+		dev_err(ds->dev,
+			"Cannot change MAC address on port %d with active HSR offload\n",
+			port);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+/* Program the switch's MAC address register with the MAC address of the
+ * requesting user port. This single address is used by the switch for multiple
+ * features, like HSR self-address filtering and WoL. Other user ports are
+ * allowed to share ownership of this address as long as their MAC address is
+ * the same. The user ports' MAC addresses must not change while they have
+ * ownership of the switch MAC address.
+ */
+static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
+				  struct netlink_ext_ack *extack)
+{
+	struct net_device *slave = dsa_to_port(ds, port)->slave;
+	const unsigned char *addr = slave->dev_addr;
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
+	int i;
+
+	/* Make sure concurrent MAC address changes are blocked */
+	ASSERT_RTNL();
+
+	switch_macaddr = dev->switch_macaddr;
+	if (switch_macaddr) {
+		if (!ether_addr_equal(switch_macaddr->addr, addr)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Switch already configured for MAC address %pM",
+					       switch_macaddr->addr);
+			return -EBUSY;
+		}
+
+		refcount_inc(&switch_macaddr->refcount);
+		return 0;
+	}
+
+	switch_macaddr = kzalloc(sizeof(*switch_macaddr), GFP_KERNEL);
+	if (!switch_macaddr)
+		return -ENOMEM;
+
+	ether_addr_copy(switch_macaddr->addr, addr);
+	refcount_set(&switch_macaddr->refcount, 1);
+	dev->switch_macaddr = switch_macaddr;
+
+	/* Program the switch MAC address to hardware */
+	for (i = 0; i < ETH_ALEN; i++)
+		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+
+	return 0;
+}
+
+static void ksz_switch_macaddr_put(struct dsa_switch *ds)
+{
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
+	int i;
+
+	/* Make sure concurrent MAC address changes are blocked */
+	ASSERT_RTNL();
+
+	switch_macaddr = dev->switch_macaddr;
+	if (!refcount_dec_and_test(&switch_macaddr->refcount))
+		return;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, 0);
+
+	dev->switch_macaddr = NULL;
+	kfree(switch_macaddr);
+}
+
+static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
+			struct netlink_ext_ack *extack)
+{
+	struct ksz_device *dev = ds->priv;
+	enum hsr_version ver;
+	int ret;
+
+	ret = hsr_get_version(hsr, &ver);
+	if (ret)
+		return ret;
+
+	if (dev->chip_id != KSZ9477_CHIP_ID) {
+		NL_SET_ERR_MSG_MOD(extack, "Chip does not support HSR offload");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 can support HW offloading of only 1 HSR device */
+	if (dev->hsr_dev && hsr != dev->hsr_dev) {
+		NL_SET_ERR_MSG_MOD(extack, "Offload supported for a single HSR");
+		return -EOPNOTSUPP;
+	}
+
+	/* KSZ9477 only supports HSR v0 and v1 */
+	if (!(ver == HSR_V0 || ver == HSR_V1)) {
+		NL_SET_ERR_MSG_MOD(extack, "Only HSR v0 and v1 supported");
+		return -EOPNOTSUPP;
+	}
+
+	/* Self MAC address filtering, to avoid frames traversing
+	 * the HSR ring more than once.
+	 */
+	ret = ksz_switch_macaddr_get(ds, port, extack);
+	if (ret)
+		return ret;
+
+	ksz9477_hsr_join(ds, port, hsr);
+	dev->hsr_dev = hsr;
+	dev->hsr_ports |= BIT(port);
+
+	return 0;
+}
+
+static int ksz_hsr_leave(struct dsa_switch *ds, int port,
+			 struct net_device *hsr)
+{
+	struct ksz_device *dev = ds->priv;
+
+	WARN_ON(dev->chip_id != KSZ9477_CHIP_ID);
+
+	ksz9477_hsr_leave(ds, port, hsr);
+	dev->hsr_ports &= ~BIT(port);
+	if (!dev->hsr_ports)
+		dev->hsr_dev = NULL;
+
+	ksz_switch_macaddr_put(ds);
+
+	return 0;
+}
+
 static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_tag_protocol	= ksz_get_tag_protocol,
 	.connect_tag_protocol   = ksz_connect_tag_protocol,
@@ -3440,6 +3584,9 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_sset_count		= ksz_sset_count,
 	.port_bridge_join	= ksz_port_bridge_join,
 	.port_bridge_leave	= ksz_port_bridge_leave,
+	.port_hsr_join		= ksz_hsr_join,
+	.port_hsr_leave		= ksz_hsr_leave,
+	.port_set_mac_address	= ksz_port_set_mac_address,
 	.port_stp_state_set	= ksz_port_stp_state_set,
 	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
 	.port_bridge_flags	= ksz_port_bridge_flags,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 1f3fb6c23f36..1f447a34f555 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -101,6 +101,11 @@ struct ksz_ptp_irq {
 	int num;
 };
 
+struct ksz_switch_macaddr {
+	unsigned char addr[ETH_ALEN];
+	refcount_t refcount;
+};
+
 struct ksz_port {
 	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	bool learning;
@@ -169,6 +174,10 @@ struct ksz_device {
 	struct mutex lock_irq;		/* IRQ Access */
 	struct ksz_irq girq;
 	struct ksz_ptp_data ptp_data;
+
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct net_device *hsr_dev;     /* HSR */
+	u8 hsr_ports;
 };
 
 /* List of supported models */
-- 
2.20.1

