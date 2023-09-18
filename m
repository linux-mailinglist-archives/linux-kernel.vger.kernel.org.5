Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A07A4661
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjIRJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbjIRJvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:51:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F9118
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:51:43 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38I6K0DP017792;
        Mon, 18 Sep 2023 04:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=bzNx+cwyBwsgMjXpMUzH/4rtbDMwJFO+M36q6Ifg9OY=; b=
        J9LOPfP3k+XGMsFjvt/ERUknWb52kH8jAkbLIkljPP137IKaeVb55eh0NA2+VnVz
        yqhF9QTFkAGRAp1c7tUiIBv2Zp8DGFf2kQQa1Rluc1xadyjXDbYy94gUl65KUDHh
        3D3l24UtcKHBs9MouGcYlq+NevEdlG/hjXJoxRlWaRh1J/SH6pNLnuYcDRrBG3BS
        0tzP6GoNt2n9RG2UNcbRt9fQV32ZqnVJJzCaSxJZapht/3PtvcigfIZ5R33LeFZ8
        OOoER1kHtfT9Ok2aoQIB3qcYRZnSKFubELGDkqXcoiQ80u/rR7PUdjlBBaT8wdps
        F9ig29beTe4jnDuEl4uFiA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t59ry256c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 04:51:36 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 18 Sep
 2023 10:51:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Mon, 18 Sep 2023 10:51:34 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.90.238.137])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3DA7615B4;
        Mon, 18 Sep 2023 09:51:33 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ALSA: hda: cs35l56: Add support for speaker id
Date:   Mon, 18 Sep 2023 10:51:28 +0100
Message-ID: <20230918095129.440-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918095129.440-1-rf@opensource.cirrus.com>
References: <20230918095129.440-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TirkbRROVxKO-34GF5sWXKytJpSnqNZ9
X-Proofpoint-ORIG-GUID: TirkbRROVxKO-34GF5sWXKytJpSnqNZ9
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of the "spk-id-gpios" _DSD property. If present, the
value indicated by the GPIOs is appended to the subsystem-id
part of the firmware name to load the appropriate tunings for that
speaker.

Some manufacturers use multiple sources of speakers, which need
different tunings for best performance. On these models the type
of speaker fitted is indicated by the values of one or more GPIOs.
The number formed by the GPIOs identifies the tuning required.

The speaker ID is only used in combination with a _SUB identifier
because the value is only meaningful if the exact model is known.

The code to get the speaker ID value has been implemented as a
new library so that the cs35l41_hda driver can be switched in
future to share common code. This library can be extended for
other common functionality shared by Cirrus Logic amp drivers.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                   |  1 +
 sound/pci/hda/Kconfig         |  5 +++
 sound/pci/hda/Makefile        |  2 +
 sound/pci/hda/cirrus_scodec.c | 73 +++++++++++++++++++++++++++++++++++
 sound/pci/hda/cirrus_scodec.h | 13 +++++++
 sound/pci/hda/cs35l56_hda.c   | 14 ++++++-
 6 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 sound/pci/hda/cirrus_scodec.c
 create mode 100644 sound/pci/hda/cirrus_scodec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..23e73d19f347 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4912,6 +4912,7 @@ F:	drivers/spi/spi-cs42l43*
 F:	include/dt-bindings/sound/cs*
 F:	include/linux/mfd/cs42l43*
 F:	include/sound/cs*
+F:	sound/pci/hda/cirrus*
 F:	sound/pci/hda/cs*
 F:	sound/pci/hda/hda_cs_dsp_ctl.*
 F:	sound/soc/codecs/cs*
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 0d7502d6e060..2980bfef0a4c 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -91,6 +91,9 @@ config SND_HDA_PATCH_LOADER
 	  start up.  The "patch" file can be specified via patch module
 	  option, such as patch=hda-init.
 
+config SND_HDA_CIRRUS_SCODEC
+	tristate
+
 config SND_HDA_SCODEC_CS35L41
 	tristate
 	select SND_HDA_GENERIC
@@ -144,6 +147,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
+	select SND_HDA_CIRRUS_SCODEC
 	select SND_HDA_CS_DSP_CONTROLS
 	help
 	  Say Y or M here to include CS35L56 amplifier support with
@@ -158,6 +162,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
+	select SND_HDA_CIRRUS_SCODEC
 	select SND_HDA_CS_DSP_CONTROLS
 	help
 	  Say Y or M here to include CS35L56 amplifier support with
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index f00fc9ed6096..aa445af0cf9a 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -28,6 +28,7 @@ snd-hda-codec-via-objs :=	patch_via.o
 snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 
 # side codecs
+snd-hda-cirrus-scodec-objs :=		cirrus_scodec.o
 snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o cs35l41_hda_property.o
 snd-hda-scodec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-objs :=	cs35l41_hda_spi.o
@@ -56,6 +57,7 @@ obj-$(CONFIG_SND_HDA_CODEC_VIA) += snd-hda-codec-via.o
 obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 
 # side codecs
