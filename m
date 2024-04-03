Return-Path: <linux-kernel+bounces-130587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09448897A28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10D61F216A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B75158212;
	Wed,  3 Apr 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BYHPS/q5"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567D158A24;
	Wed,  3 Apr 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176637; cv=none; b=TQlHwD4akgVc04ljXIQeR8stZo4KcQXRbhV3u0/z4Jp+79ynsKy2X3MrG+c32JDQ26+ZVrGdW6s6CU87yjmfftPpgFsKT/HqJGBKr7WNswrWkwu72WrRhjg9RT0Kezb1HmdIVtK/qTqP4eEKIAT4Q/wTYu7djb4E2XZe5EkhiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176637; c=relaxed/simple;
	bh=DcJqhwHAqxnaGiAFyieMHYH+qxPUuLYnJBVlpdIApVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOPhatDrj6SviuVSkV+kfNV+gcCpRaraBPKu/qhVCUZxPcls0Nz0L1DyYyKwqPfhp8C7KzYQqtGaj3qPmi5Y+yyiPInxyr3j+dGh6VlwhMpL022cKpZvk7Xp7/kiPicl1+/pkWPlnfzvcOpZkzpeKUD+PpIC8HU0sQML18qx54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BYHPS/q5; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433Kaavv038522;
	Wed, 3 Apr 2024 15:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176596;
	bh=vO3CrxDkXJKU7WHeaTF/07p+El0Cl3/7dNxjIIWuxBA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BYHPS/q5eT+Ouncd/sa3IE+mkOB3vVlJ0kGb5RNgWkreWy9AnATvYgsNKhL+N26pU
	 eqzeM2tuKkOkC5PjEzkPWXR6lVI/HjCzQKk8kJg7GhyW72/NxY2dKhXtxvIRnatJJV
	 Yab51GiQipZPPI2dDarbZshQXkoA3iQs6j1DxE/c=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433Kaa4K000507
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:36 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:36 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFj080324;
	Wed, 3 Apr 2024 15:36:35 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 04/31] hwmon: (ads7828) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:06 -0500
Message-ID: <20240403203633.914389-5-afd@ti.com>
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
 drivers/hwmon/ads7828.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 809e830f52a6b..436637264056c 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -99,8 +99,6 @@ static const struct regmap_config ads2830_regmap_config = {
 	.val_bits = 8,
 };
 
-static const struct i2c_device_id ads7828_device_ids[];
-
 static int ads7828_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -138,10 +136,7 @@ static int ads7828_probe(struct i2c_client *client)
 		}
 	}
 
-	if (client->dev.of_node)
-		chip = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		chip = i2c_match_id(ads7828_device_ids, client)->driver_data;
+	chip = (uintptr_t)i2c_get_match_data(client);
 
 	/* Bound Vref with min/max values */
 	vref_mv = clamp_val(vref_mv, ADS7828_EXT_VREF_MV_MIN,
-- 
2.39.2


