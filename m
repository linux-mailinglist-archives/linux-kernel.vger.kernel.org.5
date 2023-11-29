Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56C27FDFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjK2S7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjK2S7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:59:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940C310D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a04196fc957so12674566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701284375; x=1701889175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZCCtT/OTbXXTOf1M5ryIfFg6M3ApzkRvP5MkQZ2MxU=;
        b=BljyBqmWJQVgeCQSjZ9cNhjEpK2MydOOc5vZwNADGSXU5tqrVji2LhzjcN+lKHJX9H
         LPNy+C5xcidn5NG7m1G8XIq7aAmycRdVlbIKINQ1K9fHWcqAX2bANRZbZgCW6mRJoFDq
         OqtDkuFP57lqK45rW0opVI13mE1NNQX0rK6tqeGrOsxsHP3h7ao717KNaswBn0Tuu9qN
         YvAlRiWqiXYUUe29NtQ3gbWznNgwrk3ISRqpTWR7RIeP2hNP8Z4Dk3T+MPh7wQ0i3IJq
         AqyERlTVHUPqWdVfHSPq5T4ozMU+uvdjgNzKzCkInfVnzFZh36LAXCrApZmhTMGJtD98
         lGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284375; x=1701889175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZCCtT/OTbXXTOf1M5ryIfFg6M3ApzkRvP5MkQZ2MxU=;
        b=v4/x8eV7k2kjZvMUgyrzQ2HPt0UFg2iv/qBek+IeEtVfnrF8gnccnA3q1av8esTcu0
         EPOjjZMxewUsUqAhdKPCjfN1u0RCmTG/ocVgPrX8TYy3pnYat9Pz06ubZIoMO7uH9R3H
         PZuBcIP7xKze8Fey6BQ/etMB//6+wYxCm+2dajhum9D9cj43mUHsP9mKhBCZgPM37tG1
         Bbhc3Ohu9so/khSaUl7Ywa8nkb/GE/crJz1fis8bpkuQ1Or88lO1f0oE7zAdStxrYUO1
         3L3gY525JDXBZTMUylM/MlSr4iwj4GnKmN1K2FBf4JBKZ14iPSmG5j7CPVJrgsvG2Aeb
         JQeg==
X-Gm-Message-State: AOJu0YybZvLrkq0C3W9GOgvIp4TNYterUuREZZVcdTIZLo9YpF8h4wRi
        9fqmRseEQpR5e7UFgffbYR3Wfw==
X-Google-Smtp-Source: AGHT+IEsEvFb+JAl0jRQi/BUPC2VVAi7dGxP2f05nN8nojfZpvIlBL5dqkngFSXjWL9UVHpUD49WfA==
X-Received: by 2002:a17:906:104e:b0:a16:904f:2ee with SMTP id j14-20020a170906104e00b00a16904f02eemr3556464ejj.51.1701284375091;
        Wed, 29 Nov 2023 10:59:35 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061d4b00b009faca59cf38sm8160232ejh.182.2023.11.29.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:59:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 19:59:23 +0100
Subject: [PATCH v2 04/15] clk: qcom: gcc-sm6375: Add runtime PM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v2-4-2a583460ef26@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701284367; l=2103;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+PZmRZ3IclWULU0g4Z+4xO7TS8Y3iYSTcMPv7YVV2GY=;
 b=r/oGLogrHlF2iWi+EL8SNyymKGnjvNbU9vn5sUS5y1Jm3eieGEUX00Gd74OLNtix41F9EfYG7
 /lMABFt1GF5Ch03RVYseoXDc8d3BbzLS361LWP43Xknv3ZCBzJ1iHBY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
that CX is enabled to prevent unwanted power collapse and that the
reference is dropped when unused so that the system can enter a
firmware-managed lower power state.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6375.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 7d55e10373ef..86ed8c255c94 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm6375-gcc.h>
@@ -3785,13 +3786,25 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
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
-	if (ret)
+	if (ret) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
 	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
@@ -3807,7 +3820,10 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
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
2.43.0

