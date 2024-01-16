Return-Path: <linux-kernel+bounces-27186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB282EBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E07B2354A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D513AC2;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlvOdhA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703012B9B;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9666AC433B1;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=giZJPjzHIAgbfcWBFZIpouzW5e8CYSbpzSOMlA3D6XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlvOdhA0zQtwZG5lzcUOSlPuXQDc/qCeZA8RaccbofgGVxpFhv6Q5rwq1FUwI/Jy8
	 oXAZj8+b2auxyE/HJrTlvLXK+r5Kie1TVZUQKq6sMTz90IZgs42pLF70ki/9ZrdDPB
	 /Gqc6aY0tBhyCJV3OOoKZkgEmw11C38GjUaprBbJw7cSuHK8KDixDHhqdiMSK4RyfJ
	 ZGEWfbnXGVgGjBBtFYjcSIxHU8vYdsBxqs6BuMs/DZdNOcL2ANf6+z9eMRUNznUZj5
	 8bMq//F8nOLHX7PWBy/9CpglUpYXxWrZ07+nbyWKXjEeit6pzR98pEFaXc1so7e6NV
	 Y7+Qgcj+Ce06Q==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv6-00053b-1y;
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
Subject: [PATCH 6/7] ASoC: codecs: wcd934x: drop dead gain hacks
Date: Tue, 16 Jan 2024 10:39:02 +0100
Message-ID: <20240116093903.19403-7-johan+linaro@kernel.org>
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
some essentially dead code that reads out the gain and writes it back
again on DAPM events.

Drop these incomplete and pointless hacks.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 102 ++++++++-----------------------------
 1 file changed, 22 insertions(+), 80 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1b6e376f3833..34e97d39a146 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -4357,12 +4357,8 @@ static int wcd934x_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 					 struct snd_kcontrol *kc, int event)
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	int offset_val = 0;
-	u16 gain_reg, mix_reg;
-	int val = 0;
+	u16 mix_reg;
 
-	gain_reg = WCD934X_CDC_RX0_RX_VOL_MIX_CTL +
-					(w->shift * WCD934X_RX_PATH_CTL_OFFSET);
 	mix_reg = WCD934X_CDC_RX0_RX_PATH_MIX_CTL +
 					(w->shift * WCD934X_RX_PATH_CTL_OFFSET);
 
@@ -4373,12 +4369,6 @@ static int wcd934x_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
 					      WCD934X_CDC_RX_MIX_CLK_EN_MASK,
 					      WCD934X_CDC_RX_MIX_CLK_ENABLE);
 		break;
-
-	case SND_SOC_DAPM_POST_PMU:
-		val = snd_soc_component_read(comp, gain_reg);
-		val += offset_val;
-		snd_soc_component_write(comp, gain_reg, val);
-		break;
 	}
 
 	return 0;
@@ -4418,26 +4408,6 @@ static int wcd934x_codec_set_iir_gain(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int wcd934x_codec_enable_main_path(struct snd_soc_dapm_widget *w,
-					  struct snd_kcontrol *kcontrol,
-					  int event)
-{
-	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	u16 gain_reg;
-
-	gain_reg = WCD934X_CDC_RX0_RX_VOL_CTL + (w->shift *
-						 WCD934X_RX_PATH_CTL_OFFSET);
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_component_write(comp, gain_reg,
-				snd_soc_component_read(comp, gain_reg));
-		break;
-	}
-
-	return 0;
-}
-
 static int wcd934x_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 				       struct snd_kcontrol *kc, int event)
 {
@@ -5238,32 +5208,25 @@ static const struct snd_soc_dapm_widget wcd934x_dapm_widgets[] = {
 
 	SND_SOC_DAPM_MUX_E("RX INT0_2 MUX", SND_SOC_NOPM, INTERP_EAR, 0,
 			   &rx_int0_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT1_2 MUX", SND_SOC_NOPM, INTERP_HPHL, 0,
 			   &rx_int1_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT2_2 MUX", SND_SOC_NOPM, INTERP_HPHR, 0,
 			   &rx_int2_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT3_2 MUX", SND_SOC_NOPM, INTERP_LO1, 0,
 			   &rx_int3_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT4_2 MUX", SND_SOC_NOPM, INTERP_LO2, 0,
 			   &rx_int4_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT7_2 MUX", SND_SOC_NOPM, INTERP_SPKR1, 0,
 			   &rx_int7_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX_E("RX INT8_2 MUX", SND_SOC_NOPM, INTERP_SPKR2, 0,
 			   &rx_int8_2_mux, wcd934x_codec_enable_mix_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_MUX("RX INT0_1 MIX1 INP0", SND_SOC_NOPM, 0, 0,
 			 &rx_int0_1_mix_inp0_mux),
@@ -5389,41 +5352,20 @@ static const struct snd_soc_dapm_widget wcd934x_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("RX INT2 DEM MUX", SND_SOC_NOPM, 0, 0,
 			 &rx_int2_dem_inp_mux),
 
-	SND_SOC_DAPM_MUX_E("RX INT0_1 INTERP", SND_SOC_NOPM, INTERP_EAR, 0,
-			   &rx_int0_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("RX INT1_1 INTERP", SND_SOC_NOPM, INTERP_HPHL, 0,
-			   &rx_int1_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("RX INT2_1 INTERP", SND_SOC_NOPM, INTERP_HPHR, 0,
-			   &rx_int2_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("RX INT3_1 INTERP", SND_SOC_NOPM, INTERP_LO1, 0,
-			   &rx_int3_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("RX INT4_1 INTERP", SND_SOC_NOPM, INTERP_LO2, 0,
-			   &rx_int4_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("RX INT7_1 INTERP", SND_SOC_NOPM, INTERP_SPKR1, 0,
-			   &rx_int7_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX_E("RX INT8_1 INTERP", SND_SOC_NOPM, INTERP_SPKR2, 0,
-			   &rx_int8_1_interp_mux,
-			   wcd934x_codec_enable_main_path,
-			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-			   SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MUX("RX INT0_1 INTERP", SND_SOC_NOPM, INTERP_EAR, 0,
+			   &rx_int0_1_interp_mux),
+	SND_SOC_DAPM_MUX("RX INT1_1 INTERP", SND_SOC_NOPM, INTERP_HPHL, 0,
+			   &rx_int1_1_interp_mux),
+	SND_SOC_DAPM_MUX("RX INT2_1 INTERP", SND_SOC_NOPM, INTERP_HPHR, 0,
+			   &rx_int2_1_interp_mux),
+	SND_SOC_DAPM_MUX("RX INT3_1 INTERP", SND_SOC_NOPM, INTERP_LO1, 0,
+			   &rx_int3_1_interp_mux),
+	SND_SOC_DAPM_MUX("RX INT4_1 INTERP", SND_SOC_NOPM, INTERP_LO2, 0,
+			   &rx_int4_1_interp_mux),
+	SND_SOC_DAPM_MUX("RX INT7_1 INTERP", SND_SOC_NOPM, INTERP_SPKR1, 0,
+			   &rx_int7_1_interp_mux),
+	SND_SOC_DAPM_MUX("RX INT8_1 INTERP", SND_SOC_NOPM, INTERP_SPKR2, 0,
+			   &rx_int8_1_interp_mux),
 
 	SND_SOC_DAPM_MUX("RX INT0_2 INTERP", SND_SOC_NOPM, 0, 0,
 			 &rx_int0_2_interp_mux),
-- 
2.41.0


