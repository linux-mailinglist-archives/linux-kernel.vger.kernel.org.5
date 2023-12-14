Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB2812B36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjLNJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjLNJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:11:36 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB2E10A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:42 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77f56750defso343323085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545101; x=1703149901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DxFXPJYgIG7bY+rEjLLq6eWKt7yGgrHuHLxSAUgD04=;
        b=zt4ogbpHMlAx7+8/W/PMq+CJyvCc+yE4SCshQ48Le7NvVvz7qlUaGLfcOJp6W8JqxO
         Qv7neudkMyrioY7I4Ga9PkHS72NNUY1bVXca/T981wFIc6JQ7Xr/grUiM20Hiry4pn1k
         hlFuXKZ9Ta5hAawRCdruh/KvuqYdrVnx5YmgE10dimPYBo9lRsFqEYxMPyz5YUXYlRoK
         gG7ienbyF/xhbxi6BeuzWbaclcQkarYYXdRNb8w+N8ZqjfFhEcgrzfR324b34dPR3o6t
         toZi+Lgv7ZIh0zFTPzt0/exasSlpA7cKcKRG7yH+krhyL2Y9iXqj711r7oFa++ado7Gn
         cWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545101; x=1703149901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DxFXPJYgIG7bY+rEjLLq6eWKt7yGgrHuHLxSAUgD04=;
        b=EX49LdRGOHvgu699D0/9320xIoy0btLi28MCuEnKLzZMWPF+KrYC2+VOI4c1gClcj3
         ksyL5Y5nDT99P8MMZp69sPrLE83gNATKcFmKSp39B3qP19SBL9gSHPpRi2WzcoQgnMMa
         stA3Ik7r3he/WhL4UoHgfdDP3DSzoP2PWsWc5Nve3zHXqL/sk02RoGiSDOQ6QnJ1biQw
         ZdlaESnrd4vcRc0Dc3vZcPT2t1w1tpuDDPZR82IHMR9giophtjUhLP8/CPQBFnYtO3gJ
         jmCDXe4px97zL+Y7VLN+f4ng/06GKPGBSb1paKO/ZgZAJgZwK8DrtSyB4HfYhfB/LdDe
         G7uA==
X-Gm-Message-State: AOJu0YwEPcHZ8EyIvKAWNer5kFdseQlV8lVUDBLBQ9jTnXrLKNbyM4c1
        I6idsiCSfeHhK9LEAobs6MfS
X-Google-Smtp-Source: AGHT+IFGeYRRHFMd5RKI2JUYh2LUqufJuMqCc51bmtyQWkYRShHZtBSfcVSJiI4Tsb3u+TyDOkV2ug==
X-Received: by 2002:a05:620a:cef:b0:77e:fba3:4f0e with SMTP id c15-20020a05620a0cef00b0077efba34f0emr9799895qkj.100.1702545101407;
        Thu, 14 Dec 2023 01:11:41 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:11:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/16] clk: qcom: gcc-sc8180x: Add missing UFS QREF clocks
Date:   Thu, 14 Dec 2023 14:40:49 +0530
Message-Id: <20231214091101.45713-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
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

Add missing QREF clocks for UFS MEM and UFS CARD controllers.

Fixes: 4433594bbe5d ("clk: qcom: gcc: Add global clock controller driver for SC8180x")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/gcc-sc8180x.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index ae2147381559..544567db45f1 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -3347,6 +3347,19 @@ static struct clk_branch gcc_ufs_card_2_unipro_core_clk = {
 	},
 };
 
+static struct clk_branch gcc_ufs_card_clkref_en = {
+	.halt_reg = 0x8c004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8c004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_card_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_card_ahb_clk = {
 	.halt_reg = 0x75014,
 	.halt_check = BRANCH_HALT,
@@ -3561,6 +3574,19 @@ static struct clk_branch gcc_ufs_card_unipro_core_hw_ctl_clk = {
 	},
 };
 
+static struct clk_branch gcc_ufs_mem_clkref_en = {
+	.halt_reg = 0x8c000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8c000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_mem_clkref_en",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_phy_ahb_clk = {
 	.halt_reg = 0x77014,
 	.halt_check = BRANCH_HALT,
@@ -4413,6 +4439,7 @@ static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GCC_UFS_CARD_2_TX_SYMBOL_0_CLK] = &gcc_ufs_card_2_tx_symbol_0_clk.clkr,
 	[GCC_UFS_CARD_2_UNIPRO_CORE_CLK] = &gcc_ufs_card_2_unipro_core_clk.clkr,
 	[GCC_UFS_CARD_2_UNIPRO_CORE_CLK_SRC] = &gcc_ufs_card_2_unipro_core_clk_src.clkr,
+	[GCC_UFS_CARD_CLKREF_EN] = &gcc_ufs_card_clkref_en.clkr,
 	[GCC_UFS_CARD_AHB_CLK] = &gcc_ufs_card_ahb_clk.clkr,
 	[GCC_UFS_CARD_AXI_CLK] = &gcc_ufs_card_axi_clk.clkr,
 	[GCC_UFS_CARD_AXI_CLK_SRC] = &gcc_ufs_card_axi_clk_src.clkr,
@@ -4429,6 +4456,7 @@ static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GCC_UFS_CARD_UNIPRO_CORE_CLK] = &gcc_ufs_card_unipro_core_clk.clkr,
 	[GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC] = &gcc_ufs_card_unipro_core_clk_src.clkr,
 	[GCC_UFS_CARD_UNIPRO_CORE_HW_CTL_CLK] = &gcc_ufs_card_unipro_core_hw_ctl_clk.clkr,
+	[GCC_UFS_MEM_CLKREF_EN] = &gcc_ufs_mem_clkref_en.clkr,
 	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
 	[GCC_UFS_PHY_AXI_CLK] = &gcc_ufs_phy_axi_clk.clkr,
 	[GCC_UFS_PHY_AXI_CLK_SRC] = &gcc_ufs_phy_axi_clk_src.clkr,
-- 
2.25.1

