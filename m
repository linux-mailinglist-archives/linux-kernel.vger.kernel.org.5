Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877BD7FFACA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376261AbjK3TGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3TGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:06:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C5194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:06:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3332e351670so273035f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701371214; x=1701976014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWM7V+ZExvAnFj1W1dKLDuXcl2XOV1nsx6wXsgycfE=;
        b=rqNWdBgdbzf5iJ4AJT928zTbxfEETGW4IyF2uhAZ/Y0OA00FRHNhGRAieqfwZ37+HQ
         03he86pEpNvSTD+XOFXiCZHXgRcCZaCC4aJcXifJuMxEyN1XwBiiF0SqITP9WHYKllpi
         45LrLoMKiq07iUd2NKk+CmqL48ufK1bEuQaFtjg0Itd1yjE5Un+PHVIaW1cSoJPnUrks
         BV6jKrfZJoxM1jzC7Jg2ZV4RmNPix4ko5NdwIej/j5WS3XRX+mii78LdIhWXyv0OchBz
         u1ldibH+j9CErjc8TINM4wD70BM8O03XOrObahz5JqwmYtLmC8ma76g08GMCIws4+qJY
         na0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371214; x=1701976014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hWM7V+ZExvAnFj1W1dKLDuXcl2XOV1nsx6wXsgycfE=;
        b=U5CO6H9EnRx75xgfGaVEkX4mahMFDJXlrOrQ4nY63BdFWIf7VH/iYxSFvclaLxE07I
         t3oD1Ye5dQNfs3TekpxqZUTubz0/dmO7MRFRNOCpAzDTTvvuk80kYIFJ3O5Chon7jwov
         m3AbqOnMMdlKml9IUScTxVGTEu67BmGBij0GgTRWkEBvLTfYZh90A0AAKXIaQoQ77DLm
         0P9/4fne15DsbmpNwPqg9fhMpbyP/QZ3AnATNrs0hG9GZeiGQn52Si45e2GXzY+IBGpi
         Xlz7Tbq/1vw0Q8JvC5xySENWXkBVaiYF3iwwqfl2oH1PCPTUlLBMUGpHR+EIr6JdQ+Tj
         m2VA==
X-Gm-Message-State: AOJu0Yz3JDfPR5rC6cCiuNMSI3t7xKiTAJvFxyIc00BMitQYwjcwJbfP
        1+sLV6cQ3MZ7PpbAiiRq6RRr95ov2+L4UnKLfencXg==
X-Google-Smtp-Source: AGHT+IGG8SW/XcQazf2iyEQkOuHfNKXEzI1KvqtYFQzrb/U6iIkfOpKTu2rQXzzMQj1IPVHwiHZ0mg==
X-Received: by 2002:a17:906:b88f:b0:a19:a1ba:bab7 with SMTP id hb15-20020a170906b88f00b00a19a1babab7mr5512ejb.93.1701367681837;
        Thu, 30 Nov 2023 10:08:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906559000b009a1dbf55665sm926713ejp.161.2023.11.30.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:08:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] ASoC: qcom: audioreach: Commonize setting channel mappings
Date:   Thu, 30 Nov 2023 19:07:56 +0100
Message-Id: <20231130180758.212172-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move code assigning channel mapping values to a common helper function.
This simplifies three out of four cases, with the last case using
incompatible type (uint16_t array instead of uint8_t array).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 sound/soc/qcom/qdsp6/audioreach.c | 35 ++++++++++++++-----------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 5974c7929dd3..3db5ff367a29 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -267,6 +267,16 @@ void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t token
 }
 EXPORT_SYMBOL_GPL(audioreach_alloc_apm_cmd_pkt);
 
+static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
+{
+	if (num_channels == 1) {
+		ch_map[0] =  PCM_CHANNEL_L;
+	} else if (num_channels == 2) {
+		ch_map[0] =  PCM_CHANNEL_L;
+		ch_map[1] =  PCM_CHANNEL_R;
+	}
+}
+
 static void apm_populate_container_config(struct apm_container_obj *cfg,
 					  struct audioreach_container *cont)
 {
@@ -864,12 +874,8 @@ static int audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
 		mp3_cfg->endianness = PCM_LITTLE_ENDIAN;
 		mp3_cfg->num_channels = mcfg->num_channels;
 
-		if (mcfg->num_channels == 1) {
-			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_L;
-		} else if (mcfg->num_channels == 2) {
-			mp3_cfg->channel_mapping[0] =  PCM_CHANNEL_L;
-			mp3_cfg->channel_mapping[1] =  PCM_CHANNEL_R;
-		}
+		audioreach_set_channel_mapping(mp3_cfg->channel_mapping,
+					       mcfg->num_channels);
 		break;
 	case SND_AUDIOCODEC_AAC:
 		media_fmt_hdr->data_format = DATA_FORMAT_RAW_COMPRESSED;
@@ -1089,13 +1095,8 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	media_cfg->q_factor = mcfg->bit_width - 1;
 	media_cfg->bits_per_sample = mcfg->bit_width;
 
-	if (num_channels == 1) {
-		media_cfg->channel_mapping[0] = PCM_CHANNEL_L;
-	} else if (num_channels == 2) {
-		media_cfg->channel_mapping[0] = PCM_CHANNEL_L;
-		media_cfg->channel_mapping[1] = PCM_CHANNEL_R;
-
-	}
+	audioreach_set_channel_mapping(media_cfg->channel_mapping,
+				       num_channels);
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
 
@@ -1153,12 +1154,8 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 		cfg->endianness = PCM_LITTLE_ENDIAN;
 		cfg->num_channels = mcfg->num_channels;
 
-		if (mcfg->num_channels == 1)
-			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
-		else if (num_channels == 2) {
-			cfg->channel_mapping[0] =  PCM_CHANNEL_L;
-			cfg->channel_mapping[1] =  PCM_CHANNEL_R;
-		}
+		audioreach_set_channel_mapping(cfg->channel_mapping,
+					       num_channels);
 	} else {
 		rc = audioreach_set_compr_media_format(header, p, mcfg);
 		if (rc) {
-- 
2.34.1

