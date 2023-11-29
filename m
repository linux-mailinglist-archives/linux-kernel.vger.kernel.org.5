Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F3F7FCCAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjK2CMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjK2CMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811519BB;
        Tue, 28 Nov 2023 18:12:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so21325915e9.3;
        Tue, 28 Nov 2023 18:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223955; x=1701828755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UliKSihddON7SLOloG6iMDlJs3EBEfW4nDtrv7QoS8c=;
        b=BJx5dqAr9cxN1z+dIP8WyuwB9g2XGzL+HhFswaSgWDrlY01hZ7DYNw/cyqKCuzhg5V
         kxNXXXaRwPuLzIG6ueUG5dgpkZh4wgtk1mr+UeXif25B58XJmDYmlRgXemCgpHnPn2EB
         gaxq/D2EM4b9YFrHj1ztzY85AaXhN8mkzC32SQe84GZADhrIJAX/5mUmPGOjNUhqUV6t
         eUjqIksOTJp9f6MOQAJQzwFz9OBEMsnDs6MOTxgyJROayXdbI2MWqBqSgArGF2p+Ttlw
         33eORsQ6dpXMDBX9Z3Aqgxx7XmFbwb0L7kPcuMdJMC7zzLEN/b7SD+gKdqbm2jAnz1ri
         ZOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223955; x=1701828755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UliKSihddON7SLOloG6iMDlJs3EBEfW4nDtrv7QoS8c=;
        b=NllWtietSql7O5qLHln+IBH8XYYkwYy9ooWVwdPVpGzKJqVKputpDKGqX7wM9u+lPk
         CA0/2IHRnjftniPyIPb6KkmGENg12BkvGx4KBun6njph9kfQMSxXmx4wsmjpwUcSPpIX
         RnsuICZKMgEnQJqk15qgCbPchJSLiWvMyQL5EQzUu3nqI3nW6y+OWck338sSgJyQepxg
         EUaFy/vMTdWZ+eUSrKOZohwFneEefSI2/+Df0aINp8h47nOq91X4PZDnaRLkxh+YMx+L
         5N45QOq/WK/U2Eztbok8+muQMtFTGga2ZJ/LHCjgikI84wTYpbA6Xahq7IiVi9nAMnEj
         rPhg==
X-Gm-Message-State: AOJu0Yzca22HbZAhehf5Y/HN/t0sH91eSMD6qnlVX2OKjumS2cEanXUy
        1cCH48HCGQmtzJj3iPn6A54=
X-Google-Smtp-Source: AGHT+IFD+CQMRM53+grpjZBbCVWQOUwlV1l9Z/OA8L3Ad8stu0Fq01dJnJgjTyI+/143SA1d3sRcEg==
X-Received: by 2002:a05:600c:a49:b0:401:daf2:2735 with SMTP id c9-20020a05600c0a4900b00401daf22735mr12499182wmq.31.1701223954454;
        Tue, 28 Nov 2023 18:12:34 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:34 -0800 (PST)
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
Subject: [net-next PATCH 06/14] net: phy: at803x: move at8031 specific data out of generic at803x_priv
Date:   Wed, 29 Nov 2023 03:12:11 +0100
Message-Id: <20231129021219.20914-7-ansuelsmth@gmail.com>
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

Rework everything related to specific at8031 function to specific
function and allocate the 2 bool, is_1000basex and is_fiber and the
regulator structs to a dedicated qca8031_data struct.

This is needed to keep at803x functions more generic and detach them
from specific check of at8031/33 PHY.

Out of all the reworked functions, only config_aneg required some code
duplication with how the mdix config is handled.

This also reduces the generic at803x_priv struct by removing variables
only used by at8031 PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 637 ++++++++++++++++++++++-----------------
 1 file changed, 362 insertions(+), 275 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 9a590124d1fe..b83422c6db74 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -305,16 +305,22 @@ struct qca83xx_priv {
 	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
 };
 
