Return-Path: <linux-kernel+bounces-35677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADFD83950D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA23B2973B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9B86AE7;
	Tue, 23 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YkrjIsIm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D5823B2;
	Tue, 23 Jan 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027830; cv=none; b=PPAwCANSFTfeB2DroRtjVf44T/Ge8UZiTKSUanOGhrnw9f1cK0XCL3As+e+J57dw9xAvyoVVWC/L8lqSO+IZf1r1Z+6FGZKszMIx1EVNHawQ5EaU66haoG3YKdOrq0fu10B6mPg0Kkg40WwTR9gV32trBf95H+O4gg12VD1zO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027830; c=relaxed/simple;
	bh=8IAZrImQB2nMZjos8DaIybYIWQnIDS13M5ug8CE0yhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmqP/aTt/0dCZH7ez3y8RvB2t+LuU87aQVN66nfh4eLJxVdeNPr/0C/koJQU1m57XP+n2eK7IOdJq6UEpvaDOe/RStw3/Y3uLBIyqMetg0fcgrd1oEk8auB9qrlQZVOpBMe0SgIvp7fpX/0o+TeoIL/qP3n3LxqkDmExmNHLtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YkrjIsIm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGawUx077100;
	Tue, 23 Jan 2024 10:36:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027818;
	bh=WrnR+uYJ9Ov/7JKIZBS7WynoDP/3tGY7vPWVbSdVeoE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YkrjIsIm/fqiNu5AhvMc0kqgb0WDZE0BvgZbilMcGs4GiRAOnkujIzFRFYbopvdgr
	 mxFejUKx5P+pvyyGyCaNeddNKEdlGBDXCE8tU8JUG6jt3raveMYuqX6D3PozWJPT0J
	 QWZXb4ID/C7FkhYibT8hdlsuc6iKQqz5IlVnJcMo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGawto119728
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:58 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:58 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGars0123403;
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
Subject: [PATCH 12/21] power: supply: tps65090: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:44 -0600
Message-ID: <20240123163653.384385-13-afd@ti.com>
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
 drivers/power/supply/tps65090-charger.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index c59197d2aa87d..d41595764caa5 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -262,7 +262,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	psy_cfg.of_node			= pdev->dev.of_node;
 	psy_cfg.drv_data		= cdata;
 
-	cdata->ac = power_supply_register(&pdev->dev, &tps65090_charger_desc,
+	cdata->ac = devm_power_supply_register(&pdev->dev, &tps65090_charger_desc,
 			&psy_cfg);
 	if (IS_ERR(cdata->ac)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
@@ -277,7 +277,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	ret = tps65090_config_charger(cdata);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "charger config failed, err %d\n", ret);
-		goto fail_unregister_supply;
+		return ret;
 	}
 
 	/* Check for charger presence */
@@ -286,14 +286,14 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(cdata->dev, "%s(): Error in reading reg 0x%x", __func__,
 			TPS65090_REG_CG_STATUS1);
-		goto fail_unregister_supply;
+		return ret;
 	}
 
 	if (status1 != 0) {
 		ret = tps65090_enable_charging(cdata);
 		if (ret < 0) {
 			dev_err(cdata->dev, "error enabling charger\n");
-			goto fail_unregister_supply;
+			return ret;
 		}
 		cdata->ac_online = 1;
 		power_supply_changed(cdata->ac);
@@ -306,7 +306,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 			dev_err(cdata->dev,
 				"Unable to register irq %d err %d\n", irq,
 				ret);
-			goto fail_unregister_supply;
+			return ret;
 		}
 	} else {
 		cdata->poll_task = kthread_run(tps65090_charger_poll_task,
@@ -316,16 +316,11 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 			ret = PTR_ERR(cdata->poll_task);
 			dev_err(cdata->dev,
 				"Unable to run kthread err %d\n", ret);
-			goto fail_unregister_supply;
+			return ret;
 		}
 	}
 
 	return 0;
-
-fail_unregister_supply:
-	power_supply_unregister(cdata->ac);
-
-	return ret;
 }
 
 static void tps65090_charger_remove(struct platform_device *pdev)
@@ -334,7 +329,6 @@ static void tps65090_charger_remove(struct platform_device *pdev)
 
 	if (cdata->irq == -ENXIO)
 		kthread_stop(cdata->poll_task);
-	power_supply_unregister(cdata->ac);
 }
 
 static const struct of_device_id of_tps65090_charger_match[] = {
-- 
2.39.2


