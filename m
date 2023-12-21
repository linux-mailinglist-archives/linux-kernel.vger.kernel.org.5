Return-Path: <linux-kernel+bounces-8471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC781B80B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32F31C236CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FD83F6A;
	Thu, 21 Dec 2023 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZrhJ8CPg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB081E47;
	Thu, 21 Dec 2023 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL7oFUw019653;
	Thu, 21 Dec 2023 07:25:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=s5l7r6NnIKHqknPESEEfdFZRITwtUtccaDSes80L/yk=; b=
	ZrhJ8CPg0sTt3nJbAZz7Q9n8oX+cTQcoxdE+luq1zd+dj58mvXXFsSK+eHIhg/Ro
	dZUmODGs0x0wC8z8X8sl+lPblX2TZh+iJEGpPMpDPO+WKle00Ca7mnXjheW8V2Du
	eS8F/vknvIoszm9mAFKVdta0wV82jK7oiS3Hxm5FH2/ILg+ReatHk4JQEEHcq0Jc
	uTd9z1RMcPrJTFGmKrg9Vz4DSeJNhSRBvNCRjcM2ZhoyNoWSGAdOx6LGxZ12KFb+
	jvg1f6PcR45zFHSGS8mc4n7neTIjv16LmTjrQE+2xZlwJHiSg8R6PFZ/2OliUhAF
	liYnbYPk2y4ljfvNRZx+EA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a627crn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 07:25:28 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 13:25:25 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Thu, 21 Dec 2023 13:25:25 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4CEC646B;
	Thu, 21 Dec 2023 13:25:25 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/3] ALSA: hda: cs35l41: Prevent firmware load if SPI speed too low
Date: Thu, 21 Dec 2023 13:25:17 +0000
Message-ID: <20231221132518.3213-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221132518.3213-1-sbinding@opensource.cirrus.com>
References: <20231221132518.3213-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: brFqPjSTP81-9clM2doUjTZObUJF_HNJ
X-Proofpoint-ORIG-GUID: brFqPjSTP81-9clM2doUjTZObUJF_HNJ
X-Proofpoint-Spam-Reason: safe

Some laptops without _DSD have the SPI speed set very low in the BIOS.
Since the SPI controller uses this speed as its max speed, the SPI
transactions are very slow. Firmware download writes to many registers,
and if the SPI speed is too slow, it can take a long time to download.
For this reason, disable firmware loading if the maximum SPI speed is
too low. Without Firmware, audio playback will work, but the volume
will be low to ensure safe operation of the CS35L41.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c          | 25 ++++++++--
 sound/pci/hda/cs35l41_hda.h          | 12 ++++-
 sound/pci/hda/cs35l41_hda_i2c.c      |  2 +-
 sound/pci/hda/cs35l41_hda_property.c | 74 +++++++++++++---------------
 sound/pci/hda/cs35l41_hda_spi.c      |  2 +-
 5 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 92ca2b3b6c92..d3fa6e136744 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -12,6 +12,7 @@
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
 #include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
@@ -996,6 +997,11 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 	__be32 halo_sts;
 	int ret;
 
