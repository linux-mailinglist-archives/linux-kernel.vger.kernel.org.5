Return-Path: <linux-kernel+bounces-35895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12683984E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E631C23BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3E86AFE;
	Tue, 23 Jan 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sH6yT3O8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8682D94;
	Tue, 23 Jan 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035617; cv=none; b=KFqAWinCtC8UAvYykEYGXEbIkfom0ryaDsABkdYguIoGpj4JrHr6xXLetcsXPSfrHpVQS6lHArZu55Kf+JJjdUqeoDj39+t3tFVewwP5QO7xMhMJ/dn0BXUm4IMywIfXc5CXtzSqPFyNUEdZo4bkXKGnJMtCfsNbR8LCFcFNv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035617; c=relaxed/simple;
	bh=m/yWZtNxfkZivwoe0ZZTr4FL+nbuPIxIAAeRJ+811kE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfJEYdVOVTcuV+3amFkCEkE6DdLG071hrbOGmCtakqh9t4t3hJsfEHExheuCQupkHuswGqDyV2sIIwKfLQCAx9tdzXSL3EXY7bwPyZZVWezL39XJFo2KT4mkijzQot8awQGktxaUk2VPPATA0gOrLDGbZ1iijUafMSutHMUcT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sH6yT3O8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkZFm111630;
	Tue, 23 Jan 2024 12:46:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035595;
	bh=XULANMiamCh2z47DetgW0gGkmV23v5Hxx2b4xb/xhAE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sH6yT3O8jIYfaltHigwZlf2pGTWjqa0M/TADp31nZojUJ8AHg0RYvRuV4h484pH0F
	 8IHgAMwAqAsjHNauHb25/HAIGBIMsIAHDtaD3Y93n/8xTHTdDBwg2kS0XfHAB9cg7B
	 L2FX2b53D45Yze2B1bzkU3gXuBicFgVxuJgOJuZw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkZnL011008
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:35 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1r063265;
	Tue, 23 Jan 2024 12:46:34 -0600
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
Subject: [PATCH 2/9] remoteproc: imx_rproc: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:25 -0600
Message-ID: <20240123184632.725054-2-afd@ti.com>
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
 drivers/remoteproc/imx_rproc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 8bb293b9f327c..55ecce3ab5f75 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1104,16 +1104,14 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	int ret;
 
 	/* set some other name then imx */
-	rproc = rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
-			    NULL, sizeof(*priv));
+	rproc = devm_rproc_alloc(dev, "imx-rproc", &imx_rproc_ops,
+				 NULL, sizeof(*priv));
 	if (!rproc)
 		return -ENOMEM;
 
 	dcfg = of_device_get_match_data(dev);
-	if (!dcfg) {
-		ret = -EINVAL;
-		goto err_put_rproc;
-	}
+	if (!dcfg)
+		return -EINVAL;
 
 	priv = rproc->priv;
 	priv->rproc = rproc;
@@ -1124,8 +1122,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	priv->workqueue = create_workqueue(dev_name(dev));
 	if (!priv->workqueue) {
 		dev_err(dev, "cannot create workqueue\n");
-		ret = -ENOMEM;
-		goto err_put_rproc;
+		return -ENOMEM;
 	}
 
 	ret = imx_rproc_xtr_mbox_init(rproc);
@@ -1167,8 +1164,6 @@ static int imx_rproc_probe(struct platform_device *pdev)
 	imx_rproc_free_mbox(rproc);
 err_put_wkq:
 	destroy_workqueue(priv->workqueue);
-err_put_rproc:
-	rproc_free(rproc);
 
 	return ret;
 }
@@ -1183,7 +1178,6 @@ static void imx_rproc_remove(struct platform_device *pdev)
 	imx_rproc_put_scu(rproc);
 	imx_rproc_free_mbox(rproc);
 	destroy_workqueue(priv->workqueue);
-	rproc_free(rproc);
 }
 
 static const struct of_device_id imx_rproc_of_match[] = {
-- 
2.39.2


