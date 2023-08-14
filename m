Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90777B7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjHNL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjHNL4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EED172B;
        Mon, 14 Aug 2023 04:56:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 087D51FD68;
        Mon, 14 Aug 2023 11:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBpA0w6DrKb/1Of+0w5L8SkHa3/ufUdHFdqflJp48N4=;
        b=SPsqtb2CoXPMR0jrMS52+xHv4EXWxNXAzILKJG65HzYZ5BV/T2cOFePjtb9kfsM8WEtIml
        yPnvSqfzMSgzGN9g1KiCGukoWLpI9wJfUA92iy0uT346iJ9OctRm0ihpfakCiJEUNU0Yu4
        d211u2VbDRZcx2dlX/agcQ542R5bZbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014153;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBpA0w6DrKb/1Of+0w5L8SkHa3/ufUdHFdqflJp48N4=;
        b=QNIJ50B7hL2dnU3T/YOw1ECsoezak/DFztdBbp2McwMOs8azkbPGftNYeiuwebBh5o0d+D
        nNV963S/0yeYMIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3066138EE;
        Mon, 14 Aug 2023 11:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAqyLkgW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:52 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
        Anton Sviridenko <anton@corp.bluecherry.net>,
        Andrey Utkin <andrey_utkin@fastmail.com>,
        Ismael Luceno <ismael@iodev.co.uk>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 17/25] media: solo6x10: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:15 +0200
Message-Id: <20230814115523.15279-18-tiwai@suse.de>
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

This patch converts the solo6x10 driver code to use the new unified
PCM copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.  As copy_to_iter() updates the internal offest at
each write, we can drop the dst counter update in the loop, too.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Cc: Bluecherry Maintainers <maintainers@bluecherrydvr.com>
Cc: Anton Sviridenko <anton@corp.bluecherry.net>
Cc: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: Ismael Luceno <ismael@iodev.co.uk>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/solo6x10/solo6x10-g723.c | 38 +++-------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-g723.c b/drivers/media/pci/solo6x10/solo6x10-g723.c
index 6cebad665565..aceacb822cab 100644
--- a/drivers/media/pci/solo6x10/solo6x10-g723.c
+++ b/drivers/media/pci/solo6x10/solo6x10-g723.c
@@ -204,9 +204,9 @@ static snd_pcm_uframes_t snd_solo_pcm_pointer(struct snd_pcm_substream *ss)
 	return idx * G723_FRAMES_PER_PAGE;
 }
 
-static int snd_solo_pcm_copy_user(struct snd_pcm_substream *ss, int channel,
-				  unsigned long pos, void __user *dst,
-				  unsigned long count)
+static int snd_solo_pcm_copy(struct snd_pcm_substream *ss, int channel,
+			     unsigned long pos, struct iov_iter *dst,
+			     unsigned long count)
 {
 	struct solo_snd_pcm *solo_pcm = snd_pcm_substream_chip(ss);
 	struct solo_dev *solo_dev = solo_pcm->solo_dev;
@@ -223,35 +223,8 @@ static int snd_solo_pcm_copy_user(struct snd_pcm_substream *ss, int channel,
 		if (err)
 			return err;
 
-		if (copy_to_user(dst, solo_pcm->g723_buf, G723_PERIOD_BYTES))
+		if (!copy_to_iter(solo_pcm->g723_buf, G723_PERIOD_BYTES, dst))
 			return -EFAULT;
-		dst += G723_PERIOD_BYTES;
-	}
-
-	return 0;
-}
-
-static int snd_solo_pcm_copy_kernel(struct snd_pcm_substream *ss, int channel,
-				    unsigned long pos, void *dst,
-				    unsigned long count)
-{
-	struct solo_snd_pcm *solo_pcm = snd_pcm_substream_chip(ss);
-	struct solo_dev *solo_dev = solo_pcm->solo_dev;
-	int err, i;
-
-	for (i = 0; i < (count / G723_FRAMES_PER_PAGE); i++) {
-		int page = (pos / G723_FRAMES_PER_PAGE) + i;
-
-		err = solo_p2m_dma_t(solo_dev, 0, solo_pcm->g723_dma,
-				     SOLO_G723_EXT_ADDR(solo_dev) +
-				     (page * G723_PERIOD_BLOCK) +
-				     (ss->number * G723_PERIOD_BYTES),
-				     G723_PERIOD_BYTES, 0, 0);
-		if (err)
-			return err;
-
-		memcpy(dst, solo_pcm->g723_buf, G723_PERIOD_BYTES);
-		dst += G723_PERIOD_BYTES;
 	}
 
 	return 0;
@@ -263,8 +236,7 @@ static const struct snd_pcm_ops snd_solo_pcm_ops = {
 	.prepare = snd_solo_pcm_prepare,
 	.trigger = snd_solo_pcm_trigger,
 	.pointer = snd_solo_pcm_pointer,
-	.copy_user = snd_solo_pcm_copy_user,
-	.copy_kernel = snd_solo_pcm_copy_kernel,
+	.copy = snd_solo_pcm_copy,
 };
 
 static int snd_solo_capture_volume_info(struct snd_kcontrol *kcontrol,
-- 
2.35.3

