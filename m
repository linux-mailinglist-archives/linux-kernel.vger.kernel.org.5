Return-Path: <linux-kernel+bounces-83185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2805F868FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B54284A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155C1487E0;
	Tue, 27 Feb 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0Hx//f+e"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677EB14830B;
	Tue, 27 Feb 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035830; cv=none; b=Rc+ZhqqYtD4HqbWb8zRFyj6VDBYv2f/KbN1b1UZh9hfml9OCcWBPKLnnbh3e2OTlvS/mAs3vW/F+6z5DBXWAZWocMaznON9GSE4oV1ooCx+A/tnykd4LV9m32Aa+ZK3LibKc77xXCRkwv50UcDpzTUz6xwhJ9t0A4ZcjkBcV2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035830; c=relaxed/simple;
	bh=B+vp4Uw62xZRdn2O7lnJ5cXiKQOHqoydOc/koaWZkvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjSawxFuT9Y6Sh75VbHmCWH9mNWCIAExJa3pgqbANgKq/Osk8QyUZo5anedROxGVHU6erejx6bFOlkURS+qlxSwD3ZzqHdxQ82jNNvX12zNjyNg9T8r0dWEbKv/Rd7y1KzR/ZQZovHQQVjegQcG67+38dE7A+XwldYDTei92x+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0Hx//f+e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709035826;
	bh=B+vp4Uw62xZRdn2O7lnJ5cXiKQOHqoydOc/koaWZkvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Hx//f+enm5/mQVGdyUGy26yVSgoNVZJc9WBO69VFHrPgkLRYDZVwEB/uHRlaC4oi
	 usitbOzm7t0NlfHtR1ILP7R0rBW0gvtf2kRjY5j833bapGqcYorZPwWCvV04AkbE7i
	 rlfznkNR3iJtBWJuksTrcZ27Vlga4G7L4WZI4fy55exFiT4NCQoSpOxqEcTWx6VVTx
	 L3bSAIarbur4IjnEwib90C+x0sD3OYEbun14A3ert/7ZUij+4Wf27iaA95KEDJqJDo
	 b77cO40uEOgGIa5Jo14aK6pJhE24nR4sX5pPjvvHa+HtnSPsrS0cKhHXdsQzd0IFja
	 Qzw5WZKLQYatg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 826AA37820DD;
	Tue, 27 Feb 2024 12:10:24 +0000 (UTC)
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
Subject: [PATCH 07/22] ASoC: mediatek: mt8188: Migrate to mtk_soundcard_common_probe
Date: Tue, 27 Feb 2024 13:09:24 +0100
Message-ID: <20240227120939.290143-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
References: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 203 +++++++---------------
 1 file changed, 64 insertions(+), 139 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index a391066ab204..f629fc6bbb53 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -236,11 +236,11 @@ static const struct sof_conn_stream g_sof_conn_streams[] = {
 	},
 };
 
