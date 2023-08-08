Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62E773EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjHHQju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHHQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:39:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9215583
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:54:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98377c5d53eso805728966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510045; x=1692114845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLgWmZDXI+7PA/tCxKdChP7EEm6HakzsKLLishyTPzU=;
        b=BHG3zKtYKHDAbybsewWSfTo0jjBTCVS4qtIwYEdxhalRy1wAf930aHvJDE92ffDiJ4
         Bps8PlRXjUBww/jEnboWkx8XB4KQA3tFDZXyzMp9C+q/41Ri5GP4EB02N/Za0YetcNrU
         IFCOIl7i5WJxd46yqwRVShcqaF4gd/CosMa1pTqHAbMEoaiqzckzcaev55kQ3sqNboFh
         JQ1WiPcIRsH66UVxmlxmQ+2zCDZscP5LbcUuzPXcZRIp+12LJO+FPyqg1BUrulsybxiN
         7NQDwRzS5cLcw5zUiwhpiDgUTCisbYflVmw2bw/LpW/N4JCkzY4oeUk/kXZP60ynqLKs
         6tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510045; x=1692114845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLgWmZDXI+7PA/tCxKdChP7EEm6HakzsKLLishyTPzU=;
        b=ZICQPzNrawv85p+3e8z7Fm4GWsKYQgGAMhBDao7koPkhDvJmhogCWAXKOQxqA1aZBk
         /12TDeDRRa1k79mA6STIz6FyhaC5vroA9/rAtlDMMsS4s2LnJNmPTuIgSnbF+k/Ho1hh
         tQreHIcVGfgJ4pCeZ0kXXzduEjYZSilBPKBUixJzzjWOUdNehpxa6eVh8qjPcESUeCtW
         zlxWVFWP3Wz+UG3idR+n6QCpZk0GLMl7cVNyxaeHbIfy8+MGVyXzPLhsFAsqm7+kuvlX
         De/J1DGgzbt9KHDjggjADKB0EIpSng4UG4APFNmGeE1S+k7F0EFlqj9d507/Ta7ZqqPd
         0kYg==
X-Gm-Message-State: AOJu0YxLSR2f5HfbGjHXPok146AxR+bUYK97k251yEIRpTC6hrorl7F2
        yDKWdkbQNojBNfKc4LOXXoBXEJEFfIpiCECroio=
X-Google-Smtp-Source: AGHT+IHVBg/DZAg7RmIjwMmvomUbHWRV+0mz038UqS0mW12UPDmdNCW6SKK0tcZPJuO1Ju+eSdr14Q==
X-Received: by 2002:a05:6512:1185:b0:4fe:45ca:f8e7 with SMTP id g5-20020a056512118500b004fe45caf8e7mr7216190lfr.57.1691495028083;
        Tue, 08 Aug 2023 04:43:48 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id j20-20020ac253b4000000b004fbdba4b075sm1861679lfh.57.2023.08.08.04.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:43:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 13:43:41 +0200
Subject: [PATCH v3 10/10] clk: qcom: smd-rpm: Move CPUSS_GNoC clock to
 interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v3-10-dee684d6cdd2@linaro.org>
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691495013; l=1855;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6rZrHWsPHWWpd+L+pVqcUMQuVU01TmS5LCQGYAT1X0Q=;
 b=jtBpHrfD+ymd4XqtHtbF/noRNPMY58C9Ej/e6oBO74GRvFvp0xnbWwQis4SQSnKJbpvuAezcV
 O1Vfy8GohTlAwg/NRNh5jnTxAmB6T34tNgUqWUBA1EdFDKu7EABgkpv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, it's yet another interconnect bus clock. Move it
there. See [1] for reference.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/02f8c342b23c20a5cf967df649814be37a08227c%5E%21/#F0
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

