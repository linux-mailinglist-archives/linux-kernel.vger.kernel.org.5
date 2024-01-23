Return-Path: <linux-kernel+bounces-35659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF08394E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253E91C21E78
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB198004E;
	Tue, 23 Jan 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V+y8O77G"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155FF7FBAC;
	Tue, 23 Jan 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027825; cv=none; b=pAJQ0e0SpziMVTNNlnQfB+/2qNEBvSUgj5c8Q7EVCugN7rkaeHhu7O+9befIKNqsQpLPvuOg6HkAGYhqhsxByS+ZSzD7wkqcfkwxNTKI4POmXXojcx2lqxUmlBRrMiVWQIGEoZ9WIavahaHit0/7u2XTnW8RfN8gnQ4BFtq5rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027825; c=relaxed/simple;
	bh=6EbfTxVZTsZcDz6soZJ7jpZfyhuxH4m975EW/o+lIBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCAQ9U1gKoaMvnvuyn54zF5+SRptV3b2gXg9vNasbuVejI9n0dO5POD2BWtUwOS9E2drKYh5oz0aaXMfXOgEu2INTHbBYrMlbnNnC12Xa9r2E1CCVoroFmnvrbeJTMDfsQeOFP/ET6qELkUpQqOEoSX/nkJogM4nTJNylP51P44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V+y8O77G; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGawJN077092;
	Tue, 23 Jan 2024 10:36:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027818;
	bh=bgvmGI1WvRaGQtO6cF0xR2F5H/hltWKL+Ey04aoYvK0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=V+y8O77GeCqoZo7qKU7dU2fAtoC1NawLPUp+WHvRsv8TSwZCSBMjMb9itjMmNNRwF
	 SUdXSVUF8VfDitIHB67sFP3vjemrTIwp2KTihVvXhoLnQAk6dWOxgRgVM3HFrRCNQa
	 65gzY1QNJ2rZQhFvTacPG7qIiVreUWS44UV/Ody8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGaw8v119722
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:58 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:57 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarrx123403;
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
Subject: [PATCH 11/21] power: supply: rt5033: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:43 -0600
Message-ID: <20240123163653.384385-12-afd@ti.com>
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
 drivers/power/supply/rt5033_battery.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index d90b96df8e73d..32eafe2c00af5 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -159,12 +159,12 @@ static int rt5033_battery_probe(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	i2c_set_clientdata(client, battery);
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = battery;
 
-	battery->psy = power_supply_register(&client->dev,
-					     &rt5033_battery_desc, &psy_cfg);
+	battery->psy = devm_power_supply_register(&client->dev,
+						  &rt5033_battery_desc,
+						  &psy_cfg);
 	if (IS_ERR(battery->psy))
 		return dev_err_probe(&client->dev, PTR_ERR(battery->psy),
 				     "Failed to register power supply\n");
@@ -172,13 +172,6 @@ static int rt5033_battery_probe(struct i2c_client *client)
 	return 0;
 }
 
-static void rt5033_battery_remove(struct i2c_client *client)
-{
-	struct rt5033_battery *battery = i2c_get_clientdata(client);
-
-	power_supply_unregister(battery->psy);
-}
-
 static const struct i2c_device_id rt5033_battery_id[] = {
 	{ "rt5033-battery", },
 	{ }
@@ -197,7 +190,6 @@ static struct i2c_driver rt5033_battery_driver = {
 		.of_match_table = rt5033_battery_of_match,
 	},
 	.probe = rt5033_battery_probe,
-	.remove = rt5033_battery_remove,
 	.id_table = rt5033_battery_id,
 };
 module_i2c_driver(rt5033_battery_driver);
-- 
2.39.2


