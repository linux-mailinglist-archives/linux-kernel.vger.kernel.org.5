Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFCF8042BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjLDXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjLDXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:46:09 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B52FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:46:14 -0800 (PST)
Received: from fedori.lan (51b68398.dsl.pool.telekom.hu [::ffff:81.182.131.152])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000710AB.00000000656E64C3.00114EBC; Tue, 05 Dec 2023 00:46:11 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoc: tas2563: DSP Firmware loading support
Date:   Tue,  5 Dec 2023 00:45:37 +0100
Message-ID: <c7d0fc477393550cc29624f33361d94ad987259f.1701733441.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701733441.git.soyer@irl.hu>
References: <cover.1701733441.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS2563 device has a DSP that can run firmware.
The firmware can contain up to 5 programs and 10 configurations to
support alternate audio processing.

Firmware loading is done dymacally and the program and configuration
selection is done by the user.

The binary itself contains a list of instructions for either a single
mode write or a burst write.  The single mode write is list of register
writes to different books and pages within the register map.
The burst writes is a block of data that is written to a specific
location in memory.

The firmware loader must parse and load the blocks in real time as the
binary may contain different audio profiles.

If the DSP is not needed to do audio preocessing then the DSP program
can be turned off and the device will effectively turn off the DSP.

RFC patch:
https://lore.kernel.org/lkml/6d6aaed3-dac8-e1ec-436c-9b04273df2b3@ti.com/T/

Co-developed-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 {sound/soc/codecs => include/sound}/tas2562.h |   3 +
 include/sound/tas25xx-dsp.h                   | 100 +++++++
 sound/soc/codecs/Kconfig                      |   7 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/tas2562.c                    |   2 +-
 sound/soc/codecs/tas25xx-dsp.c                | 282 ++++++++++++++++++
 6 files changed, 395 insertions(+), 1 deletion(-)
 rename {sound/soc/codecs => include/sound}/tas2562.h (97%)
 create mode 100644 include/sound/tas25xx-dsp.h
 create mode 100644 sound/soc/codecs/tas25xx-dsp.c

diff --git a/sound/soc/codecs/tas2562.h b/include/sound/tas2562.h
similarity index 97%
rename from sound/soc/codecs/tas2562.h
rename to include/sound/tas2562.h
index 55b2a1f52ca3..f000e8f5dc88 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/include/sound/tas2562.h
@@ -11,6 +11,7 @@
 #define __TAS2562_H__
 
 #define TAS2562_PAGE_CTRL	0x00
+#define TAS2562_BOOK_CTRL	0x7f
 
 #define TAS2562_REG(page, reg)	((page * 128) + reg)
 
@@ -44,6 +45,8 @@
 #define TAS2562_DVC_CFG3	TAS2562_REG(2, 0x0e)
 #define TAS2562_DVC_CFG4	TAS2562_REG(2, 0x0f)
 
+#define TAS25XX_DSP_MODE	TAS2562_REG(1, 0x02)
+
 #define TAS2562_RESET	BIT(0)
 
 #define TAS2562_MODE_MASK	GENMASK(1,0)
