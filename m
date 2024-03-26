Return-Path: <linux-kernel+bounces-119601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE2A88CAF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C19B27B69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF01CFBD;
	Tue, 26 Mar 2024 17:32:19 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB11CD32
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474338; cv=none; b=m+qoBqAH17MJeQb/GmxBeh40UlbFcu0g6rM2L+l4Rp/ybMZIHtS7I8ho2b40e2a1yYDY5sepIhqGlyalExEx/k3E20/DZbXaZRVc9LCjFs9crFTeqMZHV9IV0ncaWaIrhpiBIqk1+ynKCkQMRAqr1rhNTchL+s+PF1N5FgzziNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474338; c=relaxed/simple;
	bh=yscuF0G/tph/Y4itTI6/5johZGaGHrI4d1K74HT7Skg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPWpD9WhwYnXgiPFEC9b099wjZBnBxAS6j906IxJxJo+pxna3rSsxgo5efHITnjo0FIEAvdsLUDEe5kG68D4qSUcRz3Pm0YdkLaFNmZ8zRHCwPDT55XpQ2KUvvqaxDhoCWxLzy98Ow4sqb0n8/YWG98fyhyeCGonuG8I8u4qunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by laurent.telenet-ops.be with bizsmtp
	id 3VYD2C00H0SSLxL01VYDYl; Tue, 26 Mar 2024 18:32:14 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAeM-0053li-UA;
	Tue, 26 Mar 2024 18:32:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAej-001ZOf-Nq;
	Tue, 26 Mar 2024 18:32:13 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm: DRM_DEBUG_MODESET_LOCK should depend on DRM
Date: Tue, 26 Mar 2024 18:32:12 +0100
Message-Id: <80bb56a361c3a4f7567f1d8a8adb050fdff62462.1711474310.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in asking the user about enabling DRM debug tracing
when configuring a kernel without DRM support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 2e1b23ccf30423a9..a24c48acf235449a 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -119,9 +119,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
 
 config DRM_DEBUG_MODESET_LOCK
 	bool "Enable backtrace history for lock contention"
-	depends on STACKTRACE_SUPPORT
-	depends on DEBUG_KERNEL
-	depends on EXPERT
+	depends on DRM && STACKTRACE_SUPPORT && DEBUG_KERNEL && EXPERT
 	select STACKDEPOT
 	default y if DEBUG_WW_MUTEX_SLOWPATH
 	help
-- 
2.34.1


