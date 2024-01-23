Return-Path: <linux-kernel+bounces-35663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEFA8394F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE4EB2863A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D481AA3;
	Tue, 23 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n9OE0G72"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E87FBC4;
	Tue, 23 Jan 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027826; cv=none; b=Ke8rgoniTtxt5o9YRg6GDODowY2fDmTggrBqzVfRWhVFf4XQ7R605iF04B9ZphqWGIVgDiWrrvfhPOE9hD8MeCzrSdzFitXs6KJyeO02kzXWCYTaHf/1Q/6ttWzlOgVkBwosOgLLJ8LT3qZH9u2rNQ6m7PJUwDge0pa+YM8jwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027826; c=relaxed/simple;
	bh=o/7DG4vBlzbT1FI27QNYk7vmJrSbn/8TuaSa9UDe3C0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b80rw+7O8ZBWmc2/Pvh/cRG1wOoXlSPA6PHAoZ4qOyBjmsv52JmgMPBzS4wHHsOo/N8fl3fq9cSYdS9n/GeIK+jGnbpGMXgF5PvkVD637gfcQ9NAUZzQiX39yRbsMv8qpj1SdZfb4OzDba4GQvX6j07eDVG7aA0T9Pt/y8Dgn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n9OE0G72; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGavTO049967;
	Tue, 23 Jan 2024 10:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027817;
	bh=8VQ1S7LYK+8NKpjBZbOiLIVCGSw9MxS0HGGM8ySLLdo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n9OE0G72O6wRJ/XypFIUG8rM1NjlNa5kzdfmbGYd7zAGfxOS8sey+IJdjSs5RocbF
	 /XNOcqmiJrjzLM3xYqqfspkNoC5A22TdMXgpqZSqG0BTdvk8qKqY+7frSCD7JBCWtE
	 UpTQyNfCbQ4CFqDg+twN1LZDHguyuZtrD0uzL2Ko=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGavU8000588
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:57 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:57 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrw123403;
	Tue, 23 Jan 2024 10:36:57 -0600
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
Subject: [PATCH 10/21] power: supply: pcf50633: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:42 -0600
Message-ID: <20240123163653.384385-11-afd@ti.com>
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
 drivers/power/supply/pcf50633-charger.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index 950e30917c638..0e980522fee51 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -404,9 +404,9 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 	psy_cfg.drv_data		= mbc;
 
 	/* Create power supplies */
-	mbc->adapter = power_supply_register(&pdev->dev,
-					     &pcf50633_mbc_adapter_desc,
-					     &psy_cfg);
+	mbc->adapter = devm_power_supply_register(&pdev->dev,
+						  &pcf50633_mbc_adapter_desc,
+						  &psy_cfg);
 	if (IS_ERR(mbc->adapter)) {
 		dev_err(mbc->pcf->dev, "failed to register adapter\n");
 		return PTR_ERR(mbc->adapter);
@@ -415,20 +415,19 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 	usb_psy_cfg = psy_cfg;
 	usb_psy_cfg.attr_grp = pcf50633_mbc_sysfs_groups;
 
-	mbc->usb = power_supply_register(&pdev->dev, &pcf50633_mbc_usb_desc,
-					 &usb_psy_cfg);
+	mbc->usb = devm_power_supply_register(&pdev->dev,
+					      &pcf50633_mbc_usb_desc,
+					      &usb_psy_cfg);
 	if (IS_ERR(mbc->usb)) {
 		dev_err(mbc->pcf->dev, "failed to register usb\n");
-		power_supply_unregister(mbc->adapter);
 		return PTR_ERR(mbc->usb);
 	}
 
-	mbc->ac = power_supply_register(&pdev->dev, &pcf50633_mbc_ac_desc,
-					&psy_cfg);
+	mbc->ac = devm_power_supply_register(&pdev->dev,
+					     &pcf50633_mbc_ac_desc,
+					     &psy_cfg);
 	if (IS_ERR(mbc->ac)) {
 		dev_err(mbc->pcf->dev, "failed to register ac\n");
-		power_supply_unregister(mbc->adapter);
-		power_supply_unregister(mbc->usb);
 		return PTR_ERR(mbc->ac);
 	}
 
@@ -449,10 +448,6 @@ static void pcf50633_mbc_remove(struct platform_device *pdev)
 	/* Remove IRQ handlers */
 	for (i = 0; i < ARRAY_SIZE(mbc_irq_handlers); i++)
 		pcf50633_free_irq(mbc->pcf, mbc_irq_handlers[i]);
-
-	power_supply_unregister(mbc->usb);
-	power_supply_unregister(mbc->adapter);
-	power_supply_unregister(mbc->ac);
 }
 
 static struct platform_driver pcf50633_mbc_driver = {
-- 
2.39.2