-struct mt8188_mt6359_priv {
-	struct snd_soc_jack dp_jack;
-	struct snd_soc_jack hdmi_jack;
-	struct snd_soc_jack headset_jack;
-	void *private_data;
+enum mt8188_jacks {
+	MT8188_JACK_HEADSET,
+	MT8188_JACK_DP,
+	MT8188_JACK_HDMI,
+	MT8188_JACK_MAX,
 };
 
 static struct snd_soc_jack_pin mt8188_hdmi_jack_pins[] = {
@@ -268,11 +268,6 @@ static struct snd_soc_jack_pin nau8825_jack_pins[] = {
 	},
 };
 
-struct mt8188_card_data {
-	const char *name;
-	unsigned long quirk;
-};
-
 static const struct snd_kcontrol_new mt8188_dumb_spk_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
@@ -590,12 +585,12 @@ static int mt8188_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
-	struct mt8188_mt6359_priv *priv = soc_card_data->mach_priv;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_HDMI];
 	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
 
 	ret = snd_soc_card_jack_new_pins(rtd->card, "HDMI Jack",
-					 SND_JACK_LINEOUT, &priv->hdmi_jack,
+					 SND_JACK_LINEOUT, jack,
 					 mt8188_hdmi_jack_pins,
 					 ARRAY_SIZE(mt8188_hdmi_jack_pins));
 	if (ret) {
@@ -603,7 +598,7 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	ret = snd_soc_component_set_jack(component, &priv->hdmi_jack, NULL);
+	ret = snd_soc_component_set_jack(component, jack, NULL);
 	if (ret) {
 		dev_err(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
 			__func__, component->name, ret);
@@ -616,19 +611,19 @@ static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
-	struct mt8188_mt6359_priv *priv = soc_card_data->mach_priv;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_DP];
 	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret = 0;
 
 	ret = snd_soc_card_jack_new_pins(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-					 &priv->dp_jack, mt8188_dp_jack_pins,
+					 jack, mt8188_dp_jack_pins,
 					 ARRAY_SIZE(mt8188_dp_jack_pins));
 	if (ret) {
 		dev_err(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
 		return ret;
 	}
 
-	ret = snd_soc_component_set_jack(component, &priv->dp_jack, NULL);
+	ret = snd_soc_component_set_jack(component, jack, NULL);
 	if (ret) {
 		dev_err(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
 			__func__, component->name, ret);
@@ -736,10 +731,9 @@ static int mt8188_max98390_codec_init(struct snd_soc_pcm_runtime *rtd)
 static int mt8188_headset_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
-	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
-	struct mt8188_mt6359_priv *priv = soc_card_data->mach_priv;
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_HEADSET];
 	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
-	struct snd_soc_jack *jack = &priv->headset_jack;
 	int ret;
 
 	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_nau8825_widgets,
@@ -1224,11 +1218,10 @@ static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
 static void mt8188_fixup_controls(struct snd_soc_card *card)
 {
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
-	struct mt8188_mt6359_priv *priv = soc_card_data->mach_priv;
-	struct mt8188_card_data *card_data = (struct mt8188_card_data *)priv->private_data;
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
 	struct snd_kcontrol *kctl;
 
-	if (card_data->quirk & (NAU8825_HS_PRESENT | RT5682S_HS_PRESENT | ES8326_HS_PRESENT)) {
+	if (card_data->flags & (NAU8825_HS_PRESENT | RT5682S_HS_PRESENT | ES8326_HS_PRESENT)) {
 		struct snd_soc_dapm_widget *w, *next_w;
 
 		for_each_card_widgets_safe(card, w, next_w) {
@@ -1259,14 +1252,10 @@ static struct snd_soc_card mt8188_mt6359_soc_card = {
 	.fixup_controls = mt8188_fixup_controls,
 };
 
-static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
+static int mt8188_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data, bool legacy)
 {
-	struct snd_soc_card *card = &mt8188_mt6359_soc_card;
-	struct device_node *platform_node;
-	struct device_node *adsp_node;
-	struct mtk_soc_card_data *soc_card_data;
-	struct mt8188_mt6359_priv *priv;
-	struct mt8188_card_data *card_data;
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = soc_card_data->card_data->card;
 	struct snd_soc_dai_link *dai_link;
 	bool init_mt6359 = false;
 	bool init_es8326 = false;
@@ -1274,91 +1263,12 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 	bool init_rt5682s = false;
 	bool init_max98390 = false;
 	bool init_dumb = false;
-	int ret, i;
-
-	card_data = (struct mt8188_card_data *)of_device_get_match_data(&pdev->dev);
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_of_parse_card_name(card, "model");
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "%s new card name parsing error\n",
-				     __func__);
-
-	if (!card->name)
-		card->name = card_data->name;
-
-	if (of_property_read_bool(pdev->dev.of_node, "audio-routing")) {
-		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
-		if (ret)
-			return ret;
-	}
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*card_data), GFP_KERNEL);
-	if (!soc_card_data)
-		return -ENOMEM;
-
-	soc_card_data->mach_priv = priv;
-
-	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
-	if (adsp_node) {
-		struct mtk_sof_priv *sof_priv;
-
-		sof_priv = devm_kzalloc(&pdev->dev, sizeof(*sof_priv), GFP_KERNEL);
-		if (!sof_priv) {
-			ret = -ENOMEM;
-			goto err_adsp_node;
-		}
-		sof_priv->conn_streams = g_sof_conn_streams;
-		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
-		soc_card_data->sof_priv = sof_priv;
-		card->probe = mtk_sof_card_probe;
-		card->late_probe = mtk_sof_card_late_probe;
-		if (!card->topology_shortname_created) {
-			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
-			card->topology_shortname_created = true;
-		}
-		card->name = card->topology_shortname;
-	}
-
-	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
-		ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
-					       "mediatek,dai-link",
-					       mt8188_mt6359_dai_links,
-					       ARRAY_SIZE(mt8188_mt6359_dai_links));
-		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "Parse dai-link fail\n");
-			goto err_adsp_node;
-		}
-	} else {
-		if (!adsp_node)
-			card->num_links = DAI_LINK_REGULAR_NUM;
-	}
-
-	platform_node = of_parse_phandle(pdev->dev.of_node,
-					 "mediatek,platform", 0);
-	if (!platform_node) {
-		ret = dev_err_probe(&pdev->dev, -EINVAL,
-				    "Property 'platform' missing or invalid\n");
-		goto err_adsp_node;
-
-	}
+	int i;
 
