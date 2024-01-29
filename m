Return-Path: <linux-kernel+bounces-43382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2338412F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13901B24B01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5FB45BEA;
	Mon, 29 Jan 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IkQvXPmV"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8076C85;
	Mon, 29 Jan 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554976; cv=none; b=URrXc5mLZTT2jiodzMZWSZbK20DJqJOyg2VoTHbTSTlqNqqc+ht3jLraKebbvZdYVP3EAFlF8J+qn6yAqlhavG1tnfhaBxJryya2ETOc228fZp/TdqcAwPk6gUS8hTqCyD/8mADLU3BMk7wuiD+sY7iH85kag0ITpzVFn4rezSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554976; c=relaxed/simple;
	bh=aSM9wPAyPVDm5b+xfCxQKgaxyvEhEsXdo6zACqRJdGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcgI3ZXWL+egUN+OqvrF668qRdwYrRmud0cjWKCn6+R6d4c8f2Rn9c/dZ5UBwmgyYoDyTxn2xg9Je3jcfBtyjY7GvAVtfwXeD2uL3QV0DD/sIOccTi3rZSr6XXulJYStiny4nnZY2HsGWuvrT0FRSPjL8GsupqDRMX6GY5GjDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IkQvXPmV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2mXE058112;
	Mon, 29 Jan 2024 13:02:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706554968;
	bh=g68VLRGGJy5bz4tZRAxiACWi4FChD3F2OvygDt/12UY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IkQvXPmV2HlCmeYbjTjX1f1MuGboDNchJl0arl1p1bfFga+Ig3QsCJEL5FO2oWgL2
	 iAzMDcG3rkBLlI3aIYX3dEB2yRP4ijkg/Tv6s35kgDL82e1U/EEnhVuMomJ1hA8oMe
	 BUjr5+aGyyDp3giL4GL6PgIHu6HCCgLoU0wdwwAM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TJ2mIL003157
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 13:02:48 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 13:02:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 13:02:48 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TJ2ldm003658;
	Mon, 29 Jan 2024 13:02:47 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2 1/4] power: supply: max14577: Use devm_power_supply_register() helper
Date: Mon, 29 Jan 2024 13:02:43 -0600
Message-ID: <20240129190246.73067-2-afd@ti.com>
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
 drivers/power/supply/max14577_charger.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 7c23fa89ea199..b28c04157709a 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -586,8 +586,9 @@ static int max14577_charger_probe(struct platform_device *pdev)
 	}
 
 	psy_cfg.drv_data = chg;
-	chg->charger = power_supply_register(&pdev->dev, &max14577_charger_desc,
-						&psy_cfg);
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &max14577_charger_desc,
+						  &psy_cfg);
 	if (IS_ERR(chg->charger)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		ret = PTR_ERR(chg->charger);
@@ -608,10 +609,7 @@ static int max14577_charger_probe(struct platform_device *pdev)
 
 static void max14577_charger_remove(struct platform_device *pdev)
 {
-	struct max14577_charger *chg = platform_get_drvdata(pdev);
-
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
-	power_supply_unregister(chg->charger);
 }
 
 static const struct platform_device_id max14577_charger_id[] = {
-- 
2.39.2


