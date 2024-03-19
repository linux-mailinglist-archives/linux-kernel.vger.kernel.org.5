Return-Path: <linux-kernel+bounces-107193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D18187F8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6B4282E70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997454776;
	Tue, 19 Mar 2024 08:08:01 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8C537E7;
	Tue, 19 Mar 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835681; cv=none; b=miGa5WMKm7qOJRbIxBL1qcTPzJWFc6SQ+1UY5r6UpkNaaCePn9cePC1PvZvtv8mvMMS7BYokqF6sjjcDUuUWBt3DHqww/LOwaJJMIZrv7rNYPsK8ZdfzaRJpFz4sfGMg3RLNAPpOa5s+BGOvgH4r0xNjrWSrJ8kttNW8GtMH6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835681; c=relaxed/simple;
	bh=CNk2VPYgaHZVUWLkXbMZyzxsjX0YYQCq1bBFNAfMI2M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=cHyMPLfJAWLH5G9WiKbx6m5y5AP6sndTWh3mbMXRGEVnr3Cltczk1JCyJU+fauBFzhQC5quiYzPzoehdZ/ZZBY+Y4xnAJeb0jGOwxXWEzC0eRHKZ8t+ZRXacBDj9zj4duVl09ZfY9RXrTtVPAKRUIbcUS6RuMtcSMXPmDUQJ0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5D955201E50;
	Tue, 19 Mar 2024 09:07:58 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 24E7B201364;
	Tue, 19 Mar 2024 09:07:58 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 10AD61820F76;
	Tue, 19 Mar 2024 16:07:55 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 06/16] ASoC: fsl_easrc: register m2m platform device
Date: Tue, 19 Mar 2024 15:51:04 +0800
Message-Id: <1710834674-3285-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Register m2m platform device,that user can
use M2M feature.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_easrc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index cf7ad30a323b..ccbf45c7abf4 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -2075,6 +2075,7 @@ MODULE_DEVICE_TABLE(of, fsl_easrc_dt_ids);
 static int fsl_easrc_probe(struct platform_device *pdev)
 {
 	struct fsl_easrc_priv *easrc_priv;
+	struct fsl_asrc_m2m_pdata m2m_pdata;
 	struct device *dev = &pdev->dev;
 	struct fsl_asrc *easrc;
 	struct resource *res;
@@ -2190,6 +2191,19 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	m2m_pdata.asrc = easrc;
+	m2m_pdata.fmt_in = FSL_EASRC_FORMATS;
+	m2m_pdata.fmt_out = FSL_EASRC_FORMATS | SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE;
+	m2m_pdata.rate_min = 8000;
+	m2m_pdata.rate_max = 768000;
+	m2m_pdata.chan_min = 1;
+	m2m_pdata.chan_max = 32;
+	easrc->m2m_pdev = platform_device_register_data(&pdev->dev,
+							M2M_DRV_NAME,
+							PLATFORM_DEVID_AUTO,
+							&m2m_pdata,
+							sizeof(m2m_pdata));
+
 	return 0;
 
 err_pm_disable:
@@ -2199,6 +2213,11 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 
 static void fsl_easrc_remove(struct platform_device *pdev)
 {
+	struct fsl_asrc *easrc = dev_get_drvdata(&pdev->dev);
+
+	if (easrc->m2m_pdev && !IS_ERR(easrc->m2m_pdev))
+		platform_device_unregister(easrc->m2m_pdev);
+
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.34.1


