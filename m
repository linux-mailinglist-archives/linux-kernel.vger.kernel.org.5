Return-Path: <linux-kernel+bounces-12759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA03881F9B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370752853CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2E10786;
	Thu, 28 Dec 2023 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KVkU812U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82810795;
	Thu, 28 Dec 2023 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BSFUuqv100551;
	Thu, 28 Dec 2023 09:30:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703777456;
	bh=nUT+e6SaWTQhh6iN7sxaO6r8+dJ5mAaZQM0ZgSDR6gM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KVkU812URm/TX4ItBgIguT/E9WTfZlLgOvnLl5ubo/nk5BtafjwvlPhFZZHGpQKwL
	 2AGJQuU1sitT3Be8gGBSnnMDj11TQwYTatpDKbymTB3Q0ee9kFjsJAat24kdrakevn
	 gfPRCOfjufmYca2Ftfy/EBgzsLflESf0t0adxJwM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BSFUuXT030710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 09:30:56 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 09:30:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 09:30:56 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.188])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BSFUSKp116497;
	Thu, 28 Dec 2023 09:30:50 -0600
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
Subject: [PATCH v4 4/4] ASoC: tas2781: Add tas2563 into driver
Date: Thu, 28 Dec 2023 23:30:23 +0800
Message-ID: <20231228153024.1659-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231228153024.1659-1-shenghao-ding@ti.com>
References: <20231228153024.1659-1-shenghao-ding@ti.com>
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
the binary firmware. What tas2781 drivder dooes is to parse the firmware
and download it to the chip, then power on the chip. So, tas2781 driver
can be resued as tas2563 driver. Only attention will be paid to downloading
corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v4:
 - Add tas2563 to tas2781 driver.
 - Add more comments on why move tas2563 to tas2781 driver.
 - Provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
 - In all cases, to make the lists ordered by a chip model, tas2563 is first,
   tas2781 is second.
---
 sound/soc/codecs/tas2781-i2c.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 55cd5e3c23a5..bd5ef4ff96fe 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+// ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
 //
 // Copyright (C) 2022 - 2023 Texas Instruments Incorporated
 // https://www.ti.com
 //
-// The TAS2781 driver implements a flexible and configurable
+// The TAS2563/TAS2781 driver implements a flexible and configurable
 // algo coefficient setting for one, two, or even multiple
-// TAS2781 chips.
+// TAS2563/TAS2781 chips.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 // Author: Kevin Lu <kevin-lu@ti.com>
@@ -32,6 +32,7 @@
 #include <sound/tas2781-tlv.h>
 
 static const struct i2c_device_id tasdevice_id[] = {
+	{ "tas2563", TAS2563 },
 	{ "tas2781", TAS2781 },
 	{}
 };
@@ -39,6 +40,7 @@ MODULE_DEVICE_TABLE(i2c, tasdevice_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id tasdevice_of_match[] = {
+	{ .compatible = "ti,tas2563" },
 	{ .compatible = "ti,tas2781" },
 	{},
 };
-- 
2.34.1


