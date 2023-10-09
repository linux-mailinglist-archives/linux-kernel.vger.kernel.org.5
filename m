Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F567BE69B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377279AbjJIQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377642AbjJIQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:36:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B3B7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:36:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bba99so43797065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696869387; x=1697474187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDFSX/M8Boh0xlXpTXGoxhFrMXCpVlR2sovQgbmNFsw=;
        b=St4/svBa9zw64VdDh5JShWvsCBYwWgsleYeO1AJ3RKigpdZb1VuEh10NFEyUs1QoPV
         +g88URL38f9DZsT2aO8HHBOTalPMYMRlfcV/NYZhaHt2mUSqibQZyLX8+g3hQgJ2f5mk
         RmJJuc/plBDSpVuw9gCIOXVKOEpziECXyxOmN8+iWkoBTrfznBKIa2hnfsMAhX7w8Bi/
         f/X3lRGSxROwpmxnxY6OS1JqoUTBOhkSCntCtxm0HaoGcI1Qle7r2W+KLJ669IrNGAdM
         +BgjwqCjVKMRhGRqfj0Ve7/4iYKx9UZPgqHEHuhzkDJOVvoDN7NuRnzOmOenmdJ4rykV
         agqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869387; x=1697474187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDFSX/M8Boh0xlXpTXGoxhFrMXCpVlR2sovQgbmNFsw=;
        b=UYULuFXXIkq6pZRHsqK+oR6fyZ4jHJbZoGxRBG3x1VTSJ59V/Fn5LkHGCh+ZlTo0BE
         EO0X5V92UFg5HEKETKOnv9krPzzxQUurppW1FnaAHnd8fcKGDsqhicTaAuwTJw/XSZWK
         j/zLmsL1ISlhrX2Jm17YhujykCbpRCVuluQT/APYtOVtYZCvjy4UXwDz1bf9aYbe8u9T
         r83b8tbKV9pktbWkLjEAezJRzHBpz/tlU+LJPQgFBrwo3C1M2FzrJGK25Iy+TZyjmtaq
         3cvadrLxTMTUS++5VvUO4h0vgZUPfn/mRZQLGcAlRA3XvDg4qvzBkR0h/0Jh9UKnksOt
         hinA==
X-Gm-Message-State: AOJu0Yye9fzSbVNVMZ7lRScVx3/8YT6LiOw1EJYJS7M+4xCUNDyBaFfr
        V6ecKgrQNq6Z1mma8M2RpFSgeA==
X-Google-Smtp-Source: AGHT+IEzTRnz/DHzEeL1C1oQPx7Gy81qHmpnlZfaodjtcxwTCyknEzPWArZdhX5w9bC30rLWFNoUCw==
X-Received: by 2002:adf:f403:0:b0:321:5b64:f744 with SMTP id g3-20020adff403000000b003215b64f744mr13689494wro.20.1696869386831;
        Mon, 09 Oct 2023 09:36:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d50cb000000b00325c7295450sm10141046wrt.3.2023.10.09.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:36:26 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Oct 2023 18:36:15 +0200
Subject: [PATCH RFC 4/5] drm/msm: dpu1: call wb & sspp clk_force_ctrl op if
 split clock control
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-4-806c0dee4e43@linaro.org>
References: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
In-Reply-To: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8214;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZOnxqR1GU8SlqAaSIdXy8L1jHjxMz2BNLdQojqmBTmc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlJCwE/I8RucJK4GNiCxoMvbs3OIDUmrKff3XmYyQw
 /d0n68uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZSQsBAAKCRB33NvayMhJ0QqeEA
 DGNW2Vqm1d4axwi8TKSMSrFVY1q+8RlaeibNaEc/5lvxr87VDDYZdarOYCckJIFHvctfik8+DhXV7o
 xzNIOC35AxopM6/IzvX6ymxrvLpqInyWWZnd5dXl321n1ioxj50quIIMk+ZWeqHICHEAmd9V1tVYE+
 RYoKyoiWHLhsi1DTAPc6gCjRYdAGUXq9b5gpjPuYvaDVgE6M/6Rlh1wfzL8ruPo9TmUyz7NP+Tn8gF
 661KgYhMo6afCSV7eXwLw89aP4KZ6jI/+h4b3uYZQyz93iR6C96P2VfFf2ODS5Bn9PJpMu/LICWGtd
 KBYl89v2v3aYaTCThwpEBV+5OBVL/Qsz7oM0Jjkjt9fAwyj5GeOpsaDkuQdAS4F0e33dpxje94Ps8S
 KXOXntB8XYdR8pZQwif6zrY7+1dj881uvbwMzvFhPHj6npj72TqWj3sGChnoHuReloTdiFGx1+ss6Q
 qGW3IV+n6zsbRt/s7TyoTU82mH/GWed2MOIS+1m+TCzO4V8wWPwOZ7NsEb8MnGlJOoK49HfxhHz1p9
 NLs6MmAdy4pGhCBQu0s6aj/5uJFWoSxLleCdnv41L6nP+dXJ287wT10D0AGDIYj0dHr1m2l4umvKt7
 k8WAdmooxu46lnDuQvPvtAB31LFqo24nx+d5/gWw/dOcQsIftRf1Y4E77voA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now clk_ctrl IDs can be optional and the clk_ctrl_reg can be specified
