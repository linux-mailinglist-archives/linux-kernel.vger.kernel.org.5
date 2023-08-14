Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0A77B7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjHNL4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjHNL4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B3719A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2604A21999;
        Mon, 14 Aug 2023 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjigMRXLLwFiO9MVxJuREvNKaLKvWTiGPYNpYq6YtnM=;
        b=vI3AtIo7QqzcfTCjEfuewVnjhZaljIeMMEPzIAkYAY5biza01E4+r56FXxYkCXIskGewGQ
        WqHpyUNdC8tW3zJVAtekGh033u0TFcuqTRodFw5cR0YSUUfUD9F5LlyLo49AGE52rTYhDF
        M/Lbo3u8DD8+YvxV0iz6NpPVWOFgpPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014144;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjigMRXLLwFiO9MVxJuREvNKaLKvWTiGPYNpYq6YtnM=;
        b=Y10qq8KhM3fcZxJwRRXm0Fe0PHJz2b6zETO8DuKZkAgeibshowl/1PEra2vn3H26Yhm3Rh
        eEHAK3KAix1dYcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04957138EE;
        Mon, 14 Aug 2023 11:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mB5YAEAW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:44 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/25] ALSA: pcm: Add copy ops with iov_iter
Date:   Mon, 14 Aug 2023 13:55:00 +0200
Message-Id: <20230814115523.15279-3-tiwai@suse.de>
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

iov_iter is a universal interface to copy the data chunk from/to
user-space and kernel in a unified manner.  This API can fit for ALSA
PCM copy ops, too; we had to split to copy_user and copy_kernel in the
past, and those can be unified to a single ops with iov_iter.

This patch adds a new PCM copy ops that passes iov_iter for copying
both kernel and user-space in the same way.  This patch touches only
the ALSA PCM core part, and the actual users will be replaced in the
following patches.

The expansion of iov_iter is done in the PCM core right before calling
each copy callback.  It's a bit suboptimal, but I took this now as
it's the most straightforward replacement.  The more conversion to
iov_iter in the caller side is a TODO for future.

As of now, the old copy_user and copy_kernel ops are still kept.
Once after all users are converted, we'll drop the old copy_user and
copy_kernel ops, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     |   3 ++
 sound/core/pcm_lib.c    | 111 ++++++++++++++++++++++++----------------
 sound/core/pcm_native.c |   2 +-
 3 files changed, 71 insertions(+), 45 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 19f564606ac4..ff4a0c1c93a2 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/pm_qos.h>
 #include <linux/refcount.h>
+#include <linux/uio.h>
 
 #define snd_pcm_substream_chip(substream) ((substream)->private_data)
 #define snd_pcm_chip(pcm) ((pcm)->private_data)
@@ -68,6 +69,8 @@ struct snd_pcm_ops {
 			struct snd_pcm_audio_tstamp_report *audio_tstamp_report);
 	int (*fill_silence)(struct snd_pcm_substream *substream, int channel,
 			    unsigned long pos, unsigned long bytes);
+	int (*copy)(struct snd_pcm_substream *substream, int channel,
+		    unsigned long pos, struct iov_iter *iter, unsigned long bytes);
 	int (*copy_user)(struct snd_pcm_substream *substream, int channel,
 			 unsigned long pos, void __user *buf,
 			 unsigned long bytes);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9c121a921b04..3303914c58ea 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1973,10 +1973,11 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 	
 typedef int (*pcm_transfer_f)(struct snd_pcm_substream *substream,
 			      int channel, unsigned long hwoff,
-			      void *buf, unsigned long bytes);
+			      struct iov_iter *iter, unsigned long bytes);
 
 typedef int (*pcm_copy_f)(struct snd_pcm_substream *, snd_pcm_uframes_t, void *,
-			  snd_pcm_uframes_t, snd_pcm_uframes_t, pcm_transfer_f);
+			  snd_pcm_uframes_t, snd_pcm_uframes_t, pcm_transfer_f,
+			  bool);
 
 /* calculate the target DMA-buffer position to be written/read */
 static void *get_dma_ptr(struct snd_pcm_runtime *runtime,
@@ -1986,32 +1987,24 @@ static void *get_dma_ptr(struct snd_pcm_runtime *runtime,
 		channel * (runtime->dma_bytes / runtime->channels);
 }
 
-/* default copy_user ops for write; used for both interleaved and non- modes */
+/* default copy ops for write; used for both interleaved and non- modes */
 static int default_write_copy(struct snd_pcm_substream *substream,
 			      int channel, unsigned long hwoff,
-			      void *buf, unsigned long bytes)
+			      struct iov_iter *iter, unsigned long bytes)
 {
-	if (copy_from_user(get_dma_ptr(substream->runtime, channel, hwoff),
-			   (void __user *)buf, bytes))
+	if (!copy_from_iter(get_dma_ptr(substream->runtime, channel, hwoff),
+			    bytes, iter))
 		return -EFAULT;
 	return 0;
 }
 
