Return-Path: <linux-kernel+bounces-35673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB10839508
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298611C25F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A486AC0;
	Tue, 23 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WP53bTYp"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76480040;
	Tue, 23 Jan 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027830; cv=none; b=GYrUFBPrTibK6Wgp+0fqU0sleqStR9PML1X/jkiSoqG+iunyTmi4j8GtdF55s5wTTa/n3dxS1i3heceSsqn6OuGG6ybVH2yfIFNdp0SMa8ukMFkjkZTXpAFfGu0yjHd6Mhd7QCtWJFtictVhgfWD3ay57JNkGiZBH69KeKBchTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027830; c=relaxed/simple;
	bh=Y4r6QN/JrItjnEuYXVICeF7hVAsCe7GxvqIcOJz5MA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYFftkUckHAVXB2OgODC1vgf6HcYnSgQYCmsEo9Vdi6S680Xy2U5plYmH10Q7V+5dMNmyYI0aT0yNZodqFDpQdFSbk+dXDTClYGWUnmAwezPwu6PF9UpYrON5EA95TUspAhrzXkRLeivIPyPHTIzxaQmP6w0TSRA5oVn43NljlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WP53bTYp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGaufv094120;
	Tue, 23 Jan 2024 10:36:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027816;
	bh=K1WNi8+Cbrepl/ifkNTZDPIJo8q3+SEk0jaxrVvGu8M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WP53bTYpTvwZNl8tyFD/A1GAlt/IJvDTgNCEckVKQ2XK3xcjmB1XD0G3uuyu5000u
	 9mMkb7HwJrhOJJ7cigBOsCuGsQaLEp7u42Ip/DVzZUtdhNvRQo++nHctpUR+vL9X7O
	 GZDaVG7feolbIOAWsTGxgzfNcHPCh07Fy+CdLAKw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGau9M000562
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:56 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:55 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrr123403;
	Tue, 23 Jan 2024 10:36:55 -0600
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
Subject: [PATCH 05/21] power: supply: lp8727: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:37 -0600
Message-ID: <20240123163653.384385-6-afd@ti.com>
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
 drivers/power/supply/lp8727_charger.c | 35 ++++++---------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
index 0875391f7ac6b..34548a4da90b2 100644
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -453,39 +453,20 @@ static int lp8727_register_psy(struct lp8727_chg *pchg)
 	psy_cfg.supplied_to = battery_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(battery_supplied_to);
 
-	psy->ac = power_supply_register(pchg->dev, &lp8727_ac_desc, &psy_cfg);
+	psy->ac = devm_power_supply_register(pchg->dev, &lp8727_ac_desc, &psy_cfg);
 	if (IS_ERR(psy->ac))
-		goto err_psy_ac;
+		return -EPERM;
 
-	psy->usb = power_supply_register(pchg->dev, &lp8727_usb_desc,
-					 &psy_cfg);
+	psy->usb = devm_power_supply_register(pchg->dev, &lp8727_usb_desc,
+					      &psy_cfg);
 	if (IS_ERR(psy->usb))
-		goto err_psy_usb;
+		return -EPERM;
 
-	psy->batt = power_supply_register(pchg->dev, &lp8727_batt_desc, NULL);
+	psy->batt = devm_power_supply_register(pchg->dev, &lp8727_batt_desc, NULL);
 	if (IS_ERR(psy->batt))
-		goto err_psy_batt;
+		return -EPERM;
 
 	return 0;
-
-err_psy_batt:
-	power_supply_unregister(psy->usb);
-err_psy_usb:
-	power_supply_unregister(psy->ac);
-err_psy_ac:
-	return -EPERM;
-}
-
-static void lp8727_unregister_psy(struct lp8727_chg *pchg)
-{
-	struct lp8727_psy *psy = pchg->psy;
-
-	if (!psy)
-		return;
-
-	power_supply_unregister(psy->ac);
-	power_supply_unregister(psy->usb);
-	power_supply_unregister(psy->batt);
 }
 
 #ifdef CONFIG_OF
@@ -583,7 +564,6 @@ static int lp8727_probe(struct i2c_client *cl)
 	ret = lp8727_setup_irq(pchg);
 	if (ret) {
 		dev_err(pchg->dev, "irq handler err: %d", ret);
-		lp8727_unregister_psy(pchg);
 		return ret;
 	}
 
@@ -595,7 +575,6 @@ static void lp8727_remove(struct i2c_client *cl)
 	struct lp8727_chg *pchg = i2c_get_clientdata(cl);
 
 	lp8727_release_irq(pchg);
-	lp8727_unregister_psy(pchg);
 }
 
 static const struct of_device_id lp8727_dt_ids[] __maybe_unused = {
-- 
2.39.2


