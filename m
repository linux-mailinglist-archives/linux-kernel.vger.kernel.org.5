Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F781112F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjLMMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjLMMgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:36:19 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3BF7;
        Wed, 13 Dec 2023 04:36:25 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58df5988172so4396923eaf.0;
        Wed, 13 Dec 2023 04:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702470985; x=1703075785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeOaNUPzIaLpTYp3WoiPTDUVL3er+2u0oaLfnKfUysU=;
        b=fqb08ZxLCs3Ujcy6Fg2rOrcDaTJsLcS+qLY6MnVCkd5AOiGrWxy+XyZdpXhQk5L5nd
         UY8xNQkGtiCZFw1J9Z2CNrm9dRC+bO0ULCrF3MwTNa9z9HiXSs35bVsoTm0MlMelG8Dw
         SBdNusbnJqskJXVgXpA0GIpIsnikmeh2ekwoc1HgSK03UKmqi2vSKfQcBHR5O0/QZS/4
         PxibgluNvGc3u8Y1L4yZWw5tzHdHA9Mh0e+oJelUy8swZZA2o3yB1v5U4N3n/dHVQgga
         37xF4vKw9Kh3ex1SYa9qNgH4rKs1787DedewRMcb21h7CnV7znDYRSYFxnkKvmKTfkoK
         amLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702470985; x=1703075785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeOaNUPzIaLpTYp3WoiPTDUVL3er+2u0oaLfnKfUysU=;
        b=RvPdmViNtGT78k3n0mJLUhnLlf9VnkSSPC069ZcYswj98YApAmC2qzy0BsiMPCmmOt
         Dpx/+33TIsqSVZ+Qh6x8fhjTihoZdGH3fUcy/X6A5r9g6UQAbo+x4JHubvKxf8675jOw
         IR/KsCPxQCh2GcygmFbYcH6AXG4n4ZEDx3IacoG25hYkrrG5maYRJLZ0XEF5hQ4pImCH
         zyZyM6xIBnioOLVxBLBrmirMzIUP9lcvMdTHtCVc13FTYE1JV54R/FHEsUjJOSCEcj9b
         BnsSk5x/Zx2WvEyu8Gzj7+CPLRzkbLgfpeUDoDl732KQiYqKwquN06hPE2Orteg1HW57
         Bz4g==
X-Gm-Message-State: AOJu0YwqRkyphJteI8mQU8np8dz8WwnwJ2+4sqZb0hecfdXYcQspDogS
        zN+wJEIC3PFd4vmmbnHQLhI=
X-Google-Smtp-Source: AGHT+IF3mPmS92KpXb0fd2MbUmh0CWcpyP6e3laWEh/2A8gchCJz/2hR/V39DL3C2iJQDt7RFMyrgQ==
X-Received: by 2002:a05:6358:70a:b0:170:cacc:f7ee with SMTP id e10-20020a056358070a00b00170caccf7eemr6977763rwj.8.1702470984986;
        Wed, 13 Dec 2023 04:36:24 -0800 (PST)
Received: from localhost.localdomain ([117.189.237.103])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00188300b0068fe5a5a566sm10193584pfh.142.2023.12.13.04.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:36:24 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 2/4] ASoC: qcom: sdm845: switch to qcom_snd_tdm_hw_params helper
Date:   Wed, 13 Dec 2023 20:35:54 +0800
Message-ID: <20231213123556.20469-2-lujianhua000@gmail.com>
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

Use qcom_snd_tdm_hw_params helper to setup TDM ports.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v3:
  1. new patch

 sound/soc/qcom/sdm845.c | 46 +++++++----------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 252a0f0819be..5052c1410723 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -53,8 +53,6 @@ static struct snd_soc_jack_pin sdm845_jack_pins[] = {
 	},
 };
 
-static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
-
 static int sdm845_slim_snd_hw_params(struct snd_pcm_substream *substream,
 				     struct snd_pcm_hw_params *params)
 {
@@ -99,10 +97,9 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai;
 	int ret = 0, j;
-	int channels, slot_width;
+	int slot_width;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -114,39 +111,11 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	channels = params_channels(params);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0, 0x3,
-				8, slot_width);
-		if (ret < 0) {
-			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
-					__func__, ret);
-			goto end;
-		}
-
-		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
-				channels, tdm_slot_offset);
-		if (ret < 0) {
-			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
-					__func__, ret);
-			goto end;
-		}
-	} else {
-		ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xf, 0,
-				8, slot_width);
-		if (ret < 0) {
-			dev_err(rtd->dev, "%s: failed to set tdm slot, err:%d\n",
-					__func__, ret);
-			goto end;
-		}
-
-		ret = snd_soc_dai_set_channel_map(cpu_dai, channels,
-				tdm_slot_offset, 0, NULL);
-		if (ret < 0) {
-			dev_err(rtd->dev, "%s: failed to set channel map, err:%d\n",
-					__func__, ret);
-			goto end;
-		}
+	ret = qcom_snd_tdm_hw_params(substream, params);
+	if (ret < 0) {
+		dev_err(rtd->dev, "%s: failed to setup TDM err:%d\n",
+			__func__, ret);
+		return ret;
 	}
 
 	for_each_rtd_codec_dais(rtd, j, codec_dai) {
@@ -176,8 +145,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-end:
-	return ret;
+	return 0;
 }
 
 static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
-- 
2.41.0

