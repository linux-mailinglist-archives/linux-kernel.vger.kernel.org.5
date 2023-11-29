Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E046D7FCCBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjK2CNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjK2CMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB51BEA;
        Tue, 28 Nov 2023 18:12:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso47239985e9.2;
        Tue, 28 Nov 2023 18:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223962; x=1701828762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE7+Cr3EheYw0+6xQZrA2aLmXhyMrCaMz02pkm5p3XQ=;
        b=IX3Z3mzYjgqU8hcfTgVWNNjEp1ibedXSMqxus1ZPL4h2ep8HjsgDG13QICxZo9XpoV
         Rf7wZtX24pAh+VeWHrxk7Nvt1gjoC6PbOWeX1Tj8Y7g9RuGiQGThU3vGmY9FDZ9PT9x0
         jZ2GSl13j+BjP3r/Y5Um2RHtDpHImoKuLgZUnwYw71LMAqvUVAaT/ZSsvnJNpN8KlHb7
         Fpjxyh2X8M8tFDbF1X+FBiF38Z3n92f7IZQQSUrGh/pfwOk5073+Om6H8zmW8xr8DHHj
         ynJIfxtL3X0IBbOzhVMBVXVYzjRMkoV0QZortpBF6pWB7Csh6e7XyUHN1ojOfU4Dpzyd
         qP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223962; x=1701828762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE7+Cr3EheYw0+6xQZrA2aLmXhyMrCaMz02pkm5p3XQ=;
        b=hnliKD9xIr6h6BgDrX6rU5BhH/ShsV81KZucUzAAVj1t2UbnDNgekC4o2g6uvtg7cA
         A7v7N5cU9RfhdDy8TkEkmeM2p1evUg1dTap3S2NYJRGG3cjOgG1kdK5yUt5aQN+Fzmbd
         lhmtfUzNDxJeiFVPTK2nLVzbhw63LaVbe0lOjQkmEA+wHmuNrVe4LU9+dIJfQH/4kuDP
         BQRPZC98aL/zBpY5qpiQLNQmp9mw2fNmhvo5MrkRShd6bKHoxImsvkID3uKPDel4UXr6
         Zs/MDDcU0sJBOKvSqRpU/4w9CFgIP/1GuT0HzKRevJmX0o3wOdW4JJh1K3zgtcbyaot3
         BP8g==
X-Gm-Message-State: AOJu0YxxbSyOfS4/FUG2Xm+D8fIkBFbmBOHbK++dX/1NqKvH2AXSkCqN
        NEMT+iVU+xNdxak4w4F9ifA=
X-Google-Smtp-Source: AGHT+IFx0TpOB2840kbhWQZVSG1OWyHu3SmkpT5AfJXU0/AsoyEIXqT1aI0XZ+FQZqLfYS0TSzikUw==
X-Received: by 2002:a05:600c:3c93:b0:409:6e0e:e948 with SMTP id bg19-20020a05600c3c9300b004096e0ee948mr11526492wmb.1.1701223962127;
        Tue, 28 Nov 2023 18:12:42 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:41 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 13/14] net: phy: qcom: deatch qca83xx PHY driver from at803x
Date:   Wed, 29 Nov 2023 03:12:18 +0100
Message-Id: <20231129021219.20914-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129021219.20914-1-ansuelsmth@gmail.com>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deatch qca83xx PHY driver from at803x.

The QCA83xx PHYs implement specific function and doesn't use generic
at803x so it can be detached from the driver and moved to a dedicated
one.

Some function for debug reg access are shared between the new qca83xx
driver and the at803x driver, for this reason some function are also
detached from at803x and moved to a common .c to be used by the 2
driver.

This is to make slimmer PHY drivers instead of including lots of bloat
that would never be used in specific SoC.

