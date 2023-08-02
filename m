Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30F76D645
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjHBR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjHBR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CB326A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so1327695e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999108; x=1691603908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tKsk9a4HVB+S55ZghOAU5wwthWw0fqP95yqfmB/mNM=;
        b=ckvh3W+OUeJ7+Uj1dkezwP69ylQ4jMSPMBJAdJM8Qlk7PWfAU/iOqdG1Rto7DD6h55
         TqRRRZA6G96XtSZG/TvqpfP6S9xE34giI8AiFf/cvdIOe2WM2PzJbA2f8KMxQLeZA8NY
         MJEbnD9jaQlUV98eo+bRqc/UNiDvhIOVbwUZBwB7ZFOUwvos6y8dLPgXEIczMURVTOTx
         IKKPpCOBg+PaSefqX/zuPfeiKXa6OaEXDj9aus9LSPN8rybAFjnO0PZZB79gr66Zce9l
         qkjZZTH2ZzDQprQEK+4EjTVTp2lyz7Hh0Q8BjMu5YsnBEIMMahrRrKNXkZ+ZWRFduINF
         AvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999108; x=1691603908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tKsk9a4HVB+S55ZghOAU5wwthWw0fqP95yqfmB/mNM=;
        b=igmRZXdTq7Bn20TN9Y9QGFsXJR/d1jySHN6195PSj42mKUD/1VpqDhjIvI+gvTkHdg
         1u8BfHA+CzuH7YIKF+ghBuch5lpIOCodSNN75L5AaZD7tVtmS2f5JvbMxKWFcaOCDn0C
         T2+AUBK9aDDt6Dg/E1QRSUsvQ4MZzKkcyBPOCmtg49gr2NHiXy9QAR8kpMYAWPq3z4cE
         bxnaU6HOx/ocY5q3nnKDBHiuUjzpy8fWTaN+Cd7xCwLPzErb6i71ozfAMUAyGgnKVXcI
         bTCD4MX4m+QVGWk249iKMm+TZVZMZ3/iM6T1gWotU3i7WRzNCIytILpRzu5yvPl4GPaM
         lNrw==
X-Gm-Message-State: ABy/qLazXhRvdyHOVaZ2aPt55GcVCgjQp5Fm2kZ5TBOyp9ODAlokwN1T
        +urN/3GBnV/aX02FQ/A9SKw=
X-Google-Smtp-Source: APBJJlEF8cOYoAUKlqHUoCLkwAgJHMLQWtyJ153NH2rnGdVlOoGWexOb01jQilkY+8Ksa0H6pPGIwQ==
X-Received: by 2002:a05:600c:2297:b0:3fe:6f7:60aa with SMTP id 23-20020a05600c229700b003fe06f760aamr5661333wmf.12.1690999107976;
        Wed, 02 Aug 2023 10:58:27 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:58:27 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 17/27] ASoC: mediatek: mt8183-mt6358-ts3a227-max98357: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:27 +0300
Message-Id: <20230802175737.263412-18-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802175737.263412-1-alpernebiyasak@gmail.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not properly map jack pins to kcontrols that PulseAudio
and PipeWire need to handle jack detection events. The TS3A227 component
used here can detect Headphones and Headset Mic connections. Expose each
to userspace as kcontrols and add the necessary widgets.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Tested on a "Cozmo" Chromebook.

 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 53 ++++++++++++++++---
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index ce9aedde7e1e..850f4d949d97 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -592,11 +592,38 @@ static struct snd_soc_dai_link mt8183_mt6358_ts3a227_dai_links[] = {
 	},
 };
 
+static const
+struct snd_kcontrol_new mt8183_mt6358_ts3a227_max98357_snd_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const
+struct snd_soc_dapm_widget mt8183_mt6358_ts3a227_max98357_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
+static struct snd_soc_jack_pin mt8183_mt6358_ts3a227_max98357_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static struct snd_soc_card mt8183_mt6358_ts3a227_max98357_card = {
 	.name = "mt8183_mt6358_ts3a227_max98357",
 	.owner = THIS_MODULE,
 	.dai_link = mt8183_mt6358_ts3a227_dai_links,
 	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_dai_links),
+	.controls = mt8183_mt6358_ts3a227_max98357_snd_controls,
+	.num_controls = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_snd_controls),
+	.dapm_widgets = mt8183_mt6358_ts3a227_max98357_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_dapm_widgets),
 };
 
 static struct snd_soc_card mt8183_mt6358_ts3a227_max98357b_card = {
@@ -604,6 +631,10 @@ static struct snd_soc_card mt8183_mt6358_ts3a227_max98357b_card = {
 	.owner = THIS_MODULE,
 	.dai_link = mt8183_mt6358_ts3a227_dai_links,
 	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_dai_links),
+	.controls = mt8183_mt6358_ts3a227_max98357_snd_controls,
+	.num_controls = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_snd_controls),
+	.dapm_widgets = mt8183_mt6358_ts3a227_max98357_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_dapm_widgets),
 };
 
 static struct snd_soc_codec_conf mt8183_mt6358_ts3a227_rt1015_amp_conf[] = {
@@ -624,6 +655,10 @@ static struct snd_soc_card mt8183_mt6358_ts3a227_rt1015_card = {
 	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_dai_links),
 	.codec_conf = mt8183_mt6358_ts3a227_rt1015_amp_conf,
 	.num_configs = ARRAY_SIZE(mt8183_mt6358_ts3a227_rt1015_amp_conf),
+	.controls = mt8183_mt6358_ts3a227_max98357_snd_controls,
+	.num_controls = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_snd_controls),
+	.dapm_widgets = mt8183_mt6358_ts3a227_max98357_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_dapm_widgets),
 };
 
 static struct snd_soc_card mt8183_mt6358_ts3a227_rt1015p_card = {
@@ -631,6 +666,10 @@ static struct snd_soc_card mt8183_mt6358_ts3a227_rt1015p_card = {
 	.owner = THIS_MODULE,
 	.dai_link = mt8183_mt6358_ts3a227_dai_links,
 	.num_links = ARRAY_SIZE(mt8183_mt6358_ts3a227_dai_links),
+	.controls = mt8183_mt6358_ts3a227_max98357_snd_controls,
+	.num_controls = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_snd_controls),
+	.dapm_widgets = mt8183_mt6358_ts3a227_max98357_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_dapm_widgets),
 };
 
 static int
@@ -641,12 +680,14 @@ mt8183_mt6358_ts3a227_max98357_headset_init(struct snd_soc_component *component)
 			snd_soc_card_get_drvdata(component->card);
 
 	/* Enable Headset and 4 Buttons Jack detection */
-	ret = snd_soc_card_jack_new(component->card,
-				    "Headset Jack",
-				    SND_JACK_HEADSET |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &priv->headset_jack);
+	ret = snd_soc_card_jack_new_pins(component->card,
+					 "Headset Jack",
+					 SND_JACK_HEADSET |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &priv->headset_jack,
+					 mt8183_mt6358_ts3a227_max98357_jack_pins,
+					 ARRAY_SIZE(mt8183_mt6358_ts3a227_max98357_jack_pins));
 	if (ret)
 		return ret;
 
-- 
2.40.1

