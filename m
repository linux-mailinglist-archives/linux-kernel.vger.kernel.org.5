Return-Path: <linux-kernel+bounces-35890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0983983D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5779AB22135
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200986146;
	Tue, 23 Jan 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e0oC/DTh"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0C82D92;
	Tue, 23 Jan 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035616; cv=none; b=V4q1iAt/IHkShgfqamgOZBXuwPEC67WaLmLF00NFPZ77C2jrZ4rgL4jLA67SPvdGPVIzz6v6UCjFlFDIOlRFBvKDX5QQy1a0SDzCSgJphpvm5KbTQ3H6j7H3CsVjX8mrqY1rIKrRzFca91hRbLhhVG3S4SS8TXI3Sv/nvWSwnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035616; c=relaxed/simple;
	bh=H+ZoJm1vUFZ9f7a1Km/BbcqQMdrszGIcz+rY7QYVaDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4P6ECk5Jmf4yVTwK5nul5Dj8NbVlhE+pgG/JvCuS4mPrAeOR/GrEirL+yd41QFrMgeH4MloAbdCDmcL+MkMl7oHugZPyQGmE8Okp5YwEz5wzGmxqQpI+CAjoVuew8WqWIz5KubhlmIcToZbm03uaO3LoYvYZTapLk3BnhLEHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e0oC/DTh; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkabU111639;
	Tue, 23 Jan 2024 12:46:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035596;
	bh=/77N6C+3SHO7CVVT9hBWykK5XA7cqasg6TvintmsU2I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=e0oC/DThtjRv0mxkRczpQZwOUfUvfLYW3wEoP3a9q10M2jBMGNRzxAEcQVz3/9IYh
	 m02e2seJ8LzjMH3PltSX2W/LFa1LjWLrqw65SboApSK3rruu0UtCFORAUw/gpWw6ta
	 VAzLrUiq0E5qOvpa5dPWKkZY7HuqyIEg5j8tJDMs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIka6e009825
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:36 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:35 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1s063265;
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
Subject: [PATCH 3/9] remoteproc: qcom_q6v5_adsp: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:26 -0600
Message-ID: <20240123184632.725054-3-afd@ti.com>
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
 drivers/remoteproc/qcom_q6v5_adsp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6c67514cc4931..34ac996a93b20 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -683,8 +683,8 @@ static int adsp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
-			    firmware_name, sizeof(*adsp));
+	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
+				 firmware_name, sizeof(*adsp));
 	if (!rproc) {
 		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
 		return -ENOMEM;
@@ -709,17 +709,17 @@ static int adsp_probe(struct platform_device *pdev)
 
 	ret = adsp_alloc_memory_region(adsp);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	ret = adsp_init_clock(adsp, desc->clk_ids);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	ret = qcom_rproc_pds_attach(adsp->dev, adsp,
 				    desc->proxy_pd_names);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to attach proxy power domains\n");
-		goto free_rproc;
+		return ret;
 	}
 	adsp->proxy_pd_count = ret;
 
@@ -755,9 +755,6 @@ static int adsp_probe(struct platform_device *pdev)
 disable_pm:
 	qcom_rproc_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 
-free_rproc:
-	rproc_free(rproc);
-
 	return ret;
 }
 
@@ -772,7 +769,6 @@ static void adsp_remove(struct platform_device *pdev)
 	qcom_remove_sysmon_subdev(adsp->sysmon);
 	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
 	qcom_rproc_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
-	rproc_free(adsp->rproc);
 }
 
 static const struct adsp_pil_data adsp_resource_init = {
-- 
2.39.2