A new Kconfig flag QCA83XX_PHY is introduced to compile the new
introduced PHY driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/Kconfig   |   7 +-
 drivers/net/phy/qcom/Makefile  |   3 +-
 drivers/net/phy/qcom/at803x.c  | 326 +--------------------------------
 drivers/net/phy/qcom/common.c  |  50 +++++
 drivers/net/phy/qcom/qca83xx.c | 275 +++++++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h    |  38 ++++
 6 files changed, 374 insertions(+), 325 deletions(-)
 create mode 100644 drivers/net/phy/qcom/common.c
 create mode 100644 drivers/net/phy/qcom/qca83xx.c
 create mode 100644 drivers/net/phy/qcom/qcom.h

diff --git a/drivers/net/phy/qcom/Kconfig b/drivers/net/phy/qcom/Kconfig
index 2c274fbbe410..06914f23a92e 100644
--- a/drivers/net/phy/qcom/Kconfig
+++ b/drivers/net/phy/qcom/Kconfig
@@ -1,7 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config AT803X_PHY
-	tristate "Qualcomm Atheros AR803X PHYs and QCA833x PHYs"
+	tristate "Qualcomm Atheros AR803X PHYs"
 	depends on REGULATOR
 	help
 	  Currently supports the AR8030, AR8031, AR8033, AR8035 and internal
 	  QCA8337(Internal qca8k PHY) model
+
+config QCA83XX_PHY
+	tristate "Qualcomm Atheros QCA833x PHYs"
+	help
+	  Currently supports the internal QCA8337(Internal qca8k PHY) model
diff --git a/drivers/net/phy/qcom/Makefile b/drivers/net/phy/qcom/Makefile
index 6a68da8aaa7b..43e4d14df8ea 100644
--- a/drivers/net/phy/qcom/Makefile
+++ b/drivers/net/phy/qcom/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_AT803X_PHY)	+= at803x.o
+obj-$(CONFIG_AT803X_PHY)	+= at803x.o common.o
+obj-$(CONFIG_QCA83XX_PHY)	+= qca83xx.o common.o
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index c6aa31495324..80da66c3d3e9 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -22,6 +22,8 @@
 #include <linux/sfp.h>
 #include <dt-bindings/net/qca-ar803x.h>
 
+#include "qcom.h"
+
 #define AT803X_SPECIFIC_FUNCTION_CONTROL	0x10
 #define AT803X_SFC_ASSERT_CRS			BIT(11)
 #define AT803X_SFC_FORCE_LINK			BIT(10)
@@ -84,9 +86,6 @@
 #define AT803X_REG_CHIP_CONFIG			0x1f
 #define AT803X_BT_BX_REG_SEL			0x8000
 
-#define AT803X_DEBUG_ADDR			0x1D
-#define AT803X_DEBUG_DATA			0x1E
-
 #define AT803X_MODE_CFG_MASK			0x0F
 #define AT803X_MODE_CFG_BASET_RGMII		0x00
 #define AT803X_MODE_CFG_BASET_SGMII		0x01
@@ -103,30 +102,6 @@
 #define AT803X_PSSR				0x11	/*PHY-Specific Status Register*/
 #define AT803X_PSSR_MR_AN_COMPLETE		0x0200
 
