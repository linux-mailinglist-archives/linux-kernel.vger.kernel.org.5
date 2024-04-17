Return-Path: <linux-kernel+bounces-148146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D028A7E50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B7B21AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA6128382;
	Wed, 17 Apr 2024 08:31:39 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEA1EB40;
	Wed, 17 Apr 2024 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342698; cv=none; b=gHrmegqdJZYSnwIgpSQ+GA5qVdJpSW36IG7LfydmN+FAjbWQxbPPjp8ysXtop6nINqDhUzLSnIQqfa7DbHu4LPnrU2LORR0CAejgwocnuosJlvhacalQ6hvZPE+WfcftsP39CvBowKZ0cVwcuBpz8fGijRDneHv/97W6qamta+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342698; c=relaxed/simple;
	bh=gqVlI2l96npSd91JE19kJxMfB/R1Y8mtt2hgaaOT1v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdLKCXQCBnXUpTdGWwoQYwqlwnLO7Bhl5+fRxONBYnZkxfQzR/G1lQTEcl7iIjCun3STjze2sEA54AmcyyhxC90hAh2FzwL5zqljGUaVAGQ0z89g7Op4EczTbAD+P8w2J5L6Og/oIgwEqH0FRtIvVrxGVnsWEpeCHZYMbXorjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 9F8772F2023F; Wed, 17 Apr 2024 08:31:28 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 3F34B2F20243;
	Wed, 17 Apr 2024 08:31:18 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	zhuning0077@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 6.1.y 1/6] ASoC: codecs: ES8326: Add es8326_mute function
Date: Wed, 17 Apr 2024 11:31:11 +0300
Message-Id: <20240417083116.608610-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240417083116.608610-1-kovalev@altlinux.org>
References: <20240417083116.608610-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ning <zhuning0077@gmail.com>

Commit 083912c240de0c5f797da0443f5a99e87b75fcb3 upstream.

The internal analog power and hp Vref of es8326 should always be on to
reduce pop noise. The HP_VOL and HP_CAL are moved to es8326_mute function
so they are turned on at last and turned off at first.

Also, the calibration should be done manually once during start-up
to reduce DC offset on headphone.

