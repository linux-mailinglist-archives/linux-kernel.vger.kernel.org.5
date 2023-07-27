Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234C7645DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjG0Fjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjG0FjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:39:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A4F421A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:54 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad8383faso4796625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436218; x=1691041018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFDKIrER1Q8EDEuXgmXxXy7qiRoYOQyJHV+mlKGKhyM=;
        b=Q5pItotCSKZWCFdXRGzjghrjkFi3Z+sL99/EwD3Ud+0lavJWRnFGQcG6R/iJ0c0TXT
         ic/vw6K4bWiQE6uKkhkm3GJFvQyyQK2EfHDZu622BFd72xzRH53btHPRiPzreyUVh/iz
         lm5zXMA1QdQ0lC4Dx8qpxKISW74rUgtQeRe3s5m8APoc9Kw7Txf4YfsMMN/xrF91WMIj
         boLQeStCa0Rvxfk9p16kl10ebs4CovIh1JwOtMxDkxCTasP5WYdA7GI3vbvVljYvUyj2
         thyshFC6UF1wuFcrV+p5KZwTitrW4H5GTyZ5Ift67NF5kW+oi7mIOhKan6DBuHdfLTjR
         63wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436218; x=1691041018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFDKIrER1Q8EDEuXgmXxXy7qiRoYOQyJHV+mlKGKhyM=;
        b=Fj6vlOPdlmteX0r2iubSh/YL/ObDEWaRtx/IwFa225Rx9EQbwW4jYcvoGI14m8HkfW
         8WXfkfuOPdyDiLCzNv5okhEHIl0snVrkQjDSRBwDRLQCkXIaj0WTxcSOfwzWJ/ck9Fhy
         wr5F2vSkcZDJJRtDm+YA8kPCW/4jEc22lWh6XGor+gqMOAj8lK9iM/I4zDuyFIFX0FoV
         SopM76TcVLffxozhK3PeV/UZkxhmgX1Eo2IvVB4M3XlZgelDwXydyRBEQ8JO2rRs7lS4
         FCNIPqxXsDGmJUVf+Fa8EZiVeUzVg8dgNotQXVESVEkYfGRe2odOfs0+3vBRBhuvVM+C
         YkRQ==
X-Gm-Message-State: ABy/qLZ0jvzr+2wALqvQKeionFiFBU9mQyH4wOy6aFzlSvRxzr8dmlfu
        uEXWWmH5PmSKnQyu1IJiTiq2Mw==
X-Google-Smtp-Source: APBJJlFsafDnT8kkWkk3yUqoJROLuqetgWn4uUQXGuwpxasw70Gtt8yiGSgxsI8WlcWcysUugjf0SA==
X-Received: by 2002:a17:902:f681:b0:1b6:b805:5ae3 with SMTP id l1-20020a170902f68100b001b6b8055ae3mr4943140plg.3.1690436218328;
        Wed, 26 Jul 2023 22:36:58 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:58 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 37/42] clk: at91: clk-sam9x60-pll: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:51 +0300
Message-Id: <20230727053156.13587-38-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove parent_names support as parent_hw support is now available on all
platforms using clk-sam9x60-pll driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 16 ++++------------
 drivers/clk/at91/pmc.h             |  6 ++----
 drivers/clk/at91/sam9x60.c         |  8 ++++----
 drivers/clk/at91/sama7g5.c         |  4 ++--
 4 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index ff65f7b916f0..787ab36ecdba 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -609,8 +609,7 @@ static const struct clk_ops sam9x60_div_pll_ops_chg = {
 
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
-			      const char *name, const char *parent_name,
-			      struct clk_hw *parent_hw, u8 id,
+			      const char *name, struct clk_hw *parent_hw, u8 id,
 			      const struct clk_pll_characteristics *characteristics,
 			      const struct clk_pll_layout *layout, u32 flags)
 {
@@ -629,10 +628,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	if (parent_name)
-		init.parent_names = &parent_name;
-	else
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_frac_pll_ops;
@@ -695,8 +691,7 @@ sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
 
 struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
-			     const char *name, const char *parent_name,
-			     struct clk_hw *parent_hw, u8 id,
+			     const char *name, struct clk_hw *parent_hw, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
 			     const struct clk_pll_layout *layout, u32 flags,
 			     u32 safe_div)
@@ -720,10 +715,7 @@ sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	if (flags & CLK_SET_RATE_GATE)
 		init.ops = &sam9x60_div_pll_ops;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 7d2524109776..fe86cca2776e 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -211,16 +211,14 @@ at91_clk_register_plldiv(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 sam9x60_clk_register_div_pll(struct regmap *regmap, spinlock_t *lock,
-			     const char *name, const char *parent_name,
-			     struct clk_hw *parent_hw, u8 id,
+			     const char *name, struct clk_hw *parent_hw, u8 id,
 			     const struct clk_pll_characteristics *characteristics,
 			     const struct clk_pll_layout *layout, u32 flags,
 			     u32 safe_div);
 
 struct clk_hw * __init
 sam9x60_clk_register_frac_pll(struct regmap *regmap, spinlock_t *lock,
-			      const char *name, const char *parent_name,
-			      struct clk_hw *parent_hw, u8 id,
+			      const char *name, struct clk_hw *parent_hw, u8 id,
 			      const struct clk_pll_characteristics *characteristics,
 			      const struct clk_pll_layout *layout, u32 flags);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 897a8f2d6102..68abd0fd47db 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -238,7 +238,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	sam9x60_pmc->chws[PMC_MAIN] = hw;
 
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "pllack_fracck",
-					   NULL, sam9x60_pmc->chws[PMC_MAIN],
+					   sam9x60_pmc->chws[PMC_MAIN],
 					   0, &plla_characteristics,
 					   &pll_frac_layout,
 					   /*
@@ -251,7 +251,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "pllack_divck",
-					  NULL, hw, 0, &plla_characteristics,
+					  hw, 0, &plla_characteristics,
 					  &pll_div_layout,
 					   /*
 					    * This feeds CPU. It should not
@@ -264,14 +264,14 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	sam9x60_pmc->chws[PMC_PLLACK] = hw;
 
 	hw = sam9x60_clk_register_frac_pll(regmap, &pmc_pll_lock, "upllck_fracck",
-					   NULL, main_osc_hw, 1,
+					   main_osc_hw, 1,
 					   &upll_characteristics,
 					   &pll_frac_layout, CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = sam9x60_clk_register_div_pll(regmap, &pmc_pll_lock, "upllck_divck",
-					  NULL, hw, 1, &upll_characteristics,
+					  hw, 1, &upll_characteristics,
 					  &pll_div_layout,
 					  CLK_SET_RATE_GATE |
 					  CLK_SET_PARENT_GATE |
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index baec84bd5d06..0d81a955e686 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1074,7 +1074,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 				hw = sam9x60_clk_register_frac_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					NULL, parent_hw, i,
+					parent_hw, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f);
@@ -1083,7 +1083,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			case PLL_TYPE_DIV:
 				hw = sam9x60_clk_register_div_pll(regmap,
 					&pmc_pll_lock, sama7g5_plls[i][j].n,
-					NULL, sama7g5_plls[i][0].hw, i,
+					sama7g5_plls[i][0].hw, i,
 					sama7g5_plls[i][j].c,
 					sama7g5_plls[i][j].l,
 					sama7g5_plls[i][j].f,
-- 
2.39.2

