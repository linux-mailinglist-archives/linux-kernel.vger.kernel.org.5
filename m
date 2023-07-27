Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8656764592
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjG0Fen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjG0Fee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98730F0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55c85b4b06bso296059a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436022; x=1691040822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx4drRTLsTo8BLvzaJxx0gqAvVOnYebcn8FvaHa6RBo=;
        b=m7Y6n6a0biU9wU3OEZlV51PTrYisbU3CVl8mv35Tvoiz8R81ht7ELjhBcuRQ0UM2en
         fmHlihmt4w6JuP8JXtP6UjWeKS5Re+QESFlaZUzUNUUkL+juKq1FVOMcz3ywENevnO9A
         cfv7M8A89p+f0yrAdJj4QeTrmWZrCDjvcxCBbv+uPJpqe+3IJKut0FaDmDjZnkSR6meW
         OvOt9qGB4bBYAtXinToNleXB+Skn2vG5SHGGTYjXhtoc56Cyn8JwbLZ3CYB8GoCYwBUF
         tXu6T5HwLV/oTdU6i4xIZHRQCgyselBzpkGYSAqHO8nYM9YtAqkwbHLLV2H/JOXudt+9
         ZK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436022; x=1691040822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx4drRTLsTo8BLvzaJxx0gqAvVOnYebcn8FvaHa6RBo=;
        b=jngPLzbn+DJdYqBmh1tpeyMNOuHWhg9xlUww03DQpLmvaVfbIYYAlt+s5PauamCISe
         U5IYhID6zYCLtaF/i207V/+nlGZ6i0O0aAHnJadiKE/Td02mKRiFVlNLpvGs5/QPPVaS
         UbUNj118dGg+v40LXFZB3k1hEE4fNPCz1FSTli5pRJWffnDQ/zHXYvplma2t4ImnXJE7
         2baPeh29M3XtHW2AzCzavrCedMv53Wu446Nr/vTDN8JMwaRbr8jkqczAsuwtCMU8qJdO
         v5AuWFzlr1La/byunwHrCQdKjXLlNx3+qTJtHxgWcg2wv33Zw4TvcWzYK/sXq6UPBmg2
         qU5w==
X-Gm-Message-State: ABy/qLbg6N009RgnRVy//Foy6/ABNQW0Y2FJu38Dyn6gCTMHr0Yn1uA5
        jpCJ2nh0TdLaQHfwsptWc+YBYg==
X-Google-Smtp-Source: APBJJlE27IIV1/aO9kFhYFpQUxkfq2D5aR9B9DdKPgTgxMtU8whHLmifslSngsT/6RNiC1a7J+qR8g==
X-Received: by 2002:a05:6a20:12c1:b0:135:38b5:7e58 with SMTP id v1-20020a056a2012c100b0013538b57e58mr4347746pzg.37.1690436021948;
        Wed, 26 Jul 2023 22:33:41 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:33:41 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 10/42] clk: at91: sama5d2: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:24 +0300
Message-Id: <20230727053156.13587-11-claudiu.beznea@tuxon.dev>
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

Switch SAMA5D2 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting. Extra time saved on registration is
~410us when running at 492MHz.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/sama5d2.c | 165 ++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 76 deletions(-)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index f5d6c7a96cf2..cdb578059449 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -37,9 +38,9 @@ static const struct clk_pcr_layout sama5d2_pcr_layout = {
 	.pid_mask = GENMASK(6, 0),
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } sama5d2_systemck[] = {
@@ -47,14 +48,14 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
-	{ .n = "pck2",  .p = "prog2",        .id = 10 },
-	{ .n = "iscck", .p = "masterck_div", .id = 18 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "iscck", .id = 18 },
 };
 
 static const struct {
@@ -164,25 +165,29 @@ static const struct clk_programmable_layout sama5d2_programmable_layout = {
 
 static void __init sama5d2_pmc_setup(struct device_node *np)
 {
+	struct clk_hw *slow_clk_hw, *main_xtal_hw, *main_rc_hw, *main_osc_hw;
+	struct clk_hw *hw, *audio_fracck_hw, *usbck_hw, *parent_hws[6];
+	static struct clk_parent_data parent_data;
 	struct clk_range range = CLK_RANGE(0, 0);
-	const char *slck_name, *mainxtal_name;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *sama5d2_pmc;
-	const char *parent_names[6];
 	struct regmap *regmap, *regmap_sfr;
-	struct clk_hw *hw;
+	struct clk *clk;
 	int i;
 	bool bypass;
 
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
@@ -195,51 +200,50 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (!sama5d2_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   100000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   100000000);
+	if (IS_ERR(main_rc_hw))
 		goto err_free;
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
-					bypass);
-	if (IS_ERR(hw))
+	parent_data.name = main_xtal_name;
+	parent_data.fw_name = main_xtal_name;
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+						 bypass);
+	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	parent_names[0] = "main_rc_osc";
-	parent_names[1] = "main_osc";
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, NULL, 2);
+	parent_hws[0] = main_rc_hw;
+	parent_hws[1] = main_osc_hw;
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_MAIN] = hw;
-
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, sama5d2_pmc->chws[PMC_MAIN], 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
-					      "mainck", NULL);
-	if (IS_ERR(hw))
+	audio_fracck_hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
+							   NULL, sama5d2_pmc->chws[PMC_MAIN]);
+	if (IS_ERR(audio_fracck_hw))
 		goto err_free;
 
