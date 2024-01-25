Return-Path: <linux-kernel+bounces-38582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FCC83C292
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0901F22A87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398017586;
	Thu, 25 Jan 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UHMpZcqz"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5E481BA;
	Thu, 25 Jan 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186008; cv=none; b=ZkoLw5m9ze2KrTz9tT8St08nzkUCxk4s2bftzvM7IMOMg3P27mowbgXVUWYi+vPgCJsrm0ShlO9MN/pR7lG/0WDNNH1uikhrGnbDXmEkPm1FwH4c3a80bKFRSzGUOt6CuQm49wcGn4bLBY+gXNyTWrYdoW2eewM1rkJzwuP62P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186008; c=relaxed/simple;
	bh=ibjJImIn88zs1YjIKt/2dvNQBau6ZoNe8tzjCHPrGx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKJXVgMz6BLtuWZFH5ILpewgm1mPvWBprEE9jomSQbip/wts4STJcESCC1XJKG8E5oMKH/uQCqnT97LQIb5jBJ9QZaGgK9F8uz1Us5uvVKe7Wcu31hQcJUwMD6CwpwC8BAgHps6L82PQYQoMcRpQ0y7ve+VRRizpV76joovTsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UHMpZcqz; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P5Ph4a014771;
	Thu, 25 Jan 2024 06:33:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=v
	2Ut9bvfDLcV174M2sjh0LDuIb84AqNcxzdKd+no5Yc=; b=UHMpZcqz2HOVHxaVU
	eYXwPsCDu8xsUliJ7Atcts1rLweaRaaUhwC9Rb2ZTBBq+y8xFFpXHz33DfbNER7W
	F3adtZgQ5+r7g68JaBLdTNzFv1waw3/Zl/I4FOrTGwY03UnzhSIYEHuDlS4lAzMg
	vETmZ3T+0NJCuucxUbzYy93ckVNNNCcVc64wqZdSKFmweNx7/SmfFtKGS7V04kiU
	RvogChtTMta458tQBne8pG5WPQGQExF498u3ZoxoQ9ePfPomZxbSb+jicC/fPSqj
	yE2/mBfgLwJ3J+34KAzfW8u7r7MvGQ0UjG0KdFIcFH+zdbNVNWQDBkXIIKILxDDd
	G8+Cw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmfhj7s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 06:33:04 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 12:33:01 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 25 Jan 2024 12:33:01 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.251.117])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 52682820246;
	Thu, 25 Jan 2024 12:33:01 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirks for HP G11 Laptops using CS35L56
Date: Thu, 25 Jan 2024 12:33:01 +0000
Message-ID: <20240125123301.41692-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Aera9NZcpbFVW9IWzhFtkvefyTwhzX4C
X-Proofpoint-GUID: Aera9NZcpbFVW9IWzhFtkvefyTwhzX4C
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Add quirks for two HP G11 laptops that use a Realtek HDA codec combined
with four CS35L56 amplifiers using SPI.

The CS35L56 driver uses the component binding interface, so uses the same
setup code as the CS35L41 quirks.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 42ee37af24bc..b2b289626323 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6819,6 +6819,11 @@ static void alc287_fixup_legion_16ithg6_speakers(struct hda_codec *cdc, const st
 	comp_generic_fixup(cdc, action, "i2c", "CLSA0101", "-%s:00-cs35l41-hda.%d", 2);
 }
 
+static void cs35l56_fixup_spi_four(struct hda_codec *cdc, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(cdc, action, "spi", "CSC3556", "-%s:00-cs35l56-hda.%d", 4);
+}
+
 static void tas2781_fixup_i2c(struct hda_codec *cdc,
 	const struct hda_fixup *fix, int action)
 {
@@ -7310,6 +7315,7 @@ enum {
 	ALC2XX_FIXUP_HEADSET_MIC,
 	ALC289_FIXUP_DELL_CS35L41_SPI_2,
 	ALC294_FIXUP_CS35L41_I2C_2,
+	ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9461,6 +9467,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
 	},
+	[ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l56_fixup_spi_four,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_GPIO_LED,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9789,6 +9801,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c47, "HP EliteBook 840 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c48, "HP EliteBook 860 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c49, "HP Elite x360 830 2-in-1 G11", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c52, "HP EliteBook 1040 G11", ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c53, "HP Elite x360 1040 2-in-1 G11", ALC245_FIXUP_CS35L56_SPI_4_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
-- 
2.30.2


