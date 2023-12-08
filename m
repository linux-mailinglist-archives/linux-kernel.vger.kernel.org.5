Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20B280A657
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574194AbjLHO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574177AbjLHO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:56:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DC835AA;
        Fri,  8 Dec 2023 06:52:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c039e9719so24711325e9.1;
        Fri, 08 Dec 2023 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047131; x=1702651931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5feJ9c621I5/VZmz7DYVtyWPMsJYNgURBm5K+LW+VFE=;
        b=VAvE848/Z4AsZCW4EnDdXInW35aj5vHwd+v+LiAWGNVd9VNfkEkWH6E8w6WXhLtnMl
         22GK8JFTxnAn90Pmw71FJ5ufMNhWePVUeN6ml1Y8d3NbnKWh4Qre0kZdveTRCy0/cuxN
         ITbZD7GwSOr6oD+Rr9E7I3rXra3fftKpx6YFIB1TuuHQ6ukBEbE6O+JJ8J6H5J8j0Dei
         4f0G+37zF8C12l/s9nlp/BbyINrUCql36goPEThGUu6ovjS5UyxHbasJDBi6jlFb6hdQ
         B0jydWazDdgaBKKOrlKiK/Etso8Gr5lxR1gl94LLv2ckSdIa02amYLBHvmUSiy24dH2q
         F2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047131; x=1702651931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5feJ9c621I5/VZmz7DYVtyWPMsJYNgURBm5K+LW+VFE=;
        b=u9RXusz4fBWaZL36K50ureiC3odlN1Pc7c9cM+z67cwy1f7tXb0zSepwyF0R676OC2
         YH55kyFTDxhDVlofWZF0an8baMHlocPpGKFdUEkdAvpokWnCwgOympPe25+8F4y9/XKD
         xiN7Zw/pD8/IxxGZvgK936fHTG4PpY+RL1NfVxmUKMQ0zE9seuVCGDDUqBI9AFKIUJ3V
         /bL0WZkqSNidt3uMnp//bY8zzX7rOS3X7qZHeQQRofPi2NJkyUuELBe5b8wBP+vn0oDG
         WaI/NX8QMuZLKU9NJdOEHlW0EcMIaAAzVXtpIRmu8nTeip4jd9RfB3TvfO0srU9o4WHH
         egmA==
X-Gm-Message-State: AOJu0Yz57HOGl1Ja99AekQbP268EWKG2ihEnYoObP1vLl72KsV8CH8rS
        0XX3wk2/F3TsY+ZX0WSi58Y=
X-Google-Smtp-Source: AGHT+IG/zXGDmAWkck+f5HF8HcpPavtzuWSCoZICM0+LbFLtrHxewTUfDYWTbtMCc3mbob6q7vyjug==
X-Received: by 2002:a05:600c:2b0f:b0:40c:33be:d166 with SMTP id y15-20020a05600c2b0f00b0040c33bed166mr49417wme.87.1702047131342;
        Fri, 08 Dec 2023 06:52:11 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:10 -0800 (PST)
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
Subject: [net-next PATCH v4 04/13] net: phy: at803x: move qca83xx specific check in dedicated functions
Date:   Fri,  8 Dec 2023 15:51:51 +0100
Message-Id: <20231208145200.25162-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework qca83xx specific check to dedicated function to tidy things up
and drop useless phy_id check.

Also drop an useless link_change_notify for QCA8337 as it did nothing an
returned early.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 68 ++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 277a6c27af7c..fa412a4e080d 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1623,27 +1623,26 @@ static int qca83xx_config_init(struct phy_device *phydev)
 		break;
 	}
 
