Return-Path: <linux-kernel+bounces-58410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602FD84E635
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AEC1C20A58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5283129A95;
	Thu,  8 Feb 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GUXPeyO+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D082D93;
	Thu,  8 Feb 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411879; cv=none; b=iPiQrUe2oQW9ntibEdeNUlhO2UalA17O/P47G6u/zlEQ9TFPLXwFFJrGzpRo00B8F6kfF/EhOzsWTGTAUbjvnQ1sWyAEp1HQRi4WDy1JB2s2vAFYNMAOMDfp55PMCh+GRkiB5kRUwhbA9daZHkW8lNMWoq8zyRS/fvGwbM57tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411879; c=relaxed/simple;
	bh=ilhrdoWUjxQAw/qNLh+VKGDKCDBwtm1fe8dEPR5edio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcv9LVDCAicd9ceFZHjyp4KvCH2gZ7e49zA2ApLeRXmyRuKMD2m3aKuZAsRj7CYe/e80ER50rnq7V1J//GitD0z1UZtpxljXEHh+TrqF6eecIX/pxKa8npYGENJhYjv7FqMxIMYEjR/tcZ/L7t2W1SC/FBmO+AbqXdVgIbgYTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GUXPeyO+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4ELp051751;
	Thu, 8 Feb 2024 11:04:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411854;
	bh=DM5F+CDTYAkATD9JuxoEYM5J5TLXMlR0cMppKdmlkcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GUXPeyO+bMgIyzoRA4DNuzMmb2GvYNBZkAtVpx9T6Eo5ZhXpQt3jT8JkCdjdrVojD
	 BjMsS5vMKERPMJPrP4XyhT9J4xg8LaZtxFmzYMc9xVg3ZM1bl+/++udSoVVXYqrinI
	 Q1ApFsATvr3VJzKuaqd3wQMjOeisG0EVNXXyoCTs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4ErV042386
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:14 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:14 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B65091006;
	Thu, 8 Feb 2024 11:04:13 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 03/19] power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper
Date: Thu, 8 Feb 2024 11:03:54 -0600
Message-ID: <20240208170410.67975-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208170410.67975-1-afd@ti.com>
References: <20240208170410.67975-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed ioremap function to simplify probe and
exit paths.

While here add __iomem to the returned pointer to fix a sparse warning.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/xgene-reboot.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index c2e5a99940d37..6b545a83d8889 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -22,7 +22,7 @@
 
 struct xgene_reboot_context {
 	struct device *dev;
-	void *csr;
+	void __iomem *csr;
 	u32 mask;
 	struct notifier_block restart_handler;
 };
@@ -54,7 +54,7 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->csr = of_iomap(dev->of_node, 0);
+	ctx->csr = devm_platform_ioremap_resource(pdev, 0);
 	if (!ctx->csr) {
 		dev_err(dev, "can not map resource\n");
 		return -ENODEV;
@@ -67,10 +67,8 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 	ctx->restart_handler.notifier_call = xgene_restart_handler;
 	ctx->restart_handler.priority = 128;
 	err = register_restart_handler(&ctx->restart_handler);
-	if (err) {
-		iounmap(ctx->csr);
+	if (err)
 		dev_err(dev, "cannot register restart handler (err=%d)\n", err);
-	}
 
 	return err;
 }
-- 
2.39.2


