Return-Path: <linux-kernel+bounces-153188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C38ACAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29165B22E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9FC1474B9;
	Mon, 22 Apr 2024 10:31:01 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9439E146A74
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781861; cv=none; b=mVLspzZsu01R1sP3d0x+X0ZV7HmgUrCCpTXYGTSXFenPztp6+MwEuCRujfl5BnBPSZKS6yZD9b51eqP8HmGfhkilL8N1HneAm3JqMech7M6LP47jtsj8kAKbsgYzOmwVFxqN3iVUPCUrYsicHnrMF2HxW41hHRzmFSxufgD4S+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781861; c=relaxed/simple;
	bh=1CXNvotAMQnIGPSbHcaV7HaPO7twZYw/r9xyNVOHBdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sqm6LHXAsd6TrU8GlbkGEBbV3BgNlKiB8EalfUp2bRkaolIeJd73awYIUuCW9G3aj4gIVA24zxFFGoEeHw+tTe0S0bUyvPJrDJYv2r4B9uroe2aqpT2rxiC2ataJy7oiwQfxiUNECkjLfhMMXX7o8gOuO2OGVXtxdtlkWGO13LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4VNM3J2GgBz4wyVd
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:30:52 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id EAWj2C00B0SSLxL06AWjTr; Mon, 22 Apr 2024 12:30:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqw1-001cvn-4S;
	Mon, 22 Apr 2024 12:30:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqwd-005i3S-3e;
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
Subject: [PATCH 00/11] drm: Restore helper usability
Date: Mon, 22 Apr 2024 12:30:28 +0200
Message-Id: <cover.1713780345.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

As discussed on IRC with Maxime and Arnd, this series reverts the
conversion of select to depends for various DRM helpers in series
"[PATCH v3 00/13] drm/display: Convert helpers Kconfig symbols to
depends on"[1], and various fixes for it.  This conversion introduced a
big usability issue when configuring a kernel and enabling DRM drivers
that use DRM helper code: as drivers now depend on helpers, the user
needs to know which helpers to enable, before the driver he is
interested even becomes visible.  The user should not need to know that,
and drivers should select the helpers they need.

Hence revert back to what we had before, where drivers selected the
helpers (and any of their dependencies, if they can be met) they need.
In general, when a symbol selects another symbol, it should just make
sure the dependencies of the target symbol are met, which may mean
adding dependencies to the source symbol.

Thanks for applying!

[1] https://lore.kernel.org/r/20240327-kms-kconfig-helpers-v3-0-eafee11b84b3@kernel.org/

Geert Uytterhoeven (11):
  Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies, part 2"
  Revert "drm/display: Select DRM_KMS_HELPER for DP helpers"
  Revert "drm/bridge: dw-hdmi: Make DRM_DW_HDMI selectable"
  Revert "drm: fix DRM_DISPLAY_DP_HELPER dependencies"
  Revert "drm: Switch DRM_DISPLAY_HDMI_HELPER to depends on"
  Revert "drm: Switch DRM_DISPLAY_HDCP_HELPER to depends on"
  Revert "drm: Switch DRM_DISPLAY_DP_HELPER to depends on"
  Revert "drm: Switch DRM_DISPLAY_DP_AUX_BUS to depends on"
  Revert "drm: Switch DRM_DISPLAY_HELPER to depends on"
  Revert "drm: Make drivers depends on DRM_DW_HDMI"
  Revert "drm/display: Make all helpers visible and switch to depends
    on"

 drivers/gpu/drm/Kconfig                 |  8 +++----
 drivers/gpu/drm/amd/amdgpu/Kconfig      | 12 ++++------
 drivers/gpu/drm/bridge/Kconfig          | 28 +++++++++++-----------
 drivers/gpu/drm/bridge/analogix/Kconfig | 18 +++++++-------
 drivers/gpu/drm/bridge/cadence/Kconfig  |  8 +++----
 drivers/gpu/drm/bridge/imx/Kconfig      |  4 ++--
 drivers/gpu/drm/bridge/synopsys/Kconfig |  6 ++---
 drivers/gpu/drm/display/Kconfig         | 32 ++++++++++---------------
 drivers/gpu/drm/exynos/Kconfig          |  4 ++--
 drivers/gpu/drm/i915/Kconfig            |  8 +++----
 drivers/gpu/drm/imx/ipuv3/Kconfig       |  5 ++--
 drivers/gpu/drm/ingenic/Kconfig         |  2 +-
 drivers/gpu/drm/mediatek/Kconfig        |  6 ++---
 drivers/gpu/drm/meson/Kconfig           |  2 +-
 drivers/gpu/drm/msm/Kconfig             |  8 +++----
 drivers/gpu/drm/nouveau/Kconfig         | 10 ++++----
 drivers/gpu/drm/panel/Kconfig           | 32 ++++++++++++-------------
 drivers/gpu/drm/radeon/Kconfig          |  8 +++----
 drivers/gpu/drm/renesas/rcar-du/Kconfig |  2 +-
 drivers/gpu/drm/rockchip/Kconfig        | 10 ++++----
 drivers/gpu/drm/sun4i/Kconfig           |  2 +-
 drivers/gpu/drm/tegra/Kconfig           |  8 +++----
 drivers/gpu/drm/vc4/Kconfig             | 10 ++++----
 drivers/gpu/drm/xe/Kconfig              | 13 ++++------
 drivers/gpu/drm/xlnx/Kconfig            |  8 +++----
 25 files changed, 116 insertions(+), 138 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

