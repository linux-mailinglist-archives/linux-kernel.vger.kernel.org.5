Return-Path: <linux-kernel+bounces-146390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152208A64AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFF72836C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93D15990B;
	Tue, 16 Apr 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BiwxkDLd"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78B158D61;
	Tue, 16 Apr 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251676; cv=none; b=U/4vJMoTvYzzsuZ/mw6R04OF4pPUtjebDy5Em3eCTs3LlevCi4drcf/U6ifHqIocJtYzzgPCTTQjhxx2XRJJhgTsa62TyoGM0VNOl6AAV2Nf611TUnLfjRJ7eRUEU8unT3VoCnN2KUqCkf3FpwhckjIMVdUyHU7thOT+LmlZ1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251676; c=relaxed/simple;
	bh=DH7vyulFVg1rDpurL/O6/TDCItfssmukTVTvmN6uB6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNj4R1hiY8pKTbBEWsVPp/y8Sg09rd8EXFcuOzOlRIYIqy4tE3t6HTSNGDrvxtfw3JB2aThOXQs5zBvpGennP2TCJm4YybhNZb0CRejVvO8kZalwpBxzJxYN7NppekFvFwNJ4Js6g5qbJ6S/jdQdNJpdxMYemSMokNdldeyRmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BiwxkDLd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713251672;
	bh=DH7vyulFVg1rDpurL/O6/TDCItfssmukTVTvmN6uB6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiwxkDLd7SURPReDm3xszdp6BBoJ4XEeemkIpH9HE2FxIBaqZJwcc2VpWR1/FIitx
	 2O03Ocyw8KtMcfVpjvFFijoxcjGlzt3oH6ukA3DZEHhTQaDbke3PfcTwWBSQAoNaUa
	 qpDMDIS4p0l3o+9zGUZ5xLkLMNwHmQkX2Gy7x+UMFla0pIJDAaL2N/YwPqmLKeqFWn
	 3yJ2D4fPHjH0t3LF2tZB/tJxsY6zEDqAG1jKCyVJVBPefhtEaa+5Mj9e/Nn+f5jo04
	 bU0UEFh+uT08SUoaLSkyX5iaa/DLz1KVHylwJlZwsrdXXhv9WIxXoAv1hfQl3yP8eH
	 hhHxxl39s9ekg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 912F4378210B;
	Tue, 16 Apr 2024 07:14:30 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 06/18] ASoC: mediatek: mt8186: Migrate to mtk_soundcard_common_probe
Date: Tue, 16 Apr 2024 09:13:58 +0200
Message-ID: <20240416071410.75620-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mtk_soundcard_pdata platform data for the MediaTek common sound card
probe mechanism, including a driver/soc-specific probe extension (used
for bits that cannot be commonized  hence specific to this driver), and
change the probe function to mtk_soundcard_common_probe.

This is also adding the possibility of specifying the links and routing
with the audio-routing property and (x)-dai-link nodes in device trees
to stop hardcoding machine specific links in the card driver assupported
by the common probe function, but support for legacy device trees is
retained with a legacy_probe function, which is used only in case the
new properties are not found.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 220 ++++++++----------
 1 file changed, 96 insertions(+), 124 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index f78197c8e582..f8856a100b27 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -21,6 +21,7 @@
 #include "../common/mtk-afe-platform-driver.h"
 #include "../common/mtk-dsp-sof-common.h"
 #include "../common/mtk-soc-card.h"
+#include "../common/mtk-soundcard-driver.h"
 #include "mt8186-afe-common.h"
 #include "mt8186-afe-clk.h"
 #include "mt8186-afe-gpio.h"
@@ -38,11 +39,16 @@
 #define SOF_DMA_UL2 "SOF_DMA_UL2"
 
 struct mt8186_mt6366_rt1019_rt5682s_priv {
-	struct snd_soc_jack headset_jack, hdmi_jack;
 	struct gpio_desc *dmic_sel;
 	int dmic_switch;
 };
 
+enum mt8186_jacks {
+	MT8186_JACK_HEADSET,
+	MT8186_JACK_HDMI,
+	MT8186_JACK_MAX,
+};
+
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin mt8186_jack_pins[] = {
 	{
@@ -165,8 +171,7 @@ static int mt8186_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
 	struct mtk_soc_card_data *soc_card_data =
 		snd_soc_card_get_drvdata(rtd->card);
-	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
-	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8186_JACK_HEADSET];
 	struct snd_soc_component *cmpnt_codec =
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret;
@@ -257,7 +262,7 @@ static int mt8186_mt6366_rt1019_rt5682s_hdmi_init(struct snd_soc_pcm_runtime *rt
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	struct mtk_soc_card_data *soc_card_data =
 		snd_soc_card_get_drvdata(rtd->card);
-	struct mt8186_mt6366_rt1019_rt5682s_priv *priv = soc_card_data->mach_priv;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8186_JACK_HDMI];
 	int ret;
 
 	ret = mt8186_dai_i2s_set_share(afe, "I2S2", "I2S3");
@@ -266,13 +271,13 @@ static int mt8186_mt6366_rt1019_rt5682s_hdmi_init(struct snd_soc_pcm_runtime *rt
 		return ret;
 	}
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, &priv->hdmi_jack);
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, jack);
 	if (ret) {
 		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
 		return ret;
 	}
 
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
+	return snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
 }
 
 static int mt8186_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -1134,166 +1139,133 @@ static struct snd_soc_card mt8186_mt6366_rt5650_soc_card = {
 	.num_configs = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_codec_conf),
 };
 
