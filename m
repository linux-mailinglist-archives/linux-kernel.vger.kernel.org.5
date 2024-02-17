Return-Path: <linux-kernel+bounces-70019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005408591D5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7918B223F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E87E102;
	Sat, 17 Feb 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="nrGm2lL8"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1691C282
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195646; cv=none; b=g59HOFCx8vzJCQ/B49vpEhn3AX7f9t3TYdqF11UMqmJXBHMv2TVfbOBoKHir6yh/or8th2cQIgWCsz6R5gaGMmCsBnroq9l3vGOH0IboyTP1xtzk0tEqGTOzRsu20ZhKparRLckJQkTyWs40q0KDF+w7JHITHNn+IExcfmPKDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195646; c=relaxed/simple;
	bh=M7kFL6IVY5bC9B0FS4qqIwBemjDZhp54+jL5ahTfYbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPd4NZyHydpu83K2x0UZ/92fTI76yFawSjfVRq3YpI2uFd2IHP19P+R3Apbtgs+22nu6tH/R1JSaYxsdMR2bC5/ysKqdTQ2PeAEQFKV2fLduuz7cfFmwX8nI45HJT3IUFCJJsfbdCB2yKh/XS5yUV1znWKLBzWVkE/+0XbJR4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=nrGm2lL8; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708195642; bh=M7kFL6IVY5bC9B0FS4qqIwBemjDZhp54+jL5ahTfYbk=;
	h=From:To:Cc:Subject:Date:From;
	b=nrGm2lL8aZW3rvmIDuLQAapt+SGeUWtVznCP3ghwOu7Ivq2TiYeE//Sl2NJGQIu3k
	 ZL/fE1Yz0f26hI7bnNryID4CMZPzGSiqWpZm302C2g6hy9+mJchtxjYxFOv+JODHjd
	 doD8ZpWYUZsWi2gR8r106LG4LB1oOiTX0iw5WMKk=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ROCKCHIP),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] drm: rockchip: dw-mipi-dsi: Fix hsclk calculation for non-burst video modes
Date: Sat, 17 Feb 2024 19:47:15 +0100
Message-ID: <20240217184720.1753730-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

For panels that don't use video burst mode, hsclock should match the
pixel clock * bpp / lane exactly. This fixes display image corruption
on Pinephone Pro, which doesn't use video burst mode to drive the panel.

To simplify the addition of exact fout calculation for non-burst modes,
the code is re-organized in order to not redo the same calculation
multiple times, and to use identical algorithm for per-lane bitrate
for internal and external dphy use cases.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 28 ++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 4cc8ed8f4fbd..7468324872ec 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -548,8 +548,6 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 {
 	struct dw_mipi_dsi_rockchip *dsi = priv_data;
 	int bpp;
-	unsigned long mpclk, tmp;
-	unsigned int target_mbps = 1000;
 	unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
 	unsigned long best_freq = 0;
 	unsigned long fvco_min, fvco_max, fin, fout;
@@ -567,30 +565,28 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 		return bpp;
 	}
 
-	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
-	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / lanes) * 10 / 8;
-		if (tmp < max_mbps)
-			target_mbps = tmp;
-		else
-			DRM_DEV_ERROR(dsi->dev,
-				      "DPHY clock frequency is out of range\n");
+	fout = mode->clock * bpp / lanes;
+	if (mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		fout = fout * 10 / 8;
+	fout *= MSEC_PER_SEC;
+
+	if (fout > max_mbps * USEC_PER_SEC) {
+		DRM_DEV_ERROR(dsi->dev,
+			      "DPHY clock frequency is out of range\n");
+		return -EINVAL;
 	}
 
-	/* for external phy only a the mipi_dphy_config is necessary */
+	/* for external phy only the mipi_dphy_config is necessary */
 	if (dsi->phy) {
-		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
-						 bpp, lanes,
+		phy_mipi_dphy_get_default_config_for_hsclk(fout, lanes,
 						 &dsi->phy_opts.mipi_dphy);
-		dsi->lane_mbps = target_mbps;
+		dsi->lane_mbps = DIV_ROUND_UP(fout, USEC_PER_SEC);
 		*lane_mbps = dsi->lane_mbps;
 
 		return 0;
 	}
 
 	fin = clk_get_rate(dsi->pllref_clk);
-	fout = target_mbps * USEC_PER_SEC;
 
 	/* constraint: 5Mhz <= Fref / N <= 40MHz */
 	min_prediv = DIV_ROUND_UP(fin, 40 * USEC_PER_SEC);
-- 
2.43.0


