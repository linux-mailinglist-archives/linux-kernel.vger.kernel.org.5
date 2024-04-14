Return-Path: <linux-kernel+bounces-144321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157558A4499
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF851F21029
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE36136648;
	Sun, 14 Apr 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VhEMgyE8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0E1CD23
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713119253; cv=none; b=r0sUcw6ShKX/mzo03SD5ShyZhNQtAgfGv4cAGdkJbts8iSbMIvb25TOaOmDer4xF9+mypbFmDqBS1BEDZlPa/myd/uj+MKhNewOOCa7x3W8yt0T+c5DRZIbeFRugxyPSxxfpGi1hWesvZQrQxp3fe/ptXxZS3d1nuwQFXl+aai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713119253; c=relaxed/simple;
	bh=QOsx3aQu/JriRpOCWq7oChskggSlT2VJlcFd2Ll+Mhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMkWqYwZEcDZNRrrbsB9oDYXUlaMZSQbQfK5UloCYGDsZ9AASTjnPaosOH2qAtKO3/IvmjntGdMY/GVGJF0P26eJm3aqqe8xNTcdHy5OAj5NGrvXBMhoR8orjc1sY/IpFaIy79mzgMGUQrzMRwbHVM3nUxraRGfIUBCosjBsmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VhEMgyE8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713119250;
	bh=QOsx3aQu/JriRpOCWq7oChskggSlT2VJlcFd2Ll+Mhg=;
	h=From:To:Cc:Subject:Date:From;
	b=VhEMgyE8Gf9QvuAUzrkmaBrGtDA8hduJZgqT7CwAHCXIHLZnkP2VSlD0s216FmZVE
	 +MHBS3Hx9I+uZeFIkq94PXewGaWCKUPa1T7dSQful+bAx8otwca00fncoACRkeZmmU
	 GDcy1+QB++0TOobBHEP0UhP+DobpschWhcCM6GVTqifx5rW+6LLNLSAxGEx3fniUSp
	 2xJVQvnhvvM2OL1dkV0aRNwxPzxoxOIwKLE2u/fCa2N6xYk34bVNAcmhGn78nrTDaU
	 eNLCHIKpRcoeiUDCwYHnt4rnJsFRXWYbmUoW+ezvxyGvkUbDeziP1BqbqOV2ge8t0/
	 npME9ki1ps2uQ==
Received: from arisu.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F2D7337814A4;
	Sun, 14 Apr 2024 18:27:26 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko Stubner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] drm: vop2: Do not divide height twice for YUV
Date: Sun, 14 Apr 2024 14:27:06 -0400
Message-ID: <20240414182706.655270-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the cbcr format, gt2 and gt4 are computed again after src_h has been
divided by vsub.

As src_h as already been divided by 2 before, introduce cbcr_src_h and
cbcr_src_w to keep a copy of those values to be used for cbcr gt2 and
gt4 computation.

This fixes yuv planes being unaligned vertically when down scaling to
1080 pixels from 2160.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 22 +++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index fdd768bbd487c..62ebbdb16253d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -706,6 +706,8 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	const struct drm_format_info *info;
 	u16 hor_scl_mode, ver_scl_mode;
 	u16 hscl_filter_mode, vscl_filter_mode;
+	uint16_t cbcr_src_w = src_w;
+	uint16_t cbcr_src_h = src_h;
 	u8 gt2 = 0;
 	u8 gt4 = 0;
 	u32 val;
@@ -763,27 +765,27 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	vop2_win_write(win, VOP2_WIN_YRGB_VSCL_FILTER_MODE, vscl_filter_mode);
 
 	if (info->is_yuv) {
-		src_w /= info->hsub;
-		src_h /= info->vsub;
+		cbcr_src_w /= info->hsub;
+		cbcr_src_h /= info->vsub;
 
 		gt4 = 0;
 		gt2 = 0;
 
-		if (src_h >= (4 * dst_h)) {
+		if (cbcr_src_h >= (4 * dst_h)) {
 			gt4 = 1;
-			src_h >>= 2;
-		} else if (src_h >= (2 * dst_h)) {
+			cbcr_src_h >>= 2;
+		} else if (cbcr_src_h >= (2 * dst_h)) {
 			gt2 = 1;
-			src_h >>= 1;
+			cbcr_src_h >>= 1;
 		}
 
-		hor_scl_mode = scl_get_scl_mode(src_w, dst_w);
-		ver_scl_mode = scl_get_scl_mode(src_h, dst_h);
+		hor_scl_mode = scl_get_scl_mode(cbcr_src_w, dst_w);
+		ver_scl_mode = scl_get_scl_mode(cbcr_src_h, dst_h);
 
-		val = vop2_scale_factor(src_w, dst_w);
+		val = vop2_scale_factor(cbcr_src_w, dst_w);
 		vop2_win_write(win, VOP2_WIN_SCALE_CBCR_X, val);
 
-		val = vop2_scale_factor(src_h, dst_h);
+		val = vop2_scale_factor(cbcr_src_h, dst_h);
 		vop2_win_write(win, VOP2_WIN_SCALE_CBCR_Y, val);
 
 		vop2_win_write(win, VOP2_WIN_VSD_CBCR_GT4, gt4);
-- 
2.43.2


