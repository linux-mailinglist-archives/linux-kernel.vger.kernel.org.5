Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE6A7EAC90
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjKNJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjKNJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:08:32 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929D1AA;
        Tue, 14 Nov 2023 01:08:27 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63EDDC000F;
        Tue, 14 Nov 2023 09:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699952906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Fa50vvn+duinPvSNUJkisW2bIzFpaD50oi5DY2jbeU=;
        b=AbvX2tn/bXd5sC+lEFQ0xbvvkaIB1xrfzmwNkKJnPUdYGc9G3/wPiGRN5I669nl4P2KABk
        pZvKKJrP2mS2MQSvHTk4apC9vKyG+w4iQiv61clhW1t7qq00T4u242qS2xoojWe8XkzRNt
        mDKwDZ6bAOcBxDNBeX5spExg0ZWWICPAmdeXMtto8ipZbUBb1iCnA3n4eQHxisnaI7cvUU
        w1oQSij4O/RDcPyYy8o/GdiQb3PxbFfgI0xZmSiZcHOztNiSwXhGeiHojLk48fvl5xcaVz
        jz2b5m4GRc5UFwnU2ncpi9bBBVf9sTXPhS+tWabDpoKnMXwmgRzMyfOEes5B3w==
From:   Romain Gantois <romain.gantois@bootlin.com>
To:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Romain Gantois <romain.gantois@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v2 7/8] net: qualcomm: ipqess: add a PSGMII calibration procedure to the IPQESS driver
Date:   Tue, 14 Nov 2023 10:07:33 +0100
Message-ID: <20231114090743.865453-8-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114090743.865453-1-romain.gantois@bootlin.com>
References: <20231114090743.865453-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPQ4019 Ethernet Switch Subsystem uses a PSGMII link to communicate
with a QCA8075 5-port PHY. This 1G link requires calibration before it can
be used reliably.

This commit introduces a calibration procedure followed by thourough
testing of the link between each switch port and its corresponding PHY
port.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/ethernet/qualcomm/ipqess/Makefile |   2 +-
 .../ethernet/qualcomm/ipqess/ipqess_calib.c   | 156 ++++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.c    |  30 ++++
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   4 +
 include/linux/dsa/qca8k.h                     |   1 +
 5 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c

diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
index b12142bbc7e5..5e755af579ae 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/Makefile
+++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
 
-ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o ipqess_ethtool.o ipqess_notifiers.o
+ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o ipqess_ethtool.o ipqess_notifiers.o ipqess_calib.o
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
new file mode 100644
index 000000000000..da9d492ca7eb
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Calibration procedure for the IPQ4019 PSGMII link
+ *
+ * Copyright (C) 2009 Felix Fietkau <nbd@nbd.name>
+ * Copyright (C) 2011-2012, 2020-2021 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (c) 2015, 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2016 John Crispin <john@phrozen.org>
+ * Copyright (c) 2022 Robert Marko <robert.marko@sartura.hr>
+ * Copyright (c) 2023 Romain Gantois <romain.gantois@bootlin.com>
+ */
+
+#include <linux/dsa/qca8k.h>
+#include <linux/phylink.h>
+#include <linux/of_net.h>
+#include <linux/of_mdio.h>
+#include <linux/regmap.h>
+
+#include "ipqess_port.h"
+#include "ipqess_switch.h"
+
+/* Nonstandard MII registers for the psgmii
+ * device on the IPQ4019 MDIO bus.
+ */
+
+#define PSGMII_RSTCTRL      0x0     /* Reset control register */
+#define PSGMII_RSTCTRL_RST  BIT(6)
+#define PSGMII_RSTCTRL_RX20 BIT(2)  /* Fix/release RX 20 bit */
+
+#define PSGMII_CDRCTRL         0x1a /* Clock and data recovery control register */
+#define PSGMII_CDRCTRL_RELEASE BIT(12)
+
+/* Retry policy */
+
+#define PSGMII_CALIB_RETRIES        50
+#define PSGMII_CALIB_RETRIES_BURST  5
+#define PSGMII_CALIB_RETRY_DELAY    100
+
+/* PSGMII PHY specific definitions */
+#define PSGMII_VCO_CALIB_INTERVAL   1000000
+#define PSGMII_VCO_CALIB_TIMEOUT    10000
+
+static void ipqess_port_unprep_test(struct ipqess_port *port)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+	/* disable loopback on switch port */
+	qca8k_clear_bits(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
+			 QCA8K_PORT_LOOKUP_LOOPBACK_EN);
+
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), 0);
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
+		  QCA8K_PORT_LOOKUP_STATE_DISABLED,
+		  QCA8K_PORT_LOOKUP_STATE_DISABLED);
+}
+
+static void ipqess_port_prep_test(struct ipqess_port *port)
+{
+	struct qca8k_priv *priv = port->sw->priv;
+
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index),
+		    QCA8K_PORT_STATUS_SPEED_1000
+		    | QCA8K_PORT_STATUS_TXMAC
+		    | QCA8K_PORT_STATUS_RXMAC
+		    | QCA8K_PORT_STATUS_DUPLEX);
+
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
+		  QCA8K_PORT_LOOKUP_STATE_FORWARD,
+		  QCA8K_PORT_LOOKUP_STATE_FORWARD);
+
+	/* put switch port in loopback */
+	qca8k_set_bits(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
+		       QCA8K_PORT_LOOKUP_LOOPBACK_EN);
+}
+
+static int psgmii_vco_calibrate(struct ipqess_port *port)
+{
+	struct ipqess_switch *sw = port->sw;
+	struct qca8k_priv *priv = sw->priv;
+	struct ipqess_port *other_port;
+	int val, ret, i;
+
+	ret = phy_start_calibration(port->netdev->phydev);
+	if (ret) {
+		dev_err(priv->dev,
+			"PHY VCO calibration PLL not ready\n");
+		return ret;
+	}
+
+	/* Start PSGMIIPHY VCO PLL calibration */
+	ret = regmap_set_bits(priv->psgmii,
+			      PSGMIIPHY_VCO_CALIBRATION_CONTROL_REGISTER_1,
+			      PSGMIIPHY_REG_PLL_VCO_CALIB_RESTART);
+
+	/* Poll for PSGMIIPHY PLL calibration finish - Dakota(IPQ40xx) */
+	ret = regmap_read_poll_timeout(priv->psgmii,
+				       PSGMIIPHY_VCO_CALIBRATION_CONTROL_REGISTER_2,
+				       val,
+				       val & PSGMIIPHY_REG_PLL_VCO_CALIB_READY,
+				       PSGMII_VCO_CALIB_INTERVAL,
+				       PSGMII_VCO_CALIB_TIMEOUT);
+	if (ret) {
+		dev_err(priv->dev,
+			"IPQ PSGMIIPHY VCO calibration PLL not ready\n");
+		return ret;
+	}
+
+	/* Prepare all switch ports, in case we're dealing with a multiport PHY */
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i];
+		if (!other_port)
+			continue;
+		ipqess_port_prep_test(other_port);
+	}
+
+	ret = phy_stop_calibration(port->netdev->phydev);
+
+	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
+		other_port = sw->port_list[i];
+		if (!other_port)
+			continue;
+		ipqess_port_unprep_test(other_port);
+	}
+
+	qca8k_fdb_flush(priv);
+
+	return ret;
+}
+
+int psgmii_calibrate_and_test(struct ipqess_port *port)
+{
+	int ret, attempt;
+
+	for (attempt = 0; attempt <= PSGMII_CALIB_RETRIES; attempt++) {
+		ret = psgmii_vco_calibrate(port);
+		if (!ret) {
+			netdev_dbg(port->netdev,
+				   "PSGMII link stabilized after %d attempts\n",
+				   attempt + 1);
+			return 0;
+		}
+
+		/* On tested hardware, the link often stabilizes in 4 or 5 retries.
+		 * If it still isn't stable, we wait a bit, then try another set
+		 * of calibration attempts.
+		 */
+		netdev_dbg(port->netdev, "PSGMII link is unstable! Retrying... %d/QCA8K_PSGMII_CALIB_RETRIES\n",
+			   attempt + 1);
+		if (attempt % PSGMII_CALIB_RETRIES_BURST == 0)
+			schedule_timeout_interruptible(msecs_to_jiffies(PSGMII_CALIB_RETRY_DELAY));
+		else
+			schedule();
+	}
+
+	netdev_err(port->netdev, "PSGMII work is unstable! Repeated recalibration attempts did not help!\n");
+	return -EFAULT;
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
index 29420820c3d8..ea759707335a 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
@@ -1218,6 +1218,26 @@ int ipqess_port_check_8021q_upper(struct net_device *netdev,
 
 /* phylink ops */
 
+static int
+ipqess_psgmii_configure(struct ipqess_port *port)
+{
+	int ret = 0;
+
+	/* For this multi-port PHY, we only need one calibration run,
+	 * don't rerun it for other ports
+	 */
+	if (!atomic_cmpxchg(&port->sw->priv->psgmii_calibrated, 0, 1)) {
+		psgmii_calibrate_and_test(port);
+
+		ret = regmap_clear_bits(port->sw->priv->psgmii, PSGMIIPHY_MODE_CONTROL,
+					PSGMIIPHY_MODE_ATHR_CSCO_MODE_25M);
+		ret = regmap_write(port->sw->priv->psgmii, PSGMIIPHY_TX_CONTROL,
+				   PSGMIIPHY_TX_CONTROL_MAGIC_VALUE);
+	}
+
+	return ret;
+}
+
 static void
 ipqess_phylink_mac_config(struct phylink_config *config,
 			  unsigned int mode,
@@ -1233,12 +1253,22 @@ ipqess_phylink_mac_config(struct phylink_config *config,
 	case 1:
 	case 2:
 	case 3:
+		if (state->interface == PHY_INTERFACE_MODE_PSGMII)
+			if (ipqess_psgmii_configure(port))
+				dev_err(priv->dev,
+					"PSGMII configuration failed!\n");
+		return;
 	case 4:
 	case 5:
 		if (phy_interface_mode_is_rgmii(state->interface))
 			regmap_set_bits(priv->regmap,
 					QCA8K_IPQ4019_REG_RGMII_CTRL,
 					QCA8K_IPQ4019_RGMII_CTRL_CLK);
+
+		if (state->interface == PHY_INTERFACE_MODE_PSGMII)
+			if (ipqess_psgmii_configure(port))
+				dev_err(priv->dev,
+					"PSGMII configuration failed!\n");
 		return;
 	default:
 		dev_err(priv->dev, "%s: unsupported port: %i\n", __func__,
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
index 00f0dff9c39d..bc24a0507702 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
@@ -95,4 +95,8 @@ int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
 
 bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
 				      const struct net_device *netdev);
+
+/* Defined in ipqess_calib.c */
+int psgmii_calibrate_and_test(struct ipqess_port *port);
+
 #endif
diff --git a/include/linux/dsa/qca8k.h b/include/linux/dsa/qca8k.h
index 9ad016f7201e..72c488e7c498 100644
--- a/include/linux/dsa/qca8k.h
+++ b/include/linux/dsa/qca8k.h
@@ -496,6 +496,7 @@ struct qca8k_priv {
 
 	/* IPQ4019 specific */
 	struct regmap *psgmii;
+	atomic_t psgmii_calibrated;
 };
 
 struct qca8k_mib_desc {
-- 
2.42.0