+	/* Following original QCA sourcecode set port to prefer master */
+	phy_set_bits(phydev, MII_CTRL1000, CTL1000_PREFER_MASTER);
+
+	return 0;
+}
+
+static int qca8327_config_init(struct phy_device *phydev)
+{
 	/* QCA8327 require DAC amplitude adjustment for 100m set to +6%.
 	 * Disable on init and enable only with 100m speed following
 	 * qca original source code.
 	 */
-	if (phydev->drv->phy_id == QCA8327_A_PHY_ID ||
-	    phydev->drv->phy_id == QCA8327_B_PHY_ID)
-		at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
-				      QCA8327_DEBUG_MANU_CTRL_EN, 0);
+	at803x_debug_reg_mask(phydev, AT803X_DEBUG_ANALOG_TEST_CTRL,
+			      QCA8327_DEBUG_MANU_CTRL_EN, 0);
 
-	/* Following original QCA sourcecode set port to prefer master */
-	phy_set_bits(phydev, MII_CTRL1000, CTL1000_PREFER_MASTER);
-
-	return 0;
+	return qca83xx_config_init(phydev);
 }
 
 static void qca83xx_link_change_notify(struct phy_device *phydev)
 {
-	/* QCA8337 doesn't require DAC Amplitude adjustement */
-	if (phydev->drv->phy_id == QCA8337_PHY_ID)
-		return;
-
 	/* Set DAC Amplitude adjustment to +6% for 100m on link running */
 	if (phydev->state == PHY_RUNNING) {
 		if (phydev->speed == SPEED_100)
@@ -1686,19 +1685,6 @@ static int qca83xx_resume(struct phy_device *phydev)
 
 static int qca83xx_suspend(struct phy_device *phydev)
 {
-	u16 mask = 0;
-
-	/* Only QCA8337 support actual suspend.
-	 * QCA8327 cause port unreliability when phy suspend
-	 * is set.
-	 */
-	if (phydev->drv->phy_id == QCA8337_PHY_ID) {
-		genphy_suspend(phydev);
-	} else {
-		mask |= ~(BMCR_SPEED1000 | BMCR_FULLDPLX);
-		phy_modify(phydev, MII_BMCR, mask, 0);
-	}
-
 	at803x_debug_reg_mask(phydev, AT803X_DEBUG_REG_GREEN,
 			      AT803X_DEBUG_GATE_CLK_IN1000, 0);
 
@@ -1709,6 +1695,27 @@ static int qca83xx_suspend(struct phy_device *phydev)
 	return 0;
 }
 
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
 static int qca808x_phy_fast_retrain_config(struct phy_device *phydev)
 {
 	int ret;
@@ -2170,7 +2177,6 @@ static struct phy_driver at803x_driver[] = {
 	.phy_id_mask		= QCA8K_PHY_ID_MASK,
 	.name			= "Qualcomm Atheros 8337 internal PHY",
 	/* PHY_GBIT_FEATURES */
-	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= at803x_probe,
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
@@ -2178,7 +2184,7 @@ static struct phy_driver at803x_driver[] = {
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca83xx_suspend,
+	.suspend		= qca8337_suspend,
 	.resume			= qca83xx_resume,
 }, {
 	/* QCA8327-A from switch QCA8327-AL1A */
@@ -2189,12 +2195,12 @@ static struct phy_driver at803x_driver[] = {
 	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= at803x_probe,
 	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca83xx_config_init,
+	.config_init		= qca8327_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca83xx_suspend,
+	.suspend		= qca8327_suspend,
 	.resume			= qca83xx_resume,
 }, {
 	/* QCA8327-B from switch QCA8327-BL1A */
@@ -2205,12 +2211,12 @@ static struct phy_driver at803x_driver[] = {
 	.link_change_notify	= qca83xx_link_change_notify,
 	.probe			= at803x_probe,
 	.flags			= PHY_IS_INTERNAL,
-	.config_init		= qca83xx_config_init,
+	.config_init		= qca8327_config_init,
 	.soft_reset		= genphy_soft_reset,
 	.get_sset_count		= qca83xx_get_sset_count,
 	.get_strings		= qca83xx_get_strings,
 	.get_stats		= qca83xx_get_stats,
-	.suspend		= qca83xx_suspend,
+	.suspend		= qca8327_suspend,
 	.resume			= qca83xx_resume,
 }, {
 	/* Qualcomm QCA8081 */
-- 
2.40.1

