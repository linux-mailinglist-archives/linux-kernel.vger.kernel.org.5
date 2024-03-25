Return-Path: <linux-kernel+bounces-116946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8288A55E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709CD1C35F42
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5153B1C5ABB;
	Mon, 25 Mar 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hAZBgus+"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715301C5AB4;
	Mon, 25 Mar 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366314; cv=none; b=CcGcfBNXZEPVSW2cuSIK7kZDf82s8ozXHylbLqfR7zbf9jd304kU7eK1WSU+z5It7k1nucWhbmwxaw625k+VJ9T38kGHezKyrh/d0JcnFMAknaObmQVsetfNSeO2L0gPc9aoXB4w6rV2v/nqRZ9Xn6n+oy7UegI3KMazZkenS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366314; c=relaxed/simple;
	bh=DtND/2TH2HecycIPvl0bQ7o+Uh9mDNNleYg4w3UFX/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7uU1IBeHCX2jW7pklwwTTiqENgMyAQzT98yz6caDnqxgvC3vdvaCRdfEc94RlCapPMFf/DviJgWF7bQZENDFhi4yG5SPht78HG1Zex/isXRm+FOBnFFa6Tw7Wfe44SH09E6WWzj5qS0k+iiRcFSxFdIJZXS1sVSOCjkSRaiAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hAZBgus+; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P4qkf5007553;
	Mon, 25 Mar 2024 06:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=s1A3sEsy8QLu47lwBUxBo7IgUoNvvzU56aJ+ojynQBQ=; b=
	hAZBgus++QqTo91R9+0lwTstUiNyOi68eSTlbEwJ7N6eDQmI5a6jJFEw/jbACMDp
	AC1UircWKayQcyELCh5g7VxvEJCdx9QrlPQdIoixJxiWcEGtsrD+/N8WexPjMto3
	55OxtVVFaHcIVW2qZvq/pMJcuQPO1cRzna7wADtGYKS1PfGks8y3eCowhGCt4S4L
	nwN47QQ1hOmYc/FXMPO/BbBnU4wMUXF3ksU5aoiZAvqg9NTXhvoGJrag4mXmRY9F
	a9+rqCKhnB0nb0MswYZWNFAq05ZTxvsPIBvs2oqFQR2vwLezO6p6d0P7Y8tLZcTM
	s7/wJgV0kMdnsb917/JhNg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:31 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 41DBA82024D;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: wm_adsp: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
Date: Mon, 25 Mar 2024 11:31:24 +0000
Message-ID: <20240325113127.112783-3-rf@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: A9SwOO9lWnUqNlKhK1VT9Lw8RetoN_Fj
X-Proofpoint-GUID: A9SwOO9lWnUqNlKhK1VT9Lw8RetoN_Fj
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Using the cs_dsp_coeff_lock_and_[read|write]_ctrl() wrappers tidies
the calling functions as it does not need to manage the DSP pwr_lock.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7d5c096e06cd..8e366902ee4e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -403,13 +403,8 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	char *p = ucontrol->value.bytes.data;
-	int ret = 0;
-
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
-	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
 
-	return ret;
+	return cs_dsp_coeff_lock_and_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
 }
 
 static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
@@ -426,13 +421,11 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 	if (!scratch)
 		return -ENOMEM;
 
-	if (copy_from_user(scratch, bytes, size)) {
+	if (copy_from_user(scratch, bytes, size))
 		ret = -EFAULT;
-	} else {
-		mutex_lock(&cs_ctl->dsp->pwr_lock);
-		ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, scratch, size);
-		mutex_unlock(&cs_ctl->dsp->pwr_lock);
-	}
+	else
+		ret = cs_dsp_coeff_lock_and_write_ctrl(cs_ctl, 0, scratch, size);
+
 	vfree(scratch);
 
 	return ret;
@@ -474,13 +467,8 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	char *p = ucontrol->value.bytes.data;
-	int ret;
 
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
-	ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
-
-	return ret;
+	return cs_dsp_coeff_lock_and_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
 }
 
 static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
-- 
2.39.2


