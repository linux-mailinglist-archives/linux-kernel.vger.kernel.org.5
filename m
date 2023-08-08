Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBB77419C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjHHRZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjHHRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:25:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB12024E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:10:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-314172bac25so4458007f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511008; x=1692115808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZH8BihJHBp/DZtT1lzAgFgSWlR+gykQRY/CxVLX/NQ=;
        b=NpAtYG7yvfdEZ9VitkztsN2vEzb+HqUnfxal1F91GO8TwmAqwcOu1MBZqK1Gxw1NOQ
         xMkZgC5EdfCo5H1kL51XcJbkfG/oi4H/TVNZurqAKJRDFLiYicOdPCPPyRn13QWhgJzd
         vNuQHmjARlpQY/EGlZJ3TYgahk+Rk3MNbl1oP4t5eB/r4FsAN4JnnlH5aywm2SYoAP//
         q+GwdKctuSgfemgn2mBVwPNVZU27W/gLKTtofxSsKP+/vOpJggtQhZJPBlrG3ztKlUPP
         vX4/hXaylM3dbYTdDqtEvMDJYZtsTgKn38NLI8L+0pYJ12c8joQ8Q/TNAQxnjdWPQaHH
         P69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511008; x=1692115808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZH8BihJHBp/DZtT1lzAgFgSWlR+gykQRY/CxVLX/NQ=;
        b=epdN/8v6GAMqIiMWOUpCW4otv6zATBx91bdoneVSYt3Z3MK9ciH1a1iCoPkyk7o0QM
         biHuKXHD0VCZYf97sC71ZDBcH5kaQXIGpCdRyF1medXGs/dcR8HdUgfQwN25pdRdCyXX
         OWxaGWxKNOzyiEGgo7UDWWwFhbyzKkSZrZQ4GJBUUTcKWiZah+RpnAUVC1HlxryUld6O
         UFIoG7xVHruASh9ynDiiKO6Cvkxlkhcxzn1XZUmImQ4ArJLbt9xiBaJGs+AzGcbQidpS
         CXS4h0RDl9VdWzNyvkBLIO8t9Lr2/LTa9WMh4vwJnCWc9mGa8jPYgIS4Cg8k/BPN4Oca
         bOHQ==
X-Gm-Message-State: AOJu0YxlmEB+2Rnn/KEfllF5JM1+9NNmLYALe5nqcwIogfVy3vXY54W/
        riqUqgr61Qqp/36NKEkuc6T5JZbS9Z8AGLz4Cuw=
X-Google-Smtp-Source: AGHT+IHxIGUFAD12lJphQeKsQdF3PxwsoN29JQ5BiG4xlGacb03xttiIY8EXVTEebeJ/xuBM044S4Q==
X-Received: by 2002:adf:ce90:0:b0:314:3b02:a8a8 with SMTP id r16-20020adfce90000000b003143b02a8a8mr7447482wrn.55.1691483268603;
        Tue, 08 Aug 2023 01:27:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:47 -0700 (PDT)
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
Subject: [PATCH 03/11] clk: samsung: exynos5250: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:30 +0200
Message-Id: <20230808082738.122804-4-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/samsung/clk-exynos5250.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 92fb09922f28..8ebe6155d8b7 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -100,6 +100,9 @@
 #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
 #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR					(CLK_MOUT_VPLLSRC + 1)
+
 /* list of PLLs to be registered */
 enum exynos5250_plls {
 	apll, mpll, cpll, epll, vpll, gpll, bpll,
@@ -797,7 +800,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, CLKS_NR);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
-- 
2.34.1

