Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B578C768
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjH2OV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbjH2OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:21:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5B71AE;
        Tue, 29 Aug 2023 07:21:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0FA9A21868;
        Tue, 29 Aug 2023 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693318890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHmbIqd2sUALnEdDnM2WVScGsOEczoZHYPBc5JTP918=;
        b=PfvisSyWAL9Y8TeZyN6Vve4T4Dgaj2MONj/yPeYxYzyjMAm39+B7qbPjls2cJbZkp4KCP4
        y2a0TZ/tag79lMIdQE3xY9hgw/5hLaE52Agocvkf0j2Upt6lKsNX89ZgtkYwZGc478chlO
        8iGBmAZ0E3eYPwgoyU9SHww2F7aqwvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693318890;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHmbIqd2sUALnEdDnM2WVScGsOEczoZHYPBc5JTP918=;
        b=idXwFnO1J6W1bIilkvJvrMvOfP/0NENujLUqkulomqjNYdPNsvrDFbcaO4eyey7eQCN7cO
        Bfnwqa8LPPvekuBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8075138E2;
        Tue, 29 Aug 2023 14:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IBfgM+n+7WREewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 29 Aug 2023 14:21:29 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/7] fbdev/core: Remove empty internal helpers from fb_logo.c
Date:   Tue, 29 Aug 2023 16:15:45 +0200
Message-ID: <20230829142109.4521-7-tzimmermann@suse.de>
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

Remove the two empty helpers for the case the CONFIG_FB_LOGO_EXTRA
has not been set. They are internal functions and only called once.
Providing empty replacements seems like overkill. Instead protect
the call sites with a test for CONFIG_FB_LOGO_EXTRA.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_logo.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index cde0a330b2ad..9cff78332858 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -412,21 +412,6 @@ static int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
 
 	return y;
 }
-
-#else /* !CONFIG_FB_LOGO_EXTRA */
-
-static inline int fb_prepare_extra_logos(struct fb_info *info,
-					 unsigned int height,
-					 unsigned int yres)
-{
-	return height;
-}
-
-static inline int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
-{
-	return y;
-}
-
 #endif /* CONFIG_FB_LOGO_EXTRA */
 
 int fb_prepare_logo(struct fb_info *info, int rotate)
@@ -497,8 +482,11 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	height = fb_logo.logo->height;
 	if (fb_center_logo)
 		height += (yres - fb_logo.logo->height) / 2;
+#ifdef CONFIG_FB_LOGO_EXTRA
+	height = fb_prepare_extra_logos(info, height, yres);
+#endif
 
-	return fb_prepare_extra_logos(info, height, yres);
+	return height;
 }
 EXPORT_SYMBOL(fb_prepare_logo);
 
@@ -512,7 +500,9 @@ int fb_show_logo(struct fb_info *info, int rotate)
 
 	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
 	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
+#ifdef CONFIG_FB_LOGO_EXTRA
 	y = fb_show_extra_logos(info, y, rotate);
+#endif
 
 	return y;
 }
-- 
2.41.0

