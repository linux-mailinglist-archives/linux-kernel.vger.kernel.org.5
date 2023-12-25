Return-Path: <linux-kernel+bounces-10898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9296981DE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C967D28193D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145D4A2A;
	Mon, 25 Dec 2023 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="StFhgmI0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96541ED7;
	Mon, 25 Dec 2023 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5duGO002257;
	Sun, 24 Dec 2023 23:39:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703482796;
	bh=FBw65Qsz6BWf4jsep//MhSInWE6dXx302FQfndtntxc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=StFhgmI0VAgWBMaHAj2ElhVVp6YC0fnNoGdnLcafLlaAcJoA+nvizCwCK7hkAetRa
	 9Tooj+PeEN8dBvjtlhkN3R2rwF/vvc7JfR5Yi+WniCnCX7RW3iIGI80QOvyNA4tVue
	 +4GnSWRlxDdTLDNnOvVHg7q9MIWQ6teXJMcVKK0g=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BP5duVr001920
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Dec 2023 23:39:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Dec 2023 23:39:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Dec 2023 23:39:56 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.240])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5defd118972;
	Sun, 24 Dec 2023 23:39:49 -0600
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
Subject: [PATCH v3 2/5] ASoC: tas2562: move tas2563 from tas2562 driver to tas2781 driver
Date: Mon, 25 Dec 2023 13:39:28 +0800
Message-ID: <20231225053932.1138-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231225053932.1138-1-shenghao-ding@ti.com>
References: <20231225053932.1138-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562 driver to tas2781 driver, because tas2563 only
work in bypass-DSP mode with tas2562 driver. In oder to enable DSP mode
for tas2563, it has been moved to tas2781 driver. As to the hardware part,
such as register setting and DSP firmware, all these are stored in the
binary firmware. What tas2781 drivder dooes is to parse the firmware and
download them to the tas2781 or tas2563, then power on tas2781 or tas2563.
So, tas2781 driver can be resued as tas2563 driver。 Only attention will
be paid to downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v3:
 - Move tas2563 from tas2562 driver to tas2781 driver
 - Add more comments on why move tas2563 to tas2781 driver
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


