Return-Path: <linux-kernel+bounces-77122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB9860170
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8A428203E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542315CD76;
	Thu, 22 Feb 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="psPTDIu/"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507F15CD4C;
	Thu, 22 Feb 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625939; cv=none; b=qhC02mKSCsbB7ZKpXDxBCWpBZhBYUK7iryLfjwtGoIbOdZBNcsI3kPgsiw4JTsHyAcpyEbsT+k0L5953zV0TPk9pIy0xPW+u8/+8QGt/AEhHiRGxOb8imWcAhkXtiWdqYBxxi2+98lqLWRt8Mm5ldrnvqs0l/ipULI5O/SgTd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625939; c=relaxed/simple;
	bh=0xAlq3FKxyKOFVzLVHdJfOKR9ZGZX8El43JyE9dp5i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYn44iveC69v6U0n5s4srt1dNcwxFmlSZOP1tOqcWIqAf9CMrcfYeeyVLi682Dyd5KwFQbe61h7DG+CNdiHDfPbSrlsSCeLE5TMuzh/kYaI+gDdGTW6cnxt7kneqVJBPDeTe9pMdR9mst6XTBU2UVf3BSl7uhYvX7KjGH0IqLSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=psPTDIu/; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708625934; bh=0xAlq3FKxyKOFVzLVHdJfOKR9ZGZX8El43JyE9dp5i8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=psPTDIu/ElVGuGT/SH5gHUemooCcfaafxJ5DKSHWm5j36mhLy6PGAgnbTW9LbJsmJ
	 7P7SnwrFWG6Xu6m0uq0vqFGUu/kqndVN9HVGlDpp0omgKN1avsYvoNVGQhxKn2xo4T
	 nnCeBqBiGQLcF+7OZdJ/PobIc1RkmZpFHSaF7SMQ=
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
Subject: [PATCH 1/4] ASoC: sun50i-codec-analog: Move suspend/resume to set_bias_level
Date: Thu, 22 Feb 2024 19:18:44 +0100
Message-ID: <20240222181851.3398254-2-megi@xff.cz>
In-Reply-To: <20240222181851.3398254-1-megi@xff.cz>
References: <20240222181851.3398254-1-megi@xff.cz>
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
2.43.0


