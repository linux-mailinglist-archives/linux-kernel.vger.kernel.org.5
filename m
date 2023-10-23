Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD887D4293
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjJWWM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJWWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:12:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F237699;
        Mon, 23 Oct 2023 15:12:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso3645607b3a.3;
        Mon, 23 Oct 2023 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099174; x=1698703974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3JBzSeEvFvVT5yIjIih/KnJNivc+rIAI/D1WIJlFoQ=;
        b=XIzDcZ1FnkNj0M73Lf8QTvsi1wqLJHhOWaMSTGnSodghCA+l2OjZ4KUl8qUXXEqz2e
         IYXTCc8uq97H3dpohjpgv0zRRaTV60PyiPy/H13hk9cItx8ufKp7pAIwLCfiinrfWMWy
         lhqcCYDKp8hS+jnKb3TP5wbeeRsNLTWCgwSNpbKNFkiUwdaaDoxlOfRJ+NmzkXbr8m5N
         L+wHIKhw8oedZRPa86/IZ+aXDDLspuhHC1CIQCDM3rcRR3NXZ2cGUfzqT5mnCD3pk0F1
         xHurENYR2vaPc4GEjkmZ3rxt3c/MouU972e211x4a8L83bsm0LHnKWB2S5Tf545Fp/Vq
         a1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099174; x=1698703974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3JBzSeEvFvVT5yIjIih/KnJNivc+rIAI/D1WIJlFoQ=;
        b=ImVLqKqlZHCaFluyLp+rcGF0U3Mpx/DsD6iL685XCLjdWUwd7AC+GI11jnzluLk5MK
         +irDQ+NBP6PGcjT2ehS8AUFhRvpzmm7TCXGHcmnN7h2w9YOsssD3+idQahE9IcMoHCXg
         OAJbV+e3+2EauJtv09DPD9UvJZoVNbYap53rrke5VapV7sogax3/u8E//vwCCLGFsVDG
         zgkmTQ2v7WfLurkdgrliLjW8a59E1MmkGdD6X3yfKXSCRk4OSRe2Sjq/v342xZ7fia3N
         c6QuP0OZ+7Y7R7bBToInMP/pC6HKZI+29AsAlb6F5aVKru01yPX1Tigdeq8gGbQkMKHT
         WP5g==
X-Gm-Message-State: AOJu0YzvMsYinQCGws3J2xrjKk7ILi2Q1huqGMlHxYCT27n42Og+FvRB
        gbBGyyM9OnMWwpXznS50lQs=
X-Google-Smtp-Source: AGHT+IHRI3o5kP9LJxbKRQayyv+er+t4jJzqW5bf3iSbYYSe9HIKoosMkwVpSW6NjuPFc9z/zc6i/A==
X-Received: by 2002:a05:6a20:8e0e:b0:129:d944:2e65 with SMTP id y14-20020a056a208e0e00b00129d9442e65mr1088606pzj.13.1698099174190;
        Mon, 23 Oct 2023 15:12:54 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b001bbb25dd3a7sm6317920plz.187.2023.10.23.15.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:12:53 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Arnaud Vrac <rawoul@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jeykumar Sankaran <quic_jeykumar@quicinc.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dpu: Fix encoder CRC to account for CTM enablement
Date:   Mon, 23 Oct 2023 15:12:33 -0700
Message-ID: <20231023221250.116500-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Seems like we need to pick INPUT_SEL=1 when CTM is enabled.  But not
otherwise.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 4 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c | 5 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h | 3 ++-
 8 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 2b83a13b3aa9..d93a92ffd5df 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -134,7 +134,7 @@ static void dpu_crtc_setup_encoder_misr(struct drm_crtc *crtc)
 	struct drm_encoder *drm_enc;
 
 	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc->state->encoder_mask)
-		dpu_encoder_setup_misr(drm_enc);
+		dpu_encoder_setup_misr(drm_enc, !!crtc->state->ctm);
 }
 
 static int dpu_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index b0a7908418ed..12ee7acb5ea6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -241,7 +241,7 @@ int dpu_encoder_get_crc_values_cnt(const struct drm_encoder *drm_enc)
 	return num_intf;
 }
 
