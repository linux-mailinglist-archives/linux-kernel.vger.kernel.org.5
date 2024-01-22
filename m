Return-Path: <linux-kernel+bounces-33369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E076C8368E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EEC282E71
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A011495D0;
	Mon, 22 Jan 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRTLSHK0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A5495CF;
	Mon, 22 Jan 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936014; cv=none; b=JDqwLaW6kJ79WbciI2lQuOusknP/I1r1kueYz5E/rukWtmChe4vrPGedVpewvQ9+kWYyUcOyKZ1xzDCl4CWWxxH0dr46yX8X/xv68j1fzrd65+mCOEM9AssDxG06NKkutaZAnHBwwtPC75+gdAS2Kklgf1q17WZ1fl6RMmRhcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936014; c=relaxed/simple;
	bh=0Ksj/HgjXZ/89YGBI3nSIWb2GQHlA0GboIwNC/9NPCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2cB6UJXQzmXrGQ2tlrFTY6tWTJ4y/KEHSfRD2Pj6f4q05YkTDTvtUAKlxFHZjjYQNCFmf5qH3e2ewLIF2JGoID+GWLX8CWO5S6P2IfIXdy4qU7vNhWNQsx9vtq2o2GfNRLG1AEcrYii2mLi94Z66pZK7ETw1hT1m/2rrz82c08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRTLSHK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C394BC43394;
	Mon, 22 Jan 2024 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936014;
	bh=0Ksj/HgjXZ/89YGBI3nSIWb2GQHlA0GboIwNC/9NPCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRTLSHK0y0W9swz+j3aChREftp6ZdX5fVD6sT9/2IbdUA+Y5ge+KJUPcb5DBcb8pz
	 5KGFoaZX91g0FdQhBZ/Gk0ePVYeqeBWX3g1Snlae/CRvywU2ztVm51wDqu15Qnw868
	 W8cI8bMUz7rHbp+q0gynkDozxOmdqs/x1nSTwFez5t9Ix4U6vtWbMObE2/2tv4JmcC
	 mkBpiCGZEHdPUfpDp6q4SR+JO7pXhByg6iP7ohq698913n3bepDWsJemu2QvWegvev
	 lJZRHfJDvLPYcN/lpVQpFY7Dg+FopsryPDYXcA3EedM1GHzkqE29Ap4YYFKn+ajhPw
	 cTBh18zNFGM+Q==
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
Subject: [PATCH AUTOSEL 6.6 47/73] drm/msm/dpu: enable writeback on SM8450
Date: Mon, 22 Jan 2024 10:02:01 -0500
Message-ID: <20240122150432.992458-47-sashal@kernel.org>
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

[ Upstream commit eaa647cdbf2e357b4a14903f2f1e47ed9c4f8df3 ]

Enable WB2 hardware block, enabling writeback support on this platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/570187/
Link: https://lore.kernel.org/r/20231203002743.1291956-4-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
index 1b12178dfbca..8a19cfa274de 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
@@ -32,6 +32,7 @@ static const struct dpu_mdp_cfg sm8450_mdp = {
 		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8 },
 		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x2bc, .bit_off = 8 },
 		[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2c4, .bit_off = 8 },
+		[DPU_CLK_CTRL_WB2] = { .reg_off = 0x2bc, .bit_off = 16 },
 		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
 	},
 };
@@ -326,6 +327,21 @@ static const struct dpu_dsc_cfg sm8450_dsc[] = {
 	},
 };
 
+static const struct dpu_wb_cfg sm8450_wb[] = {
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
 static const struct dpu_intf_cfg sm8450_intf[] = {
 	{
 		.name = "intf_0", .id = INTF_0,
@@ -423,6 +439,8 @@ const struct dpu_mdss_cfg dpu_sm8450_cfg = {
 	.dsc = sm8450_dsc,
 	.merge_3d_count = ARRAY_SIZE(sm8450_merge_3d),
 	.merge_3d = sm8450_merge_3d,
+	.wb_count = ARRAY_SIZE(sm8450_wb),
+	.wb = sm8450_wb,
 	.intf_count = ARRAY_SIZE(sm8450_intf),
 	.intf = sm8450_intf,
 	.vbif_count = ARRAY_SIZE(sdm845_vbif),
-- 
2.43.0


