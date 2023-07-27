Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCCE7645CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjG0Fiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjG0FiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A163C2A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8c81e36c0so3590955ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436181; x=1691040981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OtWdYk/NDUHZT7tkNeY9e4iyBez1HDTbhZxXvmkFCQ=;
        b=QD2NBMhcRdYlRqIaz5M+38+QVNqIRmBZ0lnr4SBGwDgdbRbf4LKlXyS0BgCs/Nl+n7
         jphVTSvTeDMjl40S9Np44r92m7n/69jucWK10YfeJfyoIYJ8xrvlN+tiqUikcehNCzL6
         zNpShJvyc9lamns5KnYqOKrI/40ke/aLuq55F7pvxoBsST3F5Ffz7ELx7WJfPx5aaMs/
         hUdl5o/tcVWa+BRYhQ19dZcNXUdH+jD6y234V3puOYK4ZR7lWvuCN8NfpYGeRWcX6bdk
         BZ/ieMr6/29F1C2gKpSD0cE3GYaeH/HZpWYBZ+9v/YcSrjdgkChor5HtLNgNB1HP80J4
         UX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436181; x=1691040981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OtWdYk/NDUHZT7tkNeY9e4iyBez1HDTbhZxXvmkFCQ=;
        b=I651JkSwNWBNf7QDHFaCg/2/W5suAmSE/eqYtYgbSvT3ynlsPOmV7x4zXJr0HzLOOY
         aTdzWp1AN5m96COCQo3RrLV5bxWslTBKAMPFP4xpepc/K73il833LIpPX3HOjB3sJTVH
         du/xd9cKlCsbopOmtJ8Q3kDoFGdLiuEjADlZsV7QuR4XQL+QVdsupuzp8631ntVG0r7b
         SlZ2nsFq3QdwgtzeRZOAKRAIZVctCNHI0WV91mqHK6A1VuJZsophdoVSWRtJyu9k/xDx
         ZaEtQret3FQe4rGKq8crBAj9uLXtS5GaczQw2FYRi+nlcMzwzeLylHkQzPeeEa6aoAsg
         +pQA==
X-Gm-Message-State: ABy/qLZQg9YxhwNpx6c/xzGkTsPc/Yy5yGOXJ2oW0SF3CDOSwDMyPhNh
        MVTv6UP13qXjrDhf8y/zz4VTzQ==
X-Google-Smtp-Source: APBJJlFyN5WzNPTb08+mhYuBXBaQ2MgG4ob8LHeDLIDS+aMaWBB100k5LIj1rMlOoz9pNp5M0ooS4w==
X-Received: by 2002:a17:902:da82:b0:1bb:c7bc:ceb4 with SMTP id j2-20020a170902da8200b001bbc7bcceb4mr4198969plx.60.1690436181683;
        Wed, 26 Jul 2023 22:36:21 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:21 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 32/42] clk: at91: clk-master: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:46 +0300
