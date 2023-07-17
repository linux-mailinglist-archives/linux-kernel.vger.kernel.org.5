Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22716756782
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGQPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGQPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9481701
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so7388040e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607160; x=1692199160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL/9liL2QLMSw3GK115iE6vTLgR9G2NI4UgfxPoIK+c=;
        b=AtlVVnOEMmn9rMMAu1Hmx8QD9ZwSUa7aRvgFSEpExRjuuDiQLgUSKsViwzr0HW89NX
         vOQY+GGq3XB46nrcemgvEe1REFnFsseuOEVDtA1VYbC8p2AyEwZyoZ0Za1Cg5Vqs3zcb
         UyYZGnJNdezEytqN3LKmm9JLe5iCcmHCSJQJ8S0ElnANnnlgn2fOsZ0DHQHh5tn8Mq3G
         +XHNMLO/jFMAuZEQ09Fb1/leEBgHP/+k6xCrI5iKHSiYB86rm7vEdxx6Nq5iIwLqXiC9
         ZZ8kGuPIs/si+4uXhvJ69G33GhhV7OPyzgWgjvtaIEqYOwIlDtD2mxIIQzVRPH6fcmoj
         HbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607160; x=1692199160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PL/9liL2QLMSw3GK115iE6vTLgR9G2NI4UgfxPoIK+c=;
        b=K7fwdA6DdvyZZ/2c0jyJ1DN7/DyMxVWuykhbgsswMlZAQBX3DnMnH/vnhT2Mr1T596
         5wKjKrW9qgBGI56Anf00b8RSnOMbVzdwokPoj+aZYBEEJpqbX1bZPpeJf8bXeMJhDqBv
         RQ+kXNcJxkevfKqpD86h1NhF6B7pmnIq0o0CCF8W00AjmYdcqxtFoKsh4B2wBrVzvKL7
         f5K8AfSkCIdiWL0VX8+LJmvWkPs4bkUIYC2COEz4njh5icCvH1tq8s17ZGObRfD6Kg7p
         99E8Czpi3G9892hyAZs+0v7A/TSVtDk9kuQ5XCMbQHndluCxZdZ5Dq0ka/mfDMrebENB
         7RLg==
X-Gm-Message-State: ABy/qLZ+Hvy5beMeskRuPUssNknb/vlKqQ9n7pNyoMOT+9jhMXf27zTL
        xSKJ21wz5aIq1U64d4Legtbltg==
X-Google-Smtp-Source: APBJJlGhWZu5q2p7LugifLYJp9HF77b3+VuyjVwl12/YHfD7gjXuzZz/zOVf+cX2E6G3+L6aX9HpZA==
X-Received: by 2002:a19:915e:0:b0:4fb:744e:17db with SMTP id y30-20020a19915e000000b004fb744e17dbmr7841352lfj.1.1689607159904;
        Mon, 17 Jul 2023 08:19:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:13 +0200
Subject: [PATCH 06/15] clk: qcom: gpucc-sm6115: Unregister critical clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-6-27784d27a4f4@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=3009;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gGAKlFsEiMqa1it7eUHKXDQHPq4ci/PWNufQygBA064=;
 b=aGgzTFz/dux49UIL4Jba0PLcD4jT5zrtFO320nx1kJrqM0u124ZO9trfZoW4Ic9nu+bC+g8MJ
 0Lg0yit19gxClVTvBBAspBNpX+ssuJRvr3X6EAWQ2c7PY29OXaagFGJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks need to be always-on, but we don't really do anything
with them, other than calling enable() once and telling Linux they're
enabled.

Unregister them to save a couple of bytes and, perhaps more
importantly, allow for runtime suspend of the clock controller device,
as CLK_IS_CRITICAL prevents the latter.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gpucc-sm6115.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
index c84727e8352d..ac048f7973d0 100644
--- a/drivers/clk/qcom/gpucc-sm6115.c
+++ b/drivers/clk/qcom/gpucc-sm6115.c
@@ -233,20 +233,6 @@ static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src = {
 	},
 };
 
-static struct clk_branch gpu_cc_ahb_clk = {
-	.halt_reg = 0x1078,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1078,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpu_cc_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpu_cc_crc_ahb_clk = {
 	.halt_reg = 0x107c,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -335,20 +321,6 @@ static struct clk_branch gpu_cc_cxo_clk = {
 	},
 };
 
-static struct clk_branch gpu_cc_gx_cxo_clk = {
-	.halt_reg = 0x1060,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1060,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpu_cc_gx_cxo_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpu_cc_gx_gfx3d_clk = {
 	.halt_reg = 0x1054,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -417,7 +389,6 @@ static struct gdsc gpu_gx_gdsc = {
 };
 
 static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
-	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
 	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
 	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,
 	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
@@ -425,7 +396,6 @@ static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
 	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
 	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
 	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
-	[GPU_CC_GX_CXO_CLK] = &gpu_cc_gx_cxo_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK] = &gpu_cc_gx_gfx3d_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpu_cc_gx_gfx3d_clk_src.clkr,
 	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
@@ -487,6 +457,14 @@ static int gpu_cc_sm6115_probe(struct platform_device *pdev)
 	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk, true);
 	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk, true);
 
+	/*
+	 * Keep clocks always enabled:
+	 *      gpu_cc_ahb_clk
+	 *      gpu_cc_gx_cxo_clk
+	 */
+	qcom_branch_set_clk_en(regmap, 0x1078);
+	qcom_branch_set_clk_en(regmap, 0x1060);
+
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
 }
 

-- 
2.41.0

