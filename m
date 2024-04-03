Return-Path: <linux-kernel+bounces-130588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E7897A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C7CB23BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997315B0F8;
	Wed,  3 Apr 2024 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ldVQRhsg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB715158D87;
	Wed,  3 Apr 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176637; cv=none; b=U2HBZd5yJzI6fGQ82o0RVEZKz1WybijiH0x1/y5Tkh4I03OZy4NXTe9+8yysj6z5tLdx169FXaT1AnsIhOnh4ujzqRc3Bf5UzLy4+i+eEMoveE2P1oda5cSARLjjlQH4sdt7boiIfvUa86pEiu4dntF7h4WJlPphRcWu6tYA1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176637; c=relaxed/simple;
	bh=8ZbiHkNtTREjZIS3zJVAZlTb0yye+Fpji6a3bLedtUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTs5rAZt07zLedorNfFqq3WBuj+dzd7qWidtxD8qS5wMjdsqhU9MiGwEcPT/wg7MurwjrpvgRsZqyKSSDRS3Sls2ro/ofY03Py8qaQHs6yH8yFSEK3SSPN2AQheQtuqq21Xxbul6PuHLud+qtE5gYc4pDRMNrzpdhx+JCejqz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ldVQRhsg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kad78076399;
	Wed, 3 Apr 2024 15:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176599;
	bh=FCV/jbQpi7sXWXYhHaR5JdV7Yoe0VOV9bhmOLCeXpUA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ldVQRhsgzIMgyomFMRaxK5n3+OxhPuTbY55tSmwnSSMf/oUDqLNVBgsOGZI+4u8vc
	 kBGIt5oDjrwsxH/Dt1LPsq0eQJSt9ndo3sFB9tdkjQflBNa/OmXkk1FI//IP4VWCsH
	 ilq5DmjqWxRd2zjFZ43LOZFVU2vIxQQvBiBZYq4g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KadVo115271
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:39 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFu080324;
	Wed, 3 Apr 2024 15:36:39 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 15/31] hwmon: (lm83) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:17 -0500
Message-ID: <20240403203633.914389-16-afd@ti.com>
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
 drivers/hwmon/lm83.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index b333c9bde4e64..f800fe2ef18b8 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -417,13 +417,6 @@ static int lm83_detect(struct i2c_client *client,
 	return 0;
 }
 
-static const struct i2c_device_id lm83_id[] = {
-	{ "lm83", lm83 },
-	{ "lm82", lm82 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, lm83_id);
-
 static int lm83_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -438,7 +431,7 @@ static int lm83_probe(struct i2c_client *client)
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
-	data->type = i2c_match_id(lm83_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data, &lm83_chip_info, NULL);
@@ -449,6 +442,13 @@ static int lm83_probe(struct i2c_client *client)
  * Driver data (common to all clients)
  */
 
+static const struct i2c_device_id lm83_id[] = {
+	{ "lm83", lm83 },
+	{ "lm82", lm82 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm83_id);
+
 static struct i2c_driver lm83_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
-- 
2.39.2


