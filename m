Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF769756229
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGQL7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGQL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:58:59 -0400
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0D4118;
        Mon, 17 Jul 2023 04:58:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0146645-0.000414135-0.984921;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.TvogKun_1689595128;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.TvogKun_1689595128)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 19:58:49 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.co,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
Subject: [PATCH V1 1/5] ASoC: codecs: Add i2c and codec registration for aw88261 and their associated operation functions
Date:   Mon, 17 Jul 2023 19:58:41 +0800
Message-ID: <20230717115845.297991-2-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717115845.297991-1-wangweidong.a@awinic.com>
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

The AW88261 is an I2S/TDM input, high efficiency
digital Smart K audio amplifier with an integrated 10.25V
smart boost convert

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261/aw88261.c | 539 +++++++++++++++++++++++++++++
 sound/soc/codecs/aw88261/aw88261.h |  52 +++
 2 files changed, 591 insertions(+)
 create mode 100644 sound/soc/codecs/aw88261/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261.h

diff --git a/sound/soc/codecs/aw88261/aw88261.c b/sound/soc/codecs/aw88261/aw88261.c
new file mode 100644
index 000000000000..14b072275822
--- /dev/null
+++ b/sound/soc/codecs/aw88261/aw88261.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261.c --  ALSA SoC AW88261 codec support
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Jimmy Zhang <zhangjianming@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "aw88261.h"
+#include "aw88261_device.h"
+#include "aw88261_lib.h"
+#include "aw88261_reg.h"
+
+static const struct regmap_config aw88261_remap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW88261_REG_MAX - 1,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static void aw88261_start_pa(struct aw88261 *aw88261)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88261_START_RETRIES; i++) {
+		ret = aw88261_dev_reg_update(aw88261->aw_pa, aw88261->aw_pa->phase_sync);
+		if (ret < 0) {
+			dev_err(aw88261->aw_pa->dev, "fw update failed, cnt:%d\n", i);
+			continue;
+		}
+		ret = aw88261_dev_start(aw88261->aw_pa);
+		if (ret) {
+			dev_err(aw88261->aw_pa->dev, "aw88261 device start failed. retry = %d", i);
+			continue;
+		} else {
+			dev_info(aw88261->aw_pa->dev, "start success\n");
+			break;
+		}
+	}
+}
+
+static void aw88261_startup_work(struct work_struct *work)
+{
+	struct aw88261 *aw88261 =
+		container_of(work, struct aw88261, start_work.work);
+
+	mutex_lock(&aw88261->lock);
+	aw88261_start_pa(aw88261);
+	mutex_unlock(&aw88261->lock);
+}
+
+static void aw88261_start(struct aw88261 *aw88261, bool sync_start)
+{
+	if (aw88261->aw_pa->fw_status != AW88261_DEV_FW_OK)
+		return;
+
+	if (aw88261->aw_pa->status == AW88261_DEV_PW_ON)
+		return;
+
+	if (sync_start == AW88261_SYNC_START)
+		aw88261_start_pa(aw88261);
+	else
+		queue_delayed_work(system_wq,
+			&aw88261->start_work,
+			AW88261_START_WORK_DELAY_MS);
+}
+
+static struct snd_soc_dai_driver aw88261_dai[] = {
+	{
+		.name = "aw88261-aif",
+		.id = 1,
+		.playback = {
+			.stream_name = "Speaker_Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88261_RATES,
+			.formats = AW88261_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Speaker_Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88261_RATES,
+			.formats = AW88261_FORMATS,
+		},
+	},
+};
+
+static int aw88261_get_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88261->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
+
+	return 0;
+}
+
+static int aw88261_set_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	int time;
+
+	time = ucontrol->value.integer.value[0];
+
+	if (time < mc->min || time > mc->max)
+		return -EINVAL;
+
+	if (time != aw_dev->fade_in_time) {
+		aw_dev->fade_in_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88261_get_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88261->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
+
+	return 0;
+}
+
+static int aw88261_set_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	int time;
+
+	time = ucontrol->value.integer.value[0];
+	if (time < mc->min || time > mc->max)
+		return -EINVAL;
+
+	if (time != aw_dev->fade_out_time) {
+		aw_dev->fade_out_time = time;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88261_profile_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+	const char *prof_name;
+	char *name;
+	int count;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = aw88261_dev_get_profile_count(aw88261->aw_pa);
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
+	prof_name = aw88261_dev_get_prof_name(aw88261->aw_pa, count);
+	if (!prof_name) {
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
+static int aw88261_profile_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88261_dev_get_profile_index(aw88261->aw_pa);
+
+	return 0;
+}
+
+static int aw88261_profile_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	/* pa stop or stopping just set profile */
+	mutex_lock(&aw88261->lock);
+	ret = aw88261_dev_set_profile_index(aw88261->aw_pa, ucontrol->value.integer.value[0]);
+	if (ret < 0) {
+		dev_dbg(codec->dev, "profile index does not change");
+		mutex_unlock(&aw88261->lock);
+		return 0;
+	}
+
+	if (aw88261->aw_pa->status) {
+		aw88261_dev_stop(aw88261->aw_pa);
+		aw88261_start(aw88261, AW88261_SYNC_START);
+	}
+
+	mutex_unlock(&aw88261->lock);
+
+	return 1;
+}
+
+static int aw88261_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88261->aw_pa->volume_desc;
+
+	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
+
+	return 0;
+}
+
+static int aw88261_volume_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88261->aw_pa->volume_desc;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (vol_desc->ctl_volume != value) {
+		vol_desc->ctl_volume = value;
+		aw88261_dev_set_volume(aw88261->aw_pa, vol_desc->ctl_volume);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88261_get_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88261->aw_pa->fade_step;
+
+	return 0;
+}
+
+static int aw88261_set_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (aw88261->aw_pa->fade_step != value) {
+		aw88261->aw_pa->fade_step = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new aw88261_controls[] = {
+	SOC_SINGLE_EXT("PCM Playback Volume", AW88261_SYSCTRL2_REG,
+		6, AW88261_MUTE_VOL, 0, aw88261_volume_get,
+		aw88261_volume_set),
+	SOC_SINGLE_EXT("Fade Step", 0, 0, AW88261_MUTE_VOL, 0,
+		aw88261_get_fade_step, aw88261_set_fade_step),
+	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw88261_get_fade_in_time, aw88261_set_fade_in_time),
+	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw88261_get_fade_out_time, aw88261_set_fade_out_time),
+	AW88261_PROFILE_EXT("Profile Set", aw88261_profile_info,
+		aw88261_profile_get, aw88261_profile_set),
+};
+
+static int aw88261_playback_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&aw88261->lock);
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		aw88261_start(aw88261, AW88261_ASYNC_START);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		aw88261_dev_stop(aw88261->aw_pa);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&aw88261->lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget aw88261_dapm_widgets[] = {
+	 /* playback */
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, 0, 0, 0,
+					aw88261_playback_event,
+					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+
+	/* capture */
+	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("ADC Input"),
+};
+
+static const struct snd_soc_dapm_route aw88261_audio_map[] = {
+	{"DAC Output", NULL, "AIF_RX"},
+	{"AIF_TX", NULL, "ADC Input"},
+};
+
+static int aw88261_request_firmware_file(struct aw88261 *aw88261)
+{
+	const struct firmware *cont = NULL;
+	int ret;
+
+	aw88261->aw_pa->fw_status = AW88261_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, AW88261_ACF_FILE, aw88261->aw_pa->dev);
+	if ((ret < 0) || (!cont)) {
+		dev_err(aw88261->aw_pa->dev, "load [%s] failed!", AW88261_ACF_FILE);
+		return ret;
+	}
+
+	dev_info(aw88261->aw_pa->dev, "loaded %s - size: %zu\n",
+			AW88261_ACF_FILE, cont ? cont->size : 0);
+
+	aw88261->aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
+	if (!aw88261->aw_cfg) {
+		release_firmware(cont);
+		return -ENOMEM;
+	}
+	aw88261->aw_cfg->len = (int)cont->size;
+	memcpy(aw88261->aw_cfg->data, cont->data, cont->size);
+	release_firmware(cont);
+
+	ret = aw88261_dev_load_acf_check(aw88261->aw_pa, aw88261->aw_cfg);
+	if (ret < 0) {
+		dev_err(aw88261->aw_pa->dev, "Load [%s] failed ....!", AW88261_ACF_FILE);
+		return ret;
+	}
+
+	dev_dbg(aw88261->aw_pa->dev, "%s : bin load success\n", __func__);
+
+	mutex_lock(&aw88261->lock);
+	/* aw device init */
+	ret = aw88261_dev_init(aw88261->aw_pa, aw88261->aw_cfg);
+	if (ret < 0)
+		dev_err(aw88261->aw_pa->dev, "dev init failed");
+	mutex_unlock(&aw88261->lock);
+
+	return ret;
+}
+
+static int aw88261_codec_probe(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	INIT_DELAYED_WORK(&aw88261->start_work, aw88261_startup_work);
+
+	ret = aw88261_request_firmware_file(aw88261);
+	if (ret < 0) {
+		dev_err(aw88261->aw_pa->dev, "aw88261_request_firmware_file failed\n");
+		return ret;
+	}
+
+	/* add widgets */
+	ret = snd_soc_dapm_new_controls(dapm, aw88261_dapm_widgets,
+							ARRAY_SIZE(aw88261_dapm_widgets));
+	if (ret < 0)
+		return ret;
+
+	/* add route */
+	ret = snd_soc_dapm_add_routes(dapm, aw88261_audio_map,
+							ARRAY_SIZE(aw88261_audio_map));
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_add_component_controls(component, aw88261_controls,
+							ARRAY_SIZE(aw88261_controls));
+
+	return ret;
+}
+
+static void aw88261_codec_remove(struct snd_soc_component *aw_codec)
+{
+	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(aw_codec);
+
+	cancel_delayed_work_sync(&aw88261->start_work);
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_aw88261 = {
+	.probe = aw88261_codec_probe,
+	.remove = aw88261_codec_remove,
+};
+
+static struct aw88261 *aw88261_malloc_init(struct i2c_client *i2c)
+{
+	struct aw88261 *aw88261 = devm_kzalloc(&i2c->dev,
+			sizeof(struct aw88261), GFP_KERNEL);
+	if (!aw88261)
+		return NULL;
+
+	mutex_init(&aw88261->lock);
+
+	return aw88261;
+}
+
+static void aw88261_hw_reset(struct aw88261 *aw88261)
+{
+	gpiod_set_value_cansleep(aw88261->reset_gpio, 0);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
+	gpiod_set_value_cansleep(aw88261->reset_gpio, 1);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
+}
+
+static int aw88261_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw88261 *aw88261;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
+		dev_err(&i2c->dev, "check_functionality failed");
+		return -EIO;
+	}
+
+	aw88261 = aw88261_malloc_init(i2c);
+	if (!aw88261) {
+		dev_err(&i2c->dev, "malloc aw88261 failed");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(i2c, aw88261);
+
+	aw88261->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw88261->reset_gpio))
+		dev_info(&i2c->dev, "reset gpio not defined\n");
+	else
+		aw88261_hw_reset(aw88261);
+
+	aw88261->regmap = devm_regmap_init_i2c(i2c, &aw88261_remap_config);
+	if (IS_ERR(aw88261->regmap)) {
+		ret = PTR_ERR(aw88261->regmap);
+		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	/* aw pa init */
+	ret = aw88261_init(&aw88261->aw_pa, i2c, aw88261->regmap);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_codec_dev_aw88261,
+			aw88261_dai, ARRAY_SIZE(aw88261_dai));
+	if (ret < 0)
+		dev_err(&i2c->dev, "failed to register aw88261: %d", ret);
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id aw88261_of_match[] = {
+	{ .compatible = "awinic,aw88261" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, aw88261_of_match);
+#endif
+
+static const struct i2c_device_id aw88261_i2c_id[] = {
+	{ AW88261_I2C_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw88261_i2c_id);
+
+static struct i2c_driver aw88261_i2c_driver = {
+	.driver = {
+		.name = AW88261_I2C_NAME,
+		.of_match_table = of_match_ptr(aw88261_of_match),
+	},
+	.probe_new = aw88261_i2c_probe,
+	.id_table = aw88261_i2c_id,
+};
+module_i2c_driver(aw88261_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW88261 Smart PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88261/aw88261.h b/sound/soc/codecs/aw88261/aw88261.h
new file mode 100644
index 000000000000..c8b9805001cc
--- /dev/null
+++ b/sound/soc/codecs/aw88261/aw88261.h
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261.h --  ALSA SoC AW88261 codec support
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Jimmy Zhang <zhangjianming@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW88261_H__
+#define __AW88261_H__
+
+#define AW88261_CHIP_ID_REG			(0x00)
+#define AW88261_START_RETRIES			(5)
+#define AW88261_START_WORK_DELAY_MS		(0)
+
+#define AW88261_I2C_NAME			"aw88261_smartpa"
+
+#define AW88261_RATES (SNDRV_PCM_RATE_8000_48000 | \
+			SNDRV_PCM_RATE_96000)
+#define AW88261_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+#define FADE_TIME_MAX			100000
+#define FADE_TIME_MIN			0
+
+#define AW88261_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = profile_info, \
+	.get = profile_get, \
+	.put = profile_set, \
+}
+
+enum {
+	AW88261_SYNC_START = 0,
+	AW88261_ASYNC_START,
+};
+
+struct aw88261 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct gpio_desc *reset_gpio;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+	struct aw_container *aw_cfg;
+};
+
+#endif
-- 
2.41.0

