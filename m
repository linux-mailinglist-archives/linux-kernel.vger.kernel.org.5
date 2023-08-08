Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD277462B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjHHSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjHHSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:53:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4415A788
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:08:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so9785583e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514511; x=1692119311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/ysiPNWLR7wpbVD7YtHSC9xvbZhsi6ZL4lXHxj1M6c=;
        b=WXlIwPtrbwQUHLrgqzNP4VwkBxUFTgcWuuU1IMlVqUP2X7xP1zHazvL2dlNa9wv7NG
         23zju8FtFsjlHl7xXemQfLhdeYmdlnZ9R1Oir+am+/0oJ4hxnSnwT8UnUho6oTykp1HQ
         9OT8oPiy/PXy2jbsg8qUQ/0/MaqjBHfD97BWAwWH0k9mCQbkRrmvS4mHmoyevcq9cQHx
         kkndfZFCOe/8PXCHYVNG2ZT6W93wYsk7rQ6j0wD33aLbdUBz3sIgCE9hxsJstvTltTv2
         eoXGhPvDs7RSHCbu0H30sccD1jgVEDPk6rvN3osgorStgJlbKfA2l2I2YhggEM5fCXae
         0rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514511; x=1692119311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/ysiPNWLR7wpbVD7YtHSC9xvbZhsi6ZL4lXHxj1M6c=;
        b=ZsReRVqi/8l5pKRRvxvETjUNrX19i1SUa7orhzSVpod8DvJ3fCIfO3yyxDHs0XsX54
         e85N/pzt+Wn26+wniaDW5H+Sqfu8gM/pXb43BioWzbMZ0A+6YxBD899edlzxbGeC6k3n
         j62oKnX5MjjzuYs6+Qz90+eHATaYn65PnYaexsLagV5qlSbUvnao40nUDSfj/QhPyC+U
         BbKK3XVeAiYdFFnI0M79A8zlwFpz/G9zwPmgfuIUyj3yxSdnVGWjCorhxDoHCyJ1AhYS
         B6czeY0IyphMd9CAqUSkZDUQ8vDacIuozIRJzJ2NyyaCowdJtKE89cmiqpKDLzOStrf/
         N34Q==
X-Gm-Message-State: AOJu0YwpjDZ2f8FLWIssEV+Hq/wvBREaoWeBMZaJVYHfOnuwVQ+2Li7l
        75gYm3dZ+bZdGsRa+WKDFndN73LWtbGpGKEzggU=
X-Google-Smtp-Source: AGHT+IFQ1+reGKbu7+VQxeellkzInKFEL4NfkTVROJIeIltY/tZlYlFyqdoEIWGGNtTNFwjonuVnVw==
X-Received: by 2002:a05:6512:2347:b0:4f9:5580:1894 with SMTP id p7-20020a056512234700b004f955801894mr8212298lfu.15.1691483274184;
        Tue, 08 Aug 2023 01:27:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm12861246wrn.83.2023.08.08.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:27:53 -0700 (PDT)
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
Subject: [PATCH 06/11] clk: samsung: exynos5420: do not define number of clocks in bindings
Date:   Tue,  8 Aug 2023 10:27:33 +0200
Message-Id: <20230808082738.122804-7-krzysztof.kozlowski@linaro.org>
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
 drivers/clk/samsung/clk-exynos5420.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 1e0cbf762408..199843f12ae5 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -139,6 +139,9 @@
 #define SRC_KFC			0x28200
 #define DIV_KFC0		0x28500
 
+/* NOTE: Must be equal to the last clock ID increased by one */
+#define CLKS_NR			(CLK_DOUT_PCLK_DREX1 + 1)
+
 /* Exynos5x SoC type */
 enum exynos5x_soc {
 	EXYNOS5420,
@@ -1587,7 +1590,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 
 	exynos5x_soc = soc;
 
-	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, CLKS_NR);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
-- 
2.34.1