-void dpu_encoder_setup_misr(const struct drm_encoder *drm_enc)
+void dpu_encoder_setup_misr(const struct drm_encoder *drm_enc, bool has_ctm)
 {
 	struct dpu_encoder_virt *dpu_enc;
 
@@ -255,7 +255,7 @@ void dpu_encoder_setup_misr(const struct drm_encoder *drm_enc)
 		if (!phys->hw_intf || !phys->hw_intf->ops.setup_misr)
 			continue;
 
-		phys->hw_intf->ops.setup_misr(phys->hw_intf, true, 1);
+		phys->hw_intf->ops.setup_misr(phys->hw_intf, true, 1, has_ctm);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4c05fd5e9ed1..510783b2fb24 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -169,8 +169,9 @@ int dpu_encoder_get_crc_values_cnt(const struct drm_encoder *drm_enc);
 /**
  * dpu_encoder_setup_misr - enable misr calculations
  * @drm_enc:    Pointer to previously created drm encoder structure
+ * @has_ctm:    Is CTM enabled
  */
-void dpu_encoder_setup_misr(const struct drm_encoder *drm_encoder);
+void dpu_encoder_setup_misr(const struct drm_encoder *drm_encoder, bool has_ctm);
 
 /**
  * dpu_encoder_get_crc - get the crc value from interface blocks
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index e8b8908d3e12..cb06f80cc671 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -318,9 +318,9 @@ static u32 dpu_hw_intf_get_line_count(struct dpu_hw_intf *intf)
 	return DPU_REG_READ(c, INTF_LINE_COUNT);
 }
 
-static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf, bool enable, u32 frame_count)
+static void dpu_hw_intf_setup_misr(struct dpu_hw_intf *intf, bool enable, u32 frame_count, bool has_ctm)
 {
-	dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable, frame_count);
+	dpu_hw_setup_misr(&intf->hw, INTF_MISR_CTRL, enable, frame_count, has_ctm);
 }
 
 static int dpu_hw_intf_collect_misr(struct dpu_hw_intf *intf, u32 *misr_value)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index c539025c418b..95aafc4cf58e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -95,7 +95,7 @@ struct dpu_hw_intf_ops {
 
 	void (*bind_pingpong_blk)(struct dpu_hw_intf *intf,
 			const enum dpu_pingpong pp);
-	void (*setup_misr)(struct dpu_hw_intf *intf, bool enable, u32 frame_count);
+	void (*setup_misr)(struct dpu_hw_intf *intf, bool enable, u32 frame_count, bool has_ctm);
 	int (*collect_misr)(struct dpu_hw_intf *intf, u32 *misr_value);
 
 	// Tearcheck on INTF since DPU 5.0.0
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index d1c3bd8379ea..2efe29396c6a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -83,7 +83,7 @@ static void dpu_hw_lm_setup_border_color(struct dpu_hw_mixer *ctx,
 
 static void dpu_hw_lm_setup_misr(struct dpu_hw_mixer *ctx, bool enable, u32 frame_count)
 {
-	dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable, frame_count);
+	dpu_hw_setup_misr(&ctx->hw, LM_MISR_CTRL, enable, frame_count, false);
 }
 
 static int dpu_hw_lm_collect_misr(struct dpu_hw_mixer *ctx, u32 *misr_value)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
index 9d2273fd2fed..528b8439209f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c
@@ -483,7 +483,7 @@ void _dpu_hw_setup_qos_lut(struct dpu_hw_blk_reg_map *c, u32 offset,
 
 void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_ctrl_offset,
-		bool enable, u32 frame_count)
+		bool enable, u32 frame_count, bool has_ctm)
 {
 	u32 config = 0;
 
@@ -496,6 +496,9 @@ void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
 		config = (frame_count & MISR_FRAME_COUNT_MASK) |
 			MISR_CTRL_ENABLE | MISR_CTRL_FREE_RUN_MASK;
 
+		if (!has_ctm)
+			config |= 1 << 24;
+
 		DPU_REG_WRITE(c, misr_ctrl_offset, config);
 	} else {
 		DPU_REG_WRITE(c, misr_ctrl_offset, 0);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
index 1f6079f47071..e42d9d00e40e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h
@@ -360,7 +360,8 @@ void _dpu_hw_setup_qos_lut(struct dpu_hw_blk_reg_map *c, u32 offset,
 void dpu_hw_setup_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_ctrl_offset,
 		bool enable,
-		u32 frame_count);
+		u32 frame_count,
+		bool has_ctm);
 
 int dpu_hw_collect_misr(struct dpu_hw_blk_reg_map *c,
 		u32 misr_ctrl_offset,
-- 
2.41.0

