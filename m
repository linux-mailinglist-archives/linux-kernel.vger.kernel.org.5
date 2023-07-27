Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E477645E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjG0Fkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjG0FkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:40:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AEB3A98
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso3730255ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436240; x=1691041040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MZ4Kp4lF1KjxsdE0fjXbxu2hcT01qgittw8+AX1ais=;
        b=i33XmaIPrG9ujwJu4RPYfqz8tKC9aklbCEg/XJ0TTJ22HMJou819xTe2CJOD+h3BaJ
         A4TvzOl9/d4C6hKAUdtaXx/zc0/ybVl7vZZ+yX/IlkoHLbWnkdV96jSTpq/2OFIAwcYX
         03PFq2YbVY5QL/bXMseU1ec/qce+ZTGCeE/sCEBNHoMpixUyw//bfdfFFO0vs5HpCz1o
         84B/RrGpCUNU8JdlQ89/x3Bs+Wi5hQkGo6Q601oO8Sp+nS7e8tXSbt1BvCn7Z37t7tg4
         RonKcJUBVICucljvRHrdMp0nyUzxeo5S4RPgAqTJNCkX3DMToGxBlC7Byoxm18iRo7+q
         QRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436240; x=1691041040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MZ4Kp4lF1KjxsdE0fjXbxu2hcT01qgittw8+AX1ais=;
        b=D3bsUoJUNkNzt3uHn8+HxlF5Acs3o61tx6apA2CznxX+DSOI48B2dzzIOyE0jwe1Hj
         Bxejx1oW+4pwkPM0iCOJY8Se6ThYUw3U1CBjrdHKoIylp07f7M9Bw54hbQxjAx/ZTTdg
         yeOA3x3yXe0GVSX+1c01uO+na8oqfUVxTlnZdkyr1Z6C+0g0kzbDgNMez+4rfrt8inJZ
         Et7Uutm36DtweRMjcX/5pdjsJ7eFnBMM3RJTN9mHkyntW/RkpitChDhRHV252J2hMZHh
         2xGplPQyJ+YqI9iw5CIBQ+R45AI/75dN7Gmt7gTLxoKojrEHhEcFtZOT0tsl6143U4P2
         s5/w==
X-Gm-Message-State: ABy/qLYh5f2OO/RZ8TejeeTw/C6yt1dhWhdiMynNGwQ84xb2OhRnSy4j
        6vrhjkPR5Aw3XTx1FWb0lbG0Jg==
X-Google-Smtp-Source: APBJJlEIhpktItHVR8GLsrBTfxaptzEbAomzADKwH8ieh3QikL6C736GamLQQJ60kN7bcb9GVJvQGQ==
X-Received: by 2002:a17:902:ec92:b0:1bb:6875:5a73 with SMTP id x18-20020a170902ec9200b001bb68755a73mr3655798plg.2.1690436240057;
        Wed, 26 Jul 2023 22:37:20 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:37:19 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 40/42] clk: at91: clk-system: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:54 +0300
