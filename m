Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3C8042BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjLDXqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjLDXqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:46:09 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E24FFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:46:14 -0800 (PST)
Received: from fedori.lan (51b68398.dsl.pool.telekom.hu [::ffff:81.182.131.152])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000710AC.00000000656E64C4.00114ECE; Tue, 05 Dec 2023 00:46:12 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 2/2] ALSA: hda/tas2563: Add tas2563 HDA driver
Date:   Tue,  5 Dec 2023 00:45:38 +0100
Message-ID: <4a2f31d4eb8479789ceb1daf2e93ec0e25c23171.1701733441.git.soyer@irl.hu>
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

Create tas2563 side codec HDA driver for Lenovo Yoga 7 14ARB7 laptops.
It has two smart amplifiers that can load firmware (tuning file) and
calibration data. The calibration data can be read from EFI variables.
All of the tas2563s in the laptop will be aggregated as one audio
speaker. The code supports realtek codec as the primary codec.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2562.h         |   5 +
 sound/pci/hda/Kconfig           |  14 +
 sound/pci/hda/Makefile          |   2 +
 sound/pci/hda/patch_realtek.c   |  22 +-
 sound/pci/hda/tas2563_hda_i2c.c | 508 ++++++++++++++++++++++++++++++++
 5 files changed, 547 insertions(+), 4 deletions(-)
 create mode 100644 sound/pci/hda/tas2563_hda_i2c.c

diff --git a/include/sound/tas2562.h b/include/sound/tas2562.h
index f000e8f5dc88..6d246a5db433 100644
--- a/include/sound/tas2562.h
+++ b/include/sound/tas2562.h
@@ -33,6 +33,11 @@
 #define TAS2562_TDM_CFG9	TAS2562_REG(0, 0x0f)
 #define TAS2562_TDM_CFG10	TAS2562_REG(0, 0x10)
 #define TAS2562_TDM_DET		TAS2562_REG(0, 0x11)
+#define TAS2562_BOOST_CFG1	TAS2562_REG(0, 0x33)
+#define TAS2562_BOOST_CFG2	TAS2562_REG(0, 0x34)
+#define TAS2562_BOOST_CFG3	TAS2562_REG(0, 0x35)
+#define TAS2562_BOOST_CFG4	TAS2562_REG(0, 0x40)
+#define TAS2562_ASI_CONFIG3	TAS2562_REG(0, 0x46)
 #define TAS2562_REV_ID		TAS2562_REG(0, 0x7d)
 
 #define TAS2562_RX_OFF_MASK	GENMASK(5, 1)
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 0d7502d6e060..364d1331f597 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -179,6 +179,20 @@ config SND_HDA_SCODEC_TAS2781_I2C
 comment "Set to Y if you want auto-loading the side codec driver"
 	depends on SND_HDA=y && SND_HDA_SCODEC_TAS2781_I2C=m
 
+config SND_HDA_SCODEC_TAS2563_I2C
+	tristate "Build TAS2563 HD-audio side codec support for I2C Bus"
+	depends on I2C
+	depends on ACPI
+	depends on EFI
+	depends on SND_SOC
+	select SND_SOC_TAS25XX_DSP
+	help
+	  Say Y or M here to include TAS2563 I2C HD-audio side codec support
+	  in snd-hda-intel driver, such as ALC287.
+
+comment "Set to Y if you want auto-loading the side codec driver"
+	depends on SND_HDA=y && SND_HDA_SCODEC_TAS2562_I2C=m
+
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index f00fc9ed6096..d746fab82d89 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -36,6 +36,7 @@ snd-hda-scodec-cs35l56-i2c-objs :=	cs35l56_hda_i2c.o
 snd-hda-scodec-cs35l56-spi-objs :=	cs35l56_hda_spi.o
 snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
 snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
+snd-hda-scodec-tas2563-i2c-objs :=	tas2563_hda_i2c.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
@@ -64,6 +65,7 @@ obj-$(CONFIG_SND_HDA_SCODEC_CS35L56_I2C) += snd-hda-scodec-cs35l56-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L56_SPI) += snd-hda-scodec-cs35l56-spi.o
 obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
 obj-$(CONFIG_SND_HDA_SCODEC_TAS2781_I2C) += snd-hda-scodec-tas2781-i2c.o