-	hw = at91_clk_register_audio_pll_pad(regmap, "audiopll_padck",
-					     "audiopll_fracck", NULL);
+	hw = at91_clk_register_audio_pll_pad(regmap, "audiopll_padck", NULL, audio_fracck_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_AUDIOPINCK] = hw;
 
-	hw = at91_clk_register_audio_pll_pmc(regmap, "audiopll_pmcck",
-					     "audiopll_fracck", NULL);
+	hw = at91_clk_register_audio_pll_pmc(regmap, "audiopll_pmcck", NULL, audio_fracck_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -249,25 +253,25 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap_sfr))
 		regmap_sfr = NULL;
 
-	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", NULL,
+				    sama5d2_pmc->chws[PMC_MAIN]);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = sama5d2_pmc->chws[PMC_MAIN];
+	parent_hws[2] = sama5d2_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d2_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
@@ -276,31 +280,31 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	sama5d2_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91_clk_register_h32mx(regmap, "h32mxck", "masterck_div", NULL);
+	hw = at91_clk_register_h32mx(regmap, "h32mxck", NULL, sama5d2_pmc->chws[PMC_MCK]);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_MCK2] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_hws[0] = sama5d2_pmc->chws[PMC_PLLACK];
+	parent_hws[1] = sama5d2_pmc->chws[PMC_UTMI];
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
-	parent_names[5] = "audiopll_pmcck";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = sama5d2_pmc->chws[PMC_MAIN];
+	parent_hws[2] = sama5d2_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d2_pmc->chws[PMC_UTMI];
+	parent_hws[4] = sama5d2_pmc->chws[PMC_MCK];
+	parent_hws[5] = sama5d2_pmc->chws[PMC_AUDIOPLLCK];
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 6, i,
+						    NULL, parent_hws, 6, i,
 						    &sama5d2_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -309,9 +313,18 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		sama5d2_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sama5d2_systemck[0].parent_hw = sama5d2_pmc->chws[PMC_MCK];
+	sama5d2_systemck[1].parent_hw = sama5d2_pmc->chws[PMC_MCK];
+	sama5d2_systemck[2].parent_hw = usbck_hw;
+	sama5d2_systemck[3].parent_hw = usbck_hw;
+	sama5d2_systemck[4].parent_hw = sama5d2_pmc->pchws[0];
+	sama5d2_systemck[5].parent_hw = sama5d2_pmc->pchws[1];
+	sama5d2_systemck[6].parent_hw = sama5d2_pmc->pchws[2];
+	sama5d2_systemck[7].parent_hw = sama5d2_pmc->chws[PMC_MCK];
 	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d2_systemck[i].n,
-					      sama5d2_systemck[i].p, NULL,
+					      NULL, sama5d2_systemck[i].parent_hw,
 					      sama5d2_systemck[i].id,
 					      sama5d2_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -324,7 +337,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL, sama5d2_pmc->chws[PMC_MCK],
 							 sama5d2_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d2_periphck[i].flags);
@@ -338,7 +351,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periph32ck[i].n,
-							 "h32mxck", NULL,
+							 NULL, sama5d2_pmc->chws[PMC_MCK2],
 							 sama5d2_periph32ck[i].id,
 							 &sama5d2_periph32ck[i].r,
 							 INT_MIN, 0);
@@ -348,17 +361,17 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		sama5d2_pmc->phws[sama5d2_periph32ck[i].id] = hw;
 	}
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
-	parent_names[5] = "audiopll_pmcck";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = sama5d2_pmc->chws[PMC_MAIN];
+	parent_hws[2] = sama5d2_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d2_pmc->chws[PMC_UTMI];
+	parent_hws[4] = sama5d2_pmc->chws[PMC_MCK];
+	parent_hws[5] = sama5d2_pmc->chws[PMC_AUDIOPLLCK];
 	for (i = 0; i < ARRAY_SIZE(sama5d2_gck); i++) {
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock,
 						 &sama5d2_pcr_layout,
 						 sama5d2_gck[i].n,
-						 parent_names, NULL, NULL, 6,
+						 NULL, parent_hws, NULL, 6,
 						 sama5d2_gck[i].id,
 						 &sama5d2_gck[i].r,
 						 sama5d2_gck[i].chg_pid);
@@ -369,19 +382,19 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	}
 
 	if (regmap_sfr) {
-		parent_names[0] = "i2s0_clk";
-		parent_names[1] = "i2s0_gclk";
+		parent_hws[0] = sama5d2_pmc->phws[54]; /* i2s0_clk */
+		parent_hws[1] = sama5d2_pmc->phws[54]; /* i2s0_gclk */
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s0_muxclk",
-					       parent_names, NULL, 2, 0);
+					       NULL, parent_hws, 2, 0);
 		if (IS_ERR(hw))
 			goto err_free;
 
 		sama5d2_pmc->chws[PMC_I2S0_MUX] = hw;
 
-		parent_names[0] = "i2s1_clk";
-		parent_names[1] = "i2s1_gclk";
+		parent_hws[0] = sama5d2_pmc->phws[55]; /* i2s1_clk */
+		parent_hws[1] = sama5d2_pmc->ghws[55]; /* i2s1_gclk */
 		hw = at91_clk_i2s_mux_register(regmap_sfr, "i2s1_muxclk",
-					       parent_names, NULL, 2, 1);
+					       NULL, parent_hws, 2, 1);
 		if (IS_ERR(hw))
 			goto err_free;
 
-- 
2.39.2