diff --git a/include/sound/tas25xx-dsp.h b/include/sound/tas25xx-dsp.h
new file mode 100644
index 000000000000..855e62bcf816
--- /dev/null
+++ b/include/sound/tas25xx-dsp.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tas25xx_dsp_loader.h - Texas Instruments TAS25xx Mono Audio Amplifier
+ *
+ * Copyright (C) 2020 Texas Instruments Incorporated -  http://www.ti.com
+ *
+ * Author: Dan Murphy <dmurphy@ti.com>
+ */
+
+#ifndef _TAS25XX_DSP_LOADER_H
+#define _TAS25XX_DSP_LOADER_H
+
+#define TAS25XX_NAME_SIZE	64
+#define TAS25XX_PROG_SIZE	5
+#define TAS25XX_CONFIG_SIZE	10
+
+#define TAS25XX_CMD_SING_W	0x1
+#define TAS25XX_CMD_BURST	0x2
+#define TAS25XX_CMD_DELAY	0x3
+
+struct tas25xx_cmd_reg {
+	u8 book;
+	u8 page;
+	u8 offset;
+	u8 data;
+};
+
+struct tas25xx_cmd_hdr {
+	u16 cmd_type;
+	u16 length;
+};
+
+struct tas25xx_cmd {
+	struct tas25xx_cmd_hdr hdr;
+	struct tas25xx_cmd_reg reg;
+};
+
+struct tas25xx_block_data {
+	u32 block_type;
+	u16 pram_checksum;
+	u16 yram_checksum;
+	u32 block_size;
+	u32 num_subblocks;
+};
+
+struct tas25xx_program_info {
+	char name[TAS25XX_NAME_SIZE];
+	u8 app_mode;
+	u8 pdm_i2s_mode;
+	u8 isns_pd;
+	u8 vsns_pd;
+	u8 reserved_1;
+	u16 reserved_2;
+	u8 ldg_power_up;
+	struct tas25xx_block_data blk_data;
+};
+
+struct tas25xx_config_info {
+	char name[TAS25XX_NAME_SIZE];
+	u16 devices;
+	u16 program;
+	u32 samp_rate;
+	u16 clk_src;
+	u16 sbclk_fs_ratio;
+	u32 clk_freq;
+	u32 num_blocks;
+	struct tas25xx_block_data blk_data;
+};
+
+struct tas25xx_fw_hdr {
+	u32 magic_num;
+	u32 image_size;
+	u32 checksum;
+	u32 version_num;
+	u32 dsp_version;
+	u32 drv_fw_version;
+	u32 timestamp;
+	char firmware_name[TAS25XX_NAME_SIZE];
+	u16 dev_family;
+	u16 dev_subfamily;
+	u32 num_programs;
+	u32 prog_size[TAS25XX_PROG_SIZE];
+	u32 num_configs;
+	u32 config_size[TAS25XX_CONFIG_SIZE];
+};
+
+struct tas25xx_fw_data {
+	struct tas25xx_fw_hdr *hdr;
+	u8 *config_data;
+	u8 *prog_data;
+};
+
+struct tas25xx_fw_data *tas25xx_parse_fw(struct device *dev,
+	const struct firmware *fw);
+int tas25xx_write_config(struct device *dev, struct regmap *regmap,
+	struct tas25xx_fw_data *fw_data, int config_num);
+int tas25xx_write_program(struct device *dev, struct regmap *regmap,
+	struct tas25xx_fw_data *fw_data, int prog_num);
+
+#endif /* _TAS25XX_DSP_LOADER_H */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1e1dbc509f6..86e66d7e4bdc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -238,6 +238,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_STI_SAS
 	imply SND_SOC_TAS2552
 	imply SND_SOC_TAS2562
+	imply SND_SOC_TAS2562_DSP
 	imply SND_SOC_TAS2764
 	imply SND_SOC_TAS2770
 	imply SND_SOC_TAS2780
@@ -1761,6 +1762,12 @@ config SND_SOC_TAS2552
 	tristate "Texas Instruments TAS2552 Mono Audio amplifier"
 	depends on I2C
 
+config SND_SOC_TAS25XX_DSP
+	depends on I2C
+	select REGMAP_I2C
+	tristate
+	default n
+
 config SND_SOC_TAS2562
 	tristate "Texas Instruments TAS2562 Mono Audio amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a87e56938ce5..807fcbb43cf5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -378,6 +378,7 @@ snd-soc-max98504-objs := max98504.o
 snd-soc-simple-amplifier-objs := simple-amplifier.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
 snd-soc-tas2552-objs := tas2552.o
+snd-soc-tas25xx-dsp-objs := tas25xx-dsp.o
 snd-soc-tas2562-objs := tas2562.o
 snd-soc-tas2764-objs := tas2764.o
 snd-soc-tas2780-objs := tas2780.o
@@ -651,6 +652,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_STI_SAS)	+= snd-soc-sti-sas.o
 obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS2562)	+= snd-soc-tas2562.o
+obj-$(CONFIG_SND_SOC_TAS25XX_DSP)	+= snd-soc-tas25xx-dsp.o
 obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS2780)	+= snd-soc-tas2780.o
 obj-$(CONFIG_SND_SOC_TAS2781_COMLIB)	+= snd-soc-tas2781-comlib.o
diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 962c2cdfa017..ca6e9d60b255 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -20,7 +20,7 @@
 #include <sound/soc-dapm.h>
 #include <sound/tlv.h>
 
-#include "tas2562.h"
+#include <sound/tas2562.h>
 
 #define TAS2562_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |\
 			 SNDRV_PCM_FORMAT_S32_LE)
