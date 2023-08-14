Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4E77B7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjHNL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjHNL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75CB1BC0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D7042199D;
        Mon, 14 Aug 2023 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXAHJRwwxBIt7oVQ3DFUfAfiPC2QJZm/gnznxANKuWo=;
        b=q6j8Sq+VuyZys5UA0A+j6C5kCPnT4mGjXLFJRxtq/sH3xg9efqGZG+fFwdiDQ4+PDgLI7N
        aUhHS2KD4Mioaeh+AOpVWDjAgFxFFeldZR6aU70n9plwVIZ0AG7sNU209wSnNvBla7JYYo
        ln5D63KYlS0X3EjYd6ZTgXIN00ZdZIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014147;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXAHJRwwxBIt7oVQ3DFUfAfiPC2QJZm/gnznxANKuWo=;
        b=tUyIg3Kohe4ZFcN1TosjJxVdIVr2mKiEbLr02YxsFC3rX+gWFswQ1a1mreCDqqRhlSS40b
        YVYI+jOIQnZTGoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A7EB138EE;
        Mon, 14 Aug 2023 11:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iDj8EEMW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:47 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/25] ALSA: es1938: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:05 +0200
Message-Id: <20230814115523.15279-8-tiwai@suse.de>
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

This patch converts the es1938 driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants in most parts.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1938.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index e34ec6f89e7e..9e28e9fecd2a 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -824,7 +824,7 @@ static snd_pcm_uframes_t snd_es1938_playback_pointer(struct snd_pcm_substream *s
 
 static int snd_es1938_capture_copy(struct snd_pcm_substream *substream,
 				   int channel, unsigned long pos,
-				   void __user *dst, unsigned long count)
+				   struct iov_iter *dst, unsigned long count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1938 *chip = snd_pcm_substream_chip(substream);
@@ -832,36 +832,17 @@ static int snd_es1938_capture_copy(struct snd_pcm_substream *substream,
 	if (snd_BUG_ON(pos + count > chip->dma1_size))
 		return -EINVAL;
 	if (pos + count < chip->dma1_size) {
-		if (copy_to_user(dst, runtime->dma_area + pos + 1, count))
+		if (!copy_to_iter(runtime->dma_area + pos + 1, count, dst))
 			return -EFAULT;
 	} else {
-		if (copy_to_user(dst, runtime->dma_area + pos + 1, count - 1))
+		if (!copy_to_iter(runtime->dma_area + pos + 1, count - 1, dst))
 			return -EFAULT;
-		if (put_user(runtime->dma_area[0],
-			     ((unsigned char __user *)dst) + count - 1))
+		if (!copy_to_iter(runtime->dma_area, 1, dst))
 			return -EFAULT;
 	}
 	return 0;
 }
 
-static int snd_es1938_capture_copy_kernel(struct snd_pcm_substream *substream,
-					  int channel, unsigned long pos,
-					  void *dst, unsigned long count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct es1938 *chip = snd_pcm_substream_chip(substream);
-
-	if (snd_BUG_ON(pos + count > chip->dma1_size))
-		return -EINVAL;
-	if (pos + count < chip->dma1_size) {
-		memcpy(dst, runtime->dma_area + pos + 1, count);
-	} else {
-		memcpy(dst, runtime->dma_area + pos + 1, count - 1);
-		runtime->dma_area[0] = *((unsigned char *)dst + count - 1);
-	}
-	return 0;
-}
-
 /* ----------------------------------------------------------------------
  * Audio1 Capture (ADC)
  * ----------------------------------------------------------------------*/
@@ -987,8 +968,7 @@ static const struct snd_pcm_ops snd_es1938_capture_ops = {
 	.prepare =	snd_es1938_capture_prepare,
 	.trigger =	snd_es1938_capture_trigger,
 	.pointer =	snd_es1938_capture_pointer,
-	.copy_user =	snd_es1938_capture_copy,
-	.copy_kernel =	snd_es1938_capture_copy_kernel,
+	.copy =		snd_es1938_capture_copy,
 };
 
 static int snd_es1938_new_pcm(struct es1938 *chip, int device)
-- 
2.35.3

