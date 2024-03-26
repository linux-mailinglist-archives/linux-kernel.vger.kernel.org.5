Return-Path: <linux-kernel+bounces-118236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93FA88B695
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B171C35F83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C6D1D547;
	Tue, 26 Mar 2024 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iugYAFiu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A851CA81
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415443; cv=none; b=R64+XtTzrcRE8SwVLxqJernCb3PsdQ17MRTY236A0PAAfo3zs1C+d791QeVeB9ZeiiEcTmmdihe6Y/W8cpemkcX96YZ0NkLibPV9zWBFBoGa3WpwD6ujP1PmcDDdfWEn0J567oMi7psU6hFAFOg5oqQC1HxNpCoMJ5dq45L0KzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415443; c=relaxed/simple;
	bh=ZDrgowY1EpQr3QzVTSfPd0mXLMB9sCiBDE36Pu+duaY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9hIXJyhx1nhXkX+YFNTkIOZrFR9vzGEFW24LfL0zWPF4PsJ7Bdkhc1iZScTWZLCV/9sLxR0EsKVJPa01ZnIbPQ6RmtCyF2htFoezI/TtB5EfAWgKVu4FGy/vRVj0h/dSH5MGFd2Z2L1B1ZZqfceA3yh+9pp34ZcLQDZWYSve7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iugYAFiu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19pU1021515;
	Mon, 25 Mar 2024 20:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711415391;
	bh=s4YUR63mI1COgvy1jIg4E8KltSMaKXGWtQ5iIceGbz4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iugYAFiusZhnoBsCA7okxyIrpioWEe+jGr1nWJRaq4RmtAhHu71OMWDl2wkcM38U8
	 WgVMHUX9yjEBC2Eb59I8Jon+5Of+9JMGBQ4eoGNOqF6ILfO8AJNr/P86cDIVh/YCLx
	 1l4zIpBV9B5UR9Gu1xWkXjA7DDQcdHHG8lAVDmVY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42Q19pjQ044493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 20:09:51 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 20:09:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 20:09:50 -0500
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42Q19AYC120020;
	Mon, 25 Mar 2024 20:09:44 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <kevin-lu@ti.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <soyer@irl.hu>
Subject: [PATCH v1 6/8] ALSA: hda/tas2781: Add tas2781 SPI-based driver
Date: Tue, 26 Mar 2024 09:09:03 +0800
Message-ID: <20240326010905.2147-6-baojun.xu@ti.com>
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

Add tas2781-spi.h for tas2781 spi driver.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/tas2781-spi.h | 180 ++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 sound/pci/hda/tas2781-spi.h

