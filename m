Return-Path: <linux-kernel+bounces-35891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A3839841
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBD41F240AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B3886151;
	Tue, 23 Jan 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dDi5lJPJ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3D82D93;
	Tue, 23 Jan 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035616; cv=none; b=sRh4jbaOw58FfCfmNDomWQeNGNNuJcMfvkEYjRrr9QUyB+/xLwZvvIl0K/uVBafOLpG7gYfalibA/OWDZMZz2g7TiY3Q3eYcRpRFZ9VX3bTdo3uwfmNh+YWwBtCAT99xaDPgwPMPsKOPEKExz66IsNHOYHvU+HHh9u12bjSt3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035616; c=relaxed/simple;
	bh=fLD5+1z+W/9umcUb6h/CH5SKNvaOjwFSSgWfwPrr7OY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN+aeVmDbVstG89fWbXrbqdRfFhqNBIzM0nEti9E3grzizJ3NO3D7nLSNqjXJN4W51LvBumUQuNVbDrTUk+FJxrlCMEsjQpFTDAdJQgvLLNzLawdfXG61WE+V+2jAiCFiTzyeZ8aL5hcyc6AGd0LfuCpsDPob2LRK3MFHKdxPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dDi5lJPJ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkb9b111736;
	Tue, 23 Jan 2024 12:46:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035597;
	bh=BP/PRDIVYJM/q1G3Lcl5tWsMpNMMIMrAuU+gEUZbLbU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dDi5lJPJJovZzwz5dwXvhoPAf5d+mbTsbkgzxPRlV6K0fs4Obgd5IZWkimTSzc59s
	 Mse6tbPUJXHV6kl7mQMIhvYHqbwjt15iWqbfLM7Chq6Qbjs7eKTslBE7y7KhYYHEkN
	 6z/JzMBwmo0iswXAc6w9Bd/+QYQRKg/fcWvMxGys=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkbv3009854
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:37 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:37 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1v063265;
	Tue, 23 Jan 2024 12:46:36 -0600
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
Subject: [PATCH 6/9] remoteproc: qcom_q6v5_wcss: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:29 -0600
Message-ID: <20240123184632.725054-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123184632.725054-1-afd@ti.com>
References: <20240123184632.725054-1-afd@ti.com>
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
 drivers/remoteproc/qcom_q6v5_wcss.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index cff1fa07d1def..94f68c919ee62 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -1011,8 +1011,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
-			    desc->firmware_name, sizeof(*wcss));
+	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, desc->ops,
+				 desc->firmware_name, sizeof(*wcss));
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
 		return -ENOMEM;
@@ -1027,29 +1027,29 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 
 	ret = q6v5_wcss_init_mmio(wcss, pdev);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	ret = q6v5_alloc_memory_region(wcss);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	if (wcss->version == WCSS_QCS404) {
 		ret = q6v5_wcss_init_clock(wcss);
 		if (ret)
-			goto free_rproc;
+			return ret;
 
 		ret = q6v5_wcss_init_regulator(wcss);
 		if (ret)
-			goto free_rproc;
+			return ret;
 	}
 
 	ret = q6v5_wcss_init_reset(wcss, desc);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	qcom_add_glink_subdev(rproc, &wcss->glink_subdev, "q6wcss");
 	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
@@ -1061,16 +1061,11 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 
 	ret = rproc_add(rproc);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	platform_set_drvdata(pdev, rproc);
 
 	return 0;
-
-free_rproc:
-	rproc_free(rproc);
-
-	return ret;
 }
 
 static void q6v5_wcss_remove(struct platform_device *pdev)
@@ -1080,7 +1075,6 @@ static void q6v5_wcss_remove(struct platform_device *pdev)
 
 	qcom_q6v5_deinit(&wcss->q6v5);
 	rproc_del(rproc);
-	rproc_free(rproc);
 }
 
 static const struct wcss_data wcss_ipq8074_res_init = {
-- 
2.39.2


