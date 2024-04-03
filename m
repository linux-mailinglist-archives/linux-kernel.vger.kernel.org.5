Return-Path: <linux-kernel+bounces-130575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2A3897A10
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABA11C246D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A100158850;
	Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MoywmNPV"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC05156865;
	Wed,  3 Apr 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176631; cv=none; b=N7ffWFaqb+NsCsb6vuMePHInkcIhAQWU4GCnMP/iE3pb9xP8ZYjX7dNKbOUodnG/lapZu44pJ17EGcZbdqKxd3YxUVOiDwbtIBouKPXscwgkNz7KLbPWod0KGaGMiyJ6bGJJLtlw2awzTtWWT+uR9+VKR+GyWuBV1l2f049JWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176631; c=relaxed/simple;
	bh=T5VHLU8nK9r6A/JuEnGEjUCRTxS3+8zFFSmaZ24gujA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSUj4ScQoExjg9GApQxocqC2HlXHnO9YrlQYMQZYh0FyTfa30tyX2fiGCDYyRnlpKYKJiLeJ9mtjN0hwJoZ10YgAZSfCKpZ+OwCkHmGeJ4smwbb6/UzgSd1aO5FwTU/9EcnTo2RSvForjPzpdqEsiqcEVA89saTlN77Yu8XWnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MoywmNPV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KafqJ038551;
	Wed, 3 Apr 2024 15:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176601;
	bh=A2RfmZvQ1FLR4C2d/yQzvUnFTxN7KDFEuQ6F/bLKly8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MoywmNPVvnOxGNTO2Bd9wbiMW0enQw5fckesEWUcpdIK3hbvJcp1+4XMW0MFriyao
	 X5RY/AofwNrTJtkD5evy2Ra0URhwJN1Y6WiEdvu6GTZyQ4Gx3mTU3wrMKvEHqv/5zW
	 Zk9qPgxebzA4z3dUZJEJdY6WFeITB9MkVoSVURY0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kaf84000546
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:41 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:41 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG2080324;
	Wed, 3 Apr 2024 15:36:41 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 21/31] hwmon: (max6697) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:23 -0500
Message-ID: <20240403203633.914389-22-afd@ti.com>
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
 drivers/hwmon/max6697.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index d161ba0e7813c..b28b7b9448aa8 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -684,8 +684,6 @@ static int max6697_init_chip(struct max6697_data *data,
 	return 0;
 }
 
-static const struct i2c_device_id max6697_id[];
-
 static int max6697_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
@@ -701,10 +699,7 @@ static int max6697_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	if (client->dev.of_node)
-		data->type = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		data->type = i2c_match_id(max6697_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	data->chip = &max6697_chip_data[data->type];
 	data->client = client;
 	mutex_init(&data->update_lock);
-- 
2.39.2


