Return-Path: <linux-kernel+bounces-22028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44C829824
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970851C20E48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DDF41236;
	Wed, 10 Jan 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZZyHrYV3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980B47762;
	Wed, 10 Jan 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704884294;
	bh=ejCQ/B2168XNcMV52MIKqts9e15VwfWaFghCB5BVK5M=;
	h=From:To:Cc:Subject:Date:From;
	b=ZZyHrYV3/0myTKoWch/rgpBIlOIGYxgRA1mywFfFpVBmqCBn9/9zFri/PCwHKtDm8
	 VBzZXQF28pRNt3yryKEPWeLBMxIK8IdBwRk/3y4JnPUwgPg4yk/C2OiEmBFvOKAOzn
	 9PyMICsaY/bVtP1YUh0qnXBcydNwdryl37wgf67EFayGxaZqFrZTL2q94jItQLKg/N
	 Q0e8CnDgQa+GD6IqkcobAFTv/e8mRFvXh8kt3pbZZ4Li2y75ipw7pGUEqjeDVoqHbR
	 /GHZLCtopQ4/BgvkMQ38FEJI2RinLXuQz6Bd5yEu+aKFzlS3KE/0Hiw7lAWyguGcdG
	 1NDRZi+UR0WZw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A85273780C21;
	Wed, 10 Jan 2024 10:58:13 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	u.kleine-koenig@pengutronix.de,
	kuninori.morimoto.gx@renesas.com,
	trevor.wu@mediatek.com,
	jernej.skrabec@gmail.com,
	claudiu.beznea@tuxon.dev,
	robh@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8195: Remove afe-dai component and rework codec link
Date: Wed, 10 Jan 2024 11:57:57 +0100
Message-ID: <20240110105757.539089-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the extra 'mt8195-afe-pcm-dai' component, register the DAI
drivers to the main AFE component, and rework the DAI linking between
the headset codec (RT5682/RT5682S) and the TDM interface in the probe
function to stop assigning name, relying on the of_node of the codec.
Also replace the COMP_DUMMY codec entry with a COMP_EMPTY for the
ETDM2_IN and remove it entirely from ETDM1_OUT to fix the registration
flow for this sound card.

While at it, since we also need to swap the codec init function from
ETDM2_IN to ETDM1_OUT, remove the static assignment of both `ops` and
`init` for both, as we now assign these dynamically during probe.

Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_DUMMY()")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

This was tested on the MT8195 Cherry Tomato Chromebook w/Pipewire:
audio works again with both internal speakers and 3.5mm jack.
As a (mostly personal) note, this driver's probe function should get
refactored at some point to rely on snd_soc_of_parse_audio_routing()
instead; I plan to do that as soon as I can (bandwidth permitting...!)

 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 33 +----------------
 sound/soc/mediatek/mt8195/mt8195-mt6359.c  | 41 +++++++++++++++-------
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 1e33863c85ca..620d7ade1992 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -1795,10 +1795,6 @@ static const struct snd_kcontrol_new mt8195_memif_controls[] = {
 			    MT8195_AFE_IRQ_28),
 };
 
