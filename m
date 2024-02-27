Return-Path: <linux-kernel+bounces-83192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA786900B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6401F22B95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE1B14CAD9;
	Tue, 27 Feb 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YhnWzNgf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E814AD2D;
	Tue, 27 Feb 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035847; cv=none; b=XrRO1VQoREsWAKYSzNgLNXSfYzU8hXHewMgiQtBJjzDo2iC0XOMs3ZRd4G29cmVURd0IeJI4quoow2V9hnfSRie8c701x0r1zQ6uZcVfxr8cE33RblscZ2COiSotPLVUB2T8ffZkh2k8BSAY5QSl3zzTKBEeoRXs1Msny7eXM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035847; c=relaxed/simple;
	bh=6lf3kyW4xSkggiUziJSrRhwyGxMWUnzQ+GAvBOJm5OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtL3b+HjRdjUvHwUHTIXjFLOEh3h7bFgMw+RNy/7y0tg6MYFpE1SZrJ9huqP3C5xBbp+RuqWd3ncK9rQ0VHa/cIP0zM/XNmUekw8xI5f2asfxHhm5pbS0q1JE04CVMv/Hf3/Sx3tyA3dppDuufPCDTR4/s0tZhq98DEuOvHkoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YhnWzNgf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709035844;
	bh=6lf3kyW4xSkggiUziJSrRhwyGxMWUnzQ+GAvBOJm5OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhnWzNgf+3yLUs7nJ8hl2WnKmKfLQeqdMbFkQYfHn3P1d1NTzeN6qQm+kqFJj/o12
	 pa7+dEBt58mja09bGrWlnpXZ0nq1PrLkMkorobFOkh+yMw1L7qDgik3ul1Gk+a4ntk
	 LSbyHCSIugtSDayQeDDJrokv7A/Ag2FvMesvYCE2IX0i1LmjLqYpNLd8qMcM0sw3w9
	 2pBOzGD0KORpwtBc8yWYKhTQgM4E1eGvHb79NNrWu346q8OUmL7VdCaoNDXjLEMZJz
	 aHE6XBXyTdrS9NmlVUMek921Jh50nDqU1D5BbpEEaDcKCaxLcQICSlcbdQ4AnFo5er
	 cE+iX59/h7HPA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E2DE37820E7;
	Tue, 27 Feb 2024 12:10:42 +0000 (UTC)
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
Subject: [PATCH 14/22] ASoC: mediatek: mt8186-rt1019: Migrate to the common mtk_soundcard_startup
Date: Tue, 27 Feb 2024 13:09:31 +0100
Message-ID: <20240227120939.290143-15-angelogioacchino.delregno@collabora.com>
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

Add a const mtk_pcm_constraints_data struct array with all of the
(again, constant) constraints for all of the supported usecases,
remove the duplicated functions and call mtk_soundcard_startup()
instead in all of the .startup() callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |  19 ++-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c   |   2 +-
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 132 +++++-------------
 3 files changed, 52 insertions(+), 101 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index bfcfc68ac64d..dbe5afa0e9ee 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -2729,7 +2729,7 @@ static int mt8186_afe_runtime_resume(struct device *dev)
 	struct mtk_base_afe *afe = dev_get_drvdata(dev);
 	struct mt8186_afe_private *afe_priv = afe->platform_priv;
 	int ret;
-
+pr_err("mt8186 afe runtime_resume\n");
 	ret = mt8186_afe_enable_clock(afe);
 	if (ret)
 		return ret;
@@ -2739,7 +2739,7 @@ static int mt8186_afe_runtime_resume(struct device *dev)
 		return ret;
 
 	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
-		goto skip_regmap;
+		return 0;
 
 	regcache_cache_only(afe->regmap, false);
 	regcache_sync(afe->regmap);
@@ -2758,13 +2758,20 @@ static int mt8186_afe_runtime_resume(struct device *dev)
 	/* enable AFE */
 	regmap_update_bits(afe->regmap, AFE_DAC_CON0, AUDIO_AFE_ON_MASK_SFT, BIT(0));
 
