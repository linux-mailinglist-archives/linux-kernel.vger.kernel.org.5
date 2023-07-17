Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26A675622F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjGQL7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGQL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:59:02 -0400
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644AE49;
        Mon, 17 Jul 2023 04:58:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0158985-0.00439184-0.97971;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=25;RT=25;SR=0;TI=SMTPD_---.TvogKyB_1689595131;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.TvogKyB_1689595131)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 19:58:52 +0800
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
Subject: [PATCH V1 4/5] ASoC: codecs: aw88261 chip register file, data type file and Kconfig Makefile
Date:   Mon, 17 Jul 2023 19:58:44 +0800
Message-ID: <20230717115845.297991-5-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717115845.297991-1-wangweidong.a@awinic.com>
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
 sound/soc/codecs/Kconfig                     |  17 +
 sound/soc/codecs/Makefile                    |   5 +
 sound/soc/codecs/aw88261/aw88261_data_type.h | 144 +++++++
 sound/soc/codecs/aw88261/aw88261_reg.h       | 377 +++++++++++++++++++
 4 files changed, 543 insertions(+)
 create mode 100644 sound/soc/codecs/aw88261/aw88261_data_type.h
 create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8020097d4e4c..8b1a8071ae2e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -55,6 +55,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ALC5632
 	imply SND_SOC_AW8738
 	imply SND_SOC_AW88395
+	imply SND_SOC_AW88261
 	imply SND_SOC_BT_SCO
 	imply SND_SOC_BD28623
 	imply SND_SOC_CQ0093VC
@@ -633,6 +634,22 @@ config SND_SOC_AW88395
 	  digital Smart K audio amplifier with an integrated 10V
 	  smart boost convert.
 
+config SND_SOC_AW88261_LIB
+	tristate
+
+config SND_SOC_AW88261
+	tristate "Soc Audio for awinic aw88261"
+	depends on I2C
+	select CRC8
+	select REGMAP_I2C
+	select GPIOLIB
+	select SND_SOC_AW88261_LIB
+	help
+	  this option enables support for aw88261 Smart PA.
+	  The Awinic AW88261 is an I2S/TDM input, high efficiency
+	  digital Smart K audio amplifier with an integrated 10.25V
+		smart boost convert.
+
 config SND_SOC_BD28623
 	tristate "ROHM BD28623 CODEC"
 	help
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5cdbae88e6e3..f64fcc569714 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -49,6 +49,9 @@ snd-soc-aw8738-objs := aw8738.o
 snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
 snd-soc-aw88395-objs := aw88395/aw88395.o \
 			aw88395/aw88395_device.o
+snd-soc-aw88261-lib-objs := aw88261/aw88261_lib.o
+snd-soc-aw88261-objs := aw88261/aw88261.o \
+			aw88261/aw88261_device.o
 snd-soc-bd28623-objs := bd28623.o
 snd-soc-bt-sco-objs := bt-sco.o
 snd-soc-cpcap-objs := cpcap.o
@@ -423,6 +426,8 @@ obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
 obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
+obj-$(CONFIG_SND_SOC_AW88261_LIB) += snd-soc-aw88261-lib.o
+obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
 obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
