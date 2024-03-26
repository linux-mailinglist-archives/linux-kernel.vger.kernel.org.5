Return-Path: <linux-kernel+bounces-119599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29088CAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439711F2989E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BA1F947;
	Tue, 26 Mar 2024 17:31:48 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CF1CF8B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474307; cv=none; b=iL2u6oJu9O3ywXukazxSg6oTZNzZHrmCwZSt181iXH6jbG9yJ4Bay5VKypgYmnHITf5P9Voj0MJUGXV090WTmXFzRmjL/9RjeT+39fpSDEVi/0NYYGTH4xzqjPZcHpVcAe2P5Wbh5vAvoqTJ/89CCL7VcVn2fBwQ2/uJNQOqxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474307; c=relaxed/simple;
	bh=bq4YNkziyQcZmvz2N637u5vOHPJJEnrP824rDyNrXGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTu4HRoRMqthkx4MSmgIHDMekJjjQTEGStS7OZTK2XWGRjQlzmqfUDdtq+K0mcTKO5cItD2fqLe4m39a4GKJ+0RMd4JU7SY/ofbo73/oaQzukp0yAFvUIPgcJxp6OAiKstaXemAWXf9t1V/SYl8mdmpfxuz2orm78uVXTpfRWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by baptiste.telenet-ops.be with bizsmtp
	id 3VXj2C00C0SSLxL01VXjoL; Tue, 26 Mar 2024 18:31:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAds-0053lR-Fw;
	Tue, 26 Mar 2024 18:31:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rpAeF-001ZND-9j;
	Tue, 26 Mar 2024 18:31:43 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm: DRM_WERROR should depend on DRM
Date: Tue, 26 Mar 2024 18:31:41 +0100
Message-Id: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no point in asking the user about enforcing the DRM compiler
warning policy when configuring a kernel without DRM support.

Fixes: f89632a9e5fa6c47 ("drm: Add CONFIG_DRM_WERROR")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f2bcf5504aa77679..2e1b23ccf30423a9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -423,7 +423,7 @@ config DRM_PRIVACY_SCREEN
 
 config DRM_WERROR
 	bool "Compile the drm subsystem with warnings as errors"
-	depends on EXPERT
+	depends on DRM && EXPERT
 	default n
 	help
 	  A kernel build should not cause any compiler warnings, and this
-- 
2.34.1


