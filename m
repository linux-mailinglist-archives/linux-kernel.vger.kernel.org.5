Return-Path: <linux-kernel+bounces-130563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9FF8979F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7F61F20FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF35157496;
	Wed,  3 Apr 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PhKum9/H"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815B156F32;
	Wed,  3 Apr 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176625; cv=none; b=MrazafK7KYd9N/JVmzbtbvD6PBkK8jvInqWpKvRkRfcsCMbIglV1fmsrRdEH7xmS1QTMjRpaHl25hRvjtJeFeA3pLMvVlS/uHol1lkVVuahp4IQ+9lKjboIXWA8GdxqCipsvUmgv9QRKdgcb/6MBb4HIWfw9a1Coi3A2MrnTk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176625; c=relaxed/simple;
	bh=vsxZuXPnc9LZp7BCFMmM+QmqhXEf9M6BtZ3xaM8AQYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEhDExGvpQj2Y+09Lu115UuzVWVVLrYiMHL70RdvN3Tr1hlVK3g14BMIunWtZiN8L5TypVe+J0SaG5+RMVPFox272avZ5zeoVt247FPgHBbbxnRq6Fm2M8xRYkwXhmiEEhi93XyDLw8c3CNpIkKSOLzS7xNCfr+Z71KvPImTLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PhKum9/H; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kacoo076306;
	Wed, 3 Apr 2024 15:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176598;
	bh=kfaADE72p/7wiRjfacJ24ecKgyHpfOb03uEZTqrrEyI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PhKum9/HaX/Q+ZnVbMhWvJ50nDthzlGe8BHfu2nfrTZWke0xUIMAyTAZ+arUckQZU
	 JZ0Bc7ykPDgTBHSjFj5sU0MnG68UNwwFr46/4QerZ4/KoSUCnBnw1yW3qFxzgeYf29
	 hBmHJNWRyQy3bAc8yGSpAN3af2ucU2/aFKf3FNtU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kackn115245
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:37 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFo080324;
	Wed, 3 Apr 2024 15:36:37 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 09/31] hwmon: (f75375s) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:11 -0500
Message-ID: <20240403203633.914389-10-afd@ti.com>
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
 drivers/hwmon/f75375s.c | 46 ++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 8c572bb64f5dc..7e867f1324201 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -111,31 +111,6 @@ struct f75375_data {
 	s8 temp_max_hyst[2];
 };
 
-static int f75375_detect(struct i2c_client *client,
-			 struct i2c_board_info *info);
-static int f75375_probe(struct i2c_client *client);
-static void f75375_remove(struct i2c_client *client);
-
-static const struct i2c_device_id f75375_id[] = {
-	{ "f75373", f75373 },
-	{ "f75375", f75375 },
-	{ "f75387", f75387 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, f75375_id);
-
-static struct i2c_driver f75375_driver = {
-	.class = I2C_CLASS_HWMON,
-	.driver = {
-		.name = "f75375",
-	},
-	.probe = f75375_probe,
-	.remove = f75375_remove,
-	.id_table = f75375_id,
-	.detect = f75375_detect,
-	.address_list = normal_i2c,
-};
-
 static inline int f75375_read8(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -830,7 +805,7 @@ static int f75375_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
-	data->kind = i2c_match_id(f75375_id, client)->driver_data;
+	data->kind = (uintptr_t)i2c_get_match_data(client);
 
 	err = sysfs_create_group(&client->dev.kobj, &f75375_group);
 	if (err)
@@ -901,6 +876,25 @@ static int f75375_detect(struct i2c_client *client,
 	return 0;
 }
 
+static const struct i2c_device_id f75375_id[] = {
+	{ "f75373", f75373 },
+	{ "f75375", f75375 },
+	{ "f75387", f75387 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, f75375_id);
+
+static struct i2c_driver f75375_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "f75375",
+	},
+	.probe = f75375_probe,
+	.remove = f75375_remove,
+	.id_table = f75375_id,
+	.detect = f75375_detect,
+	.address_list = normal_i2c,
+};
 module_i2c_driver(f75375_driver);
 
 MODULE_AUTHOR("Riku Voipio");
-- 
2.39.2


