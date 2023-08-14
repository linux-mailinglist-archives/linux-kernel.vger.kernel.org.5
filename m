Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07B77B808
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjHNL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjHNL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:56:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4E199F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:56:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C8F99219A4;
        Mon, 14 Aug 2023 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692014154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTvdESTc9PcredvOts1lRbqh/E0+ltHWoLxYeIHw25k=;
        b=xLHuGkceY3pDLyVyOFaW1sPguGNiznPHax4v/QjRpdOt1HI0E+qn3dFbge2paKoXgmI3FU
        CS93lORiP09/MdSG+C3dHQLtJ5YnzTEfR+tRTCECKwsL9UavkFKYH0O3FLiVhHTOHprzQA
        nbk90GXXCq6LCGI66LGzv/RUjVY3/s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692014154;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTvdESTc9PcredvOts1lRbqh/E0+ltHWoLxYeIHw25k=;
        b=IKI770GZBLchgkZhozf7bS2EtlwktddI6RPq6ms1kkyHb2/VCwe/8jCh5+clpAvna0aQih
        qzZkysbvAfTKK8Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96EAB138EE;
        Mon, 14 Aug 2023 11:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4APBI0oW2mRnMAAAMHmgww
        (envelope-from <tiwai@suse.de>); Mon, 14 Aug 2023 11:55:54 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 20/25] ASoC: qcom: Convert to generic PCM copy ops
Date:   Mon, 14 Aug 2023 13:55:18 +0200
Message-Id: <20230814115523.15279-21-tiwai@suse.de>
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

This patch converts the qcom lpass driver code to use the new unified
PCM copy callback.  It's a straightforward conversion from *_user() to
*_iter() variants.

Note that copy_from/to_iter() returns the copied bytes, hence the
error condition is inverted from copy_from/to_user().

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/qcom/lpass-platform.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index ef5cb40b2d9b..4ab6ac085b84 100644
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
+			if (!copy_from_iter((void __force *)dma_buf, bytes, buf))
 				ret = -EFAULT;
 		}
 	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		if (is_cdc_dma_port(dai_id)) {
-			ret = copy_to_user_fromio(buf, dma_buf, bytes);
+			ret = copy_to_iter_fromio(buf, dma_buf, bytes);
 		} else {
-			if (copy_to_user(buf, (void __force *)dma_buf, bytes))
+			if (!copy_to_iter((void __force *)dma_buf, bytes, buf))
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

