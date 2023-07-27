Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D8764597
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjG0Fe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjG0Fei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36392D43
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55ae2075990so316811a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436036; x=1691040836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4C9Oz1kltIRm38suchn59UxyDsm/QbdYXqrBIKy7eU=;
        b=lv/ar83B0jbhwKY2ab3VcuRlDhYDF+3c5B8hcYTNMY74KXuEXXKB/YBrL8Bo+2nmtu
         gpXuhKWBLJX+voHBzq1OMevlcmX1cQiYuK5S06/yiVHSeGtXkOPO0pO6fHnnA5+5sBsB
         Xk+EhkG/G8tRFH58Mu1TLs0/kK9Ich2nsn95w30V54QTfAtN6c2xaMBN+mi2gMwAiuGT
         gSCXke/FCLKPQk53BNBobq39MYi4Otcfb9FGVD0B/a1ZLfj5HH6dw0fpIl4tPP0yC34B
         qarlvw3ivcno8hZZbl7MA+dKt8Il3bGreiIYPSwKqhm51ErBIe3wPNpxQ2zy2QlRqGWD
         8OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436036; x=1691040836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4C9Oz1kltIRm38suchn59UxyDsm/QbdYXqrBIKy7eU=;
        b=EvsPtiqVBlznrndQlBzcqj8shyTJXOQINCYSwF4EPcRGTJBJGlpOawtLEv0JST8H08
         t0dxzwQaY8kKkbsRfJv3z/xviM7Cc7ZPropnXT444N9BbozMWOo5mJ78PXXRc8H8zDkj
         AP+XJCRmrDnIK0LMpbf/klCQ3gmhycH1H3F++cqx783CTCOihm78u1ks0kZCnzhgG5Lg
         VtHHTOD2iltWLqliF7IIfVCPjqSa3PQgvsxSI4E6hc+6ciqv2wd1XA6o3SqT9My/Ppj4
         XzDHrQ0ZLEBMGp2440YDpJXgPhQnyABw+vjZAUq+ReiNApfjghJfYj7onNnU+UzkNlHN
         haaA==
X-Gm-Message-State: ABy/qLZE/0Zaeu4gUY7vGg1ytuYbgo9QkAdEvN2N1tAy6Zl6h/YoLa8P
        1KSdgo06E2eZpwBsH339Je6BpGARpTmGy6P3Xj4vttVk
X-Google-Smtp-Source: APBJJlEOU9CIR0GAd1ZAfZ8u4GySVCT6xMYpY4J49vaD8T2wQ5M215lzZQ9jqzJh3xaYewN6Oa9peQ==
X-Received: by 2002:a17:903:234c:b0:1a9:40d5:b0ae with SMTP id c12-20020a170903234c00b001a940d5b0aemr3852843plh.12.1690436036369;
        Wed, 26 Jul 2023 22:33:56 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:33:56 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 12/42] clk: at91: sama5d3: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:26 +0300
Message-Id: <20230727053156.13587-13-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch SAMA5D3 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/sama5d3.c | 124 +++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 8326bb6a291c..db0c66e24091 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -37,9 +38,9 @@ static const struct clk_pcr_layout sama5d3_pcr_layout = {
 	.div_mask = GENMASK(17, 16),
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } sama5d3_systemck[] = {
@@ -47,14 +48,14 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "smdck", .p = "smdclk",       .id = 4 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
-	{ .n = "pck2",  .p = "prog2",        .id = 10 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "smdck", .id = 4 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
 };
 
 static const struct {
@@ -114,24 +115,28 @@ static const struct {
 
 static void __init sama5d3_pmc_setup(struct device_node *np)
 {
-	const char *slck_name, *mainxtal_name;
+	struct clk_hw *slow_clk_hw, *main_xtal_hw, *main_rc_hw, *main_osc_hw, *mainck_hw;
+	struct clk_hw *parent_hws[5], *smdck_hw, *usbck_hw, *hw;
+	static struct clk_parent_data parent_data;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *sama5d3_pmc;
-	const char *parent_names[5];
 	struct regmap *regmap;
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
+	if (!IS_ERR(clk))
+		return;
+	main_xtal_hw = __clk_get_hw(clk);
+	if (!main_xtal_hw)
 		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -143,54 +148,56 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	if (!sama5d3_pmc)
 		return;
 
-	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
-					   50000000);
-	if (IS_ERR(hw))
+	main_rc_hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+						   50000000);
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
-	if (IS_ERR(hw))
+	parent_hws[0] = main_rc_hw;
+	parent_hws[1] = main_osc_hw;
+	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	if (IS_ERR(mainck_hw))
 		goto err_free;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, mainck_hw, 0,
 				   &sama5d3_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d3_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck", NULL);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, mainck_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d3_pmc->chws[PMC_UTMI] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = mainck_hw;
+	parent_hws[2] = sama5d3_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d3_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
@@ -199,28 +206,28 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	sama5d3_pmc->chws[PMC_MCK] = hw;
 
-	parent_names[0] = "plladivck";
-	parent_names[1] = "utmick";
-	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	parent_hws[0] = sama5d3_pmc->chws[PMC_PLLACK];
+	parent_hws[1] = sama5d3_pmc->chws[PMC_UTMI];
+	usbck_hw = at91sam9x5_clk_register_usb(regmap, "usbck", NULL, parent_hws, 2);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, NULL, 2);
-	if (IS_ERR(hw))
+	smdck_hw = at91sam9x5_clk_register_smd(regmap, "smdclk", NULL, parent_hws, 2);
+	if (IS_ERR(smdck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "utmick";
-	parent_names[4] = "masterck_div";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = mainck_hw;
+	parent_hws[2] = sama5d3_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = sama5d3_pmc->chws[PMC_UTMI];
+	parent_hws[4] = sama5d3_pmc->chws[PMC_MCK];
 	for (i = 0; i < 3; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -229,9 +236,18 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		sama5d3_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	sama5d3_systemck[0].parent_hw = sama5d3_pmc->chws[PMC_MCK];
+	sama5d3_systemck[1].parent_hw = sama5d3_pmc->chws[PMC_MCK];
+	sama5d3_systemck[2].parent_hw = smdck_hw;
+	sama5d3_systemck[3].parent_hw = usbck_hw;
+	sama5d3_systemck[4].parent_hw = usbck_hw;
+	sama5d3_systemck[5].parent_hw = sama5d3_pmc->pchws[0];
+	sama5d3_systemck[6].parent_hw = sama5d3_pmc->pchws[1];
+	sama5d3_systemck[7].parent_hw = sama5d3_pmc->pchws[2];
 	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
 		hw = at91_clk_register_system(regmap, sama5d3_systemck[i].n,
-					      sama5d3_systemck[i].p, NULL,
+					      NULL, sama5d3_systemck[i].parent_hw,
 					      sama5d3_systemck[i].id,
 					      sama5d3_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -244,7 +260,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d3_pcr_layout,
 							 sama5d3_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL, sama5d3_pmc->chws[PMC_MCK],
 							 sama5d3_periphck[i].id,
 							 &sama5d3_periphck[i].r,
 							 INT_MIN,
-- 
2.39.2

