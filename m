Return-Path: <linux-kernel+bounces-95470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCE874E02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629211F23B80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66CC12D1F7;
	Thu,  7 Mar 2024 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XE5KHrwA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7F12CDAF;
	Thu,  7 Mar 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811917; cv=none; b=ombOsi6qPO6gyYnQa4Jdqn/1AbZkdXiZntTUVu2VePOWys0JcHC2QYyu9I8DvVrKa/5ymz46ymHGxPaaREOBpZSTJORpjpwTBcCC25HaOP1jWyTo+i/zxLVwiu7BMmH8aBG+ChyQNvYcKnsMrAgKITXDne8yfN9nZxj5Ly0VGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811917; c=relaxed/simple;
	bh=5l6ixT/QJSwR/7ij5ouRmnGQrpg9lKNtekqp8cQZN/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiwtnS+0uM6wLNjNyiVUAfPf8KhgbePeeJk0x8HVO1BZO8EEFhklsfsdP45y3zIv7X3jgKkcZ5cnjWEPoB3WrIN0UYzT6+4T5GUt03oNalhBtWQWF8ay6N1oKUtUm6MykNbgfzZPBlOkGRdJKWrOWIY8iJUNu1gXBhDqVob+G0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XE5KHrwA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709811914;
	bh=5l6ixT/QJSwR/7ij5ouRmnGQrpg9lKNtekqp8cQZN/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XE5KHrwAtvh2CbEIpfUMBJQr58Z9w5PRNVtK39aR/vZ4Lcd23uJXR4I2hqqJulzAP
	 /hLHars4gJT/Y/NtXJV5oZGHFX3565siPMLwhhaHb7Fo/o2/bRJ05dqbjlAFamlpk9
	 Lpl1yxEn00T5RW501gmBofeFZLb2DiIGdIckaB8vjgM79zP6SstHSKRsbg8SwvGrVQ
	 toRLVzFKQF41nYmB4/l0i+bSlayNQh3JCkmdqhG21BoSS3l03tqCNyscNsronRoFiW
	 /2mODwTF2EGyiP4het8pesU+Xd961BsJHt8P14gVxt/r6z0Dt5mCApNJgFtelGcknN
	 laZVc76CJBesA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5996D37820ED;
	Thu,  7 Mar 2024 11:45:12 +0000 (UTC)
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
Subject: [PATCH v2 09/22] ASoC: mediatek: mt8192: Migrate to mtk_soundcard_common_probe
Date: Thu,  7 Mar 2024 12:44:32 +0100
Message-ID: <20240307114445.196981-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 164 ++++++++++--------
 1 file changed, 91 insertions(+), 73 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index bfcb2c486c39..645bc1aa67c7 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -20,6 +20,8 @@
 #include "../../codecs/rt1015.h"
 #include "../../codecs/rt5682.h"
 #include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-soc-card.h"
+#include "../common/mtk-soundcard-driver.h"
 #include "mt8192-afe-common.h"
 #include "mt8192-afe-clk.h"
 #include "mt8192-afe-gpio.h"
@@ -38,9 +40,10 @@
 #define RT1015P_RT5682_OF_NAME "mediatek,mt8192_mt6359_rt1015p_rt5682"
 #define RT1015P_RT5682S_OF_NAME "mediatek,mt8192_mt6359_rt1015p_rt5682s"
 
-struct mt8192_mt6359_priv {
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack hdmi_jack;
+enum mt8192_jacks {
+	MT8192_JACK_HEADSET,
+	MT8192_JACK_HDMI,
+	MT8192_JACK_MAX,
 };
 
 /* Headset jack detection DAPM pins */
@@ -323,13 +326,13 @@ static int mt8192_mt6359_init(struct snd_soc_pcm_runtime *rtd)
 
 static int mt8192_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8192_JACK_HEADSET];
 	struct snd_soc_component *cmpnt_afe =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
 	struct snd_soc_component *cmpnt_codec =
 		snd_soc_rtd_to_codec(rtd, 0)->component;
