Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249E7D7C01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjJZFL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjJZFLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:11:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882D18A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:11:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvsdy-0004Y8-4B; Thu, 26 Oct 2023 07:10:54 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvsdw-004L1Q-Lt; Thu, 26 Oct 2023 07:10:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qvsdw-009ikd-1w;
        Thu, 26 Oct 2023 07:10:52 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v8 1/5] net: dsa: microchip: ksz9477: Add Wake on Magic Packet support
Date:   Thu, 26 Oct 2023 07:10:47 +0200
Message-Id: <20231026051051.2316937-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026051051.2316937-1-o.rempel@pengutronix.de>
References: <20231026051051.2316937-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
driver.

Major changes include:

1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
   Packet wake events alongside existing wake reasons.

2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
   handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
   program the switch's MAC address register accordingly when Magic
   Packet wake-up is enabled. This change will prevent WAKE_MAGIC
   activation if the related port has a different MAC address compared
   to a MAC address already used by HSR or an already active WAKE_MAGIC
   on another port.

3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
   address changes on ports with active Wake on Magic Packet, as the
   switch's MAC address register is utilized for this feature.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/microchip/ksz9477.c    | 57 ++++++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.c | 43 +++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 2534c3d122e4..441b4597ef27 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -81,7 +81,8 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
 	if (!pme_status)
 		return 0;
 
-	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s\n", port,
+	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s%s\n", port,
+		pme_status & PME_WOL_MAGICPKT ? " \"Magic Packet\"" : "",
 		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
 		pme_status & PME_WOL_ENERGY ? " \"Enery detect\"" : "");
 
@@ -109,10 +110,19 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 
 	wol->supported = WAKE_PHY;
 
+	/* Check if the current MAC address on this port can be set
+	 * as global for WAKE_MAGIC support. The result may vary
+	 * dynamically based on other ports configurations.
+	 */
+	if (ksz_is_port_mac_global_usable(dev->ds, port))
+		wol->supported |= WAKE_MAGIC;
+
 	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
 	if (ret)
 		return;
 
+	if (pme_ctrl & PME_WOL_MAGICPKT)
+		wol->wolopts |= WAKE_MAGIC;
 	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
 		wol->wolopts |= WAKE_PHY;
 }
@@ -134,10 +144,12 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 int ksz9477_set_wol(struct ksz_device *dev, int port,
 		    struct ethtool_wolinfo *wol)
 {
-	u8 pme_ctrl = 0;
+	u8 pme_ctrl = 0, pme_ctrl_old = 0;
+	bool magic_switched_off;
+	bool magic_switched_on;
 	int ret;
 
-	if (wol->wolopts & ~WAKE_PHY)
+	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
 	if (!dev->wakeup_source)
@@ -147,10 +159,42 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 	if (ret)
 		return ret;
 
+	if (wol->wolopts & WAKE_MAGIC)
+		pme_ctrl |= PME_WOL_MAGICPKT;
 	if (wol->wolopts & WAKE_PHY)
 		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
 
-	return ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
+	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl_old);
+	if (ret)
+		return ret;
+
+	if (pme_ctrl_old == pme_ctrl)
+		return 0;
+
+	magic_switched_off = (pme_ctrl_old & PME_WOL_MAGICPKT) &&
+			    !(pme_ctrl & PME_WOL_MAGICPKT);
+	magic_switched_on = !(pme_ctrl_old & PME_WOL_MAGICPKT) &&
+			    (pme_ctrl & PME_WOL_MAGICPKT);
+
+	/* To keep reference count of MAC address, we should do this
+	 * operation only on change of WOL settings.
+	 */
+	if (magic_switched_on) {
+		ret = ksz_switch_macaddr_get(dev->ds, port, NULL);
+		if (ret)
+			return ret;
+	} else if (magic_switched_off) {
+		ksz_switch_macaddr_put(dev->ds);
+	}
+
+	ret = ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
+	if (ret) {
+		if (magic_switched_on)
+			ksz_switch_macaddr_put(dev->ds);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int ksz9477_wait_vlan_ctrl_ready(struct ksz_device *dev)
@@ -1106,6 +1150,11 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 
 	/* clear pending wake flags */
 	ksz9477_handle_wake_reason(dev, port);
+
+	/* Disable all WoL options by default. Otherwise
+	 * ksz_switch_macaddr_get/put logic will not work properly.
+	 */
+	ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, 0);
 }
 
 void ksz9477_config_cpu_port(struct dsa_switch *ds)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index de788f424a3f..8244204e177d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3569,6 +3569,7 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 				    const unsigned char *addr)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct ethtool_wolinfo wol;
 
 	if (dp->hsr_dev) {
 		dev_err(ds->dev,
@@ -3577,9 +3578,45 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 		return -EBUSY;
 	}
 
+	ksz_get_wol(ds, dp->index, &wol);
+	if (wol.wolopts & WAKE_MAGIC) {
+		dev_err(ds->dev,
+			"Cannot change MAC address on port %d with active Wake on Magic Packet\n",
+			port);
+		return -EBUSY;
+	}
+
 	return 0;
 }
 
