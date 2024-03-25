Return-Path: <linux-kernel+bounces-117931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FA88B172
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439591C28FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB45B5B3;
	Mon, 25 Mar 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aaOZabnO"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B4D524B1;
	Mon, 25 Mar 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398697; cv=none; b=KqTAmgOaemT7TZS8deLxOsAHKHvLBHhlqDMgx3MZexZByfTIyG7LuzFuCcCnJ31JqKUbUpalXjkjjCjMUZyb/KLGcklPQxPc/CPgEaqivO+9ge6enBYsBtukOzAIvE9H/S1mY4wnnmHVV8ffMgL7GaK17n5R98D8cPvIuUEeE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398697; c=relaxed/simple;
	bh=WJTDke0lnj5fetV2pxypuHP46seUH87JIsS+l/UeRew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9gpK9l/J7a+87ZOPURYqVPGUX8Q199WXUDpa9TO4b2tpp5k6KrBiIY8yMdMaq7E4T4+v59P+x5hu08URTPSIN2s2ztbsvOa0Ie+XlRMXbJiXkAboz0jTE39YgX7dXMMZbjVQ5TOioyy3ZGdpIVupNQIANtdTRe76C4TUfpymZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aaOZabnO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVWde062147;
	Mon, 25 Mar 2024 15:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711398692;
	bh=/HdoomeO31XQd4Mq+PNjVFZimQrMign3yDAOf9yDcv0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aaOZabnOLloKQHit0BY513cvRuyZZCTE+yUChDzYEnkCozqDaOMC6wZRB9sDNiF3Z
	 fB4WvfZoKuikpvsOxcV5bfSQCH81Po/YnQ1++EBq7pctVhLUDHn/cLW/lo+hfp3OWq
	 r8enkxcjhrT2xgxTA4sFJ1l4QUMdmMTwMqSo7qRg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PKVWS2001403
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 15:31:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 15:31:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 15:31:32 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVUHg004442;
	Mon, 25 Mar 2024 15:31:31 -0500
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 5/6] power: supply: bq27xxx: Move cycle count reading out of update loop
Date: Mon, 25 Mar 2024 15:31:28 -0500
Message-ID: <20240325203129.150030-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325203129.150030-1-afd@ti.com>
References: <20240325203129.150030-1-afd@ti.com>
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
itself in an a function parameter. Update cycle count reading to match.

As cycle count is not checked for changes as part of the update loop,
remove the read of this from the periodic update loop. This saves I2C/1W
bandwidth. It also means we do not have to cache it, fresh values are
read when requested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 11 ++++++-----
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index eae2b9a60f407..fe1b0af143ca7 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1690,7 +1690,8 @@ static int bq27xxx_battery_read_temperature(struct bq27xxx_device_info *di,
  * Return the battery Cycle count total
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_cyct(struct bq27xxx_device_info *di)
+static int bq27xxx_battery_read_cyct(struct bq27xxx_device_info *di,
+				     union power_supply_propval *val)
 {
 	int cyct;
 
@@ -1698,7 +1699,9 @@ static int bq27xxx_battery_read_cyct(struct bq27xxx_device_info *di)
 	if (cyct < 0)
 		dev_err(di->dev, "error reading cycle count total\n");
 
-	return cyct;
+	val->intval = cyct;
+
+	return 0;
 }
 
 /*
@@ -1872,8 +1875,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.capacity = bq27xxx_battery_read_soc(di);
 		di->cache.flags = cache.flags;
 		cache.health = bq27xxx_battery_read_health(di);
-		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
-			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
 		/*
 		 * On gauges with signed current reporting the current must be
@@ -2082,7 +2083,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		return -EINVAL;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
-		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
+		ret = bq27xxx_battery_read_cyct(di, val);
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
 		ret = bq27xxx_battery_read_energy(di, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 5c75abf3cf069..d743270799d75 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -47,7 +47,6 @@ struct bq27xxx_access_methods {
 };
 
 struct bq27xxx_reg_cache {
-	int cycle_count;
 	int capacity;
 	int flags;
 	int health;
-- 
2.39.2