on the SSPP & WB caps directly, pass the SSPP & WB hw struct to the
qos & limit params then call the clk_force_ctrl() op accordingly.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  9 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 37 +++++++++++++++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           | 12 ++++---
 4 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 78037a697633..e4dfe0be7207 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -45,6 +45,7 @@ static void dpu_encoder_phys_wb_set_ot_limit(
 	struct dpu_vbif_set_ot_params ot_params;
 
 	memset(&ot_params, 0, sizeof(ot_params));
+	ot_params.wb = hw_wb;
 	ot_params.xin_id = hw_wb->caps->xin_id;
 	ot_params.num = hw_wb->idx - WB_0;
 	ot_params.width = phys_enc->cached_mode.hdisplay;
@@ -52,7 +53,6 @@ static void dpu_encoder_phys_wb_set_ot_limit(
 	ot_params.is_wfd = true;
 	ot_params.frame_rate = drm_mode_vrefresh(&phys_enc->cached_mode);
 	ot_params.vbif_idx = hw_wb->caps->vbif_idx;
-	ot_params.clk_ctrl = hw_wb->caps->clk_ctrl;
 	ot_params.rd = false;
 
 	dpu_vbif_set_ot_limit(phys_enc->dpu_kms, &ot_params);
@@ -81,9 +81,9 @@ static void dpu_encoder_phys_wb_set_qos_remap(
 	hw_wb = phys_enc->hw_wb;
 
 	memset(&qos_params, 0, sizeof(qos_params));
+	qos_params.wb = hw_wb;
 	qos_params.vbif_idx = hw_wb->caps->vbif_idx;
 	qos_params.xin_id = hw_wb->caps->xin_id;
-	qos_params.clk_ctrl = hw_wb->caps->clk_ctrl;
 	qos_params.num = hw_wb->idx - WB_0;
 	qos_params.is_rt = false;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index c2aaaded07ed..b0b662068377 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -350,6 +350,7 @@ static void _dpu_plane_set_ot_limit(struct drm_plane *plane,
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 
 	memset(&ot_params, 0, sizeof(ot_params));
+	ot_params.sspp = pipe->sspp;
 	ot_params.xin_id = pipe->sspp->cap->xin_id;
 	ot_params.num = pipe->sspp->idx - SSPP_NONE;
 	ot_params.width = drm_rect_width(&pipe_cfg->src_rect);
@@ -357,7 +358,6 @@ static void _dpu_plane_set_ot_limit(struct drm_plane *plane,
 	ot_params.is_wfd = !pdpu->is_rt_pipe;
 	ot_params.frame_rate = frame_rate;
 	ot_params.vbif_idx = VBIF_RT;
-	ot_params.clk_ctrl = pipe->sspp->cap->clk_ctrl;
 	ot_params.rd = true;
 
 	dpu_vbif_set_ot_limit(dpu_kms, &ot_params);
@@ -377,16 +377,15 @@ static void _dpu_plane_set_qos_remap(struct drm_plane *plane,
 
 	memset(&qos_params, 0, sizeof(qos_params));
 	qos_params.vbif_idx = VBIF_RT;
-	qos_params.clk_ctrl = pipe->sspp->cap->clk_ctrl;
+	qos_params.sspp = pipe->sspp;
 	qos_params.xin_id = pipe->sspp->cap->xin_id;
 	qos_params.num = pipe->sspp->idx - SSPP_VIG0;
 	qos_params.is_rt = pdpu->is_rt_pipe;
 
-	DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d, clk_ctrl:%d\n",
+	DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d\n",
 			qos_params.num,
 			qos_params.vbif_idx,
-			qos_params.xin_id, qos_params.is_rt,
-			qos_params.clk_ctrl);
+			qos_params.xin_id, qos_params.is_rt);
 
 	dpu_vbif_set_qos_remap(dpu_kms, &qos_params);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
index 2ae5cba1848b..a79559084a91 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
@@ -158,11 +158,19 @@ static u32 _dpu_vbif_get_ot_limit(struct dpu_hw_vbif *vbif,
 	return ot_lim;
 }
 
-static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_mdp *mdp,
-					  unsigned int clk_ctrl,
+static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_sspp *sspp,
+					  struct dpu_hw_wb *wb,
+					  struct dpu_hw_mdp *mdp,
 					  bool enable)
 {
-	return mdp->ops.setup_clk_force_ctrl(mdp, clk_ctrl, enable);
+	if (sspp && sspp->cap->clk_ctrl_reg)
+		return sspp->ops.setup_clk_force_ctrl(sspp, enable);
+	else if (wb && wb->caps->clk_ctrl_reg)
+		return wb->ops.setup_clk_force_ctrl(wb, enable);
+	else
+		return mdp->ops.setup_clk_force_ctrl(mdp,
+				sspp ? sspp->cap->clk_ctrl : wb->caps->clk_ctrl,
+				enable);
 }
 
 /**
@@ -190,9 +198,13 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
 		return;
 	}
 
-	if (!mdp->ops.setup_clk_force_ctrl ||
-			!vbif->ops.set_limit_conf ||
-			!vbif->ops.set_halt_ctrl)
+	if ((!params->sspp && !params->wb) ||
+	    (params->sspp && !params->sspp->ops.setup_clk_force_ctrl) ||
+	    (params->wb && !params->wb->ops.setup_clk_force_ctrl) ||
+	    !mdp->ops.setup_clk_force_ctrl)
+		return;
+
+	if (!vbif->ops.set_limit_conf || !vbif->ops.set_halt_ctrl)
 		return;
 
 	/* set write_gather_en for all write clients */
@@ -207,7 +219,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
 	trace_dpu_perf_set_ot(params->num, params->xin_id, ot_lim,
 		params->vbif_idx);
 
-	forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
+	forced_on = dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, true);
 
 	vbif->ops.set_limit_conf(vbif, params->xin_id, params->rd, ot_lim);
 
@@ -220,7 +232,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
 	vbif->ops.set_halt_ctrl(vbif, params->xin_id, false);
 
 	if (forced_on)
-		dpu_vbif_setup_clk_force_ctrl(mdp,  params->clk_ctrl, false);
+		dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, false);
 }
 
 void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
