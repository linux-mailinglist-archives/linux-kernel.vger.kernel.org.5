Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1277D2D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbjHOTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbjHOTCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF232134
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86E26219A5;
        Tue, 15 Aug 2023 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xJHuvA5gT6n1i0ytgW/H7/p1r9TYXBmYRI/sH4EsE0=;
        b=quIMOGurxTUd4o7P4VgI/hdYPnbjocIKWNj2o5BIX6Q8YM0crETczGGn6AeQdjGNJWrcmv
        ndBzGg1YefBc4s+3O/ypswil0XD64jqeWFo0DhJdmQF+8Q2bHEZ6XHLMeMq9+GDLnPZ8uy
        1+TqikHpxovQk0GGZaa1Z4MeJF4FMuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xJHuvA5gT6n1i0ytgW/H7/p1r9TYXBmYRI/sH4EsE0=;
        b=kFCrXlZzwDVJxIOSXyqawncQf1HecYhqYFgTAOtXt3Qr8QOD/Pb71Rnv6W2gpvLto+qtGI
        rfc72SC+9kFfmsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65E0B1390C;
        Tue, 15 Aug 2023 19:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cNDjF5zL22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:48 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 09/25] ALSA: nm256: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:20 +0200
Message-Id: <20230815190136.8987-10-tiwai@suse.de>
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

This patch converts the nm256 driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/nm256/nm256.c | 42 ++++++-----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index f99a1e96e923..34f90829e656 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -691,26 +691,12 @@ snd_nm256_playback_silence(struct snd_pcm_substream *substream,
 static int
 snd_nm256_playback_copy(struct snd_pcm_substream *substream,
 			int channel, unsigned long pos,
-			void __user *src, unsigned long count)
+			struct iov_iter *src, unsigned long count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct nm256_stream *s = runtime->private_data;
 
-	if (copy_from_user_toio(s->bufptr + pos, src, count))
-		return -EFAULT;
-	return 0;
-}
-
-static int
-snd_nm256_playback_copy_kernel(struct snd_pcm_substream *substream,
-			       int channel, unsigned long pos,
-			       void *src, unsigned long count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct nm256_stream *s = runtime->private_data;
-
-	memcpy_toio(s->bufptr + pos, src, count);
-	return 0;
+	return copy_from_iter_toio(s->bufptr + pos, src, count);
 }
 
 /*
@@ -719,26 +705,12 @@ snd_nm256_playback_copy_kernel(struct snd_pcm_substream *substream,
 static int
 snd_nm256_capture_copy(struct snd_pcm_substream *substream,
 		       int channel, unsigned long pos,
-		       void __user *dst, unsigned long count)
+		       struct iov_iter *dst, unsigned long count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct nm256_stream *s = runtime->private_data;
 
-	if (copy_to_user_fromio(dst, s->bufptr + pos, count))
-		return -EFAULT;
-	return 0;
-}
-
-static int
-snd_nm256_capture_copy_kernel(struct snd_pcm_substream *substream,
-			      int channel, unsigned long pos,
-			      void *dst, unsigned long count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct nm256_stream *s = runtime->private_data;
-
-	memcpy_fromio(dst, s->bufptr + pos, count);
-	return 0;
+	return copy_to_iter_fromio(dst, s->bufptr + pos, count);
 }
 
 #endif /* !__i386__ */
@@ -909,8 +881,7 @@ static const struct snd_pcm_ops snd_nm256_playback_ops = {
 	.trigger =	snd_nm256_playback_trigger,
 	.pointer =	snd_nm256_playback_pointer,
 #ifndef __i386__
-	.copy_user =	snd_nm256_playback_copy,
-	.copy_kernel =	snd_nm256_playback_copy_kernel,
+	.copy =		snd_nm256_playback_copy,
 	.fill_silence =	snd_nm256_playback_silence,
 #endif
 	.mmap =		snd_pcm_lib_mmap_iomem,
@@ -924,8 +895,7 @@ static const struct snd_pcm_ops snd_nm256_capture_ops = {
 	.trigger =	snd_nm256_capture_trigger,
 	.pointer =	snd_nm256_capture_pointer,
 #ifndef __i386__
-	.copy_user =	snd_nm256_capture_copy,
-	.copy_kernel =	snd_nm256_capture_copy_kernel,
+	.copy =		snd_nm256_capture_copy,
 #endif
 	.mmap =		snd_pcm_lib_mmap_iomem,
 };
-- 
2.35.3

