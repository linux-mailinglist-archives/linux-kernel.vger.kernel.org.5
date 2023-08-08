Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCC773D43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjHHQPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjHHQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B33AA7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:47:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98377c5d53eso804828566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509651; x=1692114451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnwG1XAT9SkXgU/6iu0TyJjY/vxrI7XxSfv3j8NwPp8=;
        b=ysKg0jLCVKlo9usl8Pg7Ln1fSXIUbf5McG8Qre5rBa8cpF+qLkZjtbMxEtP23xPiKJ
         D2b0wsfC0ZKLtSv0+YQhILCMnoUtqsjnjXX4qzWxFHl6qqs5rCzkmYC5uTRSY7e30DVM
         Jn2Ty7ZcTLIniwdT0ASdyPSWMmgKYOAeFKojKX1XLtTMJkz7xEu72Du23vPmbG2xcIeG
         QF1oGnddK1+FnUy20YtGpaaFTBSzPdXC3WUpNhKibgJwkapjj+3uLbaMX6FIAc+i8RP/
         y2nIs2R+eEJE3xr0FVD7M8CFLGZlLaP5CDRasq/NZRd//lIKnvlVabA6Qpyq7i3p1Eaf
         Ilpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509651; x=1692114451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnwG1XAT9SkXgU/6iu0TyJjY/vxrI7XxSfv3j8NwPp8=;
        b=BvvQFH62JhYkrvaEWfAVQyIHRmAkIUbU9OT9xoKRPMCcdTNqygythSaiWzECb5epbk
         Sl7ED6svcc9NzikTpuEStu+k7jlI/H9CS6mhcNrHCzidtTi+qc+NWecCRG4nKgXxfMvw
         nZ7kwNg0gMOARk74+hJwMBDN6WFuw2Bj7pN5dfUQSuz1pV8xFl4QqnBWJXFayYvQyIBL
         MzlHcMTc/PdskII+qhQuvtFeQ0G9Vs7gJZg97USeRh4wUMGe4HwezL8hoheUouubwhD3
         XSCsjGVJAHdjdxHs4lWgAWoxbEokK6FCrlhQ2IXCF77acM2lcNwqbnoIjxv1TETPFSmF
         Chyg==
X-Gm-Message-State: AOJu0YxpV7DF1Z8VwqET50QEf4FjYGtMIeCtW76xdviL8hUzGQy/HNJV
        dvGPvUPnXuiJXfoL2ClHOC0biJw2Xswku+hWRto=
X-Google-Smtp-Source: AGHT+IEOj70uM+AsIp/H+vkXLjUsGWPHj5kubZxF1Zom0bxXV7gwfaOqjFxiAjAVIapHRVYG3RZINw==
X-Received: by 2002:adf:e9cb:0:b0:317:7af4:5297 with SMTP id l11-20020adfe9cb000000b003177af45297mr8315793wrn.62.1691483279882;
        Tue, 08 Aug 2023 01:27:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:59 -0700 (PDT)
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
Subject: [PATCH 09/11] clk: samsung: exynos850: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:36 +0200
Message-Id: <20230808082738.122804-10-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/samsung/clk-exynos850.c | 35 ++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index c32b2e6451a0..bdc1eef7d6e5 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -16,6 +16,19 @@
 #include "clk.h"
 #include "clk-exynos-arm64.h"
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR_TOP			(CLK_DOUT_G3D_SWITCH + 1)
+#define CLKS_NR_APM			(CLK_GOUT_SYSREG_APM_PCLK + 1)
+#define CLKS_NR_AUD			(CLK_GOUT_AUD_CMU_AUD_PCLK + 1)
+#define CLKS_NR_CMGP			(CLK_GOUT_SYSREG_CMGP_PCLK + 1)
+#define CLKS_NR_G3D			(CLK_GOUT_G3D_SYSREG_PCLK + 1)
+#define CLKS_NR_HSI			(CLK_GOUT_HSI_CMU_HSI_PCLK + 1)
+#define CLKS_NR_IS			(CLK_GOUT_IS_SYSREG_PCLK + 1)
+#define CLKS_NR_MFCMSCL			(CLK_GOUT_MFCMSCL_SYSREG_PCLK + 1)
+#define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
+#define CLKS_NR_CORE			(CLK_GOUT_SYSREG_CORE_PCLK + 1)
+#define CLKS_NR_DPU			(CLK_GOUT_DPU_SYSREG_PCLK + 1)
+
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_TOP (0x120e0000) */
@@ -485,7 +498,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(top_div_clks),
 	.gate_clks		= top_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
