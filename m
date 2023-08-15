Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4982277D2C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjHOTCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbjHOTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC00D2680
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:01:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC2181FD66;
        Tue, 15 Aug 2023 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmpMqv9W8iYfflO8sQaY3lJwfHw1dyMQl8ItqzCOPcc=;
        b=dQBv3Bb5S9LU7uqrz7alAy2/ZG1W5C+xSoa6dBQf1/aRdNQu1EvhAZRGQCnYiqiQlm7JEf
        AmD53OFTixKoz8fwH7wW7flEu5AeR75n0ZPRBoJSTCt3zMWWJxDByHCviQnMZFhI94DSOG
        T7XJpRWMk47M+oEtd0evepUm4rw0g4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmpMqv9W8iYfflO8sQaY3lJwfHw1dyMQl8ItqzCOPcc=;
        b=/GnCwUHag7xh2X3cOvCvmo2rLX24+ESCzhOmmqtRZmuYy6GrHNMIqDeKmphtdFzr5Y2hnM
        DYQruRmLHWh+wYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B2691353E;
        Tue, 15 Aug 2023 19:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gL0KIZzL22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:48 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 10/25] ALSA: rme32: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:21 +0200
Message-Id: <20230815190136.8987-11-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230815190136.8987-1-tiwai@suse.de>
References: <20230815190136.8987-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

