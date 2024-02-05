Return-Path: <linux-kernel+bounces-53845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0384A738
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2A41F25C70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376B6EB49;
	Mon,  5 Feb 2024 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nNOg3AKT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975C467C7A;
	Mon,  5 Feb 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162303; cv=none; b=DNxJwj+YCGK9LfDklL4FxXsVyzhQUkRSrYXUezQSfvVtr5xomD2MS7oWf0FI+wAjWyi+jNuad5JernwN4Cmquj2DtTb0XJeCjJBFKCUOPB4yqXbhE1V9DvH4ATvUO2cfsDbvDCJ0DGC0/yi5F2cTsCc2gZTx0tT7UEW/mls3F2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162303; c=relaxed/simple;
	bh=ilhrdoWUjxQAw/qNLh+VKGDKCDBwtm1fe8dEPR5edio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asiuNODk0XO5QpOnycopyzLHlA2ZkqeeCc+XuKEcqtM/4HYniAE1lAWB4RZ4roXQRYg5JKLrs8lOj7gld1lzDc90giNp486u5bReoz1kspHMGFIUSkDULJyAb8d6+sMBi8fFcGoM10pdoNFwElHKctubQzvBHECaL9htm4MKI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nNOg3AKT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Jifbd010933;
	Mon, 5 Feb 2024 13:44:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162281;
	bh=DM5F+CDTYAkATD9JuxoEYM5J5TLXMlR0cMppKdmlkcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nNOg3AKTGbEdbI5tdXnyfF9whOL/RRDOnTnD/qwzXM9FlJ5O9b3bY/eavQBwwQEXm
	 TZdYMGu3A4sTcZ3GapMSfSW5bKTMjXjmrqPWrQbUe8DetR16CO/XE4Jc+eBrskw+E9
	 3JcqNMjCrdXtDqC5fWUV/m1g3jb5lnPxxlOJyoRI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JifXm003438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:44:41 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:44:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:44:41 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415JicQQ028467;
	Mon, 5 Feb 2024 13:44:40 -0600
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
Subject: [PATCH v2 03/19] power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper
Date: Mon, 5 Feb 2024 13:44:21 -0600
Message-ID: <20240205194437.180802-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205194437.180802-1-afd@ti.com>
References: <20240205194437.180802-1-afd@ti.com>
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


