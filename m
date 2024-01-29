Return-Path: <linux-kernel+bounces-43088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAE840B70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D501C22993
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F88157E91;
	Mon, 29 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TtaNEI3x"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8E157056;
	Mon, 29 Jan 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545684; cv=none; b=aUFEr4rZvtzJNY8ugX+0izLya2IQxU06KxPH5qPG0GgOphJweCxKQk7YkHFss5vQmUTc3KXcC8iIKJfbV9YKYghqR48ZqiUx6h6kd/Kaefz0osdCrpSN3GvMMPKYZcOjrRWOY1lIO5nifNXOXWHBT016mWT8v1bxSbITGLsJg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545684; c=relaxed/simple;
	bh=NDcG2FLGzxLiyCK7FSbgtFUBRX79qZ/fL/1LI2KhnQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQypZSHmphenvUqsHoAl3GMQSiBozMhnQz07fnMruMsCIbiaMy0fFu/hIGd+xmmDYOQQFl+hW+tP+7/wlVbpTdPZ3wSJOQKCS3dLcNJc9AcOKCXuFAmaratdsw7DKH/GzRN7xxO9eo/GmyFLr9jQXKOShRzUx0zZmvC57XDHDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TtaNEI3x; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0G006968;
	Mon, 29 Jan 2024 10:27:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=75qdV8k43SbI4wq02+anfiwv9c1wTYCZBM6bd1fSHB0=; b=
	TtaNEI3xlsa3BoPqvWwroWNZEXF5fCuIU3/JqBvQJ2XfN9RTVD5rpkUrQLa0VE6m
	EBpfwDpWBiC5G1rnOl1WFPQwhFsIl8n22YG5Wgx/snRXJJCRr43/XBJImFQBc8k2
	E02g+8czOlipaVMFpLL7kk8RaRGvwtORtS/AGgZPIXzaSQQvRtpRH5sIh17+mRkK
	FRj8O9JKTEFpEfNrmAMF3CaDyrE6ORykowv0uWzNtCcJEvoxCgl12NJee3GC/pSG
	L3VueIKkwTJ9+dHS8Wt1Gn7cyPIu9fM1GBoaWMOrH4OhFP6QrR2TQGQ+Hy93ky5v
	DDj0qcCUVYhBxiZVR85Zsg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8n-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:54 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:45 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:45 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 37F5E820248;
	Mon, 29 Jan 2024 16:27:45 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 11/18] ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revision
Date: Mon, 29 Jan 2024 16:27:30 +0000
Message-ID: <20240129162737.497-12-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: W_TlISqmvKoxFZ50ljCZ0cQp7hYaSPzi
X-Proofpoint-GUID: W_TlISqmvKoxFZ50ljCZ0cQp7hYaSPzi
X-Proofpoint-Spam-Reason: safe

Put the silicon revision and secured flag in the wm_adsp fwf_name
string instead of including them in the part string.

This changes the format of the firmware name string from

 cs35l56[s]-rev-misc[-system_name]

to
 cs35l56-rev[-s]-misc[-system_name]

No firmware files have been published, so this doesn't cause a
compatibility break.

Silicon revision and secured flag are included in the firmware
filename to pick a firmware compatible with the part. These strings
were being added to the part string, but that is a misuse of the
string. The correct place for these is the fwf_name string, which
is specifically intended to select between multiple firmware files
for the same part.

Backport note:
This won't apply to kernels older than v6.6.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 608f1b0dbdde ("ASoC: cs35l56: Move DSP part string generation so that it is done only once")
---
 sound/soc/codecs/cs35l56.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 1b51650a19ff..8899c02c6dea 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -907,6 +907,18 @@ static void cs35l56_dsp_work(struct work_struct *work)
 
 	pm_runtime_get_sync(cs35l56->base.dev);
 
+	/* Populate fw file qualifier with the revision and security state */
+	if (!cs35l56->dsp.fwf_name) {
+		cs35l56->dsp.fwf_name = kasprintf(GFP_KERNEL, "%02x%s-dsp1",
+						  cs35l56->base.rev,
+						  cs35l56->base.secured ? "-s" : "");
+		if (!cs35l56->dsp.fwf_name)
+			goto err;
+	}
+
+	dev_dbg(cs35l56->base.dev, "DSP fwf name: '%s' system name: '%s'\n",
+		cs35l56->dsp.fwf_name, cs35l56->dsp.system_name);
+
 	/*
 	 * When the device is running in secure mode the firmware files can
 	 * only contain insecure tunings and therefore we do not need to
@@ -926,7 +938,7 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	 * on the DAPM mutex.
 	 */
 	queue_work(cs35l56->dsp_wq, &cs35l56->mux_init_work);
-
+err:
 	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
@@ -979,6 +991,9 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 
 	wm_adsp2_component_remove(&cs35l56->dsp, component);
 
+	kfree(cs35l56->dsp.fwf_name);
+	cs35l56->dsp.fwf_name = NULL;
+
 	cs35l56->component = NULL;
 }
 
@@ -1330,12 +1345,6 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	if (ret)
 		return ret;
 
-	/* Populate the DSP information with the revision and security state */
-	cs35l56->dsp.part = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL, "cs35l56%s-%02x",
-					   cs35l56->base.secured ? "s" : "", cs35l56->base.rev);
-	if (!cs35l56->dsp.part)
-		return -ENOMEM;
-
 	if (!cs35l56->base.reset_gpio) {
 		dev_dbg(cs35l56->base.dev, "No reset gpio: using soft reset\n");
 		cs35l56->soft_resetting = true;
-- 
2.39.2


