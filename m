Return-Path: <linux-kernel+bounces-43386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D60C8412FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF71F22D72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC547603E;
	Mon, 29 Jan 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wjpUx0Rc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813F44369;
	Mon, 29 Jan 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554978; cv=none; b=fHAfntgeItiXfBLtqqP9Ul4actl9MEMOjxVTuLxE2CM23uepG4qJwaOJJb/BxHVnFt7moNmD70LC2L5wiJ7OjKL9RGG9sIcUVZFvyu9XIow4arlmtyFxu5PuWmmm0jMj9W0q+z5x+S9kxbBC2gZ0DPrLXXsJS4mAY9UEAmm2K38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554978; c=relaxed/simple;
	bh=5QGHM1zurbmGA8dFzn46raO8FDocMpyHXLg4dKM+p9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRL5Tn9L99CevScxu0xqgkkRwgeMECpYoOxzYN0rhiMhfJZ1r+gNaiY2xIJBo9FXMsNkXaswtxr6BmxrPfK12ch89DyEh0V7YD9L147WgnlvqO+yw/SGhwrBajKSbeQsykdh5aNfAZTzjDR2DzzYKnncpZ5wpsX6FLXwoa9w704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wjpUx0Rc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2nuc101906;
	Mon, 29 Jan 2024 13:02:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706554969;
	bh=mZkc3kQ+4YitDfJtxHyKhF8TyAaiE/IdniF+J5ZkTEk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wjpUx0RcUuwHr4oZLdzlXrn9qGE+PcKcWwKKi/DimEC/u6ENJmiPBdtqsmCk5GKUC
	 FQU+IKmJ/ECn6taxxxhZJg9WWMl6QMIbTwIfmOuXqv24EYcJ3NFN9D6Tp0eISysu4W
	 IYF9f2Az1nBINiRnE5bXnwMnhAgjNvGL5wg341c4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TJ2n76053324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 13:02:49 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 13:02:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 13:02:48 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2ldp003658;
	Mon, 29 Jan 2024 13:02:48 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2 4/4] power: supply: wm8350: Use devm_power_supply_register() helper
Date: Mon, 29 Jan 2024 13:02:46 -0600
Message-ID: <20240129190246.73067-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129190246.73067-1-afd@ti.com>
References: <20240129190246.73067-1-afd@ti.com>
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
 drivers/power/supply/wm8350_power.c | 30 +++++++----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/wm8350_power.c b/drivers/power/supply/wm8350_power.c
index f23b4f5343bc1..3f79ab6f6abf1 100644
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
@@ -569,26 +564,15 @@ static int wm8350_power_probe(struct platform_device *pdev)
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
 
 static void wm8350_power_remove(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
-	struct wm8350_power *power = &wm8350->power;
 
 	free_charger_irq(wm8350);
 	device_remove_file(&pdev->dev, &dev_attr_charger_state);
-	power_supply_unregister(power->battery);
-	power_supply_unregister(power->ac);
-	power_supply_unregister(power->usb);
 }
 
 static struct platform_driver wm8350_power_driver = {
-- 
2.39.2


