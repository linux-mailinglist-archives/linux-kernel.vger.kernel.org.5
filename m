Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00D797BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbjIGS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjIGS07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:26:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B581197;
        Thu,  7 Sep 2023 11:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF84621865;
        Thu,  7 Sep 2023 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694076850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41o/btvw9C5S0iA1yowHnm0gHWjgAAVogrPERtBT9GA=;
        b=PKTYaL/v/ZaN8PPLd2WqAmWUhDE5coJWqhLuQ9pROo9OQdTloob56ywQFvoOVLfnKzaXmB
        YoVZMBcJ30UXp8bB8IwX+AUygAknUqrbtfeSB276LWFYZ2wHwNBw7gXAU5ZYabD2uvcXxT
        S60ZPlhuZ/vmT0o9HFBI5HoLejAwjiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694076850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41o/btvw9C5S0iA1yowHnm0gHWjgAAVogrPERtBT9GA=;
        b=hwMwz5AFFPjhFriVqWD4zEyh9RdjaKlIu9wN8cD9VBP5RKAmY/KWnbFss/oEOkMB61pxMe
        oIAYtxjBjenH11Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B237F138FA;
        Thu,  7 Sep 2023 08:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sLtQKrKP+WT6JgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Sep 2023 08:54:10 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/7] fbdev/mmp/mmpfb: Do not display boot-up logo
Date:   Thu,  7 Sep 2023 10:52:01 +0200
Message-ID: <20230907085408.9354-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907085408.9354-1-tzimmermann@suse.de>
References: <20230907085408.9354-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbcon module takes care of displaying the logo, if any. Remove
the code form mmpfb. It is probably no tworking as expected, as it
interferes with the framebuffer console. If we want to display the
logo without fbcon, we should implement this in the fbdev core code.

v2:
	* add a note on fbcon interference (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
index 42a87474bcea..2d9797c6fb3e 100644
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -628,13 +628,6 @@ static int mmpfb_probe(struct platform_device *pdev)
 	dev_info(fbi->dev, "loaded to /dev/fb%d <%s>.\n",
 		info->node, info->fix.id);
 
-#ifdef CONFIG_LOGO
-	if (fbi->fb_start) {
-		fb_prepare_logo(info, 0);
-		fb_show_logo(info, 0);
-	}
-#endif
-
 	return 0;
 
 failed_clear_info:
-- 
2.42.0

