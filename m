Return-Path: <linux-kernel+bounces-35667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAC8394FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55C61C277D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA985C54;
	Tue, 23 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RNgpGxON"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C76811F9;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027828; cv=none; b=CTuv6OQtLhK9KSBHl4gYZBV/c+Ti+G/GRCGaXV200CrTr36d0ufNldny+FJ8yOODtJfnCpH5yB2dwBCXMtudxdwpIv5arLBT1/P2oudM4XBqx8spPtPe69oDD2MJl4/+rm16JNxMg+jfJjUcmwmU0CxypsrJMsPSP/QB1uEgBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027828; c=relaxed/simple;
	bh=xmo1Z+KyQdcCgWV1abRp3dtd3xmVCwEAMrTEymgJUmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zn7ntle7Kz79GXh+OLoWn11+4wppMxRWxmCMO4B1KQH4n6d8opqiLsXYuFRBo59jmpVP1evngqAVm9t/v2F8NZ90LRu4tu2HUBD8bpV69j0nbRkAE78goPV3g39BBSQqK3eyZmy++lzXvff1wFBMsAPLWpl3xlYHiybWGwrDz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RNgpGxON; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGb1aV049978;
	Tue, 23 Jan 2024 10:37:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027821;
	bh=YkQn++yLx8JTsqCeXj3tsHnbCEYONEo8VsBIFfzZFDM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RNgpGxONyLP1Hniiwukqa75kroEwvneMSqPbaVUpv3oyZYnQ0kM05ZsSY0EhPRJF7
	 ilFfvVIF7DLokt6VNn14aMQFreP8JjrGdpQ7WndigF3phdnWKV28ZneH7dmo3tGQW+
	 ZZTZMMKEFpc41PdQa8ioNn1646JbV2D4J9aB0aYQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGb1Y8119772
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:37:01 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:37:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:37:01 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars9123403;
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
Subject: [PATCH 21/21] power: supply: twl4030_madc: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:53 -0600
Message-ID: <20240123163653.384385-22-afd@ti.com>
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
 drivers/power/supply/twl4030_madc_battery.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index cd9e94134ab21..3935162e350b5 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -215,30 +215,21 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 		twl4030_cmp, NULL);
 
 	twl4030_madc_bat->pdata = pdata;
-	platform_set_drvdata(pdev, twl4030_madc_bat);
 	psy_cfg.drv_data = twl4030_madc_bat;
-	twl4030_madc_bat->psy = power_supply_register(&pdev->dev,
-						      &twl4030_madc_bat_desc,
-						      &psy_cfg);
+	twl4030_madc_bat->psy = devm_power_supply_register(&pdev->dev,
+							   &twl4030_madc_bat_desc,
+							   &psy_cfg);
 	if (IS_ERR(twl4030_madc_bat->psy))
 		return PTR_ERR(twl4030_madc_bat->psy);
 
 	return 0;
 }
 
-static void twl4030_madc_battery_remove(struct platform_device *pdev)
-{
-	struct twl4030_madc_battery *bat = platform_get_drvdata(pdev);
-
-	power_supply_unregister(bat->psy);
-}
-
 static struct platform_driver twl4030_madc_battery_driver = {
 	.driver = {
 		.name = "twl4030_madc_battery",
 	},
 	.probe  = twl4030_madc_battery_probe,
-	.remove_new = twl4030_madc_battery_remove,
 };
 module_platform_driver(twl4030_madc_battery_driver);
 
-- 
2.39.2


