Return-Path: <linux-kernel+bounces-130567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B479D8979FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63A01C23815
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21473157E61;
	Wed,  3 Apr 2024 20:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BqgMOgs6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794AB157466;
	Wed,  3 Apr 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176627; cv=none; b=fH1MDipsEI1CQCmUvA8KxHy5123y70CKAZKj95O4qHTrGSoSsHq5DcMxYbwSYm6Sbt533FwojDE4i/RVD//bKnluqsde+JOCGLtNSEr0iHeA3lUhKfEo90XssNUOiNG4ivwl60+3MgQpUJL1FpDGgtvvLS+xsBbUmVg2jyeBdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176627; c=relaxed/simple;
	bh=WaUcX9H4oocLmKmO4/fOKQ9tuQ+e/1+hxKKt4oh+R5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZ9JB6NGPDbF0Cl07KU1e8rxDMEcajAtdLTL6iVr/7OYxKnyEHgsGb8FlC9VPhWgSbE4bqjDeZ9/OeyNBLXrZHcC3FuW6ALaW/vWQiJYF4Bod9m8ZEbS0znKJuwVi4hdZgMA/TfjBV7Za1Vy69hzYDqoWQqYojQzbabZxHL8Wdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BqgMOgs6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KaeSI076320;
	Wed, 3 Apr 2024 15:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176600;
	bh=6FQQgLYLXxXsNReUZRpeaeGAylN2NabWPX8H64kVuOM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BqgMOgs6sEeVgEB8A6j1k8HkZ6SE3F38KRh2O0rtkH4F6uG8bQ2/leC0dzBX3MPRb
	 6kC+55v/hQ8txGq+tanmhIeDvgs9Bge9K95g+JasB8S0MpVhNB4EJ3o6BThEhRdi9j
	 X9FvAKthBTJFQ/VQ5WIM35ZbSOVZpAX22/xxB2DU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaekH115277
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:40 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFw080324;
	Wed, 3 Apr 2024 15:36:39 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 17/31] hwmon: (lm90) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:19 -0500
Message-ID: <20240403203633.914389-18-afd@ti.com>
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
 drivers/hwmon/lm90.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index e0d7454a301cf..a5c65fc21163e 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2764,10 +2764,7 @@ static int lm90_probe(struct i2c_client *client)
 	INIT_WORK(&data->report_work, lm90_report_alarms);
 
 	/* Set the device type */
-	if (client->dev.of_node)
-		data->kind = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		data->kind = i2c_match_id(lm90_id, client)->driver_data;
+	data->kind = (uintptr_t)i2c_get_match_data(client);
 
 	/*
 	 * Different devices have different alarm bits triggering the
-- 
2.39.2


