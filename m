Return-Path: <linux-kernel+bounces-35922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75C8398D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E63F1F285EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEE71272CA;
	Tue, 23 Jan 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V0iXng9O"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60986AF2;
	Tue, 23 Jan 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035761; cv=none; b=ttzGM0Py2FCTE7y8Xe8kkC/s6qahlYQcrThE9w0HWKIBOs9ao302sUHWOj0a2vdI2bClTz9kXZFfJSqn3/VvYeXxHtatnOlfxIVYuCCZYwjgplXQd38YNU4WYuNvNjkAkHgGj+xUnlTsSJUGH09COvhSHrdATgYVU4/B0m8KFTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035761; c=relaxed/simple;
	bh=6JxaZr3gQ3FflabST3iihxVacAmdxNOYNyWFOv3PSgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVRZc2LeQoxvndmrYCeXpd3gRx8iQo+jysuZJ0tGLl/uah6E4iQ8tqLv5fCbgqJUPMhdYxzYIgvTf68T8O3xReFbX4JBvDgaZHGQRexlc11b++NC6eADy2jfbMfRm5Fx069tvGeEvNFcOpV8xlKPHjfmg7BjEY9E1IgqqeYeLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V0iXng9O; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NInFBJ090413;
	Tue, 23 Jan 2024 12:49:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035755;
	bh=x7Zkj4f+0noCETbDGtxWDNsjlb2cVIVyBzbEDUpzWLs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=V0iXng9O4X/D1455oZ+5xM4jMK22FpPJRndFQwQ5Fkpb23BUerNmstadJ7xWqZw8F
	 yFR9zW9I/p4dCz7EwAP8/Nbm/2pX6V540APDT/vuM1A6d7WIaukG8yiDPWslFrU6CQ
	 ob9TjnYS4jqJP5KxWCx/jY9BiBMmnu2L+fGyrs5o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NInFvC041340
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:49:15 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:49:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:49:15 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NInEnL066395;
	Tue, 23 Jan 2024 12:49:15 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 4/8] remoteproc: k3-dsp: Use devm_ti_sci_get_by_phandle() helper
Date: Tue, 23 Jan 2024 12:49:09 -0600
Message-ID: <20240123184913.725435-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123184913.725435-1-afd@ti.com>
References: <20240123184913.725435-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed TI-SCI get() function. This helps prevent
mistakes like not put()'ing in the wrong order in cleanup functions and
forgetting to put() on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 33 +++++++----------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index a13552c71f440..0240340a83e90 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -682,7 +682,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	const char *fw_name;
 	bool p_state = false;
 	int ret = 0;
-	int ret1;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
@@ -708,30 +707,24 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	kproc->dev = dev;
 	kproc->data = data;
 
-	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
+	kproc->ti_sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
 	if (IS_ERR(kproc->ti_sci))
 		return dev_err_probe(dev, PTR_ERR(kproc->ti_sci),
 				     "failed to get ti-sci handle\n");
 
 	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
-	if (ret) {
-		dev_err_probe(dev, ret, "missing 'ti,sci-dev-id' property\n");
-		goto put_sci;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "missing 'ti,sci-dev-id' property\n");
 
 	kproc->reset = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(kproc->reset)) {
-		ret = dev_err_probe(dev, PTR_ERR(kproc->reset),
-				    "failed to get reset\n");
-		goto put_sci;
-	}
+	if (IS_ERR(kproc->reset))
+		return dev_err_probe(dev, PTR_ERR(kproc->reset),
+				     "failed to get reset\n");
 
 	kproc->tsp = k3_dsp_rproc_of_get_tsp(dev, kproc->ti_sci);
-	if (IS_ERR(kproc->tsp)) {
-		ret = dev_err_probe(dev, PTR_ERR(kproc->tsp),
-				    "failed to construct ti-sci proc control\n");
-		goto put_sci;
-	}
+	if (IS_ERR(kproc->tsp))
+		return dev_err_probe(dev, PTR_ERR(kproc->tsp),
+				     "failed to construct ti-sci proc control\n");
 
 	ret = ti_sci_proc_request(kproc->tsp);
 	if (ret < 0) {
@@ -805,10 +798,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
 free_tsp:
 	kfree(kproc->tsp);
-put_sci:
-	ret1 = ti_sci_put_handle(kproc->ti_sci);
-	if (ret1)
-		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret1));
 	return ret;
 }
 
@@ -836,10 +825,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 
 	kfree(kproc->tsp);
 
-	ret = ti_sci_put_handle(kproc->ti_sci);
-	if (ret)
-		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret));
-
 	k3_dsp_reserved_mem_exit(kproc);
 }
 
-- 
2.39.2


