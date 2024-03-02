Return-Path: <linux-kernel+bounces-89458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70A86F09B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EE71F22021
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6618C01;
	Sat,  2 Mar 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="nqNlJMLp"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3BE17BB2;
	Sat,  2 Mar 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388052; cv=none; b=oZAHjjzA+/KXMw7p5vaDwizvqnnBTc8E/lD/mnBLQs1r7PE7GvyzqbqAvyYMEaZnVHUud2yXqIjrMvzMSBhiuBSKRp3egTZu9DxtyxQFqtDOJbTNUL+6eW4kX0mqYGZ3WFKDHOAwi3outm+W2LraUMSUkN+R88R64NrNZOj/EpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388052; c=relaxed/simple;
	bh=r6weZvhYPX/wRF91u8nn22GC5bL37LloOCbH075rviA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALjaNrQ5tR6+seLI/p2rUGXZFuiKgoCXgUI96ZW+BJWvmoziXUXvsOaTIPU8aVMTSoei8Q8vEPigHVW3EVKQgiacG9bapsiwtsfiuRdGeJzuYy5vOvI37GemP7i/u4jPX1+KaIDQ4Y+qg+z1nZLUww9bFxuKNKuHAvgykUzV8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=nqNlJMLp; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1709388046; bh=r6weZvhYPX/wRF91u8nn22GC5bL37LloOCbH075rviA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nqNlJMLpQsjxq+vcHWEdWxRRo0BfU/Stbv995wm/amMCZmEv0BuX9dz+HSF18MMNX
	 EiHSn4A9od7qYj0wb07RuT5N5n3ugRUeTQB6n/KwznkKr5p2ari4b/YoworsL9fYd9
	 BeiQ1WQRcohZpOMvFM6zUzQya0Oj4ylK22oZHoIQ=
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
Subject: [PATCH v3 2/4] ASoC: sun8i-codec: Enable bus clock at STANDBY and higher bias
Date: Sat,  2 Mar 2024 15:00:36 +0100
Message-ID: <20240302140042.1990256-3-megi@xff.cz>
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

For codec variants that have a bus clock, that clock must be running to
receive interrupts. Since jack and mic accessory detection should work
even when no audio is playing, that means the bus clock should be
enabled any time the system is on.

Accomplish that by tying the bus clock to the runtime PM state, which is
then tied to the bias level not being OFF. Since the codec sets
idle_bias_on, bias will generally never be OFF. However, we can set
suspend_bias_off to maintain the power savings of gating the bus clock
during suspend, when we don't expect jack/accessory detection to work.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Ondřej Jirman <megi@xff.cz>
---
 sound/soc/sunxi/sun8i-codec.c | 41 ++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 7b45ddffe990..2a46b96b03cc 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -177,12 +177,14 @@ struct sun8i_codec_aif {
 };
 
 struct sun8i_codec_quirks {
-	bool legacy_widgets	: 1;
-	bool lrck_inversion	: 1;
+	bool	bus_clock	: 1;
+	bool	legacy_widgets	: 1;
+	bool	lrck_inversion	: 1;
 };
 
 struct sun8i_codec {
 	struct regmap			*regmap;
+	struct clk			*clk_bus;
 	struct clk			*clk_module;
 	const struct sun8i_codec_quirks	*quirks;
 	struct sun8i_codec_aif		aifs[SUN8I_CODEC_NAIFS];
@@ -197,6 +199,14 @@ static int sun8i_codec_runtime_resume(struct device *dev)
 	struct sun8i_codec *scodec = dev_get_drvdata(dev);
 	int ret;
 
+	if (scodec->clk_bus) {
+		ret = clk_prepare_enable(scodec->clk_bus);
+		if (ret) {
+			dev_err(dev, "Failed to enable the bus clock\n");
+			return ret;
+		}
+	}
+
 	regcache_cache_only(scodec->regmap, false);
 
 	ret = regcache_sync(scodec->regmap);
@@ -215,6 +225,9 @@ static int sun8i_codec_runtime_suspend(struct device *dev)
 	regcache_cache_only(scodec->regmap, true);
 	regcache_mark_dirty(scodec->regmap);
 
+	if (scodec->clk_bus)
+		clk_disable_unprepare(scodec->clk_bus);
+
 	return 0;
 }
 
@@ -1277,6 +1290,7 @@ static const struct snd_soc_component_driver sun8i_soc_component = {
 	.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),
 	.probe			= sun8i_codec_component_probe,
 	.idle_bias_on		= 1,
+	.suspend_bias_off	= 1,
 	.endianness		= 1,
 };
 
@@ -1299,6 +1313,18 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 	if (!scodec)
 		return -ENOMEM;
 
+	scodec->quirks = of_device_get_match_data(&pdev->dev);
+
+	platform_set_drvdata(pdev, scodec);
+
+	if (scodec->quirks->bus_clock) {
+		scodec->clk_bus = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(scodec->clk_bus)) {
+			dev_err(&pdev->dev, "Failed to get the bus clock\n");
+			return PTR_ERR(scodec->clk_bus);
+		}
+	}
+
 	scodec->clk_module = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(scodec->clk_module)) {
 		dev_err(&pdev->dev, "Failed to get the module clock\n");
@@ -1311,17 +1337,14 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
-	scodec->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", base,
-						   &sun8i_codec_regmap_config);
+	scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					       &sun8i_codec_regmap_config);
 	if (IS_ERR(scodec->regmap)) {
 		dev_err(&pdev->dev, "Failed to create our regmap\n");
 		return PTR_ERR(scodec->regmap);
 	}
 
-	scodec->quirks = of_device_get_match_data(&pdev->dev);
-
-	platform_set_drvdata(pdev, scodec);
-
+	regcache_cache_only(scodec->regmap, true);
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun8i_codec_runtime_resume(&pdev->dev);
@@ -1357,11 +1380,13 @@ static void sun8i_codec_remove(struct platform_device *pdev)
 }
 
 static const struct sun8i_codec_quirks sun8i_a33_quirks = {
+	.bus_clock	= true,
 	.legacy_widgets	= true,
 	.lrck_inversion	= true,
 };
 
 static const struct sun8i_codec_quirks sun50i_a64_quirks = {
+	.bus_clock	= true,
 };
 
 static const struct of_device_id sun8i_codec_of_match[] = {
-- 
2.44.0


