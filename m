Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1719807CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441920AbjLGABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441917AbjLGAAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266CD68;
        Wed,  6 Dec 2023 16:00:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so4785655e9.1;
        Wed, 06 Dec 2023 16:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907228; x=1702512028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLw2n/+QIBoz3p532oZh6o9IUO9Ie7XX1RcGDA2Pv8M=;
        b=fy5jm9o/tpuHjCmNhFrpgSWXiItoD+O9L7greFax7czsIt6myYI5tnHyrzqGZno1/D
         ovDLnGnAv21Ug9CTQeE+OabVduuGnal9AZ1bqweMvtZxuDeR60vddRFBea3BRhzyQwG/
         k1y6yRXkIfliSvzO/HAeEJhbXGTDeGVhCkF8rk+l05lwhducVu+wi8j9AYORhXRV9D89
         SP+hcGaLwrCx0LrWNWs0A7+MIKqEtaS7B82zkCkW8n0HSkQ8JHNuMg/bHR3bZqwxNWg+
         DxBMOosLDxvIBo/0F212HR103iSAg+You5mxp0kEHf8nkwbQYMfss78M+xN8zgmqzm1S
         JB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907228; x=1702512028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLw2n/+QIBoz3p532oZh6o9IUO9Ie7XX1RcGDA2Pv8M=;
        b=sV89OZqQ4+fremdYvi1PMV9g80Uo+IIhz6JU8rvrmwgeh3jqQ0v8PlUuTcbu/0Mkkc
         LsE5R528RLyoStXFxAhHgucMiSAMNhE5EQlNqUr87q4awFchWVegLlcWG7dgWvwxKRJq
         +bGbOc1l7Meax6ffeiaqwcneBy4+zeEBsJ66XMaPMzMBJ1erdIiHagNsaXPSc/lepJF0
         tOvIb/t+0p2Ai5Z2DJFB4crFjEL80HpxtjWKMjR7IY26KnAOmcnS7nUTX4WQuZ75ZUE0
         6cjvwYivgVZS6OTZyqDEsctK4th4WUUq45aHMiLIc4sgi/gmaqCeGDj9iIK4nzbIYskL
         PTcg==
X-Gm-Message-State: AOJu0Yw8mVpMJM96hlw1YrSO0WOrk+psDfSIe3fIBthj/uJcO0ehMaXc
        tsr7LjpSD5PqOuCXYTO7uWw=
X-Google-Smtp-Source: AGHT+IGFEzSJMOGJdMF1ywLy4jaW24G5qtmITrA3QZZVnq35AtNoPoCpBNpHAB8t9UIItqSedn+UYQ==
X-Received: by 2002:a05:600c:468d:b0:40b:5e4a:406a with SMTP id p13-20020a05600c468d00b0040b5e4a406amr996898wmo.138.1701907228314;
        Wed, 06 Dec 2023 16:00:28 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:28 -0800 (PST)
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
Subject: [net-next PATCH v3 10/13] net: phy: at803x: make at8031 related DT functions name more specific
Date:   Thu,  7 Dec 2023 00:57:25 +0100
Message-Id: <20231206235728.6985-11-ansuelsmth@gmail.com>
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

Rename at8031 related DT function name to a more specific name
referencing they are only related to at8031 and not to the generic
at803x PHY family.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 1897030667d9..3ae15ed7d634 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -583,7 +583,7 @@ static int at803x_resume(struct phy_device *phydev)
 	return phy_modify(phydev, MII_BMCR, BMCR_PDOWN | BMCR_ISOLATE, 0);
 }
 
-static int at803x_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
+static int at8031_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
 					    unsigned int selector)
 {
 	struct phy_device *phydev = rdev_get_drvdata(rdev);
@@ -596,7 +596,7 @@ static int at803x_rgmii_reg_set_voltage_sel(struct regulator_dev *rdev,
 					     AT803X_DEBUG_RGMII_1V8, 0);
 }
 
-static int at803x_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
+static int at8031_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct phy_device *phydev = rdev_get_drvdata(rdev);
 	int val;
@@ -610,8 +610,8 @@ static int at803x_rgmii_reg_get_voltage_sel(struct regulator_dev *rdev)
 
 static const struct regulator_ops vddio_regulator_ops = {
 	.list_voltage = regulator_list_voltage_table,
-	.set_voltage_sel = at803x_rgmii_reg_set_voltage_sel,
-	.get_voltage_sel = at803x_rgmii_reg_get_voltage_sel,
+	.set_voltage_sel = at8031_rgmii_reg_set_voltage_sel,
+	.get_voltage_sel = at8031_rgmii_reg_get_voltage_sel,
 };
 
 static const unsigned int vddio_voltage_table[] = {
@@ -666,7 +666,7 @@ static int at8031_register_regulators(struct phy_device *phydev)
 	return 0;
 }
 
-static int at803x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
+static int at8031_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 {
 	struct phy_device *phydev = upstream;
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_support);
@@ -710,10 +710,10 @@ static int at803x_sfp_insert(void *upstream, const struct sfp_eeprom_id *id)
 	return 0;
 }
 
-static const struct sfp_upstream_ops at803x_sfp_ops = {
+static const struct sfp_upstream_ops at8031_sfp_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
-	.module_insert = at803x_sfp_insert,
+	.module_insert = at8031_sfp_insert,
 };
 
 static int at803x_parse_dt(struct phy_device *phydev)
@@ -1519,7 +1519,7 @@ static int at8031_parse_dt(struct phy_device *phydev)
 	}
 
 	/* Only AR8031/8033 support 1000Base-X for SFP modules */
-	return phy_sfp_probe(phydev, &at803x_sfp_ops);
+	return phy_sfp_probe(phydev, &at8031_sfp_ops);
 }
 
 static int at8031_probe(struct phy_device *phydev)
-- 
2.40.1

