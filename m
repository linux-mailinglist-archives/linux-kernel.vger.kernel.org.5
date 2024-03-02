Return-Path: <linux-kernel+bounces-89459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C686F09C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8DA1F222B9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A57B1BC47;
	Sat,  2 Mar 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="wKYf2ij8"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34417BAB;
	Sat,  2 Mar 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388053; cv=none; b=f2NY0Qi3CTBvbJKd8/FM8KZofo9kbuqU+JNJgrKlRZvM+UF3OcnKWc6lnk7PO9yHojaSxSJOgZHyelrb1xPbhqyuEgEZkA210xnJ7r5A5XdoXpTPm27wDD3T5gkakw7LmNmKeLHWPR/A1DrXjExpbR7fqBvYePb4CBZajCSuhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388053; c=relaxed/simple;
	bh=Z28QC5gcB/zs8Hn8IrbI18nN31MND5p/CuLpPPG6++U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzppvI+sEgZbMV686MDpbeG+4hQlGweYRDN2fO+weZBSOl2MVRByv+5thH+cIZ4Az+k4u/x4Siet/QY8jVqNX0RgEvYw/fRpPJ7G/cRq/qezXDlZHUvijPpGYWnW1dLayKytHyC7SwIUzBEL2pyoKIrqPfo6/9EyB+mKH1f2/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=wKYf2ij8; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1709388045; bh=Z28QC5gcB/zs8Hn8IrbI18nN31MND5p/CuLpPPG6++U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=wKYf2ij8vG7DwafJasLhwAaCtBDnoIscdrv85dfXjKfXM+C95rP8MM901ftzykFDb
	 Zx5//2lV7HVji/zlfazVO1zhkhPf6/vN42HqVwuOcmSRZOr+ucGV6UJEzpNsRWDn81
	 TByo+g2iIcJY4VNimrmv9KdTuJaxorjEvN78NMNw=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Samuel Holland <samuel@sholland.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 1/4] ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
Date: Sat,  2 Mar 2024 15:00:35 +0100
Message-ID: <20240302140042.1990256-2-megi@xff.cz>
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

From: Samuel Holland <samuel@sholland.org>

With idle_bias_on and suspend_bias_off, there are bias level transitions
that match the suspend/resume callbacks. However, there are also
transitions during probe (OFF => STANDBY) and removal (STANDBY => OFF).

By using the set_bias_level hook, the driver can have one copy of code
that would otherwise be duplicated between the probe/resume and
suspend/remove hooks.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Ondřej Jirman <megi@xff.cz>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 29 +++++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 8a32d05e23e1..cedd4de42d1a 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -471,17 +471,23 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "EARPIECE", NULL, "Earpiece Amp" },
 };
 
-static int sun50i_a64_codec_suspend(struct snd_soc_component *component)
+static int sun50i_a64_codec_set_bias_level(struct snd_soc_component *component,
+					   enum snd_soc_bias_level level)
 {
-	return regmap_update_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
-				  BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE),
-				  BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE));
-}
+	switch (level) {
+	case SND_SOC_BIAS_OFF:
+		regmap_set_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
+				BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE));
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regmap_clear_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
+				   BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE));
+		break;
+	default:
+		break;
+	}
 
-static int sun50i_a64_codec_resume(struct snd_soc_component *component)
-{
-	return regmap_update_bits(component->regmap, SUN50I_ADDA_HP_CTRL,
-				  BIT(SUN50I_ADDA_HP_CTRL_PA_CLK_GATE), 0);
+	return 0;
 }
 
 static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
@@ -491,8 +497,9 @@ static const struct snd_soc_component_driver sun50i_codec_analog_cmpnt_drv = {
 	.num_dapm_widgets	= ARRAY_SIZE(sun50i_a64_codec_widgets),
 	.dapm_routes		= sun50i_a64_codec_routes,
 	.num_dapm_routes	= ARRAY_SIZE(sun50i_a64_codec_routes),
-	.suspend		= sun50i_a64_codec_suspend,
-	.resume			= sun50i_a64_codec_resume,
+	.set_bias_level		= sun50i_a64_codec_set_bias_level,
+	.idle_bias_on		= true,
+	.suspend_bias_off	= true,
 };
 
 static const struct of_device_id sun50i_codec_analog_of_match[] = {
-- 
2.44.0


