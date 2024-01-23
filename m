Return-Path: <linux-kernel+bounces-35506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C767A839223
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6502A1F291F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E45FBB9;
	Tue, 23 Jan 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KsEleuV8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD045F55B;
	Tue, 23 Jan 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022568; cv=none; b=KMu+X4/wT22jiDF0EuHeT+x7qVwaAZ4d5DI3ZaDufIm/kzVu0wqY8YjAptojR8/O5TA1hTpbWj7VQgBqp567za2nmAmW9YzzXzyAKxo/oBQ6oRTlcVZdbI9+2ELJUm6h1MfrwKzxciVskvPeFdemGrwodCMGFsBGqPcf0XZyTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022568; c=relaxed/simple;
	bh=zdN9AWx3mn6BQG7Qefn2YsGqa539WPtGvVDiINeK+1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCpLz3zkHmZUB4mJTHPYkqO70Ak2qPjMfKdvwO2Ii3Lvz2nO6xWWyKUiCajHgAaEM+bt0fjEWNwEh0Q94oV64vSbuPSqXUTqzdc1z/pHilOScsK56wuyzQfMG8y1D4KUGeoB5++KTDfz5hpPEWPEZNjp3j0l6riP1mcV4AR7M0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KsEleuV8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9Gib071713;
	Tue, 23 Jan 2024 09:09:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706022556;
	bh=VbxBxCWrIh0zrQFy85sWtt5gQmurWQ5SJD+FOeS70nI=;
	h=From:To:CC:Subject:Date;
	b=KsEleuV8lZ0JP71WGyWQW8tp/ZhZn9xB7Rkc3M30j3hDMr7v9mYrpAeN3lcsA+aLH
	 WFW3bYSUBmV3bU7Vh1rpLum/vsZrxFqlnxfuxdASeHQXDBE+4gOdp3n6NpsBJo2+EH
	 I89aPTQyzMfRB3PzRvRWTPHHaJq2szyMWVGBWtz4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NF9GiO075195
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 09:09:16 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 09:09:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NF9FE4128205;
	Tue, 23 Jan 2024 09:09:15 -0600
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/5] power: supply: bq27xxx: Switch to a simpler IDA interface
Date: Tue, 23 Jan 2024 09:09:10 -0600
Message-ID: <20240123150914.308510-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

We don't need to specify any ranges when allocating IDs so we can switch
to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 3a1798b0c1a79..86ce13a8ab9dd 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -13,8 +13,7 @@
 
 #include <linux/power/bq27xxx_battery.h>
 
-static DEFINE_IDR(battery_id);
-static DEFINE_MUTEX(battery_mutex);
+static DEFINE_IDA(battery_id);
 
 static irqreturn_t bq27xxx_battery_irq_handler_thread(int irq, void *data)
 {
@@ -145,9 +144,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client)
 	int num;
 
 	/* Get new ID for the new battery device */
-	mutex_lock(&battery_mutex);
-	num = idr_alloc(&battery_id, client, 0, 0, GFP_KERNEL);
-	mutex_unlock(&battery_mutex);
+	num = ida_alloc(&battery_id, GFP_KERNEL);
 	if (num < 0)
 		return num;
 
@@ -198,9 +195,7 @@ static int bq27xxx_battery_i2c_probe(struct i2c_client *client)
 	ret = -ENOMEM;
 
 err_failed:
-	mutex_lock(&battery_mutex);
-	idr_remove(&battery_id, num);
-	mutex_unlock(&battery_mutex);
+	ida_free(&battery_id, num);
 
 	return ret;
 }
@@ -212,9 +207,7 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 	free_irq(client->irq, di);
 	bq27xxx_battery_teardown(di);
 
-	mutex_lock(&battery_mutex);
-	idr_remove(&battery_id, di->id);
-	mutex_unlock(&battery_mutex);
+	ida_free(&battery_id, di->id);
 }
 
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
-- 
2.39.2


