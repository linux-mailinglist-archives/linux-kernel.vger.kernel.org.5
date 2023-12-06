Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5688807CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441912AbjLGAAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441854AbjLGAAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:00:02 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01E137
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:00:07 -0800 (PST)
Received: from fedori.lan (51b690cd.dsl.pool.telekom.hu [::ffff:81.182.144.205])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000716F9.0000000065710B06.00119065; Thu, 07 Dec 2023 01:00:06 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 09/16] ALSA: hda/tas2781: add TAS2563 support for 14ARB7
Date:   Thu,  7 Dec 2023 00:59:50 +0100
Message-ID: <1efa4849a6c7fef0fafa000fe558a2633548bba0.1701906455.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INT8866 belongs to the Lenovo Yoga 7 Gen 7 AMD 14ARB7
laptop. It has two TAS2563 amplifier. Add the ACPI UID
and calibration functions to handle them.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781.h         |  1 +
 sound/pci/hda/tas2781_hda_i2c.c | 87 +++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 5f364e4d8995..afe9584daa65 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -22,6 +22,7 @@
 #define TAS2781_DRV_VER			1
 #define SMARTAMP_MODULE_NAME		"tas2781"
 #define TAS2781_GLOBAL_ADDR	0x40
+#define TAS2563_GLOBAL_ADDR	0x48
 #define TASDEVICE_RATES			(SNDRV_PCM_RATE_44100 |\
 	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |\
 	SNDRV_PCM_RATE_88200)
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 7ebf5d7e4aac..f28383597ca8 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -65,6 +65,24 @@ enum calib_data {
 	CALIB_MAX
 };
 
+#define TAS2563_MAX_CHANNELS	4
+
+#define TAS2563_CAL_POWER	TASDEVICE_REG(0, 0x0d, 0x3c)
+#define TAS2563_CAL_R0		TASDEVICE_REG(0, 0x0f, 0x34)
+#define TAS2563_CAL_INVR0	TASDEVICE_REG(0, 0x0f, 0x40)
+#define TAS2563_CAL_R0_LOW	TASDEVICE_REG(0, 0x0f, 0x48)
+#define TAS2563_CAL_TLIM	TASDEVICE_REG(0, 0x10, 0x14)
+#define TAS2563_CAL_N		5
+#define TAS2563_CAL_DATA_SIZE	4
+#define TAS2563_CAL_CH_SIZE	20
+#define TAS2563_CAL_ARRAY_SIZE	80
+
+static unsigned int cal_regs[TAS2563_CAL_N] = {
+	TAS2563_CAL_POWER, TAS2563_CAL_R0, TAS2563_CAL_INVR0,
+	TAS2563_CAL_R0_LOW, TAS2563_CAL_TLIM,
+};
+
+
 static int tas2781_get_i2c_res(struct acpi_resource *ares, void *data)
 {
 	struct tasdevice_priv *tas_priv = data;
@@ -395,6 +413,68 @@ static const struct snd_kcontrol_new tas2781_dsp_conf_ctrl = {
 	.put = tasdevice_config_put,
 };
 
+static void tas2563_apply_calibration(struct tasdevice_priv *tas_priv)
+{
+	unsigned int data;
+	int offset = 0;
+	int ret;
+
+	for (int i = 0; i < tas_priv->ndev; i++) {
+		for (int j = 0; j < TAS2563_CAL_N; ++j) {
+			data = cpu_to_be32(
+				*(uint32_t *)&tas_priv->cali_data.data[offset]);
+			ret = tasdevice_dev_bulk_write(tas_priv, i, cal_regs[j],
+				(unsigned char *)&data, TAS2563_CAL_DATA_SIZE);
+			if (ret)
+				dev_err(tas_priv->dev,
+					"Error writing calib regs\n");
+			offset += TAS2563_CAL_DATA_SIZE;
+		}
+	}
+}
+
+static int load_calibration_efi_2(struct tasdevice_priv *tas_priv)
+{
+	static efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
+		0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
+
+	static efi_char16_t *efi_vars[TAS2563_MAX_CHANNELS][TAS2563_CAL_N] = {
+		{ L"Power_1", L"R0_1", L"InvR0_1", L"R0_Low_1", L"TLim_1" },
+		{ L"Power_2", L"R0_2", L"InvR0_2", L"R0_Low_2", L"TLim_2" },
+		{ L"Power_3", L"R0_3", L"InvR0_3", L"R0_Low_3", L"TLim_3" },
+		{ L"Power_4", L"R0_4", L"InvR0_4", L"R0_Low_4", L"TLim_4" },
+	};
+
+	unsigned long max_size = TAS2563_CAL_DATA_SIZE;
+	unsigned int offset = 0;
+	efi_status_t status;
+	unsigned int attr;
+
+	tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
+			TAS2563_CAL_ARRAY_SIZE, GFP_KERNEL);
+	if (!tas_priv->cali_data.data)
+		return -ENOMEM;
+
+	for (int i = 0; i < tas_priv->ndev; ++i) {
+		for (int j = 0; j < TAS2563_CAL_N; ++j) {
+			status = efi.get_variable(efi_vars[i][j],
+				&efi_guid, &attr, &max_size,
+				&tas_priv->cali_data.data[offset]);
+			if (status != EFI_SUCCESS ||
+				max_size != TAS2563_CAL_DATA_SIZE) {
+				dev_warn(tas_priv->dev,
+				"Calibration data read failed %ld\n", status);
+				return -EINVAL;
+			}
+			offset += TAS2563_CAL_DATA_SIZE;
+		}
+	}
+
+	tas_priv->cali_data.total_sz = offset;
+
+	return 0;
+}
+
 static void tas2781_apply_calibration(struct tasdevice_priv *tas_priv)
 {
 	static const unsigned char page_array[CALIB_MAX] = {
@@ -658,6 +738,12 @@ static int tas2781_hda_i2c_probe(struct i2c_client *clt)
 		device_name = "TIAS2781";
 		tas_priv->load_calibration = load_calibration_efi_1;
 		tas_priv->apply_calibration = tas2781_apply_calibration;
+		tas_priv->global_addr = TAS2781_GLOBAL_ADDR;
+	} else if (strstr(dev_name(&clt->dev), "INT8866")) {
+		device_name = "INT8866";
+		tas_priv->load_calibration = load_calibration_efi_2;
+		tas_priv->apply_calibration = tas2563_apply_calibration;
+		tas_priv->global_addr = TAS2563_GLOBAL_ADDR;
 	} else
 		return -ENODEV;
 
@@ -808,6 +894,7 @@ static const struct i2c_device_id tas2781_hda_i2c_id[] = {
 
 static const struct acpi_device_id tas2781_acpi_hda_match[] = {
 	{"TIAS2781", 0 },
+	{"INT8866", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, tas2781_acpi_hda_match);
-- 
2.43.0

