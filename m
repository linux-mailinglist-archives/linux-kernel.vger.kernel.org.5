Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88B7FDFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjK2S7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjK2S7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:59:30 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522910F2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:33 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a02d12a2444so12288366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701284372; x=1701889172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G34oRmQWwmaEcdKICZbCotqgq7CyoPmiPn9FtBZp4/o=;
        b=bSrNFM8wb11guQLrjPHHpZXxMt2WqrtTuCS2aV1oeoXawzbhskqYEYFT+jKWsXkSc2
         B4xo9HKWacAb5Efm6Oca2LYZUIGhLzbuVURELRrO06dvIiAZkLdmwENzAGZaQ2VrmRmO
         pWPYCj47Cf7aqyqssayCO6cil8lQ+DQ+E03jhPtE5bs3YF9d2ZD+8qyTXJV4/eSlBxVV
         Fsgr5fW2PQM6w58gzQi4lMf2hAxgybFtq1YmXXQjUm8tz2n3tLMy3exUxMWq7fzj4+3u
         u4ndBG1ACY3BuDyI+Om+lNu/2wf+YUT1aZBk3EPkp0zbtuiFRQ+HNPCMfEqceD96d0Y+
         xzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284372; x=1701889172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G34oRmQWwmaEcdKICZbCotqgq7CyoPmiPn9FtBZp4/o=;
        b=E2WGKYP6B8fS7L27Ji1a7ir5y5+lh+o3SRoyVfEKvsm9deHoXI7kIJ0Tdq6K4n7YyN
         u9fUfnM6UmkAmc4abWkmdVc17cUpO8OdtoO0r74uhUmXpa0oVbU18Bvs6PrF/AIjVKd2
         z2rzG/j1hZLbelFuC1/hpqy/RMr9BFiaTnfYoXP83P0Y+EsG5PRJGl3so3Y/fdiMd/Ga
         pGFUxmqLF7/swizDK53q6UqQe1JXTn2UXZWTwVh9jfFtAWVpirg4+2G+mMJpeSPJOdth
         k77xvhW39ZZjZIyFepvzuOby2f8w4XeKPIrjB0RnOTL2cbPGm/xPtOHpNenaSX5wb1Nt
         LQ7g==
X-Gm-Message-State: AOJu0YxtBlFIZyyZSeNZidvcUscOpqfxE5BA/AMb2MV7r4h6FRshRMoA
        53Bb3VKJVCYQIPO7UVhIigv2sQ==
X-Google-Smtp-Source: AGHT+IHhIn75j2VBH7S+8m8cDsXRkKODGG0gnrpafNL+84+3jIgTkn52KahfVuUUJavf1VaAF2XfFQ==
X-Received: by 2002:a17:906:17c7:b0:a03:9aa8:166f with SMTP id u7-20020a17090617c700b00a039aa8166fmr12315878eje.37.1701284371999;
        Wed, 29 Nov 2023 10:59:31 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061d4b00b009faca59cf38sm8160232ejh.182.2023.11.29.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:59:31 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 19:59:21 +0100
Subject: [PATCH v2 02/15] clk: qcom: Use qcom_branch_set_clk_en()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v2-2-2a583460ef26@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701284367; l=35726;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ya9hYYF9q9MMnIbg3heC9SiJt8AL/wo3VyKdtLJXwBI=;
 b=B9W59nj/GFAXjZ30GQH2mUGGYZI/8pp6oL+Gm8P0NoHHkZshBkf/RdULP+ygmm7x3Uv4Hgkgp
 Iz2+rDywHutBN6V+JNLb1KvYn+5OEjmVNEotDqAnaCakMZe/TWp3+RO
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

