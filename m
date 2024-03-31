Return-Path: <linux-kernel+bounces-125926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CC892E49
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187BF2823D4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82F579CC;
	Sun, 31 Mar 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lqRTEy9G"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03124EC3;
	Sun, 31 Mar 2024 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711851594; cv=none; b=avv+Ljmb0UvLAY4ntw/wdbcEeq8rbDzTHp/0ZwrlzkuG8JqCo7GXuzmAzFwZQbTKwBRZKpu69rlsxv9B881V8/1qKbmp3VpFDLArv6HPeudwkN2ZOC5FUoUiqEVFXCpDg5Dio7+UPBqv3fBN3YEwQJNwG77nWhIxOTgubgd+qJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711851594; c=relaxed/simple;
	bh=aeVYM9LPIF1VBhVfGl5ZCsQcbJAgoLrdLmeB/5aaZr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Twp4McYFhJTgCZLa5/7beRx4c1kOFJqaRzsPA8v2w42bNv17KzjCT2nXucW8KSfhfYQJ3WYXNRKF17oSgoEPndgjxi/cLaELbW1QKnQrHySE5qmcUZxRgY9bQUZUVdCMN53QVae/cebjRNd64H86eHl1wUE5pMjy4HhuvfG1l9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lqRTEy9G; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42V2J2Fq068506;
	Sat, 30 Mar 2024 21:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711851542;
	bh=jbFIAm0rOMd7iNLnbOXonklm8C58zKPtSiuWJ2ldQo4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lqRTEy9G2GwZIBpA1mh6i+u0ZNWaVA0+qolwXr8wVpWb6H1NcW65eqt5AjgqU9HdF
	 lpgDbr/zmfWxoxuxFQlNR7Em5BoDjEQYT3VXk1t6Kcv/4cOBpTgbKnFVJN5ho9vdig
	 mJWB3COKDoMcIZuT7knUHOQq3v8SzYMcyfAubjbM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42V2J2OY047883
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 30 Mar 2024 21:19:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 30
 Mar 2024 21:19:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 30 Mar 2024 21:19:01 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42V2IcmB106026;
	Sat, 30 Mar 2024 21:18:55 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <13916275206@139.com>,
        <mohit.chawla@ti.com>, <soyer@irl.hu>, <jkhuang3@ti.com>,
        <tiwai@suse.de>, <pdjuandi@ti.com>, <manisha.agrawal@ti.com>,
        <s-hari@ti.com>, <aviel@ti.com>, <hnagalla@ti.com>, <praneeth@ti.com>,
        <Baojun.Xu@fpt.com>, Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [PATCH v7 2/4] ASoc: PCM6240: Create header file for PCM6240 Family driver code
Date: Sun, 31 Mar 2024 10:18:32 +0800
Message-ID: <20240331021835.1470-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20240331021835.1470-1-shenghao-ding@ti.com>
References: <20240331021835.1470-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PCM6240 driver implements a flexible and configurable setting for register
and filter coefficients, to one, two or even multiple PCM6240 Family Audio
chips.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v7:
 - remove unused data structure.
---
 sound/soc/codecs/pcm6240.h | 236 +++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)
 create mode 100644 sound/soc/codecs/pcm6240.h

