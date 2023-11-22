Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC24E7F418B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjKVJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:26:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8569D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:25:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUS-0006KO-BT; Wed, 22 Nov 2023 10:25:48 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUQ-00AmPb-Ue; Wed, 22 Nov 2023 10:25:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jUQ-00C9JI-2n;
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
Subject: [PATCH net-next v5 2/3] net: dsa: microchip: ksz8: Add function to configure ports with integrated PHYs
Date:   Wed, 22 Nov 2023 10:25:44 +0100
Message-Id: <20231122092545.2895635-3-o.rempel@pengutronix.de>
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

This patch introduces the function 'ksz8_phy_port_link_up' to the
Microchip KSZ8xxx driver. This function is responsible for setting up
flow control and duplex settings for the ports that are integrated with
PHYs.

The KSZ8795 switch supports asymmetric pause control, which can't be
fully utilized since a single bit controls both RX and TX pause. Despite
this, the flow control can be adjusted based on the auto-negotiation
process, taking into account the capabilities of both link partners.

On the other hand, the KSZ8873's PORT_FORCE_FLOW_CTRL bit can be set by
the hardware bootstrap, which ignores the auto-negotiation result.
Therefore, even in auto-negotiation mode, we need to ensure that this
bit is correctly set.

When auto-negotiation isn't in use, we enforce symmetric pause control
for the KSZ8795 switch.

Please note, forcing flow control disable on a port while still
advertising pause support isn't possible. While this scenario
might not be practical or desired, it's important to be aware of this
limitation when working with the KSZ8873 and similar devices.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/dsa/microchip/ksz8795.c | 79 +++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 3504e7238eba..0b263c42b191 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1528,6 +1528,83 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	}
 }
 
+/**
+ * ksz8_phy_port_link_up - Configures ports with integrated PHYs
+ * @dev: The KSZ device instance.
+ * @port: The port number to configure.
+ * @duplex: The desired duplex mode.
+ * @tx_pause: If true, enables transmit pause.
+ * @rx_pause: If true, enables receive pause.
+ *
+ * Description:
+ * The function configures flow control settings for a given port based on the
+ * desired settings and current duplex mode.
+ *
+ * According to the KSZ8873 datasheet, the PORT_FORCE_FLOW_CTRL bit in the
+ * Port Control 2 register (0x1A for Port 1, 0x22 for Port 2, 0x32 for Port 3)
+ * determines how flow control is handled on the port:
+ *    "1 = will always enable full-duplex flow control on the port, regardless
+ *         of AN result.
+ *     0 = full-duplex flow control is enabled based on AN result."
+ *
+ * This means that the flow control behavior depends on the state of this bit:
+ * - If PORT_FORCE_FLOW_CTRL is set to 1, the switch will ignore AN results and
+ *   force flow control on the port.
+ * - If PORT_FORCE_FLOW_CTRL is set to 0, the switch will enable or disable
+ *   flow control based on the AN results.
+ *
+ * However, there is a potential limitation in this configuration. It is
+ * currently not possible to force disable flow control on a port if we still
+ * advertise pause support. While such a configuration is not currently
+ * supported by Linux, and may not make practical sense, it's important to be
+ * aware of this limitation when working with the KSZ8873 and similar devices.
+ */
+static void ksz8_phy_port_link_up(struct ksz_device *dev, int port, int duplex,
+				  bool tx_pause, bool rx_pause)
+{
+	const u16 *regs = dev->info->regs;
+	u8 ctrl = 0;
+	int ret;
+
+	/* The KSZ8795 switch differs from the KSZ8873 by supporting
+	 * asymmetric pause control. However, since a single bit is used to
+	 * control both RX and TX pause, we can't enforce asymmetric pause
+	 * control - both TX and RX pause will be either enabled or disabled
+	 * together.
+	 *
+	 * If auto-negotiation is enabled, we usually allow the flow control to
+	 * be determined by the auto-negotiation process based on the
+	 * capabilities of both link partners. However, for KSZ8873, the
+	 * PORT_FORCE_FLOW_CTRL bit may be set by the hardware bootstrap,
+	 * ignoring the auto-negotiation result. Thus, even in auto-negotiation
+	 * mode, we need to ensure that the PORT_FORCE_FLOW_CTRL bit is
+	 * properly cleared.
+	 *
+	 * In the absence of auto-negotiation, we will enforce symmetric
+	 * pause control for both variants of switches - KSZ8873 and KSZ8795.
+	 */
+	if (duplex) {
+		bool aneg_en = false;
+
+		ret = ksz_pread8(dev, port, regs[P_FORCE_CTRL], &ctrl);
+		if (ret)
+			return;
+
+		if (ksz_is_ksz88x3(dev)) {
+			if ((ctrl & PORT_AUTO_NEG_ENABLE))
+				aneg_en = true;
+		} else {
+			if (!(ctrl & PORT_AUTO_NEG_DISABLE))
+				aneg_en = true;
+		}
+
+		if (!aneg_en && (tx_pause || rx_pause))
+			ctrl |= PORT_FORCE_FLOW_CTRL;
+	}
+
+	ksz_prmw8(dev, port, regs[P_STP_CTRL], PORT_FORCE_FLOW_CTRL, ctrl);
+}
+
 /**
  * ksz8_cpu_port_link_up - Configures the CPU port of the switch.
  * @dev: The KSZ device instance.
@@ -1578,6 +1655,8 @@ void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
 	 */
 	if (dev->cpu_port == port)
 		ksz8_cpu_port_link_up(dev, speed, duplex, tx_pause, rx_pause);
+	else if (dev->info->internal_phy[port])
+		ksz8_phy_port_link_up(dev, port, duplex, tx_pause, rx_pause);
 }
 
 static int ksz8_handle_global_errata(struct dsa_switch *ds)
-- 
2.39.2

