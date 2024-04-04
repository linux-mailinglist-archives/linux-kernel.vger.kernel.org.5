Return-Path: <linux-kernel+bounces-131454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868489881B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55441C22CD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388278061C;
	Thu,  4 Apr 2024 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1wILHmz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580E3D3BF;
	Thu,  4 Apr 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234469; cv=none; b=TBaazaTZEJsaD0xYQCfyjergOafU/H7IHN65sMsOc4jl83IfM44/DWPgL4VIIRk2iPZFueLXg3pDag67KTCPUWl43A6o86X1YeocPZ8acR2w9sq1hEljYlHt2excQIQEymqGHjgsThQUQ9PQPzg4nbKQrYKjEDANhw6I7TArnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234469; c=relaxed/simple;
	bh=1+ARrgqOwE2kiq3eGjR0xYk+TKFwqS1s+JPGIlCRzrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sVzx9vPNlxlKR+ZjTa6C0nolZMv2/av+/sVl4kd5TbDQptYCCreY40NJkGg7Er2KEFy96m8YiMa0tfvdDoWKReM/wjHLdAL0BTQJ0fg/zOeF+OLz1+A2fSxFiPmDG6KPbJeS+PwZfnVESukZv4TITl7tNJWe59ZQyN4Vxv4Z8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1wILHmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4576C433C7;
	Thu,  4 Apr 2024 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712234468;
	bh=1+ARrgqOwE2kiq3eGjR0xYk+TKFwqS1s+JPGIlCRzrg=;
	h=From:To:Cc:Subject:Date:From;
	b=M1wILHmzWdiOAp7d8xIOgHHXhrz/7TiyaIV1N2+o2verXTbHYiqK0wiSsSsod5n86
	 YbzkiBrkwthA4pFginyMapp29V66ueImtirbBSyRioo09xy5hhd7gYbfsy25QqkVSt
	 uJODYi4DD/IJ1X0yu7ZUKpcc8qPAIjnyRgJxkD9LmBecKcvVN1Hnbao5N096v1ikp5
	 llsQNqn9J+qKXXmzj+55bcTNNXm6Kg9wv5/mBPX/7bEy9vwng9+/gxQLNZzKJLUyFE
	 0uGjsV5Ci0rgCkwpXuFYzqAgepspQCK/1lkFCHdbZvU7BSUcJD8CC2cTSM6XuF5vI6
	 9RNZ4CHYRj8lA==
From: Arnd Bergmann <arnd@kernel.org>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] drm: fix DRM_DISPLAY_DP_HELPER dependencies
Date: Thu,  4 Apr 2024 14:40:51 +0200
Message-Id: <20240404124101.2988099-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Both the exynos and rockchip drivers ran into link failures after
a Kconfig cleanup:

aarch64-linux-ld: drivers/gpu/drm/exynos/exynos_dp.o: in function `exynos_dp_resume':
exynos_dp.c:(.text+0xc0): undefined reference to `analogix_dp_resume'
aarch64-linux-ld: drivers/gpu/drm/exynos/exynos_dp.o: in function `exynos_dp_suspend':
exynos_dp.c:(.text+0xf4): undefined reference to `analogix_dp_suspend'

x86_64-linux-ld: drivers/gpu/drm/rockchip/cdn-dp-core.o: in function `cdn_dp_connector_mode_valid':
cdn-dp-core.c:(.text+0x13a): undefined reference to `drm_dp_bw_code_to_link_rate'
x86_64-linux-ld: cdn-dp-core.c:(.text+0x148): undefined reference to `drm_dp_bw_code_to_link_rate'
x86_64-linux-ld: drivers/gpu/drm/rockchip/cdn-dp-core.o: in function `cdn_dp_check_link_status':
cdn-dp-core.c:(.text+0x1396): undefined reference to `drm_dp_channel_eq_ok'

In both cases, the problem is that ROCKCHIP_CDN_DP and DRM_EXYNOS_DP
are 'bool' symbols that depend on the the 'tristate' DRM_DISPLAY_HELPER
symbol, but end up not working when the SoC specific part is built-in
but the helper is in a loadable module.

Use the same trick that DRM_ROCKCHIP already uses for the EXTCON
dependency and disallow DP support when it would not work.

Fixes: 0323287de87d ("drm: Switch DRM_DISPLAY_DP_HELPER to depends on")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/Kconfig   | 2 +-
 drivers/gpu/drm/rockchip/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 6a26a0b8eff2..58cd77220741 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -68,7 +68,7 @@ config DRM_EXYNOS_DP
 	bool "Exynos specific extensions for Analogix DP driver"
 	depends on DRM_EXYNOS_FIMD || DRM_EXYNOS7_DECON
 	depends on DRM_DISPLAY_DP_HELPER
-	depends on DRM_DISPLAY_HELPER
+	depends on DRM_DISPLAY_HELPER=y || (DRM_DISPLAY_HELPER=m && DRM_EXYNOS=m)
 	select DRM_ANALOGIX_DP
 	default DRM_EXYNOS
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 4b49a14758fe..4b4ad75032fd 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -46,7 +46,7 @@ config ROCKCHIP_ANALOGIX_DP
 config ROCKCHIP_CDN_DP
 	bool "Rockchip cdn DP"
 	depends on DRM_DISPLAY_DP_HELPER
-	depends on DRM_DISPLAY_HELPER
+	depends on DRM_DISPLAY_HELPER=y || (DRM_DISPLAY_HELPER=m && DRM_ROCKCHIP=m)
 	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
 	help
 	  This selects support for Rockchip SoC specific extensions
-- 
2.39.2


