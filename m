Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C407B032D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjI0LgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjI0LgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:36:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBEF3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:36:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3200b181b67so1550326f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695814561; x=1696419361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRFVxzj+hVFD0IJT/IGMwbr1NPpMK93Z+5C9tH0fQfo=;
        b=ZVRgbd4nwPX8Yc4oFzX8uxg26YXWX8e/K6akbr8sAYKEPjbzi26SuszSbIrTQELppe
         TADsE/4PHSdMQ0sPQlP1vVz3X7B1R+GTiSOiwUVqocwfcRInJu8Tu69vIa3+Lvna3dSr
         Z6+Z2ESd0c8N37O6T/cif1b4RwOvUJGm+VKPs0X1L6V67rXJ0zCVMKGVc93DaTje4Aac
         rhXj07LhW4VAftIYIlwJdzJ//DcYoj+s/XQSCw6TF+uml7XtQI2/GtWvEFpA1hu0FXp+
         U1sllC62KNCCNkhIXhRypz0ijJMUzB7Y1ZU2Xc0sw2XqNsa4Zp4JIDfe+pr6yAOFBFx6
         vr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695814561; x=1696419361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRFVxzj+hVFD0IJT/IGMwbr1NPpMK93Z+5C9tH0fQfo=;
        b=sOTq9Pyn+ZQsYq08mMAoZWjuNn2Mg/69NYFBPHRJTpzaHCVhx4mUXPZFP8BsWuolBQ
         1nj6ko1eSY2BJ1sSeR1zellcN2A2XByyZhpQwyFV5s833KdPj265udoH+zO3WpUeR7lv
         ZhvqkDlqU2xTWZ4owrJawuLXqRFcSiEGby8sdO5SQ6xnMNlWkOlbjge6ugQY75Ip6ugt
         IuqCNA8xoJnKJOldV/pcsnINUVYNy/2YExzP2Sq/i/9ElTqHl2ksbcihrlgEHxxzcwFq
         b2lynmGOrXiBYOqiqaIEXCbsEU2ne9ZXgc7FVa+SEMpMaciGmychSJtN3ePpIeJDXqw8
         a0Bw==
X-Gm-Message-State: AOJu0YwWEfyc2rv8XgDGYFp0O3WkVQgFDXr1s43QXGYKwEuqblzUDOuR
        nq95kSnTS766m059mWM1+Is=
X-Google-Smtp-Source: AGHT+IHKmKHutWvHupgciI0XgpXrodsbTAdezHCuwMWoW4BstTpHwBYaFy4VorZtx8vHj5s3ZdZ9cg==
X-Received: by 2002:a5d:568e:0:b0:31a:ea18:c516 with SMTP id f14-20020a5d568e000000b0031aea18c516mr1548970wrv.3.1695814560929;
        Wed, 27 Sep 2023 04:36:00 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b0030ae53550f5sm16792874wrv.51.2023.09.27.04.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 04:36:00 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: aloop: Add support for the non-interleaved access mode
Date:   Wed, 27 Sep 2023 12:35:54 +0100
Message-Id: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of the loopback driver supports interleaved access
mode only. This patch introduces support for the non-interleaved
access mode.

When in the interleaved mode, the 'copy_play_buf' function copies data
from the playback to the capture buffer using one memcpy call. This call
copies samples for multiple, interleaved channels.

In the non-interleaved mode we have multiple channel buffers, so we have
to perform multiple memcpy calls to copy samples channel after channel.

Add new function called 'copy_play_buf_part_n', which copies a part of
each channel buffer from playback to capture. Modify the 'copy_play_buf'
to use the corresponding memory copy function(just memcpy /
copy_play_buf_part_n) depending on the access mode.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 sound/drivers/aloop.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index a38e602b4fc6..ab116b1fed96 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -158,6 +158,9 @@ struct loopback_pcm {
 	unsigned long last_jiffies;
 	/* If jiffies timer is used */
 	struct timer_list timer;
+
+	/* size of per channel buffer in case of non-interleaved access */
+	unsigned int channel_buf_n;
 };
 
 static struct platform_device *devices[SNDRV_CARDS];
@@ -335,7 +338,8 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 							substream->runtime;
 	check = runtime->format != cruntime->format ||
 		runtime->rate != cruntime->rate ||
-		runtime->channels != cruntime->channels;
+		runtime->channels != cruntime->channels ||
+		runtime->access != cruntime->access;
 	if (!check)
 		return 0;
 	if (stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -472,6 +476,7 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
 
 	dpcm->buf_pos = 0;
 	dpcm->pcm_buffer_size = frames_to_bytes(runtime, runtime->buffer_size);
+	dpcm->channel_buf_n = dpcm->pcm_buffer_size / runtime->channels;
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		/* clear capture buffer */
 		dpcm->silent_size = dpcm->pcm_buffer_size;
@@ -522,6 +527,22 @@ static void clear_capture_buf(struct loopback_pcm *dpcm, unsigned int bytes)
 	}
 }
 
+static void copy_play_buf_part_n(struct loopback_pcm *play, struct loopback_pcm *capt,
+				 unsigned int size, unsigned int src_off, unsigned int dst_off)
+{
+	unsigned int channels = capt->substream->runtime->channels;
+	unsigned int size_p_ch = size / channels;
+	unsigned int src_off_ch = src_off / channels;
+	unsigned int dst_off_ch = dst_off / channels;
+	int i;
+
+	for (i = 0; i < channels; i++) {
+		memcpy(capt->substream->runtime->dma_area + capt->channel_buf_n * i + dst_off_ch,
+		       play->substream->runtime->dma_area + play->channel_buf_n * i + src_off_ch,
+		       size_p_ch);
+	}
+}
+
 static void copy_play_buf(struct loopback_pcm *play,
 			  struct loopback_pcm *capt,
 			  unsigned int bytes)
@@ -556,7 +577,11 @@ static void copy_play_buf(struct loopback_pcm *play,
 			size = play->pcm_buffer_size - src_off;
 		if (dst_off + size > capt->pcm_buffer_size)
 			size = capt->pcm_buffer_size - dst_off;
-		memcpy(dst + dst_off, src + src_off, size);
+		if (runtime->access == SNDRV_PCM_ACCESS_RW_NONINTERLEAVED ||
+		    runtime->access == SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED)
+			copy_play_buf_part_n(play, capt, size, src_off, dst_off);
+		else
+			memcpy(dst + dst_off, src + src_off, size);
 		capt->silent_size = 0;
 		bytes -= size;
 		if (!bytes)
@@ -878,7 +903,7 @@ static const struct snd_pcm_hardware loopback_pcm_hardware =
 {
 	.info =		(SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
 			 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE |
-			 SNDRV_PCM_INFO_RESUME),
+			 SNDRV_PCM_INFO_RESUME | SNDRV_PCM_INFO_NONINTERLEAVED),
 	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
 			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE |
-- 
2.34.1

