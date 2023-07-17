Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D930775677B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGQPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGQPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8D103
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:15 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso7375193e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607154; x=1692199154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEbz14sJogEawdfgO5oBd9h7t4FLIUgSkpv1pu1IPqw=;
        b=L2Ouk7KBh+sMXqs/a+pppZLxaIMTZ4dGtgg/aSl8qpDmqmmuXAb26WlOE3hESDEmyY
         +uGJ/DHeCdAU0m9sh4MwT2jSOHPd5KfEN2ehzpRtPecjbpx914iRdmKcoj4652T6rvgx
         K1lNFph20QeMtm1hzuGrnbgkITQGIqOIhmZDSe9GmSoHcXMIX0ordBBbyhsJ7YVuejV9
         wtu7FfxsatJLBZMZZgx6l3WEUS063PdE0wYG5z3gMDRMMGB/W+zrvoT9j+W9bFJCBS2d
         b6X+nhJrxVMqGAGqkxY14pg+JZ1ro5R71cypGwUJqOmV4Gh/miyOT02eMWz1kfnxAtW0
         Se/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607154; x=1692199154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEbz14sJogEawdfgO5oBd9h7t4FLIUgSkpv1pu1IPqw=;
        b=du4rH9GmrKXLxg9q5n/NL4IN4NI5xmTuUvaUUd7RWWyvhVwsakpBS3CZqf6Fr1wGPA
         uIZA5L9WNSd5TdRwVcFL2zOKWopwsJm5DoLQBl4eduNYd1xgDsIrnFwLeOclIzBj6PDw
         pQ3q6jb8PULfTI9MkMW2dGtv3RdbVdQ6nOmonkEynYQ+TZbgH7UKA/5HQh85EKk7c6rk
         /CqrQl7ojpHKkoWj7UsjtOFXWJweb9u/KnTR99ItRIturIL6zeBE4zLOJLhJl0W1nxez
         mEeVjbLDIhae2VGVs1pygXWY19eLThqHfcUeA04mZDl4rkno77B2fHzKwiSVZu0mcXp8
         NUiw==
X-Gm-Message-State: ABy/qLZbywKoVKGgsG9t0ljaKu2TDCwgTmTQUqbF3/Lcm6hoa/Pbn6JJ
        3YMSQCIyjtDdRMgylaiwskFxKQ==
X-Google-Smtp-Source: APBJJlG57Lhqko2sVmZQ8dp7QT3ILE9qm108opoFBRY1b5NB/ZxWqmkFpl5ACRIuBXOsi1Wg4akdBg==
X-Received: by 2002:a05:6512:46d:b0:4fb:90f7:6769 with SMTP id x13-20020a056512046d00b004fb90f76769mr7248001lfd.21.1689607153898;
        Mon, 17 Jul 2023 08:19:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:13 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:09 +0200
Subject: [PATCH 02/15] clk: qcom: Use qcom_branch_set_clk_en()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-2-27784d27a4f4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=26116;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WD5ZHHQLMyFWQF1yLyD4USNKrd2rTZcsxTllxzqVFIw=;
 b=1i6EXn+AhtpqtfVuQu1WjMmVN9Y7MwxudW2b/HsKxH0DEFNbyKGOvJLMtgW89U8O5Q65obogI
 0sTtEEkucM1A+tG0hpDGhTGu6II3bifIN/laovOJ0uOKvxooFgf/Tfw
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

