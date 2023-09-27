Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1F37B03CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjI0MSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjI0MR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:17:59 -0400
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85EACD3;
        Wed, 27 Sep 2023 05:17:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0177229-0.000429353-0.981848;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=29;RT=29;SR=0;TI=SMTPD_---.Upkf40J_1695817064;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Upkf40J_1695817064)
          by smtp.aliyun-inc.com;
          Wed, 27 Sep 2023 20:17:51 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        shumingf@realtek.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, arnd@arndb.de, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, harshit.m.mogalapalli@oracle.com,
        liweilei@awinic.com, yang.lee@linux.alibaba.com,
        u.kleine-koenig@pengutronix.de, yijiangtao@awinic.com,
        dan.carpenter@linaro.org, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 8/8] ASoC: codecs: Add aw87390 amplifier driver
Date:   Wed, 27 Sep 2023 20:16:34 +0800
Message-ID: <20230927121634.94822-9-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927121634.94822-1-wangweidong.a@awinic.com>
References: <20230927121634.94822-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add i2c and amplifier registration for aw87390 and
their associated operation functions.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig   |  15 +-
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/aw87390.c | 462 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/aw87390.h |  85 +++++++
 4 files changed, 562 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/codecs/aw87390.c
 create mode 100644 sound/soc/codecs/aw87390.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1e1dbc509f6..8c101919259f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -54,6 +54,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ALC5632
 	imply SND_SOC_AUDIO_IIO_AUX
 	imply SND_SOC_AW8738
+	imply SND_SOC_AW87390
 	imply SND_SOC_AW88395
 	imply SND_SOC_AW88261
 	imply SND_SOC_BT_SCO
@@ -638,12 +639,12 @@ config SND_SOC_AW8738
 	  operation mode using the Awinic-specific one-wire pulse control.
 
 config SND_SOC_AW88395_LIB
+	select CRC8
 	tristate
 
 config SND_SOC_AW88395
 	tristate "Soc Audio for awinic aw88395"
 	depends on I2C
-	select CRC8
 	select CRC32
 	select REGMAP_I2C
 	select GPIOLIB
@@ -657,7 +658,6 @@ config SND_SOC_AW88395
 config SND_SOC_AW88261
 	tristate "Soc Audio for awinic aw88261"
 	depends on I2C
-	select CRC8
 	select REGMAP_I2C
 	select GPIOLIB
 	select SND_SOC_AW88395_LIB
@@ -668,6 +668,17 @@ config SND_SOC_AW88261
 	  boost converter can be adjusted smartly according to
 	  the input amplitude.
 
+config SND_SOC_AW87390
+	tristate "Soc Audio for awinic aw87390"
+	depends on I2C
+	select REGMAP_I2C
+	select SND_SOC_AW88395_LIB
+	help
+	  The awinic aw87390 is specifically designed to improve
+	  the musical output dynamic range, enhance the overall
+	  sound quallity, which is a new high efficiency, low
+	  noise, constant large volume, 6th Smart K audio amplifier.
+
 config SND_SOC_BD28623
 	tristate "ROHM BD28623 CODEC"
 	help
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a87e56938ce5..60df97b67c01 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -47,6 +47,7 @@ snd-soc-ak5558-objs := ak5558.o
 snd-soc-arizona-objs := arizona.o arizona-jack.o
 snd-soc-audio-iio-aux-objs := audio-iio-aux.o
 snd-soc-aw8738-objs := aw8738.o
+snd-soc-aw87390-objs := aw87390.o
 snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
 snd-soc-aw88395-objs := aw88395/aw88395.o \
 			aw88395/aw88395_device.o
@@ -434,6 +435,7 @@ obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_AUDIO_IIO_AUX)	+= snd-soc-audio-iio-aux.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
+obj-$(CONFIG_SND_SOC_AW87390)	+= snd-soc-aw87390.o
 obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
 obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
