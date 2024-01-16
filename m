Return-Path: <linux-kernel+bounces-27190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49F82EBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1928283288
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A801B800;
	Tue, 16 Jan 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzBYrmhH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5E12E58;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDDDC433A6;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=zy0of3fiWEQpkb5cR6+C9zbsHyiHSObthcRpranYgEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzBYrmhHNQ9FbwAfpOgdV2girOOMUrZHZkXo4+L4HL6C/7+tYfaT01D3wJbYNEBPe
	 l6DfjzK6JTqmSxdlM3tGOJ0EjpbidJNk+QkCGHA+RthaUscsh3zawJlybGJ2gXNEm/
	 +kOA2yPMwxGGgJpeBdwGbtatljI/DdNUV+flNDwh54z/XKB3XsbLtOY+9uwtQ0UOAS
	 4AZ72mLrerhBDVgkkKXWEoZDyz049GYnHwdD1QGDkYJ0ggK0uNTwcS1Jdqeobuotnm
	 VkiPjyMAWnJVaZU/1liOgR6gebXldhxpxzn3ufVhUzIYoMaSRq0ZvCfAsTrscJhgHi
	 Kt0HViBoXxoDw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053Z-1g;
	Tue, 16 Jan 2024 10:39:44 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/7] ASoC: codecs: wcd9335: drop dead gain hacks
Date: Tue, 16 Jan 2024 10:39:01 +0100
Message-ID: <20240116093903.19403-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240116093903.19403-1-johan+linaro@kernel.org>
References: <20240116093903.19403-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor driver appears to be modifying the gain settings behind the
back of user space but these hacks never made it upstream except for
some essentially dead code that reads out the (cached) gain setting and
writes it back again on DAPM events.

Drop these incomplete and pointless hacks.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 115 ++++++-------------------------------
 1 file changed, 18 insertions(+), 97 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 43c648efd0d9..cee17b309160 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3028,61 +3028,6 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
-		struct snd_kcontrol *kc, int event)
-{
-	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	u16 gain_reg;
-	int offset_val = 0;
-	int val = 0;
-
-	switch (w->reg) {
-	case WCD9335_CDC_RX0_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX0_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX1_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX1_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX2_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX2_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX3_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX3_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX4_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX4_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX5_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX5_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX6_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX6_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX7_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX7_RX_VOL_MIX_CTL;
-		break;
-	case WCD9335_CDC_RX8_RX_PATH_MIX_CTL:
-		gain_reg = WCD9335_CDC_RX8_RX_VOL_MIX_CTL;
-		break;
-	default:
-		dev_err(comp->dev, "%s: No gain register avail for %s\n",
-			__func__, w->name);
-		return 0;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		val = snd_soc_component_read(comp, gain_reg);
-		val += offset_val;
-		snd_soc_component_write(comp, gain_reg, val);
-		break;
-	case SND_SOC_DAPM_POST_PMD:
-		break;
-	}
-
-	return 0;
-}
-
 static u16 wcd9335_interp_get_primary_reg(u16 reg, u16 *ind)
 {
 	u16 prim_int_reg = WCD9335_CDC_RX0_RX_PATH_CTL;
@@ -3291,38 +3236,26 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *kc, int event)
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	u16 gain_reg;
 	u16 reg;
