Return-Path: <linux-kernel+bounces-10897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7E81DE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB2A1F21476
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48C4A1C;
	Mon, 25 Dec 2023 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AfvWDeCU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658310EE;
	Mon, 25 Dec 2023 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5eDf9002428;
	Sun, 24 Dec 2023 23:40:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703482813;
	bh=IzvHSce1KXGXvd7Susyupy1VQZBvpXf3R+NT2Xh9qEE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AfvWDeCU0yT1R3yAPjxur7nFtQar9HClWrDAX4x+Btf0BQbh1zn/HdzfQV7wAVmhK
	 tha65BOYLYNZ23eTCxhfay5CYC7hZ/yfbfokXmBr/DQp5FxeQAnGQljpRBLRbv/BSd
	 zzyIgK4D1iJ393Hxr8ithtP+XyIVkqyAJBMcSiMQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BP5eDJs002184
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Dec 2023 23:40:13 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Dec 2023 23:40:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Dec 2023 23:40:12 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.240])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5deff118972;
	Sun, 24 Dec 2023 23:40:05 -0600
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
Subject: [PATCH v3 4/5] ASoC: tas2781: Add tas2563 into driver
Date: Mon, 25 Dec 2023 13:39:30 +0800
Message-ID: <20231225053932.1138-4-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231225053932.1138-1-shenghao-ding@ti.com>
References: <20231225053932.1138-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562 driver to tas2781 driver, because tas2563 only
work in bypass-DSP mode with tas2562 driver. In oder to enable DSP mode
for tas2563, it has been moved to tas2781 driver. As to the hardware part,
such as register setting and DSP firmware, all these are stored in the
binary firmware. What tas2781 drivder dooes is to parse the firmware and
download them to the tas2781 or tas2563, then power on tas2781 or tas2563.
So, tas2781 driver can be resued as tas2563 driver. Only attention will be
paid to downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v3:
 - Add tas2563 to tas2781 driver
 - Add more comments on why move tas2563 to tas2781 driver
 - Provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
---
 sound/soc/codecs/tas2781-i2c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 55cd5e3c23a5..c6afc87f2c69 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -5,9 +5,9 @@
 // Copyright (C) 2022 - 2023 Texas Instruments Incorporated
 // https://www.ti.com
 //
-// The TAS2781 driver implements a flexible and configurable
+// The TAS2781/TAS2563 driver implements a flexible and configurable
 // algo coefficient setting for one, two, or even multiple
-// TAS2781 chips.
+// TAS2781/TAS2563 chips.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 // Author: Kevin Lu <kevin-lu@ti.com>
@@ -33,6 +33,7 @@
 
 static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2781", TAS2781 },
+	{ "tas2563", TAS2563 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, tasdevice_id);
@@ -40,6 +41,7 @@ MODULE_DEVICE_TABLE(i2c, tasdevice_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2781" },
+	{ .compatible = "ti,tas2563" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tasdevice_of_match);
-- 
2.34.1


