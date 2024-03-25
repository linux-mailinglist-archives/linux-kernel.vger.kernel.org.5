Return-Path: <linux-kernel+bounces-117930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1688B16D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DE31FA55CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681FC58AA9;
	Mon, 25 Mar 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EAHvFG8Z"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDD50246;
	Mon, 25 Mar 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398696; cv=none; b=qhmJDKRMimWHZpZee/vRJm8PrDWvKls4rSMJqVj3I5HqTAlcWYL3ZYvD6QR2/NkKp5vmg3A3pt8YsgwLCrSjyOUmsNDMrvdxDUmJv+N7sPSzjfA5RxJA56VgRWeQeFgOMUYQE3/wucnKQ4R0Rn5p9ZjXhwQdIuP0GnpDSsGJMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398696; c=relaxed/simple;
	bh=El+Yq+H3sNAFUhKFQDU3VSN6wJ5kPPpGIOR4gFv+oe8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTmU8dfyLFZtTsy1ptAXGl+eNIwyi5IQ2rIXgOvnuVLighOX+4+NeVehIy2RUaak/frbg51B28EPi3qtc/dZaVFYH5+CIiolZ3/iHboenm8snmwWvJHorDfJwpHzQX99UnN3+3lAozwGrGytARNweCSw+WjXjyT6BJeq/3nWsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EAHvFG8Z; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVVIe062134;
	Mon, 25 Mar 2024 15:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711398691;
	bh=6iUFBNYH5MGTi8ZQEMq7ZpfnT9LBck2z6Tm2GsmD7bw=;
	h=From:To:CC:Subject:Date;
	b=EAHvFG8ZsAALKEgF56JGV4MxB70dd35eP0WXD8XpoZKpRW+FYZhY6MkD2gmF/LdSl
	 pGiVXfVk5YMzqC80gWnnQZYms8yWRBr9hSj4TH5N8RmYPsd4SVxYAOTNF/mElNx7wI
	 EVjT9/LFhA/raNUiCTFhr0vOfnHeTHXCCyRgBHgg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PKVVG9067461
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 15:31:31 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 15:31:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 15:31:31 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVUHc004442;
	Mon, 25 Mar 2024 15:31:30 -0500
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/6] power: supply: bq27xxx: Move temperature reading out of update loop
Date: Mon, 25 Mar 2024 15:31:24 -0500
Message-ID: <20240325203129.150030-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Most of the functions that read values return a status and put the value
itself in an a function parameter. Update temperature reading to match.

As temp is not checked for changes as part of the update loop, remove
the read of the temperature from the periodic update loop. This saves
I2C/1W bandwidth. It also means we do not have to cache it, fresh
values are read when requested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 17 ++++++++++-------
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index abca568344686..00b2a56039ac0 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1652,10 +1652,11 @@ static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di)
 }
 
 /*
- * Return the battery temperature in tenths of degree Kelvin
+ * Return the battery temperature in tenths of degree Celsius
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info *di)
+static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info *di,
+					    union power_supply_propval *val)
 {
 	int temp;
 
@@ -1668,7 +1669,12 @@ static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info *di)
 	if (di->opts & BQ27XXX_O_ZERO)
 		temp = 5 * temp / 2;
 
-	return temp;
+	/* Convert decidegree Kelvin to Celsius */
+	temp -= 2731;
+
+	val->intval = temp;
+
+	return 0;
 }
 
 /*
@@ -1851,7 +1857,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	if ((cache.flags & 0xff) == 0xff)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
-		cache.temperature = bq27xxx_battery_read_temperature(di);
 		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
 			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
 		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
@@ -2038,9 +2043,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_capacity_level(di, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		ret = bq27xxx_simple_value(di->cache.temperature, val);
-		if (ret == 0)
-			val->intval -= 2731; /* convert decidegree k to c */
+		ret = bq27xxx_battery_read_temperature(di, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
 		ret = bq27xxx_simple_value(di->cache.time_to_empty, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index b9e5bd2b42d36..64b2749d9562b 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -47,7 +47,6 @@ struct bq27xxx_access_methods {
 };
 
 struct bq27xxx_reg_cache {
-	int temperature;
 	int time_to_empty;
 	int time_to_empty_avg;
 	int time_to_full;
-- 
2.39.2


