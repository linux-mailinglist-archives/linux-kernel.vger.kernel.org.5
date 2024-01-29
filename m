Return-Path: <linux-kernel+bounces-43086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71E840B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70CC1C22892
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25FC158D77;
	Mon, 29 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MKOTEDfh"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78B15698A;
	Mon, 29 Jan 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545682; cv=none; b=lRWZUyme3Ey/bPTGd2GCgPtuyI0cvUV9KViq/+IeYhz076kpHRV6XVeuL5JUdd7oLmxLUwVQH34hUlWaNsHtslid6NfVjCRfDTGMImlqOQa69soGry+hheMwDgCvfhyOm8JmPv9Pn6nz79ileDavvwGxErk/gayw0oFeankDW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545682; c=relaxed/simple;
	bh=nKzg7ZUZ5PicJ3de2Xnf4E2RszVbiYMky9NH4GS1hSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3gFMAgQkNH0ipGeGiKwi9rW2BVZ5chwfM6wUJA/Yh9r/h6YryZbP8xlaLlf6GWBDA/XJVtbJuMYMsjMonpgyxHUJ4lR8D1OnIjy1cQAtJECnxhXvHRfuItLt0T38uooFi8+ui4kMZJlyzpXQhpunG3GK1BQYXQm3+BmPUSVLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MKOTEDfh; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0E006968;
	Mon, 29 Jan 2024 10:27:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=r5QH0UgHuWLq2qxamMiPxt7EwPVsMxTa0U6W9j5X34I=; b=
	MKOTEDfhY5HlWeFWvOuBXKH5HM//LtxGuJP4L3yrZaokL6JdtPXA8uFVsnnl10ZJ
	WbeR2smid4kNNrau0UU4Hz5MREAfdkQDUgCPPEvXCPxSuRtWAxQYcA5903+1zp2s
	i4TasD3mH4hwjZmTX5y8cjHvl+5TPiORlk66dBwpxQ84UFrhZRIMxzzQsvaiueTv
	M28GBiXTcfVf7MDzYWqLZ6BRJL2En1ZsnGfugL7QYiD+IxxqtOwdhZW3ocZRVyAM
	ibjtTZEOq41Gzfh24amx2EM5X1IWcFHWEw3vbVBRrH8D6fsj2BbI65EnixNNMZL0
	1hFJTvVlacxxSPHSEunZaA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:53 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:43 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C0BB8820242;
	Mon, 29 Jan 2024 16:27:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 04/18] ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
Date: Mon, 29 Jan 2024 16:27:23 +0000
Message-ID: <20240129162737.497-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: U-DzzndOOXzgNtJRrv7Bror1zWg2bbDx
X-Proofpoint-GUID: U-DzzndOOXzgNtJRrv7Bror1zWg2bbDx
X-Proofpoint-Spam-Reason: safe

cs35l56_component_remove() must call wm_adsp_power_down() and
wm_adsp2_component_remove().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 sound/soc/codecs/cs35l56.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 09944db4db30..491da77112c3 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -810,6 +810,11 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 
 	cancel_work_sync(&cs35l56->dsp_work);
 
+	if (cs35l56->dsp.cs_dsp.booted)
+		wm_adsp_power_down(&cs35l56->dsp);
+
+	wm_adsp2_component_remove(&cs35l56->dsp, component);
+
 	cs35l56->component = NULL;
 }
 
-- 
2.39.2