+struct at8031_data {
+	bool is_fiber;
+	bool is_1000basex;
+	struct regulator_dev *vddio_rdev;
+	struct regulator_dev *vddh_rdev;
+};
+
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
 	u16 clk_25m_mask;
 	u8 smarteee_lpi_tw_1g;
 	u8 smarteee_lpi_tw_100m;
-	bool is_fiber;
-	bool is_1000basex;
-	struct regulator_dev *vddio_rdev;
-	struct regulator_dev *vddh_rdev;
+
+	/* Specific data for at8031 PHYs */
+	void *data;
 };
 
 struct at803x_context {
@@ -469,27 +475,11 @@ static int at803x_set_wol(struct phy_device *phydev,
 			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
 				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
 
-		/* Enable WOL function for 1588 */
-		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-					     AT803X_PHY_MMD3_WOL_CTRL,
-					     0, AT803X_WOL_EN);
-			if (ret)
-				return ret;
-		}
 		/* Enable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
 		if (ret)
 			return ret;
 	} else {
-		/* Disable WoL function for 1588 */
-		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-					     AT803X_PHY_MMD3_WOL_CTRL,
-					     AT803X_WOL_EN, 0);
-			if (ret)
-				return ret;
-		}
 		/* Disable WOL interrupt */
 		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
 		if (ret)
@@ -602,139 +592,6 @@ static int at803x_resume(struct phy_device *phydev)
 	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0);
 }
 
-static int at803x_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
-					    unsigned int selector)
-{
-	struct phy_device *phydev = rdev_get_drvdata(rdev);
-
-	if (selector)
-		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
-					     0, AT803X_DEBUG_RGMII_1V8);
-	else
-		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
-					     AT803X_DEBUG_RGMII_1V8, 0);
-}
-
-static int at803x_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
-{
-	struct phy_device *phydev = rdev_get_drvdata(rdev);
-	int val;
-
-	val = at803x_debug_reg_read(phydev, AT803X_DEBUG_REG_1F);
-	if (val < 0)
-		return val;
-
-	return (val & AT803X_DEBUG_RGMII_1V8) ? 1 : 0;
-}
-
-static const struct regulator_ops vddio_regulator_ops = {
-	.list_voltage = regulator_list_voltage_table,
-	.set_voltage_sel = at803x_rgmii_reg_set_voltage_sel,
-	.get_voltage_sel = at803x_rgmii_reg_get_voltage_sel,
-};
-
-static const unsigned int vddio_voltage_table[] = {
-	1500000,
-	1800000,
-};
-
-static const struct regulator_desc vddio_desc = {
-	.name = "vddio",
-	.of_match = of_match_ptr("vddio-regulator"),
-	.n_voltages = ARRAY_SIZE(vddio_voltage_table),
-	.volt_table = vddio_voltage_table,
-	.ops = &vddio_regulator_ops,
-	.type = REGULATOR_VOLTAGE,
-	.owner = THIS_MODULE,
-};
-
-static const struct regulator_ops vddh_regulator_ops = {
-};
-
-static const struct regulator_desc vddh_desc = {
-	.name = "vddh",
-	.of_match = of_match_ptr("vddh-regulator"),
-	.n_voltages = 1,
-	.fixed_uV = 2500000,
-	.ops = &vddh_regulator_ops,
-	.type = REGULATOR_VOLTAGE,
-	.owner = THIS_MODULE,
-};
-
-static int at8031_register_regulators(struct phy_device *phydev)
-{
-	struct at803x_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	struct regulator_config config = { };
-
-	config.dev = dev;
-	config.driver_data = phydev;
-
-	priv->vddio_rdev = devm_regulator_register(dev, &vddio_desc, &config);
-	if (IS_ERR(priv->vddio_rdev)) {
-		phydev_err(phydev, "failed to register VDDIO regulator\n");
-		return PTR_ERR(priv->vddio_rdev);
-	}
-
-	priv->vddh_rdev = devm_regulator_register(dev, &vddh_desc, &config);
-	if (IS_ERR(priv->vddh_rdev)) {
-		phydev_err(phydev, "failed to register VDDH regulator\n");
-		return PTR_ERR(priv->vddh_rdev);
-	}
-
-	return 0;
-}
-
-static int at803x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
-{
-	struct phy_device *phydev = upstream;
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
-	DECLARE_PHY_INTERFACE_MASK(interfaces);
-	phy_interface_t iface;
-
-	linkmode_zero(phy_support);
-	phylink_set(phy_support, 1000baseX_Full);
-	phylink_set(phy_support, 1000baseT_Full);
-	phylink_set(phy_support, Autoneg);
-	phylink_set(phy_support, Pause);
-	phylink_set(phy_support, Asym_Pause);
-
-	linkmode_zero(sfp_support);
-	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
-	/* Some modules support 10G modes as well as others we support.
-	 * Mask out non-supported modes so the correct interface is picked.
-	 */
-	linkmode_and(sfp_support, phy_support, sfp_support);
-
-	if (linkmode_empty(sfp_support)) {
-		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
-		return -EINVAL;
-	}
-
-	iface = sfp_select_interface(phydev->sfp_bus, sfp_support);
-
-	/* Only 1000Base-X is supported by AR8031/8033 as the downstream SerDes
-	 * interface for use with SFP modules.
-	 * However, some copper modules detected as having a preferred SGMII
-	 * interface do default to and function in 1000Base-X mode, so just
-	 * print a warning and allow such modules, as they may have some chance
-	 * of working.
-	 */
-	if (iface == PHY_INTERFACE_MODE_SGMII)
-		dev_warn(&phydev->mdio.dev, "module may not function if 1000Base-X not supported\n");
-	else if (iface != PHY_INTERFACE_MODE_1000BASEX)
-		return -EINVAL;
-
-	return 0;
-}
-
-static const struct sfp_upstream_ops at803x_sfp_ops = {
-	.attach = phy_sfp_attach,
-	.detach = phy_sfp_detach,
-	.module_insert = at803x_sfp_insert,
-};
-
 static int at803x_parse_dt(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
@@ -828,30 +685,6 @@ static int at803x_parse_dt(struct phy_device *phydev)
 		}
 	}
 
