Return-Path: <linux-kernel+bounces-35665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994298394F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D8D28AD95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4133823C4;
	Tue, 23 Jan 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NJ6tdGU1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1898002A;
	Tue, 23 Jan 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027827; cv=none; b=oSMsLCwBEDw7M7fVr5fHJIdhDDHrmioko455u3/02UelAJ5NO0NOqrlB/H8TiAEPRdi+HOjoBQUK0UgbwYtJ+qRgz19SyXi15ZXW2nrHeTPNjTSaC2QfegczMuzBCvjP6VGc9ACFY1xoFbV09UFVtv4yvUp946pNK9gq3F9P/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027827; c=relaxed/simple;
	bh=bHb2knvd146pNFVcG5N5iKz+RCtUYH/df5O6GziDkaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVQ2Fp1iKFRezAd9BAg1abRpoZkcOs3NCBUxpgYwwwzbs1n1geJ2J5Ad/R2FdmBy5d0Sd3LoV7DsRmqaf2qoupBw4PaErd0peXnVlgYbjfaLC4COhttZVFVf66jXUWvyVuOP55UraAelysRG11XysM6RVSGY8AG2IVKkrPwqHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NJ6tdGU1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGaxNE095654;
	Tue, 23 Jan 2024 10:36:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027819;
	bh=83SpcOyjCoqAmqeGTJTVnxyk1THrczdzUYeXisGgzPA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NJ6tdGU1KMfeefTFAwsWjeZ9hFvFCwZzf5apwd91qgYVnm1wYWruXH7Is3ax7gd98
	 d/LY64ImgDfUS56O4MhpDZmmcuyF6mAAZezCY+KIdedVc/FUhPPwswvNl2remJWd5Z
	 HQrrDuPyzCifZO9TPg3J938g3HKfhjGPz1YcWa94=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGax4R000602
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:59 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:58 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars2123403;
	Tue, 23 Jan 2024 10:36:58 -0600
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
Subject: [PATCH 14/21] power: supply: wm831x: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:46 -0600
Message-ID: <20240123163653.384385-15-afd@ti.com>
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
 drivers/power/supply/wm831x_power.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/wm831x_power.c b/drivers/power/supply/wm831x_power.c
index e49b01ee5f3ef..d56e499ac59fb 100644
--- a/drivers/power/supply/wm831x_power.c
+++ b/drivers/power/supply/wm831x_power.c
@@ -570,8 +570,9 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	power->wall_desc.properties = wm831x_wall_props;
 	power->wall_desc.num_properties = ARRAY_SIZE(wm831x_wall_props);
 	power->wall_desc.get_property = wm831x_wall_get_prop;
-	power->wall = power_supply_register(&pdev->dev, &power->wall_desc,
-					    NULL);
+	power->wall = devm_power_supply_register(&pdev->dev,
+						 &power->wall_desc,
+						 NULL);
 	if (IS_ERR(power->wall)) {
 		ret = PTR_ERR(power->wall);
 		goto err;
@@ -582,7 +583,9 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	power->usb_desc.properties = wm831x_usb_props;
 	power->usb_desc.num_properties = ARRAY_SIZE(wm831x_usb_props);
 	power->usb_desc.get_property = wm831x_usb_get_prop;
-	power->usb = power_supply_register(&pdev->dev, &power->usb_desc, NULL);
+	power->usb = devm_power_supply_register(&pdev->dev,
+						&power->usb_desc,
+						NULL);
 	if (IS_ERR(power->usb)) {
 		ret = PTR_ERR(power->usb);
 		goto err_wall;
@@ -599,9 +602,9 @@ static int wm831x_power_probe(struct platform_device *pdev)
 		power->battery_desc.num_properties = ARRAY_SIZE(wm831x_bat_props);
 		power->battery_desc.get_property = wm831x_bat_get_prop;
 		power->battery_desc.use_for_apm = 1;
-		power->battery = power_supply_register(&pdev->dev,
-						       &power->battery_desc,
-						       NULL);
+		power->battery = devm_power_supply_register(&pdev->dev,
+							    &power->battery_desc,
+							    NULL);
 		if (IS_ERR(power->battery)) {
 			ret = PTR_ERR(power->battery);
 			goto err_usb;
@@ -684,12 +687,8 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
 	free_irq(irq, power);
 err_battery:
-	if (power->have_battery)
-		power_supply_unregister(power->battery);
 err_usb:
-	power_supply_unregister(power->usb);
 err_wall:
-	power_supply_unregister(power->wall);
 err:
 	return ret;
 }
@@ -717,11 +716,6 @@ static void wm831x_power_remove(struct platform_device *pdev)
 
 	irq = wm831x_irq(wm831x, platform_get_irq_byname(pdev, "SYSLO"));
 	free_irq(irq, wm831x_power);
-
-	if (wm831x_power->have_battery)
-		power_supply_unregister(wm831x_power->battery);
-	power_supply_unregister(wm831x_power->wall);
-	power_supply_unregister(wm831x_power->usb);
 }
 
 static struct platform_driver wm831x_power_driver = {
-- 
2.39.2


