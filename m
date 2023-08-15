Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17F77D2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjHOTDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbjHOTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:03:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300B21FD4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6744B1FD6F;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KZcjZJEL1AUmZfArsYWETPc96FRe6MC2Sdf2yaw4uU=;
        b=0C0PMJTlr/UvmiwxiiCfTrWVk2r3ILdwphrfgHX+RWaEVZa1CCzLADXJ+VKhaeLAw+CbgL
        PQBJ0vF326cSBCB4ByN0Bx13jCgQSmX0Tz+3mu0Ff+PQ7UlOeoUd0QvvtTtq2ntUBM4N7R
        dIlmEzmnYHf7q+pq+guUZH1Ovq8cc40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KZcjZJEL1AUmZfArsYWETPc96FRe6MC2Sdf2yaw4uU=;
        b=v+T/Kwjg9tmLlOfOkpi/rf0WgCWsA20OpT2+xEfMPeGw4LU4QdfheMVTb1n0sTd/Y0E+yU
        irzyxYs4lkotHvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D5401353E;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yMIRDp7L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:50 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>
Subject: [PATCH v2 20/25] ASoC: qcom: Convert to generic PCM copy ops
Date:   Tue, 15 Aug 2023 21:01:31 +0200
Message-Id: <20230815190136.8987-21-tiwai@suse.de>
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

This patch converts the qcom lpass driver code to use the new unified
PCM copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is adjusted accordingly.

Reviewed-by: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/qcom/lpass-platform.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index ef5cb40b2d9b..990d7c33f90f 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -1219,7 +1219,8 @@ static int lpass_platform_pcmops_resume(struct snd_soc_component *component)
 
 static int lpass_platform_copy(struct snd_soc_component *component,
 			       struct snd_pcm_substream *substream, int channel,
-			       unsigned long pos, void __user *buf, unsigned long bytes)
+			       unsigned long pos, struct iov_iter *buf,
+			       unsigned long bytes)
 {
 	struct snd_pcm_runtime *rt = substream->runtime;
 	unsigned int dai_id = component->id;
@@ -1230,16 +1231,16 @@ static int lpass_platform_copy(struct snd_soc_component *component,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (is_cdc_dma_port(dai_id)) {
-			ret = copy_from_user_toio(dma_buf, buf, bytes);
+			ret = copy_from_iter_toio(dma_buf, buf, bytes);
 		} else {
-			if (copy_from_user((void __force *)dma_buf, buf, bytes))
+			if (copy_from_iter((void __force *)dma_buf, bytes, buf) != bytes)
 				ret = -EFAULT;
 		}
 	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		if (is_cdc_dma_port(dai_id)) {
-			ret = copy_to_user_fromio(buf, dma_buf, bytes);
+			ret = copy_to_iter_fromio(buf, dma_buf, bytes);
 		} else {
-			if (copy_to_user(buf, (void __force *)dma_buf, bytes))
+			if (copy_to_iter((void __force *)dma_buf, bytes, buf) != bytes)
 				ret = -EFAULT;
 		}
 	}
@@ -1260,7 +1261,7 @@ static const struct snd_soc_component_driver lpass_component_driver = {
 	.pcm_construct	= lpass_platform_pcm_new,
 	.suspend		= lpass_platform_pcmops_suspend,
 	.resume			= lpass_platform_pcmops_resume,
-	.copy_user		= lpass_platform_copy,
+	.copy		= lpass_platform_copy,
 
 };
 
-- 
2.35.3

