Return-Path: <linux-kernel+bounces-35888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A6839833
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9408D1F21770
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673F782D88;
	Tue, 23 Jan 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="slWbiOLO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA381AD4;
	Tue, 23 Jan 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035613; cv=none; b=Jnak3TnAU1XtDkm/E1iFiEEEeTE8TTBVoW6D7aV4ZIYv5blU1sg5l/TLtDgyjQPctPZuk0yhWH1bEQnDdkZ1lqklZl5fAQl8giIC5sPlUB3fnXpu/pWCkU7kgulO5CqiidXWw7rFOuZ91+TmdJU4TtE6MlI9rKC//F76ev7kpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035613; c=relaxed/simple;
	bh=Hyb1VGFfyYopkNLIcjNsDib+wPbRe4qUv62+iaxQRf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6W3ZVEDJgiqamYerxiwtmpO4nays5cY055QK/Ecq6YoNL4GdkdGE7IX5165pvZbjFsN/gnG0wIzRtBqXurg0hu84R8su3bhyDaPwv3WgRgIaNYlMk/vHwLy+2a8N7WSbs702cEzz9Ywrm09g4dX7GsGKV6IlSyqEC/s74qAcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=slWbiOLO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkbEZ010747;
	Tue, 23 Jan 2024 12:46:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035597;
	bh=4OoYou47DqNz8DYkVnH3Oy3op4du31DW+m2rH224CIM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=slWbiOLOWkUwicHCeQTOVUcxkWi/h6xs4ar0Kyquf/76Cub3LdAdpDE665xb6DtX+
	 LEO9UFmvl6X6Gq+MlgWp8M12X+8l23qmonl+2e92kqx8onmxf3xjUyqTqwNGu3Wk3+
	 0oKnWFTsjCcBF4OyjWdeuLSjzTGi5WJS4AEOSY0I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkb2b011067
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:37 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:36 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1u063265;
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
Subject: [PATCH 5/9] remoteproc: qcom_q6v5_pas: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:28 -0600
Message-ID: <20240123184632.725054-5-afd@ti.com>
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
 drivers/remoteproc/qcom_q6v5_pas.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index a9dd58608052c..60b0cd30c0592 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -678,7 +678,7 @@ static int adsp_probe(struct platform_device *pdev)
 	if (desc->minidump_id)
 		ops = &adsp_minidump_ops;
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, ops, fw_name, sizeof(*adsp));
+	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, ops, fw_name, sizeof(*adsp));
 
 	if (!rproc) {
 		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
@@ -754,7 +754,6 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 free_rproc:
 	device_init_wakeup(adsp->dev, false);
-	rproc_free(rproc);
 
 	return ret;
 }
@@ -773,7 +772,6 @@ static void adsp_remove(struct platform_device *pdev)
 	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
 	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 	device_init_wakeup(adsp->dev, false);
-	rproc_free(adsp->rproc);
 }
 
 static const struct adsp_data adsp_resource_init = {
-- 
2.39.2