+obj-$(CONFIG_SND_HDA_CIRRUS_SCODEC) += snd-hda-cirrus-scodec.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41) += snd-hda-scodec-cs35l41.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_I2C) += snd-hda-scodec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_SPI) += snd-hda-scodec-cs35l41-spi.o
diff --git a/sound/pci/hda/cirrus_scodec.c b/sound/pci/hda/cirrus_scodec.c
new file mode 100644
index 000000000000..8de3bc7448fa
--- /dev/null
+++ b/sound/pci/hda/cirrus_scodec.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Common code for Cirrus side-codecs.
+//
+// Copyright (C) 2021, 2023 Cirrus Logic, Inc. and
+//               Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/dev_printk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+
+#include "cirrus_scodec.h"
+
+int cirrus_scodec_get_speaker_id(struct device *dev, int amp_index,
+				 int num_amps, int fixed_gpio_id)
+{
+	struct gpio_desc *speaker_id_desc;
+	int speaker_id = -ENOENT;
+
+	if (fixed_gpio_id >= 0) {
+		dev_dbg(dev, "Found Fixed Speaker ID GPIO (index = %d)\n", fixed_gpio_id);
+		speaker_id_desc = gpiod_get_index(dev, NULL, fixed_gpio_id, GPIOD_IN);
+		if (IS_ERR(speaker_id_desc)) {
+			speaker_id = PTR_ERR(speaker_id_desc);
+			return speaker_id;
+		}
+		speaker_id = gpiod_get_value_cansleep(speaker_id_desc);
+		gpiod_put(speaker_id_desc);
+	} else {
+		int base_index;
+		int gpios_per_amp;
+		int count;
+		int tmp;
+		int i;
+
+		count = gpiod_count(dev, "spk-id");
+		if (count > 0) {
+			speaker_id = 0;
+			gpios_per_amp = count / num_amps;
+			base_index = gpios_per_amp * amp_index;
+
+			if (count % num_amps)
+				return -EINVAL;
+
+			dev_dbg(dev, "Found %d Speaker ID GPIOs per Amp\n", gpios_per_amp);
+
+			for (i = 0; i < gpios_per_amp; i++) {
+				speaker_id_desc = gpiod_get_index(dev, "spk-id", i + base_index,
+								  GPIOD_IN);
+				if (IS_ERR(speaker_id_desc)) {
+					speaker_id = PTR_ERR(speaker_id_desc);
+					break;
+				}
+				tmp = gpiod_get_value_cansleep(speaker_id_desc);
+				gpiod_put(speaker_id_desc);
+				if (tmp < 0) {
+					speaker_id = tmp;
+					break;
+				}
+				speaker_id |= tmp << i;
+			}
+		}
+	}
+
+	dev_dbg(dev, "Speaker ID = %d\n", speaker_id);
+
+	return speaker_id;
+}
+EXPORT_SYMBOL_NS_GPL(cirrus_scodec_get_speaker_id, SND_HDA_CIRRUS_SCODEC);
+
+MODULE_DESCRIPTION("HDA Cirrus side-codec library");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/cirrus_scodec.h b/sound/pci/hda/cirrus_scodec.h
new file mode 100644
index 000000000000..ba2041d8ef24
--- /dev/null
+++ b/sound/pci/hda/cirrus_scodec.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2023 Cirrus Logic, Inc. and
+ *                    Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef CIRRUS_SCODEC_H
+#define CIRRUS_SCODEC_H
+
+int cirrus_scodec_get_speaker_id(struct device *dev, int amp_index,
+				 int num_amps, int fixed_gpio_id);
+
+#endif /* CIRRUS_SCODEC_H */
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 87ffe8fbff99..44f5ca0e73e3 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -16,6 +16,7 @@
 #include <sound/core.h>
 #include <sound/hda_codec.h>
 #include <sound/tlv.h>
+#include "cirrus_scodec.h"
 #include "cs35l56_hda.h"
 #include "hda_component.h"
 #include "hda_cs_dsp_ctl.h"
@@ -869,7 +870,17 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int id)
 			 "Read ACPI _SUB failed(%ld): fallback to generic firmware\n",
 			 PTR_ERR(sub));
 	} else {
-		cs35l56->system_name = sub;
+		ret = cirrus_scodec_get_speaker_id(cs35l56->base.dev, cs35l56->index, nval, -1);
+		if (ret == -ENOENT) {
+			cs35l56->system_name = sub;
+		} else if (ret >= 0) {
+			cs35l56->system_name = kasprintf(GFP_KERNEL, "%s-spkid%d", sub, ret);
+			kfree(sub);
+			if (!cs35l56->system_name)
+				return -ENOMEM;
+		} else {
+			return ret;
+		}
 	}
 
 	cs35l56->base.reset_gpio = devm_gpiod_get_index_optional(cs35l56->base.dev,
@@ -1025,6 +1036,7 @@ const struct dev_pm_ops cs35l56_hda_pm_ops = {
 EXPORT_SYMBOL_NS_GPL(cs35l56_hda_pm_ops, SND_HDA_SCODEC_CS35L56);
 
 MODULE_DESCRIPTION("CS35L56 HDA Driver");
+MODULE_IMPORT_NS(SND_HDA_CIRRUS_SCODEC);
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
 MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
-- 
2.30.2

