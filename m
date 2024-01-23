Return-Path: <linux-kernel+bounces-35889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1C839836
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2A01C273C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3693685C40;
	Tue, 23 Jan 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bvrdxdcC"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B88823A6;
	Tue, 23 Jan 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035614; cv=none; b=IbxZXhOH3Cz8EERbOEohmLkryPEEyUjA1B3JUT7L7DvkgOXG2PNWcdbvUSTt19Q2YZFodiY1pFZW4RZ3paJw5QINtEvt4zTO96tXwGl3IZCDP0slMccfyoU4naOlKFMul8/JM6SwU0GXt3tHGY2F7okfCzrZul2GnKci399Swgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035614; c=relaxed/simple;
	bh=oXdcUOHdzcJ0rZcx7lEysvWIJaq+w9yrXFR7q2lxaDM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VuYkhBHwiEuiTtmeFWnumtacN1k4ZTV03Ahh3mKf6OMa13uzG0iVGzDXB0pbLq5ioAOQbqib1enwhjahbY0D9R/X9oy/lIPkoA7JsEefKl2rBlqGtbtTkXjK/82e/PTzMXaK8S8D0UA+fgCeZAktYcnqwcpxkFLI+sucybdRfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bvrdxdcC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkYmI010741;
	Tue, 23 Jan 2024 12:46:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035594;
	bh=XeeSlUJpmCl1n+FlHrxIzPkq1fOSmy6cPo4580Aj5iQ=;
	h=From:To:CC:Subject:Date;
	b=bvrdxdcCiJXYod16gkvmswfo7VblMFdDx87z2qrQ11byV8x5YScu/SVaSCygh47+Q
	 NrSsodgXLwZIchC8pLf2qAt2zX1mE7RFMIAS+vrU3syxkruVBhefR1uMEwJuPU7+s/
	 01o+LrbYJSkqgbKdmetYu3Y1ISX0RGWQF6YXNBt8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkYfs009810
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:34 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:34 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1q063265;
	Tue, 23 Jan 2024 12:46:33 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/9] remoteproc: imx_dsp_rproc: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:24 -0600
Message-ID: <20240123184632.725054-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed allocation function. This helps prevent
mistakes like freeing out of order in cleanup functions and forgetting to
free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index a1c62d15f16c6..56a799cb8b363 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -1104,8 +1104,8 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rproc = rproc_alloc(dev, "imx-dsp-rproc", &imx_dsp_rproc_ops, fw_name,
-			    sizeof(*priv));
+	rproc = devm_rproc_alloc(dev, "imx-dsp-rproc", &imx_dsp_rproc_ops,
+				 fw_name, sizeof(*priv));
 	if (!rproc)
 		return -ENOMEM;
 
@@ -1125,14 +1125,14 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	ret = imx_dsp_rproc_detect_mode(priv);
 	if (ret) {
 		dev_err(dev, "failed on imx_dsp_rproc_detect_mode\n");
-		goto err_put_rproc;
+		return ret;
 	}
 
 	/* There are multiple power domains required by DSP on some platform */
 	ret = imx_dsp_attach_pm_domains(priv);
 	if (ret) {
 		dev_err(dev, "failed on imx_dsp_attach_pm_domains\n");
-		goto err_put_rproc;
+		return ret;
 	}
 	/* Get clocks */
 	ret = imx_dsp_rproc_clk_get(priv);
@@ -1155,8 +1155,6 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 
 err_detach_domains:
 	imx_dsp_detach_pm_domains(priv);
-err_put_rproc:
-	rproc_free(rproc);
 
 	return ret;
 }
@@ -1169,7 +1167,6 @@ static void imx_dsp_rproc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	rproc_del(rproc);
 	imx_dsp_detach_pm_domains(priv);
-	rproc_free(rproc);
 }
 
 /* pm runtime functions */
-- 
2.39.2


