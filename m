Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C267FCCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376808AbjK2CNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjK2CMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:12:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A61BDD;
        Tue, 28 Nov 2023 18:12:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b4d9e81deso11254045e9.0;
        Tue, 28 Nov 2023 18:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701223960; x=1701828760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLmfu/DdLnvSNop7dADW8AvL4uOevDpNuHz3idb7g+8=;
        b=CA+VXtiMfBcsJp8XP0MapGNJVIMEtPw2JpxrUJ7JD80ZmXrEXEfYPOfG/lkJLp2LJf
         5vewTvS9mftGQBydqLr5gLBu1LJKhNb6MIrQdXpfVXb7gKgKi2ouUmfe5H9SqhVuP7kY
         PLzY4XBZNLb7uK0+DudREpAJ4fttEetzJxRT56v856KyKnmAt5gDGV00wc7jmIwa0JAy
         gxd8fOwRUZdWTytoUN2SSxFLdXNYqEcLbh/X3reo4G2+hYprd+IAhgXDrglveEVR0Fqd
         5XMys3npUGA9KM5eX5tl+OVNeupq/yAeGKCiwS4ykHpR7/UC5pI4D/JJM8LImnOtxEpL
         towQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701223960; x=1701828760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLmfu/DdLnvSNop7dADW8AvL4uOevDpNuHz3idb7g+8=;
        b=VfRCAVCEhbksb4zzn03OZKFIMDl7wMzUQw8+uDOsD1lhr4y/xsx/VLAIxMHkVGkSqK
         4QgUOUrudBx61YHmyD7LH/Dz1QckvXQ92V6PL0kOhhol4yCkkRm3+zBtWkFVBKe/vNz1
         9ZXsgPmpS+NLnpmJVOIecCVnOFlpljAngZLeiiXqnUZGt++HPNl9QP2X0EaOLv3d4O5K
         SCImWo+/uB1HP5UfOCPXX0iZpQZ/4NfTdx5rIT2E2xD87hVp9zYHN+HFnnRVDyohHUQ0
         eXnDdFENpckxeIpihiNNn6q4Emoltfbvg145jCTJaDCftiSgAtU03G9+OeCLjYH46Y0P
         da9w==
X-Gm-Message-State: AOJu0Yyaj0MlV3lAqEnbSDOll7sr0Yk9SIAj0V54bowNRZnxMckToDea
        /sneBD8YquYFU+jN+PKabP8=
X-Google-Smtp-Source: AGHT+IFwT2LV0xf9YNUmEWDdR9pjKlN+k7i5VB98TtxFS9FjfVQ67MPFnCdAbcLZCNWR/qT+7FwYOA==
X-Received: by 2002:a05:600c:45cf:b0:40b:3320:ea8a with SMTP id s15-20020a05600c45cf00b0040b3320ea8amr11145112wmo.17.1701223960054;
        Tue, 28 Nov 2023 18:12:40 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b19-20020a05600c4e1300b0040648217f4fsm321406wmq.39.2023.11.28.18.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:12:39 -0800 (PST)
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
Subject: [net-next PATCH 11/14] net: phy: at803x: make specific status mask more generic
Date:   Wed, 29 Nov 2023 03:12:16 +0100
Message-Id: <20231129021219.20914-12-ansuelsmth@gmail.com>
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

Rework specific status masks to be more generic and drop checking
PHY ID in read_specific_status.

The function now takes an additional arg where the speed mask is passed
and then extracted from the AT803X_SPECIFIC_STATUS reg.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 32f44ef9835b..c6aa31495324 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -301,6 +301,11 @@ static struct at803x_hw_stat qca83xx_hw_stats[] = {
 	{ "eee_wake_errors", 0x16, GENMASK(15, 0), MMD},
 };
 
+struct at803x_ss_mask {
+	u16 speed_mask;
+	u8 speed_shift;
+};
+
 struct qca83xx_priv {
 	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
 };
@@ -900,7 +905,8 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
-static int at803x_read_specific_status(struct phy_device *phydev)
+static int at803x_read_specific_status(struct phy_device *phydev,
+				       struct at803x_ss_mask ss_mask)
 {
 	int ss;
 
@@ -919,11 +925,8 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 		if (sfc < 0)
 			return sfc;
 
-		/* qca8081 takes the different bits for speed value from at803x */
-		if (phydev->drv->phy_id == QCA8081_PHY_ID)
-			speed = FIELD_GET(QCA808X_SS_SPEED_MASK, ss);
-		else
-			speed = FIELD_GET(AT803X_SS_SPEED_MASK, ss);
+		speed = ss & ss_mask.speed_mask;
+		speed >>= ss_mask.speed_shift;
 
 		switch (speed) {
 		case AT803X_SS_SPEED_10:
@@ -967,6 +970,7 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 
 static int at803x_read_status(struct phy_device *phydev)
 {
+	struct at803x_ss_mask ss_mask = { 0 };
 	int err, old_link = phydev->link;
 
 	/* Update the link, but return if there was an error */
@@ -987,7 +991,9 @@ static int at803x_read_status(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	err = at803x_read_specific_status(phydev);
+	ss_mask.speed_mask = AT803X_SS_SPEED_MASK;
+	ss_mask.speed_shift = __bf_shf(AT803X_SS_SPEED_MASK);
+	err = at803x_read_specific_status(phydev, ss_mask);
 	if (err < 0)
 		return err;
 
@@ -1960,6 +1966,7 @@ static int qca808x_config_init(struct phy_device *phydev)
 
 static int qca808x_read_status(struct phy_device *phydev)
 {
+	struct at803x_ss_mask ss_mask = { 0 };
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
@@ -1973,7 +1980,10 @@ static int qca808x_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = at803x_read_specific_status(phydev);
+	/* qca8081 takes the different bits for speed value from at803x */
+	ss_mask.speed_mask = QCA808X_SS_SPEED_MASK;
+	ss_mask.speed_shift = __bf_shf(QCA808X_SS_SPEED_MASK);
+	ret = at803x_read_specific_status(phydev, ss_mask);
 	if (ret < 0)
 		return ret;
 
-- 
2.40.1

