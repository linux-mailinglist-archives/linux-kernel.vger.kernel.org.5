Return-Path: <linux-kernel+bounces-140309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0108A1288
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB611B235F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEBA1487F1;
	Thu, 11 Apr 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cXyYjiWg"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1931474BE;
	Thu, 11 Apr 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833711; cv=none; b=Se5LyB/2X3KdXAQMIVRWlp+NEcO7XLWCPF9SiKx/ATYf4cEn0RgcmgDhtivqoApTiYq5BzFXQCU96yV1HbAJfBf0XztA1EYugVY+OVYBPVNBJmnw6qMr2/HftZ0PHcbs7bFxmA1c6bxsV2TzUH5rSCpZtsVCAFbDinj4JBjmDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833711; c=relaxed/simple;
	bh=6rx2R3ATH+2oYWe2RaGdHtg/shVB6Lo316CGMvLV2ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz/qv60+U7uBp5a4MeVM0CAyu5kb7xNL3s2SSB7NvVwAAobBPF40OnzTHtmYsHNR4OA2y6lbyJAqHr1amnIzc5oiOSeveKW0/QIpU5SYtEiNl6VkUgi+meLrvusGH9HPG2NcQEKIJO212lFSf1m17wJuZi64LDDzo8HXOIvOhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cXyYjiWg; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naJx004518;
	Thu, 11 Apr 2024 06:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=MIxmTYGHkusm/yNHMOd44p73QXLa65vNhRO1tfmG73M=; b=
	cXyYjiWgazJZSz3zx/CfY7egKQPliySvTc3tmTtyhbPJxWtnFJ8qgRpx56R/Zpkh
	3MDnFH8EiFMR4N4KMucxEaAmf2qUFRhmXvglXb0lvRqP6i7XDHk2v6+EiAQgBLLq
	dKFqg2MFT1ki6Ker0BGk3yxKey3QZ45Ziwb4BTW0Npyvtlgi2CNBPPQKh/bTvO87
	UnwPMSJJUYBmuKmPR+YzcyCoum7zRHk+w+Wq+0Zef4llOEKVKz/RX0vXOfRH06KL
	laozc9Ns6/QxhzLJsE/53zwWGlWMIrRmuwCkNOL6rfOOycrEqSxnQtHVvL4DrS4a
	cjaSOB8tKmqcZ8Po81TCww==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq7m4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 06:08:17 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 12:08:15 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 12:08:15 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.64.140])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6F77B820245;
	Thu, 11 Apr 2024 11:08:15 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 1/7] ALSA: hda: cs35l41: Set the max PCM Gain using tuning setting
Date: Thu, 11 Apr 2024 12:08:07 +0100
Message-ID: <20240411110813.330483-2-sbinding@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: G7Ov4_NqKvvPA5VfstArGCpvYbvwsjcU
X-Proofpoint-GUID: G7Ov4_NqKvvPA5VfstArGCpvYbvwsjcU
X-Proofpoint-Spam-Reason: safe

Some systems requires different max PCM Gains settings than the default.
The current default value, when running firmware is 17.5 dB, which is
used for all systems. Some systems require lower values.
Value when running without firmware is 4.5 dB and remains unchanged.

Since the gain value is dependent on Tuning and Firmware, it can
change, so it cannot be saved in _DSD. Instead we can store it inside
a configuration binary file alongside the Firmware and Tuning files.

The gain value increments in steps of 1 dB, with value 0 representing
0.5 dB. The max value is 20, which corresponds to 20.5 dB.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs35l41.h     |   5 ++
 sound/pci/hda/cs35l41_hda.c | 170 +++++++++++++++++++++++++++++++++---
 sound/pci/hda/cs35l41_hda.h |   3 +
 3 files changed, 167 insertions(+), 11 deletions(-)

