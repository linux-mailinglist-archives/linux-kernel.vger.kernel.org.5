Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6A7CFDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbjJSPgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346243AbjJSPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:36:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EEC131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:36:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so13618773a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729761; x=1698334561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BSOa/ysYuWf3yTm4IHQkqxUatJT3g/WJSTaVnMkDXw=;
        b=U6EaI4JmXBa6T8cRii5JOaLUIAl78xFi3E5IZlfWacACugJkoUtXQNvTyuHJ8Ke/J8
         vN+kZ39FchhE4FKqwQmm0aqumVagbj2jhbyetY5J7l/1HasyzsUo6zzNL6cN2bQgj2AG
         pDNJ2faAJ5wNU9A13gBxh62wRP7PXuazKgqKmXdOheksOKLoM23y5zWORSgaBzXKURn3
         LwQMaPHb048QWk2d5UkmBuW8wj228YTpzQDKNSnpAbZQp//YGpPuteuExshRq5C2ziok
         BSVJQJ7s8kMpac6fW44Rra9SV6Yfkkm/pZ+gsMDTbAp8NT8TVQJdvY72nuZZVsIZTqQe
         xvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729761; x=1698334561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BSOa/ysYuWf3yTm4IHQkqxUatJT3g/WJSTaVnMkDXw=;
        b=Xsp47zg29NOIbOKT56UZtorXQjohb2krvLfxLdMkk2Je6pmxrEfKvFufnPejWqEwn/
         rxYKy5qqjL1G4Moe1SV7IOjpekEyYaga9USprb0PO+p2tcVqCsCS/c6dyL8F/hG8Jd7Z
         iLia9JZxiDD23ia4qR2I6Yg9xOc4OeihETDDQ05SymP4UnpXBXHSJKAu71LZeVZn+8x4
         q9dBuUWHJpY2M2stHtTs3UQmnyc7443z7XPlXgyDN/Xsuzt+UqWsI1oYsTEg0IYTiGIO
         CQ3pYwoU2QxqG+Chh/knzieJ/4gSS4UmavMFgR9m3cr5kM2sojiPNzvQ1pgFfDPV60Wr
         QYww==
X-Gm-Message-State: AOJu0YyHwKGK7PTi3LyAualb05guqjUbI2yxzV5gLINY1o0xTLyFHQw1
        /UCCRQYoU9gTA0VEdSpmGdPYSw==
X-Google-Smtp-Source: AGHT+IFXYH7+hKuQQl+Fqbwy+yO2TSI4ihbMrNPxs0SPhL+f20RzcSdgUJdVyGGNe4Mo2eUVbR2SKA==
X-Received: by 2002:a50:9e87:0:b0:53e:34c5:ad8e with SMTP id a7-20020a509e87000000b0053e34c5ad8emr2060982edf.19.1697729761711;
        Thu, 19 Oct 2023 08:36:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id c64-20020a509fc6000000b0053ebafe7a60sm4743875edf.59.2023.10.19.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:36:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: Add support for WSA2 LPASS
Date:   Thu, 19 Oct 2023 17:35:41 +0200
Message-Id: <20231019153541.49753-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019153541.49753-1-krzysztof.kozlowski@linaro.org>
References: <20231019153541.49753-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Qualcomm WSA2 LPASS (Low Power Audio SubSystem) audio
ports to several Qualcomm ADSP drivers: Q6APM LPASS DAIs, Q6DSP LPASS
ports and shared Q6DSP Soundwire code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c  | 5 +++++
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c | 6 ++++++
 sound/soc/qcom/sdw.c                     | 5 +++++
 3 files changed, 16 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index c5e065a21e27..2ae10f9dc78e 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -36,6 +36,9 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 	case WSA_CODEC_DMA_TX_0:
 	case WSA_CODEC_DMA_TX_1:
 	case WSA_CODEC_DMA_TX_2:
+	case WSA2_CODEC_DMA_TX_0:
+	case WSA2_CODEC_DMA_TX_1:
+	case WSA2_CODEC_DMA_TX_2:
 	case VA_CODEC_DMA_TX_0:
 	case VA_CODEC_DMA_TX_1:
 	case VA_CODEC_DMA_TX_2:
@@ -60,6 +63,8 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 		break;
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
+	case WSA2_CODEC_DMA_RX_0:
+	case WSA2_CODEC_DMA_RX_1:
 	case RX_CODEC_DMA_RX_0:
 	case RX_CODEC_DMA_RX_1:
 	case RX_CODEC_DMA_RX_2:
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
index 4919001de08b..a6502884531d 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c
@@ -557,6 +557,11 @@ static struct snd_soc_dai_driver q6dsp_audio_fe_dais[] = {
 	Q6AFE_CDC_DMA_RX_DAI(WSA_CODEC_DMA_RX_1),
 	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_1),
 	Q6AFE_CDC_DMA_TX_DAI(WSA_CODEC_DMA_TX_2),
+	Q6AFE_CDC_DMA_RX_DAI(WSA2_CODEC_DMA_RX_0),
+	Q6AFE_CDC_DMA_TX_DAI(WSA2_CODEC_DMA_TX_0),
+	Q6AFE_CDC_DMA_RX_DAI(WSA2_CODEC_DMA_RX_1),
+	Q6AFE_CDC_DMA_TX_DAI(WSA2_CODEC_DMA_TX_1),
+	Q6AFE_CDC_DMA_TX_DAI(WSA2_CODEC_DMA_TX_2),
 	Q6AFE_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_0),
 	Q6AFE_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_1),
 	Q6AFE_CDC_DMA_TX_DAI(VA_CODEC_DMA_TX_2),
@@ -622,6 +627,7 @@ struct snd_soc_dai_driver *q6dsp_audio_ports_set_config(struct device *dev,
 			q6dsp_audio_fe_dais[i].ops = cfg->q6tdm_ops;
 			break;
 		case WSA_CODEC_DMA_RX_0 ... RX_CODEC_DMA_RX_7:
+		case WSA2_CODEC_DMA_RX_0 ... WSA2_CODEC_DMA_TX_2:
 			q6dsp_audio_fe_dais[i].ops = cfg->q6dma_ops;
 			break;
 		default:
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 1a41419c7eb8..612865b26f88 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -21,6 +21,8 @@ int qcom_snd_sdw_prepare(struct snd_pcm_substream *substream,
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
+	case WSA2_CODEC_DMA_RX_0:
+	case WSA2_CODEC_DMA_RX_1:
 	case RX_CODEC_DMA_RX_0:
 	case RX_CODEC_DMA_RX_1:
 	case TX_CODEC_DMA_TX_0:
@@ -70,6 +72,7 @@ int qcom_snd_sdw_hw_params(struct snd_pcm_substream *substream,
 
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
+	case WSA2_CODEC_DMA_RX_0:
 	case RX_CODEC_DMA_RX_0:
 	case RX_CODEC_DMA_RX_1:
 	case TX_CODEC_DMA_TX_0:
@@ -98,6 +101,8 @@ int qcom_snd_sdw_hw_free(struct snd_pcm_substream *substream,
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
+	case WSA2_CODEC_DMA_RX_0:
+	case WSA2_CODEC_DMA_RX_1:
 	case RX_CODEC_DMA_RX_0:
 	case RX_CODEC_DMA_RX_1:
 	case TX_CODEC_DMA_TX_0:
-- 
2.34.1

