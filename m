Return-Path: <linux-kernel+bounces-130579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B316C897A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC12837A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC3158DA9;
	Wed,  3 Apr 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uILrI3wk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC31586E9;
	Wed,  3 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176633; cv=none; b=lDShFenHiNGASvxrmmMhHYCuRJba97XmSQg+XQR98mns8citUzt92Qo6tGfvvwDRUAKX2wcoqn33whG6fwQoXWqiT5CkqZjPOOuaA9N0E9qJ56un40pQI0DSah5ksCU2XzNtQZCn0RCmpizme7HnA8BbPR8EF34aCcBGwanVOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176633; c=relaxed/simple;
	bh=w9TFgxLi7zLn3rPSLvhL5jw9hZ8VztBwInomK0mRBJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iL/TEcu0tCXYo70KBDKpTaLbwnKh4EV4vQhos5slKgC2q4bd70okGTgLX/rUsxxoFQ7iyhqPcMjbY6fqz+kPEtf0PuyfAvl6mH6oDT87o63lzTP3ZP3M5Y8FQTfnrXL52JOS/S64WNQgqkFeiva5J8rSocUz+APmOM9ZiPngGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uILrI3wk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KafWu079588;
	Wed, 3 Apr 2024 15:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176601;
	bh=E0hN0MX5Ii7hAmQKTJ2BBa6fwbeVM0SaWF5WY/zarg8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uILrI3wkni0eEFpGhCph4qDpuGor5S4zGipfRgrWIh8z9uQF6w5kq2EPBtYQJC0GA
	 pZIDnr/xQv4ZshBFyM0KtXE8YiCza90XIJfn4qhM6cei2ZhMlGH8GoyLpwKbcDP3hY
	 cyURWOo0aytSgIkp/OTlrGRT2cUmc/ISSAazNn1c=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KafTn000542
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:41 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG1080324;
	Wed, 3 Apr 2024 15:36:40 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 20/31] hwmon: (max1668) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:22 -0500
Message-ID: <20240403203633.914389-21-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403203633.914389-1-afd@ti.com>
References: <20240403203633.914389-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwmon/max1668.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index c4a02edefbee7..9fc583ebb11b2 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -391,8 +391,6 @@ static int max1668_detect(struct i2c_client *client,
 	return 0;
 }
 
-static const struct i2c_device_id max1668_id[];
-
 static int max1668_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -408,7 +406,7 @@ static int max1668_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	data->type = i2c_match_id(max1668_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	mutex_init(&data->update_lock);
 
 	/* sysfs hooks */
-- 
2.39.2


