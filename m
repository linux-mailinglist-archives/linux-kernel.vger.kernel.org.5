Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473281240B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjLNApi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442888AbjLNApf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:45:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF4AC;
        Wed, 13 Dec 2023 16:45:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c46d6784eso36729795e9.3;
        Wed, 13 Dec 2023 16:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514740; x=1703119540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+moSObm6SmTF7EP235eqi6TuZLbs8gEL+3plRa6dpk=;
        b=WlkbeTlJIMWtZEKGaBcWDxLg+nrPn+nzalrow44Z+b0maQwznOEoB0Fk3NnrqJ83b4
         4Y7TmEXLbRhLpSKbzSaYjFNpzl2lhJHPDGcRS6oIdtaIEGpXviJz7vlnyydaT2gM1/VN
         f3mfcZhMDFB5XpYiUVQQrUTtYJmM5QKtF0fB9S74sk7ai3TofdfxYiL5y2WEnjEoESjm
         YgJpsQSLQMHIA6yftYa4a0PDcZV8GYbidrzve87L2bhhQRE3Ike5b2IpmOYbjMUDlGaK
         dbGs0r4ioGqRMwr0oaoyDYPZREAGLBPkVadCwPWT326rNGZATYXuPJMwxoZtlJe32J46
         S4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514740; x=1703119540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+moSObm6SmTF7EP235eqi6TuZLbs8gEL+3plRa6dpk=;
        b=LDqaGbCWucJ8vcrKtJEd9zRIrs84P2uX9JcZBiVyTkIowbGfpirxOZpr4aYdYJRq0S
         zNAW31XaxgQf+1Ic/8SHHTLxJrwnodsFCRvM78A8zR0+xBi/qMa1VZ4DHY1mvMxtpy4r
         HfamL5dwe7UY75WYlh3F3ddpVKBGK89R+t9R/xKKGstUl5zOY+7IXRuXG7H0KKoL2Yw9
         pBGVk/71Wl71cNC2jAD39b7sTbBXuNzSgQbC+AAjKIpU7HBHosUQ7/puLvWX7Z5f37Qx
         Hzmrx+ZQtUiAKLtwnfERgRNRCU4gatpzBRq07niMn7bJULgD6YlmCc+uuZUAdIa8KKrf
         J/cw==
X-Gm-Message-State: AOJu0Yzz+AmcMF5MDU2xKPpQ+BVqmPxoHVxz/2OZlpqZFBFjIojRe0Rc
        nQZvWdBQpgjvC7Nc41ls5uY=
X-Google-Smtp-Source: AGHT+IHCfqv42/t3E60QOzcjVoDubipoKSyK+S59ve4IC1N6MT2Ls69yCI4jV9mdh/7UUPHUCT0WbA==
X-Received: by 2002:a7b:c3d7:0:b0:40c:610e:3c7c with SMTP id t23-20020a7bc3d7000000b0040c610e3c7cmr169512wmj.23.1702514739940;
        Wed, 13 Dec 2023 16:45:39 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g15-20020adfe40f000000b003364470f30bsm959013wrm.52.2023.12.13.16.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:45:39 -0800 (PST)
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
Subject: [net-next PATCH 1/2] net: phy: at803x: move specific qca808x config_aneg to dedicated function
Date:   Thu, 14 Dec 2023 01:44:31 +0100
Message-Id: <20231214004432.16702-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214004432.16702-1-ansuelsmth@gmail.com>
References: <20231214004432.16702-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move specific qca808x config_aneg to dedicated function to permit easier
split of qca808x portion from at803x driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 66 ++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b9d3a26cf6dc..03f945cc7626 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1045,9 +1045,8 @@ static int at803x_config_mdix(struct phy_device *phydev, u8 ctrl)
 			  FIELD_PREP(AT803X_SFC_MDI_CROSSOVER_MODE_M, val));
 }
 
-static int at803x_config_aneg(struct phy_device *phydev)
+static int at803x_prepare_config_aneg(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int ret;
 
 	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
@@ -1064,33 +1063,22 @@ static int at803x_config_aneg(struct phy_device *phydev)
 			return ret;
 	}
 
-	if (priv->is_1000basex)
-		return genphy_c37_config_aneg(phydev);
-
-	/* Do not restart auto-negotiation by setting ret to 0 defautly,
-	 * when calling __genphy_config_aneg later.
-	 */
-	ret = 0;
-
-	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
-		int phy_ctrl = 0;
+	return 0;
+}
 
-		/* The reg MII_BMCR also needs to be configured for force mode, the
-		 * genphy_config_aneg is also needed.
-		 */
-		if (phydev->autoneg == AUTONEG_DISABLE)
-			genphy_c45_pma_setup_forced(phydev);
+static int at803x_config_aneg(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	int ret;
 
-		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
-			phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+	ret = at803x_prepare_config_aneg(phydev);
+	if (ret)
+		return ret;
 
-		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-				MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
-		if (ret < 0)
-			return ret;
-	}
+	if (priv->is_1000basex)
+		return genphy_c37_config_aneg(phydev);
 
-	return __genphy_config_aneg(phydev, ret);
+	return genphy_config_aneg(phydev);
 }
 
 static int at803x_get_downshift(struct phy_device *phydev, u8 *d)
@@ -2118,6 +2106,32 @@ static int qca808x_get_features(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca808x_config_aneg(struct phy_device *phydev)
+{
+	int phy_ctrl = 0;
+	int ret;
+
+	ret = at803x_prepare_config_aneg(phydev);
+	if (ret)
+		return ret;
+
+	/* The reg MII_BMCR also needs to be configured for force mode, the
+	 * genphy_config_aneg is also needed.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		genphy_c45_pma_setup_forced(phydev);
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
+		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
+	if (ret < 0)
+		return ret;
+
+	return __genphy_config_aneg(phydev, ret);
+}
+
 static void qca808x_link_change_notify(struct phy_device *phydev)
 {
 	/* Assert interface sgmii fifo on link down, deassert it on link up,
@@ -2295,7 +2309,7 @@ static struct phy_driver at803x_driver[] = {
 	.set_wol		= at803x_set_wol,
 	.get_wol		= at803x_get_wol,
 	.get_features		= qca808x_get_features,
-	.config_aneg		= at803x_config_aneg,
+	.config_aneg		= qca808x_config_aneg,
 	.suspend		= genphy_suspend,
 	.resume			= genphy_resume,
 	.read_status		= qca808x_read_status,
-- 
2.40.1