-static const struct snd_soc_component_driver mt8195_afe_pcm_dai_component = {
-	.name = "mt8195-afe-pcm-dai",
-};
-
 static const struct mtk_base_memif_data memif_data[MT8195_AFE_MEMIF_NUM] = {
 	[MT8195_AFE_MEMIF_DL2] = {
 		.name = "DL2",
@@ -3037,7 +3033,6 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct reset_control *rstc;
 	int i, irq_id, ret;
-	struct snd_soc_component *component;
 
 	ret = of_reserved_mem_device_init(dev);
 	if (ret)
@@ -3170,36 +3165,12 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* register component */
 	ret = devm_snd_soc_register_component(dev, &mt8195_afe_component,
-					      NULL, 0);
+					      afe->dai_drivers, afe->num_dai_drivers);
 	if (ret) {
 		dev_warn(dev, "err_platform\n");
 		goto err_pm_put;
 	}
 
-	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
-	if (!component) {
-		ret = -ENOMEM;
-		goto err_pm_put;
-	}
-
-	ret = snd_soc_component_initialize(component,
-					   &mt8195_afe_pcm_dai_component,
-					   dev);
-	if (ret)
-		goto err_pm_put;
-
-#ifdef CONFIG_DEBUG_FS
-	component->debugfs_prefix = "pcm";
-#endif
-
-	ret = snd_soc_add_component(component,
-				    afe->dai_drivers,
-				    afe->num_dai_drivers);
-	if (ret) {
-		dev_warn(dev, "err_dai_component\n");
-		goto err_pm_put;
-	}
-
 	ret = regmap_multi_reg_write(afe->regmap, mt8195_afe_reg_defaults,
 				     ARRAY_SIZE(mt8195_afe_reg_defaults));
 	if (ret)
@@ -3224,8 +3195,6 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 
 static void mt8195_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_component(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8195_afe_runtime_suspend(&pdev->dev);
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 4feb9fb76967..53fd8a897b9d 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -934,12 +934,11 @@ SND_SOC_DAILINK_DEFS(ETDM1_IN_BE,
 
 SND_SOC_DAILINK_DEFS(ETDM2_IN_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_IN")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM1_OUT_BE,
 		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
-		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(ETDM2_OUT_BE,
@@ -1237,8 +1236,6 @@ static struct snd_soc_dai_link mt8195_mt6359_dai_links[] = {
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.dpcm_capture = 1,
-		.init = mt8195_rt5682_init,
-		.ops = &mt8195_rt5682_etdm_ops,
 		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
 		SND_SOC_DAILINK_REG(ETDM2_IN_BE),
 	},
@@ -1249,7 +1246,6 @@ static struct snd_soc_dai_link mt8195_mt6359_dai_links[] = {
 			SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		.dpcm_playback = 1,
-		.ops = &mt8195_rt5682_etdm_ops,
 		.be_hw_params_fixup = mt8195_etdm_hw_params_fixup,
 		SND_SOC_DAILINK_REG(ETDM1_OUT_BE),
 	},
@@ -1381,7 +1377,7 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 	struct snd_soc_dai_link *dai_link;
 	struct mtk_soc_card_data *soc_card_data;
 	struct mt8195_mt6359_priv *mach_priv;
-	struct device_node *platform_node, *adsp_node, *dp_node, *hdmi_node;
+	struct device_node *platform_node, *adsp_node, *codec_node, *dp_node, *hdmi_node;
 	struct mt8195_card_data *card_data;
 	int is5682s = 0;
 	int init6359 = 0;
@@ -1401,8 +1397,12 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 	if (!card->name)
 		card->name = card_data->name;
 
-	if (strstr(card->name, "_5682s"))
+	if (strstr(card->name, "_5682s")) {
+		codec_node = of_find_compatible_node(NULL, NULL, "realtek,rt5682s");
 		is5682s = 1;
+	} else
+		codec_node = of_find_compatible_node(NULL, NULL, "realtek,rt5682i");
+
 	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*card_data), GFP_KERNEL);
 	if (!soc_card_data)
 		return -ENOMEM;
@@ -1488,12 +1488,27 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 				dai_link->codecs->dai_name = "i2s-hifi";
 				dai_link->init = mt8195_hdmi_codec_init;
 			}
-		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0 ||
-			   strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
-			dai_link->codecs->name =
-				is5682s ? RT5682S_DEV0_NAME : RT5682_DEV0_NAME;
-			dai_link->codecs->dai_name =
-				is5682s ? RT5682S_CODEC_DAI : RT5682_CODEC_DAI;
+		} else if (strcmp(dai_link->name, "ETDM1_OUT_BE") == 0) {
+			if (!codec_node) {
+				dev_err(&pdev->dev, "Codec not found!\n");
+			} else {
+				dai_link->codecs->of_node = codec_node;
+				dai_link->codecs->name = NULL;
+				dai_link->codecs->dai_name =
+					is5682s ? RT5682S_CODEC_DAI : RT5682_CODEC_DAI;
+				dai_link->init = mt8195_rt5682_init;
+				dai_link->ops = &mt8195_rt5682_etdm_ops;
+			}
+		} else if (strcmp(dai_link->name, "ETDM2_IN_BE") == 0) {
+			if (!codec_node) {
+				dev_err(&pdev->dev, "Codec not found!\n");
+			} else {
+				dai_link->codecs->of_node = codec_node;
+				dai_link->codecs->name = NULL;
+				dai_link->codecs->dai_name =
+					is5682s ? RT5682S_CODEC_DAI : RT5682_CODEC_DAI;
+				dai_link->ops = &mt8195_rt5682_etdm_ops;
+			}
 		} else if (strcmp(dai_link->name, "DL_SRC_BE") == 0 ||
 			   strcmp(dai_link->name, "UL_SRC1_BE") == 0 ||
 			   strcmp(dai_link->name, "UL_SRC2_BE") == 0) {
-- 
2.43.0


