Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793C27CF8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345474AbjJSM3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345570AbjJSM3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:29:18 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B2106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:29:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtS8y-0006Ku-OT; Thu, 19 Oct 2023 14:28:52 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qtS8x-002mro-I7; Thu, 19 Oct 2023 14:28:51 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qtS8x-00529C-1Z;
        Thu, 19 Oct 2023 14:28:51 +0200
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
Subject: [PATCH net-next v6 4/9] net: dsa: microchip: ksz9477: add Wake on LAN support
Date:   Thu, 19 Oct 2023 14:28:45 +0200
Message-Id: <20231019122850.1199821-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019122850.1199821-1-o.rempel@pengutronix.de>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
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

Add WoL support for KSZ9477 family of switches. This code was tested on
KSZ8563 chip.

KSZ9477 family of switches supports multiple PHY events:
- wake on Link Up
- wake on Energy Detect.
Since current UAPI can't differentiate between this PHY events, map all of them
to WAKE_PHY.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/microchip/ksz9477.c    | 100 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |   4 +
 drivers/net/dsa/microchip/ksz_common.c |  24 ++++++
 drivers/net/dsa/microchip/ksz_common.h |   4 +
 4 files changed, 132 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index cde8ef33d029..b9419d4b5e7b 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -56,6 +56,103 @@ int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
 				  REG_SW_MTU_MASK, frame_size);
 }
 
+/**
+ * ksz9477_handle_wake_reason - Handle wake reason on a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ *
+ * This function reads the PME (Power Management Event) status register of a
+ * specified port to determine the wake reason. If there is no wake event, it
+ * returns early. Otherwise, it logs the wake reason which could be due to a
+ * "Magic Packet", "Link Up", or "Energy Detect" event. The PME status register
+ * is then cleared to acknowledge the handling of the wake event.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
+static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
+{
+	u8 pme_status;
+	int ret;
+
+	ret = ksz_pread8(dev, port, REG_PORT_PME_STATUS, &pme_status);
+	if (ret)
+		return ret;
+
+	if (!pme_status)
+		return 0;
+
+	dev_dbg(dev->dev, "Wake event on port %d due to: %s %s\n", port,
+		pme_status & PME_WOL_LINKUP ? "\"Link Up\"" : "",
+		pme_status & PME_WOL_ENERGY ? "\"Enery detect\"" : "");
+
+	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
+}
+
+/**
+ * ksz9477_get_wol - Get Wake-on-LAN settings for a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ * @wol: Pointer to ethtool Wake-on-LAN settings structure.
+ *
+ * This function checks the PME Pin Control Register to see if  PME Pin Output
+ * Enable is set, indicating PME is enabled. If enabled, it sets the supported
+ * and active WoL flags.
+ */
+void ksz9477_get_wol(struct ksz_device *dev, int port,
+		     struct ethtool_wolinfo *wol)
+{
+	u8 pme_ctrl;
+	int ret;
+
+	if (!dev->wakeup_source)
+		return;
+
+	wol->supported = WAKE_PHY;
+
+	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
+	if (ret)
+		return;
+
+	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
+		wol->wolopts |= WAKE_PHY;
+}
+
+/**
+ * ksz9477_set_wol - Set Wake-on-LAN settings for a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ * @wol: Pointer to ethtool Wake-on-LAN settings structure.
+ *
+ * This function configures Wake-on-LAN (WoL) settings for a specified port.
+ * It validates the provided WoL options, checks if PME is enabled via the
+ * switch's PME Pin Control Register, clears any previous wake reasons,
+ * and sets the Magic Packet flag in the port's PME control register if
+ * specified.
+ *
+ * Return: 0 on success, or other error codes on failure.
+ */
+int ksz9477_set_wol(struct ksz_device *dev, int port,
+		    struct ethtool_wolinfo *wol)
+{
+	u8 pme_ctrl = 0;
+	int ret;
+
+	if (wol->wolopts & ~WAKE_PHY)
+		return -EINVAL;
+
+	if (!dev->wakeup_source)
+		return -EOPNOTSUPP;
+
+	ret = ksz9477_handle_wake_reason(dev, port);
+	if (ret)
+		return ret;
+
+	if (wol->wolopts & WAKE_PHY)
+		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
+
+	return ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
+}
+
 static int ksz9477_wait_vlan_ctrl_ready(struct ksz_device *dev)
 {
 	unsigned int val;
@@ -1006,6 +1103,9 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		ksz_pread16(dev, port, REG_PORT_PHY_INT_ENABLE, &data16);
 
 	ksz9477_port_acl_init(dev, port);
+
+	/* clear pending wake flags */
+	ksz9477_handle_wake_reason(dev, port);
 }
 
 void ksz9477_config_cpu_port(struct dsa_switch *ds)
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index f90e2e8ebe80..fa8d0318b437 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -58,6 +58,10 @@ void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
 void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
 void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
+void ksz9477_get_wol(struct ksz_device *dev, int port,
+		     struct ethtool_wolinfo *wol);
+int ksz9477_set_wol(struct ksz_device *dev, int port,
+		    struct ethtool_wolinfo *wol);
 
 int ksz9477_port_acl_init(struct ksz_device *dev, int port);
 void ksz9477_port_acl_free(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 11adae8a2037..3f7c86e545a7 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -319,6 +319,8 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.mdb_del = ksz9477_mdb_del,
 	.change_mtu = ksz9477_change_mtu,
 	.phylink_mac_link_up = ksz9477_phylink_mac_link_up,
+	.get_wol = ksz9477_get_wol,
+	.set_wol = ksz9477_set_wol,
 	.config_cpu_port = ksz9477_config_cpu_port,
 	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
 	.enable_stp_addr = ksz9477_enable_stp_addr,
@@ -3543,6 +3545,26 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
+static void ksz_get_wol(struct dsa_switch *ds, int port,
+			struct ethtool_wolinfo *wol)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->dev_ops->get_wol)
+		dev->dev_ops->get_wol(dev, port, wol);
+}
+
+static int ksz_set_wol(struct dsa_switch *ds, int port,
+		       struct ethtool_wolinfo *wol)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->dev_ops->set_wol)
+		return dev->dev_ops->set_wol(dev, port, wol);
+
+	return -EOPNOTSUPP;
+}
+
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 				    const unsigned char *addr)
 {
@@ -3727,6 +3749,8 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.get_pause_stats	= ksz_get_pause_stats,
 	.port_change_mtu	= ksz_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
+	.get_wol		= ksz_get_wol,
+	.set_wol		= ksz_set_wol,
 	.get_ts_info		= ksz_get_ts_info,
 	.port_hwtstamp_get	= ksz_hwtstamp_get,
 	.port_hwtstamp_set	= ksz_hwtstamp_set,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f7c471bc040f..a7394175fcf6 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -374,6 +374,10 @@ struct ksz_dev_ops {
 				    int duplex, bool tx_pause, bool rx_pause);
 	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
 	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
+	void (*get_wol)(struct ksz_device *dev, int port,
+			struct ethtool_wolinfo *wol);
+	int (*set_wol)(struct ksz_device *dev, int port,
+		       struct ethtool_wolinfo *wol);
 	void (*config_cpu_port)(struct dsa_switch *ds);
 	int (*enable_stp_addr)(struct ksz_device *dev);
 	int (*reset)(struct ksz_device *dev);
-- 
2.39.2

