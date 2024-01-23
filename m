Return-Path: <linux-kernel+bounces-35660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94C78394E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45874B2820D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F080050;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YhJCOtRC"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153237F7E2;
	Tue, 23 Jan 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027825; cv=none; b=NQ2Ux2oExXWp++FRZv1WzAYc4VUKnl6hx1G6v2zOXmrVV18nvM7JVziJg5cp3eyEQlFnPIu8bslfcR1xcOIFJ1qrqz0NW34p8nXJN0uxA7a1U3+IQwr4WcE4CDeeZVNdZYcCwPBferT0VFAibHBSUQ0/1esKyhUg/6/m2yVYKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027825; c=relaxed/simple;
	bh=OY2361TGwrkXPrQ1UsenLqUtBgbOE0Azmm4BwfLansg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOSQzyd/55s/YZSjgZ7dXkl7Zvz8a07PqyvRX/t5CazK6SQtkCg2UrC0+M9FROAuyz0u1/gP+l6Oeu6ogL1H/oyGKmbQj35RudoMXZzI5pXs++qTGBLGagK0sFCv8Nh9rGOw2L5wV7IPgl4NyRh7XKAfJSkNuDcQrIg8nex+Z4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YhJCOtRC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGatk2049949;
	Tue, 23 Jan 2024 10:36:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027815;
	bh=kY60sQE2O0mWnnL7W1my2Lgy6WoutICMhmnbxu89kcA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YhJCOtRCdPuqytKsPHHQo9zyjvkAqoOHUcWNfmezYI1V8ft+l3nIKTaKt4uCci1lt
	 Pd1G7JlLLw9rXw7wLzcVnEIuqud/y3hxz1cTD3inGCts6FLMBl40bvjYeW3A7ZmDcm
	 D2LdiCvcXyX6tXwemYHky7+2dZls4ph3xayMZOyY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGathg033944
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:55 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:55 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrp123403;
	Tue, 23 Jan 2024 10:36:55 -0600
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
Subject: [PATCH 03/21] power: supply: ds2760: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:35 -0600
Message-ID: <20240123163653.384385-4-afd@ti.com>
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
 drivers/power/supply/ds2760_battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 40fba31be1744..7cf4ea06b5003 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -739,7 +739,7 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	if (current_accum)
 		ds2760_battery_set_current_accum(di, current_accum);
 
-	di->bat = power_supply_register(dev, &di->bat_desc, &psy_cfg);
+	di->bat = devm_power_supply_register(dev, &di->bat_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
 		dev_err(di->dev, "failed to register battery\n");
 		retval = PTR_ERR(di->bat);
@@ -762,7 +762,6 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	goto success;
 
 workqueue_failed:
-	power_supply_unregister(di->bat);
 batt_failed:
 di_alloc_failed:
 success:
@@ -777,7 +776,6 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 	cancel_delayed_work_sync(&di->monitor_work);
 	cancel_delayed_work_sync(&di->set_charged_work);
 	destroy_workqueue(di->monitor_wqueue);
-	power_supply_unregister(di->bat);
 }
 
 #ifdef CONFIG_OF
-- 
2.39.2


