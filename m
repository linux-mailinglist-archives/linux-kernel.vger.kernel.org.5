Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2DA77B7F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjHNL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjHNL4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E417171B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F6FF2199E;
        Mon, 14 Aug 2023 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmpMqv9W8iYfflO8sQaY3lJwfHw1dyMQl8ItqzCOPcc=;
        b=bvGEUTw2CwAiDiv1mgn4AyDtJvCWFDa3fwh51fjpT5Yi/rUSz12wE7/bFx9mRXXK6cpO1t
        z236YYDoriOvfCDEGBigeaFIoT9I1YGec9wIDRtvKjR23/Bl2Wb3d6s8oDSZ9RcvLAP8K/
        PMMJWTu4OzFnQ46w85ppmthkI2TACeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmpMqv9W8iYfflO8sQaY3lJwfHw1dyMQl8ItqzCOPcc=;
        b=GfwwALyrad6hFArGHYPP9TVCTSawZpjZ1OVB2Kr/WdQwh25KElC4La+sY6rJN3iTz61kZJ
        3d7303dUOScDtfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E8B138EE;
        Mon, 14 Aug 2023 11:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2ModOkQW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:48 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/25] ALSA: rme32: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:08 +0200
Message-Id: <20230814115523.15279-11-tiwai@suse.de>
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

This patch converts the rme32 driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme32.c | 50 +++++++++++------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 9c0ac025e143..02144bbee6d5 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -252,48 +252,24 @@ static int snd_rme32_playback_silence(struct snd_pcm_substream *substream,
 /* copy callback for halfduplex mode */
 static int snd_rme32_playback_copy(struct snd_pcm_substream *substream,
 				   int channel, unsigned long pos,
-				   void __user *src, unsigned long count)
+				   struct iov_iter *src, unsigned long count)
 {
 	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
 
-	if (copy_from_user_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
-				src, count))
-		return -EFAULT;
-	return 0;
-}
-
-static int snd_rme32_playback_copy_kernel(struct snd_pcm_substream *substream,
-					  int channel, unsigned long pos,
-					  void *src, unsigned long count)
-{
-	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
-
-	memcpy_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos, src, count);
-	return 0;
+	return copy_from_iter_toio(rme32->iobase + RME32_IO_DATA_BUFFER + pos,
+				   src, count);
 }
 
 /* copy callback for halfduplex mode */
 static int snd_rme32_capture_copy(struct snd_pcm_substream *substream,
 				  int channel, unsigned long pos,
-				  void __user *dst, unsigned long count)
+				  struct iov_iter *dst, unsigned long count)
 {
 	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
 
-	if (copy_to_user_fromio(dst,
-			    rme32->iobase + RME32_IO_DATA_BUFFER + pos,
-			    count))
-		return -EFAULT;
-	return 0;
-}
-
-static int snd_rme32_capture_copy_kernel(struct snd_pcm_substream *substream,
-					 int channel, unsigned long pos,
-					 void *dst, unsigned long count)
-{
-	struct rme32 *rme32 = snd_pcm_substream_chip(substream);
-
-	memcpy_fromio(dst, rme32->iobase + RME32_IO_DATA_BUFFER + pos, count);
-	return 0;
+	return copy_to_iter_fromio(dst,
+				   rme32->iobase + RME32_IO_DATA_BUFFER + pos,
+				   count);
 }
 
 /*
@@ -1194,8 +1170,7 @@ static const struct snd_pcm_ops snd_rme32_playback_spdif_ops = {
 	.prepare =	snd_rme32_playback_prepare,
 	.trigger =	snd_rme32_pcm_trigger,
 	.pointer =	snd_rme32_playback_pointer,
-	.copy_user =	snd_rme32_playback_copy,
-	.copy_kernel =	snd_rme32_playback_copy_kernel,
+	.copy =		snd_rme32_playback_copy,
 	.fill_silence =	snd_rme32_playback_silence,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
@@ -1207,8 +1182,7 @@ static const struct snd_pcm_ops snd_rme32_capture_spdif_ops = {
 	.prepare =	snd_rme32_capture_prepare,
 	.trigger =	snd_rme32_pcm_trigger,
 	.pointer =	snd_rme32_capture_pointer,
-	.copy_user =	snd_rme32_capture_copy,
-	.copy_kernel =	snd_rme32_capture_copy_kernel,
+	.copy =		snd_rme32_capture_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
@@ -1219,8 +1193,7 @@ static const struct snd_pcm_ops snd_rme32_playback_adat_ops = {
 	.prepare =	snd_rme32_playback_prepare,
 	.trigger =	snd_rme32_pcm_trigger,
 	.pointer =	snd_rme32_playback_pointer,
-	.copy_user =	snd_rme32_playback_copy,
-	.copy_kernel =	snd_rme32_playback_copy_kernel,
+	.copy =		snd_rme32_playback_copy,
 	.fill_silence =	snd_rme32_playback_silence,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
@@ -1232,8 +1205,7 @@ static const struct snd_pcm_ops snd_rme32_capture_adat_ops = {
 	.prepare =	snd_rme32_capture_prepare,
 	.trigger =	snd_rme32_pcm_trigger,
 	.pointer =	snd_rme32_capture_pointer,
-	.copy_user =	snd_rme32_capture_copy,
-	.copy_kernel =	snd_rme32_capture_copy_kernel,
+	.copy =		snd_rme32_capture_copy,
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
 
-- 
2.35.3

