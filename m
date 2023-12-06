Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86978807CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjLGAAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441899AbjLGAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB831D44;
        Wed,  6 Dec 2023 16:00:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c19467a63so4251385e9.3;
        Wed, 06 Dec 2023 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907221; x=1702512021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z3Xda0RnvaE2hW0I0S04OmD8rJgdjIJIqIdkvOJgVw=;
        b=LGIu+u4L6kkzX+UonEB482yBXGJyLkqQGE7twT9R0+TCNNeBKMSZrLstviiAcO14Y2
         lDU/7++jreiUHeHrShcTxzuslViACKBOOky9VblNKlrgffMZtB0qs+Bh7g0Iv2ZT2ioP
         d2ULVUdgpu0pqt3f/TE9IJe5Fd2RLhje4grS62Qz2djNZfUgKlUincg4xjcMTc+/kuXM
         LrPZl7ijGniCUI2E3mPGKhFHei/NT+yWvIaEB86RmEcPqrXl5o6yqYYp9r29vM6MetgS
         Klu5YGURde8Wt30LibL14yowv9USc8PzVKHS1sUMECJh4bgen9Ow0xkz6dDdldOcPBpz
         1yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907221; x=1702512021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z3Xda0RnvaE2hW0I0S04OmD8rJgdjIJIqIdkvOJgVw=;
        b=eiJrtzV5kUtzezh6/DeTYXKa8VrhKuitDp4I6LrlWVsZ2BLnTRUF9QVVVt8Xrqi5ks
         QICkMc1Pz2Zw/XrHIDVkRz3AjyRFiro5/KFOB7G4Paht73EpQ52h6CpRQPWvoKhP1NhA
         IVRl53P45MLkxZiEtWe07NE9+3O1fRyvpHylnm0tWmy0hzR9HYeaeezQ4FwuPOJykaXu
         mk8U95i3a26mX1ZxErUWjrIZ92KiIVfx69TZ6o9/XzT+Y/gsbKqhwBnwuV+m/fMjFnJe
         bfC+otMeV2RlfPhQJhnqqDM7LQH8iTqMCDNAUoe0bmf5nbjwPOUBm73fynQ2APWdIUD4
         EP/w==
X-Gm-Message-State: AOJu0YwrbBrIVm7Ecgbk0F+2JcHBTSBRot0iFHv1UE5spEZ3Ukr3x0eO
        0zUnVK2tCstJBWQ5Hs8Pk/s=
X-Google-Smtp-Source: AGHT+IE0wMmw7bejA/8riUbIYNofsnvAKMasY9YgFVq/lnR8XE5cpEMMgyBYkpAUkieACrrFc1LGxw==
X-Received: by 2002:a05:600c:444e:b0:40b:5e21:ec13 with SMTP id v14-20020a05600c444e00b0040b5e21ec13mr1037512wmn.69.1701907221286;
        Wed, 06 Dec 2023 16:00:21 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:21 -0800 (PST)
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
Subject: [net-next PATCH v3 05/13] net: phy: at803x: move specific DT option for at8031 to specific probe
Date:   Thu,  7 Dec 2023 00:57:20 +0100
Message-Id: <20231206235728.6985-6-ansuelsmth@gmail.com>
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

Move specific DT options for at8031 to specific probe to tidy things up
and make at803x_parse_dt more generic.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

