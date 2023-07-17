Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16373756791
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGQPUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjGQPTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A01736
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f122ff663eso7332749e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607167; x=1692199167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2B8xuxpSnWhbwKMqhSwKujiuUg9pN0gk3aNyNEAwhE=;
        b=eatRw8c4boyIvPhRaLxD5x7GbLwPJJdKgtqcudBmKAdJt+3WsAZKB38G0s6JoxepuQ
         1fiUEMRMTEFV1vib41dJVQP0cD0paZULlKEpDLB92OHcSDPBbuXp6WyAcETmaCcOagsP
         owYnk+Dx9Miu+jMEr8902UgaPz5k73GYoZ7pG9P2XWtQ/uS1Z38lCs3ouAqp9BRpyPry
         3WArdvrA+wp9YrmQztsJFI973HztM90xTT9sVX5/1Vq8OCI4OTiV3gEJQ7H95spvY+ZY
         J0eNkvk4CvPPt4bwmw5o8Z1zy94t/zZe6iK4luYmY4UISQ8nD3X2eV1lqjxuzewQm2ry
         ayxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607167; x=1692199167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2B8xuxpSnWhbwKMqhSwKujiuUg9pN0gk3aNyNEAwhE=;
        b=ATd/9/TPJOV9k4Woz5o4AaluGKt+T+6QSImJAj2rMUMHrqFbuxooRE7aWm88uL4dWP
         LxJ5difUpH7dley4OhnRgQLZ586ZGvDd0RSUDkFyk8jRDribAhkka+iqqNJDym0dNiJz
         hAFR8gUo0ewOP11RlOL78WbkmaSJwIEqNnhxt3qMgtYccG5A9dPJsXuwT84SZ0bQgPBH
         ouE7h6yw1CHfHknXRiovzor3c21wwFMcoLd7GRHlZPpyEqx5jPxRqESKBuiAMMIk7jpy
         U+sqMkE9UDwyjghDUby2VHfj9GaBLNVv/zK5LUoj3Bk5Co+tFTcrQvEFDdXoWOE8nEbg
         jVmw==
X-Gm-Message-State: ABy/qLaDYD42uewkKrJt+HFg/zdVdFsPk09/4OPLAOn8GYMRU2OQERzp
        M//8ZsVEcyTHw5jczUrpK2zVgQ==
X-Google-Smtp-Source: APBJJlHB3Bu3FGOXz02ywSPZuf438emMgo46bOSYRj1mEklm8d1Vtr4u/9AvxT1lJdyyybspIOgeGg==
X-Received: by 2002:ac2:5f7a:0:b0:4f8:6ea5:104b with SMTP id c26-20020ac25f7a000000b004f86ea5104bmr6981516lfc.30.1689607166903;
        Mon, 17 Jul 2023 08:19:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:18 +0200
Subject: [PATCH 11/15] clk: qcom: gcc-qcm2290: Add runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-11-27784d27a4f4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=1980;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SEE5Vf2kJq6CXu3dBwAauLybj1NpUkl0+Tc5/vKK29A=;
 b=xpHotqpRsd1M6m6fXXG+MlRWzVc91b4BPgGLqLB6PoDcJtO6t4WTluXgb8iW4mKZN3lEG/wW6
 53LYl6aqR+mDtzTQEBZpmTgapcF2rbKk+1paoIbTctCdLj3Ur5Ddb2j
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

The GCC block on QCM2290 is mostly powered by the VDD_CX rail. We need
to ensure that it's enabled to prevent unwanted power collapse.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-qcm2290.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 1a8acc2de921..573cb550d678 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
@@ -2882,14 +2883,26 @@ static int gcc_qcm2290_probe(struct platform_device *pdev)
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
 	regmap = qcom_cc_map(pdev, &gcc_qcm2290_desc);
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
 
 	clk_alpha_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_alpha_pll_configure(&gpll11, regmap, &gpll11_config);
@@ -2912,7 +2925,10 @@ static int gcc_qcm2290_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x36004);
 	qcom_branch_set_clk_en(regmap, 0x2b06c);
 
-	return qcom_cc_really_probe(pdev, &gcc_qcm2290_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gcc_qcm2290_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gcc_qcm2290_driver = {

-- 
2.41.0

