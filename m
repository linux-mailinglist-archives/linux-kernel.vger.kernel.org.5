Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5097F9DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjK0Kll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjK0Klc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:41:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4B113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:41:38 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50baa3e5c00so2301222e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701081696; x=1701686496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVSAHbxZoohnOH7jImii/DY4owc5b3zp1Hwe6YQy5wU=;
        b=y5FSJzHksCLkhTeR1wb6xnBEsXuTttvnk3Gj3TnEo+Jimgymwoinr8YvYDEixbFHok
         mtjDX1aum1F5NULvOVTnJvuDlDoXuhWUYvlwjSQeOksHzL+l/fXX0ialZaqgc+RE4XCD
         OQhvVPacTfKF4sFgpHr6Ct+kvnulc58WqhWhNku13yFNO/ru16wRITEc5RM7QlK7pVJv
         Dgw7HP7Dhili2GaA4KOeMIBnqb64Nv3unhmG4F7Dy+97R3R05puXxLhculxUiQ2ueZC6
         fo1o1p9tMCLIsbMh8czU5sWTpXDNDUeI9dXaG0EG9/a0cr6jiJudG+4qIVBjlB7Qjver
         3JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701081696; x=1701686496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVSAHbxZoohnOH7jImii/DY4owc5b3zp1Hwe6YQy5wU=;
        b=kpE+lNr8HjSMIzhPf9bedi6getwK25kLnmCFN1FkWq7u7QD0g92OyntD8/x+b3TgES
         A4FGg/pAlgldkHu7OY0OqxSA6FR5oEMeztbYuXjZewdvm7K2e10HFu3mkWCb5sZv4jxX
         eyxxsIrboZjcdj9TRf9ZwhCh7rNhnYFKtrMsUbYkFvuxzTm+Bi3pmglXzh4dPTAOyUjk
         3OZ0A4ZV0EyuKe7YMHH9VwFIXu1qj30IKeEnIr9A8Y+UtknxQIX6FWzPrKrN6dnIzaOC
         Jg8WJE7nxEiuVcS8tsMKV5NpPRvRcKcu2pv2MxAf8nuFqQiHIgSnnb7Bw9BueSLA+PU0
         FRqw==
X-Gm-Message-State: AOJu0Yyn7ruCyyselteWDDTSSeZRYSgA5NgmmuBoGn5+LBmMZohIHAaK
        LJagNOmxx6UHtIRO5Z9JdN8FkA==
X-Google-Smtp-Source: AGHT+IFX7bNX12KRNlnqIDKFrEARfjiZuo+r+3ozDbjLMUk02p73hgrg4SGWJZUpk3cWJXj78xYChw==
X-Received: by 2002:a05:6512:1105:b0:50b:a69d:b8bb with SMTP id l5-20020a056512110500b0050ba69db8bbmr5175114lfg.49.1701081696442;
        Mon, 27 Nov 2023 02:41:36 -0800 (PST)
Received: from localhost.localdomain ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b004fe1f1c0ee4sm1432070lfc.82.2023.11.27.02.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:41:35 -0800 (PST)
From:   =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ram=C3=B3n=20N=2ERodriguez?= 
        <ramon.nordin.rodriguez@ferroamp.se>
Subject: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Date:   Mon, 27 Nov 2023 11:40:45 +0100
Message-ID: <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

This commit conditionally sets the collision detection bit on lan867x
and lan865x phys on changing PLCA enabled on/off. The intended realworld
scenario is that all nodes on the network run the same settings with
regards to plca, and when plca is enabled the physical layer guarantees
that no collisions should occur.
In a practical setting where it was tested running one node with
collision detection on and other off, the node with collision detection
on dropped a lot of packets, leading to a poor performing link.
Worth noting here is that the phys default/reset to plca disabled and
collision detection enabled. Thus this change would only have an effect
when changing settings via ethtool.

Signed-off-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
---
 drivers/net/phy/microchip_t1s.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index db84d850b165..3b1e82ecdf69 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -23,8 +23,10 @@
 #define LAN865X_REG_CFGPARAM_DATA 0x00D9
 #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
 #define LAN865X_REG_STS2 0x0019
+#define LAN86XX_REG_COLLISION_DETECT 0x0087
 
 #define LAN865X_CFGPARAM_READ_ENABLE BIT(1)
+#define LAN86XX_COLLISION_DETECT_ENABLE BIT(15)
 
 /* The arrays below are pulled from the following table from AN1699
  * Access MMD Address Value Mask
@@ -363,6 +365,27 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan86xx_plca_set_cfg(struct phy_device *phydev,
+				const struct phy_plca_cfg *plca_cfg)
+{
+	int err;
+
+	err = genphy_c45_plca_set_cfg(phydev, plca_cfg);
+	if (err)
+		return err;
+
+	/* Disable collision detect on the phy when PLCA is enabled.
+	 * Noise can be picked up as a false positive for collisions
+	 * leading to the phy dropping legitimate packets.
+	 * No collisions should be possible when all nodes are setup
+	 * for running PLCA.
+	 */
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+			LAN86XX_REG_COLLISION_DETECT,
+			LAN86XX_COLLISION_DETECT_ENABLE,
+			plca_cfg->enabled ? 0 : LAN86XX_COLLISION_DETECT_ENABLE);
+}
+
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -371,7 +394,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revb1_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -381,7 +404,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan867x_revc1_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 	{
@@ -391,7 +414,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.config_init        = lan865x_revb0_config_init,
 		.read_status        = lan86xx_read_status,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
+		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
 	},
 };
-- 
2.40.1