-	struct mt8192_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct snd_soc_jack *jack = &priv->headset_jack;
 	int ret;
 
 	ret = mt8192_dai_i2s_set_share(afe, "I2S8", "I2S9");
@@ -359,19 +362,19 @@ static int mt8192_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 
 static int mt8192_mt6359_hdmi_init(struct snd_soc_pcm_runtime *rtd)
 {
+	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8192_JACK_HDMI];
 	struct snd_soc_component *cmpnt_codec =
 		snd_soc_rtd_to_codec(rtd, 0)->component;
-	struct mt8192_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack);
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, jack);
 	if (ret) {
 		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
 		return ret;
 	}
 
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
+	return snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
 }
 
 static int mt8192_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -1136,71 +1139,53 @@ static int mt8192_mt6359_card_set_be_link(struct snd_soc_card *card,
 	return 0;
 }
 
-static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
+static int mt8192_mt6359_legacy_probe(struct mtk_soc_card_data *soc_card_data)
 {
-	struct snd_soc_card *card;
-	struct device_node *platform_node, *hdmi_codec, *headset_codec, *speaker_codec;
-	int ret, i;
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = card_data->card;
+	struct device *dev = card->dev;
+	struct device_node *hdmi_codec, *headset_codec, *speaker_codec;
 	struct snd_soc_dai_link *dai_link;
-	struct mt8192_mt6359_priv *priv;
-
-	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);
-	if (!card)
-		return -EINVAL;
-	card->dev = &pdev->dev;
-
-	if (of_device_is_compatible(pdev->dev.of_node, RT1015P_RT5682_OF_NAME))
-		card->name = RT1015P_RT5682_CARD_NAME;
-	else if (of_device_is_compatible(pdev->dev.of_node, RT1015P_RT5682S_OF_NAME))
-		card->name = RT1015P_RT5682S_CARD_NAME;
-	else
-		dev_dbg(&pdev->dev, "No need to set card name\n");
+	int ret, i;
 
-	hdmi_codec = of_parse_phandle(pdev->dev.of_node, "mediatek,hdmi-codec", 0);
+	hdmi_codec = of_parse_phandle(dev->of_node, "mediatek,hdmi-codec", 0);
 	if (!hdmi_codec)
-		dev_dbg(&pdev->dev, "The machine has no hdmi-codec\n");
+		dev_dbg(dev, "The machine has no hdmi-codec\n");
 
-	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
-	if (!platform_node) {
-		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
-		goto err_platform_node;
-	}
-
-	speaker_codec = of_get_child_by_name(pdev->dev.of_node, "speaker-codecs");
+	speaker_codec = of_get_child_by_name(dev->of_node, "speaker-codecs");
 	if (!speaker_codec) {
 		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'speaker-codecs' missing or invalid\n");
+		dev_err_probe(dev, ret, "Property 'speaker-codecs' missing or invalid\n");
 		goto err_speaker_codec;
 	}
 
-	headset_codec = of_get_child_by_name(pdev->dev.of_node, "headset-codec");
+	headset_codec = of_get_child_by_name(dev->of_node, "headset-codec");
 	if (!headset_codec) {
 		ret = -EINVAL;
-		dev_err_probe(&pdev->dev, ret, "Property 'headset-codec' missing or invalid\n");
+		dev_err_probe(dev, ret, "Property 'headset-codec' missing or invalid\n");
 		goto err_headset_codec;
 	}
 
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = mt8192_mt6359_card_set_be_link(card, dai_link, speaker_codec, "I2S3");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",
+			dev_err_probe(dev, ret, "%s set speaker_codec fail\n",
 				      dai_link->name);
-			goto err_probe;
+			break;
 		}
 
 		ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S8");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+			dev_err_probe(dev, ret, "%s set headset_codec fail\n",
 				      dai_link->name);
