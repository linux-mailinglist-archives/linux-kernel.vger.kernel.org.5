Return-Path: <linux-kernel+bounces-35664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91F8394F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D928C28B297
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B4823C2;
	Tue, 23 Jan 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B1/FLile"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8577FBD0;
	Tue, 23 Jan 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027826; cv=none; b=iB6lGf6rW9x4UZOtzYQZ7BVC27LoeKfmHRVyZ2j3/5DD6jrt2MuQbJbQzZP7Xj9BjNSBGRFPaPP+b+Zd9URoWrmhVNMoHDTWvmj3UOl9qt53ZLuy79eoTYmuYoDPLOeZbdB8LDVZygBn5dBzZzwhDHEtguXhot3t3djePUoGRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027826; c=relaxed/simple;
	bh=SG0tJsH3HoStXzTexJWiqyPg/30P2HNXmlKCalFw/ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xw5TonjbXf4O9Fpg0+OpPMIqucqgGR6QW8WjBONAVRatQuF27N1RXK20Kq4jPU7wP0esd6KI4Rw0ZuWm5vZeJ5FU5rRglthD3KbtxNeOpbTT4mL4NoVJ+M14kPlxx1A6vyMZRlsOu/6LgtO3TGGTxk5JDOWTeoO2iz9ikEXxn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B1/FLile; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGaupR049958;
	Tue, 23 Jan 2024 10:36:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027816;
	bh=2JPyRvYo9ngjCxHxSLyHLP9idzp5Un5sLiEDVZ9MTlI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=B1/FLilebZE7BUWx0aOmBHKLYe1nlgLipTErQFgD99Qa/4aX7JEuvWUxI3kFQHOoP
	 3j0EVoP3DyIn+f14LFZusUOLwMjJvq8DID4DOYRgY42PBp3h8YPBqBCAQMv2A3GaUP
	 eIJ0AAj8vLLvKgBl8fwwR0JPRHLDWMb0QCTtxuZQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGaupt004193
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:56 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:56 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrs123403;
	Tue, 23 Jan 2024 10:36:56 -0600
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
Subject: [PATCH 06/21] power: supply: lp8788: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:38 -0600
Message-ID: <20240123163653.384385-7-afd@ti.com>
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
 drivers/power/supply/lp8788-charger.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 2c81be82a41a4..72b170b4ac46a 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -406,12 +406,6 @@ static const struct power_supply_desc lp8788_psy_battery_desc = {
 	.get_property	= lp8788_battery_get_property,
 };
 
-static void lp8788_psy_unregister(struct lp8788_charger *pchg)
-{
-	power_supply_unregister(pchg->battery);
-	power_supply_unregister(pchg->charger);
-}
-
 static void lp8788_charger_event(struct work_struct *work)
 {
 	struct lp8788_charger *pchg =
@@ -666,18 +660,16 @@ static int lp8788_psy_register(struct platform_device *pdev,
 	charger_cfg.supplied_to = battery_supplied_to;
 	charger_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	pchg->charger = power_supply_register(&pdev->dev,
-					      &lp8788_psy_charger_desc,
-					      &charger_cfg);
+	pchg->charger = devm_power_supply_register(&pdev->dev,
+						   &lp8788_psy_charger_desc,
+						   &charger_cfg);
 	if (IS_ERR(pchg->charger))
 		return -EPERM;
 
-	pchg->battery = power_supply_register(&pdev->dev,
-					      &lp8788_psy_battery_desc, NULL);
-	if (IS_ERR(pchg->battery)) {
-		power_supply_unregister(pchg->charger);
+	pchg->battery = devm_power_supply_register(&pdev->dev,
+						   &lp8788_psy_battery_desc, NULL);
+	if (IS_ERR(pchg->battery))
 		return -EPERM;
-	}
 
 	return 0;
 }
@@ -720,7 +712,6 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 
 	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
-	lp8788_psy_unregister(pchg);
 }
 
 static struct platform_driver lp8788_charger_driver = {
-- 
2.39.2


