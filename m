Return-Path: <linux-kernel+bounces-35675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010A83950C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF86B29778
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0C86AE3;
	Tue, 23 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JCcERF7c"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B587F7DE;
	Tue, 23 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027830; cv=none; b=BtQlPEoCYObVPOGBvVwASc9+iVi6plE6d5Xtxjq/1HuiPgF1GtmBIuyprTw6TytfM2TFtZka6R88nP4vfTHeLnr2hsKRukWEqGmoC8X5DW01VBwTK0vGKsyb0GgkAmW+Hq6SnYm7+OvqB/TWuBUWOAPCa+N+8cPvSJvhr7hwUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027830; c=relaxed/simple;
	bh=6/dLm2MjBZeLAHh+W3gQoWesu1TbtOA/vZ3gQb2SLuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2dsJ1N3XnChtvf+Q5uJmjIOUra8Y/2tnHzsdTBkAq++iJ6nW0YsDHpUPN+3+/IZn8EsbYwTLIKKfGBr7J7dkWK/HmKdiP3Lk7RWTkVopr5GrZ3jTfW+cveADbgYFV/1Svo2WqhNEGc3jKu9Hh4tHKpyrY1MYw/f7l07ItJ+BwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JCcERF7c; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGb0vx094143;
	Tue, 23 Jan 2024 10:37:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027820;
	bh=zL7aZs11+xEUFcKlyHOFpkpjBIT3t+hkCmsvfTqmT94=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JCcERF7cRlA4mIEjiFkSaIyqQ2Q3/NjrRSASUv1vdEJyXtE5lZiesEUkmQ6Ww5Wfz
	 iOOGQZPvR6dYqICJeDgifUf9lLIJ/NWAWj0wjIzjmBOsB3GWOF2H/LuNZdYS9vjtES
	 3Qo7Hv5a6hT1yTdqvbZpIPF/wEw0MUGxoXThrphI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGb0Bo000610
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:37:00 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:37:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:37:00 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars6123403;
	Tue, 23 Jan 2024 10:36:59 -0600
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
Subject: [PATCH 18/21] power: supply: rx51: Use devm_iio_channel_get() helper
Date: Tue, 23 Jan 2024 10:36:50 -0600
Message-ID: <20240123163653.384385-19-afd@ti.com>
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
 drivers/power/supply/rx51_battery.c | 45 +++++++----------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index e2bfc81f0fd97..d532c670661b6 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -192,7 +192,6 @@ static int rx51_battery_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
 	struct rx51_device_info *di;
-	int ret;
 
 	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
@@ -209,41 +208,23 @@ static int rx51_battery_probe(struct platform_device *pdev)
 
 	psy_cfg.drv_data = di;
 
-	di->channel_temp = iio_channel_get(di->dev, "temp");
-	if (IS_ERR(di->channel_temp)) {
-		ret = PTR_ERR(di->channel_temp);
-		goto error;
-	}
+	di->channel_temp = devm_iio_channel_get(di->dev, "temp");
+	if (IS_ERR(di->channel_temp))
+		return PTR_ERR(di->channel_temp);
 
-	di->channel_bsi  = iio_channel_get(di->dev, "bsi");
-	if (IS_ERR(di->channel_bsi)) {
-		ret = PTR_ERR(di->channel_bsi);
-		goto error_channel_temp;
-	}
+	di->channel_bsi  = devm_iio_channel_get(di->dev, "bsi");
+	if (IS_ERR(di->channel_bsi))
+		return PTR_ERR(di->channel_bsi);
 
-	di->channel_vbat = iio_channel_get(di->dev, "vbat");
-	if (IS_ERR(di->channel_vbat)) {
-		ret = PTR_ERR(di->channel_vbat);
-		goto error_channel_bsi;
-	}
+	di->channel_vbat = devm_iio_channel_get(di->dev, "vbat");
+	if (IS_ERR(di->channel_vbat))
+		return PTR_ERR(di->channel_vbat);
 
 	di->bat = power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
-	if (IS_ERR(di->bat)) {
-		ret = PTR_ERR(di->bat);
-		goto error_channel_vbat;
-	}
+	if (IS_ERR(di->bat))
+		return PTR_ERR(di->bat);
 
 	return 0;
-
-error_channel_vbat:
-	iio_channel_release(di->channel_vbat);
-error_channel_bsi:
-	iio_channel_release(di->channel_bsi);
-error_channel_temp:
-	iio_channel_release(di->channel_temp);
-error:
-
-	return ret;
 }
 
 static void rx51_battery_remove(struct platform_device *pdev)
@@ -251,10 +232,6 @@ static void rx51_battery_remove(struct platform_device *pdev)
 	struct rx51_device_info *di = platform_get_drvdata(pdev);
 
 	power_supply_unregister(di->bat);
-
-	iio_channel_release(di->channel_vbat);
-	iio_channel_release(di->channel_bsi);
-	iio_channel_release(di->channel_temp);
 }
 
 #ifdef CONFIG_OF
-- 
2.39.2


