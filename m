Return-Path: <linux-kernel+bounces-35179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07249838D28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEFB24F60
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018BF5D8E3;
	Tue, 23 Jan 2024 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h2xoa/xu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03F5D73C;
	Tue, 23 Jan 2024 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008548; cv=none; b=dmDG1ePPNFDaO07VKipb9dM20lJx42gBfpbKZHDBvahoQ1g1f2DoZSUDzP5El9bxpAGxAm7DRACLpC5dJEMtNNkezKO5u7eMhWK/W9irPDP1ddsIDuBWClc8tN8tppvkVBQznS8inop4HGbPrS9kAu8Ojdf1hT85LGpslpi2D0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008548; c=relaxed/simple;
	bh=+C+E75lqxharvQbpo3PR/kRPaJd4SUH4GJkUH+xGIvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rI0mAEHmGff0gVdpaIIo8BH+ESH7qauvbCgs3WUd590xk9926gq6vqjFJfoKFtGcB3GFiuHEQOYJWiMh0BVcf/Llz9QNGeIeqHlJkyUmBy3luHDy5euyUVmJMNVHbeSBgQQOwvw+Q+eJIshOhM9mfOtGII4dVpQBxEOq2xy3POI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h2xoa/xu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NBEfMY103904;
	Tue, 23 Jan 2024 05:14:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706008481;
	bh=4gJRUPiOEkN9y57oNCHDaWWI7fyUc/nGZE+6XBvaBP8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h2xoa/xu8k3SpZFg8INgl+8P60QQbUFRmIihZAFEZRJdYkTmIPxVN5wUnUBKo4S78
	 sW4TSXio9CNZcsMXGngwiFnWgj/lcn7JHCv30m3L1qLdyaomy5V5xaptb0HX0gFFV8
	 GS6jyjmxzzsuU5XFUvNl6ZDKPYqD7xmno7qMetf8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NBEfIv098189
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 05:14:41 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 05:14:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 05:14:40 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.124])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NBEHxS083823;
	Tue, 23 Jan 2024 05:14:34 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <j-mcpherson@ti.com>,
        <navada@ti.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 3/4] ASoc: pcm6240: Add compile item for pcm6240 codec driver
Date: Tue, 23 Jan 2024 19:14:09 +0800
Message-ID: <20240123111411.850-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240123111411.850-1-shenghao-ding@ti.com>
References: <20240123111411.850-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PCM6240 driver implements a flexible and configurable setting for register
and filter coefficients, to one, two or even multiple PCM6240 Family Audio
chips.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v1:
 - Add compile item for pcm6240 codec driver
---
 sound/soc/codecs/Kconfig  | 10 ++++++++++
 sound/soc/codecs/Makefile |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 59f9742e9ff4..bab0ed032b5d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -178,6 +178,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_PCM5102A
 	imply SND_SOC_PCM512x_I2C
 	imply SND_SOC_PCM512x_SPI
+	imply SND_SOC_PCM6240
 	imply SND_SOC_PEB2466
 	imply SND_SOC_RK3328
 	imply SND_SOC_RK817
@@ -1389,6 +1390,15 @@ config SND_SOC_PCM512x_SPI
 	select SND_SOC_PCM512x
 	select REGMAP_SPI
 
+config SND_SOC_PCM6240
+	tristate "Texas Instruments PCM6240 Family Audio chips based on I2C"
+	depends on I2C
+	help
+	  Enable support for Texas Instruments PCM6240 Family Audio chips.
+	  Note the PCM6240 driver implements a flexible and configurable
+	  setting for register and filter coefficients, to one, two or
+	  even multiple PCM6240 Family Audio chips.
+
 config SND_SOC_PEB2466
 	tristate "Infineon PEB2466 quad PCM codec"
 	depends on SPI
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f53baa2b9565..c2ae573b62dd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -201,6 +201,7 @@ snd-soc-pcm5102a-objs := pcm5102a.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
+snd-soc-pcm6240-objs := pcm6240.o
 snd-soc-peb2466-objs := peb2466.o
 snd-soc-rk3328-objs := rk3328_codec.o
 snd-soc-rk817-objs := rk817_codec.o
@@ -586,6 +587,7 @@ obj-$(CONFIG_SND_SOC_PCM5102A)	+= snd-soc-pcm5102a.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
+obj-$(CONFIG_SND_SOC_PCM6240)	+= snd-soc-pcm6240.o
 obj-$(CONFIG_SND_SOC_PEB2466)	+= snd-soc-peb2466.o
 obj-$(CONFIG_SND_SOC_RK3328)	+= snd-soc-rk3328.o
 obj-$(CONFIG_SND_SOC_RK817)	+= snd-soc-rk817.o
-- 
2.34.1


