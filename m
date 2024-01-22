Return-Path: <linux-kernel+bounces-33313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4F783684A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FB21C21282
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3047765;
	Mon, 22 Jan 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bjFtEG/P"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AD46B9B;
	Mon, 22 Jan 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935782; cv=none; b=JjPeGHA9fMTzYque9MvDCViV+Eh7hHMHH2FkzssVjWX2Z4z68i7CYUmwi/gFhODJlRFiNwnmi0JsPs0Vc76MpJrcx/rdGg6yuE2+q/UcdgtiHfDelmAiF0JtxtP3m5GWyQAhsjZsMv3M2XNkxXAW9Y39qFZfRN3njCniFOWjmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935782; c=relaxed/simple;
	bh=SQf3HCTG9nGeUY31xrUKwFz3cZXNrJIrlswKVlLqEiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bZQmPOUU1A2EAd1WDZdziub4ViXjksoFQ0TBnHUXMotapikyUIZv6Ry09tlCk+imDlcBuqaVJpJ+PgXBq3NsueFwFkgz+9ZRjMMgLkQzFcVWUVOiAenaXc3LlIYQ9FVnQkR1S15q6GPckuOSeuw7tSqhp3+p7PeRRSQRRq8bOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bjFtEG/P; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5k6nu030313;
	Mon, 22 Jan 2024 09:02:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=0
	mPLhPK6fWPpvy8GLu7GR7nSQ3cSYPV0tcLCns0FbBg=; b=bjFtEG/PKALsZBM41
	t96ASCeK0uTEF3J4zRfPJbUYzJ8p72ykL5/JwoIfcELfMXUb2KDPpDLtrVgFFmvA
	n8pjGiinAEA9qY1ybIjdKv7kJIvFb/LSwm8f8PSQzmzVKHyzluWl8H1RzoIK77bT
	QESYfLEDMKikMSUcjD/n4VuyRUvvci5MtHliDgXjo5JSMJXDZ4E70+x+XguqTxFY
	+FUP53PBVovepA+B35UazteitlP3TEw+BTuMHQfw+2myLBCX4EGz1tJRNhB/EkD4
	BoLoQhMBLQYNf2LKFg+rGgzBiRxqZSOJlZoWQ6TGyqqvD2nixnpjDUdL/vBxaxUN
	Ierdg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vrcf32k5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 09:02:30 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 15:01:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 22 Jan 2024 15:01:57 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C5C6511CC;
	Mon, 22 Jan 2024 15:01:57 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>,
        Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>,
        Bard Liao
	<yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen
	<kai.vehmanen@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH] ASoC: Intel: mtl-match: Add cs42l43_l0 cs35l56_l23 for MTL
Date: Mon, 22 Jan 2024 15:01:56 +0000
Message-ID: <20240122150156.68983-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: W96pIoV5lf3ndjQOFSHOoXeQrBWQTuJU
X-Proofpoint-GUID: W96pIoV5lf3ndjQOFSHOoXeQrBWQTuJU
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 .../intel/common/soc-acpi-intel-mtl-match.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index feb12c6c85d1..625f991b1ad4 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -377,6 +377,36 @@ static const struct snd_soc_acpi_adr_device cs35l56_2_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device cs35l56_2_r_adr[] = {
+	{
+		.adr = 0x00023301FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00023201FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_3_endpoint,
+		.name_prefix = "AMP4"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device cs35l56_3_l_adr[] = {
+	{
+		.adr = 0x00033001fa355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00033101fa355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_2_endpoint,
+		.name_prefix = "AMP2"
+	}
+};
+
 static const struct snd_soc_acpi_link_adr rt5682_link2_max98373_link0[] = {
 	/* Expected order: jack -> amp */
 	{
@@ -554,6 +584,26 @@ static const struct snd_soc_acpi_link_adr mtl_cs42l43_cs35l56[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr cs42l43_link0_cs35l56_link2_link3[] = {
+	/* Expected order: jack -> amp */
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l43_0_adr),
+		.adr_d = cs42l43_0_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(cs35l56_2_r_adr),
+		.adr_d = cs35l56_2_r_adr,
+	},
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(cs35l56_3_l_adr),
+		.adr_d = cs35l56_3_l_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -599,6 +649,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-mtl-rt1318-l12-rt714-l0.tplg"
 	},
+	{
+		.link_mask = BIT(0) | BIT(2) | BIT(3),
+		.links = cs42l43_link0_cs35l56_link2_link3,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-mtl-cs42l43-l0-cs35l56-l23.tplg",
+	},
 	{
 		.link_mask = GENMASK(2, 0),
 		.links = mtl_cs42l43_cs35l56,
-- 
2.34.1


