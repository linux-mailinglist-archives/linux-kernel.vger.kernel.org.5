Return-Path: <linux-kernel+bounces-140314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF958A1290
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028E51F21C90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9E014B06E;
	Thu, 11 Apr 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="b4bmUc0l"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468761474D7;
	Thu, 11 Apr 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833713; cv=none; b=pMe7cqbO4aRJYPBa8JMhK3UPZpcjy3CsyDD4kzQ1q1DcSGKQSjau/P/H9t/yWR+rmMkE8FVjpfzztbM5TBETpicq1gOqOklxFhQ9LDBMa5XNBWQPsYxQHsLaDSy6Xx4QPCUU2x8j/ethobKBHUhxSdzlEPRkk2H0L0vqH07Ti9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833713; c=relaxed/simple;
	bh=IyluEE25yDhIlZPvqpnNcdtA+S2J+x4n8W3T0o+2cYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGp0+UHc17ofgApavTBKTtXYAx+Obu2DojQDuHdT4BcfZF2iTwcAYCfCVrcL8H+qFYQ51jZES4QprxHiwa580cS4F/vUB639pbvS07inv1oa7Ny0eol1vxwOG/JzKtohQfEO7uSPUjFwj33PynVVScMONiekFJ/rf8lYHYWWq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=b4bmUc0l; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naK2004518;
	Thu, 11 Apr 2024 06:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=BpgKF61WK9yGepLlNl+eqdBTC3lBRYesZpnni09ma58=; b=
	b4bmUc0lq/0WKb5DF73ZHvCITUeyAk3aoQYGThnOf6YLoNDXXoENcnmVYY4DQ8hI
	qir1uwXrenReWgMq/I+WLoTVrnRTvaxpF030seyy5fWm7de/bkoDn1WQGs58FgIS
	6vZ92jLLAjsg3GiIprnQkcF+bCBUGyIIoxrd8yi0GLzzuEpI+dQ5qsVfM/yqwFOU
	iEiagcH+BW2NHvX+zxnk+WpsxIEz2ri3larAeOEyD59RsEIRXX2EA1dRCnnExlX7
	ce+UTCtPlr5kJxPYlRmsXcX21BOUH7qKSvokq8Idun08up/Fdk2dJEj8Bu/OIfnl
	rzjS1tOUFQIVDIE7zb60YQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq7m4-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:08:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 12:08:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 12:08:16 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.140])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4923C820243;
	Thu, 11 Apr 2024 11:08:16 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 5/7] ALSA: hda: cs35l41: Use shared cs-amp-lib to apply calibration
Date: Thu, 11 Apr 2024 12:08:11 +0100
Message-ID: <20240411110813.330483-6-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
References: <20240411110813.330483-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PSYnLy-1mtOT6TnaG_oWjKxExY_ukIZx
X-Proofpoint-GUID: PSYnLy-1mtOT6TnaG_oWjKxExY_ukIZx
X-Proofpoint-Spam-Reason: safe

The original mechanism for applying calibration assumed that the
calibration data would be ordered the same as the amp instances.
However, for some 4 amp laptops, this is not the case.
To ensure that the correct calibration is applied to the correct amp,
the calibration data contains a unique id, which matches a unique id
inside the CS35L41. This can be used to match to the correct data
entry. This mechanism is available inside the shared module cs-amp-lib.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/Kconfig       |   2 +
 sound/pci/hda/cs35l41_hda.c | 140 +++++++++++++++++-------------------
 sound/pci/hda/cs35l41_hda.h |   3 +
 3 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index f806636242ee..0da625533afc 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -128,6 +128,7 @@ config SND_HDA_SCODEC_CS35L41_I2C
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
 	select SND_HDA_CS_DSP_CONTROLS
+	select SND_SOC_CS_AMP_LIB
 	help
 	  Say Y or M here to include CS35L41 I2C HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
@@ -144,6 +145,7 @@ config SND_HDA_SCODEC_CS35L41_SPI
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
 	select SND_HDA_CS_DSP_CONTROLS
