Return-Path: <linux-kernel+bounces-36856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE083A7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326351F23209
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3921B592;
	Wed, 24 Jan 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="a3C+7H+d"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA020DFA;
	Wed, 24 Jan 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095603; cv=none; b=ElhlpHTIAPDPvxOOUyQwRg3TpgKVJdD+O9hpP/UMtO6yHvARska3S7yUlJBIiXQ6SfjtmNac1C3n4JxMb8L8Sf1YQThikZ/FmOyCqg9rVuJoL0JdrrVbqE6Fm14NBewdjFrE4BoZLViKRbU6tgn7hdt5vHcsv82GDrIvhAfN6cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095603; c=relaxed/simple;
	bh=chH4bZAdi2xBt7RCAKZdF9fQDpkOTNFSFZGu1WAWcg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctSygoWwgJjz4cRs86tB9bP7wCbwN49qVGPVKeGiIx9uwZh/msbGDu7RawFN8uE6o79G6SNgMpfUndZLgDKLmXmpTjdd8tid2KxZOodpTKjV4m8ymfIJPTH8A6bMTorGtAt0ULuisom4hmGt3kFL8CgaD+M35Ie042eWhe+Ugi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=a3C+7H+d; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O5ABQr018377;
	Wed, 24 Jan 2024 05:26:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=oCCHkrJpQ7BpNJhyVqdpJOqQK20KiYbTaV4mSbY6v6Q=; b=
	a3C+7H+dyF2Lku+GyJS9KxB4onyUXAyDQ4o7JuynmwQdi69ZH2OSXL7tRI0sVJhc
	muwrlhSFxvBcYq1Yx+sbaybvefhr1DWZ9sIyV/5o6sUQS6yXhMByV+h0kuc534bC
	ewd+lERviaNc9U/UZlTOs42F4WjlLERo5xx+yT2Qe/kxCWJE0bls9blOj7iBK0BH
	rf0j14g1lbCuWKRaZSzIvKUne8j/7sFnlkoheXTCls9nycfWEAbvgzU7/0zJpMTb
	7etXXm6C+/FhlMRhYs1ICCnGHMy5QsLEs+Sd2EOEGwiOd+7US0jARwg4S5EkZpTD
	o0eywyCIEWIBMucZSh3vtw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhgqah-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 05:26:21 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 11:26:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 11:26:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.251.117])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 92701820248;
	Wed, 24 Jan 2024 11:26:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>, <soyer@irl.hu>, <shenghao-ding@ti.com>
CC: <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ALSA: hda: realtek: Move hda_component implementation to module
Date: Wed, 24 Jan 2024 11:26:07 +0000
Message-ID: <20240124112607.77614-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240124112607.77614-1-rf@opensource.cirrus.com>
References: <20240124112607.77614-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5L82T0Ig56ACxlqv9HlRBX1JFHLZmls8
X-Proofpoint-GUID: 5L82T0Ig56ACxlqv9HlRBX1JFHLZmls8
X-Proofpoint-Spam-Reason: safe

Move the generic parts of the hda_component implementation into a new
hda_component module. This will allow other HDA codecs to add support
for the component binding API without duplicating all the code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Can someone test that this doesn't break the two TAS2781 fixups?
---
 MAINTAINERS                   |   1 +
 sound/pci/hda/Kconfig         |   4 +
 sound/pci/hda/Makefile        |   2 +
 sound/pci/hda/hda_component.c | 169 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_component.h |  59 ++++++++++++
 sound/pci/hda/patch_realtek.c | 146 ++++-------------------------
 6 files changed, 252 insertions(+), 129 deletions(-)
 create mode 100644 sound/pci/hda/hda_component.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..bfc7062cf7b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5014,6 +5014,7 @@ F:	include/linux/mfd/cs42l43*
 F:	include/sound/cs*
 F:	sound/pci/hda/cirrus*
 F:	sound/pci/hda/cs*
