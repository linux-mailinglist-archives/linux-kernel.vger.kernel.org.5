Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCC80000C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377461AbjLAAPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377445AbjLAAPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786CD170B;
        Thu, 30 Nov 2023 16:14:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40838915cecso14649305e9.2;
        Thu, 30 Nov 2023 16:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389695; x=1701994495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtJoPBjW5rnAlurZq2lS+01nGhFNdESFfyXMasseLeU=;
        b=FB0oQb9mVqUxKEVx96/3Qm3mtA1Y5bC7DPqP8yRdIO9kQDCRy6dm/qQl8x0T4XUlD5
         EE8PJnVJgM/nEO31NVeq1FfPH713Tpk+JATlggS1vCdKlxPF+2tK7YcufyG9gJZD9zv6
         2jnB2WYxT6CG8mqb0MjlCkgIXJ5kLRhqTt+Oqacx3KzixSNdD5PqyxHS60jNiifjQ06Q
         c2mM6iyoAZwHIpCxz17DjqTAtJ9wO1Hbsvn5Ns/sENw9EURxHO3bfZCZEOxOAj/CORTL
         CuSUWU31lqyJ2CEUodkxEIyerF2ifIK5tBPAVot6GTK656KLnjADRAjbptViz70yyqxz
         jUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389695; x=1701994495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtJoPBjW5rnAlurZq2lS+01nGhFNdESFfyXMasseLeU=;
        b=iTVvODyMqkDiQerDJW23HIXegAlcujLTjGEo/qfIX0PXWgMjJAx46vunT3AHfjlTNt
         KI22Q/25Q4XYI26Q1HLK58J3HRzwHDWFl2AYgx3wXYHPAPPKSiC3tFxxo8LArNEM4Tsb
         HktWSkN2p964mkPC2nXagY2KJE3gfCRIiphG9ypdoKOQZuW69ymuKwN9+Hbze94KbIvt
         xmoIp2aNCYeQlLKAJrSnt5OVz6MuLqaIlpepBpB/siDCqmBAYmNHWrWYSprY2is0YWVJ
         ck4kpbwigVA2FxTgtxSARlxenCy8NgUay0zX8yn1ob8oBATU4iZjAqTz/EImfss5rUU+
         tGGQ==
X-Gm-Message-State: AOJu0YzainiCBz6WPedGAE1AgsGr37hQkHj6/ZZe2r+XuYaz0j7GFGOg
        R3HeDdLsLneDCPk4iK8GORg=
X-Google-Smtp-Source: AGHT+IGER/aOTMmXnZ8cjXz76atFClV0C1nOQoSqepbnmUoqgQMrj+AnCddPI7BGFZp6pAFI3ssCQQ==
X-Received: by 2002:a05:600c:2318:b0:40b:5e21:e274 with SMTP id 24-20020a05600c231800b0040b5e21e274mr110188wmo.97.1701389694743;
        Thu, 30 Nov 2023 16:14:54 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:54 -0800 (PST)
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
Subject: [net-next PATCH v2 06/12] net: phy: at803x: move specific at8031 probe mode check to dedicated probe
Date:   Fri,  1 Dec 2023 01:14:16 +0100
Message-Id: <20231201001423.20989-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201001423.20989-1-ansuelsmth@gmail.com>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
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

Move specific at8031 probe mode check to dedicated probe to make
at803x_probe more generic and keep code tidy.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index e507bf2c9bdd..ed3be7ed5463 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -844,26 +844,6 @@ static int at803x_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
-		int mode_cfg;
-
-		if (ccr < 0)
-			return ccr;
-		mode_cfg = ccr & AT803X_MODE_CFG_MASK;
-
-		switch (mode_cfg) {
-		case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
-		case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
-			priv->is_1000basex = true;
-			fallthrough;
-		case AT803X_MODE_CFG_FX100_RGMII_50OHM:
-		case AT803X_MODE_CFG_FX100_RGMII_75OHM:
-			priv->is_fiber = true;
-			break;
-		}
-	}
-
 	return 0;
 }
 
@@ -1584,6 +1564,9 @@ static int at8031_parse_dt(struct phy_device *phydev)
 
 static int at8031_probe(struct phy_device *phydev)
 {
+	struct at803x_priv *priv = phydev->priv;
+	int mode_cfg;
+	int ccr;
 	int ret;
 
 	ret = at803x_probe(phydev);
@@ -1597,6 +1580,22 @@ static int at8031_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
+	if (ccr < 0)
+		return ccr;
+	mode_cfg = ccr & AT803X_MODE_CFG_MASK;
+
+	switch (mode_cfg) {
+	case AT803X_MODE_CFG_BX1000_RGMII_50OHM:
+	case AT803X_MODE_CFG_BX1000_RGMII_75OHM:
+		priv->is_1000basex = true;
+		fallthrough;
+	case AT803X_MODE_CFG_FX100_RGMII_50OHM:
+	case AT803X_MODE_CFG_FX100_RGMII_75OHM:
+		priv->is_fiber = true;
+		break;
+	}
+
 	/* Disable WoL in 1588 register which is enabled
 	 * by default
 	 */
-- 
2.40.1

