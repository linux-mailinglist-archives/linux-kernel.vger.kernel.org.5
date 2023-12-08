Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40DA80A700
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574229AbjLHPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574404AbjLHPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:12:48 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD001BD1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:12:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rBcWH-0001Li-Gb; Fri, 08 Dec 2023 16:12:01 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rBcWG-00ERqQ-6f; Fri, 08 Dec 2023 16:12:00 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1rBcWG-00BiHW-0T;
        Fri, 08 Dec 2023 16:12:00 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v1 2/2] net: phy: Add support for the DP83TG720S Ethernet PHY
Date:   Fri,  8 Dec 2023 16:11:59 +0100
Message-Id: <20231208151159.2791794-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208151159.2791794-1-o.rempel@pengutronix.de>
References: <20231208151159.2791794-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DP83TG720S-Q1 device is an IEEE 802.3bp and Open Alliance compliant
automotive Ethernet physical layer transceiver.

This driver was tested with i.MX8MP EQOS (stmmac) on the MAC side and
TI same PHY on other side.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/Kconfig     |  13 +++
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/dp83tg720.c | 190 ++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 drivers/net/phy/dp83tg720.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 25cfc5ded1da..bab10c796f24 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -372,6 +372,19 @@ config DP83TC811_PHY
 	help
 	  Supports the DP83TC811 PHY.
 
+config DP83TG720_PHY
+	tristate "Texas Instruments DP83TG720 Ethernet 1000Base-T1 PHY"
+	help
+	  The DP83TG720S-Q1 is an automotive Ethernet physical layer
+	  transceiver compliant with IEEE 802.3bp and Open Alliance
+	  standards. It supports key functions necessary for
+	  transmitting and receiving data over both unshielded and
+	  shielded single twisted-pair cables. This device offers
+	  flexible xMII interface options, including support for both
+	  RGMII and SGMII MAC interfaces. It's suitable for applications
+	  requiring high-speed data transmission in automotive
+	  networking environments.
+
 config DP83848_PHY
 	tristate "Texas Instruments DP83848 PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f65e85c91fc1..defaef190962 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
 obj-$(CONFIG_DP83867_PHY)	+= dp83867.o
 obj-$(CONFIG_DP83869_PHY)	+= dp83869.o
 obj-$(CONFIG_DP83TC811_PHY)	+= dp83tc811.o
+obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
 obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
