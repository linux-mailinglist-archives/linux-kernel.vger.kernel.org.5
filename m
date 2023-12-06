Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F1807CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441903AbjLGAA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441907AbjLGAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A040D7D;
        Wed,  6 Dec 2023 16:00:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so4634715e9.0;
        Wed, 06 Dec 2023 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907224; x=1702512024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUKJ3W+rMNjz35Sa6zupf98XVAv1Y8sQonmYjlaTAA4=;
        b=hrcoXchFoSHDYwlCGgwosP9ICXBlpqE/4bHSv240xdP2uyHHrSNzhDzSdf1OhDDCDu
         gZ9VXqaysxf3Ms6tdibaDOmHQh97dCbSn0YkVzGUUFQ8pfmaI1hNaeqi/uOhiIWBg/IJ
         WIPED+4pEekYhbtd/Hffg7sAnA1ntesjYoenLeNc4mTl7JMMa27a1QxbLIOCwSPElAHO
         bUIIu9L4+wiyWJq+MR+cQNUuiqHXKupv2NXtKeiWll/C+5ZSf0vaFgTK0p2SK09+iKGx
         HrSST+k0hUUmHN57fRhvOvDnglm6hmGAE83D5uTdBooWR5MizQdoVLst3MTRfv+69o1B
         a5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907224; x=1702512024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUKJ3W+rMNjz35Sa6zupf98XVAv1Y8sQonmYjlaTAA4=;
        b=dWa6ttRMYTO66uODV7sMuo5DzEsbsu1b9+6InczU3/k6FNjPHq9WyhaIskH3VPlM83
         fP2toOFTrRWnCL7832kYLPJTHvnJYSu7qJeGaauwmLO4VR+zQ8a7H+TE3KLDghhcf+rv
         T12peUBW7QVDCRHNTDdwbkGddjT1R7SMQqYMU+A9FpLBmBzKhhSwitk6cuGlMByrB75F
         FVSKLdtqrQKo/PzSYDp2Yzp8omskl0eSK50eRVYB+FQl8JSaQYd1Eu1OuEQ+woCKPNmB
         iffynLtIe3i3rgnRP5dxuShHQgPix30m+Ioc4zfKLzv0ujia+BWdeR69hNL/BhCiP9mF
         h4Cw==
X-Gm-Message-State: AOJu0YxsJIcAz5C8PKBVoTxqXPzpe/MAbDs3p3eqoDCkhKF0CQVCfI8t
        4K7vuJqv0z/sWLpgyQQM2H4=
X-Google-Smtp-Source: AGHT+IGtX6xNTD954eyHj0z8r8TC/ZyeUdvYV40s2gQDr7eEQaqtO4Vf1IHtj4VNGg0LFoDRb85Jjw==
X-Received: by 2002:a1c:720c:0:b0:40c:25c1:3c02 with SMTP id n12-20020a1c720c000000b0040c25c13c02mr325178wmc.159.1701907224273;
        Wed, 06 Dec 2023 16:00:24 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:23 -0800 (PST)
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
Subject: [net-next PATCH v3 07/13] net: phy: at803x: move specific at8031 config_init to dedicated function
Date:   Thu,  7 Dec 2023 00:57:22 +0100
Message-Id: <20231206235728.6985-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

