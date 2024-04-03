Return-Path: <linux-kernel+bounces-130561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F988979F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6821284213
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A2156F3A;
	Wed,  3 Apr 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iN+2zFaw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BDC156C68;
	Wed,  3 Apr 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176622; cv=none; b=MGHrWX5C2JMXLkZIYSm7ivhZySIfBlnnjG5JkTwcl0LshEWXlCOXSNGf2ImIKTTQ4qBoMxSfNGi6ivx2I65IASiAI/9yMF49P+B0J+sNlGMZzp7n1ppJ1YiVfc4LlrJU+nNwUZxGFZLiaUqp6YDDheuxhDr7um5apkG9fxoKD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176622; c=relaxed/simple;
	bh=TouGBAizAGe45Q6pQL2kVk1VX1tzRnXOe6tVx7bkE6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3cighSTgcavde5GCuwKon8v1hr/fN/zs0q+8o5aPP47OzY+sTn69zHyvITVFeY7KnlWbxET7iHRVgZ7MVYTkUnE8lzLJU2mkSegIRj/49tBeI38F9aBBz+x5yH6N6JHufKC08dpMgG8TySmEandMdP1GITuawX5qaEQ8/AV028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iN+2zFaw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kag1s076341;
	Wed, 3 Apr 2024 15:36:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176602;
	bh=+/2jo2sLpOlbbd+R85BE/NyEBAiwUG3DL8bouFKnMQY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iN+2zFawzHwHsSe1TAu4SY7r1YuWhLiRAiV6ISNm1YdDuEDoJKqHCvmTR41tOuKPg
	 D3BuW0ddzNFzuCDcnjQDH2qvTxNlavJj6l7rWQC9kGRyoW0ZUAsabRha9ZIaMBLPcG
	 tnR9Diihu/5rs41cDp5qGmwnu5M5ocQ5xh/aL0zI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KagAt115301
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:42 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:42 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG4080324;
	Wed, 3 Apr 2024 15:36:41 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 23/31] hwmon: (powr1220) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:25 -0500
Message-ID: <20240403203633.914389-24-afd@ti.com>
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
 drivers/hwmon/powr1220.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
index 2388d0565e7ec..5f9ca6543530d 100644
--- a/drivers/hwmon/powr1220.c
+++ b/drivers/hwmon/powr1220.c
@@ -279,12 +279,11 @@ static const struct hwmon_chip_info powr1220_chip_info = {
 	.info = powr1220_info,
 };
 
-static const struct i2c_device_id powr1220_ids[];
-
 static int powr1220_probe(struct i2c_client *client)
 {
 	struct powr1220_data *data;
 	struct device *hwmon_dev;
+	enum powr1xxx_chips chip;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -293,7 +292,8 @@ static int powr1220_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	switch (i2c_match_id(powr1220_ids, client)->driver_data) {
+	chip = (uintptr_t)i2c_get_match_data(client);
+	switch (chip) {
 	case powr1014:
 		data->max_channels = 10;
 		break;
-- 
2.39.2


