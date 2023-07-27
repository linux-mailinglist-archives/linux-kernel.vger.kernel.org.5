Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913927645CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjG0Fij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjG0FiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987C3A8C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7658430eb5dso55871585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436174; x=1691040974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPKRD6M8sYpV7bnQLsbqFVgQafgsIsDaV98IpKMiI6g=;
        b=lYVAGJkyuE0KiNJzacX0O2CCrD7GP0MoLr4j0DgwcYwPphuk/mgM6ViG3oO5Qy+2Z4
         b6x00dJNZ80Ge3t0xPnGMR8Fw2x1NnC3Kgk4JC4aHuf57VyeaotqAfGtSZGA3SJoeNyQ
         VNq9U3bd6PzNtE5x572SeoDYaT6MLqNhkuzSAVSKsVNFjGzs3GR5gFZygOfB4eIn/IPZ
         c7jWQ8YPYhrTEA/P1H24hhDVvuEHzGAzvkrO0IR3HkytpXDJSTK8chdpOXYrGaeM+Q+i
         PmbCkiMSgsRAatgD4oxjDj+xYb8KECWI9fpmZNNdVXkMEO6ZsOFDcdEZTcaM35+SCY0S
         M1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436174; x=1691040974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPKRD6M8sYpV7bnQLsbqFVgQafgsIsDaV98IpKMiI6g=;
        b=bi1YsgTq73gRW1Q2aEkqHhWtFCF1buKhWiargmVvNna7M5kCXIOMqatvyDeNbuqLq9
         25Ww5fPu2P0y6HCPftdDgwadohfyAzV7PTJwenkssSoOcsAfZE9PBzIXOH1i8IfEdf7Z
         BdC/2s7EflkRK7eNXvAYEmResgR2WhmvRpaGCxURm1GVo28tMEd6RyoaPvSPGlFFqnqt
         gektkK5SRIcH8LoShShDQlmh3TcrQHGtSwuv6jioBcF9zcM+bZCt0F/fDiwJ6Pm3Mqx4
         1S1+PSWEuVuuwNwZoduV2ZAgiVD+xd9aTDUocYq4bvPEJe3/oYMMVx+reTxygjLw+qIr
         V0Gw==
X-Gm-Message-State: ABy/qLYiaF8B99LCaEzV/UivxOmeJ/wgJEoOZinhVFCgj71sp3FTPwFp
        +0u4NsXsvXkvp6n+7Ob/g9Ts4g==
X-Google-Smtp-Source: APBJJlEtKCCsCmYuKhGONio+jtko2qgCcabGtqrNTwQxSOALvyhmFcHjdkIhgyVQk6bAG4+Fvnbrfw==
X-Received: by 2002:a05:620a:2894:b0:765:a9d7:2ca2 with SMTP id j20-20020a05620a289400b00765a9d72ca2mr4698758qkp.48.1690436174497;
        Wed, 26 Jul 2023 22:36:14 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:14 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 31/42] clk: at91: clk-main: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:45 +0300
Message-Id: <20230727053156.13587-32-claudiu.beznea@tuxon.dev>
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