Signed-off-by: Zhu Ning <zhuning0077@gmail.com>
Link: https://lore.kernel.org/r/20230714032453.3334-1-zhuning0077@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/soc/codecs/es8326.c | 75 ++++++++++++++++-----------------------
 sound/soc/codecs/es8326.h |  8 +++--
 2 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 555125efd9ad3f..caee0d66ce47a8 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -38,6 +38,9 @@ struct es8326_priv {
 	u8 interrupt_clk;
 	bool jd_inverted;
 	unsigned int sysclk;
+
+	bool calibrated;
+	int version;
 };
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(dac_vol_tlv, -9550, 50, 0);
@@ -121,33 +124,12 @@ static const struct snd_soc_dapm_widget es8326_dapm_widgets[] = {
 	/* Analog Power Supply*/
 	SND_SOC_DAPM_DAC("Right DAC", NULL, ES8326_ANA_PDN, 0, 1),
 	SND_SOC_DAPM_DAC("Left DAC", NULL, ES8326_ANA_PDN, 1, 1),
-	SND_SOC_DAPM_SUPPLY("Analog Power", ES8326_ANA_PDN, 7, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("IBias Power", ES8326_ANA_PDN, 6, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("ADC Vref", ES8326_ANA_PDN, 5, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("DAC Vref", ES8326_ANA_PDN, 4, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("Vref Power", ES8326_ANA_PDN, 3, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS1", ES8326_ANA_MICBIAS, 2, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS2", ES8326_ANA_MICBIAS, 3, 0, NULL, 0),
 
 	SND_SOC_DAPM_PGA("LHPMIX", ES8326_DAC2HPMIX, 7, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("RHPMIX", ES8326_DAC2HPMIX, 3, 0, NULL, 0),
 
-	/* Headphone Charge Pump and Output */
-	SND_SOC_DAPM_SUPPLY("HPOR Cal", ES8326_HP_CAL, 7, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("HPOL Cal", ES8326_HP_CAL, 3, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("Headphone Charge Pump", ES8326_HP_DRIVER,
-			    3, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("Headphone Driver Bias", ES8326_HP_DRIVER,
-			    2, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("Headphone LDO", ES8326_HP_DRIVER,
-			    1, 1, NULL, 0),
-	SND_SOC_DAPM_SUPPLY("Headphone Reference", ES8326_HP_DRIVER,
-			    0, 1, NULL, 0),
-	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPOR Supply", ES8326_HP_CAL,
-			 ES8326_HPOR_SHIFT, 7, 7, 0),
-	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPOL Supply", ES8326_HP_CAL,
-			 0, 7, 7, 0),
-
 	SND_SOC_DAPM_OUTPUT("HPOL"),
 	SND_SOC_DAPM_OUTPUT("HPOR"),
 };
@@ -166,34 +148,12 @@ static const struct snd_soc_dapm_route es8326_dapm_routes[] = {
 	{"I2S OUT", NULL, "ADC L"},
 	{"I2S OUT", NULL, "ADC R"},
 
-	{"I2S OUT", NULL, "Analog Power"},
-	{"I2S OUT", NULL, "ADC Vref"},
-	{"I2S OUT", NULL, "Vref Power"},
-	{"I2S OUT", NULL, "IBias Power"},
-	{"I2S IN", NULL, "Analog Power"},
-	{"I2S IN", NULL, "DAC Vref"},
-	{"I2S IN", NULL, "Vref Power"},
-	{"I2S IN", NULL, "IBias Power"},
-
 	{"Right DAC", NULL, "I2S IN"},
 	{"Left DAC", NULL, "I2S IN"},
 
 	{"LHPMIX", NULL, "Left DAC"},
 	{"RHPMIX", NULL, "Right DAC"},
 
-	{"HPOR", NULL, "HPOR Cal"},
-	{"HPOL", NULL, "HPOL Cal"},
-	{"HPOR", NULL, "HPOR Supply"},
-	{"HPOL", NULL, "HPOL Supply"},
-	{"HPOL", NULL, "Headphone Charge Pump"},
-	{"HPOR", NULL, "Headphone Charge Pump"},
-	{"HPOL", NULL, "Headphone Driver Bias"},
-	{"HPOR", NULL, "Headphone Driver Bias"},
-	{"HPOL", NULL, "Headphone LDO"},
-	{"HPOR", NULL, "Headphone LDO"},
-	{"HPOL", NULL, "Headphone Reference"},
-	{"HPOR", NULL, "Headphone Reference"},
-
 	{"HPOL", NULL, "LHPMIX"},
 	{"HPOR", NULL, "RHPMIX"},
 };
@@ -419,6 +379,31 @@ static int es8326_pcm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int es8326_mute(struct snd_soc_dai *dai, int mute, int direction)
+{
+	struct snd_soc_component *component = dai->component;
+	struct es8326_priv *es8326 = snd_soc_component_get_drvdata(component);
+
+	if (mute) {
+		regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_OFF);
+		regmap_update_bits(es8326->regmap, ES8326_DAC_MUTE,
+				ES8326_MUTE_MASK, ES8326_MUTE);
+		regmap_write(es8326->regmap, ES8326_HP_DRIVER, 0xf0);
+	} else {
+		if (!es8326->calibrated) {
+			regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_FORCE_CAL);
+			msleep(30);
+			es8326->calibrated = true;
+		}
+		regmap_write(es8326->regmap, ES8326_HP_DRIVER, 0xa0);
+		regmap_write(es8326->regmap, ES8326_HP_VOL, 0x00);
+		regmap_write(es8326->regmap, ES8326_HP_CAL, ES8326_HP_ON);
+		regmap_update_bits(es8326->regmap, ES8326_DAC_MUTE,
+				ES8326_MUTE_MASK, ~(ES8326_MUTE));
+	}
+	return 0;
+}
+
 static int es8326_set_bias_level(struct snd_soc_component *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -469,6 +454,8 @@ static const struct snd_soc_dai_ops es8326_ops = {
 	.hw_params = es8326_pcm_hw_params,
 	.set_fmt = es8326_set_dai_fmt,
 	.set_sysclk = es8326_set_dai_sysclk,
+	.mute_stream = es8326_mute,
+	.no_capture_mute = 1,
 };
 
 static struct snd_soc_dai_driver es8326_dai = {
@@ -691,7 +678,7 @@ static int es8326_suspend(struct snd_soc_component *component)
 
 	cancel_delayed_work_sync(&es8326->jack_detect_work);
 	es8326_disable_micbias(component);
-
+	es8326->calibrated = false;
 	regmap_write(es8326->regmap, ES8326_CLK_CTL, ES8326_CLK_OFF);
 	regcache_cache_only(es8326->regmap, true);
 	regcache_mark_dirty(es8326->regmap);
diff --git a/sound/soc/codecs/es8326.h b/sound/soc/codecs/es8326.h
index 8e5ffe5ee10da3..65ed4d1dc7da09 100644
--- a/sound/soc/codecs/es8326.h
+++ b/sound/soc/codecs/es8326.h
@@ -9,8 +9,6 @@
 #ifndef _ES8326_H
 #define _ES8326_H
 
-#define CONFIG_HHTECH_MINIPMP	1
-
 /* ES8326 register space */
 #define ES8326_RESET		0x00
 #define ES8326_CLK_CTL		0x01
@@ -94,6 +92,8 @@
 #define	ES8326_PWRUP_SEQ_EN	(1 << 5)
 #define ES8326_CODEC_RESET (0x0f << 0)
 #define ES8326_CSM_OFF (0 << 7)
+#define ES8326_MUTE_MASK (3 << 0)
+#define ES8326_MUTE (3 << 0)
 
 /* ES8326_CLK_CTL */
 #define ES8326_CLK_ON (0x7f << 0)
@@ -122,7 +122,9 @@
 #define ES8326_MIC2_SEL (1 << 5)
 
 /* ES8326_HP_CAL */
-#define ES8326_HPOR_SHIFT 4
+#define ES8326_HP_OFF 0
+#define ES8326_HP_FORCE_CAL ((1 << 7) | (1 << 3))
+#define ES8326_HP_ON ((7 << 4) | (7 << 0))
 
 /* ES8326_ADC1_SRC */
 #define ES8326_ADC1_SHIFT 0
-- 
2.33.8


