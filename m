Return-Path: <linux-kernel+bounces-35674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6E839509
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF81C25611
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951686AC5;
	Tue, 23 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cj8rb6a3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E824823A0;
	Tue, 23 Jan 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027830; cv=none; b=cOhtVNDO6+hCj2W7rO21bJkYtnY9j4appuIrbVkd/rKs2kIWQ+++bscNkGafOmEGXxY7lIMe4FQ0YXlMfKm19n3/Nkbylz8PNyZp4w4NXrvSZHH0/QfZ248kN/LLowmqkEJuwd/ZinKWGPmaYFZIypUbcJepVV+QzSUzXTB44fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027830; c=relaxed/simple;
	bh=dYCrje2ssLc36AN+z3buna/SfGdx7nGnIMP/hS0/SRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFTuMaAbZ/QMzJ96CZkCJOdqLRG65uY7pcSbGNAJ8xTP5exnWXIa75PSKVBCL+Ki6qlY4uCqpP0qp8zMblNrw3xMyA8ntf48mwOwgLkBvjgbSJDx2U3WovabfJ9OkwknpoWNKb/rVvOfn6R7BzqX3/33h0mMS90DJ/H2Oh9k6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cj8rb6a3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGb0dA095659;
	Tue, 23 Jan 2024 10:37:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027820;
	bh=UvtASd/asXTA/GOqfe+7E7h/Aqkvx5Cby7w80f0NLYY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Cj8rb6a3/vaYXI793H/zBsa0IaOH0Q/dpt5L9lFODzWKTCnt72F7OoULybes21/+4
	 tfnoU+/AIWXVDvjfuAc20FRmd9sppaqGlFujLHnd3t6pBXhcDkZDO2l7CFtWkPHngE
	 wI8zxczq65iMZGufXe1mY2xudM66G1CO9NJVt9QE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGb0qR119754
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:37:00 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:37:00 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars5123403;
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
Subject: [PATCH 17/21] power: supply: da9150: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:49 -0600
Message-ID: <20240123163653.384385-18-afd@ti.com>
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
 drivers/power/supply/da9150-charger.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index 77e2d42382e45..b13cecd84f589 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -538,15 +538,13 @@ static int da9150_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->vbat_chan);
 
 	/* Register power supplies */
-	charger->usb = power_supply_register(dev, &usb_desc, NULL);
+	charger->usb = devm_power_supply_register(dev, &usb_desc, NULL);
 	if (IS_ERR(charger->usb))
 		return PTR_ERR(charger->usb);
 
-	charger->battery = power_supply_register(dev, &battery_desc, NULL);
-	if (IS_ERR(charger->battery)) {
-		ret = PTR_ERR(charger->battery);
-		goto battery_fail;
-	}
+	charger->battery = devm_power_supply_register(dev, &battery_desc, NULL);
+	if (IS_ERR(charger->battery))
+		return PTR_ERR(charger->battery);
 
 	/* Get initial online supply */
 	reg = da9150_reg_read(da9150, DA9150_STATUS_H);
@@ -606,8 +604,6 @@ static int da9150_charger_probe(struct platform_device *pdev)
 chg_irq_fail:
 	if (!IS_ERR_OR_NULL(charger->usb_phy))
 		usb_unregister_notifier(charger->usb_phy, &charger->otg_nb);
-battery_fail:
-	power_supply_unregister(charger->usb);
 
 	return ret;
 }
@@ -633,9 +629,6 @@ static void da9150_charger_remove(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(charger->usb_phy))
 		usb_unregister_notifier(charger->usb_phy, &charger->otg_nb);
 	cancel_work_sync(&charger->otg_work);
-
-	power_supply_unregister(charger->battery);
-	power_supply_unregister(charger->usb);
 }
 
 static struct platform_driver da9150_charger_driver = {
-- 
2.39.2


