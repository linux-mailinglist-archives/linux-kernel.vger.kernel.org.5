Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93236764586
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjG0Fdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjG0Fdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:33:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A1E2D78
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b4748fe4so3783095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690435992; x=1691040792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p47IEHM+JZSsAANQ/kyvjM6x0oAWT/q0JwErNba07sU=;
        b=Jwa33zZJtyHQ6H92mgUKLxpuKwc455YJUiTrkI7z8K56ZNWLnw5UeW6SLUP+rNVRni
         IDIcwsZlCQLAQI/L8464HY/WPdd3RN4xbPZDGno3r3bdbezUcvwy+/pT17jiv3DW26Uk
         JYP9beEDushkyrKuTpEJaIBFNjnWn7q0ZRvV4hNcQX9wMPeavBy0K9hTbfXWnA8iosxR
         i3xQDBNBm6nMBkpozyoQJ0vRdI2KG68b1O2rX8lMxQej1bpkg95TAwAoCbeBPX17WXQI
         vrUYqrjnbTqwD0gCqWNILBwWsmF27jlAcQpSe23WxY7NRlxU6c9hx6ZEHQhPAZSI4eVW
         WVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690435992; x=1691040792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p47IEHM+JZSsAANQ/kyvjM6x0oAWT/q0JwErNba07sU=;
        b=XksGBddRmkstxZ+yLcM0EwQQe2WPKNN21JmdQmTwd4G5yhV+RDM9oYDtQQdTVkoC9p
         VaS6YYH1BUcvTPtryjmN3fEgMm4X4a2wYWFi1L9gEHFeFDuOXLCU8YdgeQbdumKIW5Uz
         Tfo7EiAcwp8Iol+Qp2Znu/O4wkLsLQRZaGeJEqHdvW0VkNjcQ+aCyvUq09CDsPAEF/91
         745lFW+jdCr6o7YNFkMnVl3MBkPAkNYvAldppW2hyu2JqdM9s2DEK+PntFrFKkLlKJp+
         SC79lUP8Up0+H43tAP2P0H3sgTKhwDupqpgB5NS8fphEtLJ33fG0PT6l57Pc8ywcW0cu
         OBnw==
X-Gm-Message-State: ABy/qLZBjHY/yLFcGVXM08WVgFwFPEAfBR1dVMPgaPIukQR6s0YJdIxn
        Zjpl1fuM221fecGcgHgjVEIzDA==
X-Google-Smtp-Source: APBJJlEpXgAf/SMRf0Z3BXR+DOQC2gQ41hjdzkvIn6yKyCoC8D2FLzqGxSICSduADERyliEuCcZ1sg==
X-Received: by 2002:a17:902:7795:b0:1b8:b827:aa8e with SMTP id o21-20020a170902779500b001b8b827aa8emr3089993pll.11.1690435992455;
        Wed, 26 Jul 2023 22:33:12 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:33:12 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 06/42] clk: at91: clk-audio-pll: add support for parent_hw
Date:   Thu, 27 Jul 2023 08:31:20 +0300
Message-Id: <20230727053156.13587-7-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parent_hw in audio pll clock drivers.
With this parent-child relation is described with pointers rather
than strings making registration a bit faster.

All the SoC based drivers that rely on clk-audio-pll were adapted
to the new API change. The switch itself for SoCs will be done
in subsequent patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/clk-audio-pll.c | 25 +++++++++++++++++--------
 drivers/clk/at91/dt-compat.c     |  6 +++---
 drivers/clk/at91/pmc.h           |  6 +++---
 drivers/clk/at91/sama5d2.c       |  6 +++---
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
index a92da64c12e1..7a13af95d628 100644
--- a/drivers/clk/at91/clk-audio-pll.c
+++ b/drivers/clk/at91/clk-audio-pll.c
@@ -450,7 +450,7 @@ static const struct clk_ops audio_pll_pmc_ops = {
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
-				 const char *parent_name)
+				 const char *parent_name, struct clk_hw *parent_hw)
 {
 	struct clk_audio_frac *frac_ck;
 	struct clk_init_data init = {};
@@ -462,7 +462,10 @@ at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &audio_pll_frac_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE;
 
@@ -480,10 +483,10 @@ at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
-				const char *parent_name)
+				const char *parent_name, struct clk_hw *parent_hw)
 {
 	struct clk_audio_pad *apad_ck;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
@@ -492,7 +495,10 @@ at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &audio_pll_pad_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		CLK_SET_RATE_PARENT;
@@ -511,10 +517,10 @@ at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
-				const char *parent_name)
+				const char *parent_name, struct clk_hw *parent_hw)
 {
 	struct clk_audio_pmc *apmc_ck;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
@@ -523,7 +529,10 @@ at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
 
 	init.name = name;
 	init.ops = &audio_pll_pmc_ops;
-	init.parent_names = &parent_name;
+	if (parent_hw)
+		init.parent_hws = (const struct clk_hw **)&parent_hw;
+	else
+		init.parent_names = &parent_name;
 	init.num_parents = 1;
 	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
 		CLK_SET_RATE_PARENT;
diff --git a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
index d8e520e509d8..6698a770d45a 100644
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -43,7 +43,7 @@ static void __init of_sama5d2_clk_audio_pll_frac_setup(struct device_node *np)
 
 	parent_name = of_clk_get_parent_name(np, 0);
 
-	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name);
+	hw = at91_clk_register_audio_pll_frac(regmap, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
@@ -69,7 +69,7 @@ static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
 
 	parent_name = of_clk_get_parent_name(np, 0);
 
-	hw = at91_clk_register_audio_pll_pad(regmap, name, parent_name);
+	hw = at91_clk_register_audio_pll_pad(regmap, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
@@ -95,7 +95,7 @@ static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
 
 	parent_name = of_clk_get_parent_name(np, 0);
 
-	hw = at91_clk_register_audio_pll_pmc(regmap, name, parent_name);
+	hw = at91_clk_register_audio_pll_pmc(regmap, name, parent_name, NULL);
 	if (IS_ERR(hw))
 		return;
 
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index ce68c1b1fb70..6d541b4d3f50 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -130,15 +130,15 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data);
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
-				 const char *parent_name);
+				 const char *parent_name, struct clk_hw *parent_hw);
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_pad(struct regmap *regmap, const char *name,
-				const char *parent_name);
+				const char *parent_name, struct clk_hw *parent_hw);
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_pmc(struct regmap *regmap, const char *name,
-				const char *parent_name);
+				const char *parent_name, struct clk_hw *parent_hw);
 
 struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index bc62b9ed4ea0..d2af421abddc 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -227,19 +227,19 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	sama5d2_pmc->chws[PMC_PLLACK] = hw;
 
 	hw = at91_clk_register_audio_pll_frac(regmap, "audiopll_fracck",
-					      "mainck");
+					      "mainck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	hw = at91_clk_register_audio_pll_pad(regmap, "audiopll_padck",
-					     "audiopll_fracck");
+					     "audiopll_fracck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
 	sama5d2_pmc->chws[PMC_AUDIOPINCK] = hw;
 
 	hw = at91_clk_register_audio_pll_pmc(regmap, "audiopll_pmcck",
-					     "audiopll_fracck");
+					     "audiopll_fracck", NULL);
 	if (IS_ERR(hw))
 		goto err_free;
 
-- 
2.39.2

