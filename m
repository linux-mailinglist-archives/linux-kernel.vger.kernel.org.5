Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C27D2F24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjJWJz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjJWJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:55:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E7F199B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:55:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c91582fdso4518742e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698054902; x=1698659702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sijvR+hKjJi+AfXfyjsruHtUHe1YLoATqzDljEq9PNo=;
        b=fOHIyn96SAslkpwLxZEuEGRU1rnhf6L7DyhsmslymgS+8I8s7wLHtRqDnBfVat1yCX
         OcJXZq7v6qYI7Af9J6A6sHmhmthXDdkddxxApb8uLOvxaC18kCzfXg8iNO2YSy47drCh
         96Kcutur89DOJHfRr8Ro5IB0yL5p9bU+YxxnHQFO0kNCAPOrpx9bFQOXcjM4GU/SEK9h
         gdt4fxTs9OFGN+gJwAF5MTWdfG/013zTDc80/XHpKIX8DR7ik93i/2Nrn8q35R52yrg6
         aUhlKz5rgaXdP7U24Orc7vboK8ya4lFcm1qsJrd81oi1wcf0+NC4i9HVgKcLy8hS/ppu
         Xr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698054902; x=1698659702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sijvR+hKjJi+AfXfyjsruHtUHe1YLoATqzDljEq9PNo=;
        b=uSlA2T3DPdo7DIKJp7M4+txP/XqPN6dm96YHMZVWL7rwNfRLQiLNSiVvdWfF/KkWt2
         66kyyBNzagEZQUq4bvTJAGxVGoBjSvnMft8W7+/nm8Hc0SmjgkdpUEVTYMjcUyKeuMVd
         XH96mFzH8fYn2PZ/ZGLde1QbGBSIe3xw78DLlstx2Io690gMp+xR80eoD3twCOEvLVL6
         JYR9ER5KGHb60IIt+I4h1xUMDQJVJQZCaiZLBrHv/HIrAuWyIfoC5lNbBrv9ndHubZzB
         bT/6G1qg5V8fbNYqAuz9DKTFutURZ/PZAvRO2Bjr2jVYAyZc1ocVFRxlT9RJii8vctuy
         6IwQ==
X-Gm-Message-State: AOJu0YzsalBOHBPCIEvPhf4fzqLTt1ieOU19ne24GEgfdDpYkrkMLNFb
        8IyDZqQ4SvUes/70U5ZYUwH/aA==
X-Google-Smtp-Source: AGHT+IF54Qe6n/zvNqpT0Lxz4KVrjRL1LPUYGQ1mvRY5NOKen/Ok/2JBtT1ZFsNaf/o7AVD7jqRWnw==
X-Received: by 2002:a2e:a792:0:b0:2bf:e9e8:de23 with SMTP id c18-20020a2ea792000000b002bfe9e8de23mr7862726ljf.16.1698054902708;
        Mon, 23 Oct 2023 02:55:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d468e000000b00323330edbc7sm7428801wrq.20.2023.10.23.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:55:02 -0700 (PDT)
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
Subject: [RFT PATCH 13/17] ASoC: mediatek: mt8186: Handle component name prefix
Date:   Mon, 23 Oct 2023 11:54:24 +0200
Message-Id: <20231023095428.166563-14-krzysztof.kozlowski@linaro.org>
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
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c    | 2 +-
 sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c | 2 +-
 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c     | 4 ++--
 sound/soc/mediatek/mt8186/mt8186-dai-src.c     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index 247ab8df941f..85ae3f76d951 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -321,7 +321,7 @@ static int mtk_adda_mtkaif_cfg_event(struct snd_soc_dapm_widget *w,
 					   MTKAIF_RXIF_CLKINV_ADC_MASK_SFT,
 					   BIT(MTKAIF_RXIF_CLKINV_ADC_SFT));
 
-			if (strcmp(w->name, "ADDA_MTKAIF_CFG") == 0) {
+			if (snd_soc_dapm_widget_name_cmp(w, "ADDA_MTKAIF_CFG") == 0) {
 				if (afe_priv->mtkaif_chosen_phase[0] < 0 &&
 				    afe_priv->mtkaif_chosen_phase[1] < 0) {
 					dev_err(afe->dev,
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c b/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
index 33edd6cbde12..75cb30790b1b 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-hw-gain.c
@@ -47,7 +47,7 @@ static int mtk_hw_gain_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (strcmp(w->name, HW_GAIN_1_EN_W_NAME) == 0) {
+		if (snd_soc_dapm_widget_name_cmp(w, HW_GAIN_1_EN_W_NAME) == 0) {
 			gain_cur = AFE_GAIN1_CUR;
 			gain_con1 = AFE_GAIN1_CON1;
 		} else {
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
index f07181be4370..7c4021221950 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-i2s.c
@@ -393,13 +393,13 @@ static int mtk_apll_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (strcmp(w->name, APLL1_W_NAME) == 0)
+		if (snd_soc_dapm_widget_name_cmp(w, APLL1_W_NAME) == 0)
 			mt8186_apll1_enable(afe);
 		else
 			mt8186_apll2_enable(afe);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		if (strcmp(w->name, APLL1_W_NAME) == 0)
+		if (snd_soc_dapm_widget_name_cmp(w, APLL1_W_NAME) == 0)
 			mt8186_apll1_disable(afe);
 		else
 			mt8186_apll2_disable(afe);
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-src.c b/sound/soc/mediatek/mt8186/mt8186-dai-src.c
index 67989ffd67ca..e475f4591aef 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-src.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-src.c
@@ -322,7 +322,7 @@ static int mtk_hw_src_event(struct snd_soc_dapm_widget *w,
 	struct mtk_afe_src_priv *src_priv;
 	unsigned int reg;
 
-	if (strcmp(w->name, HW_SRC_1_EN_W_NAME) == 0)
+	if (snd_soc_dapm_widget_name_cmp(w, HW_SRC_1_EN_W_NAME) == 0)
 		id = MT8186_DAI_SRC_1;
 	else
 		id = MT8186_DAI_SRC_2;
@@ -487,7 +487,7 @@ static int mtk_afe_src_en_connect(struct snd_soc_dapm_widget *source,
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	struct mtk_afe_src_priv *src_priv;
 
-	if (strcmp(w->name, HW_SRC_1_EN_W_NAME) == 0)
+	if (snd_soc_dapm_widget_name_cmp(w, HW_SRC_1_EN_W_NAME) == 0)
 		src_priv = afe_priv->dai_priv[MT8186_DAI_SRC_1];
 	else
 		src_priv = afe_priv->dai_priv[MT8186_DAI_SRC_2];
-- 
2.34.1

