Return-Path: <linux-kernel+bounces-35892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC183984B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294E928B0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E9585C51;
	Tue, 23 Jan 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M7hY4ofu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9685C42;
	Tue, 23 Jan 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035617; cv=none; b=qp1zHCPsB3Rmp8JhY0jOXltdV8kcSF+2NUa1etF5o4suhFs7iZIu1xmWdsvOJTGiKJ4nQVjpQuNn1nLgYzOpZ27FqG6/xJuzRIDGzrVk4Hk2+C95VW8DCJo5PyGZtjbfrrBxa1JsNmtEWiincgoP2fhJiBywF40JrzlcV+3lrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035617; c=relaxed/simple;
	bh=qdNPZSxDWkAVBHby6lIuHE5/SaCpcBJC3lc+De6DTgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyQpVjhexiHOcHreCXo/DxA3XGufk66/rPZxM26wqyMgA2ULP95YHPagvZWj6PyiHq7nwWe9QD3z6V6XxSheYcSxmQpX4Flnj+Z1DYYGmUxl4U0ZCcWxc8RC2VT44CPG8G6zNvl62E0VkZCWuhkpQNB6zs/UuTDj3wnT5NqbdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M7hY4ofu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkcEI120304;
	Tue, 23 Jan 2024 12:46:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035598;
	bh=5DJmDZAbo+7SZREjKJ9EZltxESX1MQd8OGyJ1fsReMU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=M7hY4ofujW2+L611jrE+jPu1p7l+I+epg8JnSFH87CcMDGkvK7cUeK1msmN+JdinR
	 CXndf1x0vGjhxeFHX0L8nOPBAmyeLEiBMsuLCleug6Op+j6VGm9tcDzWOWWuvPt4yI
	 AlddgP1ZDlyD8LalbalQy61tWCqi9nI6k/TJgMto=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkcGm011088
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:38 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:37 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1w063265;
	Tue, 23 Jan 2024 12:46:37 -0600
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
Subject: [PATCH 7/9] remoteproc: qcom_wcnss: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:30 -0600
Message-ID: <20240123184632.725054-7-afd@ti.com>
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
 drivers/remoteproc/qcom_wcnss.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 90de22c81da97..a7bb9da27029d 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -555,8 +555,8 @@ static int wcnss_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -EINVAL)
 		return ret;
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, &wcnss_ops,
-			    fw_name, sizeof(*wcnss));
+	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, &wcnss_ops,
+				 fw_name, sizeof(*wcnss));
 	if (!rproc) {
 		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
 		return -ENOMEM;
@@ -574,14 +574,12 @@ static int wcnss_probe(struct platform_device *pdev)
 	mutex_init(&wcnss->iris_lock);
 
 	mmio = devm_platform_ioremap_resource_byname(pdev, "pmu");
-	if (IS_ERR(mmio)) {
-		ret = PTR_ERR(mmio);
-		goto free_rproc;
-	}
+	if (IS_ERR(mmio))
+		return PTR_ERR(mmio);
 
 	ret = wcnss_alloc_memory_region(wcnss);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	wcnss->pmu_cfg = mmio + data->pmu_offset;
 	wcnss->spare_out = mmio + data->spare_offset;
@@ -592,7 +590,7 @@ static int wcnss_probe(struct platform_device *pdev)
 	 */
 	ret = wcnss_init_pds(wcnss, data->pd_names);
 	if (ret && (ret != -ENODATA || !data->num_pd_vregs))
-		goto free_rproc;
+		return ret;
 
 	ret = wcnss_init_regulators(wcnss, data->vregs, data->num_vregs,
 				    data->num_pd_vregs);
@@ -656,8 +654,6 @@ static int wcnss_probe(struct platform_device *pdev)
 	qcom_iris_remove(wcnss->iris);
 detach_pds:
 	wcnss_release_pds(wcnss);
-free_rproc:
-	rproc_free(rproc);
 
 	return ret;
 }
@@ -673,7 +669,6 @@ static void wcnss_remove(struct platform_device *pdev)
 	qcom_remove_sysmon_subdev(wcnss->sysmon);
 	qcom_remove_smd_subdev(wcnss->rproc, &wcnss->smd_subdev);
 	wcnss_release_pds(wcnss);
-	rproc_free(wcnss->rproc);
 }
 
 static const struct of_device_id wcnss_of_match[] = {
-- 
2.39.2


