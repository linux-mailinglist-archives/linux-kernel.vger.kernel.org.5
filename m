Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE98B80E860
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346061AbjLLJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjLLJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:59:17 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B6E8;
        Tue, 12 Dec 2023 01:59:23 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so3397424b6e.1;
        Tue, 12 Dec 2023 01:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702375162; x=1702979962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5GlMW1Kh4nLITNIYwe64bCuIn3y8U980DG6b5ax924=;
        b=RAZnaZYKgMyL1B2Fyn9AeuElVZFx46jgi1+pArhuVOg6mkW2LyN/qRoX6mferpQCeg
         +Pn4GkHaRpOOvho1t5/DDauWShQobmllCtBwoS8d3a9JJsEcIK4I6q4pHk7Fs8JAfmTB
         qMFfY84p5UKrQ3AxyDt39b9O9NYc2+AqyRGNMo1vp0Sa5ov6P2ME8z8TPpIS0IxmE2ac
         Wnj68YIqxOZKpNdi2FclRpNehNqIu6vPOy+ocGwnAkyhpD6rio+pyYtH2ljK0IDswRpF
         o/4h0eRVxBMvJAsLKGUFhADihImsj31fzrl/dQlTsuC4v0zV7fTkP4OS8b32snbxy9F1
         u80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375162; x=1702979962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5GlMW1Kh4nLITNIYwe64bCuIn3y8U980DG6b5ax924=;
        b=Elc3LCqqPeCN0VJgo2QUZrvpXtBrLy5yPqC8PLbT9CRFwjvsBMX8UAadpYs43IXmMH
         XxiY9xNwTZc/K5arhZJWcpmunIcGGlRzOp8Ht96pZJst0EiJjlE47fryENzQyP3we39L
         D7IYnL2LMf2SsfzDYNMHB1mGjnCzSNOeUjOS1psVzSYsOTT3t8YagjxhUaEXGYHk8Wrw
         BFhudByiIIgpFc7rV9mAK9UAWGYFStI/Ia4G5QSfeosHyxtL0gD6fp9qA23DliHw4tKD
         Jer7GGK13z1UCQK7LadoPZGVBi4euXXG/6w0FR2nBYc9ZTl/rJk1mNW3Q3zTYn7eExDa
         /zSw==
X-Gm-Message-State: AOJu0Yxma/lQqkD946j0atEFX0bFN9xhumDebfBatmSRXyJNUX3QM3M3
        yCtAWfN/BfM1zKiMVY6+od2EAutSItD6Qw==
X-Google-Smtp-Source: AGHT+IGv+pUTcYw3AN16Fy3gEBQql0CgY9sI+VsP3TLi5giVX8oZb9syxSid0H88mpsNY3owKtMXEw==
X-Received: by 2002:a05:6808:3028:b0:3a8:432a:ea13 with SMTP id ay40-20020a056808302800b003a8432aea13mr7516672oib.46.1702375162279;
        Tue, 12 Dec 2023 01:59:22 -0800 (PST)
Received: from localhost.localdomain ([117.189.239.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a056a0010c400b006ce7344328asm7730354pfu.77.2023.12.12.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:59:21 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [RFC, PATCH v2 2/2] ASoC: qcom: sm8250: Add TERTIARY_TDM_RX_0 support
Date:   Tue, 12 Dec 2023 17:58:50 +0800
Message-ID: <20231212095850.26482-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212095850.26482-1-lujianhua000@gmail.com>
References: <20231212095850.26482-1-lujianhua000@gmail.com>
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

Add TERTIARY_TDM_RX_0 case to make speaker amplifiers working
on xiaomi-elish tablet.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
No changes in v2.

 sound/soc/qcom/sm8250.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f298167c2a23..00c89c073e72 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -16,6 +16,7 @@
 
 #define DRIVER_NAME		"sm8250"
 #define MI2S_BCLK_RATE		1536000
+#define TDM_BCLK_RATE		12288000
 
 struct sm8250_snd_data {
 	bool stream_prepared[AFE_PORT_MAX];
@@ -53,6 +54,7 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	int ret, j;
 
 	switch (cpu_dai->id) {
 	case TERTIARY_MI2S_RX:
@@ -63,6 +65,23 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
+	case TERTIARY_TDM_RX_0:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_DSP_A;
+		snd_soc_dai_set_sysclk(cpu_dai,
+			Q6AFE_LPASS_CLK_ID_TER_TDM_IBIT,
+			TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+
+		for_each_rtd_codec_dais(rtd, j, codec_dai) {
+			ret = snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
+			snd_soc_dai_set_sysclk(codec_dai,
+				0,
+				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+			if (ret < 0) {
+				dev_err(rtd->dev, "TDM fmt err:%d\n", ret);
+				return ret;
+			}
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.41.0

