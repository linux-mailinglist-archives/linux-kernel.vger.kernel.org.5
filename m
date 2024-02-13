Return-Path: <linux-kernel+bounces-63611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B928D85323A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB211F21E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7EB56474;
	Tue, 13 Feb 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2GzlSb8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533756465
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832105; cv=none; b=HQDiJBs9M+bL5X3MC9mgMyAkD9IFoXXZD+B4A100B2Fb6quQo/uPFnTDBezHYXsZnHd1H+W60ysm2fx4ELSsjDk6Zg3DFpUw4bgSjh3U1IspWIphjPn4b61JiXKqnQTA4oFzQjyFjW88MGmO/iY6LbGvG8ps1aj1bZysl+oYaaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832105; c=relaxed/simple;
	bh=26cXrqFjrg0ao0r9xUFAr1Dg4GgkrO8FmiGX8abfNuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/H7eS+0y8jT1BEwIXknVsZgrTgIie8/Tji39rtWjv4I/K7tuP00WIgrEokS8sHbeob836JbpPVvDV73+heWcwtUdPuAS5yTSZ7ngSNmlrNQTZ0MJ2vzZt/VPTbDevZp4ayOFvCbBqhf16sv5tTOgMT1tWhfCNxKpuoDBc3rvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2GzlSb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A354C433C7;
	Tue, 13 Feb 2024 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707832103;
	bh=26cXrqFjrg0ao0r9xUFAr1Dg4GgkrO8FmiGX8abfNuM=;
	h=From:To:Cc:Subject:Date:From;
	b=X2GzlSb8rmaizrJ0LylQls2sNtypF+9i+aT25Vuuvh7WYZjxmctA3xM2UEvgXAHQ9
	 LkHZlxozy10NCqsfaltRaUMEVm1POUxpoifOXVzrPA/7gyXDeedg54An0zypsT5+Bm
	 5pL153obBaefWUE4e90RlGfLmnHfeYrp8lYPzkTZ+MQkti4KJPa6SEXkE2vy29EgEB
	 ybIafh9Y/c0rAcuxQpDQ880xxUtDcVNVqnV34nzeQnDVi2C1vnRp07/VQKJO6SgBd1
	 mMfBjKc5K4eYKyYJPaorx6Ar5BXdJS9P2vSyOtN0fOwTUeorMq/U7/HBLji2sl0VHG
	 CPPlBN4LzpySQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: skip building debugfs code for CONFIG_DEBUG_FS=n
Date: Tue, 13 Feb 2024 14:48:05 +0100
Message-Id: <20240213134817.3347574-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Some of the debugfs functions are stubbed out in these configurations,
so trying to build the .c file with the definition fails:

In file included from include/uapi/linux/posix_types.h:5,
                 from drivers/gpu/drm/i915/display/intel_pipe_crc.c:27:
drivers/gpu/drm/i915/display/intel_pipe_crc.c: At top level:
include/linux/stddef.h:8:16: error: expected identifier or '(' before 'void'
    8 | #define NULL ((void *)0)
      |                ^~~~
drivers/gpu/drm/i915/display/intel_pipe_crc.c:549:20: note: in expansion of macro 'intel_crtc_get_crc_sources'
  549 | const char *const *intel_crtc_get_crc_sources(struct drm_crtc *crtc,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~

Stop trying to build them by making the Makefile entries conditional,
same as for the i915 driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index efcf0ab7a1a6..7c10ffdb7809 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -213,8 +213,6 @@ xe-$(CONFIG_DRM_XE_DISPLAY) += \
 	i915-display/intel_ddi.o \
 	i915-display/intel_ddi_buf_trans.o \
 	i915-display/intel_display.o \
-	i915-display/intel_display_debugfs.o \
-	i915-display/intel_display_debugfs_params.o \
 	i915-display/intel_display_device.o \
 	i915-display/intel_display_driver.o \
 	i915-display/intel_display_irq.o \
@@ -258,7 +256,6 @@ xe-$(CONFIG_DRM_XE_DISPLAY) += \
 	i915-display/intel_modeset_setup.o \
 	i915-display/intel_modeset_verify.o \
 	i915-display/intel_panel.o \
-	i915-display/intel_pipe_crc.o \
 	i915-display/intel_pmdemand.o \
 	i915-display/intel_pps.o \
 	i915-display/intel_psr.o \
@@ -275,6 +272,13 @@ xe-$(CONFIG_DRM_XE_DISPLAY) += \
 	i915-display/skl_universal_plane.o \
 	i915-display/skl_watermark.o
 
+ifdef CONFIG_DEBUG_FS
+xe-$(CONFIG_DRM_XE_DISPLAY) += \
+	i915-display/intel_display_debugfs.o \
+	i915-display/intel_display_debugfs_params.o \
+	i915-display/intel_pipe_crc.o
+endif
+
 ifeq ($(CONFIG_ACPI),y)
 	xe-$(CONFIG_DRM_XE_DISPLAY) += \
 		i915-display/intel_acpi.o \
-- 
2.39.2