+	select SND_SOC_CS_AMP_LIB
 	help
 	  Say Y or M here to include CS35L41 SPI HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 9f23fb07fb9e..4d4f1e1aca09 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -65,6 +65,16 @@ struct cs35l41_tuning_params {
 	u8 data[];
 } __packed;
 
+/* Firmware calibration controls */
+static const struct cirrus_amp_cal_controls cs35l41_calibration_controls = {
+	.alg_id =	CAL_DSP_CTL_ALG,
+	.mem_region =	CAL_DSP_CTL_TYPE,
+	.ambient =	CAL_AMBIENT_DSP_CTL_NAME,
+	.calr =		CAL_R_DSP_CTL_NAME,
+	.status =	CAL_STATUS_DSP_CTL_NAME,
+	.checksum =	CAL_CHECKSUM_DSP_CTL_NAME,
+};
+
 static bool firmware_autostart = 1;
 module_param(firmware_autostart, bool, 0444);
 MODULE_PARM_DESC(firmware_autostart, "Allow automatic firmware download on boot"
@@ -404,95 +414,74 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 					      coeff_firmware, coeff_filename);
 }
 
-#if IS_ENABLED(CONFIG_EFI)
-static int cs35l41_apply_calibration(struct cs35l41_hda *cs35l41, __be32 ambient, __be32 r0,
-				     __be32 status, __be32 checksum)
+
+static void cs35l41_hda_apply_calibration(struct cs35l41_hda *cs35l41)
 {
 	int ret;
 
-	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_AMBIENT_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
-				   CAL_DSP_CTL_ALG, &ambient, 4);
-	if (ret) {
-		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_AMBIENT_DSP_CTL_NAME,
-			ret);
-		return ret;
-	}
-	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_R_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
-				   CAL_DSP_CTL_ALG, &r0, 4);
-	if (ret) {
-		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_R_DSP_CTL_NAME, ret);
-		return ret;
-	}
-	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_STATUS_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
-				   CAL_DSP_CTL_ALG, &status, 4);
+	if (!cs35l41->cal_data_valid)
+		return;
+
+	ret = cs_amp_write_cal_coeffs(&cs35l41->cs_dsp, &cs35l41_calibration_controls,
+				      &cs35l41->cal_data);
+	if (ret < 0)
+		dev_warn(cs35l41->dev, "Failed to apply calibration: %d\n", ret);
+	else
+		dev_info(cs35l41->dev, "Calibration applied: R0=%d\n", cs35l41->cal_data.calR);
+}
+
+static int cs35l41_read_silicon_uid(struct cs35l41_hda *cs35l41, u64 *uid)
+{
+	u32 tmp;
+	int ret;
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_DIE_STS2, &tmp);
 	if (ret) {
-		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_STATUS_DSP_CTL_NAME,
-			ret);
+		dev_err(cs35l41->dev, "Cannot obtain CS35L41_DIE_STS2: %d\n", ret);
 		return ret;
 	}
-	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_CHECKSUM_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
-				   CAL_DSP_CTL_ALG, &checksum, 4);
+
+	*uid = tmp;
+	*uid <<= 32;
+
+	ret = regmap_read(cs35l41->regmap, CS35L41_DIE_STS1, &tmp);
 	if (ret) {
-		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_CHECKSUM_DSP_CTL_NAME,
-			ret);
+		dev_err(cs35l41->dev, "Cannot obtain CS35L41_DIE_STS1: %d\n", ret);
 		return ret;
 	}
 
+	*uid |= tmp;
+
+	dev_dbg(cs35l41->dev, "UniqueID = %#llx\n", *uid);
+
 	return 0;
 }
 
