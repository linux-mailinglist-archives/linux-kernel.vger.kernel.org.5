Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE7790BEE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjICMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjICMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:41:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93B123
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 05:41:52 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cmQEqRX1vhaW6cmQEq3SIb; Sun, 03 Sep 2023 14:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693744910;
        bh=PHniSO2zYUYgC/x8zH3jPDQE+1EC8XtwBC0f5Q2U7xI=;
        h=From:To:Cc:Subject:Date;
        b=p3cOoNSTCEea5D5oUBy6qdvbEiqZFrWMjMElRRmZoMrmpAH4hBl2M8hACnmdhqJ1i
         EyCgf1nubhvpvq8HCStgz6nhrJ46QIxGmTJEQmbJfozESIV2/yenVMQxiPmpqLnRpj
         PlxRM3AyqRlwAJyihfsYOvfZsbjQhcWuE7fs3KqTRvGjKFNEJz2VMwNqCbt28PZspL
         As87C0CVcy08dt5rfQ77esx7au0YZbXMUtAmJW7NaeuKfc7f/wIP5CEu6bBn+YXVZM
         CGxdk1/HBxGPwRSVWbIMvxjpTyvFGS+kv6fnQqZQ7lWsBhs4wA6qCVnG1LMEmwVwDw
         OSJT2CuRgTevg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 14:41:50 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: scarlett2: Fix a potential memory leak in scarlett2_init_notify()
Date:   Sun,  3 Sep 2023 14:41:45 +0200
Message-Id: <73aab53d53df156a5df2bc61314ff26448526749.1693744859.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kmalloc() fails, we should release 'mixer->urb'.

Fixes: 9e4d5c1be21f ("ALSA: usb-audio: Scarlett Gen 2 mixer interface")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/usb/mixer_scarlett_gen2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 9d11bb08667e..a439c7f64b2e 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -4060,8 +4060,10 @@ static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
 		return -ENOMEM;
 
 	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
-	if (!transfer_buffer)
+	if (!transfer_buffer) {
+		usb_free_urb(mixer->urb);
 		return -ENOMEM;
+	}
 
 	usb_fill_int_urb(mixer->urb, dev, pipe,
 			 transfer_buffer, private->wMaxPacketSize,
-- 
2.34.1