-			goto err_probe;
+			break;
 		}
 
 		ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S9");
 		if (ret) {
-			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
+			dev_err_probe(dev, ret, "%s set headset_codec fail\n",
 				      dai_link->name);
-			goto err_probe;
+			break;
 		}
 
 		if (hdmi_codec && strcmp(dai_link->name, "TDM") == 0) {
@@ -1211,52 +1196,85 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
 		if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
 		    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
 			dai_link->ops = &mt8192_rt1015_i2s_ops;
-
-		if (!dai_link->platforms->name)
-			dai_link->platforms->of_node = platform_node;
-	}
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto err_probe;
-	}
-	snd_soc_card_set_drvdata(card, priv);
-
-	ret = mt8192_afe_gpio_init(&pdev->dev);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);
-		goto err_probe;
 	}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret)
-		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n", __func__);
-
-err_probe:
 	of_node_put(headset_codec);
 err_headset_codec:
 	of_node_put(speaker_codec);
 err_speaker_codec:
-	of_node_put(platform_node);
-err_platform_node:
-	of_node_put(hdmi_codec);
+	if (hdmi_codec)
+		of_node_put(hdmi_codec);
+
 	return ret;
 }
 
+static int mt8192_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data, bool legacy)
+{
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = card_data->card;
+	int ret;
+
+	if (legacy) {
+		ret = mt8192_mt6359_legacy_probe(soc_card_data);
+		if (ret)
+			return ret;
+	} else {
+		struct snd_soc_dai_link *dai_link;
+		int i;
+
+		for_each_card_prelinks(card, i, dai_link)
+			if (dai_link->num_codecs && dai_link->codecs[0].dai_name &&
+			    strcmp(dai_link->codecs[0].dai_name, RT1015_CODEC_DAI) == 0)
+				dai_link->ops = &mt8192_rt1015_i2s_ops;
+	}
+
+	ret = mt8192_afe_gpio_init(card->dev);
+	if (ret)
+		return dev_err_probe(card->dev, ret, "%s init gpio error\n", __func__);
+
+	return 0;
+}
+
+static const struct mtk_soundcard_pdata mt8192_mt6359_rt1015_rt5682_pdata = {
+	.card_name = RT1015_RT5682_CARD_NAME,
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8192_mt6359_rt1015_rt5682_card,
+		.num_jacks = MT8192_JACK_MAX,
+	},
+	.soc_probe = mt8192_mt6359_soc_card_probe
+};
+
+static const struct mtk_soundcard_pdata mt8192_mt6359_rt1015p_rt5682_pdata = {
+	.card_name = RT1015P_RT5682_CARD_NAME,
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8192_mt6359_rt1015p_rt5682x_card,
+		.num_jacks = MT8192_JACK_MAX,
+	},
+	.soc_probe = mt8192_mt6359_soc_card_probe
+};
+
+static const struct mtk_soundcard_pdata mt8192_mt6359_rt1015p_rt5682s_pdata = {
+	.card_name = RT1015P_RT5682S_CARD_NAME,
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8192_mt6359_rt1015p_rt5682x_card,
+		.num_jacks = MT8192_JACK_MAX,
+	},
+	.soc_probe = mt8192_mt6359_soc_card_probe
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id mt8192_mt6359_dt_match[] = {
 	{
 		.compatible = RT1015_RT5682_OF_NAME,
-		.data = &mt8192_mt6359_rt1015_rt5682_card,
+		.data = &mt8192_mt6359_rt1015_rt5682_pdata,
 	},
 	{
 		.compatible = RT1015P_RT5682_OF_NAME,
-		.data = &mt8192_mt6359_rt1015p_rt5682x_card,
+		.data = &mt8192_mt6359_rt1015p_rt5682_pdata,
 	},
 	{
 		.compatible = RT1015P_RT5682S_OF_NAME,
-		.data = &mt8192_mt6359_rt1015p_rt5682x_card,
+		.data = &mt8192_mt6359_rt1015p_rt5682s_pdata,
 	},
 	{}
 };
@@ -1276,7 +1294,7 @@ static struct platform_driver mt8192_mt6359_driver = {
 #endif
 		.pm = &mt8192_mt6359_pm_ops,
 	},
-	.probe = mt8192_mt6359_dev_probe,
+	.probe = mtk_soundcard_common_probe,
 };
 
 module_platform_driver(mt8192_mt6359_driver);
-- 
2.44.0


