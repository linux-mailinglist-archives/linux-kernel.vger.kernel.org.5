Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3527741F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHHRbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjHHRa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:30:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296FF217BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:13:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c0290f0a8so768083866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511151; x=1692115951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv5+yldfcLl5F50y6SpkVFOO6DSopWazKZ9tTkvj/KI=;
        b=pwu79RJKAZzjVlM5zocnPuZWss4T7jznEN0xmV4nPe91op3F6dS3rH0t6CZ3KPLU/4
         f6D0jdg1FYiMtrDLdsfIOlx/GJjGZuxPc2UrUle8m9iAwpo4XmqW2NZ4Zt2t+MBMLyxE
         jCQKQSbw14/IIFStCrYHF/DRip0HL+ScUXgwZTmHJMXDs6vXw+dz8QdXgad52qu4P2GC
         RKRdfSYChDHDSRVGtS54qn4AQSHTOrW7ZS+Fm7DdW6jmMpLbmrtPaT2vsSE0Aa+WnYIp
         5uSwJlAi1nmZ0p2aRQDfNTqqTd/+FEt5gh0zNxW2Rnuek30up/QSjuXBAUzvh07wWioc
         /xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511151; x=1692115951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv5+yldfcLl5F50y6SpkVFOO6DSopWazKZ9tTkvj/KI=;
        b=RoV/jTnzBdXCvXAcMMsTxq4ZN/UxTUI+jPlaghonn6tcjmnGMU+M29mtLPj4jbM+BU
         BUgkqaC1GA34NnMjfPNaT0T6ztkRFcbwkyUkaevVlPov14O48Ozp4l2WjVyb0payNiJQ
         6kx1DL16sockoHw7bLqSIoM0zjjUPOJuWNFi/ce1iVShhp5OEpShA4b4ROO1L9+dSFBK
         TUA/BbSgJt38Af2wFtdJ1WedH5mqyPYSEknj0r2lEP5SRU2qa2zXSRI6r/z4f8UEsdJN
         9q7brqpbCzHK7ENZadoYZqV3iNf52MEEyLlOePtvtRjCHv1COVubEUUGmeZuM51jxZa9
         +bIw==
X-Gm-Message-State: AOJu0Yw5npWnVqjXBI9rtbGnofOZPNmA04kv9o4HU4BKGoIoYZlfaHvK
        Lg5LceiIPGny40FdF2ecj0l25H4T8EFGxdcKl7M=
X-Google-Smtp-Source: AGHT+IE1JwtFdnFB8Qb2FMa0lT19XJl5y0OhOFfz9ix5xSzooJBHWR588byfQs4NsD0XnfPqprVNBg==
X-Received: by 2002:a05:6512:39d6:b0:4f8:71bf:a259 with SMTP id k22-20020a05651239d600b004f871bfa259mr7889276lfu.67.1691483278062;
        Tue, 08 Aug 2023 01:27:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:57 -0700 (PDT)
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
Subject: [PATCH 08/11] clk: samsung: exynos7885: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:35 +0200
Message-Id: <20230808082738.122804-9-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/samsung/clk-exynos7885.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index 0c6a84764f7a..f7d7427a558b 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -16,6 +16,12 @@
 #include "clk.h"
 #include "clk-exynos-arm64.h"
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR_TOP			(CLK_GOUT_FSYS_USB30DRD + 1)
+#define CLKS_NR_CORE			(CLK_GOUT_TREX_P_CORE_PCLK_P_CORE + 1)
+#define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
+#define CLKS_NR_FSYS			(CLK_GOUT_MMC_SDIO_SDCLKIN + 1)
+
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_TOP (0x12060000) */
@@ -333,7 +339,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(top_div_clks),
 	.gate_clks		= top_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(top_gate_clks),
-	.nr_clk_ids		= TOP_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_TOP,
 	.clk_regs		= top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(top_clk_regs),
 };
@@ -552,7 +558,7 @@ static const struct samsung_cmu_info peri_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(peri_mux_clks),
 	.gate_clks		= peri_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(peri_gate_clks),
-	.nr_clk_ids		= PERI_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_PERI,
 	.clk_regs		= peri_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peri_clk_regs),
 	.clk_name		= "dout_peri_bus",
@@ -661,7 +667,7 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
 	.nr_div_clks		= ARRAY_SIZE(core_div_clks),
 	.gate_clks		= core_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(core_gate_clks),
-	.nr_clk_ids		= CORE_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_CORE,
 	.clk_regs		= core_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(core_clk_regs),
 	.clk_name		= "dout_core_bus",
@@ -743,7 +749,7 @@ static const struct samsung_cmu_info fsys_cmu_info __initconst = {
 	.nr_mux_clks		= ARRAY_SIZE(fsys_mux_clks),
 	.gate_clks		= fsys_gate_clks,
 	.nr_gate_clks		= ARRAY_SIZE(fsys_gate_clks),
-	.nr_clk_ids		= FSYS_NR_CLK,
+	.nr_clk_ids		= CLKS_NR_FSYS,
 	.clk_regs		= fsys_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(fsys_clk_regs),
 	.clk_name		= "dout_fsys_bus",
-- 
2.34.1