diff --git a/sound/pci/hda/tas2781-spi.h b/sound/pci/hda/tas2781-spi.h
new file mode 100644
index 000000000..abd6bb9aa
--- /dev/null
+++ b/sound/pci/hda/tas2781-spi.h
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
+//
+// Copyright (C) 2024 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The TAS2781 spi driver implements a flexible and configurable
+// algo coefficient setting for TAS2781 chips.
+//
+// Author: Baojun Xu <baojun.xu@ti.com>
+//
+
+#ifndef __TAS2781_SPI_H__
+#define __TAS2781_SPI_H__
+
+#include <sound/tas2781-dsp.h>
+
+/* version number */
+#define TAS2781_DRV_VER			1
+#define SMARTAMP_MODULE_NAME		"tas2781"
+#define TAS2781_GLOBAL_ADDR		0x40
+#define TAS2563_GLOBAL_ADDR		0x48
+#define TASDEVICE_RATES			(SNDRV_PCM_RATE_44100 |\
+	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |\
+	SNDRV_PCM_RATE_88200)
+
+#define TASDEVICE_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+/*PAGE Control Register (available in page0 of each book) */
+#define TASDEVICE_PAGE_SELECT		0x00
+#define TASDEVICE_BOOKCTL_PAGE		0x00
+#define TASDEVICE_BOOKCTL_REG		127
+#define TASDEVICE_BOOK_ID(reg)		(reg / (256 * 128))
+#define TASDEVICE_PAGE_ID(reg)		((reg % (256 * 128)) / 128)
+#define TASDEVICE_PAGE_REG(reg)		((reg % (256 * 128)) % 128)
+#define TASDEVICE_PGRG(reg)		(reg % (256 * 128))
+#define TASDEVICE_REG(book, page, reg)	(((book * 256 * 128) + \
+					(page * 128)) + reg)
+
+/*Software Reset */
+#define TAS2781_REG_SWRESET		TASDEVICE_REG(0x0, 0X0, 0x01)
+#define TAS2781_REG_SWRESET_RESET	BIT(0)
+
+/*I2C Checksum */
+#define TASDEVICE_I2CChecksum		TASDEVICE_REG(0x0, 0x0, 0x7E)
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
+#define TAS2781_SPI_MAX_FREQ		4000000
+
+enum audio_device {
+	TAS2781,
+};
+
+enum device_catlog_id {
+	HP = 0,
+	OTHERS
+};
+
+struct tasdevice {
+	struct tasdevice_fw *cali_data_fmw;
+	unsigned int dev_addr;
+	unsigned int err_code;
+	unsigned char cur_book;
+	short cur_prog;
+	short cur_conf;
+	bool is_loading;
+	bool is_loaderr;
+};
+
+struct tasdevice_irqinfo {
+	int irq_gpio;
+	int irq;
+};
+
+struct calidata {
+	unsigned char *data;
+	unsigned long total_sz;
+};
+
+struct tasdevice_priv {
+	struct tasdevice tasdevice;
+	struct tasdevice_irqinfo irq_info;
+	struct spi_device **spi_devs;
+	struct tasdevice_rca rcabin;
+	struct calidata cali_data;
+	struct tasdevice_fw *fmw;
+	struct gpio_desc *reset;
+	struct gpio_desc *chipselect;
+	struct mutex codec_lock;
+	struct regmap *regmap;
+	struct device *dev;
+	struct tm tm;
+
+	enum device_catlog_id catlog_id;
+	const char *acpi_subsystem_id;
+	unsigned char cal_binaryname[TASDEVICE_MAX_CHANNELS][64];
+	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
+	unsigned char coef_binaryname[64];
+	unsigned char rca_binaryname[64];
+	unsigned char dev_name[32];
+	unsigned char ndev;
+	unsigned int magic_num;
+	unsigned int chip_id;
+	unsigned int sysclk;
+
+	int cur_prog;
+	int cur_conf;
+	int fw_state;
+	int index;
+	void *client;
+	void *codec;
+	bool force_fwload_status;
+	bool playback_started;
+	bool isacpi;
+	bool isspi;
+	unsigned int global_addr;
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
+int tascodec_init(struct tasdevice_priv *tas_priv, void *codec,
+	struct module *module,
+	void (*cont)(const struct firmware *fw, void *context));
+int tasdevice_save_calibration(struct tasdevice_priv *tas_priv);
+void tasdevice_apply_calibration(struct tasdevice_priv *tas_priv);
+void tasdevice_remove(struct tasdevice_priv *tas_priv);
+int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned int *value);
+int tasdevice_spi_dev_write(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned int value);
+int tasdevice_spi_dev_bulk_write(
+	struct tasdevice_priv *tas_priv, unsigned short chn,
+	unsigned int reg, unsigned char *p_data, unsigned int n_length);
+int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned char *p_data,
+	unsigned int n_length);
+int tasdevice_spi_dev_update_bits(
+	struct tasdevice_priv *tasdevice, unsigned short chn,
+	unsigned int reg, unsigned int mask, unsigned int value);
+
+void tasdevice_spi_select_cfg_blk(void *context, int conf_no,
+	unsigned char block_type);
+void tasdevice_spi_config_info_remove(void *context);
+void tasdevice_spi_dsp_remove(void *context);
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
-- 
2.40.1


