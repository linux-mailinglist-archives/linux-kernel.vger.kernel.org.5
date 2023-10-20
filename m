Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683D7D12E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377797AbjJTPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377779AbjJTPei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:34:38 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F553B8;
        Fri, 20 Oct 2023 08:34:36 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 27E8B4C0D6;
        Fri, 20 Oct 2023 20:34:13 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1697816055; bh=1G83yOA3pOihJUDfxdRhCahaBLCDVm9iIdo/sbEw74s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u57TrMvUD2LYm/QOjQN1D9Med82xFogC+wkxbX2xTedwdEDaG8S25urIqltV7aW7D
         4TxEU+Bodcsxi5WlkwefEUF8jWLmRQ33n3ADF7gBYEEuM6f4hLdISRCtCPsWVC5q9n
         4dj9775yzrPGnxhPDVIszQoV/25E22pI2qyXf0yNy6oom6jAx5XJcxqo8mZpjPQF2v
         /+58vGmOLqpnd6k4ddJ15U1GfEG2p1xyXUnwiP7rw5X0CRBmAh1JF6Mieu1WKykbq/
         2ohEMAh3/qjHMl0/1gju6ppn9C49vT+V6ctDsTqLEFDdAYNHHBntJPXG/NAyifLmqw
         6OT5Bh/YsCycw==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Fri, 20 Oct 2023 20:33:47 +0500
Subject: [PATCH 2/2] ASoC: qcom: sc7180: Add support for qdsp6 baked sound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-sc7180-qdsp-sndcard-v1-2-157706b7d06f@trvn.ru>
References: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
In-Reply-To: <20231020-sc7180-qdsp-sndcard-v1-0-157706b7d06f@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     jenneron@postmarketos.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10027; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=1G83yOA3pOihJUDfxdRhCahaBLCDVm9iIdo/sbEw74s=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlMp3yBxWeHPei58OHhvH81vnygDBHXXPgYVfhR
 1B7cydUnrKJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTKd8gAKCRBDHOzuKBm/
 dYB7EACe/4fvl91OnPKs7NMSDVbv860CM3f7ZiSxRMSkDp0pzGLIYAsW4CaeilJAZRhBJAFLrfz
 unfLe2tYA9BIZU6BprVHlDjYDTRr3RZLm6y8qrFfCzcqL6kcfxvnXP7vfMz3RqgWUyG8EhhRDGA
 vDf9Do371DrNIppqj428cpCCzRFh4xC315Dh4kGy7hAUoAm6iLwsOL6o76cP68y/sBwzlR6Ifax
 UvuAHdpgB4U0ywNinUrA81iQDTvZ7P1ijrNUcRqhuUOrp56BAUAawDA1Gz1IacBImPa0zVL1SLC
 onC2LjIjjlEUThUWy/h8by3Rz5S+qJb44P4lNUEh7PZItvjOf51bB6i/AOCoIHNNyJA70FD0hhH
 Nkpsl4kd129maSN8fub7JxYQ3sEEJitL4d9+wAV90xGRx7rckhjeZxQW8QB9dEe/TqhqveOOZlm
 x4649bP7F65hpx+02rlWm/T55FMsQWT8DS4kmdpGK12mTa+7IkxZIYbBTPxz9MDdfyMkp57amSq
 WO9gXF5pavDn2QzFkOinphhI7piEX6lUPRQ6dJ9PGA+ui2Yded+DGAW5gNzdt1ZYk2aPrT7SqBC
 bE+Gmsf1p9c5HWfsK41Cm1WPczPkftV6CJvbPnoY8zdupmOzPcthFN5rkOSf9E+0UFFWNbJHCWJ
 TTcXr/cJLLE5HmA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sc7180 devices use audio adsp to play sound. The setup for this
adsp is similar to the dirrect lpass usage but requires the use of
different link ids and clocks.

This commit adds support for the qdsp based audio, reusing the common
parts like audio codec setup and jack creation.

Since the setup is mostly generic and codec specific setup is guarded
behind a check, a generic compatible is added, similar to other
platforms. Even though those changes target Acer Aspire 1 as the only
user of the adsp audio on this platform present upstream at the moment
of the commit, those changes should be either dirrectly compatible or
trivially expandable to the other devices that will be added in the
future.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 sound/soc/qcom/sc7180.c | 195 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 173 insertions(+), 22 deletions(-)

