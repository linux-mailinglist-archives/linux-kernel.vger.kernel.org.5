Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F87807B59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbjLFWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLFWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:32:16 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8A7D46;
        Wed,  6 Dec 2023 14:32:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c192f488cso500675e9.1;
        Wed, 06 Dec 2023 14:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701901941; x=1702506741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyhcnJA0nXBVR1HG/2l3wKqAtWW5a+bvVknLnzVqBQ4=;
        b=ML/MKq9pTcQkMeFiceaZPwrz6YOrDFyElXnP2UCyTipi2eHt752w8Xog+WXyx1rY2H
         lWLHrw8QM+2MHWklUw/JXJY01lsEaE1msupgEvO8N5ATc4jawB2XkwpEQWCZv0Us8clO
         uB/NXtWcGPkRJr3JtIPlTL2PtH35SP7wTMQ1FOyB7E7MKImhH63mmOU8qsABRNhVXiTG
         aYjI1Mv/dly3xq3nN6stwbN0sbts6Qyzxif0gAGeFS9pZ7bNODWRIMV95zBo+8rbQlYq
         2xNG6LtV1J35YarMNEcZP1iTfrtgPc3WjjhXJPGhzQ7weRalv45QealrPan2jL5rwn94
         x8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901941; x=1702506741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyhcnJA0nXBVR1HG/2l3wKqAtWW5a+bvVknLnzVqBQ4=;
        b=YqYaWd3pXyVsbbQo4/taOvZioXp5bq0zD4oUHfCoTZ4PJ6wH7Ga754/DLbIWYiUP2E
         WOptxThkjDhFk/Q9xFFFF9xD5UroQpjsmMyKKplcBrsF8HM6AX00v2YZKy9VeWkH4kh3
         oVQ587qo0pzhuJDrkGFPCpVe6YGqTwmX1FUX3qvAPOjsQmzqcFPeid2dcDt9Iih3qMLk
         DGLYxpi3nxWxpopbZ+jx/oyZcvqP3u8EZIWydyheeqrNq52Xo/yVH3zjK/UcotrO4v2A
         GCbt+QL8NGyJNqoIqAsbF2Wz7lLrYcdSxpiHxY3feWcJsNVjeHwfwzQRX9cqWCcjwrWW
         E73g==
X-Gm-Message-State: AOJu0YzGMtXOtfY8kcwY0ieLUbDWfcVfrr2K3DbriakHzV0OTr0w3ZI2
        uF1eqZXZ8EyC3khK6/c5NLjnul2l76Y2Cg==
X-Google-Smtp-Source: AGHT+IGuQ00zpBrbu9P+x80URJdIofhHnx34kXxr5f5fvg9jbnq/MaiZHfVjM7fz7yKIv0ewre3wYA==
X-Received: by 2002:a7b:cd16:0:b0:40c:2960:9603 with SMTP id f22-20020a7bcd16000000b0040c29609603mr113484wmj.3.1701901940319;
        Wed, 06 Dec 2023 14:32:20 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:46d4:8167:1025:cc12])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600011d000b00333404e9935sm662139wrx.54.2023.12.06.14.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:32:19 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ALSA: pcmtest: stop timer before buffer is released
Date:   Wed,  6 Dec 2023 22:32:11 +0000
Message-Id: <20231206223211.12761-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop timer in the 'trigger' and 'sync_stop' callbacks since we want
the timer to be stopped before the DMA buffer is released. Otherwise,
it could trigger a kernel panic in some circumstances, for instance
when the DMA buffer is already released but the timer callback is
still running.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Remove useless NULLing of v_iter->substream. It will be released in
'close' callback.
V2 -> V3:
- Change commit title from 'ALSA: pcmtest: stop timer in the hw_free
callback' to more appropriate one
- Deactivate the timer in 'trigger' function for the PCM STOP and PCM
PAUSE PUSH events
- Wait for timer handler to complete and stop it from rearming in the
'sync_stop' callback instead of destroying the timer in hw_free
callback, which could be called multiple times.

 sound/drivers/pcmtest.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/pcmtest.c b/sound/drivers/pcmtest.c
index b59b78a09224..b8bff5522bce 100644
--- a/sound/drivers/pcmtest.c
+++ b/sound/drivers/pcmtest.c
@@ -397,7 +397,6 @@ static int snd_pcmtst_pcm_close(struct snd_pcm_substream *substream)
 	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
 
 	timer_shutdown_sync(&v_iter->timer_instance);
-	v_iter->substream = NULL;
 	playback_capture_test = !v_iter->is_buf_corrupted;
 	kfree(v_iter);
 	return 0;
@@ -435,6 +434,7 @@ static int snd_pcmtst_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		// We can't call timer_shutdown_sync here, as it is forbidden to sleep here
 		v_iter->suspend = true;
+		timer_delete(&v_iter->timer_instance);
 		break;
 	}
 
@@ -512,12 +512,22 @@ static int snd_pcmtst_ioctl(struct snd_pcm_substream *substream, unsigned int cm
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
+static int snd_pcmtst_sync_stop(struct snd_pcm_substream *substream)
+{
+	struct pcmtst_buf_iter *v_iter = substream->runtime->private_data;
+
+	timer_delete_sync(&v_iter->timer_instance);
+
+	return 0;
+}
+
 static const struct snd_pcm_ops snd_pcmtst_playback_ops = {
 	.open =		snd_pcmtst_pcm_open,
 	.close =	snd_pcmtst_pcm_close,
 	.trigger =	snd_pcmtst_pcm_trigger,
 	.hw_params =	snd_pcmtst_pcm_hw_params,
 	.ioctl =	snd_pcmtst_ioctl,
+	.sync_stop =	snd_pcmtst_sync_stop,
 	.hw_free =	snd_pcmtst_pcm_hw_free,
 	.prepare =	snd_pcmtst_pcm_prepare,
 	.pointer =	snd_pcmtst_pcm_pointer,
@@ -530,6 +540,7 @@ static const struct snd_pcm_ops snd_pcmtst_capture_ops = {
 	.hw_params =	snd_pcmtst_pcm_hw_params,
 	.hw_free =	snd_pcmtst_pcm_hw_free,
 	.ioctl =	snd_pcmtst_ioctl,
+	.sync_stop =	snd_pcmtst_sync_stop,
 	.prepare =	snd_pcmtst_pcm_prepare,
 	.pointer =	snd_pcmtst_pcm_pointer,
 };
-- 
2.34.1

