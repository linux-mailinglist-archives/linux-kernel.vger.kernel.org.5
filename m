Return-Path: <linux-kernel+bounces-130571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33473897A09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22DB2869F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D31415821B;
	Wed,  3 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SFg30oPx"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93183157A47;
	Wed,  3 Apr 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176630; cv=none; b=eVbr5Vv+9vkFlatEdfbcxYEiScLEzpkUE9NAjYz8XwqJ1A2zAYThVFdZ0nRrtu3I5HGMsRN4C4CwG6fZSrIuy4eLLSI9bOGRLfRoGiHMylMJWn5MaHm7vJs6ysObYQSTJkuAg7Hbtg7P9AO6XeM5rvYNQV9PSZfd0PQEGhttsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176630; c=relaxed/simple;
	bh=0Fw2Z4VTG6YoXV3yLNJmhQau21aV6l17WNfYSo2iQZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcQYxra0SpC/g2jphzgJjZfOUPJCgH8efYq3T6VXeB8TuA0T67WgLdl2ngC5Ziqxl1aKGkaRXiDgwuRO6Uy6WK+mtGnwV3LW7FGmPbcE+nbN45ykRQWfotR45XVEjFYw2vKLuq9x4a8rGq1/2zpLykEwxg1Q5Mb/f3MtC66wKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SFg30oPx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KahKq079598;
	Wed, 3 Apr 2024 15:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176603;
	bh=qMfLozI0DMqanEMgIpvkrkvdZu7i1fxTHIM60wcusac=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SFg30oPx6PkiI3zCy5JbFh6HPIR0pdkBnkaBUeYff2BcHNnSj+EzHVRYjLfJ1LBuE
	 hvki4Ngd08yh/11I2HJf38WBZHM0EoRH0K1DKEj78uIFrM90gOt8dJeJQImtlszFTV
	 2M7ABj7eUfhGcKFHRXsvF4G8AvO2UEIFNCp/Vc7U=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KahNm115317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:43 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:43 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG9080324;
	Wed, 3 Apr 2024 15:36:43 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 28/31] hwmon: (tmp421) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:30 -0500
Message-ID: <20240403203633.914389-29-afd@ti.com>
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
 drivers/hwmon/tmp421.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 10b66c9ce0452..7a6f9532e5942 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -446,11 +446,7 @@ static int tmp421_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&data->update_lock);
-	if (client->dev.of_node)
-		data->channels = (unsigned long)
-			of_device_get_match_data(&client->dev);
-	else
-		data->channels = i2c_match_id(tmp421_id, client)->driver_data;
+	data->channels = (unsigned long)i2c_get_match_data(client);
 	data->client = client;
 
 	for (i = 0; i < data->channels; i++) {
-- 
2.39.2


