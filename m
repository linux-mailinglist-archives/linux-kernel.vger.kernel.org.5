Return-Path: <linux-kernel+bounces-130585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23620897A25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71F1B21500
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1231159568;
	Wed,  3 Apr 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s/5jvsvx"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C2158A19;
	Wed,  3 Apr 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176635; cv=none; b=pjOWws+0Puu0tHdur866d0IsXiOEnziMnGndxw5Xq6vYjtSJFWqryJPyX68ooTducnY1QxxkmPufXEcVHjeOecFWof4QK1r/eRtG7r7DNUrCKyt5KIE/OC9p0L82Pv9VGZUFUuYoutg7F6fFyREoCFI7F3qHWgJgVJjBP2okX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176635; c=relaxed/simple;
	bh=3bF9HZhd95rHubrpI/LggbrJmVwuY2ntRRPOdv3C19Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsVohDrv2HY/a4ezRRoKGE7cYN+Ja8U4sRRqnODq9+xud1En6xyP0DTMaTILGa1BvyqlQ4zkrAy8FxrcFL+lvmIilKygkohTA2Bm1CMxoOftFZ6TO0yUrrfNxH7R2xCr/qjKKPPi42YfxhpTtKDTWzj+zkW7+ma3kzSS/aaTvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s/5jvsvx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433KacJ9076395;
	Wed, 3 Apr 2024 15:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712176598;
	bh=7RBoNzKSLhZWWy2KX9GDB0M7SGBppLwxbn39LKIlPqE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=s/5jvsvxVX4M/NH3nLsZzbx5WTCTZifDT4mwNdgC1Ee63jZ2ZqtfSKTEipErGU3io
	 Q9NiKN0zjDWXdHqQPTPqYFRK+5Hg/h5w69JPWwRStgnON6F3a+OidDqxQQ7evin2jk
	 F6wSReUBq7oEtCK+LjMsISNSOLZDF+ePsjnggclc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433KacIK052090
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 15:36:38 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 15:36:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 15:36:38 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433KaYFq080324;
	Wed, 3 Apr 2024 15:36:38 -0500
From: Andrew Davis <afd@ti.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Juerg Haefliger <juergh@proton.me>, Riku Voipio <riku.voipio@iki.fi>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 11/31] hwmon: (ina2xx) Remove use of i2c_match_id()
Date: Wed, 3 Apr 2024 15:36:13 -0500
Message-ID: <20240403203633.914389-12-afd@ti.com>
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
 drivers/hwmon/ina2xx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d8415d1f21fc5..f8b5d972191ee 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -612,8 +612,6 @@ static const struct attribute_group ina226_group = {
 	.attrs = ina226_attrs,
 };
 
-static const struct i2c_device_id ina2xx_id[];
-
 static int ina2xx_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -623,10 +621,7 @@ static int ina2xx_probe(struct i2c_client *client)
 	int ret, group = 0;
 	enum ina2xx_ids chip;
 
-	if (client->dev.of_node)
-		chip = (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		chip = i2c_match_id(ina2xx_id, client)->driver_data;
+	chip = (uintptr_t)i2c_get_match_data(client);
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
2.39.2


