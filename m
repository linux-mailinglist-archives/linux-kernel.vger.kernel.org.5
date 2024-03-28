Return-Path: <linux-kernel+bounces-122878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE6188FEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66330297432
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F57EF0B;
	Thu, 28 Mar 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="K+2h2g3O"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89917EEEA;
	Thu, 28 Mar 2024 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628060; cv=none; b=CuzNnI0Zlc0JYNX4eoifDdBC73mUONZ9uBuRL/HKK+QRvA3x+Emd62rgo2BerT6jbb3WniG370+Q6dTQqGEzVpdKseWc8WJGTprI2ACwcrDs9doV/fh5+PVVr1u/HqNGc75pC2UmIwqP5xB7/PlxCOkaMpAgeYOtq29ETGpo9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628060; c=relaxed/simple;
	bh=qfJIVtEGnV5PBDcNxLtv8PQ04/VnkAd3XqvIE+epqb4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h4eN4cJC18PQxvmcT7NlMzzQ78sgi7p+LnHJHNrPXPFg+AjC8lR0gUhSJIW7SaERimkNxjuefiWI8S0VdRAkKt5R7LkWiN+w//wrnM7Pd+xU2zgRhdb8N3MH/9RbWw6Qko+pQJvPQPBCHJeZWDDfgAKoQDV9kpB+N95P/vxmzmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=K+2h2g3O; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S80qwZ031605;
	Thu, 28 Mar 2024 07:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=/
	YcgOhBnjkdBqrLgF/BoqdsdMXoJw5NAe63KAucPw24=; b=K+2h2g3OHbggsdkiS
	JyRxNyxDovd/rAg6P/5KnH2l4p2rEmEpKHJJD0tMys3gL3rkiRtMDCNIFSf8mSXr
	NavMOLZYEDG1dV5W0EtwpGKLm/mVlo3qUTYx9azKkVjm87yLZaTA86SlppgAKd4Q
	Od3R1CdlGDSwsUWKPR6MVpXBxwcPxqtrQys+VIhKb8PI1bJmR3H2TQS0n4pOf0Sp
	qQMEKFEeJkfP6YIM4UsL8yfMWkAJv0CHZyaSI6kLOzm6gQHxQhZzYhXgpPjWFt+X
	opiJym64Lzyg8WgPoODE0xXrUxbUyO3AmP/Nv8WD1rFCRoSxgWzS1QvHSR5EpfaL
	IrqjQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x4k7k2ngu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:14:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Mar
 2024 12:14:04 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Thu, 28 Mar 2024 12:14:04 +0000
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.19])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1D93D820243;
	Thu, 28 Mar 2024 12:14:04 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Add ACPI device match tables
Date: Thu, 28 Mar 2024 12:13:55 +0000
Message-ID: <20240328121355.18972-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BzIDj9hR-Rk9Q3hSWONBHy2LpF0DPg7R
X-Proofpoint-ORIG-GUID: BzIDj9hR-Rk9Q3hSWONBHy2LpF0DPg7R
X-Proofpoint-Spam-Reason: safe

Adding the ACPI HIDs to the match table triggers the cs35l56-hda modules
to be loaded on boot so that Serial Multi Instantiate can add the
devices to the bus and begin the driver init sequence.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic CS35L56 amplifier")
---
 sound/pci/hda/cs35l56_hda_i2c.c | 13 +++++++++++--
 sound/pci/hda/cs35l56_hda_spi.c | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda_i2c.c b/sound/pci/hda/cs35l56_hda_i2c.c
index 13beee807308..40f2f97944d5 100644
--- a/sound/pci/hda/cs35l56_hda_i2c.c
+++ b/sound/pci/hda/cs35l56_hda_i2c.c
@@ -56,10 +56,19 @@ static const struct i2c_device_id cs35l56_hda_i2c_id[] = {
 	{}
 };
 
+static const struct acpi_device_id cs35l56_acpi_hda_match[] = {
+	{ "CSC3554", 0 },
+	{ "CSC3556", 0 },
+	{ "CSC3557", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cs35l56_acpi_hda_match);
+
 static struct i2c_driver cs35l56_hda_i2c_driver = {
 	.driver = {
-		.name		= "cs35l56-hda",
-		.pm		= &cs35l56_hda_pm_ops,
+		.name		  = "cs35l56-hda",
+		.acpi_match_table = cs35l56_acpi_hda_match,
+		.pm		  = &cs35l56_hda_pm_ops,
 	},
 	.id_table	= cs35l56_hda_i2c_id,
 	.probe		= cs35l56_hda_i2c_probe,
diff --git a/sound/pci/hda/cs35l56_hda_spi.c b/sound/pci/hda/cs35l56_hda_spi.c
index a3b2fa76663d..7f02155fe61e 100644
--- a/sound/pci/hda/cs35l56_hda_spi.c
+++ b/sound/pci/hda/cs35l56_hda_spi.c
@@ -56,10 +56,19 @@ static const struct spi_device_id cs35l56_hda_spi_id[] = {
 	{}
 };
 
+static const struct acpi_device_id cs35l56_acpi_hda_match[] = {
+	{ "CSC3554", 0 },
+	{ "CSC3556", 0 },
+	{ "CSC3557", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cs35l56_acpi_hda_match);
+
 static struct spi_driver cs35l56_hda_spi_driver = {
 	.driver = {
-		.name		= "cs35l56-hda",
-		.pm		= &cs35l56_hda_pm_ops,
+		.name		  = "cs35l56-hda",
+		.acpi_match_table = cs35l56_acpi_hda_match,
+		.pm		  = &cs35l56_hda_pm_ops,
 	},
 	.id_table	= cs35l56_hda_spi_id,
 	.probe		= cs35l56_hda_spi_probe,
-- 
2.34.1


