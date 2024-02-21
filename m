Return-Path: <linux-kernel+bounces-74959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82785E07A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF781F248F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875908062C;
	Wed, 21 Feb 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qU7lSW0g"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F67FBCA;
	Wed, 21 Feb 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527927; cv=none; b=cSlk0xbCvpEdBGnOibuvgdC4uPbzvCjxvLa3PcslOXlxAFTcTrrObtIeF0uM1TNpBe0g/w0tfYiXZnTNpmDO8lbR9eI8Sqjxu2yYNp/NbpSPr4oajSaZXlG+LZMnsnhjim03NF1hYGG4MKG4I7djOz+PeNELetNsNant7bcullo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527927; c=relaxed/simple;
	bh=ezwGTmb0p2OuSkCHLsCPYmiNs24E5alpl0HgPG9YWWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVYHoRj1G7pp7gBHlSlVsRcoogzFdtU9lIIJPP0bNnWxk4g3OdWA776FteJ1B9aytR6hiLFJwV3vhHCB71Fc42DI3/cv+PUaFk+zDNO7q9K+U6PAMzGyPennc4CIqrTtJNoLt62ZxeeSsbweIY0Nys9ELCKAqsqyEA5TVxs7Alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qU7lSW0g; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LCUQsK011338;
	Wed, 21 Feb 2024 09:05:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=yytQ7GXTVFXWsBrfAM2U1tdjKyAr/L1PFu8PYDeSpuk=; b=
	qU7lSW0gY1I9XSP5MP3iw5+29WbYShFT/gR0Jx2zLyIxmWG36I8qL712wxXZiOF6
	sUD6aUFpMPAhdnlZCJi31w//3bdJmMTRSGQ1EAHok/Iff+q2H2PQhJA33ZMxy0w+
	i9ImqbXMjySKc6bz0FM6tXXrqr00myOBs52ZAp51JgCQGKE43RjXGiHHqwRln2yM
	8csjA+KKjJ824YrhbvrzyMH4ZOj/xqqjPxNWaiF0nrqVY/79rxkL4oHCcYLVYotY
	c6UnQo35vjJ+dmD1tTXipDmVxlccheF3ugp0dNzcLjLDbfU5a5qXQuc4l2GMb5ye
	DcMrzKK+FDaucnRG7V5n8g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205h4tk-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:13 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4CC6482025A;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 8/9] ALSA: hda: cs35l56: Apply amp calibration from EFI data
Date: Wed, 21 Feb 2024 15:05:06 +0000
Message-ID: <20240221150507.1039979-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k2y-l2KGer9iwDt8BYqoie2PBIRRsdIE
X-Proofpoint-GUID: k2y-l2KGer9iwDt8BYqoie2PBIRRsdIE
X-Proofpoint-Spam-Reason: safe

If there are factory calibration settings in EFI, extract the
settings and write them to the firmware calibration controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/Kconfig       |  2 ++
 sound/pci/hda/cs35l56_hda.c | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 21a90b3c4cc7..6edfdaf98a74 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -162,6 +162,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	select SND_HDA_SCODEC_CS35L56
 	select SND_HDA_CIRRUS_SCODEC
 	select SND_HDA_CS_DSP_CONTROLS
+	select SND_SOC_CS_AMP_LIB
 	help
 	  Say Y or M here to include CS35L56 amplifier support with
 	  I2C control.
@@ -177,6 +178,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	select SND_HDA_SCODEC_CS35L56
 	select SND_HDA_CIRRUS_SCODEC
 	select SND_HDA_CS_DSP_CONTROLS
+	select SND_SOC_CS_AMP_LIB
 	help
 	  Say Y or M here to include CS35L56 amplifier support with
 	  SPI control.
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 75a14ba54fcd..47a225114f56 100644
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
+	ret = hda_cs_dsp_write_cal_coeffs(&cs35l56->cs_dsp,
+					  &cs35l56_calibration_controls,
+					  &cs35l56->base.cal_data);
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
-- 
2.30.2


