Return-Path: <linux-kernel+bounces-163466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55368B6B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0161C21D95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702473A8D2;
	Tue, 30 Apr 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YdqFQiQ5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76041236
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462082; cv=none; b=n4aFGMciynfc6oM35KX4QIwRoc3gISHiDgryUf15EsoHkJKEkU9McMWNgWQL49y5WKd0O1zOdVgy6UgAlUaEKzZAHWqrweVnIKlOTvnI8ulR2GV7OMumXkqCoIc4aponOp9PHALd/Cko2QO3t34P8gD9qD6StCDLTmy7DmzvHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462082; c=relaxed/simple;
	bh=Fi9n40s1nkoFqx7JbF2wTedDzoTghlH8xgGq+WFeXw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mqeuu+B5wWmiDfdj8CRHGABUg8t4LnsH/c3Ha4z9iYrmgoStifJT0g4tZevz/GK82xkaPehaMTPBTKzCIn0WVxTszYfKsj6tLoKRwvyP52a8kYMTnRVcQbhq5uBOgDA9E54xqF1xU1fd2NKiSNdYU+/ztFnnO+3cTrp4HPB7Y6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YdqFQiQ5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U7Qong062031;
	Tue, 30 Apr 2024 02:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714462010;
	bh=uR3bYQhMQTGu4V8Mr+pYoJ+rLDA1FEjW60r3sfPWs6w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YdqFQiQ5IkaHap65qIdDxz6LfQbNpb6+hqIPh1tc0EAuhm34CjiVCr31ifk+cu+x5
	 8L+pttHBZvvu5xQT7GckT1r4XTEvbyiwP5qQ5yMQ+OZLP42vPBb44Ap3V+f5tuowKY
	 97nHv3K1nD/jJ7RQaaJXEJ8Gylf7fZuALrdYb5kE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U7Qown126991
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 02:26:50 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 02:26:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 02:26:50 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U7QT5B096668;
	Tue, 30 Apr 2024 02:26:44 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <shenghao-ding@ti.com>, <navada@ti.com>, <13916275206@139.com>,
        <v-po@ti.com>, <niranjan.hy@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v4 2/3] ALSA: hda/tas2781: Tas2781 hda driver for SPI
Date: Tue, 30 Apr 2024 15:25:43 +0800
Message-ID: <20240430072544.1877-3-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240430072544.1877-1-baojun.xu@ti.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Main source code for tas2781 hda driver for SPI.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>

---
v4:
 - Move include of sound/tas2781-dsp.h to c source file tas2781_hda_spi.c,
   tas2781_spi_fwlib.c, as it's not needed in header file tas2781-spi.h
 - Use page and book number define in other micro define
 - Change 4000000 to (4 * HZ_PER_MHZ)
 - Add define for calibration variable name and size in UEFI.
 - Remove structure tasdevice & tasdevice_irqinfo, and move variables in to
   structure tasdevice_priv
 - Remove some unused variables in sttructure tasdevice_priv
 - Remove function declare of tascodec_init(), use tascodec_spi_init()
 - Remove function declare of tasdevice_remove()
 - Add array_size.h included in tas2781_hda_spi.c
 - Add cleanup.h included for change mutex to guard
 - Add units.h included
 - Include tas2781-dsp.h
 - Remove unused variables in tas2781_hda structure
 - Change 0xff to GENMASK(7, 0)
 - Change 128 to define of max page size
 - Change code as all variables was moved to tasdevice_priv structure
 - Change comments for error in book write, or page write
 - Remove initial of ret, and return 0 directly
 - Change comments for wrong typo, add space in front and end
 - Add check for bulk read, max size should be a page size
 - Change usleep_rang() to fsleep()
 - Change mutex_lock to guard(mutex), and remove mutex_unlock()
 - Change tasdevice_spi_init() to void from int as no value return required
 - Change second parameter to sizeof
 - Remove tasdevice_clamp(), use clamp()
 - Add compatible with old hardware id "TIAS2781"
 - Remove cs_gpio and spi device in tas2781_read_acpi() as use default CS
 - Change dev-index check, return -EINVAL if it's <= 0
 - Change 0xFF to U8_MAX
 - Remove GPIO get for chip-select, use default from SPI device
 - Perform RESET in first AMP only as all AMPs share same RESET pin
 - return 0 directly in some simple routine to avoid variable initial
 - Change comments for function which was used by system
 - Change "ON" "OFF" to function str_on_off(...)
 - Change format of GUID
 - Add temp buffer for first efi.get_variable()
 - Free data if it was allocated
 - Change format of debug message of calibration date time print
 - Remove total_sz = 0, as it's not needed
 - Move save_calibration to after tuning_switch to avoid calibration data
   overwrite
 - Remove dev from structure tasdevice_hda, use dev in tasdevice_priv
 - Remove 0 from { "tas2781-hda", 0}, & {"TXNW2781", 0},
