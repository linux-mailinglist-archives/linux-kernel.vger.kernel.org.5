Return-Path: <linux-kernel+bounces-146388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0FC8A64A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62444283869
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF9156886;
	Tue, 16 Apr 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4xNmzsSw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94712F395;
	Tue, 16 Apr 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251671; cv=none; b=en8Z1SQEW5zPdJ+jXSeuo2yA+z7N+KNgyImQm9dNFuqoiY1r2YdIOYGBXBuymqM9rG1A6AvhTWGt+Zx26SIUZcHIKXiLCPymzUsEpKbJYDC6CvJNyPFdCSjLT9ZWQ/gfJ5UJWQLwW1blu4Yugq38GPkl0Sdg8eIsK/VWlUow9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251671; c=relaxed/simple;
	bh=TIZvwWDeJ4aqoDbvqKNZ4ihhFX6tlxaL4ndXBGXYyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iva7mtDpxYmwuNEx9pTIVNOuW6BuLBB1GM8+LX1l8TGehVfCWe4TQkvxff/U7AI6pFvE25an6VS4/l5ZvYGSMoE3Jrr6O64tv1JB/OjqRhRHwCmTM9Ysx7tah3UNHQdwalY0CQd+GK8Ia7XkYcuiJwdHf4jHS3EttSXlIbUSwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4xNmzsSw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713251668;
	bh=TIZvwWDeJ4aqoDbvqKNZ4ihhFX6tlxaL4ndXBGXYyoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4xNmzsSwqWQ0F/wFEwob9m1m907HkL8xmrZrECqjGKgiklAzcJGuq+2QMl403h9fu
	 1GsQCaLnZc536kxoEi6xWH8VA0ed108OtvI3bOMj9LOeZryycPw9RtklsUn/pjtg9Y
	 f8cSa8nb2ABCzN7/S75RyXFT668669eCb+AIk+fd1Dw4yMzkrS+cbfdO7qsJUjwvlv
	 5LJXY+TmqJ1w1ghvQOxEtTcoM8QCGNNQSG3LokluBLxdryExOD1jjBfDq8tZLrGBtA
	 WYaC/5cqtO63bAso1j1u7+tCVRAqwQlxG0JSn8ZzYc5/Y7hY783fV3EqCnd2bFt013
	 UZ4XYY3ju81hw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB1673782139;
	Tue, 16 Apr 2024 07:14:25 +0000 (UTC)
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
Subject: [PATCH v5 04/18] ASoC: mediatek: mt8195: Migrate to mtk_soundcard_common_probe
Date: Tue, 16 Apr 2024 09:13:56 +0200
Message-ID: <20240416071410.75620-5-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 292 ++++++++++++----------
 1 file changed, 159 insertions(+), 133 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 53fd8a897b9d..f694618e7635 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -22,6 +22,7 @@
 #include "../common/mtk-afe-platform-driver.h"
 #include "../common/mtk-dsp-sof-common.h"
 #include "../common/mtk-soc-card.h"
+#include "../common/mtk-soundcard-driver.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-afe-common.h"
 
@@ -29,6 +30,13 @@
 #define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
 #define MAX98390_SPEAKER_AMP_PRESENT		BIT(2)
 
+#define DUMB_CODEC_INIT				BIT(0)
+#define MT6359_CODEC_INIT			BIT(1)
+#define RT1011_CODEC_INIT			BIT(2)
+#define RT1019_CODEC_INIT			BIT(3)
+#define MAX98390_CODEC_INIT			BIT(4)
+#define RT5682_CODEC_INIT			BIT(5)
+
 #define RT1011_CODEC_DAI	"rt1011-aif"
 #define RT1011_DEV0_NAME	"rt1011.2-0038"
 #define RT1011_DEV1_NAME	"rt1011.2-0039"
@@ -51,18 +59,17 @@
 #define SOF_DMA_UL4 "SOF_DMA_UL4"
 #define SOF_DMA_UL5 "SOF_DMA_UL5"
 
-struct mt8195_card_data {
-	const char *name;
-	unsigned long quirk;
-};
-
 struct mt8195_mt6359_priv {
-	struct snd_soc_jack headset_jack;
-	struct snd_soc_jack dp_jack;
-	struct snd_soc_jack hdmi_jack;
 	struct clk *i2so1_mclk;
 };
 
+enum mt8195_jacks {
+	MT8195_JACK_HEADSET,
+	MT8195_JACK_DP,
+	MT8195_JACK_HDMI,
+	MT8195_JACK_MAX,
+};
+
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin mt8195_jack_pins[] = {
 	{
@@ -382,33 +389,31 @@ static const struct snd_soc_ops mt8195_dptx_ops = {
 static int mt8195_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
-	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8195_JACK_DP];
 	struct snd_soc_component *cmpnt_codec =
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
-				    &priv->dp_jack);
+	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT, jack);
 	if (ret)
 		return ret;
 
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->dp_jack, NULL);
+	return snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
 }
 
 static int mt8195_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
