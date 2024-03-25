Return-Path: <linux-kernel+bounces-116945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A747188A567
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A152E5A49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1FD16AFCD;
	Mon, 25 Mar 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="NashjA8/"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D31C5AA9;
	Mon, 25 Mar 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366313; cv=none; b=Sw0A3QFJAMAA4DEzUsRFAJmKswAqy7cemx14qF/b4RT8Y+9V6PwrV//DhlMqmZ6pVW8GPf15ZiuSzdak4DxNVdzNiu0vyKTZ5qG/o17F2NCTuyGDhwOAvWVYCQt/s74NZ2xOw+Fuw0gMVRiAtQmtRwYNTmez7Si+Ji3zSGmFx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366313; c=relaxed/simple;
	bh=zmwpU7zhfw8O1UTOk5P7IsqdbKBMPEewor0lPLRRAe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u49pRHIMyUwnr4pS2pb1Kml1DoXfaITmzKQAi2qJuqEch7I0HYtqgJrbjBNnFog0EZmhKxbb6NpJDwpRm5qp+JSRB3UXFavSv41VHTgZrs9m0DiNhAd0Xb+Qjm6qcNL23yitcBb+orqwSe8ckbsr4vI8oil8YAKZ1JfngxqYhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=NashjA8/; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P4qkf6007553;
	Mon, 25 Mar 2024 06:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=siE7HV2Pcf2Dad5MeeLwU/Yn1sAi4q9OlYqKhgzd2rk=; b=
	NashjA8/Q6yMq0d0V5XiRUMLbsmsBR+X5iYlJsguj8r7kCVgGQedcEb1s+eBTQZ4
	eKrkPRVJNmRy6L3ucPqBf03oj+pbguD4A+14zCAYLoWX7G+RHnlqGVAfplOHLWcA
	Zmh8oFgA5/bMnYXvfTQubNFV8KKGQU25I5pGd2PULacF9zJ4U9AF7V7Cpz8CID0Y
	c7dFUvH3DOck9t0LkrfHTBbTS74q80zOcvdURlhywP0wDbLPCNjy6HFV6kCr8l40
	e8BZkAtxavmFfcdPMHCEUB9x1C5NxUaxoLbSlc9AumuwAz5BQfmqROgLaT1qkcxQ
	QnypmRPWiTKliVUCE/Xk4w==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5553E820259;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 5/5] ALSA: hda: hda_cs_dsp_ctl: Remove notification of driver write
Date: Mon, 25 Mar 2024 11:31:27 +0000
Message-ID: <20240325113127.112783-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F0iH18PgYYJ0Qf-2-ARpnSRL4tt02OfD
X-Proofpoint-GUID: F0iH18PgYYJ0Qf-2-ARpnSRL4tt02OfD
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Any control that the driver is updating should be marked as SYSTEM and
therefore will not have an ALSA control to notify.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 725544d81941..7f2d35cf245b 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -201,7 +201,6 @@ int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 			 unsigned int alg, const void *buf, size_t len)
 {
 	struct cs_dsp_coeff_ctl *cs_ctl;
-	struct hda_cs_dsp_coeff_ctl *ctl;
 	int ret;
 
 	mutex_lock(&dsp->pwr_lock);
@@ -211,13 +210,6 @@ int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 	if (ret < 0)
 		return ret;
 
-	if (ret == 0 || (cs_ctl->flags & WMFW_CTL_FLAG_SYS))
-		return 0;
-
-	ctl = cs_ctl->priv;
-
-	snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &ctl->kctl->id);
-
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_write_ctl, SND_HDA_CS_DSP_CONTROLS);
-- 
2.39.2


