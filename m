Return-Path: <linux-kernel+bounces-61956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D691851922
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A811F21E18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD19F3D56A;
	Mon, 12 Feb 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FsMWecg9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9C3C699;
	Mon, 12 Feb 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755327; cv=none; b=QfBOL838F4pwjS2ibBb+MkMpMkGBKqFCCdKU56V/pJE4IAm6qXps3kNNF3dsdHf+zxPK9Da7/XHuZlxrbtMM2MXhRL2UONZqz5Kto4HXmUXPiMxvPOmWiGMwOmwjV/Vw2sXJhMXSVctCW/nt6rn9E8RxD7zxZ6FDNSXFb5voaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755327; c=relaxed/simple;
	bh=ilhrdoWUjxQAw/qNLh+VKGDKCDBwtm1fe8dEPR5edio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVXOEjhBNWZ9lzPeMZ/MK85EVLQX2s1PaOZdDl731QLJYzvMojWspxpV9UjrNh84sps7YyTUwlklY1vqldcyQQg8LkER+QVOgvysVZ3/qU/ssNupQ93AkhcTWt0AbKBRHkuLF3aBbhWHED4/IuK0ABmT7a8QpEfWmuEnSpcOZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FsMWecg9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSZEp045189;
	Mon, 12 Feb 2024 10:28:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755315;
	bh=DM5F+CDTYAkATD9JuxoEYM5J5TLXMlR0cMppKdmlkcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FsMWecg9kC5UB9179sxzrodGJ+BwYFphMHjuRqDJMGMmX+uJEQw1F4Y2KdJBbyU1y
	 axJ8HnpdI5e6NTPZjsioFGoQcnJOSk5ILRMwVTDXEOZf4J5ppFFem60uCaEIiBKR/P
	 /C02cGkFKcGlMn6abK1vZQyTFXRlng5eZPT8N9m4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGSZJj041897
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:35 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWQx090688;
	Mon, 12 Feb 2024 10:28:34 -0600
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
Subject: [PATCH v4 03/19] power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper
Date: Mon, 12 Feb 2024 10:28:15 -0600
Message-ID: <20240212162831.67838-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212162831.67838-1-afd@ti.com>
References: <20240212162831.67838-1-afd@ti.com>
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


