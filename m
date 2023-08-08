Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD07744C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjHHS2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjHHS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:28:21 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414724A89
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:43:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe3678010eso9796522e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691516622; x=1692121422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MmEGhsWcyV2tJiWGbgG48WJpgMlPeUsMr9lr8DHG50=;
        b=ipHVjYF9lIy8tz84z8Dn4HBktxzX82yG6Qu/pD5G2oaPzCBCYj1xnB486Mbqm99fup
         NED3a3t1Npj9OIARBwCuKC2bWKkj97NFl+b0FkvAOHxF/iFfPaR9zzCz9YYF+kxUUupP
         O+48eKYFLjG28my3hUHlgn+wtUwcz/XvdzDGLbONHNJK3uL4WvJ54Ue2/OpLKWcPOS2b
         ZqVNx20pL8HDWjaZXVvRqpDcczsU3kTQArUZxebIedbHMVJH2cU/fgTbQWN++UngizGN
         Djf9xW8OglCKB+csZR/Gjac59H7VI3ZFqTo7KbgAivkyULL0rHXF7bG4UVIiIq9eWNgW
         7+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516622; x=1692121422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MmEGhsWcyV2tJiWGbgG48WJpgMlPeUsMr9lr8DHG50=;
        b=kuw8EK7/S04SzIA460i9cuI3Q+mWWgSQldYlFoELjSs8sjJKtkwPn1uskd2jrrUPPI
         94vIOQBesqCNrQ2Syc8NSHJfNPl/V/2QcPab7c5258P4RZxNPkCfbMLfUiY2IXwVV2E7
         QR4aW/GJVLbaKnqw4ICW8c4Ob/zZRzHo5WMSm4CLRwQvrsYCUacgXtgkJvhJ0E3aIY7a
         V9IB0ojFrmfHen/y9eaLFdJ2sZA1OI+Q/DNVzhYwfPUmG553Fj8F15UuXCNXiGXnSdZd
         6JfPp3Zi8cxZqGSPeOMZM4z9iUg8efSxQdDXdi5nXNEZSH4lvXaxkvk5mEI+d9F4mMJd
         ZXnQ==
X-Gm-Message-State: AOJu0YxGn0d1M2F5geEz9BFrgkqD+w2VABwYPfTsFxeiMJA++Gs0PU04
        /0//VOdXaz/U3luUH5iOqf55Dg==
X-Google-Smtp-Source: AGHT+IHKz5Zsyb9uLFLG9UFYYyG8FqN+IRe8yffZvnZAPP1i84HeUdZsdHqQNw+tO7uYnme50hdlgw==
X-Received: by 2002:a5d:5253:0:b0:317:cff4:7357 with SMTP id k19-20020a5d5253000000b00317cff47357mr7262024wrc.20.1691483266358;
        Tue, 08 Aug 2023 01:27:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:45 -0700 (PDT)
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
Subject: [PATCH 02/11] clk: samsung: exynos4: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:29 +0200
Message-Id: <20230808082738.122804-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 drivers/clk/samsung/clk-exynos4.c        | 5 ++++-
 drivers/clk/samsung/clk-exynos4412-isp.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 43207257a9cc..4ec41221e68f 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -135,6 +135,9 @@
 #define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
 #define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR					(CLK_DIV_CORE2 + 1)
+
 /* the exynos4 soc type */
 enum exynos4_soc {
 	EXYNOS4210,
@@ -1275,7 +1278,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
 
-	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, CLKS_NR);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
index 1470c15e95da..a70c2b06a61a 100644
--- a/drivers/clk/samsung/clk-exynos4412-isp.c
+++ b/drivers/clk/samsung/clk-exynos4412-isp.c
@@ -22,6 +22,9 @@
 #define E4X12_GATE_ISP0		0x0800
 #define E4X12_GATE_ISP1		0x0804
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR_ISP		(CLK_ISP_DIV_MCUISP1 + 1)
+
 /*
  * Support for CMU save/restore across system suspends
  */
@@ -121,7 +124,7 @@ static int __init exynos4x12_isp_clk_probe(struct platform_device *pdev)
 	if (!exynos4x12_save_isp)
 		return -ENOMEM;
 
-	ctx = samsung_clk_init(dev, reg_base, CLK_NR_ISP_CLKS);
+	ctx = samsung_clk_init(dev, reg_base, CLKS_NR_ISP);
 
 	platform_set_drvdata(pdev, ctx);
 
-- 
2.34.1