Message-Id: <20230727053156.13587-33-claudiu.beznea@tuxon.dev>
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
platforms using clk-master driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c  |  4 ++--
 drivers/clk/at91/at91sam9260.c |  5 ++---
 drivers/clk/at91/at91sam9g45.c |  5 ++---
 drivers/clk/at91/at91sam9n12.c |  5 ++---
 drivers/clk/at91/at91sam9rl.c  |  5 ++---
 drivers/clk/at91/at91sam9x5.c  |  4 ++--
 drivers/clk/at91/clk-master.c  | 23 ++++++-----------------
 drivers/clk/at91/dt-compat.c   |  4 ++--
 drivers/clk/at91/pmc.h         |  6 ++----
 drivers/clk/at91/sam9x60.c     |  4 ++--
 drivers/clk/at91/sama5d2.c     |  4 ++--
 drivers/clk/at91/sama5d3.c     |  5 ++---
 drivers/clk/at91/sama5d4.c     |  4 ++--
 drivers/clk/at91/sama7g5.c     |  5 ++---
 14 files changed, 32 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 441b744eed5e..9e32189ac374 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -147,14 +147,14 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	parent_hws[2] = at91rm9200_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = at91rm9200_pmc->chws[PMC_PLLBCK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91rm9200_master_layout,
 					   &rm9200_mck_characteristics,
 					   &rm9200_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91rm9200_master_layout,
 					  &rm9200_mck_characteristics,
 					  &rm9200_mck_lock, CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 709f01c4dab9..538bbecdbdeb 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -419,15 +419,14 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	parent_hws[2] = at91sam9260_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = at91sam9260_pmc->chws[PMC_PLLBCK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91rm9200_master_layout,
 					   data->mck_characteristics,
 					   &at91sam9260_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91rm9200_master_layout,
 					  data->mck_characteristics,
 					  &at91sam9260_mck_lock,
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 535f3af23560..fbd4d68dae56 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -163,15 +163,14 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	parent_hws[2] = at91sam9g45_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = at91sam9g45_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91rm9200_master_layout,
 					   &mck_characteristics,
 					   &at91sam9g45_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91rm9200_master_layout,
 					  &mck_characteristics,
 					  &at91sam9g45_mck_lock,
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index 9327129d574e..e9b266d1de91 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -190,15 +190,14 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 	parent_hws[2] = at91sam9n12_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = at91sam9n12_pmc->chws[PMC_PLLBCK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics,
 					   &at91sam9n12_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics,
 					  &at91sam9n12_mck_lock,
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 67ff1132ef0d..1e027fa938b6 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -123,15 +123,14 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	parent_hws[2] = at91sam9rl_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = at91sam9rl_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91rm9200_master_layout,
 					   &sam9rl_mck_characteristics,
 					   &sam9rl_mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91rm9200_master_layout,
 					  &sam9rl_mck_characteristics,
 					  &sam9rl_mck_lock, CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 7c08a5bdb974..27c41fc7b097 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -211,13 +211,13 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 	parent_hws[2] = at91sam9x5_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = at91sam9x5_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 15c46489ba85..1ee19c670213 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -472,7 +472,6 @@ static const struct clk_ops master_pres_ops = {
 static struct clk_hw * __init
 at91_clk_register_master_internal(struct regmap *regmap,
 		const char *name, int num_parents,
-		const char **parent_names,
 		struct clk_hw **parent_hws,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
@@ -485,7 +484,7 @@ at91_clk_register_master_internal(struct regmap *regmap,
 	unsigned long irqflags;
 	int ret;
 
-	if (!name || !num_parents || !(parent_names || parent_hws) || !lock)
+	if (!name || !num_parents || !parent_hws || !lock)
 		return ERR_PTR(-EINVAL);
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -494,10 +493,7 @@ at91_clk_register_master_internal(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = flags;
 
@@ -530,22 +526,20 @@ at91_clk_register_master_internal(struct regmap *regmap,
 struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap,
 		const char *name, int num_parents,
-		const char **parent_names,
 		struct clk_hw **parent_hws,
 		const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		spinlock_t *lock)
 {
 	return at91_clk_register_master_internal(regmap, name, num_parents,
-						 parent_names, parent_hws, layout,
+						 parent_hws, layout,
 						 characteristics,
 						 &master_pres_ops,
 						 lock, CLK_SET_RATE_GATE);
 }
 
 struct clk_hw * __init
-at91_clk_register_master_div(struct regmap *regmap,
-		const char *name, const char *parent_name,
+at91_clk_register_master_div(struct regmap *regmap, const char *name,
 		struct clk_hw *parent_hw, const struct clk_master_layout *layout,
 		const struct clk_master_characteristics *characteristics,
 		spinlock_t *lock, u32 flags, u32 safe_div)
@@ -559,7 +553,6 @@ at91_clk_register_master_div(struct regmap *regmap,
 		ops = &master_div_ops_chg;
 
 	hw = at91_clk_register_master_internal(regmap, name, 1,
-					       parent_name ? &parent_name : NULL,
 					       parent_hw ? &parent_hw : NULL, layout,
 					       characteristics, ops,
 					       lock, flags);
@@ -811,7 +804,6 @@ static const struct clk_ops sama7g5_master_ops = {
 struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
 				 const char *name, int num_parents,
-				 const char **parent_names,
 				 struct clk_hw **parent_hws,
 				 u32 *mux_table,
 				 spinlock_t *lock, u8 id,
@@ -824,7 +816,7 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 	unsigned int val;
 	int ret;
 
-	if (!name || !num_parents || !(parent_names || parent_hws) || !mux_table ||
+	if (!name || !num_parents || !parent_hws || !mux_table ||
 	    !lock || id > MASTER_MAX_ID)
 		return ERR_PTR(-EINVAL);
 
@@ -834,10 +826,7 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 
 	init.name = name;
 	init.ops = &sama7g5_master_ops;
-	if (parent_hws)
-		init.parent_hws = (const struct clk_hw **)parent_hws;
-	else
-		init.parent_names = parent_names;
+	init.parent_hws = (const struct clk_hw **)parent_hws;
 	init.num_parents = num_parents;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
 	if (chg_pid >= 0)
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 2bd3ad0a11fd..590d0f115647 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -487,12 +487,12 @@ of_at91_clk_master_setup(struct device_node *np,
 		return;
 
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", num_parents,
-					   NULL, parent_hws, layout,
+					   parent_hws, layout,
 					   characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto out_free_characteristics;
 
-	hw = at91_clk_register_master_div(regmap, name, NULL, hw,
+	hw = at91_clk_register_master_div(regmap, name, hw,
 					  layout, characteristics,
 					  &mck_lock, CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0b4de5648944..c26dcbc8c475 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -171,15 +171,14 @@ at91_clk_register_sam9x5_main(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_master_pres(struct regmap *regmap, const char *name,
-			      int num_parents, const char **parent_names,
-			      struct clk_hw **parent_hws,
+			      int num_parents, struct clk_hw **parent_hws,
 			      const struct clk_master_layout *layout,
 			      const struct clk_master_characteristics *characteristics,
 			      spinlock_t *lock);
 
 struct clk_hw * __init
 at91_clk_register_master_div(struct regmap *regmap, const char *name,
-			     const char *parent_names, struct clk_hw *parent_hw,
+			     struct clk_hw *parent_hw,
 			     const struct clk_master_layout *layout,
 			     const struct clk_master_characteristics *characteristics,
 			     spinlock_t *lock, u32 flags, u32 safe_div);
@@ -187,7 +186,6 @@ at91_clk_register_master_div(struct regmap *regmap, const char *name,
 struct clk_hw * __init
 at91_clk_sama7g5_register_master(struct regmap *regmap,
 				 const char *name, int num_parents,
-				 const char **parent_names,
 				 struct clk_hw **parent_hws, u32 *mux_table,
 				 spinlock_t *lock, u8 id, bool critical,
 				 int chg_pid);
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index dbf9841d341f..ce54684e4684 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -285,13 +285,13 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 	parent_hws[1] = sam9x60_pmc->chws[PMC_MAIN];
 	parent_hws[2] = sam9x60_pmc->chws[PMC_PLLACK];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 3,
-					   NULL, parent_hws, &sam9x60_master_layout,
+					   parent_hws, &sam9x60_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw, &sam9x60_master_layout,
+					  hw, &sam9x60_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
 	if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index eda45c5b75f9..a25184ea7aef 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -265,13 +265,13 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	parent_hws[2] = sama5d2_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = sama5d2_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 1a149e428971..5c0ef9416370 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -190,14 +190,13 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 	parent_hws[2] = sama5d3_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = sama5d3_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div",
-					  NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 71fd5714ce31..88841d7d5477 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -205,13 +205,13 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 	parent_hws[2] = sama5d4_pmc->chws[PMC_PLLACK];
 	parent_hws[3] = sama5d4_pmc->chws[PMC_UTMI];
 	hw = at91_clk_register_master_pres(regmap, "masterck_pres", 4,
-					   NULL, parent_hws,
+					   parent_hws,
 					   &at91sam9x5_master_layout,
 					   &mck_characteristics, &mck_lock);
 	if (IS_ERR(hw))
 		goto err_free;
 
-	hw = at91_clk_register_master_div(regmap, "masterck_div", NULL, hw,
+	hw = at91_clk_register_master_div(regmap, "masterck_div", hw,
 					  &at91sam9x5_master_layout,
 					  &mck_characteristics, &mck_lock,
 					  CLK_SET_RATE_GATE, 0);
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index a6a79d1450ec..d18b2b7885e0 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1103,8 +1103,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		}
 	}
 
-	hw = at91_clk_register_master_div(regmap, "mck0", NULL,
-					  sama7g5_plls[PLL_ID_CPU][1].hw,
+	hw = at91_clk_register_master_div(regmap, "mck0", sama7g5_plls[PLL_ID_CPU][1].hw,
 					  &mck0_layout, &mck0_characteristics,
 					  &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
 	if (IS_ERR(hw))
@@ -1138,7 +1137,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 				   sama7g5_mckx[i].ep_count);
 
 		hw = at91_clk_sama7g5_register_master(regmap, sama7g5_mckx[i].n,
-				   num_parents, NULL, parent_hws, mux_table,
+				   num_parents, parent_hws, mux_table,
 				   &pmc_mckX_lock, sama7g5_mckx[i].id,
 				   sama7g5_mckx[i].c,
 				   sama7g5_mckx[i].ep_chg_id);
-- 
2.39.2

