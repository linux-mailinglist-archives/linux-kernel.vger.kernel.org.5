Return-Path: <linux-kernel+bounces-133168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A021899FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD136B2179B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B016F281;
	Fri,  5 Apr 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4GTJkF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5F43170
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327738; cv=none; b=MYpW9xl6WQ/IlR8sRfeHybx4v+NRdlVtXLWL+9hYY1bRaqWodv9OghtrX6tF6274kU6xrz35f4doXB6Adb2TdEDuOGy3J+mG4CFkZ0xMbbqgqmMjQ/ZJ0Uw73ImovqYH0Igft4/Emce9H3+Ktswr5hxFrkkoXFGnNkCeRpSFPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327738; c=relaxed/simple;
	bh=cGx3XcSUmG/0NU34vSZ8SB13pSwI3CCc+82+Mw41W9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jh+0y3vj/C5POtNRoQJ+n+lS5hDa1PSkvZu39AAh/CR109ddVMh1SM/8I1aDDTWplWlVXCKaAa6yiQx3EM+jQSgD/3pxjnTs+UM64wQlD/af+UJ4/dl4m00Wp1RLdBjGWPSjxeXKDKw/hyDUAJNLTricBAcY0gLsJCVRfwFnUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4GTJkF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF1AC433F1;
	Fri,  5 Apr 2024 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712327738;
	bh=cGx3XcSUmG/0NU34vSZ8SB13pSwI3CCc+82+Mw41W9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=W4GTJkF2NoHt9XnqwQTLKq4IfPLYruS80XBlIFbwaXdAYK8fqr/VHKS7YVA5vx25+
	 vRTkeeAUYy0PCg3sQQrm7bCMbNMHJTT6tWJVqOAlmDWYsoeRgNPFrqGxGD83G4JdXM
	 8W5nXj5IpcSI9MrityPDDT7CBfKbnrSFaGu23tSa9YMISN1ijWdOV+Beq4tKCup76Q
	 g0w1K6TVjfZexJCTgD2AyW44LaqCtGeYBc24AlTBOi2PRPQETbR5si/J/cKfWR80sb
	 S/YCAT8OftsftIV0sq3t3aC0uP8bucZ4cTaGqoR97Uz3RlX1tSzlE/ZbEc/Ygt4EfD
	 nd2nOl7qplRtQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] drm: fix DRM_DISPLAY_DP_HELPER dependencies, part 2
Date: Fri,  5 Apr 2024 16:35:10 +0200
Message-Id: <20240405143531.925589-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After my fix yesterday, I ran into another problem of the same kind:

aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `drm_dp_dpcd_readb':
analogix_dp_core.c:(.text+0x194): undefined reference to `drm_dp_dpcd_read'
aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `drm_dp_dpcd_writeb':
analogix_dp_core.c:(.text+0x214): undefined reference to `drm_dp_dpcd_write'
aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_stop_crc':
analogix_dp_core.c:(.text+0x4b0): undefined reference to `drm_dp_stop_crc'
aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_start_crc':
analogix_dp_core.c:(.text+0xbe8): undefined reference to `drm_dp_start_crc'

Add the same dependency again to ROCKCHIP_ANALOGIX_DP after checking that
nothing else selects the analogix driver. Also add a dependency to
DRM_ANALOGIX_DP to make it easier to identifier future problems of
this type when they get introduced.

Fixes: 0323287de87d ("drm: Switch DRM_DISPLAY_DP_HELPER to depends on")
Fixes: d1ef8fc18be6 ("drm: fix DRM_DISPLAY_DP_HELPER dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/bridge/analogix/Kconfig | 2 +-
 drivers/gpu/drm/rockchip/Kconfig        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index 12bfea53bf24..5b564fded6d6 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -28,7 +28,7 @@ config DRM_ANALOGIX_ANX78XX
 
 config DRM_ANALOGIX_DP
 	tristate
-	depends on DRM
+	depends on DRM_DISPLAY_HELPER
 
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 4b4ad75032fd..4c7072e6e34e 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -36,7 +36,7 @@ config ROCKCHIP_VOP2
 config ROCKCHIP_ANALOGIX_DP
 	bool "Rockchip specific extensions for Analogix DP driver"
 	depends on DRM_DISPLAY_DP_HELPER
-	depends on DRM_DISPLAY_HELPER
+	depends on DRM_DISPLAY_HELPER=y || (DRM_DISPLAY_HELPER=m && DRM_ROCKCHIP=m)
 	depends on ROCKCHIP_VOP
 	help
 	  This selects support for Rockchip SoC specific extensions
-- 
2.39.2


