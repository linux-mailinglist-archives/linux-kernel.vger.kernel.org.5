Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380BE767D90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjG2JOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjG2JOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:14:23 -0400
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5336855BC;
        Sat, 29 Jul 2023 02:13:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00579657-0.00251078-0.991693;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.U3WkWtD_1690621960;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.U3WkWtD_1690621960)
          by smtp.aliyun-inc.com;
          Sat, 29 Jul 2023 17:12:42 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        wangweidong.a@awinic.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru, povik+lin@cutebit.org,
        liweilei@awinic.com, yijiangtao@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
Subject: [PATCH V3 4/5] ASoC: codecs: aw88261 device related operation functions
Date:   Sat, 29 Jul 2023 17:12:22 +0800
Message-ID: <20230729091223.193466-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230729091223.193466-1-wangweidong.a@awinic.com>
References: <20230729091223.193466-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weidong Wang <wangweidong.a@awinic.com>

Operate the aw88261 chip, including device initialization,
chip power-on and power-off, control volume, etc.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/aw88261/aw88261_device.c | 877 ++++++++++++++++++++++
 sound/soc/codecs/aw88261/aw88261_device.h |  79 ++
 2 files changed, 956 insertions(+)
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.c
 create mode 100644 sound/soc/codecs/aw88261/aw88261_device.h

