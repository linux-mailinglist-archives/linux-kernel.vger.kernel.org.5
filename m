Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149AA7693CE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGaKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGaKyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:54:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4091FC1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe3c7f16bbso476940e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800770; x=1691405570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTLUtM1uWZf53dgnQ6whEyYV6zi8TUCbRr9vAqETA1s=;
        b=c2znP9PqoUorM4mVOlSUImCWst2Akz0RKqIQTFlxtfoGouf3V5vxm5hHMrSfnvDk6w
         iDc4W5LnbB8iO+6WqVkf1RJdjQO32tqDY1dhkOWB0ANLE4YhrnKbBs4JF6r2KV8Pzivc
         jQOgK+j45HGgFkpAAWtybbT4gQ7oOPSqXhJPicHnHQN0Z5weybYA6T/IU1VWScZvn7KX
         tIjnWGS2ICUTkl2NEzOl2HgmS7eo4JzdvdDXbuC2myxbpHM0E0c5lFdeZ4CN8Fw+i0ay
         TUmWIG/0NWdBV8kZPwnIDC4/kh0eEBkXCaRouwBUcsKg90sRppXNWGBzLN6b33UOEQ2c
         gXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800770; x=1691405570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTLUtM1uWZf53dgnQ6whEyYV6zi8TUCbRr9vAqETA1s=;
        b=hoVXug4kBi4dQn6QuXBAILUofk7z3iKzqoj94CeU60cyND7pInldPV4eQYv1Nr5Xhi
         eCvgxYOiRJ0kGJnmKI4sHmlOVaOYCVB4nEOH8LJwv3aZwQMdgwP1GAflOWGh1QaBNtWT
         LwWLHc/j7zt8YwgYuYGvXs9+mf7EGn1Bxx8VHz4IqvMjfJsWx+0Fs06HjJzQjnPesjw3
         Pg0oPypeQoqTHpLffLwqRcqg1C8aVfti26RjXe4/DNlq6DCYNnFWNINj1vQDTsAaN7gc
         YoDV3WKRSUPE+2gPDLfQlFOgxQ/NgGpD98DEcAzc6X6/T43sIzun7z9z21ur2BPqyPG/
         KhEQ==
X-Gm-Message-State: ABy/qLYGmAQ4l0X2z515Hv2W00pvNGTWmkxqBSwM7qTyctswv0u/E0/F
        TOIG6f+bMEgydhvZfcZeNQquHQ==
X-Google-Smtp-Source: APBJJlFUWxcYKuU4u5a9LhTmgvs672pkK9fpTe5+I1nUPTF3TwHcgrZ/chLYFhXXkWRkqkIq7c/ZRQ==
X-Received: by 2002:ac2:5f43:0:b0:4fe:17d6:af2b with SMTP id 3-20020ac25f43000000b004fe17d6af2bmr4626221lfz.42.1690800770093;
        Mon, 31 Jul 2023 03:52:50 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:26 +0200
Subject: [PATCH v2 10/10] clk: qcom: smd-rpm: Move CPUSS_GNoC clock to
 interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-10-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=1713;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=f1Gofilxti3i0Q7jqaHJvi76S1Nc3UXIB2Lux0RrHdA=;
 b=ZIUV/H1zLb4P75oFYqUV+xIVsQu0TlDVvSL9C1x+GsN0LHv5u4f9SllLH2OqfGr/3ZjJQuUnU
 BySvUlyDYmXDqr5yX2+veu8TCUSf9we2B7P1Hh2PHBTmHK/Cs2tC7mI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, it's yet another interconnect bus clock. Move it
there.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 9b5411932594..4a23f6d3eddd 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -567,6 +567,16 @@ static const struct clk_smd_rpm *sm_qnoc_icc_clks[] = {
 	&clk_smd_rpm_bus_2_snoc_clk,
 };
 
+static const struct clk_smd_rpm *qcm2290_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_cnoc_clk,
+	&clk_smd_rpm_mmnrt_clk,
+	&clk_smd_rpm_mmrt_clk,
+	&clk_smd_rpm_qup_clk,
+	&clk_smd_rpm_bus_2_snoc_clk,
+	&clk_smd_rpm_cpuss_gnoc_clk,
+};
+
 static struct clk_smd_rpm *msm8909_clks[] = {
 	[RPM_SMD_QPIC_CLK]		= &clk_smd_rpm_qpic_clk,
 	[RPM_SMD_QPIC_CLK_A]		= &clk_smd_rpm_qpic_a_clk,
@@ -1182,15 +1192,13 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
 	[RPM_SMD_PKA_A_CLK] = &clk_smd_rpm_pka_a_clk,
 	[RPM_SMD_BIMC_GPU_CLK] = &clk_smd_rpm_bimc_gpu_clk,
 	[RPM_SMD_BIMC_GPU_A_CLK] = &clk_smd_rpm_bimc_gpu_a_clk,
-	[RPM_SMD_CPUSS_GNOC_CLK] = &clk_smd_rpm_cpuss_gnoc_clk,
-	[RPM_SMD_CPUSS_GNOC_A_CLK] = &clk_smd_rpm_cpuss_gnoc_a_clk,
 };
 
 static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
 	.clks = qcm2290_clks,
 	.num_clks = ARRAY_SIZE(qcm2290_clks),
-	.icc_clks = sm_qnoc_icc_clks,
-	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
+	.icc_clks = qcm2290_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(qcm2290_icc_clks)
 };
 
 static const struct of_device_id rpm_smd_clk_match_table[] = {

-- 
2.41.0

