Return-Path: <linux-kernel+bounces-35676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7B83950B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED4F291FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5186ADF;
	Tue, 23 Jan 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bMxx/l9h"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7098003F;
	Tue, 23 Jan 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027830; cv=none; b=X3ie5sEUw0Z9p5iSS7IdHaTbwVKH+Ziv0k6+HGCjJ5PMvhsoZE4lw1RXFN2w6gHaxRag4MO5R0zwNv+WA0xxFfb4aaWzpzl/DZkmTHN5gzmBmS5Ep0QrR5MWoKSqSxcj16G5KD6f+g+oOO93Qf2JWQifxPmVaYa5fzK7FxBtZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027830; c=relaxed/simple;
	bh=fV62+saH4kX+KvcUIgx0K7XduczaJo6RzCgbuK4WLWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arRsPk5NFx3v9Ar8m4+yX2+nQPZSlEWCwe2gO1oqEP+nLMAR/f57U5yx+uNabQ5i4D+e24sEJjw0M0aOK02z+ITq8ePbVfZzhdlLVblAIsOiSeAVihCid8EzuGzNs+uj2GfYZIw15KyQTMKRxkIsXxAzlBT2nt4a12+FaFLBnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bMxx/l9h; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGauRb094124;
	Tue, 23 Jan 2024 10:36:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027816;
	bh=diBHJatAvryPPmwR5QhjhTLQ3HogCqBjdXM5lGueG/o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bMxx/l9hM5use8S9QIMjbiMf0d4kn0de/4/auLbNSawJyuF9/DhOzkRujnR/AK8UL
	 DjsX7e9lQ+cIiM79/Mk7Rv64eSJrnDZgpnp+PthZoJndHReqMQHAxRmBsXmKMkHLoy
	 6jrtdGW98u/BrQB79ce3so2TtLt4+/uDdquZT9wM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGau6s033972
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:56 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:56 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrt123403;
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
Subject: [PATCH 07/21] power: supply: max14577: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:39 -0600
Message-ID: <20240123163653.384385-8-afd@ti.com>
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
 drivers/power/supply/max14577_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 7c23fa89ea199..1fff82b037097 100644
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
@@ -611,7 +612,6 @@ static void max14577_charger_remove(struct platform_device *pdev)
 	struct max14577_charger *chg = platform_get_drvdata(pdev);
 
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
-	power_supply_unregister(chg->charger);
 }
 
 static const struct platform_device_id max14577_charger_id[] = {
-- 
2.39.2


