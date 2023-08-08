Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A477412B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjHHRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjHHRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:14:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8AB2B4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:06:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso9665087e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510769; x=1692115569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HRnOFNjaV6woZ3xljajZhtB13+nTXwy5XllDpkczp8=;
        b=rHcNg28cbez6buq1iyj/60oZXJH5dzUXUcH5CC8xSAip5KkezR3jKkH7w3M/3HHGod
         RKGPa7gIJ16a/7dXnO6bfAFxw/xHg1QVsCY6WYCeSqHOKn1HYaQsNUR+V+yGO3MdgeMS
         gUAOe5WXI2LUJq5DaWzpVMa0NEI4HjBREGm979BVT6Om8tBBWYywVU5s/3671YJ9IPt3
         X++j7Y3Q68QXWv3iZ1mogAmZVF0tQGGhcPxY5o5T3mEypbG/5ZvlfFzS29dfiTMVbx5J
         FX07qK61rnv7wQA3B0PsUaeuWt34Y7UJryWMgL+a29tFa/uiwnvkKfd3OkFIoZnr+Iy/
         NdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510769; x=1692115569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HRnOFNjaV6woZ3xljajZhtB13+nTXwy5XllDpkczp8=;
        b=XauV7lX760tx6Rraj5hfGNJRbFvnKw70XOjZEveWPAXmAynZrfXBtdxclJmNoscWrw
         8/LKrKTdjHHjKMLmV++xatfu125BiecMvgS5O9sP6WGzG/dsdDzo5HtzkaZbiPj1kFRR
         fxrRPcvDeKVCclT9Pd3Dm0OnVUNB2zl7jeC8Yi2sw5YKXe8JOjsiZYbOFaJGgvk+uNzr
         nuMEJAl3jQ3mTNwgmO2shhkKAvTmWZ65Y9yKE6o+ttA+U24gUn0MOmP/Eu0u0Zv9pHPK
         c9tLicQc1GPtFA3BJUw14MwaIO3BPp9C4z3pSxZK7wT+64qw4OyqkCGOP5RbN+yjSCjp
         I3XQ==
X-Gm-Message-State: AOJu0YwS6brvmEZuvBQ7RVJXbslLGlf1PhpeZqG0Sn852CQDvQ46xcmi
        TD27S0ipIrn/1f7yO0WmxgjB4xOAFdJiB9qkpFk=
X-Google-Smtp-Source: AGHT+IFHe9ORAr9ETOYHD2bBTNwrTinDunKL4IuHMGtfTVMZJyZDSj/k2Rm43K3znEBLYulQsq1lAA==
X-Received: by 2002:a5d:5912:0:b0:317:606d:c767 with SMTP id v18-20020a5d5912000000b00317606dc767mr6928690wrd.44.1691483276005;
        Tue, 08 Aug 2023 01:27:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:55 -0700 (PDT)
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
Subject: [PATCH 07/11] clk: samsung: exynos5433: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:34 +0200
Message-Id: <20230808082738.122804-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/clk/samsung/clk-exynos5433.c | 65 +++++++++++++++++++---------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index ed43233649ae..6bfc5d0cd924 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -21,6 +21,29 @@
 #include "clk-exynos-arm64.h"
 #include "clk-pll.h"
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR_TOP			(CLK_SCLK_HDMI_SPDIF_DISP + 1)
+#define CLKS_NR_CPIF			(CLK_SCLK_UFS_MPHY + 1)
+#define CLKS_NR_MIF			(CLK_SCLK_BUS_PLL_ATLAS + 1)
+#define CLKS_NR_PERIC			(CLK_DIV_SCLK_SC_IN + 1)
+#define CLKS_NR_PERIS			(CLK_SCLK_OTP_CON + 1)
+#define CLKS_NR_FSYS			(CLK_PCIE + 1)
+#define CLKS_NR_G2D			(CLK_PCLK_SMMU_G2D + 1)
+#define CLKS_NR_DISP			(CLK_PHYCLK_MIPIDPHY0_RXCLKESC0_PHY + 1)
+#define CLKS_NR_AUD			(CLK_SCLK_AUD_I2S + 1)
+#define CLKS_NR_BUSX			(CLK_ACLK_BUS2RTND_400 + 1)
+#define CLKS_NR_G3D			(CLK_SCLK_HPM_G3D + 1)
+#define CLKS_NR_GSCL			(CLK_PCLK_SMMU_GSCL2 + 1)
+#define CLKS_NR_APOLLO			(CLK_SCLK_APOLLO + 1)
+#define CLKS_NR_ATLAS			(CLK_SCLK_ATLAS + 1)
+#define CLKS_NR_MSCL			(CLK_SCLK_JPEG + 1)
+#define CLKS_NR_MFC			(CLK_PCLK_SMMU_MFC_0 + 1)
+#define CLKS_NR_HEVC			(CLK_PCLK_SMMU_HEVC_0 + 1)
+#define CLKS_NR_ISP			(CLK_SCLK_PIXELASYNCM_ISPC + 1)
+#define CLKS_NR_CAM0			(CLK_SCLK_PIXELASYNCS_LITE_C_INIT + 1)
+#define CLKS_NR_CAM1			(CLK_SCLK_ISP_CA5 + 1)
+#define CLKS_NR_IMEM			(CLK_PCLK_SLIMSSS + 1)
+
 /*
  * Register offset definitions for CMU_TOP
  */
