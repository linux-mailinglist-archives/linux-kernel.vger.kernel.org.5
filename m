Return-Path: <linux-kernel+bounces-92435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80A87201B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9937228639E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AC85C51;
	Tue,  5 Mar 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j5DpK+l8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B143AB0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645299; cv=none; b=R4GV14+NGH015rEu0xqWRZOdzt8ulxgsq60MZdsTzIoZquCh6RL/IieQsSrYcTzXXgy212HW73N6xdRaXiRJ1Z9aFZ94hafB7tSRYrhlroCXCl8LDEy5ym0Y2awNp6pbLoJSM6KR6xtulbwJuN3OZ5Q2D7K20zXhb0wpGXgHO08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645299; c=relaxed/simple;
	bh=BDne9RJuQgrAK2WzGYvcUtFDO08fWUMpgHBcg1NDGuQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aohnYBaOHH3cI8RChs8kimLBYarfquG0skYFANGZR8tGKD2wh4x7YEnsLh+ofbsFF6I7B1z0yKXnxHYz5lWeioBrtZJTnX35Dvddr6ovCzMyBt1ioUuMtGb0Q4u2gBoQaKuAbXfkOyV39aNvD5ZAsyC7Od8UAhtZkomEK6cSJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j5DpK+l8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 425DQt0B092506;
	Tue, 5 Mar 2024 07:26:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709645215;
	bh=9S6zPqmYStZU3GrM2eqWNDBpx3rODF/MHlC66/98xbc=;
	h=From:To:CC:Subject:Date;
	b=j5DpK+l8PKvy2/8aUN8/Dal/j9X/EGoa/Exe4ogVY38mFA05E2wnLeqdOTNyxtRVE
	 eBPnExhPZp9hcEjmh6ySeVjZrG4LXdqwRF2j9eo72ZeJUM8NSbCZIeHknhQZHxccGK
	 6Tqa9zaI/KTfgPPOoxOVcQbD3F72Bj9jAAmceug4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 425DQtNX005641
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Mar 2024 07:26:55 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 07:26:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 07:26:54 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.64.10])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 425DQn6S022325;
	Tue, 5 Mar 2024 07:26:50 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <mengdong.lin@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kevin-lu@ti.com>, <tiwai@suse.de>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>, <navada@ti.com>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v11] ASoc: tas2783: Add tas2783 codec driver
Date: Tue, 5 Mar 2024 21:26:45 +0800
Message-ID: <20240305132646.638-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The tas2783 is a smart audio amplifier with integrated MIPI SoundWire
interface (Version 1.2.1 compliant), I2C, and I2S/TDM interfaces designed
for portable applications. An on-chip DSP supports Texas Instruments
SmartAmp speaker protection algorithm. The integrated speaker voltage and
current sense provides for real-time monitoring of loudspeakers.

The ASoC component provides the majority of the functionality of the
device, all the audio functions.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v11:
 - simplify tasdevice_set_sdw_stream
 - fixed some Linux coding style
 - fixed the spelling mistakes
 - Select left/right channel based on unique id
 - a longer description has been added
 - remove unused crc8 in KCONFIG
 - Invert of RE here means reciprocal of RE
 - correct indentation
 - correct the wrong pow calibrated register
 - correct comment on RESET register
 - fixed usually lines don't end with an open parenthesis
 - fixed tasdevice_sdw_shutdown
 - use defines for function, entity, etc. for readable
 - remove unnecessary codec_lock in component_probe()
 - remove struct sdw_stream_data
 - remove unused macro definitions
 - use BIT(2) and BIT(1) instead of 0x2 and 0x1
 - implement pm_runtime
 - reg_start is u8, reg_start + i only adds i byte, it should be
   reg_start + i * 4, because the calibration values
 - fixed total_sz in tas2783_calibration
 - add a define for TASDEVICE_REG(0, 0, 0x0a)
 - rework macro style in header file
 - Add select CRC32
 - rewrite the mute and the return value handling
 - Add comments on bin file
 - Add link_id into the fw name to distinguish the same sdw id on different
   sdw id.
 - remove unnecessary mutex_lock
 - use set_active() in tasdevice_io_init and move all other parts in the
   probe.
 - move pm_runtime_get_noresume to the probe
 - fix the return value of putvol function
 - add put_noidle in tasdevice_sdw_remove
 - remove unused header file(of.h)
 - correct the style of the multi-line comment
 - Set the readable registers in tas2783_readable_register for debugfs
 - Use new PM macros
 - Use default put and get inline SOC_SINGLE_RANGE_TLV and
   SOC_SINGLE_SX_TLV
 - Use respective %pt to log the calibrated time
 - Remove unnecessary struct tm
 - Add trailing comma tasdevice_dapm_widgets and tasdevice_audio_map
 - Rewrite the return value handling in tasdevice_sdw_probe
 - use dev_num instead of id.unique_id
 - rework the log
 - Add code to check the size of calibrated data in UEFI
 - Add description of Layout of calibrated Data in UEFI
 - switch back link_id and unique_id to identify the devcie
 - unique_id offset as the device index of the calibrated data
 - update calibrated data layout stored in UEFI, add link_id and unique_id
   into the calibrated data in case of tas2783 sitting in different SDQW
   buses.
 - correct the wrong unique_id
 - set the unique_id as hex style in dsp bin file name
---
 sound/soc/codecs/Kconfig       |  16 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/tas2783-sdw.c | 932 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2783.h     | 106 ++++
 4 files changed, 1056 insertions(+)
 create mode 100644 sound/soc/codecs/tas2783-sdw.c
 create mode 100644 sound/soc/codecs/tas2783.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 59f9742e9ff4..6ba3fd0c0811 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -247,6 +247,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2781_COMLIB
 	imply SND_SOC_TAS2781_FMWLIB
 	imply SND_SOC_TAS2781_I2C