-skip_regmap:
 	return 0;
 }
 
 static int mt8186_afe_component_probe(struct snd_soc_component *component)
 {
-	mtk_afe_add_sub_dai_control(component);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	snd_soc_component_init_regmap(component, afe->regmap);
+
+	ret = mtk_afe_add_sub_dai_control(component);
+	if (ret)
+		return ret;
+
 	mt8186_add_misc_control(component);
 
 	return 0;
@@ -2929,6 +2936,10 @@ static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	ret = regmap_reinit_cache(afe->regmap, &mt8186_afe_regmap_config);
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
+
 	/* others */
 	afe->mtk_afe_hardware = &mt8186_afe_hardware;
 	afe->memif_fs = mt8186_memif_fs;
diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index dbd157d1a1ea..b87b04928678 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -413,7 +413,7 @@ static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
 			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_SUPPLY_S("AUD_PAD_TOP", SUPPLY_SEQ_ADDA_AUD_PAD_TOP,
-			      AFE_AUD_PAD_TOP, RG_RX_FIFO_ON_SFT, 0,
+			      SND_SOC_NOPM, 0, 0,
 			      mtk_adda_pad_top_event,
 			      SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_SUPPLY_S("ADDA_MTKAIF_CFG", SUPPLY_SEQ_ADDA_MTKAIF_CFG,
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
index f8856a100b27..95dcf06a91cb 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c
@@ -332,98 +332,6 @@ static int mt8186_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 	return ret;
 }
 
-static int mt8186_mt6366_rt1019_rt5682s_playback_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int rates[] = {
-		48000
-	};
-	static const unsigned int channels[] = {
-		2
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list  = channels,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8186_mt6366_rt1019_rt5682s_playback_ops = {
-	.startup = mt8186_mt6366_rt1019_rt5682s_playback_startup,
-};
-
-static int mt8186_mt6366_rt1019_rt5682s_capture_startup(struct snd_pcm_substream *substream)
-{
-	static const unsigned int rates[] = {
-		48000
-	};
-	static const unsigned int channels[] = {
-		1, 2
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_rates = {
-		.count = ARRAY_SIZE(rates),
-		.list  = rates,
-		.mask = 0,
-	};
-	static const struct snd_pcm_hw_constraint_list constraints_channels = {
-		.count = ARRAY_SIZE(channels),
-		.list  = channels,
-		.mask = 0,
-	};
-
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret;
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_RATE,
-					 &constraints_rates);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list rate failed\n");
-		return ret;
-	}
-
-	ret = snd_pcm_hw_constraint_list(runtime, 0,
-					 SNDRV_PCM_HW_PARAM_CHANNELS,
-					 &constraints_channels);
-	if (ret < 0) {
-		dev_err(rtd->dev, "hw_constraint_list channel failed\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct snd_soc_ops mt8186_mt6366_rt1019_rt5682s_capture_ops = {
-	.startup = mt8186_mt6366_rt1019_rt5682s_capture_startup,
-};
-
 /* FE */
 SND_SOC_DAILINK_DEFS(playback1,
 		     DAILINK_COMP_ARRAY(COMP_CPU("DL1")),
@@ -644,7 +552,7 @@ static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
 		.dpcm_merged_format = 1,
 		.dpcm_merged_chan = 1,
 		.dpcm_merged_rate = 1,
-		.ops = &mt8186_mt6366_rt1019_rt5682s_playback_ops,
+		.ops = &mtk_soundcard_common_playback_ops,
 		SND_SOC_DAILINK_REG(playback1),
 	},
 	{
@@ -678,7 +586,7 @@ static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
 		.dpcm_merged_format = 1,
 		.dpcm_merged_chan = 1,
 		.dpcm_merged_rate = 1,
-		.ops = &mt8186_mt6366_rt1019_rt5682s_playback_ops,
+		.ops = &mtk_soundcard_common_playback_ops,
 		SND_SOC_DAILINK_REG(playback3),
 	},
 	{
@@ -745,7 +653,7 @@ static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
 		.dpcm_merged_format = 1,
 		.dpcm_merged_chan = 1,
 		.dpcm_merged_rate = 1,
-		.ops = &mt8186_mt6366_rt1019_rt5682s_capture_ops,
+		.ops = &mtk_soundcard_common_capture_ops,
 		SND_SOC_DAILINK_REG(capture2),
 	},
 	{
@@ -767,7 +675,7 @@ static struct snd_soc_dai_link mt8186_mt6366_rt1019_rt5682s_dai_links[] = {
 		.dpcm_merged_format = 1,
 		.dpcm_merged_chan = 1,
 		.dpcm_merged_rate = 1,
-		.ops = &mt8186_mt6366_rt1019_rt5682s_capture_ops,
+		.ops = &mtk_soundcard_common_capture_ops,
 		SND_SOC_DAILINK_REG(capture4),
 	},
 	{
@@ -1220,6 +1128,32 @@ static int mt8186_mt6366_soc_card_probe(struct mtk_soc_card_data *soc_card_data,
 	return 0;
 }
 
+static const unsigned int mt8186_pcm_playback_channels[] = { 2 };
+static const unsigned int mt8186_pcm_capture_channels[] = { 1, 2 };
+static const unsigned int mt8186_pcm_rates[] = { 48000 };
+
+static const struct snd_pcm_hw_constraint_list mt8186_rate_constraint = {
+	.list = mt8186_pcm_rates,
+	.count = ARRAY_SIZE(mt8186_pcm_rates)
+};
+
+static const struct mtk_pcm_constraints_data mt8186_pcm_constraints[MTK_CONSTRAINT_CAPTURE + 1] = {
+	[MTK_CONSTRAINT_PLAYBACK] = {
+		.channels = {
+			.list = mt8186_pcm_playback_channels,
+			.count = ARRAY_SIZE(mt8186_pcm_playback_channels)
+		},
+		.rates = mt8186_rate_constraint,
+	},
+	[MTK_CONSTRAINT_CAPTURE] = {
+		.channels = {
+			.list = mt8186_pcm_capture_channels,
+			.count = ARRAY_SIZE(mt8186_pcm_capture_channels)
+		},
+		.rates = mt8186_rate_constraint,
+	}
+};
+
 static const struct mtk_sof_priv mt8186_sof_priv = {
 	.conn_streams = g_sof_conn_streams,
 	.num_streams = ARRAY_SIZE(g_sof_conn_streams),
@@ -1230,6 +1164,8 @@ static const struct mtk_soundcard_pdata mt8186_mt6366_rt1019_rt5682s_pdata = {
 	.card_data = &(struct mtk_platform_card_data) {
 		.card = &mt8186_mt6366_rt1019_rt5682s_soc_card,
 		.num_jacks = MT8186_JACK_MAX,
+		.pcm_constraints = mt8186_pcm_constraints,
+		.num_pcm_constraints = ARRAY_SIZE(mt8186_pcm_constraints),
 	},
 	.sof_priv = &mt8186_sof_priv,
 	.soc_probe = mt8186_mt6366_soc_card_probe
@@ -1239,6 +1175,8 @@ static const struct mtk_soundcard_pdata mt8186_mt6366_rt5682s_max98360_pdata = {
 	.card_data = &(struct mtk_platform_card_data) {
 		.card = &mt8186_mt6366_rt5682s_max98360_soc_card,
 		.num_jacks = MT8186_JACK_MAX,
+		.pcm_constraints = mt8186_pcm_constraints,
+		.num_pcm_constraints = ARRAY_SIZE(mt8186_pcm_constraints),
 	},
 	.sof_priv = &mt8186_sof_priv,
 	.soc_probe = mt8186_mt6366_soc_card_probe
@@ -1248,6 +1186,8 @@ static const struct mtk_soundcard_pdata mt8186_mt6366_rt5650_pdata = {
 	.card_data = &(struct mtk_platform_card_data) {
 		.card = &mt8186_mt6366_rt5650_soc_card,
 		.num_jacks = MT8186_JACK_MAX,
+		.pcm_constraints = mt8186_pcm_constraints,
+		.num_pcm_constraints = ARRAY_SIZE(mt8186_pcm_constraints),
 	},
 	.sof_priv = &mt8186_sof_priv,
 	.soc_probe = mt8186_mt6366_soc_card_probe
-- 
2.44.0