diff --git a/sound/soc/codecs/aw88261/aw88261_device.c b/sound/soc/codecs/aw88261/aw88261_device.c
new file mode 100644
index 000000000000..40fb9a60599d
--- /dev/null
+++ b/sound/soc/codecs/aw88261/aw88261_device.c
@@ -0,0 +1,877 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261_device.c --  AW88261 function for ALSA Audio Driver
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Jimmy Zhang <zhangjianming@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/crc32.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include "aw88261_device.h"
+#include "aw88261_reg.h"
+#include "../aw88395/aw88395_data_type.h"
+
+static unsigned int reg_val_to_db(unsigned int value)
+{
+	return (((value >> AW88261_VOL_6DB_START) *
+				AW88261_VOLUME_STEP_DB) + (value & AW88261_REG_TO_DB));
+}
+
+static unsigned short db_to_reg_val(unsigned short value)
+{
+	return (((value / AW88261_VOLUME_STEP_DB) << AW88261_VOL_6DB_START) +
+			(value % AW88261_VOLUME_STEP_DB));
+}
+
+void aw88261_dev_set_volume(struct aw88261_device *aw_dev, unsigned int value)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->aw88261_base->volume_desc;
+	unsigned int reg_value;
+	u16 real_value, volume;
+
+	volume = min((value + vol_desc->init_volume), (unsigned int)AW88261_MUTE_VOL);
+	real_value = db_to_reg_val(volume);
+
+	/* cal real value */
+	regmap_read(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL2_REG, &reg_value);
+
+	real_value = (real_value << AW88261_VOL_START_BIT) | (reg_value & AW88261_VOL_START_MASK);
+
+	dev_dbg(aw_dev->dev, "value 0x%x , real_value:0x%x", value, real_value);
+
+	/* write value */
+	regmap_write(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL2_REG, real_value);
+}
+
+static void aw_dev_fade_in(struct aw88261_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->aw88261_base->volume_desc;
+	int fade_step = aw_dev->aw88261_base->fade_step;
+	int fade_in_vol = desc->ctl_volume;
+	int i;
+
+	if (fade_step == 0 || aw_dev->aw88261_base->fade_in_time == 0) {
+		aw88261_dev_set_volume(aw_dev, fade_in_vol);
+		return;
+	}
+
+	for (i = AW88261_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
+		aw88261_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->aw88261_base->fade_in_time,
+					aw_dev->aw88261_base->fade_in_time + 10);
+	}
+
+	if (i != fade_in_vol)
+		aw88261_dev_set_volume(aw_dev, fade_in_vol);
+}
+
+static void aw_dev_fade_out(struct aw88261_device *aw_dev)
+{
+	struct aw_device *aw88261_base = aw_dev->aw88261_base;
+	struct aw_volume_desc *desc = &aw88261_base->volume_desc;
+	int fade_step = aw88261_base->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->aw88261_base->fade_out_time == 0) {
+		aw88261_dev_set_volume(aw_dev, AW88261_MUTE_VOL);
+		return;
+	}
+
+	for (i = desc->ctl_volume; i <= AW88261_MUTE_VOL; i += fade_step) {
+		aw88261_dev_set_volume(aw_dev, i);
+		usleep_range(aw88261_base->fade_out_time, aw88261_base->fade_out_time + 10);
+	}
+
+	if (i != AW88261_MUTE_VOL) {
+		aw88261_dev_set_volume(aw_dev, AW88261_MUTE_VOL);
+		usleep_range(aw88261_base->fade_out_time, aw88261_base->fade_out_time + 10);
+	}
+}
+
+static void aw_dev_i2s_tx_enable(struct aw88261_device *aw_dev, bool flag)
+{
+	if (flag)
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_I2SCFG1_REG,
+			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_I2SCFG1_REG,
+			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
+}
+
+static void aw_dev_pwd(struct aw88261_device *aw_dev, bool pwd)
+{
+	if (pwd)
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK,	AW88261_PWDN_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_PWDN_MASK,	AW88261_PWDN_WORKING_VALUE);
+}
+
+static void aw_dev_amppd(struct aw88261_device *aw_dev, bool amppd)
+{
+	if (amppd)
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_POWER_DOWN_VALUE);
+	else
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_AMPPD_MASK, AW88261_AMPPD_WORKING_VALUE);
+}
+
+void aw88261_dev_mute(struct aw88261_device *aw_dev, bool is_mute)
+{
+	if (is_mute) {
+		aw_dev_fade_out(aw_dev);
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_HMUTE_MASK, AW88261_HMUTE_ENABLE_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_HMUTE_MASK, AW88261_HMUTE_DISABLE_VALUE);
+		aw_dev_fade_in(aw_dev);
+	}
+}
+
+static void aw88261_dev_uls_hmute(struct aw88261_device *aw_dev, bool uls_hmute)
+{
+	if (uls_hmute)
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_ULS_HMUTE_MASK,
+				AW88261_ULS_HMUTE_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_SYSCTRL_REG,
+				~AW88261_ULS_HMUTE_MASK,
+				AW88261_ULS_HMUTE_DISABLE_VALUE);
+}
+
+static int aw_dev_get_icalk(struct aw88261_device *aw_dev, int16_t *icalk)
+{
+	u16 reg_icalk, reg_icalkl;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_EFRH4_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_icalk = reg_val & (~AW88261_EF_ISN_GESLP_H_MASK);
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_EFRL4_REG, &reg_val);
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
+static int aw_dev_get_vcalk(struct aw88261_device *aw_dev, int16_t *vcalk)
+{
+	u16 reg_vcalk, reg_vcalkl;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_EFRH3_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_vcalk = (u16)reg_val & (~AW88261_EF_VSN_GESLP_H_MASK);
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_EFRL3_REG, &reg_val);
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
+static int aw_dev_set_vcalb(struct aw88261_device *aw_dev)
+{
+	int16_t icalk_val, vcalk_val;
+	int icalk, vcalk, vcalb;
+	u32 reg_val;
+	int ret;
+
+	ret = aw_dev_get_icalk(aw_dev, &icalk_val);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s:get icalk failed\n", __func__);
+		return ret;
+	}
+
+	ret = aw_dev_get_vcalk(aw_dev, &vcalk_val);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s:get vcalk failed\n", __func__);
+		return ret;
+	}
+
+	icalk = AW88261_CABL_BASE_VALUE + AW88261_ICABLK_FACTOR * icalk_val;
+	vcalk = AW88261_CABL_BASE_VALUE + AW88261_VCABLK_FACTOR * vcalk_val;
+	if (!vcalk) {
+		dev_err(aw_dev->dev, "vcalk is 0");
+		return -EINVAL;
+	}
+
+	vcalb = AW88261_VCAL_FACTOR * icalk / vcalk;
+	reg_val = (unsigned int)vcalb;
+
+	dev_dbg(aw_dev->dev, "icalk=%d, vcalk=%d, vcalb=%d, reg_val=0x%04x",
+			icalk, vcalk, vcalb, reg_val);
+	ret = regmap_write(aw_dev->aw88261_base->regmap, AW88261_VSNTM1_REG, reg_val);
+
+	return ret;
+}
+
+static void aw_dev_clear_int_status(struct aw88261_device *aw_dev)
+{
+	unsigned int int_status;
+
+	/* read int status and clear */
+	regmap_read(aw_dev->aw88261_base->regmap, AW88261_SYSINT_REG, &int_status);
+	/* make sure int status is clear */
+	regmap_read(aw_dev->aw88261_base->regmap, AW88261_SYSINT_REG, &int_status);
+
+	dev_dbg(aw_dev->dev, "read interrupt reg = 0x%04x", int_status);
+}
+
+static int aw_dev_get_iis_status(struct aw88261_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_SYSST_REG, &reg_val);
+	if (ret)
+		return -EIO;
+	if ((reg_val & AW88261_BIT_PLL_CHECK) != AW88261_BIT_PLL_CHECK) {
+		dev_err(aw_dev->dev, "check pll lock fail, reg_val:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int aw_dev_check_mode1_pll(struct aw88261_device *aw_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw_dev_get_iis_status(aw_dev);
+		if (ret < 0) {
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
+static int aw_dev_check_mode2_pll(struct aw88261_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_PLLCTRL1_REG, &reg_val);
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
+	ret = regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_PLLCTRL1_REG,
+			~AW88261_CCO_MUX_MASK, AW88261_CCO_MUX_DIVIDED_VALUE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 iis signal check error");
+			usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	/* change mode1 */
+	ret = regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_PLLCTRL1_REG,
+			~AW88261_CCO_MUX_MASK, AW88261_CCO_MUX_BYPASS_VALUE);
+	if (ret == 0) {
+		usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+		for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+			ret = aw_dev_check_mode1_pll(aw_dev);
+			if (ret < 0) {
+				dev_err(aw_dev->dev, "mode1 iis signal check error");
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
+static int aw_dev_check_syspll(struct aw88261_device *aw_dev)
+{
+	int ret;
+
+	ret = aw_dev_check_mode1_pll(aw_dev);
+	if (ret) {
+		dev_dbg(aw_dev->dev, "mode1 check iis failed try switch to mode2 check");
+		ret = aw_dev_check_mode2_pll(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 check iis failed");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int aw_dev_check_sysst(struct aw88261_device *aw_dev)
+{
+	unsigned int check_val;
+	unsigned int reg_val;
+	int ret, i;
+
+	for (i = 0; i < AW88261_DEV_SYSST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_SYSST_REG, &reg_val);
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
+static int aw_dev_update_reg_container(struct aw88261_device *aw_dev,
+				unsigned char *data, unsigned int len)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->aw88261_base->volume_desc;
+	unsigned int read_val, efcheck_val;
+	int16_t *reg_data;
+	int data_len;
+	u16 read_vol;
+	u16 reg_val;
+	u8 reg_addr;
+	int i, ret;
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
+			aw_dev->amppd_st = reg_val & (~AW88261_AMPPD_MASK);
+			ret = regmap_read(aw_dev->aw88261_base->regmap, reg_addr, &read_val);
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
+				aw_dev->efuse_check = AW_EF_OR_CHECK;
+			else
+				aw_dev->efuse_check = AW_EF_AND_CHECK;
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
+			aw_dev->aw88261_base->volume_desc.init_volume =
+				reg_val_to_db(read_vol);
+		}
+
+		if (reg_addr == AW88261_VSNTM1_REG)
+			continue;
+
+		dev_dbg(aw_dev->dev, "reg=0x%04x, val = 0x%04x",
+				(uint16_t)reg_addr, (uint16_t)reg_val);
+
+		ret = regmap_write(aw_dev->aw88261_base->regmap, reg_addr, reg_val);
+		if (ret)
+			break;
+
+	}
+
+	ret = aw_dev_set_vcalb(aw_dev);
+	if (ret)
+		return ret;
+
+	if (aw_dev->aw88261_base->prof_cur != aw_dev->aw88261_base->prof_index)
+		vol_desc->ctl_volume = 0;
+
+	/* keep min volume */
+	aw88261_dev_set_volume(aw_dev, vol_desc->mute_volume);
+
+	return ret;
+}
+
+static int aw_dev_reg_update(struct aw88261_device *aw_dev,
+					unsigned char *data, unsigned int len)
+{
+	int ret;
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "reg data is null or len is 0");
+		return -EINVAL;
+	}
+
+	ret = aw_dev_update_reg_container(aw_dev, data, len);
+	if (ret)
+		dev_err(aw_dev->dev, "reg update failed");
+
+	return ret;
+}
+
+static int aw_frcset_check(struct aw88261_device *aw_dev)
+{
+	unsigned int reg_val;
+	u16 temh, teml, tem;
+	int ret;
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_EFRH3_REG, &reg_val);
+	if (ret)
+		return ret;
+	temh = ((u16)reg_val & (~AW88261_TEMH_MASK));
+
+	ret = regmap_read(aw_dev->aw88261_base->regmap, AW88261_EFRL3_REG, &reg_val);
+	if (ret)
+		return ret;
+	teml = ((u16)reg_val & (~AW88261_TEML_MASK));
+
+	if (aw_dev->efuse_check == AW_EF_OR_CHECK)
+		tem = (temh | teml);
+	else
+		tem = (temh & teml);
+
+	if (tem == AW88261_DEFAULT_CFG)
+		aw_dev->frcset_en = AW_FRCSET_ENABLE;
+	else
+		aw_dev->frcset_en = AW_FRCSET_DISABLE;
+
+	dev_dbg(aw_dev->dev, "tem is 0x%04x, frcset_en is %d",
+						tem, aw_dev->frcset_en);
+
+	return ret;
+}
+
+static void aw88261_reg_force_set(struct aw88261_device *aw_dev)
+{
+	if (aw_dev->frcset_en == AW_FRCSET_ENABLE) {
+		/* set FORCE_PWM */
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_BSTCTRL3_REG,
+				AW88261_FORCE_PWM_MASK, AW88261_FORCE_PWM_FORCEMINUS_PWM_VALUE);
+		/* set BOOST_OS_WIDTH */
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_BSTCTRL5_REG,
+				AW88261_BST_OS_WIDTH_MASK, AW88261_BST_OS_WIDTH_50NS_VALUE);
+		/* set BURST_LOOPR */
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_BSTCTRL6_REG,
+				AW88261_BST_LOOPR_MASK, AW88261_BST_LOOPR_340K_VALUE);
+		/* set RSQN_DLY */
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_BSTCTRL7_REG,
+				AW88261_RSQN_DLY_MASK, AW88261_RSQN_DLY_35NS_VALUE);
+		/* set BURST_SSMODE */
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_BSTCTRL8_REG,
+				AW88261_BURST_SSMODE_MASK, AW88261_BURST_SSMODE_FAST_VALUE);
+		/* set BST_BURST */
+		regmap_update_bits(aw_dev->aw88261_base->regmap, AW88261_BSTCTRL9_REG,
+				AW88261_BST_BURST_MASK, AW88261_BST_BURST_30MA_VALUE);
+	} else {
+		dev_dbg(aw_dev->dev, "needn't set reg value");
+	}
+}
+
+static int aw_dev_fw_update(struct aw88261_device *aw_dev)
+{
+	struct aw_prof_desc *prof_index_desc;
+	struct aw_sec_data_desc *sec_desc;
+	char *prof_name;
+	int ret;
+
+	prof_name = aw88261_dev_get_prof_name(aw_dev, aw_dev->aw88261_base->prof_index);
+	if (!prof_name) {
+		dev_err(aw_dev->dev, "get prof_name failed");
+		return -EINVAL;
+	}
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw88261_dev_get_prof_data(aw_dev, aw_dev->aw88261_base->prof_index, &prof_index_desc);
+	if (ret)
+		return ret;
+
+	/* update reg */
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw_dev_reg_update(aw_dev, sec_desc[AW88395_DATA_TYPE_REG].data,
+					sec_desc[AW88395_DATA_TYPE_REG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update reg failed");
+		return ret;
+	}
+
+	aw_dev->aw88261_base->prof_cur = aw_dev->aw88261_base->prof_index;
+
+	return ret;
+}
+
+int aw88261_dev_reg_update(struct aw88261_device *aw_dev, bool force)
+{
+	int ret;
+
+	if (force) {
+		ret = regmap_write(aw_dev->aw88261_base->regmap,
+					AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
+		if (ret < 0)
+			return ret;
+
+		ret = aw_dev_fw_update(aw_dev);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (aw_dev->aw88261_base->prof_cur != aw_dev->aw88261_base->prof_index) {
+			ret = aw_dev_fw_update(aw_dev);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	aw_dev->aw88261_base->prof_cur = aw_dev->aw88261_base->prof_index;
+
+	return ret;
+}
+
+int aw88261_dev_start(struct aw88261_device *aw_dev)
+{
+	int ret;
+
+	if (aw_dev->aw88261_base->status == AW88261_DEV_PW_ON) {
+		dev_info(aw_dev->aw88261_base->dev, "already power on");
+		return 0;
+	}
+
+	/* power on */
+	aw_dev_pwd(aw_dev, false);
+	usleep_range(AW88261_2000_US, AW88261_2000_US + 10);
+
+	ret = aw_dev_check_syspll(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "pll check failed cannot start");
+		goto pll_check_fail;
+	}
+
+	/* amppd on */
+	aw_dev_amppd(aw_dev, false);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 50);
+
+	/* check i2s status */
+	ret = aw_dev_check_sysst(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "sysst check failed");
+		goto sysst_check_fail;
+	}
+
+	/* enable tx feedback */
+	aw_dev_i2s_tx_enable(aw_dev, true);
+
+	if (aw_dev->amppd_st)
+		aw_dev_amppd(aw_dev, true);
+
+	aw88261_reg_force_set(aw_dev);
+
+	/* close uls mute */
+	aw88261_dev_uls_hmute(aw_dev, false);
+
+	/* close mute */
+	if (!aw_dev->mute_st)
+		aw88261_dev_mute(aw_dev, false);
+
+	/* clear inturrupt */
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev->aw88261_base->status = AW88261_DEV_PW_ON;
+
+	return 0;
+
+sysst_check_fail:
+	aw_dev_i2s_tx_enable(aw_dev, false);
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev_amppd(aw_dev, true);
+pll_check_fail:
+	aw_dev_pwd(aw_dev, true);
+	aw_dev->aw88261_base->status = AW88261_DEV_PW_OFF;
+
+	return ret;
+}
+
+int aw88261_dev_stop(struct aw88261_device *aw_dev)
+{
+	if (aw_dev->aw88261_base->status == AW88261_DEV_PW_OFF) {
+		dev_info(aw_dev->aw88261_base->dev, "already power off");
+		return 0;
+	}
+
+	aw_dev->aw88261_base->status = AW88261_DEV_PW_OFF;
+
+	/* clear inturrupt */
+	aw_dev_clear_int_status(aw_dev);
+
+	aw88261_dev_uls_hmute(aw_dev, true);
+	/* set mute */
+	aw88261_dev_mute(aw_dev, true);
+
+	/* close tx feedback */
+	aw_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
+
+	/* enable amppd */
+	aw_dev_amppd(aw_dev, true);
+
+	/* set power down */
+	aw_dev_pwd(aw_dev, true);
+
+	dev_dbg(aw_dev->dev, "pa stop success\n");
+
+	return 0;
+}
+
+int aw88261_dev_init(struct aw88261_device *aw_dev, struct aw_container *aw_cfg)
+{
+	int ret;
+
+	if ((!aw_dev) || (!aw_cfg)) {
+		pr_err("aw_dev is NULL or aw_cfg is NULL");
+		return -ENOMEM;
+	}
+
+	ret = aw88395_dev_cfg_load(aw_dev->aw88261_base, aw_cfg);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw_dev acf parse failed");
+		return -EINVAL;
+	}
+
+	ret = regmap_write(aw_dev->aw88261_base->regmap, AW88261_ID_REG, AW88261_SOFT_RESET_VALUE);
+	if (ret < 0)
+		return ret;
+
+	aw_dev->aw88261_base->fade_in_time = AW88261_1000_US / 10;
+	aw_dev->aw88261_base->fade_out_time = AW88261_1000_US >> 1;
+	aw_dev->aw88261_base->prof_cur = AW_INIT_PROFILE;
+	aw_dev->aw88261_base->prof_index = AW_INIT_PROFILE;
+
+	ret = aw_dev_fw_update(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = aw_frcset_check(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw_frcset_check failed ret = %d\n", ret);
+		return ret;
+	}
+
+	aw_dev_clear_int_status(aw_dev);
+
+	aw88261_dev_uls_hmute(aw_dev, true);
+
+	aw88261_dev_mute(aw_dev, true);
+
+	aw_dev_i2s_tx_enable(aw_dev, false);
+
+	usleep_range(AW88261_1000_US, AW88261_1000_US + 100);
+
+	aw_dev_amppd(aw_dev, true);
+
+	aw_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static void aw_parse_channel_dt(struct aw88261_device *aw_dev)
+{
+	struct device_node *np = aw_dev->aw88261_base->dev->of_node;
+	u32 channel_value;
+	u32 sync_enable;
+	int ret;
+
+	ret = of_property_read_u32(np, "sound-channel", &channel_value);
+	if (ret)
+		channel_value = AW88261_DEV_DEFAULT_CH;
+
+	ret = of_property_read_u32(np, "sync-flag", &sync_enable);
+	if (ret)
+		sync_enable = false;
+
+	dev_dbg(aw_dev->dev,  "sync flag is %d", sync_enable);
+	dev_dbg(aw_dev->dev, "read sound-channel value is: %d", channel_value);
+
+	aw_dev->aw88261_base->channel = channel_value;
+	aw_dev->phase_sync = sync_enable;
+}
+
+static int aw_dev_init(struct aw88261_device *aw_dev)
+{
+	aw_dev->aw88261_base->chip_id = AW88261_CHIP_ID;
+	/* call aw device init func */
+	aw_dev->aw88261_base->acf = NULL;
+	aw_dev->aw88261_base->prof_info.prof_desc = NULL;
+	aw_dev->aw88261_base->prof_info.count = 0;
+	aw_dev->aw88261_base->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->aw88261_base->channel = 0;
+	aw_dev->aw88261_base->fw_status = AW88261_DEV_FW_FAILED;
+
+	aw_dev->aw88261_base->fade_step = AW88261_VOLUME_STEP_DB;
+	aw_dev->aw88261_base->volume_desc.ctl_volume = AW88261_VOL_DEFAULT_VALUE;
+	aw_dev->aw88261_base->volume_desc.mute_volume = AW88261_MUTE_VOL;
+	aw_parse_channel_dt(aw_dev);
+
+	return 0;
+}
+
+int aw88261_dev_set_profile_index(struct aw88261_device *aw_dev, int index)
+{
+	struct aw_device *aw88261_base = aw_dev->aw88261_base;
+
+	/* check the index whether is valid */
+	if ((index >= aw88261_base->prof_info.count) || (index < 0))
+		return -EINVAL;
+	/* check the index whether change */
+	if (aw88261_base->prof_index == index)
+		return -EINVAL;
+
+	aw88261_base->prof_index = index;
+
+	return 0;
+}
+
+char *aw88261_dev_get_prof_name(struct aw88261_device *aw_dev, int index)
+{
+	struct aw_prof_info *prof_info = &aw_dev->aw88261_base->prof_info;
+	struct aw_prof_desc *prof_desc;
+
+	if ((index >= aw_dev->aw88261_base->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
+			index, aw_dev->aw88261_base->prof_info.count);
+		return NULL;
+	}
+
+	prof_desc = &aw_dev->aw88261_base->prof_info.prof_desc[index];
+
+	return prof_info->prof_name_list[prof_desc->id];
+}
+
+int aw88261_dev_get_prof_data(struct aw88261_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc)
+{
+	if ((index >= aw_dev->aw88261_base->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "%s: index[%d] overflow count[%d]\n",
+				__func__, index, aw_dev->aw88261_base->prof_info.count);
+		return -EINVAL;
+	}
+
+	*prof_desc = &aw_dev->aw88261_base->prof_info.prof_desc[index];
+
+	return 0;
+}
+
+int aw88261_init(struct aw88261_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap)
+{
+	unsigned int chip_id;
+	int ret;
+
+	if (*aw_dev) {
+		dev_info(&i2c->dev, "it should be initialized here.\n");
+	} else {
+		*aw_dev = devm_kzalloc(&i2c->dev, sizeof(struct aw88261_device), GFP_KERNEL);
+		if (!(*aw_dev))
+			return -ENOMEM;
+	}
+
+	(*aw_dev)->aw88261_base =
+			devm_kzalloc(&i2c->dev, sizeof(struct aw_device), GFP_KERNEL);
+	if (!(*aw_dev)->aw88261_base)
+		return -ENOMEM;
+
+	(*aw_dev)->aw88261_base->i2c = i2c;
+	(*aw_dev)->aw88261_base->dev = &i2c->dev;
+	(*aw_dev)->aw88261_base->regmap = regmap;
+	(*aw_dev)->dev = &i2c->dev;
+
+	/* read chip id */
+	ret = regmap_read((*aw_dev)->aw88261_base->regmap, AW88261_CHIP_ID_REG, &chip_id);
+	if (ret) {
+		dev_err((*aw_dev)->dev, "%s read chipid error. ret = %d", __func__, ret);
+		return ret;
+	}
+	dev_info((*aw_dev)->dev, "chip id = %x\n", chip_id);
+
+	switch (chip_id) {
+	case AW88261_CHIP_ID:
+		ret = aw_dev_init((*aw_dev));
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err((*aw_dev)->dev, "unsupported device");
+		break;
+	}
+
+	return ret;
+}
+
+MODULE_DESCRIPTION("AW88261 device");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88261/aw88261_device.h b/sound/soc/codecs/aw88261/aw88261_device.h
new file mode 100644
index 000000000000..c18f2328f792
--- /dev/null
+++ b/sound/soc/codecs/aw88261/aw88261_device.h
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261_device.h --  AW88261 function for ALSA Audio Driver
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Jimmy Zhang <zhangjianming@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW88261_DEVICE_FILE_H__
+#define __AW88261_DEVICE_FILE_H__
+
+#include "aw88261.h"
+#include "../aw88395/aw88395_device.h"
+
+#define AW88261_DEV_DEFAULT_CH				(0)
+#define AW88261_ACF_FILE				"aw88261_acf.bin"
+#define AW88261_DEV_SYSST_CHECK_MAX			(10)
+#define AW88261_SOFT_RESET_VALUE			(0x55aa)
+#define AW88261_REG_TO_DB				(0x3f)
+#define AW88261_VOL_START_MASK				(0xfc00)
+#define AW_INIT_PROFILE				(0)
+
+enum {
+	AW88261_1000_US = 1000,
+	AW88261_2000_US = 2000,
+	AW88261_3000_US = 3000,
+	AW88261_4000_US = 4000,
+	AW88261_5000_US = 5000,
+	AW88261_10000_US = 10000,
+	AW88261_100000_US = 100000,
+};
+
+enum AW88261_DEV_STATUS {
+	AW88261_DEV_PW_OFF = 0,
+	AW88261_DEV_PW_ON,
+};
+
+enum AW88261_DEV_FW_STATUS {
+	AW88261_DEV_FW_FAILED = 0,
+	AW88261_DEV_FW_OK,
+};
+
+enum {
+	AW_EF_AND_CHECK = 0,
+	AW_EF_OR_CHECK,
+};
+
+enum {
+	AW_FRCSET_DISABLE = 0,
+	AW_FRCSET_ENABLE,
+};
+
+struct aw88261_device {
+	struct aw_device *aw88261_base;
+	struct device *dev;
+
+	int efuse_check;
+	int frcset_en;
+	unsigned int mute_st;
+	unsigned int amppd_st;
+
+	unsigned char phase_sync;
+};
+
+int aw88261_init(struct aw88261_device **aw_dev, struct i2c_client *i2c, struct regmap *regmap);
+int aw88261_dev_init(struct aw88261_device *aw_dev, struct aw_container *aw_cfg);
+int aw88261_dev_start(struct aw88261_device *aw_dev);
+int aw88261_dev_stop(struct aw88261_device *aw_dev);
+int aw88261_dev_reg_update(struct aw88261_device *aw_dev, bool force);
+void aw88261_dev_set_volume(struct aw88261_device *aw_dev, unsigned int set_vol);
+int aw88261_dev_get_prof_data(struct aw88261_device *aw_dev, int index,
+			struct aw_prof_desc **prof_desc);
+char *aw88261_dev_get_prof_name(struct aw88261_device *aw_dev, int index);
+int aw88261_dev_set_profile_index(struct aw88261_device *aw_dev, int index);
+void aw88261_dev_mute(struct aw88261_device *aw_dev, bool is_mute);
+
+#endif
-- 
2.41.0

