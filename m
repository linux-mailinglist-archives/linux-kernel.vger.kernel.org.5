Return-Path: <linux-kernel+bounces-33368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FCC8368DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0341A1C234A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4E6BB3D;
	Mon, 22 Jan 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZHJfE0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BF48CD8;
	Mon, 22 Jan 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936008; cv=none; b=Hzy/vwp8W6uL8/UgYy4LEwjYC9meNdzy0mRgxYN8p9BPqImvpDHTtZe1PzgP+GhXKFeARYRiMjr3UhuSiA1cDLau1pIASfGJ9dB0KtlrqZ89PTc/MOb2TshsIugmBnUdcZFAoA8XUiIFjshInNYyoqvKWkz/eT/lMhBERg+ZkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936008; c=relaxed/simple;
	bh=U/GmYvwZveJIn+gK5OKTDP5s5kd2TA9QgBjnAWPcvu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYCe8YBh+xU0LoVn9XLagd+k5JnXyEgQeDEP9vKI1DJwkvG6VfOd/mYD5cusa5ste9e/XVRa3tpwzu5IACt1eNjQjlAy2rD1UatWw4aqN3wsrpZHD4s2zOvgTMH0a1f4BUUvVjtumXLdMNHpQzBUrwFzE5RZbCqxvSZjqKWwR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZHJfE0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4086CC43330;
	Mon, 22 Jan 2024 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936007;
	bh=U/GmYvwZveJIn+gK5OKTDP5s5kd2TA9QgBjnAWPcvu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZHJfE0aFH/p9e/X49GMZg5sK0WZlOnw8R9wlXqC9j8wIMI7ca5gW+hlJ1Kg0GB7d
	 ++5E41nnigVtYDq/OGoBMNrF8Bt3n+8JSuBsuQWlxY79Jo/tgmxK5Gg3m4oS7vZx2J
	 DAaFkOj7QpvCJDySpqsbITwRrq60v6EB7tXhXRCFLk9Gz53HXEV5X57DLULgWTB9GI
	 oDEE2INr0QIxzmDX4uDv5hiyeypWvkbZlp7wUjebl7TLyDnVhn1iBnu0XdcUW3lEsf
	 xYwm6h5coKUP5hw2QewOLxaaOyBWxHbO0XnPZCqBzD4jjx7l1qupjwrW/iJnwdtyAO
	 3dpvAW2/CAIYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	marijn.suijten@somainline.org,
	konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 46/73] drm/msm/dpu: enable writeback on SM8350
Date: Mon, 22 Jan 2024 10:02:00 -0500
Message-ID: <20240122150432.992458-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit c2949a49dfe960e952400029e14751dceff79d38 ]

Enable WB2 hardware block, enabling writeback support on this platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/570188/
Link: https://lore.kernel.org/r/20231203002743.1291956-3-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index f8d16f9bf528..428bcbcfbf19 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -31,6 +31,7 @@ static const struct dpu_mdp_cfg sm8350_mdp = {
 		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
 		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2bc, .bit_off = 8 },
 		[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2c4, .bit_off = 8 },
+		[DPU_CLK_CTRL_WB2] = { .reg_off = 0x2bc, .bit_off = 16 },
 		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
 	},
 };
@@ -304,6 +305,21 @@ static const struct dpu_dsc_cfg sm8350_dsc[] = {
 	},
 };
 
+static const struct dpu_wb_cfg sm8350_wb[] = {
+	{
+		.name = "wb_2", .id = WB_2,
+		.base = 0x65000, .len = 0x2c8,
+		.features = WB_SM8250_MASK,
+		.format_list = wb2_formats,
+		.num_formats = ARRAY_SIZE(wb2_formats),
+		.clk_ctrl = DPU_CLK_CTRL_WB2,
+		.xin_id = 6,
+		.vbif_idx = VBIF_RT,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
+	},
+};
+
 static const struct dpu_intf_cfg sm8350_intf[] = {
 	{
 		.name = "intf_0", .id = INTF_0,
@@ -401,6 +417,8 @@ const struct dpu_mdss_cfg dpu_sm8350_cfg = {
 	.dsc = sm8350_dsc,
 	.merge_3d_count = ARRAY_SIZE(sm8350_merge_3d),
 	.merge_3d = sm8350_merge_3d,
+	.wb_count = ARRAY_SIZE(sm8350_wb),
+	.wb = sm8350_wb,
 	.intf_count = ARRAY_SIZE(sm8350_intf),
 	.intf = sm8350_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
-- 
2.43.0


