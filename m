Return-Path: <linux-kernel+bounces-118237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239188B6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61996B28A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B71CA8B;
	Tue, 26 Mar 2024 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ca9bKO17"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAE1CAA0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415458; cv=none; b=l059Zq+43NheN1sXjZAhvJI49G9hhagFIzboUEPPJ26Fd3HGYSNRyOXAVKbVUGa4+4tCqZT3xeEoto0Yxianehran26KZTbQ1cyjW/spqBwLxbxvZ1vFHB7deEcsa9QEcnOdJIMjRHudEvWFrRippoXlWcIA/z+cekkkrCdTMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415458; c=relaxed/simple;
	bh=F7sKqkt5uCoMZspxFpj4Kz8IbfFkMsDTZ1lbiQYPRME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNv/Mjoyzfi1krjvEnI5mGL/jIuIPXrKmb33tVFPs+obRnc72b52jPpHkgVDWspZC9N0tPgNxEbBTX2tUq7cS/6pNUb4n4VbRFq7YWRx8c+tn2dZYj43PwPC5q4vJw+dBrb0KBC4M3VIOzYfo/9RL3mQDGPI/XVBTpwoPXqK/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ca9bKO17; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q1A4is009834;
	Mon, 25 Mar 2024 20:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711415404;
	bh=Ho+kxlw24f5GUUPjJ/o03GF70SkJicIKEfuh7SJqEws=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ca9bKO17UiPv267Sq7NdRxSNo75/9pmCzLI+CiXJMlI5amLFzzf+jwBsyra1VEffy
	 ZOoPhHnCvnOZyZhgxEm8O6xuY38HAEJBvPjgmBGLQQ9Fteyblimihe4hZfWo6gijO4
	 jdOZvJnm9lZprOvEFsvlbFso40s2YYUpTYFD1JcM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q1A4Z7107569
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 20:10:04 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 20:10:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 20:10:03 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19AYE120020;
	Mon, 25 Mar 2024 20:09:58 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v1 8/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Date: Tue, 26 Mar 2024 09:09:05 +0800
Message-ID: <20240326010905.2147-8-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240326010905.2147-1-baojun.xu@ti.com>
References: <20240326010905.2147-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Main file for tas2781 spi driver.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/tas2781_hda_spi.c | 1284 +++++++++++++++++++++++++++++++
 1 file changed, 1284 insertions(+)
 create mode 100644 sound/pci/hda/tas2781_hda_spi.c

