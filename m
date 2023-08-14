Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776F77B802
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjHNL52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjHNL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364D2199C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 696A5219A5;
        Mon, 14 Aug 2023 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kBlXlO3k9TYLm10sfgPBIo4Z29pR8vXrC5WvGNK3gs=;
        b=c63LSxmFjrWSASG/l9fIfUS+bfD6dRdST4AHcprrFusZUBa2QAvMDJk76lSXLhGU/GMRYf
        HtP96nCwz/zv4fwIamzzehA7QUu3gp7WBkiGcQFbj9yIOtIrL8XajflWvthSWopo4O33SB
        vVx1fAfNJT95KdX08rr9pqQ0puTqsZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kBlXlO3k9TYLm10sfgPBIo4Z29pR8vXrC5WvGNK3gs=;
        b=sbS1op/ULOfPB0jtEZxsBjBRKr9m5ijmQIK4zk49jgl4tl0jffnK7xX+93QHB7JmQM32FC
        5oe6mXkUYDrZdPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FE75138EE;
        Mon, 14 Aug 2023 11:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iCS4DksW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:55 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 21/25] ASoC: dmaengine: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:19 +0200
Message-Id: <20230814115523.15279-22-tiwai@suse.de>
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

This patch converts the ASoC dmaenging driver code to use the new
unified PCM copy callback.  It's a straightforward conversion from
*_user() to *_iter() variants.

The process callback is still using the direct pointer as of now, but
it'll be converted in the next patch.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 3b99f619e37e..1a4f000fddb9 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -287,10 +287,10 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 		return snd_dmaengine_pcm_pointer(substream);
 }
 
-static int dmaengine_copy_user(struct snd_soc_component *component,
-			       struct snd_pcm_substream *substream,
-			       int channel, unsigned long hwoff,
-			       void __user *buf, unsigned long bytes)
+static int dmaengine_copy(struct snd_soc_component *component,
+			  struct snd_pcm_substream *substream,
+			  int channel, unsigned long hwoff,
+			  struct iov_iter *buf, unsigned long bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
@@ -300,19 +300,20 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 	bool is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	void *dma_ptr = runtime->dma_area + hwoff +
 			channel * (runtime->dma_bytes / runtime->channels);
+	void *ptr = (void __force *)iter_iov_addr(buf);
 
 	if (is_playback)
-		if (copy_from_user(dma_ptr, buf, bytes))
+		if (!copy_from_iter(dma_ptr, bytes, buf))
 			return -EFAULT;
 
 	if (process) {
-		int ret = process(substream, channel, hwoff, (__force void *)buf, bytes);
+		int ret = process(substream, channel, hwoff, ptr, bytes);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (!is_playback)
-		if (copy_to_user(buf, dma_ptr, bytes))
+		if (!copy_to_iter(dma_ptr, bytes, buf))
 			return -EFAULT;
 
 	return 0;
@@ -337,7 +338,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.hw_params	= dmaengine_pcm_hw_params,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
-	.copy_user	= dmaengine_copy_user,
+	.copy		= dmaengine_copy,
 	.pcm_construct	= dmaengine_pcm_new,
 };
 
-- 
2.35.3

