Return-Path: <linux-kernel+bounces-35670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893A839505
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEEEF1F2C2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7F86136;
	Tue, 23 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xuQuj3Gl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FC81AB8;
	Tue, 23 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027829; cv=none; b=dVmeCl6uBxdvLGMTUtbFq6ACCcDbpRnblR6N17QxRFkUnfqwOgtlec1jV3UPhdYtqwLxYLvXvnrJilabLLlzAwbRyUHda4OlEKWFx1Bp1KazswDKqbB7fBzZHN30UWD1ubEozhIf2R6LNoFFJsT+H2AuQ8ILOeUCzHPLBOSb4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027829; c=relaxed/simple;
	bh=sr2Vyb1EOHE0YZHeGvfTOHoxjt5lsn89GNkUPtiXd84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIS8QKCH/tDY2k9w44jq0NsTLBxvbWEnmB1fDGqbi/ApC0fUIEXRCpLbFS4A52/3JldLllRbn6+6DGUS0iLY0T5QYJVzM2VSAB88daixncWAnLqyKi5fJMxzJHHmni+u40ydMS3JBrjzihtybmOkN7UDb7PDebjnUEHe9BRtMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xuQuj3Gl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGavD4049963;
	Tue, 23 Jan 2024 10:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027817;
	bh=2SMklRBcdhC+e02hBGW+GTz+VKdDCFtjMgA9tyn8QQI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xuQuj3GluL2HEf4VLZUTa9+5RxFLp6x6gUDfYzhz44sZLooO/cGZnICYqBjVo2gB4
	 kDmyj02jLExMBNOeMPiFlbeyuIwbSQYSdNiB5p2/O0S/ocDjV6DsyKbY+ktR9tQ2ib
	 T2d1BsXgRXVFgLM4dIUH1Hb89/I09NB+gbiGoGZI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGavrC119705
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:57 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:57 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrv123403;
	Tue, 23 Jan 2024 10:36:57 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 09/21] power: supply: max8925: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:41 -0600
Message-ID: <20240123163653.384385-10-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123163653.384385-1-afd@ti.com>
References: <20240123163653.384385-1-afd@ti.com>
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
 drivers/power/supply/max8925_power.c | 36 ++++++++--------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/power/supply/max8925_power.c b/drivers/power/supply/max8925_power.c
index 4a2d6894f94ee..29ce6c5bfe0e6 100644
--- a/drivers/power/supply/max8925_power.c
+++ b/drivers/power/supply/max8925_power.c
@@ -528,25 +528,19 @@ static int max8925_power_probe(struct platform_device *pdev)
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
@@ -558,24 +552,14 @@ static int max8925_power_probe(struct platform_device *pdev)
 
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


