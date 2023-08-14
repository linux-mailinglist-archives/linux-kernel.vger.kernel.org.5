Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1F77B7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjHNL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjHNL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7BD1739
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D27621997;
        Mon, 14 Aug 2023 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cj4kVpKPycOnuk0PSnAEX3PBDOqTT9BbDloAvvcIDuk=;
        b=v+gVKG7AHRdXsPrzr5WS4g0zk6aej2YxUQ7W4MmOcYAGn16Tp6ak0xS5OZ4xKZ/pNVVl9a
        nCrPzStbxKKiqV9jmdrHt7PCPopASCZW217X/84AV4A/Tinkgt8R55Fnm+/xP9UEADU8OM
        shIMCqxRq2qjjBdGQb3CoviccpXAcRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cj4kVpKPycOnuk0PSnAEX3PBDOqTT9BbDloAvvcIDuk=;
        b=Atr9xTc9QFkEzzPpvkjiqfww7dypbhe9YA41waabl7gEB7OF3DJGm/ADhonEITwQ2DkOm9
        IKGNqVZTXusw1iCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BC68138EE;
        Mon, 14 Aug 2023 11:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QADpHEYW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:50 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/25] ALSA: rme9652: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:11 +0200
Message-Id: <20230814115523.15279-14-tiwai@suse.de>
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

This patch converts the rme9652 driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/rme9652.c | 46 +++++--------------------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index e7c320afefe8..fb01d9c4247b 100644
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
+	if (!copy_from_iter(channel_buf + pos, count, src))
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
+	if (!copy_to_iter(channel_buf + pos, count, dst))
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

