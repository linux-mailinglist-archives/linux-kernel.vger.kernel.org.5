Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10578C767
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjH2OV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbjH2OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C4C1AD;
        Tue, 29 Aug 2023 07:21:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D404421867;
        Tue, 29 Aug 2023 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693318889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUbB8t1jMs2NvTCL1i8e3x7ghSB0BFTTbtWoCMhSOSY=;
        b=A8xCpbPDau4XwZc+45JW6g2X/jaY2IE8fkugiwZoPNZ3nBPYVmYBMf6Da/4mY3S8bDnKqH
        uqOQKDUzhIImREJ8yFMvUUC3YA83hIGW2NBPU02Xf/M8vDzDTTMCNPpUQKA+ipECI/YJBs
        KB17/bt8brk1RqY//I5d34VRYJ3Du6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693318889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUbB8t1jMs2NvTCL1i8e3x7ghSB0BFTTbtWoCMhSOSY=;
        b=iSKxgAz0Fi9Kkc8E2cgWoajAeFSoHk032LkhPT7U2I4nwxN/lEjePx5FJg9iNhQzk/3qgv
        pIHe8kc0sTF8ZYDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A973213909;
        Tue, 29 Aug 2023 14:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sJB4KOn+7WREewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 29 Aug 2023 14:21:29 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/7] fbdev/core: Build fb_logo iff CONFIG_LOGO has been selected
Date:   Tue, 29 Aug 2023 16:15:44 +0200
Message-ID: <20230829142109.4521-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829142109.4521-1-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only build fb_logo.c if CONFIG_LOGO has been selected. Otherwise
provide empty implementations of the contained interfaces and avoid
using the exported variables.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/Makefile      |  3 ++-
 drivers/video/fbdev/core/fb_internal.h | 11 +++++++++++
 drivers/video/fbdev/core/fb_logo.c     | 14 --------------
 drivers/video/fbdev/core/fbcon.c       |  4 ++++
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index adce31155e92..36d3156dc759 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
 obj-$(CONFIG_FB_CORE)             += fb.o
 fb-y                              := fb_info.o \
-                                     fb_logo.o \
                                      fbmem.o fbcmap.o \
                                      modedb.o fbcvt.o fb_cmdline.o fb_io_fops.o
 ifdef CONFIG_FB
@@ -24,6 +23,8 @@ fb-y				  += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
 endif
 endif
 
+fb-$(CONFIG_LOGO)		  += fb_logo.o
+
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
 obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
diff --git a/drivers/video/fbdev/core/fb_internal.h b/drivers/video/fbdev/core/fb_internal.h
index 79e57a5e6e7e..613832d335fe 100644
--- a/drivers/video/fbdev/core/fb_internal.h
+++ b/drivers/video/fbdev/core/fb_internal.h
@@ -21,10 +21,21 @@ static inline void fb_unregister_chrdev(void)
 #endif
 
 /* fb_logo.c */
+#if defined(CONFIG_LOGO)
 extern bool fb_center_logo;
 extern int fb_logo_count;
 int fb_prepare_logo(struct fb_info *fb_info, int rotate);
 int fb_show_logo(struct fb_info *fb_info, int rotate);
+#else
+static inline int fb_prepare_logo(struct fb_info *info, int rotate)
+{
+	return 0;
+}
+static inline int fb_show_logo(struct fb_info *info, int rotate)
+{
+	return 0;
+}
+#endif /* CONFIG_LOGO */
 
 /* fbmem.c */
 extern struct class *fb_class;
diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index 76ba5a2bebae..cde0a330b2ad 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -7,7 +7,6 @@
 bool fb_center_logo __read_mostly;
 int fb_logo_count __read_mostly = -1;
 
-#ifdef CONFIG_LOGO
 static inline unsigned int safe_shift(unsigned int d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
@@ -518,16 +517,3 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	return y;
 }
 EXPORT_SYMBOL(fb_show_logo);
-#else
-int fb_prepare_logo(struct fb_info *info, int rotate)
-{
-	return 0;
-}
-EXPORT_SYMBOL(fb_prepare_logo);
-
-int fb_show_logo(struct fb_info *info, int rotate)
-{
-	return 0;
-}
-EXPORT_SYMBOL(fb_show_logo);
-#endif /* CONFIG_LOGO */
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index f157a5a1dffc..24b038510a71 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -474,15 +474,19 @@ static int __init fb_console_setup(char *this_opt)
 
 		if (!strncmp(options, "logo-pos:", 9)) {
 			options += 9;
+#ifdef CONFIG_LOGO
 			if (!strcmp(options, "center"))
 				fb_center_logo = true;
+#endif
 			continue;
 		}
 
 		if (!strncmp(options, "logo-count:", 11)) {
 			options += 11;
+#ifdef CONFIG_LOGO
 			if (*options)
 				fb_logo_count = simple_strtol(options, &options, 0);
+#endif
 			continue;
 		}
 	}
-- 
2.41.0