-/* default copy_kernel ops for write */
-static int default_write_copy_kernel(struct snd_pcm_substream *substream,
-				     int channel, unsigned long hwoff,
-				     void *buf, unsigned long bytes)
-{
-	memcpy(get_dma_ptr(substream->runtime, channel, hwoff), buf, bytes);
-	return 0;
-}
-
 /* fill silence instead of copy data; called as a transfer helper
  * from __snd_pcm_lib_write() or directly from noninterleaved_copy() when
  * a NULL buffer is passed
  */
 static int fill_silence(struct snd_pcm_substream *substream, int channel,
-			unsigned long hwoff, void *buf, unsigned long bytes)
+			unsigned long hwoff, struct iov_iter *iter,
+			unsigned long bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -2027,25 +2020,54 @@ static int fill_silence(struct snd_pcm_substream *substream, int channel,
 	return 0;
 }
 
-/* default copy_user ops for read; used for both interleaved and non- modes */
+/* default copy ops for read; used for both interleaved and non- modes */
 static int default_read_copy(struct snd_pcm_substream *substream,
 			     int channel, unsigned long hwoff,
-			     void *buf, unsigned long bytes)
+			     struct iov_iter *iter, unsigned long bytes)
 {
-	if (copy_to_user((void __user *)buf,
-			 get_dma_ptr(substream->runtime, channel, hwoff),
-			 bytes))
+	if (!copy_to_iter(get_dma_ptr(substream->runtime, channel, hwoff),
+			  bytes, iter))
 		return -EFAULT;
 	return 0;
 }
 