-	ret = parse_dai_link_info(card);
-	if (ret)
-		goto err;
+	if (legacy)
+		return -EINVAL;
 
 	for_each_card_prelinks(card, i, dai_link) {
-		if (!dai_link->platforms->name) {
-			if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && adsp_node)
-				dai_link->platforms->of_node = adsp_node;
-			else
-				dai_link->platforms->of_node = platform_node;
-		}
-
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
 			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
 				dai_link->init = mt8188_dptx_codec_init;
@@ -1381,7 +1291,7 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 				 * mt8188_max98390_ops. Two amps is I2S mode,
 				 * SOC and codec don't require TDM settings.
 				 */
-				if (!(card_data->quirk & MAX98390_TWO_AMP)) {
+				if (!(card_data->flags & MAX98390_TWO_AMP)) {
 					dai_link->ops = &mt8188_max98390_ops;
 				}
 				if (!init_max98390) {
@@ -1420,40 +1330,55 @@ static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
 		}
 	}
 
-	priv->private_data = card_data;
-	snd_soc_card_set_drvdata(card, soc_card_data);
-
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
-		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n",
-			      __func__);
-err:
-	of_node_put(platform_node);
-	clean_card_reference(card);
-
-err_adsp_node:
-	of_node_put(adsp_node);
-
-	return ret;
+	return 0;
 }
 
-static struct mt8188_card_data mt8188_evb_card = {
-	.name = "mt8188_mt6359",
+static const struct mtk_sof_priv mt8188_sof_priv = {
+	.conn_streams = g_sof_conn_streams,
+	.num_streams = ARRAY_SIZE(g_sof_conn_streams),
+};
+
+static const struct mtk_soundcard_pdata mt8188_evb_card = {
+	.card_name = "mt8188_mt6359",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8188_mt6359_soc_card,
+		.num_jacks = MT8188_JACK_MAX,
+	},
+	.sof_priv = &mt8188_sof_priv,
+	.soc_probe = mt8188_mt6359_soc_card_probe,
 };
 
-static struct mt8188_card_data mt8188_nau8825_card = {
-	.name = "mt8188_nau8825",
-	.quirk = NAU8825_HS_PRESENT,
+static const struct mtk_soundcard_pdata mt8188_nau8825_card = {
+	.card_name = "mt8188_nau8825",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8188_mt6359_soc_card,
+		.num_jacks = MT8188_JACK_MAX,
+		.flags = NAU8825_HS_PRESENT
+	},
+	.sof_priv = &mt8188_sof_priv,
+	.soc_probe = mt8188_mt6359_soc_card_probe,
 };
 
-static struct mt8188_card_data mt8188_rt5682s_card = {
-	.name = "mt8188_rt5682s",
-	.quirk = RT5682S_HS_PRESENT | MAX98390_TWO_AMP,
+static const struct mtk_soundcard_pdata mt8188_rt5682s_card = {
+	.card_name = "mt8188_rt5682s",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8188_mt6359_soc_card,
+		.num_jacks = MT8188_JACK_MAX,
+		.flags = RT5682S_HS_PRESENT | MAX98390_TWO_AMP
+	},
+	.sof_priv = &mt8188_sof_priv,
+	.soc_probe = mt8188_mt6359_soc_card_probe,
 };
 
-static struct mt8188_card_data mt8188_es8326_card = {
-	.name = "mt8188_es8326",
-	.quirk = ES8326_HS_PRESENT | MAX98390_TWO_AMP,
+static const struct mtk_soundcard_pdata mt8188_es8326_card = {
+	.card_name = "mt8188_es8326",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8188_mt6359_soc_card,
+		.num_jacks = MT8188_JACK_MAX,
+		.flags = ES8326_HS_PRESENT | MAX98390_TWO_AMP
+	},
+	.sof_priv = &mt8188_sof_priv,
+	.soc_probe = mt8188_mt6359_soc_card_probe,
 };
 
 static const struct of_device_id mt8188_mt6359_dt_match[] = {
@@ -1471,7 +1396,7 @@ static struct platform_driver mt8188_mt6359_driver = {
 		.of_match_table = mt8188_mt6359_dt_match,
 		.pm = &snd_soc_pm_ops,
 	},
-	.probe = mt8188_mt6359_dev_probe,
+	.probe = mtk_soundcard_common_probe,
 };
 
 module_platform_driver(mt8188_mt6359_driver);
-- 
2.44.0


