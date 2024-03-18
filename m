Return-Path: <linux-kernel+bounces-106611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30E87F0E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA91C21E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BDF57866;
	Mon, 18 Mar 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbroGQ2X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7C557862;
	Mon, 18 Mar 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792493; cv=none; b=slMvWEXQliN922uB1HURvxTM5nnO3gedg/IQFgoQHv4GpBnbv3DmC4Etk6L+o19VN5zXlzOPbWB922QlWU0Sb6guMCP/02AI2W95XrKrdFl/iOwNupgaE2NjDYcOH/aBZTr2aola4W6JxYm4fGT9Bxa6d8y6u5ZrH0ORlopM8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792493; c=relaxed/simple;
	bh=sMw7esYZrxxW1kATPTh6O4ptDRoE3Q+nZihwtYXZxlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hc+yS9MIbrznDvidSW7VnXeUfA20kGG6aPO7BpJ02+WiSjkO18ecPzdtWuo68zH+Sk4BDhJhGJTdpXYu9Jto01vyHy2hHe/1oVSIGI5gNb403B54/7ohVd2OQwmU61ROKjxOk5Dp4pKJpFd3aPxuBy/obPnJRZFw9sshKjkxgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbroGQ2X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710792492; x=1742328492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sMw7esYZrxxW1kATPTh6O4ptDRoE3Q+nZihwtYXZxlg=;
  b=SbroGQ2XNShvl5bSrtml3YvjL/YYRaPmJ7THkGmk9iK0EvHOAzBzQM22
   y+W4Sg/OUR6lcM8Gp2tPclo+vNZEJk9JJ16t9zxWW2AfyYy5p0PBdUcO2
   Wp3Wbsg8uaPEXStUT5sQSYACRQjDWZgrb0Lc6swGHtZpHfgbipKZWkxOj
   NHXeqourCBm7df+t5le2dw3FkGYRbY07kFqBJ+Td6DjMmbwJoy85Wo1PK
   VmkwmkQtoZU9aELdPt7rip/ipe/7UFdFX4UEFTeaqOeMV2I5ZuWceFLM7
   1GhbNu3L48zAauA5gObHlHVV04DmhDnt63Y0ngNCixywEFmRUFmKOATsj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16354711"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16354711"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 13:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="937060635"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="937060635"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2024 13:08:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 68B82241; Mon, 18 Mar 2024 22:08:06 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ASoC: fsl: imx-es8328: Switch to using gpiod API
Date: Mon, 18 Mar 2024 22:07:56 +0200
Message-ID: <20240318200804.181516-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the driver to gpiod API, and removes yet another use of
of_get_named_gpio().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error
 sound/soc/fsl/imx-es8328.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 6f0d031c1d5f..d67b8a149bff 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -3,7 +3,7 @@
 // Copyright 2012 Freescale Semiconductor, Inc.
 // Copyright 2012 Linaro Ltd.
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -23,7 +23,7 @@ struct imx_es8328_data {
 	struct snd_soc_card card;
 	char codec_dai_name[DAI_NAME_SIZE];
 	char platform_name[DAI_NAME_SIZE];
-	int jack_gpio;
+	struct gpio_desc *jack_gpiod;
 };
 
 static struct snd_soc_jack_gpio headset_jack_gpios[] = {
@@ -54,8 +54,8 @@ static int imx_es8328_dai_init(struct snd_soc_pcm_runtime *rtd)
 					struct imx_es8328_data, card);
 	int ret = 0;
 
-	/* Headphone jack detection */
-	if (gpio_is_valid(data->jack_gpio)) {
+	if (data->jack_gpiod) {
+		/* Headphone jack detection */
 		ret = snd_soc_card_jack_new_pins(rtd->card, "Headphone",
 						 SND_JACK_HEADSET | SND_JACK_BTN_0,
 						 &headset_jack,
@@ -64,7 +64,7 @@ static int imx_es8328_dai_init(struct snd_soc_pcm_runtime *rtd)
 		if (ret)
 			return ret;
 
-		headset_jack_gpios[0].gpio = data->jack_gpio;
+		headset_jack_gpios[0].desc = data->jack_gpiod;
 		ret = snd_soc_jack_add_gpios(&headset_jack,
 					     ARRAY_SIZE(headset_jack_gpios),
 					     headset_jack_gpios);
@@ -174,7 +174,11 @@ static int imx_es8328_probe(struct platform_device *pdev)
 
 	data->dev = dev;
 
-	data->jack_gpio = of_get_named_gpio(pdev->dev.of_node, "jack-gpio", 0);
+	data->jack_gpiod = devm_gpiod_get_optional(dev, "jack", GPIOD_IN);
+	if (IS_ERR(data->jack_gpiod)) {
+		ret = PTR_ERR(data->jack_gpiod);
+		goto put_device;
+	}
 
 	/*
 	 * CPU == Platform
-- 
2.43.0.rc1.1.gbec44491f096


