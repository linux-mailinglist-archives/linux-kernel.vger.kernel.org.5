Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C479980001E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377469AbjLAAPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377440AbjLAAPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD8199D;
        Thu, 30 Nov 2023 16:15:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so11459665e9.2;
        Thu, 30 Nov 2023 16:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389701; x=1701994501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0La5H0sjddNIq/VvoGQu8ZG94GEUi31ycq7n/iZy+E=;
        b=jq3pdT26z2bx314KexihN4nYi1TPpZWhkt4N2MrvzQsTpb3RHq7zC7YjAdJEyDki4c
         t3HPOwJ3s/pcyTFykSrq9sKTRzcYIr/IVau4Pg93D8qCZUTm03wh/NO84peUKS66dQ/g
         ApqoyVPRCPeOc64RPLkrHOE184JQDYTI+2//ztBRw3kEKKlzeupQlEfx6GOq6bqZktOE
         OwFQ3UDP2VHrf5HW1Lzbp/L6+RBhMcXHHbEMEs1MMnMU70I9YdXMfzpAuRiKCoCywKmf
         Msl4cDWu6zly+r2tG7w/JMc0K6J8VUYJiXoE9PDkPVOSyTh+rZy9V3vNPGNNXZJAn8CP
         9Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389701; x=1701994501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0La5H0sjddNIq/VvoGQu8ZG94GEUi31ycq7n/iZy+E=;
        b=RNS65/RNPCYsE/A2Ab5FEJJIcbToxRVX/fN5b5HWi8qzoBUUj+6cCMuxaxfqwjVBkU
         ShAET4jBSlVrTwKiuV1qFP0pt/4bs9acng2JBarqNbSautnluPOTB0pavaLhph/WpbYQ
         ZSNz7NAg7vkvPcvqS+TaaeSh137L75+GPb1jbm7mKK8ZeneAYAw4fCevsVFUULC89cAg
         8A/rVXe7s0IKM39iwqD6Lz2mZ0MjhiP6s29ZFqhDj8GiGE6r0845vTmuMHT86+BI8iFD
         7wj5bizgVaOLakIAYryc45djUWkUAW9DklPBybHlARvwMUGG0G78NVOI2sPB2DLRQxcU
         D9yQ==
X-Gm-Message-State: AOJu0YwfQ09at8pmew4Z+xefIUkZWYdGBLZd2Vlju0EYa/aCq5k+zfeO
        j83z4RO+RWvXlMql0yzrn6w=
X-Google-Smtp-Source: AGHT+IFtGye2IP2ziCz7F2vBizhjGkh+8k2WtNNzepSDOg/li/0McSwyDBcgg4DN+2Xelyqu8IJkHw==
X-Received: by 2002:a05:600c:46c9:b0:40b:3faa:c964 with SMTP id q9-20020a05600c46c900b0040b3faac964mr81262wmo.27.1701389701515;
        Thu, 30 Nov 2023 16:15:01 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:15:01 -0800 (PST)
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
Subject: [net-next PATCH v2 12/12] net: phy: at803x: drop specific PHY id check from cable test functions
Date:   Fri,  1 Dec 2023 01:14:23 +0100
Message-Id: <20231201001423.20989-14-ansuelsmth@gmail.com>
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

Drop specific PHY id check for cable test functions for at803x. This is
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
index 27dc0a9ca076..d102f826db73 100644
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
@@ -1620,6 +1599,29 @@ static int at8031_config_intr(struct phy_device *phydev)
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
@@ -2043,11 +2045,14 @@ static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finish
 
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
 
@@ -2145,8 +2150,8 @@ static struct phy_driver at803x_driver[] = {
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
@@ -2183,8 +2188,8 @@ static struct phy_driver at803x_driver[] = {
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
@@ -2199,7 +2204,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 }, {
 	/* ATHEROS AR9331 */
 	PHY_ID_MATCH_EXACT(ATH9331_PHY_ID),
@@ -2212,7 +2217,7 @@ static struct phy_driver at803x_driver[] = {
 	.config_intr		= at803x_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.cable_test_start	= at803x_cable_test_start,
-	.cable_test_get_status	= at803x_cable_test_get_status,
+	.cable_test_get_status	= at8032_cable_test_get_status,
 	.read_status		= at803x_read_status,
 	.soft_reset		= genphy_soft_reset,
 	.config_aneg		= at803x_config_aneg,
@@ -2228,7 +2233,7 @@ static struct phy_driver at803x_driver[] = {
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

