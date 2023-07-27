Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593E7645A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjG0FfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjG0Fex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6304358A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso4618535ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436065; x=1691040865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kid366wiUoXwgFB76gRtzNPUPTmnA2Hry2ysnz0JRIc=;
        b=iTwFAaZoQR0slAJQ6ZFA/OIw+wZMhPqKMeCFKKIIIz6uKqzdUa+gbJasrMqdi9lWEq
         hBecxsx7vGEPk7T+2ns7Wrt6FXL6w2JgAUWH0ysS6/qSMRS/yy8g5MYf4w9CzdrC0GCV
         h4ZoAnSYM/gy1yDYzORz6Q0DeDA9BKWE/fSnhW/xelNXOtNKNqp/la9Fiqc7Mx9VxKig
         jbbHK5r4tYpfdJ2UE+u6xg0W6mc1+163RQ7vcRaUp7jQvv1Q719naD4ehEfChm64WjXn
         jhvCxUOncdCEqipYRVj8QdunhyxuaoxLD37GgrEWsFciZ95NbgIq5ccR5H2NcKxt5Exm
         lY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436065; x=1691040865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kid366wiUoXwgFB76gRtzNPUPTmnA2Hry2ysnz0JRIc=;
        b=ZL5V5J1ykbzj8FDWrWT70DCsOia20E0C9u2oQMxXjj9rnTL7kW8+pOBHh8xWqFhHQN
         CQ9K6wFScDG2wVIpz3064k/D4CRkqaCWu54qOWvbRG98Qi7oCBSKwH9ouyVSkZuEF6qU
         eS9H4Rumm7rOwu8wSH9qhCNrwSz5FdvX3Hda/EYFWJqAYIce0lK5wb+2xFKrIBlezhDp
         oGZo8pSi0CXMYWQclgl+YUdwiAGgVPvonjdC8zbd8rlhozyR7JBOgPan7o0eXfXloepU
         KuX2EL99+aq6FV4XtbXtlR5FyZaoO2JH/XTNDNIWoe1Sbg/vKvpOhptH2tdzXv4euNwb
         mEvA==
X-Gm-Message-State: ABy/qLaNpObR8jUxxWgPvIBVxI1vDT4vE/UJcCRLkmnBHKFZmERDj05F
        O5v0kVcHxv0y7/1J7CaGughN/Sv0eRpUWQW96v/zVefO
X-Google-Smtp-Source: APBJJlH0XNbuHwIiz8HkLlyy1CZ4I1oM876K9F2n/xW/gkzLy9fK4Ym4GPsj3gVktULHuk9bYJI2AQ==
X-Received: by 2002:a17:902:ec8c:b0:1ab:11c8:777a with SMTP id x12-20020a170902ec8c00b001ab11c8777amr5186878plg.13.1690436065269;
        Wed, 26 Jul 2023 22:34:25 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:34:25 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 16/42] clk: at91: at91rm9200: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:30 +0300
Message-Id: <20230727053156.13587-17-claudiu.beznea@tuxon.dev>
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

Switch AT91RM9200 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c | 96 ++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 623e232ec9c6..87fd7b1609bd 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -11,7 +12,7 @@ static DEFINE_SPINLOCK(rm9200_mck_lock);
 
 struct sck {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	u8 id;
 };
 
@@ -39,13 +40,13 @@ static const struct clk_pll_characteristics rm9200_pll_characteristics = {
 	.out = rm9200_pll_out,
 };
 
-static const struct sck at91rm9200_systemck[] = {
-	{ .n = "udpck", .p = "usbck",    .id = 1 },
-	{ .n = "uhpck", .p = "usbck",    .id = 4 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
-	{ .n = "pck2",  .p = "prog2",    .id = 10 },
-	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+static struct sck at91rm9200_systemck[] = {
+	{ .n = "udpck", .id = 1 },
+	{ .n = "uhpck", .id = 4 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "pck3",  .id = 11 },
 };
 
 static const struct pck at91rm9200_periphck[] = {
@@ -76,25 +77,29 @@ static const struct pck at91rm9200_periphck[] = {
 
 static void __init at91rm9200_pmc_setup(struct device_node *np)
 {
-	const char *slowxtal_name, *mainxtal_name;
+	struct clk_hw *slow_xtal_hw, *main_xtal_hw, *main_osc_hw;
+	struct clk_hw *parent_hws[6], *usbck_hw, *hw;
+	static struct clk_parent_data parent_data;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *at91rm9200_pmc;
 	u32 usb_div[] = { 1, 2, 0, 0 };
-	const char *parent_names[6];
 	struct regmap *regmap;
-	struct clk_hw *hw;
+	struct clk *clk;
 	int i;
 	bool bypass;
 
-	i = of_property_match_string(np, "clock-names", "slow_xtal");
-	if (i < 0)
+	clk = of_clk_get_by_name(np, "slow_xtal");
+	if (IS_ERR(clk))
 		return;
-
-	slowxtal_name = of_clk_get_parent_name(np, i);
-
-	i = of_property_match_string(np, "clock-names", "main_xtal");
-	if (i < 0)
+	slow_xtal_hw = __clk_get_hw(clk);
+	if (!slow_xtal_hw)
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
@@ -108,18 +113,20 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
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
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, main_osc_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	at91rm9200_pmc->chws[PMC_MAIN] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, at91rm9200_pmc->chws[PMC_MAIN], 0,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
@@ -127,7 +134,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL, at91rm9200_pmc->chws[PMC_MAIN], 1,
 				   &at91rm9200_pll_layout,
 				   &rm9200_pll_characteristics);
 	if (IS_ERR(hw))
@@ -135,20 +142,19 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slowxtal_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_hws[0] = slow_xtal_hw;
+	parent_hws[1] = at91rm9200_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91rm9200_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91rm9200_pmc->chws[PMC_PLLBCK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91rm9200_master_layout,
 					   &rm9200_mck_characteristics,
 					   &rm9200_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
 					  &at91rm9200_master_layout,
 					  &rm9200_mck_characteristics,
 					  &rm9200_mck_lock, CLK_SET_RATE_GATE, 0);
@@ -157,21 +163,22 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	at91rm9200_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
-	if (IS_ERR(hw))
+	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck", NULL,
+					       at91rm9200_pmc->chws[PMC_PLLBCK], usb_div);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slowxtal_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_hws[0] = slow_xtal_hw;
+	parent_hws[1] = at91rm9200_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91rm9200_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91rm9200_pmc->chws[PMC_PLLBCK];
 	for (i = 0; i < 4; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 4, i,
+						    NULL, parent_hws, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -180,9 +187,16 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 		at91rm9200_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	at91rm9200_systemck[0].parent_hw = usbck_hw;
+	at91rm9200_systemck[1].parent_hw = usbck_hw;
+	at91rm9200_systemck[2].parent_hw = at91rm9200_pmc->pchws[0];
+	at91rm9200_systemck[3].parent_hw = at91rm9200_pmc->pchws[1];
+	at91rm9200_systemck[4].parent_hw = at91rm9200_pmc->pchws[2];
+	at91rm9200_systemck[5].parent_hw = at91rm9200_pmc->pchws[3];
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
 		hw = at91_clk_register_system(regmap, at91rm9200_systemck[i].n,
-					      at91rm9200_systemck[i].p, NULL,
+					      NULL, at91rm9200_systemck[i].parent_hw,
 					      at91rm9200_systemck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -193,7 +207,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91rm9200_periphck[i].n,
-						  "masterck_div", NULL,
+						  NULL, at91rm9200_pmc->chws[PMC_MCK],
 						  at91rm9200_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.39.2

