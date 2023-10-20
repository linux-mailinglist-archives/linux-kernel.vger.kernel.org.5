Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45F07D0ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376520AbjJTIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376558AbjJTItZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:49:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DFDD68
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:49:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d834ec222so398247f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697791762; x=1698396562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GnHiqqVEbl+pDvywkw0tVZ8FisGTMqMuua4/tZ42RoE=;
        b=ilYF5hjFhQiHKshGyV6tgcqaosNm37cmrPnWj48szjr/LeTu4cfMrjP8Y7vrV1UDSo
         UX4ACWtl/0Zm+u4ggDbz88iNLOwAHzfNwVisxpHOHeKe3UxqFNF5U8V7HJx+x2Ca0C5I
         GG8pFAnvkye6FKm9+GIKCL2/nyncMyO/aGsclCeNmGuEsFd4Uwi1nXJ+fPSlZNdHKArh
         0WLqOIuuswIpvNrV6BDO3SVlefoA+3u+1UEwbw4l+kOidFZMyQ+m6gcwb9upsorovkXU
         Dxbc/08a1rnHRl/fXPiiBq8riMsxJB0TlkAAe8iBmHWxQPjUT6KsDlCH+iyfRlKmz3lN
         OzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697791762; x=1698396562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnHiqqVEbl+pDvywkw0tVZ8FisGTMqMuua4/tZ42RoE=;
        b=BwS/qwLCHoI/1kbC4w5DvRsr6f30dc8fGFqwYIMoBJZcq4y5mUBsiu34fm0y+uJfqI
         iPhEQUikION6sMGiRNPRpB0FWBAaNVMvpnFk4yEZ0vpxWY+WAloSxU+US0A2oOlrE5Np
         ULthrFYRfvS8U2bWY578NvrHFseiXvZoYKUWIBqi/WGhiuF/eKU+Ie2FoPXhtU1Qnp1O
         ws3rCU7I5d7jarfxmxZ4mjgQHgQEjHTtxbJUTriSiDLFXo5LreSeruEMGvuMpkOzCT/K
         sT3OCcd6IDPdmZ7udaEfVchh7R/120JqyNXSolpw0BobyE0sdm2jOoFfFYeqtMpFDAY9
         mS7A==
X-Gm-Message-State: AOJu0YwYMa1gQOcBCCfzTTxojxslEjP231ivtf1N1nFpjmseFGeEkASx
        9RIb14quniq5GOqBiQR0dVpSqbV10moBKBoPA1I=
X-Google-Smtp-Source: AGHT+IFUTyfFp/kwwteBdgtgwlAO6fV9liuEpYs3jx7es/7vKaY8OxYJjz14JfezGlN1sjLOeo3Tmw==
X-Received: by 2002:a5d:4e06:0:b0:329:6e92:8d73 with SMTP id p6-20020a5d4e06000000b003296e928d73mr775428wrt.67.1697791762085;
        Fri, 20 Oct 2023 01:49:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id c1-20020adfa301000000b00323287186aasm1231783wrb.32.2023.10.20.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:49:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: audioreach: Add 4 channel support
Date:   Fri, 20 Oct 2023 10:49:19 +0200
Message-Id: <20231020084919.18628-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add support four channel streams.  Map channel 3 and 4 to left/right
surround ("quad(side)" from ffmpeg standard channel list) to match what
is in qdsp6/q6dsp-common.c driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

quad(side):
https://trac.ffmpeg.org/wiki/AudioChannelManipulation#Listchannelnamesandstandardchannellayouts
---
 sound/soc/qcom/qdsp6/audioreach.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 5974c7929dd3..4dd2a2e261c9 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -833,6 +833,11 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	} else if (num_channels == 2) {
 		media_format->channel_mapping[0] = PCM_CHANNEL_L;
 		media_format->channel_mapping[1] = PCM_CHANNEL_R;
+	} else if (num_channels == 4) {
+		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
+		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
+		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
+		media_format->channel_mapping[3] = PCM_CHANNEL_RS;
 	}
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
@@ -869,6 +874,11 @@ static int audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
 		} else if (mcfg->num_channels == 2) {
 			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_L;
 			mp3_cfg->channel_mapping[1] =  PCM_CHANNEL_R;
+		} else if (mcfg->num_channels == 4) {
+			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_FL;
+			mp3_cfg->channel_mapping[1] =  PCM_CHANNEL_FR;
+			mp3_cfg->channel_mapping[2] =  PCM_CHANNEL_LS;
+			mp3_cfg->channel_mapping[3] =  PCM_CHANNEL_RS;
 		}
 		break;
 	case SND_AUDIOCODEC_AAC:
@@ -1057,7 +1067,7 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	int rc, payload_size;
 	struct gpr_pkt *pkt;
 
-	if (num_channels > 2) {
+	if (num_channels > 4) {
 		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
 		return -EINVAL;
 	}
@@ -1094,7 +1104,11 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	} else if (num_channels == 2) {
 		media_cfg->channel_mapping[0] = PCM_CHANNEL_L;
 		media_cfg->channel_mapping[1] = PCM_CHANNEL_R;
-
+	} else if (num_channels == 4) {
+		media_cfg->channel_mapping[0] = PCM_CHANNEL_FL;
+		media_cfg->channel_mapping[1] = PCM_CHANNEL_FR;
+		media_cfg->channel_mapping[2] = PCM_CHANNEL_LS;
+		media_cfg->channel_mapping[3] = PCM_CHANNEL_RS;
 	}
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
@@ -1116,7 +1130,7 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 	struct gpr_pkt *pkt;
 	void *p;
 
-	if (num_channels > 2) {
+	if (num_channels > 4) {
 		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
 		return -EINVAL;
 	}
@@ -1158,6 +1172,11 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 		else if (num_channels == 2) {
 			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
 			cfg->channel_mapping[1] =  PCM_CHANNEL_R;
+		} else if (num_channels == 4) {
+			cfg->channel_mapping[0] =  PCM_CHANNEL_FL;
+			cfg->channel_mapping[1] =  PCM_CHANNEL_FR;
+			cfg->channel_mapping[2] =  PCM_CHANNEL_LS;
+			cfg->channel_mapping[3] =  PCM_CHANNEL_RS;
 		}
 	} else {
 		rc = audioreach_set_compr_media_format(header, p, mcfg);
-- 
2.34.1