+obj-$(CONFIG_SND_HDA_SCODEC_TAS2563_I2C) += snd-hda-scodec-tas2563-i2c.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9677c09cf7a9..1d3e9f77c9d4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6770,7 +6770,7 @@ static int comp_match_cs35l41_dev_name(struct device *dev, void *data)
 	return !strcmp(d + n, tmp);
 }
 
-static int comp_match_tas2781_dev_name(struct device *dev,
+static int comp_match_tas2xxx_dev_name(struct device *dev,
 	void *data)
 {
 	struct scodec_dev_name *p = data;
@@ -6823,7 +6823,7 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 	}
 }
 
-static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
+static void tas2xxx_generic_fixup(struct hda_codec *cdc, int action,
 	const char *bus, const char *hid)
 {
 	struct device *dev = hda_codec_dev(cdc);
@@ -6841,7 +6841,7 @@ static void tas2781_generic_fixup(struct hda_codec *cdc, int action,
 		rec->index = 0;
 		spec->comps[0].codec = cdc;
 		component_match_add(dev, &spec->match,
-			comp_match_tas2781_dev_name, rec);
+			comp_match_tas2xxx_dev_name, rec);
 		ret = component_master_add_with_match(dev, &comp_master_ops,
 			spec->match);
 		if (ret)
@@ -6888,7 +6888,13 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
-	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
+	 tas2xxx_generic_fixup(cdc, action, "i2c", "TIAS2781");
+}
+
+static void tas2563_fixup_i2c(struct hda_codec *cdc,
+	const struct hda_fixup *fix, int action)
+{
+	 tas2xxx_generic_fixup(cdc, action, "i2c", "INT8866");
 }
 
 /* for alc295_fixup_hp_top_speakers */
@@ -7358,6 +7364,7 @@ enum {
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 	ALC287_FIXUP_TAS2781_I2C,
+	ALC287_FIXUP_TAS2563_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
@@ -9447,6 +9454,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
+	[ALC287_FIXUP_TAS2563_I2C] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = tas2563_fixup_i2c,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
+	},
 	[ALC245_FIXUP_HP_MUTE_LED_COEFBIT] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_coefbit,
