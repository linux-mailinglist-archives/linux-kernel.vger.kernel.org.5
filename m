Return-Path: <linux-kernel+bounces-16815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A69682444D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A971C20A48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CC72421B;
	Thu,  4 Jan 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uPHA1uhd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D21241E7;
	Thu,  4 Jan 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404EvfD1047684;
	Thu, 4 Jan 2024 08:57:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704380261;
	bh=DsfckQaYzNb7/dN+G/t2Cwkcac/YIBW5lT5+D6M+jvQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uPHA1uhduQRxxBdh+htc7mzoGcUQLY9alZoM1o6N0vwDuQYcWTX83fRHbHwwIp2H6
	 c8rQ4aafowNYTy/AMgb+ovnBJOHhIpCNmb9xZK9FrV7njpMjUHsigQXx2bSIDjulr+
	 YxOBRa+egPTsOQIxr8af2Zz5CfcFYYP/KS/AzpnM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404Evfh5034232
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 08:57:41 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 08:57:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 08:57:41 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.227])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404EvPfN105959;
	Thu, 4 Jan 2024 08:57:35 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <soyer@irl.hu>, <tiwai@suse.de>,
        <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v5 2/4] ASoC: tas2562: move tas2563 from tas2562 driver to tas2781 driver
Date: Thu, 4 Jan 2024 22:57:17 +0800
Message-ID: <20240104145721.1398-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240104145721.1398-1-shenghao-ding@ti.com>
References: <20240104145721.1398-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562 driver to tas2781 driver to unbind tas2563 from
tas2562 driver code and bind it to tas2781 driver code, because tas2563
only work in bypass-DSP mode with tas2562 driver. In order to enable DSP
mode for tas2563, it has been moved to tas2781 driver. As to the hardware
part, such as register setting and DSP firmware, all these are stored in
the binary firmware. What tas2781 drivder does is to parse the firmware
and download it to the chip, then power on the chip. So, tas2781 driver
can be resued as tas2563 driver. Only attention will be paid to
downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v5:
 - Move tas2563 from tas2562 driver to tas2781 driver.
 - Add more comments on why move tas2563 to tas2781 driver.
 - Provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
---
 sound/soc/codecs/tas2562.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 962c2cdfa017..54561ae598b8 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -59,7 +59,6 @@ struct tas2562_data {
 
 enum tas256x_model {
 	TAS2562,
-	TAS2563,
 	TAS2564,
 	TAS2110,
 };
@@ -721,7 +720,6 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 
 static const struct i2c_device_id tas2562_id[] = {
 	{ "tas2562", TAS2562 },
-	{ "tas2563", TAS2563 },
 	{ "tas2564", TAS2564 },
 	{ "tas2110", TAS2110 },
 	{ }
@@ -770,7 +768,6 @@ static int tas2562_probe(struct i2c_client *client)
 #ifdef CONFIG_OF
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
-	{ .compatible = "ti,tas2563", },
 	{ .compatible = "ti,tas2564", },
 	{ .compatible = "ti,tas2110", },
 	{ },
-- 
2.34.1


