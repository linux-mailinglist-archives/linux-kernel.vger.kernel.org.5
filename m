Return-Path: <linux-kernel+bounces-107621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B787FF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1601C22275
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE51581AB0;
	Tue, 19 Mar 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="llZpaTi6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2656480612
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856770; cv=none; b=awekarKHR7DZ8GMf11lKp0Ips0hyJOmRUoi3y4wMpWQX1PoVBzQ3KsAWJ7RWCQrFx0v9gHSgPerMMfbRPfbNuEByUIGAycJYiZgxGHaO6/r/jZBX2713f8GtrqfgkawEfzOwl8j22xEJKzjI6lMRQuEKcBA8IHGF6b9vCbFceCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856770; c=relaxed/simple;
	bh=gmf93xJEWZuqK5d3uzU7LJFHDtZmb2ueBOtD26npYsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lJejx6HS5wd8JAcqOUqMW062ILlnXyG32Rhmt16h/STkmlkF2tUQ5Alt70paWiGoR+kYbQZykg5MQDicoJVZCOxmqxpdAXxFCoW43t8rT4WLDOKfUGpi5dK+HyAm+/csT6xCQ6T0GatxZMLPbYKP0HqESyuCRUQH2+fBs4gVqFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=llZpaTi6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JDwMix079460;
	Tue, 19 Mar 2024 08:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710856702;
	bh=bi8VWsDKVzI6RrervZExnkTnCkwPJghy7tMwbHNuH/s=;
	h=From:To:CC:Subject:Date;
	b=llZpaTi6bRJ42G69X0g+6c4eG47v8zPfYiUoY54TMdqgQ3y1azldYSeXNxgnjfL5o
	 /BPJjj9HW3RNY2ntpcoUCW4p7HWtdJcLjnrDm7Va1CtChwR202EpS0TMJDpA9nJr5C
	 V3HyK9v0K/HBsdHl5io85EiLLlMtiTWZHrCi3qMI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JDwM73013819
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 08:58:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 08:58:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 08:58:21 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JDwEI7040961;
	Tue, 19 Mar 2024 08:58:15 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <mengdong.lin@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kevin-lu@ti.com>, <tiwai@suse.de>,
        <baojun.xu@ti.com>, <soyer@irl.hu>, <Baojun.Xu@fpt.com>,
        <navada@ti.com>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v11] ASoc: tas2783: Add tas2783 codec driver
Date: Tue, 19 Mar 2024 21:58:10 +0800
Message-ID: <20240319135811.186-1-shenghao-ding@ti.com>
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
 - use __func__ in the dev_err message in two identical logs
   intas2783_apply_calibv1/v2.
 - In tas2783_apply_calibv2, the very least move initializations to a
   different line.
 - No need for separate j variable, reuse i in tasdevice_read_prop.
 - remove unused "struct sdw_bus_params params", unsigned char dev_name[32]
   pstream, and chip_id
 - define dspfw_binaryname as a local variable in tasdevice_comp_probe.
 - reduce a lot of indentation in tasdevice_mute and spilte tasdevice_mute
   into tasdevice_enable_echo_ref and tasdevice_playback
 - remove tas2783_reg_defaults
 - use REGCACHE_MAPLE instead of REGCACHE_RBTREE
 - define fw_node_sz to store the node size
---
 sound/soc/codecs/Kconfig       |  16 +
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/tas2783-sdw.c | 893 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/tas2783.h     | 107 ++++
 4 files changed, 1018 insertions(+)
 create mode 100644 sound/soc/codecs/tas2783-sdw.c
 create mode 100644 sound/soc/codecs/tas2783.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f78ea2f86fa6..939384837d5e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -248,6 +248,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_TAS2781_COMLIB
 	imply SND_SOC_TAS2781_FMWLIB
 	imply SND_SOC_TAS2781_I2C
+	imply SND_SOC_TAS2783
 	imply SND_SOC_TAS5086
 	imply SND_SOC_TAS571X
 	imply SND_SOC_TAS5720
@@ -1880,6 +1881,21 @@ config SND_SOC_TAS2781_I2C
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
index 7c075539dc47..6f27f810affc 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -287,6 +287,7 @@ snd-soc-tas2770-objs := tas2770.o
 snd-soc-tas2781-comlib-objs := tas2781-comlib.o
 snd-soc-tas2781-fmwlib-objs := tas2781-fmwlib.o
 snd-soc-tas2781-i2c-objs := tas2781-i2c.o
