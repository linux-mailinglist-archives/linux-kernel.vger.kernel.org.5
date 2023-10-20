Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC9C7D0AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376500AbjJTIff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376486AbjJTIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:35:32 -0400
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6FD6C;
        Fri, 20 Oct 2023 01:35:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0549846-0.0017938-0.943222;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.V3Yjm.w_1697790914;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.V3Yjm.w_1697790914)
          by smtp.aliyun-inc.com;
          Fri, 20 Oct 2023 16:35:21 +0800
From:   wangweidong.a@awinic.com
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, wangweidong.a@awinic.com,
        shumingf@realtek.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        ajye_huang@compal.corp-partner.google.com,
        harshit.m.mogalapalli@oracle.com, arnd@arndb.de,
        colin.i.king@gmail.com, dan.carpenter@linaro.org, trix@redhat.com,
        liweilei@awinic.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com
Subject: [PATCH V2 4/4] ASoC: codecs: Add aw88399 amplifier driver
Date:   Fri, 20 Oct 2023 16:34:26 +0800
Message-ID: <20231020083426.302925-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020083426.302925-1-wangweidong.a@awinic.com>
References: <20231020083426.302925-1-wangweidong.a@awinic.com>
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
aw88399 and their associated operation functions.

Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
---
 sound/soc/codecs/Kconfig   |   14 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/aw88399.c | 1911 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/aw88399.h |  599 +++++++++++
 4 files changed, 2526 insertions(+)
 create mode 100644 sound/soc/codecs/aw88399.c
 create mode 100644 sound/soc/codecs/aw88399.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1e1dbc509f6..956b22c0c867 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,6 +56,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_AW8738
 	imply SND_SOC_AW88395
 	imply SND_SOC_AW88261
+	imply SND_SOC_AW88399
 	imply SND_SOC_BT_SCO
 	imply SND_SOC_BD28623
 	imply SND_SOC_CHV3_CODEC
@@ -668,6 +669,19 @@ config SND_SOC_AW88261
 	  boost converter can be adjusted smartly according to
 	  the input amplitude.
 
+config SND_SOC_AW88399
+	tristate "Soc Audio for awinic aw88399"
+	depends on I2C
+	select CRC8
+	select REGMAP_I2C
+	select GPIOLIB
+	select SND_SOC_AW88399_LIB
+	help
+	  This option enables support for aw88399 Smart PA.
+	  The awinic AW88399 is an I2S/TDM input, high efficiency
+	  digital Smart K audio amplifier and SKTune speaker
+	  protection algorithms.
+
 config SND_SOC_BD28623
 	tristate "ROHM BD28623 CODEC"
 	help
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a87e56938ce5..f637b8913413 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -51,6 +51,7 @@ snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
 snd-soc-aw88395-objs := aw88395/aw88395.o \
 			aw88395/aw88395_device.o
 snd-soc-aw88261-objs := aw88261.o
+snd-soc-aw88399-objs := aw88399.o
 snd-soc-bd28623-objs := bd28623.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-chv3-codec-objs := chv3-codec.o
@@ -437,6 +438,7 @@ obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
 obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
 obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
+obj-$(CONFIG_SND_SOC_AW88399)	+=snd-soc-aw88399.o
 obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_CHV3_CODEC) += snd-soc-chv3-codec.o
diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
new file mode 100644
index 000000000000..ce30bc7cdea9
--- /dev/null
+++ b/sound/soc/codecs/aw88399.c
@@ -0,0 +1,1911 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88399.c --  ALSA SoC AW88399 codec support
+//
+// Copyright (c) 2023 AWINIC Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#include <linux/crc32.h>
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+#include "aw88399.h"
+#include "aw88395/aw88395_device.h"
+#include "aw88395/aw88395_reg.h"
+
+static const struct regmap_config aw88399_remap_config = {
+	.val_bits = 16,
+	.reg_bits = 8,
+	.max_register = AW88399_REG_MAX,
+	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static int aw_dev_dsp_write_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int dsp_data)
+{
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write addr error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW88399_DSPMDAT_REG, (u16)dsp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write data error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int aw_dev_dsp_read_16bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data)
+{
+	unsigned int temp_data;
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(aw_dev->regmap, AW88399_DSPMDAT_REG, &temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+	*dsp_data = temp_data;
+
+	return 0;
+}
+
+static int aw_dev_dsp_read_32bit(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data)
+{
+	unsigned int temp_data;
+	int ret;
+
+	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, dsp_addr);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s write error, ret=%d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(aw_dev->regmap, AW88399_DSPMDAT_REG, &temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+	*dsp_data = temp_data;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_DSPMDAT_REG, &temp_data);
+	if (ret) {
+		dev_err(aw_dev->dev, "%s read error, ret=%d", __func__, ret);
+		return ret;
+	}
+	*dsp_data |= (temp_data << 16);
+
+	return 0;
+}
+
+static int aw_dev_dsp_read(struct aw_device *aw_dev,
+		unsigned short dsp_addr, unsigned int *dsp_data, unsigned char data_type)
+{
+	u32 reg_value;
+	int ret;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	switch (data_type) {
+	case AW88399_DSP_16_DATA:
+		ret = aw_dev_dsp_read_16bit(aw_dev, dsp_addr, dsp_data);
+		if (ret)
+			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 16-bit dsp_data[0x%x] failed",
+					(u32)dsp_addr, *dsp_data);
+		break;
+	case AW88399_DSP_32_DATA:
+		ret = aw_dev_dsp_read_32bit(aw_dev, dsp_addr, dsp_data);
+		if (ret)
+			dev_err(aw_dev->dev, "read dsp_addr[0x%x] 32r-bit dsp_data[0x%x] failed",
+					(u32)dsp_addr, *dsp_data);
+		break;
+	default:
+		dev_err(aw_dev->dev, "data type[%d] unsupported", data_type);
+		ret = -EINVAL;
+		break;
+	}
+
+	/* clear dsp chip select state */
+	if (regmap_read(aw_dev->regmap, AW88399_ID_REG, &reg_value))
+		dev_err(aw_dev->dev, "%s fail to clear chip state. ret=%d\n", __func__, ret);
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return ret;
+}
+
+static void aw_dev_pwd(struct aw_device *aw_dev, bool pwd)
+{
+	int ret;
+
+	if (pwd)
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_PWDN_MASK, AW88399_PWDN_POWER_DOWN_VALUE);
+	else
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_PWDN_MASK, AW88399_PWDN_WORKING_VALUE);
+
+	if (ret)
+		dev_dbg(aw_dev->dev, "%s failed", __func__);
+}
+
+static void aw_dev_get_int_status(struct aw_device *aw_dev, unsigned short *int_status)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_SYSINT_REG, &reg_val);
+	if (ret)
+		dev_err(aw_dev->dev, "read interrupt reg fail, ret=%d", ret);
+	else
+		*int_status = reg_val;
+
+	dev_dbg(aw_dev->dev, "read interrupt reg=0x%04x", *int_status);
+}
+
+static void aw_dev_clear_int_status(struct aw_device *aw_dev)
+{
+	u16 int_status;
+
+	/* read int status and clear */
+	aw_dev_get_int_status(aw_dev, &int_status);
+	/* make sure int status is clear */
+	aw_dev_get_int_status(aw_dev, &int_status);
+	if (int_status)
+		dev_dbg(aw_dev->dev, "int status(%d) is not cleaned.\n", int_status);
+}
+
+static int aw_dev_get_iis_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_SYSST_REG, &reg_val);
+	if (ret)
+		return ret;
+	if ((reg_val & AW88399_BIT_PLL_CHECK) != AW88399_BIT_PLL_CHECK) {
+		dev_err(aw_dev->dev, "check pll lock fail, reg_val:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw_dev_check_mode1_pll(struct aw_device *aw_dev)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode1 iis signal check error");
+			usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static int aw_dev_check_mode2_pll(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_PLLCTRL2_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= (~AW88399_CCO_MUX_MASK);
+	if (reg_val == AW88399_CCO_MUX_DIVIDED_VALUE) {
+		dev_dbg(aw_dev->dev, "CCO_MUX is already divider");
+		return -EPERM;
+	}
+
+	/* change mode2 */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_PLLCTRL2_REG,
+			~AW88399_CCO_MUX_MASK, AW88399_CCO_MUX_DIVIDED_VALUE);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
+		ret = aw_dev_get_iis_status(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "mode2 iis signal check error");
+			usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+		} else {
+			break;
+		}
+	}
+
+	/* change mode1 */
+	regmap_update_bits(aw_dev->regmap, AW88399_PLLCTRL2_REG,
+			~AW88399_CCO_MUX_MASK, AW88399_CCO_MUX_BYPASS_VALUE);
+	if (ret == 0) {
+		usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+		for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
+			ret = aw_dev_get_iis_status(aw_dev);
+			if (ret) {
+				dev_err(aw_dev->dev, "mode2 switch to mode1, iis signal check error");
+				usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+			} else {
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int aw_dev_check_syspll(struct aw_device *aw_dev)
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
+	return 0;
+}
+
+static int aw_dev_check_sysst(struct aw_device *aw_dev)
+{
+	unsigned int check_val;
+	unsigned int reg_val;
+	int ret, i;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_PWMCTRL3_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	if (reg_val & (~AW88399_NOISE_GATE_EN_MASK))
+		check_val = AW88399_BIT_SYSST_NOSWS_CHECK;
+	else
+		check_val = AW88399_BIT_SYSST_SWS_CHECK;
+
+	for (i = 0; i < AW88399_DEV_SYSST_CHECK_MAX; i++) {
+		ret = regmap_read(aw_dev->regmap, AW88399_SYSST_REG, &reg_val);
+		if (ret)
+			return ret;
+
+		if ((reg_val & (~AW88399_BIT_SYSST_CHECK_MASK) & check_val) != check_val) {
+			dev_err(aw_dev->dev, "check sysst fail, cnt=%d, reg_val=0x%04x, check:0x%x",
+				i, reg_val, AW88399_BIT_SYSST_NOSWS_CHECK);
+			usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+		} else {
+			return 0;
+		}
+	}
+
+	return -EPERM;
+}
+
+static void aw_dev_amppd(struct aw_device *aw_dev, bool amppd)
+{
+	int ret;
+
+	if (amppd)
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_AMPPD_MASK, AW88399_AMPPD_POWER_DOWN_VALUE);
+	else
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_AMPPD_MASK, AW88399_AMPPD_WORKING_VALUE);
+
+	if (ret)
+		dev_dbg(aw_dev->dev, "%s failed", __func__);
+}
+
+static void aw_dev_dsp_enable(struct aw_device *aw_dev, bool is_enable)
+{
+	int ret;
+
+	if (is_enable)
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+					~AW88399_DSPBY_MASK, AW88399_DSPBY_WORKING_VALUE);
+	else
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+					~AW88399_DSPBY_MASK, AW88399_DSPBY_BYPASS_VALUE);
+
+	if (ret)
+		dev_dbg(aw_dev->dev, "%s failed\n", __func__);
+}
+
+static int aw88399_dev_get_icalk(struct aw88399 *aw88399, int16_t *icalk)
+{
+	uint16_t icalkh_val, icalkl_val, icalk_val;
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_EFRH4_REG, &reg_val);
+	if (ret)
+		return ret;
+	icalkh_val = reg_val & (~AW88399_EF_ISN_GESLP_H_MASK);
+
+	ret = regmap_read(aw_dev->regmap, AW88399_EFRL4_REG, &reg_val);
+	if (ret)
+		return ret;
+	icalkl_val = reg_val & (~AW88399_EF_ISN_GESLP_L_MASK);
+
+	if (aw88399->check_val == AW_EF_AND_CHECK)
+		icalk_val = icalkh_val & icalkl_val;
+	else
+		icalk_val = icalkh_val | icalkl_val;
+
+	if (icalk_val & (~AW88399_EF_ISN_GESLP_SIGN_MASK))
+		icalk_val = icalk_val | AW88399_EF_ISN_GESLP_SIGN_NEG;
+	*icalk = (int16_t)icalk_val;
+
+	return 0;
+}
+
+static int aw88399_dev_get_vcalk(struct aw88399 *aw88399, int16_t *vcalk)
+{
+	uint16_t vcalkh_val, vcalkl_val, vcalk_val;
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_EFRH3_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	vcalkh_val = reg_val & (~AW88399_EF_VSN_GESLP_H_MASK);
+
+	ret = regmap_read(aw_dev->regmap, AW88399_EFRL3_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	vcalkl_val = reg_val & (~AW88399_EF_VSN_GESLP_L_MASK);
+
+	if (aw88399->check_val == AW_EF_AND_CHECK)
+		vcalk_val = vcalkh_val & vcalkl_val;
+	else
+		vcalk_val = vcalkh_val | vcalkl_val;
+
+	if (vcalk_val & AW88399_EF_VSN_GESLP_SIGN_MASK)
+		vcalk_val = vcalk_val | AW88399_EF_VSN_GESLP_SIGN_NEG;
+	*vcalk = (int16_t)vcalk_val;
+
+	return 0;
+}
+
+static int aw88399_dev_get_internal_vcalk(struct aw88399 *aw88399, int16_t *vcalk)
+{
+	uint16_t vcalkh_val, vcalkl_val, vcalk_val;
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_EFRH2_REG, &reg_val);
+	if (ret)
+		return ret;
+	vcalkh_val = reg_val & (~AW88399_INTERNAL_VSN_TRIM_H_MASK);
+
+	ret = regmap_read(aw_dev->regmap, AW88399_EFRL2_REG, &reg_val);
+	if (ret)
+		return ret;
+	vcalkl_val = reg_val & (~AW88399_INTERNAL_VSN_TRIM_L_MASK);
+
+	if (aw88399->check_val == AW_EF_AND_CHECK)
+		vcalk_val = (vcalkh_val >> AW88399_INTERNAL_VSN_TRIM_H_START_BIT) &
+				(vcalkl_val >> AW88399_INTERNAL_VSN_TRIM_L_START_BIT);
+	else
+		vcalk_val = (vcalkh_val >> AW88399_INTERNAL_VSN_TRIM_H_START_BIT) |
+				(vcalkl_val >> AW88399_INTERNAL_VSN_TRIM_L_START_BIT);
+
+	if (vcalk_val & (~AW88399_TEM4_SIGN_MASK))
+		vcalk_val = vcalk_val | AW88399_TEM4_SIGN_NEG;
+
+	*vcalk = (int16_t)vcalk_val;
+
+	return 0;
+}
+
+static int aw_dev_set_vcalb(struct aw88399 *aw88399)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	unsigned int vsense_select, vsense_value;
+	int32_t ical_k, vcal_k, vcalb;
+	int16_t icalk, vcalk;
+	uint16_t reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_VSNCTRL1_REG, &vsense_value);
+	if (ret)
+		return ret;
+
+	vsense_select = vsense_select & (~AW88399_VDSEL_MASK);
+
+	ret = aw88399_dev_get_icalk(aw88399, &icalk);
+	if (ret) {
+		dev_err(aw_dev->dev, "get icalk failed\n");
+		return ret;
+	}
+
+	ical_k = icalk * AW88399_ICABLK_FACTOR + AW88399_CABL_BASE_VALUE;
+
+	switch (vsense_select) {
+	case AW88399_DEV_VDSEL_VSENSE:
+		ret = aw88399_dev_get_vcalk(aw88399, &vcalk);
+		vcal_k = vcalk * AW88399_VCABLK_FACTOR + AW88399_CABL_BASE_VALUE;
+		vcalb = AW88399_VCALB_ACCURACY * AW88399_VSCAL_FACTOR / AW88399_ISCAL_FACTOR /
+			ical_k / vcal_k * aw88399->vcalb_init_val;
+		break;
+	case AW88399_DEV_VDSEL_DAC:
+		ret = aw88399_dev_get_internal_vcalk(aw88399, &vcalk);
+		vcal_k = vcalk * AW88399_VCABLK_DAC_FACTOR + AW88399_CABL_BASE_VALUE;
+		vcalb = AW88399_VCALB_ACCURACY * AW88399_VSCAL_DAC_FACTOR /
+					AW88399_ISCAL_DAC_FACTOR / ical_k /
+					vcal_k * aw88399->vcalb_init_val;
+		break;
+	default:
+		dev_err(aw_dev->dev, "%s: unsupport vsense\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+	if (ret)
+		return ret;
+
+	vcalb = vcalb >> AW88399_VCALB_ADJ_FACTOR;
+	reg_val = (uint32_t)vcalb;
+
+	regmap_write(aw_dev->regmap, AW88399_DSPVCALB_REG, reg_val);
+
+	return 0;
+}
+
+static int aw_dev_update_cali_re(struct aw_cali_desc *cali_desc)
+{
+	struct aw_device *aw_dev =
+		container_of(cali_desc, struct aw_device, cali_desc);
+	uint16_t re_lbits, re_hbits;
+	u32 cali_re;
+	int ret;
+
+	if ((aw_dev->cali_desc.cali_re <= AW88399_CALI_RE_MAX) ||
+			(aw_dev->cali_desc.cali_re >= AW88399_CALI_RE_MIN))
+		return -EINVAL;
+
+	cali_re = AW88399_SHOW_RE_TO_DSP_RE((aw_dev->cali_desc.cali_re +
+				aw_dev->cali_desc.ra), AW88399_DSP_RE_SHIFT);
+
+	re_hbits = (cali_re & (~AW88399_CALI_RE_HBITS_MASK)) >> AW88399_CALI_RE_HBITS_SHIFT;
+	re_lbits = (cali_re & (~AW88399_CALI_RE_LBITS_MASK)) >> AW88399_CALI_RE_LBITS_SHIFT;
+
+	ret = regmap_write(aw_dev->regmap, AW88399_ACR1_REG, re_hbits);
+	if (ret) {
+		dev_err(aw_dev->dev, "set cali re error");
+		return ret;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW88399_ACR2_REG, re_lbits);
+	if (ret)
+		dev_err(aw_dev->dev, "set cali re error");
+
+	return ret;
+}
+
+static int aw_dev_fw_crc_check(struct aw_device *aw_dev)
+{
+	uint16_t check_val, fw_len_val;
+	unsigned int reg_val;
+	int ret;
+
+	/* calculate fw_end_addr */
+	fw_len_val = ((aw_dev->dsp_fw_len / AW_FW_ADDR_LEN) - 1) + AW88399_CRC_FW_BASE_ADDR;
+
+	/* write fw_end_addr to crc_end_addr */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
+					~AW88399_CRC_END_ADDR_MASK, fw_len_val);
+	if (ret)
+		return ret;
+	/* enable fw crc check */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
+		~AW88399_CRC_CODE_EN_MASK, AW88399_CRC_CODE_EN_ENABLE_VALUE);
+
+	usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+
+	/* read crc check result */
+	regmap_read(aw_dev->regmap, AW88399_HAGCST_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	check_val = (reg_val & (~AW88399_CRC_CHECK_BITS_MASK)) >> AW88399_CRC_CHECK_START_BIT;
+
+	/* disable fw crc check */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
+		~AW88399_CRC_CODE_EN_MASK, AW88399_CRC_CODE_EN_DISABLE_VALUE);
+	if (ret)
+		return ret;
+
+	if (check_val != AW88399_CRC_CHECK_PASS_VAL) {
+		dev_err(aw_dev->dev, "%s failed, check_val 0x%x != 0x%x",
+				__func__, check_val, AW88399_CRC_CHECK_PASS_VAL);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int aw_dev_cfg_crc_check(struct aw_device *aw_dev)
+{
+	uint16_t check_val, cfg_len_val;
+	unsigned int reg_val;
+	int ret;
+
+	/* calculate cfg end addr */
+	cfg_len_val = ((aw_dev->dsp_cfg_len / AW_FW_ADDR_LEN) - 1) + AW88399_CRC_CFG_BASE_ADDR;
+
+	/* write cfg_end_addr to crc_end_addr */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
+				~AW88399_CRC_END_ADDR_MASK, cfg_len_val);
+	if (ret)
+		return ret;
+
+	/* enable cfg crc check */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
+			~AW88399_CRC_CFG_EN_MASK, AW88399_CRC_CFG_EN_ENABLE_VALUE);
+	if (ret)
+		return ret;
+
+	usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+
+	/* read crc check result */
+	ret = regmap_read(aw_dev->regmap, AW88399_HAGCST_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	check_val = (reg_val & (~AW88399_CRC_CHECK_BITS_MASK)) >> AW88399_CRC_CHECK_START_BIT;
+
+	/* disable cfg crc check */
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_CRCCTRL_REG,
+			~AW88399_CRC_CFG_EN_MASK, AW88399_CRC_CFG_EN_DISABLE_VALUE);
+	if (ret)
+		return ret;
+
+	if (check_val != AW88399_CRC_CHECK_PASS_VAL) {
+		dev_err(aw_dev->dev, "crc_check failed, check val 0x%x != 0x%x",
+						check_val, AW88399_CRC_CHECK_PASS_VAL);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int aw_dev_hw_crc_check(struct aw88399 *aw88399)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	int ret;
+
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_I2SCFG1_REG,
+		~AW88399_RAM_CG_BYP_MASK, AW88399_RAM_CG_BYP_BYPASS_VALUE);
+	if (ret)
+		return ret;
+
+	ret = aw_dev_fw_crc_check(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "fw_crc_check failed\n");
+		goto crc_check_failed;
+	}
+
+	ret = aw_dev_cfg_crc_check(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "cfg_crc_check failed\n");
+		goto crc_check_failed;
+	}
+
+	ret = regmap_write(aw_dev->regmap, AW88399_CRCCTRL_REG, aw88399->crc_init_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(aw_dev->regmap, AW88399_I2SCFG1_REG,
+		~AW88399_RAM_CG_BYP_MASK, AW88399_RAM_CG_BYP_WORK_VALUE);
+
+	return ret;
+
+crc_check_failed:
+	regmap_update_bits(aw_dev->regmap, AW88399_I2SCFG1_REG,
+		~AW88399_RAM_CG_BYP_MASK, AW88399_RAM_CG_BYP_WORK_VALUE);
+	return ret;
+}
+
+static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
+{
+	int ret;
+
+	if (flag)
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_I2SCTRL3_REG,
+			~AW88399_I2STXEN_MASK, AW88399_I2STXEN_ENABLE_VALUE);
+	else
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_I2SCFG1_REG,
+			~AW88399_I2STXEN_MASK, AW88399_I2STXEN_DISABLE_VALUE);
+
+	if (ret)
+		dev_dbg(aw_dev->dev, "%s failed", __func__);
+}
+
+static int aw_dev_get_dsp_status(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_WDT_REG, &reg_val);
+	if (ret)
+		return ret;
+	if (!(reg_val & (~AW88399_WDT_CNT_MASK)))
+		ret = -EPERM;
+
+	return 0;
+}
+
+static int aw_dev_dsp_check(struct aw_device *aw_dev)
+{
+	int ret, i;
+
+	switch (aw_dev->dsp_cfg) {
+	case AW88399_DEV_DSP_BYPASS:
+		dev_dbg(aw_dev->dev, "dsp bypass");
+		ret = 0;
+		break;
+	case AW88399_DEV_DSP_WORK:
+		aw_dev_dsp_enable(aw_dev, false);
+		aw_dev_dsp_enable(aw_dev, true);
+		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+		for (i = 0; i < AW88399_DEV_DSP_CHECK_MAX; i++) {
+			ret = aw_dev_get_dsp_status(aw_dev);
+			if (ret) {
+				dev_err(aw_dev->dev, "dsp wdt status error=%d", ret);
+				usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+			}
+		}
+		break;
+	default:
+		dev_err(aw_dev->dev, "unknown dsp cfg=%d", aw_dev->dsp_cfg);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int aw_dev_set_volume(struct aw_device *aw_dev, unsigned int value)
+{
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	unsigned int reg_value;
+	u16 real_value;
+	int ret;
+
+	real_value = min((value + vol_desc->init_volume), (unsigned int)AW88399_MUTE_VOL);
+
+	ret = regmap_read(aw_dev->regmap, AW88399_SYSCTRL2_REG, &reg_value);
+	if (ret)
+		return ret;
+
+	dev_dbg(aw_dev->dev, "value 0x%x , reg:0x%x", value, real_value);
+
+	real_value = (real_value << AW88399_VOL_START_BIT) | (reg_value & AW88399_VOL_MASK);
+
+	ret = regmap_write(aw_dev->regmap, AW88399_SYSCTRL2_REG, real_value);
+
+	return ret;
+}
+
+static void aw_dev_fade_in(struct aw_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	u16 fade_in_vol = desc->ctl_volume;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_in_time == 0) {
+		aw_dev_set_volume(aw_dev, fade_in_vol);
+		return;
+	}
+
+	for (i = AW88399_MUTE_VOL; i >= fade_in_vol; i -= fade_step) {
+		aw_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_in_time, aw_dev->fade_in_time + 10);
+	}
+
+	if (i != fade_in_vol)
+		aw_dev_set_volume(aw_dev, fade_in_vol);
+}
+
+static void aw_dev_fade_out(struct aw_device *aw_dev)
+{
+	struct aw_volume_desc *desc = &aw_dev->volume_desc;
+	int fade_step = aw_dev->fade_step;
+	int i;
+
+	if (fade_step == 0 || aw_dev->fade_out_time == 0) {
+		aw_dev_set_volume(aw_dev, AW88399_MUTE_VOL);
+		return;
+	}
+
+	for (i = desc->ctl_volume; i <= AW88399_MUTE_VOL; i += fade_step) {
+		aw_dev_set_volume(aw_dev, i);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+
+	if (i != AW88399_MUTE_VOL) {
+		aw_dev_set_volume(aw_dev, AW88399_MUTE_VOL);
+		usleep_range(aw_dev->fade_out_time, aw_dev->fade_out_time + 10);
+	}
+}
+
+static void aw88399_dev_mute(struct aw_device *aw_dev, bool is_mute)
+{
+	if (is_mute) {
+		aw_dev_fade_out(aw_dev);
+		regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_HMUTE_MASK, AW88399_HMUTE_ENABLE_VALUE);
+	} else {
+		regmap_update_bits(aw_dev->regmap, AW88399_SYSCTRL_REG,
+				~AW88399_HMUTE_MASK, AW88399_HMUTE_DISABLE_VALUE);
+		aw_dev_fade_in(aw_dev);
+	}
+}
+
+static void aw88399_dev_set_dither(struct aw88399 *aw88399, bool dither)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+
+	if (dither)
+		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+				~AW88399_DITHER_EN_MASK, AW88399_DITHER_EN_ENABLE_VALUE);
+	else
+		regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+				~AW88399_DITHER_EN_MASK, AW88399_DITHER_EN_DISABLE_VALUE);
+}
+
+static int aw88399_dev_start(struct aw88399 *aw88399)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	int ret;
+
+	if (aw_dev->status == AW88399_DEV_PW_ON) {
+		dev_dbg(aw_dev->dev, "already power on");
+		return 0;
+	}
+
+	aw88399_dev_set_dither(aw88399, false);
+
+	/* power on */
+	aw_dev_pwd(aw_dev, false);
+	usleep_range(AW88399_2000_US, AW88399_2000_US + 10);
+
+	ret = aw_dev_check_syspll(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "pll check failed cannot start");
+		goto pll_check_fail;
+	}
+
+	/* amppd on */
+	aw_dev_amppd(aw_dev, false);
+	usleep_range(AW88399_1000_US, AW88399_1000_US + 50);
+
+	/* check i2s status */
+	ret = aw_dev_check_sysst(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "sysst check failed");
+		goto sysst_check_fail;
+	}
+
+	if (aw_dev->dsp_cfg == AW88399_DEV_DSP_WORK) {
+		ret = aw_dev_hw_crc_check(aw88399);
+		if (ret) {
+			dev_err(aw_dev->dev, "dsp crc check failed");
+			goto crc_check_fail;
+		}
+		aw_dev_dsp_enable(aw_dev, false);
+		aw_dev_set_vcalb(aw88399);
+		aw_dev_update_cali_re(&aw_dev->cali_desc);
+
+		ret = aw_dev_dsp_check(aw_dev);
+		if (ret) {
+			dev_err(aw_dev->dev, "dsp status check failed");
+			goto dsp_check_fail;
+		}
+	} else {
+		dev_dbg(aw_dev->dev, "start pa with dsp bypass");
+	}
+
+	/* enable tx feedback */
+	aw_dev_i2s_tx_enable(aw_dev, true);
+
+	if (aw88399->dither_st == AW88399_DITHER_EN_ENABLE_VALUE)
+		aw88399_dev_set_dither(aw88399, true);
+
+	/* close mute */
+	aw88399_dev_mute(aw_dev, false);
+	/* clear inturrupt */
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev->status = AW88399_DEV_PW_ON;
+
+	return 0;
+
+dsp_check_fail:
+crc_check_fail:
+	aw_dev_dsp_enable(aw_dev, false);
+sysst_check_fail:
+	aw_dev_clear_int_status(aw_dev);
+	aw_dev_amppd(aw_dev, true);
+pll_check_fail:
+	aw_dev_pwd(aw_dev, true);
+	aw_dev->status = AW88399_DEV_PW_OFF;
+
+	return ret;
+}
+
+static int aw_dev_dsp_update_container(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len, unsigned short base)
+{
+	u32 tmp_len;
+	int i, ret;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	ret = regmap_write(aw_dev->regmap, AW88399_DSPMADD_REG, base);
+	if (ret)
+		goto error_operation;
+
+	for (i = 0; i < len; i += AW88399_MAX_RAM_WRITE_BYTE_SIZE) {
+		if ((len - i) < AW88399_MAX_RAM_WRITE_BYTE_SIZE)
+			tmp_len = len - i;
+		else
+			tmp_len = AW88399_MAX_RAM_WRITE_BYTE_SIZE;
+
+		ret = regmap_raw_write(aw_dev->regmap, AW88399_DSPMDAT_REG,
+					&data[i], tmp_len);
+		if (ret)
+			goto error_operation;
+	}
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return 0;
+
+error_operation:
+	mutex_unlock(&aw_dev->dsp_lock);
+	return ret;
+}
+
+static int aw_dev_get_ra(struct aw_cali_desc *cali_desc)
+{
+	struct aw_device *aw_dev =
+		container_of(cali_desc, struct aw_device, cali_desc);
+	u32 dsp_ra;
+	int ret;
+
+	ret = aw_dev_dsp_read(aw_dev, AW88399_DSP_REG_CFG_ADPZ_RA,
+				&dsp_ra, AW88399_DSP_32_DATA);
+	if (ret) {
+		dev_err(aw_dev->dev, "read ra error");
+		return ret;
+	}
+
+	cali_desc->ra = AW88399_DSP_RE_TO_SHOW_RE(dsp_ra,
+					AW88399_DSP_RE_SHIFT);
+
+	return 0;
+}
+
+static int aw_dev_dsp_update_cfg(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len)
+{
+	int ret;
+
+	dev_dbg(aw_dev->dev, "dsp config len:%d", len);
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "dsp config data is null or len is 0");
+		return -EINVAL;
+	}
+
+	ret = aw_dev_dsp_update_container(aw_dev, data, len, AW88399_DSP_CFG_ADDR);
+	if (ret)
+		return ret;
+
+	aw_dev->dsp_cfg_len = len;
+
+	ret = aw_dev_get_ra(&aw_dev->cali_desc);
+
+	return ret;
+}
+
+static int aw_dev_dsp_update_fw(struct aw_device *aw_dev,
+			unsigned char *data, unsigned int len)
+{
+	int ret;
+
+	dev_dbg(aw_dev->dev, "dsp firmware len:%d", len);
+
+	if (!len || !data) {
+		dev_err(aw_dev->dev, "dsp firmware data is null or len is 0");
+		return -EINVAL;
+	}
+
+	aw_dev->dsp_fw_len = len;
+	ret = aw_dev_dsp_update_container(aw_dev, data, len, AW88399_DSP_FW_ADDR);
+
+	return ret;
+}
+
+static int aw_dev_check_sram(struct aw_device *aw_dev)
+{
+	unsigned int reg_val;
+
+	mutex_lock(&aw_dev->dsp_lock);
+	/* read dsp_rom_check_reg */
+	aw_dev_dsp_read_16bit(aw_dev, AW88399_DSP_ROM_CHECK_ADDR, &reg_val);
+	if (reg_val != AW88399_DSP_ROM_CHECK_DATA) {
+		dev_err(aw_dev->dev, "check dsp rom failed, read[0x%x] != check[0x%x]",
+						reg_val, AW88399_DSP_ROM_CHECK_DATA);
+		goto error;
+	}
+
+	/* check dsp_cfg_base_addr */
+	aw_dev_dsp_write_16bit(aw_dev, AW88399_DSP_CFG_ADDR, AW88399_DSP_ODD_NUM_BIT_TEST);
+	aw_dev_dsp_read_16bit(aw_dev, AW88399_DSP_CFG_ADDR, &reg_val);
+	if (reg_val != AW88399_DSP_ODD_NUM_BIT_TEST) {
+		dev_err(aw_dev->dev, "check dsp cfg failed, read[0x%x] != write[0x%x]",
+						reg_val, AW88399_DSP_ODD_NUM_BIT_TEST);
+		goto error;
+	}
+	mutex_unlock(&aw_dev->dsp_lock);
+
+	return 0;
+error:
+	mutex_unlock(&aw_dev->dsp_lock);
+	return -EPERM;
+}
+
+static void aw_dev_select_memclk(struct aw_device *aw_dev, unsigned char flag)
+{
+	int ret;
+
+	switch (flag) {
+	case AW88399_DEV_MEMCLK_PLL:
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+					~AW88399_MEM_CLKSEL_MASK,
+					AW88399_MEM_CLKSEL_DAPHCLK_VALUE);
+		if (ret)
+			dev_err(aw_dev->dev, "memclk select pll failed");
+		break;
+	case AW88399_DEV_MEMCLK_OSC:
+		ret = regmap_update_bits(aw_dev->regmap, AW88399_DBGCTRL_REG,
+					~AW88399_MEM_CLKSEL_MASK,
+					AW88399_MEM_CLKSEL_OSCCLK_VALUE);
+		if (ret)
+			dev_err(aw_dev->dev, "memclk select OSC failed");
+		break;
+	default:
+		dev_err(aw_dev->dev, "unknown memclk config, flag=0x%x", flag);
+		break;
+	}
+}
+
+static void aw_dev_get_cur_mode_st(struct aw_device *aw_dev)
+{
+	struct aw_profctrl_desc *profctrl_desc = &aw_dev->profctrl_desc;
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(aw_dev->regmap, AW88399_SYSCTRL_REG, &reg_val);
+	if (ret) {
+		dev_dbg(aw_dev->dev, "%s failed", __func__);
+		return;
+	}
+	if ((reg_val & (~AW88399_RCV_MODE_MASK)) == AW88399_RCV_MODE_RECEIVER_VALUE)
+		profctrl_desc->cur_mode = AW88399_RCV_MODE;
+	else
+		profctrl_desc->cur_mode = AW88399_NOT_RCV_MODE;
+}
+
+static int aw_dev_update_reg_container(struct aw88399 *aw88399,
+				unsigned char *data, unsigned int len)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	struct aw_volume_desc *vol_desc = &aw_dev->volume_desc;
+	u16 read_vol, reg_val;
+	int data_len, i, ret;
+	int16_t *reg_data;
+	u8 reg_addr;
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
+		if (reg_addr == AW88399_DSPVCALB_REG) {
+			aw88399->vcalb_init_val = reg_val;
+			continue;
+		}
+
+		if (reg_addr == AW88399_SYSCTRL_REG) {
+			if (reg_val & (~AW88399_DSPBY_MASK))
+				aw_dev->dsp_cfg = AW88399_DEV_DSP_BYPASS;
+			else
+				aw_dev->dsp_cfg = AW88399_DEV_DSP_WORK;
+
+			reg_val &= (AW88399_HMUTE_MASK | AW88399_PWDN_MASK |
+						AW88399_DSPBY_MASK);
+			reg_val |= (AW88399_HMUTE_ENABLE_VALUE | AW88399_PWDN_POWER_DOWN_VALUE |
+						AW88399_DSPBY_BYPASS_VALUE);
+		}
+
+		if (reg_addr == AW88399_I2SCTRL3_REG) {
+			reg_val &= AW88399_I2STXEN_MASK;
+			reg_val |= AW88399_I2STXEN_DISABLE_VALUE;
+		}
+
+		if (reg_addr == AW88399_SYSCTRL2_REG) {
+			read_vol = (reg_val & (~AW88399_VOL_MASK)) >>
+				AW88399_VOL_START_BIT;
+			aw_dev->volume_desc.init_volume = read_vol;
+		}
+
+		if (reg_addr == AW88399_DBGCTRL_REG) {
+			if ((reg_val & (~AW88399_EF_DBMD_MASK)) == AW88399_EF_DBMD_OR_VALUE)
+				aw88399->check_val = AW_EF_OR_CHECK;
+			else
+				aw88399->check_val = AW_EF_AND_CHECK;
+
+			aw88399->dither_st = reg_val & (~AW88399_DITHER_EN_MASK);
+		}
+
+		if (reg_addr == AW88399_CRCCTRL_REG)
+			aw88399->crc_init_val = reg_val;
+
+		ret = regmap_write(aw_dev->regmap, reg_addr, reg_val);
+		if (ret)
+			return ret;
+	}
+
+	aw_dev_pwd(aw_dev, false);
+	usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+
+	aw_dev_get_cur_mode_st(aw_dev);
+
+	if (aw_dev->prof_cur != aw_dev->prof_index)
+		vol_desc->ctl_volume = 0;
+	else
+		aw_dev_set_volume(aw_dev, vol_desc->ctl_volume);
+
+	return 0;
+}
+
+static int aw_dev_reg_update(struct aw88399 *aw88399,
+					unsigned char *data, unsigned int len)
+{
+	int ret;
+
+	if (!len || !data) {
+		dev_err(aw88399->aw_pa->dev, "reg data is null or len is 0");
+		return -EINVAL;
+	}
+
+	ret = aw_dev_update_reg_container(aw88399, data, len);
+	if (ret)
+		dev_err(aw88399->aw_pa->dev, "reg update failed");
+
+	return ret;
+}
+
+static int aw88399_dev_get_prof_name(struct aw_device *aw_dev, int index, char **prof_name)
+{
+	struct aw_prof_info *prof_info = &aw_dev->prof_info;
+	struct aw_prof_desc *prof_desc;
+
+	if ((index >= aw_dev->prof_info.count) || (index < 0)) {
+		dev_err(aw_dev->dev, "index[%d] overflow count[%d]",
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
+static int aw88399_dev_get_prof_data(struct aw_device *aw_dev, int index,
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
+static int aw88399_dev_fw_update(struct aw88399 *aw88399, bool up_dsp_fw_en, bool force_up_en)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	struct aw_prof_desc *prof_index_desc;
+	struct aw_sec_data_desc *sec_desc;
+	char *prof_name;
+	int ret;
+
+	if ((aw_dev->prof_cur == aw_dev->prof_index) &&
+			(force_up_en == AW88399_FORCE_UPDATE_OFF)) {
+		dev_dbg(aw_dev->dev, "scene no change, not update");
+		return 0;
+	}
+
+	if (aw_dev->fw_status == AW88399_DEV_FW_FAILED) {
+		dev_err(aw_dev->dev, "fw status[%d] error", aw_dev->fw_status);
+		return -EPERM;
+	}
+
+	ret = aw88399_dev_get_prof_name(aw_dev, aw_dev->prof_index, &prof_name);
+	if (ret)
+		return ret;
+
+	dev_dbg(aw_dev->dev, "start update %s", prof_name);
+
+	ret = aw88399_dev_get_prof_data(aw_dev, aw_dev->prof_index, &prof_index_desc);
+	if (ret)
+		return ret;
+
+	/* update reg */
+	sec_desc = prof_index_desc->sec_desc;
+	ret = aw_dev_reg_update(aw88399, sec_desc[AW88395_DATA_TYPE_REG].data,
+					sec_desc[AW88395_DATA_TYPE_REG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update reg failed");
+		return ret;
+	}
+
+	aw88399_dev_mute(aw_dev, true);
+
+	if (aw_dev->dsp_cfg == AW88399_DEV_DSP_WORK)
+		aw_dev_dsp_enable(aw_dev, false);
+
+	aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_OSC);
+
+	ret = aw_dev_check_sram(aw_dev);
+	if (ret) {
+		dev_err(aw_dev->dev, "check sram failed");
+		goto error;
+	}
+
+	if (up_dsp_fw_en) {
+		dev_dbg(aw_dev->dev, "fw_ver: [%x]", prof_index_desc->fw_ver);
+		ret = aw_dev_dsp_update_fw(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_FW].data,
+					sec_desc[AW88395_DATA_TYPE_DSP_FW].len);
+		if (ret) {
+			dev_err(aw_dev->dev, "update dsp fw failed");
+			goto error;
+		}
+	}
+
+	/* update dsp config */
+	ret = aw_dev_dsp_update_cfg(aw_dev, sec_desc[AW88395_DATA_TYPE_DSP_CFG].data,
+					sec_desc[AW88395_DATA_TYPE_DSP_CFG].len);
+	if (ret) {
+		dev_err(aw_dev->dev, "update dsp cfg failed");
+		goto error;
+	}
+
+	aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_PLL);
+
+	aw_dev->prof_cur = aw_dev->prof_index;
+
+	return 0;
+
+error:
+	aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_PLL);
+	return ret;
+}
+
+static void aw88399_start_pa(struct aw88399 *aw88399)
+{
+	int ret, i;
+
+	for (i = 0; i < AW88399_START_RETRIES; i++) {
+		ret = aw88399_dev_start(aw88399);
+		if (ret) {
+			dev_err(aw88399->aw_pa->dev, "aw88399 device start failed. retry = %d", i);
+			ret = aw88399_dev_fw_update(aw88399, AW88399_DSP_FW_UPDATE_ON, true);
+			if (ret) {
+				dev_err(aw88399->aw_pa->dev, "fw update failed");
+				continue;
+			}
+		} else {
+			dev_dbg(aw88399->aw_pa->dev, "start success\n");
+			break;
+		}
+	}
+}
+
+static void aw88399_startup_work(struct work_struct *work)
+{
+	struct aw88399 *aw88399 =
+		container_of(work, struct aw88399, start_work.work);
+
+	mutex_lock(&aw88399->lock);
+	aw88399_start_pa(aw88399);
+	mutex_unlock(&aw88399->lock);
+}
+
+static void aw88399_start(struct aw88399 *aw88399, bool sync_start)
+{
+	int ret;
+
+	if (aw88399->aw_pa->fw_status != AW88399_DEV_FW_OK)
+		return;
+
+	if (aw88399->aw_pa->status == AW88399_DEV_PW_ON)
+		return;
+
+	ret = aw88399_dev_fw_update(aw88399, AW88399_DSP_FW_UPDATE_OFF, true);
+	if (ret) {
+		dev_err(aw88399->aw_pa->dev, "fw update failed.");
+		return;
+	}
+
+	if (sync_start == AW88399_SYNC_START)
+		aw88399_start_pa(aw88399);
+	else
+		queue_delayed_work(system_wq,
+			&aw88399->start_work,
+			AW88399_START_WORK_DELAY_MS);
+}
+
+static int aw_dev_check_sysint(struct aw_device *aw_dev)
+{
+	u16 reg_val;
+
+	aw_dev_get_int_status(aw_dev, &reg_val);
+	if (reg_val & AW88399_BIT_SYSINT_CHECK) {
+		dev_err(aw_dev->dev, "pa stop check fail:0x%04x", reg_val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aw88399_stop(struct aw_device *aw_dev)
+{
+	struct aw_sec_data_desc *dsp_cfg =
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_CFG];
+	struct aw_sec_data_desc *dsp_fw =
+		&aw_dev->prof_info.prof_desc[aw_dev->prof_cur].sec_desc[AW88395_DATA_TYPE_DSP_FW];
+	int int_st;
+
+	if (aw_dev->status == AW88399_DEV_PW_OFF) {
+		dev_dbg(aw_dev->dev, "already power off");
+		return 0;
+	}
+
+	aw_dev->status = AW88399_DEV_PW_OFF;
+
+	aw88399_dev_mute(aw_dev, true);
+	usleep_range(AW88399_4000_US, AW88399_4000_US + 100);
+
+	aw_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW88399_1000_US, AW88399_1000_US + 100);
+
+	int_st = aw_dev_check_sysint(aw_dev);
+
+	aw_dev_dsp_enable(aw_dev, false);
+
+	aw_dev_amppd(aw_dev, true);
+
+	if (int_st) {
+		aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_OSC);
+		aw_dev_dsp_update_fw(aw_dev, dsp_fw->data, dsp_fw->len);
+		aw_dev_dsp_update_cfg(aw_dev, dsp_cfg->data, dsp_cfg->len);
+		aw_dev_select_memclk(aw_dev, AW88399_DEV_MEMCLK_PLL);
+	}
+
+	aw_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver aw88399_dai[] = {
+	{
+		.name = "aw88399-aif",
+		.id = 1,
+		.playback = {
+			.stream_name = "Speaker_Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88399_RATES,
+			.formats = AW88399_FORMATS,
+		},
+		.capture = {
+			.stream_name = "Speaker_Capture",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = AW88399_RATES,
+			.formats = AW88399_FORMATS,
+		},
+	},
+};
+
+static int aw88399_get_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88399->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_in_time;
+
+	return 0;
+}
+
+static int aw88399_set_fade_in_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88399->aw_pa;
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
+static int aw88399_get_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
+	struct aw_device *aw_dev = aw88399->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->fade_out_time;
+
+	return 0;
+}
+
+static int aw88399_set_fade_out_time(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88399->aw_pa;
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
+static int aw88399_dev_set_profile_index(struct aw_device *aw_dev, int index)
+{
+	/* check the index whether is valid */
+	if ((index >= aw_dev->prof_info.count) || (index < 0))
+		return -EINVAL;
+	/* check the index whether change */
+	if (aw_dev->prof_index == index)
+		return -EINVAL;
+
+	aw_dev->prof_index = index;
+	dev_dbg(aw_dev->dev, "set prof[%s]",
+		aw_dev->prof_info.prof_name_list[aw_dev->prof_info.prof_desc[index].id]);
+
+	return 0;
+}
+
+static int aw88399_profile_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	char *prof_name, *name;
+	int count, ret;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = aw88399->aw_pa->prof_info.count;
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
+	ret = aw88399_dev_get_prof_name(aw88399->aw_pa, count, &prof_name);
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
+static int aw88399_profile_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88399->aw_pa->prof_index;
+
+	return 0;
+}
+
+static int aw88399_profile_set(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	int ret;
+
+	mutex_lock(&aw88399->lock);
+	ret = aw88399_dev_set_profile_index(aw88399->aw_pa, ucontrol->value.integer.value[0]);
+	if (ret) {
+		dev_dbg(codec->dev, "profile index does not change");
+		mutex_unlock(&aw88399->lock);
+		return 0;
+	}
+
+	if (aw88399->aw_pa->status) {
+		aw88399_stop(aw88399->aw_pa);
+		aw88399_start(aw88399, AW88399_SYNC_START);
+	}
+
+	mutex_unlock(&aw88399->lock);
+
+	return 1;
+}
+
+static int aw88399_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88399->aw_pa->volume_desc;
+
+	ucontrol->value.integer.value[0] = vol_desc->ctl_volume;
+
+	return 0;
+}
+
+static int aw88399_volume_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	struct aw_volume_desc *vol_desc = &aw88399->aw_pa->volume_desc;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (vol_desc->ctl_volume != value) {
+		vol_desc->ctl_volume = value;
+		aw_dev_set_volume(aw88399->aw_pa, vol_desc->ctl_volume);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88399_get_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+
+	ucontrol->value.integer.value[0] = aw88399->aw_pa->fade_step;
+
+	return 0;
+}
+
+static int aw88399_set_fade_step(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (aw88399->aw_pa->fade_step != value) {
+		aw88399->aw_pa->fade_step = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88399_re_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	struct aw_device *aw_dev = aw88399->aw_pa;
+
+	ucontrol->value.integer.value[0] = aw_dev->cali_desc.cali_re;
+
+	return 0;
+}
+
+static int aw88399_re_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *codec = snd_soc_kcontrol_component(kcontrol);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(codec);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	int value;
+
+	value = ucontrol->value.integer.value[0];
+	if (value < mc->min || value > mc->max)
+		return -EINVAL;
+
+	if (aw_dev->cali_desc.cali_re != value) {
+		aw_dev->cali_desc.cali_re = value;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int aw88399_dev_init(struct aw88399 *aw88399, struct aw_container *aw_cfg)
+{
+	struct aw_device *aw_dev = aw88399->aw_pa;
+	int ret;
+
+	ret = aw88395_dev_cfg_load(aw_dev, aw_cfg);
+	if (ret) {
+		dev_err(aw_dev->dev, "aw_dev acf parse failed");
+		return -EINVAL;
+	}
+	aw_dev->fade_in_time = AW88399_1000_US / 10;
+	aw_dev->fade_out_time = AW88399_1000_US >> 1;
+	aw_dev->prof_cur = aw_dev->prof_info.prof_desc[0].id;
+	aw_dev->prof_index = aw_dev->prof_info.prof_desc[0].id;
+
+	ret = aw88399_dev_fw_update(aw88399, AW88399_FORCE_UPDATE_ON, AW88399_DSP_FW_UPDATE_ON);
+	if (ret) {
+		dev_err(aw_dev->dev, "fw update failed ret = %d\n", ret);
+		return ret;
+	}
+
+	aw88399_dev_mute(aw_dev, true);
+
+	/* close tx feedback */
+	aw_dev_i2s_tx_enable(aw_dev, false);
+	usleep_range(AW88399_1000_US, AW88399_1000_US + 100);
+
+	/* enable amppd */
+	aw_dev_amppd(aw_dev, true);
+
+	/* close dsp */
+	aw_dev_dsp_enable(aw_dev, false);
+	/* set power down */
+	aw_dev_pwd(aw_dev, true);
+
+	return 0;
+}
+
+static int aw88399_request_firmware_file(struct aw88399 *aw88399)
+{
+	const struct firmware *cont = NULL;
+	int ret;
+
+	aw88399->aw_pa->fw_status = AW88399_DEV_FW_FAILED;
+
+	ret = request_firmware(&cont, AW88399_ACF_FILE, aw88399->aw_pa->dev);
+	if (ret) {
+		dev_err(aw88399->aw_pa->dev, "request [%s] failed!", AW88399_ACF_FILE);
+		return ret;
+	}
+
+	dev_dbg(aw88399->aw_pa->dev, "loaded %s - size: %zu\n",
+			AW88399_ACF_FILE, cont ? cont->size : 0);
+
+	aw88399->aw_cfg = devm_kzalloc(aw88399->aw_pa->dev,
+			struct_size(aw88399->aw_cfg, data, cont->size), GFP_KERNEL);
+	if (!aw88399->aw_cfg) {
+		release_firmware(cont);
+		return -ENOMEM;
+	}
+	aw88399->aw_cfg->len = (int)cont->size;
+	memcpy(aw88399->aw_cfg->data, cont->data, cont->size);
+	release_firmware(cont);
+
+	ret = aw88395_dev_load_acf_check(aw88399->aw_pa, aw88399->aw_cfg);
+	if (ret) {
+		dev_err(aw88399->aw_pa->dev, "load [%s] failed!", AW88399_ACF_FILE);
+		return ret;
+	}
+
+	mutex_lock(&aw88399->lock);
+	/* aw device init */
+	ret = aw88399_dev_init(aw88399, aw88399->aw_cfg);
+	if (ret)
+		dev_err(aw88399->aw_pa->dev, "dev init failed");
+	mutex_unlock(&aw88399->lock);
+
+	return ret;
+}
+
+static const struct snd_kcontrol_new aw88399_controls[] = {
+	SOC_SINGLE_EXT("PCM Playback Volume", AW88399_SYSCTRL2_REG,
+		6, AW88399_MUTE_VOL, 0, aw88399_volume_get,
+		aw88399_volume_set),
+	SOC_SINGLE_EXT("Fade Step", 0, 0, AW88399_MUTE_VOL, 0,
+		aw88399_get_fade_step, aw88399_set_fade_step),
+	SOC_SINGLE_EXT("Volume Ramp Up Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw88399_get_fade_in_time, aw88399_set_fade_in_time),
+	SOC_SINGLE_EXT("Volume Ramp Down Step", 0, 0, FADE_TIME_MAX, FADE_TIME_MIN,
+		aw88399_get_fade_out_time, aw88399_set_fade_out_time),
+	SOC_SINGLE_EXT("Calib", 0, 0, 100, 0,
+		aw88399_re_get, aw88399_re_set),
+	AW88399_PROFILE_EXT("AW88399 Profile Set", aw88399_profile_info,
+		aw88399_profile_get, aw88399_profile_set),
+};
+
+static int aw88399_playback_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&aw88399->lock);
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		aw88399_start(aw88399, AW88399_ASYNC_START);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		aw88399_stop(aw88399->aw_pa);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&aw88399->lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget aw88399_dapm_widgets[] = {
+	 /* playback */
+	SND_SOC_DAPM_AIF_IN_E("AIF_RX", "Speaker_Playback", 0, 0, 0, 0,
+					aw88399_playback_event,
+					SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+
+	/* capture */
+	SND_SOC_DAPM_AIF_OUT("AIF_TX", "Speaker_Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("ADC Input"),
+};
+
+static const struct snd_soc_dapm_route aw88399_audio_map[] = {
+	{"DAC Output", NULL, "AIF_RX"},
+	{"AIF_TX", NULL, "ADC Input"},
+};
+
+static int aw88399_codec_probe(struct snd_soc_component *component)
+{
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	INIT_DELAYED_WORK(&aw88399->start_work, aw88399_startup_work);
+
+	ret = aw88399_request_firmware_file(aw88399);
+	if (ret)
+		dev_err(aw88399->aw_pa->dev, "%s failed\n", __func__);
+
+	return ret;
+}
+
+static void aw88399_codec_remove(struct snd_soc_component *aw_codec)
+{
+	struct aw88399 *aw88399 = snd_soc_component_get_drvdata(aw_codec);
+
+	cancel_delayed_work_sync(&aw88399->start_work);
+}
+
+static const struct snd_soc_component_driver soc_codec_dev_aw88399 = {
+	.probe = aw88399_codec_probe,
+	.remove = aw88399_codec_remove,
+	.dapm_widgets = aw88399_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(aw88399_dapm_widgets),
+	.dapm_routes = aw88399_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(aw88399_audio_map),
+	.controls = aw88399_controls,
+	.num_controls = ARRAY_SIZE(aw88399_controls),
+};
+
+static void aw88399_hw_reset(struct aw88399 *aw88399)
+{
+	if (aw88399->reset_gpio) {
+		gpiod_set_value_cansleep(aw88399->reset_gpio, 1);
+		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+		gpiod_set_value_cansleep(aw88399->reset_gpio, 0);
+		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+		gpiod_set_value_cansleep(aw88399->reset_gpio, 1);
+		usleep_range(AW88399_1000_US, AW88399_1000_US + 10);
+	}
+}
+
+static void aw88399_parse_channel_dt(struct aw_device *aw_dev)
+{
+	struct device_node *np = aw_dev->dev->of_node;
+	u32 channel_value;
+
+	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
+	aw_dev->channel = channel_value;
+}
+
+static int aw88399_init(struct aw88399 *aw88399, struct i2c_client *i2c, struct regmap *regmap)
+{
+	struct aw_device *aw_dev;
+	unsigned int chip_id;
+	int ret;
+
+	ret = regmap_read(regmap, AW88399_ID_REG, &chip_id);
+	if (ret) {
+		dev_err(&i2c->dev, "%s read chipid error. ret = %d", __func__, ret);
+		return ret;
+	}
+	if (chip_id != AW88399_CHIP_ID) {
+		dev_err(&i2c->dev, "unsupported device");
+		return -ENXIO;
+	}
+	dev_dbg(&i2c->dev, "chip id = %x\n", chip_id);
+
+	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
+	if (!aw_dev)
+		return -ENOMEM;
+	aw88399->aw_pa = aw_dev;
+
+	aw_dev->i2c = i2c;
+	aw_dev->dev = &i2c->dev;
+	aw_dev->regmap = regmap;
+	mutex_init(&aw_dev->dsp_lock);
+
+	aw_dev->chip_id = chip_id;
+	aw_dev->acf = NULL;
+	aw_dev->prof_info.prof_desc = NULL;
+	aw_dev->prof_info.count = 0;
+	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
+	aw_dev->channel = AW88399_DEV_DEFAULT_CH;
+	aw_dev->fw_status = AW88399_DEV_FW_FAILED;
+
+	aw_dev->fade_step = AW88399_VOLUME_STEP_DB;
+	aw_dev->volume_desc.ctl_volume = AW88399_VOL_DEFAULT_VALUE;
+
+	aw88399_parse_channel_dt(aw_dev);
+
+	return 0;
+}
+
+static int aw88399_i2c_probe(struct i2c_client *i2c)
+{
+	struct aw88399 *aw88399;
+	int ret;
+
+	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed");
+
+	aw88399 = devm_kzalloc(&i2c->dev, sizeof(*aw88399), GFP_KERNEL);
+	if (!aw88399)
+		return -ENOMEM;
+
+	mutex_init(&aw88399->lock);
+
+	i2c_set_clientdata(i2c, aw88399);
+
+	aw88399->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(aw88399->reset_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(aw88399->reset_gpio),
+							"reset gpio not defined\n");
+	aw88399_hw_reset(aw88399);
+
+	aw88399->regmap = devm_regmap_init_i2c(i2c, &aw88399_remap_config);
+	if (IS_ERR(aw88399->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(aw88399->regmap),
+							"failed to init regmap\n");
+
+	/* aw pa init */
+	ret = aw88399_init(aw88399, i2c, aw88399->regmap);
+	if (ret)
+		return ret;
+
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_codec_dev_aw88399,
+			aw88399_dai, ARRAY_SIZE(aw88399_dai));
+	if (ret)
+		dev_err(&i2c->dev, "failed to register aw88399: %d", ret);
+
+	return ret;
+}
+
+static const struct i2c_device_id aw88399_i2c_id[] = {
+	{ AW88399_I2C_NAME, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, aw88399_i2c_id);
+
+static struct i2c_driver aw88399_i2c_driver = {
+	.driver = {
+		.name = AW88399_I2C_NAME,
+	},
+	.probe = aw88399_i2c_probe,
+	.id_table = aw88399_i2c_id,
+};
+module_i2c_driver(aw88399_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AW88399 Smart PA Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/aw88399.h b/sound/soc/codecs/aw88399.h
new file mode 100644
index 000000000000..8e3bbc6abb61
--- /dev/null
+++ b/sound/soc/codecs/aw88399.h
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88399.h --  ALSA SoC AW88399 codec support
+//
+// Copyright (c) 2023 AWINIC Technology CO., LTD
+//
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW88399_H__
+#define __AW88399_H__
+
+/* registers list */
+#define AW88399_ID_REG			(0x00)
+#define AW88399_SYSST_REG		(0x01)
+#define AW88399_SYSINT_REG		(0x02)
+#define AW88399_SYSINTM_REG		(0x03)
+#define AW88399_SYSCTRL_REG		(0x04)
+#define AW88399_SYSCTRL2_REG		(0x05)
+#define AW88399_I2SCTRL1_REG		(0x06)
+#define AW88399_I2SCTRL2_REG		(0x07)
+#define AW88399_I2SCTRL3_REG		(0x08)
+#define AW88399_DACCFG1_REG		(0x09)
+#define AW88399_DACCFG2_REG		(0x0A)
+#define AW88399_DACCFG3_REG		(0x0B)
+#define AW88399_DACCFG4_REG		(0x0C)
+#define AW88399_DACCFG5_REG		(0x0D)
+#define AW88399_DACCFG6_REG		(0x0E)
+#define AW88399_DACCFG7_REG		(0x0F)
+#define AW88399_MPDCFG1_REG		(0x10)
+#define AW88399_MPDCFG2_REG		(0x11)
+#define AW88399_MPDCFG3_REG		(0x12)
+#define AW88399_MPDCFG4_REG		(0x13)
+#define AW88399_PWMCTRL1_REG		(0x14)
+#define AW88399_PWMCTRL2_REG		(0x15)
+#define AW88399_PWMCTRL3_REG		(0x16)
+#define AW88399_I2SCFG1_REG		(0x17)
+#define AW88399_DBGCTRL_REG		(0x18)
+#define AW88399_HAGCST_REG		(0x20)
+#define AW88399_VBAT_REG		(0x21)
+#define AW88399_TEMP_REG		(0x22)
+#define AW88399_PVDD_REG		(0x23)
+#define AW88399_ISNDAT_REG		(0x24)
+#define AW88399_VSNDAT_REG		(0x25)
+#define AW88399_I2SINT_REG		(0x26)
+#define AW88399_I2SCAPCNT_REG		(0x27)
+#define AW88399_ANASTA1_REG		(0x28)
+#define AW88399_ANASTA2_REG		(0x29)
+#define AW88399_ANASTA3_REG		(0x2A)
+#define AW88399_TESTDET_REG		(0x2B)
+#define AW88399_DSMCFG1_REG		(0x30)
+#define AW88399_DSMCFG2_REG		(0x31)
+#define AW88399_DSMCFG3_REG		(0x32)
+#define AW88399_DSMCFG4_REG		(0x33)
+#define AW88399_DSMCFG5_REG		(0x34)
+#define AW88399_DSMCFG6_REG		(0x35)
+#define AW88399_DSMCFG7_REG		(0x36)
+#define AW88399_DSMCFG8_REG		(0x37)
+#define AW88399_TESTIN_REG		(0x38)
+#define AW88399_TESTOUT_REG		(0x39)
+#define AW88399_MEMTEST_REG		(0x3A)
+#define AW88399_VSNCTRL1_REG		(0x3B)
+#define AW88399_ISNCTRL1_REG		(0x3C)
+#define AW88399_ISNCTRL2_REG		(0x3D)
+#define AW88399_DSPMADD_REG		(0x40)
+#define AW88399_DSPMDAT_REG		(0x41)
+#define AW88399_WDT_REG		(0x42)
+#define AW88399_ACR1_REG		(0x43)
+#define AW88399_ACR2_REG		(0x44)
+#define AW88399_ASR1_REG		(0x45)
+#define AW88399_ASR2_REG		(0x46)
+#define AW88399_DSPCFG_REG		(0x47)
+#define AW88399_ASR3_REG		(0x48)
+#define AW88399_ASR4_REG		(0x49)
+#define AW88399_DSPVCALB_REG		(0x4A)
+#define AW88399_CRCCTRL_REG		(0x4B)
+#define AW88399_DSPDBG1_REG		(0x4C)
+#define AW88399_DSPDBG2_REG		(0x4D)
+#define AW88399_DSPDBG3_REG		(0x4E)
+#define AW88399_PLLCTRL1_REG		(0x50)
+#define AW88399_PLLCTRL2_REG		(0x51)
+#define AW88399_PLLCTRL3_REG		(0x52)
+#define AW88399_CDACTRL1_REG		(0x53)
+#define AW88399_CDACTRL2_REG		(0x54)
+#define AW88399_CDACTRL3_REG		(0x55)
+#define AW88399_SADCCTRL1_REG		(0x56)
+#define AW88399_SADCCTRL2_REG		(0x57)
+#define AW88399_BOPCTRL1_REG		(0x58)
+#define AW88399_BOPCTRL2_REG		(0x5A)
+#define AW88399_BOPCTRL3_REG		(0x5B)
+#define AW88399_BOPCTRL4_REG		(0x5C)
+#define AW88399_BOPCTRL5_REG		(0x5D)
+#define AW88399_BOPCTRL6_REG		(0x5E)
+#define AW88399_BOPCTRL7_REG		(0x5F)
+#define AW88399_BSTCTRL1_REG		(0x60)
+#define AW88399_BSTCTRL2_REG		(0x61)
+#define AW88399_BSTCTRL3_REG		(0x62)
+#define AW88399_BSTCTRL4_REG		(0x63)
+#define AW88399_BSTCTRL5_REG		(0x64)
+#define AW88399_BSTCTRL6_REG		(0x65)
+#define AW88399_BSTCTRL7_REG		(0x66)
+#define AW88399_BSTCTRL8_REG		(0x67)
+#define AW88399_BSTCTRL9_REG		(0x68)
+#define AW88399_BSTCTRL10_REG		(0x69)
+#define AW88399_CPCTRL_REG		(0x6A)
+#define AW88399_EFWH_REG		(0x6C)
+#define AW88399_EFWM2_REG		(0x6D)
+#define AW88399_EFWM1_REG		(0x6E)
+#define AW88399_EFWL_REG		(0x6F)
+#define AW88399_TESTCTRL1_REG		(0x70)
+#define AW88399_TESTCTRL2_REG		(0x71)
+#define AW88399_EFCTRL1_REG		(0x72)
+#define AW88399_EFCTRL2_REG		(0x73)
+#define AW88399_EFRH4_REG		(0x74)
+#define AW88399_EFRH3_REG		(0x75)
+#define AW88399_EFRH2_REG		(0x76)
+#define AW88399_EFRH1_REG		(0x77)
+#define AW88399_EFRL4_REG		(0x78)
+#define AW88399_EFRL3_REG		(0x79)
+#define AW88399_EFRL2_REG		(0x7A)
+#define AW88399_EFRL1_REG		(0x7B)
+#define AW88399_TM_REG			(0x7C)
+#define AW88399_TM2_REG		(0x7D)
+
+#define AW88399_REG_MAX		(0x7E)
+#define AW88399_MUTE_VOL		(1023)
+
+#define AW88399_DSP_CFG_ADDR		(0x9B00)
+#define AW88399_DSP_REG_CFG_ADPZ_RA	(0x9B68)
+#define AW88399_DSP_FW_ADDR		(0x8980)
+#define AW88399_DSP_ROM_CHECK_ADDR	(0x1F40)
+#define AW88399_DSP_ROM_CHECK_DATA	(0x4638)
+
+#define AW88399_CALI_RE_HBITS_MASK	(~(0xFFFF0000))
+#define AW88399_CALI_RE_HBITS_SHIFT	(16)
+
+#define AW88399_CALI_RE_LBITS_MASK	(~(0xFFFF))
+#define AW88399_CALI_RE_LBITS_SHIFT	(0)
+
+#define AW88399_I2STXEN_START_BIT	(9)
+#define AW88399_I2STXEN_BITS_LEN	(1)
+#define AW88399_I2STXEN_MASK		\
+	(~(((1<<AW88399_I2STXEN_BITS_LEN)-1) << AW88399_I2STXEN_START_BIT))
+
+#define AW88399_I2STXEN_DISABLE	(0)
+#define AW88399_I2STXEN_DISABLE_VALUE	\
+	(AW88399_I2STXEN_DISABLE << AW88399_I2STXEN_START_BIT)
+
+#define AW88399_I2STXEN_ENABLE		(1)
+#define AW88399_I2STXEN_ENABLE_VALUE	\
+	(AW88399_I2STXEN_ENABLE << AW88399_I2STXEN_START_BIT)
+
+#define AW88399_VOL_START_BIT		(0)
+#define AW88399_VOL_BITS_LEN		(10)
+#define AW88399_VOL_MASK		\
+	(~(((1<<AW88399_VOL_BITS_LEN)-1) << AW88399_VOL_START_BIT))
+
+#define AW88399_PWDN_START_BIT		(0)
+#define AW88399_PWDN_BITS_LEN		(1)
+#define AW88399_PWDN_MASK		\
+	(~(((1<<AW88399_PWDN_BITS_LEN)-1) << AW88399_PWDN_START_BIT))
+
+#define AW88399_PWDN_POWER_DOWN	(1)
+#define AW88399_PWDN_POWER_DOWN_VALUE	\
+	(AW88399_PWDN_POWER_DOWN << AW88399_PWDN_START_BIT)
+
+#define AW88399_PWDN_WORKING		(0)
+#define AW88399_PWDN_WORKING_VALUE	\
+	(AW88399_PWDN_WORKING << AW88399_PWDN_START_BIT)
+
+#define AW88399_DSPBY_START_BIT	(2)
+#define AW88399_DSPBY_BITS_LEN		(1)
+#define AW88399_DSPBY_MASK		\
+	(~(((1<<AW88399_DSPBY_BITS_LEN)-1) << AW88399_DSPBY_START_BIT))
+
+#define AW88399_DSPBY_WORKING		(0)
+#define AW88399_DSPBY_WORKING_VALUE	\
+	(AW88399_DSPBY_WORKING << AW88399_DSPBY_START_BIT)
+
+#define AW88399_DSPBY_BYPASS		(1)
+#define AW88399_DSPBY_BYPASS_VALUE	\
+	(AW88399_DSPBY_BYPASS << AW88399_DSPBY_START_BIT)
+
+#define AW88399_MEM_CLKSEL_START_BIT	(3)
+#define AW88399_MEM_CLKSEL_BITS_LEN	(1)
+#define AW88399_MEM_CLKSEL_MASK		\
+	(~(((1<<AW88399_MEM_CLKSEL_BITS_LEN)-1) << AW88399_MEM_CLKSEL_START_BIT))
+
+#define AW88399_MEM_CLKSEL_OSCCLK	(0)
+#define AW88399_MEM_CLKSEL_OSCCLK_VALUE	\
+	(AW88399_MEM_CLKSEL_OSCCLK << AW88399_MEM_CLKSEL_START_BIT)
+
+#define AW88399_MEM_CLKSEL_DAPHCLK	(1)
+#define AW88399_MEM_CLKSEL_DAPHCLK_VALUE	\
+	(AW88399_MEM_CLKSEL_DAPHCLK << AW88399_MEM_CLKSEL_START_BIT)
+
+#define AW88399_DITHER_EN_START_BIT	(15)
+#define AW88399_DITHER_EN_BITS_LEN	(1)
+#define AW88399_DITHER_EN_MASK		 \
+	(~(((1<<AW88399_DITHER_EN_BITS_LEN)-1) << AW88399_DITHER_EN_START_BIT))
+
+#define AW88399_DITHER_EN_DISABLE	(0)
+#define AW88399_DITHER_EN_DISABLE_VALUE	\
+	(AW88399_DITHER_EN_DISABLE << AW88399_DITHER_EN_START_BIT)
+
+#define AW88399_DITHER_EN_ENABLE	(1)
+#define AW88399_DITHER_EN_ENABLE_VALUE	\
+	(AW88399_DITHER_EN_ENABLE << AW88399_DITHER_EN_START_BIT)
+
+#define AW88399_HMUTE_START_BIT	(8)
+#define AW88399_HMUTE_BITS_LEN		(1)
+#define AW88399_HMUTE_MASK		\
+	(~(((1<<AW88399_HMUTE_BITS_LEN)-1) << AW88399_HMUTE_START_BIT))
+
+#define AW88399_HMUTE_DISABLE		(0)
+#define AW88399_HMUTE_DISABLE_VALUE	\
+	(AW88399_HMUTE_DISABLE << AW88399_HMUTE_START_BIT)
+
+#define AW88399_HMUTE_ENABLE		(1)
+#define AW88399_HMUTE_ENABLE_VALUE	\
+	(AW88399_HMUTE_ENABLE << AW88399_HMUTE_START_BIT)
+
+#define AW88399_EF_DBMD_START_BIT	(2)
+#define AW88399_EF_DBMD_BITS_LEN	(1)
+#define AW88399_EF_DBMD_MASK		\
+	(~(((1<<AW88399_EF_DBMD_BITS_LEN)-1) << AW88399_EF_DBMD_START_BIT))
+
+#define AW88399_EF_DBMD_OR		(1)
+#define AW88399_EF_DBMD_OR_VALUE	\
+	(AW88399_EF_DBMD_OR << AW88399_EF_DBMD_START_BIT)
+
+#define AW88399_VDSEL_START_BIT	(5)
+#define AW88399_VDSEL_BITS_LEN		(1)
+#define AW88399_VDSEL_MASK		\
+	(~(((1<<AW88399_VDSEL_BITS_LEN)-1) << AW88399_VDSEL_START_BIT))
+
+#define AW88399_EF_ISN_GESLP_H_START_BIT	(0)
+#define AW88399_EF_ISN_GESLP_H_BITS_LEN	(10)
+#define AW88399_EF_ISN_GESLP_H_MASK		\
+	(~(((1<<AW88399_EF_ISN_GESLP_H_BITS_LEN)-1) << AW88399_EF_ISN_GESLP_H_START_BIT))
+
+/* EF_VSN_GESLP_H bit 9:0 (EFRH3 0x75) */
+#define AW88399_EF_VSN_GESLP_H_START_BIT	(0)
+#define AW88399_EF_VSN_GESLP_H_BITS_LEN	(10)
+#define AW88399_EF_VSN_GESLP_H_MASK		\
+	(~(((1<<AW88399_EF_VSN_GESLP_H_BITS_LEN)-1) << AW88399_EF_VSN_GESLP_H_START_BIT))
+
+#define AW88399_EF_ISN_GESLP_L_START_BIT	(0)
+#define AW88399_EF_ISN_GESLP_L_BITS_LEN	(10)
+#define AW88399_EF_ISN_GESLP_L_MASK		\
+	(~(((1<<AW88399_EF_ISN_GESLP_L_BITS_LEN)-1) << AW88399_EF_ISN_GESLP_L_START_BIT))
+
+/* EF_VSN_GESLP_L bit 9:0 (EFRL3 0x79) */
+#define AW88399_EF_VSN_GESLP_L_START_BIT	(0)
+#define AW88399_EF_VSN_GESLP_L_BITS_LEN	(10)
+#define AW88399_EF_VSN_GESLP_L_MASK		\
+	(~(((1<<AW88399_EF_VSN_GESLP_L_BITS_LEN)-1) << AW88399_EF_VSN_GESLP_L_START_BIT))
+
+#define AW88399_INTERNAL_VSN_TRIM_H_START_BIT	(9)
+#define AW88399_INTERNAL_VSN_TRIM_H_BITS_LEN	(6)
+#define AW88399_INTERNAL_VSN_TRIM_H_MASK	\
+	(~(((1<<AW88399_INTERNAL_VSN_TRIM_H_BITS_LEN)-1) << AW88399_INTERNAL_VSN_TRIM_H_START_BIT))
+
+#define AW88399_INTERNAL_VSN_TRIM_L_START_BIT	(9)
+#define AW88399_INTERNAL_VSN_TRIM_L_BITS_LEN	(6)
+#define AW88399_INTERNAL_VSN_TRIM_L_MASK	\
+	(~(((1<<AW88399_INTERNAL_VSN_TRIM_L_BITS_LEN)-1) << AW88399_INTERNAL_VSN_TRIM_L_START_BIT))
+
+#define AW88399_RCV_MODE_START_BIT	(7)
+#define AW88399_RCV_MODE_BITS_LEN	(1)
+#define AW88399_RCV_MODE_MASK		\
+	(~(((1<<AW88399_RCV_MODE_BITS_LEN)-1) << AW88399_RCV_MODE_START_BIT))
+
+#define AW88399_CLKI_START_BIT		(4)
+#define AW88399_NOCLKI_START_BIT	(5)
+#define AW88399_PLLI_START_BIT		(0)
+#define AW88399_PLLI_INT_VALUE		(1)
+#define AW88399_PLLI_INT_INTERRUPT \
+	(AW88399_PLLI_INT_VALUE << AW88399_PLLI_START_BIT)
+
+#define AW88399_CLKI_INT_VALUE		(1)
+#define AW88399_CLKI_INT_INTERRUPT \
+	(AW88399_CLKI_INT_VALUE << AW88399_CLKI_START_BIT)
+
+#define AW88399_NOCLKI_INT_VALUE	(1)
+#define AW88399_NOCLKI_INT_INTERRUPT \
+	(AW88399_NOCLKI_INT_VALUE << AW88399_NOCLKI_START_BIT)
+
+#define AW88399_BIT_SYSINT_CHECK \
+		(AW88399_PLLI_INT_INTERRUPT | \
+		AW88399_CLKI_INT_INTERRUPT | \
+		AW88399_NOCLKI_INT_INTERRUPT)
+
+#define AW88399_CRC_CHECK_START_BIT	(12)
+#define AW88399_CRC_CHECK_BITS_LEN	(3)
+#define AW88399_CRC_CHECK_BITS_MASK	\
+	(~(((1<<AW88399_CRC_CHECK_BITS_LEN)-1) << AW88399_CRC_CHECK_START_BIT))
+
+#define AW88399_RCV_MODE_RECEIVER	(1)
+#define AW88399_RCV_MODE_RECEIVER_VALUE	\
+	(AW88399_RCV_MODE_RECEIVER << AW88399_RCV_MODE_START_BIT)
+
+#define AW88399_AMPPD_START_BIT	(1)
+#define AW88399_AMPPD_BITS_LEN		(1)
+#define AW88399_AMPPD_MASK		\
+	(~(((1<<AW88399_AMPPD_BITS_LEN)-1) << AW88399_AMPPD_START_BIT))
+
+#define AW88399_AMPPD_WORKING		(0)
+#define AW88399_AMPPD_WORKING_VALUE	\
+	(AW88399_AMPPD_WORKING << AW88399_AMPPD_START_BIT)
+
+#define AW88399_AMPPD_POWER_DOWN	(1)
+#define AW88399_AMPPD_POWER_DOWN_VALUE	\
+	(AW88399_AMPPD_POWER_DOWN << AW88399_AMPPD_START_BIT)
+
+#define AW88399_RAM_CG_BYP_START_BIT	(0)
+#define AW88399_RAM_CG_BYP_BITS_LEN	(1)
+#define AW88399_RAM_CG_BYP_MASK		\
+	(~(((1<<AW88399_RAM_CG_BYP_BITS_LEN)-1) << AW88399_RAM_CG_BYP_START_BIT))
+
+#define AW88399_RAM_CG_BYP_WORK	(0)
+#define AW88399_RAM_CG_BYP_WORK_VALUE	\
+	(AW88399_RAM_CG_BYP_WORK << AW88399_RAM_CG_BYP_START_BIT)
+
+#define AW88399_RAM_CG_BYP_BYPASS	(1)
+#define AW88399_RAM_CG_BYP_BYPASS_VALUE	\
+	(AW88399_RAM_CG_BYP_BYPASS << AW88399_RAM_CG_BYP_START_BIT)
+
+#define AW88399_CRC_END_ADDR_START_BIT	(0)
+#define AW88399_CRC_END_ADDR_BITS_LEN	(12)
+#define AW88399_CRC_END_ADDR_MASK	\
+	(~(((1<<AW88399_CRC_END_ADDR_BITS_LEN)-1) << AW88399_CRC_END_ADDR_START_BIT))
+
+#define AW88399_CRC_CODE_EN_START_BIT	(13)
+#define AW88399_CRC_CODE_EN_BITS_LEN	(1)
+#define AW88399_CRC_CODE_EN_MASK	\
+	(~(((1<<AW88399_CRC_CODE_EN_BITS_LEN)-1) << AW88399_CRC_CODE_EN_START_BIT))
+
+#define AW88399_CRC_CODE_EN_DISABLE	(0)
+#define AW88399_CRC_CODE_EN_DISABLE_VALUE	\
+	(AW88399_CRC_CODE_EN_DISABLE << AW88399_CRC_CODE_EN_START_BIT)
+
+#define AW88399_CRC_CODE_EN_ENABLE	(1)
+#define AW88399_CRC_CODE_EN_ENABLE_VALUE	\
+	(AW88399_CRC_CODE_EN_ENABLE << AW88399_CRC_CODE_EN_START_BIT)
+
+#define AW88399_CRC_CFG_EN_START_BIT	(12)
+#define AW88399_CRC_CFG_EN_BITS_LEN	(1)
+#define AW88399_CRC_CFG_EN_MASK		\
+	(~(((1<<AW88399_CRC_CFG_EN_BITS_LEN)-1) << AW88399_CRC_CFG_EN_START_BIT))
+
+#define AW88399_CRC_CFG_EN_DISABLE	(0)
+#define AW88399_CRC_CFG_EN_DISABLE_VALUE	\
+	(AW88399_CRC_CFG_EN_DISABLE << AW88399_CRC_CFG_EN_START_BIT)
+
+#define AW88399_CRC_CFG_EN_ENABLE	(1)
+#define AW88399_CRC_CFG_EN_ENABLE_VALUE	\
+	(AW88399_CRC_CFG_EN_ENABLE << AW88399_CRC_CFG_EN_START_BIT)
+
+#define AW88399_OCDS_START_BIT		(3)
+#define AW88399_OCDS_OC		(1)
+#define AW88399_OCDS_OC_VALUE		\
+	(AW88399_OCDS_OC << AW88399_OCDS_START_BIT)
+
+#define AW88399_NOCLKS_START_BIT	(5)
+#define AW88399_NOCLKS_NO_CLOCK	(1)
+#define AW88399_NOCLKS_NO_CLOCK_VALUE	\
+	(AW88399_NOCLKS_NO_CLOCK << AW88399_NOCLKS_START_BIT)
+
+#define AW88399_SWS_START_BIT		(8)
+#define AW88399_SWS_SWITCHING		(1)
+#define AW88399_SWS_SWITCHING_VALUE	\
+	(AW88399_SWS_SWITCHING << AW88399_SWS_START_BIT)
+
+#define AW88399_BSTS_START_BIT		(9)
+#define AW88399_BSTS_FINISHED		(1)
+#define AW88399_BSTS_FINISHED_VALUE	\
+	(AW88399_BSTS_FINISHED << AW88399_BSTS_START_BIT)
+
+#define AW88399_UVLS_START_BIT		(14)
+#define AW88399_UVLS_NORMAL		(0)
+#define AW88399_UVLS_NORMAL_VALUE	\
+	(AW88399_UVLS_NORMAL << AW88399_UVLS_START_BIT)
+
+#define AW88399_BSTOCS_START_BIT	(11)
+#define AW88399_BSTOCS_OVER_CURRENT	(1)
+#define AW88399_BSTOCS_OVER_CURRENT_VALUE	\
+	(AW88399_BSTOCS_OVER_CURRENT << AW88399_BSTOCS_START_BIT)
+
+#define AW88399_OTHS_START_BIT		(1)
+#define AW88399_OTHS_OT		(1)
+#define AW88399_OTHS_OT_VALUE		\
+	(AW88399_OTHS_OT << AW88399_OTHS_START_BIT)
+
+#define AW88399_PLLS_START_BIT		(0)
+#define AW88399_PLLS_LOCKED		(1)
+#define AW88399_PLLS_LOCKED_VALUE	\
+	(AW88399_PLLS_LOCKED << AW88399_PLLS_START_BIT)
+
+#define AW88399_CLKS_START_BIT		(4)
+#define AW88399_CLKS_STABLE		(1)
+#define AW88399_CLKS_STABLE_VALUE	\
+	(AW88399_CLKS_STABLE << AW88399_CLKS_START_BIT)
+
+#define AW88399_BIT_PLL_CHECK \
+		(AW88399_CLKS_STABLE_VALUE | \
+		AW88399_PLLS_LOCKED_VALUE)
+
+#define AW88399_BIT_SYSST_CHECK_MASK \
+		(~(AW88399_UVLS_NORMAL_VALUE | \
+		AW88399_BSTOCS_OVER_CURRENT_VALUE | \
+		AW88399_BSTS_FINISHED_VALUE | \
+		AW88399_SWS_SWITCHING_VALUE | \
+		AW88399_NOCLKS_NO_CLOCK_VALUE | \
+		AW88399_CLKS_STABLE_VALUE | \
+		AW88399_OCDS_OC_VALUE | \
+		AW88399_OTHS_OT_VALUE | \
+		AW88399_PLLS_LOCKED_VALUE))
+
+#define AW88399_BIT_SYSST_NOSWS_CHECK \
+		(AW88399_BSTS_FINISHED_VALUE | \
+		AW88399_CLKS_STABLE_VALUE | \
+		AW88399_PLLS_LOCKED_VALUE)
+
+#define AW88399_BIT_SYSST_SWS_CHECK \
+		(AW88399_BSTS_FINISHED_VALUE | \
+		AW88399_CLKS_STABLE_VALUE | \
+		AW88399_PLLS_LOCKED_VALUE | \
+		AW88399_SWS_SWITCHING_VALUE)
+
+#define AW88399_CCO_MUX_START_BIT	(14)
+#define AW88399_CCO_MUX_BITS_LEN	(1)
+#define AW88399_CCO_MUX_MASK		\
+	(~(((1<<AW88399_CCO_MUX_BITS_LEN)-1) << AW88399_CCO_MUX_START_BIT))
+
+#define AW88399_CCO_MUX_DIVIDED	(0)
+#define AW88399_CCO_MUX_DIVIDED_VALUE	\
+	(AW88399_CCO_MUX_DIVIDED << AW88399_CCO_MUX_START_BIT)
+
+#define AW88399_CCO_MUX_BYPASS		(1)
+#define AW88399_CCO_MUX_BYPASS_VALUE	\
+	(AW88399_CCO_MUX_BYPASS << AW88399_CCO_MUX_START_BIT)
+
+#define AW88399_NOISE_GATE_EN_START_BIT	(13)
+#define AW88399_NOISE_GATE_EN_BITS_LEN		(1)
+#define AW88399_NOISE_GATE_EN_MASK	\
+	(~(((1<<AW88399_NOISE_GATE_EN_BITS_LEN)-1) << AW88399_NOISE_GATE_EN_START_BIT))
+
+#define AW88399_WDT_CNT_START_BIT	(0)
+#define AW88399_WDT_CNT_BITS_LEN	(8)
+#define AW88399_WDT_CNT_MASK		\
+	(~(((1<<AW88399_WDT_CNT_BITS_LEN)-1) << AW88399_WDT_CNT_START_BIT))
+
+#define AW88399_VOLUME_STEP_DB			(64)
+#define AW88399_VOL_DEFAULT_VALUE		(0)
+#define AW88399_DSP_ODD_NUM_BIT_TEST		(0x5555)
+#define AW88399_EF_ISN_GESLP_SIGN_MASK		(~(1 << 9))
+#define AW88399_EF_ISN_GESLP_SIGN_NEG		(0xfe00)
+
+#define AW88399_EF_VSN_GESLP_SIGN_MASK		(~(1 << 9))
+#define AW88399_EF_VSN_GESLP_SIGN_NEG		(0xfe00)
+
+#define AW88399_TEM4_SIGN_MASK			(~(1 << 5))
+#define AW88399_TEM4_SIGN_NEG			(0xffc0)
+
+#define AW88399_ICABLK_FACTOR			(1)
+#define AW88399_VCABLK_FACTOR			(1)
+#define AW88399_VCABLK_DAC_FACTOR		(2)
+
+#define AW88399_VCALB_ADJ_FACTOR		(12)
+#define AW88399_VCALB_ACCURACY			(1 << 12)
+
+#define AW88399_ISCAL_FACTOR			(3125)
+#define AW88399_VSCAL_FACTOR			(18875)
+#define AW88399_ISCAL_DAC_FACTOR		(3125)
+#define AW88399_VSCAL_DAC_FACTOR		(12600)
+#define AW88399_CABL_BASE_VALUE		(1000)
+
+#define AW88399_DEV_DEFAULT_CH			(0)
+#define AW88399_DEV_DSP_CHECK_MAX		(5)
+#define AW88399_MAX_RAM_WRITE_BYTE_SIZE	(128)
+#define AW88399_DSP_RE_SHIFT			(12)
+#define AW88399_CALI_RE_MAX			(15000)
+#define AW88399_CALI_RE_MIN			(4000)
+#define AW_FW_ADDR_LEN				(4)
+#define AW88399_DSP_RE_TO_SHOW_RE(re, shift)	(((re) * (1000)) >> (shift))
+#define AW88399_SHOW_RE_TO_DSP_RE(re, shift)	(((re) << shift) / (1000))
+#define AW88399_CRC_CHECK_PASS_VAL		(0x4)
+
+#define AW88399_CRC_CFG_BASE_ADDR		(0xD80)
+#define AW88399_CRC_FW_BASE_ADDR		(0x4C0)
+#define AW88399_ACF_FILE			"aw88399_acf.bin"
+#define AW88399_DEV_SYSST_CHECK_MAX		(10)
+
+#define AW88399_I2C_NAME			"aw88399"
+
+#define AW88399_START_RETRIES			(5)
+#define AW88399_START_WORK_DELAY_MS		(0)
+
+#define AW88399_RATES (SNDRV_PCM_RATE_8000_48000 | \
+			SNDRV_PCM_RATE_96000)
+#define AW88399_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+#define FADE_TIME_MAX		100000
+#define FADE_TIME_MIN		0
+
+#define AW88399_PROFILE_EXT(xname, profile_info, profile_get, profile_set) \
+{ \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = xname, \
+	.info = profile_info, \
+	.get = profile_get, \
+	.put = profile_set, \
+}
+
+enum {
+	AW_EF_AND_CHECK = 0,
+	AW_EF_OR_CHECK,
+};
+
+enum {
+	AW88399_DEV_VDSEL_DAC = 0,
+	AW88399_DEV_VDSEL_VSENSE = 1,
+};
+
+enum {
+	AW88399_DSP_CRC_NA = 0,
+	AW88399_DSP_CRC_OK = 1,
+};
+
+enum {
+	AW88399_DSP_FW_UPDATE_OFF = 0,
+	AW88399_DSP_FW_UPDATE_ON = 1,
+};
+
+enum {
+	AW88399_FORCE_UPDATE_OFF = 0,
+	AW88399_FORCE_UPDATE_ON = 1,
+};
+
+enum {
+	AW88399_1000_US = 1000,
+	AW88399_2000_US = 2000,
+	AW88399_3000_US = 3000,
+	AW88399_4000_US = 4000,
+};
+
+enum AW88399_DEV_STATUS {
+	AW88399_DEV_PW_OFF = 0,
+	AW88399_DEV_PW_ON,
+};
+
+enum AW88399_DEV_FW_STATUS {
+	AW88399_DEV_FW_FAILED = 0,
+	AW88399_DEV_FW_OK,
+};
+
+enum AW88399_DEV_MEMCLK {
+	AW88399_DEV_MEMCLK_OSC = 0,
+	AW88399_DEV_MEMCLK_PLL = 1,
+};
+
+enum AW88399_DEV_DSP_CFG {
+	AW88399_DEV_DSP_WORK = 0,
+	AW88399_DEV_DSP_BYPASS = 1,
+};
+
+enum {
+	AW88399_DSP_16_DATA = 0,
+	AW88399_DSP_32_DATA = 1,
+};
+
+enum {
+	AW88399_NOT_RCV_MODE = 0,
+	AW88399_RCV_MODE = 1,
+};
+
+enum {
+	AW88399_SYNC_START = 0,
+	AW88399_ASYNC_START,
+};
+
+struct aw88399 {
+	struct aw_device *aw_pa;
+	struct mutex lock;
+	struct gpio_desc *reset_gpio;
+	struct delayed_work start_work;
+	struct regmap *regmap;
+	struct aw_container *aw_cfg;
+
+	unsigned int check_val;
+	unsigned int crc_init_val;
+	unsigned int vcalb_init_val;
+	unsigned int dither_st;
+};
+
+#endif
-- 
2.41.0

