Return-Path: <linux-kernel+bounces-35657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBAB8394E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C70AB27DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0D8003C;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fMzDX2z0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500D7FBA7;
	Tue, 23 Jan 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027825; cv=none; b=oLs12gCA0BiPekZADWRl48MzLH9qKSbkphYo0LF3Me9JKT/lCuPbusw9vz4sq5d7rZjwRNglwEK8VGKwzJuS3sOFwQMtlhRndfQIXq4p7rGrB9Wb0TivueMIHkHbwbJ1fbpCXuDUktoAEP/FvQJa0+vMuZYLvX8F+pz3GeTfxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027825; c=relaxed/simple;
	bh=myx2MpLW0BLIIV1WjqQSWc7I22jNcepmPeZLJ9LmvD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQFMgMfJB3zxzDr0gJUisjnQYNq8LhhFy+KFDbjwc2QnXjy8qumdiP/N1wPKDJfbw0RurA7T8TZrEgTouA1R7igqpxXcVe0Vsxfr0EAgUqlvzH20VtKPvXANcikjWDLwmA3QYdB3jCjR6AOeREwRp24twnmQ6wVOfkJhtHPj2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fMzDX2z0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGatNd049954;
	Tue, 23 Jan 2024 10:36:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027816;
	bh=s6LdQ0CqE6bsag94Q3BFy5Co7g4aAv5Nxljjo9epZBY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fMzDX2z0GAJwHAoBUe6Ike2S1/Ie+Vco4c1s3f0hciGHKUQVnvJMVzu9sH29IrFY4
	 ssTDxTp9z7/Lhr0zuZNOQ16qoCcYrUYzhdW9grQJW2yzTqs3zAdG1yVE/+eL7iANMJ
	 WX4ETDOQ9ixCMVbghM7Z21sfomiytP7v6HEZMKg8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGatvx004183
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:55 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:55 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrq123403;
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
Subject: [PATCH 04/21] power: supply: goldfish: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:36 -0600
Message-ID: <20240123163653.384385-5-afd@ti.com>
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
 drivers/power/supply/goldfish_battery.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index 8bb645ad1e5d5..479195e35d734 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -232,31 +232,22 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = data;
 
-	data->ac = power_supply_register(&pdev->dev, &ac_desc, &psy_cfg);
+	data->ac = devm_power_supply_register(&pdev->dev,
+					      &ac_desc,
+					      &psy_cfg);
 	if (IS_ERR(data->ac))
 		return PTR_ERR(data->ac);
 
-	data->battery = power_supply_register(&pdev->dev, &battery_desc,
-						&psy_cfg);
-	if (IS_ERR(data->battery)) {
-		power_supply_unregister(data->ac);
+	data->battery = devm_power_supply_register(&pdev->dev,
+						   &battery_desc,
+						   &psy_cfg);
+	if (IS_ERR(data->battery))
 		return PTR_ERR(data->battery);
-	}
-
-	platform_set_drvdata(pdev, data);
 
 	GOLDFISH_BATTERY_WRITE(data, BATTERY_INT_ENABLE, BATTERY_INT_MASK);
 	return 0;
 }
 
-static void goldfish_battery_remove(struct platform_device *pdev)
-{
-	struct goldfish_battery_data *data = platform_get_drvdata(pdev);
-
-	power_supply_unregister(data->battery);
-	power_supply_unregister(data->ac);
-}
-
 static const struct of_device_id goldfish_battery_of_match[] = {
 	{ .compatible = "google,goldfish-battery", },
 	{},
@@ -273,7 +264,6 @@ MODULE_DEVICE_TABLE(acpi, goldfish_battery_acpi_match);
 
 static struct platform_driver goldfish_battery_device = {
 	.probe		= goldfish_battery_probe,
-	.remove_new	= goldfish_battery_remove,
 	.driver = {
 		.name = "goldfish-battery",
 		.of_match_table = goldfish_battery_of_match,
-- 
2.39.2