diff --git a/sound/soc/qcom/sc7180.c b/sound/soc/qcom/sc7180.c
index 8e433e309f77..b0320a74d508 100644
--- a/sound/soc/qcom/sc7180.c
+++ b/sound/soc/qcom/sc7180.c
@@ -5,6 +5,7 @@
 // sc7180.c -- ALSA SoC Machine driver for SC7180
 
 #include <dt-bindings/sound/sc7180-lpass.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -19,8 +20,10 @@
 #include "../codecs/rt5682.h"
 #include "../codecs/rt5682s.h"
 #include "common.h"
+#include "qdsp6/q6afe.h"
 
 #define DEFAULT_MCLK_RATE		19200000
+#define MI2S_BCLK_RATE			1536000
 #define RT5682_PLL1_FREQ (48000 * 512)
 
 #define DRIVER_NAME "SC7180"
@@ -133,12 +136,28 @@ static int sc7180_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int sc7180_snd_startup(struct snd_pcm_substream *substream)
+static int sc7180_qdsp_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_card *card = rtd->card;
-	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+		return sc7180_headset_init(rtd);
+	case PRIMARY_MI2S_TX:
+	case TERTIARY_MI2S_RX:
+		return 0;
+	case DISPLAY_PORT_RX:
+		return sc7180_hdmi_init(rtd);
+	default:
+		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
+			cpu_dai->id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sc7180_startup_realtek_codec(struct snd_soc_pcm_runtime *rtd)
+{
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 	int pll_id, pll_source, pll_in, pll_out, clk_id, ret;
 
@@ -154,8 +173,40 @@ static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 		clk_id = RT5682S_SCLK_S_PLL2;
 		pll_out = RT5682_PLL1_FREQ;
 		pll_in = DEFAULT_MCLK_RATE;
+	} else {
+		return 0;
+	}
+	snd_soc_dai_set_fmt(codec_dai,
+			    SND_SOC_DAIFMT_BC_FC |
+			    SND_SOC_DAIFMT_NB_NF |
+			    SND_SOC_DAIFMT_I2S);
+
+	/* Configure PLL1 for codec */
+	ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source,
+				  pll_in, pll_out);
+	if (ret) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
 	}
 
+	/* Configure sysclk for codec */
+	ret = snd_soc_dai_set_sysclk(codec_dai, clk_id, pll_out,
+				     SND_SOC_CLOCK_IN);
+	if (ret)
+		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n",
+			ret);
+
+	return ret;
+}
+
+static int sc7180_snd_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	int ret;
+
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
 		if (++data->pri_mi2s_clk_count == 1) {
@@ -165,30 +216,66 @@ static int sc7180_snd_startup(struct snd_pcm_substream *substream)
 					       SNDRV_PCM_STREAM_PLAYBACK);
 		}
 
-		snd_soc_dai_set_fmt(codec_dai,
-				    SND_SOC_DAIFMT_BC_FC |
-				    SND_SOC_DAIFMT_NB_NF |
-				    SND_SOC_DAIFMT_I2S);
-
-		/* Configure PLL1 for codec */
-		ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source,
-					  pll_in, pll_out);
-		if (ret) {
-			dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		ret = sc7180_startup_realtek_codec(rtd);
+		if (ret)
 			return ret;
+
+		break;
+	case MI2S_SECONDARY:
+		break;
+	case LPASS_DP_RX:
+		break;
+	default:
+		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
+			cpu_dai->id);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sc7180_qdsp_snd_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	int ret;
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		if (++data->pri_mi2s_clk_count == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+					       Q6AFE_LPASS_CLK_ID_MCLK_1,
+					       DEFAULT_MCLK_RATE,
+					       SNDRV_PCM_STREAM_PLAYBACK);
+			snd_soc_dai_set_sysclk(cpu_dai,
+					       Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
+					       MI2S_BCLK_RATE,
+					       SNDRV_PCM_STREAM_PLAYBACK);
 		}
 
-		/* Configure sysclk for codec */
-		ret = snd_soc_dai_set_sysclk(codec_dai, clk_id, pll_out,
-					     SND_SOC_CLOCK_IN);
+		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
+
+		ret = sc7180_startup_realtek_codec(rtd);
 		if (ret)
-			dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n",
-				ret);
+			return ret;
 
 		break;
