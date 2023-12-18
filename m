Return-Path: <linux-kernel+bounces-3900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BA8174E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B391F24858
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19449883;
	Mon, 18 Dec 2023 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kHaTOre3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845233A1BB;
	Mon, 18 Dec 2023 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI5gNV3015248;
	Mon, 18 Dec 2023 09:12:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=1kC0rX+c/t8AY4Pbr4Mm2/U+Yl8ryan8GhBn+X6zX5U=; b=
	kHaTOre3uKHyTlfMmuYS7MIzeSWpUkuupzcCYXX4O72/RHzZDmpNIDZLNzOLm/zF
	s8vI55XY09txjTELlBL6LyEM6DYPYHLmHgV1BvHw6jTA7RwWOSVSnW4JUwnNwRNf
	qf08+ce6DfWMKLhvp/R+SWKGeREzxB22SYv7OJpcuKq29rtZAHrfZxS2jinQ1G/o
	FqZoORgzftqQ/LL1vshCi79B3uKi2PW5Ba/6Iyqnomkjft2aEYTZKf9+jC5rruLA
	2tgYnLC+8wil763+9RuxL/2AERAkBeuKxmNN1pD3hipL7JddmycZtFZNWCrklxmJ
	aGKk+Ez7NTN4mzOXKQSyMg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a622ub0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 09:12:49 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 15:12:47 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Mon, 18 Dec 2023 15:12:47 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 286FA15A5;
	Mon, 18 Dec 2023 15:12:47 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/7] ALSA: hda: cs35l41: Add config table to support many laptops without _DSD
Date: Mon, 18 Dec 2023 15:12:15 +0000
Message-ID: <20231218151221.388745-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
References: <20231218151221.388745-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: LHAPymQRpU2CoOmdM4rFrKtSgdlp5snc
X-Proofpoint-ORIG-GUID: LHAPymQRpU2CoOmdM4rFrKtSgdlp5snc
X-Proofpoint-Spam-Reason: safe

This make use of the CS35L41 HDA Property framework, which supports
laptops which do not have the _DSD properties in their ACPI.

Add configuration table to be able to use a generic function which allows
laptops to be supported just by adding an entry into the table.

Use configuration table function for existing system 103C89C6.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c          |   2 +
 sound/pci/hda/cs35l41_hda.h          |   5 +-
 sound/pci/hda/cs35l41_hda_property.c | 304 +++++++++++++++++++++++----
 3 files changed, 269 insertions(+), 42 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index cbd7d8badf91..92ca2b3b6c92 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1826,6 +1826,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
+	gpiod_put(cs35l41->cs_gpio);
 	acpi_dev_put(cs35l41->dacpi);
 	kfree(cs35l41->acpi_subsystem_id);
 
@@ -1853,6 +1854,7 @@ void cs35l41_hda_remove(struct device *dev)
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
 	gpiod_put(cs35l41->reset_gpio);
