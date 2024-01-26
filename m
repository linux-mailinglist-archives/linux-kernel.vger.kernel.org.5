Return-Path: <linux-kernel+bounces-40050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089E83D95B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F429361F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423AB1B7E5;
	Fri, 26 Jan 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="F0n9LrC6"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BC81AACD;
	Fri, 26 Jan 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268641; cv=none; b=jGHdAjKNi3ASs+NxNFmKz8tiLANIqecCE7iUxE59KC2K1sZzRJv8s5QYIZPeqto3HQVZKlptniqDwAemG9HayNDnRnXMJFwUTw9INmH5/I8XBLMBOlMhxc/Gqz6+Fq5l5ocrGjoeqBKsrghit2gTUBz3GZq5n/q9eV/SMas4ScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268641; c=relaxed/simple;
	bh=4zbQUjsj3dgdWCURhXT0L/NIrT+3lvP4U5SKuqfZawE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUrcCcqzH444AvHZQSKdKrVV22GXWYa8eDt3LDpNdhmqkNMPOabT4XQqdPSJTjvhlxUSmNO5pgomjJj4xhjXS9ahb6qt0rXHehlyUjnehGzOSoKLbbbLCZAJUZ+HO5qWk8Ju3dVsjfWBjjWUhUdw0l8179GgqfmpTxnvgZr5y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=F0n9LrC6; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QAq09r023770;
	Fri, 26 Jan 2024 05:30:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=HrfhbL45vt5QCqOJGS84ZDQ1gvDhC+TWwuE32OZjF54=; b=
	F0n9LrC6RyFzVtmnuZ/G3aM0DvQHqHvxbx9XCiV0ytzgDba7WsDzfSu82gZ4M09+
	PCuWPmMPpE6Pyb822tnGEGenPeBAiEopmvuHjaq6EAcZI15qg2x+M2hYSgQOJ3iV
	85JIDmP9/PXdO7vaaTKlyXXYS9gxB3PiFrovNxw8UTlZC2DTwT41lVRO4xi0XdX7
	5kozm3iC+w/U9QYBX5hZ8H/IVsVgWuo7ZJepfVGI9rHNa0rD34TPpavy1RfkysiZ
	Awy5pycT+C3V+h1nZwq47d9HuY67pXT22/frXlWpfn6X2OrE2C9EXyJb+IJiV4X4
	1RTxLk+zphMlSkSfXR21Ag==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vtmf9unnn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 05:30:19 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 11:30:17 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 26 Jan 2024 11:30:17 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (LONNG2L6RQ3.ad.cirrus.com [198.90.238.116])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3AF1A820247;
	Fri, 26 Jan 2024 11:30:17 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/4] ALSA: hda: cs35l41: Set Channel Index correctly when system is missing _DSD
Date: Fri, 26 Jan 2024 11:30:04 +0000
Message-ID: <20240126113007.4084-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
References: <20240126113007.4084-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KQncx-_J0paeHTWbhTIVOQhdMtQeq16K
X-Proofpoint-ORIG-GUID: KQncx-_J0paeHTWbhTIVOQhdMtQeq16K
X-Proofpoint-Spam-Reason: safe

Current method to set Channel Index when the system is missing _DSD
assumes that the channels alternate, which is not guaranteed.
Instead use the same methodology as the main driver does when _DSD
exists.

Fixes: 8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 35277ce890a4..87edf0d2fbb0 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -203,6 +203,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 	struct spi_device *spi;
 	bool dsd_found;
 	int ret;
+	int i;
 
 	for (cfg = cs35l41_config_table; cfg->ssid; cfg++) {
 		if (!strcasecmp(cfg->ssid, cs35l41->acpi_subsystem_id))
@@ -288,16 +289,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 			cs35l41->index = id == 0x40 ? 0 : 1;
 	}
 
-	if (cfg->num_amps == 3)
-		/* 3 amps means a center channel, so no duplicate channels */
-		cs35l41->channel_index = 0;
-	else
-		/*
-		 * if 4 amps, there are duplicate channels, so they need different indexes
-		 * if 2 amps, no duplicate channels, channel_index would be 0
-		 */
-		cs35l41->channel_index = cs35l41->index / 2;
-
 	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
 						     cs35l41->index, GPIOD_OUT_LOW,
 						     "cs35l41-reset");
@@ -305,6 +296,11 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 
 	hw_cfg->spk_pos = cfg->channel[cs35l41->index];
 
+	cs35l41->channel_index = 0;
+	for (i = 0; i < cs35l41->index; i++)
+		if (cfg->channel[i] == hw_cfg->spk_pos)
+			cs35l41->channel_index++;
+
 	if (cfg->boost_type == INTERNAL) {
 		hw_cfg->bst_type = CS35L41_INT_BOOST;
 		hw_cfg->bst_ind = cfg->boost_ind_nanohenry;
-- 
2.34.1