Instead of magically poking at the bit0 of branch clocks' CBCR, use
the newly introduced helper.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/camcc-sm8550.c       |  9 ++-------
 drivers/clk/qcom/dispcc-qcm2290.c     |  3 +--
 drivers/clk/qcom/dispcc-sc7280.c      |  6 +-----
 drivers/clk/qcom/dispcc-sc8280xp.c    |  3 +--
 drivers/clk/qcom/dispcc-sm6115.c      |  3 +--
 drivers/clk/qcom/dispcc-sm8250.c      |  3 +--
 drivers/clk/qcom/dispcc-sm8450.c      |  6 +-----
 drivers/clk/qcom/dispcc-sm8550.c      |  6 +-----
 drivers/clk/qcom/gcc-sa8775p.c        | 24 +++++++++---------------
 drivers/clk/qcom/gcc-sc7180.c         | 21 ++++++++-------------
 drivers/clk/qcom/gcc-sc7280.c         | 19 +++++++------------
 drivers/clk/qcom/gcc-sc8180x.c        | 27 ++++++++++-----------------
 drivers/clk/qcom/gcc-sc8280xp.c       | 24 +++++++++---------------
 drivers/clk/qcom/gcc-sdx55.c          | 11 +++--------
 drivers/clk/qcom/gcc-sdx65.c          | 12 ++++--------
 drivers/clk/qcom/gcc-sdx75.c          |  9 ++-------
 drivers/clk/qcom/gcc-sm4450.c         | 27 ++++++++-------------------
 drivers/clk/qcom/gcc-sm6375.c         | 10 +++-------
 drivers/clk/qcom/gcc-sm7150.c         | 22 ++++++++--------------
 drivers/clk/qcom/gcc-sm8250.c         | 18 ++++++------------
 drivers/clk/qcom/gcc-sm8350.c         | 19 +++++++------------
 drivers/clk/qcom/gcc-sm8450.c         | 20 +++++++-------------
 drivers/clk/qcom/gcc-sm8550.c         | 20 +++++++-------------
 drivers/clk/qcom/gpucc-sc7280.c       |  8 ++------
 drivers/clk/qcom/gpucc-sc8280xp.c     |  8 ++------
 drivers/clk/qcom/gpucc-sm8550.c       |  9 ++-------
 drivers/clk/qcom/lpasscorecc-sc7180.c |  6 +-----
 drivers/clk/qcom/videocc-sm8250.c     |  5 ++---
 drivers/clk/qcom/videocc-sm8350.c     |  9 ++-------
 drivers/clk/qcom/videocc-sm8450.c     | 12 +++---------
 drivers/clk/qcom/videocc-sm8550.c     | 12 +++---------
 31 files changed, 124 insertions(+), 267 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sm8550.c b/drivers/clk/qcom/camcc-sm8550.c
index dd51ba4ea757..de424913cf47 100644
--- a/drivers/clk/qcom/camcc-sm8550.c
+++ b/drivers/clk/qcom/camcc-sm8550.c
@@ -3536,13 +3536,8 @@ static int cam_cc_sm8550_probe(struct platform_device *pdev)
 	clk_lucid_ole_pll_configure(&cam_cc_pll11, regmap, &cam_cc_pll11_config);
 	clk_lucid_ole_pll_configure(&cam_cc_pll12, regmap, &cam_cc_pll12_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	cam_cc_gdsc_clk
-	 *	cam_cc_sleep_clk
-	 */
-	regmap_update_bits(regmap, 0x1419c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x142cc, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x1419c); /* CAM_CC_GDSC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x142cc); /* CAM_CC_SLEEP_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &cam_cc_sm8550_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 9206f0eed446..a6d905feeddb 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -519,8 +519,7 @@ static int disp_cc_qcm2290_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x604c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_qcm2290_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index ad596d567f6a..2d40febbedc2 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -878,11 +878,7 @@ static int disp_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * DISP_CC_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x5008, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x5008); /* DISP_CC_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &disp_cc_sc7280_desc, regmap);
 }
diff --git a/drivers/clk/qcom/dispcc-sc8280xp.c b/drivers/clk/qcom/dispcc-sc8280xp.c
index 30f636b9f0ec..606beb34028d 100644
--- a/drivers/clk/qcom/dispcc-sc8280xp.c
+++ b/drivers/clk/qcom/dispcc-sc8280xp.c
@@ -3178,8 +3178,7 @@ static int disp_cc_sc8280xp_probe(struct platform_device *pdev)
 		goto out_pm_runtime_put;
 	}
 
-	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISP_CC_XO_CLK */
 
 out_pm_runtime_put:
 	pm_runtime_put_sync(&pdev->dev);
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
index 1fab43f08e73..a3cf7d09dfb2 100644
--- a/drivers/clk/qcom/dispcc-sm6115.c
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -583,8 +583,7 @@ static int disp_cc_sm6115_probe(struct platform_device *pdev)
 
 	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 
-	/* Keep DISP_CC_XO_CLK always-ON */
-	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x604c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm6115_desc, regmap);
 	if (ret) {
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index e17bb8b543b5..eedb48311ac9 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -1365,8 +1365,7 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, 0x8000, 0x10, 0x10);
 
