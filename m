Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0F77B7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjHNL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjHNL43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73610E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A62571F7AB;
        Mon, 14 Aug 2023 11:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMyTH+n/x40PlmiWqQalwBgzt2srwvf1AihY+ppT2RY=;
        b=07lUyFsb5dTl2xHhgSqJ1E+hZf+Jig7MzmZEIyBGcaf2r5F+2q6f73t7WWK0zmMI/mhfSd
        yD0TmWX2JL2xPZg2/JgHHIyWMY8aJkyZA4zVLrEA+UwrDBOci032N4EEpN3YVMbWv3A0Rq
        EsUFjhYtimGDGd32a9yk2jSfBwNSO9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014145;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMyTH+n/x40PlmiWqQalwBgzt2srwvf1AihY+ppT2RY=;
        b=MZRl7f8oMgZvKHP6RqrJ0d6wlOLzHHbC3rqulgZ1s6paIGYioqG8Ki3vq+1NtAGjIgU6jH
        wkx4SjgsMM5FW3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 803A5138EE;
        Mon, 14 Aug 2023 11:55:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KARmHUEW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:45 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/25] ALSA: dummy: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:02 +0200
Message-Id: <20230814115523.15279-5-tiwai@suse.de>
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

This patch converts the dummy driver code to use the new unified PCM
copy callback.  As dummy driver doesn't do anything in the callback,
it's just a simple replacement.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/dummy.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 9c17b49a2ae1..4317677ba24a 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -626,14 +626,7 @@ static int alloc_fake_buffer(void)
 
 static int dummy_pcm_copy(struct snd_pcm_substream *substream,
 			  int channel, unsigned long pos,
-			  void __user *dst, unsigned long bytes)
-{
-	return 0; /* do nothing */
-}
-
-static int dummy_pcm_copy_kernel(struct snd_pcm_substream *substream,
-				 int channel, unsigned long pos,
-				 void *dst, unsigned long bytes)
+			  struct iov_iter *iter, unsigned long bytes)
 {
 	return 0; /* do nothing */
 }
@@ -667,8 +660,7 @@ static const struct snd_pcm_ops dummy_pcm_ops_no_buf = {
 	.prepare =	dummy_pcm_prepare,
 	.trigger =	dummy_pcm_trigger,
 	.pointer =	dummy_pcm_pointer,
-	.copy_user =	dummy_pcm_copy,
-	.copy_kernel =	dummy_pcm_copy_kernel,
+	.copy =		dummy_pcm_copy,
 	.fill_silence =	dummy_pcm_silence,
 	.page =		dummy_pcm_page,
 };
-- 
2.35.3

