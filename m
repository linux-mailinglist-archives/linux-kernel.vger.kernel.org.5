Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363677CFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbjHOQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbjHOQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:11:01 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA713E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:10:59 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FERlpL005801;
        Tue, 15 Aug 2023 11:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=1
        Vg2/PytKi0obfnuFLVhcntMrovleIVdk6MBr1KBy+o=; b=L5YfNOWX+E1biR2jB
        aPS3VdiZutpepw+G7izTOySIWdQMzccSOjuEl0GV5Ou+8/Rjyg/5UxC6Eiy5ocUD
        tyBeGteUzovK6mRvAnNkqdYl6LMkTLg1ggP6V1VMdqyzJ7rkOgx+e/qvFCIvm9th
        gEu9f7457Wz7etCxv4EzVHN312e6volfeLDSQ5A8NzgdXZoKetx/CGWhsV0WRqlc
        B+NnePz8XlghwfHt0TcLa8vfTNaD6P1IRBTfUuufrHIIk3O/anI8d1ZXMReH0ZPE
        Aprz3zgBifPybQJVXSDM0yZhSxtmtX4A8UN9ffzdezwqgxxQLR0aRwiZaHZtswZr
        1yp9g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhk6qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 11:10:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 17:10:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 15 Aug 2023 17:10:45 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.48])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A36E4475;
        Tue, 15 Aug 2023 16:10:45 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda: cs35l41: Support systems with missing _DSD properties
Date:   Tue, 15 Aug 2023 17:10:33 +0100
Message-ID: <20230815161033.3519-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6mve0ARCnch5TkNPx2ZSTc9R5pU3YvFZ
X-Proofpoint-ORIG-GUID: 6mve0ARCnch5TkNPx2ZSTc9R5pU3YvFZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems using CS35L41 with HDA were released without some
required _DSD properties in ACPI. To support these special cases,
add an api to configure the correct properties for systems with
this issue.

This initial commit moves the no _DSD support for Lenovo
Legion Laptops (CLSA0100, CLSA0101) into a new framework which
can be extended to support additional laptops in the future.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/Makefile               |  2 +-
 sound/pci/hda/cs35l41_hda.c          | 65 ++++++-------------------
 sound/pci/hda/cs35l41_hda.h          |  1 +
 sound/pci/hda/cs35l41_hda_property.c | 73 ++++++++++++++++++++++++++++
 sound/pci/hda/cs35l41_hda_property.h | 18 +++++++
 5 files changed, 108 insertions(+), 51 deletions(-)
 create mode 100644 sound/pci/hda/cs35l41_hda_property.c
 create mode 100644 sound/pci/hda/cs35l41_hda_property.h

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index c6e6509e7b8e..5506255be895 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -28,7 +28,7 @@ snd-hda-codec-via-objs :=	patch_via.o
 snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 
 # side codecs
-snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o
+snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o cs35l41_hda_property.o
 snd-hda-scodec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-objs :=	cs35l41_hda_spi.o
 snd-hda-scodec-cs35l56-objs :=		cs35l56_hda.o
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 825e551be9bb..f9b77353c266 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -19,6 +19,7 @@
 #include "hda_component.h"
 #include "cs35l41_hda.h"
 #include "hda_cs_dsp_ctl.h"
+#include "cs35l41_hda_property.h"
 
 #define CS35L41_FIRMWARE_ROOT "cirrus/"
 #define CS35L41_PART "cs35l41"
@@ -1315,8 +1316,7 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, &hw_cfg->spk_pos);
 }
 
-static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
-				  int num_amps, int fixed_gpio_id)
+int cs35l41_get_speaker_id(struct device *dev, int amp_index, int num_amps, int fixed_gpio_id)
 {
 	struct gpio_desc *speaker_id_desc;
 	int speaker_id = -ENODEV;
@@ -1370,49 +1370,6 @@ static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
 	return speaker_id;
 }
 
