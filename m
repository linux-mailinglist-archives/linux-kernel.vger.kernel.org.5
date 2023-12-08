Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7180A64F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574195AbjLHOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574056AbjLHOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:54:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0A3860;
        Fri,  8 Dec 2023 06:52:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c32df9174so8939985e9.3;
        Fri, 08 Dec 2023 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702047137; x=1702651937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ire9TzxrqfCVF6+oXacCtQAHi8rA2FHZhZNxfVwYUAk=;
        b=Fq+TVfSKYAxiWrGtf3VtEXuYgOLVOQnXZzmSlb3mM0CtUGBvP122/kcep7Vqb+bK4K
         oywyMa6xrbseYkeGLCWmXZ/lswNIsHswwifZ4eoqVxM138Gn46sG9FQ5DZZOG49VmvtW
         6UlME8F1fi3P/PJIAmC+vVqzr1M9+2Z2aOXZheSJoPjY3c9mgEUbUi2lUFtNQ1QSO0e7
         KErl4iKuWGTCeF5Z4IPTSiptNQygxgP3UubUBv5SVyfLa83sM9YAX7zzNL+Qb7/uRjIB
         HDu0MRh/NrDc2SCObA+k/8v+8QJ8Q4Ai6XM+ZvwssdYi48fDlABJ8GUhCnAWInl/Aj9x
         aTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047137; x=1702651937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ire9TzxrqfCVF6+oXacCtQAHi8rA2FHZhZNxfVwYUAk=;
        b=AS7cpmS6jtXPEJOWhYNdYRxcPGNOeBTsXf32VXTBxJkHY9GPGRTVGED4q4mVsSGFp7
         VE1crID2fQsBeh0n6vbtPJmPg9V+e18BLEP59UJZjEJGfjxUe22q2klcuJ8c98eEg0nl
         pAq63uEB5YrIOe5Jvvmzuj3iZ2d+7bz0apVgQhGfwCNCrB8j+dNfw5ID6eZDGYSHLEN/
         jh+MmIif4IUatxlbd5Ynr4Unmukm47NBJukvl+XuMlygsLPi5nvuteAUm2pvD25200/G
         A4LdoJaqNpw94BOEWahzIofotRWVJxjpUX00TRKOBePkhdkarFfJgRrQKwMUZd11KOpB
         UqDw==
X-Gm-Message-State: AOJu0YwwK6Nm0Aam9TQAVgPPSTrKZenyl5OxLHaqHam4BYIMEngD3ZsT
        Sy7dAYL8HuFV9tsr0jIcOF8=
X-Google-Smtp-Source: AGHT+IHZO6Lq0ydedpSvPcnC4aVvltxnvxW0gEH+xl+MUm4RczIy8vJ4hlqTYIQzk+x8F2slWOKQqg==
X-Received: by 2002:a1c:7c1a:0:b0:40b:5e21:c5b6 with SMTP id x26-20020a1c7c1a000000b0040b5e21c5b6mr30370wmc.132.1702047136938;
        Fri, 08 Dec 2023 06:52:16 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r9-20020a05600c458900b0040b3e79bad3sm3088264wmo.40.2023.12.08.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:52:16 -0800 (PST)
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
Subject: [net-next PATCH v4 09/13] net: phy: at803x: move specific at8031 config_intr to dedicated function
Date:   Fri,  8 Dec 2023 15:51:56 +0100
Message-Id: <20231208145200.25162-10-ansuelsmth@gmail.com>
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

Move specific at8031 config_intr bits to dedicated function to make
at803x_config_initr more generic.

This is needed in preparation for PHY driver split as qca8081 share the
same function to setup interrupts.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 862ec08ad86b..83428305281b 100644
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
@@ -1617,6 +1612,29 @@ static int at8031_set_wol(struct phy_device *phydev,
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
@@ -2137,7 +2155,7 @@ static struct phy_driver at803x_driver[] = {
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

