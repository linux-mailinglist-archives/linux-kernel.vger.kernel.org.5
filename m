Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D907645E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjG0FlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjG0Fkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:40:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4758468A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:39:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55bac17b442so375914a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436256; x=1691041056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGj8fnk95YF2UgdI2+UIkZtkwoXa64ISRzxRMHwyox0=;
        b=Ywm0o4powSfA2UBaRTJ5e3QOp6qBwwzYfKaQmkfZK/cBIgZdByQLZqDG7g9hldVmrK
         LKfjfKHmR2IiQ/fRAOkdCtHvT7hGVEOHfPjw4z9qJcpoQaDxBaO/lVEoftBYH1QZoagv
         3M+aB/7QeDbpipvYgJez7zdvLG8usjeXwsWeIKaeRK6hdfC3KFeCrk/iU4R1VLMw+22r
         cKNyIA0EtTZrh6B9awVPGuC7Gn+GnvldlKxwprAE6+FGOuZIOVr0TikSguzyb0A9/F3f
         qdnIOg2GLQRDiVojDSeSbSUN1kOm8vQ9QO6+wrqu0NBtZhomZyHr/pKAKCvp22T3a00q
         1smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436256; x=1691041056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGj8fnk95YF2UgdI2+UIkZtkwoXa64ISRzxRMHwyox0=;
        b=gvnEzo7EQvuD8a2P1rj8Jb5j2Y8+6guBfOREk0G8WRJbIV+oeqkE/3J5IllZ8QoIto
         jxieTVqNHPBOK2Y9wQWBOJkNBYCkzSSJ7vcH/UaTjkD1DCpH8GgC+88V6Nxmm8Vkk1fN
         tjqplINMjD4Ev3yf8RVFuq8htApQCiidY9LTb2Kabh6EgklRnyKnA5SV1j0mJgAgb0Tl
         QAhyg6sFIUA6m/efMT96Dx7OXRnV5yJmhnt1vyuE4/1k/FYuOpML1bv8jfws1yrj8CnB
         ugkZFWRqu6MkmIAXnOMR18CEXZuiFWT2sfrzJrTJQqziw0k19+T86IHuSqNjv0lhikRz
         0lRg==
X-Gm-Message-State: ABy/qLZ2+irvwqw16sz+uBt+O9jVS/NsEbcahBR+siqJs/FKCoGO2esA
        TchdSkG8NdSfkU7zYBQbwXQttA==
X-Google-Smtp-Source: APBJJlFvFb4k1Z2ecpW1EVwDrhqZYgAuvp4+vjV9Qd1lMw5gzgmBXW6LFcQ6J7aI7tCDRnM60zb36Q==
X-Received: by 2002:a17:90a:df86:b0:267:f99f:492f with SMTP id p6-20020a17090adf8600b00267f99f492fmr3348479pjv.48.1690436256696;
        Wed, 26 Jul 2023 22:37:36 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:37:36 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 42/42] clk: at91: clk-utmi: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:56 +0300
Message-Id: <20230727053156.13587-43-claudiu.beznea@tuxon.dev>
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
platforms using clk-utmi driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91sam9g45.c |  2 +-
 drivers/clk/at91/at91sam9rl.c  |  2 +-
 drivers/clk/at91/at91sam9x5.c  |  2 +-
 drivers/clk/at91/clk-utmi.c    | 23 ++++++++---------------
 drivers/clk/at91/dt-compat.c   |  2 +-
 drivers/clk/at91/pmc.h         |  5 ++---
 drivers/clk/at91/sama5d2.c     |  2 +-
 drivers/clk/at91/sama5d3.c     |  2 +-
 drivers/clk/at91/sama5d4.c     |  2 +-
 drivers/clk/at91/sama7g5.c     |  2 +-
 10 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index 1e5262b678f5..1a20ce75201b 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -152,7 +152,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 
 	at91sam9g45_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, at91sam9g45_pmc->chws[PMC_MAIN]);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", at91sam9g45_pmc->chws[PMC_MAIN]);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index eaa757f6670a..05ea2bf3c73b 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -112,7 +112,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 
 	at91sam9rl_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, at91sam9rl_pmc->chws[PMC_MAIN]);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", at91sam9rl_pmc->chws[PMC_MAIN]);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 1968dd69fbf7..b3a7d5803168 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -200,7 +200,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 
 	at91sam9x5_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, at91sam9x5_pmc->chws[PMC_MAIN]);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", at91sam9x5_pmc->chws[PMC_MAIN]);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index 40c84f5af5e8..8e2cf4893609 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -143,8 +143,7 @@ static const struct clk_ops utmi_ops = {
 static struct clk_hw * __init
 at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 				struct regmap *regmap_sfr,