-static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
+static int cs35l41_get_calibration(struct cs35l41_hda *cs35l41)
 {
-	static efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe,
-					      0x5a, 0xa3, 0x5d, 0xb3);
-	static efi_char16_t efi_name[] = L"CirrusSmartAmpCalibrationData";
-	const struct cs35l41_amp_efi_data *efi_data;
-	const struct cs35l41_amp_cal_data *cl;
-	unsigned long data_size = 0;
-	efi_status_t status;
-	int ret = 0;
-	u8 *data = NULL;
-	u32 attr;
+	u64 silicon_uid;
+	int ret;
+
+	ret = cs35l41_read_silicon_uid(cs35l41, &silicon_uid);
+	if (ret < 0)
+		return ret;
+
+	ret = cs_amp_get_efi_calibration_data(cs35l41->dev, silicon_uid,
+					      cs35l41->index,
+					      &cs35l41->cal_data);
+
+	/* Only return an error status if probe should be aborted */
+	if ((ret == -ENOENT) || (ret == -EOVERFLOW))
+		return 0;
+
+	if (ret < 0)
+		return ret;
+
+	cs35l41->cal_data_valid = true;
 
-	/* Get real size of UEFI variable */
-	status = efi.get_variable(efi_name, &efi_guid, &attr, &data_size, data);
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		ret = -ENODEV;
-		/* Allocate data buffer of data_size bytes */
-		data = vmalloc(data_size);
-		if (!data)
-			return -ENOMEM;
-		/* Get variable contents into buffer */
-		status = efi.get_variable(efi_name, &efi_guid, &attr, &data_size, data);
-		if (status == EFI_SUCCESS) {
-			efi_data = (struct cs35l41_amp_efi_data *)data;
-			dev_dbg(cs35l41->dev, "Calibration: Size=%d, Amp Count=%d\n",
-				efi_data->size, efi_data->count);
-			if (efi_data->count > cs35l41->index) {
-				cl = &efi_data->data[cs35l41->index];
-				dev_dbg(cs35l41->dev,
-					"Calibration: Ambient=%02x, Status=%02x, R0=%d\n",
-					cl->calAmbient, cl->calStatus, cl->calR);
-
-				/* Calibration can only be applied whilst the DSP is not running */
-				ret = cs35l41_apply_calibration(cs35l41,
-								cpu_to_be32(cl->calAmbient),
-								cpu_to_be32(cl->calR),
-								cpu_to_be32(cl->calStatus),
-								cpu_to_be32(cl->calR + 1));
-			}
-		}
-		vfree(data);
-	}
-	return ret;
-}
-#else
-static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
-{
-	dev_warn(cs35l41->dev, "Calibration not supported without EFI support.\n");
 	return 0;
 }
-#endif
+
 
 static void cs35l41_set_default_tuning_params(struct cs35l41_hda *cs35l41)
 {
@@ -625,7 +614,7 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 
 	cs35l41_add_controls(cs35l41);
 
-	ret = cs35l41_save_calibration(cs35l41);
+	cs35l41_hda_apply_calibration(cs35l41);
 
 err:
 	if (ret)
@@ -1961,6 +1950,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (ret)
 		goto err;
 
+	ret = cs35l41_get_calibration(cs35l41);
+	if (ret && ret != -ENOENT)
+		goto err;
+
 	cs35l41_mute(cs35l41->dev, true);
 
 	INIT_WORK(&cs35l41->fw_load_work, cs35l41_fw_load_work);
@@ -2041,6 +2034,7 @@ EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
 
 MODULE_DESCRIPTION("CS35L41 HDA Driver");
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
+MODULE_IMPORT_NS(SND_SOC_CS_AMP_LIB);
 MODULE_AUTHOR("Lucas Tanure, Cirrus Logic Inc, <tanureal@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(FW_CS_DSP);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index d60aa98bfafc..b0bebb778462 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/device.h>
 #include <sound/cs35l41.h>
+#include <sound/cs-amp-lib.h>
 
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
@@ -86,6 +87,8 @@ struct cs35l41_hda {
 	enum control_bus control_bus;
 	bool bypass_fw;
 	unsigned int tuning_gain;
+	struct cirrus_amp_cal_data cal_data;
+	bool cal_data_valid;
 
 };
 
-- 
2.34.1