-	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8195_JACK_HDMI];
 	struct snd_soc_component *cmpnt_codec =
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	int ret;
 
-	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
-				    &priv->hdmi_jack);
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT, jack);
 	if (ret)
 		return ret;
 
-	return snd_soc_component_set_jack(cmpnt_codec, &priv->hdmi_jack, NULL);
+	return snd_soc_component_set_jack(cmpnt_codec, jack, NULL);
 }
 
 static int mt8195_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -566,7 +571,7 @@ static int mt8195_rt5682_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_rtd_to_codec(rtd, 0)->component;
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
 	struct mt8195_mt6359_priv *priv = soc_card_data->mach_priv;
-	struct snd_soc_jack *jack = &priv->headset_jack;
+	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8195_JACK_HEADSET];
 	struct snd_soc_component *cmpnt_afe =
 		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
@@ -687,7 +692,7 @@ static int mt8195_rt1011_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-static int mt8195_rt1019_init(struct snd_soc_pcm_runtime *rtd)
+static int mt8195_dumb_amp_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	int ret;
@@ -707,6 +712,18 @@ static int mt8195_rt1019_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	return 0;
+}
+
+static int mt8195_rt1019_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	ret = mt8195_dumb_amp_init(rtd);
+	if (ret)
+		return ret;
+
 	ret = snd_soc_dapm_add_routes(&card->dapm, mt8195_rt1019_routes,
 				      ARRAY_SIZE(mt8195_rt1019_routes));
 	if (ret)
@@ -1371,108 +1388,31 @@ static int mt8195_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 	return ret;
 }
 
-static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
+static int mt8195_mt6359_legacy_probe(struct mtk_soc_card_data *soc_card_data)
 {
-	struct snd_soc_card *card = &mt8195_mt6359_soc_card;
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = card_data->card;
+	struct device_node *codec_node, *dp_node, *hdmi_node;
 	struct snd_soc_dai_link *dai_link;
-	struct mtk_soc_card_data *soc_card_data;
-	struct mt8195_mt6359_priv *mach_priv;
-	struct device_node *platform_node, *adsp_node, *codec_node, *dp_node, *hdmi_node;
-	struct mt8195_card_data *card_data;
-	int is5682s = 0;
-	int init6359 = 0;
-	int sof_on = 0;
-	int ret, i;
-
-	card_data = (struct mt8195_card_data *)of_device_get_match_data(&pdev->dev);
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_of_parse_card_name(card, "model");
-	if (ret) {
-		dev_err(&pdev->dev, "%s new card name parsing error %d\n",
-			__func__, ret);
-		return ret;
-	}
-
-	if (!card->name)
-		card->name = card_data->name;
+	struct device *dev = card->dev;
+	bool is5682s, init6359 = false;
+	int i;
 
 	if (strstr(card->name, "_5682s")) {
 		codec_node = of_find_compatible_node(NULL, NULL, "realtek,rt5682s");
-		is5682s = 1;
-	} else
-		codec_node = of_find_compatible_node(NULL, NULL, "realtek,rt5682i");
-
-	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*card_data), GFP_KERNEL);
-	if (!soc_card_data)
-		return -ENOMEM;
-
-	mach_priv = devm_kzalloc(&pdev->dev, sizeof(*mach_priv), GFP_KERNEL);
-	if (!mach_priv)
-		return -ENOMEM;
-
-	soc_card_data->mach_priv = mach_priv;
-
-	adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
-	if (adsp_node) {
-		struct mtk_sof_priv *sof_priv;
-
-		sof_priv = devm_kzalloc(&pdev->dev, sizeof(*sof_priv), GFP_KERNEL);
-		if (!sof_priv) {
-			ret = -ENOMEM;
-			goto err_kzalloc;
-		}
-		sof_priv->conn_streams = g_sof_conn_streams;
-		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
-		sof_priv->sof_dai_link_fixup = mt8195_dai_link_fixup;
-		soc_card_data->sof_priv = sof_priv;
-		card->probe = mtk_sof_card_probe;
-		card->late_probe = mtk_sof_card_late_probe;
-		if (!card->topology_shortname_created) {
-			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
-			card->topology_shortname_created = true;
-		}
-		card->name = card->topology_shortname;
-		sof_on = 1;
-	}
-
-	if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
-		ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
-					       "mediatek,dai-link",
-					       mt8195_mt6359_dai_links,
-					       ARRAY_SIZE(mt8195_mt6359_dai_links));
-		if (ret) {
-			dev_dbg(&pdev->dev, "Parse dai-link fail\n");
-			goto err_parse_of;
-		}
+		is5682s = true;
 	} else {
-		if (!sof_on)
-			card->num_links = DAI_LINK_REGULAR_NUM;
-	}
-
-	platform_node = of_parse_phandle(pdev->dev.of_node,
-					 "mediatek,platform", 0);
-	if (!platform_node) {
-		dev_dbg(&pdev->dev, "Property 'platform' missing or invalid\n");
-		ret = -EINVAL;
-		goto err_platform_node;
+		codec_node = of_find_compatible_node(NULL, NULL, "realtek,rt5682i");
+		is5682s = false;
 	}
 