@@ -798,7 +821,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_fixed_clks		= ARRAY_SIZE(top_fixed_clks),
 	.fixed_factor_clks	= top_fixed_factor_clks,
 	.nr_fixed_factor_clks	= ARRAY_SIZE(top_fixed_factor_clks),
-	.nr_clk_ids		= TOP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_TOP,
 	.clk_regs		= top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
 	.suspend_regs		= top_suspend_regs,
@@ -877,7 +900,7 @@ static const struct samsung_cmu_info cpif_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(cpif_div_clks),
 	.gate_clks		= cpif_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(cpif_gate_clks),
-	.nr_clk_ids		= CPIF_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CPIF,
 	.clk_regs		= cpif_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cpif_clk_regs),
 	.suspend_regs		= cpif_suspend_regs,
@@ -1531,7 +1554,7 @@ static const struct samsung_cmu_info mif_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(mif_gate_clks),
 	.fixed_factor_clks	= mif_fixed_factor_clks,
 	.nr_fixed_factor_clks	= ARRAY_SIZE(mif_fixed_factor_clks),
-	.nr_clk_ids		= MIF_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_MIF,
 	.clk_regs		= mif_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mif_clk_regs),
 };
@@ -1730,7 +1753,7 @@ static const struct samsung_cmu_info peric_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(peric_div_clks),
 	.gate_clks		= peric_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peric_gate_clks),
-	.nr_clk_ids		= PERIC_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERIC,
 	.clk_regs		= peric_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peric_clk_regs),
 	.suspend_regs		= peric_suspend_regs,
@@ -1924,7 +1947,7 @@ static const struct samsung_gate_clock peris_gate_clks[] __initconst = {
 static const struct samsung_cmu_info peris_cmu_info __initconst = {
 	.gate_clks		= peris_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peris_gate_clks),
-	.nr_clk_ids		= PERIS_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERIS,
 	.clk_regs		= peris_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peris_clk_regs),
 };
@@ -2336,7 +2359,7 @@ static const struct samsung_cmu_info fsys_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(fsys_gate_clks),
 	.fixed_clks		= fsys_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(fsys_fixed_clks),
-	.nr_clk_ids		= FSYS_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_FSYS,
 	.clk_regs		= fsys_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys_clk_regs),
 	.suspend_regs		= fsys_suspend_regs,
@@ -2459,7 +2482,7 @@ static const struct samsung_cmu_info g2d_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(g2d_div_clks),
 	.gate_clks		= g2d_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(g2d_gate_clks),
-	.nr_clk_ids		= G2D_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_G2D,
 	.clk_regs		= g2d_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(g2d_clk_regs),
 	.suspend_regs		= g2d_suspend_regs,
