Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49177B7F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjHNL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHNL4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E67171A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24F731FD66;
        Mon, 14 Aug 2023 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEyKWEV49JtEdl1DYURZo9RW0RDOuBmS/jGSdWXcXwE=;
        b=EnsRFA1qKgyhKt0gFJjMzw6as2fKYaaHSZYZvJc/825TQ2XSnDcqKnIYJA8xm/2eTJ7OCc
        nypK8p6vy8TTqsLoT0Uq4Ezaz8igb28z/DgehbIXYeA5Z/kfgibz5dv+ip0QnpJilRUQwz
        c2ngtPJkRkh0/LTYhuO28eFeddC9Gbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEyKWEV49JtEdl1DYURZo9RW0RDOuBmS/jGSdWXcXwE=;
        b=h8b1DK2e1i7M2w1Uu/TRpxJvQx7WcE8h/sHgEX6Rn9t2wgT+X74UF8i78WaVCoZ1/iKAci
        Yvr4pJOsmaSYutDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04609138EE;
        Mon, 14 Aug 2023 11:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SLmGO0UW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:49 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/25] ALSA: hdsp: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:10 +0200
Message-Id: <20230814115523.15279-13-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814115523.15279-1-tiwai@suse.de>
References: <20230814115523.15279-1-tiwai@suse.de>
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

This patch converts the hdsp driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdsp.c | 42 ++++++----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 65add92c88aa..960cc75608cb 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3961,7 +3961,7 @@ static signed char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 
 static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream,
 				  int channel, unsigned long pos,
-				  void __user *src, unsigned long count)
+				  struct iov_iter *src, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	signed char *channel_buf;
@@ -3972,28 +3972,14 @@ static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream,
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_from_user(channel_buf + pos, src, count))
+	if (!copy_from_iter(channel_buf + pos, count, src))
 		return -EFAULT;
 	return 0;
 }
 
-static int snd_hdsp_playback_copy_kernel(struct snd_pcm_substream *substream,
-					 int channel, unsigned long pos,
-					 void *src, unsigned long count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	signed char *channel_buf;
-
-	channel_buf = hdsp_channel_buffer_location(hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memcpy(channel_buf + pos, src, count);
-	return 0;
-}
-
 static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream,
 				 int channel, unsigned long pos,
-				 void __user *dst, unsigned long count)
+				 struct iov_iter *dst, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
 	signed char *channel_buf;
@@ -4004,25 +3990,11 @@ static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream,
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
 		return -EIO;
-	if (copy_to_user(dst, channel_buf + pos, count))
+	if (!copy_to_iter(channel_buf + pos, count, dst))
 		return -EFAULT;
 	return 0;
 }
 
-static int snd_hdsp_capture_copy_kernel(struct snd_pcm_substream *substream,
-					int channel, unsigned long pos,
-					void *dst, unsigned long count)
-{
-	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	signed char *channel_buf;
-
-	channel_buf = hdsp_channel_buffer_location(hdsp, substream->pstr->stream, channel);
-	if (snd_BUG_ON(!channel_buf))
-		return -EIO;
-	memcpy(dst, channel_buf + pos, count);
-	return 0;
-}
-
 static int snd_hdsp_hw_silence(struct snd_pcm_substream *substream,
 			       int channel, unsigned long pos,
 			       unsigned long count)
@@ -4950,8 +4922,7 @@ static const struct snd_pcm_ops snd_hdsp_playback_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy_user =	snd_hdsp_playback_copy,
-	.copy_kernel =	snd_hdsp_playback_copy_kernel,
+	.copy =		snd_hdsp_playback_copy,
 	.fill_silence =	snd_hdsp_hw_silence,
 };
 
@@ -4963,8 +4934,7 @@ static const struct snd_pcm_ops snd_hdsp_capture_ops = {
 	.prepare =	snd_hdsp_prepare,
 	.trigger =	snd_hdsp_trigger,
 	.pointer =	snd_hdsp_hw_pointer,
-	.copy_user =	snd_hdsp_capture_copy,
-	.copy_kernel =	snd_hdsp_capture_copy_kernel,
+	.copy =		snd_hdsp_capture_copy,
 };
 
 static int snd_hdsp_create_hwdep(struct snd_card *card, struct hdsp *hdsp)
-- 
2.35.3