-	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
-	 * options.
-	 */
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		if (of_property_read_bool(node, "qca,keep-pll-enabled"))
-			priv->flags |= AT803X_KEEP_PLL_ENABLED;
-
-		ret = at8031_register_regulators(phydev);
-		if (ret < 0)
-			return ret;
-
-		ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
-							 "vddio");
-		if (ret) {
-			phydev_err(phydev, "failed to get VDDIO regulator\n");
-			return ret;
-		}
-
-		/* Only AR8031/8033 support 1000Base-X for SFP modules */
-		ret = phy_sfp_probe(phydev, &at803x_sfp_ops);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -871,56 +704,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
-		int mode_cfg;
-
-		if (ccr < 0)
-			return ccr;
-		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
-
-		switch (mode_cfg) {
-		case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
-		case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
-			priv->is_1000basex = true;
-			fallthrough;
-		case AT803X_MODE_CFG_FX100_RGMII_50OHM:
-		case AT803X_MODE_CFG_FX100_RGMII_75OHM:
-			priv->is_fiber = true;
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int at803x_get_features(struct phy_device *phydev)
-{
-	struct at803x_priv *priv = phydev->priv;
-	int err;
-
-	err = genphy_read_abilities(phydev);
-	if (err)
-		return err;
-
-	if (phydev->drv->phy_id != ATH8031_PHY_ID)
-		return 0;
-
-	/* AR8031/AR8033 have different status registers
-	 * for copper and fiber operation. However, the
-	 * extended status register is the same for both
-	 * operation modes.
-	 *
-	 * As a result of that, ESTATUS_1000_XFULL is set
-	 * to 1 even when operating in copper TP mode.
-	 *
-	 * Remove this mode from the supported link modes
-	 * when not operating in 1000BaseX mode.
-	 */
-	if (!priv->is_1000basex)
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
-				   phydev->supported);
-
 	return 0;
 }
 
