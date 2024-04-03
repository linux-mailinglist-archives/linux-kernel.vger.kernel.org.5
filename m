Return-Path: <linux-kernel+bounces-130580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A63FF897A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457981F21D07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11859158DA5;
	Wed,  3 Apr 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dAfrhcC8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E91586E0;
	Wed,  3 Apr 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176633; cv=none; b=Jof5x+s+r7azW3BS+7/V4vzS5ffuGXfpw5yURMM9LgSkHUjK/s8M39/zlH51I4uowyq0r4DxFA8Zpb9qnAwHQRbWsm/en238Kd6udbz7oF5/Oy2WFr3hif5H8+hQuxzanEeO8ZNcw8U7HO0NBtYeL/VgPgdZCcsrtInJjiAbm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176633; c=relaxed/simple;
	bh=P02+nXdJbqfYxf4tQf2Pbpb0u9iI7e2xMOts+NOqO5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgrA7ML1eOYwculNoKYxCalzCVeUpcedHavQH3F4D3pXxuYuc+qQy68dMqaPkA+lJ4XZDBvWlYeLdgl4SzhFTieO0bLSjqICtaqe+UQAyDPHGGWUuwr4dxRGN3ef03Or6G7zuSmQClKuPkyuTQTaFOO76HgG8AlgEnDlODldh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dAfrhcC8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KahUQ038556;
	Wed, 3 Apr 2024 15:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176603;
	bh=kN8uor3TFZ1XDxUmVKlBH/TOnvxRGZwHhs7wYGaT+2E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dAfrhcC8JFnS+fZguTPZkrDrYSbGR3YJoHjpdrnKn96qtXo98EoHrE3cGtmV8MzNW
	 TOAt1lj+XwLjTfT/7o21rQYmaEp6MwN1sdOZ+OmZzCkMiFeotdAgbtyhTu5ZxlKMXv
	 tiJuaODsIiLSI95PYVZkYEVTQrBBhMLKBO/6YqmY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kahsi115311
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:43 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:43 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYG7080324;
	Wed, 3 Apr 2024 15:36:42 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 26/31] hwmon: (thmc50) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:28 -0500
Message-ID: <20240403203633.914389-27-afd@ti.com>
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
 drivers/hwmon/thmc50.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index 68ba26bc90142..0cbdb91698b1f 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -377,8 +377,6 @@ static void thmc50_init_client(struct thmc50_data *data)
 	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
 }
 
-static const struct i2c_device_id thmc50_id[];
-
 static int thmc50_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -391,7 +389,7 @@ static int thmc50_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data->client = client;
-	data->type = i2c_match_id(thmc50_id, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	mutex_init(&data->update_lock);
 
 	thmc50_init_client(data);
-- 
2.39.2