diff --git a/sound/soc/codecs/tas25xx-dsp.c b/sound/soc/codecs/tas25xx-dsp.c
new file mode 100644
index 000000000000..d5081fa01441
--- /dev/null
+++ b/sound/soc/codecs/tas25xx-dsp.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Firmware loader for the Texas Instruments TAS25XX DSP
+// Copyright (C) 2020 Texas Instruments Inc.
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <sound/tas2562.h>
+#include <sound/tas25xx-dsp.h>
+
+
+static void tas25xx_process_fw_delay(struct tas25xx_cmd *cmd)
+{
+	mdelay(cpu_to_be16(cmd->hdr.length));
+}
+
+static int tas25xx_process_fw_single(struct regmap *regmap,
+	struct tas25xx_cmd *cmd)
+{
+	int ret;
+	int num_writes = cpu_to_be16(cmd->hdr.length);
+	struct tas25xx_cmd_reg *reg = &cmd->reg;
+
+	for (int i = 0; i < num_writes; i++, reg++) {
+		/* Reset Page to 0 to access BOOK_CTRL */
+		ret = regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(regmap, TAS2562_BOOK_CTRL, reg->book);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(regmap, TAS2562_REG(reg->page, reg->offset),
+			reg->data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int tas25xx_process_fw_burst(struct regmap *regmap,
+	struct tas25xx_cmd *cmd)
+{
+	int ret;
+
+	/* Reset Page to 0 to access BOOK_CTRL */
+	ret = regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, TAS2562_BOOK_CTRL, cmd->reg.book);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_write(regmap, TAS2562_REG(cmd->reg.page, cmd->reg.offset), &cmd[1],
+				cpu_to_be16(cmd->hdr.length));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tas25xx_process_block(struct device *dev, struct regmap *regmap,
+	struct tas25xx_cmd *cmd, int max_block_size)
+{
+	int ret;
+	int block_read;
+
+	const int hdr_size = sizeof(struct tas25xx_cmd_hdr);
+	const int reg_size = sizeof(struct tas25xx_cmd_reg);
+	const int cmd_size = sizeof(struct tas25xx_cmd);
+
+	switch (cpu_to_be16(cmd->hdr.cmd_type)) {
+	case TAS25XX_CMD_SING_W:
+		block_read = cpu_to_be16(cmd->hdr.length) * reg_size + hdr_size;
+		break;
+	case TAS25XX_CMD_BURST:
+		block_read = cpu_to_be16(cmd->hdr.length) + cmd_size;
+		break;
+	case TAS25XX_CMD_DELAY:
+		block_read = 4;
+		break;
+	default:
+		block_read = 0;
+	}
+
+	if (block_read > max_block_size) {
+		dev_err(dev,
+			"Corrupt firmware: block_read > max_block_size %d %d\n",
+			block_read, max_block_size);
+		return -EINVAL;
+	}
+
+	switch (cpu_to_be16(cmd->hdr.cmd_type)) {
+	case TAS25XX_CMD_SING_W:
+		ret = tas25xx_process_fw_single(regmap, cmd);
+		if (ret) {
+			dev_err(dev, "Failed to process single write %d\n",
+				ret);
+			return ret;
+		}
+		break;
+	case TAS25XX_CMD_BURST:
+		ret = tas25xx_process_fw_burst(regmap, cmd);
+		if (ret) {
+			dev_err(dev, "Failed to process burst write %d\n", ret);
+			return ret;
+		}
+		break;
+	case TAS25XX_CMD_DELAY:
+		tas25xx_process_fw_delay(cmd);
+		break;
+	default:
+		dev_warn(dev, "Unknown cmd type %d\n",
+			cpu_to_be16(cmd->hdr.cmd_type));
+		break;
+	};
+
+	return block_read;
+}
+
+
+int tas25xx_write_program(struct device *dev, struct regmap *regmap,
+	struct tas25xx_fw_data *fw_data, int prog_num)
+{
+	int offset = 0;
+	int length = 0;
+	struct tas25xx_program_info *prog_info;
+	struct tas25xx_fw_hdr *hdr = fw_data->hdr;
+	struct tas25xx_cmd *cmd;
+
+	if (prog_num > cpu_to_be32(hdr->num_programs))
+		return -EINVAL;
+
+	for (int i = 0; i < prog_num; i++)
+		offset += cpu_to_be32(hdr->prog_size[i]);
+
+	prog_info = (struct tas25xx_program_info *)&fw_data->prog_data[offset];
+	dev_info(dev, "Write program %d: %s\n", prog_num, prog_info->name);
+
+	int max_offset = offset + cpu_to_be32(hdr->prog_size[prog_num]);
+	int num_subblocks = cpu_to_be32(prog_info->blk_data.num_subblocks);
+
+	offset += sizeof(struct tas25xx_program_info);
+
+	for (int i = 0; i < num_subblocks; i++) {
+		cmd = (struct tas25xx_cmd *)&fw_data->prog_data[offset];
+		length = tas25xx_process_block(dev, regmap, cmd,
+			max_offset - offset);
+		if (length < 0)
+			return length;
+
+		offset += length;
+	}
+
+	/* Reset Book to 0 */
+	regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
+	regmap_write(regmap, TAS2562_BOOK_CTRL, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tas25xx_write_program);
+
+int tas25xx_write_config(struct device *dev, struct regmap *regmap,
+	struct tas25xx_fw_data *fw_data, int config_num)
+{
+	int offset = 0;
+	int length = 0;
+	struct tas25xx_config_info *cfg_info;
+	struct tas25xx_fw_hdr *hdr = fw_data->hdr;
+	struct tas25xx_cmd *cmd;
+
+	if (config_num > cpu_to_be32(hdr->num_configs))
+		return -EINVAL;
+
+	for (int i = 0; i < config_num; i++)
+		offset += cpu_to_be32(hdr->config_size[i]);
+
+	cfg_info = (struct tas25xx_config_info *)&fw_data->config_data[offset];
+	dev_info(dev, "Write config %d: %s\n", config_num, cfg_info->name);
+
+	int max_offset = offset + cpu_to_be32(hdr->config_size[config_num]);
+	int num_subblocks = cpu_to_be32(cfg_info->blk_data.num_subblocks);
+
+	offset += sizeof(struct tas25xx_config_info);
+
+	for (int i = 0; i < num_subblocks; i++) {
+		cmd = (struct tas25xx_cmd *)&fw_data->config_data[offset];
+		length = tas25xx_process_block(dev, regmap, cmd,
+			max_offset - offset);
+		if (length < 0)
+			return length;
+
+		offset += length;
+	}
+
+	/* Reset Book to 0 */
+	regmap_write(regmap, TAS2562_PAGE_CTRL, 0);
+	regmap_write(regmap, TAS2562_BOOK_CTRL, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tas25xx_write_config);
+
+
+struct tas25xx_fw_data *tas25xx_parse_fw(struct device *dev,
+	const struct firmware *fw)
+{
+	u32 total_prog_sz = 0;
+	u32 total_config_sz = 0;
+	u32 prog_num = 0;
+	u32 config_num = 0;
+	int hdr_size = sizeof(struct tas25xx_fw_hdr);
+	struct tas25xx_fw_data *fw_data = NULL;
+
+	fw_data = devm_kzalloc(dev, sizeof(struct tas25xx_fw_data), GFP_KERNEL);
+	if (!fw_data)
+		goto err_fw;
+
+	if (fw->size < hdr_size)
+		goto err_data;
+
+	fw_data->hdr = devm_kzalloc(dev, hdr_size, GFP_KERNEL);
+	if (!fw_data->hdr)
+		goto err_data;
+
+	memcpy(fw_data->hdr, &fw->data[0], hdr_size);
+
+	for (int i = 0; i < cpu_to_be32(fw_data->hdr->num_programs); i++)
+		total_prog_sz += cpu_to_be32(fw_data->hdr->prog_size[i]);
+
+	for (int i = 0; i < cpu_to_be32(fw_data->hdr->num_configs); i++)
+		total_config_sz += cpu_to_be32(fw_data->hdr->config_size[i]);
+
+	if (fw->size < hdr_size + total_prog_sz + total_config_sz)
+		goto err_hdr;
+
+	fw_data->prog_data = devm_kzalloc(dev, total_prog_sz, GFP_KERNEL);
+	if (!fw_data->prog_data)
+		goto err_hdr;
+
+	memcpy(fw_data->prog_data, &fw->data[hdr_size], total_prog_sz);
+
+	fw_data->config_data = devm_kzalloc(dev, total_config_sz, GFP_KERNEL);
+	if (!fw_data->config_data)
+		goto err_prog;
+
+	memcpy(fw_data->config_data, &fw->data[hdr_size + total_prog_sz],
+		total_config_sz);
+
+	prog_num = cpu_to_be32(fw_data->hdr->num_programs);
+	config_num = cpu_to_be32(fw_data->hdr->num_configs);
+	dev_info(dev, "Firmware loaded: programs %d, configs %d\n",
+		prog_num, config_num);
+
+	return fw_data;
+
+err_prog:
+	devm_kfree(dev, fw_data->prog_data);
+err_hdr:
+	devm_kfree(dev, fw_data->hdr);
+err_data:
+	devm_kfree(dev, fw_data);
+err_fw:
+	release_firmware(fw);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(tas25xx_parse_fw);
+
+MODULE_DESCRIPTION("TAS25xx DSP library");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0

