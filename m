Return-Path: <linux-kernel+bounces-78310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B923D8611AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADDB1C21A48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7028003E;
	Fri, 23 Feb 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ojy6kkfy"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B47FBA5;
	Fri, 23 Feb 2024 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691975; cv=none; b=rIbs0dQApxXW9KgnaRfNIx3u+DvWImeI2gg+/iNC8QUBgo2qmP0etaYnnllVMtMtMqV/ycQYcxpqeZyfkEfg9yaltyvJ+vW1y9QeqF4m1a8il3yCkPEfh0b4eogW/kshN6hzZzcNW4JMp7WumrHMPh2ebP/Ajq0hXq/68Rv9CWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691975; c=relaxed/simple;
	bh=LRIALPCxG2VdqdoL0THs5MVFy9mOUgDSWW+Lt9epGVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZPPIDxkRn5WgK5l36Z31ZEOhgoqjOsnhLD8LsN+ORancxWLZhNs/v5ybJ3V5m530vcA/OolqZ9co2rHjeWq5k/XudJXnrIrFb89bLsHIrjiH+LmVtQbPbTrYxCR1PQNKL7Y/Iq794b2zvPdpmG5LPkwHAxXMY4nV0bL5uPf/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ojy6kkfy; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NCcdEs051553;
	Fri, 23 Feb 2024 06:38:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708691919;
	bh=h3f3N/0Bpl+P3WMuaHjKwmwTB7bB50yTD/YsRY95/lQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ojy6kkfy8pmA+SQPt4KLXty6fiEYDeiWWMbavVEZuhnqVwHfNUfFSpLu7im7dWTSG
	 EQiDV9eR59trxeIncBBPgenEAXfWIsfNcZ/2boxTaLac/WE6pn3tTkufhq1cDOQsTK
	 JgHidYutLi/UTjm1QZwfnFkh5rlcAymc+k+ROYuU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NCcd4u025978
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 06:38:39 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 06:38:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 06:38:39 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NCcDjp107069;
	Fri, 23 Feb 2024 06:38:32 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <s-hari@ti.com>, <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v6 3/4] ASoc: PCM6240: Add compile item for PCM6240 Family driver
Date: Fri, 23 Feb 2024 20:38:06 +0800
Message-ID: <20240223123809.503-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240223123809.503-1-shenghao-ding@ti.com>
References: <20240223123809.503-1-shenghao-ding@ti.com>
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
Change in v6:
 - All these chips have only a portion of the codec's functionality, such
   as ADC or DAC, and so on, but their audio performance is far superior
   to the codec's, and cost is lower than codec, and much easier to
   program than codec.
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


