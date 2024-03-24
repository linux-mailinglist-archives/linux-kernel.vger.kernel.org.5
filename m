Return-Path: <linux-kernel+bounces-114563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D9888B13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393911F274F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23796184F02;
	Sun, 24 Mar 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrAWIsIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F814A4EC;
	Sun, 24 Mar 2024 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322201; cv=none; b=tTpeYjUVzqayH/HVhAOl5SW4zGcw0latpWupijq1Qb9AFp/jxVbcpS8mISxrHVpW0yo94noagrDE05l1w9bY+RiFfDKSrToYtqBlIBiVz4kZWF7JHMPnfaZ8jfHWe114l8KxoE9wzdL4WwUNPwKtxwF73N6x1SQX0/hWD0Hl7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322201; c=relaxed/simple;
	bh=TcfgaUMNaa4X0MxPfCFxq4JHN1C/Ibye9dsDwAoSIyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHH5Hway8wT7V1cmHK03+m7tB3X6ZAK9ZdoU2COPO0fiotYx+qMpSrxR7hofcjQchl3MPbBOBkZ6VMtnnXogIYOgzvkLm9Q0ttpGO7qvpzAE5MG1raepmHbRiW/KB9TjLy6pxguv6LCNHD7NRAbLAP4nRSojttDgK0CAUYcGQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrAWIsIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B570C433A6;
	Sun, 24 Mar 2024 23:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322199;
	bh=TcfgaUMNaa4X0MxPfCFxq4JHN1C/Ibye9dsDwAoSIyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrAWIsIbMUVD6tsFG87cBMEt0WNBuQRicPm0baJJ7262FZ941GvfOgfX3uMBKZgGe
	 00GJ/0z+ZIje0bejWVJj1L2TdZuD7xWUK21+8flvmgMgd9U//RXoOmZa12KPZr8ryU
	 f9CQooCAZ9ZZ0NMEbFGJtf/948gif1NzrtRw8OM3DPe+e5xDqknUu1f27iERKEgAIk
	 Ff9kXWENEqfC/pneGbclPHzt0qBq8Ki24P3q6KvWyfeg1Mv0eWzJIfrwtW11oCZyKp
	 D54pbpSDSC82UnKmJthReNkBNqD5sl8H6Y2CTs+0bbtJo4ns/1+de7VJ64CTxmCBhH
	 nB9LKesbQVlCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 279/451] drm/msm/dpu: fix the programming of INTF_CFG2_DATA_HCTL_EN
Date: Sun, 24 Mar 2024 19:09:15 -0400
Message-ID: <20240324231207.1351418-280-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 25245ef386db6..4bdde5cb23aae 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -228,6 +228,13 @@ bool dpu_encoder_is_widebus_enabled(const struct drm_encoder *drm_enc)
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
index 9e7236ef34e6d..a71efa2b9e508 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -175,6 +175,13 @@ int dpu_encoder_get_vsync_count(struct drm_encoder *drm_enc);
 
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
index 2c14646661b77..09aeec00bf5e2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -100,6 +100,7 @@ static void drm_mode_to_intf_timing_params(
 	}
 
 	timing->wide_bus_en = dpu_encoder_is_widebus_enabled(phys_enc->parent);
+	timing->compression_en = dpu_encoder_is_dsc_enabled(phys_enc->parent);
 
 	/*
 	 * for DP, divide the horizonal parameters by 2 when
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index 384558d2f9602..1debac4fcc3eb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -154,13 +154,8 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
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
 
@@ -230,6 +225,14 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
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
index e75339b96a1d2..7f502c8bee1d4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -33,6 +33,7 @@ struct intf_timing_params {
 	u32 hsync_skew;
 
 	bool wide_bus_en;
+	bool compression_en;
 };
 
 struct intf_prog_fetch {
-- 
2.43.0


