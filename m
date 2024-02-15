Return-Path: <linux-kernel+bounces-66925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014E8563AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B31428914C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5012F374;
	Thu, 15 Feb 2024 12:50:25 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C712EBC6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001424; cv=none; b=sj68/8i1EQAasRspNH60qoT7Zn+4aX7yLWnnjwddCelzRuug7UWI43FsazZ2RlrL2ITsUdPD16/2d9KvHOm1pexhf4VHZvSwDF+GOPJdUlIx++aPhdAmDO7FEBMTnnPdzyZl5Pgkca/gOMs2uHPh20xcaKdJ89mAcqWbTNPY1qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001424; c=relaxed/simple;
	bh=1tWTWuVX6lxYG8U4HnLFrl2doGFXSXLHE/ylxNHGUCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdyKdcxECR1v6OTHHEZjitHtantWH+/iKvw2PS81OqQphkG5PcuoKqwL3sNgU6oyZLdBsr8W7t+qxJIKQTHjB+bSxhiOUV0622v6FKXaF2t+YTelRNJJu08cvT8GlGURpGlMh4+NgG5AeYlz2LyZZQh3P6SOA2ez5JCein0buJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by xavier.telenet-ops.be with bizsmtp
	id nQqA2B00K0LVNSS01QqALE; Thu, 15 Feb 2024 13:50:15 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabBj-000gwk-8T;
	Thu, 15 Feb 2024 13:50:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rabBq-00HVIF-HO;
	Thu, 15 Feb 2024 13:50:10 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Donald Robson <donald.robson@imgtec.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
Date: Thu, 15 Feb 2024 13:50:09 +0100
Message-Id: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the Imagination Technologies PowerVR Series 6 GPU requires a
proprietary firmware image, which is currently only available for Texas
Instruments K3 AM62x SoCs.  Hence add a dependency on ARCH_K3, to
prevent asking the user about this driver when configuring a kernel
without Texas Instruments K3 Multicore SoC support.

Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
v2:
  - Add Reviewed-by,
  - Clarify the firmware dependency.
---
 drivers/gpu/drm/imagination/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 3bfa2ac212dccb73..af492dbd9afd4ed9 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -6,6 +6,7 @@ config DRM_POWERVR
 	depends on ARM64
 	depends on DRM
 	depends on PM
+	depends on ARCH_K3 || COMPILE_TEST
 	select DRM_EXEC
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_SCHED
-- 
2.34.1


