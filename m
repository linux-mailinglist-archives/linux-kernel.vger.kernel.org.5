Return-Path: <linux-kernel+bounces-130576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13165897A12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE128868E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C315886F;
	Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GAWQIJBX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007851581EA;
	Wed,  3 Apr 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176631; cv=none; b=rZ3ZnYGSwFtSArGaln18J/DUJluRoWRCtYWrW54aDeLJfmVXNMQrHJXQXkRq4dalZ+vDYA3LXROYnnq0xInjQSwZJSsnPzUNC1k+T/uauGYLTaenkUVoqy12PuwzfYoImkIBBh+IjMMY+Y3gBM+n8nl+85sMCpMh7u3KGo5TF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176631; c=relaxed/simple;
	bh=htYl1xEKTxhf+91LyIRRinKUV2fmdiibhEQeoLxwBaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGag/Q76WWdgPQwbrlGgY4OWj9EjkkJhfoNBAEoRVs8XnaBqWMocc6gHrFPBxTOXbxo6peIbW7aDQ63ItMsXmmKKZKzN+ocX4UnX5FAovG1XZk0GY+bX2MYGSPEZ7w/kpgaPE5TXRJJ6Y477Zco3cFg7R+3mqmTTpUia4bIdgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GAWQIJBX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaaZ7079571;
	Wed, 3 Apr 2024 15:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176596;
	bh=vLG7nR3cXKqdnmHs0sRyFkgQxJmyQMwMWdu+b28S8xk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GAWQIJBXnDF3pCwa6hkTnjJgFBrxfsnxvV+X2tFZ2KzY+vWrN1PUydgAIuA51kpCt
	 hsqeqW3d0Jmv3Ac/KGZrsO9A/fG9EOi/ObUHw8cYNlF8T2ZWX9NdvhDFc3+l0mTAsv
	 aS5swoLdt9Pnx4uAoPmfNIJKTcDjc8AM7brWgd4Q=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaaUR115231
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:36 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:35 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFi080324;
	Wed, 3 Apr 2024 15:36:35 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 03/31] hwmon: (adm1031) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:05 -0500
Message-ID: <20240403203633.914389-4-afd@ti.com>
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
 drivers/hwmon/adm1031.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 88c7e0d62d089..343118532cdb4 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -1021,8 +1021,6 @@ static void adm1031_init_client(struct i2c_client *client)
 	data->update_interval = update_intervals[i];
 }
 
-static const struct i2c_device_id adm1031_id[];
-
 static int adm1031_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1035,7 +1033,7 @@ static int adm1031_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 	data->client = client;
-	data->chip_type = i2c_match_id(adm1031_id, client)->driver_data;
+	data->chip_type = (uintptr_t)i2c_get_match_data(client);
 	mutex_init(&data->update_lock);
 
 	if (data->chip_type == adm1030)
-- 
2.39.2