+/**
+ * ksz_is_port_mac_global_usable - Check if the MAC address on a given port
+ *                                 can be used as a global address.
+ * @ds: Pointer to the DSA switch structure.
+ * @port: The port number on which the MAC address is to be checked.
+ *
+ * This function examines the MAC address set on the specified port and
+ * determines if it can be used as a global address for the switch.
+ *
+ * Return: true if the port's MAC address can be used as a global address, false
+ * otherwise.
+ */
+bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port)
+{
+	struct net_device *user = dsa_to_port(ds, port)->user;
+	const unsigned char *addr = user->dev_addr;
+	struct ksz_switch_macaddr *switch_macaddr;
+	struct ksz_device *dev = ds->priv;
+
+	ASSERT_RTNL();
+
+	switch_macaddr = dev->switch_macaddr;
+	if (switch_macaddr && !ether_addr_equal(switch_macaddr->addr, addr))
+		return false;
+
+	return true;
+}
+
 /* Program the switch's MAC address register with the MAC address of the
  * requesting user port. This single address is used by the switch for multiple
  * features, like HSR self-address filtering and WoL. Other user ports are
@@ -3587,8 +3624,8 @@ static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
  * the same. The user ports' MAC addresses must not change while they have
  * ownership of the switch MAC address.
  */
-static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
-				  struct netlink_ext_ack *extack)
+int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
+			   struct netlink_ext_ack *extack)
 {
 	struct net_device *user = dsa_to_port(ds, port)->user;
 	const unsigned char *addr = user->dev_addr;
@@ -3628,7 +3665,7 @@ static int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static void ksz_switch_macaddr_put(struct dsa_switch *ds)
+void ksz_switch_macaddr_put(struct dsa_switch *ds)
 {
 	struct ksz_switch_macaddr *switch_macaddr;
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a7394175fcf6..06996813f9a8 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -390,12 +390,16 @@ int ksz_switch_register(struct ksz_device *dev);
 void ksz_switch_remove(struct ksz_device *dev);
 
 void ksz_init_mib_timer(struct ksz_device *dev);
+bool ksz_is_port_mac_global_usable(struct dsa_switch *ds, int port);
 void ksz_r_mib_stats64(struct ksz_device *dev, int port);
 void ksz88xx_r_mib_stats64(struct ksz_device *dev, int port);
 void ksz_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
 bool ksz_get_gbit(struct ksz_device *dev, int port);
 phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit);
 extern const struct ksz_chip_data ksz_switch_chips[];
+int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
+			   struct netlink_ext_ack *extack);
+void ksz_switch_macaddr_put(struct dsa_switch *ds);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
-- 
2.39.2

