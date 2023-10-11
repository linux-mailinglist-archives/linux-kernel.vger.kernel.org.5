Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4A7C52BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346473AbjJKL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJKL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:59:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868993
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:59:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so6394172f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697025575; x=1697630375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYaq7cxyGCmrr3w+vhXlvxdVviCMq5scl/IwNcYkX0o=;
        b=j3/i3umm44A2+yRJhyF9zC47jMVNt3vVEFxkXJLmsYxI1N/YufHElWRfVl7qtGPj1f
         6A7VmpF2ZiGVIsN9TvwwPW+9hVZc2qQ+KJ+Y6D+PGIwDH7yB3x2xtq3UHJcA0ZE8kZgG
         t9d0+UHnqB9xPheWKg2syR1gxIOzlBECT/mu2IMpGVtkpmrhpDSqYN0r/YQOMxgYk1Hn
         GMuoVh68uE85n3M2N33kE9v6C5JiptTTEzrvtdPxixfNSTDhD6Qv2mLfsMsqWWnsTGHm
         Tlc7mB0lFZVwWW6WmgNpxvCEi6oA9pfEwr6icEXKnMGZQDfTTwPsDrwlUfa4I4sykaDt
         xGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025575; x=1697630375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYaq7cxyGCmrr3w+vhXlvxdVviCMq5scl/IwNcYkX0o=;
        b=dSMCXtJt9MSyICv21zGz+oj2Rp2xU1mry5V5xXpkX20XtonHJoAeagQ1t0feUzGhMJ
         9ejCtmmIeCIPabEZXhBETL4yH+Cs4yEHhQnudEGZO3hBNAXfKoQsjOTrpOg91hd4LLnr
         SKTQrLcjwx2ubgEVi8qagRC6nd4rE55SID9TXvB2so1TneJlkx1Yu+30WRFpA4PDcejS
         yevOBEJog+jgfJcN4v2dmUmTcc4TUBbbc/QmdCnk3RxGD6D0cm7J2YoRTI2PxbiHZix1
         mCwDZMeV3K6rDEfUOvMgPjotDPqObZ3J0AxykVDcdKvlHMhVRPoAsV4pBVSIC9CP9Qcf
         7cZQ==
X-Gm-Message-State: AOJu0Yyx15rd4Vtpgee9BR69+TWs1KE0tKRlQOtVdOO1z495Y09u4M+9
        uBBx+LMUr6TQiiPbJOdjsj2saTkRyAvXm0qr+tMuUs7b
X-Google-Smtp-Source: AGHT+IEKwuOu9u+sh9WuML666DHFNXwhNKpgYSTjxoKrQM25LQJPaKbDsCwpGLRqJWzspklJWGt8YQ==
X-Received: by 2002:a5d:44cd:0:b0:32d:885f:3f8d with SMTP id z13-20020a5d44cd000000b0032d885f3f8dmr949700wrr.52.1697025574925;
        Wed, 11 Oct 2023 04:59:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b00323293bd023sm15447805wro.6.2023.10.11.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:59:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 11 Oct 2023 13:59:22 +0200
Subject: [PATCH v2 2/5] drm/msm/dpu: add setup_clk_force_ctrl() op to sspp
 & wb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-2-b219c945df53@linaro.org>
References: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org>
In-Reply-To: <20231011-topic-sm8550-graphics-sspp-split-clk-v2-0-b219c945df53@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8650;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/iKGEvNKYsxVQygEQERnTv8x8q+wddAtr5d5mvSllvM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJo4hanPm+cUq6N0/cr7o6i/KGDy3fvEVHUBLgmi6
 xMVrJaaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSaOIQAKCRB33NvayMhJ0VGeD/
 4//khcpvmyVeMfWgq8JqqjU98uwLKeeHtZjHvi3ZvOlfOIXr4ph4B0676q8yB++BN8fCksN956pdf3
 St6/iuX+SXUXgDqGVH7058sX0p5Kz1ubkIRw3Kg2QEZwQm1DRzDj4X1AHtlvNBWmwns4PCJR6rHyMf
 /nDcfi3W23ziHGmVflSCM4Y1pSkLwTySZFiwjKzUQtuxkygukibVxuyZiqduP0s8w+fXqQzH5RCnWQ
 De78djWfIAu+QDXwqyjrwl/cO7ff8FfLtLYflafbnroxIrRtzvvUhQDGyMFSWtfMNdKR4HgfuRhgCP
 XPpbyPZqwAa9JQ49EtTa84RzeioOcnJwF/F3bR2ocY9HXPkydyUXCJiVchiVqqhIJYR267wszt67/b
 V0TQKdO5O/sxNlWZN8TagM77NjPDohwacSY4G0mnSd0vVpIj6629lmx2k2fJX4D7Vr5WtnHE0HzIPP
 r8JxSU38FyuI/dBiOjzO0KLpA1j0upPMU/Iq+LHy2oSHZ/fVyW6uUngKuwk5lmk0xus9QV0V2cD7px
 33MkZQjp9ct6Zl7HSqnr6CLrGuQiRxpHnSHtcQc8kjb5HjlAL3znN0gRxDXL/BmNT0QI1Q/ldiDeG7
 zrh8+Vod7Y6cMJC/O39x5QdNpjIe2K1ynxWyrv9t9vOAIgBkA22zhmsgtG3Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from SM8550, the SSPP & WB clock controls are moved
