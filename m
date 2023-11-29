Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D47FCCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376764AbjK2CMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjK2CM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9A1735;
        Tue, 28 Nov 2023 18:12:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so8891345e9.1;
        Tue, 28 Nov 2023 18:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223951; x=1701828751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spIA+TVjxFqYjCqYdLI5WqUat6LJ/25LYK4uOryfg2Q=;
        b=PkGCGP9yvCYJtSK/fn3XDhHB1RHAOoZC4ubcACm+sjWpJ0/zxWbS7/ioN15f0lMgSK
         PnuTYxfBrHJw4213WA9GUOktGdD5I7YVol0zlc+U+D+ntO6gWeHSH/KtwVmmh4dxA7U5
         gsIR/BM7HPKpSZhTzDaNOLKdJhl5edHkK7OPfcN3MNF0E5d/CKgNrOw7MQ6snRQ55AfM
         yATwhlVNhJUsWrqU2IudpeStjy4F0YAVBjgbMGSV3Rd/282it2VaDTNWGkMQq05Bwsel
         AOv4uoK6vmWkmR4eUUZBx4viWR1wEm/ZeomD9T+rA8tcNt6KSyHPu23i7E/Aqmi9eceF
         dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223951; x=1701828751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spIA+TVjxFqYjCqYdLI5WqUat6LJ/25LYK4uOryfg2Q=;
        b=Mewd6+F6PtI2/u/zCezbNenQhsba/qgV4j1OfIQrT4WDoqUoz6vdbmrdMdjCv63olF
         rpRNQtYBNTzTiHeHzTz64gahWe3A8ivC6qeGISKebrt3WOHEZE7P3VZvt/PmO/n7UpmA
         BqYq6gFMRdkMKw0F2jB2YFCfxHG+X6yw/eRweQklxDta0KDLcXYxUYyKxMW5s/RRH/y7
         O6TfVkrxILdPgZNeKQ2DORXrKzjE+kiupiCEdK6LSoO34V98R1owO9O7a0xbSX6IMohg
         S/29Z7dKlu5R46Psl1xnKpBmiumEmYiaj/5x8VLHL/BojL7YuBpTPnCh7uywotPlBxgQ
         3E1g==
X-Gm-Message-State: AOJu0YxsWNqR6bAMrXp+1vIoF1P25p4BEZdJEaOQGED2bDoZI8bZVMaq
        sXgRrRbwbx1hlxQDx0Tp1Qk=
X-Google-Smtp-Source: AGHT+IFlYKmeagQA+yS6/P8KZXaea6xay9JuJR4phGasl+3pyHT3j8aDrhGEZ9c4j/AebbSsID+oOg==
X-Received: by 2002:adf:f705:0:b0:332:ef1e:bb8b with SMTP id r5-20020adff705000000b00332ef1ebb8bmr8792250wrp.7.1701223951645;
        Tue, 28 Nov 2023 18:12:31 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:31 -0800 (PST)
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
Subject: [net-next PATCH 03/14] net: phy: at803x: raname hw_stats functions to qca83xx specific name
Date:   Wed, 29 Nov 2023 03:12:08 +0100
Message-Id: <20231129021219.20914-4-ansuelsmth@gmail.com>
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

The function and the struct related to hw_stats were specific to qca83xx
PHY but were called following the convention in the driver of calling
everything with at803x prefix.

To better organize the code, rename these function a more specific name
to better describe that they are specific to 83xx PHY family.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b32ff82240dc..4ff41d70fc47 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -295,7 +295,7 @@ struct at803x_hw_stat {
 	enum stat_access_type access_type;
 };
 
-static struct at803x_hw_stat at803x_hw_stats[] = {
+static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "phy_idle_errors", 0xa, GENMASK(7, 0), PHY},
 	{ "phy_receive_errors", 0x15, GENMASK(15, 0), PHY},
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
@@ -311,7 +311,7 @@ struct at803x_priv {
 	bool is_1000basex;
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
-	u64 stats[ARRAY_SIZE(at803x_hw_stats)];
+	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
 };
 
 struct at803x_context {
@@ -529,24 +529,24 @@ static void at803x_get_wol(struct phy_device *phydev,
 		wol->wolopts |= WAKE_MAGIC;
 }
 
-static int at803x_get_sset_count(struct phy_device *phydev)
+static int qca83xx_get_sset_count(struct phy_device *phydev)
 {
-	return ARRAY_SIZE(at803x_hw_stats);
+	return ARRAY_SIZE(qca83xx_hw_stats);
 }
 
-static void at803x_get_strings(struct phy_device *phydev, u8 *data)
+static void qca83xx_get_strings(struct phy_device *phydev, u8 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(at803x_hw_stats); i++) {
+	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++) {
 		strscpy(data + i * ETH_GSTRING_LEN,
-			at803x_hw_stats[i].string, ETH_GSTRING_LEN);
+			qca83xx_hw_stats[i].string, ETH_GSTRING_LEN);
 	}
 }
 
-static u64 at803x_get_stat(struct phy_device *phydev, int i)
+static u64 qca83xx_get_stat(struct phy_device *phydev, int i)
 {
-	struct at803x_hw_stat stat = at803x_hw_stats[i];
+	struct at803x_hw_stat stat = qca83xx_hw_stats[i];
 	struct at803x_priv *priv = phydev->priv;
 	int val;
 	u64 ret;
@@ -567,13 +567,13 @@ static u64 at803x_get_stat(struct phy_device *phydev, int i)
 	return ret;
 }
 
-static void at803x_get_stats(struct phy_device *phydev,
-			     struct ethtool_stats *stats, u64 *data)
+static void qca83xx_get_stats(struct phy_device *phydev,
+			      struct ethtool_stats *stats, u64 *data)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(at803x_hw_stats); i++)
-		data[i] = at803x_get_stat(phydev, i);
+	for (i = 0; i < ARRAY_SIZE(qca83xx_hw_stats); i++)
+		data[i] = qca83xx_get_stat(phydev, i);
 }
 
 static int at803x_suspend(struct phy_device *phydev)
@@ -2168,9 +2168,9 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= at803x_get_sset_count,
-	.get_strings		= at803x_get_strings,
-	.get_stats		= at803x_get_stats,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca83xx_suspend,
 	.resume			= qca83xx_resume,
 }, {
@@ -2184,9 +2184,9 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= at803x_get_sset_count,
-	.get_strings		= at803x_get_strings,
-	.get_stats		= at803x_get_stats,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca83xx_suspend,
 	.resume			= qca83xx_resume,
 }, {
@@ -2200,9 +2200,9 @@ static struct phy_driver at803x_driver[] = {
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-	.get_sset_count		= at803x_get_sset_count,
-	.get_strings		= at803x_get_strings,
-	.get_stats		= at803x_get_stats,
+	.get_sset_count		= qca83xx_get_sset_count,
+	.get_strings		= qca83xx_get_strings,
+	.get_stats		= qca83xx_get_stats,
 	.suspend		= qca83xx_suspend,
 	.resume			= qca83xx_resume,
 }, {
-- 
2.40.1

