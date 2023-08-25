Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B71788CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbjHYPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbjHYPir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7AA270F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso1663580e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977917; x=1693582717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiZENdL6t9VEM6eAL38ECOvrFwxXjTQK1S+ZGsAEBlQ=;
        b=Fp+8EHZfqbz8xMhsp71HyfyfrWrsLV6a4fh9+tgs4iQCS3qAMKzu3r/2Ulct5MJNuA
         +/dWnhDbwDk5tTA5dnStQP3n84O0fB/4vuW0XqT9H1Rq13MHNll/eM+k+MXn7qSC1nJG
         53uB85uplDbtaT1W/Ojj3pyBa/Jr0Llq1gHIC4EV826trj1iYbHUBRjKHVTpqPReNDii
         FheD962F6m721rwOTrnmBbr38CirslprwQAsDZJTnfWfdL3gWVnRUEWCnlMoKbsnoIhl
         XDuFq//TZ2MNAdVGMej8u3uWDly5aaTbTqK1B5lS7Eqi06dURqXc3IUAdeIml0ZueXK5
         oO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977917; x=1693582717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiZENdL6t9VEM6eAL38ECOvrFwxXjTQK1S+ZGsAEBlQ=;
        b=RWaU7E9WTr9jM0HnO/RVHVqkfcj+EG8S7pGzvLmhYkqgRsSiIASE6bByZqoR18s8Yp
         gPsCnU7UEKwJJT0gODTKYJtK5KcNUhSC7BOi9y+ybiH5XkL12IrpxUKotgNNVQ7i4POe
         Iv9Ze5SmV4zGPztw/gsgp9UFPBpwspODPowkdYKMkV3ldnVWvmm5pcu5lidU2jmVIhY9
         zm8WuZghFTWP0naqkWe0rHC9wWfey6VQeqQftJGkgbU9XEYSsGWA7YOn/CEalgS5XAbs
         +U0CpnVTFb733zIik/MtgRQydhjctK0t+TOysA9GILTdWAYsTIDnDu1u/xJghIA7SQC5
         TrOQ==
X-Gm-Message-State: AOJu0Yy3WjHXeACY6Vwl/uL+53KI0p5MrHFjzjsa0xY/iFn78+cLmvWK
        NrA1ryIalgVV9krYUmnz/O6nyQ==
X-Google-Smtp-Source: AGHT+IHgvbNgd/z7RmMgRHy4tYPVXlvxPZk9qUYWcaklbmHdT70adu20BDaNu8UMdLGsOqKXh70UBA==
X-Received: by 2002:a05:6512:a94:b0:4fe:c4e:709f with SMTP id m20-20020a0565120a9400b004fe0c4e709fmr16313758lfu.20.1692977916991;
        Fri, 25 Aug 2023 08:38:36 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:31 +0200
Subject: [PATCH v4 09/10] interconnect: qcom: msm8996: Set AB/IB
 coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-9-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=1682;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SdQeJUatGaAH+ZYrspx7Qreq3n6DZHgEM2odYauRg7s=;
 b=bdk73CBuWAS1tNrDhRP36Vyq/v2nzE4DhHI2/O3H64qS1n5nYYTyfC3YEEG37P5XRKwQtT54M
 0c1XxojsuJfArVRhD7dZaVj7joG1trZlxlHZzK1FIIdlImZ4kX18Q4+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses and nodes need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8996.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 88683dfa468f..b73566c9b21f 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -448,6 +448,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.name = "mas_mdp_p0",
 	.id = MSM8996_MASTER_MDP_PORT0,
 	.buswidth = 32,
+	.ib_coeff = 25,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -463,6 +464,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.name = "mas_mdp_p1",
 	.id = MSM8996_MASTER_MDP_PORT1,
 	.buswidth = 32,
+	.ib_coeff = 25,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -1889,7 +1891,8 @@ static const struct qcom_icc_desc msm8996_bimc = {
 	.nodes = bimc_nodes,
 	.num_nodes = ARRAY_SIZE(bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
-	.regmap_cfg = &msm8996_bimc_regmap_config
+	.regmap_cfg = &msm8996_bimc_regmap_config,
+	.ab_coeff = 154,
 };
 
 static struct qcom_icc_node * const cnoc_nodes[] = {
@@ -2004,7 +2007,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
-	.regmap_cfg = &msm8996_mnoc_regmap_config
+	.regmap_cfg = &msm8996_mnoc_regmap_config,
+	.ab_coeff = 154,
 };
 
 static struct qcom_icc_node * const pnoc_nodes[] = {

-- 
2.42.0

