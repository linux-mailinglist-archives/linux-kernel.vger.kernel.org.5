Return-Path: <linux-kernel+bounces-53214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B255684A242
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66E21C23045
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D93487A2;
	Mon,  5 Feb 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZBqxSjKq"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B62482FB;
	Mon,  5 Feb 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157680; cv=none; b=EUrDSe7MLhO7X9AiiiO8zVccahYSXrd1sxSQl+ljvrss1mHFK8hWNSeoNU/5HlYYHxQsrDudv6ConAzDVKSmnJsArR+xpZ179vdI9T28NvlvRHbHJpLzMalKnVPwM3xLfWw4sOk1tUnl2neJi1EUdGTq15go+iOOS/i5FfRnB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157680; c=relaxed/simple;
	bh=Kh9yRK3JG8JtXsrppNxzxgruosSYQ16G2fxHLif/Xfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFqhF/UM/27JShxzEXfrmiCCCiTk+GK6+H1MhvYVGIYDNUAtwmCdyHiiIsXy6TIfPgJcJ2HvGmbPE7W5nqXn3rmRoJEkXyAYDvV9qoSGsbODWk7all+1J9jdSvzEoaJUKz966i5AgLka6uZ7hBIX0kl2APsO7XiSfI3KaqjiEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZBqxSjKq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415IRtZ4119736;
	Mon, 5 Feb 2024 12:27:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707157675;
	bh=xaLWTIDjzfNp2P1XeVqQkeb9zL5PNKaNChxFw6CRZmI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZBqxSjKqt+FPjyT+9Ra4zUPQzOGGM/9FVnk3+rEUz/UVG89IwuLBJIq2YH09Odpzq
	 Oo1OxDl9KHXbcVo64EZ4n+B8IrMEMMojPLRPjDj71+pCWK083S86aYBGIsuOoMpYFK
	 SOaC9wbitxnwo72tg2EvZL5Ft4H0feYMIwUW+PIU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415IRt2E120823
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:27:55 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:27:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:27:54 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415IRsX5058567;
	Mon, 5 Feb 2024 12:27:54 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 1/5] remoteproc: k3-dsp: Use devm_ti_sci_get_by_phandle() helper
Date: Mon, 5 Feb 2024 12:27:49 -0600
Message-ID: <20240205182753.36978-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205182753.36978-1-afd@ti.com>
References: <20240205182753.36978-1-afd@ti.com>
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
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 32 +++++++----------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index a13552c71f440..64ec5759c4ec1 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -708,30 +708,24 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
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
@@ -805,10 +799,6 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to release proc (%pe)\n", ERR_PTR(ret1));
 free_tsp:
 	kfree(kproc->tsp);
-put_sci:
-	ret1 = ti_sci_put_handle(kproc->ti_sci);
-	if (ret1)
-		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret1));
 	return ret;
 }
 
@@ -836,10 +826,6 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 
 	kfree(kproc->tsp);
 
-	ret = ti_sci_put_handle(kproc->ti_sci);
-	if (ret)
-		dev_err(dev, "failed to put ti_sci handle (%pe)\n", ERR_PTR(ret));
-
 	k3_dsp_reserved_mem_exit(kproc);
 }
 
-- 
2.39.2


