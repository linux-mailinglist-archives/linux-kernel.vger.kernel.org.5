Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299E7FFB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376442AbjK3Tav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjK3Tao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:30:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5936D40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:30:50 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a132acb67b5so190121866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701372649; x=1701977449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07QYxEgyoqmQ3Q1vq77DMefnw2mMccatpZsNXnEAueU=;
        b=AMuqyq8Di2KMd1hQ/tuSmaY+EisuXhI9qaqpeIiIjbgEdJ4bkCvH++dVzhssPk8fkK
         FwgkOtaCGMh8CzJUZ4DeZo8lgcXQn3UfSnF1+QJUw9rwaMU4MxlzZR0zN8gciUAXbqMA
         UppN7dNuSmggeosKfS2xJqUZzrTNRnUx0u//ojsSuYeCSDejGfLVZwEvd+sZkwkRps7y
         GgdYIpbXhAZWZijqYuwovVO93Mu5a4gXM74vybrBkQ2oF6HVbbSKJwwPA88hMiInlqOQ
         ZEDt6oElhzZUugzJDHga3bu1/KcYTInVDkKL/Lvt9IwUq1+50ci/T3kUOQQaxC9JVqns
         A7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372649; x=1701977449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07QYxEgyoqmQ3Q1vq77DMefnw2mMccatpZsNXnEAueU=;
        b=bgAao4RNMLTQWFi8Zw/SNLUJKQTKIoRegqcld/KZgrjgmZqDyratygIbaj7ql8xXfD
         ijMrQbPZE3JtqGaK5AXXY3MCuEG6s/C/6KQZ2ru98mcydg2hbBua1T7U8erqCYXKaFsU
         jrSk8nXue8+NwbS27+ry+Cl7JK1BvOIVYfWRtqTj+d496ZhfbXID4co/DGt6uSNhhwQt
         HchaTprGY0kLHyT7a93lGclu5cf8qyGZY9NfW8XguMkR3BDUM8QRRyzEvTReXeV7iCU1
         kwn2UvCOU5NYHks6Kr21ZiMpza8IIgVRN46x/eqpXhdYuGywqgW/pTIDcOk9rIGFs77A
         Iw7g==
X-Gm-Message-State: AOJu0YxfQDpLGq6FPoYjVf33SJBsG5t811LxSZsJTMxquXWTVqVIaPwm
        5nWOA8GHmPmW1A8ZJlJbvFXG5/xAx8VxqaX79U2+DA==
X-Google-Smtp-Source: AGHT+IH5RLOmJKYkkr8iZOW9SC+fCUJYFeQDas3VL1+GiBFExPCe+HsuOw/Ti2CQ542OzjVBSw5i4g==
X-Received: by 2002:a17:906:ca2:b0:9fe:3bb6:99fe with SMTP id k2-20020a1709060ca200b009fe3bb699femr80697ejh.2.1701367698155;
        Thu, 30 Nov 2023 10:08:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906559000b009a1dbf55665sm926713ejp.161.2023.11.30.10.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:08:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] ASoC: qcom: audioreach: Add 4 channel support
Date:   Thu, 30 Nov 2023 19:07:58 +0100
Message-Id: <20231130180758.212172-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130180758.212172-1-krzysztof.kozlowski@linaro.org>
References: <20231130180758.212172-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Changes in v2:
1. Rebase to avoid duplicate code.

v1:
https://lore.kernel.org/alsa-devel/20231020084919.18628-1-krzysztof.kozlowski@linaro.org/

quad(side):
https://trac.ffmpeg.org/wiki/AudioChannelManipulation#Listchannelnamesandstandardchannellayouts
---
 sound/soc/qcom/qdsp6/audioreach.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 5c7113d46b6f..5291deac0a0b 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -274,6 +274,11 @@ static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
 	} else if (num_channels == 2) {
 		ch_map[0] =  PCM_CHANNEL_FL;
 		ch_map[1] =  PCM_CHANNEL_FR;
+	} else if (num_channels == 4) {
+		ch_map[0] =  PCM_CHANNEL_FL;
+		ch_map[1] =  PCM_CHANNEL_FR;
+		ch_map[2] =  PCM_CHANNEL_LS;
+		ch_map[3] =  PCM_CHANNEL_RS;
 	}
 }
 
@@ -843,6 +848,11 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	} else if (num_channels == 2) {
 		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
 		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
+	} else if (num_channels == 4) {
+		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
+		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
+		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
+		media_format->channel_mapping[3] = PCM_CHANNEL_RS;
 	}
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
@@ -1063,7 +1073,7 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	int rc, payload_size;
 	struct gpr_pkt *pkt;
 
-	if (num_channels > 2) {
+	if (num_channels > 4) {
 		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
 		return -EINVAL;
 	}
@@ -1117,7 +1127,7 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 	struct gpr_pkt *pkt;
 	void *p;
 
-	if (num_channels > 2) {
+	if (num_channels > 4) {
 		dev_err(graph->dev, "Error: Invalid channels (%d)!\n", num_channels);
 		return -EINVAL;
 	}
-- 
2.34.1

