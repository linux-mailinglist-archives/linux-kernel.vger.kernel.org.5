Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0405379C406
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjILDUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbjILDLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:11:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E0EF5CCA;
        Mon, 11 Sep 2023 19:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9003EC433CC;
        Mon, 11 Sep 2023 20:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694465628;
        bh=neueOhMV9geEct4AV1YpL7ChkhrLTiaS+cLVbXk27xY=;
        h=From:To:Cc:Subject:Date:From;
        b=Or7LRukEPtbnopW5zQv8hlRjYC08mBils0KkbrC1Wiu3cMfNw5WfzMHLeIx0r9isQ
         bFqKpb00XrMn0mvt6uSch0ybqDEPGn954VMwYdUJ0I67iwf1OBOaY9BUXmffdlEi3H
         Qhr2h+6b8a833sz5dyqv2+A3AjyQMZgP/J2V/nVbjDEU7kZ9AdTUQ6JLysXEx2RhNf
         fIiD9sfKQnaq8pptwKw+NBkjz6ZwZHC1IDUvbWG7O7aSToWuC+p0F8Zhe2tiGyqGIB
         SqjP0qD4c04vUbWVHX1yZFB9FUJHWEWeJuZLNksYwDAYcTeCVtqopqzsU2/4yUlFK6
         tSd7lOl0WPilw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] drm: fix up fbdev Kconfig defaults
Date:   Mon, 11 Sep 2023 22:52:53 +0200
Message-Id: <20230911205338.2385278-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As a result of the recent Kconfig reworks, the default settings for the
framebuffer interfaces changed in unexpected ways:

Configurations that leave CONFIG_FB disabled but use DRM now get
DRM_FBDEV_EMULATION by default. This also turns on the deprecated /dev/fb
device nodes for machines that don't actually want it.

In turn, configurations that previously had DRM_FBDEV_EMULATION enabled
now only get the /dev/fb front-end but not the more useful framebuffer
console, which is not selected any more.

We had previously decided that any combination of the three frontends
(FB_DEVICE, FRAMEBUFFER_CONSOLE and LOGO) should be selectable, but the
new default settings mean that a lot of defconfig files would have to
get adapted.

Change the defaults back to what they were in Linux 6.5:

 - Leave DRM_FBDEV_EMULATION turned off unless CONFIG_FB
   is enabled. Previously this was a hard dependency but now the two are
   independent. However, configurations that enable CONFIG_FB probably
   also want to keep the emulation for DRM, while those without FB
   presumably did that intentionally in the past.

 - Leave FB_DEVICE turned off for FB=n. Following the same
   logic, the deprecated option should not automatically get enabled
   here, most users that had FB turned off in the past do not want it,
   even if they want the console

 - Turn the FRAMEBUFFER_CONSOLE option on if
   DRM_FBDEV_EMULATION is set to avoid having to change defconfig
   files that relied on it being selected unconditionally in the past.
   This also makes sense since both LOGO and FB_DEVICE are now disabled
   by default for builds without CONFIG_FB, but DRM_FBDEV_EMULATION
   would make no sense if all three are disabled.

Fixes: a5ae331edb02b ("drm: Drop select FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION")
Fixes: 701d2054fa317 ("fbdev: Make support for userspace interfaces configurable")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/Kconfig          | 2 +-
 drivers/video/console/Kconfig    | 1 +
 drivers/video/fbdev/core/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 7df8b6875b121..144a9a1d31cea 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
 	depends on DRM
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
-	default y
+	default FB
 	help
 	  Choose this option if you have a need for the legacy fbdev
 	  support. Note that this support also provides the linux console
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index b575cf54174af..83c2d7329ca58 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
 config FRAMEBUFFER_CONSOLE
 	bool "Framebuffer Console support"
 	depends on FB_CORE && !UML
+	default DRM_FBDEV_EMULATION
 	select VT_HW_CONSOLE_BINDING
 	select CRC32
 	select FONT_SUPPORT
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
index 114cb8aa6c8fd..804c2bec9b43c 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -28,7 +28,7 @@ config FIRMWARE_EDID
 config FB_DEVICE
 	bool "Provide legacy /dev/fb* device"
 	depends on FB_CORE
-	default y
+	default FB
 	help
 	  Say Y here if you want the legacy /dev/fb* device file and
 	  interfaces within sysfs anc procfs. It is only required if you
-- 
2.39.2

