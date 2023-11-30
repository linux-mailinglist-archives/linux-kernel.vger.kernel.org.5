Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D121B7FFBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjK3TmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjK3TmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:42:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEA10FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:41:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bd4fcbde1so625910e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701373281; x=1701978081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC9X+I2DWGil+KYfObDh0oa4Sp4cVvyRNcYSz6qi/GY=;
        b=XyrPnP5kk1V1SqjzoAoDihM83FBpyx0xC3kh2Yj7+bxDBMe+6AcH87QID6JYtQPoai
         YCrGmhes3gHbEl62pjDqe3nfPNz081SOAKjSY1xAJJy9ZytJ96e08FC2K8FuEmPM6hJ1
         Geu0mw3a8prcLLy1aFoafL6Jaud/ayKNSUks7TCSZx4ggizFiwkHqXjB/R0AEN1hEctX
         J+wu9hFVUOo7u7y0SJ6gNXeiGamchpIJfiL6ZUrEqKWFEBUcVd8ZaUM3wYDZTvK2uQxg
         3VJ7Wc2RK5BllMaMq4XfJy7s7K0c2dH75WCcZMh7K6vpoLW65OlY+at6yWdaWO6nlakb
         xo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373281; x=1701978081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AC9X+I2DWGil+KYfObDh0oa4Sp4cVvyRNcYSz6qi/GY=;
        b=NJAsATRevxLA64TVo66lmL6C+duChMehHRxfhHlKdHtgxMBusVAk4M8X2wKCKPhSTv
         Im/qVUlXK0qh5YvFQU/WSgO9AWk6U4mVzN1isPppUeHbHnofCy2NR7zy5YbaQNMyIqpQ
         /uyBstnOFpAp8XLlQusPyeXST7Y8AspDjEOrM8Fgebp6LhM4pUJaGEsQnIW3zBbuAAbq
         ONcY2MB1wp1piZxXGYQ+Vg/zSEB0QTROPIXP3b7D34wRxx/Dn6r/C7X0kimjnseOa253
         put9XR6d2wXFpE7Oo6q57LllOn5pUWOGyojy2Ra995LZfHBFKRzXW+cS+SIrcre8Wo6E
         QCIg==
X-Gm-Message-State: AOJu0Yxuty+BR1Y4uY3xaoqoJG2hb3HSmhQ+ysYVd+4FICG7/zR8Vrze
        q/09D9EfchCc1NM9NTS8TmuaEx4eKYUYQAPIcPtP4w==
X-Google-Smtp-Source: AGHT+IFvub3SCGtusk+ZqhsrvxJgXcKJ9ivYgKET4m1jBYY5pnBV8bUXpwvzJHOJT7A45CaynCXmxA==
X-Received: by 2002:adf:fdcc:0:b0:333:2fd2:68fa with SMTP id i12-20020adffdcc000000b003332fd268famr12459wrs.141.1701367693588;
        Thu, 30 Nov 2023 10:08:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906559000b009a1dbf55665sm926713ejp.161.2023.11.30.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 10:08:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] ASoC: qcom: audioreach: drop duplicate channel defines
Date:   Thu, 30 Nov 2023 19:07:57 +0100
Message-Id: <20231130180758.212172-2-krzysztof.kozlowski@linaro.org>
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

q6apm.h header already defines channel mapping values, so drop
duplicated devices from audioreach.h.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. New patch
---
 sound/soc/qcom/qdsp6/audioreach.c | 12 ++++++------
 sound/soc/qcom/qdsp6/audioreach.h |  2 --
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 3db5ff367a29..5c7113d46b6f 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -270,10 +270,10 @@ EXPORT_SYMBOL_GPL(audioreach_alloc_apm_cmd_pkt);
 static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
 {
 	if (num_channels == 1) {
-		ch_map[0] =  PCM_CHANNEL_L;
+		ch_map[0] =  PCM_CHANNEL_FL;
 	} else if (num_channels == 2) {
-		ch_map[0] =  PCM_CHANNEL_L;
-		ch_map[1] =  PCM_CHANNEL_R;
+		ch_map[0] =  PCM_CHANNEL_FL;
+		ch_map[1] =  PCM_CHANNEL_FR;
 	}
 }
 
@@ -839,10 +839,10 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	media_format->num_channels = cfg->num_channels;
 
 	if (num_channels == 1) {
-		media_format->channel_mapping[0] = PCM_CHANNEL_L;
+		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
 	} else if (num_channels == 2) {
-		media_format->channel_mapping[0] = PCM_CHANNEL_L;
-		media_format->channel_mapping[1] = PCM_CHANNEL_R;
+		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
+		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
 	}
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index e38111ffd7b9..2c82917b7162 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -158,8 +158,6 @@ struct param_id_enc_bitrate_param {
 
 #define MEDIA_FMT_ID_PCM	0x09001000
 #define MEDIA_FMT_ID_MP3	0x09001009
-#define PCM_CHANNEL_L		1
-#define PCM_CHANNEL_R		2
 #define SAMPLE_RATE_48K		48000
 #define BIT_WIDTH_16		16
 
-- 
2.34.1