Message-Id: <20230727053156.13587-41-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parent_names support as parent_hw support is now available on all
platforms using clk-system driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c  | 2 +-
 drivers/clk/at91/at91sam9260.c | 2 +-
 drivers/clk/at91/at91sam9g45.c | 2 +-
 drivers/clk/at91/at91sam9n12.c | 2 +-
 drivers/clk/at91/at91sam9rl.c  | 2 +-
 drivers/clk/at91/at91sam9x5.c  | 4 ++--
 drivers/clk/at91/clk-system.c  | 9 +++------
 drivers/clk/at91/dt-compat.c   | 2 +-
 drivers/clk/at91/pmc.h         | 2 +-
 drivers/clk/at91/sam9x60.c     | 2 +-
 drivers/clk/at91/sama5d2.c     | 2 +-
 drivers/clk/at91/sama5d3.c     | 2 +-
 drivers/clk/at91/sama5d4.c     | 2 +-
 drivers/clk/at91/sama7g5.c     | 2 +-
 14 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 9305cb6eaef2..4b8a9c27cc9e 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -196,7 +196,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	at91rm9200_systemck[5].parent_hw = at91rm9200_pmc->pchws[3];
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n,
-					      NULL, at91rm9200_systemck[i].parent_hw,
+					      at91rm9200_systemck[i].parent_hw,
 					      at91rm9200_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 97efc39a7e2b..71002ada33dd 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -475,7 +475,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	}
 	for (i = 0; i < data->num_sck; i++) {
 		hw = at91_clk_register_system(regmap, data->sck[i].n,
-					      NULL, data->sck[i].parent_hw,
+					      data->sck[i].parent_hw,
 					      data->sck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index a5bc6f5c8173..bf5951097fca 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -213,7 +213,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	at91sam9g45_systemck[3].parent_hw = at91sam9g45_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9g45_systemck[i].n,
-					      NULL, at91sam9g45_systemck[i].parent_hw,
+					      at91sam9g45_systemck[i].parent_hw,
 					      at91sam9g45_systemck[i].id,
 					      at91sam9g45_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index b4dfe2d1de8a..fa7daab2793b 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -241,7 +241,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	at91sam9n12_systemck[5].parent_hw = at91sam9n12_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9n12_systemck[i].n,
-					      NULL, at91sam9n12_systemck[i].parent_hw,
+					      at91sam9n12_systemck[i].parent_hw,
 					      at91sam9n12_systemck[i].id,
 					      at91sam9n12_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 48d79189fc98..eaa757f6670a 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -164,7 +164,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	at91sam9rl_systemck[1].parent_hw = at91sam9rl_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n,
-					      NULL, at91sam9rl_systemck[i].parent_hw,
+					      at91sam9rl_systemck[i].parent_hw,
 					      at91sam9rl_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 93165263502e..994010f1cf03 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -265,7 +265,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	at91sam9x5_systemck[5].parent_hw = at91sam9x5_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9x5_systemck[i].n,
-					      NULL, at91sam9x5_systemck[i].parent_hw,
+					      at91sam9x5_systemck[i].parent_hw,
 					      at91sam9x5_systemck[i].id,
 					      at91sam9x5_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -275,7 +275,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	}
 
 	if (has_lcdck) {
-		hw = at91_clk_register_system(regmap, "lcdck", NULL,
+		hw = at91_clk_register_system(regmap, "lcdck",
 					      at91sam9x5_pmc->chws[PMC_MCK], 3, 0);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/clk-system.c b/drivers/clk/at91/clk-system.c
index 90eed39d0785..3f626a65ce9c 100644
--- a/drivers/clk/at91/clk-system.c
+++ b/drivers/clk/at91/clk-system.c
@@ -105,7 +105,7 @@ static const struct clk_ops system_ops = {
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, struct clk_hw *parent_hw, u8 id,
+			 struct clk_hw *parent_hw, u8 id,
 			 unsigned long flags)
 {
 	struct clk_system *sys;
@@ -113,7 +113,7 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 	struct clk_init_data init = {};
 	int ret;
 
-	if (!(parent_name || parent_hw) || id > SYSTEM_MAX_ID)
+	if (!parent_hw || id > SYSTEM_MAX_ID)
 		return ERR_PTR(-EINVAL);
 
 	sys = kzalloc(sizeof(*sys), GFP_KERNEL);
@@ -122,10 +122,7 @@ at91_clk_register_system(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &system_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_PARENT | flags;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 294e3b0e8a9d..dc8eb6036643 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -1020,7 +1020,7 @@ static void __init of_at91rm9200_clk_sys_setup(struct device_node *np)
 		if (!strcmp(sysclknp->name, "ddrck"))
 			flags = CLK_IS_CRITICAL;
 
-		hw = at91_clk_register_system(regmap, name, NULL, parent_hw,
+		hw = at91_clk_register_system(regmap, name, parent_hw,
 					      id, flags);
 		if (IS_ERR(hw))
 			continue;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 131ef55d3e47..bdb2dfb8fa86 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -242,7 +242,7 @@ at91sam9x5_clk_register_smd(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_system(struct regmap *regmap, const char *name,
-			 const char *parent_name, struct clk_hw *parent_hw,
+			 struct clk_hw *parent_hw,
 			 u8 id, unsigned long flags);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 68abd0fd47db..f344cbbc9c25 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -335,7 +335,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	sam9x60_systemck[4].parent_hw = sam9x60_pmc->chws[PMC_MCK];
 	for (i = 0; i < ARRAY_SIZE(sam9x60_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sam9x60_systemck[i].n,
-					      NULL, sam9x60_systemck[i].parent_hw,
+					      sam9x60_systemck[i].parent_hw,
 					      sam9x60_systemck[i].id,
 					      sam9x60_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index c64b79b44ba6..0fce17af769e 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -324,7 +324,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	sama5d2_systemck[7].parent_hw = sama5d2_pmc->chws[PMC_MCK];
 	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d2_systemck[i].n,
-					      NULL, sama5d2_systemck[i].parent_hw,
+					      sama5d2_systemck[i].parent_hw,
 					      sama5d2_systemck[i].id,
 					      sama5d2_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 239806dcd03d..c00380ed0000 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -246,7 +246,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	sama5d3_systemck[7].parent_hw = sama5d3_pmc->pchws[2];
 	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d3_systemck[i].n,
-					      NULL, sama5d3_systemck[i].parent_hw,
+					      sama5d3_systemck[i].parent_hw,
 					      sama5d3_systemck[i].id,
 					      sama5d3_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index f193460495c0..0d2a834a5903 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -269,7 +269,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	sama5d4_systemck[7].parent_hw = sama5d4_pmc->pchws[2];
 	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d4_systemck[i].n,
-					      NULL, sama5d4_systemck[i].parent_hw,
+					      sama5d4_systemck[i].parent_hw,
 					      sama5d4_systemck[i].id,
 					      sama5d4_systemck[i].flags);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 0d81a955e686..61f7027f1033 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1183,7 +1183,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	for (i = 0; i < ARRAY_SIZE(sama7g5_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama7g5_systemck[i].n,
-					      NULL, sama7g5_pmc->pchws[i],
+					      sama7g5_pmc->pchws[i],
 					      sama7g5_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.39.2

