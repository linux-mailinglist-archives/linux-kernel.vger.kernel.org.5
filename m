Return-Path: <linux-kernel+bounces-74961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D511685E07B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA081F24705
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E680BEB;
	Wed, 21 Feb 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="D6E2nmUs"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742880023;
	Wed, 21 Feb 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527928; cv=none; b=iGRk2FyFeRw4RU9iCPA3gbFjnOwDXidIoudjdbw7l7QTGJJ81MIWHbJOe2PQoXqQhaU9TJ3AEN6y4ctAlNeFTeQAAYuY1G1HwwKfDFt0WxDMBHKOZSs4pg74rqKUggSGpeMRZgKSW/Sf1E5aUULgxE+Z7CrrCSo73puSAMn01Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527928; c=relaxed/simple;
	bh=uf6vpbcIoUtdbhnJ3basXbSQ/u2ojbk1oT1gnr/GaPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbmp2RCUU6XvxtwVmbkU4pqxVlxUfnSivfEsSkJZ3g+zN4a99VJHf50S+wcDin1bz6FlDsXrEe4nZUCYdz5NsPtyTSArrg/sbgZq2YDGGj7x/B4gHEfmoaRLQy+QSyy6U33txJRaJvZWweHUOU8E+iyZLkAMZRvmMStqNgomasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=D6E2nmUs; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L72AP2020807;
	Wed, 21 Feb 2024 09:05:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=jxurZ9g8byiCpiiilA/KSypC/QlK/0d0/qRchJfkX/o=; b=
	D6E2nmUsC1Dv7F3EMC4iI4D9UrsdLWIVk7rDEd4DH1psPQmOnSFmgjzW0ijNNxqH
	47VzgMsIlooEwFJcGUimPMxbI46E+p/DDUvv/LWAabsc6IlnTzDcpeMR2HyI4aWt
	k7Oj9uFHBezZuVP+ID6WW2Ndve4MYak047jaMXWiK5seBVrydSCYjfYICtKMl92z
	Jb/mL/TayVb1dT9zhjKsXJhrZ3I1p9TcxVU487p3ao7nyQhuAasQItWFZIfocNmj
	SfDghvp3cJeRTDBdgkhGg58XSTiMYGlTHyR/orReDxz+51LtX/wDDqSIuRRxeOm9
	fO8nc7r0HC6zydFWhUbBKA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wd207h58t-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 09:05:12 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:05:07 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 21 Feb 2024 15:05:07 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 48CA8820259;
	Wed, 21 Feb 2024 15:05:07 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 7/9] ALSA: hda: hda_cs_dsp_ctl: Add helper function to write calibration
Date: Wed, 21 Feb 2024 15:05:05 +0000
Message-ID: <20240221150507.1039979-8-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: w0IK1iOTQqvTEzp0K88FP1p3gONu8Es5
X-Proofpoint-ORIG-GUID: w0IK1iOTQqvTEzp0K88FP1p3gONu8Es5
X-Proofpoint-Spam-Reason: safe

Add hda_cs_dsp_write_cal_coeffs(), a helper function to write amp
calibration data to firmware controls.

The calibration data is passed in a struct cirrus_amp_cal_data and
a definition of the firmware algorithm controls in a struct
cirrus_amp_cal_controls.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 47 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h |  4 +++
 2 files changed, 51 insertions(+)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 0f5fdd44721c..bdc21a117dd2 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -10,6 +10,7 @@
 #include <sound/soc.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
+#include <sound/cs-amp-lib.h>
 #include "hda_cs_dsp_ctl.h"
 
 #define ADSP_MAX_STD_CTRL_SIZE               512
@@ -247,6 +248,52 @@ int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_read_ctl, SND_HDA_CS_DSP_CONTROLS);
 
+static int hda_cs_dsp_write_cal_coeff(struct cs_dsp *cs_dsp,
+				      const struct cirrus_amp_cal_controls *controls,
+				      const char *ctl_name, unsigned int val)
+{
+	__be32 beval = cpu_to_be32(val);
+	int ret;
+
+	ret = hda_cs_dsp_write_ctl(cs_dsp, ctl_name, controls->mem_region,
+				   controls->alg_id, &beval, 4);
+	if (ret) {
+		dev_err(cs_dsp->dev, "Failed to write control %s: %d\n", ctl_name, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int hda_cs_dsp_write_cal_coeffs(struct cs_dsp *cs_dsp,
+				const struct cirrus_amp_cal_controls *controls,
+				const struct cirrus_amp_cal_data *data)
+{
+	int ret;
+
+	dev_dbg(cs_dsp->dev, "Calibration: Ambient=%#x, Status=%#x, R0=%d\n",
+		data->calAmbient, data->calStatus, data->calR);
+
+	ret = hda_cs_dsp_write_cal_coeff(cs_dsp, controls, controls->ambient, data->calAmbient);
+	if (ret)
+		return ret;
+
+	ret = hda_cs_dsp_write_cal_coeff(cs_dsp, controls, controls->calr, data->calR);
+	if (ret)
+		return ret;
+
+	ret = hda_cs_dsp_write_cal_coeff(cs_dsp, controls, controls->status, data->calStatus);
+	if (ret)
+		return ret;
+
+	ret = hda_cs_dsp_write_cal_coeff(cs_dsp, controls, controls->checksum, data->calR + 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_write_cal_coeffs, SND_HDA_CS_DSP_CONTROLS);
+
 MODULE_DESCRIPTION("CS_DSP ALSA Control HDA Library");
 MODULE_AUTHOR("Stefan Binding, <sbinding@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
index 2cf93359c4f2..329531672005 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.h
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -10,6 +10,7 @@
 #ifndef __HDA_CS_DSP_CTL_H__
 #define __HDA_CS_DSP_CTL_H__
 
+#include <sound/cs-amp-lib.h>
 #include <sound/soc.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 
@@ -35,5 +36,8 @@ int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 			 unsigned int alg, const void *buf, size_t len);
 int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
 			unsigned int alg, void *buf, size_t len);
+int hda_cs_dsp_write_cal_coeffs(struct cs_dsp *cs_dsp,
+				const struct cirrus_amp_cal_controls *controls,
+				const struct cirrus_amp_cal_data *data);
 
 #endif /*__HDA_CS_DSP_CTL_H__*/
-- 
2.30.2