+snd-soc-tas2783-objs := tas2783-sdw.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tfa989x-objs := tfa989x.o
 snd-soc-tlv320adc3xxx-objs := tlv320adc3xxx.o
@@ -672,6 +673,7 @@ obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
 obj-$(CONFIG_SND_SOC_TAS2781_COMLIB)	+= snd-soc-tas2781-comlib.o
 obj-$(CONFIG_SND_SOC_TAS2781_FMWLIB)	+= snd-soc-tas2781-fmwlib.o
 obj-$(CONFIG_SND_SOC_TAS2781_I2C)	+= snd-soc-tas2781-i2c.o
+obj-$(CONFIG_SND_SOC_TAS2783)	+= snd-soc-tas2783.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
new file mode 100644
index 000000000000..2844cc5189dc
--- /dev/null
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -0,0 +1,893 @@
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
+struct calibdatav2_info {
+	unsigned int number_of_devices;
+	unsigned int crc32_indx;
+	unsigned int byt_sz;
+	unsigned int *cali_data;
+};
+
+static const unsigned int tas2783_cali_reg[] = {
+	TAS2783_CALIBRATION_RE,		/* Resistance */
+	TAS2783_CALIBRATION_RE_LOW,	/* Low limitation of RE */
+	TAS2783_CALIBRATION_INV_RE,	/* Reciprocal of RE */
+	TAS2783_CALIBRATION_POW,	/* RMS Power */
+	TAS2783_CALIBRATION_TLIMIT	/* Temperature limitation */
+};
+
+static bool tas2783_readable_register(struct device *dev,
+	unsigned int reg)
+{
+	switch (reg) {
+	/* Page 0 */
+	case 0x8000 ... 0x807F:
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
+	.cache_type = REGCACHE_MAPLE,
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
+/*
+ * Load the calibration data, including speaker impedance, f0, etc.
+ * Calibration is done by the manufacturer in the factory. The calibration
+ * data are used by the algorithm for calculating the speaker temperature,
+ * speaker membrane excursion and f0 in real time during playback.
+ * The DSP will work with default data values if calibrated data are
+ * missing or are invalid.
+ * Layout of calibrated Data V1 in UEFI(total 256 bytes):
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
+			dev_err(tas_dev->dev, "%s: Cali failed %x:%d\n",
+				__func__, tas2783_cali_reg[i], ret);
+			break;
+		}
+	}
+}
+
+/*
+ * New features were added in calibrated Data V2:
+ *	1. Added some the fields to store the link_id and uniqie_id for
+ *	multi-link solutions
+ *	2. Support flexible number of devices instead of fixed one in V1.
+ * Layout of calibrated data V2 in UEFI(total 256 bytes):
+ *	ChipID (2783, 4 bytes)
+ *	Device-Sum (4 bytes)
+ *	TimeStamp of Calibration (4 bytes)
+ *	for (i = 0; i < Device-Sum; i++) {
+ *		Device #i index_info () {
+ *			SDW link id (2bytes)
+ *			SDW unique_id (2bytes)
+ *		}
+ *		Calibrated Data of Device #i (20 bytes)
+ *	}
+ *	CRC (4 bytes)
+ *	Reserved (the rest)
+ */
+static void tas2783_apply_calibv2(struct tasdevice_priv *tas_dev,
+	const struct calibdatav2_info *p)
+{
+	const unsigned int arr_size = ARRAY_SIZE(tas2783_cali_reg);
+	struct regmap *map = tas_dev->regmap;
+	unsigned int i, j, k;
+	u8 *cali_start;
+	u16 dev_indx;
+	int ret;
+
+	if (!tas_dev->sdw_peripheral) {
+		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
+			__func__);
+		return;
+	}
+
+	dev_indx = tas_dev->sdw_peripheral->bus->link_id |
+		tas_dev->sdw_peripheral->id.unique_id << 16;
+
+	for (i = 0; i < p->number_of_devices; i++) {
+		k = i * (arr_size + 1);
+
+		if (dev_indx != p->cali_data[k])
+			continue;
+
+		/* skip 4 byte dev-indx */
+		cali_start = (u8 *)&p->cali_data[k + 1];
+
+		for (j = 0; j < arr_size; j++) {
+			k = 4 * j;
+			ret = regmap_bulk_write(map, tas2783_cali_reg[j],
+				&cali_start[k], 4);
+			if (ret) {
+				dev_err(tas_dev->dev,
+					"%s: Cali failed %x:%d\n", __func__,
+					tas2783_cali_reg[j], ret);
+				break;
+			}
+		}
+		return;
+	}
+}
+
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
+	/* Check Calibrated Data V1 */
+	crc = crc32(~0, cali_data.data, TAS2783_CALIDATAV1_BYTE_SIZE) ^ ~0;
+	if (crc == tmp_val[TAS2783_CALIDATAV1_CRC32_INDX]) {
+		/* Date and time of when calibration was done. */
+		tas2783_apply_calibv1(tas_dev, tmp_val);
+		dev_dbg(tas_dev->dev, "V1: %ptTs",
+			&tmp_val[TAS2783_CALIDATAV1_TIMESTAMP_INDX]);
+		return;
+	}
+
+	/* Check Calibrated Data V2 */
+	if (tmp_val[0] == 2783) {
+		const struct calibdatav2_info calib_info = {
+			.number_of_devices = tmp_val[1],
+			.crc32_indx = 3 + tmp_val[1] * 6,
+			.byt_sz = 12 + tmp_val[1] * 24,
+			.cali_data = &tmp_val[3]
+		};
+
+		if (calib_info.number_of_devices > TAS2783_MAX_DEV_NUM ||
+			calib_info.number_of_devices == 0) {
+			dev_dbg(tas_dev->dev, "No dev in calibrated data V2.");
+			return;
+		}
+		crc = crc32(~0, cali_data.data, calib_info.byt_sz)
+			^ ~0;
+		if (crc == tmp_val[calib_info.crc32_indx]) {
+			tas2783_apply_calibv2(tas_dev, &calib_info);
+			dev_dbg(tas_dev->dev, "V2: %ptTs",
+				&tmp_val[TAS2783_CALIDATAV2_TIMESTAMP_INDX]);
+		} else {
+			dev_dbg(tas_dev->dev,
+				"V2: CRC 0x%08x not match 0x%08x\n",
+				crc, tmp_val[calib_info.crc32_indx]);
+		}
+	} else {
+		dev_err(tas_dev->dev, "Non-2783 chip\n");
+	}
+}
+
+static void tasdevice_dspfw_ready(const struct firmware *fmw,
+	void *context)
+{
+	struct tasdevice_priv *tas_dev = (struct tasdevice_priv *) context;
+	struct regmap *map = tas_dev->regmap;
+	struct tas2783_firmware_node *p;
+	unsigned char *buf;
+	int fw_node_sz = sizeof(struct tas2783_firmware_node);
+	int img_sz, ret;
+	int offset = 0;
+
+	if (!fmw || !fmw->data) {
+		dev_warn(tas_dev->dev,
+			"%s: failed to read fw, work in bypass-dsp mode.\n",
+			__func__);
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
+		if (p->length > 1)
+			ret = regmap_bulk_write(map, p->download_addr,
+				buf + offset + fw_node_sz, p->length);
+		else
+			ret = regmap_write(map, p->download_addr,
+				*(buf + offset + fw_node_sz));
+
+		if (ret != 0) {
+			dev_dbg(tas_dev->dev,
+				"%s: load FW fail: %d, work in bypass.\n",
+				__func__, ret);
+			return;
+		}
+		offset += fw_node_sz + p->length;
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
+/* Capture stream is the echo ref data for voice mode.*/
+static int tasdevice_enable_echo_ref(struct tasdevice_priv *tas_dev,
+	int mute)
+{
+	struct regmap *map = tas_dev->regmap;
+	unsigned int val;
+	int ret;
+
+	if (mute)
+		val = TAS2783_REG_AEF_INACTIVE;
+	else
+		val = TAS2783_REG_AEF_ACTIVE;
+
+	ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
+		TAS2783_REG_AEF_MASK, TAS2783_REG_AEF_INACTIVE);
+	if (ret)
+		dev_err(tas_dev->dev, "%s: Disable AEF failed.\n", __func__);
+
+	return ret;
+}
+
+static int tasdevice_playback(struct tasdevice_priv *tas_dev, int mute)
+{
+	struct regmap *map = tas_dev->regmap;
+	int ret;
+
+	if (mute) {
+		/* FU23 mute (0x40400108) */
+		ret = regmap_write(map,
+			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
+			TAS2783_SDCA_ENT_FU23,
+			TAS2783_SDCA_CTL_FU_MUTE, 0), 1);
+		if (ret) {
+			dev_err(tas_dev->dev, "%s: FU23 mute failed.\n",
+				__func__);
+			goto out;
+		}
+
+		ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
+			TAS2783_REG_PWR_MODE_MASK |
+			TAS2783_REG_AEF_MASK,
+			TAS2783_REG_PWR_MODE_ACTIVE |
+			TAS2783_REG_PWR_MODE_SW_PWD);
+		if (ret) {
+			dev_err(tas_dev->dev, "%s: shutdown failed.\n",
+				__func__);
+		}
+	} else {
+		/* FU23 Unmute, 0x40400108. */
+		ret = regmap_write(map,
+			SDW_SDCA_CTL(TAS2783_FUNC_TYPE_SMART_AMP,
+			TAS2783_SDCA_ENT_FU23,
+			TAS2783_SDCA_CTL_FU_MUTE, 0), 0);
+		if (ret) {
+			dev_err(tas_dev->dev,
+				"%s: FU23 Unmute failed.\n", __func__);
+			goto out;
+		}
+		ret = regmap_update_bits(map, TAS2873_REG_PWR_CTRL,
+			TAS2783_REG_PWR_MODE_MASK,
+			TAS2783_REG_PWR_MODE_ACTIVE);
+		if (ret) {
+			dev_err(tas_dev->dev,
+				"%s: PWR Unmute failed.\n", __func__);
+		}
+	}
+out:
+	return ret;
+}
+
+static int tasdevice_mute(struct snd_soc_dai *dai, int mute,
+	int direction)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tasdevice_priv *tas_dev =
+		snd_soc_component_get_drvdata(component);
+
+	int ret;
+
+	dev_dbg(tas_dev->dev, "%s: %d.\n", __func__, mute);
+
+	if (direction == SNDRV_PCM_STREAM_CAPTURE)
+		ret = tasdevice_enable_echo_ref(tas_dev, mute);
+	else
+		ret = tasdevice_playback(tas_dev, mute);
+
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
+	unsigned char dspfw_binaryname[TAS2783_DSPFW_FILENAME_LEN];
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
+		scnprintf(dspfw_binaryname, TAS2783_DSPFW_FILENAME_LEN,
+			"%s-tas2783.bin", comp->name_prefix);
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
+			scnprintf(dspfw_binaryname, TAS2783_DSPFW_FILENAME_LEN,
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
+			scnprintf(dspfw_binaryname, TAS2783_DSPFW_FILENAME_LEN,
+				"tas2783-%d-0x%x.bin",
+				tas_dev->sdw_peripheral->bus->link_id,
+				tas_dev->sdw_peripheral->id.unique_id);
+		}
+	}
+
+	ret = request_firmware(&fw_entry, dspfw_binaryname, tas_dev->dev);
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
+		&soc_codec_driver_tasdevice, tasdevice_dai_driver,
+		ARRAY_SIZE(tasdevice_dai_driver));
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
+	int nval, i;
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
+	i = 0;
+	dpn = prop->sink_dpn_prop;
+	addr = prop->sink_ports;
+	for_each_set_bit(bit, &addr, 32) {
+		dpn[i].num = bit;
+		dpn[i].type = SDW_DPN_FULL;
+		dpn[i].simple_ch_prep_sm = true;
+		dpn[i].ch_prep_timeout = 10;
+		i++;
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
+	if (status == SDW_SLAVE_UNATTACHED)
+		tas_priv->hw_init = false;
+	/*
+	 * Perform initialization only if slave status
+	 * is present and hw_init flag is false
+	 */
+	if (tas_priv->hw_init || status != SDW_SLAVE_ATTACHED)
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
index 000000000000..de72e07602bc
--- /dev/null
+++ b/sound/soc/codecs/tas2783.h
@@ -0,0 +1,107 @@
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
+#define TAS2783_UNIQUE_ID_BASE			0x08
+#define TAS2783_MAX_DEV_NUM			8
+
+#define TAS2783_DEVICE_RATES		(SNDRV_PCM_RATE_44100 | \
+						SNDRV_PCM_RATE_48000 | \
+						SNDRV_PCM_RATE_96000 | \
+						SNDRV_PCM_RATE_88200)
+
+#define TAS2783_DEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
+						SNDRV_PCM_FMTBIT_S24_LE | \
+						SNDRV_PCM_FMTBIT_S32_LE)
+
+/* BOOK, PAGE Control Register */
+#define TASDEVICE_REG(book, page, reg)	((book * 256 * 256) + 0x8000 + \
+						(page * 128) + reg)
+
+/*Software Reset */
+#define TAS2873_REG_SWRESET			TASDEVICE_REG(0x0, 0x00, 0x01)
+#define TAS2873_REG_SWRESET_MASK		BIT(0)
+#define TAS2873_REG_SWRESET_RESET		BIT(0)
+
+#define TAS2873_REG_PWR_CTRL			TASDEVICE_REG(0x0, 0x00, 0x02)
+#define TAS2783_REG_AEF_MASK			GENMASK(4, 3)
+#define TAS2783_REG_AEF_ACTIVE			0
+#define TAS2783_REG_AEF_INACTIVE		GENMASK(4, 3)
+#define TAS2783_REG_PWR_MODE_MASK		GENMASK(2, 0)
+#define TAS2783_REG_PWR_MODE_ACTIVE		0
+#define TAS2783_REG_PWR_MODE_SW_PWD		BIT(1)
+
+#define TAS2783_REG_TDM_RX_CFG			TASDEVICE_REG(0x0, 0x00, 0x0a)
+
+/* Volume control */
+#define TAS2783_DVC_LVL				TASDEVICE_REG(0x0, 0x00, 0x1a)
+#define TAS2783_AMP_LEVEL			TASDEVICE_REG(0x0, 0x00, 0x03)
+#define TAS2783_AMP_LEVEL_MASK			GENMASK(5, 1)
+
+/* Calibration data */
+#define TAS2783_CALIBRATION_RE			TASDEVICE_REG(0x0, 0x17, 0x74)
+#define TAS2783_CALIBRATION_RE_LOW		TASDEVICE_REG(0x0, 0x18, 0x14)
+#define TAS2783_CALIBRATION_INV_RE		TASDEVICE_REG(0x0, 0x18, 0x0c)
+#define TAS2783_CALIBRATION_POW			TASDEVICE_REG(0x0, 0x13, 0x70)
+#define TAS2783_CALIBRATION_TLIMIT		TASDEVICE_REG(0x0, 0x18, 0x7c)
+
+/* TAS2783 SDCA Control - function number */
+#define TAS2783_FUNC_TYPE_SMART_AMP		0x01
+
+/* TAS2783 SDCA entity */
+#define TAS2783_SDCA_ENT_FU21			0x01
+#define TAS2783_SDCA_ENT_FU23			0x02
+
+/* TAS2783 SDCA control */
+#define TAS2783_SDCA_CTL_REQ_POWER_STATE	0x01
+#define TAS2783_SDCA_CTL_FU_MUTE		0x01
+#define TAS2783_SDCA_CTL_FU_VOLUME		0x02
+#define TAS2783_SDCA_CTL_UDMPU_CLUSTER		0x10
+
+#define TAS2783_DEVICE_CHANNEL_LEFT		1
+#define TAS2783_DEVICE_CHANNEL_RIGHT		2
+#define TAS2783_DSPFW_FILENAME_LEN		64
+
+#define TAS2783_MAX_CALIDATA_SIZE		256
+
+#define TAS2783_CALIDATAV1_TIMESTAMP_INDX	40
+#define TAS2783_CALIDATAV1_CRC32_INDX		41
+/* 8 devs * 20 bytes calibrated data/dev + 4 bytes Timestamp */
+#define TAS2783_CALIDATAV1_BYTE_SIZE		(8 * 20 + 4)
+
+#define TAS2783_CALIDATAV2_TIMESTAMP_INDX	2
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
+	struct regmap *regmap;
+	struct device *dev;
+	bool hw_init;
+	bool first_hw_init;
+};
+
+#endif /*__TAS2783_H__ */
-- 
2.34.1


