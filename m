Return-Path: <linux-kernel+bounces-117259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808B88A950
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F001C63F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED71494DB;
	Mon, 25 Mar 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NQWMKPA+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A6148FFE;
	Mon, 25 Mar 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376988; cv=none; b=TgVeTARt2TRCkEr/MjzcTfgi+iXESbOyAyYAPut4SmGZZQXwnl7xEj3+Swomx+1CdHXu94jjWqX3hKPLDXlpeyf4zKBccPU1G8DNEXOTk5qZJkgmqfR0CEzHONXexUAg+nB87JYgis04ogvv94IBe/+93X3USPenBMJjx/FQUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376988; c=relaxed/simple;
	bh=3/aO5OuorLl8UcRWmY0nPxQX+riWkFHW9LJcFrhK7kM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPxp1J328oMR/QgrmKVCvupM5RiO008NlIEOaBF5xgwIx4ONOkqu8WOduMPJ/m0adEj+MGJsBPVTlTRGeMZQJeKfij0MlhufK7sTRgp60f1D56ud/I+XmLvOwWVTyy4axff6tosMmpVYl8Pe2uLxHg5tVw0TKNwl5x9UarXAyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NQWMKPA+; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P7Rwds032111;
	Mon, 25 Mar 2024 09:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=i
	U76he4wuuKu7dLL8rq067nWSEgF6XzN74dcE1qsi3A=; b=NQWMKPA+RgfKWOSta
	6uadNyMBZwf6Qe3LyFQ2oNgl9h0rzCgAdmUVuwKDlgUDEDEV1+YD+Gq46nopihkP
	B03zu4c/9JavRcXzTVO0EbOZWXkjIVnoXKKLja/ZZaANLhDgB/PARL9TSZruVF9D
	ompvSlJhTZlAFakVeDZ3E1Gr0+kNgZPLrCaeoJtnFojbSOyHxCNphbdFWE3eAiYB
	i6M/1GaKuuxtEIRV9QvSQdDAynSoqnfNXNLyE0Y6SUeKEH88kWC3qijed06xTQB9
	4GLYTSYTZMc8jEemjV4Z9617TJ0CTT+iMBkdYE3pAtHoMH2tS5XI7ZGpqvl+8nR0
	x2v5w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x1ugm3hym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 09:29:40 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 14:29:38 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 25 Mar 2024 14:29:38 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 06853820244;
	Mon, 25 Mar 2024 14:29:38 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Raise device name message log level
Date: Mon, 25 Mar 2024 14:29:37 +0000
Message-ID: <20240325142937.257869-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -l-o5qGsO2wpx8pyk7r5-ks3XXWjmyvJ
X-Proofpoint-GUID: -l-o5qGsO2wpx8pyk7r5-ks3XXWjmyvJ
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

The system and amplifier names influence which firmware and tuning files
are downloaded to the device; log these values to aid end-user system
support.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 41974b3897a7..f3c5715f5e02 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -1024,8 +1024,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 		goto err;
 	}
 
-	dev_dbg(cs35l56->base.dev, "DSP system name: '%s', amp name: '%s'\n",
-		cs35l56->system_name, cs35l56->amp_name);
+	dev_info(cs35l56->base.dev, "DSP system name: '%s', amp name: '%s'\n",
+		 cs35l56->system_name, cs35l56->amp_name);
 
 	regmap_multi_reg_write(cs35l56->base.regmap, cs35l56_hda_dai_config,
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
-- 
2.39.2


