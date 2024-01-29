Return-Path: <linux-kernel+bounces-43385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811338412FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59A21C23CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5AC7602A;
	Mon, 29 Jan 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WmRRWT5V"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B62E3F2;
	Mon, 29 Jan 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554978; cv=none; b=mgMMHTEaIIu2NN0y+skuNdEx+j3QlN1Au7REzn5eBnauQsNLWbWMqZPRWLh4s+BRNVAUWKBF1MJNhKaYgZAFdqjaRMRx4NbmQjGbtL1+P6WFIeGNV+/bajS8/S+DDsr7/9am8026fg8N8xPH38lhVS6qW7P1mwpEpZ6k/r7O6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554978; c=relaxed/simple;
	bh=fdbDOOZ8ZWN98QLU9QnPnSBqslUHsecWpRX2TegdXoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmhPtQODIe6gy0AvaLD8SqnboZa0POH5i8adro4F4usWdNnuBNBGhunXhG2T6xSij0A8Cv+1uvaGa0q15cXOjsFoan+bJjeAdATi2+bn37WAXvQk7z3vAsYl0ejfekFSZ7ygAaESlatqg8h28J3/XsQaP6VyM9XNlgZjrqZZW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WmRRWT5V; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2nSW101902;
	Mon, 29 Jan 2024 13:02:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706554969;
	bh=7JebxtcTaMFtDLVu1l2VtdysYDSvONcVN9rANhH+fD8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WmRRWT5Vkw+b0O51oaQVq4LIxROC0Cjg64svqIvEyUNkEFwGIamFGCV+GKb+/SUFO
	 vcLUV7x8TgKHzU3vJIHefblw3CpwF+LDjFqjj97mv0glUhB/+E0keyzYiIh2XJhwsp
	 UMyhbnJ4nW2umUAsEKdFp9TuZRo0ZogrEjcjkllo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TJ2ngO053320
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 13:02:49 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 13:02:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 13:02:48 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2ldo003658;
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
Subject: [PATCH v2 3/4] power: supply: max8925: Use devm_power_supply_register() helper
Date: Mon, 29 Jan 2024 13:02:45 -0600
Message-ID: <20240129190246.73067-4-afd@ti.com>
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
 drivers/power/supply/max8925_power.c | 37 ++++++++--------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/max8925_power.c
index 4a2d6894f94ee..621a006d52a96 100644
--- a/drivers/power/supply/max8925_power.c
+++ b/drivers/power/supply/max8925_power.c
@@ -507,7 +507,6 @@ static int max8925_power_probe(struct platform_device *pdev)
 	struct power_supply_config psy_cfg = {}; /* Only for ac and usb */
 	struct max8925_power_pdata *pdata = NULL;
 	struct max8925_power_info *info;
-	int ret;
 
 	pdata = max8925_power_dt_init(pdev);
 	if (!pdata) {
@@ -528,25 +527,19 @@ static int max8925_power_probe(struct platform_device *pdev)
 	psy_cfg.supplied_to = pdata->supplied_to;
 	psy_cfg.num_supplicants = pdata->num_supplicants;
 
-	info->ac = power_supply_register(&pdev->dev, &ac_desc, &psy_cfg);
-	if (IS_ERR(info->ac)) {
-		ret = PTR_ERR(info->ac);
-		goto out;
-	}
+	info->ac = devm_power_supply_register(&pdev->dev, &ac_desc, &psy_cfg);
+	if (IS_ERR(info->ac))
+		return PTR_ERR(info->ac);
 	info->ac->dev.parent = &pdev->dev;
 
-	info->usb = power_supply_register(&pdev->dev, &usb_desc, &psy_cfg);
-	if (IS_ERR(info->usb)) {
-		ret = PTR_ERR(info->usb);
-		goto out_unregister_ac;
-	}
+	info->usb = devm_power_supply_register(&pdev->dev, &usb_desc, &psy_cfg);
+	if (IS_ERR(info->usb))
+		return PTR_ERR(info->usb);
 	info->usb->dev.parent = &pdev->dev;
 
-	info->battery = power_supply_register(&pdev->dev, &battery_desc, NULL);
-	if (IS_ERR(info->battery)) {
-		ret = PTR_ERR(info->battery);
-		goto out_unregister_usb;
-	}
+	info->battery = devm_power_supply_register(&pdev->dev, &battery_desc, NULL);
+	if (IS_ERR(info->battery))
+		return PTR_ERR(info->battery);
 	info->battery->dev.parent = &pdev->dev;
 
 	info->batt_detect = pdata->batt_detect;
@@ -558,24 +551,14 @@ static int max8925_power_probe(struct platform_device *pdev)
 
 	max8925_init_charger(chip, info);
 	return 0;
-out_unregister_usb:
-	power_supply_unregister(info->usb);
-out_unregister_ac:
-	power_supply_unregister(info->ac);
-out:
-	return ret;
 }
 
 static void max8925_power_remove(struct platform_device *pdev)
 {
 	struct max8925_power_info *info = platform_get_drvdata(pdev);
 
-	if (info) {
-		power_supply_unregister(info->ac);
-		power_supply_unregister(info->usb);
-		power_supply_unregister(info->battery);
+	if (info)
 		max8925_deinit_charger(info);
-	}
 }
 
 static struct platform_driver max8925_power_driver = {
-- 
2.39.2


