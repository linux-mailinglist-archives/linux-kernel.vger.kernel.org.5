Return-Path: <linux-kernel+bounces-130583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A465897A20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2C51C20C99
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1021158DD6;
	Wed,  3 Apr 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qkvTq5ki"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856E15885C;
	Wed,  3 Apr 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176634; cv=none; b=GrY8XQaOYYuSvFDCuNKN6sH2+oGkB6CvRET6lw1kKqEU57eV1tE1CT0oeXiJhadgXoc0bW3eDX7+mtFF74qF7UbzteO5aCtUCHE4NtsrOZ/ILNSXbY7vZGqBYzhelq4CF7qFyR85GbQ/vjliuqzAO74iLHABWDuiqLEHAp8pEBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176634; c=relaxed/simple;
	bh=OuyFG07uniwB23FrwfjyibbHLOUKBP2QbqqS5rtW5Kw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJGQ438sLdWAK7pbnGWbNf3ejHRoxfZW85TN/PJmuOQcG9LtIb2v/cmwh9Z9ffempwvr8FvHOjxvZem8GRzqn0SRQbI1+ycRRc/GoXWb3NYM4jSKu8M/g0VkvAV4R6iII/+/YXdm/Dkz3ZRzMhFvILPmBZDVNeVKavZtAHJ7WWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qkvTq5ki; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kabbb076389;
	Wed, 3 Apr 2024 15:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176597;
	bh=P9m8XX8RkK7F9kUnAd6NeB+F6XpajJFyRRLbsFk3hWY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qkvTq5ki8JM08wmpYmi6lROYyTNc11PHe+sioJitcB9+GP+yLAxCzuG/grcFirpcp
	 afDTokK2y3+QgPwfGps4AL6WOUJ0salYMI/AHtbf5dRMFa+yerX1D/7Q5rgCuiU1FW
	 mF6C4FftYFiw8uuohFEG2ri7dGkoL7Gud4DFnRLM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KabWi115241
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:37 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:36 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFl080324;
	Wed, 3 Apr 2024 15:36:36 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 06/31] hwmon: (aht10) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:08 -0500
Message-ID: <20240403203633.914389-7-afd@ti.com>
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
 drivers/hwmon/aht10.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/aht10.c b/drivers/hwmon/aht10.c
index f136bf3ff40ad..312ef3e987540 100644
--- a/drivers/hwmon/aht10.c
+++ b/drivers/hwmon/aht10.c
@@ -331,8 +331,7 @@ static const struct hwmon_chip_info aht10_chip_info = {
 
 static int aht10_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_match_id(aht10_id, client);
-	enum aht10_variant variant = id->driver_data;
+	enum aht10_variant variant = (uintptr_t)i2c_get_match_data(client);
 	struct device *device = &client->dev;
 	struct device *hwmon_dev;
 	struct aht10_data *data;
-- 
2.39.2


