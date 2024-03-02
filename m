Return-Path: <linux-kernel+bounces-89456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB1586F099
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49949283CD3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3058917C7B;
	Sat,  2 Mar 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="DVN3V/z8"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F13C17BC7;
	Sat,  2 Mar 2024 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388051; cv=none; b=G5Wk8XgQbvnW5I9Tsv4fIqghCC3+2JJrha5Co34KaXqVFsxE9HZ0ZKXEaqDVwjFZFbExzdpP79uzUmg45v+zbRC5UEYb+essVbFu+r12qQ1K5ZIiTg8gJ0iYY66bJ4xwlqlqMv7xl1y0EvF/PqHK/nqgzsn4Mr6dyMO5BJJLBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388051; c=relaxed/simple;
	bh=j93r2+l7XHv0hLu50L4yLXzgY9moOiv87tc8ON5op58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlhXKS5RHXJRfWzduA/7GDm0O4H37DLGZpQo5Z9jEFdSmrENY5QWkCnsaqH8lPOeb4JgUKKfz0xAMg4jDozIDvV8FhLFi5Lmy/+HTkm0N0WnnhlmrpUMnPp5FFzktgJkU9JFSmHvUM41+VrIp0M79wQH2mVs4t3kqVynCretd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=DVN3V/z8; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1709388046; bh=j93r2+l7XHv0hLu50L4yLXzgY9moOiv87tc8ON5op58=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DVN3V/z8QQZkO91y7eRpXSf4IZkT8L8Gy+2m8kna0c7UNd0vnN85eQql7OVTI80cC
	 e+4SSmMcVAReyrzACVBnnDSO3xofDYZFvXWWgvGmOYpkrRT7IoEc00/GntcWW6w+Q7
	 awE+xI5wuv9Dua7VSAwk/6C5xHyFc/Ym7lH0zx6s=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
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
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 3/4] ASoC: sun50i-codec-analog: Enable jack detection on startup
Date: Sat,  2 Mar 2024 15:00:37 +0100
Message-ID: <20240302140042.1990256-4-megi@xff.cz>
In-Reply-To: <20240302140042.1990256-1-megi@xff.cz>
References: <20240302140042.1990256-1-megi@xff.cz>
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
2.44.0


