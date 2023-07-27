Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E822E7645B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjG0FhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjG0Fgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:36:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A635AC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:35:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89d47ffb6so3421805ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436116; x=1691040916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA2TrheluzQnAFbCVQ+vAz4zJ4LsOThO95zEdvuZGfo=;
        b=EkFF4gPwxDnbKx/J7LkqyC3bIRRwG52czDWaorcgXR6HrgdZ4jyxRV7FP+wbQJr4RB
         tn1xQmZIaBehGueBCk18NcjvkUGndC3danISrC3TxPSiyfylohNlZi5lXcqm/4CZOPKl
         Uttv5Y/8HDk1gLq1quYhFC/6OTM2E4c5Nd4/bTpq8UkAZ4SmACiUdY1FSlKwnH4KBGVR
         UvoMu3M1vFeBGeM4wH8UARSvJIJDzm6suo5Lznue0tUR1oXn5lnYpllFKIbZpvTPrXBE
         LGRaF2IpkCoLlwJE+vpLABswUF5IgwCqJqhpXdqzETC4X929DRTCsJ+o6oNLFMsEGjyR
         7V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436116; x=1691040916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA2TrheluzQnAFbCVQ+vAz4zJ4LsOThO95zEdvuZGfo=;
        b=eAKuqydojm23LQmqSzMPhZVS6gRAKqJqxfTSE++gAZn5eDMmPGoeyzB2DGHqhfd2BW
         agikXQuOCUb4b4C4dUQn6JcD1jCj37u6qtvbpVdpZLVs5eEzC9Yx7Wc8NJCPlNu0vwdx
         lKkqfxn/v1YlgTM5oeFHgxxtRDKCpBMIZf1zkMbYbtlQKAkpJjAiGBXljVB1lUbHqC/j
         s6NBctZZkGDNULHr5kDdH8/gVctiNmbwVRr6ykI7Y+C+XWFyrhfPfzBmbPkJpU1Aj/AX
         uqe8VCrNWcviqFH1Y6eHVGV6FKYjPvjkp21DrJkYTiLthhNL57aFK2FVWQY/jmW3o8vY
         XL/w==
X-Gm-Message-State: ABy/qLbL4Q9PHwi06O7cO+spRngYJ8qlf5ddfw3MFSAgKqG/CJ3/IKOd
        kv0iU4HEt1Woh8kpOySL27mFRA==
X-Google-Smtp-Source: APBJJlEzht+QR53SZxeYmEj0hRCQ1Y6DMJIqdzDM7dzKYeYqRgd4FqDbqo4bvKSF2FjZ9Ci8CBmyhg==
X-Received: by 2002:a17:902:ee55:b0:1b8:3dec:48de with SMTP id 21-20020a170902ee5500b001b83dec48demr3404846plo.47.1690436116638;
        Wed, 26 Jul 2023 22:35:16 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:35:16 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 23/42] clk: at91: at91sam9n12: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:37 +0300
Message-Id: <20230727053156.13587-24-claudiu.beznea@tuxon.dev>
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

Switch AT91SAM9N12 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9n12.c | 109 +++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 34dd7645f964..d8dcff9ffaaa 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -51,9 +52,9 @@ static const struct clk_pll_characteristics pllb_characteristics = {
 	.out = pllb_out,
 };
 
