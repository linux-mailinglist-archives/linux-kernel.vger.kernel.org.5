Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF9800015
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377384AbjLAAPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377443AbjLAAPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE431729;
        Thu, 30 Nov 2023 16:15:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso11652535e9.1;
        Thu, 30 Nov 2023 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389699; x=1701994499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlc394zhfhzVq8aAP75het7E8RUg91LzoOZRny54CvY=;
        b=ETpdoLCfgi8S+/R23XPUatPQz+jto6TXmohgozLiX9wwQ+ahb1iZT+D8ZYHqGGUCH4
         z4MmxMhcS9c7RNvAqYCCqAP8NiVOUqLg9LNKTG4d3CVTcU6FZBi6T4QbprkBiDqHaFpj
         k3BvFUm6dwA9m1XBIZVZmiJyq7YzVovy9HWBTGiGA8h2c9Rz3c6C/ZZLCsbYu0TObsuI
         GJLiD64LzDjbGQX6gDmgZUZ2Lf5NYxZIohe7dzS97Q0FdhUyz4tYAntZT3ujFjFS3dI5
         hzgbQWqSpMWzbDwQpVatN+N29A7WpMEzZc72gHDOQmSaonB4QiTEtrzJf1iEblaqmtUu
         uABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389699; x=1701994499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlc394zhfhzVq8aAP75het7E8RUg91LzoOZRny54CvY=;
        b=fw5fl+JwqNv0DbV+u/rengw1NRUu8qCFUIGqsgaxj6GhfH/g/7bIIsDYgnRGDrVa7U
         iWvoYMMpqzOw3kElON4rhg0gPuVExGy/xHs+Ep6CSkS5ALbw5JwfWLyWvpXypT27+ObJ
         AYcd3vs94d+APMTH8hg+fuVuZMeOM3HdNv2Zxa1dVOAwwTMgLd4g6Ua1q87PfpXRA3VQ
         gCDIcZGPuP2tLYCGdmufTDF43oOcPTJMGdLxPCpuxqMOQBR6CZDMEmQui8PiEv2NFW2G
         x50JrkGWp+hj4MGDNSjsYL9NVmeDzdo4zMWUT+7+iKeG/z2V1lyUuonICJWy6eMoTSVp
         k8gw==
X-Gm-Message-State: AOJu0YzBOIGIKzH5C6C3ePVZTyVZmQtcUSSonIS9k+g3qNt/J2EpuqPD
        iGYp2XbOS+b1Lkha/aGgcSeICDPvmDE=
X-Google-Smtp-Source: AGHT+IEKS05Ow6h/Fo0fRLm62WTLx5Ro7rvGRDW5qnD9orrhSRAe5EXcUU3nHFISMcsIrFbAgDQssg==
X-Received: by 2002:a7b:cd92:0:b0:40b:5e59:b7a5 with SMTP id y18-20020a7bcd92000000b0040b5e59b7a5mr114394wmj.130.1701389698798;
        Thu, 30 Nov 2023 16:14:58 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:58 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 10/12] net: phy: at803x: make at8031 related DT functions name more specific
Date:   Fri,  1 Dec 2023 01:14:20 +0100
Message-Id: <20231201001423.20989-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201001423.20989-1-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
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

Rename at8031 related DT function name to a more specific name
referencing they are only related to at8031 and not to the generic
at803x PHY family.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 268 +++++++++++++++++++--------------------
 1 file changed, 134 insertions(+), 134 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 1897030667d9..73d1a5e29202 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -583,139 +583,6 @@ static int at803x_resume(struct phy_device *phydev)
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
@@ -1498,6 +1365,139 @@ static int at803x_cable_test_start(struct phy_device *phydev)
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
+	struct regulator_config config = { };
+
+	config.dev = dev;
+	config.driver_data = phydev;
+
+	priv->vddio_rdev = devm_regulator_register(dev, &vddio_desc, &config);
+	if (IS_ERR(priv->vddio_rdev)) {
+		phydev_err(phydev, "failed to register VDDIO regulator\n");
+		return PTR_ERR(priv->vddio_rdev);
+	}
+
+	priv->vddh_rdev = devm_regulator_register(dev, &vddh_desc, &config);
+	if (IS_ERR(priv->vddh_rdev)) {
+		phydev_err(phydev, "failed to register VDDH regulator\n");
+		return PTR_ERR(priv->vddh_rdev);
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
 static int at8031_parse_dt(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
@@ -1519,7 +1519,7 @@ static int at8031_parse_dt(struct phy_device *phydev)
 	}
 
 	/* Only AR8031/8033 support 1000Base-X for SFP modules */
-	return phy_sfp_probe(phydev, &at803x_sfp_ops);
+	return phy_sfp_probe(phydev, &at8031_sfp_ops);
 }
 
 static int at8031_probe(struct phy_device *phydev)
-- 
2.40.1