+	imply SND_SOC_TAS2783
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1847,6 +1848,21 @@ config SND_SOC_TAS2781_I2C
 	  algo coefficient setting, for one, two or even multiple TAS2781
 	  chips.
 
+config SND_SOC_TAS2783
+	tristate "Texas Instruments TAS2783 speaker amplifier (sdw)"
+	depends on SOUNDWIRE
+	depends on EFI
+	select REGMAP
+	select REGMAP_SOUNDWIRE
+	select CRC32
+	select CRC32_SARWATE
+	help
+	  Enable support for Texas Instruments TAS2783 Smart Amplifier
+	  Digital input mono Class-D and DSP-inside audio power amplifiers.
+	  TAS2783 supports the MIPI SoundWire v1.2 compatible interface
+	  for audio and control data. At the end of calibrated data appends
+	  the crc data with crc32_sarwate for error detection.
+
 config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index f53baa2b9565..6afceb126ae3 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -284,6 +284,7 @@ snd-soc-tas2770-objs := tas2770.o
 snd-soc-tas2781-comlib-objs := tas2781-comlib.o
 snd-soc-tas2781-fmwlib-objs := tas2781-fmwlib.o
 snd-soc-tas2781-i2c-objs := tas2781-i2c.o
+snd-soc-tas2783-objs := tas2783-sdw.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tfa989x-objs := tfa989x.o
 snd-soc-tlv320adc3xxx-objs := tlv320adc3xxx.o
@@ -664,6 +665,7 @@ obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
 obj-$(CONFIG_SND_SOC_TAS2781_COMLIB)	+= snd-soc-tas2781-comlib.o
 obj-$(CONFIG_SND_SOC_TAS2781_FMWLIB)	+= snd-soc-tas2781-fmwlib.o
 obj-$(CONFIG_SND_SOC_TAS2781_I2C)	+= snd-soc-tas2781-i2c.o