-static const struct {
+static struct {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	unsigned long flags;
 	u8 id;
 } at91sam9n12_systemck[] = {
@@ -61,12 +62,12 @@ static const struct {
 	 * ddrck feeds DDR controller and is enabled by bootloader thus we need
 	 * to keep it enabled in case there is no Linux consumer for it.
 	 */
-	{ .n = "ddrck", .p = "masterck_div", .id = 2, .flags = CLK_IS_CRITICAL },
-	{ .n = "lcdck", .p = "masterck_div", .id = 3 },
-	{ .n = "uhpck", .p = "usbck",        .id = 6 },
-	{ .n = "udpck", .p = "usbck",        .id = 7 },
-	{ .n = "pck0",  .p = "prog0",        .id = 8 },
-	{ .n = "pck1",  .p = "prog1",        .id = 9 },
+	{ .n = "ddrck", .id = 2, .flags = CLK_IS_CRITICAL },
+	{ .n = "lcdck", .id = 3 },
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct clk_pcr_layout at91sam9n12_pcr_layout = {
@@ -111,25 +112,29 @@ static const struct pck at91sam9n12_periphck[] = {
 
 static void __init at91sam9n12_pmc_setup(struct device_node *np)
 {
+	struct clk_hw *parent_hws[5], *usbck_hw, *main_rc_hw, *main_osc_hw, *hw;
+	struct clk_hw *slow_clk_hw, *main_xtal_hw;
+	static struct clk_parent_data parent_data;
+	const char *main_xtal_name = "main_xtal";
 	struct clk_range range = CLK_RANGE(0, 0);
-	const char *slck_name, *mainxtal_name;
 	struct pmc_data *at91sam9n12_pmc;
-	const char *parent_names[6];
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
+	if (IS_ERR(clk))
+		return;
+	main_xtal_hw = __clk_get_hw(clk);
+	if (!main_xtal_hw)
 		return;
-	mainxtal_name = of_clk_get_parent_name(np, i);
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap))
@@ -140,50 +145,52 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	if (!at91sam9n12_pmc)
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
+	parent_hws[0] = main_rc_hw;
+	parent_hws[1] = main_osc_hw;
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9n12_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, at91sam9n12_pmc->chws[PMC_MAIN], 0,
 				   &at91rm9200_pll_layout, &plla_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack", NULL);
+	hw = at91_clk_register_plldiv(regmap, "plladivck", NULL, hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9n12_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL, at91sam9n12_pmc->chws[PMC_MAIN], 1,
 				   &at91rm9200_pll_layout, &pllb_characteristics);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91sam9n12_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "pllbck";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = at91sam9n12_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91sam9n12_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91sam9n12_pmc->chws[PMC_PLLBCK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics,
 					   &at91sam9n12_mck_lock);
@@ -191,7 +198,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics,
 					  &at91sam9n12_mck_lock,
@@ -201,22 +208,23 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	at91sam9n12_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91sam9n12_clk_register_usb(regmap, "usbck", "pllbck", NULL);
-	if (IS_ERR(hw))
+	usbck_hw = at91sam9n12_clk_register_usb(regmap, "usbck", NULL,
+						at91sam9n12_pmc->chws[PMC_PLLBCK]);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "plladivck";
-	parent_names[3] = "pllbck";
-	parent_names[4] = "masterck_div";
+	parent_hws[0] = slow_clk_hw;
+	parent_hws[1] = at91sam9n12_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91sam9n12_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91sam9n12_pmc->chws[PMC_PLLBCK];
+	parent_hws[4] = at91sam9n12_pmc->chws[PMC_MCK];
 	for (i = 0; i < 2; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 5, i,
+						    NULL, parent_hws, 5, i,
 						    &at91sam9x5_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -225,9 +233,16 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		at91sam9n12_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91sam9n12_systemck[0].parent_hw = at91sam9n12_pmc->chws[PMC_MCK];
+	at91sam9n12_systemck[1].parent_hw = at91sam9n12_pmc->chws[PMC_MCK];
+	at91sam9n12_systemck[2].parent_hw = usbck_hw;
+	at91sam9n12_systemck[3].parent_hw = usbck_hw;
+	at91sam9n12_systemck[4].parent_hw = at91sam9n12_pmc->pchws[0];
+	at91sam9n12_systemck[5].parent_hw = at91sam9n12_pmc->pchws[1];
 	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91sam9n12_systemck[i].n,
-					      at91sam9n12_systemck[i].p, NULL,
+					      NULL, at91sam9n12_systemck[i].parent_hw,
 					      at91sam9n12_systemck[i].id,
 					      at91sam9n12_systemck[i].flags);
 		if (IS_ERR(hw))
@@ -240,7 +255,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9n12_pcr_layout,
 							 at91sam9n12_periphck[i].n,
-							 "masterck_div", NULL,
+							 NULL, at91sam9n12_pmc->chws[PMC_MCK],
 							 at91sam9n12_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
-- 
2.39.2

