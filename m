Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE965800009
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377438AbjLAAO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377413AbjLAAOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:14:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8897F10FA;
        Thu, 30 Nov 2023 16:14:55 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b4c2ef584so13633705e9.3;
        Thu, 30 Nov 2023 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389694; x=1701994494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeuD35kl9OZh7RWQWxD6o92Iwh3LhKseRWsjP+na1qo=;
        b=h5dEEg5pyfWLVWC4z2wap13deccfUxkwFEfdPVWUzm44uR+SRG9XQVA3tHXeCv0qzf
         nZ278Q8lAt6ZNP4phwWosuvl1z3DZGmd74MmV3K6XCHmemYd7qvgTbEMlEfugPdr6dRT
         m9W7x/STcixl3DSVpluZJZ0I2V98CW2PUX0Y/OgmpuYRtudyQl9CnLGmB5RFewGyKkd6
         iwU3a8r0PDv1aCgA0VIUcPIYlAcxRDVVMWyVxdxdsIvsVkTY8jxxpiuIll19+PBuWodW
         D3O39S/yrz+xOA/eStWdjzU3zFtcC4OeeFQrHs8VYATi9N0hEQF8o4jEke43Y1w5qiOY
         9XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389694; x=1701994494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeuD35kl9OZh7RWQWxD6o92Iwh3LhKseRWsjP+na1qo=;
        b=jZVzVj8kcluJnI5Eb8LkDGMstl6ncGw8JGsM1jiI7Y39AtaBwJvs4sPFy5HpGro/YO
         EQ+xqmiY99/YU3n93MyfdbGHFFHgMFzjGi0H4jOKDyzDvh8OsAOhi7WmAXJtfHTf0jyX
         eRVZ1Pm9qDYkwn69tRZe7S70x5J2LwsV8wDlAOpG+8V/VQEgxYPC5c3s1B/uu2OY13KV
         zj7q3UePwTeEv/BOC+s1pR3My8jpIBNxZ9JtkXF7aLMjinpix13plkFG4xeqUd9+39PW
         vq4fFnfJ9+EJkfkJ78VBgS6PHSrqAk56FwbZlpdxewz8+y8U5iJ2Xpn2bEyUqsZLcwBS
         paxg==
X-Gm-Message-State: AOJu0YykSZFMfSSfQuGFD9Ee/c1+j0HuCUd61Pl+lYPMZppTNyJ5gGVN
        7rxlWg9vX2VgCK3iZPGH71JxaWjxP3o=
X-Google-Smtp-Source: AGHT+IEBRRVimWr3edmybQopZ8UmEyOSDIxM9h9RhFK8eSX8a7oFmQMQw0Fpaa/hu/vvYrmBXIMRbA==
X-Received: by 2002:a05:600c:4f0d:b0:40b:5e22:95d with SMTP id l13-20020a05600c4f0d00b0040b5e22095dmr187662wmq.76.1701389693826;
        Thu, 30 Nov 2023 16:14:53 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:53 -0800 (PST)
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
Subject: [net-next PATCH v2 05/12] net: phy: at803x: move specific DT option for at8031 to specific probe
Date:   Fri,  1 Dec 2023 01:14:15 +0100
Message-Id: <20231201001423.20989-6-ansuelsmth@gmail.com>
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

Move specific DT options for at8031 to specific probe to tidy things up
and make at803x_parse_dt more generic.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 779e0835fa5d..e507bf2c9bdd 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -825,30 +825,6 @@ static int at803x_parse_dt(struct phy_device *phydev)
 		}
 	}
 
-	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
-	 * options.
-	 */
-	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
-		if (of_property_read_bool(node, "qca,keep-pll-enabled"))
-			priv->flags |= AT803X_KEEP_PLL_ENABLED;
-
-		ret = at8031_register_regulators(phydev);
-		if (ret < 0)
-			return ret;
-
-		ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
-							 "vddio");
-		if (ret) {
-			phydev_err(phydev, "failed to get VDDIO regulator\n");
-			return ret;
-		}
-
-		/* Only AR8031/8033 support 1000Base-X for SFP modules */
-		ret = phy_sfp_probe(phydev, &at803x_sfp_ops);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -1582,6 +1558,30 @@ static int at803x_cable_test_start(struct phy_device *phydev)
 	return 0;
 }
 
+static int at8031_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct at803x_priv *priv = phydev->priv;
+	int ret;
+
+	if (of_property_read_bool(node, "qca,keep-pll-enabled"))
+		priv->flags |= AT803X_KEEP_PLL_ENABLED;
+
+	ret = at8031_register_regulators(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_regulator_get_enable_optional(&phydev->mdio.dev,
+						 "vddio");
+	if (ret) {
+		phydev_err(phydev, "failed to get VDDIO regulator\n");
+		return ret;
+	}
+
+	/* Only AR8031/8033 support 1000Base-X for SFP modules */
+	return phy_sfp_probe(phydev, &at803x_sfp_ops);
+}
+
 static int at8031_probe(struct phy_device *phydev)
 {
 	int ret;
@@ -1590,6 +1590,13 @@ static int at8031_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* Only supported on AR8031/AR8033, the AR8030/AR8035 use strapping
+	 * options.
+	 */
+	ret = at8031_parse_dt(phydev);
+	if (ret)
+		return ret;
+
 	/* Disable WoL in 1588 register which is enabled
 	 * by default
 	 */
-- 
2.40.1

