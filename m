Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA080000F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbjLAAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377393AbjLAAPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3C1711;
        Thu, 30 Nov 2023 16:14:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3316a4bc37dso1371376f8f.2;
        Thu, 30 Nov 2023 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389696; x=1701994496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyfugPgXL8moAZoSDe7LFzttEirMMzMWF2wGXHc3eNQ=;
        b=I92BYbQt11nmjugpTzr3xobap8MLBZXQFFi1Q/krW0HrQmXDYYapjYX9PR+Mnva6GV
         wuoXvyZwAbKlYC9s74DUEGNDZTa8KXOkS82HWNg/nSbZd4HsBpktgjNm4IPg3670jsCo
         JVMht8AEmTU+tfFYmdgGP25K8ApD+EhW/Nm7UhpFsZwophh5K4GCGuvqoUfBEJcWFxpg
         ZjJkxXOUr1AeCrMIrt963U+kLB2k4YsT1drQossEWd7FdLkeE2J+In+Tmj6TaUZtTsmA
         rWcfaziay5HrK1sU/cCMpcDuKY5e4m3lG6ZA1dFYSiZUED3BN2HmFDN/lUjGdPhO1uzB
         Iwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389696; x=1701994496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyfugPgXL8moAZoSDe7LFzttEirMMzMWF2wGXHc3eNQ=;
        b=mMkV/8tgIpvlicSIbMWqoh2YjCNgiyQAhnbdqcyGeT41oVz9G4OX+sgPHWyMxKAZ/b
         Bz5aO+snsfAl0r+e2eZhbaZgRQVIb393A3NdsWzlpMGUlLUDcU37bt6FV1mTU5dlUbJ1
         z++Z2Qdr38KMPzADHDQ5myehQFs2b00wSlK3uhZqBnCo9jZ2LMKSmyiE/MguFjZBeoaT
         To5LzaFj3bPGxyym8+hVocm1YeDLwZgsC+AfAhAQbqkoBz4RQ2a1A5TOTXzVZ7MwSNDP
         UKKKyQakrBjY8DuzkDlYSJI7/J96ssvOgeVQRuRcl/xhg0zhS0NhtsgeN4XWFKRvkjCN
         GqDw==
X-Gm-Message-State: AOJu0YznwwXdKgnT21plvZ4cmylbEmEOHqiy0r6rRL6iAhyJvk9oBXif
        qWoNpW++QF1zyUsFZD8KVfE=
X-Google-Smtp-Source: AGHT+IEosLSz9FcHXEmvXqUs+yc7kn9BV6mri4XzGmeUozj7pjESzgrCevNusOQqzK6MlrQjzn/u9w==
X-Received: by 2002:adf:a195:0:b0:333:2fd2:4ae0 with SMTP id u21-20020adfa195000000b003332fd24ae0mr225872wru.92.1701389695912;
        Thu, 30 Nov 2023 16:14:55 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:55 -0800 (PST)
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
Subject: [net-next PATCH v2 07/12] net: phy: at803x: move specific at8031 config_init to dedicated function
Date:   Fri,  1 Dec 2023 01:14:17 +0100
Message-Id: <20231201001423.20989-8-ansuelsmth@gmail.com>
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

Move specific at8031 config_init to dedicated function to make
at803x_config_init more generic and tidy things up.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 45 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index ed3be7ed5463..02ac71f98466 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -951,27 +951,8 @@ static int at803x_hibernation_mode_config(struct phy_device *phydev)
 
 static int at803x_config_init(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		/* Some bootloaders leave the fiber page selected.
-		 * Switch to the appropriate page (fiber or copper), as otherwise we
-		 * read the PHY capabilities from the wrong page.
-		 */
-		phy_lock_mdio_bus(phydev);
-		ret = at803x_write_page(phydev,
-					priv->is_fiber ? AT803X_PAGE_FIBER :
-							 AT803X_PAGE_COPPER);
-		phy_unlock_mdio_bus(phydev);
-		if (ret)
-			return ret;
-
-		ret = at8031_pll_config(phydev);
-		if (ret < 0)
-			return ret;
-	}
-
 	/* The RX and TX delay default is:
 	 *   after HW reset: RX delay enabled and TX delay disabled
 	 *   after SW reset: RX delay enabled, while TX delay retains the
@@ -1606,6 +1587,30 @@ static int at8031_probe(struct phy_device *phydev)
 	return ret;
 }
 
+static int at8031_config_init(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	int ret;
+
+	/* Some bootloaders leave the fiber page selected.
+	 * Switch to the appropriate page (fiber or copper), as otherwise we
+	 * read the PHY capabilities from the wrong page.
+	 */
+	phy_lock_mdio_bus(phydev);
+	ret = at803x_write_page(phydev,
+				priv->is_fiber ? AT803X_PAGE_FIBER :
+						 AT803X_PAGE_COPPER);
+	phy_unlock_mdio_bus(phydev);
+	if (ret)
+		return ret;
+
+	ret = at8031_pll_config(phydev);
+	if (ret < 0)
+		return ret;
+
+	return at803x_config_init(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2115,7 +2120,7 @@ static struct phy_driver at803x_driver[] = {
 	.name			= "Qualcomm Atheros AR8031/AR8033",
 	.flags			= PHY_POLL_CABLE_TEST,
 	.probe			= at8031_probe,
-	.config_init		= at803x_config_init,
+	.config_init		= at8031_config_init,
 	.config_aneg		= at803x_config_aneg,
 	.soft_reset		= genphy_soft_reset,
 	.set_wol		= at803x_set_wol,
-- 
2.40.1