+	if (cs35l41->bypass_fw) {
+		dev_warn(cs35l41->dev, "Bypassing Firmware.\n");
+		return 0;
+	}
+
 	ret = cs35l41_init_dsp(cs35l41);
 	if (ret) {
 		dev_warn(cs35l41->dev, "Cannot Initialize Firmware. Error: %d\n", ret);
@@ -1588,6 +1594,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	u32 values[HDA_MAX_COMPONENTS];
 	struct acpi_device *adev;
 	struct device *physdev;
+	struct spi_device *spi;
 	const char *sub;
 	char *property;
 	size_t nval;
@@ -1610,7 +1617,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	ret = cs35l41_add_dsd_properties(cs35l41, physdev, id, hid);
 	if (!ret) {
 		dev_info(cs35l41->dev, "Using extra _DSD properties, bypassing _DSD in ACPI\n");
-		goto put_physdev;
+		goto out;
 	}
 
 	property = "cirrus,dev-index";
@@ -1701,8 +1708,20 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 		hw_cfg->bst_type = CS35L41_EXT_BOOST;
 
 	hw_cfg->valid = true;
+out:
 	put_device(physdev);
 
+	cs35l41->bypass_fw = false;
+	if (cs35l41->control_bus == SPI) {
+		spi = to_spi_device(cs35l41->dev);
+		if (spi->max_speed_hz < CS35L41_MAX_ACCEPTABLE_SPI_SPEED_HZ) {
+			dev_warn(cs35l41->dev,
+				 "SPI speed is too slow to support firmware download: %d Hz.\n",
+				 spi->max_speed_hz);
+			cs35l41->bypass_fw = true;
+		}
+	}
+
 	return 0;
 
 err:
@@ -1711,14 +1730,13 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
 	acpi_dev_put(cs35l41->dacpi);
-put_physdev:
 	put_device(physdev);
 
 	return ret;
 }
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
-		      struct regmap *regmap)
+		      struct regmap *regmap, enum control_bus control_bus)
 {
 	unsigned int regid, reg_revid;
 	struct cs35l41_hda *cs35l41;
@@ -1737,6 +1755,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	cs35l41->dev = dev;
 	cs35l41->irq = irq;
 	cs35l41->regmap = regmap;
+	cs35l41->control_bus = control_bus;
 	dev_set_drvdata(dev, cs35l41);
 
 	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 3d925d677213..43d55292b327 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -20,6 +20,8 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 
+#define CS35L41_MAX_ACCEPTABLE_SPI_SPEED_HZ	1000000
+
 struct cs35l41_amp_cal_data {
 	u32 calTarget[2];
 	u32 calTime[2];
@@ -46,6 +48,11 @@ enum cs35l41_hda_gpio_function {
 	CS35l41_SYNC,
 };
 
+enum control_bus {
+	I2C,
+	SPI
+};
+
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
@@ -74,6 +81,9 @@ struct cs35l41_hda {
 	struct cs_dsp cs_dsp;
 	struct acpi_device *dacpi;
 	bool mute_override;
+	enum control_bus control_bus;
+	bool bypass_fw;
+
 };
 
 enum halo_state {
@@ -85,7 +95,7 @@ enum halo_state {
 extern const struct dev_pm_ops cs35l41_hda_pm_ops;
 
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
-		      struct regmap *regmap);
+		      struct regmap *regmap, enum control_bus control_bus);
 void cs35l41_hda_remove(struct device *dev);
 int cs35l41_get_speaker_id(struct device *dev, int amp_index, int num_amps, int fixed_gpio_id);
 
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index b44536fbba17..603e9bff3a71 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -30,7 +30,7 @@ static int cs35l41_hda_i2c_probe(struct i2c_client *clt)
 		return -ENODEV;
 
 	return cs35l41_hda_probe(&clt->dev, device_name, clt->addr, clt->irq,
-				 devm_regmap_init_i2c(clt, &cs35l41_regmap_i2c));
+				 devm_regmap_init_i2c(clt, &cs35l41_regmap_i2c), I2C);
 }
 
 static void cs35l41_hda_i2c_remove(struct i2c_client *clt)
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 5eab2de0d4bb..be2b01b596c2 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -16,10 +16,6 @@
 
 struct cs35l41_config {
 	const char *ssid;
-	enum {
-		SPI,
-		I2C
-	} bus;
 	int num_amps;
 	enum {
 		INTERNAL,
@@ -35,46 +31,46 @@ struct cs35l41_config {
 };
 
 static const struct cs35l41_config cs35l41_config_table[] = {
-	{ "10280B27", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10280B28", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10280BEB", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
-	{ "10280C4D", I2C, 4, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10280B27", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10280B28", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10280BEB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
+	{ "10280C4D", 4, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT }, 0, 1, -1, 1000, 4500, 24 },
 /*
  * Device 103C89C6 does have _DSD, however it is setup to use the wrong boost type.
  * We can override the _DSD to correct the boost type here.
  * Since this laptop has valid ACPI, we do not need to handle cs-gpios, since that already exists
  * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
  */
-	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
-	{ "104312AF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431433", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431463", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431473", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
-	{ "10431483", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
-	{ "10431493", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "104314D3", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "104314E3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431503", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431533", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431573", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431663", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
-	{ "104316D3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "104316F3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "104317F3", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431863", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "104318D3", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
-	{ "10431C9F", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CAF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CCF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CDF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431CEF", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
-	{ "10431D1F", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431DA2", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "10431E02", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
-	{ "10431EE2", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
-	{ "10431F12", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
-	{ "10431F1F", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
-	{ "10431F62", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "103C89C6", 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
+	{ "104312AF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431433", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431463", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431473", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431483", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "10431493", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104314D3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104314E3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431503", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431863", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "104318D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "10431C9F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CAF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CCF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CDF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431CEF", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10431D1F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431DA2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10431E02", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10431EE2", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
+	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
+	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{}
 };
 
@@ -212,7 +208,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 			 "_DSD already exists.\n");
 	}
 
-	if (cfg->bus == SPI) {
+	if (cs35l41->control_bus == SPI) {
 		cs35l41->index = id;
 
 #if IS_ENABLED(CONFIG_SPI)
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index eb287aa5f782..b76c0dfd5fef 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -26,7 +26,7 @@ static int cs35l41_hda_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	return cs35l41_hda_probe(&spi->dev, device_name, spi_get_chipselect(spi, 0), spi->irq,
-				 devm_regmap_init_spi(spi, &cs35l41_regmap_spi));
+				 devm_regmap_init_spi(spi, &cs35l41_regmap_spi), SPI);
 }
 
 static void cs35l41_hda_spi_remove(struct spi_device *spi)
-- 
2.34.1