@@ -2887,7 +2910,7 @@ static const struct samsung_cmu_info disp_cmu_info __initconst = {
 	.nr_fixed_clks		= ARRAY_SIZE(disp_fixed_clks),
 	.fixed_factor_clks	= disp_fixed_factor_clks,
 	.nr_fixed_factor_clks	= ARRAY_SIZE(disp_fixed_factor_clks),
-	.nr_clk_ids		= DISP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_DISP,
 	.clk_regs		= disp_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(disp_clk_regs),
 	.suspend_regs		= disp_suspend_regs,
@@ -3057,7 +3080,7 @@ static const struct samsung_cmu_info aud_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
 	.fixed_clks		= aud_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(aud_fixed_clks),
-	.nr_clk_ids		= AUD_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_AUD,
 	.clk_regs		= aud_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
 	.suspend_regs		= aud_suspend_regs,
@@ -3189,7 +3212,7 @@ static const struct samsung_gate_clock bus2_gate_clks[] __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(bus##id##_div_clks),	\
 	.gate_clks		= bus##id##_gate_clks,			\
 	.nr_gate_clks		= ARRAY_SIZE(bus##id##_gate_clks),	\
-	.nr_clk_ids		= BUSx_NR_CLK
+	.nr_clk_ids		= CLKS_NR_BUSX
 
 static const struct samsung_cmu_info bus0_cmu_info __initconst = {
 	CMU_BUS_INFO_CLKS(0),
@@ -3340,7 +3363,7 @@ static const struct samsung_cmu_info g3d_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
 	.gate_clks		= g3d_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
-	.nr_clk_ids		= G3D_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_G3D,
 	.clk_regs		= g3d_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
 	.suspend_regs		= g3d_suspend_regs,
@@ -3483,7 +3506,7 @@ static const struct samsung_cmu_info gscl_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(gscl_mux_clks),
 	.gate_clks		= gscl_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(gscl_gate_clks),
-	.nr_clk_ids		= GSCL_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_GSCL,
 	.clk_regs		= gscl_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(gscl_clk_regs),
 	.suspend_regs		= gscl_suspend_regs,
@@ -3693,7 +3716,7 @@ static const struct samsung_cmu_info apollo_cmu_info __initconst = {
 	.nr_gate_clks	= ARRAY_SIZE(apollo_gate_clks),
 	.cpu_clks	= apollo_cpu_clks,
 	.nr_cpu_clks	= ARRAY_SIZE(apollo_cpu_clks),
-	.nr_clk_ids	= APOLLO_NR_CLK,
+	.nr_clk_ids	= CLKS_NR_APOLLO,
 	.clk_regs	= apollo_clk_regs,
 	.nr_clk_regs	= ARRAY_SIZE(apollo_clk_regs),
 };
@@ -3938,7 +3961,7 @@ static const struct samsung_cmu_info atlas_cmu_info __initconst = {
 	.nr_gate_clks	= ARRAY_SIZE(atlas_gate_clks),
 	.cpu_clks	= atlas_cpu_clks,
 	.nr_cpu_clks	= ARRAY_SIZE(atlas_cpu_clks),
-	.nr_clk_ids	= ATLAS_NR_CLK,
+	.nr_clk_ids	= CLKS_NR_ATLAS,
 	.clk_regs	= atlas_clk_regs,
 	.nr_clk_regs	= ARRAY_SIZE(atlas_clk_regs),
 };
@@ -4112,7 +4135,7 @@ static const struct samsung_cmu_info mscl_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(mscl_div_clks),
 	.gate_clks		= mscl_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(mscl_gate_clks),
-	.nr_clk_ids		= MSCL_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_MSCL,
 	.clk_regs		= mscl_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mscl_clk_regs),
 	.suspend_regs		= mscl_suspend_regs,
@@ -4220,7 +4243,7 @@ static const struct samsung_cmu_info mfc_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(mfc_div_clks),
 	.gate_clks		= mfc_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(mfc_gate_clks),
-	.nr_clk_ids		= MFC_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_MFC,
 	.clk_regs		= mfc_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mfc_clk_regs),
 	.suspend_regs		= mfc_suspend_regs,
@@ -4330,7 +4353,7 @@ static const struct samsung_cmu_info hevc_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(hevc_div_clks),
 	.gate_clks		= hevc_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(hevc_gate_clks),
-	.nr_clk_ids		= HEVC_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_HEVC,
 	.clk_regs		= hevc_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(hevc_clk_regs),
 	.suspend_regs		= hevc_suspend_regs,
@@ -4583,7 +4606,7 @@ static const struct samsung_cmu_info isp_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(isp_div_clks),
 	.gate_clks		= isp_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(isp_gate_clks),
-	.nr_clk_ids		= ISP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_ISP,
 	.clk_regs		= isp_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(isp_clk_regs),
 	.suspend_regs		= isp_suspend_regs,
@@ -5065,7 +5088,7 @@ static const struct samsung_cmu_info cam0_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(cam0_gate_clks),
 	.fixed_clks		= cam0_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(cam0_fixed_clks),
-	.nr_clk_ids		= CAM0_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CAM0,
 	.clk_regs		= cam0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cam0_clk_regs),
 	.suspend_regs		= cam0_suspend_regs,
@@ -5440,7 +5463,7 @@ static const struct samsung_cmu_info cam1_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(cam1_gate_clks),
 	.fixed_clks		= cam1_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(cam1_fixed_clks),
-	.nr_clk_ids		= CAM1_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CAM1,
 	.clk_regs		= cam1_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cam1_clk_regs),
 	.suspend_regs		= cam1_suspend_regs,
@@ -5472,7 +5495,7 @@ static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
 static const struct samsung_cmu_info imem_cmu_info __initconst = {
 	.gate_clks		= imem_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(imem_gate_clks),
-	.nr_clk_ids		= IMEM_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_IMEM,
 	.clk_regs		= imem_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(imem_clk_regs),
 	.clk_name		= "aclk_imem_200",
-- 
2.34.1

