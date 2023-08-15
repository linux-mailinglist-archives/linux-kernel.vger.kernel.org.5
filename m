Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A6877D2DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjHOTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbjHOTCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD3210A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 229071FD69;
        Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ySaxeYR4V6QAHTuuwVyisQreRoOordxkp1IR/NdAHw=;
        b=JbAezIn6LBIFEk3x6CGtLkgEv/YMgYekvaXq4NM4ANDZAyOe8+CkLs2jDJ5dmVBigG+85y
        D93TbACISwday1+W9N3u+ARGfX+Z8NjAtyxuG0tsf84JVQLELSrBooHT5otSczWpxQbFvO
        ubYH3SpI8Ekqw0Si5U9jL/HPAx3V5eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ySaxeYR4V6QAHTuuwVyisQreRoOordxkp1IR/NdAHw=;
        b=9OLjurHIjISj0ca4zZByPgGXlRHLbSqtBscNp5S8Bpf+BXeqyEAdfgAmpaOJYR0Ou4NFoY
        lztKgEKurYrK9ZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 044D91390C;
        Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MNguAJ3L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:49 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 13/25] ALSA: rme9652: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:24 +0200
Message-Id: <20230815190136.8987-14-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the rme9652 driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is adjusted accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/rme9652.c | 46 +++++--------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index e7c320afefe8..d066c70ae160 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -1844,7 +1844,7 @@ static signed char *rme9652_channel_buffer_location(struct snd_rme9652 *rme9652,
 
 static int snd_rme9652_playback_copy(struct snd_pcm_substream *substream,
 				     int channel, unsigned long pos,
-				     void __user *src, unsigned long count)
+				     struct iov_iter *src, unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
 	signed char *channel_buf;
@@ -1857,30 +1857,14 @@ static int snd_rme9652_playback_copy(struct snd_pcm_substream *substream,
 						       channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_from_user(channel_buf + pos, src, count))
+	if (copy_from_iter(channel_buf + pos, count, src) != count)
 		return -EFAULT;
 	return 0;
 }
 
-static int snd_rme9652_playback_copy_kernel(struct snd_pcm_substream *substream,
-					    int channel, unsigned long pos,
-					    void *src, unsigned long count)
-{
-	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	signed char *channel_buf;
-
-	channel_buf = rme9652_channel_buffer_location(rme9652,
-						      substream->pstr->stream,
-						      channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memcpy(channel_buf + pos, src, count);
-	return 0;
-}
-
 static int snd_rme9652_capture_copy(struct snd_pcm_substream *substream,
 				    int channel, unsigned long pos,
-				    void __user *dst, unsigned long count)
+				    struct iov_iter *dst, unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
 	signed char *channel_buf;
@@ -1893,27 +1877,11 @@ static int snd_rme9652_capture_copy(struct snd_pcm_substream *substream,
 						       channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_to_user(dst, channel_buf + pos, count))
+	if (copy_to_iter(channel_buf + pos, count, dst) != count)
 		return -EFAULT;
 	return 0;
 }
 
-static int snd_rme9652_capture_copy_kernel(struct snd_pcm_substream *substream,
-					   int channel, unsigned long pos,
-					   void *dst, unsigned long count)
-{
-	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	signed char *channel_buf;
-
-	channel_buf = rme9652_channel_buffer_location(rme9652,
-						      substream->pstr->stream,
-						      channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memcpy(dst, channel_buf + pos, count);
-	return 0;
-}
-
 static int snd_rme9652_hw_silence(struct snd_pcm_substream *substream,
 				  int channel, unsigned long pos,
 				  unsigned long count)
@@ -2370,8 +2338,7 @@ static const struct snd_pcm_ops snd_rme9652_playback_ops = {
 	.prepare =	snd_rme9652_prepare,
 	.trigger =	snd_rme9652_trigger,
 	.pointer =	snd_rme9652_hw_pointer,
-	.copy_user =	snd_rme9652_playback_copy,
-	.copy_kernel =	snd_rme9652_playback_copy_kernel,
+	.copy =		snd_rme9652_playback_copy,
 	.fill_silence =	snd_rme9652_hw_silence,
 };
 
@@ -2383,8 +2350,7 @@ static const struct snd_pcm_ops snd_rme9652_capture_ops = {
 	.prepare =	snd_rme9652_prepare,
 	.trigger =	snd_rme9652_trigger,
 	.pointer =	snd_rme9652_hw_pointer,
-	.copy_user =	snd_rme9652_capture_copy,
-	.copy_kernel =	snd_rme9652_capture_copy_kernel,
+	.copy =		snd_rme9652_capture_copy,
 };
 
 static int snd_rme9652_create_pcm(struct snd_card *card,
-- 
2.35.3