@@ -10056,6 +10069,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_TAS2563_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387d, "Yoga S780-16 pro Quad AAC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x387e, "Yoga S780-16 pro Quad YC", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3881, "YB9 dual power mode2 YC", ALC287_FIXUP_TAS2781_I2C),
diff --git a/sound/pci/hda/tas2563_hda_i2c.c b/sound/pci/hda/tas2563_hda_i2c.c
new file mode 100644
index 000000000000..14f7c1ab6cbc
--- /dev/null
+++ b/sound/pci/hda/tas2563_hda_i2c.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// TAS2563 HDA I2C driver
+//
+// Copyright (C) 2023 Gergo Koteles <soyer@irl.hu>
+
+#include <linux/acpi.h>
+#include <linux/crc8.h>
+#include <linux/crc32.h>
+#include <linux/efi.h>
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/hda_codec.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include <sound/tas2562.h>
+#include <sound/tas25xx-dsp.h>
+
+#include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_component.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+
+#define TAS2563_GLOBAL_ADDR		0x48
+#define TAS2563_MAX_CHANNELS	2
+
+#define TAS2562_SW_RESET_RESET	BIT(0)
+#define TAS2562_PWR_ACTIVE	0
+#define TAS2562_PWR_SUSPEND	BIT(1)
+
+
+#define TAS2563_CAL_POWER	TAS2562_REG(0x0d, 0x3c)
+#define TAS2563_CAL_R0		TAS2562_REG(0x0f, 0x34)
+#define TAS2563_CAL_INVR0	TAS2562_REG(0x0f, 0x40)
+#define TAS2563_CAL_R0_LOW	TAS2562_REG(0x0f, 0x48)
+#define TAS2563_CAL_TLIM	TAS2562_REG(0x10, 0x14)
+#define TAS2563_CAL_N		5
+#define TAS2563_CAL_DATA_SIZE	4
+
+static unsigned int cal_regs[TAS2563_CAL_N] = {
+	TAS2563_CAL_POWER, TAS2563_CAL_R0, TAS2563_CAL_INVR0,
+	TAS2563_CAL_R0_LOW, TAS2563_CAL_TLIM,
+};
+
+static efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, 0x09,
+		0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
+
+static efi_char16_t *efi_var_names[TAS2563_MAX_CHANNELS][TAS2563_CAL_N] = {
+	{ L"Power_1", L"R0_1", L"InvR0_1", L"R0_Low_1", L"TLim_1" },
+	{ L"Power_2", L"R0_2", L"InvR0_2", L"R0_Low_2", L"TLim_2" },
+};
+
+struct tas2563_dev {
+	unsigned char dev_id;
+	unsigned int i2c_addr;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	uint32_t cal_data[TAS2563_CAL_N];
+};
+
+struct tas2563_data {
+	struct device *dev;
+	struct i2c_client *client;
+	struct tas2563_dev tasdevs[TAS2563_MAX_CHANNELS];
+	unsigned char ndev;
+	char firmware_name[32];
+	struct tas25xx_fw_data *fw_data;
+};
+
+static const struct regmap_range_cfg tas2563_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = 255 * 128,
+		.selector_reg = TAS2562_PAGE_CTRL,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 128,
+	},
+};
+
+static const struct regmap_config tas2563_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = 255 * 128,
+	.cache_type = REGCACHE_NONE,
+	.ranges = tas2563_ranges,
+	.num_ranges = ARRAY_SIZE(tas2563_ranges),
+};
+
+#define TAS2563_REG_INIT_N 12
+static const struct reg_default tas2563_reg_init[TAS2563_MAX_CHANNELS]
+	[TAS2563_REG_INIT_N] = {
+	{
+		{ TAS2562_TDM_CFG2, 0x5a },
+		{ TAS2562_TDM_CFG4, 0xf3 },
+		{ TAS2562_TDM_CFG5, 0x42 },
+		{ TAS2562_TDM_CFG6, 0x40 },
+		{ TAS2562_BOOST_CFG1, 0xd4 },
+		{ TAS2562_BOOST_CFG3, 0xa4 },
+		{ TAS2562_REG(0x00, 0x36), 0x0b },
+		{ TAS2562_REG(0x00, 0x38), 0x21 },
+		{ TAS2562_REG(0x00, 0x3c), 0x58 },
+		{ TAS2562_BOOST_CFG4, 0xb6 },
+		{ TAS2562_ASI_CONFIG3, 0x04},
+		{ TAS2562_REG(0x00, 0x47), 0xb1 },
+	},
+	{
+		{ TAS2562_TDM_CFG2, 0x6a },
+		{ TAS2562_TDM_CFG4, 0x93 },
+		{ TAS2562_TDM_CFG5, 0x46 },
+		{ TAS2562_TDM_CFG6, 0x44 },
+		{ TAS2562_BOOST_CFG1, 0xd4 },
+		{ TAS2562_BOOST_CFG3, 0xa4 },
+		{ TAS2562_REG(0x00, 0x36), 0x0c },
+		{ TAS2562_REG(0x00, 0x38), 0x21 },
+		{ TAS2562_REG(0x00, 0x3c), 0x58 },
+		{ TAS2562_BOOST_CFG4, 0xb6 },
+		{ TAS2562_ASI_CONFIG3, 0x05},
+		{ TAS2562_REG(0x00, 0x47), 0xb0 },
+	},
+};
+
+static void tas2563_set_power(struct tas2563_data *tas2563, char power)
+{
+	int ret;
+
+	if (!tas2563->fw_data)
+		return;
+
+	for (int i = 0; i < tas2563->ndev; ++i) {
+		struct regmap *regmap = tas2563->tasdevs[i].regmap;
+
+		ret = regmap_write(regmap, TAS2562_PWR_CTRL, power);
+		if (ret)
+			dev_err(tas2563->dev, "Error setting power\n");
+	}
+}
+
+static void tas2563_tasdev_setup(struct tas2563_data *tas2563,
+	struct tas2563_dev *tasdev)
+{
+	int ret;
+	struct regmap *regmap = tasdev->regmap;
+
+	if (!tas2563->fw_data)
+		return;
+
+	ret = regmap_write(regmap, TAS2562_SW_RESET, TAS2562_SW_RESET_RESET);
+	if (ret)
+		dev_err(tas2563->dev, "Error resetting device\n");
+
+	ret = tas25xx_write_program(tas2563->dev, regmap, tas2563->fw_data, 0);
+	if (ret)
+		dev_err(tas2563->dev, "Error writing program\n");
+
+	ret = tas25xx_write_config(tas2563->dev, regmap, tas2563->fw_data, 0);
+	if (ret)
+		dev_err(tas2563->dev, "Error writing config\n");
+
+	for (int i = 0; i < TAS2563_REG_INIT_N; ++i) {
+		struct reg_default reg = tas2563_reg_init[tasdev->dev_id][i];
+
+		ret = regmap_write(regmap, reg.reg, reg.def);
+		if (ret)
+			dev_err(tas2563->dev, "Error writing init regs\n");
+	}
+
+	ret = regmap_write(regmap, TAS25XX_DSP_MODE, 1);
+	if (ret)
+		dev_err(tas2563->dev, "Error enabling DSP\n");
+
+	for (int i = 0; i < TAS2563_CAL_N; ++i) {
+		ret = regmap_bulk_write(regmap, cal_regs[i],
+			&tasdev->cal_data[i], TAS2563_CAL_DATA_SIZE);
+		if (ret)
+			dev_err(tas2563->dev, "Error writing calib regs\n");
+	}
+
+	ret = regmap_write(regmap, TAS2562_PWR_CTRL, 0);
+	if (ret)
+		dev_err(tas2563->dev, "Error setting power on\n");
+}
+
+static void tas2563_fw_loaded(const struct firmware *fw, void *context)
+{
+	struct tas2563_data *tas2563 = context;
+
+	if (!fw)
+		return;
+
+	tas2563->fw_data = tas25xx_parse_fw(tas2563->dev, fw);
+	if (!tas2563->fw_data) {
+		dev_err(tas2563->dev, "Failed to parse firmware\n");
+		return;
+	}
+
+	for (int i = 0; i < tas2563->ndev; ++i)
+		tas2563_tasdev_setup(tas2563, &tas2563->tasdevs[i]);
+}
+
+static void tas2563_hda_playback_hook(struct device *dev, int action)
+{
+	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
+
+	dev_dbg(tas2563->dev, "%s: action = %d\n", __func__, action);
+	switch (action) {
+	case HDA_GEN_PCM_ACT_OPEN:
+		pm_runtime_get_sync(dev);
+		tas2563_set_power(tas2563, TAS2562_PWR_ACTIVE);
+		break;
+	case HDA_GEN_PCM_ACT_CLOSE:
+		tas2563_set_power(tas2563, TAS2562_PWR_SUSPEND);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+		break;
+	default:
+		dev_dbg(tas2563->dev, "Playback action not supported: %d\n",
+			action);
+		break;
+	}
+}
+
+static int tas2563_hda_bind(struct device *dev, struct device *master,
+	void *master_data)
+{
+	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
+	struct hda_component *comps = master_data;
+	struct hda_codec *codec;
+	int ret;
+
+	if (!comps)
+		return -EINVAL;
+
+	if (comps->dev)
+		return -EBUSY;
+	comps->dev = dev;
+	codec = comps->codec;
+
+	pm_runtime_get_sync(dev);
+
+	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
+	scnprintf(tas2563->firmware_name, 32, "TAS2563-%08X.bin",
+		codec->core.subsystem_id);
+
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
+				tas2563->firmware_name, tas2563->dev,
+				GFP_KERNEL, tas2563,
+				tas2563_fw_loaded);
+	if (ret)
+		dev_err(tas2563->dev, "request_firmware_nowait err: %d\n",
+			ret);
+
+	comps->playback_hook = tas2563_hda_playback_hook;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
+static void tas2563_hda_unbind(struct device *dev,
+	struct device *master, void *master_data)
+{
+	struct hda_component *comps = master_data;
+
+	if (comps->dev != dev)
+		return;
+
+	comps->dev = NULL;
+	comps->playback_hook = NULL;
+}
+
+static const struct component_ops tas2563_hda_comp_ops = {
+	.bind = tas2563_hda_bind,
+	.unbind = tas2563_hda_unbind,
+};
+
+static int tas2563_tasdev_init_regmap(struct tas2563_data *tas2563,
+	struct tas2563_dev *tasdev)
+{
+	tasdev->regmap = devm_regmap_init_i2c(tasdev->client,
+		&tas2563_regmap_config);
+	if (IS_ERR(tasdev->regmap))
+		return PTR_ERR(tasdev->regmap);
+	return 0;
+}
+
+static int tas2563_tasdev_init_client(struct tas2563_data *tas2563,
+	struct tas2563_dev *tasdev)
+{
+	tasdev->client = tas2563->client->addr == tasdev->i2c_addr
+		? tas2563->client : devm_i2c_new_dummy_device(tas2563->dev,
+				tas2563->client->adapter, tasdev->i2c_addr);
+	if (IS_ERR(tasdev->client))
+		return PTR_ERR(tasdev->client);
+	return 0;
+}
+
+/* Update the calibrate data, including speaker impedance, f0, etc, into algo.
+ * Calibrate data is done by manufacturer in the factory. These data are used
+ * by Algo for calucating the speaker temperature, speaker membrance excursion
+ * and f0 in real time during playback.
+ */
+static int tas2563_tasdev_read_efi(struct tas2563_data *tas2563,
+	struct tas2563_dev *tasdev)
+{
+	efi_status_t status;
+	unsigned int attr;
+	unsigned long max_size = TAS2563_CAL_DATA_SIZE;
+
+	for (int i = 0; i < TAS2563_CAL_N; ++i) {
+		status = efi.get_variable(efi_var_names[tasdev->dev_id][i],
+			&efi_guid, &attr, &max_size,
+			&tasdev->cal_data[i]);
+		if (status != EFI_SUCCESS)
+			return -EINVAL;
+		tasdev->cal_data[i] = cpu_to_be32(tasdev->cal_data[i]);
+	}
+
+	dev_info(tas2563->dev,
+		"Calibration data %d: power:%08x r0:%08x inv_r0:%08x r0_low:%08x tlim:%08x\n",
+		tasdev->dev_id, tasdev->cal_data[0], tasdev->cal_data[1],
+		tasdev->cal_data[2], tasdev->cal_data[3], tasdev->cal_data[4]);
+
+	return 0;
+}
+
+static int tas2563_get_i2c_res(struct acpi_resource *ares, void *data)
+{
+	struct tas2563_data *tas2563 = data;
+	struct acpi_resource_i2c_serialbus *sb;
+	struct tas2563_dev *tasdev;
+
+	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
+		if (tas2563->ndev < 2 &&
+			sb->slave_address != TAS2563_GLOBAL_ADDR) {
+			tasdev = &tas2563->tasdevs[tas2563->ndev];
+			tasdev->dev_id = tas2563->ndev;
+			tasdev->i2c_addr =
+				(unsigned int)sb->slave_address;
+			tas2563->ndev++;
+		}
+	}
+	return 1;
+}
+
+static int tas2563_read_acpi(struct tas2563_data *tas2563)
+{
+	struct acpi_device *adev;
+	LIST_HEAD(resources);
+	int ret;
+
+	adev = ACPI_COMPANION(tas2563->dev);
+	if (!adev) {
+		dev_err(tas2563->dev, "Error could not get ACPI device\n");
+		return -ENODEV;
+	}
+
+	ret = acpi_dev_get_resources(adev, &resources, tas2563_get_i2c_res,
+		tas2563);
+	if (ret < 0) {
+		dev_err(tas2563->dev, "Read acpi error, ret: %d\n", ret);
+		return ret;
+	}
+
+	acpi_dev_free_resource_list(&resources);
+
+	return 0;
+}
+
+static int tas2563_hda_i2c_probe(struct i2c_client *client)
+{
+	struct tas2563_data *tas2563;
+	int ret;
+
+	tas2563 = devm_kzalloc(&client->dev, sizeof(struct tas2563_data),
+		GFP_KERNEL);
+	if (!tas2563)
+		return -ENOMEM;
+	tas2563->dev = &client->dev;
+	tas2563->client = client;
+
+	dev_set_drvdata(tas2563->dev, tas2563);
+
+	ret = tas2563_read_acpi(tas2563);
+	if (ret)
+		return dev_err_probe(tas2563->dev, ret,
+			"Platform not supported\n");
+
+	for (int i = 0; i < tas2563->ndev; ++i) {
+		struct tas2563_dev *tasdev = &tas2563->tasdevs[i];
+
+		ret = tas2563_tasdev_read_efi(tas2563, tasdev);
+		if (ret)
+			return dev_err_probe(tas2563->dev, ret,
+				"Calibration data cannot be read from EFI\n");
+
+		ret = tas2563_tasdev_init_client(tas2563, tasdev);
+		if (ret)
+			return dev_err_probe(tas2563->dev, ret,
+				"Failed to init i2c client\n");
+
+		ret = tas2563_tasdev_init_regmap(tas2563, tasdev);
+		if (ret)
+			return dev_err_probe(tas2563->dev, ret,
+				"Failed to allocate register map\n");
+	}
+
+	ret = component_add(tas2563->dev, &tas2563_hda_comp_ops);
+	if (ret) {
+		return dev_err_probe(tas2563->dev, ret,
+			"Register component failed\n");
+	}
+
+	pm_runtime_set_autosuspend_delay(tas2563->dev, 3000);
+	pm_runtime_use_autosuspend(tas2563->dev);
+	pm_runtime_mark_last_busy(tas2563->dev);
+	pm_runtime_set_active(tas2563->dev);
+	pm_runtime_get_noresume(tas2563->dev);
+	pm_runtime_enable(tas2563->dev);
+
+	pm_runtime_put_autosuspend(tas2563->dev);
+
+	return 0;
+}
+
+static void tas2563_hda_i2c_remove(struct i2c_client *client)
+{
+	struct tas2563_data *tas2563 = dev_get_drvdata(&client->dev);
+
+	pm_runtime_get_sync(tas2563->dev);
+	pm_runtime_disable(tas2563->dev);
+
+	component_del(tas2563->dev, &tas2563_hda_comp_ops);
+
+	pm_runtime_put_noidle(tas2563->dev);
+}
+
+static int tas2563_system_suspend(struct device *dev)
+{
+	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(tas2563->dev, "System Suspend\n");
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tas2563_system_resume(struct device *dev)
+{
+	int ret;
+	struct tas2563_data *tas2563 = dev_get_drvdata(dev);
+
+	dev_dbg(tas2563->dev, "System Resume\n");
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < tas2563->ndev; ++i)
+		tas2563_tasdev_setup(tas2563, &tas2563->tasdevs[i]);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tas2563_hda_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(tas2563_system_suspend, tas2563_system_resume)
+};
+
+static const struct i2c_device_id tas2563_hda_i2c_id[] = {
+	{ "tas2563-hda", 0 },
+	{}
+};
+
+static const struct acpi_device_id tas2563_acpi_hda_match[] = {
+	{"INT8866", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tas2563_acpi_hda_match);
+
+static struct i2c_driver tas2563_hda_i2c_driver = {
+	.driver = {
+		.name		= "tas2563-hda",
+		.acpi_match_table = tas2563_acpi_hda_match,
+		.pm		= &tas2563_hda_pm_ops,
+	},
+	.id_table	= tas2563_hda_i2c_id,
+	.probe		= tas2563_hda_i2c_probe,
+	.remove		= tas2563_hda_i2c_remove,
+};
+module_i2c_driver(tas2563_hda_i2c_driver);
+
+MODULE_DESCRIPTION("TAS2563 HDA Driver");
+MODULE_AUTHOR("Gergo Koteles <soyer@irl.hu>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_TAS25XX_DSP);
-- 
2.43.0