-	int val;
-	int offset_val = 0;
 
 	if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT0 INTERP"))) {
 		reg = WCD9335_CDC_RX0_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX0_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT1 INTERP"))) {
 		reg = WCD9335_CDC_RX1_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX1_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT2 INTERP"))) {
 		reg = WCD9335_CDC_RX2_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX2_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT3 INTERP"))) {
 		reg = WCD9335_CDC_RX3_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX3_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT4 INTERP"))) {
 		reg = WCD9335_CDC_RX4_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX4_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT5 INTERP"))) {
 		reg = WCD9335_CDC_RX5_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX5_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT6 INTERP"))) {
 		reg = WCD9335_CDC_RX6_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX6_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT7 INTERP"))) {
 		reg = WCD9335_CDC_RX7_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX7_RX_VOL_CTL;
 	} else if (!(snd_soc_dapm_widget_name_cmp(w, "RX INT8 INTERP"))) {
 		reg = WCD9335_CDC_RX8_RX_PATH_CTL;
-		gain_reg = WCD9335_CDC_RX8_RX_VOL_CTL;
 	} else {
 		dev_err(comp->dev, "%s: Interpolator reg not found\n",
 			__func__);
@@ -3336,9 +3269,6 @@ static int wcd9335_codec_enable_interpolator(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		wcd9335_config_compander(comp, w->shift, event);
-		val = snd_soc_component_read(comp, gain_reg);
-		val += offset_val;
-		snd_soc_component_write(comp, gain_reg, val);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		wcd9335_config_compander(comp, w->shift, event);
@@ -4367,33 +4297,24 @@ static const struct snd_soc_dapm_widget wcd9335_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("SLIM RX5", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("SLIM RX6", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("SLIM RX7", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_MUX_E("RX INT0_2 MUX", WCD9335_CDC_RX0_RX_PATH_MIX_CTL,
-			5, 0, &rx_int0_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT1_2 MUX", WCD9335_CDC_RX1_RX_PATH_MIX_CTL,
-			5, 0, &rx_int1_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT2_2 MUX", WCD9335_CDC_RX2_RX_PATH_MIX_CTL,
-			5, 0, &rx_int2_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT3_2 MUX", WCD9335_CDC_RX3_RX_PATH_MIX_CTL,
-			5, 0, &rx_int3_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT4_2 MUX", WCD9335_CDC_RX4_RX_PATH_MIX_CTL,
-			5, 0, &rx_int4_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT5_2 MUX", WCD9335_CDC_RX5_RX_PATH_MIX_CTL,
-			5, 0, &rx_int5_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT6_2 MUX", WCD9335_CDC_RX6_RX_PATH_MIX_CTL,
-			5, 0, &rx_int6_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT7_2 MUX", WCD9335_CDC_RX7_RX_PATH_MIX_CTL,
-			5, 0, &rx_int7_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_MUX_E("RX INT8_2 MUX", WCD9335_CDC_RX8_RX_PATH_MIX_CTL,
-			5, 0, &rx_int8_2_mux, wcd9335_codec_enable_mix_path,
-			SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_MUX("RX INT0_2 MUX", WCD9335_CDC_RX0_RX_PATH_MIX_CTL,
+			5, 0, &rx_int0_2_mux),
+	SND_SOC_DAPM_MUX("RX INT1_2 MUX", WCD9335_CDC_RX1_RX_PATH_MIX_CTL,
+			5, 0, &rx_int1_2_mux),
+	SND_SOC_DAPM_MUX("RX INT2_2 MUX", WCD9335_CDC_RX2_RX_PATH_MIX_CTL,
+			5, 0, &rx_int2_2_mux),
+	SND_SOC_DAPM_MUX("RX INT3_2 MUX", WCD9335_CDC_RX3_RX_PATH_MIX_CTL,
+			5, 0, &rx_int3_2_mux),
+	SND_SOC_DAPM_MUX("RX INT4_2 MUX", WCD9335_CDC_RX4_RX_PATH_MIX_CTL,
+			5, 0, &rx_int4_2_mux),
+	SND_SOC_DAPM_MUX("RX INT5_2 MUX", WCD9335_CDC_RX5_RX_PATH_MIX_CTL,
+			5, 0, &rx_int5_2_mux),
+	SND_SOC_DAPM_MUX("RX INT6_2 MUX", WCD9335_CDC_RX6_RX_PATH_MIX_CTL,
+			5, 0, &rx_int6_2_mux),
+	SND_SOC_DAPM_MUX("RX INT7_2 MUX", WCD9335_CDC_RX7_RX_PATH_MIX_CTL,
+			5, 0, &rx_int7_2_mux),
+	SND_SOC_DAPM_MUX("RX INT8_2 MUX", WCD9335_CDC_RX8_RX_PATH_MIX_CTL,
+			5, 0, &rx_int8_2_mux),
 	SND_SOC_DAPM_MUX("RX INT0_1 MIX1 INP0", SND_SOC_NOPM, 0, 0,
 		&rx_int0_1_mix_inp0_mux),
 	SND_SOC_DAPM_MUX("RX INT0_1 MIX1 INP1", SND_SOC_NOPM, 0, 0,
-- 
2.41.0


