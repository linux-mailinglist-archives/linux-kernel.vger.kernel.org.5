Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82A7D2F21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjJWJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjJWJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:55:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4910D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:55:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32003aae100so2389616f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054911; x=1698659711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G81EZhNEBfjywIhuDWJjtpTXYP61176MP839Y8OZoG8=;
        b=lHOLSFUc0yK7Ro+MNrul4bf5L+2cj3y+D/gX6YW5Pj+FKibWdu8iplLyLvCTxmygYD
         YH7cXdyN/KUjsLkK4/m+u/sRyop/blbjSfhT4Jl6bhkQAI62YFlTY/TW7BRk2GP8OmDM
         lmFU6jCnbRr0lw/r0kqAkYnR2FcJkRVoPGLIOMwkc1UIyw5W7cQLT/+uJdFncBFAKkXF
         FjE3ApzCTEpTKv3pmE5WFjvH4mBNHitMwYgPTGUdZqtgsRTGcqtGcStvDwqUZt3/Bcod
         TXqYkOybMDJENO801txAvYhXZeCaOJDyh5ckTdVT8J/nIQU1ZJAtUww31tZSMosi/E1Q
         AgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054911; x=1698659711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G81EZhNEBfjywIhuDWJjtpTXYP61176MP839Y8OZoG8=;
        b=BeR/o986pIWUlotqw7AnG4Nm0wallArnL2ueKQtCOwQH1VhS47a3r5tAU5s0W4G8MO
         jDuS8/SXtyTyPXWSZ0JSEUn88jTJSFJbGSeba+X27h+58Bs/G0d3rvAhMaKwpN85RXQc
         fFE+w2ivwjDocXbNBH3nITltQFpxRrdwkIUhuMu6JJFukBxBn52AFl3Fvt00KLN/vTGc
         3yKVewZ+qEjWzH2SwgwZzs1eKgiZLZCbsXtI1lPOGqb2C0MZ8RLNx7cP3623c1D2Aw6Q
         pWiqGtYwUjDWl6+7cXnM2pvthBWSqYf3vioP1glxMM+kX/hjoIDledz83r1jPbuZpXVj
         qHyw==
X-Gm-Message-State: AOJu0Yz79rd3b0gj5Y8m4tn2i5b/UfjoIhdHRvj8ZWVp8ZPtwLhNcoWP
        0ejOqCJZ4Zg7PRnZGkObKp7y/A==
X-Google-Smtp-Source: AGHT+IF2iXpBOUlnIxhQVTQ1O4HJJuZY9k94V739kocrPuR1iW5RroQxWCPWTyJ4Y36tYCQLJLsx0Q==
X-Received: by 2002:adf:a499:0:b0:32d:a3f7:f0dd with SMTP id g25-20020adfa499000000b0032da3f7f0ddmr10781049wrb.25.1698054911534;
        Mon, 23 Oct 2023 02:55:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:55:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 17/17] ASoC: tegra: machine: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:28 +0200
Message-Id: <20231023095428.166563-18-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
References: <20231023095428.166563-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use snd_soc_dapm_widget_name_cmp() helper when comparing widget names,
to include also the component's name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/tegra/tegra_asoc_machine.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index 3caadee9584f..192e9692bdf2 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -81,19 +81,23 @@ static int tegra_machine_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct tegra_machine *machine = snd_soc_card_get_drvdata(dapm->card);
 
-	if (!strcmp(w->name, "Int Spk") || !strcmp(w->name, "Speakers"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Int Spk") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Speakers"))
 		gpiod_set_value_cansleep(machine->gpiod_spkr_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Mic Jack") || !strcmp(w->name, "Headset Mic"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Mic Jack") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Headset Mic"))
 		gpiod_set_value_cansleep(machine->gpiod_ext_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Int Mic") || !strcmp(w->name, "Internal Mic 2"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Int Mic") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Internal Mic 2"))
 		gpiod_set_value_cansleep(machine->gpiod_int_mic_en,
 					 SND_SOC_DAPM_EVENT_ON(event));
 
-	if (!strcmp(w->name, "Headphone") || !strcmp(w->name, "Headphone Jack"))
+	if (!snd_soc_dapm_widget_name_cmp(w, "Headphone") ||
+	    !snd_soc_dapm_widget_name_cmp(w, "Headphone Jack"))
 		gpiod_set_value_cansleep(machine->gpiod_hp_mute,
 					 !SND_SOC_DAPM_EVENT_ON(event));
 
-- 
2.34.1

