Return-Path: <linux-kernel+bounces-130562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736D8979F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D52852A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365D15746C;
	Wed,  3 Apr 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DdVml6XR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C3156F34;
	Wed,  3 Apr 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176624; cv=none; b=GpY1tSgHA5mo4q2Js90ES54cJHITyB00RV/0XA6RgbNjKTDrqu8CP0xF6+yFTObTpUnlP/WrVC0Y2ICnS7plxg/h9/vaAG0/RQFkuFn4A7/nqAtczeD+VLLwU/otx4clIyO0PxCZ6HesRDb2xM5MYiCLuwnEDmsKXc1ngwAVKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176624; c=relaxed/simple;
	bh=dP5nBeZ4OmeLq2nUhtY0MOmQkKqwR5I3iMT/iFabJJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCM9eCAntf2/CdMfdulSYMJX/oTRFOPjHyGnWZJ/4Z1c78dkPghuRMcYeAGhhjm90eVTDR9zjXrI+GOMdWTrX6sl9oBoUmhw+NyC2EY0IUSWIM4in+oCxWxAUuBmCIj6XmkefU/WmIgEGP6ox+1avLyrYX9pUxRti6ri4KGjlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DdVml6XR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kaijm076347;
	Wed, 3 Apr 2024 15:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176604;
	bh=3f+fWpc6UrtJFAy9Ej0B4JEpcUnkcygsQ6t500zmMgk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DdVml6XRQKSNjlXOZVHM0N3KI6Phiu2dhxAWkBk5kSePYr1afAcfmUBOtYT54m+0y
	 TCoG63d+FS+ZTWlvyAz/cBvyrYhwGhQef9TzPqoYE3cIE16PvzCLjEKkoCMXDFLx41
	 l80TgkRshWW4PleI/ihp6oa4x/M+tesuvv/xlGtA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KaiQV000578
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:44 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYGB080324;
	Wed, 3 Apr 2024 15:36:43 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 30/31] hwmon: (w83781d) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:32 -0500
Message-ID: <20240403203633.914389-31-afd@ti.com>
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
 drivers/hwmon/w83781d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index cba5ec432e6d1..b7957c84d2352 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1192,8 +1192,6 @@ static void w83781d_remove_files(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &w83781d_group_other);
 }
 
-static const struct i2c_device_id w83781d_ids[];
-
 static int w83781d_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1208,7 +1206,7 @@ static int w83781d_probe(struct i2c_client *client)
 	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 
-	data->type = i2c_match_id(w83781d_ids, client)->driver_data;
+	data->type = (uintptr_t)i2c_get_match_data(client);
 	data->client = client;
 
 	/* attach secondary i2c lm75-like clients */
-- 
2.39.2


