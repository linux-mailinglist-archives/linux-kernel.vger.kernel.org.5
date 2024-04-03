Return-Path: <linux-kernel+bounces-130558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449D8979ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A892728402F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00D15665C;
	Wed,  3 Apr 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cyw/WEH9"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EF15625C;
	Wed,  3 Apr 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176618; cv=none; b=UihXsl71lg/dpdK+SOvchyKrw89PfGYrG6IychRWfo0S/yKnX59lb8cPdVYoVQgH0wde1NZH3yHV/XOa8onLy6fgdGnHtxR/tG6UeP1EfDM8WA07t+aKmpLBIP3Q7G+HHlRroup6xO/NUl3xFid4ZIMQCTVSBrm6uH07KXqrmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176618; c=relaxed/simple;
	bh=YAfBzgHyxT/OlQjSIEKq5otHy5Sx3imuMxJ0Pv0RfP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtnYIs/jYpTDXDexOT/VSDskWUeEOcvrP8SWt+M7VeDBVaJmRufGC56BDwaYz+jQHznOu0j4GQ3yANFFyOI3LXnYeo92EtSJ7vwBpEoDuOqIk+6nT+8rzrd6sf0l1IRLW05Nu3Ww/QNfqJ7VKnbK0kWbJ5Lz+X8Kp2u/KfX/HCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cyw/WEH9; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kaa3G076293;
	Wed, 3 Apr 2024 15:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176596;
	bh=wUqUo35lVw+/wFCUc/qn97gM/nTw5m4+tR7JON2D8aY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cyw/WEH9SDJUigjqq4x9/wHN6TRj+ObYzjlDWzIDQkD0MMMeBA6Wfvs9BcpP6Bk4y
	 47oQRuwUcbIVQtkSVdorHlaZEiOI4NpMYsx2vLhTnFelQEHzqIR4mwgVj5+5KcRz3S
	 NYM7gk6dxb0aDQWp5tC7V7Zjqhl+08togu2+TDc4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaaLi092348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:36 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:36 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFk080324;
	Wed, 3 Apr 2024 15:36:36 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 05/31] hwmon: (adt7475) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:07 -0500
Message-ID: <20240403203633.914389-6-afd@ti.com>
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
 drivers/hwmon/adt7475.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb304832..5f78e66330187 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1676,7 +1676,6 @@ static int adt7475_probe(struct i2c_client *client)
 	struct device *hwmon_dev;
 	int i, ret = 0, revision, group_num = 0;
 	u8 config3;
-	const struct i2c_device_id *id = i2c_match_id(adt7475_id, client);
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (data == NULL)
@@ -1686,10 +1685,7 @@ static int adt7475_probe(struct i2c_client *client)
 	data->client = client;
 	i2c_set_clientdata(client, data);
 
-	if (client->dev.of_node)
-		chip = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		chip = id->driver_data;
+	chip = (uintptr_t)i2c_get_match_data(client);
 
 	/* Initialize device-specific values */
 	switch (chip) {
@@ -1717,7 +1713,7 @@ static int adt7475_probe(struct i2c_client *client)
 	if (!(config3 & CONFIG3_SMBALERT))
 		data->has_pwm2 = 1;
 	/* Meaning of this bit is inverted for the ADT7473-1 */
-	if (id->driver_data == adt7473 && revision >= 1)
+	if (chip == adt7473 && revision >= 1)
 		data->has_pwm2 = !data->has_pwm2;
 
 	data->config4 = adt7475_read(REG_CONFIG4);
@@ -1730,12 +1726,12 @@ static int adt7475_probe(struct i2c_client *client)
 	 * because 2 different pins (TACH4 and +2.5 Vin) can be used for
 	 * this function
 	 */
-	if (id->driver_data == adt7490) {
+	if (chip == adt7490) {
 		if ((data->config4 & CONFIG4_PINFUNC) == 0x1 &&
 		    !(config3 & CONFIG3_THERM))
 			data->has_fan4 = 1;
 	}
-	if (id->driver_data == adt7476 || id->driver_data == adt7490) {
+	if (chip == adt7476 || chip == adt7490) {
 		if (!(config3 & CONFIG3_THERM) ||
 		    (data->config4 & CONFIG4_PINFUNC) == 0x1)
 			data->has_voltage |= (1 << 0);		/* in0 */
@@ -1745,7 +1741,7 @@ static int adt7475_probe(struct i2c_client *client)
 	 * On the ADT7476, the +12V input pin may instead be used as VID5,
 	 * and VID pins may alternatively be used as GPIO
 	 */
-	if (id->driver_data == adt7476) {
+	if (chip == adt7476) {
 		u8 vid = adt7475_read(REG_VID);
 		if (!(vid & VID_VIDSEL))
 			data->has_voltage |= (1 << 4);		/* in4 */
@@ -1829,7 +1825,7 @@ static int adt7475_probe(struct i2c_client *client)
 	}
 
 	dev_info(&client->dev, "%s device, revision %d\n",
-		 names[id->driver_data], revision);
+		 names[chip], revision);
 	if ((data->has_voltage & 0x11) || data->has_fan4 || data->has_pwm2)
 		dev_info(&client->dev, "Optional features:%s%s%s%s%s\n",
 			 (data->has_voltage & (1 << 0)) ? " in0" : "",
-- 
2.39.2


