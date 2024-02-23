Return-Path: <linux-kernel+bounces-78625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BD861608
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E7282818
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9E8405B;
	Fri, 23 Feb 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XZjyc/Af"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924D8286E;
	Fri, 23 Feb 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702775; cv=none; b=gDWeL6cMgxBOdrAeUOMNtPWun0bG4n7mEKnJ17XAvjFWYvNurq5Liee1BFHIhTjeg1LIHZihFIDGItAHWbEZ6HRazzmijHSKja1GCV4AG1tVAuOJ+z0ss/tze/yHYE3TPfFCVQ5pwb76Myxet/vxF8xrKI7bvRQWDqMu4lqPpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702775; c=relaxed/simple;
	bh=at4PleEsdofi0W9d0DHq9d3aHLVH9DNyQVTGoGwWLic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2Y6V8OSZvlOFVMk2NKwruaEaGoYS9qBIrnVQfLE48CTvBpQ0AZ8WfzRbtCnsd7derRkU35qRy5sE67Qt0JdiR46du8XPlqeIAAoU212hxHIDbt0QSbTMgCnvO4gTtQlz1qY/DWatWfMJJOVWzw9w02oqC0fR9oXMa18EXCNFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XZjyc/Af; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N5xe8x005825;
	Fri, 23 Feb 2024 09:39:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=3z2szSszGyGY76+w1bd3gmMNzvy8vmlvqxcIqwLz1oU=; b=
	XZjyc/Af2fREOUTBwV6wnG0has8/ucQHH4/Dd/d4mpW20JOvHQzLT1olZW/jqv/x
	jKUeI8CmdN1a33AJoNZdpxwfjg7G8HESiXPTu1eQilK9h0IkxcSKE8EZHvDVWIib
	K6lTcLfU45oRysGtLDtoTN+OUo7AlK+TqHsoV42xZuq/Bn2+VeCCjLDDyOMVXyeV
	kLNMMkKrsgIjKw21BHTOlYi+m/wzeMzI2rs5IweAxKp2gXdAmzMEDCoB7s6YS5Ts
	hU0NZwMFfx2OYwPf9UvHKcLB5UOS5OFutPYOdbPWcGQVWPP/R5WujB3ZZTKtfX2o
	8FBDSlGbHXIcq56GILie9w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205m5pf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:39:12 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:39:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:39:10 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6FF9B820258;
	Fri, 23 Feb 2024 15:39:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 5/6] ALSA: hda: cs35l56: Apply amp calibration from EFI data
Date: Fri, 23 Feb 2024 15:39:09 +0000
Message-ID: <20240223153910.2063698-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223153910.2063698-1-rf@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XPFxklkVkvtGI-zt_bsAP_b0xRbmgSLY
X-Proofpoint-GUID: XPFxklkVkvtGI-zt_bsAP_b0xRbmgSLY
X-Proofpoint-Spam-Reason: safe

If there are factory calibration settings in EFI, extract the
settings and write them to the firmware calibration controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/Kconfig       |  2 ++
 sound/pci/hda/cs35l56_hda.c | 39 ++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 26da739eea82..f806636242ee 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -165,6 +165,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	select SND_HDA_SCODEC_CS35L56
 	select SND_HDA_CIRRUS_SCODEC
 	select SND_HDA_CS_DSP_CONTROLS
+	select SND_SOC_CS_AMP_LIB
 	help
 	  Say Y or M here to include CS35L56 amplifier support with
 	  I2C control.
@@ -180,6 +181,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	select SND_HDA_SCODEC_CS35L56
 	select SND_HDA_CIRRUS_SCODEC
 	select SND_HDA_CS_DSP_CONTROLS
+	select SND_SOC_CS_AMP_LIB
 	help
 	  Say Y or M here to include CS35L56 amplifier support with
 	  SPI control.
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 75a14ba54fcd..5ad76d6914c3 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/cs-amp-lib.h>
 #include <sound/hda_codec.h>
 #include <sound/tlv.h>
 #include "cirrus_scodec.h"
@@ -547,6 +548,22 @@ static void cs35l56_hda_add_dsp_controls(struct cs35l56_hda *cs35l56)
 	hda_cs_dsp_add_controls(&cs35l56->cs_dsp, &info);
 }
 
+static void cs35l56_hda_apply_calibration(struct cs35l56_hda *cs35l56)
+{
+	int ret;
+
+	if (!cs35l56->base.cal_data_valid || cs35l56->base.secured)
+		return;
+
+	ret = cs_amp_write_cal_coeffs(&cs35l56->cs_dsp,
+				      &cs35l56_calibration_controls,
+				      &cs35l56->base.cal_data);
+	if (ret < 0)
+		dev_warn(cs35l56->base.dev, "Failed to write calibration: %d\n", ret);
+	else
+		dev_info(cs35l56->base.dev, "Calibration applied\n");
+}
+
 static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 {
 	const struct firmware *coeff_firmware = NULL;
@@ -618,12 +635,8 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (coeff_filename)
 		dev_dbg(cs35l56->base.dev, "Loaded Coefficients: %s\n", coeff_filename);
 
-	if (!firmware_missing) {
-		ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
-		if (ret)
-			goto err_powered_up;
-	} else if (wmfw_firmware || coeff_firmware) {
-		/* If we downloaded firmware, reset the device and wait for it to boot */
+	/* If we downloaded firmware, reset the device and wait for it to boot */
+	if (firmware_missing && (wmfw_firmware || coeff_firmware)) {
 		cs35l56_system_reset(&cs35l56->base, false);
 		regcache_mark_dirty(cs35l56->base.regmap);
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
@@ -646,6 +659,11 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (ret)
 		dev_dbg(cs35l56->base.dev, "%s: cs_dsp_run ret %d\n", __func__, ret);
 
+	cs35l56_hda_apply_calibration(cs35l56);
+	ret = cs35l56_mbox_send(&cs35l56->base, CS35L56_MBOX_CMD_AUDIO_REINIT);
+	if (ret)
+		cs_dsp_stop(&cs35l56->cs_dsp);
+
 err_powered_up:
 	if (!cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
@@ -953,6 +971,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 		goto err;
 	}
 
+	cs35l56->base.cal_index = cs35l56->index;
+
 	cs35l56_init_cs_dsp(&cs35l56->base, &cs35l56->cs_dsp);
 	cs35l56->cs_dsp.client_ops = &cs35l56_hda_client_ops;
 
@@ -990,6 +1010,10 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int id)
 	if (ret)
 		goto err;
 
+	ret = cs35l56_get_calibration(&cs35l56->base);
+	if (ret)
+		goto err;
+
 	ret = cs_dsp_halo_init(&cs35l56->cs_dsp);
 	if (ret) {
 		dev_err_probe(cs35l56->base.dev, ret, "cs_dsp_halo_init failed\n");
@@ -1064,10 +1088,11 @@ const struct dev_pm_ops cs35l56_hda_pm_ops = {
 EXPORT_SYMBOL_NS_GPL(cs35l56_hda_pm_ops, SND_HDA_SCODEC_CS35L56);
 
 MODULE_DESCRIPTION("CS35L56 HDA Driver");
+MODULE_IMPORT_NS(FW_CS_DSP);
 MODULE_IMPORT_NS(SND_HDA_CIRRUS_SCODEC);
 MODULE_IMPORT_NS(SND_HDA_CS_DSP_CONTROLS);
 MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
+MODULE_IMPORT_NS(SND_SOC_CS_AMP_LIB);
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_AUTHOR("Simon Trimmer <simont@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(FW_CS_DSP);
-- 
2.30.2


