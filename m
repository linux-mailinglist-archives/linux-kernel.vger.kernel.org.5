Return-Path: <linux-kernel+bounces-35656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4308394DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ADA28B812
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7C7F7D0;
	Tue, 23 Jan 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WvcptC83"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB67F7DE;
	Tue, 23 Jan 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027824; cv=none; b=DpFjF5EcuR/7/fFkohRQkolzM3acGH/o47TOvy16AKyPgJfIflZKd9EIO1qMirvhFhAElq1bJg3mj0e19PWZesN1akgl62R0p/CNue16/p4pR9GXjgLWZnWWQBnHaxY38U0LoQlN4w/D8LYlULEnSRRPcOYreEA6YPf/IZE5IuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027824; c=relaxed/simple;
	bh=V+29UwgyDpXx8GxUdu6KJwdE/Zs8q4X5BKpdEnqZqdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY8FfGd3h5/RRACJ19dp/luYhsLWmuFEAlD3fkmXDPVRsK+MYEYpAy0V1z8KrDQD7doOFTEHCx4wYPybyL3xneGWvjTfNwepiFHgOtGgaNqQnJ5F/UD9nsEQ2IriJlI6J2cC1H03hXdsrsdmhDawKByVZIvr7F7fHrIv3GP6zpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WvcptC83; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGatAN095550;
	Tue, 23 Jan 2024 10:36:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027815;
	bh=5Id6Oqhr9a7k5hr6AyXWKnA0e9FTJXVNCHOuwHNCchc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WvcptC83h5E669R034tcGgqxsyNWqYzCwbHN6wMKJqhQWKEa09NRanD6QGIJqu/FO
	 C9HaS/7GwsmCZguGk4Ig4vJeXrpDXN5lGeZTpMysvG517TJ1E7yZNIK90rprQPij+P
	 T3NpxBCZ6c5dUO83Mo1qIPTVM+uAoxj4vnS4//2U=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGasLZ033931
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:55 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:54 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrn123403;
	Tue, 23 Jan 2024 10:36:54 -0600
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
Subject: [PATCH 01/21] power: supply: da9030: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:33 -0600
Message-ID: <20240123163653.384385-2-afd@ti.com>
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
 drivers/power/supply/da9030_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 581cf956d2d25..04e0f4162d42b 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -530,8 +530,9 @@ static int da9030_battery_probe(struct platform_device *pdev)
 
 	da9030_battery_setup_psy(charger);
 	psy_cfg.drv_data = charger;
-	charger->psy = power_supply_register(&pdev->dev, &charger->psy_desc,
-					     &psy_cfg);
+	charger->psy = devm_power_supply_register(&pdev->dev,
+						  &charger->psy_desc,
+						  &psy_cfg);
 	if (IS_ERR(charger->psy)) {
 		ret = PTR_ERR(charger->psy);
 		goto err_ps_register;
@@ -563,7 +564,6 @@ static void da9030_battery_remove(struct platform_device *dev)
 				   DA9030_EVENT_CHIOVER | DA9030_EVENT_TBAT);
 	cancel_delayed_work_sync(&charger->work);
 	da9030_set_charge(charger, 0);
-	power_supply_unregister(charger->psy);
 }
 
 static struct platform_driver da903x_battery_driver = {
-- 
2.39.2