@@ -998,36 +781,8 @@ static int at803x_hibernation_mode_config(struct phy_device *phydev)
 
 static int at803x_config_init(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		/* Disable WoL in 1588 register which is enabled
-		 * by default
-		 */
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     AT803X_PHY_MMD3_WOL_CTRL,
-				     AT803X_WOL_EN, 0);
-		if (ret)
-			return ret;
-
-		/* Some bootloaders leave the fiber page selected.
-		 * Switch to the appropriate page (fiber or copper), as otherwise we
-		 * read the PHY capabilities from the wrong page.
-		 */
-		phy_lock_mdio_bus(phydev);
-		ret = at803x_write_page(phydev,
-					priv->is_fiber ? AT803X_PAGE_FIBER :
-							 AT803X_PAGE_COPPER);
-		phy_unlock_mdio_bus(phydev);
-		if (ret)
-			return ret;
-
-		ret = at8031_pll_config(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
 	/* The RX and TX delay default is:
 	 *   after HW reset: RX delay enabled and TX delay disabled
 	 *   after SW reset: RX delay enabled, while TX delay retains the
@@ -1081,7 +836,6 @@ static int at803x_ack_interrupt(struct phy_device *phydev)
 
 static int at803x_config_intr(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int err;
 	int value;
 
@@ -1098,10 +852,6 @@ static int at803x_config_intr(struct phy_device *phydev)
 		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
 		value |= AT803X_INTR_ENABLE_LINK_FAIL;
 		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
-		if (priv->is_fiber) {
-			value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
-			value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
-		}
 
 		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
 	} else {
@@ -1234,12 +984,8 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 
 static int at803x_read_status(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int err, old_link = phydev->link;
 
-	if (priv->is_1000basex)
-		return genphy_c37_read_status(phydev);
-
 	/* Update the link, but return if there was an error */
 	err = genphy_update_link(phydev);
 	if (err)
@@ -1293,7 +1039,6 @@ static int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
 
 static int at803x_config_aneg(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int ret;
 
 	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
@@ -1310,9 +1055,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (priv->is_1000basex)
-		return genphy_c37_config_aneg(phydev);
-
 	/* Do not restart auto-negotiation by setting ret to 0 defautly,
 	 * when calling __genphy_config_aneg later.
 	 */
@@ -1594,6 +1336,351 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int at8031_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
+					    unsigned int selector)
+{
+	struct phy_device *phydev = rdev_get_drvdata(rdev);
+
+	if (selector)
+		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
+					     0, AT803X_DEBUG_RGMII_1V8);
+	else
+		return at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_1F,
+					     AT803X_DEBUG_RGMII_1V8, 0);
+}
+
+static int at8031_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct phy_device *phydev = rdev_get_drvdata(rdev);
+	int val;
+
+	val = at803x_debug_reg_read(phydev, AT803X_DEBUG_REG_1F);
+	if (val < 0)
+		return val;
+
+	return (val & AT803X_DEBUG_RGMII_1V8) ? 1 : 0;
+}
+
+static const struct regulator_ops vddio_regulator_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = at8031_rgmii_reg_set_voltage_sel,
+	.get_voltage_sel = at8031_rgmii_reg_get_voltage_sel,
+};
+
+static const unsigned int vddio_voltage_table[] = {
+	1500000,
+	1800000,
+};
+
+static const struct regulator_desc vddio_desc = {
+	.name = "vddio",
+	.of_match = of_match_ptr("vddio-regulator"),
+	.n_voltages = ARRAY_SIZE(vddio_voltage_table),
+	.volt_table = vddio_voltage_table,
+	.ops = &vddio_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_ops vddh_regulator_ops = {
+};
+
+static const struct regulator_desc vddh_desc = {
+	.name = "vddh",
+	.of_match = of_match_ptr("vddh-regulator"),
+	.n_voltages = 1,
+	.fixed_uV = 2500000,
+	.ops = &vddh_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int at8031_register_regulators(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	struct at8031_data *data = priv->data;
+	struct regulator_config config = { };
+
+	config.dev = dev;
+	config.driver_data = phydev;
+
+	data->vddio_rdev = devm_regulator_register(dev, &vddio_desc, &config);
+	if (IS_ERR(data->vddio_rdev)) {
+		phydev_err(phydev, "failed to register VDDIO regulator\n");
+		return PTR_ERR(data->vddio_rdev);
+	}
+
+	data->vddh_rdev = devm_regulator_register(dev, &vddh_desc, &config);
+	if (IS_ERR(data->vddh_rdev)) {
+		phydev_err(phydev, "failed to register VDDH regulator\n");
+		return PTR_ERR(data->vddh_rdev);
+	}
+
+	return 0;
+}
+
+static int at8031_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+{
+	struct phy_device *phydev = upstream;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
+	DECLARE_PHY_INTERFACE_MASK(interfaces);
+	phy_interface_t iface;
+
+	linkmode_zero(phy_support);
+	phylink_set(phy_support, 1000baseX_Full);
+	phylink_set(phy_support, 1000baseT_Full);
+	phylink_set(phy_support, Autoneg);
+	phylink_set(phy_support, Pause);
+	phylink_set(phy_support, Asym_Pause);
+
+	linkmode_zero(sfp_support);
+	sfp_parse_support(phydev->sfp_bus, id, sfp_support, interfaces);
+	/* Some modules support 10G modes as well as others we support.
+	 * Mask out non-supported modes so the correct interface is picked.
+	 */
+	linkmode_and(sfp_support, phy_support, sfp_support);
+
+	if (linkmode_empty(sfp_support)) {
+		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted\n");
+		return -EINVAL;
+	}
+
+	iface = sfp_select_interface(phydev->sfp_bus, sfp_support);
+
+	/* Only 1000Base-X is supported by AR8031/8033 as the downstream SerDes
+	 * interface for use with SFP modules.
+	 * However, some copper modules detected as having a preferred SGMII
+	 * interface do default to and function in 1000Base-X mode, so just
+	 * print a warning and allow such modules, as they may have some chance
+	 * of working.
+	 */
+	if (iface == PHY_INTERFACE_MODE_SGMII)
+		dev_warn(&phydev->mdio.dev, "module may not function if 1000Base-X not supported\n");
+	else if (iface != PHY_INTERFACE_MODE_1000BASEX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct sfp_upstream_ops at8031_sfp_ops = {
+	.attach = phy_sfp_attach,
+	.detach = phy_sfp_detach,
+	.module_insert = at8031_sfp_insert,
+};
+
+static int at8031_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct at803x_priv *priv = phydev->priv;
+	int ret;
+
+	if (of_property_read_bool(node, "qca,keep-pll-enabled"))
+		priv->flags |= AT803X_KEEP_PLL_ENABLED;
+
+	ret = at8031_register_regulators(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
+						 "vddio");
+	if (ret) {
+		phydev_err(phydev, "failed to get VDDIO regulator\n");
+		return ret;
+	}
+
+	/* Only AR8031/8033 support 1000Base-X for SFP modules */
+	return phy_sfp_probe(phydev, &at8031_sfp_ops);
+}
+
+static int at8031_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct at8031_data *data;
+	struct at803x_priv *priv;
+	int ccr, mode_cfg;
+	int ret;
+
+	ret = at803x_probe(phydev);
+	if (ret)
+		return ret;
+
+	priv = phydev->priv;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	priv->data = data;
+
+	ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
+	if (ccr < 0)
+		return ccr;
+
+	mode_cfg = FIELD_GET(AT803X_MODE_CFG_MASK, ccr);
+
+	switch (mode_cfg) {
+	case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
+	case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
+		data->is_1000basex = true;
+		fallthrough;
+	case AT803X_MODE_CFG_FX100_RGMII_50OHM:
+	case AT803X_MODE_CFG_FX100_RGMII_75OHM:
+		data->is_fiber = true;
+		break;
+	}
+
+	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
+	 * options.
+	 */
+	return at8031_parse_dt(phydev);
+}
+
+static int at8031_config_init(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct at8031_data *data = priv->data;
+	int ret;
+
+	/* Disable WoL in 1588 register which is enabled
+	 * by default
+	 */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+			     AT803X_PHY_MMD3_WOL_CTRL,
+			     AT803X_WOL_EN, 0);
+	if (ret)
+		return ret;
+
+	/* Some bootloaders leave the fiber page selected.
+	 * Switch to the appropriate page (fiber or copper), as otherwise we
+	 * read the PHY capabilities from the wrong page.
+	 */
+	phy_lock_mdio_bus(phydev);
+	ret = at803x_write_page(phydev,
+				data->is_fiber ? AT803X_PAGE_FIBER :
+				AT803X_PAGE_COPPER);
+	phy_unlock_mdio_bus(phydev);
+	if (ret)
+		return ret;
+
+	ret = at8031_pll_config(phydev);
+	if (ret < 0)
+		return ret;
+
+	return at803x_config_init(phydev);
+}
+
+static int at8031_config_intr(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct at8031_data *data = priv->data;
+	int err, value = 0;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED &&
+	    data->is_fiber) {
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
+		value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
+
+		err = phy_set_bits(phydev, AT803X_INTR_ENABLE, value);
+		if (err)
+			return err;
+	}
+
+	return at803x_config_intr(phydev);
+}
+
+static int at8031_get_features(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct at8031_data *data = priv->data;
+	int err;
+
+	err = genphy_read_abilities(phydev);
+	if (err)
+		return err;
+
+	/* AR8031/AR8033 have different status registers
+	 * for copper and fiber operation. However, the
+	 * extended status register is the same for both
+	 * operation modes.
+	 *
+	 * As a result of that, ESTATUS_1000_XFULL is set
+	 * to 1 even when operating in copper TP mode.
+	 *
+	 * Remove this mode from the supported link modes
+	 * when not operating in 1000BaseX mode.
+	 */
+	if (!data->is_1000basex)
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				   phydev->supported);
+
+	return 0;
+}
+
+static int at8031_read_status(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct at8031_data *data = priv->data;
+
+	if (data->is_1000basex)
+		return genphy_c37_read_status(phydev);
+
+	return at803x_read_status(phydev);
+}
+
+static int at8031_config_aneg(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	struct at8031_data *data = priv->data;
+	int ret;
+
+	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+
+	/* Changes of the midx bits are disruptive to the normal operation;
+	 * therefore any changes to these registers must be followed by a
+	 * software reset to take effect.
+	 */
+	if (ret == 1) {
+		ret = genphy_soft_reset(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (data->is_1000basex)
+		return genphy_c37_config_aneg(phydev);
+
+	return __genphy_config_aneg(phydev, ret);
+}
+
+static int at8031_set_wol(struct phy_device *phydev,
+			  struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		/* Enable WOL function for 1588 */
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+				       AT803X_PHY_MMD3_WOL_CTRL,
+				       AT803X_WOL_EN);
+	else
+		/* Disable WoL function for 1588 */
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+					 AT803X_PHY_MMD3_WOL_CTRL,
+					 AT803X_WOL_EN);
+	if (ret)
+		return ret;
+
+	return at803x_set_wol(phydev, wol);
+}
+
 static int qca83xx_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -2116,19 +2203,19 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8031_PHY_ID),
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
-	.probe			= at803x_probe,
-	.config_init		= at803x_config_init,
-	.config_aneg		= at803x_config_aneg,
+	.probe			= at8031_probe,
+	.config_init		= at8031_config_init,
+	.config_aneg		= at8031_config_aneg,
 	.soft_reset		= genphy_soft_reset,
-	.set_wol		= at803x_set_wol,
+	.set_wol		= at8031_set_wol,
 	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	.read_page		= at803x_read_page,
 	.write_page		= at803x_write_page,
-	.get_features		= at803x_get_features,
-	.read_status		= at803x_read_status,
-	.config_intr		= at803x_config_intr,
+	.get_features		= at8031_get_features,
+	.read_status		= at8031_read_status,
+	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-- 
2.40.1

