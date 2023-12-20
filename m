Return-Path: <linux-kernel+bounces-7327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105AE81A5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2033281F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986A47790;
	Wed, 20 Dec 2023 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CdW7BCwO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595B4777E;
	Wed, 20 Dec 2023 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKFAkOL027189;
	Wed, 20 Dec 2023 10:58:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=EEqOXioMrsS5cfGOyT5uA+R4PIihLaRy8ro7FSWVp24=; b=
	CdW7BCwO3dxeYFgdUBCvchJSBLnTUAn/kUQ7WwlchbC3FobgpQPeGkQb9ZEOK8Hl
	bV8redxyimjFyUJCBj/j3t2QFF2dXPp/abiub+i/x7vOwFHTuLAYpjZbAzdw9Oje
	yGG0ymbfkGMTv/ml+VyD06/bzm8Kp4oWz5ubhLUaag7OHFAhQshBSAVm9X8rzbOb
	DevzNM45PE7wDebcbuImjBCJESAqKER9HtDGZil5Lc04IUmAD8+emxlZ1stbQKkB
	lYWCBYBBuBYG+9YJC5eA5z1wyckffghVxHDRCgQh0KYrrBS6XKgtuLeRRGhGcvnG
	DhfCayS3NOCm0ewx+NgMkw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3v196ndrdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:58:38 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 16:58:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 20 Dec 2023 16:58:36 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BC19E11CC;
	Wed, 20 Dec 2023 16:58:36 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/3] ALSA: hda: cs35l41: Support additional Dell models without _DSD
Date: Wed, 20 Dec 2023 16:58:27 +0000
Message-ID: <20231220165829.160711-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220165829.160711-1-sbinding@opensource.cirrus.com>
References: <20231220165829.160711-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sk0V2LMuPYB4f1NumQUO1xiTjcFC-S9S
X-Proofpoint-GUID: sk0V2LMuPYB4f1NumQUO1xiTjcFC-S9S
X-Proofpoint-Spam-Reason: safe

Add new model entries into configuration table.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index c9eb70290973..11d4b8b32a66 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -35,6 +35,10 @@ struct cs35l41_config {
 };
 
 static const struct cs35l41_config cs35l41_config_table[] = {
+	{ "10280B27", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10280B28", SPI, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "10280BEB", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
+	{ "10280C4D", I2C, 4, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, CS35L41_LEFT, CS35L41_RIGHT }, 0, 1, -1, 1000, 4500, 24 },
 /*
  * Device 103C89C6 does have _DSD, however it is setup to use the wrong boost type.
  * We can override the _DSD to correct the boost type here.
@@ -344,6 +348,10 @@ struct cs35l41_prop_model {
 static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CLSA0100", NULL, lenovo_legion_no_acpi },
 	{ "CLSA0101", NULL, lenovo_legion_no_acpi },
+	{ "CSC3551", "10280B27", generic_dsd_config },
+	{ "CSC3551", "10280B28", generic_dsd_config },
+	{ "CSC3551", "10280BEB", generic_dsd_config },
+	{ "CSC3551", "10280C4D", generic_dsd_config },
 	{ "CSC3551", "103C89C6", generic_dsd_config },
 	{ "CSC3551", "104312AF", generic_dsd_config },
 	{ "CSC3551", "10431433", generic_dsd_config },
-- 
2.34.1


