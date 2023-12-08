Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD45580A656
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574049AbjLHO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574231AbjLHO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:56:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A013A8B;
        Fri,  8 Dec 2023 06:52:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so25234445e9.2;
        Fri, 08 Dec 2023 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047141; x=1702651941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXKo4SROCMc9mbMIHxYwIaoEGcT/NyrozQrh4hVTf9Q=;
        b=Nw1Rl4Gs9IChcfVh/cf3B25PqJ5vatx0llIe8D4HlIzV18ujmHd6ge5SyrQFm7AsbE
         kaKrGikmdWPmXdsBUxUEJzB//c+18LUGJI3o3lxHRZkiz1wCyeFqWqUtXHIVZVIbI9dA
         ixeoOeQ4XuhLWIO3fhB3jArVZzB/tMhPlv8HJxx89Ey14DdDz++88E28SetCNICKGf1B
         68FLYQ09Cc5D717u63bbSwRgQfQcROSQ4QWT/USma2Nr3zyEabJ/LHNStRFRzKBL3Nr9
         EKhwOiYCpYThEFsyz53l9GcqvbqqRrtIkbZ1hLbPC6IZgfNWjrebBKG37sM428ynUABL
         dPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047141; x=1702651941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXKo4SROCMc9mbMIHxYwIaoEGcT/NyrozQrh4hVTf9Q=;
        b=RZjXgMpFraw3ZkvsVOxz9KWqte3qegepbHr8NsIK8KtODFTjXkGlbaHZ1VBdOM0X3k
         4uFWdxz9PUKxbcbeCBeLXrb+AIWNOC8tiV4+xp5pT0f839SAsc8OyygGqKDUcf87JjZz
         ZcK+dx0O6ZvGyEl5zH0VSQnC1M5GDi5csJTw7GC7OMtDMVYfDeaRBV7GIGIrEcSFPMJV
         Z3qrabDvW/lAIYoKpkTNbTA2pyjM6BVm5auOhIGT4YIn53za+L/HSNIvZL47L1gGiBUS
         Wmhq/z89O3TC8uXEd2NcKaU3+XsAcz3cVGy+IR6RVcP+h0Kf56Dz0+o9RXR+O8GsOMcF
         7TGA==
X-Gm-Message-State: AOJu0YziE/vSQJmgWkqTsXEG0Lu7dFo4eYdkI4Hmc5gwcGlDrL5HUjqk
        38Ai1hq2xtl0wMXrP8FDX4M=
X-Google-Smtp-Source: AGHT+IGpZBovJ+Gk07o/Wvyd2bGrC+Z9SGFt14Humk7kOlMBgMrK/RiyAAtrTs1NC3t2vyJyGphBKA==
X-Received: by 2002:a05:600c:1715:b0:40b:5e21:c5b5 with SMTP id c21-20020a05600c171500b0040b5e21c5b5mr29432wmn.131.1702047141418;
        Fri, 08 Dec 2023 06:52:21 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:20 -0800 (PST)
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
Subject: [net-next PATCH v4 13/13] net: phy: at803x: drop specific PHY ID check from cable test functions
Date:   Fri,  8 Dec 2023 15:52:00 +0100
Message-Id: <20231208145200.25162-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208145200.25162-1-ansuelsmth@gmail.com>
References: <20231208145200.25162-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop specific PHY ID check for cable test functions for at803x. This is
done to make functions more generic. While at it better describe what
the functions does by using more symbolic function names.

PHYs that requires to set additional reg are moved to specific function
calling the more generic one.

cdt_start and cdt_wait_for_completion are changed to take an additional
arg to pass specific values specific to the PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 95 +++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index da3506fd19c8..b9d3a26cf6dc 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1222,31 +1222,16 @@ static int at803x_cdt_fault_length(u16 status)
 	return (dt * 824) / 10;
 }
 
-static int at803x_cdt_start(struct phy_device *phydev, int pair)
+static int at803x_cdt_start(struct phy_device *phydev,
+			    u32 cdt_start)
 {
-	u16 cdt;
-
-	/* qca8081 takes the different bit 15 to enable CDT test */
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
-		cdt = QCA808X_CDT_ENABLE_TEST |
-			QCA808X_CDT_LENGTH_UNIT |
-			QCA808X_CDT_INTER_CHECK_DIS;
-	else
-		cdt = FIELD_PREP(AT803X_CDT_MDI_PAIR_MASK, pair) |
-			AT803X_CDT_ENABLE_TEST;
-
-	return phy_write(phydev, AT803X_CDT, cdt);
+	return phy_write(phydev, AT803X_CDT, cdt_start);
 }
 
