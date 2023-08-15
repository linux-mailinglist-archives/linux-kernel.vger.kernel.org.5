Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80FD77D2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbjHOTDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 15:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbjHOTC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:02:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7A2133
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 12:02:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC8291FD70;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692126110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62EgIloqhA+hcLk/4OBOeWiYMDU41CiAUCQbyVwWNP0=;
        b=tal2WdM3yUfMr2BHj04XTNgYz0GkxkaYuAo8LQnwHU8DfOOy84eaQZq4LNe3mGepqw0Tlb
        PZOKVO3N02i4i7dn7l/VO7QXw1KM+rCL4HH4ys36AlFBiHY/ypa7SeXsDHQCEKaEndB+4F
        ydHQ3YIQNiSWZx1aq2uazDIHR/EmYaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692126110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62EgIloqhA+hcLk/4OBOeWiYMDU41CiAUCQbyVwWNP0=;
        b=lwscZ13Wsg2Jj270Y2Bv2EJPxhgDy86ZgM+fteNNw5OOGvx9Z4f3TIom9WWB4iCYAxA2L7
        xYFEh9LQvDkSr4Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9871D1353E;
        Tue, 15 Aug 2023 19:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oGIpJJ7L22QTVAAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 15 Aug 2023 19:01:50 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v2 22/25] ASoC: dmaengine: Use iov_iter for process callback, too
Date:   Tue, 15 Aug 2023 21:01:33 +0200
Message-Id: <20230815190136.8987-23-tiwai@suse.de>
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

Along with the conversion to PCM copy ops, use the iov_iter for the
pointer to be passed to the dmaengine process callback, too.  It
avoids the direct reference of iter_iov_addr(), and it can potentially
help for the drivers to access memory properly (although both atmel
and stm drivers don't use the given buffer address at all for now).

Reviewed-by: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/dmaengine_pcm.h         | 2 +-
 sound/soc/atmel/mchp-pdmc.c           | 2 +-
 sound/soc/soc-generic-dmaengine-pcm.c | 5 ++---
 sound/soc/stm/stm32_sai_sub.c         | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2df54cf02cb3..c9a8bce9a785 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -142,7 +142,7 @@ struct snd_dmaengine_pcm_config {
 			struct snd_pcm_substream *substream);
 	int (*process)(struct snd_pcm_substream *substream,
 		       int channel, unsigned long hwoff,
-		       void *buf, unsigned long bytes);
+		       struct iov_iter *buf, unsigned long bytes);
 	dma_filter_fn compat_filter_fn;
 	struct device *dma_dev;
 	const char *chan_names[SNDRV_PCM_STREAM_LAST + 1];
diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index c79c73e6791e..b3afcf25b4a9 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -962,7 +962,7 @@ static int mchp_pdmc_dt_init(struct mchp_pdmc *dd)
 /* used to clean the channel index found on RHR's MSB */
 static int mchp_pdmc_process(struct snd_pcm_substream *substream,
 			     int channel, unsigned long hwoff,
-			     void *buf, unsigned long bytes)
+			     struct iov_iter *buf, unsigned long bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	u8 *dma_ptr = runtime->dma_area + hwoff +
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index f2cb75781566..ff2166525dbc 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -296,18 +296,17 @@ static int dmaengine_copy(struct snd_soc_component *component,
 	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	int (*process)(struct snd_pcm_substream *substream,
 		       int channel, unsigned long hwoff,
-		       void *buf, unsigned long bytes) = pcm->config->process;
+		       struct iov_iter *buf, unsigned long bytes) = pcm->config->process;
 	bool is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	void *dma_ptr = runtime->dma_area + hwoff +
 			channel * (runtime->dma_bytes / runtime->channels);
-	void *ptr = (void __force *)iter_iov_addr(buf);
 
 	if (is_playback)
 		if (copy_from_iter(dma_ptr, bytes, buf) != bytes)
 			return -EFAULT;
 
 	if (process) {
-		int ret = process(substream, channel, hwoff, ptr, bytes);
+		int ret = process(substream, channel, hwoff, buf, bytes);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 271ec5b3378d..39f9b4654fa2 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1233,7 +1233,7 @@ static const struct snd_soc_dai_ops stm32_sai_pcm_dai_ops = {
 
 static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
 				       int channel, unsigned long hwoff,
-				       void *buf, unsigned long bytes)
+				       struct iov_iter *buf, unsigned long bytes)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-- 
2.35.3

