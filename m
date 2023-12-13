Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A493E811131
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjLMMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjLMMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:36:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D79113;
        Wed, 13 Dec 2023 04:36:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso5634605a12.0;
        Wed, 13 Dec 2023 04:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702471010; x=1703075810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZihwxl0v63j7g6/9Ub3zyT34OyL1Z04NfBICmYEzJk=;
        b=Yjqi5CFL/PE1vUIRj+mjZ9GU2RM3WNzdRqOYkNos9IR7UrSyzqIweP4xDOci2mtN8m
         x7fzCQFwFNv3Sju6HGgVcCj1bDF5qnaP6bbwSu5+852srDk9c15JL/1XNZAzNR1NZtMR
         p+PuaFRpdGs/9KhuWZr2mUIY0746h4uiru7ofstA2gh9vaRJxVDD1Mq6OQ5GCyIIop89
         uZwNL0vCIQZuY5Alc19fBOvgTasUwg8YGA/YiKyJAXAnsCS0v4St66GXAZ/YhgAMhR+e
         FJIeL0P3zGcZ0/3UML9K19A1gQ27m9FTU9edyFFxtIIoCObb4a2LWkN3W3sRkUZFOfHa
         g8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702471010; x=1703075810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZihwxl0v63j7g6/9Ub3zyT34OyL1Z04NfBICmYEzJk=;
        b=b7PFkwGb9XpAPzkzlhGFnrnGPdSgSK0C1B7iaFw+fuk8RexGjpWcGCNee0HlID849F
         E75tNjnGIy2zScpKLcQvQJmxJxUPrRqU5yF1fUJBBkjud127DavOw/00g6lVH6xu+Mg2
         UK1UkEdCzl9eCTUzeq83+m795YmN5IhOGk28iiIf4JhQITRZV1KFDKArjWECP7Ciq95P
         5d5FTvilFOKPDK+W18/MnzfJYNzYOPQqe3fn2RSRlZTIgiOGmwp9Aj28bgeDfTrq8lU8
         lWHwmQRH+JjmSgCQ0TJqHUkdJKaBVoqNpN2bFei9ADHuMkJOItjeexYDGnE+jmaxqWJ3
         U8Xw==
X-Gm-Message-State: AOJu0YzpDhxJog+QEzY+1QwuO9SzOYOi2oJXRJUcvzH0yhHm307qCKr2
        vTpSLbN6MUTLV9iKjOAdTM4=
X-Google-Smtp-Source: AGHT+IEm5mEDtS1LOQPlg62W3tJlZX2ZCSTzqHOg/4SL8BX/XhHwx2CVtF+Cuq8ajRix5XT7ni3shg==
X-Received: by 2002:a05:6a20:9481:b0:18b:4a28:6e15 with SMTP id hs1-20020a056a20948100b0018b4a286e15mr8029288pzb.34.1702471009861;
        Wed, 13 Dec 2023 04:36:49 -0800 (PST)
Received: from localhost.localdomain ([117.189.237.103])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00188300b0068fe5a5a566sm10193584pfh.142.2023.12.13.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:36:49 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 4/4] ASoC: qcom: sm8250: Add TERTIARY_TDM_RX_0 support
Date:   Wed, 13 Dec 2023 20:35:56 +0800
Message-ID: <20231213123556.20469-4-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213123556.20469-1-lujianhua000@gmail.com>
References: <20231213123556.20469-1-lujianhua000@gmail.com>
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
on Xiaomi Pad 5 Pro tablet.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
No changes in v3.

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