-static int at803x_cdt_wait_for_completion(struct phy_device *phydev)
+static int at803x_cdt_wait_for_completion(struct phy_device *phydev,
+					  u32 cdt_en)
 {
 	int val, ret;
-	u16 cdt_en;
-
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
-		cdt_en = QCA808X_CDT_ENABLE_TEST;
-	else
-		cdt_en = AT803X_CDT_ENABLE_TEST;
 
 	/* One test run takes about 25ms */
 	ret = phy_read_poll_timeout(phydev, AT803X_CDT, val,
@@ -1266,11 +1251,13 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 	};
 	int ret, val;
 
-	ret = at803x_cdt_start(phydev, pair);
+	val = FIELD_PREP(AT803X_CDT_MDI_PAIR_MASK, pair) |
+	      AT803X_CDT_ENABLE_TEST;
+	ret = at803x_cdt_start(phydev, val);
 	if (ret)
 		return ret;
 
-	ret = at803x_cdt_wait_for_completion(phydev);
+	ret = at803x_cdt_wait_for_completion(phydev, AT803X_CDT_ENABLE_TEST);
 	if (ret)
 		return ret;
 
@@ -1292,19 +1279,11 @@ static int at803x_cable_test_one_pair(struct phy_device *phydev, int pair)
 }
 
 static int at803x_cable_test_get_status(struct phy_device *phydev,
-					bool *finished)
+					bool *finished, unsigned long pair_mask)
 {
-	unsigned long pair_mask;
 	int retries = 20;
 	int pair, ret;
 
-	if (phydev->phy_id == ATH9331_PHY_ID ||
-	    phydev->phy_id == ATH8032_PHY_ID ||
-	    phydev->phy_id == QCA9561_PHY_ID)
-		pair_mask = 0x3;
-	else
-		pair_mask = 0xf;
-
 	*finished = false;
 
 	/* According to the datasheet the CDT can be performed when
@@ -1331,7 +1310,7 @@ static int at803x_cable_test_get_status(struct phy_device *phydev,
 	return 0;
 }
 
-static int at803x_cable_test_start(struct phy_device *phydev)
+static void at803x_cable_test_autoneg(struct phy_device *phydev)
 {
 	/* Enable auto-negotiation, but advertise no capabilities, no link
 	 * will be established. A restart of the auto-negotiation is not
@@ -1339,11 +1318,11 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	 */
 	phy_write(phydev, MII_BMCR, BMCR_ANENABLE);
 	phy_write(phydev, MII_ADVERTISE, ADVERTISE_CSMA);
-	if (phydev->phy_id != ATH9331_PHY_ID &&
-	    phydev->phy_id != ATH8032_PHY_ID &&
-	    phydev->phy_id != QCA9561_PHY_ID)
-		phy_write(phydev, MII_CTRL1000, 0);
+}
 
+static int at803x_cable_test_start(struct phy_device *phydev)
+{
+	at803x_cable_test_autoneg(phydev);
 	/* we do all the (time consuming) work later */
 	return 0;
 }
@@ -1618,6 +1597,29 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+/* AR8031 and AR8035 share the same cable test get status reg */
+static int at8031_cable_test_get_status(struct phy_device *phydev,
+					bool *finished)
+{
+	return at803x_cable_test_get_status(phydev, finished, 0xf);
+}
+
+/* AR8031 and AR8035 share the same cable test start logic */
+static int at8031_cable_test_start(struct phy_device *phydev)
+{
+	at803x_cable_test_autoneg(phydev);
+	phy_write(phydev, MII_CTRL1000, 0);
+	/* we do all the (time consuming) work later */
+	return 0;
+}
+
+/* AR8032, AR9331 and QCA9561 share the same cable test get status reg */
+static int at8032_cable_test_get_status(struct phy_device *phydev,
+					bool *finished)
+{
+	return at803x_cable_test_get_status(phydev, finished, 0x3);
+}
+
 static int at8035_parse_dt(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
@@ -2041,11 +2043,14 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 
 	*finished = false;
 
-	ret = at803x_cdt_start(phydev, 0);
+	val = QCA808X_CDT_ENABLE_TEST |
+	      QCA808X_CDT_LENGTH_UNIT |
+	      QCA808X_CDT_INTER_CHECK_DIS;
+	ret = at803x_cdt_start(phydev, val);
 	if (ret)
 		return ret;
 
-	ret = at803x_cdt_wait_for_completion(phydev);
+	ret = at803x_cdt_wait_for_completion(phydev, QCA808X_CDT_ENABLE_TEST);
 	if (ret)
 		return ret;
 
@@ -2143,8 +2148,8 @@ static struct phy_driver at803x_driver[] = {
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_start	= at8031_cable_test_start,
+	.cable_test_get_status	= at8031_cable_test_get_status,
 }, {
 	/* Qualcomm Atheros AR8030 */
 	.phy_id			= ATH8030_PHY_ID,
@@ -2181,8 +2186,8 @@ static struct phy_driver at803x_driver[] = {
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_start	= at8031_cable_test_start,
+	.cable_test_get_status	= at8031_cable_test_get_status,
 }, {
 	/* Qualcomm Atheros AR8032 */
 	PHY_ID_MATCH_EXACT(ATH8032_PHY_ID),
@@ -2197,7 +2202,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 }, {
 	/* ATHEROS AR9331 */
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
@@ -2210,7 +2215,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
@@ -2226,7 +2231,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
-- 
2.40.1

