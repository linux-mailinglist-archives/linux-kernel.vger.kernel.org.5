Return-Path: <linux-kernel+bounces-130569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62E6897A05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9015B28C5E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A651581F8;
	Wed,  3 Apr 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MkRKtG0w"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA1157A77;
	Wed,  3 Apr 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176629; cv=none; b=VP6bScUXqiGnWD5+LqVe+uTjMTvov0gxjvuKE1UmtFqXmpLRSCqLDDv2CpEYOys2Vt/YJriSH+WOQesDUHmYtvs6nkLVIKM5T4rbxEFiMJoV9MZibXpNP55j4Msun9TuN6byXNmWk4vVCTm7qZhl4/3j5OsTbtx8ORiS0MkAlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176629; c=relaxed/simple;
	bh=l2ILJrvm523Pdh6/q7kf63sgiFrMwHIDd2MGZ/ZaeCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh60E/M1LIRrCfg9Q0DEKK1l3wwK9w+4spdff6vm86JuAeIz7Oz+ysc0HwUOWzAYWjuv32IJszT9+1NHRZdpsCUrKs4dTtyFZq7VrTJcDj2Z1n5q1NMhJLrm3DVqAkD9xluoeD0MFHICcCECG3L1Ea0SfwvyDy4ih/gluvav5TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MkRKtG0w; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KagYm079593;
	Wed, 3 Apr 2024 15:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176602;
	bh=JxK8cs7QSwJFELf2r5HBFoU70Gmh8OmgX3Wa2YPIZ6Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MkRKtG0wQ2NErgOqXeyDeH0RRQTGHHztvlOcNynnf1OlAwyIRmZuPYww3EpmFdaxU
	 aH26BcdKzK1F6pNPwkPJIENvTttuH/eCu0iXqPxtmjvRei86Vitea1tMjdv3i0RUW4
	 jh6qub4a2iKjP2avavzjD85ZMrK5KKSQoPi0Ht9g=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KagmQ052140
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:42 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG6080324;
	Wed, 3 Apr 2024 15:36:42 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 25/31] hwmon: (shtc1) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:27 -0500
Message-ID: <20240403203633.914389-26-afd@ti.com>
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
 drivers/hwmon/shtc1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index 1f96e94967ee8..24a8ae092d00e 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -186,8 +186,6 @@ static void shtc1_select_command(struct shtc1_data *data)
 	}
 }
 
-static const struct i2c_device_id shtc1_id[];
-
 static int shtc1_probe(struct i2c_client *client)
 {
 	int ret;
@@ -195,7 +193,7 @@ static int shtc1_probe(struct i2c_client *client)
 	char id_reg_buf[2];
 	struct shtc1_data *data;
 	struct device *hwmon_dev;
-	enum shtcx_chips chip = i2c_match_id(shtc1_id, client)->driver_data;
+	enum shtcx_chips chip = (uintptr_t)i2c_get_match_data(client);
 	struct i2c_adapter *adap = client->adapter;
 	struct device *dev = &client->dev;
 	struct device_node *np = dev->of_node;
-- 
2.39.2