-/* default copy_kernel ops for read */
-static int default_read_copy_kernel(struct snd_pcm_substream *substream,
-				    int channel, unsigned long hwoff,
-				    void *buf, unsigned long bytes)
+/* a wrapper for calling old copy_kernel or copy_user ops */
+static int call_old_copy(struct snd_pcm_substream *substream,
+			 int channel, unsigned long hwoff,
+			 struct iov_iter *iter, unsigned long bytes)
 {
-	memcpy(buf, get_dma_ptr(substream->runtime, channel, hwoff), bytes);
-	return 0;
+	if (iov_iter_is_kvec(iter))
+		return substream->ops->copy_kernel(substream, channel, hwoff,
+						   iter_iov_addr(iter), bytes);
+	else
+		return substream->ops->copy_user(substream, channel, hwoff,
+						 iter_iov_addr(iter), bytes);
+}
+
+/* call transfer with the filled iov_iter */
+static int do_transfer(struct snd_pcm_substream *substream, int c,
+		       unsigned long hwoff, void *data, unsigned long bytes,
+		       pcm_transfer_f transfer, bool in_kernel)
+{
+	struct iov_iter iter;
+	int err, type;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		type = ITER_SOURCE;
+	else
+		type = ITER_DEST;
+
+	if (in_kernel) {
+		struct kvec kvec = { data, bytes };
+
+		iov_iter_kvec(&iter, type, &kvec, 1, bytes);
+		return transfer(substream, c, hwoff, &iter, bytes);
+	}
+
+	err = import_ubuf(type, (__force void __user *)data, bytes, &iter);
+	if (err)
+		return err;
+	return transfer(substream, c, hwoff, &iter, bytes);
 }
 
 /* call transfer function with the converted pointers and sizes;
@@ -2055,7 +2077,8 @@ static int interleaved_copy(struct snd_pcm_substream *substream,
 			    snd_pcm_uframes_t hwoff, void *data,
 			    snd_pcm_uframes_t off,
 			    snd_pcm_uframes_t frames,
-			    pcm_transfer_f transfer)
+			    pcm_transfer_f transfer,
+			    bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -2063,7 +2086,9 @@ static int interleaved_copy(struct snd_pcm_substream *substream,
 	hwoff = frames_to_bytes(runtime, hwoff);
 	off = frames_to_bytes(runtime, off);
 	frames = frames_to_bytes(runtime, frames);
-	return transfer(substream, 0, hwoff, data + off, frames);
+
+	return do_transfer(substream, 0, hwoff, data + off, frames, transfer,
+			   in_kernel);
 }
 
 /* call transfer function with the converted pointers and sizes for each
@@ -2073,7 +2098,8 @@ static int noninterleaved_copy(struct snd_pcm_substream *substream,
 			       snd_pcm_uframes_t hwoff, void *data,
 			       snd_pcm_uframes_t off,
 			       snd_pcm_uframes_t frames,
-			       pcm_transfer_f transfer)
+			       pcm_transfer_f transfer,
+			       bool in_kernel)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int channels = runtime->channels;
@@ -2091,8 +2117,8 @@ static int noninterleaved_copy(struct snd_pcm_substream *substream,
 		if (!data || !*bufs)
 			err = fill_silence(substream, c, hwoff, NULL, frames);
 		else
-			err = transfer(substream, c, hwoff, *bufs + off,
-				       frames);
+			err = do_transfer(substream, c, hwoff, *bufs + off,
+					  frames, transfer, in_kernel);
 		if (err < 0)
 			return err;
 	}
@@ -2108,10 +2134,10 @@ static int fill_silence_frames(struct snd_pcm_substream *substream,
 	if (substream->runtime->access == SNDRV_PCM_ACCESS_RW_INTERLEAVED ||
 	    substream->runtime->access == SNDRV_PCM_ACCESS_MMAP_INTERLEAVED)
 		return interleaved_copy(substream, off, NULL, 0, frames,
-					fill_silence);
+					fill_silence, true);
 	else
 		return noninterleaved_copy(substream, off, NULL, 0, frames,
-					   fill_silence);
+					   fill_silence, true);
 }
 
 /* sanity-check for read/write methods */
@@ -2121,7 +2147,7 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy_user && !runtime->dma_area))
+	if (snd_BUG_ON(!substream->ops->copy && !substream->ops->copy_user && !runtime->dma_area))
 		return -EINVAL;
 	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
@@ -2226,15 +2252,12 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 			transfer = fill_silence;
 		else
 			return -EINVAL;
-	} else if (in_kernel) {
-		if (substream->ops->copy_kernel)
-			transfer = substream->ops->copy_kernel;
-		else
-			transfer = is_playback ?
-				default_write_copy_kernel : default_read_copy_kernel;
 	} else {
-		if (substream->ops->copy_user)
-			transfer = (pcm_transfer_f)substream->ops->copy_user;
+		if (substream->ops->copy)
+			transfer = substream->ops->copy;
+		else if ((in_kernel && substream->ops->copy_kernel) ||
+			 (!in_kernel && substream->ops->copy_user))
+			transfer = call_old_copy;
 		else
 			transfer = is_playback ?
 				default_write_copy : default_read_copy;
@@ -2307,7 +2330,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		if (!is_playback)
 			snd_pcm_dma_buffer_sync(substream, SNDRV_DMA_SYNC_CPU);
 		err = writer(substream, appl_ofs, data, offset, frames,
-			     transfer);
+			     transfer, in_kernel);
 		if (is_playback)
 			snd_pcm_dma_buffer_sync(substream, SNDRV_DMA_SYNC_DEVICE);
 		snd_pcm_stream_lock_irq(substream);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 95fc56e403b1..34efd4d198d6 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -809,7 +809,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		runtime->boundary *= 2;
 
 	/* clear the buffer for avoiding possible kernel info leaks */
-	if (runtime->dma_area && !substream->ops->copy_user) {
+	if (runtime->dma_area && !substream->ops->copy && !substream->ops->copy_user) {
 		size_t size = runtime->dma_bytes;
 
 		if (runtime->info & SNDRV_PCM_INFO_MMAP)
-- 
2.35.3

