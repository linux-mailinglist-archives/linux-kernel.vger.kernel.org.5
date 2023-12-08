Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097CB80A675
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574112AbjLHPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574051AbjLHPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:03:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FF3853;
        Fri,  8 Dec 2023 06:52:17 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2718a768so22048665e9.0;
        Fri, 08 Dec 2023 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047136; x=1702651936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUWRj8SMGfke2llijADB8r/5G0kPfaXc58R9QB7gQMQ=;
        b=jnT/hZqfNztMEu/jSWkZpVQ97zYhtCSDzbi8qMIFt/CLCZ/T48CgWGud9qnG6btfZ4
         BTZGRtBRbpFfpaNGdGr4+OoG8q/az0hUlq3Vuj7SU1Uxblg647JqLougto2ul7FwO0j1
         88RXDOva5/9fHFWx6Savykqh8ahOZbu0HMLZNHU0O3RJ+zjZRg3y/WDzLp1etdl9urVf
         GJSVvDaWzBBDWwUTxXze7H5AOfTYDqEIxeJRl8cG74tX8NSbJvTjfZJ5OJz903PnZqmp
         wFk1+BzgefH2o6NnpkskBlxTrDoUxzLax58p5JuIt8RVwP3gD3r8rHEv+WtH6UnHo5mj
         3/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047136; x=1702651936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUWRj8SMGfke2llijADB8r/5G0kPfaXc58R9QB7gQMQ=;
        b=p6/qSnmwQNWTx4w86Bt3PZg+O744ZdMxjexGF61s7cVTseNcAxjemKsnsNZ8iAkj8l
         +DK+QixFXv6XCZlmCUiVJZcpTgsotjH/ScQWxEo/pyo0/xN3aoeOpvyOzrpKGm7bOhTN
         RXkk0r+q/WCc4WadhA/l3n6Syayi0bSXAUyvyOV4/dwDFOfAvH0i2Ol6elSWbnBr3YXP
         RjrjbrbRPiAVqaVw3ftz9HrTazgruAgNTWoKtjmuEpYwApb3I0pTbhQtZcVaODFQYGBQ
         lF2u795vH/CvQdPwdsL0QdRECtoMmLTFGUc1/oB1lhQTyTcQqcPL2NA+qNZfrAVj2Pq6
         YheQ==
X-Gm-Message-State: AOJu0Yx8/R4I3Vwtoy/j7VcWVTNevS/nlRChWMthCh9yFz31Z3EbHHvu
        VeTxbmasJ9jMT6Y4ybpWLxcuEN6FRPY=
X-Google-Smtp-Source: AGHT+IE9X8QmX/V+T4sumcp3bnCyNdzU2BbAqVxUj8ZkQ/dwLinBWoKzQ0o+xJnidQRKwolLwsyw3Q==
X-Received: by 2002:a05:600c:32af:b0:40c:2c2f:a5f0 with SMTP id t47-20020a05600c32af00b0040c2c2fa5f0mr41351wmp.92.1702047135709;
        Fri, 08 Dec 2023 06:52:15 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:15 -0800 (PST)
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
Subject: [net-next PATCH v4 08/13] net: phy: at803x: move specific at8031 WOL bits to dedicated function
Date:   Fri,  8 Dec 2023 15:51:55 +0100
Message-Id: <20231208145200.25162-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
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

Move specific at8031 WOL enable/disable to dedicated function to make
at803x_set_wol more generic.

This is needed in preparation for PHY driver split as qca8081 share the
same function to toggle WOL settings.

In this new implementation WOL module in at8031 is enabled after the
generic interrupt is setup. This should not cause any problem as the
WOL_INT has a separate implementation and only relay on MAC bits.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 42 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index e2bf5a16ba3c..862ec08ad86b 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -466,27 +466,11 @@ static int at803x_set_wol(struct phy_device *phydev,
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
@@ -1609,6 +1593,30 @@ static int at8031_config_init(struct phy_device *phydev)
 	return at803x_config_init(phydev);
 }
 
+static int at8031_set_wol(struct phy_device *phydev,
+			  struct ethtool_wolinfo *wol)
+{
+	int ret;
+
+	/* First setup MAC address and enable WOL interrupt */
+	ret = at803x_set_wol(phydev, wol);
+	if (ret)
+		return ret;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		/* Enable WOL function for 1588 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     0, AT803X_WOL_EN);
+	else
+		/* Disable WoL function for 1588 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     AT803X_PHY_MMD3_WOL_CTRL,
+				     AT803X_WOL_EN, 0);
+
+	return ret;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2121,7 +2129,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_init		= at8031_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
-	.set_wol		= at803x_set_wol,
+	.set_wol		= at8031_set_wol,
 	.get_wol		= at803x_get_wol,
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
-- 
2.40.1

