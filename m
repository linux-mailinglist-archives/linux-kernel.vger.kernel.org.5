Return-Path: <linux-kernel+bounces-130560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 736578979F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148CEB27741
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B0156F23;
	Wed,  3 Apr 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wOD5JrTX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F44156C42;
	Wed,  3 Apr 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176621; cv=none; b=n5rJ8IibWY1dd23khyrMGsyOJPjoAHCAXI+Nv0MirSytx76x8iXVvfJGtbhJ4tokIxgC6WEhQmRUKKtq52S/TaAqZs9KqtwkvWN5kxWjK6h799gQy5d6SsulQ6MoP1VWKUYHT3RKhO1mMo5Sej9MPKyEJ8lAbZJ6zEVABIdDGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176621; c=relaxed/simple;
	bh=PccP3Xxp2cI2yyXU9MSff16ZCkCqQEI8PV99Plgf9RE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cf+lvUbq3XvQWhxWt2v9MrwNFkNmMEpe8QlgoPB/3EG1BB91IWaqYIikN4CJAw3xaroBe9expZXC/mHMHTwGavbHos4AidzjCzSzuP4uZBkzG4qe+JMKQjGfvhgou38wFtZUPIu9/Si0YDAEU87tzyO8AZcjcwZiBJ5yigXSUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wOD5JrTX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaeZd076315;
	Wed, 3 Apr 2024 15:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176600;
	bh=ff7Uw6i1RTzEx7wJ63U5eJ76bOzpYeZfMFBZuFhotN4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wOD5JrTXnvD+Bu0ADZYREdz4XzD+mZYLYVGFpvtng6ZRTIwc0ZudmDclyEjdO6sZb
	 3nbwC/1ZM10FtoQHx3M6qa+B6gJDRkTaAoGnhS2d5e50uySXXFZVC80odQywUCk7wZ
	 yb9tBWFkmKk9HmNm7gBdGQBlOHtQY7Jo1tJ0G4eY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaeBJ000535
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:39 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFv080324;
	Wed, 3 Apr 2024 15:36:39 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 16/31] hwmon: (lm85) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:18 -0500
Message-ID: <20240403203633.914389-17-afd@ti.com>
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
 drivers/hwmon/lm85.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 68c2100023575..1c244ed75122e 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1544,8 +1544,6 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
-static const struct i2c_device_id lm85_id[];
-
 static int lm85_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1558,10 +1556,7 @@ static int lm85_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	if (client->dev.of_node)
-		data->type = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		data->type = i2c_match_id(lm85_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	mutex_init(&data->update_lock);
 
 	/* Fill in the chip specific driver values */
-- 
2.39.2


