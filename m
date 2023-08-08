Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3A774327
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjHHR5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjHHR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:57:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119FD2AF0F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:25:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1370893f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511947; x=1692116747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ga9ShVSfRDMx/t8+Pt2uOUsHlvwZxV8rq0HaCpReBAw=;
        b=AYBof/1rY3LtHgv0ZgJzUUZC5M7Z+/Zc08ShBHIgm3JR2fvfePh4WdbWv1ef/t2WQZ
         qvT9TKKnjsbT6b0KdPaawFWmrJzkgEmkQv3geFtR8JuLyewb+IPPjuV9fN9a+2MO5xCx
         9F2HlbsNdOyjJcjlUNNp/dxbElIHfHnwTs8Mhv7wleCihWXaWePJ7rP+Zt/GeuWcprEZ
         1SVOnewRTqZq793iPJ78dL3pSpphRt9HV1jckx0hA2DnEqe5EgcneV/EaLlRznzR93nL
         ZNco2nG/PG65Nlw0aqZbPpuyphVIfMSXYK9VrAnRwd7gDsZL8DFFSTY3KW90HcwNu9tS
         vm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511947; x=1692116747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ga9ShVSfRDMx/t8+Pt2uOUsHlvwZxV8rq0HaCpReBAw=;
        b=goKiI+52PCMNxeb8ru7ipowv5SPn+qCp2Kb8RVZ+Eqcl40TJfdHH3us0HBtATrG97Q
         mYMjCaXmvonhFbJnn8KdKQCWjaQb579Rpnejrb2keIYQS/WgqTyH2mhdE4tCqf/t/tl6
         WKERHspdFU2Qo6zfBJyC71SHKjxY6jZELKM0bXbhO93+xfiTYzN9fCulp4bYFASK609p
         oE+S6sM4tmFNZaPm1buCrKTUY+SC9xLVyr/M39a3ltEWSXJ6yWJS/IsBrpu4JKTi0svL
         bXTDvx+/f55kXzUfD7/u/4vEM47TIgQCFjE7DkM8PU8/W/1REi2dr7Gz13t/VZcZBUFS
         UGcw==
X-Gm-Message-State: AOJu0YwX1fH47e7DCFkW4iCVbsbPQpTS3JrHyehdOHAhfdb3yImCyZGJ
        4lA+Y/Gn9A8XrrQCpcoWEnK+/t0AZqyvMmBvtoE=
X-Google-Smtp-Source: AGHT+IGoYdIOrAk32Xpjqu5lGI0d77DrpYLqBhLO0RsGUXKf+OwfLW2ec1eVNHj/KnbQGKFgnC4TGw==
X-Received: by 2002:a05:6512:3d8e:b0:4f8:7568:e948 with SMTP id k14-20020a0565123d8e00b004f87568e948mr9356536lfv.51.1691483281731;
        Tue, 08 Aug 2023 01:28:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:28:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 10/11] clk: samsung: exynoautov9: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:37 +0200
Message-Id: <20230808082738.122804-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Number of clocks supported by Linux drivers might vary - sometimes we
add new clocks, not exposed previously.  Therefore this number of clocks
should not be in the bindings, because otherwise we should not change
it.

Define number of clocks per each clock controller inside the driver
directly.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/samsung/clk-exynosautov9.c | 29 ++++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
index ddef546be545..e9c06eb93e66 100644
--- a/drivers/clk/samsung/clk-exynosautov9.c
+++ b/drivers/clk/samsung/clk-exynosautov9.c
@@ -16,6 +16,17 @@
 #include "clk.h"
 #include "clk-exynos-arm64.h"
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR_TOP			(GOUT_CLKCMU_PERIS_BUS + 1)
+#define CLKS_NR_BUSMC			(CLK_GOUT_BUSMC_SPDMA_PCLK + 1)
+#define CLKS_NR_CORE			(CLK_GOUT_CORE_CMU_CORE_PCLK + 1)
+#define CLKS_NR_FSYS0			(CLK_GOUT_FSYS0_PCIE_GEN3B_4L_CLK + 1)
+#define CLKS_NR_FSYS1			(CLK_GOUT_FSYS1_USB30_1_ACLK + 1)
+#define CLKS_NR_FSYS2			(CLK_GOUT_FSYS2_UFS_EMBD1_UNIPRO + 1)
+#define CLKS_NR_PERIC0			(CLK_GOUT_PERIC0_PCLK_11 + 1)
+#define CLKS_NR_PERIC1			(CLK_GOUT_PERIC1_PCLK_11 + 1)
+#define CLKS_NR_PERIS			(CLK_GOUT_WDT_CLUSTER1 + 1)
+
 /* ---- CMU_TOP ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_TOP (0x1b240000) */