Instead of magically poking at the bit0 of branch clocks' CBCR, use
the newly introduced helper.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-qcm2290.c     |  2 +-
 drivers/clk/qcom/dispcc-sc7280.c      |  2 +-
 drivers/clk/qcom/dispcc-sc8280xp.c    |  2 +-
 drivers/clk/qcom/dispcc-sm6115.c      |  2 +-
 drivers/clk/qcom/dispcc-sm8250.c      |  2 +-
 drivers/clk/qcom/dispcc-sm8450.c      |  2 +-
 drivers/clk/qcom/dispcc-sm8550.c      |  2 +-
 drivers/clk/qcom/gcc-sa8775p.c        | 18 +++++++++---------
 drivers/clk/qcom/gcc-sc7180.c         | 16 ++++++++--------
 drivers/clk/qcom/gcc-sc7280.c         | 14 +++++++-------
 drivers/clk/qcom/gcc-sc8180x.c        | 20 ++++++++++----------
 drivers/clk/qcom/gcc-sc8280xp.c       | 18 +++++++++---------
 drivers/clk/qcom/gcc-sdx55.c          |  2 +-
 drivers/clk/qcom/gcc-sdx65.c          |  2 +-
 drivers/clk/qcom/gcc-sdx75.c          |  4 ++--
 drivers/clk/qcom/gcc-sm6375.c         |  6 +++---
 drivers/clk/qcom/gcc-sm7150.c         | 16 ++++++++--------
 drivers/clk/qcom/gcc-sm8250.c         | 12 ++++++------
 drivers/clk/qcom/gcc-sm8350.c         | 14 +++++++-------
 drivers/clk/qcom/gcc-sm8450.c         | 14 +++++++-------
 drivers/clk/qcom/gcc-sm8550.c         | 14 +++++++-------
 drivers/clk/qcom/gpucc-sc7280.c       |  4 ++--
 drivers/clk/qcom/gpucc-sc8280xp.c     |  4 ++--
 drivers/clk/qcom/gpucc-sm8550.c       |  4 ++--
 drivers/clk/qcom/lpasscorecc-sc7180.c |  2 +-
 drivers/clk/qcom/videocc-sm8250.c     |  4 ++--
 drivers/clk/qcom/videocc-sm8350.c     |  4 ++--
 drivers/clk/qcom/videocc-sm8450.c     |  6 +++---
 drivers/clk/qcom/videocc-sm8550.c     |  6 +++---
 29 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 44dd5cfcc150..5f90e8c15c01 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -520,7 +520,7 @@ static int disp_cc_qcm2290_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
 	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x604c);
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_qcm2290_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index ad596d567f6a..975f31b51539 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -882,7 +882,7 @@ static int disp_cc_sc7280_probe(struct platform_device *pdev)
 	 * Keep the clocks always-ON
 	 * DISP_CC_XO_CLK
 	 */
-	regmap_update_bits(regmap, 0x5008, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x5008);
 
 	return qcom_cc_really_probe(pdev, &disp_cc_sc7280_desc, regmap);
 }
diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 167470beb369..37b8bbbe9282 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3179,7 +3179,7 @@ static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
 	}
 
 	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x605c);
 
 out_pm_runtime_put:
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
index 1937edf23f21..cf88ca143bd7 100644
--- a/drivers/clk/qcom/dispcc-sm6115.c
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -584,7 +584,7 @@ static int disp_cc_sm6115_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
 	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x604c);
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm6115_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..4f2297043820 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1366,7 +1366,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x8000, 0x10, 0x10);
 
 	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x605c);
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index adbfd30bfc96..e258cd9ba87e 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1789,7 +1789,7 @@ static int disp_cc_sm8450_probe(struct platform_device *pdev)
 	 * Keep clocks always enabled:
 	 *	disp_cc_xo_clk
 	 */
-	regmap_update_bits(regmap, 0xe05c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe05c);
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8450_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index 1e5a11081860..2bd6ca2c952f 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1774,7 +1774,7 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 	 * Keep clocks always enabled:
 	 *	disp_cc_xo_clk
 	 */
-	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe054);
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
 
diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index bb94ff367abd..9db144b7f05f 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4748,15 +4748,15 @@ static int gcc_sa8775p_probe(struct platform_device *pdev)
 	 * GCC_DISP1_XO_CLK, GCC_DISP_AHB_CLK, GCC_DISP_XO_CLK,
 	 * GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK, GCC_VIDEO_XO_CLK.
 	 */
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xc7004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xc7018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x33004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x33018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x7d004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x34004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x34024, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x32004);
+	qcom_branch_set_clk_en(regmap, 0x32020);
+	qcom_branch_set_clk_en(regmap, 0xc7004);
+	qcom_branch_set_clk_en(regmap, 0xc7018);
+	qcom_branch_set_clk_en(regmap, 0x33004);
+	qcom_branch_set_clk_en(regmap, 0x33018);
+	qcom_branch_set_clk_en(regmap, 0x7d004);
+	qcom_branch_set_clk_en(regmap, 0x34004);
+	qcom_branch_set_clk_en(regmap, 0x34024);
 
 	return qcom_cc_really_probe(pdev, &gcc_sa8775p_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index cef3c77564cf..4f79ecb8300d 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2447,14 +2447,14 @@ static int gcc_sc7180_probe(struct platform_device *pdev)
 	 * GCC_CPUSS_GNOC_CLK, GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK,
 	 * GCC_DISP_AHB_CLK, GCC_GPU_CFG_AHB_CLK
 	 */
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x48004);
+	qcom_branch_set_clk_en(regmap, 0x0b004);
+	qcom_branch_set_clk_en(regmap, 0x0b008);
+	qcom_branch_set_clk_en(regmap, 0x0b00c);
+	qcom_branch_set_clk_en(regmap, 0x0b02c);
+	qcom_branch_set_clk_en(regmap, 0x0b028);
+	qcom_branch_set_clk_en(regmap, 0x0b030);
+	qcom_branch_set_clk_en(regmap, 0x71004);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 					ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 1dc804154031..b23f7103d08d 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3458,13 +3458,13 @@ static int gcc_sc7280_probe(struct platform_device *pdev)
 	 * GCC_CAMERA_AHB_CLK/XO_CLK, GCC_DISP_AHB_CLK/XO_CLK
 	 * GCC_VIDEO_AHB_CLK/XO_CLK, GCC_GPU_CFG_AHB_CLK
 	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2701C, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28014, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004);
