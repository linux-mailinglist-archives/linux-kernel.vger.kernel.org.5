Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCF77D2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjHOTCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbjHOTCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB4810E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 736141FD6A;
        Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/BgMI8FuOi/5pmBMZAtt3gp913bmnjYvQcbxzOHfHE=;
        b=nhabCSKsWkx41NfRqAxKgh8FQUXjbeOAtxOYCVMoXsAyxByAjesTZHGSNbtuRbYe9rWpob
        l/pgaU9eAKtGUJ+w5zfo5Qky1TpOVwKv1YoiTfvx4KZQwdlLea7GH114OMQV9Gjib9bFB0
        9JbVbJgcn5fjiqGxhu56qkfvsNm1M/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/BgMI8FuOi/5pmBMZAtt3gp913bmnjYvQcbxzOHfHE=;
        b=+XKBo0gra+U9kLyDt5tVYGNJHRwve2LRNG7LL5QlEl7517QnhuahhelIchrFC0AdbhSepj
        n3JcgCWw5rBcIkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B7221390C;
        Tue, 15 Aug 2023 19:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wFeVEZ3L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:49 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2 15/25] ALSA: xen: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:26 +0200
Message-Id: <20230815190136.8987-16-tiwai@suse.de>
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

This patch converts the xen frontend driver code to use the new
unified PCM copy callback.  It's a straightforward conversion from
*_user() to *_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is adjusted accordingly.

Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/xen/xen_snd_front_alsa.c | 56 +++++++---------------------------
 1 file changed, 11 insertions(+), 45 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index db917453a473..bfae303633ef 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -602,38 +602,24 @@ static snd_pcm_uframes_t alsa_pointer(struct snd_pcm_substream *substream)
 	return (snd_pcm_uframes_t)atomic_read(&stream->hw_ptr);
 }
 
-static int alsa_pb_copy_user(struct snd_pcm_substream *substream,
-			     int channel, unsigned long pos, void __user *src,
-			     unsigned long count)
+static int alsa_pb_copy(struct snd_pcm_substream *substream,
+			int channel, unsigned long pos, struct iov_iter *src,
+			unsigned long count)
 {
 	struct xen_snd_front_pcm_stream_info *stream = stream_get(substream);
 
 	if (unlikely(pos + count > stream->buffer_sz))
 		return -EINVAL;
 
-	if (copy_from_user(stream->buffer + pos, src, count))
+	if (copy_from_iter(stream->buffer + pos, count, src) != count)
 		return -EFAULT;
 
 	return xen_snd_front_stream_write(&stream->evt_pair->req, pos, count);
 }
 
-static int alsa_pb_copy_kernel(struct snd_pcm_substream *substream,
-			       int channel, unsigned long pos, void *src,
-			       unsigned long count)
-{
-	struct xen_snd_front_pcm_stream_info *stream = stream_get(substream);
-
-	if (unlikely(pos + count > stream->buffer_sz))
-		return -EINVAL;
-
-	memcpy(stream->buffer + pos, src, count);
-
-	return xen_snd_front_stream_write(&stream->evt_pair->req, pos, count);
-}
-
-static int alsa_cap_copy_user(struct snd_pcm_substream *substream,
-			      int channel, unsigned long pos, void __user *dst,
-			      unsigned long count)
+static int alsa_cap_copy(struct snd_pcm_substream *substream,
+			 int channel, unsigned long pos, struct iov_iter *dst,
+			 unsigned long count)
 {
 	struct xen_snd_front_pcm_stream_info *stream = stream_get(substream);
 	int ret;
@@ -645,26 +631,8 @@ static int alsa_cap_copy_user(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	return copy_to_user(dst, stream->buffer + pos, count) ?
-		-EFAULT : 0;
-}
-
-static int alsa_cap_copy_kernel(struct snd_pcm_substream *substream,
-				int channel, unsigned long pos, void *dst,
-				unsigned long count)
-{
-	struct xen_snd_front_pcm_stream_info *stream = stream_get(substream);
-	int ret;
-
-	if (unlikely(pos + count > stream->buffer_sz))
-		return -EINVAL;
-
-	ret = xen_snd_front_stream_read(&stream->evt_pair->req, pos, count);
-	if (ret < 0)
-		return ret;
-
-	memcpy(dst, stream->buffer + pos, count);
-
+	if (copy_to_iter(stream->buffer + pos, count, dst) != count)
+		return -EFAULT;
 	return 0;
 }
 
@@ -697,8 +665,7 @@ static const struct snd_pcm_ops snd_drv_alsa_playback_ops = {
 	.prepare	= alsa_prepare,
 	.trigger	= alsa_trigger,
 	.pointer	= alsa_pointer,
-	.copy_user	= alsa_pb_copy_user,
-	.copy_kernel	= alsa_pb_copy_kernel,
+	.copy		= alsa_pb_copy,
 	.fill_silence	= alsa_pb_fill_silence,
 };
 
@@ -710,8 +677,7 @@ static const struct snd_pcm_ops snd_drv_alsa_capture_ops = {
 	.prepare	= alsa_prepare,
 	.trigger	= alsa_trigger,
 	.pointer	= alsa_pointer,
-	.copy_user	= alsa_cap_copy_user,
-	.copy_kernel	= alsa_cap_copy_kernel,
+	.copy		= alsa_cap_copy,
 };
 
 static int new_pcm_instance(struct xen_snd_front_card_info *card_info,
-- 
2.35.3

