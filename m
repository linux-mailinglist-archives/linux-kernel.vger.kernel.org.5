Return-Path: <linux-kernel+bounces-35894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70583984D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5491128F17B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A286AF6;
	Tue, 23 Jan 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="revUkMym"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7185C49;
	Tue, 23 Jan 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035617; cv=none; b=CNOvrIeu8p9fv4DFSTN7kAoNrK53k5F0HLZac/9Taw4hMXNtIikPIch28TCfnxbrNu3NAuibKvb6Q9i+J/s1DUGYj66vv8VlDsE5jLAzZtvtPuZ1YgJto65t3dQq/PcTxvA5JX5UjGuvsLb412DIblrtd4HYnjZyBsVdqFb+Xvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035617; c=relaxed/simple;
	bh=9Er/9ZzriBnUYFV8MYQi+FyCt/oxHJRm34fkJBeBlTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbDXRiH9G5VKV4G1CAvoxQAYWHpXea7IGyHzU5lxp/3ZIaQvDNp/L/kz9pgK1oFFEtKKmFqA0XFO0z4xfW0Lgpvz2FF3xhZfQLIkIfpN6KnY1DiYLNacNTnOk8fdJVBm18UvvtSHNfm4wiF03dpUoBuU8vZ7/qtxMCaz0KvAEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=revUkMym; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkaqo111731;
	Tue, 23 Jan 2024 12:46:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035596;
	bh=jD1FKqDzVix2VafCVSn9UVihhquiSbNa047p/EY4x68=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=revUkMymYkfh9Qb9IG0NdGm+Qeq1kGH/R+wx7Icb7UEBHMQPpylFLGSETQ24zQHvZ
	 78RfagJhyRAsxYkxHoUDKJ9yVD8HvZmx0iMz4PLl2D1hAOqmzhGnR17J9EJ4ibF0uf
	 5MEKGW1BsWVi0gu/WMFC6ZkzXm2nw3enYOYWwcvo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkaOa125892
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:36 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:36 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1t063265;
	Tue, 23 Jan 2024 12:46:35 -0600
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
Subject: [PATCH 4/9] remoteproc: qcom_q6v5_mss: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:27 -0600
Message-ID: <20240123184632.725054-4-afd@ti.com>
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
 drivers/remoteproc/qcom_q6v5_mss.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 394b2c1cb5e21..1779fc890e102 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1990,8 +1990,8 @@ static int q6v5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
-			    mba_image, sizeof(*qproc));
+	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
+				 mba_image, sizeof(*qproc));
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
 		return -ENOMEM;
@@ -2008,7 +2008,7 @@ static int q6v5_probe(struct platform_device *pdev)
 					    1, &qproc->hexagon_mdt_image);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(&pdev->dev, "unable to read mpss firmware-name\n");
-		goto free_rproc;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, qproc);
@@ -2019,17 +2019,17 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->has_spare_reg = desc->has_spare_reg;
 	ret = q6v5_init_mem(qproc, pdev);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	ret = q6v5_alloc_memory_region(qproc);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	ret = q6v5_init_clocks(&pdev->dev, qproc->proxy_clks,
 			       desc->proxy_clk_names);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get proxy clocks.\n");
-		goto free_rproc;
+		return ret;
 	}
 	qproc->proxy_clk_count = ret;
 
@@ -2037,7 +2037,7 @@ static int q6v5_probe(struct platform_device *pdev)
 			       desc->reset_clk_names);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get reset clocks.\n");
-		goto free_rproc;
+		return ret;
 	}
 	qproc->reset_clk_count = ret;
 
@@ -2045,7 +2045,7 @@ static int q6v5_probe(struct platform_device *pdev)
 			       desc->active_clk_names);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get active clocks.\n");
-		goto free_rproc;
+		return ret;
 	}
 	qproc->active_clk_count = ret;
 
@@ -2053,7 +2053,7 @@ static int q6v5_probe(struct platform_device *pdev)
 				  desc->proxy_supply);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get proxy regulators.\n");
-		goto free_rproc;
+		return ret;
 	}
 	qproc->proxy_reg_count = ret;
 
@@ -2061,7 +2061,7 @@ static int q6v5_probe(struct platform_device *pdev)
 				  desc->active_supply);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to get active regulators.\n");
-		goto free_rproc;
+		return ret;
 	}
 	qproc->active_reg_count = ret;
 
@@ -2074,12 +2074,12 @@ static int q6v5_probe(struct platform_device *pdev)
 					  desc->fallback_proxy_supply);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Failed to get fallback proxy regulators.\n");
-			goto free_rproc;
+			return ret;
 		}
 		qproc->fallback_proxy_reg_count = ret;
 	} else if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to init power domains\n");
-		goto free_rproc;
+		return ret;
 	} else {
 		qproc->proxy_pd_count = ret;
 	}
@@ -2127,8 +2127,6 @@ static int q6v5_probe(struct platform_device *pdev)
 	qcom_remove_glink_subdev(rproc, &qproc->glink_subdev);
 detach_proxy_pds:
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
-free_rproc:
-	rproc_free(rproc);
 
 	return ret;
 }
@@ -2149,8 +2147,6 @@ static void q6v5_remove(struct platform_device *pdev)
 	qcom_remove_glink_subdev(rproc, &qproc->glink_subdev);
 
 	q6v5_pds_detach(qproc, qproc->proxy_pds, qproc->proxy_pd_count);
-
-	rproc_free(rproc);
 }
 
 static const struct rproc_hexagon_res sc7180_mss = {
-- 
2.39.2