diff --git a/sound/pci/hda/tas2781_hda_spi.c b/sound/pci/hda/tas2781_hda_spi.c
new file mode 100644
index 000000000..ef3543dfc
--- /dev/null
+++ b/sound/pci/hda/tas2781_hda_spi.c
@@ -0,0 +1,1284 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// TAS2781 HDA SPI driver
+//
+// Copyright 2024 Texas Instruments, Inc.
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+
+#include <linux/acpi.h>
+#include <linux/crc8.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/firmware.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <sound/hda_codec.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include <sound/tas2781-tlv.h>
+
+#include "tas2781-spi.h"
+
+#include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_component.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+
+#define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
+
+/* No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD
+ * Define two controls, one is Volume control callbacks, the other is
+ * flag setting control callbacks.
+ */
+
+/* Volume control callbacks for tas2781 */
+#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinvert, \
+	xhandler_get, xhandler_put, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_range, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .rreg = xreg, .shift = xshift, \
+		 .rshift = xshift, .min = xmin, .max = xmax, \
+		 .invert = xinvert} }
+
+/* Flag control callbacks for tas2781 */
+#define ACARD_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = xname, \
+	.info = snd_ctl_boolean_mono_info, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = xdata }
+
+
+enum calib_data {
+	R0_VAL = 0,
+	INV_R0,
+	R0LOW,
+	POWER,
+	TLIM,
+	CALIB_MAX
+};
+
+struct tas2781_hda {
+	struct device *dev;
+	struct gpio_desc *cs_gpio;
+	struct gpio_desc *reset_gpio;
+	struct tasdevice_priv *priv;
+	struct snd_kcontrol *dsp_prog_ctl;
+	struct snd_kcontrol *dsp_conf_ctl;
+	struct snd_kcontrol *prof_ctl;
+	struct snd_kcontrol *snd_ctls[3];
+};
+
+static const struct regmap_range_cfg tasdevice_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = 256 * 128,
+		.selector_reg = TASDEVICE_PAGE_SELECT,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 128,
+	},
+};
+
+static const struct regmap_config tasdevice_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.ranges = tasdevice_ranges,
+	.num_ranges = ARRAY_SIZE(tasdevice_ranges),
+	.max_register = 256 * 128,
+};
+
+
+static void tas2781_spi_reset(struct tasdevice_priv *tas_dev);
+static int tasdevice_spi_init(struct tasdevice_priv *tas_priv);
+static int tasdevice_spi_amp_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+static int tasdevice_spi_amp_getvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+static int tasdevice_spi_digital_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+static int tasdevice_spi_digital_getvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc);
+
+static int tasdevice_spi_change_chn_book(struct tasdevice_priv *tas_priv,
+	unsigned short chn, int book)
+{
+	int ret = 0;
+
+	if (chn == tas_priv->index) {
+		struct tasdevice *tasdev = &tas_priv->tasdevice;
+		struct regmap *map = tas_priv->regmap;
+
+		if (tasdev->cur_book != book) {
+			/* Change to page 0 before book change.
+			 */
+			ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
+			if (ret < 0) {
+				dev_err(tas_priv->dev, "%s, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			ret = regmap_write(map, TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0) {
+				dev_err(tas_priv->dev, "%s, E=%d\n",
+					__func__, ret);
+				goto out;
+			}
+			tasdev->cur_book = book;
+		}
+	}
+
+out:
+	return ret;
+}
+
+int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned int *val)
+{
+	int ret = 0;
+
+	if (chn  == tas_priv->index) {
+		struct regmap *map = tas_priv->regmap;
+
+		ret = tasdevice_spi_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_read(map, TASDEVICE_PGRG(reg), val);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_spi_dev_read);
+
+int tasdevice_spi_dev_write(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned int value)
+{
+	int ret = 0;
+
+	if (chn  == tas_priv->index) {
+		struct regmap *map = tas_priv->regmap;
+
+		ret = tasdevice_spi_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_write(map, TASDEVICE_PGRG(reg),
+			value);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_spi_dev_write);
+
+int tasdevice_spi_dev_bulk_write(
+	struct tasdevice_priv *tas_priv, unsigned short chn,
+	unsigned int reg, unsigned char *data, unsigned int len)
+{
+	int ret = 0;
+
+	if (chn  == tas_priv->index) {
+		struct regmap *map = tas_priv->regmap;
+
+		ret = tasdevice_spi_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_write(map, TASDEVICE_PGRG(reg),
+			data, len);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_spi_dev_bulk_write);
+
+int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned char *data,
+	unsigned int len)
+{
+	int ret = 0;
+
+	if (chn  == tas_priv->index) {
+		struct regmap *map = tas_priv->regmap;
+
+		ret = tasdevice_spi_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_bulk_read(map, TASDEVICE_PGRG(reg), data, len);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_spi_dev_bulk_read);
+
+int tasdevice_spi_dev_update_bits(
+	struct tasdevice_priv *tas_priv, unsigned short chn,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	int ret = 0;
+
+	if (chn  == tas_priv->index) {
+		struct regmap *map = tas_priv->regmap;
+
+		ret = tasdevice_spi_change_chn_book(tas_priv, chn,
+			TASDEVICE_BOOK_ID(reg));
+		if (ret < 0)
+			goto out;
+
+		ret = regmap_update_bits(map, TASDEVICE_PGRG(reg),
+			mask, value);
+		if (ret < 0)
+			dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+	}
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tasdevice_spi_dev_update_bits);
+
+static void tas2781_spi_reset(struct tasdevice_priv *tas_dev)
+{
+	int ret;
+
+	if (tas_dev->reset) {
+		gpiod_set_value_cansleep(tas_dev->reset, 0);
+		usleep_range(500, 1000);
+		gpiod_set_value_cansleep(tas_dev->reset, 1);
+	} else {
+		ret = tasdevice_spi_dev_write(tas_dev, tas_dev->index,
+			TAS2781_REG_SWRESET, TAS2781_REG_SWRESET_RESET);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "dev swreset fail, %d\n", ret);
+	}
+	usleep_range(1000, 1050);
+}
+
+static int tasdevice_spi_init(struct tasdevice_priv *tas_priv)
+{
+	tas_priv->cur_prog = -1;
+	tas_priv->cur_conf = -1;
+
+	tas_priv->tasdevice.cur_book = -1;
+	tas_priv->tasdevice.cur_prog = -1;
+	tas_priv->tasdevice.cur_conf = -1;
+
+	mutex_init(&tas_priv->codec_lock);
+
+	return 0;
+}
+
+static int tasdevice_clamp(int val, int max, unsigned int invert)
+{
+	if (val > max)
+		val = max;
+	if (invert)
+		val = max - val;
+	if (val < 0)
+		val = 0;
+	return val;
+}
+
+static int tasdevice_spi_amp_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
+{
+	unsigned int invert = mc->invert;
+	unsigned char mask;
+	int max = mc->max;
+	int val, ret;
+
+	mask = (1 << fls(max)) - 1;
+	mask <<= mc->shift;
+	val = tasdevice_clamp(ucontrol->value.integer.value[0], max, invert);
+	ret = tasdevice_spi_dev_update_bits(tas_priv, tas_priv->index,
+		mc->reg, mask, (unsigned int)(val << mc->shift));
+	if (ret)
+		dev_err(tas_priv->dev, "set AMP vol error in dev %d\n",
+			tas_priv->ndev);
+
+	return ret;
+}
+
+static int tasdevice_spi_amp_getvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
+{
+	unsigned int invert = mc->invert;
+	unsigned char mask = 0;
+	int max = mc->max;
+	int ret, val;
+
+	/* Read the primary device */
+	ret = tasdevice_spi_dev_read(tas_priv, tas_priv->index, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_priv->dev, "%s, get AMP vol error\n", __func__);
+		goto out;
+	}
+
+	mask = (1 << fls(max)) - 1;
+	mask <<= mc->shift;
+	val = (val & mask) >> mc->shift;
+	val = tasdevice_clamp(val, max, invert);
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+
+}
+
+static int tasdevice_spi_digital_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
+{
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int val, ret;
+
+	val = tasdevice_clamp(ucontrol->value.integer.value[0], max, invert);
+
+	ret = tasdevice_spi_dev_write(tas_priv, tas_priv->index, mc->reg,
+		(unsigned int)val);
+	if (ret)
+		dev_err(tas_priv->dev, "set digital vol err in dev %d\n",
+			tas_priv->ndev);
+
+	return ret;
+
+}
+
+static int tasdevice_spi_digital_getvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
+{
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int ret, val;
+
+	/* Read the primary device as the whole */
+	ret = tasdevice_spi_dev_read(tas_priv, tas_priv->index, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_priv->dev, "%s, get digital vol error\n",
+			__func__);
+		goto out;
+	}
+
+	val = tasdevice_clamp(val, max, invert);
+	ucontrol->value.integer.value[0] = val;
+
+out:
+	return ret;
+
+}
+
+static int tas2781_read_acpi(struct tas2781_hda *tas_hda, const char *hid,
+	int id)
+{
+	struct tasdevice_priv *p = tas_hda->priv;
+	struct acpi_device *adev;
+	struct device *physdev;
+	u32 values[HDA_MAX_COMPONENTS];
+	const char *sub, *property;
+	size_t nval;
+	int ret, i;
+
+	/*
+	 * ACPI_COMPANION isn't available when this driver was instantiated by
+	 * the serial-multi-instantiate driver, so lookup the node by HID
+	 */
+	if (!ACPI_COMPANION(p->dev)) {
+		adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+		if (!adev) {
+			dev_err(p->dev,
+				"Failed to find an ACPI device for %s\n",
+				dev_name(p->dev));
+			return -ENODEV;
+		}
+		ACPI_COMPANION_SET(p->dev, adev);
+	}
+	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+	if (!adev) {
+		dev_err(p->dev,
+			"Failed to find an ACPI device for %s\n", hid);
+		return -ENODEV;
+	}
+
+	strscpy(p->dev_name, hid, sizeof(p->dev_name));
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+
+	/* No side-effect to the playback even if subsystem_id is NULL*/
+	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+	if (IS_ERR(sub))
+		sub = NULL;
+
+	p->acpi_subsystem_id = sub;
+
+	put_device(physdev);
+
+	property = "ti,dev-index";
+	ret = device_property_count_u32(p->dev, property);
+	if (ret <= 0)
+		goto err;
+
+	if (ret > ARRAY_SIZE(values)) {
+		ret = -EINVAL;
+		goto err;
+	}
+	nval = ret;
+
+	ret = device_property_read_u32_array(p->dev, property, values, nval);
+	if (ret)
+		goto err;
+
+	p->index = 0xFF;
+	for (i = 0; i < nval; i++) {
+		if (values[i] == id) {
+			p->index = i;
+			break;
+		}
+	}
+	/*
+	 * It's not an error for the ID to be missing: for I2C there can be
+	 * an alias address that is not a real device. So reject silently.
+	 */
+	if (p->ndev == 0xFF) {
+		dev_dbg(p->dev, "No index found in %s\n", property);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	p->reset = devm_gpiod_get_index_optional(p->dev,
+		"reset", p->ndev, GPIOD_OUT_LOW);
+	if (IS_ERR(p->reset)) {
+		ret = PTR_ERR(p->reset);
+
+		/*
+		 * If RESET is shared the first amp to probe will grab the
+		 * reset line and reset all the amps
+		 */
+		if (ret != -EBUSY)
+			return dev_err_probe(p->dev, ret,
+				"Failed to get reset GPIO\n");
+
+		dev_info(p->dev, "Reset GPIO busy, assume shared reset\n");
+		p->reset = NULL;
+	}
+
+	return 0;
+
+err:
+	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
+	acpi_dev_put(adev);
+
+	return ret;
+}
+
+static void tas2781_hda_playback_hook(struct device *dev, int action)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+
+	dev_dbg(tas_hda->dev, "%s: action = %d\n", __func__, action);
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		mutex_lock(&tas_hda->priv->codec_lock);
+		tasdevice_tuning_switch(tas_hda->priv, 0);
+		mutex_unlock(&tas_hda->priv->codec_lock);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		mutex_lock(&tas_hda->priv->codec_lock);
+		tasdevice_tuning_switch(tas_hda->priv, 1);
+		mutex_unlock(&tas_hda->priv->codec_lock);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		break;
+	default:
+		dev_dbg(tas_hda->dev, "Playback action not supported: %d\n",
+			action);
+		break;
+	}
+}
+
+static int tasdevice_info_profile(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_priv->rcabin.ncfgs - 1;
+
+	return 0;
+}
+
+static int tasdevice_get_profile_id(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->rcabin.profile_cfg_id;
+
+	return 0;
+}
+
+static int tasdevice_set_profile_id(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	int nr_profile = ucontrol->value.integer.value[0];
+	int max = tas_priv->rcabin.ncfgs - 1;
+	int val, ret = 0;
+
+	val = clamp(nr_profile, 0, max);
+
+	if (tas_priv->rcabin.profile_cfg_id != val) {
+		tas_priv->rcabin.profile_cfg_id = val;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_fw->nr_programs - 1;
+
+	return 0;
+}
+
+static int tasdevice_info_config(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_fw->nr_configurations - 1;
+
+	return 0;
+}
+
+static int tasdevice_program_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->cur_prog;
+
+	return 0;
+}
+
+static int tasdevice_program_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+	int nr_program = ucontrol->value.integer.value[0];
+	int max = tas_fw->nr_programs - 1;
+	int val, ret = 0;
+
+	val = clamp(nr_program, 0, max);
+
+	if (tas_priv->cur_prog != val) {
+		tas_priv->cur_prog = val;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int tasdevice_config_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = tas_priv->cur_conf;
+
+	return 0;
+}
+
+static int tasdevice_config_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct tasdevice_fw *tas_fw = tas_priv->fmw;
+	int nr_config = ucontrol->value.integer.value[0];
+	int max = tas_fw->nr_configurations - 1;
+	int val, ret = 0;
+
+	val = clamp(nr_config, 0, max);
+
+	if (tas_priv->cur_conf != val) {
+		tas_priv->cur_conf = val;
+		ret = 1;
+	}
+
+	return ret;
+}
+
+/*
+ * tas2781_digital_getvol - get the volum control
+ * @kcontrol: control pointer
+ * @ucontrol: User data
+ * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
+ * depends on internal regmap mechanism.
+ * tas2781 contains book and page two-level register map, especially
+ * book switching will set the register BXXP00R7F, after switching to the
+ * correct book, then leverage the mechanism for paging to access the
+ * register.
+ */
+static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_spi_digital_getvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	return tasdevice_spi_amp_getvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	/* The check of the given value is in tasdevice_digital_putvol. */
+	return tasdevice_spi_digital_putvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+
+	/* The check of the given value is in tasdevice_amp_putvol. */
+	return tasdevice_spi_amp_putvol(tas_priv, ucontrol, mc);
+}
+
+static int tas2781_force_fwload_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = (int)tas_priv->force_fwload_status;
+	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
+			tas_priv->force_fwload_status ? "ON" : "OFF");
+
+	return 0;
+}
+
+static int tas2781_force_fwload_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+	bool change, val = (bool)ucontrol->value.integer.value[0];
+
+	if (tas_priv->force_fwload_status == val)
+		change = false;
+	else {
+		change = true;
+		tas_priv->force_fwload_status = val;
+	}
+	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
+		tas_priv->force_fwload_status ? "ON" : "OFF");
+
+	return change;
+}
+
+static const struct snd_kcontrol_new tas2781_snd_controls[] = {
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
+		1, 0, 20, 0, tas2781_amp_getvol,
+		tas2781_amp_putvol, amp_vol_tlv),
+	ACARD_SINGLE_RANGE_EXT_TLV("Speaker Digital Gain", TAS2781_DVC_LVL,
+		0, 0, 200, 1, tas2781_digital_getvol,
+		tas2781_digital_putvol, dvc_tlv),
+	ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
+		tas2781_force_fwload_get, tas2781_force_fwload_put),
+};
+
+static const struct snd_kcontrol_new tas2781_prof_ctrl = {
+	.name = "Speaker Profile Id",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = tasdevice_info_profile,
+	.get = tasdevice_get_profile_id,
+	.put = tasdevice_set_profile_id,
+};
+
+static const struct snd_kcontrol_new tas2781_dsp_prog_ctrl = {
+	.name = "Speaker Program Id",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = tasdevice_info_programs,
+	.get = tasdevice_program_get,
+	.put = tasdevice_program_put,
+};
+
+static const struct snd_kcontrol_new tas2781_dsp_conf_ctrl = {
+	.name = "Speaker Config Id",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = tasdevice_info_config,
+	.get = tasdevice_config_get,
+	.put = tasdevice_config_put,
+};
+
+static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
+{
+	static const unsigned char page_array[CALIB_MAX] = {
+		0x17, 0x18, 0x18, 0x13, 0x18
+	};
+	static const unsigned char rgno_array[CALIB_MAX] = {
+		0x74, 0x0c, 0x14, 0x70, 0x7c
+	};
+	unsigned char *data;
+	int j, rc;
+
+	data = tas_priv->cali_data.data +
+		tas_priv->ndev * TASDEVICE_SPEAKER_CALIBRATION_SIZE;
+	for (j = 0; j < CALIB_MAX; j++) {
+		rc = tasdevice_spi_dev_bulk_write(tas_priv, tas_priv->index,
+			TASDEVICE_REG(0, page_array[j], rgno_array[j]),
+			&(data[4 * j]), 4);
+		if (rc < 0)
+			dev_err(tas_priv->dev,
+				"chn %d calib %d bulk_wr err = %d\n",
+				tas_priv->ndev, j, rc);
+	}
+
+}
+
+/* Update the calibration data, including speaker impedance, f0, etc,
+ * into algo. Calibrate data is done by manufacturer in the factory.
+ * These data are used by Algo for calculating the speaker temperature,
+ * speaker membrane excursion and f0 in real time during playback.
+ * Calibration data format in EFI is V2, since 2024.
+ */
+static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
+{
+	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
+		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static efi_char16_t efi_name[] = L"CALI_DATA";
+	struct tm *tm = &tas_priv->tm;
+	unsigned int attr, crc;
+	unsigned int *tmp_val;
+	efi_status_t status;
+
+	tas_priv->cali_data.total_sz = 0;
+	/* Get real size of UEFI variable */
+	status = efi.get_variable(efi_name, &efi_guid, &attr,
+		&tas_priv->cali_data.total_sz, tas_priv->cali_data.data);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		/* Allocate data buffer of data_size bytes */
+		tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
+			tas_priv->cali_data.total_sz, GFP_KERNEL);
+		if (!tas_priv->cali_data.data)
+			return -ENOMEM;
+		/* Get variable contents into buffer */
+		status = efi.get_variable(efi_name, &efi_guid, &attr,
+			&tas_priv->cali_data.total_sz,
+			tas_priv->cali_data.data);
+	}
+	if (status != EFI_SUCCESS)
+		return -EINVAL;
+
+	tmp_val = (unsigned int *)tas_priv->cali_data.data;
+	if (tmp_val[0] == 2781) {
+		/* Calibration data is in V2 format.
+		 * struct cali_data {
+		 *      short link_id;
+		 *      short unique_id;
+		 *      char cali_data[20];
+		 *}
+		 *
+		 * struct {
+		 *      int ChipID;
+		 *      int Device-Sum (4 bytes)
+		 *      int  TimeStamp of Calibration (4 bytes)
+		 *
+		 *      struct cali_data cali_data[Device-Sum];
+		 *      int CRC (4 bytes)
+		 * } ueft;
+		 */
+		crc = crc32(~0, tas_priv->cali_data.data,
+			3 + tmp_val[0]  * 6) ^ ~0;
+		dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+			crc, tmp_val[3+tmp_val[0]*6]);
+
+		if (crc == tmp_val[3+tmp_val[0]*6]) {
+			time64_to_tm(tmp_val[2], 0, tm);
+			dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
+				tm->tm_year, tm->tm_mon, tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec);
+			tasdevice_apply_calibration(tas_priv);
+		} else {
+			tas_priv->cali_data.total_sz = 0;
+		}
+	} else {
+		/* Calibration data is in V1 format.
+		 * struct cali_data {
+		 *      char cali_data[20];
+		 * }
+		 *
+		 * struct {
+		 *      struct cali_data cali_data[4];
+		 *      int  TimeStamp of Calibration (4 bytes)
+		 *      int CRC (4 bytes)
+		 * } ueft;
+		 */
+		crc = crc32(~0, tas_priv->cali_data.data, 84) ^ ~0;
+		dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+			crc, tmp_val[21]);
+
+		if (crc == tmp_val[21]) {
+			time64_to_tm(tmp_val[20], 0, tm);
+			dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
+				tm->tm_year, tm->tm_mon, tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec);
+			tasdevice_apply_calibration(tas_priv);
+		} else
+			tas_priv->cali_data.total_sz = 0;
+	}
+	return 0;
+}
+
+static void tas2781_hda_remove_controls(struct tas2781_hda *tas_hda)
+{
+	struct hda_codec *codec = tas_hda->priv->codec;
+
+	if (tas_hda->dsp_prog_ctl)
+		snd_ctl_remove(codec->card, tas_hda->dsp_prog_ctl);
+
+	if (tas_hda->dsp_conf_ctl)
+		snd_ctl_remove(codec->card, tas_hda->dsp_conf_ctl);
+
+	for (int i = ARRAY_SIZE(tas_hda->snd_ctls) - 1; i >= 0; i--)
+		if (tas_hda->snd_ctls[i])
+			snd_ctl_remove(codec->card, tas_hda->snd_ctls[i]);
+
+	if (tas_hda->prof_ctl)
+		snd_ctl_remove(codec->card, tas_hda->prof_ctl);
+}
+
+static void tasdev_fw_ready(const struct firmware *fmw, void *context)
+{
+	struct tasdevice_priv *tas_priv = context;
+	struct tas2781_hda *tas_hda = dev_get_drvdata(tas_priv->dev);
+	struct hda_codec *codec = tas_priv->codec;
+	int i, ret;
+
+	pm_runtime_get_sync(tas_priv->dev);
+	mutex_lock(&tas_priv->codec_lock);
+
+	ret = tasdevice_spi_rca_parser(tas_priv, fmw);
+	if (ret)
+		goto out;
+
+	tas_hda->prof_ctl = snd_ctl_new1(&tas2781_prof_ctrl, tas_priv);
+	ret = snd_ctl_add(codec->card, tas_hda->prof_ctl);
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to add KControl %s = %d\n",
+			tas2781_prof_ctrl.name, ret);
+		goto out;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
+		tas_hda->snd_ctls[i] = snd_ctl_new1(&tas2781_snd_controls[i],
+			tas_priv);
+		ret = snd_ctl_add(codec->card, tas_hda->snd_ctls[i]);
+		if (ret) {
+			dev_err(tas_priv->dev,
+				"Failed to add KControl %s = %d\n",
+				tas2781_snd_controls[i].name, ret);
+			goto out;
+		}
+	}
+
+	tasdevice_dsp_remove(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%04X-%01d.bin",
+		codec->core.subsystem_id & 0xffff, tas_priv->index);
+	dev_info(tas_priv->dev, "Binary %s.\n", tas_priv->coef_binaryname);
+	ret = tasdevice_dsp_parser(tas_priv);
+	if (ret) {
+		dev_err(tas_priv->dev, "dspfw load %s error\n",
+			tas_priv->coef_binaryname);
+		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+
+	tas_hda->dsp_prog_ctl = snd_ctl_new1(&tas2781_dsp_prog_ctrl,
+		tas_priv);
+	ret = snd_ctl_add(codec->card, tas_hda->dsp_prog_ctl);
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to add KControl %s = %d\n",
+			tas2781_dsp_prog_ctrl.name, ret);
+		goto out;
+	}
+
+	tas_hda->dsp_conf_ctl = snd_ctl_new1(&tas2781_dsp_conf_ctrl,
+		tas_priv);
+	ret = snd_ctl_add(codec->card, tas_hda->dsp_conf_ctl);
+	if (ret) {
+		dev_err(tas_priv->dev,
+			"Failed to add KControl %s = %d\n",
+			tas2781_dsp_conf_ctrl.name, ret);
+		goto out;
+	}
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	tasdevice_prmg_load(tas_priv, 0);
+	if (tas_priv->fmw->nr_programs > 0)
+		tas_priv->cur_prog = 0;
+	if (tas_priv->fmw->nr_configurations > 0)
+		tas_priv->cur_conf = 0;
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	tasdevice_save_calibration(tas_priv);
+
+	tasdevice_tuning_switch(tas_hda->priv, 0);
+
+out:
+	mutex_unlock(&tas_hda->priv->codec_lock);
+	if (fmw)
+		release_firmware(fmw);
+	pm_runtime_mark_last_busy(tas_hda->dev);
+	pm_runtime_put_autosuspend(tas_hda->dev);
+}
+
+static int tas2781_hda_bind(struct device *dev, struct device *master,
+	void *master_data)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+	struct hda_codec *codec;
+	unsigned int subid;
+	int ret;
+
+	if (!comps || tas_hda->priv->index < 0 ||
+		tas_hda->priv->index >= HDA_MAX_COMPONENTS)
+		return -EINVAL;
+
+	comps = &comps[tas_hda->priv->index];
+	if (comps->dev)
+		return -EBUSY;
+
+	codec = comps->codec;
+	subid = codec->core.subsystem_id >> 16;
+
+	switch (subid) {
+	case 0x103C:
+		tas_hda->priv->catlog_id = HP;
+		break;
+	default:
+		tas_hda->priv->catlog_id = OTHERS;
+		break;
+	}
+
+	pm_runtime_get_sync(dev);
+
+	comps->dev = dev;
+
+	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
+
+	dev_info(dev, "Bind %d.%d.\n", subid, (int)tas_hda->priv->catlog_id);
+	ret = tascodec_init(tas_hda->priv, codec, THIS_MODULE,
+		tasdev_fw_ready);
+	if (!ret)
+		comps->playback_hook = tas2781_hda_playback_hook;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static void tas2781_hda_unbind(struct device *dev,
+	struct device *master, void *master_data)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+
+	comps = &comps[tas_hda->priv->index];
+
+	if (comps->dev == dev) {
+		comps->dev = NULL;
+		memset(comps->name, 0, sizeof(comps->name));
+		comps->playback_hook = NULL;
+	}
+
+	tas2781_hda_remove_controls(tas_hda);
+
+	tasdevice_config_info_remove(tas_hda->priv);
+	tasdevice_dsp_remove(tas_hda->priv);
+
+	tas_hda->priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+}
+
+static const struct component_ops tas2781_hda_comp_ops = {
+	.bind = tas2781_hda_bind,
+	.unbind = tas2781_hda_unbind,
+};
+
+static void tas2781_hda_remove(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+
+	pm_runtime_get_sync(tas_hda->dev);
+	pm_runtime_disable(tas_hda->dev);
+
+	component_del(tas_hda->dev, &tas2781_hda_comp_ops);
+
+	pm_runtime_put_noidle(tas_hda->dev);
+
+	tasdevice_remove(tas_hda->priv);
+}
+
+static int tas2781_hda_spi_probe(struct spi_device *spi)
+{
+	struct tas2781_hda *tas_hda;
+	struct tasdevice_priv *tas_priv;
+	const char *device_name;
+	int ret;
+
+	tas_hda = devm_kzalloc(&spi->dev, sizeof(*tas_hda), GFP_KERNEL);
+	if (!tas_hda)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, tas_hda);
+	tas_hda->dev = &spi->dev;
+
+	tas_priv = devm_kzalloc(&spi->dev, sizeof(*tas_priv), GFP_KERNEL);
+	if (!tas_priv)
+		return -ENOMEM;
+	tas_priv->dev = &spi->dev;
+	tas_priv->client = (void *)spi;
+	tas_hda->priv = tas_priv;
+
+	if (strstr(dev_name(&spi->dev), "TXNW2781")) {
+		device_name = "TXNW2781";
+		tas_hda->priv->save_calibration = tas2781_save_calibration;
+		tas_hda->priv->apply_calibration = tas2781_apply_calib;
+	} else
+		return -ENODEV;
+
+	tas_hda->priv->irq_info.irq = spi->irq;
+	ret = tas2781_read_acpi(tas_hda, device_name,
+		spi_get_chipselect(spi, 0));
+	if (ret)
+		return dev_err_probe(tas_hda->dev, ret,
+			"Platform not supported\n");
+
+	tas_hda->priv->regmap = devm_regmap_init_spi(spi, &tasdevice_regmap);
+	if (IS_ERR(tas_hda->priv->regmap)) {
+		ret = PTR_ERR(tas_hda->priv->regmap);
+		dev_err(tas_priv->dev, "Failed to allocate regmap: %d\n",
+			ret);
+		goto err;
+	}
+	ret = tasdevice_spi_init(tas_hda->priv);
+	if (ret)
+		goto err;
+
+	pm_runtime_set_autosuspend_delay(tas_hda->dev, 3000);
+	pm_runtime_use_autosuspend(tas_hda->dev);
+	pm_runtime_mark_last_busy(tas_hda->dev);
+	pm_runtime_set_active(tas_hda->dev);
+	pm_runtime_get_noresume(tas_hda->dev);
+	pm_runtime_enable(tas_hda->dev);
+
+	pm_runtime_put_autosuspend(tas_hda->dev);
+
+	tas2781_spi_reset(tas_hda->priv);
+
+	ret = component_add(tas_hda->dev, &tas2781_hda_comp_ops);
+	if (ret) {
+		dev_err(tas_hda->dev, "Register component failed: %d\n", ret);
+		pm_runtime_disable(tas_hda->dev);
+	}
+
+err:
+	if (ret)
+		tas2781_hda_remove(&spi->dev);
+	return ret;
+}
+
+static void tas2781_hda_spi_remove(struct spi_device *spi)
+{
+	tas2781_hda_remove(&spi->dev);
+}
+
+static int tas2781_runtime_suspend(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+
+	dev_dbg(tas_hda->dev, "Runtime Suspend\n");
+
+	mutex_lock(&tas_hda->priv->codec_lock);
+
+	if (tas_hda->priv->playback_started) {
+		tasdevice_tuning_switch(tas_hda->priv, 1);
+		tas_hda->priv->playback_started = false;
+	}
+
+	tas_hda->priv->tasdevice.cur_book = -1;
+	tas_hda->priv->tasdevice.cur_prog = -1;
+	tas_hda->priv->tasdevice.cur_conf = -1;
+
+	mutex_unlock(&tas_hda->priv->codec_lock);
+
+	return 0;
+}
+
+static int tas2781_runtime_resume(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+
+	dev_dbg(tas_hda->dev, "Runtime Resume\n");
+
+	mutex_lock(&tas_hda->priv->codec_lock);
+
+	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
+
+	/* If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	tasdevice_apply_calibration(tas_hda->priv);
+
+	mutex_unlock(&tas_hda->priv->codec_lock);
+
+	return 0;
+}
+
+static int tas2781_system_suspend(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(tas_hda->priv->dev, "System Suspend\n");
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Shutdown chip before system suspend */
+	tasdevice_tuning_switch(tas_hda->priv, 1);
+
+	/*
+	 * Reset GPIO may be shared, so cannot reset here.
+	 * However beyond this point, amps may be powered down.
+	 */
+	return 0;
+}
+
+static int tas2781_system_resume(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	int ret;
+
+	dev_info(tas_hda->priv->dev, "System Resume\n");
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&tas_hda->priv->codec_lock);
+
+	tas_hda->priv->tasdevice.cur_book = -1;
+	tas_hda->priv->tasdevice.cur_prog = -1;
+	tas_hda->priv->tasdevice.cur_conf = -1;
+
+	tas2781_spi_reset(tas_hda->priv);
+	tasdevice_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
+
+	/* If calibrated data occurs error, dsp will still work with default
+	 * calibrated data inside algo.
+	 */
+	tasdevice_apply_calibration(tas_hda->priv);
+	mutex_unlock(&tas_hda->priv->codec_lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tas2781_hda_pm_ops = {
+	RUNTIME_PM_OPS(tas2781_runtime_suspend, tas2781_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(tas2781_system_suspend, tas2781_system_resume)
+};
+
+static const struct spi_device_id tas2781_hda_spi_id[] = {
+	{ "tas2781-hda", 0 },
+	{}
+};
+
+static const struct acpi_device_id tas2781_acpi_hda_match[] = {
+	{"TXNW2781", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
+
+static struct spi_driver tas2781_hda_spi_driver = {
+	.driver = {
+		.name		= "tas2781-hda",
+		.acpi_match_table = tas2781_acpi_hda_match,
+		.pm		= &tas2781_hda_pm_ops,
+	},
+	.id_table	= tas2781_hda_spi_id,
+	.probe		= tas2781_hda_spi_probe,
+	.remove		= tas2781_hda_spi_remove,
+};
+module_spi_driver(tas2781_hda_spi_driver);
+
+MODULE_DESCRIPTION("TAS2781 HDA Driver");
+MODULE_AUTHOR("Baojun Xu, TI, <baojun.xu@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_TAS2781_FMWLIB);
-- 
2.40.1