-	case MI2S_SECONDARY:
+	case TERTIARY_MI2S_RX:
+		snd_soc_dai_set_sysclk(cpu_dai,
+				       Q6AFE_LPASS_CLK_ID_TER_MI2S_IBIT,
+				       MI2S_BCLK_RATE,
+				       SNDRV_PCM_STREAM_PLAYBACK);
+
+		snd_soc_dai_set_fmt(codec_dai,
+				SND_SOC_DAIFMT_BC_FC |
+				SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_I2S);
+		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
 		break;
-	case LPASS_DP_RX:
+	case DISPLAY_PORT_RX:
 		break;
 	default:
 		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
@@ -246,6 +333,42 @@ static void sc7180_snd_shutdown(struct snd_pcm_substream *substream)
 	}
 }
 
+static void sc7180_qdsp_snd_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct sc7180_snd_data *data = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		if (--data->pri_mi2s_clk_count == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+					       Q6AFE_LPASS_CLK_ID_MCLK_1,
+					       0,
+					       SNDRV_PCM_STREAM_PLAYBACK);
+			snd_soc_dai_set_sysclk(cpu_dai,
+					       Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
+					       0,
+					       SNDRV_PCM_STREAM_PLAYBACK);
+		}
+		break;
+	case TERTIARY_MI2S_RX:
+		snd_soc_dai_set_sysclk(cpu_dai,
+				       Q6AFE_LPASS_CLK_ID_TER_MI2S_IBIT,
+				       0,
+				       SNDRV_PCM_STREAM_PLAYBACK);
+		break;
+	case DISPLAY_PORT_RX:
+		break;
+	default:
+		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
+			cpu_dai->id);
+		break;
+	}
+}
+
 static int sc7180_adau7002_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -294,11 +417,30 @@ static int sc7180_adau7002_snd_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int sc7180_qdsp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				     struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	return 0;
+}
+
 static const struct snd_soc_ops sc7180_ops = {
 	.startup = sc7180_snd_startup,
 	.shutdown = sc7180_snd_shutdown,
 };
 
+static const struct snd_soc_ops sc7180_qdsp_ops = {
+	.startup = sc7180_qdsp_snd_startup,
+	.shutdown = sc7180_qdsp_snd_shutdown,
+};
+
 static const struct snd_soc_ops sc7180_adau7002_ops = {
 	.startup = sc7180_adau7002_snd_startup,
 };
@@ -354,7 +496,7 @@ static int sc7180_snd_platform_probe(struct platform_device *pdev)
 	struct snd_soc_dai_link *link;
 	int ret;
 	int i;
-	bool no_headphone = false;
+	bool qdsp = false, no_headphone = false;
 
 	/* Allocate the private data */
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -390,6 +532,8 @@ static int sc7180_snd_platform_probe(struct platform_device *pdev)
 		no_headphone = true;
 		card->dapm_widgets = sc7180_adau7002_snd_widgets;
 		card->num_dapm_widgets = ARRAY_SIZE(sc7180_adau7002_snd_widgets);
+	} else if (of_device_is_compatible(dev->of_node, "qcom,sc7180-qdsp6-sndcard")) {
+		qdsp = true;
 	}
 
 	ret = qcom_snd_parse_of(card);
@@ -400,6 +544,12 @@ static int sc7180_snd_platform_probe(struct platform_device *pdev)
 		if (no_headphone) {
 			link->ops = &sc7180_adau7002_ops;
 			link->init = sc7180_adau7002_init;
+		} else if (qdsp) {
+			if (link->no_pcm == 1) {
+				link->ops = &sc7180_qdsp_ops;
+				link->be_hw_params_fixup = sc7180_qdsp_be_hw_params_fixup;
+				link->init = sc7180_qdsp_init;
+			}
 		} else {
 			link->ops = &sc7180_ops;
 			link->init = sc7180_init;
@@ -412,6 +562,7 @@ static int sc7180_snd_platform_probe(struct platform_device *pdev)
 static const struct of_device_id sc7180_snd_device_id[]  = {
 	{.compatible = "google,sc7180-trogdor"},
 	{.compatible = "google,sc7180-coachz"},
+	{.compatible = "qcom,sc7180-qdsp6-sndcard"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sc7180_snd_device_id);

-- 
2.41.0

