Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E298800019
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377528AbjLAAPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377466AbjLAAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:15:09 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB11981;
        Thu, 30 Nov 2023 16:15:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-333308c3683so131198f8f.3;
        Thu, 30 Nov 2023 16:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701389700; x=1701994500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i12Gu+wY1CypxJPzomZzPt1KEPWiDTFBh+rmjVLvo38=;
        b=bT3b7giLwZKBWt200a+53yO984RsbHnFC4N+s2Eh/tR+xviHSbC57cZ8OpuXZ1wSA+
         8KaIx4BQqTdiCUitQciHfXc6wkBy0r5w17lyXU0gmMA+dJGyfG1gH7sNDjZMN5fP8/MN
         /iDLd9IFMIBFGuVkRXzHdsiMeCRidRMYnqtzTMTTKKgcX9UmEx4VfV7zKPWSmAO8nBtB
         BUQADlN/MJ1hXzFZjhWgwIvaI8uOplQGm41WbCqzmrxUl/BWmLJEAitVkvaJn2IYNjHZ
         RpczfCwPLSbhxjqfacSDti9RrLPy+zIlo4N16fcKcfcD/kAGUBAjFCNXMX1LZsCt9dZt
         82IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701389700; x=1701994500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i12Gu+wY1CypxJPzomZzPt1KEPWiDTFBh+rmjVLvo38=;
        b=ms8h2pSwWFQl0uEahISUe4CZnYW1lYgxjnrc+/MbdiVeakJ5ySFafbMibhCiGvzbqi
         WMwkA1mvX4hUDtRCYKha0sNxH8a8xuDSZpumuWzi9au6sQ/eEpgIKBeu13lqvLnzW6/T
         L8bwgMDmqn/QBGoFny1W7il1FJPehos7yNcyv4yTveNpwOnaOliEskwAUhNeQ5XYJppk
         ZIH8LZ0aMav6h6xXqNRTcM0aIe6OB4zY5Gqi51Kyu6CwMWZBQL1JITSWpRcgarFZFpHW
         iZ+6JUrWxaPocwBXPkMblso6HdRr+T2LOAgRRWIq4ZyceWY+wNgK+9gfe/fmZ4vtr4L4
         c1xg==
X-Gm-Message-State: AOJu0YxEej46lcIpM7V1S3aturIn1eWnJd3NIrqel7lOKU+a9uvdI4F/
        M7GzUD7d64GYPz368f3zL40=
X-Google-Smtp-Source: AGHT+IF9kRgqpd1LwyGLGxl7zWAJ0wi4B4i2Ez0CAfxVHmO8pUWwHq9gI1vc2UauLxF/Rq7lc5WAQA==
X-Received: by 2002:a5d:484b:0:b0:333:1a1c:50f5 with SMTP id n11-20020a5d484b000000b003331a1c50f5mr135853wrs.62.1701389699724;
        Thu, 30 Nov 2023 16:14:59 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm3535457wmq.14.2023.11.30.16.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 16:14:59 -0800 (PST)
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
Subject: [net-next PATCH v2 11/12] net: phy: at803x: move at8035 specific DT parse to dedicated probe
Date:   Fri,  1 Dec 2023 01:14:21 +0100
Message-Id: <20231201001423.20989-12-ansuelsmth@gmail.com>
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

Move at8035 specific DT parse for clock out frequency to dedicated probe
to make at803x probe function more generic.

This is to tidy code and no behaviour change are intended.

Detection logic is changed, we check if the clk 25m mask is set and if
it's not zero, we assume the qca,clk-out-frequency property is set.

The property is checked in the generic at803x_parse_dt called by
at803x_probe.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
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