diff --git a/sound/soc/codecs/aw87390.c b/sound/soc/codecs/aw87390.c
new file mode 100644
index 000000000000..8efae3b73eea
--- /dev/null
+++ b/sound/soc/codecs/aw87390.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw87390.c  --  AW87390 ALSA SoC Audio driver
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "aw87390.h"
+#include "aw88395/aw88395_data_type.h"
+#include "aw88395/aw88395_device.h"
+
+static const struct regmap_config aw87390_remap_config = {
+	.val_bits = 8,
+	.reg_bits = 8,
+	.max_register = AW87390_REG_MAX,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static int aw87390_dev_reg_update(struct aw_device *aw_dev,
+					unsigned char *data, unsigned int len)
+{
+	int i, ret;
+
+	if (!data) {
+		dev_err(aw_dev->dev, "data is NULL\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < len; i = i + 2) {
+		if (data[i] == AW87390_DELAY_REG_ADDR) {
+			usleep_range(data[i + 1] * AW87390_REG_DELAY_TIME,
+					data[i + 1] * AW87390_REG_DELAY_TIME + 10);
+			continue;
+		}
+		ret = regmap_write(aw_dev->regmap, data[i], data[i + 1]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int aw87390_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_prof_desc *prof_desc;
+
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]\n",
+			index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	*prof_name = prof_info->prof_name_list[prof_desc->id];
+
+	return 0;
+}
+
+static int aw87390_dev_get_prof_data(struct aw_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc)
+{
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
+				__func__, index, aw_dev->prof_info.count);
+		return -EINVAL;
+	}
+
+	*prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	return 0;
+}
+
+static int aw87390_dev_fw_update(struct aw_device *aw_dev)
+{
+	struct aw_prof_desc *prof_index_desc;
+	struct aw_sec_data_desc *sec_desc;
+	char *prof_name;
+	int ret;
+
+	ret = aw87390_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	if (ret) {
+		dev_err(aw_dev->dev, "get prof name failed\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw87390_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw87390_dev_get_prof_data failed\n");
+		return ret;
+	}
+
+	/* update reg */
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw87390_dev_reg_update(aw_dev, sec_desc[AW88395_DATA_TYPE_REG].data,
+					sec_desc[AW88395_DATA_TYPE_REG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update reg failed\n");
+		return ret;
+	}
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return ret;
+}
+
+static int aw87390_power_off(struct aw_device *aw_dev)
+{
+	int ret;
+
+	if (aw_dev->status == AW87390_DEV_PW_OFF) {
+		dev_info(aw_dev->dev, "already power off\n");
+		return 0;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW87390_SYSCTRL_REG, AW87390_POWER_DOWN_VALUE);
+	if (ret)
+		return ret;
+	aw_dev->status = AW87390_DEV_PW_OFF;
+
+	return ret;
+}
+
+static int aw87390_power_on(struct aw_device *aw_dev)
+{
+	int ret;
+
+	if (aw_dev->status == AW87390_DEV_PW_ON) {
+		dev_info(aw_dev->dev, "already power on\n");
+		return 0;
+	}
+
+	if (!aw_dev->fw_status) {
+		dev_err(aw_dev->dev, "fw not load\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW87390_SYSCTRL_REG, AW87390_POWER_DOWN_VALUE);
+	if (ret)
+		return ret;
+
+	ret = aw87390_dev_fw_update(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s load profile failed\n", __func__);
+		return ret;
+	}
+	aw_dev->status = AW87390_DEV_PW_ON;
+
+	return ret;
+}
+
+static int aw87390_dev_set_profile_index(struct aw_device *aw_dev, int index)
+{
+	if ((index >= aw_dev->prof_info.count) || (index < 0))
+		return -EINVAL;
+
+	if (aw_dev->prof_index == index)
+		return -EPERM;
+
+	aw_dev->prof_index = index;
+
+	return 0;
+}
+
+static int aw87390_profile_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(codec);
+	char *prof_name, *name;
+	int count, ret;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = aw87390->aw_pa->prof_info.count;
+	if (count <= 0) {
+		uinfo->value.enumerated.items = 0;
+		return 0;
+	}
+
+	uinfo->value.enumerated.items = count;
+
+	if (uinfo->value.enumerated.item >= count)
+		uinfo->value.enumerated.item = count - 1;
+
+	name = uinfo->value.enumerated.name;
+	count = uinfo->value.enumerated.item;
+
+	ret = aw87390_dev_get_prof_name(aw87390->aw_pa, count, &prof_name);
+	if (ret) {
+		strscpy(uinfo->value.enumerated.name, "null",
+						strlen("null") + 1);
+		return 0;
+	}
+
+	strscpy(name, prof_name, sizeof(uinfo->value.enumerated.name));
+
+	return 0;
+}
+
+static int aw87390_profile_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw87390->aw_pa->prof_index;
+
+	return 0;
+}
+
+static int aw87390_profile_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&aw87390->lock);
+	ret = aw87390_dev_set_profile_index(aw87390->aw_pa, ucontrol->value.integer.value[0]);
+	if (ret) {
+		dev_dbg(codec->dev, "profile index does not change\n");
+		mutex_unlock(&aw87390->lock);
+		return 0;
+	}
+
+	if (aw87390->aw_pa->status == AW87390_DEV_PW_ON) {
+		aw87390_power_off(aw87390->aw_pa);
+		aw87390_power_on(aw87390->aw_pa);
+	}
+
+	mutex_unlock(&aw87390->lock);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new aw87390_controls[] = {
+	AW87390_PROFILE_EXT("AW87390 Profile Set", aw87390_profile_info,
+		aw87390_profile_get, aw87390_profile_set),
+};
+
+static int aw87390_request_firmware_file(struct aw87390 *aw87390)
+{
+	const struct firmware *cont = NULL;
+	int ret;
+
+	aw87390->aw_pa->fw_status = AW87390_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, AW87390_ACF_FILE, aw87390->aw_pa->dev);
+	if (ret)
+		return dev_err_probe(aw87390->aw_pa->dev, ret,
+					"load [%s] failed!\n", AW87390_ACF_FILE);
+
+	dev_dbg(aw87390->aw_pa->dev, "loaded %s - size: %zu\n",
+			AW87390_ACF_FILE, cont ? cont->size : 0);
+
+	aw87390->aw_cfg = devm_kzalloc(aw87390->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
+	if (!aw87390->aw_cfg) {
+		release_firmware(cont);
+		return -ENOMEM;
+	}
+
+	aw87390->aw_cfg->len = (int)cont->size;
+	memcpy(aw87390->aw_cfg->data, cont->data, cont->size);
+	release_firmware(cont);
+
+	ret = aw88395_dev_load_acf_check(aw87390->aw_pa, aw87390->aw_cfg);
+	if (ret) {
+		dev_err(aw87390->aw_pa->dev, "load [%s] failed !\n", AW87390_ACF_FILE);
+		return ret;
+	}
+
+	mutex_lock(&aw87390->lock);
+
+	ret = aw88395_dev_cfg_load(aw87390->aw_pa, aw87390->aw_cfg);
+	if (ret)
+		dev_err(aw87390->aw_pa->dev, "aw_dev acf parse failed\n");
+
+	mutex_unlock(&aw87390->lock);
+
+	return ret;
+}
+
+static int aw87390_drv_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw87390->aw_pa;
+	int ret;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		ret = aw87390_power_on(aw_dev);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = aw87390_power_off(aw_dev);
+		break;
+	default:
+		dev_err(aw_dev->dev, "%s: invalid event %d\n", __func__, event);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget aw87390_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("IN"),
+	SND_SOC_DAPM_PGA_E("SPK PA", SND_SOC_NOPM, 0, 0, NULL, 0, aw87390_drv_event,
+			       SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("OUT"),
+};
+
+static const struct snd_soc_dapm_route aw87390_dapm_routes[] = {
+	{ "SPK PA", NULL, "IN" },
+	{ "OUT", NULL, "SPK PA" },
+};
+
+static int aw87390_codec_probe(struct snd_soc_component *component)
+{
+	struct aw87390 *aw87390 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = aw87390_request_firmware_file(aw87390);
+	if (ret)
+		return dev_err_probe(aw87390->aw_pa->dev, ret,
+				"aw87390_request_firmware_file failed\n");
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_aw87390 = {
+	.probe = aw87390_codec_probe,
+	.dapm_widgets = aw87390_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aw87390_dapm_widgets),
+	.dapm_routes = aw87390_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(aw87390_dapm_routes),
+	.controls = aw87390_controls,
+	.num_controls = ARRAY_SIZE(aw87390_controls),
+};
+
+static void aw87390_parse_channel_dt(struct aw87390 *aw87390)
+{
+	struct aw_device *aw_dev = aw87390->aw_pa;
+	struct device_node *np = aw_dev->dev->of_node;
+	u32 channel_value = AW87390_DEV_DEFAULT_CH;
+
+	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
+
+	aw_dev->channel = channel_value;
+}
+
+static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct regmap *regmap)
+{
+	struct aw_device *aw_dev;
+	unsigned int chip_id;
+	int ret;
+
+	/* read chip id */
+	ret = regmap_read(regmap, AW87390_ID_REG, &chip_id);
+	if (ret) {
+		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
+		return ret;
+	}
+
+	if (chip_id != AW87390_CHIP_ID) {
+		dev_err(&i2c->dev, "unsupported device\n");
+		return -ENXIO;
+	}
+
+	dev_info(&i2c->dev, "chip id = 0x%x\n", chip_id);
+
+	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
+	if (!aw_dev)
+		return -ENOMEM;
+
+	(*aw87390)->aw_pa = aw_dev;
+	aw_dev->i2c = i2c;
+	aw_dev->regmap = regmap;
+	aw_dev->dev = &i2c->dev;
+	aw_dev->chip_id = AW87390_CHIP_ID;
+	aw_dev->acf = NULL;
+	aw_dev->prof_info.prof_desc = NULL;
+	aw_dev->prof_info.count = 0;
+	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->channel = AW87390_DEV_DEFAULT_CH;
+	aw_dev->fw_status = AW87390_DEV_FW_FAILED;
+	aw_dev->prof_index = AW87390_INIT_PROFILE;
+	aw_dev->status = AW87390_DEV_PW_OFF;
+
+	aw87390_parse_channel_dt(*aw87390);
+
+	return ret;
+}
+
+static int aw87390_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw87390 *aw87390;
+	int ret;
+
+	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
+	if (!ret)
+		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed\n");
+
+	aw87390 = devm_kzalloc(&i2c->dev, sizeof(*aw87390), GFP_KERNEL);
+	if (!aw87390)
+		return -ENOMEM;
+
+	mutex_init(&aw87390->lock);
+
+	i2c_set_clientdata(i2c, aw87390);
+
+	aw87390->regmap = devm_regmap_init_i2c(i2c, &aw87390_remap_config);
+	if (IS_ERR(aw87390->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(aw87390->regmap),
+					"failed to init regmap\n");
+
+	/* aw pa init */
+	ret = aw87390_init(&aw87390, i2c, aw87390->regmap);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(aw87390->regmap, AW87390_ID_REG, AW87390_SOFT_RESET_VALUE);
+	if (ret)
+		return ret;
+
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				&soc_codec_dev_aw87390, NULL, 0);
+	if (ret)
+		dev_err(&i2c->dev, "failed to register aw87390: %d\n", ret);
+
+	return ret;
+}
+
+static const struct i2c_device_id aw87390_i2c_id[] = {
+	{ AW87390_I2C_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw87390_i2c_id);
+
+static struct i2c_driver aw87390_i2c_driver = {
+	.driver = {
+		.name = AW87390_I2C_NAME,
+	},
+	.probe = aw87390_i2c_probe,
+	.id_table = aw87390_i2c_id,
+};
+module_i2c_driver(aw87390_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW87390 PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw87390.h b/sound/soc/codecs/aw87390.h
new file mode 100644
index 000000000000..54c268c18e72
--- /dev/null
+++ b/sound/soc/codecs/aw87390.h
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw87390.h  --  aw87390 ALSA SoC Audio driver
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW87390_H__
+#define __AW87390_H__
+
+#define AW87390_ID_REG			(0x00)
+#define AW87390_SYSCTRL_REG		(0x01)
+#define AW87390_MDCTRL_REG		(0x02)
+#define AW87390_CPOVP_REG		(0x03)
+#define AW87390_CPP_REG		(0x04)
+#define AW87390_PAG_REG		(0x05)
+#define AW87390_AGC3P_REG		(0x06)
+#define AW87390_AGC3PA_REG		(0x07)
+#define AW87390_AGC2P_REG		(0x08)
+#define AW87390_AGC2PA_REG		(0x09)
+#define AW87390_AGC1PA_REG		(0x0A)
+#define AW87390_SYSST_REG		(0x59)
+#define AW87390_SYSINT_REG		(0x60)
+#define AW87390_DFT_SYSCTRL_REG	(0x61)
+#define AW87390_DFT_MDCTRL_REG		(0x62)
+#define AW87390_DFT_CPADP_REG		(0x63)
+#define AW87390_DFT_AGCPA_REG		(0x64)
+#define AW87390_DFT_POFR_REG		(0x65)
+#define AW87390_DFT_OC_REG		(0x66)
+#define AW87390_DFT_ADP1_REG		(0x67)
+#define AW87390_DFT_REF_REG		(0x68)
+#define AW87390_DFT_LDO_REG		(0x69)
+#define AW87390_ADP1_REG		(0x70)
+#define AW87390_ADP2_REG		(0x71)
+#define AW87390_NG1_REG		(0x72)
+#define AW87390_NG2_REG		(0x73)
+#define AW87390_NG3_REG		(0x74)
+#define AW87390_CP_REG			(0x75)
+#define AW87390_AB_REG			(0x76)
+#define AW87390_TEST_REG		(0x77)
+#define AW87390_ENCR_REG		(0x78)
+#define AW87390_DELAY_REG_ADDR		(0xFE)
+
+#define AW87390_SOFT_RESET_VALUE	(0xAA)
+#define AW87390_POWER_DOWN_VALUE	(0x00)
+#define AW87390_REG_MAX		(0xFF)
+#define AW87390_DEV_DEFAULT_CH		(0)
+#define AW87390_INIT_PROFILE		(0)
+#define AW87390_REG_DELAY_TIME		(1000)
+#define AW87390_I2C_NAME		"aw87390"
+#define AW87390_ACF_FILE		"aw87390_acf.bin"
+
+#define AW87390_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = profile_info, \
+	.get = profile_get, \
+	.put = profile_set, \
+}
+
+enum aw87390_id {
+	AW87390_CHIP_ID = 0x76,
+};
+
+enum {
+	AW87390_DEV_FW_FAILED = 0,
+	AW87390_DEV_FW_OK,
+};
+
+enum {
+	AW87390_DEV_PW_OFF = 0,
+	AW87390_DEV_PW_ON,
+};
+
+struct aw87390 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct regmap *regmap;
+	struct aw_container *aw_cfg;
+};
+
+#endif
-- 
2.41.0

