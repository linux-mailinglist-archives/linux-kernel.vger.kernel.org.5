Return-Path: <linux-kernel+bounces-78622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51A6861604
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82159283CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B682D77;
	Fri, 23 Feb 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="R4ITCF05"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92C823C5;
	Fri, 23 Feb 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702774; cv=none; b=JncEex3Oy3Vp2CxWXJi7JQ4fgNC/sqG8j4bd5DSzhyrr41QhGM3XKu1lOpFkuR6kSOBxsBLpkzIQci2/CzlIHOKkbgfA+ZC8+hAxPaogg4tutoYhxJDc99ey1IqEjfff+qdr+lpk2qx5LjbvalpEi8Em1tDg8Lv2WswqLLNojm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702774; c=relaxed/simple;
	bh=OKdQJCFhAqqpbWVPBGX0dPyvOIVA2y3RPVYZ2iQ4DF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3dpoOwop3H34T6seW8ICrBWUkGmtgDVaYFSnDe+0D8nI0cYI6xwb/p0o5UXXO9C4XEc03QPfp5cAalU9+4CC0/ZZz1+Gvti9NHSnjsmH6VgmjH507k58EXMVbLgDj5ko0orBQBfweJxHlal1VwTVmTUpk1fbdrt2fuXT1H5afQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=R4ITCF05; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8gUBT005505;
	Fri, 23 Feb 2024 09:39:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=LAKmFjKtKhPNxrQSxKAdVi250lMdkTuizyIqCUftZ3M=; b=
	R4ITCF05QtPO7pRl+w9TMFyOjNN+svra9CtJZWMMpKdInp4+k4MkAyRHAOm9gRRl
	lkck96bIEp36BU0NJccCZLxqcQKN/1bJzB45D2aqNCqLiP56p62WkN5sMnFl3O2C
	/vR3LpkJXllZIC3I9EGev5ieE0su/2Fv01xHf4m1v4VkLlf8sqgvKCCg860lsFOP
	0NVewGGRugd5J+5o46TxhkuT8nvel/WNzp6T9xkLU/DwRhG7KwKqOQo+3Y4mrqOe
	2duUkjjn0331uH7ELkUXjX9upzOud964X5PqQDrxcVE/XLvhwvxlbgbncfEJU6mR
	6DSbSsT9w4TGJY+3mUayMQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205m5pe-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 09:39:13 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 15:39:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 23 Feb 2024 15:39:10 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6799D82024B;
	Fri, 23 Feb 2024 15:39:10 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/6] ASoC: wm_adsp: Add wm_adsp_start() and wm_adsp_stop()
Date: Fri, 23 Feb 2024 15:39:05 +0000
Message-ID: <20240223153910.2063698-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223153910.2063698-1-rf@opensource.cirrus.com>
References: <20240223153910.2063698-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nUbU09Aytq7CW1IUBSvrxt0qntPr0FIe
X-Proofpoint-GUID: nUbU09Aytq7CW1IUBSvrxt0qntPr0FIe
X-Proofpoint-Spam-Reason: safe

Separate the functionality of wm_adsp_event() into two exported
functions wm_adsp_start() and wm_adsp_stop().

This allows the codec driver to start and stop the DSP outside of a
DAPM widget.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 27 ++++++++++++++++++---------
 sound/soc/codecs/wm_adsp.h |  2 ++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 36ea0dcdc7ab..e451c009f2d9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1092,27 +1092,36 @@ static void wm_adsp_event_post_stop(struct cs_dsp *cs_dsp)
 	dsp->fatal_error = false;
 }
 
+int wm_adsp_run(struct wm_adsp *dsp)
+{
+	flush_work(&dsp->boot_work);
+
+	return cs_dsp_run(&dsp->cs_dsp);
+}
+EXPORT_SYMBOL_GPL(wm_adsp_run);
+
+void wm_adsp_stop(struct wm_adsp *dsp)
+{
+	cs_dsp_stop(&dsp->cs_dsp);
+}
+EXPORT_SYMBOL_GPL(wm_adsp_stop);
+
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
 	struct wm_adsp *dsp = &dsps[w->shift];
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		flush_work(&dsp->boot_work);
-		ret = cs_dsp_run(&dsp->cs_dsp);
-		break;
+		return wm_adsp_run(dsp);
 	case SND_SOC_DAPM_PRE_PMD:
-		cs_dsp_stop(&dsp->cs_dsp);
-		break;
+		wm_adsp_stop(dsp);
+		return 0;
 	default:
-		break;
+		return 0;
 	}
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_event);
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 067d807a7ca8..e53dfcf1f78f 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -98,6 +98,8 @@ irqreturn_t wm_adsp2_bus_error(int irq, void *data);
 irqreturn_t wm_halo_bus_error(int irq, void *data);
 irqreturn_t wm_halo_wdt_expire(int irq, void *data);
 
+int wm_adsp_run(struct wm_adsp *dsp);
+void wm_adsp_stop(struct wm_adsp *dsp);
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event);
 
-- 
2.30.2


