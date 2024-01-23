Return-Path: <linux-kernel+bounces-35669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58B839503
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09ADB28FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033E85C77;
	Tue, 23 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="En/XbSYb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBB80046;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027829; cv=none; b=P6eKtePJbOun7wXPcd16AETVBr9Otl42VQMD+H3FXlVyoYryFHTCAmOFgASxri5zBSTKiz5fH6psdXNCko3E/MIWXM9UipsGK5Wy6N51sEKE/a5j4Ox54CQbhq1YnmKRge7XrR/ysaJUsvo3GH5OefzI/zGi/NP8TcnYheGIN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027829; c=relaxed/simple;
	bh=AOscs8QIG573GTnqalFMMwHtcQ8ONmRuwieK8uqlR40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryqcfJRfO5cYPeOLlz/ywwwWi/HdvmSoGxVTM+mRVyTwvSuKJNvmtAtLZJxot1vYfvp8tMPj7HLm7BhWH3wXFR0QLwWPuKWoGCpX2+PDot84eCqcfX+XyyuEXJdOogkSGG1kF0Ml7N9AIgmIH5Bc9e4VHGwYF8gY4qp4ocOqwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=En/XbSYb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGax8N094134;
	Tue, 23 Jan 2024 10:36:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027819;
	bh=NynlMJZVVWmFK6HEqJQ06332dhB5iMXyjOa26cOux3g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=En/XbSYbkpAcJ6Xir3CNLJiY1RSv1Tblem41AtTRy3eVfDAYyubRm40jysHFe5o5e
	 yR7dxzI1qPLHTXBJQ5jwyiTPbYEe/0eYi8DXg4GB4tIi4PfEnV8nFwypqppuesg6CP
	 6i/sCNkGkSQt4pv5UKakL8dTC5VASwYwq1MsjC+g=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGaxU5119736
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:59 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:59 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars3123403;
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
Subject: [PATCH 15/21] power: supply: wm8350: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:47 -0600
Message-ID: <20240123163653.384385-16-afd@ti.com>
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
 drivers/power/supply/wm8350_power.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index f23b4f5343bc1..9b0010b28cafc 100644
--- a/drivers/power/supply/wm8350_power.c
+++ b/drivers/power/supply/wm8350_power.c
@@ -540,22 +540,17 @@ static int wm8350_power_probe(struct platform_device *pdev)
 	struct wm8350_charger_policy *policy = power->policy;
 	int ret;
 
-	power->ac = power_supply_register(&pdev->dev, &wm8350_ac_desc, NULL);
+	power->ac = devm_power_supply_register(&pdev->dev, &wm8350_ac_desc, NULL);
 	if (IS_ERR(power->ac))
 		return PTR_ERR(power->ac);
 
-	power->battery = power_supply_register(&pdev->dev, &wm8350_battery_desc,
-					       NULL);
-	if (IS_ERR(power->battery)) {
-		ret = PTR_ERR(power->battery);
-		goto battery_failed;
-	}
+	power->battery = devm_power_supply_register(&pdev->dev, &wm8350_battery_desc, NULL);
+	if (IS_ERR(power->battery))
+		return PTR_ERR(power->battery);
 
-	power->usb = power_supply_register(&pdev->dev, &wm8350_usb_desc, NULL);
-	if (IS_ERR(power->usb)) {
-		ret = PTR_ERR(power->usb);
-		goto usb_failed;
-	}
+	power->usb = devm_power_supply_register(&pdev->dev, &wm8350_usb_desc, NULL);
+	if (IS_ERR(power->usb))
+		return PTR_ERR(power->usb);
 
 	ret = device_create_file(&pdev->dev, &dev_attr_charger_state);
 	if (ret < 0)
@@ -569,13 +564,6 @@ static int wm8350_power_probe(struct platform_device *pdev)
 		wm8350_reg_lock(wm8350);
 	}
 
-	return ret;
-
-usb_failed:
-	power_supply_unregister(power->battery);
-battery_failed:
-	power_supply_unregister(power->ac);
-
 	return ret;
 }
 
@@ -586,9 +574,6 @@ static void wm8350_power_remove(struct platform_device *pdev)
 
 	free_charger_irq(wm8350);
 	device_remove_file(&pdev->dev, &dev_attr_charger_state);
-	power_supply_unregister(power->battery);
-	power_supply_unregister(power->ac);
-	power_supply_unregister(power->usb);
 }
 
 static struct platform_driver wm8350_power_driver = {
-- 
2.39.2


