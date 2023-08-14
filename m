Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9B77B7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHNL5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjHNL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9619BE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99A1E2199F;
        Mon, 14 Aug 2023 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjxBtA0K776P/pHFSLKAptmDdu6ejterm7BFJcjarEE=;
        b=MqkYUKC84WDh0gijsgQg5GT4ops+uhrtNgO+PUaxJh9gTyqfGkVbk6dozpItWX5TRqwaJv
        VbmN5TLs4zrL4yVyWUQaObv3zwmNgudpAEVkqptaFex4Y7PooidF73qC7B5q/9roflRL1c
        j3WZbnoAaLRTQsJWHPc4XEeedRmzRJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjxBtA0K776P/pHFSLKAptmDdu6ejterm7BFJcjarEE=;
        b=stzyMsXS3ZvNbIFzAMJllCGovy9cDi/l5ZyOEvHECSH4fBzWMGMqM9jufjE4jJ4/22eZ9r
        a9Dj6xuIobDxRPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AE86138EE;
        Mon, 14 Aug 2023 11:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IIjvHEUW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:49 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/25] ALSA: rme96: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:09 +0200
Message-Id: <20230814115523.15279-12-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814115523.15279-1-tiwai@suse.de>
References: <20230814115523.15279-1-tiwai@suse.de>
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

This patch converts the rme96 driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 42 ++++++++----------------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index bccb7e0d3d11..6b5ffb18197b 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -320,48 +320,26 @@ snd_rme96_playback_silence(struct snd_pcm_substream *substream,
 static int
 snd_rme96_playback_copy(struct snd_pcm_substream *substream,
 			int channel, unsigned long pos,
-			void __user *src, unsigned long count)
+			struct iov_iter *src, unsigned long count)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 
-	return copy_from_user_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos,
+	return copy_from_iter_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos,
 				   src, count);
 }
 
-static int
-snd_rme96_playback_copy_kernel(struct snd_pcm_substream *substream,
-			       int channel, unsigned long pos,
-			       void *src, unsigned long count)
-{
-	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-
-	memcpy_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos, src, count);
-	return 0;
-}
-
 static int
 snd_rme96_capture_copy(struct snd_pcm_substream *substream,
 		       int channel, unsigned long pos,
-		       void __user *dst, unsigned long count)
+		       struct iov_iter *dst, unsigned long count)
 {
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 
-	return copy_to_user_fromio(dst,
+	return copy_to_iter_fromio(dst,
 				   rme96->iobase + RME96_IO_REC_BUFFER + pos,
 				   count);
 }
 
-static int
-snd_rme96_capture_copy_kernel(struct snd_pcm_substream *substream,
-			      int channel, unsigned long pos,
-			      void *dst, unsigned long count)
-{
-	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
-
-	memcpy_fromio(dst, rme96->iobase + RME96_IO_REC_BUFFER + pos, count);
-	return 0;
-}
-
 /*
  * Digital output capabilities (S/PDIF)
  */
@@ -1518,8 +1496,7 @@ static const struct snd_pcm_ops snd_rme96_playback_spdif_ops = {
 	.prepare =	snd_rme96_playback_prepare,
 	.trigger =	snd_rme96_playback_trigger,
 	.pointer =	snd_rme96_playback_pointer,
-	.copy_user =	snd_rme96_playback_copy,
-	.copy_kernel =	snd_rme96_playback_copy_kernel,
+	.copy =		snd_rme96_playback_copy,
 	.fill_silence =	snd_rme96_playback_silence,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
@@ -1531,8 +1508,7 @@ static const struct snd_pcm_ops snd_rme96_capture_spdif_ops = {
 	.prepare =	snd_rme96_capture_prepare,
 	.trigger =	snd_rme96_capture_trigger,
 	.pointer =	snd_rme96_capture_pointer,
-	.copy_user =	snd_rme96_capture_copy,
-	.copy_kernel =	snd_rme96_capture_copy_kernel,
+	.copy =		snd_rme96_capture_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
@@ -1543,8 +1519,7 @@ static const struct snd_pcm_ops snd_rme96_playback_adat_ops = {
 	.prepare =	snd_rme96_playback_prepare,
 	.trigger =	snd_rme96_playback_trigger,
 	.pointer =	snd_rme96_playback_pointer,
-	.copy_user =	snd_rme96_playback_copy,
-	.copy_kernel =	snd_rme96_playback_copy_kernel,
+	.copy =		snd_rme96_playback_copy,
 	.fill_silence =	snd_rme96_playback_silence,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
@@ -1556,8 +1531,7 @@ static const struct snd_pcm_ops snd_rme96_capture_adat_ops = {
 	.prepare =	snd_rme96_capture_prepare,
 	.trigger =	snd_rme96_capture_trigger,
 	.pointer =	snd_rme96_capture_pointer,
-	.copy_user =	snd_rme96_capture_copy,
-	.copy_kernel =	snd_rme96_capture_copy_kernel,
+	.copy =		snd_rme96_capture_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-- 
2.35.3

