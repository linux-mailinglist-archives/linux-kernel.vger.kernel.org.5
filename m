Return-Path: <linux-kernel+bounces-138700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F989F92F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152C71C2792C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8516F0CE;
	Wed, 10 Apr 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZRCbb9E/"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3D15B568;
	Wed, 10 Apr 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757594; cv=none; b=UzSKxXoTDlzKGiBnwjjhbSpkWRqCc2afzjS40X6M1C84LoWfohqK4OnJRSH2SmlUaPz4ndAQ0Ji05ReGfF1yYX8snEhpxPjBUSa87txEw7ypkvBZ+YICNsyCWlN+KdzsgdP7+/v+q7hteytT3+7PQECa/fuIprwvPVMAFbO/C5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757594; c=relaxed/simple;
	bh=NcOCcA1t31ypyx8cNN32oWTH1pjrXQ2t7Fb75KNyUbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFYOBtUki9e+DMw1GHGBOTbXI4xCBrzIZhAfoc8U8zSD79MpB5qPgCverFQ2EBhTI0oRf4PReYfEAp+rrNrkskbJgrWVpaVo1KRbMSWPW6OwTSzkf3bSdHnXgKHsiCFFPWHUFFFIZHGzT9OEx8qvXarwrBt/2mXZUOtRDpntzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZRCbb9E/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxkbv056749;
	Wed, 10 Apr 2024 08:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757586;
	bh=nQlvgEyRLvm0RPmSVnsggj8wOBAJLIUCQWiiAO/T3vc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZRCbb9E/lIB4TqCLieiinTX04PlE6Y2bh1j7uapwppVO8YXv3W8SZCPDr3a37YK22
	 uIuNGR434jo+1piBs9oAlOdPiHtroHvWXv+sZ0Y4ri4q7WMNFNK/TGqU2Wna0NUI/C
	 Vj/pD201RoUUMCkzyJHf/rs7plG5loHYz0OXfpO0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxkuO011501
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:46 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhar067183;
	Wed, 10 Apr 2024 08:59:45 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 07/13] mailbox: omap: Use devm_pm_runtime_enable() helper
Date: Wed, 10 Apr 2024 08:59:36 -0500
Message-ID: <20240410135942.61667-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410135942.61667-1-afd@ti.com>
References: <20240410135942.61667-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed runtime enable function to simplify probe
and exit paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index ea467931faf46..4f956c7b4072c 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -726,11 +726,11 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		return ret;
 
 	platform_set_drvdata(pdev, mdev);
-	pm_runtime_enable(mdev->dev);
+	devm_pm_runtime_enable(mdev->dev);
 
 	ret = pm_runtime_resume_and_get(mdev->dev);
 	if (ret < 0)
-		goto unregister;
+		return ret;
 
 	/*
 	 * just print the raw revision register, the format is not
@@ -741,26 +741,14 @@ static int omap_mbox_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_put_sync(mdev->dev);
 	if (ret < 0 && ret != -ENOSYS)
-		goto unregister;
+		return ret;
 
 	devm_kfree(&pdev->dev, finfoblk);
 	return 0;
-
-unregister:
-	pm_runtime_disable(mdev->dev);
-	return ret;
-}
-
-static void omap_mbox_remove(struct platform_device *pdev)
-{
-	struct omap_mbox_device *mdev = platform_get_drvdata(pdev);
-
-	pm_runtime_disable(mdev->dev);
 }
 
 static struct platform_driver omap_mbox_driver = {
 	.probe	= omap_mbox_probe,
-	.remove_new = omap_mbox_remove,
 	.driver	= {
 		.name = "omap-mailbox",
 		.pm = &omap_mbox_pm_ops,
-- 
2.39.2


