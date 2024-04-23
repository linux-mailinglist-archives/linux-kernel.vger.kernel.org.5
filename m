Return-Path: <linux-kernel+bounces-154860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C38AE219
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E071B1F25A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5E6997A;
	Tue, 23 Apr 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHCxxhVA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8226BB47;
	Tue, 23 Apr 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867945; cv=none; b=Jppb95j/LuzVtthuaTMgs1P4QX+e/hl/49Wad6m34gtHKrNPTUf7GXbURA2OCK33Q5oL7E8M/YG93vSejkUPJnaWXx+ItCUQmoRXfVKuBtzO2j8Sz1mMQtr5fa2c27iIlpzvA+yIytf6BEEL1e4J/ywFzGR/dnwaifbvovGRZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867945; c=relaxed/simple;
	bh=n09yJzubRKA9cSYp8TkeTpJhWQ1QQIIQzpKSNmbwu1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XTqVTjuPDrczANnns6GL1XH5Mn885s/UmBGfXQmXX/ldlGC6QUYy+s5wErzYDsyRGWGo8orT45TARIuGiHh5EGhUE+r/ryztRdOqEWwCJaWpyPceuAkZFJ9WEnN1H7J9kptJTOLkPs+YpHEbK81G3YrzORq55ROi34c09GMpuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHCxxhVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F57BC3277B;
	Tue, 23 Apr 2024 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867945;
	bh=n09yJzubRKA9cSYp8TkeTpJhWQ1QQIIQzpKSNmbwu1k=;
	h=From:To:Cc:Subject:Date:From;
	b=mHCxxhVA6cyU/PoiepmDlSLS+H7E3lXEVZZ7SkQkbRwU8wsJn7yq/gsrdZ/KQ8EWQ
	 qTdpyo+2/eOC0aeBtVgoHDfCIzopETuwzyuMteiQN0gOmyQFRX7HK+D8L6Qhs1nSf6
	 QSW5QnB3PyHGaVi8/l72o8F+us2LH4bpe0oFOeOkxpMCBJBY9IfpsuMMMLnryGz3cD
	 xE/GSa9LVnBLrOWUt19DDw6R4yEA4xjbFxKiOupkHRJaRa4+MRQgeR4IoqQPpzY+Y2
	 /eI7tzFD1uKkwRbUpC0GOeZz2y8yY+HaAhUWdjcPSqVCGFWqu84OB0sN7tXOLyUw0i
	 tbJVwJjELHQGQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] drm: move DRM-related CONFIG options into DRM submenu
Date: Tue, 23 Apr 2024 19:24:43 +0900
Message-Id: <20240423102443.453261-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you create a submenu using the 'menu' syntax, there is no
ambiguity about the end of the submenu because the code between
'menu' and 'endmenu' becomes the submenu.

In contrast, 'menuconfig' does not have the corresponding end marker.
Instead, it infers the end of submenu from symbol dependency.

This is described in Documentation/kbuild/kconfig-language.rst,
starting line 348. It demonstrates two ways to place the code under
the submenu:

 (1) open an if-block right after the 'menuconfig', placing the submenu
     content inside the if-block

 (2) give 'depends on' to every symbol that should go into the submenu

Many subsystems adopt (1) because it is the only reliable way to
maintain the submenu structure. It ensures the code enclosed within the
if-block is placed under the submenu.

The DRM subsystem adopts (2). The submenu ends when the sequence of
'depends on' breaks. DRM_DEBUG_MODESET_LOCK is the first option that
does not depend on DRM. So, DRM_DEBUG_MODESET_LOCK and subsequent
options reside outside the DRM submenu.

You can confirm it by running a GUI frontend such as 'make menuconfig'
and visiting the DRM menu:

    < > Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)  ----

If you toggle '< >', you will notice most of the DRM-related options
appear below it, not in the submenu.

I highly recommend the approach (1). Obviously, (2) is not a reliable
way because the submenu breaks whenever someone forgets to add
'depends on DRM'.

This commit surrounds the entire DRM configuration with 'if DRM' and
'endif', except DRM_PANEL_ORIENTATION_QUIRKS.

Note:
 Now, 'depends on DRM' properties inside 'if DRM' ... 'endif' are
 all redundant. I leave it as follow-up cleanups.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/gpu/drm/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5a0c476361c3..11f952d540aa 100644
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
@@ -403,10 +405,6 @@ config DRM_HYPERV
 config DRM_EXPORT_FOR_TESTS
 	bool
 
-# Separate option because drm_panel_orientation_quirks.c is shared with fbdev
-config DRM_PANEL_ORIENTATION_QUIRKS
-	tristate
-
 config DRM_LIB_RANDOM
 	bool
 	default n
@@ -414,3 +412,9 @@ config DRM_LIB_RANDOM
 config DRM_PRIVACY_SCREEN
 	bool
 	default n
+
+endif
+
+# Separate option because drm_panel_orientation_quirks.c is shared with fbdev
+config DRM_PANEL_ORIENTATION_QUIRKS
+	tristate
-- 
2.40.1


