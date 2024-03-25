Return-Path: <linux-kernel+bounces-117574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72D88ACC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B712C50D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A74F129E9E;
	Mon, 25 Mar 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MQo2NyPd"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5B84D12;
	Mon, 25 Mar 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387255; cv=none; b=YkcNCcdIoZE3h2IGu4chOLpwbQABtCR6mdEcAs4glvShuVYUAMEyaGGy3hDWnJ2JOd8q2wg+19Mcu+K3IU+N+y68RoWrcrp7V1xUgyqzuI22K0T9LjXJNxeN51hBye2qaMRV8TwuKzjn802HEwk8Hlwglu2Y/jX+amwzKSDxnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387255; c=relaxed/simple;
	bh=NcOCcA1t31ypyx8cNN32oWTH1pjrXQ2t7Fb75KNyUbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kp+6hg+RR3qE0DvDrgavZcLFjJ0Iyq1T7WGKfp9PpW+sQKjNq492jRe+oohNBlYq5TthH2YB5XeEgmRyZJSy/UcbA4QOjrhac5TyfFYjF8Ni0jGmCYvgI4qTiBn6K+Fil/C5b6v8xpOcTWG3lz5Kdq4U+1Ry/NbQO/lNqeRt1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MQo2NyPd; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKnTb040386;
	Mon, 25 Mar 2024 12:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387249;
	bh=nQlvgEyRLvm0RPmSVnsggj8wOBAJLIUCQWiiAO/T3vc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MQo2NyPdRuxbTualBlmurAg9GL6nHtVSIjDUWNbc6j2m+KdryM8XbadbmwzHA5i04
	 zL93V152nLjmeJoSQmPshSexCLE1OtSnGpSViZwLVLDdrKup/54vYJMJtPGoVciNgW
	 Cyf6k1zaD+184btu1eF3jlEp9Qhi9/Ov9wycACPk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKnBp105011
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:49 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYd075282;
	Mon, 25 Mar 2024 12:20:48 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 07/13] mailbox: omap: Use devm_pm_runtime_enable() helper
Date: Mon, 25 Mar 2024 12:20:39 -0500
Message-ID: <20240325172045.113047-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172045.113047-1-afd@ti.com>
References: <20240325172045.113047-1-afd@ti.com>
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


