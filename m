Return-Path: <linux-kernel+bounces-43384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A148412F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5491A1C23B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EAF2AD0F;
	Mon, 29 Jan 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DuBgSFXg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B461E53A;
	Mon, 29 Jan 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554977; cv=none; b=N4L8FHq367lbvGnTHDdfDtae9QfmzZ+m+ZDnntPvEqC2D/MYbDtuqBf8CgNId9ri5CVQ7ea9UKtIiPcXYmjemIqU0A8Ss1f/J55IqumdiuthXHynv3DUgWfKgmSxjdt2TIIfvdZp5zAJX4mh4xuj+nlDELh8NIKw2HtHz3jkiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554977; c=relaxed/simple;
	bh=hQVVKwUdC+zKSnOnHS3P769zWu992z267ImR3b3Ma4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nj67uvmkDl1u8NzzRHnZAIP3yrouu4qg/2NF8GMne36PxUidELKpwx1Kr5iImEqO992XnVNpu9xEPwjhEUqWZiTQollIiWdAJOXvXckL4wb2NZIpBO8XR+bW5nVtPQ5BIZMPNyYj2pD5skbJqvxIZ5gwhlJYMzZZedF2QCoabBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DuBgSFXg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2m1P047049;
	Mon, 29 Jan 2024 13:02:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706554968;
	bh=EkCoRg96Bi3pZyGYSs63y7IXgnOqtVbWEnW4q2jNl2w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DuBgSFXgaO7cIVT0mTUvKDropMSJsuWL3ULm7xWhb8NPbYdMDaVacOA28tyKxQ0pO
	 nJaIUKFd5HtjURkKl1x9UJSd9b7onpGyMkTjgWW3fa3V8uOiiUo2VxollqsyyR4zNy
	 GB7llH+SRKk4xSR0mpc8QwIMOjLtyOQQncOTUdd0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TJ2mUu090224
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 13:02:48 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 13:02:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 13:02:48 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2ldn003658;
	Mon, 29 Jan 2024 13:02:48 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2 2/4] power: supply: max77693: Use devm_power_supply_register() helper
Date: Mon, 29 Jan 2024 13:02:44 -0600
Message-ID: <20240129190246.73067-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129190246.73067-1-afd@ti.com>
References: <20240129190246.73067-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed register function. This helps prevent
mistakes like unregistering out of order in cleanup functions and
forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/max77693_charger.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index d0157e63b8b50..2001e12c9f7de 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -709,9 +709,9 @@ static int max77693_charger_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	chg->charger = power_supply_register(&pdev->dev,
-						&max77693_charger_desc,
-						&psy_cfg);
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &max77693_charger_desc,
+						  &psy_cfg);
 	if (IS_ERR(chg->charger)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		ret = PTR_ERR(chg->charger);
@@ -730,13 +730,9 @@ static int max77693_charger_probe(struct platform_device *pdev)
 
 static void max77693_charger_remove(struct platform_device *pdev)
 {
-	struct max77693_charger *chg = platform_get_drvdata(pdev);
-
 	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
-
-	power_supply_unregister(chg->charger);
 }
 
 static const struct platform_device_id max77693_charger_id[] = {
-- 
2.39.2


