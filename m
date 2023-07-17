Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFF75678F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGQPT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGQPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB410E3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so7472934e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607164; x=1692199164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WE5v23OlD5LJtk2p6O/kwniXhCkm0INjdGCu2aq7Yhw=;
        b=K2RsrZiK6ywueOF8zudyG+3JPdxj2VzooeydrEYDhn6MH3y2AzQgPEOv7wJ04lLjs9
         cUt6wh24LZmLfEwZN94lrzri2sEkYSe6/p25EjiUbs2tlvVcwW0CS3t+bQ8N3Pbx6x6I
         TnKo/E1Nta9LtaRi4d5hL9Vn8f5SUfuNpfz33wpqgdILWq5u0XXxmyHI2oZ9BhmnABg+
         Ew9TA0c/OSv/0tGXLusZnDMoSZQc8z+gqWPEPqDBoqdQpDeKkY4hqqCn9d99CVfmEI/F
         aPingDL8a5o/OKd9W+x5JWU8iePt87NZBqyQWrHffKd04jMvwT0PeMZk7cG7EWSdc0RS
         yQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607164; x=1692199164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE5v23OlD5LJtk2p6O/kwniXhCkm0INjdGCu2aq7Yhw=;
        b=URwMEqSUN5HjmRfC/Dz68cPjwCa89d5D7KsAosLa/Y86KpdeZLY0TPR7F4sZN4hwEX
         st/GljbNol8LqP8sfllrjImvpOBkTNojQ5ees1CejOh1kdIuvHxu2jseoblj0UAHxPB+
         XO/zS11Y7D/Y8+FBor8wFPQqMeuZ5qV4UIRVBPsBbySKbumb+lK5ovImSCtnV0WrPnGZ
         ekzp0ZQ8lPAs0RUq2582sdCbraMR9QEfBZaHaiK7LUrhE+Txu4BV9otLaGUlfjQ+132q
         IZo1CMtkfmSfN2ZNpR1eropDtZsIXeYGLV++vmlzzx5V2brXd2CHgWmaLd4KTJNwUn0W
         rKdA==
X-Gm-Message-State: ABy/qLbpbXMjWsPXYKmx6kBYaG1Cft1SjHTF+r82lOwO9dv2t/+LTh1I
        Q9sNdBMXJuIhBiZ8mB48ggkeeQ==
X-Google-Smtp-Source: APBJJlH7uKeucNofXL2/qi1ls8Cjbry39xzk8tL+KG8MMPy6aVi8Dxv8oXsxBh+HgSlPiGqEGkYA2A==
X-Received: by 2002:ac2:4bd0:0:b0:4fd:c0dd:d54b with SMTP id o16-20020ac24bd0000000b004fdc0ddd54bmr2124537lfq.65.1689607164166;
        Mon, 17 Jul 2023 08:19:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:16 +0200
Subject: [PATCH 09/15] clk: qcom: gcc-sm6115: Add runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-9-27784d27a4f4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=1944;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lXR6hOkSuPWCLG8Y1XTv1XtQPJ6qFUCSZCtX0olhcqk=;
 b=DQYrdPNp19ItZkKR9xWvUUJTORbiBfixcO8AHbrs211Ztx4OFUykP8yb7igKdKVAa5/WLFnmo
 qw6yMvFLjcWCmwnUwF5TEtWfHufk7HvsdnuJvf5ryqyOpsGjqyupVfF
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC block on SM6115 is mostly powered by the VDD_CX rail. We need
to ensure that it's enabled to prevent unwanted power collapse.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6115.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 1b6016e7ddeb..7f1e278c63c0 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
@@ -3383,14 +3384,26 @@ static int gcc_sm6115_probe(struct platform_device *pdev)
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
 	regmap = qcom_cc_map(pdev, &gcc_sm6115_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 			ARRAY_SIZE(gcc_dfs_clocks));
-	if (ret)
+	if (ret) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	clk_alpha_pll_configure(&gpll8, regmap, &gpll8_config);
 	clk_alpha_pll_configure(&gpll9, regmap, &gpll9_config);
@@ -3415,7 +3428,10 @@ static int gcc_sm6115_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x36004);
 	qcom_branch_set_clk_en(regmap, 0x2b06c);
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6115_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gcc_sm6115_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gcc_sm6115_driver = {

-- 
2.41.0