-	dp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,dptx-codec", 0);
-	hdmi_node = of_parse_phandle(pdev->dev.of_node,
-				     "mediatek,hdmi-codec", 0);
+	dp_node = of_parse_phandle(dev->of_node, "mediatek,dptx-codec", 0);
+	hdmi_node = of_parse_phandle(dev->of_node, "mediatek,hdmi-codec", 0);
 
 	for_each_card_prelinks(card, i, dai_link) {
-		if (!dai_link->platforms->name) {
-			if (!strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")) && sof_on)
-				dai_link->platforms->of_node = adsp_node;
-			else
-				dai_link->platforms->of_node = platform_node;
-		}
-
 		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
 			if (!dp_node) {
-				dev_dbg(&pdev->dev, "No property 'dptx-codec'\n");
+				dev_dbg(dev, "No property 'dptx-codec'\n");
 			} else {
 				dai_link->codecs->of_node = dp_node;
 				dai_link->codecs->name = NULL;
@@ -1481,7 +1421,7 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 			}
 		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
 			if (!hdmi_node) {
-				dev_dbg(&pdev->dev, "No property 'hdmi-codec'\n");
+				dev_dbg(dev, "No property 'hdmi-codec'\n");
 			} else {
 				dai_link->codecs->of_node = hdmi_node;
 				dai_link->codecs->name = NULL;
@@ -1490,7 +1430,7 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 			}
 		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0) {
 			if (!codec_node) {
-				dev_err(&pdev->dev, "Codec not found!\n");
+				dev_err(dev, "Codec not found!\n");
 			} else {
 				dai_link->codecs->of_node = codec_node;
 				dai_link->codecs->name = NULL;
@@ -1501,7 +1441,7 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 			}
 		} else if (strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
 			if (!codec_node) {
-				dev_err(&pdev->dev, "Codec not found!\n");
+				dev_err(dev, "Codec not found!\n");
 			} else {
 				dai_link->codecs->of_node = codec_node;
 				dai_link->codecs->name = NULL;
@@ -1514,10 +1454,10 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 			   strcmp(dai_link->name, "UL_SRC2_BE") == 0) {
 			if (!init6359) {
 				dai_link->init = mt8195_mt6359_init;
-				init6359 = 1;
+				init6359 = true;
 			}
 		} else if (strcmp(dai_link->name, "ETDM2_OUT_BE") == 0) {
-			switch (card_data->quirk) {
+			switch (card_data->flags) {
 			case RT1011_SPEAKER_AMP_PRESENT:
 				dai_link->codecs = rt1011_comps;
 				dai_link->num_codecs = ARRAY_SIZE(rt1011_comps);
@@ -1545,33 +1485,119 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 		}
 	}
 
-	snd_soc_card_set_drvdata(card, soc_card_data);
+	return 0;
+}
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
+static int mt8195_mt6359_soc_card_probe(struct mtk_soc_card_data *soc_card_data, bool legacy)
+{
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
+	struct snd_soc_card *card = card_data->card;
+	struct mt8195_mt6359_priv *mach_priv;
+	struct snd_soc_dai_link *dai_link;
+	u8 codec_init = 0;
+	int i;
 
-	of_node_put(platform_node);
-	of_node_put(dp_node);
-	of_node_put(hdmi_node);
-err_kzalloc:
-err_parse_of:
-err_platform_node:
-	of_node_put(adsp_node);
-	return ret;
+	mach_priv = devm_kzalloc(card->dev, sizeof(*mach_priv), GFP_KERNEL);
+	if (!mach_priv)
+		return -ENOMEM;
+
+	soc_card_data->mach_priv = mach_priv;
+
+	if (legacy)
+		return mt8195_mt6359_legacy_probe(soc_card_data);
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
+			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+				dai_link->init = mt8195_dptx_codec_init;
+		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
+			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+				dai_link->init = mt8195_hdmi_codec_init;
+		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC1_BE") == 0 ||
+			   strcmp(dai_link->name, "UL_SRC2_BE") == 0) {
+			if (!(codec_init & MT6359_CODEC_INIT)) {
+				dai_link->init = mt8195_mt6359_init;
+				codec_init |= MT6359_CODEC_INIT;
+			}
+		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM2_OUT_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM1_IN_BE") == 0 ||
+			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
+			if (!strcmp(dai_link->codecs->dai_name, MAX98390_CODEC_DAI)) {
+				if (!(codec_init & MAX98390_CODEC_INIT)) {
+					dai_link->init = mt8195_max98390_init;
+					codec_init |= MAX98390_CODEC_INIT;
+				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT1011_CODEC_DAI)) {
+				dai_link->ops = &mt8195_rt1011_etdm_ops;
+				if (!(codec_init & RT1011_CODEC_INIT)) {
+					dai_link->init = mt8195_rt1011_init;
+					codec_init |= RT1011_CODEC_INIT;
+				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT1019_CODEC_DAI)) {
+				if (!(codec_init & RT1019_CODEC_INIT)) {
+					dai_link->init = mt8195_rt1019_init;
+					codec_init |= RT1019_CODEC_INIT;
+				}
+			} else if (!strcmp(dai_link->codecs->dai_name, RT5682_CODEC_DAI) ||
+				   !strcmp(dai_link->codecs->dai_name, RT5682S_CODEC_DAI)) {
+				dai_link->ops = &mt8195_rt5682_etdm_ops;
+				if (!(codec_init & RT5682_CODEC_INIT)) {
+					dai_link->init = mt8195_rt5682_init;
+					codec_init |= RT5682_CODEC_INIT;
+				}
+			} else {
+				if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai")) {
+					if (!(codec_init & DUMB_CODEC_INIT)) {
+						dai_link->init = mt8195_dumb_amp_init;
+						codec_init |= DUMB_CODEC_INIT;
+					}
+				}
+			}
+		}
+	}
+
+	return 0;
 }
 
