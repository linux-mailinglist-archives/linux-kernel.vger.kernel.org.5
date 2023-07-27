Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7147645D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjG0FjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjG0Fie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB7A0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:41 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a425ef874dso555029b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436189; x=1691040989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHiZnC//dKhKHVPO0qNmCO5eqfKdG5DqSJMZ1aUfAvU=;
        b=XTzAZjbSrpWj9+zWSZTLphmvyX0gW2ZlfsxwTUDO8CbQmuQytLUbOi6j/FcxQFoZfZ
         XyA1sEfCbCquleeQFsOB0qBYMTvkeAddSMeczxr3pfyBkXyNEAUNRq42Tm/D38S0pPgQ
         OWWkqozWo7HPgwTOuOTPadQHEXKmb+0s5Dvs8bq7A71n1nDdUuoMAzVMfC2EQ2HWLAtR
         ShlLjVEhAoIjaXHCxBo57JaGB2GWIDkDZZcBFe+jPSPi2Y95lgq2p08LlZrIU1BqwUOS
         sCpLP3fA7ufQCjAWVR30Lzibvq4VClY/3vtTKaVDXQUbdiv6E8u05m/lohnmzLqlFFvr
         CcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436189; x=1691040989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHiZnC//dKhKHVPO0qNmCO5eqfKdG5DqSJMZ1aUfAvU=;
        b=JoClIazdt/qZllHWB91tXg4Qf2A/FGamC9f53D80V5fbkTGAzjXlpH8ZUgctE81KM3
         n8C/2hmKw2ezRnBXs2qThlRMBNDwvoCf/wNbgz0Ec4l8G+kexYoR8zgks5mMVCUWl/+D
         EAVNUpLeihauhy+J7JD+mEC3GZGMQLQrGUX+P+kKivyXEw5Z5k3/L+NWN/d+HieHHBkZ
         pvysX28XzPAiCcwrdH9uU2l4lU9b51r5T+FAesL+vjhQInFpnOwv5cNP8GdqgW3aEgkP
         AD9efv2+G93yC6GwLKsczxIk1GuD38DAJWA59BUvKZ+uhTeYayy5FybA4WoXCCGPa2lL
         G1bQ==
X-Gm-Message-State: ABy/qLYE+n97sDvvLLwykhPiqd9rHMq55BwLrfHg0bAyFoHGVXhHO6k/
        ogLHHHoLnUQGqNRyayN8Txf9gg==
X-Google-Smtp-Source: APBJJlGuQ00Fuq1b7Mx/AmGyo5y38uf06QC6VXRVfFWX5zi5TqxvXLHpcZKB5MuFsluVWmuXDtvvjQ==
X-Received: by 2002:a05:6808:428e:b0:3a4:8ac7:3407 with SMTP id dq14-20020a056808428e00b003a48ac73407mr1803669oib.42.1690436188765;
        Wed, 26 Jul 2023 22:36:28 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:28 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 33/42] clk: at91: clk-peripheral: remove parent_names support
Date:   Thu, 27 Jul 2023 08:31:47 +0300
Message-Id: <20230727053156.13587-34-claudiu.beznea@tuxon.dev>
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
platforms using clk-peripheral driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/at91rm9200.c     |  2 +-
 drivers/clk/at91/at91sam9260.c    |  2 +-
 drivers/clk/at91/at91sam9g45.c    |  2 +-
 drivers/clk/at91/at91sam9n12.c    |  2 +-
 drivers/clk/at91/at91sam9rl.c     |  2 +-
 drivers/clk/at91/at91sam9x5.c     |  4 ++--
 drivers/clk/at91/clk-peripheral.c | 20 ++++++--------------
 drivers/clk/at91/dt-compat.c      |  3 +--
 drivers/clk/at91/pmc.h            |  6 ++----
 drivers/clk/at91/sam9x60.c        |  2 +-
 drivers/clk/at91/sama5d2.c        |  4 ++--
 drivers/clk/at91/sama5d3.c        |  2 +-
 drivers/clk/at91/sama5d4.c        |  4 ++--
 drivers/clk/at91/sama7g5.c        |  1 -
 14 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
index 9e32189ac374..7cb90d71d0ce 100644
--- a/drivers/clk/at91/at91rm9200.c
+++ b/drivers/clk/at91/at91rm9200.c
@@ -207,7 +207,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91rm9200_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91rm9200_periphck[i].n,
-						  NULL, at91rm9200_pmc->chws[PMC_MCK],
+						  at91rm9200_pmc->chws[PMC_MCK],
 						  at91rm9200_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