@@ -941,7 +952,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_fixed_factor_clks	= ARRAY_SIZE(top_fixed_factor_clks),
 	.gate_clks		= top_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
-	.nr_clk_ids		= TOP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_TOP,
 	.clk_regs		= top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
 };
@@ -1001,7 +1012,7 @@ static const struct samsung_cmu_info busmc_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(busmc_div_clks),
 	.gate_clks		= busmc_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(busmc_gate_clks),
-	.nr_clk_ids		= BUSMC_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_BUSMC,
 	.clk_regs		= busmc_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(busmc_clk_regs),
 	.clk_name		= "dout_clkcmu_busmc_bus",
@@ -1059,7 +1070,7 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
 	.gate_clks		= core_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
-	.nr_clk_ids		= CORE_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CORE,
 	.clk_regs		= core_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
 	.clk_name		= "dout_clkcmu_core_bus",
@@ -1299,7 +1310,7 @@ static const struct samsung_cmu_info fsys0_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(fsys0_mux_clks),
 	.gate_clks		= fsys0_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(fsys0_gate_clks),
-	.nr_clk_ids		= FSYS0_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_FSYS0,
 	.clk_regs		= fsys0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys0_clk_regs),
 	.clk_name		= "dout_clkcmu_fsys0_bus",
@@ -1426,7 +1437,7 @@ static const struct samsung_cmu_info fsys1_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(fsys1_div_clks),
 	.gate_clks		= fsys1_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(fsys1_gate_clks),
-	.nr_clk_ids		= FSYS1_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_FSYS1,
 	.clk_regs		= fsys1_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys1_clk_regs),
 	.clk_name		= "dout_clkcmu_fsys1_bus",
@@ -1493,7 +1504,7 @@ static const struct samsung_cmu_info fsys2_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(fsys2_mux_clks),
 	.gate_clks		= fsys2_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(fsys2_gate_clks),
-	.nr_clk_ids		= FSYS2_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_FSYS2,
 	.clk_regs		= fsys2_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys2_clk_regs),
 	.clk_name		= "dout_clkcmu_fsys2_bus",
@@ -1748,7 +1759,7 @@ static const struct samsung_cmu_info peric0_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(peric0_div_clks),
 	.gate_clks		= peric0_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peric0_gate_clks),
-	.nr_clk_ids		= PERIC0_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERIC0,
 	.clk_regs		= peric0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peric0_clk_regs),
 	.clk_name		= "dout_clkcmu_peric0_bus",
@@ -2003,7 +2014,7 @@ static const struct samsung_cmu_info peric1_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(peric1_div_clks),
 	.gate_clks		= peric1_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peric1_gate_clks),
-	.nr_clk_ids		= PERIC1_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERIC1,
 	.clk_regs		= peric1_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peric1_clk_regs),
 	.clk_name		= "dout_clkcmu_peric1_bus",
@@ -2050,7 +2061,7 @@ static const struct samsung_cmu_info peris_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(peris_mux_clks),
 	.gate_clks		= peris_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peris_gate_clks),
-	.nr_clk_ids		= PERIS_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERIS,
 	.clk_regs		= peris_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peris_clk_regs),
 	.clk_name		= "dout_clkcmu_peris_bus",
-- 
2.34.1