-static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card = {
-	.name = "mt8195_r1019_5682",
-	.quirk = RT1019_SPEAKER_AMP_PRESENT,
+static const struct mtk_sof_priv mt8195_sof_priv = {
+	.conn_streams = g_sof_conn_streams,
+	.num_streams = ARRAY_SIZE(g_sof_conn_streams),
+	.sof_dai_link_fixup = mt8195_dai_link_fixup
 };
 
-static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card = {
-	.name = "mt8195_r1011_5682",
-	.quirk = RT1011_SPEAKER_AMP_PRESENT,
+static const struct mtk_soundcard_pdata mt8195_mt6359_rt1019_rt5682_card = {
+	.card_name = "mt8195_r1019_5682",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8195_mt6359_soc_card,
+		.num_jacks = MT8195_JACK_MAX,
+		.flags = RT1019_SPEAKER_AMP_PRESENT
+	},
+	.sof_priv = &mt8195_sof_priv,
+	.soc_probe = mt8195_mt6359_soc_card_probe
 };
 
-static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card = {
-	.name = "mt8195_m98390_r5682",
-	.quirk = MAX98390_SPEAKER_AMP_PRESENT,
+static const struct mtk_soundcard_pdata mt8195_mt6359_rt1011_rt5682_card = {
+	.card_name = "mt8195_r1011_5682",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8195_mt6359_soc_card,
+		.num_jacks = MT8195_JACK_MAX,
+		.flags = RT1011_SPEAKER_AMP_PRESENT
+	},
+	.sof_priv = &mt8195_sof_priv,
+	.soc_probe = mt8195_mt6359_soc_card_probe
+};
+
+static const struct mtk_soundcard_pdata mt8195_mt6359_max98390_rt5682_card = {
+	.card_name = "mt8195_m98390_r5682",
+	.card_data = &(struct mtk_platform_card_data) {
+		.card = &mt8195_mt6359_soc_card,
+		.num_jacks = MT8195_JACK_MAX,
+		.flags = MAX98390_SPEAKER_AMP_PRESENT
+	},
+	.sof_priv = &mt8195_sof_priv,
+	.soc_probe = mt8195_mt6359_soc_card_probe
 };
 
 static const struct of_device_id mt8195_mt6359_dt_match[] = {
@@ -1597,7 +1623,7 @@ static struct platform_driver mt8195_mt6359_driver = {
 		.of_match_table = mt8195_mt6359_dt_match,
 		.pm = &snd_soc_pm_ops,
 	},
-	.probe = mt8195_mt6359_dev_probe,
+	.probe = mtk_soundcard_common_probe,
 };
 
 module_platform_driver(mt8195_mt6359_driver);
-- 
2.44.0