diff --git a/include/sound/cs35l41.h b/include/sound/cs35l41.h
index 68e053fe7340..bb70782d15d0 100644
--- a/include/sound/cs35l41.h
+++ b/include/sound/cs35l41.h
@@ -554,6 +554,11 @@
 #define CS35L41_LRCLK_FRC_SHIFT		1
 
 #define CS35L41_AMP_GAIN_PCM_MASK	0x3E0
+#define CS35L41_AMP_GAIN_PCM_SHIFT	5
+#define CS35L41_AMP_GAIN_PDM_MASK	0x1F
+#define CS35L41_AMP_GAIN_PDM_SHIFT	0
+#define CS35L41_AMP_GAIN_PCM_MAX	20
+#define CS35L41_AMP_GAIN_PDM_MAX	20
 #define CS35L41_AMP_GAIN_ZC_MASK	0x0400
 #define CS35L41_AMP_GAIN_ZC_SHIFT	10
 
diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 990b5bd717a1..1a5e970734ef 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -38,6 +38,32 @@
 #define CS35L41_UUID			"50d90cdc-3de4-4f18-b528-c7fe3b71f40d"
 #define CS35L41_DSM_GET_MUTE		5
 #define CS35L41_NOTIFY_EVENT		0x91
+#define CS35L41_TUNING_SIG		0x109A4A35
+
+enum cs35l41_tuning_param_types {
+	TUNING_PARAM_GAIN,
+};
+
+struct cs35l41_tuning_param_hdr {
+	__le32 tuning_index;
+	__le32 type;
+	__le32 size;
+} __packed;
+
+struct cs35l41_tuning_param {
+	struct cs35l41_tuning_param_hdr hdr;
+	union {
+		__le32 gain;
+	};
+} __packed;
+
+struct cs35l41_tuning_params {
+	__le32 signature;
+	__le32 version;
+	__le32 size;
+	__le32 num_entries;
+	u8 data[];
+} __packed;
 
 static bool firmware_autostart = 1;
 module_param(firmware_autostart, bool, 0444);
@@ -93,11 +119,6 @@ static const struct reg_sequence cs35l41_hda_unmute[] = {
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
 };
 
-static const struct reg_sequence cs35l41_hda_unmute_dsp[] = {
-	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00008000 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB
-	{ CS35L41_AMP_GAIN_CTRL,	0x00000233 }, // AMP_GAIN_PCM = 17.5dB AMP_GAIN_PDM = 19.5dB
-};
-
 static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000000 }, // AMP_GAIN_PCM 0.5 dB
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_HPF_PCM_EN = 1, AMP_VOL_PCM Mute
@@ -118,6 +139,27 @@ static const struct cs_dsp_client_ops client_ops = {
 	.control_remove = hda_cs_dsp_control_remove,
 };
 
+static int cs35l41_request_tuning_param_file(struct cs35l41_hda *cs35l41, char *tuning_filename,
+					     const struct firmware **firmware, char **filename,
+					     const char *ssid)
+{
+	int ret = 0;
+
+	/* Filename is the same as the tuning file with "cfg" suffix */
+	*filename = kasprintf(GFP_KERNEL, "%scfg", tuning_filename);
+	if (*filename == NULL)
+		return -ENOMEM;
+
+	ret = firmware_request_nowarn(firmware, *filename, cs35l41->dev);
+	if (ret != 0) {
+		dev_dbg(cs35l41->dev, "Failed to request '%s'\n", *filename);
+		kfree(*filename);
+		*filename = NULL;
+	}
+
+	return ret;
+}
+
 static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 					 const struct firmware **firmware, char **filename,
 					 const char *dir, const char *ssid, const char *amp_name,
@@ -452,6 +494,94 @@ static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
 }
 #endif
 
