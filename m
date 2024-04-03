Return-Path: <linux-kernel+bounces-128888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9B89617F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DD21F2A8DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAED79460;
	Wed,  3 Apr 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HPfplfJY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC214A9D;
	Wed,  3 Apr 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104413; cv=none; b=WEns22XCvPi1RByDU2Vh58iWDoKts6bOr1NTlAeu6g5XS6ZcsCZWbU6NKYTYybvL3s9lfXeELgdSjO114DoqKqxh/EnmESM0sokBt62LCApVixdGnHZ17VHZhCIsii2WMGBhrQHpuO22VDApCp/sdI4mFZrGHzFWD903FxY9SVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104413; c=relaxed/simple;
	bh=rHWDHL1i/IvJcRqLw+SJNY2wbffLubgOnS2NLVPbBbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2xCHN60M0mZ6M4tvXd+j+mS1mQzSEpsUCsbh2T8s+v/s4JRBruYeykppECQPPXZ0y/q0YuLtQ6jH2qmS3Uck7PsEhyh7omZorjEK00lbrHTTMT9gwpM82hehm5Cn5sxFdhYg6BqWGiAEk08iXuFGsxorXdjtBtFpAeNM/vvzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HPfplfJY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4330WdxB033944;
	Tue, 2 Apr 2024 19:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712104359;
	bh=GVrr+F2p0WJZ3urc9o+Df04rBukw2qRLjEQV2Y/wL88=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HPfplfJYN8YTQ+CokXkMlxwRAdwkPJNtXiyf57p9t6f1dnRWjm+iXSv3bPc2nzX8g
	 Q92OMxjKgmbJgYtPJYy9/NP0OLgavz7L8+CFbc2YhILy+GWwdD2fmf2KOBPmmYRpG6
	 C0sU7APL+vHzEYF0NnaAaqFFI9KLX3xwbvmxPaVg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4330WdSs058870
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 19:32:39 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 19:32:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 19:32:38 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4330W2JC079729;
	Tue, 2 Apr 2024 19:32:30 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v8 3/4] ASoc: PCM6240: Add compile item for PCM6240 Family driver
Date: Wed, 3 Apr 2024 08:31:57 +0800
Message-ID: <20240403003159.389-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240403003159.389-1-shenghao-ding@ti.com>
References: <20240403003159.389-1-shenghao-ding@ti.com>
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
v8:
 - use some reasonable format of changelog.
 - Link to v2: https://lore.kernel.org/all/20240126035855.1785-3-shenghao-ding@ti.com/
---
 sound/soc/codecs/Kconfig  | 10 ++++++++++
 sound/soc/codecs/Makefile |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f78ea2f86fa6..0c35cdfd4a47 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -179,6 +179,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_PCM5102A
 	imply SND_SOC_PCM512x_I2C
 	imply SND_SOC_PCM512x_SPI
+	imply SND_SOC_PCM6240
 	imply SND_SOC_PEB2466
 	imply SND_SOC_RK3328
 	imply SND_SOC_RK817
@@ -1422,6 +1423,15 @@ config SND_SOC_PCM512x_SPI
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
index 7c075539dc47..5553155b843b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -204,6 +204,7 @@ snd-soc-pcm5102a-objs := pcm5102a.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
+snd-soc-pcm6240-objs := pcm6240.o
 snd-soc-peb2466-objs := peb2466.o
 snd-soc-rk3328-objs := rk3328_codec.o
 snd-soc-rk817-objs := rk817_codec.o
@@ -594,6 +595,7 @@ obj-$(CONFIG_SND_SOC_PCM5102A)	+= snd-soc-pcm5102a.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
+obj-$(CONFIG_SND_SOC_PCM6240)	+= snd-soc-pcm6240.o
 obj-$(CONFIG_SND_SOC_PEB2466)	+= snd-soc-peb2466.o
 obj-$(CONFIG_SND_SOC_RK3328)	+= snd-soc-rk3328.o
 obj-$(CONFIG_SND_SOC_RK817)	+= snd-soc-rk817.o
-- 
2.34.1


