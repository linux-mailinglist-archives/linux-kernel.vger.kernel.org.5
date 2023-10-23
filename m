Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380AB7D3B72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjJWPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjJWPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:50:18 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F4D7A;
        Mon, 23 Oct 2023 08:50:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58B0D1BF216;
        Mon, 23 Oct 2023 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698076212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaYaHeCezQayxJ2/GqMRLkniVlk5Cnh902YETWh3nkE=;
        b=BmmDlWNXqjzRHh739q0oVMXuOGkb/XaxEOov8wLd13J7SODvhmnfHcENliU+hMjLm+xVl6
        NXCnR1xi9EduY2RboJZiH9K+RBySK5JXfRn9jU3XPPkXyIoc4NNEcQEZeWRAaDeaCpK7eP
        q1eXp9FxaAp/YMltdAmFoVmtLyv2sB7fpdyz2S3Q5W+DuY/bQCmJ1daSkhbU5zQCn0TZ0A
        d0Fc8+0eb9hRpu93ODScMMjIrCjrNG1oiSUdebx8CDp5DnHKSPtTuYz0vqtPR3K9jILtgl
        euzsy87sUdqApfLHESdmlWYL/DkxqQiYZ0uCeuiqtWyjwnTewzH2IsVq7Gf79g==
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 4/5] net: ipqess: add a PSGMII calibration procedure to the IPQESS driver
Date:   Mon, 23 Oct 2023 17:50:11 +0200
Message-ID: <20231023155013.512999-5-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023155013.512999-1-romain.gantois@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../ethernet/qualcomm/ipqess/ipqess_calib.c   | 495 ++++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.c    |   3 +-
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   4 +
 4 files changed, 502 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c

diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
index 51d7163ef0fc..110f6003f04b 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/Makefile
+++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
 
-ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_notifiers.o ipqess_edma.o
+ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_notifiers.o ipqess_edma.o ipqess_calib.o
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
new file mode 100644
index 000000000000..ca9b5593a200
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
@@ -0,0 +1,495 @@
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
+#define PSGMII_VCO_CALIB_CTRL  0x28 /* VCO PLL calibration */
+#define PSGMII_VCO_CALIB_READY BIT(0)
+
+/* Delays and timeouts */
+
+#define PSGMII_WAIT_AFTER_CALIB     50
+#define PSGMII_WAIT_AFTER_RELEASE   200
+#define PSGMII_VCO_CALIB_INTERVAL   1000000
+#define PSGMII_VCO_CALIB_TIMEOUT    10000
+#define PSGMII_CALIB_RETRIES        50
+#define PSGMII_CALIB_RETRIES_BURST  5
+#define PSGMII_CALIB_RETRY_DELAY    100
+
+/* Calibration data */
+
+struct psgmii_port_data {
+	struct list_head list;
+	struct phy_device *phy;
+	int id;
+
+	/* calibration test results */
+	u32 test_ok;
+	u32 tx_loss;
+	u32 rx_loss;
+	u32 tx_errors;
+	u32 rx_errors;
+};
+
+static LIST_HEAD(calib);
+
+static int psgmii_vco_calibrate(struct qca8k_priv *priv)
+{
+	int val, ret;
+
+	if (!priv->psgmii_ethphy) {
+		dev_err(priv->dev,
+			"PSGMII eth PHY missing, calibration failed!\n");
+		return -ENODEV;
+	}
+
+	/* Fix PSGMII RX 20bit */
+	ret = phy_clear_bits(priv->psgmii_ethphy, PSGMII_RSTCTRL,
+			     PSGMII_RSTCTRL_RX20);
+	/* Reset PHY PSGMII */
+	ret = phy_clear_bits(priv->psgmii_ethphy, PSGMII_RSTCTRL,
+			     PSGMII_RSTCTRL_RST);
+	/* Release PHY PSGMII reset */
+	ret = phy_set_bits(priv->psgmii_ethphy, PSGMII_RSTCTRL,
+			   PSGMII_RSTCTRL_RST);
+
+	/* Poll for VCO PLL calibration finish - Malibu(QCA8075) */
+	ret = phy_read_mmd_poll_timeout(priv->psgmii_ethphy,
+					MDIO_MMD_PMAPMD,
+					PSGMII_VCO_CALIB_CTRL,
+					val,
+					val & PSGMII_VCO_CALIB_READY,
+					PSGMII_VCO_CALIB_INTERVAL,
+					PSGMII_VCO_CALIB_TIMEOUT,
+					false);
+	if (ret) {
+		dev_err(priv->dev,
+			"QCA807x PSGMII VCO calibration PLL not ready\n");
+		return ret;
+	}
+	mdelay(PSGMII_WAIT_AFTER_CALIB);
+
+	/* Freeze PSGMII RX CDR */
+	ret = phy_clear_bits(priv->psgmii_ethphy, PSGMII_CDRCTRL,
+			     PSGMII_CDRCTRL_RELEASE);
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
+	mdelay(PSGMII_WAIT_AFTER_CALIB);
+
+	/* Release PSGMII RX CDR */
+	ret = phy_set_bits(priv->psgmii_ethphy, PSGMII_CDRCTRL,
+			   PSGMII_CDRCTRL_RELEASE);
+	/* Release PSGMII RX 20bit */
+	ret = phy_set_bits(priv->psgmii_ethphy, PSGMII_RSTCTRL,
+			   PSGMII_RSTCTRL_RX20);
+	mdelay(PSGMII_WAIT_AFTER_RELEASE);
+
+	return ret;
+}
+
+static int
+qca8k_wait_for_phy_link_state(struct phy_device *phy, int need_link)
+{
+	u16 status;
+	int ret;
+
+	ret = phy_read_poll_timeout(phy, MII_QCA8075_SSTATUS, status,
+				    !!(status & QCA8075_PHY_SPEC_STATUS_LINK) == need_link,
+				    MII_QCA8075_SSTATUS_WAIT, MII_QCA8075_SSTATUS_TIMEOUT, 1);
+	if (ret == -ETIMEDOUT)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void
+psgmii_phy_loopback_enable(struct qca8k_priv *priv, struct phy_device *phy,
+			   int sw_port)
+{
+	phy_write(phy, MII_BMCR, BMCR_ANENABLE | BMCR_RESET);
+	phy_modify(phy, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+	qca8k_wait_for_phy_link_state(phy, 0);
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(sw_port), 0);
+	phy_write(phy, MII_BMCR,
+		  BMCR_SPEED1000
+		  | BMCR_FULLDPLX
+		  | BMCR_LOOPBACK);
+	qca8k_wait_for_phy_link_state(phy, 1);
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(sw_port),
+		    QCA8K_PORT_STATUS_SPEED_1000
+		    | QCA8K_PORT_STATUS_TXMAC
+		    | QCA8K_PORT_STATUS_RXMAC
+		    | QCA8K_PORT_STATUS_DUPLEX);
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(sw_port),
+		  QCA8K_PORT_LOOKUP_STATE_FORWARD,
+		  QCA8K_PORT_LOOKUP_STATE_FORWARD);
+}
+
+static void
+psgmii_phy_loopback_disable(struct qca8k_priv *priv, struct phy_device *phy,
+			    int sw_port)
+{
+	qca8k_write(priv, QCA8K_REG_PORT_STATUS(sw_port), 0);
+	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(sw_port),
+		  QCA8K_PORT_LOOKUP_STATE_DISABLED,
+		  QCA8K_PORT_LOOKUP_STATE_DISABLED);
+	phy_write(phy, MII_BMCR,
+		  BMCR_SPEED1000 | BMCR_ANENABLE | BMCR_RESET);
+	/* turn off the power of the phys - so that unused
+	 * ports do not raise links
+	 */
+	phy_modify(phy, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+}
+
+static void
+qca8k_wait_for_phy_pkt_gen_fin(struct qca8k_priv *priv, struct phy_device *phy)
+{
+	int val;
+
+	/* Wait for all traffic to end:
+	 * 4096(pkt num)*1524(size)*8ns(125MHz)=49938us
+	 */
+	phy_read_mmd_poll_timeout(phy, MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_CTRL,
+				  val, !(val & QCA8075_MMD7_PKT_GEN_INPROGR),
+				  50000, 1000000, true);
+}
+
+static int
+psgmii_start_parallel_pkt_gen(struct qca8k_priv *priv)
+{
+	struct phy_device *phy;
+
+	phy = phy_device_create(priv->bus, QCA8075_MDIO_BRDCST_PHY_ADDR,
+				0, 0, NULL);
+	if (!phy) {
+		dev_err(priv->dev,
+			"unable to create mdio broadcast PHY(0x%x)\n",
+			QCA8075_MDIO_BRDCST_PHY_ADDR);
+		return -ENODEV;
+	}
+
+	/* start packet generation */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_CTRL,
+		      QCA8075_MMD7_PKT_GEN_START | QCA8075_MMD7_PKT_GEN_INPROGR);
+
+	phy_device_free(phy);
+	return 0;
+}
+
+static void
+qca8k_get_phy_pkt_gen_test_result(struct psgmii_port_data *port_data)
+{
+	struct phy_device *phy = port_data->phy;
+	u32 tx_all_ok, rx_all_ok;
+	u32 tx_ok, tx_errors;
+	u32 rx_ok, rx_errors;
+	u32 tx_ok_high16;
+	u32 rx_ok_high16;
+
+	/* check counters */
+	tx_ok = phy_read_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_EG_FRAME_RECV_CNT_LO);
+	tx_ok_high16 = phy_read_mmd(phy, MDIO_MMD_AN,
+				    QCA8075_MMD7_EG_FRAME_RECV_CNT_HI);
+	tx_errors = phy_read_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_EG_FRAME_ERR_CNT);
+	rx_ok = phy_read_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_IG_FRAME_RECV_CNT_LO);
+	rx_ok_high16 = phy_read_mmd(phy, MDIO_MMD_AN,
+				    QCA8075_MMD7_IG_FRAME_RECV_CNT_HI);
+	rx_errors = phy_read_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_IG_FRAME_ERR_CNT);
+	tx_all_ok = tx_ok + (tx_ok_high16 << 16);
+	rx_all_ok = rx_ok + (rx_ok_high16 << 16);
+
+	port_data->tx_loss = QCA8075_PKT_GEN_PKTS_COUNT - tx_all_ok;
+	port_data->rx_loss = QCA8075_PKT_GEN_PKTS_COUNT - rx_all_ok;
+	port_data->tx_errors = tx_errors;
+	port_data->rx_errors = rx_errors;
+	port_data->test_ok = !(port_data->tx_loss | port_data->rx_loss | tx_errors | rx_errors);
+}
+
+static void psgmii_port_cleanup_test(struct qca8k_priv *priv,
+				     struct psgmii_port_data *port_data)
+{
+	struct phy_device *phy = port_data->phy;
+	int port_id = port_data->id;
+
+	/* set packet count to 0 */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_PKT_NUMB, 0);
+
+	/* disable CRC checker and packet counter */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_CRC_AND_PKTS_COUNT, 0);
+
+	/* disable traffic gen */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_CTRL, 0);
+
+	/* disable broadcasts on MDIO bus */
+	phy_clear_bits_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_MDIO_BRDCST_WRITE,
+			   QCA8075_MMD7_MDIO_BRDCST_WRITE_EN);
+
+	/* disable loopback on switch port and PHY */
+	qca8k_clear_bits(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+			 QCA8K_PORT_LOOKUP_LOOPBACK_EN);
+	psgmii_phy_loopback_disable(priv, phy, port_id);
+}
+
+static void psgmii_port_prep_test(struct qca8k_priv *priv,
+				  struct psgmii_port_data *port_data)
+{
+	struct phy_device *phy = port_data->phy;
+	int port_id = port_data->id;
+
+	/* put PHY and switch port in loopback */
+	psgmii_phy_loopback_enable(priv, phy, port_id);
+	qca8k_set_bits(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
+		       QCA8K_PORT_LOOKUP_LOOPBACK_EN);
+
+	/* enable broadcasts on MDIO bus */
+	phy_set_bits_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_MDIO_BRDCST_WRITE,
+			 QCA8075_MMD7_MDIO_BRDCST_WRITE_EN);
+
+	/* enable PHY CRC checker and packet counters */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_CRC_AND_PKTS_COUNT,
+		      QCA8075_MMD7_CNT_FRAME_CHK_EN | QCA8075_MMD7_CNT_SELFCLR);
+	qca8k_wait_for_phy_link_state(phy, 1);
+
+	/* set number of packets to send during the test */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_PKT_NUMB,
+		      QCA8075_PKT_GEN_PKTS_COUNT);
+	/* set packet size */
+	phy_write_mmd(phy, MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_PKT_SIZE,
+		      QCA8075_PKT_GEN_PKTS_SIZE);
+}
+
+static int psgmii_link_parallel_test(struct qca8k_priv *priv)
+{
+	struct psgmii_port_data *port_data;
+	bool test_failed = false;
+
+	list_for_each_entry(port_data, &calib, list) {
+		/* prep switch port for test */
+		psgmii_port_prep_test(priv, port_data);
+	}
+
+	psgmii_start_parallel_pkt_gen(priv);
+
+	list_for_each_entry(port_data, &calib, list) {
+		/* wait for test results */
+		qca8k_wait_for_phy_pkt_gen_fin(priv, port_data->phy);
+		qca8k_get_phy_pkt_gen_test_result(port_data);
+
+		if (!port_data->test_ok) {
+			dev_dbg(priv->dev,
+				"PSGMII calibration: failed parallel test on port %d errors: %d %d %d %d\n",
+				port_data->id, port_data->tx_loss, port_data->rx_loss,
+				port_data->tx_errors, port_data->rx_errors);
+
+			test_failed = true;
+		}
+
+		psgmii_port_cleanup_test(priv, port_data);
+	}
+
+	return test_failed;
+}
+
+static int psgmii_link_serial_test(struct qca8k_priv *priv)
+{
+	struct psgmii_port_data *port_data;
+	bool test_failed = false;
+
+	list_for_each_entry(port_data, &calib, list) {
+		/* prep switch port for test */
+		psgmii_port_prep_test(priv, port_data);
+
+		/* start packet generation */
+		phy_write_mmd(port_data->phy,
+			      MDIO_MMD_AN, QCA8075_MMD7_PKT_GEN_CTRL,
+			      QCA8075_MMD7_PKT_GEN_START |
+			      QCA8075_MMD7_PKT_GEN_INPROGR);
+
+		/* wait for test results */
+		qca8k_wait_for_phy_pkt_gen_fin(priv, port_data->phy);
+		qca8k_get_phy_pkt_gen_test_result(port_data);
+
+		if (!port_data->test_ok) {
+			dev_dbg(priv->dev,
+				"PSGMII calibration: failed serial test on port %d errors: %d %d %d %d\n",
+				port_data->id, port_data->tx_loss, port_data->rx_loss,
+				port_data->tx_errors, port_data->rx_errors);
+
+			test_failed = true;
+		}
+
+		psgmii_port_cleanup_test(priv, port_data);
+	}
+
+	return test_failed;
+}
+
+static void psgmii_free_calib_data(void)
+{
+	struct psgmii_port_data *port_data, *temp;
+
+	list_for_each_entry_safe(port_data, temp, &calib, list) {
+		list_del(&port_data->list);
+		kfree(port_data);
+	}
+}
+
+static int psgmii_alloc_calib_data(struct qca8k_priv *priv)
+{
+	struct device_node *phy_dn, *ports, *port_dn;
+	struct psgmii_port_data *port_data;
+	struct phy_device *phy;
+	int err, port_id;
+
+	/* get port data from device tree */
+	ports = of_get_child_by_name(priv->dev->of_node, "ports");
+	if (!ports) {
+		dev_err(priv->dev, "no ports child node found\n");
+		return -EINVAL;
+	}
+	for_each_available_child_of_node(ports, port_dn) {
+		/* alloc port data */
+		port_data = kzalloc(sizeof(port_data), GFP_KERNEL);
+		if (!port_data) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		list_add(&port_data->list, &calib);
+
+		/* get port ID */
+		err = of_property_read_u32(port_dn, "reg", &port_id);
+		if (err) {
+			dev_err(priv->dev, "error: missing 'reg' property in device node\n");
+			goto out_free;
+		}
+
+		if (port_id >= QCA8K_NUM_PORTS) {
+			dev_err(priv->dev, "error: port ID out of range\n");
+			err = -EINVAL;
+			goto out_free;
+		}
+
+		/* get PHY device */
+		phy_dn = of_parse_phandle(port_dn, "phy-handle", 0);
+		if (!phy_dn) {
+			dev_err(priv->dev, "error: missing 'phy-handle' property in device node\n");
+			err = -EINVAL;
+			goto out_free;
+		}
+		phy = of_phy_find_device(phy_dn);
+		of_node_put(phy_dn);
+		if (!phy) {
+			dev_err(priv->dev,
+				"error: unable to fetch PHY device for port %d\n",
+				port_id);
+			err = -EINVAL;
+			goto out_free;
+		}
+
+		port_data->phy = phy;
+		port_data->id = port_id;
+	}
+
+	return 0;
+
+out_free:
+	psgmii_free_calib_data();
+	return err;
+}
+
+int psgmii_calibrate_and_test(struct qca8k_priv *priv)
+{
+	struct psgmii_port_data *port_data;
+	bool test_failed = false;
+	int ret, attempt;
+
+	ret = psgmii_alloc_calib_data(priv);
+	if (ret)
+		return ret;
+
+	for (attempt = 0; attempt <= PSGMII_CALIB_RETRIES; attempt++) {
+		/* first we run the VCO calibration */
+		ret = psgmii_vco_calibrate(priv);
+		if (ret)
+			goto out_free;
+
+		/* then, we test the link */
+		test_failed = psgmii_link_serial_test(priv);
+		if (!test_failed)
+			test_failed = psgmii_link_parallel_test(priv);
+
+		qca8k_fdb_flush(priv);
+
+		if (!test_failed) {
+			dev_dbg(priv->dev,
+				"PSGMII link stabilized after %d attempts\n",
+				attempt + 1);
+			ret = 0;
+			goto out_free;
+		}
+
+		/* On tested hardware, the link often stabilizes in 4 or 5 retries.
+		 * If it still isn't stable, we wait a bit, then try another set
+		 * of calibration attempts.
+		 */
+		dev_warn(priv->dev, "PSGMII link is unstable! Retrying... %d/QCA8K_PSGMII_CALIB_RETRIES\n",
+			 attempt + 1);
+		if (attempt % PSGMII_CALIB_RETRIES_BURST == 0)
+			schedule_timeout_interruptible(msecs_to_jiffies(PSGMII_CALIB_RETRY_DELAY));
+		else
+			schedule();
+	}
+
+	dev_err(priv->dev, "PSGMII work is unstable! Repeated recalibration attempts did not help!\n");
+	ret = -EFAULT;
+
+out_free:
+	list_for_each_entry(port_data, &calib, list) {
+		put_device(&port_data->phy->mdio.dev);
+	}
+	psgmii_free_calib_data();
+	return ret;
+}
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
index 95407a008971..757d937dd711 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
@@ -1315,7 +1315,8 @@ ipqess_psgmii_configure(struct qca8k_priv *priv)
 	int ret;
 
 	if (!atomic_fetch_inc(&priv->psgmii_calibrated)) {
-		dev_warn(priv->dev, "Unable to calibrate PSGMII, link will be unstable!\n");
+		dev_dbg(priv->dev, "starting PSGMII calibration...\n");
+		psgmii_calibrate_and_test(priv);
 
 		ret = regmap_clear_bits(priv->psgmii, PSGMIIPHY_MODE_CONTROL,
 					PSGMIIPHY_MODE_ATHR_CSCO_MODE_25M);
diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
index a0639933e8bb..6e6a5d15f588 100644
--- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
+++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
@@ -92,4 +92,8 @@ int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
 
 bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
 				      const struct net_device *netdev);
+
+/* Defined in ipqess_calib.c */
+int psgmii_calibrate_and_test(struct qca8k_priv *priv);
+
 #endif
-- 
2.42.0

