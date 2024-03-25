Return-Path: <linux-kernel+bounces-117929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007F88B16E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3BC305843
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012B59168;
	Mon, 25 Mar 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="baJEeXcn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C150248;
	Mon, 25 Mar 2024 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398696; cv=none; b=hdiD54K+p3xXi74cDDT262L651tJo2Hg0vbdtSQi7FYoP3ZOR1Q5RKVDdiP6YzsA0B3RZhpP4/da7L2McLovRssFRNK5czGwj0ljdydFZkKosSD3e2NYxUsWKRyd2m6HgsUhughhp8BYwXGbFaVSp5S1/zBEP2V/JJsS1kpiYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398696; c=relaxed/simple;
	bh=DYghL9pZeMuFoPTUQ7r7nDGpxRHkRWpT1XtCuqFkBDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5M/ep0QdALkZ9Epu8/0t36zEuQBOTJa9pzmNPaXD3vCj8FRJASmieoQrJvpJ4goZKwcH8HETnkPrCcPIbFytkqtnbGYSSm22Yss/cd162kTdfq+deihjtcjLUi80dk5ubiKmNZXv15g1/YohreF/zdxxyCzCBcOSZ4nMVaUV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=baJEeXcn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVVb8105464;
	Mon, 25 Mar 2024 15:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711398691;
	bh=GSrThxlZYIsRYc848usB0nxv1T6WYirHxZ4wQHT5oBI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=baJEeXcnnEmRjzmscM13yLMBqfbgPKT6GrPbh3k9IZRKUcS9gd5ljyB4OT7V/lIJ9
	 sMd0lOkwydCS17GcauuPcWxXet/Nt1YSTICacGxnLfnRGGLV8145Rk7oFUmzVU/ekj
	 OjGQT8wQQewAI4J15f/DA37c9VrjqPIWKxN0l3JQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PKVVcF067464
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 15:31:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 15:31:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 15:31:31 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVUHd004442;
	Mon, 25 Mar 2024 15:31:31 -0500
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 2/6] power: supply: bq27xxx: Move time reading out of update loop
Date: Mon, 25 Mar 2024 15:31:25 -0500
Message-ID: <20240325203129.150030-2-afd@ti.com>
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
itself in an a function parameter. Update time reading to match.

As time is not checked for changes as part of the update loop, remove
the read of the this from the periodic update loop. This saves
I2C/1W bandwidth. It also means we do not have to cache it, fresh
values are read when requested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 20 ++++++++------------
 include/linux/power/bq27xxx_battery.h  |  3 ---
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 00b2a56039ac0..dcfe3c10e7ed3 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1696,7 +1696,8 @@ static int bq27xxx_battery_read_cyct(struct bq27xxx_device_info *di)
  * Read a time register.
  * Return < 0 if something fails.
  */
-static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
+static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg,
+				     union power_supply_propval *val)
 {
 	int tval;
 
@@ -1710,7 +1711,9 @@ static int bq27xxx_battery_read_time(struct bq27xxx_device_info *di, u8 reg)
 	if (tval == 65535)
 		return -ENODATA;
 
-	return tval * 60;
+	val->intval = tval * 60;
+
+	return 0;
 }
 
 /*
@@ -1857,13 +1860,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	if ((cache.flags & 0xff) == 0xff)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
-		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
 		cache.charge_full = bq27xxx_battery_read_fcc(di);
 		cache.capacity = bq27xxx_battery_read_soc(di);
 		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
@@ -2046,13 +2042,13 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_read_temperature(di, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
-		ret = bq27xxx_simple_value(di->cache.time_to_empty, val);
+		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
-		ret = bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
+		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
-		ret = bq27xxx_simple_value(di->cache.time_to_full, val);
+		ret = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF, val);
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		if (di->opts & BQ27XXX_O_MUL_CHEM)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 64b2749d9562b..e89ef989a5752 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -47,9 +47,6 @@ struct bq27xxx_access_methods {
 };
 
 struct bq27xxx_reg_cache {
-	int time_to_empty;
-	int time_to_empty_avg;
-	int time_to_full;
 	int charge_full;
 	int cycle_count;
 	int capacity;
-- 
2.39.2


