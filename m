Return-Path: <linux-kernel+bounces-130570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20278897A08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03D128696A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3406158210;
	Wed,  3 Apr 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NyReIWmu"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D30C157E6E;
	Wed,  3 Apr 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176630; cv=none; b=rLJmrvBh61zIMbFeLvQE14R9/jKEqONAutdmWUb7qHJPiZB9aRdQeCIRkRbagfT/f+SOSHEumkJzzmWRiNKsJEVD0C9wkJlZC4gch06eLwVgy4jk+43BUVS6dEuvtZWk+PduLNvTsHhkaa/TSmWDBekupSXPLw8xExwBAeLTvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176630; c=relaxed/simple;
	bh=NqGjmDEiTmVXUb0XDnMYpVdBDiAkNMDsmBrzSBd12AU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRMARC+fpK8DvG4CVG9nloO4IgAMPWYCKGJRyfmCpWCiVp3rlRLOqq0arXUQWidohjvXZlibjf08XupPBQxxIlX4KBZhilc2WHvrnk14Iyqh7e0vgzWJXKAGX4MVU2fAZlg3EhnSD3uQrnJri4BATBtouEj0P8NjfTFrOm355es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NyReIWmu; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaZLo079567;
	Wed, 3 Apr 2024 15:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176595;
	bh=m/N3CzMxaS7yhX0k7iLE7QjhuIiupwLxVyAaTqmAzeA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NyReIWmu5N1TL8HhMeraskEkpT++N7yolDcmZtyYjod9FWyUpC2rPN4a3tXkI6J5X
	 bg/V3Sf3gYD2iHR6HvUUUYO7mhfgtNpz9cNHpo87oQucvgvL5xDG3jIrHkLos5l0aA
	 Kd2GV36K3ZYkzQAK4Qu5e8SU1h6bPa0f3PKb24ls=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaZd1000493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:35 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFh080324;
	Wed, 3 Apr 2024 15:36:35 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 02/31] hwmon: (adm1021) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:04 -0500
Message-ID: <20240403203633.914389-3-afd@ti.com>
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
 drivers/hwmon/adm1021.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
index 7c15398ebb378..87b42e0cfd2ef 100644
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -440,8 +440,6 @@ static void adm1021_init_client(struct i2c_client *client)
 	i2c_smbus_write_byte_data(client, ADM1021_REG_CONV_RATE_W, 0x04);
 }
 
-static const struct i2c_device_id adm1021_id[];
-
 static int adm1021_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -453,7 +451,7 @@ static int adm1021_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	data->type = i2c_match_id(adm1021_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	mutex_init(&data->update_lock);
 
 	/* Initialize the ADM1021 chip */
-- 
2.39.2


