Return-Path: <linux-kernel+bounces-138919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64F689FC00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476A11F22133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1B174EDD;
	Wed, 10 Apr 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RfbOIHQ9"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435A616F0FB;
	Wed, 10 Apr 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764373; cv=none; b=oZzyr4AcsseqScTPoS3Ip2BtsSW6T4tfdIj1ZEn7iBT7vBMM7JZ9/MmSMGGmsCS+Y9ZCpjDxoXuTseIswNpaBwFf4ECx8gjVN9G/0qFMWhK+uVmGdrKn8Xw9vXuO9+BHDzLPvy4m+CxUdtpMZpJ0pOgLaVw8wlV3gEKCgVKOaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764373; c=relaxed/simple;
	bh=XyTyh+E1UlS4JdlwwhhbntVL91jfQIUuQ1Mtn/NrsdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkxvJ+Gib5o9Z372pBSiDiF24vSX9jOROoJxlm9np1ItC9pfcvda48Nq2T6Gk0Npb3QpIMhISLEqD28NbHDtlzB+iCVF+IzNspGBWbNQxDavF5qn+ZKEbidmZCVG+7uq5uLnWH3GEQswgPBA/ZWdl0fL+oWhPBVUvXeyR9JpSho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RfbOIHQ9; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A5ji57028164;
	Wed, 10 Apr 2024 10:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=PF4nkE9+JPkNNlQSTlgjGViKbcCsRBPb9MnofVi+A34=; b=
	RfbOIHQ9t9I4/HRtbfm258v6xP5BSw9x/mN1euTvpvRp2R7Kuc2pSO3MKdUFTRV0
	Q0ope85W27isJp9RUkFgBNaGdtoS5dFfzqk8XDpxJCqfxYHqt/ZeboQ00u8K4ncD
	l7+Wyjeac4bkhW3mLafpDk+k6QT1nB/ELR1y4ZKeUVIr0zi8HAni4/neuMA/Lxq3
	msciOwEraXKm+yHBMyGkbLHUrP7QEGI87pf0xlMMXcsk4WD8/cDyc/mxVtb1KX1Z
	4FSmHOyl+Z1wDvMO7ombSGxXoxll+M6AeF5AJQh+bqawmlKArpWhkdGyRYLtl3k8
	hVaiPbOxBCIhLwvPb41ZkQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxn6f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:52:40 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 16:52:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Wed, 10 Apr 2024 16:52:25 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (SHANCC79D24.ad.cirrus.com [198.61.64.86])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A46E682024A;
	Wed, 10 Apr 2024 15:52:25 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/7] ALSA: hda: cs35l41: Support HP Omen models without _DSD
Date: Wed, 10 Apr 2024 16:52:18 +0100
Message-ID: <20240410155223.7164-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410155223.7164-1-sbinding@opensource.cirrus.com>
References: <20240410155223.7164-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 83EHy1dBBgvcu3P2MnOMtekqQkFaAmPL
X-Proofpoint-GUID: 83EHy1dBBgvcu3P2MnOMtekqQkFaAmPL
X-Proofpoint-Spam-Reason: safe

Add support for 2 new HP Omen models without _DSD into configuration
table.
These laptops use the PCM Gain setting for the tuning setting file.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 8fb688e41414..efa62e99d330 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -70,6 +70,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "103C8C15", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4000, 24 },
 	{ "103C8C16", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4000, 24 },
 	{ "103C8C17", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4000, 24 },
+	{ "103C8C4D", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
+	{ "103C8C4E", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8C4F", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8C50", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
 	{ "103C8C51", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4100, 24 },
@@ -457,6 +459,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "103C8C15", generic_dsd_config },
 	{ "CSC3551", "103C8C16", generic_dsd_config },
 	{ "CSC3551", "103C8C17", generic_dsd_config },
+	{ "CSC3551", "103C8C4D", generic_dsd_config },
+	{ "CSC3551", "103C8C4E", generic_dsd_config },
 	{ "CSC3551", "103C8C4F", generic_dsd_config },
 	{ "CSC3551", "103C8C50", generic_dsd_config },
 	{ "CSC3551", "103C8C51", generic_dsd_config },
-- 
2.34.1


