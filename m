Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C254776D635
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjHBR60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjHBR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:58:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B900170D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:58:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so1268875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690999080; x=1691603880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8q6oeJAXCtu9hv15ODqXQ4DGTBLuJ63S8PbYuJF85k=;
        b=hvqAAqCj6zLmA/e0ULUUNBKF+kdiqCvNGh4AfBHwGFDJ7Rbwbps4cpWNjeCUwQi1Fy
         O+lf+6UUgcFb8NSipYOOu1CQCXQOdWGEe6JYUM6xwdGZMm/Ce9m/KBAN5k0lvEUUH0uk
         yxcd4hlJOJvCRPXZU7lNwuM7JW0oYDgbB1/tHAIXhTJf0OSkLPza5GHCY+idS2GbTR5e
         zzJQkTO9jGj8gy5+GHCHrkLFs+tcOfCvnBKkwhAVCy5LyNLTU0QT/LVbvaKA5w0/uruD
         ndTFEMw+SsH2n9nEWRm9ZLkXoby/GshpBmXmQTkaeBH0XJjzVr5XKlHIQKGymR8/cCHv
         30/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690999080; x=1691603880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8q6oeJAXCtu9hv15ODqXQ4DGTBLuJ63S8PbYuJF85k=;
        b=HFRiyCKW8C+p27U/wBWe1WkBxIKvqaY/V1YqXjozz5wh1nkv2qUOLo0gcBLD5f0Q17
         LSdx/7AN9rUwNkudbltRbPplnnKYJzA6SPkgsFX2Ta1D9WOWwO6mn7O8vYJEQ53OSVF4
         bhpciP2hA+AKQtReLA7MzW5oM/HYvrhnOjU1MAkT3cPMH0BpOXGjmPShhA26cxkpQnGF
         8l+hEs8GNOAIzE39tov56cCIeo1H/hIzQXLJqelqXYfXLY0gka4ugcrtLWd17pIqYDK1
         zrzoZfUYWvcMDAypJ/GHmnhqylVmbiMxwcdZB5hg5+JWSMxl5O0FRwSmo4UGaZxXK6sR
         frGw==
X-Gm-Message-State: ABy/qLa58JSNttO+pS6G59tTz4FUVXzFN38sAPnRU53seeDWnJiXK/pg
        pkfg9Pp8s252jeb7IugKk5E=
X-Google-Smtp-Source: APBJJlGUrfqpF/yOLbHFeZQc7xwlzqX/qHeUy+3Q3sxp65BzfkvHzfmYba5BF+W7DC9EZ6VUK/bQsw==
X-Received: by 2002:a5d:428f:0:b0:314:2f5b:2ce with SMTP id k15-20020a5d428f000000b003142f5b02cemr5303270wrq.12.1690999080395;
        Wed, 02 Aug 2023 10:58:00 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b003fe20db88ebsm2192439wmi.31.2023.08.02.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:57:59 -0700 (PDT)
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
Subject: [PATCH 03/27] ASoC: amd: acp: Map missing jack kcontrols
Date:   Wed,  2 Aug 2023 20:57:13 +0300
Message-Id: <20230802175737.263412-4-alpernebiyasak@gmail.com>
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
and PipeWire need to handle jack detection events. The RT5682, RT5682s,
NAU8825 and NAU8821 codecs used here can detect Headphone and Headset
Mic connections. Expose both to userspace as kcontrols and add the
necessary widgets. Split the jack and pin structs per-codec to
accommodate for per-codec differences.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Do I have to keep the lowercase "jack" in the last one instead?
Should the SND_JACK_LINEOUT be removed from the jack_new_pins calls?
I don't know why it was split as vg_headset / pco_jack, maybe everything
could be merged instead?

 sound/soc/amd/acp/acp-mach-common.c | 226 ++++++++++++++++++++++------
 1 file changed, 182 insertions(+), 44 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index ff5cbc4a6427..f3abaa182fbb 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -28,7 +28,6 @@
 #include "../../codecs/nau8821.h"
 #include "acp-mach.h"
 
-static struct snd_soc_jack vg_headset;
 #define PCO_PLAT_CLK 48000000
 #define RT5682_PLL_FREQ (48000 * 512)
 #define DUAL_CHANNEL	2
@@ -52,8 +51,6 @@ const struct dmi_system_id acp_quirk_table[] = {
 };
 EXPORT_SYMBOL_GPL(acp_quirk_table);
 
-static struct snd_soc_jack pco_jack;
-
 static const unsigned int channels[] = {
 	DUAL_CHANNEL,
 };
