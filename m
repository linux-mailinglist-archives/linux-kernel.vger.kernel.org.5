Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664837645AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjG0FgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjG0Ffx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:35:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4833C02
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:35:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbc7b2133fso3474395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436094; x=1691040894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBbNugk5HlQlfZHqiOgCV5xi8h3KCTbkMOfTcf6vRhA=;
        b=Id14NP7yd/JImdN8lyAnXofVzX4iaeIgUf9JDxY6LmHBdN3I3aS4+ju0haYsHe0p4O
         R25ny66K46hZ6FcqWIzeG5IRTHDFkGhw2r6xnkmWxb9rG4MoMOlmS+IhucZuHlEhNOeA
         d9g2DSO6oT8sVGbxBNznGD0FkGfWtou4JIcMDRIpZ4J8YTRmjV3NeGnrY3N4tJTf49Ks
         OG1o36YclVqsj3xGm4CcLcO8ixR0jjlbxxMn+wXycc8vj3ENto2eL7zLIFOIx0ooe5cM
         fBhHXOcyoAfPRlIOAL0JI0OUDsxgLQS4X0Uo7HGMpBbffrYkBPF8M9oh9sW27JzkrsSm
         F/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436094; x=1691040894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBbNugk5HlQlfZHqiOgCV5xi8h3KCTbkMOfTcf6vRhA=;
        b=M5IMrUB3wj9C+f1zScWUKTFkJSqNvNSOp7JtjEEkw1f8lV3soBRet573hLnFuTrciO
         YvUDXyGhvrY+Y3DC9Qt3ygOpYWW0AfX3heMsM05YszgjPSJh3Dd0yzuYpeTR9JE0LcLZ
         gqEn7RbDbplWeuEyq7DoSiEmPg+MtXMGGNmvio9x/tHpuk0G80tMx49HeZEdcQXlQTWr
         Kh2Cxb78tt8YU+6czDP1jkhl7nl8PvhLsnwIV0jIoDbjjtMK+8FO/l5fIOUpuaROCTaJ
         k7Z+uF23YrhuziERskb6H3VUL60XGL5ZdvI8xgvtDcOuO7aFdRuw1+ucGXzO77ezdn2B
         5NIg==
X-Gm-Message-State: ABy/qLbXdI8gLT1KU4xZ7bXpyZNmEWNiklw0u5bD2rwxCGYs4kMT9QBQ
        CUIKHQ6Lg1HW+1XCoLDFwC/2Wg==
X-Google-Smtp-Source: APBJJlFHB3fbxz9kQNZcbEoiaodWds/3Wlbiqfinvqoq5s0dSd6rVHUql6diHUdm1pZI7v0EJsUFwg==
X-Received: by 2002:a17:902:6ac3:b0:1b3:fafd:11c5 with SMTP id i3-20020a1709026ac300b001b3fafd11c5mr3247438plt.44.1690436093938;
        Wed, 26 Jul 2023 22:34:53 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:34:53 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 20/42] clk: at91: at91sam9260: switch to parent_hw and parent_data
Date:   Thu, 27 Jul 2023 08:31:34 +0300
Message-Id: <20230727053156.13587-21-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch AT91SAM92600 clocks to use parent_hw and parent_data. Having
parent_hw instead of parent names improves to clock registration
speed and re-parenting.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9260.c | 139 ++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 55350331b07e..1ef7c02bee63 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/slab.h>
@@ -9,7 +10,7 @@
 
 struct sck {
 	char *n;
-	char *p;
+	struct clk_hw *parent_hw;
 	u8 id;
 };
 