-	/* DISP_CC_XO_CLK always-on */
-	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x605c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index 2c4aecd75186..2c374286ee66 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1787,11 +1787,7 @@ static int disp_cc_sm8450_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	disp_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0xe05c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe05c); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8450_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/dispcc-sm8550.c b/drivers/clk/qcom/dispcc-sm8550.c
index aefa19f3c2c5..cad2ca39c6c6 100644
--- a/drivers/clk/qcom/dispcc-sm8550.c
+++ b/drivers/clk/qcom/dispcc-sm8550.c
@@ -1772,11 +1772,7 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 	/* Enable clock gating for MDP clocks */
 	regmap_update_bits(regmap, DISP_CC_MISC_CMD, 0x10, 0x10);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	disp_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0xe054, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8550_desc, regmap);
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sa8775p.c b/drivers/clk/qcom/gcc-sa8775p.c
index 8171d23c96e6..9145ceecbb2f 100644
--- a/drivers/clk/qcom/gcc-sa8775p.c
+++ b/drivers/clk/qcom/gcc-sa8775p.c
@@ -4742,21 +4742,15 @@ static int gcc_sa8775p_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP1_AHB_CLK,
-	 * GCC_DISP1_XO_CLK, GCC_DISP_AHB_CLK, GCC_DISP_XO_CLK,
-	 * GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK, GCC_VIDEO_XO_CLK.
-	 */
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xc7004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xc7018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x33004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x33018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x7d004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x34004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x34024, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32020); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xc7004); /* GCC_DISP1_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xc7018); /* GCC_DISP1_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x33004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x33018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x7d004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x34004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x34024); /* GCC_VIDEO_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sa8775p_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index a3406aadbd17..8fcf30fe2050 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -2443,19 +2443,14 @@ static int gcc_sc7180_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CPUSS_GNOC_CLK, GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK,
-	 * GCC_DISP_AHB_CLK, GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x48004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b02c); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b028); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b030); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 					ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 2b661df5de26..b2e2fa2a01a7 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3453,18 +3453,13 @@ static int gcc_sc7280_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CAMERA_AHB_CLK/XO_CLK, GCC_DISP_AHB_CLK/XO_CLK
-	 * GCC_VIDEO_AHB_CLK/XO_CLK, GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2701C, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28014, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004);/* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028);/* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004);/* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2701c);/* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28004);/* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28014);/* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004);/* GCC_GPU_CFG_AHB_CLK */
 	regmap_update_bits(regmap, 0x7100C, BIT(13), BIT(13));
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index ae2147381559..764cd41c5660 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -4579,23 +4579,16 @@ static int gcc_sc8180x_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/*
-	 * Enable the following always-on clocks:
-	 * GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK, GCC_DISP_AHB_CLK,
-	 * GCC_VIDEO_XO_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_XO_CLK,
-	 * GCC_CPUSS_GNOC_CLK, GCC_CPUSS_DVM_BUS_CLK, GCC_NPU_CFG_AHB_CLK and
-	 * GCC_GPU_CFG_AHB_CLK
-	 */
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
+	qcom_branch_set_clk_en(regmap, 0xb004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb040); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb044); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xb048); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x48004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x48190); /* GCC_CPUSS_DVM_BUS_CLK */
+	qcom_branch_set_clk_en(regmap, 0x4d004); /* GCC_NPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	/* Disable the GPLL0 active input to NPU and GPU via MISC registers */
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index bfb77931e868..1ba78990b9f4 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -7543,21 +7543,15 @@ static int gcc_sc8280xp_probe(struct platform_device *pdev)
 		goto err_put_rpm;
 	}
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK,
-	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK,
-	 * GCC_VIDEO_XO_CLK, GCC_DISP1_AHB_CLK, GCC_DISP1_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xbb004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xbb028, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26020); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27028); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28028); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0xbb004); /* GCC_DISP1_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xbb028); /* GCC_DISP1_XO_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sdx55.c b/drivers/clk/qcom/gcc-sdx55.c
index d5e17122698c..314931b4b10f 100644
--- a/drivers/clk/qcom/gcc-sdx55.c
+++ b/drivers/clk/qcom/gcc-sdx55.c
@@ -1611,14 +1611,9 @@ static int gcc_sdx55_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	/*
-	 * Keep the clocks always-ON as they are critical to the functioning
-	 * of the system:
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK, GCC_CPUSS_AHB_CLK, GCC_CPUSS_GNOC_CLK
-	 */
-	regmap_update_bits(regmap, 0x6d008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
-	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
+	qcom_branch_set_clk_en(regmap, 0x6d008); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22)); /* GCC_CPUSS_GNOC_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx55_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sdx65.c b/drivers/clk/qcom/gcc-sdx65.c
index ffddbed5a6db..999268cc8eee 100644
--- a/drivers/clk/qcom/gcc-sdx65.c
+++ b/drivers/clk/qcom/gcc-sdx65.c
@@ -1574,14 +1574,10 @@ static int gcc_sdx65_probe(struct platform_device *pdev)
 	regmap = qcom_cc_map(pdev, &gcc_sdx65_desc);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
-	/*
-	 * Keep the clocks always-ON as they are critical to the functioning
-	 * of the system:
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK, GCC_CPUSS_AHB_CLK, GCC_CPUSS_GNOC_CLK
-	 */
-	regmap_update_bits(regmap, 0x6d008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21));
-	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22));
+
+	qcom_branch_set_clk_en(regmap, 0x6d008); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(21), BIT(21)); /* GCC_CPUSS_AHB_CLK */
+	regmap_update_bits(regmap, 0x6d008, BIT(22), BIT(22)); /* GCC_CPUSS_GNOC_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx65_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sdx75.c b/drivers/clk/qcom/gcc-sdx75.c
index 573af17bd24c..0189da8c7a13 100644
--- a/drivers/clk/qcom/gcc-sdx75.c
+++ b/drivers/clk/qcom/gcc-sdx75.c
@@ -2936,13 +2936,8 @@ static int gcc_sdx75_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Keep clocks always enabled:
-	 * gcc_ahb_pcie_link_clk
-	 * gcc_xo_pcie_link_clk
-	 */
-	regmap_update_bits(regmap, 0x3e004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3e008, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x3e004); /* GCC_AHB_PCIE_LINK_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3e008); /* GCC_XO_PCIE_LINK_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sdx75_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm4450.c b/drivers/clk/qcom/gcc-sm4450.c
index 31abe2775fc8..ce7c209a3ed6 100644
--- a/drivers/clk/qcom/gcc-sm4450.c
+++ b/drivers/clk/qcom/gcc-sm4450.c
@@ -2849,25 +2849,14 @@ static int gcc_sm4450_probe(struct platform_device *pdev)
 
 	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
 
-	/*
-	 * Keep clocks always enabled:
-	 * gcc_camera_ahb_clk
-	 * gcc_camera_sleep_clk
-	 * gcc_camera_xo_clk
-	 * gcc_disp_ahb_clk
-	 * gcc_disp_xo_clk
-	 * gcc_gpu_cfg_ahb_clk
-	 * gcc_video_ahb_clk
-	 * gcc_video_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x36018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3601c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37014, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42018, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x36018); /* GCC_CAMERA_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3601c); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x37004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x37014); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x81004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42018); /* GCC_VIDEO_XO_CLK */
 
 	regmap_update_bits(regmap, 0x4201c, BIT(21), BIT(21));
 
diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index 3dd15d765b22..fe1a004c259d 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -3882,13 +3882,9 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * Keep the following clocks always on:
-	 * GCC_CAMERA_XO_CLK, GCC_CPUSS_GNOC_CLK, GCC_DISP_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x17028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x1702c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1702c); /* GCC_DISP_XO_CLK */
 
 	clk_lucid_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_lucid_pll_configure(&gpll11, regmap, &gpll11_config);
diff --git a/drivers/clk/qcom/gcc-sm7150.c b/drivers/clk/qcom/gcc-sm7150.c
index d9983bb27475..673810be8310 100644
--- a/drivers/clk/qcom/gcc-sm7150.c
+++ b/drivers/clk/qcom/gcc-sm7150.c
@@ -3002,20 +3002,14 @@ static int gcc_sm7150_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	/*
-	 * Keep the critical clocks always-ON
-	 * GCC_CPUSS_GNOC_CLK, GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK,
-	 * GCC_DISP_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_VIDEO_XO_CLK,
-	 * GCC_DISP_XO_CLK, GCC_GPU_CFG_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x48004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x48004); /* GCC_CPUSS_GNOC_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b02c); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b028); /* GCC_VIDEO_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b030); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_sm7150_dfs_desc,
 					ARRAY_SIZE(gcc_sm7150_dfs_desc));
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index c6c5261264f1..a8aa3f1f6373 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3643,18 +3643,12 @@ static int gcc_sm8250_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x4d110, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GCC_VIDEO_AHB_CLK, GCC_CAMERA_AHB_CLK, GCC_DISP_AHB_CLK,
-	 * GCC_CPUSS_DVM_BUS_CLK, GCC_GPU_CFG_AHB_CLK,
-	 * GCC_SYS_NOC_CPUSS_AHB_CLK
-	 */
-	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x4818c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x52000, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x0b004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x0b00c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x4818c); /* GCC_CPUSS_DVM_BUS_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x52000); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 				       ARRAY_SIZE(gcc_dfs_clocks));
diff --git a/drivers/clk/qcom/gcc-sm8350.c b/drivers/clk/qcom/gcc-sm8350.c
index 1385a98eb3bb..f7e1775663f5 100644
--- a/drivers/clk/qcom/gcc-sm8350.c
+++ b/drivers/clk/qcom/gcc-sm8350.c
@@ -3806,18 +3806,13 @@ static int gcc_sm8350_probe(struct platform_device *pdev)
 		return PTR_ERR(regmap);
 	}
 
-	/*
-	 * Keep the critical clock always-On
-	 * GCC_CAMERA_AHB_CLK, GCC_CAMERA_XO_CLK, GCC_DISP_AHB_CLK, GCC_DISP_XO_CLK,
-	 * GCC_GPU_CFG_AHB_CLK, GCC_VIDEO_AHB_CLK, GCC_VIDEO_XO_CLK
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x2701c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x28020, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26018); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x2701c); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x28020); /* GCC_VIDEO_XO_CLK */
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 563542982551..c9544f1bbd71 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -3280,19 +3280,13 @@ static int gcc_sm8450_probe(struct platform_device *pdev)
 	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
 	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
 
