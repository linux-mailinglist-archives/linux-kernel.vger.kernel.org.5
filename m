Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169D7CC888
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjJQQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjJQQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:14:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D7F5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:14:34 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b95622c620so1026595866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697559273; x=1698164073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqta/Ta79wVcWXCXNCV11oVf8kvXjcJa0MxKMtJZ3AE=;
        b=KbTdpFz48WmFcRTOeOKW/UwFo1+n5TmRZ9IfDDdVSlhoTPmYIFY8v3fGAJGp3N3P/p
         U7mJlrbveKwVHTi5vh0Y5Kprn0ijteR+rKwUQWtriJaxAz3S3tHq6svSdbSZ/kWYp/Bv
         T9+FJmDa2zcgrcZU3Is3uuzUxiM81d0sM8l/rSDCA6zphHRuDRKis+2aYo1AE8x9NcAO
         rmxsLrvOoFK52Bo9QpekfdZYfas63MDLUaZtbf23WH7SQ8XRO5sekFBHw7Czg6N2W6me
         TiY1zSIupMnpXMgwr01hHA4fPJ9l4m/LuA93oMaA4RxoCjOym0ysh/kgrQExJ+Bnd8LZ
         43pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559273; x=1698164073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sqta/Ta79wVcWXCXNCV11oVf8kvXjcJa0MxKMtJZ3AE=;
        b=Ch8e0M7S/HTg5LU7Qyki1YPXeQ6bxpJGIX6O4qK7r6bFn/fqefG/pw5PtRrOubN0gG
         rjuyVFcMLawSKdzim60TSYNPDSMEvbqwLwSZC2CUYGwW2y3HijMFAwa6mcetJeR0jd/p
         5fzUAbUoERED7HD5cCmaW4Uz/TigPMOdsrmB5OUY4Z9fFWYzmb+nFwujHahiwNx+DlUa
         /hvHNalTct92iZaDp4BOl+5Iy/EnGfKvrXHYuzXntAz9rN2gi2oGq8gl0l8VEqnPsrwK
         KN//Q5U7GPcOMdF28GhQlu30h7C7GOM/QsazITKsQBLJyIk52hDYpZeEstadau1mgX8C
         ewng==
X-Gm-Message-State: AOJu0YwbH4n1YyMh8UXKSkkCwb4lHmoeXjRpBeOVL/lKyaOKecxlZLEv
        fTMVylvk2PjDNp8JJGdRsgVs4Q==
X-Google-Smtp-Source: AGHT+IEkArJiEQ52iBEL5uXIZHn0gatrsf9WltFV37rGzxsJzomcF8p1Va5TsIwC72FuiYd/Ek1LDg==
X-Received: by 2002:a17:907:c19:b0:9ad:a59f:331a with SMTP id ga25-20020a1709070c1900b009ada59f331amr2485924ejc.57.1697559273257;
        Tue, 17 Oct 2023 09:14:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906190e00b0099b7276235esm78040eje.93.2023.10.17.09.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:14:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: q6apm-lpass-dais: pass max number of channels to Audioreach
Date:   Tue, 17 Oct 2023 18:14:29 +0200
Message-Id: <20231017161429.431663-1-krzysztof.kozlowski@linaro.org>
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

Using the params_channels() helper when setting hw_params, results in
passing to Audioreach minimum number of channels valid for given
hardware.  This is not valid for any hardware which sets minimum
channels to two and maximum to something bigger, like four channels.

Instead pass the maximum number of supported channels to allow playback
of multi-channel formats.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 7ad604b80e25..c5e065a21e27 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -97,7 +97,7 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 {
 	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct audioreach_module_config *cfg = &dai_data->module_config[dai->id];
-	int channels = params_channels(params);
+	int channels = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max;
 	int ret;
 
 	cfg->bit_width = params_width(params);
@@ -130,7 +130,7 @@ static int q6dma_hw_params(struct snd_pcm_substream *substream,
 
 	cfg->bit_width = params_width(params);
 	cfg->sample_rate = params_rate(params);
-	cfg->num_channels = params_channels(params);
+	cfg->num_channels = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max;
 
 	return 0;
 }
-- 
2.34.1

