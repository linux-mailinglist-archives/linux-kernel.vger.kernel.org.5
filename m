Return-Path: <linux-kernel+bounces-88656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479CC86E4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD02A1F23850
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA77172F;
	Fri,  1 Mar 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qnd5SErE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08570ACB;
	Fri,  1 Mar 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308962; cv=none; b=E3Pl3p3ttq50tpzU7ROcS0qQGLhERHRTFbdcmpBi5CIW/RR7Kh3GZ8cOzmo0uq4xCyX9ieAytvvUUev+8Y6Ja4M7HJB+z3Y3s5Ig570/0M5LAggyzHk/nkJt4mUNl8faT33bOGJsfoyMItVcuhrxLSE9RNluvYw3FTFWa7OdnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308962; c=relaxed/simple;
	bh=+4VNy0TOtFIyKSFFXCMTWjkpBmVv68Q+Pn3KnKddvuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNI8Ac3M8XtH2zFRxlJO47XYbHMVMVwDj22L4eDuocyEibt4on/cEKXbJHAuosWXcq8xDrGYG+pSDsqb2tETM0OiirKOfr+9CgXCqKCEg2e+kU3RD+uWaTJHXlYaFIgxTs0Y02K4sU57Uy7vhqbjclDPgoIB5uHP2eRb+7GS/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qnd5SErE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 421Ewl9M003471;
	Fri, 1 Mar 2024 10:02:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=XyNIpKTLAge1DZ1X01S3EuqQI4WXcmS7YFnVAjWSw0Q=; b=
	qnd5SErE+4U3+LyRYyCLaRRzPLiKlbLdpyU51jj9KSvk+DexLxMYjsK1t1ITwaSw
	7EQNGMhcy4h9xAMbBWXCuG3IW0W4mGTF+T1YmOeurbIoxA1YCP7OMojOVIzAQ+q8
	z/PYd0zF/dX0hZUudkhjRMboZVL6eQOVyzDyTe9dZ9YGlCr3aQMwnuQHby4uods7
	6TbJwsTepOyJ4v1YGxm3G9aceP1BkSiDF30PrgIk6ejSoCjm2lEtwwbmM7kDCwMW
	ldosw2umfK8bEIkmwqnA6UrcnazFISPHKMjP6A2nZeNXXWWl0mZvmaOpQt01ZaIG
	UsQ97ngb/44hoUcozj8NOA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wkh8r02na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 10:02:14 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Mar
 2024 16:02:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 1 Mar 2024 16:02:11 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.61.65.72])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 00DAD82024C;
	Fri,  1 Mar 2024 16:02:10 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/3] ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P
Date: Fri, 1 Mar 2024 16:01:52 +0000
Message-ID: <20240301160154.158398-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301160154.158398-1-sbinding@opensource.cirrus.com>
References: <20240301160154.158398-1-sbinding@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: U-0f3Mt3eJ7MKblN5vv-rmt5w1FUf25Q
X-Proofpoint-GUID: U-0f3Mt3eJ7MKblN5vv-rmt5w1FUf25Q
X-Proofpoint-Spam-Reason: safe

Adds sound support for 2 Lenovo Thinkbook 16P laptops using CS35L41
HDA with External Boost.

SSIDs:
- 17AA38A9
- 17AA38AB

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218437

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index b1a5c0ec2b55..38a19752cb6c 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -108,6 +108,8 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
+	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
+	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38B4", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B5", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA38B6", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -493,6 +495,8 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
+	{ "CSC3551", "17AA38A9", generic_dsd_config },
+	{ "CSC3551", "17AA38AB", generic_dsd_config },
 	{ "CSC3551", "17AA38B4", generic_dsd_config },
 	{ "CSC3551", "17AA38B5", generic_dsd_config },
 	{ "CSC3551", "17AA38B6", generic_dsd_config },
-- 
2.34.1