index 538bbecdbdeb..9839bd4586cd 100644
--- a/drivers/clk/at91/at91sam9260.c
+++ b/drivers/clk/at91/at91sam9260.c
@@ -486,7 +486,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
 	for (i = 0; i < data->num_pck; i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  data->pck[i].n,
-						  NULL, at91sam9260_pmc->chws[PMC_MCK],
+						  at91sam9260_pmc->chws[PMC_MCK],
 						  data->pck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
index fbd4d68dae56..e7f2173ff6c1 100644
--- a/drivers/clk/at91/at91sam9g45.c
+++ b/drivers/clk/at91/at91sam9g45.c
@@ -225,7 +225,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9g45_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9g45_periphck[i].n,
-						  NULL, at91sam9g45_pmc->chws[PMC_MCK],
+						  at91sam9g45_pmc->chws[PMC_MCK],
 						  at91sam9g45_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
index e9b266d1de91..2d26c202b257 100644
--- a/drivers/clk/at91/at91sam9n12.c
+++ b/drivers/clk/at91/at91sam9n12.c
@@ -254,7 +254,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9n12_pcr_layout,
 							 at91sam9n12_periphck[i].n,
-							 NULL, at91sam9n12_pmc->chws[PMC_MCK],
+							 at91sam9n12_pmc->chws[PMC_MCK],
 							 at91sam9n12_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
index 1e027fa938b6..c7fc4bcf4e5b 100644
--- a/drivers/clk/at91/at91sam9rl.c
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -175,7 +175,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
 	for (i = 0; i < ARRAY_SIZE(at91sam9rl_periphck); i++) {
 		hw = at91_clk_register_peripheral(regmap,
 						  at91sam9rl_periphck[i].n,
-						  NULL, at91sam9rl_pmc->chws[PMC_MCK],
+						  at91sam9rl_pmc->chws[PMC_MCK],
 						  at91sam9rl_periphck[i].id);
 		if (IS_ERR(hw))
 			goto err_free;
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
index 27c41fc7b097..8da2732a73fa 100644
--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -287,7 +287,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9x5_pcr_layout,
 							 at91sam9x5_periphck[i].n,
-							 NULL, at91sam9x5_pmc->chws[PMC_MCK],
+							 at91sam9x5_pmc->chws[PMC_MCK],
 							 at91sam9x5_periphck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
@@ -300,7 +300,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &at91sam9x5_pcr_layout,
 							 extra_pcks[i].n,
-							 NULL, at91sam9x5_pmc->chws[PMC_MCK],
+							 at91sam9x5_pmc->chws[PMC_MCK],
 							 extra_pcks[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c173a44c800a..73c90fa535e0 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -97,15 +97,14 @@ static const struct clk_ops peripheral_ops = {
 
 struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
-			     const char *parent_name, struct clk_hw *parent_hw,
-			     u32 id)
+			     struct clk_hw *parent_hw, u32 id)
 {
 	struct clk_peripheral *periph;
 	struct clk_init_data init = {};
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !(parent_name || parent_hw) || id > PERIPHERAL_ID_MAX)
+	if (!name || !parent_hw || id > PERIPHERAL_ID_MAX)
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -114,10 +113,7 @@ at91_clk_register_peripheral(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &peripheral_ops;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	init.flags = 0;
 
@@ -447,8 +443,7 @@ static const struct clk_ops sam9x5_peripheral_chg_ops = {
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
-				    const char *name, const char *parent_name,
-				    struct clk_hw *parent_hw,
+				    const char *name, struct clk_hw *parent_hw,
 				    u32 id, const struct clk_range *range,
 				    int chg_pid, unsigned long flags)
 {
@@ -457,7 +452,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 	struct clk_hw *hw;
 	int ret;
 
-	if (!name || !(parent_name || parent_hw))
+	if (!name || !parent_hw)
 		return ERR_PTR(-EINVAL);
 
 	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
@@ -465,10 +460,7 @@ at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	if (parent_hw)
-		init.parent_hws = (const struct clk_hw **)&parent_hw;
-	else
-		init.parent_names = &parent_name;
+	init.parent_hws = (const struct clk_hw **)&parent_hw;
 	init.num_parents = 1;
 	init.flags = flags;
 	if (chg_pid < 0) {
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index 590d0f115647..8f67a7a94c54 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -561,7 +561,7 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 
 		if (type == PERIPHERAL_AT91RM9200) {
 			hw = at91_clk_register_peripheral(regmap, name,
-							  NULL, parent_hw, id);
+							  parent_hw, id);
 		} else {
 			struct clk_range range = CLK_RANGE(0, 0);
 			unsigned long flags = 0;
@@ -582,7 +582,6 @@ of_at91_clk_periph_setup(struct device_node *np, u8 type)
 								 &pmc_pcr_lock,
 								 &dt_pcr_layout,
 								 name,
-								 NULL,
 								 parent_hw,
 								 id, &range,
 								 INT_MIN,
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index c26dcbc8c475..54088c6d4de4 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -192,13 +192,11 @@ at91_clk_sama7g5_register_master(struct regmap *regmap,
 
 struct clk_hw * __init
 at91_clk_register_peripheral(struct regmap *regmap, const char *name,
-			     const char *parent_name, struct clk_hw *parent_hw,
-			     u32 id);
+			     struct clk_hw *parent_hw, u32 id);
 struct clk_hw * __init
 at91_clk_register_sam9x5_peripheral(struct regmap *regmap, spinlock_t *lock,
 				    const struct clk_pcr_layout *layout,
-				    const char *name, const char *parent_name,
-				    struct clk_hw *parent_hw,
+				    const char *name, struct clk_hw *parent_hw,
 				    u32 id, const struct clk_range *range,
 				    int chg_pid, unsigned long flags);
 
diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index ce54684e4684..148873fced1b 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -348,7 +348,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sam9x60_pcr_layout,
 							 sam9x60_periphck[i].n,
-							 NULL, sam9x60_pmc->chws[PMC_MCK],
+							 sam9x60_pmc->chws[PMC_MCK],
 							 sam9x60_periphck[i].id,
 							 &range, INT_MIN,
 							 sam9x60_periphck[i].flags);
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index a25184ea7aef..809926c63078 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -337,7 +337,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periphck[i].n,
-							 NULL, sama5d2_pmc->chws[PMC_MCK],
+							 sama5d2_pmc->chws[PMC_MCK],
 							 sama5d2_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d2_periphck[i].flags);
@@ -351,7 +351,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d2_pcr_layout,
 							 sama5d2_periph32ck[i].n,
-							 NULL, sama5d2_pmc->chws[PMC_MCK2],
+							 sama5d2_pmc->chws[PMC_MCK2],
 							 sama5d2_periph32ck[i].id,
 							 &sama5d2_periph32ck[i].r,
 							 INT_MIN, 0);
diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
index 5c0ef9416370..4453f47798b7 100644
--- a/drivers/clk/at91/sama5d3.c
+++ b/drivers/clk/at91/sama5d3.c
@@ -259,7 +259,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d3_pcr_layout,
 							 sama5d3_periphck[i].n,
-							 NULL, sama5d3_pmc->chws[PMC_MCK],
+							 sama5d3_pmc->chws[PMC_MCK],
 							 sama5d3_periphck[i].id,
 							 &sama5d3_periphck[i].r,
 							 INT_MIN,
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
index 88841d7d5477..9f6ad0699702 100644
--- a/drivers/clk/at91/sama5d4.c
+++ b/drivers/clk/at91/sama5d4.c
@@ -282,7 +282,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d4_pcr_layout,
 							 sama5d4_periphck[i].n,
-							 NULL, sama5d4_pmc->chws[PMC_MCK],
+							 sama5d4_pmc->chws[PMC_MCK],
 							 sama5d4_periphck[i].id,
 							 &range, INT_MIN,
 							 sama5d4_periphck[i].flags);
@@ -296,7 +296,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 							 &sama5d4_pcr_layout,
 							 sama5d4_periph32ck[i].n,
-							 NULL, sama5d4_pmc->chws[PMC_MCK2],
+							 sama5d4_pmc->chws[PMC_MCK2],
 							 sama5d4_periph32ck[i].id,
 							 &range, INT_MIN, 0);
 		if (IS_ERR(hw))
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index d18b2b7885e0..9cba1ad116a8 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -1195,7 +1195,6 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
 		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
 						&sama7g5_pcr_layout,
 						sama7g5_periphck[i].n,
-						NULL,
 						sama7g5_mckx[sama7g5_periphck[i].p].hw,
 						sama7g5_periphck[i].id,
 						&sama7g5_periphck[i].r,
-- 
2.39.2

