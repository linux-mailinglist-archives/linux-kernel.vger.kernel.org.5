Return-Path: <linux-kernel+bounces-160110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55388B393B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B47F1F2191B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E875F14A4D2;
	Fri, 26 Apr 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXZy47Tm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC21487E7;
	Fri, 26 Apr 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139770; cv=none; b=DIhzYEOrMQ+J243hGkmZa+GzfDhHRveTTgj19F/RnSgI9qCu946mNMG3vKfgWAUMGG1gTJNWhADEi+AsSEssTLTdXlLb+UuVLS7b9GgIpwpsDoytX6mRtzsmFmlUUGVhiEaQPAwOHDJf5CD70jnLjuJlBcdfEg/OhCiQPci2+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139770; c=relaxed/simple;
	bh=0+zg+HziepsJXdpuYfXEg99K1gcbh+aTdTuGOHhJCk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0Yuu3o/mPLBn3woccMZLy7UW4UOQlCMrMaCmkwms6VT7BZItO3PN1gELtcITGck3DAVok4TY+YmtBE2kIYhk4f0wF8LjwLfzOT3csdw/5JBhmn2f+hQXTSUrmJTOonxBLlZ8OaljHvqnHEo8nb3OEc1aYJouxanFJXu1WWkkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXZy47Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A74FC2BD10;
	Fri, 26 Apr 2024 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714139769;
	bh=0+zg+HziepsJXdpuYfXEg99K1gcbh+aTdTuGOHhJCk8=;
	h=From:To:Cc:Subject:Date:From;
	b=FXZy47TmOUSg3WqWMcMut1Z7zIiZ4tmxrMRafdj5yH1iWAAh+yHzXlHbaNlxGA5Ot
	 CV1+3AWLq9oEj0+MZ7uk/d+XiQu63zslESmwEqQQX9z6z0W+R1wuNRxIP5T9PM2c04
	 jfx9fVrA+LYvBpDU0VnsR0E+lIOIAY2091nAM2v+fX30k0457MkPQ9idi8rce6dtT6
	 AAyOfHXcG2It/3dta/8aCg923akzlajAkTsmmr6Juu0iRFGp2wry9p+icBkfFRDYg7
	 3L1heWYtSAESsX+VLYZC+GmrUGY2MfMugWazphB0375F0QSv4ZJVzqzrd5+L9906bz
	 c1IgnoFFGR6wQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: linux-kbuild@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: move DRM-related CONFIG options into DRM submenu
Date: Fri, 26 Apr 2024 22:56:02 +0900
Message-Id: <20240426135602.2500125-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you create a submenu using the 'menu' syntax, there is no
ambiguity about its end because the code between 'menu' and 'endmenu'
becomes the submenu.

In contrast, 'menuconfig' does not have the corresponding end marker.
Instead, the end of the submenu is inferred from symbol dependencies.

This is detailed in Documentation/kbuild/kconfig-language.rst, starting
line 348. It outlines two methods to place the code under the submenu:

 (1) Open an if-block immediately after 'menuconfig', enclosing the
     submenu content within it

 (2) Add 'depends on' to every symbol intended for the submenu

Many subsystems opt for (1) because it reliably maintains the submenu
structure.

The DRM subsystem adopts (2). The submenu ends when the sequence of
'depends on DRM' breaks. It can be confirmed by running a GUI frontend
such as 'make menuconfig' and visiting the DRM menu:

    < > Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)  ----

If you toggle this, you will notice most of the DRM-related options
appear below it, not in the submenu.

I highly recommend the approach (1). Obviously, (2) is not reliable,
as the submenu breaks whenever someone forgets to add 'depends on DRM'.

This commit encloses the entire DRM configuration with 'if DRM' and
'endif', except for DRM_PANEL_ORIENTATION_QUIRKS.

Note:
 Now, 'depends on DRM' properties inside the if-block are all redundant.
 I leave it as follow-up cleanups.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

Changes in v2:
  - Rebased onto next-20240426

 drivers/gpu/drm/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 959b19a04101..7df15543a70a 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -29,6 +29,8 @@ menuconfig DRM
 	  details.  You should also select and configure AGP
 	  (/dev/agpgart) support if it is available for your platform.
 
+if DRM
+
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
@@ -439,10 +441,6 @@ config DRM_HYPERV
 config DRM_EXPORT_FOR_TESTS
 	bool
 
-# Separate option because drm_panel_orientation_quirks.c is shared with fbdev
-config DRM_PANEL_ORIENTATION_QUIRKS
-	tristate
-
 config DRM_LIB_RANDOM
 	bool
 	default n
@@ -463,3 +461,9 @@ config DRM_WERROR
 	  this config option is disabled by default.
 
 	  If in doubt, say N.
+
+endif
+
+# Separate option because drm_panel_orientation_quirks.c is shared with fbdev
+config DRM_PANEL_ORIENTATION_QUIRKS
+	tristate
-- 
2.40.1


