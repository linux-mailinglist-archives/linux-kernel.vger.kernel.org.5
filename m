Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE6807CD5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441840AbjLGABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjLGAAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A869ED62;
        Wed,  6 Dec 2023 16:00:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso8433275e9.0;
        Wed, 06 Dec 2023 16:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701907227; x=1702512027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYf/4x1S6Xi4qxCbsW/ZhILQxOYsjDvuEIJRKEsMK/k=;
        b=RBFiFxZvRRQzYOeDmuZrldz20PDWn4DKI+awAiIwtSUPIn+npVFpkMfV6EJTA64Be8
         lWCqjQ0JcxrnFn8k+VkgYeYrJuKPuH6GCh+0o3gSSrWzSPaNPIraOiag/+0JZm6gFGsn
         YmK5QhTgCR12YFdKI8joW6Unxk02n7Ji7jXoCO/1hQrrz3TjkG71rg0Nfn2RXGCfr4Ih
         GgrMRaJHPMNRsaPEi/HFMRc0nON9bC41GAJ5PC4R5QZUi0TM7M87W+MLJebPKgvo5aSQ
         mXjhneK2mcP6QsY/GbzUemVBhow/lKmmAmqU6xXt8XJUWWYpNzLAL53ugTdhqzAqsjrM
         XErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907227; x=1702512027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYf/4x1S6Xi4qxCbsW/ZhILQxOYsjDvuEIJRKEsMK/k=;
        b=DZT4henzxJ6aIPI+LqOyx1qaue9OF6sC7eSh2DED7ejjZE2X7DN5TAkG8TBt2DPlnd
         gP+njGBzyKThOEnY9aq5hmhGKO+cOoxtFBjWfcrNEsMMiLxdBpNQ0lQSubR4g6r6cfvl
         m965c2+nrpAsSrjGkXhns3F9RrBWTkJKIynjpgBh8dNu98S4hcTcG0/q+SCQQHpAKlb4
         O5SvcOL3VCxTR+TTLyvGAYCm8z2beqZiOOq7eq2vjtrZsjwyVB8SD7snT552qcNcx2pS
         T49qWzi10TjohX2SS2bA9UbYIiFOEf65kIAxu5yiXlH1Dt6VUSCbuVWfMCfLx6PNl6gp
         gS3w==
X-Gm-Message-State: AOJu0YwGhzZtjEz0c0pPDlU2mbpRXlXLKqZ5G15rSXtBMoeuZAg+Ip+Z
        8izACVpKVnSRlh/ubVd6hYo=
X-Google-Smtp-Source: AGHT+IElsDJmDetQs/EdK0OPQeUrb6dsfr3O805FFpJ7oprp00YCThosfXR+HgRJpzu3BY5wA2GFWg==
X-Received: by 2002:a7b:ce08:0:b0:40b:5e56:7b67 with SMTP id m8-20020a7bce08000000b0040b5e567b67mr2141779wmc.176.1701907227032;
        Wed, 06 Dec 2023 16:00:27 -0800 (PST)
Received: from localhost.localdomain (host-79-26-252-6.retail.telecomitalia.it. [79.26.252.6])
        by smtp.googlemail.com with ESMTPSA id je16-20020a05600c1f9000b00405442edc69sm50280wmb.14.2023.12.06.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:00:26 -0800 (PST)
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
Subject: [net-next PATCH v3 09/13] net: phy: at803x: move specific at8031 config_intr to dedicated function
Date:   Thu,  7 Dec 2023 00:57:24 +0100
Message-Id: <20231206235728.6985-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206235728.6985-1-ansuelsmth@gmail.com>
References: <20231206235728.6985-1-ansuelsmth@gmail.com>
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

Move specific at8031 config_intr bits to dedicated function to make
at803x_config_initr more generic.

This is needed in preparation for PHY driver split as qca8081 share the
same function to setup interrupts.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 2de7a59c0faa..1897030667d9 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -990,7 +990,6 @@ static int at803x_ack_interrupt(struct phy_device *phydev)
 
 static int at803x_config_intr(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	int err;
 	int value;
 
@@ -1007,10 +1006,6 @@ static int at803x_config_intr(struct phy_device *phydev)
 		value |= AT803X_INTR_ENABLE_DUPLEX_CHANGED;
 		value |= AT803X_INTR_ENABLE_LINK_FAIL;
 		value |= AT803X_INTR_ENABLE_LINK_SUCCESS;
-		if (priv->is_fiber) {
-			value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
-			value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
-		}
 
 		err = phy_write(phydev, AT803X_INTR_ENABLE, value);
 	} else {
@@ -1619,6 +1614,29 @@ static int at8031_set_wol(struct phy_device *phydev,
 	return ret;
 }
 
+static int at8031_config_intr(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+	int err, value = 0;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED &&
+	    priv->is_fiber) {
+		/* Clear any pending interrupts */
+		err = at803x_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		value |= AT803X_INTR_ENABLE_LINK_FAIL_BX;
+		value |= AT803X_INTR_ENABLE_LINK_SUCCESS_BX;
+
+		err = phy_set_bits(phydev, AT803X_INTR_ENABLE, value);
+		if (err)
+			return err;
+	}
+
+	return at803x_config_intr(phydev);
+}
+
 static int qca83xx_config_init(struct phy_device *phydev)
 {
 	u8 switch_revision;
@@ -2139,7 +2157,7 @@ static struct phy_driver at803x_driver[] = {
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
 	.read_status		= at803x_read_status,
-	.config_intr		= at803x_config_intr,
+	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
 	.set_tunable		= at803x_set_tunable,
-- 
2.40.1

