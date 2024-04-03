Return-Path: <linux-kernel+bounces-129313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC16E89686D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237201C21B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC717319F;
	Wed,  3 Apr 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL4FfJyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECA5C61C;
	Wed,  3 Apr 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132001; cv=none; b=I/S5wx1DU0QNv0acmmBaht+efjhutOaBBvC/MqWiiGx3TfFW1zcpK8eVrcwTmcRu15WC/Kt2PpgyAo//bmG60DsjsWXVB/ClNSK8qa/q6M/tkez2vCf0LkSmnMos+0yQjabfZj/OTA1pxashDo87n8g/drg5t34TqgpOaqhPntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132001; c=relaxed/simple;
	bh=cHRmsqunH9hP/qtXbd35N4JkMuQoGtu0x3hJ4tAgdrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDOtYeAq4SKBvWonitmtqvd7rnFfKFv4jHqVO+hi24byVjhsAAxeyvZkvg9w/0F4tIThyxZlTQbDBO2CX5D2w6Fpvmr1gLTzaKQtTiBjPhZmG8WXPYTMM9yim15xRxF7gJaEOmIAh0PRDKf+Zx0XyDPCDrOVnBMWa9tZ0HSdet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL4FfJyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95395C433C7;
	Wed,  3 Apr 2024 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712132000;
	bh=cHRmsqunH9hP/qtXbd35N4JkMuQoGtu0x3hJ4tAgdrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL4FfJyzLl9gsq+QwjOIrerxmGhTo6GDqw+UdiO+FN1TNPbQ1HU4hUHSq50YrgXyO
	 hXHcEM4a1AfR/UMk2OlDEdOtkZ7hLM16HAr75p42zC3E/fZmTMFFvDziVxgFQIRCfO
	 0qPx53oM278y1D0ZnnomrHkf/8qt46zlW41rrmspumuSLR/CwOXBD8PAekA0tR4SV5
	 n6RyEQgcFzrrp4y18VqL/jxAFRC0t2QR05D1FAIqEsfiAca752UIyw7Aktq+IPx3TC
	 n1oRUic3ZgN8V1orOq8yfxAiWatGMFmTrfPdsjirFu3CT0SmC51Inan5tHzb3m4Wdy
	 OZORH7MZL3gMw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yinchuan Guo <guoych37@mail2.sysu.edu.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 32/34] ASoC: remove incorrect of_match_ptr/ACPI_PTR annotations
Date: Wed,  3 Apr 2024 10:06:50 +0200
Message-Id: <20240403080702.3509288-33-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When building with CONFIG_OF and/or CONFIG_ACPI disabled but W=1 extra
warnings enabled, a lot of driver cause a warning about an unused
ID table:

sound/soc/atmel/sam9x5_wm8731.c:187:34: error: unused variable 'sam9x5_wm8731_of_match' [-Werror,-Wunused-const-variable]
sound/soc/codecs/rt5514-spi.c:496:34: error: unused variable 'rt5514_of_match' [-Werror,-Wunused-const-variable]
sound/soc/samsung/aries_wm8994.c:524:34: error: unused variable 'samsung_wm8994_of_match' [-Werror,-Wunused-const-variable]

The fix is always to just remove the of_match_ptr() and ACPI_PTR() wrappers
that remove the reference, rather than adding another #ifdef just for build
testing for a configuration that doesn't matter in practice.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/amd/acp3x-rt5682-max9836.c | 2 +-
 sound/soc/atmel/sam9x5_wm8731.c      | 2 +-
 sound/soc/codecs/rt5514-spi.c        | 2 +-
 sound/soc/qcom/lpass-sc7280.c        | 2 +-
 sound/soc/samsung/aries_wm8994.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
index d6cdb6d9fdd6..ffc105759994 100644
--- a/sound/soc/amd/acp3x-rt5682-max9836.c
+++ b/sound/soc/amd/acp3x-rt5682-max9836.c
@@ -543,7 +543,7 @@ MODULE_DEVICE_TABLE(acpi, acp3x_audio_acpi_match);
 static struct platform_driver acp3x_audio = {
 	.driver = {
 		.name = "acp3x-alc5682-max98357",
-		.acpi_match_table = ACPI_PTR(acp3x_audio_acpi_match),
+		.acpi_match_table = acp3x_audio_acpi_match,
 		.pm = &snd_soc_pm_ops,
 	},
 	.probe = acp3x_probe,
diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index d1c1f370a9cd..95c8c37478a3 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -193,7 +193,7 @@ MODULE_DEVICE_TABLE(of, sam9x5_wm8731_of_match);
 static struct platform_driver sam9x5_wm8731_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(sam9x5_wm8731_of_match),
+		.of_match_table = sam9x5_wm8731_of_match,
 	},
 	.probe = sam9x5_wm8731_driver_probe,
 	.remove_new = sam9x5_wm8731_driver_remove,
diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index f475c8cfadae..da397db8d7d5 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -503,7 +503,7 @@ static struct spi_driver rt5514_spi_driver = {
 	.driver = {
 		.name = "rt5514",
 		.pm = &rt5514_pm_ops,
-		.of_match_table = of_match_ptr(rt5514_of_match),
+		.of_match_table = rt5514_of_match,
 	},
 	.probe = rt5514_spi_probe,
 };
diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
index 47c622327a8d..c91620128fd4 100644
--- a/sound/soc/qcom/lpass-sc7280.c
+++ b/sound/soc/qcom/lpass-sc7280.c
@@ -441,7 +441,7 @@ MODULE_DEVICE_TABLE(of, sc7280_lpass_cpu_device_id);
 static struct platform_driver sc7280_lpass_cpu_platform_driver = {
 	.driver = {
 		.name = "sc7280-lpass-cpu",
-		.of_match_table = of_match_ptr(sc7280_lpass_cpu_device_id),
+		.of_match_table = sc7280_lpass_cpu_device_id,
 		.pm = &sc7280_lpass_pm_ops,
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index a548ac33dd94..9f7318c4ee33 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -689,7 +689,7 @@ static int aries_audio_probe(struct platform_device *pdev)
 static struct platform_driver aries_audio_driver = {
 	.driver		= {
 		.name	= "aries-audio-wm8994",
-		.of_match_table = of_match_ptr(samsung_wm8994_of_match),
+		.of_match_table = samsung_wm8994_of_match,
 		.pm	= &snd_soc_pm_ops,
 	},
 	.probe		= aries_audio_probe,
-- 
2.39.2