-/*
- * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
- * And devices created by serial-multi-instantiate don't have their device struct
- * pointing to the correct fwnode, so acpi_dev must be used here.
- * And devm functions expect that the device requesting the resource has the correct
- * fwnode.
- */
-static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
-			       const char *hid)
-{
-	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
-
-	/* check I2C address to assign the index */
-	cs35l41->index = id == 0x40 ? 0 : 1;
-	cs35l41->channel_index = 0;
-	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
-	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
-	hw_cfg->spk_pos = cs35l41->index;
-	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
-	hw_cfg->gpio2.valid = true;
-	hw_cfg->valid = true;
-
-	if (strncmp(hid, "CLSA0100", 8) == 0) {
-		hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
-	} else if (strncmp(hid, "CLSA0101", 8) == 0) {
-		hw_cfg->bst_type = CS35L41_EXT_BOOST;
-		hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
-		hw_cfg->gpio1.valid = true;
-	} else {
-		/*
-		 * Note: CLSA010(0/1) are special cases which use a slightly different design.
-		 * All other HIDs e.g. CSC3551 require valid ACPI _DSD properties to be supported.
-		 */
-		dev_err(cs35l41->dev, "Error: ACPI _DSD Properties are missing for HID %s.\n", hid);
-		hw_cfg->valid = false;
-		hw_cfg->gpio1.valid = false;
-		hw_cfg->gpio2.valid = false;
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, int id)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
@@ -1438,12 +1395,17 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 		sub = NULL;
 	cs35l41->acpi_subsystem_id = sub;
 
+	ret = cs35l41_add_dsd_properties(cs35l41, physdev, id, hid);
+	if (!ret) {
+		dev_info(cs35l41->dev, "Using extra _DSD properties, bypassing _DSD in ACPI\n");
+		goto put_physdev;
+	}
+
 	property = "cirrus,dev-index";
 	ret = device_property_count_u32(physdev, property);
-	if (ret <= 0) {
-		ret = cs35l41_no_acpi_dsd(cs35l41, physdev, id, hid);
-		goto err_put_physdev;
-	}
+	if (ret <= 0)
+		goto err;
+
 	if (ret > ARRAY_SIZE(values)) {
 		ret = -EINVAL;
 		goto err;
@@ -1533,7 +1495,10 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 err:
 	dev_err(cs35l41->dev, "Failed property %s: %d\n", property, ret);
-err_put_physdev:
+	hw_cfg->valid = false;
+	hw_cfg->gpio1.valid = false;
+	hw_cfg->gpio2.valid = false;
+put_physdev:
 	put_device(physdev);
 
 	return ret;
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index bdb35f3be68a..b93bf762976e 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -83,5 +83,6 @@ extern const struct dev_pm_ops cs35l41_hda_pm_ops;
 int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int irq,
 		      struct regmap *regmap);
 void cs35l41_hda_remove(struct device *dev);
+int cs35l41_get_speaker_id(struct device *dev, int amp_index, int num_amps, int fixed_gpio_id);
 
 #endif /*__CS35L41_HDA_H__*/
diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
new file mode 100644
index 000000000000..673f23257a09
--- /dev/null
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// CS35L41 ALSA HDA Property driver
+//
+// Copyright 2023 Cirrus Logic, Inc.
+//
+// Author: Stefan Binding <sbinding@opensource.cirrus.com>
+
+#include <linux/gpio/consumer.h>
+#include <linux/string.h>
+#include "cs35l41_hda_property.h"
+
+/*
+ * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
+ * And devices created by serial-multi-instantiate don't have their device struct
+ * pointing to the correct fwnode, so acpi_dev must be used here.
+ * And devm functions expect that the device requesting the resource has the correct
+ * fwnode.
+ */
+static int lenovo_legion_no_acpi(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+				 const char *hid)
+{
+	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
+
+	/* check I2C address to assign the index */
+	cs35l41->index = id == 0x40 ? 0 : 1;
+	cs35l41->channel_index = 0;
+	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
+	hw_cfg->spk_pos = cs35l41->index;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
+	hw_cfg->gpio2.valid = true;
+	hw_cfg->valid = true;
+
+	if (strcmp(hid, "CLSA0100") == 0) {
+		hw_cfg->bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
+	} else if (strcmp(hid, "CLSA0101") == 0) {
+		hw_cfg->bst_type = CS35L41_EXT_BOOST;
+		hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
+		hw_cfg->gpio1.valid = true;
+	}
+
+	return 0;
+}
+
+struct cs35l41_prop_model {
+	const char *hid;
+	const char *ssid;
+	int (*add_prop)(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			const char *hid);
+};
+
+const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
+	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
+	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{}
+};
+
+int cs35l41_add_dsd_properties(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			       const char *hid)
+{
+	const struct cs35l41_prop_model *model;
+
+	for (model = cs35l41_prop_model_table; model->hid > 0; model++) {
+		if (!strcmp(model->hid, hid) &&
+		    (!model->ssid ||
+		     (cs35l41->acpi_subsystem_id &&
+		      !strcmp(model->ssid, cs35l41->acpi_subsystem_id))))
+			return model->add_prop(cs35l41, physdev, id, hid);
+	}
+
+	return -ENOENT;
+}
diff --git a/sound/pci/hda/cs35l41_hda_property.h b/sound/pci/hda/cs35l41_hda_property.h
new file mode 100644
index 000000000000..fd834042e2fd
--- /dev/null
+++ b/sound/pci/hda/cs35l41_hda_property.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * CS35L41 ALSA HDA Property driver
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ *
+ * Author: Stefan Binding <sbinding@opensource.cirrus.com>
+ */
+
+#ifndef CS35L41_HDA_PROP_H
+#define CS35L41_HDA_PROP_H
+
+#include <linux/device.h>
+#include "cs35l41_hda.h"
+
+int cs35l41_add_dsd_properties(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			       const char *hid);
+#endif /* CS35L41_HDA_PROP_H */
-- 
2.34.1

