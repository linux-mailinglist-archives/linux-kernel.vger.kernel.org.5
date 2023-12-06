Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB03807CD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjLGABB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjLGAAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E01D5A;
        Wed,  6 Dec 2023 16:00:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so3854965e9.1;
        Wed, 06 Dec 2023 16:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907226; x=1702512026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg7qa9kgNv3JPVirMlKzkE9ZBdZKAWAeOTAv7Yn8WPU=;
        b=huKiWaSCh+YdySp5i9DkG1WF+yhoGmQ2TUtQuNXaigT4jCthFflqoNBXGkZWC+miaK
         irckehxWvsaX0J8Od1aABDti+uwp/zoVS9hg4RVzfmESolEmFEfNjq39dKtL/AlmmzPU
         7aDvXfC8a3cxPsHSTj+cnasEPcD6aSuBmfvUO0HfJarYWtRL74Xnr5SF74gcMtNINwLL
         cX87IE8oE+e0l3vyYOKtRq45bEl271bW3HWdY9t64+5gEvJZLOmA4mhOXFajRQrDUN/7
         YfX+R5sB2sq3TFnuCiP/+5yubOz9M5qKSn9/FRKqEEmueIIsN5+B32PPJUDBwfLDWT+j
         Db2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907226; x=1702512026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lg7qa9kgNv3JPVirMlKzkE9ZBdZKAWAeOTAv7Yn8WPU=;
        b=Aa6rph3TLgKJ5w4qPuYZwfU+ImIwaNP1na/oSZlOPvoJPhxqXMh+KjRIVD65N8neGE
         XhO7JhHwbteBKFvBabVQeds+cGX0FbGXktV1CgpxbJ2OV0mKMBGXDFgu9PLJneV2rIBX
         g/zM9MugoYayJWe2PTw5qFC+X/n6UC395NDcdj75nkVV+E6AxYG5BRUm8MOvQmPRh8Z/
         aESCaHThDYETEIbY4OA0dUM//qJS9Dr/r3cy7yR89FiENTvfmYcpBsugAwydQGA5EbAZ
         PW/08sFU7evAVG1jDawEhRB/umYUuAoPo8FpMGoIa9/tvhv4PUoPHVAkMIj3+Bfjl1nx
         +zCw==
X-Gm-Message-State: AOJu0YwoMewE6oBaHyeskauD7LikHdT8FORoNz23VE7cGoveBczdHPtR
        4YhvfLPASaAaoEYt7PuQWSI=
X-Google-Smtp-Source: AGHT+IF9bZtXPYGfUkxjyTZW8PvepHSY0TGZvquPTwalKlI+NpLXym3iwhh3TUKXXHR0amG/dojndg==
X-Received: by 2002:a05:600c:1c20:b0:40b:4805:f829 with SMTP id j32-20020a05600c1c2000b0040b4805f829mr1061028wms.22.1701907225756;
        Wed, 06 Dec 2023 16:00:25 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:25 -0800 (PST)
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
Subject: [net-next PATCH v3 08/13] net: phy: at803x: move specific at8031 WOL bits to dedicated function
Date:   Thu,  7 Dec 2023 00:57:23 +0100
Message-Id: <20231206235728.6985-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
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
index 02ac71f98466..2de7a59c0faa 100644
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
@@ -1611,6 +1595,30 @@ static int at8031_config_init(struct phy_device *phydev)
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
@@ -2123,7 +2131,7 @@ static struct phy_driver at803x_driver[] = {
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

