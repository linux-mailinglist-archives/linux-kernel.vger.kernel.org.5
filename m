Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C51F7FCCA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjK2CMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376749AbjK2CM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:27 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25109172E;
        Tue, 28 Nov 2023 18:12:34 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40838915cecso44294065e9.2;
        Tue, 28 Nov 2023 18:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223952; x=1701828752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHb4Hqab32ZAoiBQ23jqK137Vq4bVEqKWL0HZ1i2azE=;
        b=cJB0KiRGYYw0avtvXFOT3EtiLm8A/bIq2XiUEamaWVLL89RuiA0h8AbvT9trO+JxyT
         4fjE56FTzZRBuzEDB2QAvPaqEpv5JjQWnvbc+Tdt79cYJcR8NW3dVXIGwmYpok9ggQaF
         XHIShR1kXCBUHhFaVp6ldsDbWAUurfJps6nChtI9pUQXRIbZ0weSUAdEuUWa7Po/Kl2G
         Yl2Vry1CVpqYgfgEC5ljsihpnQ1OcYL08QpXIOhkpU6IzXLbJsg4moxE6vmBSsRw3b5i
         Dlw5mae8X/B6Yla7+sLCaaws+6FV86THN0rogLOYoPaG1M2A4N/o5D9VfEtl77JBOg5I
         bhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223952; x=1701828752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHb4Hqab32ZAoiBQ23jqK137Vq4bVEqKWL0HZ1i2azE=;
        b=al0oVoxReKvUZiwa80nsLzhMFQ5D8k1Ccy9gytMTQqg2PoQJFy5a37iFzNJ+Kor14P
         UpRnOpScR1/bTVIivSoj68qP4r6mNPpNCB5czewL9dD21p2s84XE1PVbATPuPAt5GYiH
         sRn4wa/4TEoAIEMkLt2Ygy6R0ih4+qI2y3iqffcLmK6xlGfrIW6EtDXnYhF9qw1hHoSn
         bTp954bAYYUWuByCKQkx1VkBH2QB7nNXQ+Oos1Hg3z7Y+/oaXqOVLntrkAWlFeaW+4YT
         /wu86DGgENNfDFxlQ/Sb67/s+RdSNOQFjo8pnAQQkhBwcVsM5GX515623fREq8CJzL1c
         9IrQ==
X-Gm-Message-State: AOJu0YxMqiM4xM32cgRCFduMjjqJfpJMp7iH7eVAhroJzLoRZbLhbaz+
        vG2qfRP46Nt1ZvC3X4a1pW4=
X-Google-Smtp-Source: AGHT+IE4Btq9lw5P4JnT6R6dW5UkJaK7rWgy2593/OMc4bdW7HGTN0Bow7yX3Wtdg8MvE4wzTuv2EA==
X-Received: by 2002:a05:600c:1ca8:b0:408:3707:b199 with SMTP id k40-20020a05600c1ca800b004083707b199mr9687018wms.3.1701223952579;
        Tue, 28 Nov 2023 18:12:32 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:32 -0800 (PST)
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
Subject: [net-next PATCH 04/14] net: phy: at803x: move qca83xx stats out of generic at803x_priv struct
Date:   Wed, 29 Nov 2023 03:12:09 +0100
Message-Id: <20231129021219.20914-5-ansuelsmth@gmail.com>
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

Introduce a specific priv struct for qca83xx PHYs to store hw stats
data and a specific probe to allocate this alternative priv struct.

This also have the benefits of reducing memory allocated for every other
at803x PHY since only qca83xx currently supports storing hw stats.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 4ff41d70fc47..3b7baa4bb637 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -301,6 +301,10 @@ static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
 };
 
+struct qca83xx_priv {
+	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
+};
+
 struct at803x_priv {
 	int flags;
 	u16 clk_25m_reg;
@@ -311,7 +315,6 @@ struct at803x_priv {
 	bool is_1000basex;
 	struct regulator_dev *vddio_rdev;
 	struct regulator_dev *vddh_rdev;
-	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
 };
 
 struct at803x_context {
@@ -547,7 +550,7 @@ static void qca83xx_get_strings(struct phy_device *phydev, u8 *data)
 static u64 qca83xx_get_stat(struct phy_device *phydev, int i)
 {
 	struct at803x_hw_stat stat = qca83xx_hw_stats[i];
-	struct at803x_priv *priv = phydev->priv;
+	struct qca83xx_priv *priv = phydev->priv;
 	int val;
 	u64 ret;
 
@@ -1591,6 +1594,20 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int qca83xx_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct qca83xx_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2164,7 +2181,7 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros 8337 internal PHY",
 	/* PHY_GBIT_FEATURES */
 	.link_change_notify	= qca83xx_link_change_notify,
-	.probe			= at803x_probe,
+	.probe			= qca83xx_probe,
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
@@ -2180,7 +2197,7 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros 8327-A internal PHY",
 	/* PHY_GBIT_FEATURES */
 	.link_change_notify	= qca83xx_link_change_notify,
-	.probe			= at803x_probe,
+	.probe			= qca83xx_probe,
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
@@ -2196,7 +2213,7 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros 8327-B internal PHY",
 	/* PHY_GBIT_FEATURES */
 	.link_change_notify	= qca83xx_link_change_notify,
-	.probe			= at803x_probe,
+	.probe			= qca83xx_probe,
 	.flags			= PHY_IS_INTERNAL,
 	.config_init		= qca83xx_config_init,
 	.soft_reset		= genphy_soft_reset,
-- 
2.40.1

