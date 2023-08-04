Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7E576FFAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjHDLsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjHDLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:48:13 -0400
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A6195;
        Fri,  4 Aug 2023 04:48:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0430977-0.000191237-0.956711;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U8VaXA2_1691149680;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U8VaXA2_1691149680)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 19:48:01 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        herve.codina@bootlin.com, 13916275206@139.com,
        ryans.lee@analog.com, ckeepax@opensource.cirrus.com,
        sebastian.reichel@collabora.com,
        ajye_huang@compal.corp-partner.google.com, povik+lin@cutebit.org,
        yijiangtao@awinic.com, trix@redhat.com, colin.i.king@gmail.com,
        liweilei@awinic.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V4 3/3] ASoC: codecs: Add aw88261 amplifier driver
Date:   Fri,  4 Aug 2023 19:47:49 +0800
Message-ID: <20230804114749.215460-4-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804114749.215460-1-wangweidong.a@awinic.com>
References: <20230804114749.215460-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Add i2c and amplifier registration for
aw88261 and their associated operation functions.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig   |   15 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/aw88261.c | 1298 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/aw88261.h |  459 +++++++++++++
 4 files changed, 1774 insertions(+)
 create mode 100644 sound/soc/codecs/aw88261.c
 create mode 100644 sound/soc/codecs/aw88261.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c2de4ee72183..1e3526812cc8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -55,6 +55,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ALC5632
 	imply SND_SOC_AW8738
 	imply SND_SOC_AW88395
+	imply SND_SOC_AW88261
 	imply SND_SOC_BT_SCO
 	imply SND_SOC_BD28623
 	imply SND_SOC_CHV3_CODEC
@@ -640,6 +641,20 @@ config SND_SOC_AW88395
 	  digital Smart K audio amplifier with an integrated 10V
 	  smart boost convert.
 
+config SND_SOC_AW88261
+	tristate "Soc Audio for awinic aw88261"
+	depends on I2C
+	select CRC8
+	select REGMAP_I2C
+	select GPIOLIB
+	select SND_SOC_AW88395_LIB
+	help
+	  This option enables support for aw88261 Smart PA.
+	  The awinic AW88261 is an I2S/TDM input, high efficiency
+	  digital Smart K audio amplifier. The output voltage of
+	  boost converter can be adjusted smartly according to
+	  the input amplitude.
+
 config SND_SOC_BD28623
 	tristate "ROHM BD28623 CODEC"
 	help
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b48a9a323b84..364f38cc228e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -49,6 +49,7 @@ snd-soc-aw8738-objs := aw8738.o
 snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
 snd-soc-aw88395-objs := aw88395/aw88395.o \
 			aw88395/aw88395_device.o
+snd-soc-aw88261-objs := aw88261.o
 snd-soc-bd28623-objs := bd28623.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-chv3-codec-objs := chv3-codec.o
@@ -431,6 +432,7 @@ obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
 obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
+obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
 obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_CHV3_CODEC) += snd-soc-chv3-codec.o
diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
new file mode 100644
index 000000000000..82923b454dd4
--- /dev/null
+++ b/sound/soc/codecs/aw88261.c
@@ -0,0 +1,1298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261.c  --  AW88261 ALSA SoC Audio driver
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
+#include "aw88395/aw88395_data_type.h"
+#include "aw88395/aw88395_device.h"
+
+static const struct regmap_config aw88261_remap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW88261_REG_MAX - 1,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static void aw88261_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int real_value, volume;
+	unsigned int reg_value;
+
+	volume = min((value + vol_desc->init_volume), (unsigned int)AW88261_MUTE_VOL);
+	real_value = DB_TO_REG_VAL(volume);
+
+	regmap_read(aw_dev->regmap, AW88261_SYSCTRL2_REG, &reg_value);
+
+	real_value = (real_value | (reg_value & AW88261_VOL_START_MASK));
+
+	dev_dbg(aw_dev->dev, "value 0x%x , real_value:0x%x", value, real_value);
+
+	regmap_write(aw_dev->regmap, AW88261_SYSCTRL2_REG, real_value);
+}
+
+static void aw88261_dev_fade_in(struct aw_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_in_vol = desc->ctl_volume;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
+		aw88261_dev_set_volume(aw_dev, fade_in_vol);
+		return;
+	}
+
+	for (i = AW88261_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
+		aw88261_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_in_time,
+					aw_dev->fade_in_time + 10);
+	}
+
+	if (i != fade_in_vol)
+		aw88261_dev_set_volume(aw_dev, fade_in_vol);
+}
+
+static void aw88261_dev_fade_out(struct aw_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
+		aw88261_dev_set_volume(aw_dev, AW88261_MUTE_VOL);
+		return;
+	}
+
+	for (i = desc->ctl_volume; i <= AW88261_MUTE_VOL; i += fade_step) {
+		aw88261_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+
+	if (i != AW88261_MUTE_VOL) {
+		aw88261_dev_set_volume(aw_dev, AW88261_MUTE_VOL);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+}
+
+static void aw88261_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
+{
+	if (flag)
+		regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
+			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
+			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
+}
+
+static void aw88261_dev_pwd(struct aw_device *aw_dev, bool pwd)
+{
+	if (pwd)
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK, AW88261_PWDN_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK, AW88261_PWDN_WORKING_VALUE);
+}
+
+static void aw88261_dev_amppd(struct aw_device *aw_dev, bool amppd)
+{
+	if (amppd)
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_WORKING_VALUE);
+}
+
+static void aw88261_dev_mute(struct aw_device *aw_dev, bool is_mute)
+{
+	if (is_mute) {
+		aw88261_dev_fade_out(aw_dev);
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_HMUTE_MASK, AW88261_HMUTE_ENABLE_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_HMUTE_MASK, AW88261_HMUTE_DISABLE_VALUE);
+		aw88261_dev_fade_in(aw_dev);
+	}
+}
+
+static void aw88261_dev_clear_int_status(struct aw_device *aw_dev)
+{
+	unsigned int int_status;
+
+	/* read int status and clear */
+	regmap_read(aw_dev->regmap, AW88261_SYSINT_REG, &int_status);
+	/* make sure int status is clear */
+	regmap_read(aw_dev->regmap, AW88261_SYSINT_REG, &int_status);
+
+	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", int_status);
+}
+
+static int aw88261_dev_get_iis_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88261_SYSST_REG, &reg_val);
+	if (ret)
+		return ret;
+	if ((reg_val & AW88261_BIT_PLL_CHECK) != AW88261_BIT_PLL_CHECK) {
+		dev_err(aw_dev->dev, "check pll lock fail,reg_val:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int aw88261_dev_check_mode1_pll(struct aw_device *aw_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw88261_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		} else {
+			return ret;
+		}
+	}
+
+	return -EPERM;
+}
+
+static int aw88261_dev_check_mode2_pll(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->regmap, AW88261_PLLCTRL1_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= (~AW88261_CCO_MUX_MASK);
+	if (reg_val == AW88261_CCO_MUX_DIVIDED_VALUE) {
+		dev_dbg(aw_dev->dev, "CCO_MUX is already divider");
+		return -EPERM;
+	}
+
+	/* change mode2 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88261_PLLCTRL1_REG,
+			~AW88261_CCO_MUX_MASK, AW88261_CCO_MUX_DIVIDED_VALUE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw88261_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 iis signal check error");
+			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	/* change mode1 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88261_PLLCTRL1_REG,
+			~AW88261_CCO_MUX_MASK, AW88261_CCO_MUX_BYPASS_VALUE);
+	if (ret == 0) {
+		usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+			ret = aw88261_dev_check_mode1_pll(aw_dev);
+			if (ret) {
+				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
+				usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+			} else {
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int aw88261_dev_check_syspll(struct aw_device *aw_dev)
+{
+	int ret;
+
+	ret = aw88261_dev_check_mode1_pll(aw_dev);
+	if (ret) {
+		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
+		ret = aw88261_dev_check_mode2_pll(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 check iis failed");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int aw88261_dev_check_sysst(struct aw_device *aw_dev)
+{
+	unsigned int check_val;
+	unsigned int reg_val;
+	int ret, i;
+
+	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->regmap, AW88261_SYSST_REG, &reg_val);
+		if (ret)
+			return ret;
+
+		check_val = reg_val & (~AW88261_BIT_SYSST_CHECK_MASK)
+							& AW88261_BIT_SYSST_CHECK;
+		if (check_val != AW88261_BIT_SYSST_CHECK) {
+			dev_err(aw_dev->dev, "check sysst fail, reg_val=0x%04x, check:0x%x",
+				reg_val, AW88261_BIT_SYSST_CHECK);
+			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static void aw88261_dev_uls_hmute(struct aw_device *aw_dev, bool uls_hmute)
+{
+	if (uls_hmute)
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_ULS_HMUTE_MASK,
+				AW88261_ULS_HMUTE_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_ULS_HMUTE_MASK,
+				AW88261_ULS_HMUTE_DISABLE_VALUE);
+}
+
+static void aw88261_reg_force_set(struct aw88261 *aw88261)
+{
+	if (aw88261->frcset_en == AW88261_FRCSET_ENABLE) {
+		/* set FORCE_PWM */
+		regmap_update_bits(aw88261->regmap, AW88261_BSTCTRL3_REG,
+				AW88261_FORCE_PWM_MASK, AW88261_FORCE_PWM_FORCEMINUS_PWM_VALUE);
+		/* set BOOST_OS_WIDTH */
+		regmap_update_bits(aw88261->regmap, AW88261_BSTCTRL5_REG,
+				AW88261_BST_OS_WIDTH_MASK, AW88261_BST_OS_WIDTH_50NS_VALUE);
+		/* set BURST_LOOPR */
+		regmap_update_bits(aw88261->regmap, AW88261_BSTCTRL6_REG,
+				AW88261_BST_LOOPR_MASK, AW88261_BST_LOOPR_340K_VALUE);
+		/* set RSQN_DLY */
+		regmap_update_bits(aw88261->regmap, AW88261_BSTCTRL7_REG,
+				AW88261_RSQN_DLY_MASK, AW88261_RSQN_DLY_35NS_VALUE);
+		/* set BURST_SSMODE */
+		regmap_update_bits(aw88261->regmap, AW88261_BSTCTRL8_REG,
+				AW88261_BURST_SSMODE_MASK, AW88261_BURST_SSMODE_FAST_VALUE);
+		/* set BST_BURST */
+		regmap_update_bits(aw88261->regmap, AW88261_BSTCTRL9_REG,
+				AW88261_BST_BURST_MASK, AW88261_BST_BURST_30MA_VALUE);
+	} else {
+		dev_dbg(aw88261->aw_pa->dev, "needn't set reg value");
+	}
+}
+
+static int aw88261_dev_get_icalk(struct aw_device *aw_dev, int16_t *icalk)
+{
+	u16 reg_icalk, reg_icalkl;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88261_EFRH4_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_icalk = reg_val & (~AW88261_EF_ISN_GESLP_H_MASK);
+
+	ret = regmap_read(aw_dev->regmap, AW88261_EFRL4_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_icalkl = reg_val & (~AW88261_EF_ISN_GESLP_L_MASK);
+
+	reg_icalk = (reg_icalk >> AW88261_ICALK_SHIFT) & (reg_icalkl >> AW88261_ICALKL_SHIFT);
+
+	if (reg_icalk & (~AW88261_EF_ISN_GESLP_SIGN_MASK))
+		reg_icalk = reg_icalk | ~AW88261_EF_ISN_GESLP_NEG;
+
+	*icalk = (int16_t)reg_icalk;
+
+	return ret;
+}
+
+static int aw88261_dev_get_vcalk(struct aw_device *aw_dev, int16_t *vcalk)
+{
+	u16 reg_vcalk, reg_vcalkl;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88261_EFRH3_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_vcalk = (u16)reg_val & (~AW88261_EF_VSN_GESLP_H_MASK);
+
+	ret = regmap_read(aw_dev->regmap, AW88261_EFRL3_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_vcalkl = (u16)reg_val & (~AW88261_EF_VSN_GESLP_L_MASK);
+
+	reg_vcalk = (reg_vcalk >> AW88261_VCALK_SHIFT) & (reg_vcalkl >> AW88261_VCALKL_SHIFT);
+
+	if (reg_vcalk & AW88261_EF_VSN_GESLP_SIGN_MASK)
+		reg_vcalk = reg_vcalk | (~AW88261_EF_VSN_GESLP_NEG);
+	*vcalk = (int16_t)reg_vcalk;
+
+	return ret;
+}
+
+static int aw88261_dev_set_vcalb(struct aw_device *aw_dev)
+{
+	int16_t icalk_val, vcalk_val;
+	int icalk, vcalk, vcalb;
+	u32 reg_val;
+	int ret;
+
+	ret = aw88261_dev_get_icalk(aw_dev, &icalk_val);
+	if (ret)
+		return ret;
+
+	ret = aw88261_dev_get_vcalk(aw_dev, &vcalk_val);
+	if (ret)
+		return ret;
+
+	icalk = AW88261_CABL_BASE_VALUE + AW88261_ICABLK_FACTOR * icalk_val;
+	vcalk = AW88261_CABL_BASE_VALUE + AW88261_VCABLK_FACTOR * vcalk_val;
+	if (!vcalk)
+		return -EINVAL;
+
+	vcalb = AW88261_VCAL_FACTOR * icalk / vcalk;
+	reg_val = (unsigned int)vcalb;
+
+	dev_dbg(aw_dev->dev, "icalk=%d, vcalk=%d, vcalb=%d, reg_val=0x%04x",
+			icalk, vcalk, vcalb, reg_val);
+	ret = regmap_write(aw_dev->regmap, AW88261_VSNTM1_REG, reg_val);
+
+	return ret;
+}
+
+static int aw88261_dev_reg_update(struct aw88261 *aw88261,
+					unsigned char *data, unsigned int len)
+{
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int read_val, efcheck_val, read_vol;
+	int data_len, i, ret;
+	int16_t *reg_data;
+	u16 reg_val;
+	u8 reg_addr;
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "reg data is null or len is 0");
+		return -EINVAL;
+	}
+
+	reg_data = (int16_t *)data;
+	data_len = len >> 1;
+
+	if (data_len & 0x1) {
+		dev_err(aw_dev->dev, "data len:%d unsupported",	data_len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data_len; i += 2) {
+		reg_addr = reg_data[i];
+		reg_val = reg_data[i + 1];
+
+		if (reg_addr == AW88261_SYSCTRL_REG) {
+			aw88261->amppd_st = reg_val & (~AW88261_AMPPD_MASK);
+			ret = regmap_read(aw_dev->regmap, reg_addr, &read_val);
+			if (ret)
+				break;
+
+			read_val &= (~AW88261_AMPPD_MASK) | (~AW88261_PWDN_MASK) |
+								(~AW88261_HMUTE_MASK);
+			reg_val &= (AW88261_AMPPD_MASK | AW88261_PWDN_MASK | AW88261_HMUTE_MASK);
+			reg_val |= read_val;
+
+			/* enable uls hmute */
+			reg_val &= AW88261_ULS_HMUTE_MASK;
+			reg_val |= AW88261_ULS_HMUTE_ENABLE_VALUE;
+		}
+
+		if (reg_addr == AW88261_DBGCTRL_REG) {
+			efcheck_val = reg_val & (~AW88261_EF_DBMD_MASK);
+			if (efcheck_val == AW88261_OR_VALUE)
+				aw88261->efuse_check = AW88261_EF_OR_CHECK;
+			else
+				aw88261->efuse_check = AW88261_EF_AND_CHECK;
+		}
+
+		/* i2stxen */
+		if (reg_addr == AW88261_I2SCTRL3_REG) {
+			/* close tx */
+			reg_val &= AW88261_I2STXEN_MASK;
+			reg_val |= AW88261_I2STXEN_DISABLE_VALUE;
+		}
+
+		if (reg_addr == AW88261_SYSCTRL2_REG) {
+			read_vol = (reg_val & (~AW88261_VOL_MASK)) >>
+				AW88261_VOL_START_BIT;
+			aw_dev->volume_desc.init_volume =
+				REG_VAL_TO_DB(read_vol);
+		}
+
+		if (reg_addr == AW88261_VSNTM1_REG)
+			continue;
+
+		ret = regmap_write(aw_dev->regmap, reg_addr, reg_val);
+		if (ret)
+			break;
+	}
+
+	ret = aw88261_dev_set_vcalb(aw_dev);
+	if (ret)
+		return ret;
+
+	if (aw_dev->prof_cur != aw_dev->prof_index)
+		vol_desc->ctl_volume = 0;
+
+	/* keep min volume */
+	aw88261_dev_set_volume(aw_dev, vol_desc->mute_volume);
+
+	return ret;
+}
+
+static char *aw88261_dev_get_prof_name(struct aw_device *aw_dev, int index)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_prof_desc *prof_desc;
+
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
+			index, aw_dev->prof_info.count);
+		return NULL;
+	}
+
+	prof_desc = &aw_dev->prof_info.prof_desc[index];
+
+	return prof_info->prof_name_list[prof_desc->id];
+}
+
+static int aw88261_dev_get_prof_data(struct aw_device *aw_dev, int index,
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
+static int aw88261_dev_fw_update(struct aw88261 *aw88261)
+{
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	struct aw_prof_desc *prof_index_desc;
+	struct aw_sec_data_desc *sec_desc;
+	char *prof_name;
+	int ret;
+
+	prof_name = aw88261_dev_get_prof_name(aw_dev, aw_dev->prof_index);
+	if (!prof_name) {
+		dev_err(aw_dev->dev, "get prof name failed");
+		return -EINVAL;
+	}
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw88261_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	if (ret)
+		return ret;
+
+	/* update reg */
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw88261_dev_reg_update(aw88261, sec_desc[AW88395_DATA_TYPE_REG].data,
+					sec_desc[AW88395_DATA_TYPE_REG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update reg failed");
+		return ret;
+	}
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return ret;
+}
+
+static int aw88261_dev_start(struct aw88261 *aw88261)
+{
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	int ret;
+
+	if (aw_dev->status == AW88261_DEV_PW_ON) {
+		dev_info(aw_dev->dev, "already power on");
+		return 0;
+	}
+
+	/* power on */
+	aw88261_dev_pwd(aw_dev, false);
+	usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+
+	ret = aw88261_dev_check_syspll(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "pll check failed cannot start");
+		goto pll_check_fail;
+	}
+
+	/* amppd on */
+	aw88261_dev_amppd(aw_dev, false);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 50);
+
+	/* check i2s status */
+	ret = aw88261_dev_check_sysst(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "sysst check failed");
+		goto sysst_check_fail;
+	}
+
+	/* enable tx feedback */
+	aw88261_dev_i2s_tx_enable(aw_dev, true);
+
+	if (aw88261->amppd_st)
+		aw88261_dev_amppd(aw_dev, true);
+
+	aw88261_reg_force_set(aw88261);
+
+	/* close uls mute */
+	aw88261_dev_uls_hmute(aw_dev, false);
+
+	/* close mute */
+	if (!aw88261->mute_st)
+		aw88261_dev_mute(aw_dev, false);
+
+	/* clear inturrupt */
+	aw88261_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW88261_DEV_PW_ON;
+
+	return 0;
+
+sysst_check_fail:
+	aw88261_dev_i2s_tx_enable(aw_dev, false);
+	aw88261_dev_clear_int_status(aw_dev);
+	aw88261_dev_amppd(aw_dev, true);
+pll_check_fail:
+	aw88261_dev_pwd(aw_dev, true);
+	aw_dev->status = AW88261_DEV_PW_OFF;
+
+	return ret;
+}
+
+static int aw88261_dev_stop(struct aw_device *aw_dev)
+{
+	if (aw_dev->status == AW88261_DEV_PW_OFF) {
+		dev_info(aw_dev->dev, "already power off");
+		return 0;
+	}
+
+	aw_dev->status = AW88261_DEV_PW_OFF;
+
+	/* clear inturrupt */
+	aw88261_dev_clear_int_status(aw_dev);
+
+	aw88261_dev_uls_hmute(aw_dev, true);
+	/* set mute */
+	aw88261_dev_mute(aw_dev, true);
+
+	/* close tx feedback */
+	aw88261_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
+
+	/* enable amppd */
+	aw88261_dev_amppd(aw_dev, true);
+
+	/* set power down */
+	aw88261_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static int aw88261_reg_update(struct aw88261 *aw88261, bool force)
+{
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	int ret;
+
+	if (force) {
+		ret = regmap_write(aw_dev->regmap,
+					AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
+		if (ret)
+			return ret;
+
+		ret = aw88261_dev_fw_update(aw88261);
+		if (ret)
+			return ret;
+	} else {
+		if (aw_dev->prof_cur != aw_dev->prof_index) {
+			ret = aw88261_dev_fw_update(aw88261);
+			if (ret)
+				return ret;
+		}
+	}
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return ret;
+}
+
+static void aw88261_start_pa(struct aw88261 *aw88261)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88261_START_RETRIES; i++) {
+		ret = aw88261_reg_update(aw88261, aw88261->phase_sync);
+		if (ret) {
+			dev_err(aw88261->aw_pa->dev, "fw update failed, cnt:%d\n", i);
+			continue;
+		}
+		ret = aw88261_dev_start(aw88261);
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
+static int aw88261_dev_set_profile_index(struct aw_device *aw_dev, int index)
+{
+	/* check the index whether is valid */
+	if ((index >= aw_dev->prof_info.count) || (index < 0))
+		return -EINVAL;
+	/* check the index whether change */
+	if (aw_dev->prof_index == index)
+		return -EPERM;
+
+	aw_dev->prof_index = index;
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
+	count = aw88261->aw_pa->prof_info.count;
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
+	ucontrol->value.integer.value[0] = aw88261->aw_pa->prof_index;
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
+	if (ret) {
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
+static int aw88261_frcset_check(struct aw88261 *aw88261)
+{
+	unsigned int reg_val;
+	u16 temh, teml, tem;
+	int ret;
+
+	ret = regmap_read(aw88261->regmap, AW88261_EFRH3_REG, &reg_val);
+	if (ret)
+		return ret;
+	temh = ((u16)reg_val & (~AW88261_TEMH_MASK));
+
+	ret = regmap_read(aw88261->regmap, AW88261_EFRL3_REG, &reg_val);
+	if (ret)
+		return ret;
+	teml = ((u16)reg_val & (~AW88261_TEML_MASK));
+
+	if (aw88261->efuse_check == AW88261_EF_OR_CHECK)
+		tem = (temh | teml);
+	else
+		tem = (temh & teml);
+
+	if (tem == AW88261_DEFAULT_CFG)
+		aw88261->frcset_en = AW88261_FRCSET_ENABLE;
+	else
+		aw88261->frcset_en = AW88261_FRCSET_DISABLE;
+
+	dev_dbg(aw88261->aw_pa->dev, "tem is 0x%04x, frcset_en is %d",
+						tem, aw88261->frcset_en);
+
+	return ret;
+}
+
+static int aw88261_dev_init(struct aw88261 *aw88261, struct aw_container *aw_cfg)
+{
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	int ret;
+
+	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw_dev acf parse failed");
+		return -EINVAL;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
+	if (ret)
+		return ret;
+
+	aw_dev->fade_in_time = AW88261_500_US;
+	aw_dev->fade_out_time = AW88261_500_US;
+	aw_dev->prof_cur = AW88261_INIT_PROFILE;
+	aw_dev->prof_index = AW88261_INIT_PROFILE;
+
+	ret = aw88261_dev_fw_update(aw88261);
+	if (ret) {
+		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = aw88261_frcset_check(aw88261);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw88261_frcset_check ret = %d\n", ret);
+		return ret;
+	}
+
+	aw88261_dev_clear_int_status(aw_dev);
+
+	aw88261_dev_uls_hmute(aw_dev, true);
+
+	aw88261_dev_mute(aw_dev, true);
+
+	aw88261_dev_i2s_tx_enable(aw_dev, false);
+
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
+
+	aw88261_dev_amppd(aw_dev, true);
+
+	aw88261_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static int aw88261_request_firmware_file(struct aw88261 *aw88261)
+{
+	const struct firmware *cont = NULL;
+	int ret;
+
+	aw88261->aw_pa->fw_status = AW88261_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, AW88261_ACF_FILE, aw88261->aw_pa->dev);
+	if (ret)
+		return dev_err_probe(aw88261->aw_pa->dev, ret,
+					"load [%s] failed!", AW88261_ACF_FILE);
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
+	ret = aw88395_dev_load_acf_check(aw88261->aw_pa, aw88261->aw_cfg);
+	if (ret) {
+		dev_err(aw88261->aw_pa->dev, "load [%s] failed !", AW88261_ACF_FILE);
+		return ret;
+	}
+
+	mutex_lock(&aw88261->lock);
+	/* aw device init */
+	ret = aw88261_dev_init(aw88261, aw88261->aw_cfg);
+	if (ret)
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
+	if (ret)
+		return dev_err_probe(aw88261->aw_pa->dev, ret,
+				"aw88261_request_firmware_file failed\n");
+
+	/* add widgets */
+	ret = snd_soc_dapm_new_controls(dapm, aw88261_dapm_widgets,
+							ARRAY_SIZE(aw88261_dapm_widgets));
+	if (ret)
+		return ret;
+
+	/* add route */
+	ret = snd_soc_dapm_add_routes(dapm, aw88261_audio_map,
+							ARRAY_SIZE(aw88261_audio_map));
+	if (ret)
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
+static void aw88261_hw_reset(struct aw88261 *aw88261)
+{
+	gpiod_set_value_cansleep(aw88261->reset_gpio, 0);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
+	gpiod_set_value_cansleep(aw88261->reset_gpio, 1);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
+}
+
+static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
+{
+	struct aw_device *aw_dev = aw88261->aw_pa;
+	struct device_node *np = aw_dev->dev->of_node;
+	u32 channel_value = AW88261_DEV_DEFAULT_CH;
+	u32 sync_enable = false;
+
+	of_property_read_u32(np, "sound-channel", &channel_value);
+	of_property_read_u32(np, "sync-flag", &sync_enable);
+
+	aw_dev->channel = channel_value;
+	aw88261->phase_sync = sync_enable;
+}
+
+static int aw88261_init(struct aw88261 **aw88261, struct i2c_client *i2c, struct regmap *regmap)
+{
+	struct aw_device *aw_dev;
+	unsigned int chip_id;
+	int ret;
+
+	/* read chip id */
+	ret = regmap_read(regmap, AW88261_ID_REG, &chip_id);
+	if (ret) {
+		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
+		return ret;
+	}
+	if (chip_id != AW88261_CHIP_ID) {
+		dev_err(&i2c->dev, "unsupported device");
+		return -ENXIO;
+	}
+
+	dev_info(&i2c->dev, "chip id = %x\n", chip_id);
+
+	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
+	if (!aw_dev)
+		return -ENOMEM;
+
+	(*aw88261)->aw_pa = aw_dev;
+	aw_dev->i2c = i2c;
+	aw_dev->regmap = regmap;
+	aw_dev->dev = &i2c->dev;
+	aw_dev->chip_id = AW88261_CHIP_ID;
+	aw_dev->acf = NULL;
+	aw_dev->prof_info.prof_desc = NULL;
+	aw_dev->prof_info.count = 0;
+	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->channel = 0;
+	aw_dev->fw_status = AW88261_DEV_FW_FAILED;
+	aw_dev->fade_step = AW88261_VOLUME_STEP_DB;
+	aw_dev->volume_desc.ctl_volume = AW88261_VOL_DEFAULT_VALUE;
+	aw_dev->volume_desc.mute_volume = AW88261_MUTE_VOL;
+	aw88261_parse_channel_dt(*aw88261);
+
+	return ret;
+}
+
+static int aw88261_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw88261 *aw88261;
+	int ret;
+
+	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
+	if (!ret)
+		return dev_err_probe(&i2c->dev, ret, "check_functionality failed");
+
+	aw88261 = devm_kzalloc(&i2c->dev, sizeof(*aw88261), GFP_KERNEL);
+	if (!aw88261)
+		return -ENOMEM;
+
+	mutex_init(&aw88261->lock);
+
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
+		return dev_err_probe(&i2c->dev, ret, "failed to init regmap: %d\n", ret);
+	}
+
+	/* aw pa init */
+	ret = aw88261_init(&aw88261, i2c, aw88261->regmap);
+	if (ret)
+		return ret;
+
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_codec_dev_aw88261,
+			aw88261_dai, ARRAY_SIZE(aw88261_dai));
+	if (ret)
+		dev_err(&i2c->dev, "failed to register aw88261: %d", ret);
+
+	return ret;
+}
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
+	},
+	.probe = aw88261_i2c_probe,
+	.id_table = aw88261_i2c_id,
+};
+module_i2c_driver(aw88261_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW88261 Smart PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88261.h b/sound/soc/codecs/aw88261.h
new file mode 100644
index 000000000000..cc63d5d05f97
--- /dev/null
+++ b/sound/soc/codecs/aw88261.h
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261.h  --  AW88261 ALSA SoC Audio driver
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
+#define AW88261_ID_REG			(0x00)
+#define AW88261_SYSST_REG		(0x01)
+#define AW88261_SYSINT_REG		(0x02)
+#define AW88261_SYSINTM_REG		(0x03)
+#define AW88261_SYSCTRL_REG		(0x04)
+#define AW88261_SYSCTRL2_REG		(0x05)
+#define AW88261_I2SCTRL1_REG		(0x06)
+#define AW88261_I2SCTRL2_REG		(0x07)
+#define AW88261_I2SCTRL3_REG		(0x08)
+#define AW88261_DACCFG1_REG		(0x09)
+#define AW88261_DACCFG2_REG		(0x0A)
+#define AW88261_DACCFG3_REG		(0x0B)
+#define AW88261_DACCFG4_REG		(0x0C)
+#define AW88261_DACCFG5_REG		(0x0D)
+#define AW88261_DACCFG6_REG		(0x0E)
+#define AW88261_DACCFG7_REG		(0x0F)
+#define AW88261_DACCFG8_REG		(0x10)
+#define AW88261_PWMCTRL1_REG		(0x11)
+#define AW88261_PWMCTRL2_REG		(0x12)
+#define AW88261_I2SCFG1_REG		(0x13)
+#define AW88261_DBGCTRL_REG		(0x14)
+#define AW88261_DACCFG9_REG		(0x15)
+#define AW88261_DACCFG10_REG		(0x16)
+#define AW88261_DACST_REG		(0x20)
+#define AW88261_VBAT_REG		(0x21)
+#define AW88261_TEMP_REG		(0x22)
+#define AW88261_PVDD_REG		(0x23)
+#define AW88261_ISNDAT_REG		(0x24)
+#define AW88261_VSNDAT_REG		(0x25)
+#define AW88261_I2SINT_REG		(0x26)
+#define AW88261_I2SCAPCNT_REG		(0x27)
+#define AW88261_ANASTA1_REG		(0x28)
+#define AW88261_ANASTA2_REG		(0x29)
+#define AW88261_ANASTA3_REG		(0x2A)
+#define AW88261_TESTDET_REG		(0x2B)
+#define AW88261_DSMCFG1_REG		(0x30)
+#define AW88261_DSMCFG2_REG		(0x31)
+#define AW88261_DSMCFG3_REG		(0x32)
+#define AW88261_DSMCFG4_REG		(0x33)
+#define AW88261_DSMCFG5_REG		(0x34)
+#define AW88261_DSMCFG6_REG		(0x35)
+#define AW88261_DSMCFG7_REG		(0x36)
+#define AW88261_DSMCFG8_REG		(0x37)
+#define AW88261_TESTIN_REG		(0x38)
+#define AW88261_TESTOUT_REG		(0x39)
+#define AW88261_SADCCTRL1_REG		(0x3A)
+#define AW88261_SADCCTRL2_REG		(0x3B)
+#define AW88261_SADCCTRL3_REG		(0x3C)
+#define AW88261_SADCCTRL4_REG		(0x3D)
+#define AW88261_SADCCTRL5_REG		(0x3E)
+#define AW88261_SADCCTRL6_REG		(0x3F)
+#define AW88261_SADCCTRL7_REG		(0x40)
+#define AW88261_VSNTM1_REG		(0x50)
+#define AW88261_VSNTM2_REG		(0x51)
+#define AW88261_ISNCTRL1_REG		(0x52)
+#define AW88261_ISNCTRL2_REG		(0x53)
+#define AW88261_PLLCTRL1_REG		(0x54)
+#define AW88261_PLLCTRL2_REG		(0x55)
+#define AW88261_PLLCTRL3_REG		(0x56)
+#define AW88261_CDACTRL1_REG		(0x57)
+#define AW88261_CDACTRL2_REG		(0x58)
+#define AW88261_DITHERCFG1_REG		(0x59)
+#define AW88261_DITHERCFG2_REG		(0x5A)
+#define AW88261_DITHERCFG3_REG		(0x5B)
+#define AW88261_CPCTRL_REG		(0x5C)
+#define AW88261_BSTCTRL1_REG		(0x60)
+#define AW88261_BSTCTRL2_REG		(0x61)
+#define AW88261_BSTCTRL3_REG		(0x62)
+#define AW88261_BSTCTRL4_REG		(0x63)
+#define AW88261_BSTCTRL5_REG		(0x64)
+#define AW88261_BSTCTRL6_REG		(0x65)
+#define AW88261_BSTCTRL7_REG		(0x66)
+#define AW88261_BSTCTRL8_REG		(0x67)
+#define AW88261_BSTCTRL9_REG		(0x68)
+#define AW88261_TM_REG			(0x6F)
+#define AW88261_TESTCTRL1_REG		(0x70)
+#define AW88261_TESTCTRL2_REG		(0x71)
+#define AW88261_EFCTRL1_REG		(0x72)
+#define AW88261_EFCTRL2_REG		(0x73)
+#define AW88261_EFWH_REG		(0x74)
+#define AW88261_EFWM2_REG		(0x75)
+#define AW88261_EFWM1_REG		(0x76)
+#define AW88261_EFWL_REG		(0x77)
+#define AW88261_EFRH4_REG		(0x78)
+#define AW88261_EFRH3_REG		(0x79)
+#define AW88261_EFRH2_REG		(0x7A)
+#define AW88261_EFRH1_REG		(0x7B)
+#define AW88261_EFRL4_REG		(0x7C)
+#define AW88261_EFRL3_REG		(0x7D)
+#define AW88261_EFRL2_REG		(0x7E)
+#define AW88261_EFRL1_REG		(0x7F)
+
+#define AW88261_REG_MAX		(0x80)
+#define AW88261_EF_DBMD_MASK		(0xfff7)
+#define AW88261_OR_VALUE		(0x0008)
+
+#define AW88261_TEMH_MASK		(0x83ff)
+#define AW88261_TEML_MASK		(0x83ff)
+#define AW88261_DEFAULT_CFG		(0x0000)
+
+#define AW88261_ICALK_SHIFT		(0)
+#define AW88261_ICALKL_SHIFT		(0)
+#define AW88261_VCALK_SHIFT		(0)
+#define AW88261_VCALKL_SHIFT		(0)
+
+#define AW88261_AMPPD_START_BIT	(1)
+#define AW88261_AMPPD_BITS_LEN		(1)
+#define AW88261_AMPPD_MASK		\
+	(~(((1<<AW88261_AMPPD_BITS_LEN)-1) << AW88261_AMPPD_START_BIT))
+
+#define AW88261_UVLS_START_BIT		(14)
+#define AW88261_UVLS_NORMAL		(0)
+#define AW88261_UVLS_NORMAL_VALUE	\
+	(AW88261_UVLS_NORMAL << AW88261_UVLS_START_BIT)
+
+#define AW88261_BSTOCS_START_BIT	(11)
+#define AW88261_BSTOCS_OVER_CURRENT	(1)
+#define AW88261_BSTOCS_OVER_CURRENT_VALUE	\
+	(AW88261_BSTOCS_OVER_CURRENT << AW88261_BSTOCS_START_BIT)
+
+#define AW88261_BSTS_START_BIT		(9)
+#define AW88261_BSTS_FINISHED		(1)
+#define AW88261_BSTS_FINISHED_VALUE	\
+	(AW88261_BSTS_FINISHED << AW88261_BSTS_START_BIT)
+
+#define AW88261_SWS_START_BIT		(8)
+#define AW88261_SWS_SWITCHING		(1)
+#define AW88261_SWS_SWITCHING_VALUE	\
+	(AW88261_SWS_SWITCHING << AW88261_SWS_START_BIT)
+
+#define AW88261_NOCLKS_START_BIT	(5)
+#define AW88261_NOCLKS_NO_CLOCK	(1)
+#define AW88261_NOCLKS_NO_CLOCK_VALUE	\
+	(AW88261_NOCLKS_NO_CLOCK << AW88261_NOCLKS_START_BIT)
+
+#define AW88261_CLKS_START_BIT		(4)
+#define AW88261_CLKS_STABLE		(1)
+#define AW88261_CLKS_STABLE_VALUE	\
+	(AW88261_CLKS_STABLE << AW88261_CLKS_START_BIT)
+
+#define AW88261_OCDS_START_BIT		(3)
+#define AW88261_OCDS_OC		(1)
+#define AW88261_OCDS_OC_VALUE		\
+	(AW88261_OCDS_OC << AW88261_OCDS_START_BIT)
+
+#define AW88261_OTHS_START_BIT		(1)
+#define AW88261_OTHS_OT		(1)
+#define AW88261_OTHS_OT_VALUE		\
+	(AW88261_OTHS_OT << AW88261_OTHS_START_BIT)
+
+#define AW88261_PLLS_START_BIT		(0)
+#define AW88261_PLLS_LOCKED		(1)
+#define AW88261_PLLS_LOCKED_VALUE	\
+	(AW88261_PLLS_LOCKED << AW88261_PLLS_START_BIT)
+
+#define AW88261_BIT_PLL_CHECK \
+		(AW88261_CLKS_STABLE_VALUE | \
+		AW88261_PLLS_LOCKED_VALUE)
+
+#define AW88261_BIT_SYSST_CHECK_MASK \
+		(~(AW88261_UVLS_NORMAL_VALUE | \
+		AW88261_BSTOCS_OVER_CURRENT_VALUE | \
+		AW88261_BSTS_FINISHED_VALUE | \
+		AW88261_SWS_SWITCHING_VALUE | \
+		AW88261_NOCLKS_NO_CLOCK_VALUE | \
+		AW88261_CLKS_STABLE_VALUE | \
+		AW88261_OCDS_OC_VALUE | \
+		AW88261_OTHS_OT_VALUE | \
+		AW88261_PLLS_LOCKED_VALUE))
+
+#define AW88261_BIT_SYSST_CHECK \
+		(AW88261_BSTS_FINISHED_VALUE | \
+		AW88261_SWS_SWITCHING_VALUE | \
+		AW88261_CLKS_STABLE_VALUE | \
+		AW88261_PLLS_LOCKED_VALUE)
+
+#define AW88261_ULS_HMUTE_START_BIT	(14)
+#define AW88261_ULS_HMUTE_BITS_LEN	(1)
+#define AW88261_ULS_HMUTE_MASK		\
+	(~(((1<<AW88261_ULS_HMUTE_BITS_LEN)-1) << AW88261_ULS_HMUTE_START_BIT))
+
+#define AW88261_ULS_HMUTE_DISABLE	(0)
+#define AW88261_ULS_HMUTE_DISABLE_VALUE	\
+	(AW88261_ULS_HMUTE_DISABLE << AW88261_ULS_HMUTE_START_BIT)
+
+#define AW88261_ULS_HMUTE_ENABLE	(1)
+#define AW88261_ULS_HMUTE_ENABLE_VALUE	\
+	(AW88261_ULS_HMUTE_ENABLE << AW88261_ULS_HMUTE_START_BIT)
+
+#define AW88261_HMUTE_START_BIT	(8)
+#define AW88261_HMUTE_BITS_LEN		(1)
+#define AW88261_HMUTE_MASK		\
+	(~(((1<<AW88261_HMUTE_BITS_LEN)-1) << AW88261_HMUTE_START_BIT))
+
+#define AW88261_HMUTE_DISABLE		(0)
+#define AW88261_HMUTE_DISABLE_VALUE	\
+	(AW88261_HMUTE_DISABLE << AW88261_HMUTE_START_BIT)
+
+#define AW88261_HMUTE_ENABLE		(1)
+#define AW88261_HMUTE_ENABLE_VALUE	\
+	(AW88261_HMUTE_ENABLE << AW88261_HMUTE_START_BIT)
+
+#define AW88261_AMPPD_START_BIT	(1)
+#define AW88261_AMPPD_BITS_LEN		(1)
+#define AW88261_AMPPD_MASK		\
+	(~(((1<<AW88261_AMPPD_BITS_LEN)-1) << AW88261_AMPPD_START_BIT))
+
+#define AW88261_AMPPD_WORKING		(0)
+#define AW88261_AMPPD_WORKING_VALUE	\
+	(AW88261_AMPPD_WORKING << AW88261_AMPPD_START_BIT)
+
+#define AW88261_AMPPD_POWER_DOWN	(1)
+#define AW88261_AMPPD_POWER_DOWN_VALUE	\
+	(AW88261_AMPPD_POWER_DOWN << AW88261_AMPPD_START_BIT)
+
+#define AW88261_PWDN_START_BIT		(0)
+#define AW88261_PWDN_BITS_LEN		(1)
+#define AW88261_PWDN_MASK		\
+	(~(((1<<AW88261_PWDN_BITS_LEN)-1) << AW88261_PWDN_START_BIT))
+
+#define AW88261_PWDN_WORKING		(0)
+#define AW88261_PWDN_WORKING_VALUE	\
+	(AW88261_PWDN_WORKING << AW88261_PWDN_START_BIT)
+
+#define AW88261_PWDN_POWER_DOWN	(1)
+#define AW88261_PWDN_POWER_DOWN_VALUE	\
+	(AW88261_PWDN_POWER_DOWN << AW88261_PWDN_START_BIT)
+
+#define AW88261_MUTE_VOL		(90 * 8)
+#define AW88261_VOLUME_STEP_DB		(6 * 8)
+
+#define AW88261_VOL_6DB_START		(6)
+
+#define AW88261_VOL_START_BIT		(0)
+#define AW88261_VOL_BITS_LEN		(10)
+#define AW88261_VOL_MASK		\
+	(~(((1<<AW88261_VOL_BITS_LEN)-1) << AW88261_VOL_START_BIT))
+
+#define AW88261_VOL_DEFAULT_VALUE	(0)
+
+#define AW88261_I2STXEN_START_BIT	(6)
+#define AW88261_I2STXEN_BITS_LEN	(1)
+#define AW88261_I2STXEN_MASK		\
+	(~(((1<<AW88261_I2STXEN_BITS_LEN)-1) << AW88261_I2STXEN_START_BIT))
+
+#define AW88261_I2STXEN_DISABLE	(0)
+#define AW88261_I2STXEN_DISABLE_VALUE	\
+	(AW88261_I2STXEN_DISABLE << AW88261_I2STXEN_START_BIT)
+
+#define AW88261_I2STXEN_ENABLE		(1)
+#define AW88261_I2STXEN_ENABLE_VALUE	\
+	(AW88261_I2STXEN_ENABLE << AW88261_I2STXEN_START_BIT)
+
+#define AW88261_CCO_MUX_START_BIT	(14)
+#define AW88261_CCO_MUX_BITS_LEN	(1)
+#define AW88261_CCO_MUX_MASK		\
+	(~(((1<<AW88261_CCO_MUX_BITS_LEN)-1) << AW88261_CCO_MUX_START_BIT))
+
+#define AW88261_CCO_MUX_DIVIDED	(0)
+#define AW88261_CCO_MUX_DIVIDED_VALUE	\
+	(AW88261_CCO_MUX_DIVIDED << AW88261_CCO_MUX_START_BIT)
+
+#define AW88261_CCO_MUX_BYPASS		(1)
+#define AW88261_CCO_MUX_BYPASS_VALUE	\
+	(AW88261_CCO_MUX_BYPASS << AW88261_CCO_MUX_START_BIT)
+
+#define AW88261_EF_VSN_GESLP_H_START_BIT	(0)
+#define AW88261_EF_VSN_GESLP_H_BITS_LEN	(10)
+#define AW88261_EF_VSN_GESLP_H_MASK		\
+	(~(((1<<AW88261_EF_VSN_GESLP_H_BITS_LEN)-1) << AW88261_EF_VSN_GESLP_H_START_BIT))
+
+#define AW88261_EF_VSN_GESLP_L_START_BIT	(0)
+#define AW88261_EF_VSN_GESLP_L_BITS_LEN	(10)
+#define AW88261_EF_VSN_GESLP_L_MASK		\
+	(~(((1<<AW88261_EF_VSN_GESLP_L_BITS_LEN)-1) << AW88261_EF_VSN_GESLP_L_START_BIT))
+
+#define AW88261_FORCE_PWM_START_BIT		(12)
+#define AW88261_FORCE_PWM_BITS_LEN		(1)
+#define AW88261_FORCE_PWM_MASK			\
+	(~(((1<<AW88261_FORCE_PWM_BITS_LEN)-1) << AW88261_FORCE_PWM_START_BIT))
+
+#define AW88261_FORCE_PWM_FORCEMINUS_PWM	(1)
+#define AW88261_FORCE_PWM_FORCEMINUS_PWM_VALUE	\
+	(AW88261_FORCE_PWM_FORCEMINUS_PWM << AW88261_FORCE_PWM_START_BIT)
+
+#define AW88261_BST_OS_WIDTH_START_BIT		(0)
+#define AW88261_BST_OS_WIDTH_BITS_LEN		(3)
+#define AW88261_BST_OS_WIDTH_MASK		\
+	(~(((1<<AW88261_BST_OS_WIDTH_BITS_LEN)-1) << AW88261_BST_OS_WIDTH_START_BIT))
+
+#define AW88261_BST_OS_WIDTH_50NS		(4)
+#define AW88261_BST_OS_WIDTH_50NS_VALUE	\
+	(AW88261_BST_OS_WIDTH_50NS << AW88261_BST_OS_WIDTH_START_BIT)
+
+/* BST_LOOPR bit 1:0 (BSTCTRL6 0x65) */
+#define AW88261_BST_LOOPR_START_BIT	(0)
+#define AW88261_BST_LOOPR_BITS_LEN	(2)
+#define AW88261_BST_LOOPR_MASK		\
+	(~(((1<<AW88261_BST_LOOPR_BITS_LEN)-1) << AW88261_BST_LOOPR_START_BIT))
+
+#define AW88261_BST_LOOPR_340K		(2)
+#define AW88261_BST_LOOPR_340K_VALUE	\
+	(AW88261_BST_LOOPR_340K << AW88261_BST_LOOPR_START_BIT)
+
+/* RSQN_DLY bit 15:14 (BSTCTRL7 0x66) */
+#define AW88261_RSQN_DLY_START_BIT	(14)
+#define AW88261_RSQN_DLY_BITS_LEN	(2)
+#define AW88261_RSQN_DLY_MASK		\
+	(~(((1<<AW88261_RSQN_DLY_BITS_LEN)-1) << AW88261_RSQN_DLY_START_BIT))
+
+#define AW88261_RSQN_DLY_35NS		(2)
+#define AW88261_RSQN_DLY_35NS_VALUE	\
+	(AW88261_RSQN_DLY_35NS << AW88261_RSQN_DLY_START_BIT)
+
+/* BURST_SSMODE bit 3 (BSTCTRL8 0x67) */
+#define AW88261_BURST_SSMODE_START_BIT	(3)
+#define AW88261_BURST_SSMODE_BITS_LEN	(1)
+#define AW88261_BURST_SSMODE_MASK	\
+	(~(((1<<AW88261_BURST_SSMODE_BITS_LEN)-1) << AW88261_BURST_SSMODE_START_BIT))
+
+#define AW88261_BURST_SSMODE_FAST	(0)
+#define AW88261_BURST_SSMODE_FAST_VALUE	\
+	(AW88261_BURST_SSMODE_FAST << AW88261_BURST_SSMODE_START_BIT)
+
+/* BST_BURST bit 9:7 (BSTCTRL9 0x68) */
+#define AW88261_BST_BURST_START_BIT	(7)
+#define AW88261_BST_BURST_BITS_LEN	(3)
+#define AW88261_BST_BURST_MASK		\
+	(~(((1<<AW88261_BST_BURST_BITS_LEN)-1) << AW88261_BST_BURST_START_BIT))
+
+#define AW88261_BST_BURST_30MA		(2)
+#define AW88261_BST_BURST_30MA_VALUE	\
+	(AW88261_BST_BURST_30MA << AW88261_BST_BURST_START_BIT)
+
+#define AW88261_EF_VSN_GESLP_SIGN_MASK		(~0x0200)
+#define AW88261_EF_VSN_GESLP_NEG		(~0xfc00)
+
+#define AW88261_EF_ISN_GESLP_SIGN_MASK		(~0x0200)
+#define AW88261_EF_ISN_GESLP_NEG		(~0xfc00)
+
+#define AW88261_EF_ISN_GESLP_H_START_BIT	(0)
+#define AW88261_EF_ISN_GESLP_H_BITS_LEN	(10)
+#define AW88261_EF_ISN_GESLP_H_MASK		\
+	(~(((1<<AW88261_EF_ISN_GESLP_H_BITS_LEN)-1) << AW88261_EF_ISN_GESLP_H_START_BIT))
+
+#define AW88261_EF_ISN_GESLP_L_START_BIT	(0)
+#define AW88261_EF_ISN_GESLP_L_BITS_LEN	(10)
+#define AW88261_EF_ISN_GESLP_L_MASK		\
+	(~(((1<<AW88261_EF_ISN_GESLP_L_BITS_LEN)-1) << AW88261_EF_ISN_GESLP_L_START_BIT))
+
+#define AW88261_CABL_BASE_VALUE		(1000)
+#define AW88261_ICABLK_FACTOR		(1)
+#define AW88261_VCABLK_FACTOR		(1)
+
+#define AW88261_VCAL_FACTOR		(1<<13)
+
+#define AW88261_START_RETRIES		(5)
+#define AW88261_START_WORK_DELAY_MS	(0)
+
+#define AW88261_I2C_NAME		"aw88261_smartpa"
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
+#define AW88261_DEV_DEFAULT_CH		(0)
+#define AW88261_ACF_FILE		"aw88261_acf.bin"
+#define AW88261_DEV_SYSST_CHECK_MAX	(10)
+#define AW88261_SOFT_RESET_VALUE	(0x55aa)
+#define AW88261_REG_TO_DB		(0x3f)
+#define AW88261_VOL_START_MASK		(0xfc00)
+#define AW88261_INIT_PROFILE		(0)
+
+#define REG_VAL_TO_DB(value)		((((value) >> AW88261_VOL_6DB_START) * \
+					AW88261_VOLUME_STEP_DB) + \
+					((value) & AW88261_REG_TO_DB))
+#define DB_TO_REG_VAL(value)		((((value) / AW88261_VOLUME_STEP_DB) << \
+					AW88261_VOL_6DB_START) + \
+					((value) % AW88261_VOLUME_STEP_DB))
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
+enum aw88261_id {
+	AW88261_CHIP_ID = 0x2113,
+};
+
+enum {
+	AW88261_500_US = 500,
+	AW88261_1000_US = 1000,
+	AW88261_2000_US = 2000,
+};
+
+enum {
+	AW88261_DEV_PW_OFF = 0,
+	AW88261_DEV_PW_ON,
+};
+
+enum {
+	AW88261_DEV_FW_FAILED = 0,
+	AW88261_DEV_FW_OK,
+};
+
+enum {
+	AW88261_EF_AND_CHECK = 0,
+	AW88261_EF_OR_CHECK,
+};
+
+enum {
+	AW88261_FRCSET_DISABLE = 0,
+	AW88261_FRCSET_ENABLE,
+};
+
+struct aw88261 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct gpio_desc *reset_gpio;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+	struct aw_container *aw_cfg;
+
+	int efuse_check;
+	int frcset_en;
+	unsigned int mute_st;
+	unsigned int amppd_st;
+
+	unsigned char phase_sync;
+};
+
+#endif
-- 
2.41.0