-	.nr_clk_ids		= TOP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_TOP,
 	.clk_regs		= top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
 };
@@ -625,7 +638,7 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(apm_gate_clks),
 	.fixed_clks		= apm_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(apm_fixed_clks),
-	.nr_clk_ids		= APM_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_APM,
 	.clk_regs		= apm_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(apm_clk_regs),
 	.clk_name		= "dout_clkcmu_apm_bus",
@@ -908,7 +921,7 @@ static const struct samsung_cmu_info aud_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(aud_gate_clks),
 	.fixed_clks		= aud_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(aud_fixed_clks),
-	.nr_clk_ids		= AUD_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_AUD,
 	.clk_regs		= aud_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(aud_clk_regs),
 	.clk_name		= "dout_aud",
@@ -1011,7 +1024,7 @@ static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
 	.nr_gate_clks		= ARRAY_SIZE(cmgp_gate_clks),
 	.fixed_clks		= cmgp_fixed_clks,
 	.nr_fixed_clks		= ARRAY_SIZE(cmgp_fixed_clks),
-	.nr_clk_ids		= CMGP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CMGP,
 	.clk_regs		= cmgp_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cmgp_clk_regs),
 	.clk_name		= "gout_clkcmu_cmgp_bus",
@@ -1107,7 +1120,7 @@ static const struct samsung_cmu_info g3d_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
 	.gate_clks		= g3d_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
-	.nr_clk_ids		= G3D_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_G3D,
 	.clk_regs		= g3d_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
 	.clk_name		= "dout_g3d_switch",
@@ -1209,7 +1222,7 @@ static const struct samsung_cmu_info hsi_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(hsi_mux_clks),
 	.gate_clks		= hsi_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(hsi_gate_clks),
-	.nr_clk_ids		= HSI_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_HSI,
 	.clk_regs		= hsi_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(hsi_clk_regs),
 	.clk_name		= "dout_hsi_bus",
@@ -1341,7 +1354,7 @@ static const struct samsung_cmu_info is_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(is_div_clks),
 	.gate_clks		= is_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(is_gate_clks),
-	.nr_clk_ids		= IS_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_IS,
 	.clk_regs		= is_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(is_clk_regs),
 	.clk_name		= "dout_is_bus",
@@ -1450,7 +1463,7 @@ static const struct samsung_cmu_info mfcmscl_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(mfcmscl_div_clks),
 	.gate_clks		= mfcmscl_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(mfcmscl_gate_clks),
-	.nr_clk_ids		= MFCMSCL_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_MFCMSCL,
 	.clk_regs		= mfcmscl_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(mfcmscl_clk_regs),
 	.clk_name		= "dout_mfcmscl_mfc",
@@ -1625,7 +1638,7 @@ static const struct samsung_cmu_info peri_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(peri_div_clks),
 	.gate_clks		= peri_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peri_gate_clks),
-	.nr_clk_ids		= PERI_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERI,
 	.clk_regs		= peri_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peri_clk_regs),
 	.clk_name		= "dout_peri_bus",
@@ -1732,7 +1745,7 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
 	.gate_clks		= core_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
-	.nr_clk_ids		= CORE_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CORE,
 	.clk_regs		= core_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
 	.clk_name		= "dout_core_bus",
@@ -1806,7 +1819,7 @@ static const struct samsung_cmu_info dpu_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(dpu_div_clks),
 	.gate_clks		= dpu_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(dpu_gate_clks),
-	.nr_clk_ids		= DPU_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_DPU,
 	.clk_regs		= dpu_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(dpu_clk_regs),
 	.clk_name		= "dout_dpu",
-- 
2.34.1