+obj-$(CONFIG_SND_SOC_TAS2783)	+= snd-soc-tas2783.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
new file mode 100644
index 000000000000..71c218792bc9
--- /dev/null
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -0,0 +1,932 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
+//
+// Copyright (C) 2023 - 2024 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+//	Kevin Lu <kevin-lu@ti.com>
+//	Shenghao Ding <shenghao-ding@ti.com>
+//
+
+#include <asm/unaligned.h>
+#include <linux/acpi.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_type.h>
+#include <sound/pcm_params.h>
+#include <sound/sdw.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include <sound/tas2781-tlv.h>
+#include "tas2783.h"
+
+static const unsigned int tas2783_cali_reg[] = {
+	TAS2783_CALIBRATION_RE,		/* Resistance */
+	TAS2783_CALIBRATION_RE_LOW,	/* Low limitation of RE */
+	TAS2783_CALIBRATION_INV_RE,	/* Reciprocal of RE */
+	TAS2783_CALIBRATION_POW,	/* RMS Power */
+	TAS2783_CALIBRATION_TLIMIT	/* Temperature limitation */
+};
+
+static const struct reg_default tas2783_reg_defaults[] = {
+	/* Default values for ROM mode. Activated. */
+	{ 0x8002, 0x1a },	/* AMP inactive. */
+	{ 0x8097, 0xc8 },
+	{ 0x80b5, 0x74 },
+	{ 0x8099, 0x20 },
+	{ 0xfe8d, 0x0d },
+	{ 0xfebe, 0x4a },
+	{ 0x8230, 0x00 },
+	{ 0x8231, 0x00 },
+	{ 0x8232, 0x00 },
+	{ 0x8233, 0x01 },
+	{ 0x8418, 0x00 },	/* Set volume to 0 dB. */
+	{ 0x8419, 0x00 },
+	{ 0x841a, 0x00 },
+	{ 0x841b, 0x00 },
+	{ 0x8428, 0x40 },	/* Unmute channel */
+	{ 0x8429, 0x00 },
+	{ 0x842a, 0x00 },
+	{ 0x842b, 0x00 },
+	{ 0x8548, 0x00 },	/* Set volume to 0 dB. */
+	{ 0x8549, 0x00 },
+	{ 0x854a, 0x00 },
+	{ 0x854b, 0x00 },
+	{ 0x8558, 0x40 },	/* Unmute channel */
+	{ 0x8559, 0x00 },
+	{ 0x855a, 0x00 },
+	{ 0x855b, 0x00 },
+	{ 0x800a, 0x3a },	/* Enable both channel */
+	{ 0x800e, 0x44 },
+	{ 0x800f, 0x40 },
+	{ 0x805c, 0x99 },
+	{ SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP, TAS2783_SDCA_ENT_FU21,
+		TAS2783_SDCA_CTL_FU_MUTE, 0), 0 },
+	{ SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP, TAS2783_SDCA_ENT_FU21,
+		TAS2783_SDCA_CTL_FU_VOLUME, 0), 0 },
+	{ SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP, TAS2783_SDCA_ENT_FU23,
+		TAS2783_SDCA_CTL_FU_MUTE, 0), 0 },
+};
+
+static bool tas2783_readable_register(struct device *dev,
+	unsigned int reg)
+{
+	switch (reg) {
+	case 0x8000 ... 0x807F:	/* Page 0 */
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tas2783_volatile_register(struct device *dev,
+	unsigned int reg)
+{
+	switch (reg) {
+	/*
+	 * Only software reset register was volatiled.
+	 * Bit is self clearing.
+	 * 0b = Don't reset
+	 * 1b = reset
+	 */
+	case 0x8001:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config tasdevice_regmap = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.readable_reg = tas2783_readable_register,
+	.volatile_reg = tas2783_volatile_register,
+	.max_register = 0x44ffffff,
+	.reg_defaults = tas2783_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static const struct snd_kcontrol_new tas2783_snd_controls[] = {
+	SOC_SINGLE_RANGE_TLV("Digital Volume", TAS2783_DVC_LVL,
+		0, 0, 200, 1, dvc_tlv),
+	SOC_SINGLE_SX_TLV("Amp Gain Volume", TAS2783_AMP_LEVEL,
+		1, 0, 20, amp_vol_tlv),
+};
+
+static void tas2783_apply_calibv1(struct tasdevice_priv *tas_dev,
+	unsigned int *cali_data)
+{
+	struct regmap *map = tas_dev->regmap;
+	u8 *cali_start;
+	u16 offset;
+	int ret;
+
+	if (!tas_dev->sdw_peripheral) {
+		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
+			__func__);
+		return;
+	}
+
+	offset = tas_dev->sdw_peripheral->id.unique_id -
+		TAS2783_UNIQUE_ID_BASE;
+	if (offset >= TAS2783_MAX_DEV_NUM) {
+		dev_err(tas_dev->dev, "%s: offset(%u) is out of range.\n",
+			 __func__, offset);
+		return;
+	}
+
+	/*
+	 * The area saving tas2783 calibrated data is specified by its
+	 * unique_id offset. cali_start is the first address of current
+	 * tas2783's calibrated data.
+	 */
+	cali_start = (u8 *)(cali_data + offset * sizeof(tas2783_cali_reg));
+	for (int i = 0; i < ARRAY_SIZE(tas2783_cali_reg); i++) {
+		ret = regmap_bulk_write(map, tas2783_cali_reg[i],
+			&cali_start[4 * i], 4);
+		if (ret) {
+			dev_err(tas_dev->dev, "Cali failed %x:%d\n",
+				tas2783_cali_reg[i], ret);
+			break;
+		}
+	}
+}
+
+static void tas2783_apply_calibv2(struct tasdevice_priv *tas_dev,
+	unsigned int *cali_data)
+{
+	const unsigned int arr_size = ARRAY_SIZE(tas2783_cali_reg);
+	struct regmap *map = tas_dev->regmap;
+	unsigned int dev_sum = cali_data[1], i, j, k;
+	u8 *cali_start;
+	u16 dev_info;
+	int ret;
+
+	if (!tas_dev->sdw_peripheral) {
+		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
+			__func__);
+		return;
+	}
+
+	dev_info = tas_dev->sdw_peripheral->bus->link_id |
+		tas_dev->sdw_peripheral->id.unique_id << 16;
+
+	/*
+	 * The area saving tas2783 calibrated data is specified by its
+	 * unique_id offset. cali_start is the first address of current
+	 * tas2783's calibrated data.
+	 */
+	cali_start = (u8 *)&cali_data[3];
+	for (i = 0; i < dev_sum; i++) {
+		k = i * (arr_size + 1) + 3;
+		if (dev_info != cali_data[k]) {
+			for (j = 0; j < arr_size; j++) {
+				k = 4 * (k + 1 + j);
+				ret = regmap_bulk_write(map,
+					tas2783_cali_reg[j],
+					&cali_start[k], 4);
+				if (ret) {
+					dev_err(tas_dev->dev,
+						"Cali failed %x:%d\n",
+						tas2783_cali_reg[j], ret);
+					break;
+				}
+			}
+			break;
+		}
+	}
+}
+
+/*
+ * Load the calibration data, including speaker impedance, f0, etc.
+ * Calibration is done by the manufacturer in the factory. The calibration
+ * data are used by the algorithm for calculating the speaker temperature,
+ * speaker membrane excursion and f0 in real time during playback.
+ * The DSP will work with default data values if calibrated data are
+ * missing or are invalid.
+ * Layout of calibrated Data in UEFI(total 256 bytes):
+ * V2:
+ *	ChipID (2783, 4 bytes)
+ *	Device-Sum (4 bytes)
+ *	TimeStamp of Calibration (4 bytes)
+ *	for (i = 0; i < Device-Sum; i++) {
+ *		Device #i info () {
+ *			SDW link id (2bytes)
+ *			SDW unique_id (2bytes)
+ *		}
+ *		Calibrated Data of Device #i (20 bytes)
+ *	}
+ *	CRC (4 bytes)
+ *	Reserved (the rest)
+ * Or
+ * V1:
+ *	Calibrated Data of Dev 0(unique_id offset 0) (20 bytes)
+ *	Calibrated Data of Dev 1(unique_id offset 1) (20 bytes)
+ *	Calibrated Data of Dev 2(unique_id offset 2) (20 bytes)
+ *	Calibrated Data of Dev 3(unique_id offset 3) (20 bytes)
+ *	Calibrated Data of Dev 4(unique_id offset 4) (20 bytes)
+ *	Calibrated Data of Dev 5(unique_id offset 5) (20 bytes)
+ *	Calibrated Data of Dev 6(unique_id offset 6) (20 bytes)
+ *	Calibrated Data of Dev 7(unique_id offset 7) (20 bytes)
+ *	TimeStamp of Calibration (4 bytes)
+ *	CRC (4 bytes)
+ *	Reserved (88 bytes)
+ */
+static void tas2783_calibration(struct tasdevice_priv *tas_dev)
+{
+	efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
+			0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
+	static efi_char16_t efi_name[] = L"CALI_DATA";
+	struct calibration_data cali_data;
+	unsigned int *tmp_val;
+	unsigned int crc;
+	efi_status_t status;
+
+	cali_data.total_sz = 0;
+
+	status = efi.get_variable(efi_name, &efi_guid, NULL,
+		&cali_data.total_sz, NULL);
+	if (status == EFI_BUFFER_TOO_SMALL
+		&& cali_data.total_sz < TAS2783_MAX_CALIDATA_SIZE) {
+		status = efi.get_variable(efi_name, &efi_guid, NULL,
+			&cali_data.total_sz,
+			cali_data.data);
+		dev_dbg(tas_dev->dev, "%s: cali get %lx bytes result:%ld\n",
+			__func__, cali_data.total_sz, status);
+	}
+	if (status != 0) {
+		/* Failed got calibration data from EFI. */
+		dev_dbg(tas_dev->dev, "No calibration data in UEFI.");
+		return;
+	}
+
+	tmp_val = (unsigned int *)cali_data.data;
+
+	if (tmp_val[0] == 2783) {
+		/* Calibrated Data V2 */
+		unsigned int dev_sum = tmp_val[1];
+
+		if (dev_sum > TAS2783_MAX_DEV_NUM ||
+			dev_sum == 0) {
+			dev_dbg(tas_dev->dev, "No dev in calibrated data V2.");
+			return;
+		}
+		crc = crc32(~0, cali_data.data, 12 + dev_sum * 24) ^ ~0;
+		if (crc == tmp_val[3 + dev_sum * 6]) {
+			tas2783_apply_calibv2(tas_dev, tmp_val);
+			dev_dbg(tas_dev->dev, "V2: %ptTs", &tmp_val[40]);
+		} else {
+			dev_dbg(tas_dev->dev,
+				"V2: CRC 0x%08x not match 0x%08x\n",
+				crc, tmp_val[41]);
+		}
+	} else {
+		/* Calibrated Data V1 */
+		/* 8 devs * 20 bytes calibrated data/dev + 4 bytes Timestamp */
+		crc = crc32(~0, cali_data.data, 164) ^ ~0;
+		if (crc == tmp_val[41]) {
+			/* Date and time of when calibration was done. */
+			tas2783_apply_calibv1(tas_dev, tmp_val);
+			dev_dbg(tas_dev->dev, "V1: %ptTs", &tmp_val[40]);
+		} else {
+			dev_dbg(tas_dev->dev,
+				"V1: CRC 0x%08x not match 0x%08x\n",
+				crc, tmp_val[41]);
+		}
+	}
+}
+
+static void tasdevice_dspfw_ready(const struct firmware *fmw,
+	void *context)
+{
+	struct tasdevice_priv *tas_dev =
+		(struct tasdevice_priv *) context;
+	struct tas2783_firmware_node *p;
+	struct regmap *map = tas_dev->regmap;
+	unsigned char *buf = NULL;
+	int offset = 0, img_sz;
+	int ret;
+
+	if (!fmw || !fmw->data) {
+		dev_warn(tas_dev->dev,
+			"%s: failed to read %s: work in bypass-dsp mode.\n",
+			__func__, tas_dev->dspfw_binaryname);
+		return;
+	}
+	buf = (unsigned char *)fmw->data;
+
+	img_sz = get_unaligned_le32(&buf[offset]);
+	offset  += sizeof(img_sz);
+	if (img_sz != fmw->size) {
+		dev_warn(tas_dev->dev, "%s: size not matching, %d %u.",
+			__func__, (int)fmw->size, img_sz);
+		return;
+	}
+
+	while (offset < img_sz) {
+		p = (struct tas2783_firmware_node *)(buf + offset);
+		if (p->length > 1) {
+			ret = regmap_bulk_write(map, p->download_addr,
+			buf + offset + sizeof(unsigned int) * 5, p->length);
+		} else {
+			ret = regmap_write(map, p->download_addr,
+				*(buf + offset + sizeof(unsigned int) * 5));
+		}
+
+		if (ret != 0) {
+			dev_dbg(tas_dev->dev,
+				"%s: load FW fail: %d, work in bypass.\n",
+				__func__, ret);
+			return;
+		}
+		offset += sizeof(unsigned int) * 5 + p->length;
+	}
+
+	tas2783_calibration(tas_dev);
+}
+
+static const struct snd_soc_dapm_widget tasdevice_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("ASI", "ASI Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ASI OUT", "ASI Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("DMIC"),
+};
+
+static const struct snd_soc_dapm_route tasdevice_audio_map[] = {
+	{"OUT", NULL, "ASI"},
+	{"ASI OUT", NULL, "DMIC"},
+};
+
+static int tasdevice_set_sdw_stream(struct snd_soc_dai *dai,
+	void *sdw_stream, int direction)
+{
+	snd_soc_dai_dma_data_set(dai, direction, sdw_stream);
+
+	return 0;
+}
+
+static void tasdevice_sdw_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+}
+
+static int tasdevice_sdw_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tas_priv =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_config stream_config = {0};
+	struct sdw_port_config port_config = {0};
+	struct sdw_stream_runtime *sdw_stream;
+	int ret;
+
+	dev_dbg(dai->dev, "%s: dai_name %s", __func__, dai->name);
+	sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!sdw_stream)
+		return -EINVAL;
+
+	if (!tas_priv->sdw_peripheral)
+		return -EINVAL;
+
+	/* SoundWire specific configuration */
+	snd_sdw_params_to_config(substream, params,
+		&stream_config, &port_config);
+
+	/* port 1 for playback */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		port_config.num = 1;
+	else
+		port_config.num = 2;
+
+	ret = sdw_stream_add_slave(tas_priv->sdw_peripheral,
+		&stream_config, &port_config, 1, sdw_stream);
+	if (ret) {
+		dev_err(dai->dev, "%s: Unable to configure port\n", __func__);
+		return ret;
+	}
+
+	dev_dbg(dai->dev, "%s: format: %i rate: %i\n", __func__,
+		params_format(params), params_rate(params));
+
+	return 0;
+}
+
+static int tasdevice_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tas_priv =
+		snd_soc_component_get_drvdata(component);
+	struct sdw_stream_runtime *sdw_stream =
+		snd_soc_dai_get_dma_data(dai, substream);
+
+	if (!tas_priv->sdw_peripheral)
+		return -EINVAL;
+
+	sdw_stream_remove_slave(tas_priv->sdw_peripheral, sdw_stream);
+
+	return 0;
+}
+
+static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
+	int direction)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(component);
+	struct regmap *map = tas_dev->regmap;
+	int ret;
+
+	dev_dbg(tas_dev->dev, "%s: %d.\n", __func__, mute);
+
+	if (mute) {
+		if (direction == SNDRV_PCM_STREAM_CAPTURE) {
+			ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
+				TAS2783_REG_AEF_MASK,
+				TAS2783_REG_AEF_INACTIVE);
+			if (ret)
+				dev_err(tas_dev->dev,
+					"%s: Disable AEF failed.\n", __func__);
+		} else {
+			/* FU23 mute (0x40400108) */
+			ret = regmap_write(map,
+				SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
+				TAS2783_SDCA_ENT_FU23,
+				TAS2783_SDCA_CTL_FU_MUTE, 0), 1);
+			if (ret) {
+				dev_err(tas_dev->dev,
+					"%s: FU23 mute failed.\n", __func__);
+				goto out;
+			}
+			/*
+			 * Both playback and echo data will be shutdown in
+			 * playback stream.
+			 */
+			ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
+				TAS2783_REG_PWR_MODE_MASK |
+				TAS2783_REG_AEF_MASK,
+				TAS2783_REG_PWR_MODE_ACTIVE |
+				TAS2783_REG_PWR_MODE_SW_PWD);
+			if (ret) {
+				dev_err(tas_dev->dev,
+					"%s: PWR&AEF shutdown failed.\n",
+					__func__);
+				goto out;
+			}
+			tas_dev->pstream = false;
+		}
+	} else {
+		/* FU23 Unmute, 0x40400108. */
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			ret = regmap_write(map,
+				SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
+				TAS2783_SDCA_ENT_FU23,
+				TAS2783_SDCA_CTL_FU_MUTE, 0), 0);
+			if (ret) {
+				dev_err(tas_dev->dev,
+					"%s: FU23 Unmute failed.\n", __func__);
+				goto out;
+			}
+			ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
+				TAS2783_REG_PWR_MODE_MASK,
+				TAS2783_REG_PWR_MODE_ACTIVE);
+			if (ret) {
+				dev_err(tas_dev->dev,
+					"%s: PWR Unmute failed.\n", __func__);
+				goto out;
+			}
+			tas_dev->pstream = true;
+		} else {
+			/* Capture stream is the echo ref data for voice.
+			 * Without playback, it can't be active.
+			 */
+			if (tas_dev->pstream == true) {
+				ret = regmap_update_bits(map,
+					TAS2873_REG_PWR_CTRL,
+					TAS2783_REG_AEF_MASK,
+					TAS2783_REG_AEF_ACTIVE);
+				if (ret) {
+					dev_err(tas_dev->dev,
+						"%s: AEF enable failed.\n",
+						__func__);
+					goto out;
+				}
+			} else {
+				dev_err(tas_dev->dev,
+					"%s: No playback, no AEF!", __func__);
+				ret = -EINVAL;
+			}
+		}
+	}
+out:
+	if (ret)
+		dev_err(tas_dev->dev, "Mute or unmute %d failed %d.\n",
+			mute, ret);
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops tasdevice_dai_ops = {
+	.mute_stream	= tasdevice_mute,
+	.hw_params	= tasdevice_sdw_hw_params,
+	.hw_free	= tasdevice_sdw_pcm_hw_free,
+	.set_stream	= tasdevice_set_sdw_stream,
+	.shutdown	= tasdevice_sdw_shutdown,
+};
+
+static struct snd_soc_dai_driver tasdevice_dai_driver[] = {
+	{
+		.name = "tas2783-codec",
+		.id = 0,
+		.playback = {
+			.stream_name	= "Playback",
+			.channels_min	= 1,
+			.channels_max	= 4,
+			.rates		= TAS2783_DEVICE_RATES,
+			.formats	= TAS2783_DEVICE_FORMATS,
+		},
+		.capture = {
+			.stream_name	= "Capture",
+			.channels_min	= 1,
+			.channels_max	= 4,
+			.rates		= TAS2783_DEVICE_RATES,
+			.formats	= TAS2783_DEVICE_FORMATS,
+		},
+		.ops = &tasdevice_dai_ops,
+		.symmetric_rate = 1,
+	},
+};
+
+static int tasdevice_comp_probe(struct snd_soc_component *comp)
+{
+	struct tasdevice_priv *tas_dev = snd_soc_component_get_drvdata(comp);
+	acpi_handle handle = ACPI_HANDLE(tas_dev->dev);
+	const struct firmware *fw_entry = NULL;
+	const char *sub = NULL;
+	int ret;
+
+	if (handle) {
+		sub = acpi_get_subsystem_id(handle);
+		if (IS_ERR(sub))
+			sub = NULL;
+	}
+
+	tas_dev->component = comp;
+
+	/*
+	 * Each tas2783 in the system has its own dspfw.
+	 */
+	if (comp->name_prefix) {
+		/*
+		 * name_prefix.bin stores the dsp firmware including speaker
+		 * protection algorithm, audio acoustic algorithm, speaker
+		 * characters and algorithm params, it must be copied into
+		 * firmware folder.
+		 */
+		scnprintf(tas_dev->dspfw_binaryname,
+			TAS2783_DSPFW_FILENAME_LEN, "%s-tas2783.bin",
+			comp->name_prefix);
+	} else {
+		/* Compatible with the previous naming rule */
+		if (sub) {
+			/*
+			 * subsys_id-link_id[0,1,...,N]-unique_id
+			 * [0x8,...,0xf].bin stores the dsp firmware including
+			 * speaker protection algorithm, audio acoustic
+			 * algorithm, speaker characters and algorithm params,
+			 * it must be copied into firmware folder.
+			 */
+			scnprintf(tas_dev->dspfw_binaryname,
+				TAS2783_DSPFW_FILENAME_LEN,
+				"%s-%d-0x%x.bin", sub,
+				tas_dev->sdw_peripheral->bus->link_id,
+				tas_dev->sdw_peripheral->id.unique_id);
+		} else {
+			/*
+			 * tas2783-link_id[0,1,...,N]-unique_id
+			 * [0x8,...,0xf].bin stores the dsp firmware including
+			 * speaker protection algorithm, audio acoustic
+			 * algorithm, speaker characters and algorithm params,
+			 * it must be copied into firmware folder.
+			 */
+			scnprintf(tas_dev->dspfw_binaryname,
+				TAS2783_DSPFW_FILENAME_LEN,
+				"tas2783-%d-0x%x.bin",
+				tas_dev->sdw_peripheral->bus->link_id,
+				tas_dev->sdw_peripheral->id.unique_id);
+		}
+	}
+
+	ret = request_firmware(&fw_entry, tas_dev->dspfw_binaryname,
+		tas_dev->dev);
+	if (ret) {
+		dev_err(tas_dev->dev,
+			"%s: request_firmware %x open status: %d.\n", __func__,
+			tas_dev->sdw_peripheral->id.unique_id, ret);
+		goto out;
+	}
+
+	tasdevice_dspfw_ready(fw_entry, tas_dev);
+
+out:
+	if (fw_entry)
+		release_firmware(fw_entry);
+	return 0;
+}
+
+static const struct snd_soc_component_driver
+	soc_codec_driver_tasdevice = {
+	.probe		= tasdevice_comp_probe,
+	.controls	= tas2783_snd_controls,
+	.num_controls	= ARRAY_SIZE(tas2783_snd_controls),
+	.dapm_widgets	= tasdevice_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tasdevice_dapm_widgets),
+	.dapm_routes	= tasdevice_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(tasdevice_audio_map),
+	.idle_bias_on	= 1,
+	.endianness	= 1,
+};
+
+static int tasdevice_init(struct tasdevice_priv *tas_dev)
+{
+	int ret;
+
+	dev_set_drvdata(tas_dev->dev, tas_dev);
+
+	ret = devm_snd_soc_register_component(tas_dev->dev,
+		&soc_codec_driver_tasdevice,
+		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
+	if (ret) {
+		dev_err(tas_dev->dev, "%s: codec register error:%d.\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* set autosuspend parameters */
+	pm_runtime_set_autosuspend_delay(tas_dev->dev, 3000);
+	pm_runtime_use_autosuspend(tas_dev->dev);
+
+	/* make sure the device does not suspend immediately */
+	pm_runtime_mark_last_busy(tas_dev->dev);
+	pm_runtime_enable(tas_dev->dev);
+
+	return 0;
+}
+
+static int tasdevice_read_prop(struct sdw_slave *slave)
+{
+	struct sdw_slave_prop *prop = &slave->prop;
+	struct sdw_dpn_prop *dpn;
+	unsigned long addr;
+	int nval, i, j;
+	u32 bit;
+
+	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
+	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
+
+	prop->paging_support = true;
+
+	/* first we need to allocate memory for set bits in port lists */
+	prop->source_ports = BIT(2); /* BITMAP: 00000100 */
+	prop->sink_ports = BIT(1); /* BITMAP:  00000010 */
+
+	nval = hweight32(prop->source_ports);
+	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
+		sizeof(*prop->src_dpn_prop), GFP_KERNEL);
+	if (!prop->src_dpn_prop)
+		return -ENOMEM;
+
+	i = 0;
+	dpn = prop->src_dpn_prop;
+	addr = prop->source_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[i].num = bit;
+		dpn[i].type = SDW_DPN_FULL;
+		dpn[i].simple_ch_prep_sm = true;
+		dpn[i].ch_prep_timeout = 10;
+		i++;
+	}
+
+	/* do this again for sink now */
+	nval = hweight32(prop->sink_ports);
+	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
+		sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
+	if (!prop->sink_dpn_prop)
+		return -ENOMEM;
+
+	j = 0;
+	dpn = prop->sink_dpn_prop;
+	addr = prop->sink_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[j].num = bit;
+		dpn[j].type = SDW_DPN_FULL;
+		dpn[j].simple_ch_prep_sm = true;
+		dpn[j].ch_prep_timeout = 10;
+		j++;
+	}
+
+	/* set the timeout values */
+	prop->clk_stop_timeout = 20;
+
+	return 0;
+}
+
+static int tasdevice_io_init(struct device *dev,
+	struct sdw_slave *slave)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	int ret;
+
+	regcache_cache_only(tas_priv->regmap, false);
+
+	if (tas_priv->first_hw_init) {
+		regcache_cache_bypass(tas_priv->regmap, true);
+	} else {
+		/*
+		 * PM runtime is only enabled when a Slave reports as Attached
+		 * Update count of parent 'active' children.
+		 */
+		pm_runtime_set_active(&slave->dev);
+	}
+
+	/* sw reset */
+	ret = regmap_write(tas_priv->regmap, TAS2873_REG_SWRESET,
+		TAS2873_REG_SWRESET_RESET);
+	if (ret) {
+		dev_err(tas_priv->dev, "Reset failed.\n");
+		goto out;
+	}
+
+	if (tas_priv->first_hw_init) {
+		regcache_cache_bypass(tas_priv->regmap, false);
+		regcache_mark_dirty(tas_priv->regmap);
+	}
+
+	tas_priv->first_hw_init = true;
+	tas_priv->hw_init = true;
+
+out:
+	return ret;
+}
+
+static int tasdevice_update_status(struct sdw_slave *slave,
+	enum sdw_slave_status status)
+{
+	struct  tasdevice_priv *tas_priv = dev_get_drvdata(&slave->dev);
+
+	/* Update the status */
+	tas_priv->status = status;
+
+	if (status == SDW_SLAVE_UNATTACHED)
+		tas_priv->hw_init = false;
+	/*
+	 * Perform initialization only if slave status
+	 * is present and hw_init flag is false
+	 */
+	if (tas_priv->hw_init || tas_priv->status != SDW_SLAVE_ATTACHED)
+		return 0;
+
+	/* perform I/O transfers required for Slave initialization */
+	return tasdevice_io_init(&slave->dev, slave);
+}
+
+/*
+ * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
+ * port_prep are not defined for now
+ */
+static const struct sdw_slave_ops tasdevice_sdw_ops = {
+	.read_prop	= tasdevice_read_prop,
+	.update_status	= tasdevice_update_status,
+};
+
+static int tasdevice_sdw_probe(struct sdw_slave *peripheral,
+	const struct sdw_device_id *id)
+{
+	struct device *dev = &peripheral->dev;
+	struct tasdevice_priv *tas_dev;
+
+	tas_dev = devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
+	if (!tas_dev)
+		return -ENOMEM;
+
+	tas_dev->dev = dev;
+	tas_dev->chip_id = id->driver_data;
+	tas_dev->sdw_peripheral = peripheral;
+	/*
+	 * Mark hw_init to false
+	 * HW init will be performed when device reports present
+	 */
+	tas_dev->hw_init = false;
+	tas_dev->first_hw_init = false;
+
+	dev_set_drvdata(dev, tas_dev);
+
+	tas_dev->regmap = devm_regmap_init_sdw(peripheral, &tasdevice_regmap);
+	if (IS_ERR(tas_dev->regmap))
+		return dev_err_probe(dev, PTR_ERR(tas_dev->regmap),
+			"Failed devm_regmap_init_sdw.");
+
+	return tasdevice_init(tas_dev);
+}
+
+static int tasdevice_sdw_remove(struct sdw_slave *peripheral)
+{
+	struct tasdevice_priv *tas_dev = dev_get_drvdata(&peripheral->dev);
+
+	if (tas_dev->first_hw_init)
+		pm_runtime_disable(tas_dev->dev);
+
+	return 0;
+}
+
+static const struct sdw_device_id tasdevice_sdw_id[] = {
+	SDW_SLAVE_ENTRY(0x0102, 0x0000, 0),
+	{}
+};
+MODULE_DEVICE_TABLE(sdw, tasdevice_sdw_id);
+
+static int __maybe_unused tas2783_sdca_dev_suspend(struct device *dev)
+{
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+
+	if (!tas_priv->hw_init)
+		return 0;
+
+	regcache_cache_only(tas_priv->regmap, true);
+
+	return 0;
+}
+
+#define TAS2783_PROBE_TIMEOUT_MS 5000
+
+static int __maybe_unused tas2783_sdca_dev_resume(struct device *dev)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	struct tasdevice_priv *tas_priv = dev_get_drvdata(dev);
+	unsigned long time;
+
+	if (!tas_priv->first_hw_init)
+		return 0;
+
+	if (!slave->unattach_request)
+		goto regmap_sync;
+
+	time = wait_for_completion_timeout(&slave->initialization_complete,
+		msecs_to_jiffies(TAS2783_PROBE_TIMEOUT_MS));
+	if (!time) {
+		dev_err(&slave->dev, "Init not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
+		return -ETIMEDOUT;
+	}
+
+regmap_sync:
+	slave->unattach_request = 0;
+	regcache_cache_only(tas_priv->regmap, false);
+	regcache_sync(tas_priv->regmap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tas2783_sdca_pm = {
+	SYSTEM_SLEEP_PM_OPS(tas2783_sdca_dev_suspend,
+		tas2783_sdca_dev_resume)
+	RUNTIME_PM_OPS(tas2783_sdca_dev_suspend,
+		tas2783_sdca_dev_resume, NULL)
+};
+
+static struct sdw_driver tasdevice_sdw_driver = {
+	.driver = {
+		.name = "slave-tas2783",
+		.pm = &tas2783_sdca_pm,
+	},
+	.probe = tasdevice_sdw_probe,
+	.remove = tasdevice_sdw_remove,
+	.ops = &tasdevice_sdw_ops,
+	.id_table = tasdevice_sdw_id,
+};
+
+module_sdw_driver(tasdevice_sdw_driver);
+
+MODULE_AUTHOR("Baojun Xu <baojun.xu@ti.com>");
+MODULE_AUTHOR("Shenghao Ding <shenghao-ding@ti.com>");
+MODULE_DESCRIPTION("ASoC TAS2783 SoundWire Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
new file mode 100644
index 000000000000..631776dcec4c
--- /dev/null
+++ b/sound/soc/codecs/tas2783.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ALSA SoC Texas Instruments TAS2783 Audio Smart Amplifier
+ *
+ * Copyright (C) 2023 - 2024 Texas Instruments Incorporated
+ * https://www.ti.com
+ *
+ * Author: Baojun Xu <baojun.xu@ti.com>
+ *	Shenghao Ding <shenghao-ding@ti.com>
+ */
+
+#ifndef __TAS2783_H__
+#define __TAS2783_H__
+
+/* Unique id start */
+#define TAS2783_UNIQUE_ID_BASE		0x08
+#define TAS2783_MAX_DEV_NUM		8
+
+#define TAS2783_DEVICE_RATES		(SNDRV_PCM_RATE_44100 | \
+					SNDRV_PCM_RATE_48000 | \
+					SNDRV_PCM_RATE_96000 | \
+					SNDRV_PCM_RATE_88200)
+
+#define TAS2783_DEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
+					SNDRV_PCM_FMTBIT_S24_LE | \
+					SNDRV_PCM_FMTBIT_S32_LE)
+
+/* BOOK, PAGE Control Register */
+#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 + \
+					(page * 128) + reg)
+
+/*Software Reset */
+#define TAS2873_REG_SWRESET		TASDEVICE_REG(0x0, 0x00, 0x01)
+#define TAS2873_REG_SWRESET_MASK	BIT(0)
+#define TAS2873_REG_SWRESET_RESET	BIT(0)
+
+#define TAS2873_REG_PWR_CTRL		TASDEVICE_REG(0x0, 0x00, 0x02)
+#define TAS2783_REG_AEF_MASK		GENMASK(4, 3)
+#define TAS2783_REG_AEF_ACTIVE		0
+#define TAS2783_REG_AEF_INACTIVE	GENMASK(4, 3)
+#define TAS2783_REG_PWR_MODE_MASK	GENMASK(2, 0)
+#define TAS2783_REG_PWR_MODE_ACTIVE	0
+#define TAS2783_REG_PWR_MODE_SW_PWD	BIT(1)
+
+#define TAS2783_REG_TDM_RX_CFG		TASDEVICE_REG(0x0, 0x00, 0x0a)
+
+/* Volume control */
+#define TAS2783_DVC_LVL			TASDEVICE_REG(0x0, 0x00, 0x1a)
+#define TAS2783_AMP_LEVEL		TASDEVICE_REG(0x0, 0x00, 0x03)
+#define TAS2783_AMP_LEVEL_MASK		GENMASK(5, 1)
+
+/* Calibration data */
+#define TAS2783_CALIBRATION_RE		TASDEVICE_REG(0x0, 0x17, 0x74)
+#define TAS2783_CALIBRATION_RE_LOW	TASDEVICE_REG(0x0, 0x18, 0x14)
+#define TAS2783_CALIBRATION_INV_RE	TASDEVICE_REG(0x0, 0x18, 0x0c)
+#define TAS2783_CALIBRATION_POW		TASDEVICE_REG(0x0, 0x13, 0x70)
+#define TAS2783_CALIBRATION_TLIMIT	TASDEVICE_REG(0x0, 0x18, 0x7c)
+
+/* TAS2783 SDCA Control - function number */
+#define TAS2783_FUNC_TYPE_SMART_AMP	0x01
+
+/* TAS2783 SDCA entity */
+#define TAS2783_SDCA_ENT_FU21		0x01
+#define TAS2783_SDCA_ENT_FU23		0x02
+
+/* TAS2783 SDCA control */
+#define TAS2783_SDCA_CTL_REQ_POWER_STATE	0x01
+#define TAS2783_SDCA_CTL_FU_MUTE	0x01
+#define TAS2783_SDCA_CTL_FU_VOLUME	0x02
+#define TAS2783_SDCA_CTL_UDMPU_CLUSTER	0x10
+
+#define TAS2783_DEVICE_CHANNEL_LEFT	1
+#define TAS2783_DEVICE_CHANNEL_RIGHT	2
+#define TAS2783_DSPFW_FILENAME_LEN	64
+
+#define TAS2783_MAX_CALIDATA_SIZE	256
+
+struct tas2783_firmware_node {
+	unsigned int vendor_id;
+	unsigned int file_id;
+	unsigned int version_id;
+	unsigned int length;
+	unsigned int download_addr;
+};
+
+struct calibration_data {
+	unsigned long total_sz;
+	unsigned char data[TAS2783_MAX_CALIDATA_SIZE];
+};
+
+struct tasdevice_priv {
+	struct snd_soc_component *component;
+	struct sdw_slave *sdw_peripheral;
+	enum sdw_slave_status status;
+	struct sdw_bus_params params;
+	struct regmap *regmap;
+	struct device *dev;
+	unsigned char dspfw_binaryname[TAS2783_DSPFW_FILENAME_LEN];
+	unsigned char dev_name[32];
+	unsigned int chip_id;
+	bool pstream;
+	bool hw_init;
+	bool first_hw_init;
+};
+
+#endif /*__TAS2783_H__ */
-- 
2.34.1