+	gpiod_put(cs35l41->cs_gpio);
 	kfree(cs35l41->acpi_subsystem_id);
 }
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index ce3f2bb6ffd0..3d925d677213 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -35,8 +35,8 @@ struct cs35l41_amp_efi_data {
 } __packed;
 
 enum cs35l41_hda_spk_pos {
-	CS35l41_LEFT,
-	CS35l41_RIGHT,
+	CS35L41_LEFT,
+	CS35L41_RIGHT,
 };
 
 enum cs35l41_hda_gpio_function {
@@ -50,6 +50,7 @@ struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
+	struct gpio_desc *cs_gpio;
 	struct cs35l41_hw_cfg hw_cfg;
 	struct hda_codec *codec;
 
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c83328971728..f90423ded85d 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -6,9 +6,271 @@
 //
 // Author: Stefan Binding <sbinding@opensource.cirrus.com>
 
+#include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/string.h>
 #include "cs35l41_hda_property.h"
+#include <linux/spi/spi.h>
+
+#define MAX_AMPS 4
+
+struct cs35l41_config {
+	const char *ssid;
+	enum {
+		SPI,
+		I2C
+	} bus;
+	int num_amps;
+	enum {
+		INTERNAL,
+		EXTERNAL
+	} boost_type;
+	u8 channel[MAX_AMPS];
+	int reset_gpio_index; /* -1 if no reset gpio */
+	int spkid_gpio_index; /* -1 if no spkid gpio */
+	int cs_gpio_index; /* -1 if no cs gpio, or cs-gpios already exists, max num amps == 2 */
+	int boost_ind_nanohenry; /* Required if boost_type == Internal */
+	int boost_peak_milliamp; /* Required if boost_type == Internal */
+	int boost_cap_microfarad; /* Required if boost_type == Internal */
+};
+
+static const struct cs35l41_config cs35l41_config_table[] = {
+/*
+ * Device 103C89C6 does have _DSD, however it is setup to use the wrong boost type.
+ * We can override the _DSD to correct the boost type here.
+ * Since this laptop has valid ACPI, we do not need to handle cs-gpios, since that already exists
+ * in the ACPI. The Reset GPIO is also valid, so we can use the Reset defined in _DSD.
+ */
+	{ "103C89C6", SPI, 2, INTERNAL, { CS35L41_RIGHT, CS35L41_LEFT, 0, 0 }, -1, -1, -1, 1000, 4500, 24 },
+	{}
+};
+
+static int cs35l41_add_gpios(struct cs35l41_hda *cs35l41, struct device *physdev, int reset_gpio,
+			     int spkid_gpio, int cs_gpio_index, int num_amps)
+{
+	struct acpi_gpio_mapping *gpio_mapping;
+	struct acpi_gpio_params *reset_gpio_params;
+	struct acpi_gpio_params *spkid_gpio_params;
+	struct acpi_gpio_params *cs_gpio_params;
+	unsigned int num_entries = 0;
+	unsigned int reset_index, spkid_index, csgpio_index;
+	int i;
+
+	/*
+	 * GPIO Mapping only needs to be done once, since it would be available for subsequent amps
+	 */
+	if (cs35l41->dacpi->driver_gpios)
+		return 0;
+
+	if (reset_gpio >= 0) {
+		reset_index = num_entries;
+		num_entries++;
+	}
+
+	if (spkid_gpio >= 0) {
+		spkid_index = num_entries;
+		num_entries++;
+	}
+
+	if ((cs_gpio_index >= 0)  && (num_amps == 2)) {
+		csgpio_index = num_entries;
+		num_entries++;
+	}
+
+	if (!num_entries)
+		return 0;
+
+	/* must include termination entry */
+	num_entries++;
+
+	gpio_mapping = devm_kcalloc(physdev, num_entries, sizeof(struct acpi_gpio_mapping),
+				    GFP_KERNEL);
+
+	if (!gpio_mapping)
+		goto err;
+
+	if (reset_gpio >= 0) {
+		gpio_mapping[reset_index].name = "reset-gpios";
+		reset_gpio_params = devm_kcalloc(physdev, num_amps, sizeof(struct acpi_gpio_params),
+						 GFP_KERNEL);
+		if (!reset_gpio_params)
+			goto err;
+
+		for (i = 0; i < num_amps; i++)
+			reset_gpio_params[i].crs_entry_index = reset_gpio;
+
+		gpio_mapping[reset_index].data = reset_gpio_params;
+		gpio_mapping[reset_index].size = num_amps;
+	}
+
+	if (spkid_gpio >= 0) {
+		gpio_mapping[spkid_index].name = "spk-id-gpios";
+		spkid_gpio_params = devm_kcalloc(physdev, num_amps, sizeof(struct acpi_gpio_params),
+						 GFP_KERNEL);
+		if (!spkid_gpio_params)
+			goto err;
+
+		for (i = 0; i < num_amps; i++)
+			spkid_gpio_params[i].crs_entry_index = spkid_gpio;
+
+		gpio_mapping[spkid_index].data = spkid_gpio_params;
+		gpio_mapping[spkid_index].size = num_amps;
+	}
+
+	if ((cs_gpio_index >= 0) && (num_amps == 2)) {
+		gpio_mapping[csgpio_index].name = "cs-gpios";
+		/* only one GPIO CS is supported without using _DSD, obtained using index 0 */
+		cs_gpio_params = devm_kzalloc(physdev, sizeof(struct acpi_gpio_params), GFP_KERNEL);
+		if (!cs_gpio_params)
+			goto err;
+
+		cs_gpio_params->crs_entry_index = cs_gpio_index;
+
+		gpio_mapping[csgpio_index].data = cs_gpio_params;
+		gpio_mapping[csgpio_index].size = 1;
+	}
+
+	return devm_acpi_dev_add_driver_gpios(physdev, gpio_mapping);
+err:
+	devm_kfree(physdev, gpio_mapping);
+	devm_kfree(physdev, reset_gpio_params);
+	devm_kfree(physdev, spkid_gpio_params);
+	devm_kfree(physdev, cs_gpio_params);
+	return -ENOMEM;
+}
+
+static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			      const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+	const struct cs35l41_config *cfg;
+	struct gpio_desc *cs_gpiod;
+	struct spi_device *spi;
+	bool dsd_found;
+	int ret;
+
+	for (cfg = cs35l41_config_table; cfg->ssid; cfg++) {
+		if (!strcasecmp(cfg->ssid, cs35l41->acpi_subsystem_id))
+			break;
+	}
+
+	if (!cfg->ssid)
+		return -ENOENT;
+
+	if (!cs35l41->dacpi || cs35l41->dacpi != ACPI_COMPANION(physdev)) {
+		dev_err(cs35l41->dev, "ACPI Device does not match, cannot override _DSD.\n");
+		return -ENODEV;
+	}
+
+	dev_info(cs35l41->dev, "Adding DSD properties for %s\n", cs35l41->acpi_subsystem_id);
+
+	dsd_found = acpi_dev_has_props(cs35l41->dacpi);
+
+	if (!dsd_found) {
+		ret = cs35l41_add_gpios(cs35l41, physdev, cfg->reset_gpio_index,
+						 cfg->spkid_gpio_index, cfg->cs_gpio_index,
+						 cfg->num_amps);
+		if (ret) {
+			dev_err(cs35l41->dev, "Error adding GPIO mapping: %d\n", ret);
+			return ret;
+		}
+	} else if (cfg->reset_gpio_index >= 0 || cfg->spkid_gpio_index >= 0) {
+		dev_warn(cs35l41->dev, "Cannot add Reset/Speaker ID/SPI CS GPIO Mapping, "
+			 "_DSD already exists.\n");
+	}
+
+	if (cfg->bus == SPI) {
+		cs35l41->index = id;
+		/*
+		 * Manually set the Chip Select for the second amp <cs_gpio_index> in the node.
+		 * This is only supported for systems with 2 amps, since we cannot expand the
+		 * default number of chip selects without using cs-gpios
+		 * The CS GPIO must be set high prior to communicating with the first amp (which
+		 * uses a native chip select), to ensure the second amp does not clash with the
+		 * first.
+		 */
+		if (cfg->cs_gpio_index >= 0) {
+			spi = to_spi_device(cs35l41->dev);
+
+			if (cfg->num_amps != 2) {
+				dev_warn(cs35l41->dev,
+					 "Cannot update SPI CS, Number of Amps (%d) != 2\n",
+					 cfg->num_amps);
+			} else if (dsd_found) {
+				dev_warn(cs35l41->dev,
+					"Cannot update SPI CS, _DSD already exists.\n");
+			} else {
+				/*
+				 * This is obtained using driver_gpios, since only one GPIO for CS
+				 * exists, this can be obtained using index 0.
+				 */
+				cs_gpiod = gpiod_get_index(physdev, "cs", 0, GPIOD_OUT_LOW);
+				if (IS_ERR(cs_gpiod)) {
+					dev_err(cs35l41->dev,
+						"Unable to get Chip Select GPIO descriptor\n");
+					return PTR_ERR(cs_gpiod);
+				}
+				if (id == 1) {
+					spi_set_csgpiod(spi, 0, cs_gpiod);
+					cs35l41->cs_gpio = cs_gpiod;
+				} else {
+					gpiod_set_value_cansleep(cs_gpiod, true);
+					gpiod_put(cs_gpiod);
+				}
+				spi_setup(spi);
+			}
+		}
+	} else {
+		if (cfg->num_amps > 2)
+			/*
+			 * i2c addresses for 3/4 amps are used in order: 0x40, 0x41, 0x42, 0x43,
+			 * subtracting 0x40 would give zero-based index
+			 */
+			cs35l41->index = id - 0x40;
+		else
+			/* i2c addr 0x40 for first amp (always), 0x41/0x42 for 2nd amp */
+			cs35l41->index = id == 0x40 ? 0 : 1;
+	}
+
+	if (cfg->num_amps == 3)
+		/* 3 amps means a center channel, so no duplicate channels */
+		cs35l41->channel_index = 0;
+	else
+		/*
+		 * if 4 amps, there are duplicate channels, so they need different indexes
+		 * if 2 amps, no duplicate channels, channel_index would be 0
+		 */
+		cs35l41->channel_index = cs35l41->index / 2;
+
+	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
+						     cs35l41->index, GPIOD_OUT_LOW,
+						     "cs35l41-reset");
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, cs35l41->index, cfg->num_amps, -1);
+
+	hw_cfg->spk_pos = cfg->channel[cs35l41->index];
+
+	if (cfg->boost_type == INTERNAL) {
+		hw_cfg->bst_type = CS35L41_INT_BOOST;
+		hw_cfg->bst_ind = cfg->boost_ind_nanohenry;
+		hw_cfg->bst_ipk = cfg->boost_peak_milliamp;
+		hw_cfg->bst_cap = cfg->boost_cap_microfarad;
+		hw_cfg->gpio1.func = CS35L41_NOT_USED;
+		hw_cfg->gpio1.valid = true;
+	} else {
+		hw_cfg->bst_type = CS35L41_EXT_BOOST;
+		hw_cfg->bst_ind = -1;
+		hw_cfg->bst_ipk = -1;
+		hw_cfg->bst_cap = -1;
+		hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
+		hw_cfg->gpio1.valid = true;
+	}
+
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->valid = true;
+
+	return 0;
+}
 
 /*
  * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
@@ -43,44 +305,6 @@ static int lenovo_legion_no_acpi(struct cs35l41_hda *cs35l41, struct device *phy
 	return 0;
 }
 
-/*
- * Device 103C89C6 does have _DSD, however it is setup to use the wrong boost type.
- * We can override the _DSD to correct the boost type here.
- * Since this laptop has valid ACPI, we do not need to handle cs-gpios, since that already exists
- * in the ACPI.
- */
-static int hp_vision_acpi_fix(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
-			      const char *hid)
-{
-	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
-
-	dev_info(cs35l41->dev, "Adding DSD properties for %s\n", cs35l41->acpi_subsystem_id);
-
-	cs35l41->index = id;
-	cs35l41->channel_index = 0;
-
-	/*
-	 * This system has _DSD, it just contains an error, so we can still get the reset using
-	 * the "reset" label.
-	 */
-	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
-						     cs35l41->index, GPIOD_OUT_LOW,
-						     "cs35l41-reset");
-	cs35l41->speaker_id = -ENOENT;
-	hw_cfg->spk_pos = cs35l41->index ? 0 : 1; // right:left
-	hw_cfg->gpio1.func = CS35L41_NOT_USED;
-	hw_cfg->gpio1.valid = true;
-	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
-	hw_cfg->gpio2.valid = true;
-	hw_cfg->bst_type = CS35L41_INT_BOOST;
-	hw_cfg->bst_ind = 1000;
-	hw_cfg->bst_ipk = 4500;
-	hw_cfg->bst_cap = 24;
-	hw_cfg->valid = true;
-
-	return 0;
-}
-
 struct cs35l41_prop_model {
 	const char *hid;
 	const char *ssid;
@@ -91,7 +315,7 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
-	{ "CSC3551", "103C89C6", hp_vision_acpi_fix },
+	{ "CSC3551", "103C89C6", generic_dsd_config },
 	{}
 };
 
@@ -104,7 +328,7 @@ int cs35l41_add_dsd_properties(struct cs35l41_hda *cs35l41, struct device *physd
 		if (!strcmp(model->hid, hid) &&
 		    (!model->ssid ||
 		     (cs35l41->acpi_subsystem_id &&
-		      !strcmp(model->ssid, cs35l41->acpi_subsystem_id))))
+		      !strcasecmp(model->ssid, cs35l41->acpi_subsystem_id))))
 			return model->add_prop(cs35l41, physdev, id, hid);
 	}
 
-- 
2.34.1