-	/*
-	 * Keep the critical clock always-On
-	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
-	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
-	 * gcc_video_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x36004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x36020, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x37004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x3701c, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x81004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x42028, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x36020); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x37004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x3701c); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x81004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x42028); /* GCC_VIDEO_XO_CLK */
 
 	return qcom_cc_really_probe(pdev, &gcc_sm8450_desc, regmap);
 }
diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
index 586126c4dd90..bb45bc6d72db 100644
--- a/drivers/clk/qcom/gcc-sm8550.c
+++ b/drivers/clk/qcom/gcc-sm8550.c
@@ -3344,19 +3344,13 @@ static int gcc_sm8550_probe(struct platform_device *pdev)
 	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
 	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg, BIT(14), BIT(14));
 
-	/*
-	 * Keep the critical clock always-On
-	 * gcc_camera_ahb_clk, gcc_camera_xo_clk, gcc_disp_ahb_clk,
-	 * gcc_disp_xo_clk, gcc_gpu_cfg_ahb_clk, gcc_video_ahb_clk,
-	 * gcc_video_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x26028, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x27018, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x32030, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x26004); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x26028); /* GCC_CAMERA_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27004); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x27018); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x71004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32004); /* GCC_VIDEO_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x32030); /* GCC_VIDEO_XO_CLK */
 
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52024, 0x0);
diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 1490cd45a654..0eeca1e9ccc1 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -457,12 +457,8 @@ static int gpu_cc_sc7280_probe(struct platform_device *pdev)
 
 	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GPU_CC_CB_CLK, GPUCC_CX_GMU_CLK