-static int mt8186_mt6366_rt1019_rt5682s_dev_probe(struct platform_device *pdev)
+static int mt8186_mt6366_legacy_probe(struct mtk_soc_card_data *soc_card_data)
 {
-	struct snd_soc_card *card;
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = card_data->card;
+	struct device *dev = card->dev;
 	struct snd_soc_dai_link *dai_link;
-	struct mtk_soc_card_data *soc_card_data;
-	struct mt8186_mt6366_rt1019_rt5682s_priv *mach_priv;
-	struct device_node *platform_node, *headset_codec, *playback_codec, *adsp_node;
-	int sof_on = 0;
+	struct device_node *headset_codec, *playback_codec;
 	int ret, i;
 
-	card = (struct snd_soc_card *)device_get_match_data(&pdev->dev);
-	if (!card)
-		return -EINVAL;
-	card->dev = &pdev->dev;
-
-	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*soc_card_data), GFP_KERNEL);
-	if (!soc_card_data)
-		return -ENOMEM;
-	mach_priv = devm_kzalloc(&pdev->dev, sizeof(*mach_priv), GFP_KERNEL);
-	if (!mach_priv)
-		return -ENOMEM;
-
-	soc_card_data->mach_priv = mach_priv;
-
-	mach_priv->dmic_sel = devm_gpiod_get_optional(&pdev->dev,
-						      "dmic", GPIOD_OUT_LOW);
-	if (IS_ERR(mach_priv->dmic_sel)) {
-		dev_err(&pdev->dev, "DMIC gpio failed err=%ld\n",
-			PTR_ERR(mach_priv->dmic_sel));
-		return PTR_ERR(mach_priv->dmic_sel);
-	}
-
-	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
-	if (adsp_node) {
-		struct mtk_sof_priv *sof_priv;
+	playback_codec = of_get_child_by_name(dev->of_node, "playback-codecs");
+	if (!playback_codec)
+		return dev_err_probe(dev, -EINVAL,
+				     "Property 'playback-codecs' missing or invalid\n");
 
-		sof_priv = devm_kzalloc(&pdev->dev, sizeof(*sof_priv), GFP_KERNEL);
-		if (!sof_priv) {
-			ret = -ENOMEM;
-			goto err_adsp_node;
-		}
-		sof_priv->conn_streams = g_sof_conn_streams;
-		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
-		sof_priv->sof_dai_link_fixup = mt8186_sof_dai_link_fixup;
-		soc_card_data->sof_priv = sof_priv;
-		card->probe = mtk_sof_card_probe;
-		card->late_probe = mtk_sof_card_late_probe;
-		if (!card->topology_shortname_created) {
-			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
-			card->topology_shortname_created = true;
-		}
-		card->name = card->topology_shortname;
-		sof_on = 1;
-	} else {
-		dev_dbg(&pdev->dev, "Probe without adsp\n");
-	}
-
-	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
-		ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
-					       "mediatek,dai-link",
-					       mt8186_mt6366_rt1019_rt5682s_dai_links,
-					       ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links));
-		if (ret) {
-			dev_dbg(&pdev->dev, "Parse dai-link fail\n");
-			goto err_adsp_node;
-		}
-	} else {
-		if (!sof_on)
-			card->num_links = ARRAY_SIZE(mt8186_mt6366_rt1019_rt5682s_dai_links)
-					- ARRAY_SIZE(g_sof_conn_streams);
-	}
-
-	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
-	if (!platform_node) {
-		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
-		goto err_platform_node;
-	}
-
-	playback_codec = of_get_child_by_name(pdev->dev.of_node, "playback-codecs");
-	if (!playback_codec) {
-		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'playback-codecs' missing or invalid\n");
-		goto err_playback_codec;
-	}
-
-	headset_codec = of_get_child_by_name(pdev->dev.of_node, "headset-codec");
+	headset_codec = of_get_child_by_name(dev->of_node, "headset-codec");
 	if (!headset_codec) {
-		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'headset-codec' missing or invalid\n");
-		goto err_headset_codec;
+		of_node_put(playback_codec);
+		return dev_err_probe(dev, -EINVAL,
+				     "Property 'headset-codec' missing or invalid\n");
 	}
 
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = mt8186_mt6366_card_set_be_link(card, dai_link, playback_codec, "I2S3");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set playback_codec fail\n",
+			dev_err_probe(dev, ret, "%s set playback_codec fail\n",
 				      dai_link->name);
-			goto err_probe;
+			break;
 		}
 
 		ret = mt8186_mt6366_card_set_be_link(card, dai_link, headset_codec, "I2S0");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+			dev_err_probe(dev, ret, "%s set headset_codec fail\n",
 				      dai_link->name);