+	qcom_branch_set_clk_en(regmap, 0x26028);
+	qcom_branch_set_clk_en(regmap, 0x27004);
+	qcom_branch_set_clk_en(regmap, 0x2701C);
+	qcom_branch_set_clk_en(regmap, 0x28004);
+	qcom_branch_set_clk_en(regmap, 0x28014);
+	qcom_branch_set_clk_en(regmap, 0x71004);
 	regmap_update_bits(regmap, 0x7100C, BIT(13), BIT(13));
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index c41b9f010585..14f09c407198 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4587,16 +4587,16 @@ static int gcc_sc8180x_probe(struct platform_device *pdev)
 	 * GCC_CPUSS_GNOC_CLK, GCC_CPUSS_DVM_BUS_CLK, GCC_NPU_CFG_AHB_CLK and
 	 * GCC_GPU_CFG_AHB_CLK
 	 */
-	regmap_update_bits(regmap, 0xb004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb040, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb044, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xb048, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x48190, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x4d004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xb004);
+	qcom_branch_set_clk_en(regmap, 0xb008);
+	qcom_branch_set_clk_en(regmap, 0xb00c);
+	qcom_branch_set_clk_en(regmap, 0xb040);
+	qcom_branch_set_clk_en(regmap, 0xb044);
+	qcom_branch_set_clk_en(regmap, 0xb048);
+	qcom_branch_set_clk_en(regmap, 0x48004);
+	qcom_branch_set_clk_en(regmap, 0x48190);
+	qcom_branch_set_clk_en(regmap, 0x4d004);
+	qcom_branch_set_clk_en(regmap, 0x71004);
 
 	/* Disable the GPLL0 active input to NPU and GPU via MISC registers */
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 1fb6ffac730c..a9b3735baa4b 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7549,15 +7549,15 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK,
 	 * GCC_VIDEO_XO_CLK, GCC_DISP1_AHB_CLK, GCC_DISP1_XO_CLK
 	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xbb004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xbb028, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004);
+	qcom_branch_set_clk_en(regmap, 0x26020);
+	qcom_branch_set_clk_en(regmap, 0x27004);
+	qcom_branch_set_clk_en(regmap, 0x27028);
+	qcom_branch_set_clk_en(regmap, 0x71004);
+	qcom_branch_set_clk_en(regmap, 0x28004);
+	qcom_branch_set_clk_en(regmap, 0x28028);
+	qcom_branch_set_clk_en(regmap, 0xbb004);
+	qcom_branch_set_clk_en(regmap, 0xbb028);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sdx55.c b/drivers/clk/qcom/gcc-sdx55.c
index d5e17122698c..b1ef6223b5ee 100644
--- a/drivers/clk/qcom/gcc-sdx55.c
+++ b/drivers/clk/qcom/gcc-sdx55.c
@@ -1616,7 +1616,7 @@ static int gcc_sdx55_probe(struct platform_device *pdev)
 	 * of the system:
 	 * GCC_SYS_NOC_CPUSS_AHB_CLK, GCC_CPUSS_AHB_CLK, GCC_CPUSS_GNOC_CLK
 	 */
-	regmap_update_bits(regmap, 0x6d008, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x6d008);
 	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
 	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
 
diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
index b0c17043551d..62ea059d528d 100644
--- a/drivers/clk/qcom/gcc-sdx65.c
+++ b/drivers/clk/qcom/gcc-sdx65.c
@@ -1579,7 +1579,7 @@ static int gcc_sdx65_probe(struct platform_device *pdev)
 	 * of the system:
 	 * GCC_SYS_NOC_CPUSS_AHB_CLK, GCC_CPUSS_AHB_CLK, GCC_CPUSS_GNOC_CLK
 	 */
-	regmap_update_bits(regmap, 0x6d008, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x6d008);
 	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
 	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
 
diff --git a/drivers/clk/qcom/gcc-sdx75.c b/drivers/clk/qcom/gcc-sdx75.c
index b6772abdcec5..3c838fb43ce8 100644
--- a/drivers/clk/qcom/gcc-sdx75.c
+++ b/drivers/clk/qcom/gcc-sdx75.c
@@ -2940,8 +2940,8 @@ static int gcc_sdx75_probe(struct platform_device *pdev)
 	 * gcc_ahb_pcie_link_clk
 	 * gcc_xo_pcie_link_clk
 	 */
-	regmap_update_bits(regmap, 0x3e004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3e008, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x3e004);
+	qcom_branch_set_clk_en(regmap, 0x3e008);
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx75_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 417a0fd242ec..e94e88bdfb91 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -3885,9 +3885,9 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	 * Keep the following clocks always on:
 	 * GCC_CAMERA_XO_CLK, GCC_CPUSS_GNOC_CLK, GCC_DISP_XO_CLK
 	 */
-	regmap_update_bits(regmap, 0x17028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x1702c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x17028);
+	qcom_branch_set_clk_en(regmap, 0x2b004);
+	qcom_branch_set_clk_en(regmap, 0x1702c);
 
 	clk_lucid_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_lucid_pll_configure(&gpll11, regmap, &gpll11_config);
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index 6da87f0436d0..696cca37b48b 100644
--- a/drivers/clk/qcom/gcc-sm7150.c
+++ b/drivers/clk/qcom/gcc-sm7150.c
@@ -3008,14 +3008,14 @@ static int gcc_sm7150_probe(struct platform_device *pdev)
 	 * GCC_DISP_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_VIDEO_XO_CLK,
 	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK
 	 */
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x48004);
+	qcom_branch_set_clk_en(regmap, 0x0b004);
+	qcom_branch_set_clk_en(regmap, 0x0b008);
+	qcom_branch_set_clk_en(regmap, 0x0b00c);
+	qcom_branch_set_clk_en(regmap, 0x0b02c);
+	qcom_branch_set_clk_en(regmap, 0x0b028);
+	qcom_branch_set_clk_en(regmap, 0x0b030);
+	qcom_branch_set_clk_en(regmap, 0x71004);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_sm7150_dfs_desc,
 					ARRAY_SIZE(gcc_sm7150_dfs_desc));
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index b6cf4bc88d4d..ad3dd69dd198 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3648,12 +3648,12 @@ static int gcc_sm8250_probe(struct platform_device *pdev)
 	 * GCC_CPUSS_DVM_BUS_CLK, GCC_GPU_CFG_AHB_CLK,
 	 * GCC_SYS_NOC_CPUSS_AHB_CLK
 	 */
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x4818c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x52000, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x0b004);
+	qcom_branch_set_clk_en(regmap, 0x0b008);
+	qcom_branch_set_clk_en(regmap, 0x0b00c);
+	qcom_branch_set_clk_en(regmap, 0x4818c);
+	qcom_branch_set_clk_en(regmap, 0x71004);
+	qcom_branch_set_clk_en(regmap, 0x52000);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 				       ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 1385a98eb3bb..b56a7669b770 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -3811,13 +3811,13 @@ static int gcc_sm8350_probe(struct platform_device *pdev)
 	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK, GCC_DISP_XO_CLK,
 	 * GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK, GCC_VIDEO_XO_CLK
 	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2701c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28020, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004);
+	qcom_branch_set_clk_en(regmap, 0x26018);
+	qcom_branch_set_clk_en(regmap, 0x27004);
+	qcom_branch_set_clk_en(regmap, 0x2701c);
+	qcom_branch_set_clk_en(regmap, 0x71004);
+	qcom_branch_set_clk_en(regmap, 0x28004);
+	qcom_branch_set_clk_en(regmap, 0x28020);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 75635d40a12d..5a7a723ff5ef 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -3285,13 +3285,13 @@ static int gcc_sm8450_probe(struct platform_device *pdev)
 	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
 	 * gcc_video_xo_clk
 	 */