Remove parent_names support as parent_hw support is now available on all
platforms using clk-main driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c  |  4 ++--
 drivers/clk/at91/at91sam9260.c |  4 ++--
 drivers/clk/at91/at91sam9g45.c |  4 ++--
 drivers/clk/at91/at91sam9n12.c |  4 ++--
 drivers/clk/at91/at91sam9rl.c  |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  4 ++--
 drivers/clk/at91/clk-main.c    | 24 ++++++------------------
 drivers/clk/at91/dt-compat.c   |  7 +++----
 drivers/clk/at91/pmc.h         |  3 ---
 drivers/clk/at91/sam9x60.c     |  5 ++---
 drivers/clk/at91/sama5d2.c     |  4 ++--
 drivers/clk/at91/sama5d3.c     |  4 ++--
 drivers/clk/at91/sama5d4.c     |  4 ++--
 drivers/clk/at91/sama7g5.c     |  4 ++--
 14 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index e0418ab5d65c..441b744eed5e 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -115,12 +115,12 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 						 bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, main_osc_hw);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", main_osc_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 1ef7c02bee63..709f01c4dab9 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -369,12 +369,12 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, hw);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 868897fad3f0..535f3af23560 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -130,12 +130,12 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 					bypass);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, hw);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 01d943ebb680..9327129d574e 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -154,14 +154,14 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 						 bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 29f24a5b1fef..67ff1132ef0d 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -98,7 +98,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	if (!at91sam9rl_pmc)
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, "mainck", NULL, main_xtal_hw);
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", main_xtal_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 8b2747091b03..7c08a5bdb974 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -176,14 +176,14 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 						 bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 9b462becc693..e4ebc9f88e46 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -151,7 +151,6 @@ static const struct clk_ops main_osc_ops = {
 struct clk_hw * __init
 at91_clk_register_main_osc(struct regmap *regmap,
 			   const char *name,
-			   const char *parent_name,
 			   struct clk_parent_data *parent_data,
 			   bool bypass)
 {
@@ -160,7 +159,7 @@ at91_clk_register_main_osc(struct regmap *regmap,
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !(parent_name || parent_data))
+	if (!name || !parent_data)
 		return ERR_PTR(-EINVAL);
 
 	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
@@ -169,10 +168,7 @@ at91_clk_register_main_osc(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &main_osc_ops;
-	if (parent_data)
-		init.parent_data = (const struct clk_parent_data *)parent_data;
-	else
-		init.parent_names = &parent_name;
+	init.parent_data = (const struct clk_parent_data *)parent_data;
 	init.num_parents = 1;
 	init.flags = CLK_IGNORE_UNUSED;
 
@@ -401,7 +397,6 @@ static const struct clk_ops rm9200_main_ops = {
 struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
-			      const char *parent_name,
 			      struct clk_hw *parent_hw)
 {
 	struct clk_rm9200_main *clkmain;
@@ -412,7 +407,7 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!(parent_name || parent_hw))
+	if (!parent_hw)
 		return ERR_PTR(-EINVAL);
 
 	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
@@ -421,10 +416,7 @@ at91_clk_register_rm9200_main(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &rm9200_main_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	init.flags = 0;
 
@@ -551,7 +543,6 @@ static const struct clk_ops sam9x5_main_ops = {
 struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap,
 			      const char *name,
-			      const char **parent_names,
 			      struct clk_hw **parent_hws,
 			      int num_parents)
 {
@@ -564,7 +555,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 	if (!name)
 		return ERR_PTR(-EINVAL);
 
-	if (!(parent_hws || parent_names) || !num_parents)
+	if (!parent_hws || !num_parents)
 		return ERR_PTR(-EINVAL);
 
 	clkmain = kzalloc(sizeof(*clkmain), GFP_KERNEL);
@@ -573,10 +564,7 @@ at91_clk_register_sam9x5_main(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sam9x5_main_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_PARENT_GATE;
 
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 7ab116a6e701..2bd3ad0a11fd 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -314,7 +314,7 @@ static void __init of_at91rm9200_clk_main_osc_setup(struct device_node *np)
 
 	parent_data.name = parent_name;
 	parent_data.fw_name = parent_name;
-	hw = at91_clk_register_main_osc(regmap, name, NULL, &parent_data, bypass);
+	hw = at91_clk_register_main_osc(regmap, name, &parent_data, bypass);
 	if (IS_ERR(hw))
 		return;
 
@@ -375,7 +375,7 @@ static void __init of_at91rm9200_clk_main_setup(struct device_node *np)
 	if (!parent_hw)
 		return;
 
-	hw = at91_clk_register_rm9200_main(regmap, name, NULL, parent_hw);
+	hw = at91_clk_register_rm9200_main(regmap, name, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
@@ -414,8 +414,7 @@ static void __init of_at91sam9x5_clk_main_setup(struct device_node *np)
 
 	of_property_read_string(np, "clock-output-names", &name);
 
-	hw = at91_clk_register_sam9x5_main(regmap, name, NULL, parent_hws,
-					   num_parents);
+	hw = at91_clk_register_sam9x5_main(regmap, name, parent_hws, num_parents);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 07f372abcfd0..0b4de5648944 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -160,16 +160,13 @@ at91_clk_register_main_rc_osc(struct regmap *regmap, const char *name,
 			      u32 frequency, u32 accuracy);
 struct clk_hw * __init
 at91_clk_register_main_osc(struct regmap *regmap, const char *name,
-			   const char *parent_name,
 			   struct clk_parent_data *parent_data, bool bypass);
 struct clk_hw * __init
 at91_clk_register_rm9200_main(struct regmap *regmap,
 			      const char *name,
-			      const char *parent_name,
 			      struct clk_hw *parent_hw);
 struct clk_hw * __init
 at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
-			      const char **parent_names,
 			      struct clk_hw **parent_hws, int num_parents);
 
 struct clk_hw * __init
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index 43997f686b87..dbf9841d341f 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -225,14 +225,13 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
-						 &parent_data, 0);
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data, 0);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 17a40cedd7fb..eda45c5b75f9 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -209,14 +209,14 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 						 bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index e1c1ba907e3a..1a149e428971 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -157,14 +157,14 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 						 bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(mainck_hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index b4375cb1c3f3..71fd5714ce31 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -172,14 +172,14 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL, &parent_data,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", &parent_data,
 						 bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	mainck_hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index b2d27193741b..a6a79d1450ec 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1037,14 +1037,14 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 
 	parent_data.name = main_xtal_name;
 	parent_data.fw_name = main_xtal_name;
-	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc", NULL,
+	main_osc_hw = at91_clk_register_main_osc(regmap, "main_osc",
 						 &parent_data, bypass);
 	if (IS_ERR(main_osc_hw))
 		goto err_free;
 
 	parent_hws[0] = main_rc_hw;
 	parent_hws[1] = main_osc_hw;
-	hw = at91_clk_register_sam9x5_main(regmap, "mainck", NULL, parent_hws, 2);
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_hws, 2);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.39.2