-#define AT803X_DEBUG_ANALOG_TEST_CTRL		0x00
-#define QCA8327_DEBUG_MANU_CTRL_EN		BIT(2)
-#define QCA8337_DEBUG_MANU_CTRL_EN		GENMASK(3, 2)
-#define AT803X_DEBUG_RX_CLK_DLY_EN		BIT(15)
-
-#define AT803X_DEBUG_SYSTEM_CTRL_MODE		0x05
-#define AT803X_DEBUG_TX_CLK_DLY_EN		BIT(8)
-
-#define AT803X_DEBUG_REG_HIB_CTRL		0x0b
-#define   AT803X_DEBUG_HIB_CTRL_SEL_RST_80U	BIT(10)
-#define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
-#define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
-
-#define AT803X_DEBUG_REG_3C			0x3C
-
-#define AT803X_DEBUG_REG_GREEN			0x3D
-#define   AT803X_DEBUG_GATE_CLK_IN1000		BIT(6)
-
-#define AT803X_DEBUG_REG_1F			0x1F
-#define AT803X_DEBUG_PLL_ON			BIT(2)
-#define AT803X_DEBUG_RGMII_1V8			BIT(3)
-
-#define MDIO_AZ_DEBUG				0x800D
-
 /* AT803x supports either the XTAL input pad, an internal PLL or the
  * DSP as clock reference for the clock output pad. The XTAL reference
  * is only used for 25 MHz output, all other frequencies need the PLL.
@@ -177,17 +152,12 @@
 
 #define QCA8081_PHY_ID				0x004dd101
 
-#define QCA8327_A_PHY_ID			0x004dd033
-#define QCA8327_B_PHY_ID			0x004dd034
-#define QCA8337_PHY_ID				0x004dd036
 #define QCA9561_PHY_ID				0x004dd042
-#define QCA8K_PHY_ID_MASK			0xffffffff
-
-#define QCA8K_DEVFLAGS_REVISION_MASK		GENMASK(2, 0)
 
 #define AT803X_PAGE_FIBER			0
 #define AT803X_PAGE_COPPER			1
 
+/* AT803x priv flags */
 /* don't turn off internal PLL */
 #define AT803X_KEEP_PLL_ENABLED			BIT(0)
 #define AT803X_DISABLE_SMARTEEE			BIT(1)
@@ -283,33 +253,11 @@ MODULE_DESCRIPTION("Qualcomm Atheros AR803x and QCA808X PHY driver");
 MODULE_AUTHOR("Matus Ujhelyi");
 MODULE_LICENSE("GPL");
 
-enum stat_access_type {
-	PHY,
-	MMD
-};
-
-struct at803x_hw_stat {
-	const char *string;
-	u8 reg;
-	u32 mask;
-	enum stat_access_type access_type;
-};
-
-static struct at803x_hw_stat qca83xx_hw_stats[] = {
-	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
-	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
-	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
-};
-
 struct at803x_ss_mask {
 	u16 speed_mask;
 	u8 speed_shift;
 };
 
-struct qca83xx_priv {
-	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
-};
-
 struct at8031_data {
 	bool is_fiber;
 	bool is_1000basex;
@@ -337,45 +285,6 @@ struct at803x_context {
 	u16 led_control;
 };
 
-static int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
-{
-	int ret;
-
-	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
-	if (ret < 0)
-		return ret;
-
-	return phy_write(phydev, AT803X_DEBUG_DATA, data);
-}
-
-static int at803x_debug_reg_read(struct phy_device *phydev, u16 reg)
-{
-	int ret;
-
-	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
-	if (ret < 0)
-		return ret;
-
-	return phy_read(phydev, AT803X_DEBUG_DATA);
-}
-
-static int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
-				 u16 clear, u16 set)
-{
-	u16 val;
-	int ret;
-
-	ret = at803x_debug_reg_read(phydev, reg);
-	if (ret < 0)
-		return ret;
-
-	val = ret & 0xffff;
-	val &= ~clear;
-	val |= set;
-
-	return phy_write(phydev, AT803X_DEBUG_DATA, val);
-}
-
 static int at803x_write_page(struct phy_device *phydev, int page)
 {
 	int mask;
@@ -527,53 +436,6 @@ static void at803x_get_wol(struct phy_device *phydev,
 		wol->wolopts |= WAKE_MAGIC;
 }
 
-static int qca83xx_get_sset_count(struct phy_device *phydev)
-{
-	return ARRAY_SIZE(qca83xx_hw_stats);
-}
-
-static void qca83xx_get_strings(struct phy_device *phydev, u8 *data)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++) {
-		strscpy(data + i * ETH_GSTRING_LEN,
-			qca83xx_hw_stats[i].string, ETH_GSTRING_LEN);
-	}
-}
-
-static u64 qca83xx_get_stat(struct phy_device *phydev, int i)
-{
-	struct at803x_hw_stat stat = qca83xx_hw_stats[i];
-	struct qca83xx_priv *priv = phydev->priv;
-	int val;
-	u64 ret;
-
-	if (stat.access_type == MMD)
-		val = phy_read_mmd(phydev, MDIO_MMD_PCS, stat.reg);
-	else
-		val = phy_read(phydev, stat.reg);
-
-	if (val < 0) {
-		ret = U64_MAX;
-	} else {
-		val = val & stat.mask;
-		priv->stats[i] += val;
-		ret = priv->stats[i];
-	}
-
-	return ret;
-}
-
-static void qca83xx_get_stats(struct phy_device *phydev,
-			      struct ethtool_stats *stats, u64 *data)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++)
-		data[i] = qca83xx_get_stat(phydev, i);
-}
-
 static int at803x_suspend(struct phy_device *phydev)
 {
 	int value;
@@ -1689,138 +1551,6 @@ static int at8035_probe(struct phy_device *phydev)
 	return at8035_parse_dt(phydev);
 }
 