+F:	sound/pci/hda/hda_component*
 F:	sound/pci/hda/hda_cs_dsp_ctl.*
 F:	sound/soc/codecs/cs*
 
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 21a90b3c4cc7..20d757e38f94 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -116,6 +116,9 @@ config SND_HDA_CS_DSP_CONTROLS
 	tristate
 	select FW_CS_DSP
 
+config SND_HDA_SCODEC_COMPONENT
+	tristate
+
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
 	depends on I2C
@@ -201,6 +204,7 @@ config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
 	select SND_HDA_GENERIC_LEDS
+	select SND_HDA_SCODEC_COMPONENT
 	help
 	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 793e296c3f64..13e04e1f65de 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -37,6 +37,7 @@ snd-hda-scodec-cs35l56-objs :=		cs35l56_hda.o
 snd-hda-scodec-cs35l56-i2c-objs :=	cs35l56_hda_i2c.o
 snd-hda-scodec-cs35l56-spi-objs :=	cs35l56_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
+snd-hda-scodec-component-objs :=	hda_component.o
 snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
 
 # common driver
@@ -67,6 +68,7 @@ obj-$(CONFIG_SND_HDA_SCODEC_CS35L56) += snd-hda-scodec-cs35l56.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L56_I2C) += snd-hda-scodec-cs35l56-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L56_SPI) += snd-hda-scodec-cs35l56-spi.o
 obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
+obj-$(CONFIG_SND_HDA_SCODEC_COMPONENT) += snd-hda-scodec-component.o
 obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_I2C) += snd-hda-scodec-tas2781-i2c.o
 
 # this must be the last entry after codec drivers;
diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
new file mode 100644
index 000000000000..cd299d7d84ba
--- /dev/null
+++ b/sound/pci/hda/hda_component.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HD audio Component Binding Interface
+ *
+ * Copyright (C) 2021, 2023 Cirrus Logic, Inc. and
+ *			Cirrus Logic International Semiconductor Ltd.
+ */
+
+#include <linux/acpi.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <sound/hda_codec.h>
+#include "hda_component.h"
+#include "hda_local.h"
+
+#ifdef CONFIG_ACPI
+void hda_component_acpi_device_notify(struct hda_component *comps, int num_comps,
+				      acpi_handle handle, u32 event, void *data)
+{
+	int i;
+
+	for (i = 0; i < num_comps; i++) {
+		if (comps[i].dev && comps[i].acpi_notify)
+			comps[i].acpi_notify(acpi_device_handle(comps[i].adev), event,
+					     comps[i].dev);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_acpi_device_notify, SND_HDA_SCODEC_COMPONENT);
+
+int hda_component_manager_bind_acpi_notifications(struct hda_codec *cdc,
+						  struct hda_component *comps, int num_comps,
+						  acpi_notify_handler handler, void *data)
+{
+	bool support_notifications = false;
+	struct acpi_device *adev;
+	int ret;
+	int i;
+
+	adev = comps[0].adev;
+	if (!acpi_device_handle(adev))
+		return 0;
+
+	for (i = 0; i < num_comps; i++)
+		support_notifications = support_notifications ||
+			comps[i].acpi_notifications_supported;
+
+	if (support_notifications) {
+		ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+						  handler, data);
+		if (ret < 0) {
+			codec_warn(cdc, "Failed to install notify handler: %d\n", ret);
+			return 0;
+		}
+
+		codec_dbg(cdc, "Notify handler installed\n");
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_manager_bind_acpi_notifications, SND_HDA_SCODEC_COMPONENT);
+
+void hda_component_manager_unbind_acpi_notifications(struct hda_codec *cdc,
+						     struct hda_component *comps,
+						     acpi_notify_handler handler)
+{
+	struct acpi_device *adev;
+	int ret;
+
+	adev = comps[0].adev;
+	if (!acpi_device_handle(adev))
+		return;
+
+	ret = acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY, handler);
+	if (ret < 0)
+		codec_warn(cdc, "Failed to uninstall notify handler: %d\n", ret);
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_manager_unbind_acpi_notifications, SND_HDA_SCODEC_COMPONENT);
+#endif /* ifdef CONFIG_ACPI */
+
+void hda_component_manager_playback_hook(struct hda_component *comps, int num_comps, int action)
+{
+	int i;
+
+	for (i = 0; i < num_comps; i++) {
+		if (comps[i].dev && comps[i].pre_playback_hook)
+			comps[i].pre_playback_hook(comps[i].dev, action);
+	}
+	for (i = 0; i < num_comps; i++) {
+		if (comps[i].dev && comps[i].playback_hook)
+			comps[i].playback_hook(comps[i].dev, action);
+	}
+	for (i = 0; i < num_comps; i++) {
+		if (comps[i].dev && comps[i].post_playback_hook)
+			comps[i].post_playback_hook(comps[i].dev, action);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_manager_playback_hook, SND_HDA_SCODEC_COMPONENT);
+
+struct hda_scodec_match {
+	const char *bus;
+	const char *hid;
+	const char *match_str;
+	int index;
+};
+
+/* match the device name in a slightly relaxed manner */
+static int hda_comp_match_dev_name(struct device *dev, void *data)
+{
+	struct hda_scodec_match *p = data;
+	const char *d = dev_name(dev);
+	int n = strlen(p->bus);
+	char tmp[32];
+
+	/* check the bus name */
+	if (strncmp(d, p->bus, n))
+		return 0;
+	/* skip the bus number */
+	if (isdigit(d[n]))
+		n++;
+	/* the rest must be exact matching */
+	snprintf(tmp, sizeof(tmp), p->match_str, p->hid, p->index);
+	return !strcmp(d + n, tmp);
+}
+
+int hda_component_manager_init(struct hda_codec *cdc,
+			       struct hda_component *comps, int count,
+			       const char *bus, const char *hid,
+			       const char *match_str,
+			       const struct component_master_ops *ops)
+{
+	struct device *dev = hda_codec_dev(cdc);
+	struct component_match *match = NULL;
+	struct hda_scodec_match *sm;
+	int ret, i;
+
+	for (i = 0; i < count; i++) {
+		sm = devm_kmalloc(dev, sizeof(*sm), GFP_KERNEL);
+		if (!sm)
+			return -ENOMEM;
+
+		sm->bus = bus;
+		sm->hid = hid;
+		sm->match_str = match_str;
+		sm->index = i;
+		comps[i].codec = cdc;
+		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
+	}
+
+	ret = component_master_add_with_match(dev, ops, match);
+	if (ret)
+		codec_err(cdc, "Fail to register component aggregator %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_manager_init, SND_HDA_SCODEC_COMPONENT);
+
+void hda_component_manager_free(struct hda_codec *cdc,
+				const struct component_master_ops *ops)
+{
+	struct device *dev = hda_codec_dev(cdc);
+
+	component_master_del(dev, ops);
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_manager_free, SND_HDA_SCODEC_COMPONENT);
+
+MODULE_DESCRIPTION("HD Audio component binding library");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index bbd6f0ed16c1..deae9dea01b4 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -23,3 +23,62 @@ struct hda_component {
 	void (*playback_hook)(struct device *dev, int action);
 	void (*post_playback_hook)(struct device *dev, int action);
 };
+
+#ifdef CONFIG_ACPI
+void hda_component_acpi_device_notify(struct hda_component *comps, int num_comps,
+				      acpi_handle handle, u32 event, void *data);
+int hda_component_manager_bind_acpi_notifications(struct hda_codec *cdc,
+						  struct hda_component *comps, int num_comps,
+						  acpi_notify_handler handler, void *data);
+void hda_component_manager_unbind_acpi_notifications(struct hda_codec *cdc,
+						     struct hda_component *comps,
+						     acpi_notify_handler handler);
+#else
+static inline void hda_component_acpi_device_notify(struct hda_component *comps,
+						    int num_comps,
+						    acpi_handle handle,
+						    u32 event,
+						    void *data)
+{
+}
+
+static inline int hda_component_manager_bind_acpi_notifications(struct hda_codec *cdc,
+								struct hda_component *comps,
+								int num_comps,
+								acpi_notify_handler handler,
+								void *data)
+
+{
+	return 0;
+}
+
+static inline void hda_component_manager_unbind_acpi_notifications(struct hda_codec *cdc,
+								   struct hda_component *comps,
+								   acpi_notify_handler handler)
+{
+}
+#endif /* ifdef CONFIG_ACPI */
+
+void hda_component_manager_playback_hook(struct hda_component *comps, int num_comps,
+					 int action);
+
+int hda_component_manager_init(struct hda_codec *cdc,
+			       struct hda_component *comps, int count,
+			       const char *bus, const char *hid,
+			       const char *match_str,
+			       const struct component_master_ops *ops);
+
+void hda_component_manager_free(struct hda_codec *cdc,
+				const struct component_master_ops *ops);
+
+static inline int hda_component_manager_bind(struct hda_codec *cdc,
+					     struct hda_component *comps)
+{
+	return component_bind_all(hda_codec_dev(cdc), comps);
+}
+
+static inline void hda_component_manager_unbind(struct hda_codec *cdc,
+					       struct hda_component *comps)
+{
+	component_unbind_all(hda_codec_dev(cdc), comps);
+}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2e2906d2dd1c..62382a1b0e05 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -133,7 +133,6 @@ struct alc_spec {
 	u8 alc_mute_keycode_map[1];
 
 	/* component binding */
-	struct component_match *match;
 	struct hda_component comps[HDA_MAX_COMPONENTS];
 };
 
@@ -6717,91 +6716,30 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
-#ifdef CONFIG_ACPI
 static void comp_acpi_device_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct hda_codec *cdc = data;
 	struct alc_spec *spec = cdc->spec;
-	int i;
 
 	codec_info(cdc, "ACPI Notification %d\n", event);
 
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (spec->comps[i].dev && spec->comps[i].acpi_notify)
-			spec->comps[i].acpi_notify(acpi_device_handle(spec->comps[i].adev), event,
-						   spec->comps[i].dev);
-	}
+	hda_component_acpi_device_notify(spec->comps, ARRAY_SIZE(spec->comps),
+					 handle, event, data);
 }
 
-static int comp_bind_acpi(struct device *dev)
-{
-	struct hda_codec *cdc = dev_to_hda_codec(dev);
-	struct alc_spec *spec = cdc->spec;
-	bool support_notifications = false;
-	struct acpi_device *adev;
-	int ret;
-	int i;
-
-	adev = spec->comps[0].adev;
-	if (!acpi_device_handle(adev))
-		return 0;
-
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++)
-		support_notifications = support_notifications ||
-			spec->comps[i].acpi_notifications_supported;
-
-	if (support_notifications) {
-		ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
-						comp_acpi_device_notify, cdc);
-		if (ret < 0) {
-			codec_warn(cdc, "Failed to install notify handler: %d\n", ret);
-			return 0;
-		}
-
-		codec_dbg(cdc, "Notify handler installed\n");
-	}
-
-	return 0;
-}
-
-static void comp_unbind_acpi(struct device *dev)
-{
-	struct hda_codec *cdc = dev_to_hda_codec(dev);
-	struct alc_spec *spec = cdc->spec;
-	struct acpi_device *adev;
-	int ret;
-
-	adev = spec->comps[0].adev;
-	if (!acpi_device_handle(adev))
-		return;
-
-	ret = acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
-					 comp_acpi_device_notify);
-	if (ret < 0)
-		codec_warn(cdc, "Failed to uninstall notify handler: %d\n", ret);
-}
-#else
-static int comp_bind_acpi(struct device *dev)
-{
-	return 0;
-}
-
-static void comp_unbind_acpi(struct device *dev)
-{
-}
-#endif
-
 static int comp_bind(struct device *dev)
 {
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
 	struct alc_spec *spec = cdc->spec;
 	int ret;
 
-	ret = component_bind_all(dev, spec->comps);
+	ret = hda_component_manager_bind(cdc, spec->comps);
 	if (ret)
 		return ret;
 
-	return comp_bind_acpi(dev);
+	return hda_component_manager_bind_acpi_notifications(cdc,
+							     spec->comps, ARRAY_SIZE(spec->comps),
+							     comp_acpi_device_notify, cdc);
 }
 
 static void comp_unbind(struct device *dev)
