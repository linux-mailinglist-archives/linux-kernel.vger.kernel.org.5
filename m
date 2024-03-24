Return-Path: <linux-kernel+bounces-114830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2188919B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486B5292193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182421BAA37;
	Mon, 25 Mar 2024 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZtcLxbo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242A1769F7;
	Sun, 24 Mar 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323458; cv=none; b=F+iXprvq19tHWMZCxwW6lmylt08Ps96C1QiVeCkWqX+xcqcwNZrgObO2VoiegCKqp7IJ9/ksASNqN1/gbjzTJjNg2mItfsOcCg9HIT1Y1MdWW5O7nrEnMKppZ1z+N2FujOt3BmPWaEod1NZjawsEmoiMg6zFP53XBOmadum59KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323458; c=relaxed/simple;
	bh=ZGSwcXrrwBI8oVF6JgQbL1JI79+KhMLNKjT5Huj02KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFRwzTcMwJ3hHj/wMuc49i4s17DRSEx6LbVHwCaeuWrTp51lYcDKVcbN31zlBFRgR0AwYhmbsG9sNB3D2mKX5vFPIa1inmFf+sHUVsVavee052OO0DMpK/BOU8PKcfeqvsJcK+DfKsJc/MbpShAjMq0j64ryGwxRp+eLEJBnjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZtcLxbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF10C43390;
	Sun, 24 Mar 2024 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323458;
	bh=ZGSwcXrrwBI8oVF6JgQbL1JI79+KhMLNKjT5Huj02KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZtcLxbo+96fZIGgZgul3TabS6Cv4cgOWUPQJBNVlFTevbN1JOjzQBq6T3EJaz5cZ
	 AZewsMBggF6pSqN06Ld6lDCEWDy0dTsqMG0hMm9nX06epCq7yl0ZP5HF8wljVo3QYF
	 MfbJaVnTurE4Q3+g4lCivOKanK43bw5j+31xMIoJY7nq+QEZcr4kj3nXscpWiBCoFj
	 /gEp2s/TyVaMHrPq3iQ78TtGsB5BosJsOwQ7Uz2koP4eaQo/FrXRoobrweTWiGnvVN
	 Q5LuwdKfZJL1iMA/bOM/TAFYZkm2RUV+j4wCQbptEjSrxxQ72wl55WjoN0nHXTZFby
	 cUgMHbrDivy+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Osipenko <digetx@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 162/317] drm/tegra: dc: rgb: Allow changing PLLD rate on Tegra30+
Date: Sun, 24 Mar 2024 19:32:22 -0400
Message-ID: <20240324233458.1352854-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 0c921b6d4ba06bc899fd84d3ce1c1afd3d00bc1c ]