v3:
 - Change format for some define in tas2781-spi.h.
 - Add define for TASDEVICE_MAX_BOOK_NUM, TASDEVICE_MAX_PAGE.
 - Move declare of "enum calib_data {" to header file from source file.
 - Remove "enum device_catlog_id {" as only one platform was supported now.
 - Remove "struct calidata", as we will save pure calibration data only.
 - Remove "struct calidata", "enum device_catlog_id" in tasdevice_priv.
 - Add calibration_data in tasdevice_priv to save pure calibration data.
 - Remove declare of tasdevice_save_calibration() and
   tasdevice_apply_calibration(), as it will be used within same c file.
 - Add below header files included in tas2781_hda_spi.c:
   bits.h, mutex.h, property.h, time.h, types.h.
 - Move two micro define to header file tas2781-spi.h.
 - Change format of some micro define.
 - Change format of some structure.
 - Remove irq in tas2781_hda, as have it already in tasdevice_priv.
 - Remove some local functions declare as not necessarily.
 - Return error if regmap_write() failed.
 - Change fixed value 2 to sizeof(data).
 - Remove all of EXPORT_SYMBOL_GPL,
   as all of function was called within same module.
 - Remove empty line after last return in some functions.
 - Remove some variable initialyzation.
 - Remove variable sub, store acpi_subsystem_id directly.
 - Remove wrong comments for device index, it's must, can't be NULL.
 - Remove some local variables, use elements in structure directly.
 - Append commas in last element of an array.
 - Change calibration data process, didn't save all of calibration data in EFI,
   get in local, and save pure calibration data in tasdevice_priv.
 - Call tasdevice_save_calibration() from function pointer in tasdevice_priv;
 - Remove subid as one platform was supported only, needn't check.
 - Add initialyzation for local variable.
 - Move regmap initialyzation to before acpi read.
 - Call tasdevice_apply_calibration() from function pointer in tasdevice_priv;
 - Remove MODULE_IMPORT_NS(SND_SOC_TAS2781_FMWLIB), as all functions was
   performed within same module.
v2:
 - Update information in file header of tas2781-spi.h.
 - Remove useless micro define.
 - Change TASDEVICE_I2CChecksum to TASDEVICE_Checksum
 - Remove enum control_bus as current code support SPI only.
 - Remove device define as current code support TAS2781 only.
 - Remove spi_device **spi_devs in structure tasdevice_priv.
 - Remove cal_binaryname in structure tasdevice_priv.
 - Remove ndev in structure tasdevice_priv.
 - Change isacpi and  isspi, replace by control_bus(I2C or SPI).
 - Remove void tasdevice_spi_dsp_remove(void *context).
 - Add acpi_device and irq in structure tas2781_hda in tas2781_hda_spi.c.
 - Remove parameter chn in all of registers access functions.
 - Add tascodec_spi_init().
 - Add chip select gpio set for SPI device.
 - Change tasdevice_tuning_switch() to tasdevice_spi_tuning_switch().
 - Change device offset from tas_priv->ndev to tas_priv->index.
 - Change tasdevice_dsp_remove() to tasdevice_spi_dsp_remove().
 - tasdevice_prmg_load() to tasdevice_spi_prmg_load().
 - Change tasdevice_config_info_remove() to
   tasdevice_spi_config_info_remove().
 - Add one dummy byte shift when read from page 2~127, or not book 0.
 - Change tasdevice_spi_change_chn_book() to tasdevice_spi_switch_book()
 - Perform put_device(physdev) before error return.
 - Change calibration data id to 2781 from 2783 in EFI
 - Change calibration data structure name in comments.
---
 sound/pci/hda/tas2781-spi.h     |  149 ++++
 sound/pci/hda/tas2781_hda_spi.c | 1240 +++++++++++++++++++++++++++++++
 2 files changed, 1389 insertions(+)
 create mode 100644 sound/pci/hda/tas2781-spi.h
 create mode 100644 sound/pci/hda/tas2781_hda_spi.c

