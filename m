Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C473C7844FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjHVPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjHVPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:06:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E381B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:06:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c66b7da88so55293f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692716777; x=1693321577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiuif0UPEilRfTqfvjhgYV9OjFsrTUZzsOgS/HAy03Q=;
        b=EK/QqDRkxi36aIi0UBd9fmgJGjMU2iJAesESNS7RXj3CU+4OgQFnmS0DRe1Pjqt3Vj
         aSNjrghPdOk8/h1SE6SKPJAzc5DqcD4+5PrMeavHJyeyp9S2zKh9XaOtlZn7mY5eYSD/
         cm7wR5jRdkxFzEfC6rjLF6OrbpWnmsYdVYAbNFkRPqOaRDPsW+L2vGKCop7uzax2TDuC
         euiDhxVc05SOEdjkhWgM5YYDIwbmQVLcQmKlNFbOLPaHYZPkGsrL6Tw3elinaF/uY5e/
         yOhAj28EKnvg3I1Q1bZmpJZa6Itn2Tc0RfB8et8DvcNdvmh/azKkJDvWb84xZwElkzTw
         kTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692716777; x=1693321577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiuif0UPEilRfTqfvjhgYV9OjFsrTUZzsOgS/HAy03Q=;
        b=R0lHPJ5DXEDEFeZZoXJQfFGSLl6m340F0HO/J/uvtNuvzyIoYm5HwxEZi9mM7SfVgx
         /lK/hT1/2ed0b2QKDTYYU/Hf+oxSGQ5/slcPlb8SHoTzG+tjFr82SJ8NNv6TuVeuU/pV
         5+nV0leMsgRpqd3khQBetBizbqpYdszZHEiXqmbdfv9HPjOXoF7rwwOuQVbesyeUjjXp
         YN6cp8yDJOS6Dak1Nc/QjhRVL8KhFpodbUTpyPUVUYP0fwaeFn7imPrRroSneabZ++Mu
         1cgsRyCZyti4L/xTbAqO5TiUkvG1Z6M4oNFYTyfC+j8OcVF5l0U6No1yIukEg8+f+5GQ
         SLXQ==
X-Gm-Message-State: AOJu0YzqH/G9zLk8esc88YD1862W5HiW+NmJr18/5cCiW31wwi2ITkO0
        RWwLZJzMzF1MduQVDyOlvCM=
X-Google-Smtp-Source: AGHT+IG/WYaK4QKoY/sXJElN3HnYE35+BGE/wEL15yzukGUemxKM29AaJP9Afn93aZrjhi0CYRIJjg==
X-Received: by 2002:adf:e710:0:b0:317:3d36:b2c1 with SMTP id c16-20020adfe710000000b003173d36b2c1mr8082225wrm.7.1692716776656;
        Tue, 22 Aug 2023 08:06:16 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id p13-20020adff20d000000b0031c52e81490sm6619066wro.72.2023.08.22.08.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:06:16 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcmtest: Add support for pcm pausing
Date:   Tue, 22 Aug 2023 19:05:41 +0400
Message-Id: <20230822150541.8450-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pause push/release support to the virtual PCM test driver. Add
'suspend' boolean field to the pcmtst_buf_iter structure, so we can
pause the timer without shutting it down. Update the trigger callback
handler correspondingly. Extract buffer initialization to the
'reset_buf_iterator' function since it is used in multiple places now.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/pcmtest.c | 49 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 27cbb9d38f08..b59b78a09224 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -108,6 +108,7 @@ struct pcmtst_buf_iter {
 	size_t total_bytes;			// Total bytes read/written
 	size_t chan_block;			// Bytes in one channel buffer when non-interleaved
 	struct snd_pcm_substream *substream;
+	bool suspend;				// We need to pause timer without shutting it down
 	struct timer_list timer_instance;
 };
 
@@ -115,7 +116,8 @@ static struct snd_pcm_hardware snd_pcmtst_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_NONINTERLEAVED |
-		 SNDRV_PCM_INFO_MMAP_VALID),
+		 SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_PAUSE),
 	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_8000_48000,
 	.rate_min =		8000,
@@ -346,6 +348,9 @@ static void timer_timeout(struct timer_list *data)
 	v_iter = from_timer(v_iter, data, timer_instance);
 	substream = v_iter->substream;
 
+	if (v_iter->suspend)
+		return;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && !v_iter->is_buf_corrupted)
 		check_buf_block(v_iter, substream->runtime);
 	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -358,7 +363,9 @@ static void timer_timeout(struct timer_list *data)
 		v_iter->period_pos %= v_iter->period_bytes;
 		snd_pcm_period_elapsed(substream);
 	}
-	mod_timer(&v_iter->timer_instance, jiffies + TIMER_INTERVAL + inject_delay);
+
+	if (!v_iter->suspend)
+		mod_timer(&v_iter->timer_instance, jiffies + TIMER_INTERVAL + inject_delay);
 }
 
 static int snd_pcmtst_pcm_open(struct snd_pcm_substream *substream)
@@ -373,19 +380,15 @@ static int snd_pcmtst_pcm_open(struct snd_pcm_substream *substream)
 	if (!v_iter)
 		return -ENOMEM;
 
+	v_iter->substream = substream;
 	runtime->hw = snd_pcmtst_hw;
 	runtime->private_data = v_iter;
-	v_iter->substream = substream;
-	v_iter->buf_pos = 0;
-	v_iter->is_buf_corrupted = false;
-	v_iter->period_pos = 0;
-	v_iter->total_bytes = 0;
 
 	playback_capture_test = 0;
 	ioctl_reset_test = 0;
 
 	timer_setup(&v_iter->timer_instance, timer_timeout, 0);
-	mod_timer(&v_iter->timer_instance, jiffies + TIMER_INTERVAL);
+
 	return 0;
 }
 
@@ -400,10 +403,40 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static inline void reset_buf_iterator(struct pcmtst_buf_iter *v_iter)
+{
+	v_iter->buf_pos = 0;
+	v_iter->is_buf_corrupted = false;
+	v_iter->period_pos = 0;
+	v_iter->total_bytes = 0;
+}
+
+static inline void start_pcmtest_timer(struct pcmtst_buf_iter *v_iter)
+{
+	v_iter->suspend = false;
+	mod_timer(&v_iter->timer_instance, jiffies + TIMER_INTERVAL);
+}
+
 static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
 	if (inject_trigger_err)
 		return -EINVAL;
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		reset_buf_iterator(v_iter);
+		start_pcmtest_timer(v_iter);
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		start_pcmtest_timer(v_iter);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		// We can't call timer_shutdown_sync here, as it is forbidden to sleep here
+		v_iter->suspend = true;
+		break;
+	}
 
 	return 0;
 }
-- 
2.34.1