@@ -245,7 +257,10 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
 		return;
 	}
 
-	if (!vbif->ops.set_qos_remap || !mdp->ops.setup_clk_force_ctrl) {
+	if ((!params->sspp && !params->wb) ||
+	    (params->sspp && !params->sspp->ops.setup_clk_force_ctrl) ||
+	    (params->wb && !params->wb->ops.setup_clk_force_ctrl) ||
+	    !mdp->ops.setup_clk_force_ctrl || !vbif->ops.set_qos_remap) {
 		DRM_DEBUG_ATOMIC("qos remap not supported\n");
 		return;
 	}
@@ -258,7 +273,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
 		return;
 	}
 
-	forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
+	forced_on = dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, true);
 
 	for (i = 0; i < qos_tbl->npriority_lvl; i++) {
 		DRM_DEBUG_ATOMIC("%s xin:%d lvl:%d/%d\n",
@@ -269,7 +284,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
 	}
 
 	if (forced_on)
-		dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, false);
+		dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, false);
 }
 
 void dpu_vbif_clear_errors(struct dpu_kms *dpu_kms)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
index ab490177d886..a4fe76e390d9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
@@ -7,7 +7,12 @@
 
 #include "dpu_kms.h"
 
+struct dpu_hw_sspp;
+struct dpu_hw_wb;
+
 struct dpu_vbif_set_ot_params {
+	struct dpu_hw_sspp *sspp;
+	struct dpu_hw_wb *wb;
 	u32 xin_id;
 	u32 num;
 	u32 width;
@@ -16,28 +21,27 @@ struct dpu_vbif_set_ot_params {
 	bool rd;
 	bool is_wfd;
 	u32 vbif_idx;
-	u32 clk_ctrl;
 };
 
 struct dpu_vbif_set_memtype_params {
 	u32 xin_id;
 	u32 vbif_idx;
-	u32 clk_ctrl;
 	bool is_cacheable;
 };
 
 /**
  * struct dpu_vbif_set_qos_params - QoS remapper parameter
+ * @sspp: backing SSPP
  * @vbif_idx: vbif identifier
  * @xin_id: client interface identifier
- * @clk_ctrl: clock control identifier of the xin
  * @num: pipe identifier (debug only)
  * @is_rt: true if pipe is used in real-time use case
  */
 struct dpu_vbif_set_qos_params {
+	struct dpu_hw_sspp *sspp;
+	struct dpu_hw_wb *wb;
 	u32 vbif_idx;
 	u32 xin_id;
-	u32 clk_ctrl;
 	u32 num;
 	bool is_rt;
 };

-- 
2.34.1