-	 */
-	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x1098, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1098); /* GPUCC_CX_GMU_CLK */
 	regmap_update_bits(regmap, 0x1098, BIT(13), BIT(13));
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sc7280_desc, regmap);
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 8e147ee294ee..55102f648a5d 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -444,12 +444,8 @@ static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	/*
-	 * Keep the clocks always-ON
-	 * GPU_CC_CB_CLK, GPU_CC_CXO_CLK
-	 */
-	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x109c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x1170); /* GPU_CC_CB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x109c); /* GPU_CC_CXO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/gpucc-sm8550.c b/drivers/clk/qcom/gpucc-sm8550.c
index 420dcb27b47d..98ecac49c1b9 100644
--- a/drivers/clk/qcom/gpucc-sm8550.c
+++ b/drivers/clk/qcom/gpucc-sm8550.c
@@ -575,13 +575,8 @@ static int gpu_cc_sm8550_probe(struct platform_device *pdev)
 	clk_lucid_ole_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	gpu_cc_cxo_aon_clk
-	 *	gpu_cc_demet_clk
-	 */
-	regmap_update_bits(regmap, 0x9004, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x900c, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x9004); /* GPU_CC_CXO_AON_CLK */
+	qcom_branch_set_clk_en(regmap, 0x900c); /* GPU_CC_DEMET_CLK */
 
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm8550_desc, regmap);
 }
diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c
index 9051fd567112..e4c20cc4c998 100644
--- a/drivers/clk/qcom/lpasscorecc-sc7180.c
+++ b/drivers/clk/qcom/lpasscorecc-sc7180.c
@@ -401,11 +401,7 @@ static int lpass_core_cc_sc7180_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	/*
-	 * Keep the CLK always-ON
-	 * LPASS_AUDIO_CORE_SYSNOC_SWAY_CORE_CLK
-	 */
-	regmap_update_bits(regmap, 0x24000, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x24000); /* LPASS_AUDIO_CORE_SYSNOC_SWAY_CORE_CLK */
 
 	/* PLL settings */
 	regmap_write(regmap, 0x1008, 0x20);
diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index ad46c4014a40..d11a5bdf7da7 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -383,9 +383,8 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
 
-	/* Keep VIDEO_CC_AHB_CLK and VIDEO_CC_XO_CLK ALWAYS-ON */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe58); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0xeec); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
index 7246f3c99492..a14d6702e6c3 100644
--- a/drivers/clk/qcom/videocc-sm8350.c
+++ b/drivers/clk/qcom/videocc-sm8350.c
@@ -558,13 +558,8 @@ static int video_cc_sm8350_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *      video_cc_ahb_clk
-	 *      video_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
-	regmap_update_bits(regmap, video_cc_xo_clk_cbcr, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0xe58); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, video_cc_xo_clk_cbcr); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8350_desc, regmap);
 	pm_runtime_put(&pdev->dev);
diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
index 16a61146e619..52a4b08ad577 100644
--- a/drivers/clk/qcom/videocc-sm8450.c
+++ b/drivers/clk/qcom/videocc-sm8450.c
@@ -423,15 +423,9 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
 	clk_lucid_evo_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
 	clk_lucid_evo_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	video_cc_ahb_clk
-	 *	video_cc_sleep_clk
-	 *	video_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x80e4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8130, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8114, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x80e4); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8130); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8114); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8450_desc, regmap);
 
diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
index f3c9dfaee968..28747d483a30 100644
--- a/drivers/clk/qcom/videocc-sm8550.c
+++ b/drivers/clk/qcom/videocc-sm8550.c
@@ -428,15 +428,9 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
 	clk_lucid_ole_pll_configure(&video_cc_pll0, regmap, &video_cc_pll0_config);
 	clk_lucid_ole_pll_configure(&video_cc_pll1, regmap, &video_cc_pll1_config);
 
-	/*
-	 * Keep clocks always enabled:
-	 *	video_cc_ahb_clk
-	 *	video_cc_sleep_clk
-	 *	video_cc_xo_clk
-	 */
-	regmap_update_bits(regmap, 0x80f4, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8140, BIT(0), BIT(0));
-	regmap_update_bits(regmap, 0x8124, BIT(0), BIT(0));
+	qcom_branch_set_clk_en(regmap, 0x80f4); /* VIDEO_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8140); /* VIDEO_CC_SLEEP_CLK */
+	qcom_branch_set_clk_en(regmap, 0x8124); /* VIDEO_CC_XO_CLK */
 
 	ret = qcom_cc_really_probe(pdev, &video_cc_sm8550_desc, regmap);
 

-- 
2.43.0