-				const char *name, const char *parent_name,
-				struct clk_hw *parent_hw,
+				const char *name, struct clk_hw *parent_hw,
 				const struct clk_ops *ops, unsigned long flags)
 {
 	struct clk_utmi *utmi;
@@ -152,7 +151,7 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 	struct clk_init_data init = {};
 	int ret;
 
-	if (!(parent_name || parent_hw))
+	if (!parent_hw)
 		return ERR_PTR(-EINVAL);
 
 	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
@@ -161,13 +160,8 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 
 	init.name = name;
 	init.ops = ops;
-	if (parent_hw) {
-		init.parent_hws = parent_hw ? (const struct clk_hw **)&parent_hw : NULL;
-		init.num_parents = parent_hw ? 1 : 0;
-	} else {
-		init.parent_names = parent_name ? &parent_name : NULL;
-		init.num_parents = parent_name ? 1 : 0;
-	}
+	init.parent_hws = parent_hw ? (const struct clk_hw **)&parent_hw : NULL;
+	init.num_parents = parent_hw ? 1 : 0;
 	init.flags = flags;
 
 	utmi->hw.init = &init;
@@ -186,11 +180,10 @@ at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
 
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
-		       const char *name, const char *parent_name,
-		       struct clk_hw *parent_hw)
+		       const char *name, struct clk_hw *parent_hw)
 {
 	return at91_clk_register_utmi_internal(regmap_pmc, regmap_sfr, name,
-			parent_name, parent_hw, &utmi_ops, CLK_SET_RATE_GATE);
+			parent_hw, &utmi_ops, CLK_SET_RATE_GATE);
 }
 
 static int clk_utmi_sama7g5_prepare(struct clk_hw *hw)
@@ -289,8 +282,8 @@ static const struct clk_ops sama7g5_utmi_ops = {
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap_pmc, const char *name,
-			       const char *parent_name, struct clk_hw *parent_hw)
+			       struct clk_hw *parent_hw)
 {
 	return at91_clk_register_utmi_internal(regmap_pmc, NULL, name,
-			parent_name, parent_hw, &sama7g5_utmi_ops, 0);
+			parent_hw, &sama7g5_utmi_ops, 0);
 }
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 285ede5d6702..68211b36c8f6 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -1189,7 +1189,7 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
 			regmap_sfr = NULL;
 	}
 
-	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, NULL, parent_hw);
+	hw = at91_clk_register_utmi(regmap_pmc, regmap_sfr, name, parent_hw);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 5e65f5b59536..889230d29bf2 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -263,11 +263,10 @@ at91rm9200_clk_register_usb(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
-		       const char *name, const char *parent_name,
-		       struct clk_hw *parent_hw);
+		       const char *name, struct clk_hw *parent_hw);
 
 struct clk_hw * __init
 at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *name,
-			       const char *parent_name, struct clk_hw *parent_hw);
+			       struct clk_hw *parent_hw);
 
 #endif /* __PMC_H_ */
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index fa14c6f7d37a..cf1f34a69862 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -253,7 +253,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap_sfr))
 		regmap_sfr = NULL;
 
-	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick", NULL,
+	hw = at91_clk_register_utmi(regmap, regmap_sfr, "utmick",
 				    sama5d2_pmc->chws[PMC_MAIN]);
 	if (IS_ERR(hw))
 		goto err_free;
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 0713a6b21c8a..707e501b1a73 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -179,7 +179,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 
 	sama5d3_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, mainck_hw);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", mainck_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index d0bd025876ac..542c7cccda46 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -194,7 +194,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 
 	sama5d4_pmc->chws[PMC_PLLACK] = hw;
 
-	hw = at91_clk_register_utmi(regmap, NULL, "utmick", NULL, mainck_hw);
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", mainck_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 61f7027f1033..012e992ce14b 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1151,7 +1151,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 			sama7g5_pmc->chws[sama7g5_mckx[i].eid] = hw;
 	}
 
-	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", NULL, main_xtal_hw);
+	hw = at91_clk_sama7g5_register_utmi(regmap, "utmick", main_xtal_hw);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.39.2

