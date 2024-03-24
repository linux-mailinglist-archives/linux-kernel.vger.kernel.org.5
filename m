Return-Path: <linux-kernel+bounces-114299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511A888F95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618D21C2BF51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636351ED0DC;
	Sun, 24 Mar 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0UBR5qV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC520F22D;
	Sun, 24 Mar 2024 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321673; cv=none; b=qa3/DlSHQja0vlShtLXEfoxaIykIcDdQ+dgQmRIXM4DHbCVlWARUSdmw3TMFxom+O9keMIeFxlW6sHf9LUmC9Yq1080lnbbaLPd7Qutzzl890yMC+MFWzA7e8KMaarMGqcbEP+ZACJ+Nebj7uiRNeh6jt4nOGbew6YGx/uWPTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321673; c=relaxed/simple;
	bh=uk1JeAXQxJcagIppgWyt4T/MyhKNrPluMQxvEW2jAuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgUR+yNuhRGk3OzpFOPWKUQazylN2ldfiMO1awj5QhixPEU5uoMBpjYUCIiJL4Upqay1ZPEGb+uuIcaMk/B/SEyDRHWNDaDj4AHCfvBD6XdZSExh841qD45f19ggue8+Bg6pfaZRpZKiU9ZcgEKbUtG6XA2nc09B4NeXsoKzVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0UBR5qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E3C43399;
	Sun, 24 Mar 2024 23:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321672;
	bh=uk1JeAXQxJcagIppgWyt4T/MyhKNrPluMQxvEW2jAuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0UBR5qVH/vDEoL+7KIW7g0/fB86ePv/S3LJUiv//kW44Udqm+5z9VQqBNREAbgI/
	 I8+JnmWdMBSuPN+eT71SuuSElpEKv+rlkoE6jNJwaAjXY0tYufU0Wq3s88JUxelHX0
	 g9lkHozuZHzJlrjSvtF4CxHL+ZAns+GGyw3d9sI88VOlTxugfueY0Ahddhdu2Ej4qI
	 e1rPysTwmLYvnzyYAQeCT+ycajoNBycTe2mQSjvEgdkkHrXG5O5y0QhCV6Mx/tb9cG
	 oWMR5a1vSyMEtkWJVwXDCK6yPhs5UOUYNyF9W0yA1OkBRX8F2oIvxc9TryD1K2Ltey
	 Cne7tmznlBUiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 401/638] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
Date: Sun, 24 Mar 2024 18:57:18 -0400
Message-ID: <20240324230116.1348576-402-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index ca4e5eae8e064..89bd526f3990a 100644
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
index c2189e58de6af..97c31d03d5520 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -100,6 +100,7 @@ static void drm_mode_to_intf_timing_params(
 	}
 
 	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
+	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
 
 	/*
 	 * for DP, divide the horizonal parameters by 2 when
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index da071b1c02afe..9cdd2d8bf79ba 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -161,13 +161,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
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
 
@@ -227,6 +222,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
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
index 4e86108bee289..192f4e67b1732 100644
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


