Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751E790C00
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbjICNGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbjICNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:06:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D011A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 06:06:06 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cmniqQ8hcCR96cmniqWxe4; Sun, 03 Sep 2023 15:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693746365;
        bh=O220rzlIlLp6o2xfxGxBVH/zqfS61CmNj2d3+epiJpo=;
        h=From:To:Cc:Subject:Date;
        b=Isp4NlJiXf0F+xOmZ1F1oiBm7dh/goI15PQk/DF3YbHfSuFKleoK3ZOv8NTYT9SlY
         RqoUlPlgP0q6R9zwNteU/O7zq4hJweT30R32NaoDsJ8uEbaFwMx5XvVeDw9Utw7yHt
         ccGob7O4Xw0vUhEiPxM6/Qvz5AUKFs0JcB5RwJMw+7FNxBmW0qkK0V3OO+lcLjTM5z
         70zyTyWAr9T6QTIYDQ1UA4Yb7naP7EptKPeRFvYFZGPQa7jrL5qmyuNA5iA15dguBF
         vhRrFOUpSRh9/UQiZI6pdGiUHitKj3o7rT6tM3+RNUUHrdSfSlm2ZnXhMYz2vK3zO5
         XXFLD6RN/T7yA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 15:06:05 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix a potential memory leak in scarlett2_init_notify()
Date:   Sun,  3 Sep 2023 15:06:00 +0200
Message-Id: <fc275ed315b9157952dcf2744ee7bdb78defdb5f.1693746347.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If usb_alloc_coherent() or usb_urb_ep_type_check() fail, we should release
the resources previously allocated.

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/usb/midi2.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index a27e244650c8..4109c82adff6 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -302,7 +302,8 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
 		ctx->urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!ctx->urb) {
 			dev_err(&ep->dev->dev, "URB alloc failed\n");
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto err_free_all;
 		}
 		ctx->ep = ep;
 		buffer = usb_alloc_coherent(ep->dev, len, GFP_KERNEL,
@@ -310,7 +311,8 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
 		if (!buffer) {
 			dev_err(&ep->dev->dev,
 				"URB buffer alloc failed (size %d)\n", len);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto err_free_cur_urb;
 		}
 		if (ep->interval)
 			usb_fill_int_urb(ctx->urb, ep->dev, ep->pipe,
@@ -322,13 +324,22 @@ static int alloc_midi_urbs(struct snd_usb_midi2_endpoint *ep)
 		if (err < 0) {
 			dev_err(&ep->dev->dev, "invalid MIDI EP %x\n",
 				endpoint);
-			return err;
+			goto err_free_cur_dma;
 		}
 		ctx->urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
 		ep->num_urbs++;
 	}
 	ep->urb_free = ep->urb_free_mask = GENMASK(ep->num_urbs - 1, 0);
 	return 0;
+
+err_free_cur_dma:
+	usb_free_coherent(ep->dev, len, buffer, ctx->urb->transfer_dma);
+err_free_cur_urb:
+	usb_free_urb(ctx->urb);
+	ctx->urb = NULL;
+err_free_all:
+	free_midi_urbs(ep);
+	return err;
 }
 
 static struct snd_usb_midi2_endpoint *
-- 
2.34.1

