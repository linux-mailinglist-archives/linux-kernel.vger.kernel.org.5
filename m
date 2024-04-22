Return-Path: <linux-kernel+bounces-153183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C88ACAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2AB1C208E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEBC145B0F;
	Mon, 22 Apr 2024 10:30:57 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545A14431F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781856; cv=none; b=Hp5SdoDJAvY2r1NnV9bdq4sNpgmVY7+BSzNp+um3kmB5POvsMLyzRB/XDcMGtkXA6HXSjNOgzkwM37Vpi3qLoI8off9E5Y/RKy7fGeLvFNze7YNA0mEXTlAGlvagNm0Fs6jhNcJWsi2JUonYszYtSJTm8hkpaf4LAJdp5UGOeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781856; c=relaxed/simple;
	bh=yGB5hpGX52RWf1gg9FuTBOEB/EkM8qiRC1czeIo03Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqzqHAOe4UGoO5Mc7qFQIxSdxLgv/ItfRDMsnOnUfZIoL69dFY17GhFZthhOqfwl3PAXhFUDEXY17vZWRgVfaCZJ85CWJB1j/ytdoac9/A8mhVJkeZOfP7E5jJSmWSTQoVVasEitZdGIQGShTJazVLMYMMR0WNZoGG7WNuuBMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by andre.telenet-ops.be with bizsmtp
	id EAWj2C0070SSLxL01AWj4V; Mon, 22 Apr 2024 12:30:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqw1-001cvo-4U;
	Mon, 22 Apr 2024 12:30:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqwd-005i3V-4Z;
	Mon, 22 Apr 2024 12:30:43 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/11] Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies, part 2"
Date: Mon, 22 Apr 2024 12:30:29 +0200
Message-Id: <37216404c77b4c677d3b3a80d12d6d4447a3f3a0.1713780345.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713780345.git.geert+renesas@glider.be>
References: <cover.1713780345.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a57e191ebbaa0363dbf352cc37447c2230573e29, as the
commits it fixes will be reverted, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/bridge/analogix/Kconfig | 2 +-
 drivers/gpu/drm/rockchip/Kconfig        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index 5b564fded6d6c8e7..12bfea53bf24b2c2 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -28,7 +28,7 @@ config DRM_ANALOGIX_ANX78XX
 
 config DRM_ANALOGIX_DP
 	tristate
-	depends on DRM_DISPLAY_HELPER
+	depends on DRM
 
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 4c7072e6e34eafb5..4b4ad75032fda17e 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -36,7 +36,7 @@ config ROCKCHIP_VOP2
 config ROCKCHIP_ANALOGIX_DP
 	bool "Rockchip specific extensions for Analogix DP driver"
 	depends on DRM_DISPLAY_DP_HELPER
-	depends on DRM_DISPLAY_HELPER=y || (DRM_DISPLAY_HELPER=m && DRM_ROCKCHIP=m)
+	depends on DRM_DISPLAY_HELPER
 	depends on ROCKCHIP_VOP
 	help
 	  This selects support for Rockchip SoC specific extensions
-- 
2.34.1


