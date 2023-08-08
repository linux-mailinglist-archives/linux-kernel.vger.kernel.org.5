Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A46773CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjHHQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjHHQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:11:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A47D89
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:46:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-318015ade49so17617f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509602; x=1692114402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMzXqqe28IQY+hzgVA8sdRyW99nsQbJZiTRlRSVrT6A=;
        b=lNKwCw2GRrjHxDJnRo9Ed9pvkCpPuk3WF5KsmBmDJBjXTRZyyd9hNYX6Jc64w11gNP
         IDuEMQ+QNdwX4AdtobwBPXKmXUkVN6+9/4delCp2EkuPPLfwkhGyMo8ZfEKot88XMxGU
         Jh3UWBy9FYgTPS27/6FretwrFZlsUkp5h00oEILD7hAJGGE0l10ZtGRFn/TJ/on1VqDK
         aCgHfYN/R1PXspji8olHpDUfgqALNItmD281Havhpk7cLKqbS2IapXTBEreVhNzaH+lz
         Biw1DfkCCVSX8qi+do7Pm+wtrnHig1e39W4+A+6Bz3yPIDhJ1/0or/jw+CsMkR62EpQA
         LAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509602; x=1692114402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMzXqqe28IQY+hzgVA8sdRyW99nsQbJZiTRlRSVrT6A=;
        b=Z4jGKbDKhSAgCkaA9iJsG2Nar8XAL0o7i70+QYRl93HRECdqNYVXBAEq7hdEN+Dtkv
         zlClDojgwDifWOwP7+wmZPjQkQ36KnQLOsr7Tcort1u2Um4N3gTxU3uwnAaAWonmVMUn
         Mvgc2X6RzX91F0+lvA6EACLPuRVD7pi1zn94byNr1rVs5vFY417EfOwkmdWkqo4iuOQs
         wDo1IaKgT7CyeSYOsST41Ukh4u8bYF3kKQStn5l7UNCRX3fazrlCsaQnrLa8AnuMkstZ
         wWthC6NayHlIQehjQeOjDsz5mES4GuaVVnXOcOuSLPpogjwz1yKdSo4nwkWvKB4FzJPr
         wKzQ==
X-Gm-Message-State: AOJu0YwxL4UsWd0IXB8A8+KqAb2112fu90eK5htrtdFOW7nRZhwKl9zL
        2YEKL0MM5HK/dL90z7QNtUp4TDYHEpQ0jxq9OtU=
X-Google-Smtp-Source: AGHT+IE8JZGO5AJlHB0gVlpfgqATSBJHgAWyKC6QKwkPaljKOyd6RoW2fJ5F/H5/4XrPqd1hvBYD1Q==
X-Received: by 2002:a5d:5257:0:b0:314:4a15:e557 with SMTP id k23-20020a5d5257000000b003144a15e557mr8567311wrc.5.1691483272362;
        Tue, 08 Aug 2023 01:27:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:51 -0700 (PDT)
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
Subject: [PATCH 05/11] clk: samsung: exynos5410: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:32 +0200
Message-Id: <20230808082738.122804-6-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/samsung/clk-exynos5410.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index d67d67a519a4..2654077211e7 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -56,6 +56,9 @@
 #define SRC_KFC			0x28200
 #define DIV_KFC0		0x28500
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR			512
+
 /* list of PLLs */
 enum exynos5410_plls {
 	apll, cpll, epll, mpll,
@@ -260,7 +263,7 @@ static const struct samsung_cmu_info cmu __initconst = {
 	.nr_div_clks	= ARRAY_SIZE(exynos5410_div_clks),
 	.gate_clks	= exynos5410_gate_clks,
 	.nr_gate_clks	= ARRAY_SIZE(exynos5410_gate_clks),
-	.nr_clk_ids	= CLK_NR_CLKS,
+	.nr_clk_ids	= CLKS_NR,
 };
 
 /* register exynos5410 clocks */
-- 
2.34.1

