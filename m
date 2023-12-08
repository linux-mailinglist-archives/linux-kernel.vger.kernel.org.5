Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B096280A643
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574066AbjLHOyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574114AbjLHOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:53:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BD1BE8;
        Fri,  8 Dec 2023 06:52:12 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so25400185e9.0;
        Fri, 08 Dec 2023 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047130; x=1702651930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3CRHE2JlPJvxR2z8QlM71Lcm2zabL9cZ1I1qY4IDPc=;
        b=grGzUsrqvep430CEdV8YFprBx8rmBxEQNtfiXKP+2a2KYEJke2JxqQnWttFRy4Katn
         X+K0aCsVsW+J4OdeyExEPOKtlg+Bl7Uib1q68k9EpSxW7r+C8UPbZeC8ThJGZBVp+T4x
         hPY3TbAud7vIfXGs81qpSkRPXMPXH1YD0NFvIVYTXQAQqJXUVi1a4ndZ4bzdyhK1lGbq
         dEU59m0q+I8CGqyHZD9+xFzFQ9BnLr6HgdrZVyik6WvLO5GDla3Z5fQyiuRWJJhhLKgb
         W929lcbzmZ8tgSdOLlzD3oElkNd+j89JA0doNygzLDTRsQux27hhco27DohNSog3ixsr
         +mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047130; x=1702651930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3CRHE2JlPJvxR2z8QlM71Lcm2zabL9cZ1I1qY4IDPc=;
        b=AW1Rfj7PnmSTQ4wmLEYrJTmSZZlHH/iYgQWs0XZpSiuzRUBKFm0BZr1QUg/WYVNbOm
         8ENqGLXgr9IrbqUNtC19dafMfLXVN+auVMHhEXbFKdy3Q2tA2kbK4jwSDbQVv6169vQN
         Bkxl2RpoZ1JRA+ljF6kJ4YHC5J3PJNoZmL7E4R0Hy++Q59nRufSTr5EKwQPOemMpARgX
         TmaqTKRGYlgJHy1EUp/z4JlTHrxQF4vNXZ6HiZgzzkHc6HFQiU8t7lnxOaCf4PJl2N64
         fYEWiid3JR0lZQHUrs/2fjlt3OXnYItotH+27jMwTxWgDE9nGfBCxhNxAcff0qcHxP2k
         PiAg==
X-Gm-Message-State: AOJu0YxTxi2/tXl+yI+uFbH5z3UxzzFRMb905tZw9RiC71p4ogakcdXh
        CBvGzsrbWiiW7IGGMBMz+A8=
X-Google-Smtp-Source: AGHT+IE+Sl9uvm0eP7FJUHY58vaObqFyBtRzEdpfIkIq3tIEwLcDaQIduGUVkPvMv8tYJtW2m6NOnA==
X-Received: by 2002:a7b:cd12:0:b0:40c:3742:5a3 with SMTP id f18-20020a7bcd12000000b0040c374205a3mr27161wmj.256.1702047130293;
        Fri, 08 Dec 2023 06:52:10 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:09 -0800 (PST)
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
Subject: [net-next PATCH v4 03/13] net: phy: at803x: raname hw_stats functions to qca83xx specific name
Date:   Fri,  8 Dec 2023 15:51:50 +0100
Message-Id: <20231208145200.25162-4-ansuelsmth@gmail.com>
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

The function and the struct related to hw_stats were specific to qca83xx
PHY but were called following the convention in the driver of calling
everything with at803x prefix.

To better organize the code, rename these function a more specific name
to better describe that they are specific to 83xx PHY family.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b8f3c215d0e8..277a6c27af7c 100644
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
@@ -2175,9 +2175,9 @@ static struct phy_driver at803x_driver[] = {
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
@@ -2191,9 +2191,9 @@ static struct phy_driver at803x_driver[] = {
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
@@ -2207,9 +2207,9 @@ static struct phy_driver at803x_driver[] = {
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