diff --git a/sound/pci/hda/tas2781-spi.h b/sound/pci/hda/tas2781-spi.h
new file mode 100644
index 000000000000..d55ba33d9f83
--- /dev/null
+++ b/sound/pci/hda/tas2781-spi.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2024 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 driver implements a flexible and configurable
+// algo coefficient setting for TAS2781 chips.
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+//
+
+#ifndef __TAS2781_SPI_H__
+#define __TAS2781_SPI_H__
+
+#define TASDEVICE_RATES			\
+	(SNDRV_PCM_RATE_44100 |	SNDRV_PCM_RATE_48000 | \
+	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_88200)
+
+#define TASDEVICE_FORMATS		\
+	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+#define TASDEVICE_MAX_BOOK_NUM		256
+#define TASDEVICE_MAX_PAGE		128
+
+#define TASDEVICE_MAX_SIZE	(TASDEVICE_MAX_BOOK_NUM * TASDEVICE_MAX_PAGE)
+
+/* PAGE Control Register (available in page0 of each book) */
+#define TASDEVICE_PAGE_SELECT		0x00
+#define TASDEVICE_BOOKCTL_PAGE		0x00
+#define TASDEVICE_BOOKCTL_REG		127
+#define TASDEVICE_BOOK_ID(reg)		(reg / TASDEVICE_MAX_SIZE)
+#define TASDEVICE_PAGE_ID(reg)		((reg % TASDEVICE_MAX_SIZE) / \
+					TASDEVICE_MAX_PAGE)
+#define TASDEVICE_PAGE_REG(reg)		((reg % TASDEVICE_MAX_SIZE) % \
+					TASDEVICE_MAX_PAGE)
+#define TASDEVICE_PGRG(reg)		(reg % TASDEVICE_MAX_SIZE)
+#define TASDEVICE_REG(book, page, reg)	(((book * TASDEVICE_MAX_SIZE) + \
+					(page * TASDEVICE_MAX_PAGE)) + reg)
+
+/* Software Reset */
+#define TAS2781_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)
+#define TAS2781_REG_SWRESET_RESET	BIT(0)
+
+/* I2C Checksum */
+#define TASDEVICE_Checksum		TASDEVICE_REG(0x0, 0x0, 0x7E)
+
+/* Volume control */
+#define TAS2781_DVC_LVL			TASDEVICE_REG(0x0, 0x0, 0x1A)
+#define TAS2781_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
+#define TAS2781_AMP_LEVEL_MASK		GENMASK(5, 1)
+
+#define TASDEVICE_CMD_SING_W		0x1
+#define TASDEVICE_CMD_BURST		0x2
+#define TASDEVICE_CMD_DELAY		0x3
+#define TASDEVICE_CMD_FIELD_W		0x4
+
+#define TAS2781_SPI_MAX_FREQ		(4 * HZ_PER_MHZ)
+
+#define TASDEVICE_CRC8_POLYNOMIAL		0x4d
+#define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
+
+#define TASDEVICE_CALIBRATION_DATA_NAME	L"CALI_DATA"
+#define TASDEVICE_CALIBRATION_DATA_SIZE	256
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
+struct tasdevice_priv {
+	struct tasdevice_fw *cali_data_fmw;
+	struct tasdevice_rca rcabin;
+	struct tasdevice_fw *fmw;
+	struct gpio_desc *reset;
+	struct mutex codec_lock;
+	struct regmap *regmap;
+	struct device *dev;
+	struct tm tm;
+
+	const char *acpi_subsystem_id;
+	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
+	unsigned char coef_binaryname[64];
+	unsigned char rca_binaryname[64];
+	unsigned char dev_name[32];
+
+	unsigned int err_code;
+	bool is_loading;
+	bool is_loaderr;
+	int cur_book;
+	int cur_prog;
+	int cur_conf;
+	int fw_state;
+	int index;
+	int irq;
+	void *client;
+	void *codec;
+	bool force_fwload_status;
+	bool playback_started;
+	unsigned int calibration_data[CALIB_MAX];
+
+	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_priv,
+		const struct firmware *fmw, int offset);
+	int (*fw_parse_program_data)(struct tasdevice_priv *tas_priv,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_priv,
+		struct tasdevice_fw *tas_fmw,
+		const struct firmware *fmw, int offset);
+	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
+		struct tasdev_blk *block);
+
+	int (*save_calibration)(struct tasdevice_priv *tas_priv);
+	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
+};
+
+int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned int *value);
+int tasdevice_spi_dev_write(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned int value);
+int tasdevice_spi_dev_bulk_write(
+	struct tasdevice_priv *tas_priv, unsigned int reg,
+	unsigned char *p_data, unsigned int n_length);
+int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned char *p_data, unsigned int n_length);
+int tasdevice_spi_dev_update_bits(struct tasdevice_priv *tasdevice,
+	unsigned int reg, unsigned int mask, unsigned int value);
+
+void tasdevice_spi_select_cfg_blk(void *context, int conf_no,
+	unsigned char block_type);
+void tasdevice_spi_config_info_remove(void *context);
+int tasdevice_spi_dsp_parser(void *context);
+int tasdevice_spi_rca_parser(void *context, const struct firmware *fmw);
+void tasdevice_spi_dsp_remove(void *context);
+void tasdevice_spi_calbin_remove(void *context);
+int tasdevice_spi_select_tuningprm_cfg(void *context, int prm,
+	int cfg_no, int rca_conf_no);
+int tasdevice_spi_prmg_load(void *context, int prm_no);
+int tasdevice_spi_prmg_calibdata_load(void *context, int prm_no);
+void tasdevice_spi_tuning_switch(void *context, int state);
+int tas2781_spi_load_calibration(void *context, char *file_name,
+	unsigned short i);
+#endif /* __TAS2781_SPI_H__ */
diff --git a/sound/pci/hda/tas2781_hda_spi.c b/sound/pci/hda/tas2781_hda_spi.c
new file mode 100644
index 000000000000..7f61d5a506f0
--- /dev/null
+++ b/sound/pci/hda/tas2781_hda_spi.c
@@ -0,0 +1,1240 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// TAS2781 HDA SPI driver
+//
+// Copyright 2024 Texas Instruments, Inc.
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+
+#include <linux/acpi.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/firmware.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <sound/hda_codec.h>
+#include <sound/soc.h>
+#include <sound/tas2781-dsp.h>
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
+/*
+ * No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD
+ * Define two controls, one is Volume control callbacks, the other is
+ * flag setting control callbacks.
+ */
+
+/* Volume control callbacks for tas2781 */
+#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinvert, \
+	xhandler_get, xhandler_put, tlv_array) { \
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw_range, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) { \
+		.reg = xreg, .rreg = xreg, \
+		.shift = xshift, .rshift = xshift,\
+		.min = xmin, .max = xmax, .invert = xinvert, \
+	} \
+}
+
+/* Flag control callbacks for tas2781 */
+#define ACARD_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) { \
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD, \
+	.name = xname, \
+	.info = snd_ctl_boolean_mono_info, \
+	.get = xhandler_get, \
+	.put = xhandler_put, \
+	.private_value = xdata, \
+}
+
+struct tas2781_hda {
+	struct tasdevice_priv *priv;
+	struct acpi_device *dacpi;
+	struct snd_kcontrol *dsp_prog_ctl;
+	struct snd_kcontrol *dsp_conf_ctl;
+	struct snd_kcontrol *snd_ctls[3];
+	struct snd_kcontrol *prof_ctl;
+};
+
+static const struct regmap_range_cfg tasdevice_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = TASDEVICE_MAX_BOOK_NUM * TASDEVICE_MAX_PAGE,
+		.selector_reg = TASDEVICE_PAGE_SELECT,
+		.selector_mask = GENMASK(7, 0),
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = TASDEVICE_MAX_PAGE,
+	},
+};
+
+static const struct regmap_config tasdevice_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+	.ranges = tasdevice_ranges,
+	.num_ranges = ARRAY_SIZE(tasdevice_ranges),
+	.max_register = TASDEVICE_MAX_BOOK_NUM * TASDEVICE_MAX_PAGE,
+};
+
+static int tasdevice_spi_switch_book(struct tasdevice_priv *tas_priv, int book)
+{
+	struct regmap *map = tas_priv->regmap;
+	int ret;
+
+	if (tas_priv->cur_book != book) {
+		/* Change to page 0 before book change. */
+		ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
+		if (ret < 0) {
+			dev_err(tas_priv->dev, "Switch page E=%d\n", ret);
+			return ret;
+		}
+		ret = regmap_write(map, TASDEVICE_BOOKCTL_REG, book);
+		if (ret < 0) {
+			dev_err(tas_priv->dev, "Switch Book E=%d\n", ret);
+			return ret;
+		}
+		tas_priv->cur_book = book;
+	}
+
+	return 0;
+}
+
+int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned int *val)
+{
+	struct regmap *map = tas_priv->regmap;
+	int ret;
+
+	ret = tasdevice_spi_switch_book(tas_priv, TASDEVICE_BOOK_ID(reg));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * In our TAS2781 SPI mode, if read from other book (not book 0),
+	 * or read from page number larger than 1 in book 0, one more byte
+	 * read is needed, and first byte is a dummy byte, need to be ignored.
+	 */
+	if ((TASDEVICE_BOOK_ID(reg) > 0) || (TASDEVICE_PAGE_ID(reg) > 1)) {
+		unsigned char data[2];
+
+		ret = regmap_bulk_read(map, TASDEVICE_PGRG(reg), data,
+			sizeof(data));
+		*val = data[1];
+	} else {
+		ret = regmap_read(map, TASDEVICE_PGRG(reg), val);
+	}
+	if (ret < 0)
+		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+
+	return ret;
+}
+
+int tasdevice_spi_dev_write(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned int value)
+{
+	struct regmap *map = tas_priv->regmap;
+	int ret;
+
+	ret = tasdevice_spi_switch_book(tas_priv, TASDEVICE_BOOK_ID(reg));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(map, TASDEVICE_PGRG(reg), value);
+	if (ret < 0)
+		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+
+	return ret;
+}
+
+int tasdevice_spi_dev_bulk_write(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned char *data, unsigned int len)
+{
+	struct regmap *map = tas_priv->regmap;
+	int ret;
+
+	ret = tasdevice_spi_switch_book(tas_priv, TASDEVICE_BOOK_ID(reg));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_write(map, TASDEVICE_PGRG(reg), data, len);
+	if (ret < 0)
+		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+
+	return ret;
+}
+
+int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned char *data, unsigned int len)
+{
+	struct regmap *map = tas_priv->regmap;
+	int ret;
+
+	ret = tasdevice_spi_switch_book(tas_priv, TASDEVICE_BOOK_ID(reg));
+	if (ret < 0)
+		return ret;
+
+	if (len > TASDEVICE_MAX_PAGE)
+		len = TASDEVICE_MAX_PAGE;
+	/*
+	 * In our TAS2781 SPI mode, if read from other book (not book 0),
+	 * or read from page number larger than 1 in book 0, one more byte
+	 * read is needed, and first byte is a dummy byte, need to be ignored.
+	 */
+	if ((TASDEVICE_BOOK_ID(reg) > 0) || (TASDEVICE_PAGE_ID(reg) > 1)) {
+		unsigned char buf[TASDEVICE_MAX_PAGE+1];
+
+		ret = regmap_bulk_read(map, TASDEVICE_PGRG(reg),
+			buf, len + 1);
+		memcpy(data, buf + 1, len);
+	} else {
+		ret = regmap_bulk_read(map, TASDEVICE_PGRG(reg), data, len);
+	}
+	if (ret < 0)
+		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+
+	return ret;
+}
+
+int tasdevice_spi_dev_update_bits(struct tasdevice_priv *tas_priv,
+	unsigned int reg, unsigned int mask, unsigned int value)
+{
+	struct regmap *map = tas_priv->regmap;
+	int ret;
+
+	ret = tasdevice_spi_switch_book(tas_priv, TASDEVICE_BOOK_ID(reg));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(map, TASDEVICE_PGRG(reg), mask, value);
+	if (ret < 0)
+		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
+
+	return ret;
+}
+
+static void tas2781_spi_reset(struct tasdevice_priv *tas_dev)
+{
+	int ret;
+
+	if (tas_dev->reset) {
+		gpiod_set_value_cansleep(tas_dev->reset, 0);
+		fsleep(800);
+		gpiod_set_value_cansleep(tas_dev->reset, 1);
+	} else {
+		ret = tasdevice_spi_dev_write(tas_dev, TAS2781_REG_SWRESET,
+			TAS2781_REG_SWRESET_RESET);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "dev sw-reset fail, %d\n", ret);
+	}
+	fsleep(1000);
+}
+
+static int tascodec_spi_init(struct tasdevice_priv *tas_priv, void *codec,
+	struct module *module,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	int ret;
+
+	/*
+	 * Codec Lock Hold to ensure that codec_probe and firmware parsing and
+	 * loading do not simultaneously execute.
+	 */
+	guard(mutex)(&tas_priv->codec_lock);
+
+	ret = scnprintf(tas_priv->rca_binaryname,
+		sizeof(tas_priv->rca_binaryname), "%sRCA%d.bin",
+		tas_priv->dev_name, tas_priv->index);
+	if (ret <= 0) {
+		dev_err(tas_priv->dev, "rca name err:0x%08x\n", ret);
+		return ret;
+	}
+	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
+	tas_priv->codec = codec;
+	ret = request_firmware_nowait(module, FW_ACTION_UEVENT,
+		tas_priv->rca_binaryname, tas_priv->dev, GFP_KERNEL, tas_priv,
+		cont);
+	if (ret)
+		dev_err(tas_priv->dev, "request_firmware_nowait err:0x%08x\n",
+			ret);
+
+	return ret;
+}
+
+static void tasdevice_spi_init(struct tasdevice_priv *tas_priv)
+{
+	tas_priv->cur_prog = -1;
+	tas_priv->cur_conf = -1;
+
+	tas_priv->cur_book = -1;
+	tas_priv->cur_prog = -1;
+	tas_priv->cur_conf = -1;
+
+	mutex_init(&tas_priv->codec_lock);
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
+	mask = rounddown_pow_of_two(max);
+	mask <<= mc->shift;
+	val =  clamp(invert ? max - ucontrol->value.integer.value[0] :
+		ucontrol->value.integer.value[0], 0, max);
+	ret = tasdevice_spi_dev_update_bits(tas_priv,
+		mc->reg, mask, (unsigned int)(val << mc->shift));
+	if (ret)
+		dev_err(tas_priv->dev, "set AMP vol error in dev %d\n",
+			tas_priv->index);
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
+	ret = tasdevice_spi_dev_read(tas_priv, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_priv->dev, "%s, get AMP vol error\n", __func__);
+		return ret;
+	}
+
+	mask = rounddown_pow_of_two(max);
+	mask <<= mc->shift;
+	val = (val & mask) >> mc->shift;
+	val = clamp(invert ? max - val : val, 0, max);
+	ucontrol->value.integer.value[0] = val;
+
+	return ret;
+}
+
+static int tasdevice_spi_digital_putvol(struct tasdevice_priv *tas_priv,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
+{
+	unsigned int invert = mc->invert;
+	int max = mc->max;
+	int val, ret;
+
+	val = clamp(invert ? max - ucontrol->value.integer.value[0] :
+		ucontrol->value.integer.value[0], 0, max);
+	ret = tasdevice_spi_dev_write(tas_priv, mc->reg, (unsigned int)val);
+	if (ret)
+		dev_err(tas_priv->dev, "set digital vol err in dev %d\n",
+			tas_priv->index);
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
+	ret = tasdevice_spi_dev_read(tas_priv, mc->reg, &val);
+	if (ret) {
+		dev_err(tas_priv->dev, "%s, get digital vol err\n", __func__);
+		return ret;
+	}
+
+	val = clamp(invert ? max - val : val, 0, max);
+	ucontrol->value.integer.value[0] = val;
+
+	return ret;
+}
+
+static int tas2781_read_acpi(struct tas2781_hda *tas_hda, const char *hid,
+	int id)
+{
+	struct tasdevice_priv *p = tas_hda->priv;
+	struct acpi_device *adev;
+	struct device *physdev;
+	u32 values[HDA_MAX_COMPONENTS];
+	const char *property;
+	size_t nval;
+	int ret, i;
+
+	adev = acpi_dev_get_first_match_dev(hid, NULL, -1);
+	if (!adev) {
+		dev_err(p->dev, "Failed to find ACPI device: %s\n", hid);
+		return -ENODEV;
+	}
+
+	strscpy(p->dev_name, hid, sizeof(p->dev_name));
+	tas_hda->dacpi = adev;
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
+
+	/* No side-effect to the playback even if subsystem_id is NULL */
+	p->acpi_subsystem_id = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
+
+	property = "ti,dev-index";
+	ret = device_property_count_u32(physdev, property);
+	if ((ret <= 0) || (ret > ARRAY_SIZE(values))) {
+		ret = -EINVAL;
+		goto err;
+	}
+	nval = ret;
+
+	ret = device_property_read_u32_array(physdev, property, values, nval);
+	if (ret)
+		goto err;
+
+	p->index = U8_MAX;
+	for (i = 0; i < nval; i++) {
+		if (values[i] == id) {
+			p->index = i;
+			break;
+		}
+	}
+	if (p->index == U8_MAX) {
+		dev_dbg(p->dev, "No index found in %s\n", property);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	if (p->index == 0) {
+		/* All of amps share same RESET pin. */
+		p->reset = devm_gpiod_get_index_optional(physdev, "reset",
+			p->index, GPIOD_OUT_LOW);
+		if (IS_ERR(p->reset)) {
+			dev_err_probe(p->dev, ret, "Failed on reset GPIO\n");
+			goto err;
+		}
+	}
+
+	put_device(physdev);
+
+	return 0;
+
+err:
+	dev_err(p->dev, "read acpi error, ret: %d\n", ret);
+	put_device(physdev);
+	acpi_dev_put(adev);
+
+	return ret;
+}
+
+static void tas2781_hda_playback_hook(struct device *dev, int action)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		guard(mutex)(&tas_hda->priv->codec_lock);
+		tasdevice_spi_tuning_switch(tas_hda->priv, 0);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		guard(mutex)(&tas_hda->priv->codec_lock);
+		tasdevice_spi_tuning_switch(tas_hda->priv, 1);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		break;
+	default:
+		dev_dbg(tas_hda->priv->dev,
+			"Playback action not supported: %d\n", action);
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
+	int max = tas_priv->rcabin.ncfgs - 1;
+	int val;
+
+	val = clamp(ucontrol->value.integer.value[0], 0, max);
+	if (tas_priv->rcabin.profile_cfg_id != val) {
+		tas_priv->rcabin.profile_cfg_id = val;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_priv->fmw->nr_programs - 1;
+
+	return 0;
+}
+
+static int tasdevice_info_config(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct tasdevice_priv *tas_priv = snd_kcontrol_chip(kcontrol);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = tas_priv->fmw->nr_configurations - 1;
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
+	int nr_program = ucontrol->value.integer.value[0];
+	int max = tas_priv->fmw->nr_programs - 1;
+	int val;
+
+	val = clamp(nr_program, 0, max);
+
+	if (tas_priv->cur_prog != val) {
+		tas_priv->cur_prog = val;
+		return 1;
+	}
+
+	return 0;
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
+	int max = tas_priv->fmw->nr_configurations - 1;
+	int val;
+
+	val = clamp(ucontrol->value.integer.value[0], 0, max);
+
+	if (tas_priv->cur_conf != val) {
+		tas_priv->cur_conf = val;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * tas2781_digital_getvol - get the volum control
+ * @kcontrol: control pointer
+ * @ucontrol: User data
+ *
+ * Customer Kcontrol for tas2781 is primarily for regmap booking, paging
+ * depends on internal regmap mechanism.
+ * tas2781 contains book and page two-level register map, especially
+ * book switching will set the register BXXP00R7F, after switching to the
+ * correct book, then leverage the mechanism for paging to access the
+ * register.
+ *
+ * Return 0 if succeeded.
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
+		str_on_off(tas_priv->force_fwload_status));
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
+	if (tas_priv->force_fwload_status == val) {
+		change = false;
+	} else {
+		change = true;
+		tas_priv->force_fwload_status = val;
+	}
+	dev_dbg(tas_priv->dev, "%s : Force FWload %s\n", __func__,
+		str_on_off(tas_priv->force_fwload_status));
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
+		0x17, 0x18, 0x18, 0x13, 0x18,
+	};
+	static const unsigned char rgno_array[CALIB_MAX] = {
+		0x74, 0x0c, 0x14, 0x70, 0x7c,
+	};
+	int j, rc;
+
+	/*
+	 * If no calibration data exist in tasdevice_priv *tas_priv,
+	 * calibration apply will be ignored, and use default values
+	 * in firmware binary, which was loaded during firmware download.
+	 */
+	if (tas_priv->calibration_data[0] == 0)
+		return;
+	/*
+	 * Calibration data was saved in tasdevice_priv *tas_priv as:
+	 * unsigned int calibration_data[CALIB_MAX];
+	 * and every data (in 4 bytes) will be saved in register which in
+	 * book 0, and page number in page_array[], offset was saved in
+	 * rgno_array[].
+	 */
+	for (j = 0; j < CALIB_MAX; j++) {
+		rc = tasdevice_spi_dev_bulk_write(tas_priv,
+			TASDEVICE_REG(0, page_array[j], rgno_array[j]),
+			(unsigned char *)&tas_priv->calibration_data[j], 4);
+		if (rc < 0)
+			dev_err(tas_priv->dev,
+				"chn %d calib %d bulk_wr err = %d\n",
+				tas_priv->index, j, rc);
+	}
+}
+
+/*
+ * Update the calibration data, including speaker impedance, f0, etc,
+ * into algo. Calibrate data is done by manufacturer in the factory.
+ * These data are used by Algo for calculating the speaker temperature,
+ * speaker membrane excursion and f0 in real time during playback.
+ * Calibration data format in EFI is V2, since 2024.
+ */
+static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
+{
+	/*
+	 * GUID was used for data access in BIOS, it was provide by board
+	 * manufactory, like HP: "{02f9af02-7734-4233-b43d-93fe5aa35db3}"
+	 */
+	efi_guid_t efi_guid =
+		EFI_GUID(0x02f9af02, 0x7734, 0x4233,
+			 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static efi_char16_t efi_name[] = TASDEVICE_CALIBRATION_DATA_NAME;
+	struct tm *tm = &tas_priv->tm;
+	unsigned long total_sz = 0;
+	unsigned int attr, crc;
+	unsigned int *tmp_val;
+	efi_status_t status;
+	unsigned char data[TASDEVICE_CALIBRATION_DATA_SIZE];
+
+	tas_priv->calibration_data[0] = 0;
+	status = efi.get_variable(efi_name, &efi_guid, &attr, &total_sz,
+		data);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		if (total_sz > TASDEVICE_CALIBRATION_DATA_SIZE)
+			return -ENOMEM;
+		/* Get variable contents into buffer */
+		status = efi.get_variable(efi_name, &efi_guid, &attr,
+			&total_sz, data);
+	}
+	if (status != EFI_SUCCESS)
+		return -EINVAL;
+
+	tmp_val = (unsigned int *)data;
+	if (tmp_val[0] == 2781) {
+		/*
+		 * New features were added in calibrated Data V2:
+		 *     1. Added some the fields to store the link_id and
+		 *     uniqie_id for multi-link solutions
+		 *     2. Support flexible number of devices instead of
+		 *     fixed one in V1.
+		 * Layout of calibrated data V2 in UEFI(total 256 bytes):
+		 *     ChipID (2781, 4 bytes)
+		 *     Device-Sum (4 bytes)
+		 *     TimeStamp of Calibration (4 bytes)
+		 *     for (i = 0; i < Device-Sum; i++) {
+		 *             Device #i index_info () {
+		 *                     SDW link id (2bytes)
+		 *                     SDW unique_id (2bytes)
+		 *             }
+		 *             Calibrated Data of Device #i (20 bytes)
+		 *     }
+		 *     CRC (4 bytes)
+		 *     Reserved (the rest)
+		 */
+		crc = crc32(~0, data, 3 + tmp_val[0] * 6) ^ ~0;
+		dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+			crc, tmp_val[3 + tmp_val[0] * 6]);
+
+		if (crc == tmp_val[3 + tmp_val[0] * 6]) {
+			time64_to_tm(tmp_val[2], 0, tm);
+			dev_dbg(tas_priv->dev, "Calibration date %pt.\n", tm);
+			for (int i = 0; i < CALIB_MAX; i++)
+				tas_priv->calibration_data[i] =
+					tmp_val[3 + tas_priv->index * 6 + i];
+			tas_priv->apply_calibration(tas_priv);
+		}
+	} else {
+		/*
+		 * Calibration data is in V1 format.
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
+		crc = crc32(~0, data, 84) ^ ~0;
+		dev_dbg(tas_priv->dev, "cali crc 0x%08x PK tmp_val 0x%08x\n",
+			crc, tmp_val[21]);
+
+		if (crc == tmp_val[21]) {
+			time64_to_tm(tmp_val[20], 0, tm);
+			dev_dbg(tas_priv->dev, "Calibration date %pt.\n", tm);
+			for (int i = 0; i < CALIB_MAX; i++)
+				tas_priv->calibration_data[i] =
+					tmp_val[tas_priv->index * 5 + i];
+			tas_priv->apply_calibration(tas_priv);
+		}
+	}
+
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
+	guard(mutex)(&tas_priv->codec_lock);
+
+	ret = tasdevice_spi_rca_parser(tas_priv, fmw);
+	if (ret)
+		goto out;
+
+	/* Add control one time only. */
+	if (tas_priv->index == 0) {
+		tas_hda->prof_ctl = snd_ctl_new1(&tas2781_prof_ctrl, tas_priv);
+		ret = snd_ctl_add(codec->card, tas_hda->prof_ctl);
+		if (ret) {
+			dev_err(tas_priv->dev,
+				"Failed to add KControl %s = %d\n",
+				tas2781_prof_ctrl.name, ret);
+			goto out;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(tas2781_snd_controls); i++) {
+			tas_hda->snd_ctls[i] =
+				snd_ctl_new1(&tas2781_snd_controls[i],
+				tas_priv);
+			ret = snd_ctl_add(codec->card, tas_hda->snd_ctls[i]);
+			if (ret) {
+				dev_err(tas_priv->dev,
+					"Failed to add KControl %s = %d\n",
+					tas2781_snd_controls[i].name, ret);
+				goto out;
+			}
+		}
+	}
+
+	tasdevice_spi_dsp_remove(tas_priv);
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
+	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%08X-%01d.bin",
+		codec->core.subsystem_id, tas_priv->index);
+	ret = tasdevice_spi_dsp_parser(tas_priv);
+	if (ret) {
+		dev_err(tas_priv->dev, "dspfw load %s error\n",
+			tas_priv->coef_binaryname);
+		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
+		goto out;
+	}
+
+	/* Add control one time only. */
+	if (tas_priv->index == 0) {
+		tas_hda->dsp_prog_ctl = snd_ctl_new1(&tas2781_dsp_prog_ctrl,
+			tas_priv);
+		ret = snd_ctl_add(codec->card, tas_hda->dsp_prog_ctl);
+		if (ret) {
+			dev_err(tas_priv->dev,
+				"Failed to add KControl %s = %d\n",
+				tas2781_dsp_prog_ctrl.name, ret);
+			goto out;
+		}
+
+		tas_hda->dsp_conf_ctl = snd_ctl_new1(&tas2781_dsp_conf_ctrl,
+			tas_priv);
+		ret = snd_ctl_add(codec->card, tas_hda->dsp_conf_ctl);
+		if (ret) {
+			dev_err(tas_priv->dev,
+				"Failed to add KControl %s = %d\n",
+				tas2781_dsp_conf_ctrl.name, ret);
+			goto out;
+		}
+	}
+
+	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
+	tasdevice_spi_prmg_load(tas_priv, 0);
+	if (tas_priv->fmw->nr_programs > 0)
+		tas_priv->cur_prog = 0;
+	if (tas_priv->fmw->nr_configurations > 0)
+		tas_priv->cur_conf = 0;
+
+	tasdevice_spi_tuning_switch(tas_hda->priv, 0);
+
+	/*
+	 * If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	tas_priv->save_calibration(tas_priv);
+
+out:
+	if (fmw)
+		release_firmware(fmw);
+	pm_runtime_mark_last_busy(tas_hda->priv->dev);
+	pm_runtime_put_autosuspend(tas_hda->priv->dev);
+}
+
+static int tas2781_hda_bind(struct device *dev, struct device *master,
+	void *master_data)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+	struct hda_codec *codec;
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
+
+	pm_runtime_get_sync(dev);
+
+	comps->dev = dev;
+
+	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
+
+	ret = tascodec_spi_init(tas_hda->priv, codec, THIS_MODULE,
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
+	tasdevice_spi_config_info_remove(tas_hda->priv);
+	tasdevice_spi_dsp_remove(tas_hda->priv);
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
+	pm_runtime_get_sync(tas_hda->priv->dev);
+	pm_runtime_disable(tas_hda->priv->dev);
+
+	component_del(tas_hda->priv->dev, &tas2781_hda_comp_ops);
+
+	pm_runtime_put_noidle(tas_hda->priv->dev);
+
+	mutex_destroy(&tas_hda->priv->codec_lock);
+}
+
+static int tas2781_hda_spi_probe(struct spi_device *spi)
+{
+	struct tasdevice_priv *tas_priv;
+	struct tas2781_hda *tas_hda;
+	const char *device_name;
+	int ret = 0;
+
+	tas_hda = devm_kzalloc(&spi->dev, sizeof(*tas_hda), GFP_KERNEL);
+	if (!tas_hda)
+		return -ENOMEM;
+
+	spi->max_speed_hz = TAS2781_SPI_MAX_FREQ;
+
+	tas_priv = devm_kzalloc(&spi->dev, sizeof(*tas_priv), GFP_KERNEL);
+	if (!tas_priv)
+		goto err;
+	tas_priv->dev = &spi->dev;
+	tas_priv->client = spi;
+	tas_hda->priv = tas_priv;
+	tas_priv->regmap = devm_regmap_init_spi(spi, &tasdevice_regmap);
+	if (IS_ERR(tas_priv->regmap)) {
+		ret = PTR_ERR(tas_priv->regmap);
+		dev_err(tas_priv->dev, "Failed to allocate regmap: %d\n",
+			ret);
+		goto err;
+	}
+	if (strstr(dev_name(&spi->dev), "TXNW2781")) {
+		device_name = "TXNW2781";
+		tas_priv->save_calibration = tas2781_save_calibration;
+		tas_priv->apply_calibration = tas2781_apply_calib;
+	} else if (strstr(dev_name(&spi->dev), "TIAS2781")) {
+		device_name = "TIAS2781";
+		tas_priv->save_calibration = tas2781_save_calibration;
+		tas_priv->apply_calibration = tas2781_apply_calib;
+	} else {
+		goto err;
+	}
+
+	tas_priv->irq = spi->irq;
+	dev_set_drvdata(&spi->dev, tas_hda);
+	ret = tas2781_read_acpi(tas_hda, device_name,
+		spi_get_chipselect(spi, 0));
+	if (ret)
+		return dev_err_probe(tas_priv->dev, ret,
+			"Platform not supported\n");
+
+	tasdevice_spi_init(tas_priv);
+
+	pm_runtime_set_autosuspend_delay(tas_priv->dev, 3000);
+	pm_runtime_use_autosuspend(tas_priv->dev);
+	pm_runtime_mark_last_busy(tas_priv->dev);
+	pm_runtime_set_active(tas_priv->dev);
+	pm_runtime_get_noresume(tas_priv->dev);
+	pm_runtime_enable(tas_priv->dev);
+
+	pm_runtime_put_autosuspend(tas_priv->dev);
+
+	tas2781_spi_reset(tas_priv);
+
+	ret = component_add(tas_priv->dev, &tas2781_hda_comp_ops);
+	if (ret) {
+		dev_err(tas_priv->dev, "Register component failed: %d\n", ret);
+		pm_runtime_disable(tas_priv->dev);
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
+	dev_dbg(tas_hda->priv->dev, "Runtime Suspend\n");
+
+	guard(mutex)(&tas_hda->priv->codec_lock);
+
+	if (tas_hda->priv->playback_started) {
+		tasdevice_spi_tuning_switch(tas_hda->priv, 1);
+		tas_hda->priv->playback_started = false;
+	}
+
+	tas_hda->priv->cur_book = -1;
+	tas_hda->priv->cur_prog = -1;
+	tas_hda->priv->cur_conf = -1;
+
+	return 0;
+}
+
+static int tas2781_runtime_resume(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+
+	dev_dbg(tas_hda->priv->dev, "Runtime Resume\n");
+
+	guard(mutex)(&tas_hda->priv->codec_lock);
+
+	tasdevice_spi_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
+
+	/*
+	 * If calibrated data occurs error, dsp will still works with default
+	 * calibrated data inside algo.
+	 */
+	tas_hda->priv->apply_calibration(tas_hda->priv);
+
+	return 0;
+}
+
+static int tas2781_system_suspend(struct device *dev)
+{
+	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	int ret;
+
+	dev_info(tas_hda->priv->dev, "System Suspend %p\n", tas_hda);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Shutdown chip before system suspend */
+	tasdevice_spi_tuning_switch(tas_hda->priv, 1);
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
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&tas_hda->priv->codec_lock);
+
+	tas_hda->priv->cur_book = -1;
+	tas_hda->priv->cur_prog = -1;
+	tas_hda->priv->cur_conf = -1;
+
+	tas2781_spi_reset(tas_hda->priv);
+	tasdevice_spi_prmg_load(tas_hda->priv, tas_hda->priv->cur_prog);
+
+	/*
+	 * If calibrated data occurs error, dsp will still work with default
+	 * calibrated data inside algo.
+	 */
+	tas_hda->priv->apply_calibration(tas_hda->priv);
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
+	{ "tas2781-hda", },
+	{}
+};
+
+static const struct acpi_device_id tas2781_acpi_hda_match[] = {
+	{"TXNW2781", },
+	{"TIAS2781", },
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
+MODULE_DESCRIPTION("TAS2781 HDA SPI Driver");
+MODULE_AUTHOR("Baojun, Xu, <baojun.xug@ti.com>");
+MODULE_LICENSE("GPL");
-- 
2.40.1


