Return-Path: <linux-kernel+bounces-53217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ED684A248
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B89CB222B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45448CFD;
	Mon,  5 Feb 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H5yulMLP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13682482FE;
	Mon,  5 Feb 2024 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157681; cv=none; b=CMLTFqTpSA7uAXFeFOFogZMcpwe3AZeGFO3/a0K5VWaCNe8ALaJc6ioNbSPOA3EQwN4OgT/KCWolIOZ17lwP++Dln14pH/WppEuxJUWKLiOCMn2q9C76SBnGr2OGADIi4qis2pw2AsKX+EfC/YRj0m1gYHj1v9A7Wiw4bRC+Vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157681; c=relaxed/simple;
	bh=UTKjnl02zRrNFWyX0e1HTEuHJnpztcqmM5wI4qOg/PM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFUndIcuFAkuNbQfnGbY5McoCbRvhUwLc8PYcsX1xsQUQHNaDzmKOQ5shWsE1P3befB3qGpiwNd/+pf+B4FS6Fmx7lJmMyW8s2epKxmWJ9SiEICOWz/wPcHmdivyTZU7IaruQIRRJ6/s48xajmEiX0LBbfn9aLB7Gl2QjCyadVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H5yulMLP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415IRukq120265;
	Mon, 5 Feb 2024 12:27:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707157676;
	bh=cCOdsqhr20y5QKXtiSnCUsddUxH/Yci+gnu7HPlrDyE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H5yulMLPBSMo1WqQqmzdeIODB5B+tM/DEG72QsvlnQ+3FHxzoHYJKwp3pNlHNljjt
	 Hqu+0vCM+6BicpapV4dsQYmr+5Sd3/cRR98hdiMWfo6aD9ydfNHx+e1C4wImrWKPVb
	 sh1nsOdLszLKhwFsN6aorpx9ERxOTxrEhCTYM0jQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415IRu8B123163
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 12:27:56 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 12:27:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 12:27:56 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415IRsX9058567;
	Mon, 5 Feb 2024 12:27:55 -0600
From: Andrew Davis <afd@ti.com>
To: Jai Luthra <j-luthra@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 5/5] remoteproc: k3-dsp: Use devm_rproc_add() helper
Date: Mon, 5 Feb 2024 12:27:53 -0600
Message-ID: <20240205182753.36978-6-afd@ti.com>
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

Use device lifecycle managed devm_rproc_add() helper function. This helps
prevent mistakes like deleting out of order in cleanup functions and
forgetting to delete on all error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index f799f74734b4a..3555b535b1683 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -768,7 +768,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = rproc_add(rproc);
+	ret = devm_rproc_add(dev, rproc);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to add register device with remoteproc core\n");
 
@@ -786,14 +786,9 @@ static void k3_dsp_rproc_remove(struct platform_device *pdev)
 
 	if (rproc->state == RPROC_ATTACHED) {
 		ret = rproc_detach(rproc);
-		if (ret) {
-			/* Note this error path leaks resources */
+		if (ret)
 			dev_err(dev, "failed to detach proc (%pe)\n", ERR_PTR(ret));
-			return;
-		}
 	}
-
-	rproc_del(kproc->rproc);
 }
 
 static const struct k3_dsp_mem_data c66_mems[] = {
-- 
2.39.2


