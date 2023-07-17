Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49075677F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGQPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjGQPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60B10C8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fbf1f6c771so7448562e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607156; x=1692199156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5UGzoa3/koIQxPCbuvsSf/gSJDcDpJCJzVPK7lHYGg=;
        b=lvVIY5HnPn775etSZkJURynY2sELYdbHS1aL5KCIr3doLxGDLnqsV3pw6iT8ywcyv7
         PXv6Q3CxYOk/JR9hmr4AZwP8LJS1PKxZLfMDtahvpo3yZf3ocFX1E4shgymv645TRCKo
         IBM2c/D8OEJf6r/WzIWy0VHZAG8Ubm9cCvdF0eXtplWUp8863aHM844dbanbe21l+QNk
         KU9toeof+Es9vrY2kqbu0trTogO/L69I4Qiss7nPWr5qHSp8GPxFNzzlc6VmWCKsYODr
         3UN+B1Smhq1wZWAisUEpXf/YmX3AK42rKdHkPlUiduUKG4UoWKQm8/A1snZ/W8aKezxN
         5Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607156; x=1692199156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5UGzoa3/koIQxPCbuvsSf/gSJDcDpJCJzVPK7lHYGg=;
        b=IsU4QtHepXCj7dc3sYefckYiF5JpUAoUr3OPo4uumymljQNA+gqZqOFxzGx+IG4TSx
         QttyUF4Wd43E6uq04d+zfqiEVBKlFKBPvH01V0iss/SHqGNgQBTeQEYY/XmCj8om0kQA
         JNYWECTKtigFOEo+EXfiRbTNQ62CxDtXX9m/9h5lvjOKBIy0q0CZd+ZigaOEG9GvZpsh
         EgC9Y3x64ednkUZhyKg0fyn9P/sd2GJoBeqb1BqotMC+G2eFk2RbDttEWFvchSo+9wkY
         6728CSe4lihbZks9zi9kCcW3u+PTC1w0lzSNCJ3b8jwcsyBP8ZQgh80LrQ+ixBSilcdE
         mvwQ==
X-Gm-Message-State: ABy/qLZOJXOFOh2AVUUVWmogqwL6DmB1l/sqNA94v1PFMjpud1ncrsnM
        wA/Y36lkPQUa6v6v+hMbItYeVQ==
X-Google-Smtp-Source: APBJJlHpfSk3/uCqQQp9NNFSIXwZiqk7fxeoXosh4JKIvtnPHYF9rh1kRUNdd+clQ0VkTHqtErvdfA==
X-Received: by 2002:a05:6512:114e:b0:4f8:56cd:da8c with SMTP id m14-20020a056512114e00b004f856cdda8cmr8589577lfg.34.1689607156634;
        Mon, 17 Jul 2023 08:19:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:16 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:11 +0200
Subject: [PATCH 04/15] clk: qcom: gcc-sm6375: Add runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=1780;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WXWB5RGonBM5RqpbxW2SMsHOf815i9gADOm2q9pJjmc=;
 b=pWDCxZlE9tVeTMDDwCA3p9Rrnt12uzwSvlwHXrl1IvLIW1632NI1TETMDnuB+qC3FrRMZgcEF
 TtvljvXN3azCzTks/QYfkOJ+xYNaQKKqWTAnKYaUWJ/hO2MD6rDpj2Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
that it's enabled to prevent unwanted power collapse.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6375.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 14dafea45ac9..4b2de545d3f8 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm6375-gcc.h>
@@ -3784,9 +3785,19 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	regmap = qcom_cc_map(pdev, &gcc_sm6375_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
@@ -3817,7 +3828,10 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpll8, regmap, &gpll8_config);
 	clk_zonda_pll_configure(&gpll9, regmap, &gpll9_config);
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6375_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gcc_sm6375_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gcc_sm6375_driver = {

-- 
2.41.0

