Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEDE76EE1D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjHCP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjHCP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:28:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16BE6E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:28:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9e8d7c6cbso1834361fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691076521; x=1691681321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fv1LCJk+f7RVF8k/ixLAQ0iB0AzU0l/9VwQdVFGXgR8=;
        b=MnDCwmQ/dByCs/tojD4nKtp/RjoX793JDmx/Fzbo1WQVxl0M1xtoQsEIM/VaV9a+BD
         r1XxSYLb0h7ULkYpFKtX93xDcs1B11R9AZH+MW+mBm+T9RCjHse3ImhTqOzDu1mG4WNz
         f6bkEZ8kXrWmG7t22bXhWkgN+ZwyiVat7+cupd/GeGWOkAo2+cO0s0ePNEV7Upz7CROP
         koP+HjuaDobs81LngADNHkHYgO02MRjnamX0P22G1i3HH+ObcNlPVr/po4UVplDm5MQv
         Gg3wVklxRDpBUEc564EKnogGcbmGUkpMgRVg1PtmXFKZ0HSsyzqjmSk+J4zQannNiuk0
         0TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076521; x=1691681321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fv1LCJk+f7RVF8k/ixLAQ0iB0AzU0l/9VwQdVFGXgR8=;
        b=Amu6Lk6iUxBNsA2ewwivIP0sE3YWpwjtQPIB3e48Kj/lU+RCpDEs+qkW0zGI/zkZEO
         IrlIR/PBwo6IAlmajM7zfLeasPCBzuiFJvJZWPXwZiU3f1d9GOfblohLXmegFpyCCfao
         UiOtzk/TxN+KUHymU1xrFgyFa3EEzYdkSSDEANQE2ZhwLWgxzSDRbV8WSRIblzgcdH/O
         bpl9LdIQZdekdZcQKQg6hrF3daB8UvTpOnu5GYz7TIkt5aJK+BnvVBeQUUHsT239LloP
         KjR86Si7esTvwgTXrLwQAomZKXsN5viPz7+Xq4H5ul5tCsUkLKgBbh1phdqTltcUtbX1
         odZg==
X-Gm-Message-State: ABy/qLaNW/XxfxwiLH3aSXIDK5Hc3th2KHwytPnWhwXPHTJVVghPtdia
        rfQNW8RrVLYZnLih7LSWijXSXGiddtTloEbF
X-Google-Smtp-Source: APBJJlH7BTs2SskwP8aha/5LX92ptdWcFqDZlLUmmHykJcslucD1S0yT5lOPHU67HB/TX5d5nkmHyw==
X-Received: by 2002:a05:651c:31a:b0:2b7:34c0:a03a with SMTP id a26-20020a05651c031a00b002b734c0a03amr9667022ljp.3.1691076520920;
        Thu, 03 Aug 2023 08:28:40 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([141.136.93.39])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090681c300b00997d76981e0sm10617559ejx.208.2023.08.03.08.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 08:28:40 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcmtest: Move buffer iterator initialization to prepare callback
Date:   Thu,  3 Aug 2023 19:28:24 +0400
Message-Id: <20230803152824.7531-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger callback is not the best place for buffer iterator
initialization, so move it out to the prepare callback, where it
have to be.

Minor enhancement: remove redundant definitions and blank line.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/pcmtest.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index 08e14b5eb772..7f170429eb8f 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -41,8 +41,6 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 
-#define DEVNAME "pcmtestd"
-#define CARD_NAME "pcm-test-card"
 #define TIMER_PER_SEC 5
 #define TIMER_INTERVAL (HZ / TIMER_PER_SEC)
 #define DELAY_JIFFIES HZ
@@ -74,11 +72,11 @@ static u8 ioctl_reset_test;
 static struct dentry *driver_debug_dir;
 
 module_param(index, int, 0444);
-MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard");
+MODULE_PARM_DESC(index, "Index value for pcmtest soundcard");
 module_param(id, charp, 0444);
-MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard");
+MODULE_PARM_DESC(id, "ID string for pcmtest soundcard");
 module_param(enable, bool, 0444);
-MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
+MODULE_PARM_DESC(enable, "Enable pcmtest soundcard.");
 module_param(fill_mode, short, 0600);
 MODULE_PARM_DESC(fill_mode, "Buffer fill mode: rand(0) or pattern(1)");
 module_param(inject_delay, int, 0600);
@@ -92,7 +90,6 @@ MODULE_PARM_DESC(inject_trigger_err, "Inject EINVAL error in the 'trigger' callb
 module_param(inject_open_err, bool, 0600);
 MODULE_PARM_DESC(inject_open_err, "Inject EBUSY error in the 'open' callback");
 
-
 struct pcmtst {
 	struct snd_pcm *pcm;
 	struct snd_card *card;
@@ -405,25 +402,9 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 
 static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct pcmtst_buf_iter *v_iter = runtime->private_data;
-
 	if (inject_trigger_err)
 		return -EINVAL;
 
-	v_iter->sample_bytes = runtime->sample_bits / 8;
-	v_iter->period_bytes = frames_to_bytes(runtime, runtime->period_size);
-	if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
-	    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) {
-		v_iter->chan_block = runtime->dma_bytes / runtime->channels;
-		v_iter->interleaved = false;
-	} else {
-		v_iter->interleaved = true;
-	}
-	// We want to record RATE * ch_cnt samples per sec, it is rate * sample_bytes * ch_cnt bytes
-	v_iter->s_rw_ch = runtime->rate / TIMER_PER_SEC;
-	v_iter->b_rw = v_iter->s_rw_ch * v_iter->sample_bytes * runtime->channels;
-
 	return 0;
 }
 
@@ -454,8 +435,24 @@ static void pcmtst_pdev_release(struct device *dev)
 
 static int snd_pcmtst_pcm_prepare(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct pcmtst_buf_iter *v_iter = runtime->private_data;
+
 	if (inject_prepare_err)
 		return -EINVAL;
+
+	v_iter->sample_bytes = samples_to_bytes(runtime, 1);
+	v_iter->period_bytes = snd_pcm_lib_period_bytes(substream);
+	v_iter->interleaved = true;
+	if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
+	    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) {
+		v_iter->chan_block = snd_pcm_lib_buffer_bytes(substream) / runtime->channels;
+		v_iter->interleaved = false;
+	}
+	// We want to record RATE * ch_cnt samples per sec, it is rate * sample_bytes * ch_cnt bytes
+	v_iter->s_rw_ch = runtime->rate / TIMER_PER_SEC;
+	v_iter->b_rw = v_iter->s_rw_ch * v_iter->sample_bytes * runtime->channels;
+
 	return 0;
 }
 
-- 
2.34.1

