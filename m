Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB27F418F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjKVJ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKVJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:26:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E913083
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:25:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUS-0006KN-BU; Wed, 22 Nov 2023 10:25:48 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUQ-00AmPa-Tw; Wed, 22 Nov 2023 10:25:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUQ-00C9J2-2j;
        Wed, 22 Nov 2023 10:25:46 +0100
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
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Simon Horman <simon.horman@corigine.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v5 1/3] net: dsa: microchip: ksz8: Make flow control, speed, and duplex on CPU port configurable
Date:   Wed, 22 Nov 2023 10:25:43 +0100
Message-Id: <20231122092545.2895635-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122092545.2895635-1-o.rempel@pengutronix.de>
References: <20231122092545.2895635-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow flow control, speed, and duplex settings on the CPU port to be
configurable. Previously, the speed and duplex relied on default switch
values, which limited flexibility. Additionally, flow control was
hardcoded and only functional in duplex mode. This update enhances the
configurability of these parameters.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/dsa/microchip/ksz8.h       |  4 ++
 drivers/net/dsa/microchip/ksz8795.c    | 54 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c |  1 +
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index ef653bbfde75..571c26ce71e4 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -54,5 +54,9 @@ int ksz8_reset_switch(struct ksz_device *dev);
 int ksz8_switch_init(struct ksz_device *dev);
 void ksz8_switch_exit(struct ksz_device *dev);
 int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
+void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
+			      unsigned int mode, phy_interface_t interface,
+			      struct phy_device *phydev, int speed, int duplex,
+			      bool tx_pause, bool rx_pause);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 8deb217638d3..3504e7238eba 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1528,6 +1528,58 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	}
 }
 
+/**
+ * ksz8_cpu_port_link_up - Configures the CPU port of the switch.
+ * @dev: The KSZ device instance.
+ * @speed: The desired link speed.
+ * @duplex: The desired duplex mode.
+ * @tx_pause: If true, enables transmit pause.
+ * @rx_pause: If true, enables receive pause.
+ *
+ * Description:
+ * The function configures flow control and speed settings for the CPU
+ * port of the switch based on the desired settings, current duplex mode, and
+ * speed.
+ */
+static void ksz8_cpu_port_link_up(struct ksz_device *dev, int speed, int duplex,
+				  bool tx_pause, bool rx_pause)
+{
+	const u16 *regs = dev->info->regs;
+	u8 ctrl = 0;
+
+	/* SW_FLOW_CTRL, SW_HALF_DUPLEX, and SW_10_MBIT bits are bootstrappable
+	 * at least on KSZ8873. They can have different values depending on your
+	 * board setup.
+	 */
+	if (duplex) {
+		if (tx_pause || rx_pause)
+			ctrl |= SW_FLOW_CTRL;
+	} else {
+		ctrl |= SW_HALF_DUPLEX;
+	}
+
+	/* This hardware only supports SPEED_10 and SPEED_100. For SPEED_10
+	 * we need to set the SW_10_MBIT bit. Otherwise, we can leave it 0.
+	 */
+	if (speed == SPEED_10)
+		ctrl |= SW_10_MBIT;
+
+	ksz_rmw8(dev, regs[S_BROADCAST_CTRL], SW_HALF_DUPLEX | SW_FLOW_CTRL |
+		 SW_10_MBIT, ctrl);
+}
+
+void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
+			      unsigned int mode, phy_interface_t interface,
+			      struct phy_device *phydev, int speed, int duplex,
+			      bool tx_pause, bool rx_pause)
+{
+	/* If the port is the CPU port, apply special handling. Only the CPU
+	 * port is configured via global registers.
+	 */
+	if (dev->cpu_port == port)
+		ksz8_cpu_port_link_up(dev, speed, duplex, tx_pause, rx_pause);
+}
+
 static int ksz8_handle_global_errata(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
@@ -1576,8 +1628,6 @@ int ksz8_setup(struct dsa_switch *ds)
 	 */
 	ds->vlan_filtering_is_global = true;
 
-	ksz_cfg(dev, S_REPLACE_VID_CTRL, SW_FLOW_CTRL, true);
-
 	/* Enable automatic fast aging when link changed detected. */
 	ksz_cfg(dev, S_LINK_AGING_CTRL, SW_LINK_AUTO_AGING, true);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3fed406fb46a..0ee7cfb8d4bd 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -277,6 +277,7 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.mirror_add = ksz8_port_mirror_add,
 	.mirror_del = ksz8_port_mirror_del,
 	.get_caps = ksz8_get_caps,
+	.phylink_mac_link_up = ksz8_phylink_mac_link_up,
 	.config_cpu_port = ksz8_config_cpu_port,
 	.enable_stp_addr = ksz8_enable_stp_addr,
 	.reset = ksz8_reset_switch,
-- 
2.39.2

