Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207C7645BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjG0Fht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjG0Fh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:37:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC5E3582
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89d47ffb6so3422455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436131; x=1691040931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eV7FwAQnhqmKgtMd0G6R4TLPgqzhAKhV6ZHHlFmK5M=;
        b=mra48eD2kN04BmlLuyAEvoEKjENVGmX08ZtHeBWV3TrnVT8w9cDYeNjDK+3LTUo9pg
         BMHCmE8isRPu0hr1Br50C0+6Dv3T1FQvw1R3Q8iGjbu3mc/1+ctEz37Hto6vI34nn3sd
         VsXpIHD3auMSYQzDlH6e7Adai3jRYKt3dzxNDWJiXRZirk2k2a8qfbAkGGu/j3PTbjaV
         RQlKgl8oI8g/eOIUdKJN6x+RB9Xw6gDIQIMDr9WnyydaJv2Kbu3CHdWPztkN7nX+ojDg
         OKx8pcW2FkGy6WlJPOOYqbUG26xl+6B1LY9oqVX0mutOICzTvJ0lyzsyLfOxgT58bqc6
         vf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436131; x=1691040931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eV7FwAQnhqmKgtMd0G6R4TLPgqzhAKhV6ZHHlFmK5M=;
        b=VFb0OBwfpE0HE83EWgCcB8FnQYdqTRN+sKN1ZsBoxr8cnEifDYK19kCidpmyI2qYMf
         SwzM9py6ZovIA+4Qn9Hm7B/Zchd5qBTkPlLJ1YJYVsykQ2mRABIahpmhOEE0NXa8NQl4
         IPF0GQ3C0ZMyBlViZECuhVjZVw9CkTs6IKcjIqWjFLPcrRocdk32dv3uz8GnzXa2GS5D
         nQaSOYWKDpiASP8Kmq+/wX6j1cTCzQqROndQhSbHPTgvD1swtUXhZ702crkJJi74SbKr
         nTnoTPzPHxDfJTj84WgQhgEK0uw6I76KXwQ3fU8j8966SzplZtio5RVF8mdPH175JQrt
         XA/Q==
X-Gm-Message-State: ABy/qLbMEIEO6h6ne1CQOp+I0zF4bwp/FhMuzwD2RwJRG8ERu129H5fw
        Vw+4BxMZ0pxTicNbHIUT0tNJxw==
X-Google-Smtp-Source: APBJJlHvImL9nMGYwJO3XtrJzHDpD8HPaM0PRBf1WB8LD5lptPCb27jBcnAi8tB4UrHR6TMuogusIA==
X-Received: by 2002:a17:903:11d1:b0:1bb:7b0a:374 with SMTP id q17-20020a17090311d100b001bb7b0a0374mr4165915plh.4.1690436131299;
        Wed, 26 Jul 2023 22:35:31 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:35:31 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 25/42] clk: at91: at91sam9rl: switch to parent_hw
Date:   Thu, 27 Jul 2023 08:31:39 +0300
Message-Id: <20230727053156.13587-26-claudiu.beznea@tuxon.dev>
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

Switch AT91SAM9RL clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9rl.c | 70 +++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 0e8657aac491..29f24a5b1fef 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -28,13 +29,13 @@ static const struct clk_pll_characteristics sam9rl_plla_characteristics = {
 	.out = sam9rl_plla_out,
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	u8 id;
 } at91sam9rl_systemck[] = {
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct {
@@ -67,23 +68,25 @@ static const struct {
 
 static void __init at91sam9rl_pmc_setup(struct device_node *np)
 {
-	const char *slck_name, *mainxtal_name;
+	struct clk_hw *parent_hws[5], *hw, *slow_clk_hw, *main_xtal_hw;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *at91sam9rl_pmc;
-	const char *parent_names[6];
 	struct regmap *regmap;
-	struct clk_hw *hw;
+	struct clk *clk;
 	int i;
 
-	i = of_property_match_string(np, "clock-names", "slow_clk");
-	if (i < 0)
+	clk = of_clk_get_by_name(np, "slow_clk");
+	if (IS_ERR(clk))
 		return;
-
-	slck_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
+	slow_clk_hw = __clk_get_hw(clk);
+	if (!slow_clk_hw)
+		return;
+	clk = of_clk_get_by_name(np, main_xtal_name);
+	if (IS_ERR(clk))
+		return;
+	main_xtal_hw = __clk_get_hw(clk);
+	if (!main_xtal_hw)
 		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -95,13 +98,13 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	if (!at91sam9rl_pmc)
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", mainxtal_name, NULL);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, main_xtal_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9rl_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, at91sam9rl_pmc->chws[PMC_MAIN], 0,
 				   &at91rm9200_pll_layout,
 				   &sam9rl_plla_characteristics);
 	if (IS_ERR(hw))
@@ -109,18 +112,18 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, at91sam9rl_pmc->chws[PMC_MAIN]);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9rl_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "utmick";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = at91sam9rl_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91sam9rl_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91sam9rl_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91rm9200_master_layout,
 					   &sam9rl_mck_characteristics,
 					   &sam9rl_mck_lock);
@@ -128,7 +131,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, hw,
 					  &at91rm9200_master_layout,
 					  &sam9rl_mck_characteristics,
 					  &sam9rl_mck_lock, CLK_SET_RATE_GATE, 0);
@@ -137,18 +140,18 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = at91sam9rl_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91sam9rl_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91sam9rl_pmc->chws[PMC_UTMI];
+	parent_hws[4] = at91sam9rl_pmc->chws[PMC_MCK];
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_hws, 5, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -157,9 +160,12 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 		at91sam9rl_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91sam9rl_systemck[0].parent_hw = at91sam9rl_pmc->pchws[0];
+	at91sam9rl_systemck[1].parent_hw = at91sam9rl_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n,
-					      at91sam9rl_systemck[i].p, NULL,
+					      NULL, at91sam9rl_systemck[i].parent_hw,
 					      at91sam9rl_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -170,7 +176,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9rl_periphck[i].n,
-						  "masterck_div", NULL,
+						  NULL, at91sam9rl_pmc->chws[PMC_MCK],
 						  at91sam9rl_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.39.2