-	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x36020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3701c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42028, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x36004);
+	qcom_branch_set_clk_en(regmap, 0x36020);
+	qcom_branch_set_clk_en(regmap, 0x37004);
+	qcom_branch_set_clk_en(regmap, 0x3701c);
+	qcom_branch_set_clk_en(regmap, 0x81004);
+	qcom_branch_set_clk_en(regmap, 0x42004);
+	qcom_branch_set_clk_en(regmap, 0x42028);
 
 	return qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 277cd4f020ff..a6404421021f 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3349,13 +3349,13 @@ static int gcc_sm8550_probe(struct platform_device *pdev)
 	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
 	 * gcc_video_xo_clk
 	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32030, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004);
+	qcom_branch_set_clk_en(regmap, 0x26028);
+	qcom_branch_set_clk_en(regmap, 0x27004);
+	qcom_branch_set_clk_en(regmap, 0x27018);
+	qcom_branch_set_clk_en(regmap, 0x71004);
+	qcom_branch_set_clk_en(regmap, 0x32004);
+	qcom_branch_set_clk_en(regmap, 0x32030);
 
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52024, 0x0);
diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 1490cd45a654..a678c51cd75e 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -461,8 +461,8 @@ static int gpu_cc_sc7280_probe(struct platform_device *pdev)
 	 * Keep the clocks always-ON
 	 * GPU_CC_CB_CLK, GPUCC_CX_GMU_CLK
 	 */
-	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x1098, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x1170);
+	qcom_branch_set_clk_en(regmap, 0x1098);
 	regmap_update_bits(regmap, 0x1098, BIT(13), BIT(13));
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sc7280_desc, regmap);
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..c709365a3c57 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -448,8 +448,8 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	 * Keep the clocks always-ON
 	 * GPU_CC_CB_CLK, GPU_CC_CXO_CLK
 	 */
-	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x109c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x1170);
+	qcom_branch_set_clk_en(regmap, 0x109c);
 
 	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
index 8a2e3522af51..225807979435 100644
--- a/drivers/clk/qcom/gpucc-sm8550.c
+++ b/drivers/clk/qcom/gpucc-sm8550.c
@@ -581,8 +581,8 @@ static int gpu_cc_sm8550_probe(struct platform_device *pdev)
 	 *	gpu_cc_cxo_aon_clk
 	 *	gpu_cc_demet_clk
 	 */
-	regmap_update_bits(regmap, 0x9004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x900c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x9004);
+	qcom_branch_set_clk_en(regmap, 0x900c);
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm8550_desc, regmap);
 }
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 010867dcc2ef..7fa2e28489fd 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -405,7 +405,7 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 	 * Keep the CLK always-ON
 	 * LPASS_AUDIO_CORE_SYSNOC_SWAY_CORE_CLK
 	 */
-	regmap_update_bits(regmap, 0x24000, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x24000);
 
 	/* PLL settings */
 	regmap_write(regmap, 0x1008, 0x20);
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..1f269025f3f8 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -384,8 +384,8 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
 
 	/* Keep VIDEO_CC_AHB_CLK and VIDEO_CC_XO_CLK ALWAYS-ON */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe58);
+	qcom_branch_set_clk_en(regmap, 0xeec);
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
index b148877fc73d..4e6b2c7fe61b 100644
--- a/drivers/clk/qcom/videocc-sm8350.c
+++ b/drivers/clk/qcom/videocc-sm8350.c
@@ -524,8 +524,8 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 	 *      video_cc_ahb_clk
 	 *      video_cc_xo_clk
 	 */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe58);
+	qcom_branch_set_clk_en(regmap, 0xeec);
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
index 7d0029b8b799..deaf58c95749 100644
--- a/drivers/clk/qcom/videocc-sm8450.c
+++ b/drivers/clk/qcom/videocc-sm8450.c
@@ -428,9 +428,9 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
 	 *	video_cc_sleep_clk
 	 *	video_cc_xo_clk
 	 */
-	regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x80e4);
+	qcom_branch_set_clk_en(regmap, 0x8130);
+	qcom_branch_set_clk_en(regmap, 0x8114);
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index e2400fe23e60..802bbd616b2f 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -435,9 +435,9 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 	 *	video_cc_sleep_clk
 	 *	video_cc_xo_clk
 	 */
-	regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x80f4);
+	qcom_branch_set_clk_en(regmap, 0x8140);
+	qcom_branch_set_clk_en(regmap, 0x8124);
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
 

-- 
2.41.0

