Return-Path: <linux-kernel+bounces-35671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1D839506
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15649290EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD686146;
	Tue, 23 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sj02YRbE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCE811F0;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027829; cv=none; b=TKrN5nsQ+Ss8yF/O+VjCBf6irDkDfCh8WFIyLaGpeOvSnY/dYtoXCUuL5vMYNJIcPQYqYxQ6eLfUelUbuSbX7qp+lw3eD62quRmk9eOKmOFv0IbIThiiAaiCDco6KIVaQvrAltDU/EGXHxt3T0MiDQN4wLlk8lsv9R0c5Dc3ZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027829; c=relaxed/simple;
	bh=k7Zat9ihsdYcIrX3WmyfcTU3YEIt3v7FOQBP7PuRDtE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhnPgArV5c1jIfK88UYTAdcQKUgvu1Wmcw6hNTQfh1zMqOLbP1JphAFSqQilDTDuuvPwGY+/n3XnvBZOWECIPPxaUDrGALY+X1Izw9XuZRc+l+ZP9lLs5/gtGZ5xawA4UIKJACRjxyCyZDybIsHU8mHM64mjv00ncArd6GW0T14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sj02YRbE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGb0tj094147;
	Tue, 23 Jan 2024 10:37:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027820;
	bh=cvG+uaN/7N2Dit5c/n8AJ+cABCuXl9sFCTAkKuB72r0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sj02YRbExzLvuKsK+4ULS9bVZrrARaNgzsM2ezYrdS/7OgsyanB8cD4D6ubZRC2qx
	 KAUvtzEe8q66a/n2iuafnnvwFUEVo1tkIz4oMfM8aKX1geRWMt+KsjTKC1SYO4RDxi
	 BgZaf+z6dEiLOP7ZvI2zd6rpWNho4WJKtiM+38D4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGb0Np000624
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:37:00 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:37:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:37:00 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars7123403;
	Tue, 23 Jan 2024 10:37:00 -0600
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
Subject: [PATCH 19/21] power: supply: rx51: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:51 -0600
Message-ID: <20240123163653.384385-20-afd@ti.com>
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
 drivers/power/supply/rx51_battery.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index d532c670661b6..7cdcd415e8684 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -197,8 +197,6 @@ static int rx51_battery_probe(struct platform_device *pdev)
 	if (!di)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, di);
-
 	di->dev = &pdev->dev;
 	di->bat_desc.name = "rx51-battery";
 	di->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
@@ -220,20 +218,13 @@ static int rx51_battery_probe(struct platform_device *pdev)
 	if (IS_ERR(di->channel_vbat))
 		return PTR_ERR(di->channel_vbat);
 
-	di->bat = power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
+	di->bat = devm_power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
 	if (IS_ERR(di->bat))
 		return PTR_ERR(di->bat);
 
 	return 0;
 }
 
-static void rx51_battery_remove(struct platform_device *pdev)
-{
-	struct rx51_device_info *di = platform_get_drvdata(pdev);
-
-	power_supply_unregister(di->bat);
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id n900_battery_of_match[] = {
 	{.compatible = "nokia,n900-battery", },
@@ -244,7 +235,6 @@ MODULE_DEVICE_TABLE(of, n900_battery_of_match);
 
 static struct platform_driver rx51_battery_driver = {
 	.probe = rx51_battery_probe,
-	.remove_new = rx51_battery_remove,
 	.driver = {
 		.name = "rx51-battery",
 		.of_match_table = of_match_ptr(n900_battery_of_match),
-- 
2.39.2