diff --git a/sound/soc/codecs/aw88261/aw88261_data_type.h b/sound/soc/codecs/aw88261/aw88261_data_type.h
new file mode 100644
index 000000000000..e1d40270beae
--- /dev/null
+++ b/sound/soc/codecs/aw88261/aw88261_data_type.h
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261_data_type.h --  The data type of the AW88261 chip
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Jimmy Zhang <zhangjianming@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW88261_DATA_TYPE_H__
+#define __AW88261_DATA_TYPE_H__
+
+#define PROJECT_NAME_MAX		(24)
+#define CUSTOMER_NAME_MAX		(16)
+#define CFG_VERSION_MAX		(4)
+#define DEV_NAME_MAX			(16)
+#define PROFILE_STR_MAX		(32)
+#define AW_INIT_PROFILE		(0)
+
+#define ACF_FILE_ID			(0xa15f908)
+
+enum aw_cfg_hdr_version {
+	AW88261_CFG_HDR_VER	= 0x00000001,
+	AW88261_CFG_HDR_VER_V1	= 0x01000000,
+};
+
+enum aw_cfg_dde_type {
+	AW88261_DEV_NONE_TYPE_ID	= 0xFFFFFFFF,
+	AW88261_DEV_TYPE_ID		= 0x00000000,
+	AW88261_SKT_TYPE_ID		= 0x00000001,
+	AW88261_DEV_DEFAULT_TYPE_ID	= 0x00000002,
+};
+
+enum aw_sec_type {
+	ACF_SEC_TYPE_REG = 0,
+	ACF_SEC_TYPE_DSP,
+	ACF_SEC_TYPE_DSP_CFG,
+	ACF_SEC_TYPE_DSP_FW,
+	ACF_SEC_TYPE_HDR_REG,
+	ACF_SEC_TYPE_HDR_DSP_CFG,
+	ACF_SEC_TYPE_HDR_DSP_FW,
+	ACF_SEC_TYPE_MULTIPLE_BIN,
+	ACF_SEC_TYPE_SKT_PROJECT,
+	ACF_SEC_TYPE_DSP_PROJECT,
+	ACF_SEC_TYPE_MONITOR,
+	ACF_SEC_TYPE_MAX,
+};
+
+enum profile_data_type {
+	AW88261_DATA_TYPE_REG = 0,
+	AW88261_DATA_TYPE_DSP_CFG,
+	AW88261_DATA_TYPE_DSP_FW,
+	AW88261_DATA_TYPE_MAX,
+};
+
+enum aw_prof_type {
+	AW88261_PROFILE_MUSIC = 0,
+	AW88261_PROFILE_VOICE,
+	AW88261_PROFILE_VOIP,
+	AW88261_PROFILE_RINGTONE,
+	AW88261_PROFILE_RINGTONE_HS,
+	AW88261_PROFILE_LOWPOWER,
+	AW88261_PROFILE_BYPASS,
+	AW88261_PROFILE_MMI,
+	AW88261_PROFILE_FM,
+	AW88261_PROFILE_NOTIFICATION,
+	AW88261_PROFILE_RECEIVER,
+	AW88261_PROFILE_MAX,
+};
+
+enum aw_profile_status {
+	AW88261_PROFILE_WAIT = 0,
+	AW88261_PROFILE_OK,
+};
+
+struct aw_cfg_hdr {
+	u32 id;
+	char project[PROJECT_NAME_MAX];
+	char custom[CUSTOMER_NAME_MAX];
+	char version[CFG_VERSION_MAX];
+	u32 author_id;
+	u32 ddt_size;
+	u32 ddt_num;
+	u32 hdr_offset;
+	u32 hdr_version;
+	u32 reserved[3];
+};
+
+struct aw_cfg_dde {
+	u32 type;
+	char dev_name[DEV_NAME_MAX];
+	u16 dev_index;
+	u16 dev_bus;
+	u16 dev_addr;
+	u16 dev_profile;
+	u32 data_type;
+	u32 data_size;
+	u32 data_offset;
+	u32 data_crc;
+	u32 reserved[5];
+};
+
+struct aw_cfg_dde_v1 {
+	u32 type;
+	char dev_name[DEV_NAME_MAX];
+	u16 dev_index;
+	u16 dev_bus;
+	u16 dev_addr;
+	u16 dev_profile;
+	u32 data_type;
+	u32 data_size;
+	u32 data_offset;
+	u32 data_crc;
+	char dev_profile_str[PROFILE_STR_MAX];
+	u32 chip_id;
+	u32 reserved[4];
+};
+
+struct aw_sec_data_desc {
+	u32 len;
+	u8 *data;
+};
+
+struct aw_prof_desc {
+	u32 id;
+	u32 prof_st;
+	char *prf_str;
+	u32 fw_ver;
+	struct aw_sec_data_desc sec_desc[AW88261_DATA_TYPE_MAX];
+};
+
+struct aw_all_prof_info {
+	struct aw_prof_desc prof_desc[AW88261_PROFILE_MAX];
+};
+
+struct aw_prof_info {
+	int count;
+	int prof_type;
+	char **prof_name_list;
+	struct aw_prof_desc *prof_desc;
+};
+
+#endif
diff --git a/sound/soc/codecs/aw88261/aw88261_reg.h b/sound/soc/codecs/aw88261/aw88261_reg.h
new file mode 100644
index 000000000000..1d569ba6a583
--- /dev/null
+++ b/sound/soc/codecs/aw88261/aw88261_reg.h
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// aw88261_reg.h --  AW88261 chip register file
+//
+// Copyright (c) 2023 awinic Technology CO., LTD
+//
+// Author: Jimmy Zhang <zhangjianming@awinic.com>
+// Author: Weidong Wang <wangweidong.a@awinic.com>
+//
+
+#ifndef __AW88261_REG_H__
+#define __AW88261_REG_H__
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
+enum aw88261_id {
+	AW88261_CHIP_ID = 0x2113,
+};
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
+#define AW88261_FORCE_PWM_START_BIT	(12)
+#define AW88261_FORCE_PWM_BITS_LEN	(1)
+#define AW88261_FORCE_PWM_MASK		\
+	(~(((1<<AW88261_FORCE_PWM_BITS_LEN)-1) << AW88261_FORCE_PWM_START_BIT))
+
+#define AW88261_FORCE_PWM_FORCEMINUS_PWM	(1)
+#define AW88261_FORCE_PWM_FORCEMINUS_PWM_VALUE	\
+	(AW88261_FORCE_PWM_FORCEMINUS_PWM << AW88261_FORCE_PWM_START_BIT)
+
+#define AW88261_BST_OS_WIDTH_START_BIT	(0)
+#define AW88261_BST_OS_WIDTH_BITS_LEN	(3)
+#define AW88261_BST_OS_WIDTH_MASK	\
+	(~(((1<<AW88261_BST_OS_WIDTH_BITS_LEN)-1) << AW88261_BST_OS_WIDTH_START_BIT))
+
+#define AW88261_BST_OS_WIDTH_50NS	(4)
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
+#define AW88261_CABL_BASE_VALUE	(1000)
+#define AW88261_ICABLK_FACTOR		(1)
+#define AW88261_VCABLK_FACTOR		(1)
+
+#define AW88261_VCAL_FACTOR		(1<<13)
+
+#define AW88261_TEMP_SIGN_MASK		(~(1<<9))
+#define AW88261_TEMP_NEG_MASK		(0xFC00)
+
+#endif
-- 
2.41.0

