Return-Path: <linux-kernel+bounces-79695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8E86257E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E2F1F219D4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491684C61F;
	Sat, 24 Feb 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="D88CM6ek"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC640BFE;
	Sat, 24 Feb 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782913; cv=none; b=aYtSryWjLlrOiGz1SEDKCslbKLHuu4eIZ7K05oksYES4rO+pHkqCS8X0e6vC/DfDnWAP4CNj6KpstiTwGise0Az1cxA7WzUq9oMWT304oCGnPQcF5y45UUb4SIqAyKHLPFVdieRTskuqxTLJDvf0ReC4HyMprPUXENvgn8B7J0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782913; c=relaxed/simple;
	bh=8aPsPyUjJEl/R2IiSeB6qnP9Jf53fx5I0eeKkSCAPzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGLLtW5zWdHZ7Hwp0LDSuOH4S7SXqhmAjebg9FVzwBmw7LSGAkRQWCec1SDP+3k20EYc0g1hW7xeBrh7569zDNTQIsMPrfvP5SzMZ3Wc9UfAP2Az0JUGwVW6Fmhrja8AnYLH7EAi0mebOu2jW9aD8fCvHXLGw1fn0RKPPXVSOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=D88CM6ek; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708782909; bh=8aPsPyUjJEl/R2IiSeB6qnP9Jf53fx5I0eeKkSCAPzA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=D88CM6ekulNrNZzctmxlJ60Qm8q1PGfsrWMse8uyjRRX1OdYsW1eSwCJvWLARfuOH
	 72MN8+eOGaW0jJUOolgNrp/UpcpKQn7fe2DsxtbSGRSzwAx5xBtpPrpiv93F8FV4x9
	 QEUZdgpi+wXnGngU5/RIpIQoBDjM2bycR7WwYa3Q=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ondrej Jirman <megi@xff.cz>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [RESEND PATCH v2 4/5] ASoC: sun50i-codec-analog: Enable jack detection on startup
Date: Sat, 24 Feb 2024 14:54:57 +0100
Message-ID: <20240224135501.3822390-5-megi@xff.cz>
In-Reply-To: <20240224135501.3822390-1-megi@xff.cz>
References: <20240224135501.3822390-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

This commit adds the necessary setup to enable jack detection on startup
as well as the callback function enabling the microphone ADC when
headset bias is enabled. The microphone ADC is also disabled in suspend.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: Moved MICADCEN setup to HBIAS event, added bias hooks]
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Ondřej Jirman <megi@xff.cz>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 32 ++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index cedd4de42d1a..2081721a8ff2 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -116,8 +116,10 @@
 #define SUN50I_ADDA_HS_MBIAS_CTRL_MMICBIASEN	7
 
 #define SUN50I_ADDA_JACK_MIC_CTRL	0x1d
+#define SUN50I_ADDA_JACK_MIC_CTRL_JACKDETEN	7
 #define SUN50I_ADDA_JACK_MIC_CTRL_INNERRESEN	6
 #define SUN50I_ADDA_JACK_MIC_CTRL_HMICBIASEN	5
+#define SUN50I_ADDA_JACK_MIC_CTRL_MICADCEN	4
 
 /* mixer controls */
 static const struct snd_kcontrol_new sun50i_a64_codec_mixer_controls[] = {
@@ -296,6 +298,19 @@ static const struct snd_kcontrol_new sun50i_codec_earpiece_switch[] = {
 			SUN50I_ADDA_EARPIECE_CTRL1_ESPPA_MUTE, 1, 0),
 };
 
+static int sun50i_codec_hbias_event(struct snd_soc_dapm_widget *w,
+				    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	u32 value = !!SND_SOC_DAPM_EVENT_ON(event);
+
+	regmap_update_bits(component->regmap, SUN50I_ADDA_JACK_MIC_CTRL,
+			   BIT(SUN50I_ADDA_JACK_MIC_CTRL_MICADCEN),
+			   value << SUN50I_ADDA_JACK_MIC_CTRL_MICADCEN);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* DAC */
 	SND_SOC_DAPM_DAC("Left DAC", NULL, SUN50I_ADDA_MIX_DAC_CTRL,
@@ -367,7 +382,8 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	/* Microphone Bias */
 	SND_SOC_DAPM_SUPPLY("HBIAS", SUN50I_ADDA_JACK_MIC_CTRL,
 			    SUN50I_ADDA_JACK_MIC_CTRL_HMICBIASEN,
-			    0, NULL, 0),
+			    0, sun50i_codec_hbias_event,
+			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 
 	/* Mic input path */
 	SND_SOC_DAPM_PGA("Mic2 Amplifier", SUN50I_ADDA_MIC2_CTRL,
@@ -474,14 +490,28 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 static int sun50i_a64_codec_set_bias_level(struct snd_soc_component *component,
 					   enum snd_soc_bias_level level)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	int hbias;
+
 	switch (level) {
 	case SND_SOC_BIAS_OFF:
+		regmap_clear_bits(component->regmap, SUN50I_ADDA_JACK_MIC_CTRL,
+				   BIT(SUN50I_ADDA_JACK_MIC_CTRL_JACKDETEN) |
+				   BIT(SUN50I_ADDA_JACK_MIC_CTRL_MICADCEN));
+
 		regmap_set_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
 				BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE));
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		regmap_clear_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
 				   BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE));
+
+		hbias = snd_soc_dapm_get_pin_status(dapm, "HBIAS");
+		regmap_update_bits(component->regmap, SUN50I_ADDA_JACK_MIC_CTRL,
+				   BIT(SUN50I_ADDA_JACK_MIC_CTRL_JACKDETEN) |
+				   BIT(SUN50I_ADDA_JACK_MIC_CTRL_MICADCEN),
+				   BIT(SUN50I_ADDA_JACK_MIC_CTRL_JACKDETEN) |
+				   hbias << SUN50I_ADDA_JACK_MIC_CTRL_MICADCEN);
 		break;
 	default:
 		break;
-- 
2.43.0