@@ -6809,8 +6747,8 @@ static void comp_unbind(struct device *dev)
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
 	struct alc_spec *spec = cdc->spec;
 
-	comp_unbind_acpi(dev);
-	component_unbind_all(dev, spec->comps);
+	hda_component_manager_unbind_acpi_notifications(cdc, spec->comps, comp_acpi_device_notify);
+	hda_component_manager_unbind(cdc, spec->comps);
 }
 
 static const struct component_master_ops comp_master_ops = {
@@ -6822,78 +6760,27 @@ static void comp_generic_playback_hook(struct hda_pcm_stream *hinfo, struct hda_
 				       struct snd_pcm_substream *sub, int action)
 {
 	struct alc_spec *spec = cdc->spec;
-	int i;
 
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (spec->comps[i].dev && spec->comps[i].pre_playback_hook)
-			spec->comps[i].pre_playback_hook(spec->comps[i].dev, action);
-	}
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (spec->comps[i].dev && spec->comps[i].playback_hook)
-			spec->comps[i].playback_hook(spec->comps[i].dev, action);
-	}
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (spec->comps[i].dev && spec->comps[i].post_playback_hook)
-			spec->comps[i].post_playback_hook(spec->comps[i].dev, action);
-	}
-}
-
-struct scodec_dev_name {
-	const char *bus;
-	const char *hid;
-	const char *match_str;
-	int index;
-};
-
-/* match the device name in a slightly relaxed manner */
-static int comp_match_dev_name(struct device *dev, void *data)
-{
-	struct scodec_dev_name *p = data;
-	const char *d = dev_name(dev);
-	int n = strlen(p->bus);
-	char tmp[32];
-
-	/* check the bus name */
-	if (strncmp(d, p->bus, n))
-		return 0;
-	/* skip the bus number */
-	if (isdigit(d[n]))
-		n++;
-	/* the rest must be exact matching */
-	snprintf(tmp, sizeof(tmp), p->match_str, p->hid, p->index);
-	return !strcmp(d + n, tmp);
+	hda_component_manager_playback_hook(spec->comps, ARRAY_SIZE(spec->comps), action);
 }
 
 static void comp_generic_fixup(struct hda_codec *cdc, int action, const char *bus,
 			       const char *hid, const char *match_str, int count)
 {
-	struct device *dev = hda_codec_dev(cdc);
 	struct alc_spec *spec = cdc->spec;
-	struct scodec_dev_name *rec;
-	int ret, i;
+	int ret;
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
-		for (i = 0; i < count; i++) {
-			rec = devm_kmalloc(dev, sizeof(*rec), GFP_KERNEL);
-			if (!rec)
-				return;
-			rec->bus = bus;
-			rec->hid = hid;
-			rec->match_str = match_str;
-			rec->index = i;
-			spec->comps[i].codec = cdc;
-			component_match_add(dev, &spec->match,
-					    comp_match_dev_name, rec);
-		}
-		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
+		ret = hda_component_manager_init(cdc, spec->comps, count, bus, hid,
+						 match_str, &comp_master_ops);
 		if (ret)
-			codec_err(cdc, "Fail to register component aggregator %d\n", ret);
-		else
-			spec->gen.pcm_playback_hook = comp_generic_playback_hook;
+			return;
+
+		spec->gen.pcm_playback_hook = comp_generic_playback_hook;
 		break;
 	case HDA_FIXUP_ACT_FREE:
-		component_master_del(dev, &comp_master_ops);
+		hda_component_manager_free(cdc, &comp_master_ops);
 		break;
 	}
 }
@@ -12568,6 +12455,7 @@ MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_realtek);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek HD-audio codec");
+MODULE_IMPORT_NS(SND_HDA_SCODEC_COMPONENT);
 
 static struct hda_codec_driver realtek_driver = {
 	.id = snd_hda_id_realtek,
-- 
2.30.2


