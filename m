Return-Path: <linux-kernel+bounces-35666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D45839500
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50EE1C27C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EAF85C5E;
	Tue, 23 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="glIL0hdb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9F811E9;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027828; cv=none; b=T/JzsTvBwjz23ci0jcbboShzZq9OK97eLtc8dLoe/qVkJILe17NrVMoJrlHoidjWi0GPbmaP+F+owbO3A0NRL1Fzi2+Q3FUvFO3tBn1ImlvlRMkIrrYHyTuhAptxIdUYXAeSPIyc3aaS9/P5ZbC95U3/hRppk2IXvtVKH2yXLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027828; c=relaxed/simple;
	bh=Mt9VGXSLpx6lU+a/atqtbnv9Q7Fuz7Ts4+Nnj4wDzCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iae2eCHDf+J0ANMo/TXJb2SGf9AXh0G++/xItbrbPnqxFsfNmKApK8+lTb/Bz0rYAIuK06E6xdOzAii5QQbJLYU+ghAKB+ElQU4TUe6E25ELoEk9fPNpa+uYkEQGzswF7B6FLgrmYbJ+NIIDpWlFo3msiBjXwrm9X+dH7s57z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=glIL0hdb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGb1HT094151;
	Tue, 23 Jan 2024 10:37:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027821;
	bh=E33CzJiobEDNF9PypNy3HQMQ/t8tZZOrwMdlqCyg1Ws=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=glIL0hdb2lSd4PuTlHy5p117GvpPZ7tYFFyGGzjXFeLmpZ+tV4gFIYb3UUTM5zHmK
	 6mPyx1HreOTYf853E9hcrgLKapJGRFub3y4z+jkbejNwntXsyKK4qTNf204BwsZJSL
	 cwy8ou+9+48Ra0DWXGAk0XClmhlOwlH8hyBWNXd8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGb1X6004284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:37:01 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:37:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:37:00 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars8123403;
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
Subject: [PATCH 20/21] power: supply: twl4030_madc: Use devm_iio_channel_get() helper
Date: Tue, 23 Jan 2024 10:36:52 -0600
Message-ID: <20240123163653.384385-21-afd@ti.com>
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

Use the device lifecycle managed get function. This helps prevent
mistakes like releasing out of order in cleanup functions and
forgetting to release on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/twl4030_madc_battery.c | 44 ++++++---------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index 33106476bea2c..cd9e94134ab21 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -188,30 +188,23 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 	struct twl4030_madc_battery *twl4030_madc_bat;
 	struct twl4030_madc_bat_platform_data *pdata = pdev->dev.platform_data;
 	struct power_supply_config psy_cfg = {};
-	int ret = 0;
 
 	twl4030_madc_bat = devm_kzalloc(&pdev->dev, sizeof(*twl4030_madc_bat),
 				GFP_KERNEL);
 	if (!twl4030_madc_bat)
 		return -ENOMEM;
 
-	twl4030_madc_bat->channel_temp = iio_channel_get(&pdev->dev, "temp");
-	if (IS_ERR(twl4030_madc_bat->channel_temp)) {
-		ret = PTR_ERR(twl4030_madc_bat->channel_temp);
-		goto err;
-	}
+	twl4030_madc_bat->channel_temp = devm_iio_channel_get(&pdev->dev, "temp");
+	if (IS_ERR(twl4030_madc_bat->channel_temp))
+		return PTR_ERR(twl4030_madc_bat->channel_temp);
 
-	twl4030_madc_bat->channel_ichg = iio_channel_get(&pdev->dev, "ichg");
-	if (IS_ERR(twl4030_madc_bat->channel_ichg)) {
-		ret = PTR_ERR(twl4030_madc_bat->channel_ichg);
-		goto err_temp;
-	}
+	twl4030_madc_bat->channel_ichg = devm_iio_channel_get(&pdev->dev, "ichg");
+	if (IS_ERR(twl4030_madc_bat->channel_ichg))
+		return PTR_ERR(twl4030_madc_bat->channel_ichg);
 
-	twl4030_madc_bat->channel_vbat = iio_channel_get(&pdev->dev, "vbat");
-	if (IS_ERR(twl4030_madc_bat->channel_vbat)) {
-		ret = PTR_ERR(twl4030_madc_bat->channel_vbat);
-		goto err_ichg;
-	}
+	twl4030_madc_bat->channel_vbat = devm_iio_channel_get(&pdev->dev, "vbat");
+	if (IS_ERR(twl4030_madc_bat->channel_vbat))
+		return PTR_ERR(twl4030_madc_bat->channel_vbat);
 
 	/* sort charging and discharging calibration data */
 	sort(pdata->charging, pdata->charging_size,
@@ -227,21 +220,10 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 	twl4030_madc_bat->psy = power_supply_register(&pdev->dev,
 						      &twl4030_madc_bat_desc,
 						      &psy_cfg);
-	if (IS_ERR(twl4030_madc_bat->psy)) {
-		ret = PTR_ERR(twl4030_madc_bat->psy);
-		goto err_vbat;
-	}
+	if (IS_ERR(twl4030_madc_bat->psy))
+		return PTR_ERR(twl4030_madc_bat->psy);
 
 	return 0;
-
-err_vbat:
-	iio_channel_release(twl4030_madc_bat->channel_vbat);
-err_ichg:
-	iio_channel_release(twl4030_madc_bat->channel_ichg);
-err_temp:
-	iio_channel_release(twl4030_madc_bat->channel_temp);
-err:
-	return ret;
 }
 
 static void twl4030_madc_battery_remove(struct platform_device *pdev)
@@ -249,10 +231,6 @@ static void twl4030_madc_battery_remove(struct platform_device *pdev)
 	struct twl4030_madc_battery *bat = platform_get_drvdata(pdev);
 
 	power_supply_unregister(bat->psy);
-
-	iio_channel_release(bat->channel_vbat);
-	iio_channel_release(bat->channel_ichg);
-	iio_channel_release(bat->channel_temp);
 }
 
 static struct platform_driver twl4030_madc_battery_driver = {
-- 
2.39.2