+static void cs35l41_set_default_tuning_params(struct cs35l41_hda *cs35l41)
+{
+	cs35l41->tuning_gain = DEFAULT_AMP_GAIN_PCM;
+}
+
+static int cs35l41_read_tuning_params(struct cs35l41_hda *cs35l41, const struct firmware *firmware)
+{
+	struct cs35l41_tuning_params *params;
+	unsigned int offset = 0;
+	unsigned int end;
+	int i;
+
+	params = (void *)&firmware->data[0];
+
+	if (le32_to_cpu(params->size) != firmware->size) {
+		dev_err(cs35l41->dev, "Wrong Size for Tuning Param file. Expected %d got %zu\n",
+			le32_to_cpu(params->size), firmware->size);
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(params->version) != 1) {
+		dev_err(cs35l41->dev, "Unsupported Tuning Param Version: %d\n",
+			le32_to_cpu(params->version));
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(params->signature) != CS35L41_TUNING_SIG) {
+		dev_err(cs35l41->dev,
+			"Mismatched Signature for Tuning Param file. Expected %#x got %#x\n",
+			CS35L41_TUNING_SIG, le32_to_cpu(params->signature));
+		return -EINVAL;
+	}
+
+	end = firmware->size - sizeof(struct cs35l41_tuning_params);
+
+	for (i = 0; i < le32_to_cpu(params->num_entries); i++) {
+		struct cs35l41_tuning_param *param;
+
+		if ((offset >= end) || ((offset + sizeof(struct cs35l41_tuning_param_hdr)) >= end))
+			return -EFAULT;
+
+		param = (void *)&params->data[offset];
+		offset += le32_to_cpu(param->hdr.size);
+
+		if (offset > end)
+			return -EFAULT;
+
+		switch (le32_to_cpu(param->hdr.type)) {
+		case TUNING_PARAM_GAIN:
+			cs35l41->tuning_gain = le32_to_cpu(param->gain);
+			dev_dbg(cs35l41->dev, "Applying Gain: %d\n", cs35l41->tuning_gain);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int cs35l41_load_tuning_params(struct cs35l41_hda *cs35l41, char *tuning_filename)
+{
+	const struct firmware *tuning_param_file = NULL;
+	char *tuning_param_filename = NULL;
+	int ret;
+
+	ret = cs35l41_request_tuning_param_file(cs35l41, tuning_filename, &tuning_param_file,
+						&tuning_param_filename, cs35l41->acpi_subsystem_id);
+	if (ret) {
+		dev_dbg(cs35l41->dev, "Missing Tuning Param for file: %s: %d\n", tuning_filename,
+			ret);
+		return 0;
+	}
+
+	ret = cs35l41_read_tuning_params(cs35l41, tuning_param_file);
+	if (ret) {
+		dev_err(cs35l41->dev, "Error reading Tuning Params from file: %s: %d\n",
+			tuning_param_filename, ret);
+		/* Reset to default Tuning Parameters */
+		cs35l41_set_default_tuning_params(cs35l41);
+	}
+
+	release_firmware(tuning_param_file);
+	kfree(tuning_param_filename);
+
+	return ret;
+}
+
 static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 {
 	const struct firmware *coeff_firmware = NULL;
@@ -471,27 +601,35 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 		cs35l41->halo_initialized = true;
 	}
 
+	cs35l41_set_default_tuning_params(cs35l41);
+
 	ret = cs35l41_request_firmware_files(cs35l41, &wmfw_firmware, &wmfw_filename,
 					     &coeff_firmware, &coeff_filename);
 	if (ret < 0)
 		return ret;
 
 	dev_dbg(cs35l41->dev, "Loading WMFW Firmware: %s\n", wmfw_filename);
-	if (coeff_filename)
+	if (coeff_filename) {
 		dev_dbg(cs35l41->dev, "Loading Coefficient File: %s\n", coeff_filename);
-	else
+		ret = cs35l41_load_tuning_params(cs35l41, coeff_filename);
+		if (ret)
+			dev_warn(cs35l41->dev, "Unable to load Tuning Parameters: %d\n", ret);
+	} else {
 		dev_warn(cs35l41->dev, "No Coefficient File available.\n");
+	}
 
 	ret = cs_dsp_power_up(dsp, wmfw_firmware, wmfw_filename, coeff_firmware, coeff_filename,
 			      hda_cs_dsp_fw_ids[cs35l41->firmware_type]);
 	if (ret)
-		goto err_release;
+		goto err;
 
 	cs35l41_add_controls(cs35l41);
 
 	ret = cs35l41_save_calibration(cs35l41);
 
-err_release:
+err:
+	if (ret)
+		cs35l41_set_default_tuning_params(cs35l41);
 	release_firmware(wmfw_firmware);
 	release_firmware(coeff_firmware);
 	kfree(wmfw_filename);
@@ -504,6 +642,7 @@ static void cs35l41_shutdown_dsp(struct cs35l41_hda *cs35l41)
 {
 	struct cs_dsp *dsp = &cs35l41->cs_dsp;
 
+	cs35l41_set_default_tuning_params(cs35l41);
 	cs_dsp_stop(dsp);
 	cs_dsp_power_down(dsp);
 	dev_dbg(cs35l41->dev, "Unloaded Firmware\n");
@@ -571,6 +710,7 @@ static void cs35l41_mute(struct device *dev, bool mute)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 	struct regmap *reg = cs35l41->regmap;
+	unsigned int amp_gain;
 
 	dev_dbg(dev, "Mute(%d:%d) Playback Started: %d\n", mute, cs35l41->mute_override,
 		cs35l41->playback_started);
@@ -582,8 +722,13 @@ static void cs35l41_mute(struct device *dev, bool mute)
 		} else {
 			dev_dbg(dev, "Unmuting\n");
 			if (cs35l41->cs_dsp.running) {
-				regmap_multi_reg_write(reg, cs35l41_hda_unmute_dsp,
-						ARRAY_SIZE(cs35l41_hda_unmute_dsp));
+				dev_dbg(dev, "Using Tuned Gain: %d\n", cs35l41->tuning_gain);
+				amp_gain = (cs35l41->tuning_gain << CS35L41_AMP_GAIN_PCM_SHIFT) |
+					(DEFAULT_AMP_GAIN_PDM << CS35L41_AMP_GAIN_PDM_SHIFT);
+
+				/* AMP_HPF_PCM_EN = 1, AMP_VOL_PCM  0.0 dB */
+				regmap_write(reg, CS35L41_AMP_DIG_VOL_CTRL, 0x00008000);
+				regmap_write(reg, CS35L41_AMP_GAIN_CTRL, amp_gain);
 			} else {
 				regmap_multi_reg_write(reg, cs35l41_hda_unmute,
 						ARRAY_SIZE(cs35l41_hda_unmute));
@@ -1057,6 +1202,9 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 		goto clean_dsp;
 	}
 
+	dev_info(cs35l41->dev, "Firmware Loaded - Type: %s, Gain: %d\n",
+		 hda_cs_dsp_fw_ids[cs35l41->firmware_type], cs35l41->tuning_gain);
+
 	return 0;
 
 clean_dsp:
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 43d55292b327..d60aa98bfafc 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -21,6 +21,8 @@
 #include <linux/firmware/cirrus/wmfw.h>
 
 #define CS35L41_MAX_ACCEPTABLE_SPI_SPEED_HZ	1000000
+#define DEFAULT_AMP_GAIN_PCM			17	/* 17.5dB Gain */
+#define DEFAULT_AMP_GAIN_PDM			19	/* 19.5dB Gain */
 
 struct cs35l41_amp_cal_data {
 	u32 calTarget[2];
@@ -83,6 +85,7 @@ struct cs35l41_hda {
 	bool mute_override;
 	enum control_bus control_bus;
 	bool bypass_fw;
+	unsigned int tuning_gain;
 
 };
 
-- 
2.34.1


