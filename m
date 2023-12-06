Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E9807CEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442936AbjLGABU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441866AbjLGAA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3366310C8;
        Wed,  6 Dec 2023 16:00:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso8433535e9.0;
        Wed, 06 Dec 2023 16:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907231; x=1702512031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJTYW3+VwtWQ9mxnVIQxaCRT7NyQ9rnqwM6rkDrYRts=;
        b=T6CsprVeOX9+SOx8MQkMZlDpoLUxczaqIlSLp7b6R3cynC9Q62BS2drX97Ic41CUaH
         hgqy8Y6RC8S536RAFwdNd+BNhP6oV/aS+JoOkkLSAZponhMFdNifkq/ltmFiMnY5tp1Z
         XTQXoADi13GN2xBUYrsjYZXUiJqaXiBey/nUTH/q4WrftkQZLN3eXdCRKxyq6xkVvuJ8
         mGylMtFljUKTVG9K0lLbHrerzKee5PzyL7WisPjnVeQu2cjxG/Lg9JXwHIj74VgiSbv+
         PjTw9I1cn0jyP2UkQoVKxEMMK+rx0DxdtMfXQGFjDQRmQZ28xIgUkLJtM9TENb9STphk
         Bn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907231; x=1702512031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJTYW3+VwtWQ9mxnVIQxaCRT7NyQ9rnqwM6rkDrYRts=;
        b=gDATlOpp63izFO1AJfkyjufIdr5yX0VGpl4WSaPbXVeiAY8oIdlo98Eq0wmTDUhTC3
         nt8CCs1ChzbbtSeaIfy469rfsxCb+OAb78iPC3HX13/uJPL/2hHcgGBMv99XwSJHBvLG
         huYgslgKuV2yxVGaKsukxfrBfdfBCjZSd8j6sccQuyu3lMZ9NlHfeanhdptUPEgqc8i7
         uVN+tX/R44qIFvBbBE3kmGdFNVd3fpenYJn721/E8l1mU6tJyk5TFHJKryizzNHXZD2R
         p+a4zoKxaGhZOCKAudJYh/QUPlM5zu9PC8Rwuyist/syRtwUAw9QqNlZktN59SffmjLi
         Cd/Q==
X-Gm-Message-State: AOJu0YyZA/dar75Tft6HmCZJddfJ9xgDKjlciZz7e77sB2AXi6zyy17j
        Ie2KG0thqC5ovdObKxJOjo8=
X-Google-Smtp-Source: AGHT+IF8gdaNJ9L9K4O2YOFIskp+7zLtmxdNlcPLSbqVvjdxAfv8mfM4KrjvKogUh6rBKo20oGoYTQ==
X-Received: by 2002:a05:600c:4f07:b0:40b:5e4a:233f with SMTP id l7-20020a05600c4f0700b0040b5e4a233fmr2176639wmq.65.1701907231466;
        Wed, 06 Dec 2023 16:00:31 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:31 -0800 (PST)
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
Subject: [net-next PATCH v3 12/13] net: phy: at803x: move at8035 specific DT parse to dedicated probe
Date:   Thu,  7 Dec 2023 00:57:27 +0100
Message-Id: <20231206235728.6985-13-ansuelsmth@gmail.com>
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

Move at8035 specific DT parse for clock out frequency to dedicated probe
to make at803x probe function more generic.

This is to tidy code and no behaviour change are intended.

Detection logic is changed, we check if the clk 25m mask is set and if
it's not zero, we assume the qca,clk-out-frequency property is set.

The property is checked in the generic at803x_parse_dt called by
at803x_probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/at803x.c | 60 +++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 73d1a5e29202..27dc0a9ca076 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -638,23 +638,6 @@ static int at803x_parse_dt(struct phy_device *phydev)
 
 		priv->clk_25m_reg |= FIELD_PREP(AT803X_CLK_OUT_MASK, sel);
 		priv->clk_25m_mask |= AT803X_CLK_OUT_MASK;
-
-		/* Fixup for the AR8030/AR8035. This chip has another mask and
-		 * doesn't support the DSP reference. Eg. the lowest bit of the
-		 * mask. The upper two bits select the same frequencies. Mask
-		 * the lowest bit here.
-		 *
-		 * Warning:
-		 *   There was no datasheet for the AR8030 available so this is
-		 *   just a guess. But the AR8035 is listed as pin compatible
-		 *   to the AR8030 so there might be a good chance it works on
-		 *   the AR8030 too.
-		 */
-		if (phydev->drv->phy_id == ATH8030_PHY_ID ||
-		    phydev->drv->phy_id == ATH8035_PHY_ID) {
-			priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
-			priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;
-		}
 	}
 
 	ret = of_property_read_u32(node, "qca,clk-out-strength", &strength);
@@ -1637,6 +1620,45 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+static int at8035_parse_dt(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+
+	/* Mask is set by the generic at803x_parse_dt
+	 * if property is set. Assume property is set
+	 * with the mask not zero.
+	 */
+	if (priv->clk_25m_mask) {
+		/* Fixup for the AR8030/AR8035. This chip has another mask and
+		 * doesn't support the DSP reference. Eg. the lowest bit of the
+		 * mask. The upper two bits select the same frequencies. Mask
+		 * the lowest bit here.
+		 *
+		 * Warning:
+		 *   There was no datasheet for the AR8030 available so this is
+		 *   just a guess. But the AR8035 is listed as pin compatible
+		 *   to the AR8030 so there might be a good chance it works on
+		 *   the AR8030 too.
+		 */
+		priv->clk_25m_reg &= AT8035_CLK_OUT_MASK;
+		priv->clk_25m_mask &= AT8035_CLK_OUT_MASK;
+	}
+
+	return 0;
+}
+
+/* AR8030 and AR8035 shared the same special mask for clk_25m */
+static int at8035_probe(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = at803x_probe(phydev);
+	if (ret)
+		return ret;
+
+	return at8035_parse_dt(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2109,7 +2131,7 @@ static struct phy_driver at803x_driver[] = {
 	PHY_ID_MATCH_EXACT(ATH8035_PHY_ID),
 	.name			= "Qualcomm Atheros AR8035",
 	.flags			= PHY_POLL_CABLE_TEST,
-	.probe			= at803x_probe,
+	.probe			= at8035_probe,
 	.config_aneg		= at803x_config_aneg,
 	.config_init		= at803x_config_init,
 	.soft_reset		= genphy_soft_reset,
@@ -2130,7 +2152,7 @@ static struct phy_driver at803x_driver[] = {
 	.phy_id			= ATH8030_PHY_ID,
 	.name			= "Qualcomm Atheros AR8030",
 	.phy_id_mask		= AT8030_PHY_ID_MASK,
-	.probe			= at803x_probe,
+	.probe			= at8035_probe,
 	.config_init		= at803x_config_init,
 	.link_change_notify	= at803x_link_change_notify,
 	.set_wol		= at803x_set_wol,
-- 
2.40.1

