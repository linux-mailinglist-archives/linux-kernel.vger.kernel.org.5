Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89077B803
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjHNL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjHNL4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471D1995
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7937219A1;
        Mon, 14 Aug 2023 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzlxAU1XSkzR3XPjbJVOWpV2hz5S7Z3vbPhCeirTcv4=;
        b=quiF4tq/eE5i+5CxgUSEBXtEQkYHSLt2QDgJPiFJpiau4p1G2BsMfcBFSHBTY9fTHYmo73
        U6alWrXa3GIQej/g1COubPoXKecXeFaOGkpFDLdjuv/3Y9kQSbx/hDlFAhi7HlK2brgzq1
        2PtNesfj+OeWGqgZl4h4vhPOQuvOwJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014151;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzlxAU1XSkzR3XPjbJVOWpV2hz5S7Z3vbPhCeirTcv4=;
        b=4cxNHhcBpU4rDaUthyZ/Fc6HCW2HJ78Nzov/mMICTpF1A0gqlWDJgi9VOgn89ABwPnzPRi
        hyIYNuAUp2PBZZAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAF42138EE;
        Mon, 14 Aug 2023 11:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qC3jKEcW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:51 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 15/25] ALSA: xen: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:13 +0200
Message-Id: <20230814115523.15279-16-tiwai@suse.de>
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

This patch converts the xen frontend driver code to use the new
unified PCM copy callback.  It's a straightforward conversion from
*_user() to *_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/xen/xen_snd_front_alsa.c | 55 +++++++---------------------------
 1 file changed, 10 insertions(+), 45 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index db917453a473..363351bff264 100644
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
+	if (!copy_from_iter(stream->buffer + pos, count, src))
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
@@ -645,29 +631,10 @@ static int alsa_cap_copy_user(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	return copy_to_user(dst, stream->buffer + pos, count) ?
+	return !copy_to_iter(stream->buffer + pos, count, dst) ?
 		-EFAULT : 0;
 }
 
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
-	return 0;
-}
-
 static int alsa_pb_fill_silence(struct snd_pcm_substream *substream,
 				int channel, unsigned long pos,
 				unsigned long count)
@@ -697,8 +664,7 @@ static const struct snd_pcm_ops snd_drv_alsa_playback_ops = {
 	.prepare	= alsa_prepare,
 	.trigger	= alsa_trigger,
 	.pointer	= alsa_pointer,
-	.copy_user	= alsa_pb_copy_user,
-	.copy_kernel	= alsa_pb_copy_kernel,
+	.copy		= alsa_pb_copy,
 	.fill_silence	= alsa_pb_fill_silence,
 };
 
@@ -710,8 +676,7 @@ static const struct snd_pcm_ops snd_drv_alsa_capture_ops = {
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

