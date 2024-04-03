Return-Path: <linux-kernel+bounces-130566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2D8979FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CEF28C534
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A8157A56;
	Wed,  3 Apr 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HmMY0tAM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB1156F52;
	Wed,  3 Apr 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176626; cv=none; b=Pmwl8Kxdk4qUN1hAesBJEj75nbTUkjhWEVoJBZlQN3tWNgR16k3MjjzHnrV/+vdpu7wUXHN2+NVootOiRu0jyFyFBr2y0mF5gLcMKYEqtxofoxXdbrHy9LBqTihLKGGKOXP6XAtfgas/+hBQYkHRMZMD3yQIYCBoKBhuLgLUcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176626; c=relaxed/simple;
	bh=Fcsy7U0/zN4YmwfH+1lI8fpDJuJo06ipaQB7zIKzDkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk5lI+cOyGz0Y+gJTRbHumh9T6I46OYIJHQREfoNb+4tpcJ0Jvp5lYuyF+3GSmwTRAu10lX1TNHDMfM155GNqOlqcnsfgkkpsK0NFqiuwHPIQu/vHEnm/YgrGbcHFhKsHxGfHrKUbKjez4xZng4fswspXq8GS16YQ4OyWfya0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HmMY0tAM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KabcX076301;
	Wed, 3 Apr 2024 15:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176597;
	bh=blgQGHWD87ZJY8vnu2bep0EjvDVDGNrPkRIBtJghVk8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HmMY0tAMhdfdouDPjzAN2+sw9c//xoMa7P7RbhZgXAPRZcfUV62vm/deSm+2x4c3U
	 DmPMsKVeRb9NYa4gBcR9mMHAVephocVYigUgaP5MepbGfnCQdoViIzi7ZfBjthVwkB
	 Tu7yY7xfM2ALmGRML4yFOGHZQXqUtmWLXUcenV2U=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KabEa092365
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:37 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFn080324;
	Wed, 3 Apr 2024 15:36:37 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 08/31] hwmon: (ds1621) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:10 -0500
Message-ID: <20240403203633.914389-9-afd@ti.com>
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
 drivers/hwmon/ds1621.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index bffbc80401718..42ec34cb8a5f8 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -342,8 +342,6 @@ static const struct attribute_group ds1621_group = {
 };
 __ATTRIBUTE_GROUPS(ds1621);
 
-static const struct i2c_device_id ds1621_id[];
-
 static int ds1621_probe(struct i2c_client *client)
 {
 	struct ds1621_data *data;
@@ -356,7 +354,7 @@ static int ds1621_probe(struct i2c_client *client)
 
 	mutex_init(&data->update_lock);
 
-	data->kind = i2c_match_id(ds1621_id, client)->driver_data;
+	data->kind = (uintptr_t)i2c_get_match_data(client);
 	data->client = client;
 
 	/* Initialize the DS1621 chip */
-- 
2.39.2