Asus Transformer TF700T is a Tegra30 tablet device which uses RGB->DSI
bridge that requires a precise clock rate in order to operate properly.
Tegra30 has a dedicated PLL for each display controller, hence the PLL
rate can be changed freely. Allow PLL rate changes on Tegra30+ for RGB
output. Configure the clock rate before display controller is enabled
since DC itself may be running off this PLL and it's not okay to change
the rate of the active PLL that doesn't support dynamic frequency
switching since hardware will hang.

Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> #TF700T
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Stable-dep-of: bc456b5d93db ("drm/tegra: rgb: Fix some error handling paths in tegra_dc_rgb_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dc.c  | 27 ++++++++++++--------
 drivers/gpu/drm/tegra/dc.h  |  1 +
 drivers/gpu/drm/tegra/rgb.c | 49 +++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index abb409b08bc64..f44a64e896587 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1762,10 +1762,9 @@ int tegra_dc_state_setup_clock(struct tegra_dc *dc,
 	return 0;
 }
 
-static void tegra_dc_commit_state(struct tegra_dc *dc,
-				  struct tegra_dc_state *state)
+static void tegra_dc_set_clock_rate(struct tegra_dc *dc,
+				    struct tegra_dc_state *state)
 {
-	u32 value;
 	int err;
 
 	err = clk_set_parent(dc->clk, state->clk);
@@ -1796,11 +1795,6 @@ static void tegra_dc_commit_state(struct tegra_dc *dc,
 	DRM_DEBUG_KMS("rate: %lu, div: %u\n", clk_get_rate(dc->clk),
 		      state->div);
 	DRM_DEBUG_KMS("pclk: %lu\n", state->pclk);
-
-	if (!dc->soc->has_nvdisplay) {
-		value = SHIFT_CLK_DIVIDER(state->div) | PIXEL_CLK_DIVIDER_PCD1;
-		tegra_dc_writel(dc, value, DC_DISP_DISP_CLOCK_CONTROL);
-	}
 }
 
 static void tegra_dc_stop(struct tegra_dc *dc)
@@ -2002,6 +1996,9 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 	u32 value;
 	int err;
 
+	/* apply PLL changes */
+	tegra_dc_set_clock_rate(dc, crtc_state);
+
 	err = host1x_client_resume(&dc->client);
 	if (err < 0) {
 		dev_err(dc->dev, "failed to resume: %d\n", err);
@@ -2076,8 +2073,11 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
 	else
 		tegra_dc_writel(dc, 0, DC_DISP_BORDER_COLOR);
 
-	/* apply PLL and pixel clock changes */
-	tegra_dc_commit_state(dc, crtc_state);
+	/* apply pixel clock changes */
+	if (!dc->soc->has_nvdisplay) {
+		value = SHIFT_CLK_DIVIDER(crtc_state->div) | PIXEL_CLK_DIVIDER_PCD1;
+		tegra_dc_writel(dc, value, DC_DISP_DISP_CLOCK_CONTROL);
+	}
 
 	/* program display mode */
 	tegra_dc_set_timings(dc, mode);
@@ -2685,6 +2685,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = true,
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = false,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -2707,6 +2708,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = true,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = true,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2729,6 +2731,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = true,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2751,6 +2754,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2773,6 +2777,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.has_win_b_vfilter_mem_client = false,
 	.has_win_c_without_vert_filter = false,
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = true,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
@@ -2823,6 +2828,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.wgrps = tegra186_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra186_dc_wgrps),
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = false,
 };
 
 static const struct tegra_windowgroup_soc tegra194_dc_wgrps[] = {
@@ -2873,6 +2879,7 @@ static const struct tegra_dc_soc_info tegra194_dc_soc_info = {
 	.wgrps = tegra194_dc_wgrps,
 	.num_wgrps = ARRAY_SIZE(tegra194_dc_wgrps),
 	.plane_tiled_memory_bandwidth_x2 = false,
+	.has_pll_d2_out0 = false,
 };
 
 static const struct of_device_id tegra_dc_of_match[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 40378308d527a..c9c4c45c05183 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -76,6 +76,7 @@ struct tegra_dc_soc_info {
 	bool has_win_b_vfilter_mem_client;
 	bool has_win_c_without_vert_filter;
 	bool plane_tiled_memory_bandwidth_x2;
+	bool has_pll_d2_out0;
 };
 
 struct tegra_dc {
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index 606c78a2b988f..a84aee2f4acd0 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -17,6 +17,8 @@ struct tegra_rgb {
 	struct tegra_output output;
 	struct tegra_dc *dc;
 
+	struct clk *pll_d_out0;
+	struct clk *pll_d2_out0;
 	struct clk *clk_parent;
 	struct clk *clk;
 };
@@ -123,6 +125,18 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	tegra_dc_commit(rgb->dc);
 }
 
+static bool tegra_rgb_pll_rate_change_allowed(struct tegra_rgb *rgb)
+{
+	if (!rgb->pll_d2_out0)
+		return false;
+
+	if (!clk_is_match(rgb->clk_parent, rgb->pll_d_out0) &&
+	    !clk_is_match(rgb->clk_parent, rgb->pll_d2_out0))
+		return false;
+
+	return true;
+}
+
 static int
 tegra_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_crtc_state *crtc_state,
@@ -151,8 +165,17 @@ tegra_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 	 * and hope that the desired frequency can be matched (or at least
 	 * matched sufficiently close that the panel will still work).
 	 */
-	div = ((clk_get_rate(rgb->clk) * 2) / pclk) - 2;
-	pclk = 0;
+	if (tegra_rgb_pll_rate_change_allowed(rgb)) {
+		/*
+		 * Set display controller clock to x2 of PCLK in order to
+		 * produce higher resolution pulse positions.
+		 */
+		div = 2;
+		pclk *= 2;
+	} else {
+		div = ((clk_get_rate(rgb->clk) * 2) / pclk) - 2;
+		pclk = 0;
+	}
 
 	err = tegra_dc_state_setup_clock(dc, crtc_state, rgb->clk_parent,
 					 pclk, div);
@@ -210,6 +233,22 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 		return err;
 	}
 
+	rgb->pll_d_out0 = clk_get_sys(NULL, "pll_d_out0");
+	if (IS_ERR(rgb->pll_d_out0)) {
+		err = PTR_ERR(rgb->pll_d_out0);
+		dev_err(dc->dev, "failed to get pll_d_out0: %d\n", err);
+		return err;
+	}
+
+	if (dc->soc->has_pll_d2_out0) {
+		rgb->pll_d2_out0 = clk_get_sys(NULL, "pll_d2_out0");
+		if (IS_ERR(rgb->pll_d2_out0)) {
+			err = PTR_ERR(rgb->pll_d2_out0);
+			dev_err(dc->dev, "failed to get pll_d2_out0: %d\n", err);
+			return err;
+		}
+	}
+
 	dc->rgb = &rgb->output;
 
 	return 0;
@@ -217,9 +256,15 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
 
 int tegra_dc_rgb_remove(struct tegra_dc *dc)
 {
+	struct tegra_rgb *rgb;
+
 	if (!dc->rgb)
 		return 0;
 
+	rgb = to_rgb(dc->rgb);
+	clk_put(rgb->pll_d2_out0);
+	clk_put(rgb->pll_d_out0);
+
 	tegra_output_remove(dc->rgb);
 	dc->rgb = NULL;
 
-- 
2.43.0


