Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEF7CBFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjJQJkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjJQJkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:40:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E0E8;
        Tue, 17 Oct 2023 02:40:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97CAC433CB;
        Tue, 17 Oct 2023 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697535600;
        bh=K50Y7pAstCn0vIlPs9oEq/dIQQ7sSFid9QIZDsnEC58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7pNPOWwMNsnxJiNu+/ulgNnBPDAK35fhQY/w7ONBieXm4cxYawjWgp+kN+LC7hSs
         9GJ9Tcb6m25A1HX7BzUn4rev268Rkgkrbkob8CL0e393Bikj1yJFTFiqAcGV7/vxMB
         YNvql7JqXrq6bvENwo+N7rGrSMwXCMgsoPUBzktAVO29HeHYQR6CXNEsPEXMU8AEw+
         Z/nNofFXDLIJNcfRYEqfhQMUKuf3vP/Ywv31+csIT9PN4yDoiI/cXtRwng0kDUwiwD
         wB9rHCuJNUzxssMimXgA+/Jldhu15olqxUYcne59UwMrXksyGLTyAHL6x9ZURDDCbH
         vS8plkDZ4H3/w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] console: fix up ARM screen_info reference
Date:   Tue, 17 Oct 2023 11:39:47 +0200
Message-Id: <20231017093947.3627976-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017093947.3627976-1-arnd@kernel.org>
References: <20231017093947.3627976-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Separating the VGA console screen_info from the EFI one unfortunately
caused a build failure for footbridge that I had never caught
with randconfig builds:

arch/arm/kernel/setup.c:932:27: error: static declaration of 'vgacon_screen_info' follows non-static declaration
  932 | static struct screen_info vgacon_screen_info = {
      |                           ^~~~~~~~~~~~~~~~~~
In file included from arch/arm/kernel/setup.c:44:
arch/arm/include/asm/setup.h:40:27: note: previous declaration of 'vgacon_screen_info' with type 'struct screen_info'
   40 | extern struct screen_info vgacon_screen_info;
      |                           ^~~~~~~~~~~~~~~~~~
arm-linux-gnueabi-ld: drivers/video/console/dummycon.o: in function `dummycon_init':
dummycon.c:(.text+0xe4): undefined reference to `screen_info'

Make sure the variable is global to avoid the conflict with the extern
declaration, and make it work in dummycon.c

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Greg, this was caused by patch "vgacon: clean up global screen_info
instances" in tty-testing. You can either apply this patch on top or fold
it into that, or I can just resend the fixed series if you prefer.
---
 arch/arm/include/asm/vga.h       | 1 +
 arch/arm/kernel/setup.c          | 2 +-
 drivers/video/console/dummycon.c | 5 +++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/vga.h b/arch/arm/include/asm/vga.h
index 7c0bee57855ab..6c430ec371df2 100644
--- a/arch/arm/include/asm/vga.h
+++ b/arch/arm/include/asm/vga.h
@@ -5,6 +5,7 @@
 #include <linux/io.h>
 
 extern unsigned long vga_base;
+extern struct screen_info vgacon_screen_info;
 
 #define VGA_MAP_MEM(x,s)	(vga_base + (x))
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b808712e85981..ff2299ce1ad7a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -929,7 +929,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
 }
 
 #if defined(CONFIG_VGA_CONSOLE)
-static struct screen_info vgacon_screen_info = {
+struct screen_info vgacon_screen_info = {
  .orig_video_lines	= 30,
  .orig_video_cols	= 80,
  .orig_video_mode	= 0,
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 70549fecee12c..14af5d9e13b00 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -19,8 +19,9 @@
  */
 
 #if defined(CONFIG_ARCH_FOOTBRIDGE) && defined(CONFIG_VGA_CONSOLE)
-#define DUMMY_COLUMNS	screen_info.orig_video_cols
-#define DUMMY_ROWS	screen_info.orig_video_lines
+#include <asm/vga.h>
+#define DUMMY_COLUMNS	vgacon_screen_info.orig_video_cols
+#define DUMMY_ROWS	vgacon_screen_info.orig_video_lines
 #else
 /* set by Kconfig. Use 80x25 for 640x480 and 160x64 for 1280x1024 */
 #define DUMMY_COLUMNS	CONFIG_DUMMY_CONSOLE_COLUMNS
-- 
2.39.2

