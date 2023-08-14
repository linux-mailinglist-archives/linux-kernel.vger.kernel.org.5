Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF8977B7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjHNL5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjHNL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57B171D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4FBDD219A0;
        Mon, 14 Aug 2023 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sornzw8ObUuh4FueGJ820FsFvgO7TY3p6mTQ3GQIfsY=;
        b=CVrUT9XIrY3uMZzCWOFV7JlPopcREvQN2H1+iHkxvnKkDp/mT8wf7315ohwnedV3KVRLPf
        IKjrJoawVhJToAAowJJjFkoo8hsktpfD70pwJjcWwFpHplo9LGjd0fL4zpf90B2QpOAbd4
        W58VXdLcQgL10h1uk+C91eAseOWzlb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sornzw8ObUuh4FueGJ820FsFvgO7TY3p6mTQ3GQIfsY=;
        b=Y9L7oU/8UYK3IKOnphxNwmZN54/GSRtS6pvX9/QjTpmxrMkV6nQj8V27wQJrfTnYB+T9xJ
        BQZqybIE3N87BcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 237CD138EE;
        Mon, 14 Aug 2023 11:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kMPqB0cW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:51 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/25] ALSA: sh: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:12 +0200
Message-Id: <20230814115523.15279-15-tiwai@suse.de>
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

This patch converts the sh_dac_audio driver code to use the new
unified PCM copy callback.  It's a straightforward conversion from
*_user() to *_iter() variants.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/sh/sh_dac_audio.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 8cf571955c9d..95ba3abd4e47 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -158,12 +158,12 @@ static int snd_sh_dac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
 			       int channel, unsigned long pos,
-			       void __user *src, unsigned long count)
+			       struct iov_iter *src, unsigned long count)
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
 
-	if (copy_from_user_toio(chip->data_buffer + pos, src, count))
+	if (copy_from_iter_toio(chip->data_buffer + pos, src, count))
 		return -EFAULT;
 	chip->buffer_end = chip->data_buffer + pos + count;
 
@@ -175,24 +175,6 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int snd_sh_dac_pcm_copy_kernel(struct snd_pcm_substream *substream,
-				      int channel, unsigned long pos,
-				      void *src, unsigned long count)
-{
-	/* channel is not used (interleaved data) */
-	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-
-	memcpy_toio(chip->data_buffer + pos, src, count);
-	chip->buffer_end = chip->data_buffer + pos + count;
-
-	if (chip->empty) {
-		chip->empty = 0;
-		dac_audio_start_timer(chip);
-	}
-
-	return 0;
-}
-
 static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
 				  int channel, unsigned long pos,
 				  unsigned long count)
@@ -227,8 +209,7 @@ static const struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.prepare	= snd_sh_dac_pcm_prepare,
 	.trigger	= snd_sh_dac_pcm_trigger,
 	.pointer	= snd_sh_dac_pcm_pointer,
-	.copy_user	= snd_sh_dac_pcm_copy,
-	.copy_kernel	= snd_sh_dac_pcm_copy_kernel,
+	.copy		= snd_sh_dac_pcm_copy,
 	.fill_silence	= snd_sh_dac_pcm_silence,
 	.mmap		= snd_pcm_lib_mmap_iomem,
 };
-- 
2.35.3

