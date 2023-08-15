Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742677D2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbjHOTDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbjHOTDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:03:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39A2680
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48A48219AE;
        Tue, 15 Aug 2023 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzfPkrsHVrap+B5JD7fqRR+3BmI5kvbs99homa/INDo=;
        b=juoT+uObn3CD0krY/i+cNkxP7QHDHI8/HrUuKScmdoZ50YMYYKJDz5tAx7miJATHux4YDw
        6zdAFTaFHzbXO7A2TwSxxG0cH7HU/BNwnnGPDeGe5ohkywxpyRykvRuDMHpzZTAnTOY+2f
        36C3K8C4jtGCZ9kQvAxvZ16xmbc8LTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzfPkrsHVrap+B5JD7fqRR+3BmI5kvbs99homa/INDo=;
        b=wc+3KYgI+GLwVih151IBlS+fSQFRm/wbGbNniZOWs9nQh/ueciFj6VekaqpydoXQhg/BiS
        rCnbCJJrtTJNpAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2893D1390C;
        Tue, 15 Aug 2023 19:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IEJCZ/L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:51 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 25/25] ALSA: pcm: Drop obsoleted PCM copy_user and copy_kernel ops
Date:   Tue, 15 Aug 2023 21:01:36 +0200
Message-Id: <20230815190136.8987-26-tiwai@suse.de>
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

Finally all users have been converted to the new PCM copy ops, let's
drop the obsoleted copy_kernel and copy_user ops completely.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     |  5 -----
 sound/core/pcm_lib.c    | 18 +-----------------
 sound/core/pcm_native.c |  2 +-
 3 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index f75beead79e3..958a0b284b5f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -71,11 +71,6 @@ struct snd_pcm_ops {
 			    unsigned long pos, unsigned long bytes);
 	int (*copy)(struct snd_pcm_substream *substream, int channel,
 		    unsigned long pos, struct iov_iter *iter, unsigned long bytes);
-	int (*copy_user)(struct snd_pcm_substream *substream, int channel,
-			 unsigned long pos, void __user *buf,
-			 unsigned long bytes);
-	int (*copy_kernel)(struct snd_pcm_substream *substream, int channel,
-			   unsigned long pos, void *buf, unsigned long bytes);
 	struct page *(*page)(struct snd_pcm_substream *substream,
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 3303914c58ea..4859fb1caec9 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2031,19 +2031,6 @@ static int default_read_copy(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* a wrapper for calling old copy_kernel or copy_user ops */
-static int call_old_copy(struct snd_pcm_substream *substream,
-			 int channel, unsigned long hwoff,
-			 struct iov_iter *iter, unsigned long bytes)
-{
-	if (iov_iter_is_kvec(iter))
-		return substream->ops->copy_kernel(substream, channel, hwoff,
-						   iter_iov_addr(iter), bytes);
-	else
-		return substream->ops->copy_user(substream, channel, hwoff,
-						 iter_iov_addr(iter), bytes);
-}
-
 /* call transfer with the filled iov_iter */
 static int do_transfer(struct snd_pcm_substream *substream, int c,
 		       unsigned long hwoff, void *data, unsigned long bytes,
@@ -2147,7 +2134,7 @@ static int pcm_sanity_check(struct snd_pcm_substream *substream)
 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;
-	if (snd_BUG_ON(!substream->ops->copy && !substream->ops->copy_user && !runtime->dma_area))
+	if (snd_BUG_ON(!substream->ops->copy && !runtime->dma_area))
 		return -EINVAL;
 	if (runtime->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
@@ -2255,9 +2242,6 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 	} else {
 		if (substream->ops->copy)
 			transfer = substream->ops->copy;
-		else if ((in_kernel && substream->ops->copy_kernel) ||
-			 (!in_kernel && substream->ops->copy_user))
-			transfer = call_old_copy;
 		else
 			transfer = is_playback ?
 				default_write_copy : default_read_copy;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 34efd4d198d6..bd9ddf412b46 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -809,7 +809,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		runtime->boundary *= 2;
 
 	/* clear the buffer for avoiding possible kernel info leaks */
-	if (runtime->dma_area && !substream->ops->copy && !substream->ops->copy_user) {
+	if (runtime->dma_area && !substream->ops->copy) {
 		size_t size = runtime->dma_bytes;
 
 		if (runtime->info & SNDRV_PCM_INFO_MMAP)
-- 
2.35.3

