Return-Path: <linux-kernel+bounces-130584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F1897A24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB5F2866CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D7159569;
	Wed,  3 Apr 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JMOlb70M"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1E158A1C;
	Wed,  3 Apr 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176635; cv=none; b=uDtu3Wg5FnaSp5G09dHs6ayjZwDMrN/aaOTnCrd39WCiHQWJ/xk17LNPw83NlshIUw3652E6ss9Dd5cxTZQLNEb/IcFEP7hePJ7it2q/eONLPZKsfeImf6nC6Tr2kUPSVptZmTHmEXlfFvs0Ps1AuxzmPCPNLahrf/ZrRskLFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176635; c=relaxed/simple;
	bh=+L3wPgJG2F5w/3XKBeCEb5SvyQSpcS6LqZCOy3EyN5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blPZioFSICMRBZTlFDmN8PFCQkZPeMo7F0IaQ3YEoNtqkqusV6Cv4IFeZOV9GkjQS7R6Q7OKvB6VaAL8N/WDdgRbjvb30r9oHiu8LMs7oh/XilWs31klqsl20q1kx4dMWoL/d61nT+Otxm+i1CIO++z9tdVakQl51+MfPXy1dYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JMOlb70M; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaZrO076384;
	Wed, 3 Apr 2024 15:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176595;
	bh=n/lQYuX5u/cQQZZkgcKo4jIV9eSG7CRNsMGVGa/PAr0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JMOlb70MDC6V+qYeJpq6cA/PMi9qDedLtbTCSXQ1tp+TljkRZlwVfQRwZzFvpKw1x
	 5vOXU+TTxb32g8vL3pdPA2LMQtn63qMLY7Dc09KvEhC5MYV1wH+9o4gCMlEz77r0o3
	 2admnkllr3/Dy5mtEacuTDAFMa9dJh6DGW6wMhCA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaZ1e000488
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:35 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:35 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFg080324;
	Wed, 3 Apr 2024 15:36:34 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 01/31] hwmon: (ad7418) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:03 -0500
Message-ID: <20240403203633.914389-2-afd@ti.com>
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
 drivers/hwmon/ad7418.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index 4829f83ff52e3..7a132accdf8a3 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -230,8 +230,6 @@ static void ad7418_init_client(struct i2c_client *client)
 	}
 }
 
-static const struct i2c_device_id ad7418_id[];
-
 static int ad7418_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -252,10 +250,7 @@ static int ad7418_probe(struct i2c_client *client)
 
 	mutex_init(&data->lock);
 	data->client = client;
-	if (dev->of_node)
-		data->type = (uintptr_t)of_device_get_match_data(dev);
-	else
-		data->type = i2c_match_id(ad7418_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 
 	switch (data->type) {
 	case ad7416:
-- 
2.39.2