-static int qca83xx_probe(struct phy_device *phydev)
-{
-	struct device *dev = &phydev->mdio.dev;
-	struct qca83xx_priv *priv;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	phydev->priv = priv;
-
-	return 0;
-}
-
-static int qca83xx_config_init(struct phy_device *phydev)
-{
-	u8 switch_revision;
-
-	switch_revision = phydev->dev_flags & QCA8K_DEVFLAGS_REVISION_MASK;
-
-	switch (switch_revision) {
-	case 1:
-		/* For 100M waveform */
-		at803x_debug_reg_write(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL, 0x02ea);
-		/* Turn on Gigabit clock */
-		at803x_debug_reg_write(phydev, AT803X_DEBUG_REG_GREEN, 0x68a0);
-		break;
-
-	case 2:
-		phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0x0);
-		fallthrough;
-	case 4:
-		phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_AZ_DEBUG, 0x803f);
-		at803x_debug_reg_write(phydev, AT803X_DEBUG_REG_GREEN, 0x6860);
-		at803x_debug_reg_write(phydev, AT803X_DEBUG_SYSTEM_CTRL_MODE, 0x2c46);
-		at803x_debug_reg_write(phydev, AT803X_DEBUG_REG_3C, 0x6000);
-		break;
-	}
-
-	/* Following original QCA sourcecode set port to prefer master */
-	phy_set_bits(phydev, MII_CTRL1000, CTL1000_PREFER_MASTER);
-
-	return 0;
-}
-
-static int qca8327_config_init(struct phy_device *phydev)
-{
-	/* QCA8327 require DAC amplitude adjustment for 100m set to +6%.
-	 * Disable on init and enable only with 100m speed following
-	 * qca original source code.
-	 */
-	at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
-			      QCA8327_DEBUG_MANU_CTRL_EN, 0);
-
-	return qca83xx_config_init(phydev);
-}
-
-static void qca83xx_link_change_notify(struct phy_device *phydev)
-{
-	/* Set DAC Amplitude adjustment to +6% for 100m on link running */
-	if (phydev->state == PHY_RUNNING) {
-		if (phydev->speed == SPEED_100)
-			at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
-					      QCA8327_DEBUG_MANU_CTRL_EN,
-					      QCA8327_DEBUG_MANU_CTRL_EN);
-	} else {
-		/* Reset DAC Amplitude adjustment */
-		at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
-				      QCA8327_DEBUG_MANU_CTRL_EN, 0);
-	}
-}
-
-static int qca83xx_resume(struct phy_device *phydev)
-{
-	int ret, val;
-
-	/* Skip reset if not suspended */
-	if (!phydev->suspended)
-		return 0;
-
-	/* Reinit the port, reset values set by suspend */
-	qca83xx_config_init(phydev);
-
-	/* Reset the port on port resume */
-	phy_set_bits(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE);
-
-	/* On resume from suspend the switch execute a reset and
-	 * restart auto-negotiation. Wait for reset to complete.
-	 */
-	ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
-				    50000, 600000, true);
-	if (ret)
-		return ret;
-
-	msleep(1);
-
-	return 0;
-}
-
-static int qca83xx_suspend(struct phy_device *phydev)
-{
-	at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_GREEN,
-			      AT803X_DEBUG_GATE_CLK_IN1000, 0);
-
-	at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
-			      AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE |
-			      AT803X_DEBUG_HIB_CTRL_SEL_RST_80U, 0);
-
-	return 0;
-}
-
-static int qca8337_suspend(struct phy_device *phydev)
-{
-	/* Only QCA8337 support actual suspend. */
-	genphy_suspend(phydev);
-
-	return qca83xx_suspend(phydev);
-}
-
-static int qca8327_suspend(struct phy_device *phydev)
-{
-	u16 mask = 0;
-
-	/* QCA8327 cause port unreliability when phy suspend
-	 * is set.
-	 */
-	mask |= ~(BMCR_SPEED1000 | BMCR_FULLDPLX);
-	phy_modify(phydev, MII_BMCR, mask, 0);
-
-	return qca83xx_suspend(phydev);
-}
-
 static int qca808x_config_aneg(struct phy_device *phydev)
 {
 	int phy_ctrl = 0;
@@ -2345,53 +2075,6 @@ static struct phy_driver at803x_driver[] = {
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
-}, {
-	/* QCA8337 */
-	.phy_id			= QCA8337_PHY_ID,
-	.phy_id_mask		= QCA8K_PHY_ID_MASK,
-	.name			= "Qualcomm Atheros 8337 internal PHY",
-	/* PHY_GBIT_FEATURES */
-	.probe			= qca83xx_probe,
-	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca83xx_config_init,
-	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= qca83xx_get_sset_count,
-	.get_strings		= qca83xx_get_strings,
-	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca8337_suspend,
-	.resume			= qca83xx_resume,
-}, {
-	/* QCA8327-A from switch QCA8327-AL1A */
-	.phy_id			= QCA8327_A_PHY_ID,
-	.phy_id_mask		= QCA8K_PHY_ID_MASK,
-	.name			= "Qualcomm Atheros 8327-A internal PHY",
-	/* PHY_GBIT_FEATURES */
-	.link_change_notify	= qca83xx_link_change_notify,
-	.probe			= qca83xx_probe,
-	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca8327_config_init,
-	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= qca83xx_get_sset_count,
-	.get_strings		= qca83xx_get_strings,
-	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca8327_suspend,
-	.resume			= qca83xx_resume,
-}, {
-	/* QCA8327-B from switch QCA8327-BL1A */
-	.phy_id			= QCA8327_B_PHY_ID,
-	.phy_id_mask		= QCA8K_PHY_ID_MASK,
-	.name			= "Qualcomm Atheros 8327-B internal PHY",
-	/* PHY_GBIT_FEATURES */
-	.link_change_notify	= qca83xx_link_change_notify,
-	.probe			= qca83xx_probe,
-	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca8327_config_init,
-	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= qca83xx_get_sset_count,
-	.get_strings		= qca83xx_get_strings,
-	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca8327_suspend,
-	.resume			= qca83xx_resume,
 }, {
 	/* Qualcomm QCA8081 */
 	PHY_ID_MATCH_EXACT(QCA8081_PHY_ID),
@@ -2423,9 +2106,6 @@ static struct mdio_device_id __maybe_unused atheros_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(ATH8032_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(ATH8035_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(ATH9331_PHY_ID) },
-	{ PHY_ID_MATCH_EXACT(QCA8337_PHY_ID) },
-	{ PHY_ID_MATCH_EXACT(QCA8327_A_PHY_ID) },
-	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA9561_PHY_ID) },
 	{ PHY_ID_MATCH_EXACT(QCA8081_PHY_ID) },
 	{ }
diff --git a/drivers/net/phy/qcom/common.c b/drivers/net/phy/qcom/common.c
new file mode 100644
index 000000000000..1d9b80fea2e9
--- /dev/null
+++ b/drivers/net/phy/qcom/common.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/phy.h>
+#include <linux/module.h>
+
+#include <linux/regulator/driver.h>
+#include <linux/of.h>
+#include <linux/phylink.h>
+#include <linux/sfp.h>
+
+#include "qcom.h"
+
+int at803x_debug_reg_read(struct phy_device *phydev, u16 reg)
+{
+	int ret;
+
+	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	return phy_read(phydev, AT803X_DEBUG_DATA);
+}
+
+int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
+			  u16 clear, u16 set)
+{
+	u16 val;
+	int ret;
+
+	ret = at803x_debug_reg_read(phydev, reg);
+	if (ret < 0)
+		return ret;
+
+	val = ret & 0xffff;
+	val &= ~clear;
+	val |= set;
+
+	return phy_write(phydev, AT803X_DEBUG_DATA, val);
+}
+
+int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data)
+{
+	int ret;
+
+	ret = phy_write(phydev, AT803X_DEBUG_ADDR, reg);
+	if (ret < 0)
+		return ret;
+
+	return phy_write(phydev, AT803X_DEBUG_DATA, data);
+}
diff --git a/drivers/net/phy/qcom/qca83xx.c b/drivers/net/phy/qcom/qca83xx.c
new file mode 100644
index 000000000000..e0f849d405e6
--- /dev/null
+++ b/drivers/net/phy/qcom/qca83xx.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/phy.h>
+#include <linux/module.h>
+
+#include "qcom.h"
+
+#define AT803X_DEBUG_REG_3C			0x3C
+
+#define AT803X_DEBUG_REG_GREEN			0x3D
+#define   AT803X_DEBUG_GATE_CLK_IN1000		BIT(6)
+
+#define MDIO_AZ_DEBUG				0x800D
+
+#define QCA8327_A_PHY_ID			0x004dd033
+#define QCA8327_B_PHY_ID			0x004dd034
+#define QCA8337_PHY_ID				0x004dd036
+#define QCA8K_PHY_ID_MASK			0xffffffff
+
+#define QCA8K_DEVFLAGS_REVISION_MASK		GENMASK(2, 0)
+
+static struct at803x_hw_stat qca83xx_hw_stats[] = {
+	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
+	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
+	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
+};
+
+struct qca83xx_priv {
+	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
+};
+
+MODULE_DESCRIPTION("Qualcomm Atheros QCA83XX PHY driver");
+MODULE_AUTHOR("Matus Ujhelyi");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+
+static int qca83xx_get_sset_count(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(qca83xx_hw_stats);
+}
+
+static void qca83xx_get_strings(struct phy_device *phydev, u8 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++) {
+		strscpy(data + i * ETH_GSTRING_LEN,
+			qca83xx_hw_stats[i].string, ETH_GSTRING_LEN);
+	}
+}
+
+static u64 qca83xx_get_stat(struct phy_device *phydev, int i)
+{
+	struct at803x_hw_stat stat = qca83xx_hw_stats[i];
+	struct qca83xx_priv *priv = phydev->priv;
+	int val;
+	u64 ret;
+
+	if (stat.access_type == MMD)
+		val = phy_read_mmd(phydev, MDIO_MMD_PCS, stat.reg);
+	else
+		val = phy_read(phydev, stat.reg);
+
+	if (val < 0) {
+		ret = U64_MAX;
+	} else {
+		val = val & stat.mask;
+		priv->stats[i] += val;
+		ret = priv->stats[i];
+	}
+
+	return ret;
+}
+
+static void qca83xx_get_stats(struct phy_device *phydev,
+			      struct ethtool_stats *stats, u64 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++)
+		data[i] = qca83xx_get_stat(phydev, i);
+}
+
+static int qca83xx_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct qca83xx_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int qca83xx_config_init(struct phy_device *phydev)
+{
+	u8 switch_revision;
+
+	switch_revision = phydev->dev_flags & QCA8K_DEVFLAGS_REVISION_MASK;
+
+	switch (switch_revision) {
+	case 1:
+		/* For 100M waveform */
+		at803x_debug_reg_write(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL, 0x02ea);
+		/* Turn on Gigabit clock */
+		at803x_debug_reg_write(phydev, AT803X_DEBUG_REG_GREEN, 0x68a0);
+		break;
+
+	case 2:
+		phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0x0);
+		fallthrough;
+	case 4:
+		phy_write_mmd(phydev, MDIO_MMD_PCS, MDIO_AZ_DEBUG, 0x803f);
+		at803x_debug_reg_write(phydev, AT803X_DEBUG_REG_GREEN, 0x6860);
+		at803x_debug_reg_write(phydev, AT803X_DEBUG_SYSTEM_CTRL_MODE, 0x2c46);
+		at803x_debug_reg_write(phydev, AT803X_DEBUG_REG_3C, 0x6000);
+		break;
+	}
+
+	/* Following original QCA sourcecode set port to prefer master */
+	phy_set_bits(phydev, MII_CTRL1000, CTL1000_PREFER_MASTER);
+
+	return 0;
+}
+
+static int qca8327_config_init(struct phy_device *phydev)
+{
+	/* QCA8327 require DAC amplitude adjustment for 100m set to +6%.
+	 * Disable on init and enable only with 100m speed following
+	 * qca original source code.
+	 */
+	at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
+			      QCA8327_DEBUG_MANU_CTRL_EN, 0);
+
+	return qca83xx_config_init(phydev);
+}
+
+static void qca83xx_link_change_notify(struct phy_device *phydev)
+{
+	/* Set DAC Amplitude adjustment to +6% for 100m on link running */
+	if (phydev->state == PHY_RUNNING) {
+		if (phydev->speed == SPEED_100)
+			at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
+					      QCA8327_DEBUG_MANU_CTRL_EN,
+					      QCA8327_DEBUG_MANU_CTRL_EN);
+	} else {
+		/* Reset DAC Amplitude adjustment */
+		at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
+				      QCA8327_DEBUG_MANU_CTRL_EN, 0);
+	}
+}
+
+static int qca83xx_resume(struct phy_device *phydev)
+{
+	int ret, val;
+
+	/* Skip reset if not suspended */
+	if (!phydev->suspended)
+		return 0;
+
+	/* Reinit the port, reset values set by suspend */
+	qca83xx_config_init(phydev);
+
+	/* Reset the port on port resume */
+	phy_set_bits(phydev, MII_BMCR, BMCR_RESET | BMCR_ANENABLE);
+
+	/* On resume from suspend the switch execute a reset and
+	 * restart auto-negotiation. Wait for reset to complete.
+	 */
+	ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				    50000, 600000, true);
+	if (ret)
+		return ret;
+
+	msleep(1);
+
+	return 0;
+}
+
+static int qca83xx_suspend(struct phy_device *phydev)
+{
+	at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_GREEN,
+			      AT803X_DEBUG_GATE_CLK_IN1000, 0);
+
+	at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_HIB_CTRL,
+			      AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE |
+			      AT803X_DEBUG_HIB_CTRL_SEL_RST_80U, 0);
+
+	return 0;
+}
+
+static int qca8337_suspend(struct phy_device *phydev)
+{
+	/* Only QCA8337 support actual suspend. */
+	genphy_suspend(phydev);
+
+	return qca83xx_suspend(phydev);
+}
+
+static int qca8327_suspend(struct phy_device *phydev)
+{
+	u16 mask = 0;
+
+	/* QCA8327 cause port unreliability when phy suspend
+	 * is set.
+	 */
+	mask |= ~(BMCR_SPEED1000 | BMCR_FULLDPLX);
+	phy_modify(phydev, MII_BMCR, mask, 0);
+
+	return qca83xx_suspend(phydev);
+}
+
+static struct phy_driver qca833x_driver[] = {
+{
+	/* QCA8337 */
+	.phy_id			= QCA8337_PHY_ID,
+	.phy_id_mask		= QCA8K_PHY_ID_MASK,
+	.name			= "Qualcomm Atheros 8337 internal PHY",
+	/* PHY_GBIT_FEATURES */
+	.probe			= qca83xx_probe,
+	.flags			= PHY_IS_INTERNAL,
+	.config_init		= qca83xx_config_init,
+	.soft_reset		= genphy_soft_reset,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
+	.suspend		= qca8337_suspend,
+	.resume			= qca83xx_resume,
+}, {
+	/* QCA8327-A from switch QCA8327-AL1A */
+	.phy_id			= QCA8327_A_PHY_ID,
+	.phy_id_mask		= QCA8K_PHY_ID_MASK,
+	.name			= "Qualcomm Atheros 8327-A internal PHY",
+	/* PHY_GBIT_FEATURES */
+	.link_change_notify	= qca83xx_link_change_notify,
+	.probe			= qca83xx_probe,
+	.flags			= PHY_IS_INTERNAL,
+	.config_init		= qca8327_config_init,
+	.soft_reset		= genphy_soft_reset,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
+	.suspend		= qca8327_suspend,
+	.resume			= qca83xx_resume,
+}, {
+	/* QCA8327-B from switch QCA8327-BL1A */
+	.phy_id			= QCA8327_B_PHY_ID,
+	.phy_id_mask		= QCA8K_PHY_ID_MASK,
+	.name			= "Qualcomm Atheros 8327-B internal PHY",
+	/* PHY_GBIT_FEATURES */
+	.link_change_notify	= qca83xx_link_change_notify,
+	.probe			= qca83xx_probe,
+	.flags			= PHY_IS_INTERNAL,
+	.config_init		= qca8327_config_init,
+	.soft_reset		= genphy_soft_reset,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
+	.suspend		= qca8327_suspend,
+	.resume			= qca83xx_resume,
+}, };
+
+module_phy_driver(qca833x_driver);
+
+static struct mdio_device_id __maybe_unused qca83xx_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(QCA8337_PHY_ID) },
+	{ PHY_ID_MATCH_EXACT(QCA8327_A_PHY_ID) },
+	{ PHY_ID_MATCH_EXACT(QCA8327_B_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, qca83xx_tbl);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
new file mode 100644
index 000000000000..17cc6705dd3e
--- /dev/null
+++ b/drivers/net/phy/qcom/qcom.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define AT803X_DEBUG_ANALOG_TEST_CTRL		0x00
+#define QCA8327_DEBUG_MANU_CTRL_EN		BIT(2)
+#define QCA8337_DEBUG_MANU_CTRL_EN		GENMASK(3, 2)
+#define AT803X_DEBUG_RX_CLK_DLY_EN		BIT(15)
+
+#define AT803X_DEBUG_SYSTEM_CTRL_MODE		0x05
+#define AT803X_DEBUG_TX_CLK_DLY_EN		BIT(8)
+
+#define AT803X_DEBUG_REG_HIB_CTRL		0x0b
+#define   AT803X_DEBUG_HIB_CTRL_SEL_RST_80U	BIT(10)
+#define   AT803X_DEBUG_HIB_CTRL_EN_ANY_CHANGE	BIT(13)
+#define   AT803X_DEBUG_HIB_CTRL_PS_HIB_EN	BIT(15)
+
+#define AT803X_DEBUG_ADDR			0x1D
+#define AT803X_DEBUG_DATA			0x1E
+
+#define AT803X_DEBUG_REG_1F			0x1F
+#define AT803X_DEBUG_PLL_ON			BIT(2)
+#define AT803X_DEBUG_RGMII_1V8			BIT(3)
+
+enum stat_access_type {
+	PHY,
+	MMD
+};
+
+struct at803x_hw_stat {
+	const char *string;
+	u8 reg;
+	u32 mask;
+	enum stat_access_type access_type;
+};
+
+int at803x_debug_reg_read(struct phy_device *phydev, u16 reg);
+int at803x_debug_reg_mask(struct phy_device *phydev, u16 reg,
+			  u16 clear, u16 set);
+int at803x_debug_reg_write(struct phy_device *phydev, u16 reg, u16 data);
-- 
2.40.1