diff --git a/sound/soc/codecs/pcm6240.h b/sound/soc/codecs/pcm6240.h
new file mode 100644
index 000000000000..49a313305b26
--- /dev/null
+++ b/sound/soc/codecs/pcm6240.h
@@ -0,0 +1,236 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+//
+// ALSA SoC Texas Instruments PCM6240 Family Audio ADC/DAC/Router
+//
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
+// https://www.ti.com
+//
+// The PCM6240 driver implements a flexible and configurable
+// algo coefficient setting for one, two, or even multiple
+// PCM6240 Family Audio chips.
+//
+// Author: Shenghao Ding <shenghao-ding@ti.com>
+//
+
+#ifndef __PCM6240_H__
+#define __PCM6240_H__
+
+enum pcm_device {
+	ADC3120,
+	ADC5120,
+	ADC6120,
+	DIX4192,
+	PCM1690,
+	PCM3120,
+	PCM3140,
+	PCM5120,
+	PCM5140,
+	PCM6120,
+	PCM6140,
+	PCM6240,
+	PCM6260,
+	PCM9211,
+	PCMD3140,
+	PCMD3180,
+	PCMD512X,
+	TAA5212,
+	TAA5412,
+	TAD5212,
+	TAD5412,
+	MAX_DEVICE,
+};
+
+#define PCMDEV_GENERIC_VOL_CTRL			0x0
+#define PCMDEV_PCM1690_VOL_CTRL			0x1
+#define PCMDEV_PCM1690_FINE_VOL_CTRL		0x2
+
+/* Maximum number of I2C addresses */
+#define PCMDEVICE_MAX_I2C_DEVICES		4
+/* Maximum number defined in REGBIN protocol */
+#define PCMDEVICE_MAX_REGBIN_DEVICES		8
+#define PCMDEVICE_CONFIG_SUM			64
+#define PCMDEVICE_BIN_FILENAME_LEN		64
+
+#define PCMDEVICE_RATES	(SNDRV_PCM_RATE_44100 | \
+	SNDRV_PCM_RATE_48000)
+#define PCMDEVICE_MAX_CHANNELS			8
+#define PCMDEVICE_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+	SNDRV_PCM_FMTBIT_S20_3LE | \
+	SNDRV_PCM_FMTBIT_S24_3LE | \
+	SNDRV_PCM_FMTBIT_S24_LE | \
+	SNDRV_PCM_FMTBIT_S32_LE)
+
+/* PAGE Control Register (available in page0 of each book) */
+#define PCMDEVICE_PAGE_SELECT			0x00
+#define PCMDEVICE_REG(page, reg)		((page * 128) + reg)
+#define PCMDEVICE_REG_SWRESET			PCMDEVICE_REG(0X0, 0x01)
+#define PCMDEVICE_REG_SWRESET_RESET		BIT(0)
+
+#define ADC5120_REG_CH1_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x3d)
+#define ADC5120_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x3e)
+#define ADC5120_REG_CH2_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x42)
+#define ADC5120_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x43)
+
+#define PCM1690_REG_MODE_CTRL			PCMDEVICE_REG(0X0, 0x46)
+#define PCM1690_REG_MODE_CTRL_DAMS_MSK		BIT(7)
+#define PCM1690_REG_MODE_CTRL_DAMS_FINE_STEP	0x0
+#define PCM1690_REG_MODE_CTRL_DAMS_WIDE_RANGE	0x80
+
+#define PCM1690_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x48)
+#define PCM1690_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x49)
+#define PCM1690_REG_CH3_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4a)
+#define PCM1690_REG_CH4_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4b)
+#define PCM1690_REG_CH5_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4c)
+#define PCM1690_REG_CH6_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4d)
+#define PCM1690_REG_CH7_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4e)
+#define PCM1690_REG_CH8_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4f)
+
+#define PCM6240_REG_CH1_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x3d)
+#define PCM6240_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x3e)
+#define PCM6240_REG_CH2_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x42)
+#define PCM6240_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x43)
+#define PCM6240_REG_CH3_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x47)
+#define PCM6240_REG_CH3_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x48)
+#define PCM6240_REG_CH4_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x4c)
+#define PCM6240_REG_CH4_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4d)
+
+#define PCM6260_REG_CH1_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x3d)
+#define PCM6260_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x3e)
+#define PCM6260_REG_CH2_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x42)
+#define PCM6260_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x43)
+#define PCM6260_REG_CH3_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x47)
+#define PCM6260_REG_CH3_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x48)
+#define PCM6260_REG_CH4_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x4c)
+#define PCM6260_REG_CH4_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4d)
+#define PCM6260_REG_CH5_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x51)
+#define PCM6260_REG_CH5_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x52)
+#define PCM6260_REG_CH6_ANALOG_GAIN		PCMDEVICE_REG(0X0, 0x56)
+#define PCM6260_REG_CH6_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x57)
+
+#define PCM9211_REG_SW_CTRL			PCMDEVICE_REG(0X0, 0x40)
+#define PCM9211_REG_SW_CTRL_MRST_MSK		BIT(7)
+#define PCM9211_REG_SW_CTRL_MRST		0x0
+
+#define PCM9211_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x46)
+#define PCM9211_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x47)
+
+#define PCMD3140_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x3E)
+#define PCMD3140_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x43)
+#define PCMD3140_REG_CH3_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x48)
+#define PCMD3140_REG_CH4_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4D)
+
+#define PCMD3180_REG_CH1_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x3E)
+#define PCMD3180_REG_CH2_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x43)
+#define PCMD3180_REG_CH3_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x48)
+#define PCMD3180_REG_CH4_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x4D)
+#define PCMD3180_REG_CH5_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x52)
+#define PCMD3180_REG_CH6_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x57)
+#define PCMD3180_REG_CH7_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x5C)
+#define PCMD3180_REG_CH8_DIGITAL_GAIN		PCMDEVICE_REG(0X0, 0x61)
+
+#define TAA5412_REG_CH1_DIGITAL_VOLUME		PCMDEVICE_REG(0X0, 0x52)
+#define TAA5412_REG_CH2_DIGITAL_VOLUME		PCMDEVICE_REG(0X0, 0x57)
+#define TAA5412_REG_CH3_DIGITAL_VOLUME		PCMDEVICE_REG(0X0, 0x5B)
+#define TAA5412_REG_CH4_DIGITAL_VOLUME		PCMDEVICE_REG(0X0, 0x5F)
+
+#define TAA5412_REG_CH1_FINE_GAIN		PCMDEVICE_REG(0X0, 0x53)
+#define TAA5412_REG_CH2_FINE_GAIN		PCMDEVICE_REG(0X0, 0x58)
+#define TAA5412_REG_CH3_FINE_GAIN		PCMDEVICE_REG(0X0, 0x5C)
+#define TAA5412_REG_CH4_FINE_GAIN		PCMDEVICE_REG(0X0, 0x60)
+
+#define PCMDEVICE_CMD_SING_W		0x1
+#define PCMDEVICE_CMD_BURST		0x2
+#define PCMDEVICE_CMD_DELAY		0x3
+#define PCMDEVICE_CMD_FIELD_W		0x4
+
+enum pcmdevice_bin_blk_type {
+	PCMDEVICE_BIN_BLK_COEFF = 1,
+	PCMDEVICE_BIN_BLK_POST_POWER_UP,
+	PCMDEVICE_BIN_BLK_PRE_SHUTDOWN,
+	PCMDEVICE_BIN_BLK_PRE_POWER_UP,
+	PCMDEVICE_BIN_BLK_POST_SHUTDOWN
+};
+
+enum pcmdevice_fw_state {
+	PCMDEVICE_FW_LOAD_OK = 0,
+	PCMDEVICE_FW_LOAD_FAILED
+};
+
+struct pcmdevice_regbin_hdr {
+	unsigned int img_sz;
+	unsigned int checksum;
+	unsigned int binary_version_num;
+	unsigned int drv_fw_version;
+	unsigned int timestamp;
+	unsigned char plat_type;
+	unsigned char dev_family;
+	unsigned char reserve;
+	unsigned char ndev;
+	unsigned char devs[PCMDEVICE_MAX_REGBIN_DEVICES];
+	unsigned int nconfig;
+	unsigned int config_size[PCMDEVICE_CONFIG_SUM];
+};
+
+struct pcmdevice_block_data {
+	unsigned char dev_idx;
+	unsigned char block_type;
+	unsigned short yram_checksum;
+	unsigned int block_size;
+	unsigned int n_subblks;
+	unsigned char *regdata;
+};
+
+struct pcmdevice_config_info {
+	char cfg_name[64];
+	unsigned int nblocks;
+	unsigned int real_nblocks;
+	unsigned char active_dev;
+	struct pcmdevice_block_data **blk_data;
+};
+
+struct pcmdevice_regbin {
+	struct pcmdevice_regbin_hdr fw_hdr;
+	int ncfgs;
+	struct pcmdevice_config_info **cfg_info;
+};
+
+struct pcmdevice_irqinfo {
+	int gpio;
+	int nmb;
+};
+
+struct pcmdevice_priv {
+	struct snd_soc_component *component;
+	struct i2c_client *client;
+	struct device *dev;
+	struct mutex codec_lock;
+	struct gpio_desc *hw_rst;
+	struct regmap *regmap;
+	struct pcmdevice_regbin regbin;
+	struct pcmdevice_irqinfo irq_info;
+	unsigned int addr[PCMDEVICE_MAX_I2C_DEVICES];
+	unsigned int chip_id;
+	int cur_conf;
+	int fw_state;
+	int ndev;
+	unsigned char bin_name[PCMDEVICE_BIN_FILENAME_LEN];
+	unsigned char dev_name[I2C_NAME_SIZE];
+};
+
+/* mixer control */
+struct pcmdevice_mixer_control {
+	int max;
+	int reg;
+	unsigned int dev_no;
+	unsigned int shift;
+	unsigned int invert;
+};
+struct pcmdev_ctrl_info {
+	const unsigned int *gain;
+	const struct pcmdevice_mixer_control *pcmdev_ctrl;
+	unsigned int ctrl_array_size;
+	snd_kcontrol_get_t *get;
+	snd_kcontrol_put_t *put;
+	int pcmdev_ctrl_name_id;
+};
+#endif /* __PCM6240_H__ */
-- 
2.34.1


