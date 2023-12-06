Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19C7807CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441851AbjLGABK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441920AbjLGAA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:26 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A9B10C3;
        Wed,  6 Dec 2023 16:00:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so3787145e9.2;
        Wed, 06 Dec 2023 16:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907230; x=1702512030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1GjoFCHwWRz6fRwuR7ibzQ19O6g0gXQ8gbR6f752RI=;
        b=kgTs+1q4xbcaFHdcXfiVH4sl+tA1vJPUEriiBIGOh7nlKjP7JPsnKhYnBsv+5BZYfM
         KCckmuAfYsQZh5iA9B+YihSU3PXNSSXn3u5YG+KnEAd+4vyCVODAP5D9Wr6FmoOL2LJ+
         KnwsD6BJIWHq1BOWm5kLU++7JUmQvnOqgS+4ANGbW7K8nJCgZrR/BWcW8N6UMqI95qai
         KdmYyrmyJ1/UdEvQQ3yasnFgQaIYuigHnfv88LW8nGnY675sXiK2V1riUZRAtRZDK6oM
         vy3p9Axc52490nWyAIVyA93og7ntIjlD8yg2RzeL2SB7vo7cHFYIztKZxAB3lLh6ZsON
         yMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907230; x=1702512030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1GjoFCHwWRz6fRwuR7ibzQ19O6g0gXQ8gbR6f752RI=;
        b=MkoovLu8E1pITLU1vB/fv6cWoKV4thmPN7Ooy8zH3w5tjYQdBdsSBD3wedWGdVMog0
         SoDIpsE4HL6lXaitF5Db5wZrg7AZ2KftZH7HTjBiT6hGoHtqVJbgcDCcQO+eSDSh2KAv
         P912o8nMImN5YLM1MG0rSRCo+DpX06URFnVJm5BguhpQto//mgIRahkQva/12J5i2js1
         TuNzBcbDXJNdAEMZNdCNBLQKuw3Ow+QvK/5k5eDP76gQCRvOLSIOnz/mZh655zSrm5nR
         TKnx0EtUUzCHi55Y+puo81FmOftMxAUBzD6wM/RYCPL6qrNvNj+jzQ7BX6M/g5RFhN/z
         ZiyA==
X-Gm-Message-State: AOJu0Yx4kN3HZYzzwWF7mk2+SDIsbvzK/ufE+DLn8udRQEDWpxxkvfCg
        6uclRfjlcsYxhu/HtoUt9Ag=
X-Google-Smtp-Source: AGHT+IGs5gfiZWcjtq9eQJ2iEvpi5sElLdhowK5mfeV692ypbllrxMYFKhCPvNJmzfe7kyKiNiL9sw==
X-Received: by 2002:a05:600c:b46:b0:40b:5e1b:54a4 with SMTP id k6-20020a05600c0b4600b0040b5e1b54a4mr1209251wmr.48.1701907229812;
        Wed, 06 Dec 2023 16:00:29 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:29 -0800 (PST)
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
Subject: [net-next PATCH v3 11/13] net: phy: at803x: move at8031 functions in dedicated section
Date:   Thu,  7 Dec 2023 00:57:26 +0100
Message-Id: <20231206235728.6985-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
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

Move at8031 functions in dedicated section with dedicated at8031
parse_dt and probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 266 +++++++++++++++++++--------------------
 1 file changed, 133 insertions(+), 133 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 3ae15ed7d634..73d1a5e29202 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -583,139 +583,6 @@ static int at803x_resume(struct phy_device *phydev)
 	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0);
 }
 
-static int at8031_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
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
-static int at8031_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
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
-	.set_voltage_sel = at8031_rgmii_reg_set_voltage_sel,
-	.get_voltage_sel = at8031_rgmii_reg_get_voltage_sel,
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
-static int at8031_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
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
-static const struct sfp_upstream_ops at8031_sfp_ops = {
-	.attach = phy_sfp_attach,
-	.detach = phy_sfp_detach,
-	.module_insert = at8031_sfp_insert,
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
-- 
2.40.1