new file mode 100644
index 000000000000..133952e88c6c
--- /dev/null
+++ b/drivers/net/phy/dp83tg720.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Driver for the Texas Instruments DP83TG720 PHY
+ * Copyright (c) 2023 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+ */
+#include <linux/bitfield.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+
+#define DP83TG720S_PHY_ID			0x2000a284
+
+/* MDIO_MMD_VEND2 registers */
+#define DP83TG720S_MII_REG_10			0x10
+#define DP83TG720S_STS_MII_INT			BIT(7)
+#define DP83TG720S_LINK_STATUS			BIT(0)
+
+#define DP83TG720S_PHY_RESET			0x1f
+#define DP83TG720S_HW_RESET			BIT(15)
+
+#define DP83TG720S_RGMII_DELAY_CTRL		0x602
+/* In RGMII mode, Enable or disable the internal delay for RXD */
+#define DP83TG720S_RGMII_RX_CLK_SEL		BIT(1)
+/* In RGMII mode, Enable or disable the internal delay for TXD */
+#define DP83TG720S_RGMII_TX_CLK_SEL		BIT(0)
+
+#define DP83TG720S_SQI_REG_1			0x871
+#define DP83TG720S_SQI_OUT_WORST		GENMASK(7, 5)
+#define DP83TG720S_SQI_OUT			GENMASK(3, 1)
+
+#define DP83TG720_SQI_MAX			7
+
+static int dp83tg720_read_status(struct phy_device *phydev)
+{
+	u16 phy_sts;
+	int ret;
+
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	/* Most of Clause 45 registers are not present, so we can't use
+	 * genphy_c45_read_status() here.
+	 */
+	phy_sts = phy_read(phydev, DP83TG720S_MII_REG_10);
+	phydev->link = !!(phy_sts & DP83TG720S_LINK_STATUS);
+	if (!phydev->link) {
+		/* According to the "DP83TC81x, DP83TG72x Software
+		 * Implementation Guide", the PHY needs to be reset after a
+		 * link loss or if no link is created after at least 100ms.
+		 *
+		 * Currently we are polling with the PHY_STATE_TIME (1000ms)
+		 * interval, which is still enough for not automotive use cases.
+		 */
+		ret = phy_init_hw(phydev);
+		if (ret)
+			return ret;
+
+		/* After HW reset we need to restore master/slave configuration.
+		 */
+		if (phydev->drv->config_aneg) {
+			ret = phydev->drv->config_aneg(phydev);
+			if (ret)
+				return ret;
+		}
+
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+	} else {
+		/* PMA/PMD control 1 register (Register 1.0) is present, but it
+		 * doesn't contain the link speed information.
+		 * So genphy_c45_read_pma() can't be used here.
+		 */
+		ret = genphy_c45_pma_baset1_read_master_slave(phydev);
+		if (ret)
+			return ret;
+
+		phydev->duplex = DUPLEX_FULL;
+		phydev->speed = SPEED_1000;
+	}
+
+	return 0;
+}
+
+static int dp83tg720_config_aneg(struct phy_device *phydev)
+{
+	/* Autoneg is not supported and this PHY supports only one speed.
+	 * We need to care only about master/slave configuration if it was
+	 * changed by user.
+	 */
+	return genphy_c45_pma_baset1_setup_master_slave(phydev);
+}
+
+static int dp83tg720_get_sqi(struct phy_device *phydev)
+{
+	int ret;
+
+	if (!phydev->link)
+		return 0;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_SQI_REG_1);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(DP83TG720S_SQI_OUT, ret);
+}
+
+static int dp83tg720_get_sqi_max(struct phy_device *phydev)
+{
+	return DP83TG720_SQI_MAX;
+}
+
+static int dp83tg720_config_rgmii_delay(struct phy_device *phydev)
+{
+	u16 rgmii_delay_mask;
+	u16 rgmii_delay = 0;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		rgmii_delay = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		rgmii_delay = DP83TG720S_RGMII_RX_CLK_SEL |
+				DP83TG720S_RGMII_TX_CLK_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		rgmii_delay = DP83TG720S_RGMII_RX_CLK_SEL;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		rgmii_delay = DP83TG720S_RGMII_TX_CLK_SEL;
+		break;
+	default:
+		return 0;
+	}
+
+	rgmii_delay_mask = DP83TG720S_RGMII_RX_CLK_SEL |
+		DP83TG720S_RGMII_TX_CLK_SEL;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			      DP83TG720S_RGMII_DELAY_CTRL, rgmii_delay_mask,
+			      rgmii_delay);
+}
+
+static int dp83tg720_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Software Restart is not enough to recover from a link failure.
+	 * Using Hardware Reset instead.
+	 */
+	ret = phy_write(phydev, DP83TG720S_PHY_RESET, DP83TG720S_HW_RESET);
+	if (ret)
+		return ret;
+
+	/* Wait until MDC can be used again.
+	 * The wait value of one 1ms is documented in "DP83TG720S-Q1 1000BASE-T1
+	 * Automotive Ethernet PHY with SGMII and RGMII" datasheet.
+	 */
+	usleep_range(1000, 2000);
+
+	if (phy_interface_is_rgmii(phydev))
+		return dp83tg720_config_rgmii_delay(phydev);
+
+	return 0;
+}
+
+static struct phy_driver dp83tg720_driver[] = {
+{
+	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
+	.name		= "TI DP83TG720S",
+
+	.config_aneg	= dp83tg720_config_aneg,
+	.read_status	= dp83tg720_read_status,
+	.get_features	= genphy_c45_pma_read_ext_abilities,
+	.config_init	= dp83tg720_config_init,
+	.get_sqi	= dp83tg720_get_sqi,
+	.get_sqi_max	= dp83tg720_get_sqi_max,
+
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+} };
+module_phy_driver(dp83tg720_driver);
+
+static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
+	{ PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
+
+MODULE_DESCRIPTION("Texas Instruments DP83TG720S PHY driver");
+MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
+MODULE_LICENSE("GPL");
-- 
2.39.2