-			goto err_probe;
+			break;
 		}
 
 		ret = mt8186_mt6366_card_set_be_link(card, dai_link, headset_codec, "I2S1");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+			dev_err_probe(dev, ret, "%s set headset_codec fail\n",
 				      dai_link->name);
-			goto err_probe;
+			break;
 		}
+	}
+	of_node_put(headset_codec);
+	of_node_put(playback_codec);
 
-		if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && sof_on)
-			dai_link->platforms->of_node = adsp_node;
+	return ret;
+}
 
-		if (!dai_link->platforms->name && !dai_link->platforms->of_node)
-			dai_link->platforms->of_node = platform_node;
-	}
+static int mt8186_mt6366_soc_card_probe(struct mtk_soc_card_data *soc_card_data, bool legacy)
+{
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = card_data->card;
+	struct mt8186_mt6366_rt1019_rt5682s_priv *mach_priv;
+	int ret;
 
-	snd_soc_card_set_drvdata(card, soc_card_data);
+	mach_priv = devm_kzalloc(card->dev, sizeof(*mach_priv), GFP_KERNEL);
+	if (!mach_priv)
+		return -ENOMEM;
 
-	ret = mt8186_afe_gpio_init(&pdev->dev);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);
-		goto err_probe;
+	soc_card_data->mach_priv = mach_priv;
+
+	mach_priv->dmic_sel = devm_gpiod_get_optional(card->dev,
+						      "dmic", GPIOD_OUT_LOW);
+	if (IS_ERR(mach_priv->dmic_sel))
+		return dev_err_probe(card->dev, PTR_ERR(mach_priv->dmic_sel),
+				     "DMIC gpio failed\n");
+
+	if (legacy) {
+		ret = mt8186_mt6366_legacy_probe(soc_card_data);
+		if (ret)
+			return ret;
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	ret = mt8186_afe_gpio_init(card->dev);
 	if (ret)
-		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);
+		return dev_err_probe(card->dev, ret, "init AFE gpio error\n");
 
-err_probe:
-	of_node_put(headset_codec);
-err_headset_codec:
-	of_node_put(playback_codec);
-err_playback_codec:
-	of_node_put(platform_node);
-err_platform_node:
-err_adsp_node:
-	of_node_put(adsp_node);
-
-	return ret;
+	return 0;
 }
 
+static const struct mtk_sof_priv mt8186_sof_priv = {
+	.conn_streams = g_sof_conn_streams,
+	.num_streams = ARRAY_SIZE(g_sof_conn_streams),
+	.sof_dai_link_fixup = mt8186_sof_dai_link_fixup
+};
+
+static const struct mtk_soundcard_pdata mt8186_mt6366_rt1019_rt5682s_pdata = {
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8186_mt6366_rt1019_rt5682s_soc_card,
+		.num_jacks = MT8186_JACK_MAX,
+	},
+	.sof_priv = &mt8186_sof_priv,
+	.soc_probe = mt8186_mt6366_soc_card_probe
+};
+
+static const struct mtk_soundcard_pdata mt8186_mt6366_rt5682s_max98360_pdata = {
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8186_mt6366_rt5682s_max98360_soc_card,
+		.num_jacks = MT8186_JACK_MAX,
+	},
+	.sof_priv = &mt8186_sof_priv,
+	.soc_probe = mt8186_mt6366_soc_card_probe
+};
+
+static const struct mtk_soundcard_pdata mt8186_mt6366_rt5650_pdata = {
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8186_mt6366_rt5650_soc_card,
+		.num_jacks = MT8186_JACK_MAX,
+	},
+	.sof_priv = &mt8186_sof_priv,
+	.soc_probe = mt8186_mt6366_soc_card_probe
+};
+
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id mt8186_mt6366_rt1019_rt5682s_dt_match[] = {
 	{
 		.compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound",
-		.data = &mt8186_mt6366_rt1019_rt5682s_soc_card,
+		.data = &mt8186_mt6366_rt1019_rt5682s_pdata,
 	},
 	{
 		.compatible = "mediatek,mt8186-mt6366-rt5682s-max98360-sound",
-		.data = &mt8186_mt6366_rt5682s_max98360_soc_card,
+		.data = &mt8186_mt6366_rt5682s_max98360_pdata,
 	},
 	{
 		.compatible = "mediatek,mt8186-mt6366-rt5650-sound",
-		.data = &mt8186_mt6366_rt5650_soc_card,
+		.data = &mt8186_mt6366_rt5650_pdata,
 	},
 	{}
 };
@@ -1308,7 +1280,7 @@ static struct platform_driver mt8186_mt6366_rt1019_rt5682s_driver = {
 #endif
 		.pm = &snd_soc_pm_ops,
 	},
-	.probe = mt8186_mt6366_rt1019_rt5682s_dev_probe,
+	.probe = mtk_soundcard_common_probe,
 };
 
 module_platform_driver(mt8186_mt6366_rt1019_rt5682s_driver);
-- 
2.44.0