@@ -24,7 +25,7 @@ struct at91sam926x_data {
 	const struct clk_pll_layout *pllb_layout;
 	const struct clk_pll_characteristics *pllb_characteristics;
 	const struct clk_master_characteristics *mck_characteristics;
-	const struct sck *sck;
+	struct sck *sck;
 	const struct pck *pck;
 	u8 num_sck;
 	u8 num_pck;
@@ -72,11 +73,11 @@ static const struct clk_pll_characteristics sam9260_pllb_characteristics = {
 	.out = sam9260_pllb_out,
 };
 
-static const struct sck at91sam9260_systemck[] = {
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+static struct sck at91sam9260_systemck[] = {
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
 };
 
 static const struct pck at91sam9260_periphck[] = {
@@ -213,15 +214,15 @@ static const struct clk_pll_characteristics sam9261_pllb_characteristics = {
 	.out = sam9261_pllb_out,
 };
 
-static const struct sck at91sam9261_systemck[] = {
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
-	{ .n = "pck2",  .p = "prog2",    .id = 10 },
-	{ .n = "pck3",  .p = "prog3",    .id = 11 },
-	{ .n = "hclk0", .p = "masterck_div", .id = 16 },
-	{ .n = "hclk1", .p = "masterck_div", .id = 17 },
+static struct sck at91sam9261_systemck[] = {
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "pck3",  .id = 11 },
+	{ .n = "hclk0", .id = 16 },
+	{ .n = "hclk1", .id = 17 },
 };
 
 static const struct pck at91sam9261_periphck[] = {
@@ -277,13 +278,13 @@ static const struct clk_pll_characteristics sam9263_pll_characteristics = {
 	.out = sam9260_plla_out,
 };
 
-static const struct sck at91sam9263_systemck[] = {
-	{ .n = "uhpck", .p = "usbck",    .id = 6 },
-	{ .n = "udpck", .p = "usbck",    .id = 7 },
-	{ .n = "pck0",  .p = "prog0",    .id = 8 },
-	{ .n = "pck1",  .p = "prog1",    .id = 9 },
-	{ .n = "pck2",  .p = "prog2",    .id = 10 },
-	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+static struct sck at91sam9263_systemck[] = {
+	{ .n = "uhpck", .id = 6 },
+	{ .n = "udpck", .id = 7 },
+	{ .n = "pck0",  .id = 8 },
+	{ .n = "pck1",  .id = 9 },
+	{ .n = "pck2",  .id = 10 },
+	{ .n = "pck3",  .id = 11 },
 };
 
 static const struct pck at91sam9263_periphck[] = {
@@ -329,26 +330,29 @@ static struct at91sam926x_data at91sam9263_data = {
 static void __init at91sam926x_pmc_setup(struct device_node *np,
 					 struct at91sam926x_data *data)
 {
-	const char *slowxtal_name, *mainxtal_name;
+	struct clk_hw *slow_xtal_hw, *main_xtal_hw;
+	struct clk_hw *parent_hws[4], *usbck_hw, *hw;
+	static struct clk_parent_data parent_data;
+	const char *main_xtal_name = "main_xtal";
 	struct pmc_data *at91sam9260_pmc;
 	u32 usb_div[] = { 1, 2, 4, 0 };
-	const char *parent_names[6];
-	const char *slck_name;
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
@@ -363,12 +367,14 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	bypass = of_property_read_bool(np, "atmel,osc-bypass");
 
-	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL,
+	parent_data.name = main_xtal_name;
+	parent_data.fw_name = main_xtal_name;
+	hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc", NULL);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
@@ -382,20 +388,17 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		if (IS_ERR(hw))
 			goto err_free;
 
-		parent_names[0] = "slow_rc_osc";
-		parent_names[1] = "slow_xtal";
-		hw = at91_clk_register_sam9260_slow(regmap, "slck",
-						    parent_names, NULL, 2);
+		parent_hws[0] = hw;
+		parent_hws[1] = slow_xtal_hw;
+		hw = at91_clk_register_sam9260_slow(regmap, "slck", NULL, parent_hws, 2);
 		if (IS_ERR(hw))
 			goto err_free;
 
 		at91sam9260_pmc->chws[PMC_SLOW] = hw;
-		slck_name = "slck";
-	} else {
-		slck_name = slowxtal_name;
+		slow_xtal_hw = hw;
 	}
 
-	hw = at91_clk_register_pll(regmap, "pllack", "mainck", NULL, 0,
+	hw = at91_clk_register_pll(regmap, "pllack", NULL, at91sam9260_pmc->chws[PMC_MAIN], 0,
 				   data->plla_layout,
 				   data->plla_characteristics);
 	if (IS_ERR(hw))
@@ -403,7 +406,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", NULL, 1,
+	hw = at91_clk_register_pll(regmap, "pllbck", NULL, at91sam9260_pmc->chws[PMC_MAIN], 1,
 				   data->pllb_layout,
 				   data->pllb_characteristics);
 	if (IS_ERR(hw))
@@ -411,12 +414,12 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_PLLBCK] = hw;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_hws[0] = slow_xtal_hw;
+	parent_hws[1] = at91sam9260_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91sam9260_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91sam9260_pmc->chws[PMC_PLLBCK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   parent_names, NULL,
+					   NULL, parent_hws,
 					   &at91rm9200_master_layout,
 					   data->mck_characteristics,
 					   &at91sam9260_mck_lock);
@@ -424,7 +427,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  "masterck_pres", NULL,
+					  NULL, hw,
 					  &at91rm9200_master_layout,
 					  data->mck_characteristics,
 					  &at91sam9260_mck_lock,
@@ -434,21 +437,22 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	at91sam9260_pmc->chws[PMC_MCK] = hw;
 
-	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", NULL, usb_div);
-	if (IS_ERR(hw))
+	usbck_hw = at91rm9200_clk_register_usb(regmap, "usbck", NULL,
+					       at91sam9260_pmc->chws[PMC_PLLBCK], usb_div);
+	if (IS_ERR(usbck_hw))
 		goto err_free;
 
-	parent_names[0] = slck_name;
-	parent_names[1] = "mainck";
-	parent_names[2] = "pllack";
-	parent_names[3] = "pllbck";
+	parent_hws[0] = slow_xtal_hw;
+	parent_hws[1] = at91sam9260_pmc->chws[PMC_MAIN];
+	parent_hws[2] = at91sam9260_pmc->chws[PMC_PLLACK];
+	parent_hws[3] = at91sam9260_pmc->chws[PMC_PLLBCK];
 	for (i = 0; i < data->num_progck; i++) {
 		char name[6];
 
 		snprintf(name, sizeof(name), "prog%d", i);
 
 		hw = at91_clk_register_programmable(regmap, name,
-						    parent_names, NULL, 4, i,
+						    NULL, parent_hws, 4, i,
 						    &at91rm9200_programmable_layout,
 						    NULL);
 		if (IS_ERR(hw))
@@ -457,9 +461,22 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 		at91sam9260_pmc->pchws[i] = hw;
 	}
 
+	/* Set systemck parent hws. */
+	data->sck[0].parent_hw = usbck_hw;
+	data->sck[1].parent_hw = usbck_hw;
+	data->sck[2].parent_hw = at91sam9260_pmc->pchws[0];
+	data->sck[3].parent_hw = at91sam9260_pmc->pchws[1];
+	if (data->num_sck == 6) {
+		data->sck[4].parent_hw = at91sam9260_pmc->pchws[2];
+		data->sck[5].parent_hw = at91sam9260_pmc->pchws[3];
+	}
+	if (data->num_sck == 8) {
+		data->sck[6].parent_hw = at91sam9260_pmc->chws[PMC_MCK];
+		data->sck[7].parent_hw = at91sam9260_pmc->chws[PMC_MCK];
+	}
 	for (i = 0; i < data->num_sck; i++) {
 		hw = at91_clk_register_system(regmap, data->sck[i].n,
-					      data->sck[i].p, NULL,
+					      NULL, data->sck[i].parent_hw,
 					      data->sck[i].id, 0);
 		if (IS_ERR(hw))
 			goto err_free;
@@ -470,7 +487,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	for (i = 0; i < data->num_pck; i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  data->pck[i].n,
-						  "masterck_div", NULL,
+						  NULL, at91sam9260_pmc->chws[PMC_MCK],
 						  data->pck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
-- 
2.39.2