the SSPP and WB register range, as it's called "VBIF_CLK_SPLIT"
downstream.

Implement setup_clk_force_ctrl() only starting from major version 9
which corresponds to SM8550 MDSS.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 21 ++++++++++++++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h | 12 +++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c   | 20 +++++++++++++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h   |  7 ++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  4 ++--
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index f2192de93713..5fd213ed6491 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -69,6 +69,7 @@
 #define SSPP_EXCL_REC_XY_REC1              0x188
 #define SSPP_EXCL_REC_SIZE                 0x1B4
 #define SSPP_EXCL_REC_XY                   0x1B8
+#define SSPP_CLK_CTRL                      0x330
 
 /* SSPP_SRC_OP_MODE & OP_MODE_REC1 */
 #define MDSS_MDP_OP_DEINTERLACE            BIT(22)
@@ -581,8 +582,18 @@ static void dpu_hw_sspp_setup_cdp(struct dpu_sw_pipe *pipe,
 	dpu_setup_cdp(&ctx->hw, cdp_cntl_offset, fmt, enable);
 }
 
+static bool dpu_hw_sspp_setup_clk_force_ctrl(struct dpu_hw_sspp *ctx, bool enable)
+{
+	struct dpu_clk_ctrl_reg sspp_clk_ctrl = {
+		.reg_off = SSPP_CLK_CTRL,
+		.bit_off = 0
+	};
+
+	return dpu_hw_clk_force_ctrl(&ctx->hw, &sspp_clk_ctrl, enable);
+}
+
 static void _setup_layer_ops(struct dpu_hw_sspp *c,
-		unsigned long features)
+		unsigned long features, const struct dpu_mdss_version *mdss_rev)
 {
 	c->ops.setup_format = dpu_hw_sspp_setup_format;
 	c->ops.setup_rects = dpu_hw_sspp_setup_rects;
@@ -612,6 +623,9 @@ static void _setup_layer_ops(struct dpu_hw_sspp *c,
 
 	if (test_bit(DPU_SSPP_CDP, &features))
 		c->ops.setup_cdp = dpu_hw_sspp_setup_cdp;
+
+	if (mdss_rev->core_major_ver >= 9)
+		c->ops.setup_clk_force_ctrl = dpu_hw_sspp_setup_clk_force_ctrl;
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -672,7 +686,8 @@ int _dpu_hw_sspp_init_debugfs(struct dpu_hw_sspp *hw_pipe, struct dpu_kms *kms,
 #endif
 
 struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
-		void __iomem *addr, const struct msm_mdss_data *mdss_data)
+		void __iomem *addr, const struct msm_mdss_data *mdss_data,
+		const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_sspp *hw_pipe;
 
@@ -690,7 +705,7 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
 	hw_pipe->ubwc = mdss_data;
 	hw_pipe->idx = cfg->id;
 	hw_pipe->cap = cfg;
-	_setup_layer_ops(hw_pipe, hw_pipe->cap->features);
+	_setup_layer_ops(hw_pipe, hw_pipe->cap->features, mdss_rev);
 
 	return hw_pipe;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index cbf4f95ff0fd..f93969fddb22 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -271,6 +271,14 @@ struct dpu_hw_sspp_ops {
 	void (*setup_qos_ctrl)(struct dpu_hw_sspp *ctx,
 			       bool danger_safe_en);
 
+	/**
+	 * setup_clk_force_ctrl - setup clock force control
+	 * @ctx: Pointer to pipe context
+	 * @enable: enable clock force if true
+	 */
+	bool (*setup_clk_force_ctrl)(struct dpu_hw_sspp *ctx,
+				     bool enable);
+
 	/**
 	 * setup_histogram - setup histograms
 	 * @ctx: Pointer to pipe context
@@ -334,9 +342,11 @@ struct dpu_kms;
  * @cfg:  Pipe catalog entry for which driver object is required
  * @addr: Mapped register io address of MDP
  * @mdss_data: UBWC / MDSS configuration data
+ * @mdss_rev: dpu core's major and minor versions
  */
 struct dpu_hw_sspp *dpu_hw_sspp_init(const struct dpu_sspp_cfg *cfg,
-		void __iomem *addr, const struct msm_mdss_data *mdss_data);
+		void __iomem *addr, const struct msm_mdss_data *mdss_data,
+		const struct dpu_mdss_version *mdss_rev);
 
 /**
  * dpu_hw_sspp_destroy(): Destroys SSPP driver context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
index ebc416400382..374c2c64c9e4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
@@ -43,6 +43,7 @@
 #define WB_MUX                                0x150
 #define WB_CROP_CTRL                          0x154
 #define WB_CROP_OFFSET                        0x158
+#define WB_CLK_CTRL                           0x178
 #define WB_CSC_BASE                           0x260
 #define WB_DST_ADDR_SW_STATUS                 0x2B0
 #define WB_CDP_CNTL                           0x2B4
@@ -175,8 +176,18 @@ static void dpu_hw_wb_bind_pingpong_blk(
 	DPU_REG_WRITE(c, WB_MUX, mux_cfg);
 }
 
+static bool dpu_hw_wb_setup_clk_force_ctrl(struct dpu_hw_wb *ctx, bool enable)
+{
+	struct dpu_clk_ctrl_reg wb_clk_ctrl = {
+		.reg_off = WB_CLK_CTRL,
+		.bit_off = 0
+	};
+
+	return dpu_hw_clk_force_ctrl(&ctx->hw, &wb_clk_ctrl, enable);
+}
+
 static void _setup_wb_ops(struct dpu_hw_wb_ops *ops,
-		unsigned long features)
+		unsigned long features, const struct dpu_mdss_version *mdss_rev)
 {
 	ops->setup_outaddress = dpu_hw_wb_setup_outaddress;
 	ops->setup_outformat = dpu_hw_wb_setup_format;
@@ -192,10 +203,13 @@ static void _setup_wb_ops(struct dpu_hw_wb_ops *ops,
 
 	if (test_bit(DPU_WB_INPUT_CTRL, &features))
 		ops->bind_pingpong_blk = dpu_hw_wb_bind_pingpong_blk;
+
+	if (mdss_rev->core_major_ver >= 9)
+		ops->setup_clk_force_ctrl = dpu_hw_wb_setup_clk_force_ctrl;
 }
 
 struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
-		void __iomem *addr)
+		void __iomem *addr, const struct dpu_mdss_version *mdss_rev)
 {
 	struct dpu_hw_wb *c;
 
@@ -212,7 +226,7 @@ struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
 	/* Assign ops */
 	c->idx = cfg->id;
 	c->caps = cfg;
-	_setup_wb_ops(&c->ops, c->caps->features);
+	_setup_wb_ops(&c->ops, c->caps->features, mdss_rev);
 
 	return c;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
index 2d7db2efa3d0..88792f450a92 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
@@ -29,6 +29,7 @@ struct dpu_hw_wb_cfg {
  *  @setup_outformat: setup output format of writeback block from writeback job
  *  @setup_qos_lut:   setup qos LUT for writeback block based on input
  *  @setup_cdp:       setup chroma down prefetch block for writeback block
+ *  @setup_clk_force_ctrl: setup clock force control
  *  @bind_pingpong_blk: enable/disable the connection with ping-pong block
  */
 struct dpu_hw_wb_ops {
@@ -48,6 +49,9 @@ struct dpu_hw_wb_ops {
 			  const struct dpu_format *fmt,
 			  bool enable);
 
+	bool (*setup_clk_force_ctrl)(struct dpu_hw_wb *ctx,
+				     bool enable);
+
 	void (*bind_pingpong_blk)(struct dpu_hw_wb *ctx,
 				  const enum dpu_pingpong pp);
 };
@@ -74,10 +78,11 @@ struct dpu_hw_wb {
  * dpu_hw_wb_init() - Initializes the writeback hw driver object.
  * @cfg:  wb_path catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
+ * @mdss_rev: dpu core's major and minor versions
  * Return: Error code or allocated dpu_hw_wb context
  */
 struct dpu_hw_wb *dpu_hw_wb_init(const struct dpu_wb_cfg *cfg,
-		void __iomem *addr);
+		void __iomem *addr, const struct dpu_mdss_version *mdss_rev);
 
 /**
  * dpu_hw_wb_destroy(): Destroy writeback hw driver object.
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index f9215643c71a..f363bcfdfd70 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -175,7 +175,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_wb *hw;
 		const struct dpu_wb_cfg *wb = &cat->wb[i];
 
-		hw = dpu_hw_wb_init(wb, mmio);
+		hw = dpu_hw_wb_init(wb, mmio, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed wb object creation: err %d\n", rc);
@@ -231,7 +231,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 		struct dpu_hw_sspp *hw;
 		const struct dpu_sspp_cfg *sspp = &cat->sspp[i];
 
-		hw = dpu_hw_sspp_init(sspp, mmio, mdss_data);
+		hw = dpu_hw_sspp_init(sspp, mmio, mdss_data, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed sspp object creation: err %d\n", rc);

-- 
2.34.1

