Return-Path: <linux-kernel+bounces-113307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF59888348
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12F41F226FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740D18FC60;
	Sun, 24 Mar 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYVcciC+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C521191EB1;
	Sun, 24 Mar 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320108; cv=none; b=QsosTUhCJXTE2Fkt+UDDa+17JrXJRyPQ4fijdStgiqqfds+jGlnyWc2yYsWMYpxT5GvNrXB7Lr/EHjurrp4ZuBLlT9uz6RPOB2dvP9ICGR57Dz5OLBGphOgsQnAoGNTh5ioYsc4ppURJwQUf0yJ56+rkYxnktMdro1O47TgZq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320108; c=relaxed/simple;
	bh=2U1BXXky8ZR/quxJwTYei+aSurGFxYXAH+6Y+cYM1Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnlYXJUr6CURJv8aBzwXRvN8AajSB7HnNsqRqY/MJYFtb7cm6oERmuP++qmbvQ4YySZw6n1y2zPPDhBiNEfk/kv8DLML7TfH1rWcpRd2VmrPFhE9bQQwwguqU4t+s+LTuiqQNz3AO5dmm3pc7Inr3coTJs9Bz6Hx06amPRyBLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYVcciC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79C1C433F1;
	Sun, 24 Mar 2024 22:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320108;
	bh=2U1BXXky8ZR/quxJwTYei+aSurGFxYXAH+6Y+cYM1Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYVcciC+9WHtTbkTIKIkuAWcoxABSW0Ingl50bQ7fvvBTlq9ebHj3R6J8YUjtZXwz
	 6gqUb4170B/o6wlg3kHZcCXwWB4vJ38VGc9XioQ0nIpaTvUuJnAmHZR41XinT3sdiB
	 7lAGKAip3iaz8BK6oscE+X3/G40a3X6mkMbBEtNbYw4iLEMMLwbBU6HIdcqSJlKJ/W
	 ymsQuup5SdAsFuen8X9TY/KUS3xBCneFae3t0g1Hz/Q4y7IAjTerzguD+4AYdBJB3p
	 djeBeF3yP8pi8kyzNQBoU30A14dz9ReSRdlfE5SibzgtYxy5u42Oln0XdsXMqpYTXw
	 b/4cEk0xc0sHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 416/715] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
Date: Sun, 24 Mar 2024 18:29:55 -0400
Message-ID: <20240324223455.1342824-417-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

[ Upstream commit 2f4a67a3894e15c135125cb54edc5b43abc1b70e ]

Currently INTF_CFG2_DATA_HCTL_EN is coupled with the enablement
of widebus but this is incorrect because we should be enabling
this bit independent of widebus except for cases where compression
is enabled in one pixel per clock mode.

Fix this by making the condition checks more explicit and enabling
INTF_CFG2_DATA_HCTL_EN for all other cases when supported by DPU.

Fixes: 3309a7563971 ("drm/msm/dpu: revise timing engine programming to support widebus feature")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/576722/
Link: https://lore.kernel.org/r/20240201004737.2478-1-quic_abhinavk@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  7 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h       |  7 +++++++
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c       | 15 +++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h       |  1 +
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 6a4b489d44e51..8932f38a41b2d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -226,6 +226,13 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
 	return dpu_enc->wide_bus_en;
 }
 
+bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc)
+{
+	const struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
+
+	return dpu_enc->dsc ? true : false;
+}
+
 int dpu_encoder_get_crc_values_cnt(const struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 4c05fd5e9ed18..fe6b1d312a742 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -158,6 +158,13 @@ int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
 
 bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc);
 
+/**
+ * dpu_encoder_is_dsc_enabled - indicate whether dsc is enabled
+ *				for the encoder.
+ * @drm_enc:    Pointer to previously created drm encoder structure
+ */
+bool dpu_encoder_is_dsc_enabled(const struct drm_encoder *drm_enc);
+
 /**
  * dpu_encoder_get_crc_values_cnt - get number of physical encoders contained
  *	in virtual encoder that can collect CRC values
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index d0f56c5c4cce9..f562beb6f7971 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -102,6 +102,7 @@ static void drm_mode_to_intf_timing_params(
 	}
 
 	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
+	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
 
 	/*
 	 * for DP, divide the horizonal parameters by 2 when
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 6bba531d6dc41..965692ef7892c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -163,13 +163,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	hsync_ctl = (hsync_period << 16) | p->hsync_pulse_width;
 	display_hctl = (hsync_end_x << 16) | hsync_start_x;
 
-	/*
-	 * DATA_HCTL_EN controls data timing which can be different from
-	 * video timing. It is recommended to enable it for all cases, except
-	 * if compression is enabled in 1 pixel per clock mode
-	 */
 	if (p->wide_bus_en)
-		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN | INTF_CFG2_DATA_HCTL_EN;
+		intf_cfg2 |= INTF_CFG2_DATABUS_WIDEN;
 
 	data_width = p->width;
 
@@ -229,6 +224,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
 	DPU_REG_WRITE(c, INTF_CONFIG, intf_cfg);
 	DPU_REG_WRITE(c, INTF_PANEL_FORMAT, panel_format);
 	if (ctx->cap->features & BIT(DPU_DATA_HCTL_EN)) {
+		/*
+		 * DATA_HCTL_EN controls data timing which can be different from
+		 * video timing. It is recommended to enable it for all cases, except
+		 * if compression is enabled in 1 pixel per clock mode
+		 */
+		if (!(p->compression_en && !p->wide_bus_en))
+			intf_cfg2 |= INTF_CFG2_DATA_HCTL_EN;
+
 		DPU_REG_WRITE(c, INTF_CONFIG2, intf_cfg2);
 		DPU_REG_WRITE(c, INTF_DISPLAY_DATA_HCTL, display_data_hctl);
 		DPU_REG_WRITE(c, INTF_ACTIVE_DATA_HCTL, active_data_hctl);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index 0bd57a32144a6..6f4c87244f944 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -33,6 +33,7 @@ struct dpu_hw_intf_timing_params {
 	u32 hsync_skew;
 
 	bool wide_bus_en;
+	bool compression_en;
 };
 
 struct dpu_hw_intf_prog_fetch {
-- 
2.43.0


