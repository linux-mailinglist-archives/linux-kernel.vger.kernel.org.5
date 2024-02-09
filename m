Return-Path: <linux-kernel+bounces-59495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1284F7F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A16287489
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C836D1A0;
	Fri,  9 Feb 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fNTJr+CM"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0D3F9C0;
	Fri,  9 Feb 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490637; cv=none; b=jfFuNag311+Re6LWPLKZeU8Egcq1L//jz/MTwxSa7SXCRf9Wu9xgvP0GL48lfNl7q1dTCt1uN3JAwtTnkTef2BycLLKU0waomNQNPk7HbVNwp8cLuFEBASFI1WRMafcgKHSGibSOgj0/id483eXAeEb07x3i3mUwWhuuRQ111i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490637; c=relaxed/simple;
	bh=wO38Yt4tXTY92INv32gdo8g+xlsn6zHVAdq7e+Xxp0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tEl6+nMrDMZWCTTtAj1AiVBjJqynKMfmzs60hLATF8OAl8Egeuzkmj9nmlC5Mb3NW7npmjt0I3c+9oEreIsIKwnPLZzkDUWruMPEQ3nl9ZpRtNflgPmW5RJzBfMPnvAea3JDWu5YFXFMt3Necp9K/8bsGeREl4UjXJXpue3Xqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fNTJr+CM; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4199AB9n000674;
	Fri, 9 Feb 2024 08:57:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=/
	8ZkQK18xlzwxeIuyhUWjvqXdyTGQv17yphhR0arZB8=; b=fNTJr+CM+26yf+JQe
	+aWvSfE1KDRgDGk2eCawIV32aAFw8m4+BLqVKaLSl2tr1f/N7NCKC0mSzyU4tjiD
	MHaWTM+dvnpUquN4BFLny+ZHUPeDoF7wnH9eBBP+FY/GdGesix7JshmRGYyq+jO6
	F6YB4Gu1rDxJkKrT3xHxu1Bpg4gegEk42DYkUCwJTI03KQR+e+VmFHco/R1PdhqP
	QjkC6Tbd0t1Q7OpDoi5VAoIJlt6QpLZ9An5Qaq9mE+lLMpVfdya13wjK22UIVZLv
	w7C9hdzJqu+uuVtNzEYdVSGdjoWquhh9ovgk5VzlRz+C6KIRpE948x5ZrxzMxDLS
	kjiqg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks2g1sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 08:57:02 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 14:57:00 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 9 Feb 2024 14:57:00 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3AB74820243;
	Fri,  9 Feb 2024 14:57:00 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Remove default from IRQ1_CFG register
Date: Fri, 9 Feb 2024 14:57:00 +0000
Message-ID: <20240209145700.1555950-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Ra__ikqGi0ZyXfYsS1F3WyRJeJ8lXdt2
X-Proofpoint-ORIG-GUID: Ra__ikqGi0ZyXfYsS1F3WyRJeJ8lXdt2
X-Proofpoint-Spam-Reason: safe

The driver never uses the IRQ1_CFG register so there's no need to provide
a default value. It's set as a readable register only for debugging
through the regmap registers file.

A system-specific firmware could overwrite this register with a non-default
value. Therefore the driver can't hardcode what the initial value actually
is. As the register is only for debugging the value can be left unknown
until someone wants to read it through debugfs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-shared.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index 02fba4bc0a14..995d979b6d87 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -51,7 +51,6 @@ static const struct reg_default cs35l56_reg_defaults[] = {
 	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
 	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
 	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
-	{ CS35L56_IRQ1_CFG,			0x00000000 },
 	{ CS35L56_IRQ1_MASK_1,			0x83ffffff },
 	{ CS35L56_IRQ1_MASK_2,			0xffff7fff },
 	{ CS35L56_IRQ1_MASK_4,			0xe0ffffff },
-- 
2.30.2


