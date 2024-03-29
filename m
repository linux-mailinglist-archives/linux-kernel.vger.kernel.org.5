Return-Path: <linux-kernel+bounces-124441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344FF8917C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581371C22990
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883646AFAE;
	Fri, 29 Mar 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="pKCCSMsO"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD356A037;
	Fri, 29 Mar 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711709; cv=none; b=B5DErkXBUtbJS19jxCJGVOrpAxygKUqpciXHdnuLhM/wteqKzfrPKFTSPybJ8xXkYsL/9r+FbrBWeWEC+UlRX3qVQUFUEz44Dk4Nqvz2rgmTAfpQibA/lON8hrg8AkF3JO4lDIUhfPsZ8HeVFJWdP2IwW0aBx0v4sXZTcWhOc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711709; c=relaxed/simple;
	bh=ke/VUwIe1OO+bDbORJF1f8ePxj8H2rnfKHFV6nTnzfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OiIjKl7hJSZ0o5L/N6V9gfmwgVXqMCm97D+0HkxP4b4rVvwnjf8eYHR7VjMNU4LScFrNqsy3i+cyEtFyuBdaTooViZ8/4DbDJOlXC/SK+F1gDBzXNxsnJ3LycPRnGRBq9cqzBs+MjdtVSNxits3rO4YFxut8wjS1Geu/xJ8G1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=pKCCSMsO; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TAeera029260;
	Fri, 29 Mar 2024 06:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=x
	SAFwG9CV4jLKTWXRdMat2YE8sxtFXXlUQvX5gSJWrE=; b=pKCCSMsO5/3Q/mXoh
	BEPWhekyK5nrt/7Gm345mCDgUaeVw/uu9B5fDPInsELDjkZdZ75r6mzVWvbbMgbU
	sUt/GhLa+Yj3z+XA6R1c9/NfTae0L2AlO6JIasOkPVtdeB4M2j9ZKcWGQJFXygbn
	Dbjwo4bSHZOZ3e/UJlPc87yCT2l07ZWAoM55oKiJRBjUno5xJrNbMMCmKA7nQdg9
	xDrIXfLniEW92Kpo1fTu9HtYjpykMcNU/ekBy0v9kT9y+YtcfaTffHe10KAaQXfs
	ysgnh4EXZ3VxnfyXtn7E+ZWjevye1/J/2JO/sMFUTCPi9mpdnn/orIZ+wBLMy5uU
	lEEPw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x4et84ev4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 06:28:12 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 11:28:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Fri, 29 Mar 2024 11:28:10 +0000
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.19])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3174F820244;
	Fri, 29 Mar 2024 11:28:10 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirks for ASUS Laptops using CS35L56
Date: Fri, 29 Mar 2024 11:28:03 +0000
Message-ID: <20240329112803.23897-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7OkJ-kNs1QpHM4pRLS9A68IjO_-xygUH
X-Proofpoint-ORIG-GUID: 7OkJ-kNs1QpHM4pRLS9A68IjO_-xygUH
X-Proofpoint-Spam-Reason: safe

These ASUS laptops use the Realtek HDA codec combined with a number of
CS35L56 amplifiers.

The SSID of the GA403U matches a previous ASUS laptop - we can tell them
apart because they use different codecs.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 53 ++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a17c36a36aa5..7d229f4a8aa6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6875,11 +6875,38 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	comp_generic_fixup(cdc, action, "i2c", "CLSA0101", "-%s:00-cs35l41-hda.%d", 2);
 }
 
+static void cs35l56_fixup_i2c_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "i2c", "CSC3556", "-%s:00-cs35l56-hda.%d", 2);
+}
+
+static void cs35l56_fixup_i2c_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "i2c", "CSC3556", "-%s:00-cs35l56-hda.%d", 4);
+}
+
+static void cs35l56_fixup_spi_two(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "spi", "CSC3556", "-%s:00-cs35l56-hda.%d", 2);
+}
+
 static void cs35l56_fixup_spi_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(cdc, action, "spi", "CSC3556", "-%s:00-cs35l56-hda.%d", 4);
 }
 
+static void alc285_fixup_asus_ga403u(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	/*
+	 * The same SSID has been re-used in different hardware, they have
+	 * different codecs and the newer GA403U has a ALC285.
+	 */
+	if (cdc->core.vendor_id == 0x10ec0285)
+		cs35l56_fixup_i2c_two(cdc, fix, action);
+	else
+		alc_fixup_inv_dmic(cdc, fix, action);
+}
+
 static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
@@ -7436,6 +7463,10 @@ enum {
 	ALC256_FIXUP_ACER_SFG16_MICMUTE_LED,
 	ALC256_FIXUP_HEADPHONE_AMP_VOL,
 	ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX,
+	ALC285_FIXUP_CS35L56_SPI_2,
+	ALC285_FIXUP_CS35L56_I2C_2,
+	ALC285_FIXUP_CS35L56_I2C_4,
+	ALC285_FIXUP_ASUS_GA403U,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9643,6 +9674,22 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_spectre_x360_eu0xxx,
 	},
+	[ALC285_FIXUP_CS35L56_SPI_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l56_fixup_spi_two,
+	},
+	[ALC285_FIXUP_CS35L56_I2C_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l56_fixup_i2c_two,
+	},
+	[ALC285_FIXUP_CS35L56_I2C_4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l56_fixup_i2c_four,
+	},
+	[ALC285_FIXUP_ASUS_GA403U] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_asus_ga403u,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10096,7 +10143,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1b11, "ASUS UX431DA", ALC294_FIXUP_ASUS_COEF_1B),
-	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x1043, 0x1b13, "ASUS U41SV/GA403U", ALC285_FIXUP_ASUS_GA403U),
 	SND_PCI_QUIRK(0x1043, 0x1b93, "ASUS G614JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c03, "ASUS UM3406HA", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10104,6 +10151,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c33, "ASUS UX5304MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c43, "ASUS UX8406MA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1c63, "ASUS GU605M", ALC285_FIXUP_CS35L56_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1c9f, "ASUS G614JU/JV/JI", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JY/JZ/JI/JG", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
@@ -10115,11 +10163,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606", ALC285_FIXUP_CS35L56_I2C_4),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1e63, "ASUS H7606W", ALC285_FIXUP_CS35L56_I2C_2),
+	SND_PCI_QUIRK(0x1043, 0x1e83, "ASUS GA605W", ALC285_FIXUP_CS35L56_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1ee2, "ASUS UM6702RA/RC", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_ASUS_GA401),
-- 
2.34.1