@@ -87,6 +84,28 @@ static int acp_clk_enable(struct acp_card_drvdata *drvdata,
 SND_SOC_DAILINK_DEF(rt5682,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5682:00", "rt5682-aif1")));
 
+static struct snd_soc_jack rt5682_jack;
+static struct snd_soc_jack_pin rt5682_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new rt5682_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_widget rt5682_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
 static const struct snd_soc_dapm_route rt5682_map[] = {
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
@@ -110,22 +129,38 @@ static int acp_card_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 	drvdata->wclk = clk_get(component->dev, "rt5682-dai-wclk");
 	drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &pco_jack);
+	ret = snd_soc_dapm_new_controls(&card->dapm, rt5682_widgets,
+					ARRAY_SIZE(rt5682_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, rt5682_controls,
+					ARRAY_SIZE(rt5682_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &rt5682_jack,
+					 rt5682_jack_pins,
+					 ARRAY_SIZE(rt5682_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
 	}
 
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	snd_jack_set_key(rt5682_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(rt5682_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(rt5682_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(rt5682_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
+	ret = snd_soc_component_set_jack(component, &rt5682_jack, NULL);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
 		return ret;
@@ -275,6 +310,28 @@ static const struct snd_soc_ops acp_card_rt5682_ops = {
 SND_SOC_DAILINK_DEF(rt5682s,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-RTL5682:00", "rt5682s-aif1")));
 
+static struct snd_soc_jack rt5682s_jack;
+static struct snd_soc_jack_pin rt5682s_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new rt5682s_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_widget rt5682s_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
 static const struct snd_soc_dapm_route rt5682s_map[] = {
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
@@ -299,22 +356,38 @@ static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 		drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
 	}
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &pco_jack);
+	ret = snd_soc_dapm_new_controls(&card->dapm, rt5682s_widgets,
+					ARRAY_SIZE(rt5682s_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, rt5682s_controls,
+					ARRAY_SIZE(rt5682s_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &rt5682s_jack,
+					 rt5682s_jack_pins,
+					 ARRAY_SIZE(rt5682s_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
 	}
 
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	snd_jack_set_key(rt5682s_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(rt5682s_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(rt5682s_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(rt5682s_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
+	ret = snd_soc_component_set_jack(component, &rt5682s_jack, NULL);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
 		return ret;
@@ -762,6 +835,28 @@ static const struct snd_soc_ops acp_max98388_ops = {
 SND_SOC_DAILINK_DEF(nau8825,
 		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10508825:00", "nau8825-hifi")));
 
+static struct snd_soc_jack nau8825_jack;
+static struct snd_soc_jack_pin nau8825_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new nau8825_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_widget nau8825_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
 static const struct snd_soc_dapm_route nau8825_map[] = {
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
@@ -780,22 +875,38 @@ static int acp_card_nau8825_init(struct snd_soc_pcm_runtime *rtd)
 	if (drvdata->hs_codec_id != NAU8825)
 		return -EINVAL;
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
+	ret = snd_soc_dapm_new_controls(&card->dapm, nau8825_widgets,
+					ARRAY_SIZE(nau8825_widgets));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add widget dapm controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_add_card_controls(card, nau8825_controls,
+					ARRAY_SIZE(nau8825_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
 					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
 					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
-					 &pco_jack);
+					 &nau8825_jack,
+					 nau8825_jack_pins,
+					 ARRAY_SIZE(nau8825_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "HP jack creation failed %d\n", ret);
 		return ret;
 	}
 
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	snd_jack_set_key(nau8825_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(nau8825_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(nau8825_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(nau8825_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
+	ret = snd_soc_component_set_jack(component, &nau8825_jack, NULL);
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
 		return ret;
@@ -921,8 +1032,25 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
+static struct snd_soc_jack nau8821_jack;
+static struct snd_soc_jack_pin nau8821_jack_pins[] = {
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new nau8821_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
 static const struct snd_soc_dapm_widget nau8821_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
@@ -932,12 +1060,12 @@ static const struct snd_soc_dapm_widget nau8821_widgets[] = {
 
 static const struct snd_soc_dapm_route nau8821_audio_route[] = {
 	/* HP jack connectors - unknown if we have jack detection */
-	{ "Headphone jack", NULL, "HPOL" },
-	{ "Headphone jack", NULL, "HPOR" },
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
 	{ "MICL", NULL, "Headset Mic" },
 	{ "MICR", NULL, "Headset Mic" },
 	{ "DMIC", NULL, "Int Mic" },
-	{ "Headphone jack", NULL, "Platform Clock" },
+	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
 	{ "Int Mic", NULL, "Platform Clock" },
 };
@@ -966,21 +1094,31 @@ static int acp_8821_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
-				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
-				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
-				    &vg_headset);
+	ret = snd_soc_add_card_controls(card, nau8821_controls,
+					ARRAY_SIZE(nau8821_controls));
+	if (ret) {
+		dev_err(rtd->dev, "unable to add card controls, ret %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
+					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
+					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
+					 &nau8821_jack,
+					 nau8821_jack_pins,
+					 ARRAY_SIZE(nau8821_jack_pins));
 	if (ret) {
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
 	}
-	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
 
-	nau8821_enable_jack_detect(component, &vg_headset);
+	snd_jack_set_key(nau8821_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(nau8821_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(nau8821_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(nau8821_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	nau8821_enable_jack_detect(component, &nau8821_jack);
 
 	return snd_soc_dapm_add_routes(&rtd->card->dapm, nau8821_audio_route,
 				       ARRAY_SIZE(nau8821_audio_route));
-- 
2.40.1

