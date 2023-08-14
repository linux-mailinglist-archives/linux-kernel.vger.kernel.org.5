Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22CB77B7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjHNL5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjHNL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B610FB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 415F22199B;
        Mon, 14 Aug 2023 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfwP6oZUs8EGVLwkqju+PtJRX1CinD3ct3lzUDwZEgk=;
        b=SZSjrG9vuq9kIRCPQTxzwMV05MGcjPpYLVa9Ky4I69ukqgy3eFqGVFAlWGll/hBJQTIJQ+
        cl75/uIZxsaizW7PUa6livgluXpeiTzGp3aSkd9+XwAEHCT9hAyNQ+sUTGX0i8qO4jBlq4
        8JlJjUfT5xa8gRLpitKNThGBaYnoIoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfwP6oZUs8EGVLwkqju+PtJRX1CinD3ct3lzUDwZEgk=;
        b=SxbC5mE+qcKRiJ2tf77kKljLrAyXh+pXGWxIuBs/iHZedKMt0JIsfkeGToRyka5tDib1m0
        cJaFJFWmkfrKCiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BE9F138EE;
        Mon, 14 Aug 2023 11:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OODDBUIW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:46 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/25] ALSA: gus: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:03 +0200
Message-Id: <20230814115523.15279-6-tiwai@suse.de>
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

This patch converts the GUS driver code to use the new unified PCM
copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/gus/gus_pcm.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 388db5fb65bd..f67b53612d5f 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -369,7 +369,7 @@ static int playback_copy_ack(struct snd_pcm_substream *substream,
 
 static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
 				     int voice, unsigned long pos,
-				     void __user *src, unsigned long count)
+				     struct iov_iter *src, unsigned long count)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct gus_pcm_private *pcmp = runtime->private_data;
@@ -379,27 +379,11 @@ static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
 	bpos = get_bpos(pcmp, voice, pos, len);
 	if (bpos < 0)
 		return pos;
-	if (copy_from_user(runtime->dma_area + bpos, src, len))
+	if (!copy_from_iter(runtime->dma_area + bpos, len, src))
 		return -EFAULT;
 	return playback_copy_ack(substream, bpos, len);
 }
 
-static int snd_gf1_pcm_playback_copy_kernel(struct snd_pcm_substream *substream,
-					    int voice, unsigned long pos,
-					    void *src, unsigned long count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct gus_pcm_private *pcmp = runtime->private_data;
-	unsigned int len = count;
-	int bpos;
-
-	bpos = get_bpos(pcmp, voice, pos, len);
-	if (bpos < 0)
-		return pos;
-	memcpy(runtime->dma_area + bpos, src, len);
-	return playback_copy_ack(substream, bpos, len);
-}
-
 static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
 					int voice, unsigned long pos,
 					unsigned long count)
@@ -830,8 +814,7 @@ static const struct snd_pcm_ops snd_gf1_pcm_playback_ops = {
 	.prepare =	snd_gf1_pcm_playback_prepare,
 	.trigger =	snd_gf1_pcm_playback_trigger,
 	.pointer =	snd_gf1_pcm_playback_pointer,
-	.copy_user =	snd_gf1_pcm_playback_copy,
-	.copy_kernel =	snd_gf1_pcm_playback_copy_kernel,
+	.copy =		snd_gf1_pcm_playback_copy,
 	.fill_silence =	snd_gf1_pcm_playback_silence,
 };
 
-- 
2.35.3

