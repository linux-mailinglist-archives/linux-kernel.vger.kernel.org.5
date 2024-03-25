Return-Path: <linux-kernel+bounces-117933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2889C88B174
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A85C1C27E70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307E65DF0E;
	Mon, 25 Mar 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gcTyZPfB"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A183A28E7;
	Mon, 25 Mar 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398698; cv=none; b=iHWRkrj6d35WNDGe+5iIow0wdMz3spVA60NmtJMdWFS1mrb/1/Fi3E1I6/uPvZYjKS6PkZhj6bJL2Jkg3Anc/gJHUF+Iboxl4VrDbvvWJJC9zvIU6lmOSlnEQxSP1c/u8q5l6ntuUFv4tP4sWcrBGQzaZEY9y4Y1F7rPVYgkMaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398698; c=relaxed/simple;
	bh=4RdNXl7J5Ue1f/bMVB4eEDYGbf76/32Mfiy33wdLVKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpOKPWFCS1Ua/s0R18jsBUAW4byFPXFuu1suyeKXX+GmGhM3+91Xz7+/beWXn7WZUg+RbJeSgfsDDVUN4HjkYoEuqXrO5jb/bKALP3iQCbMju6Dhrg/I3EHSjal5wpp5TqS8FygJoXV2dGFpAcqKeIlXBn/UmT0oB6rrkZpxKR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gcTyZPfB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVWib081359;
	Mon, 25 Mar 2024 15:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711398692;
	bh=6oiZ2Ci2p4F5RMIzGjiy5HbYGMOsLi6d6FjH8V9nNbo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gcTyZPfBJPgqp7LG0TNd/2JspTFSvlMXTfa9M3bV6cZAcHYOEZED5HRycgDXt5NdO
	 Zxq+Om/Tai+SGQaofg2O3ZM/r6zNXH6W2Tx6GWpUwjxVMdHJ9zwLHt/dT9cV/bJOC4
	 MS4PLurWL1IOGtx3w9UTlvKcGIvwKpiOx/QJyRgE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PKVWIf115366
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 15:31:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 15:31:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 15:31:32 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVUHh004442;
	Mon, 25 Mar 2024 15:31:32 -0500
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 6/6] power: supply: bq27xxx: Move health reading out of update loop
Date: Mon, 25 Mar 2024 15:31:29 -0500
Message-ID: <20240325203129.150030-6-afd@ti.com>
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
itself in an a function parameter. Update health reading to match.

As health is not checked for changes as part of the update loop, remove
the read of this from the periodic update loop. This saves I2C/1W
bandwidth. It also means we do not have to cache it, fresh values are
read when requested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 30 +++++++++++++++-----------
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index fe1b0af143ca7..750fda543308c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1777,19 +1777,26 @@ static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
 		return false;
 }
 
-static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
+static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di,
+				       union power_supply_propval *val)
 {
+	int health;
+
 	/* Unlikely but important to return first */
 	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
-		return POWER_SUPPLY_HEALTH_OVERHEAT;
-	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
-		return POWER_SUPPLY_HEALTH_COLD;
-	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
-		return POWER_SUPPLY_HEALTH_DEAD;
-	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
-		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
-
-	return POWER_SUPPLY_HEALTH_GOOD;
+		health = POWER_SUPPLY_HEALTH_OVERHEAT;
+	else if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
+		health = POWER_SUPPLY_HEALTH_COLD;
+	else if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
+		health = POWER_SUPPLY_HEALTH_DEAD;
+	else if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
+		health = POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
+	else
+		health = POWER_SUPPLY_HEALTH_GOOD;
+
+	val->intval = health;
+
+	return 0;
 }
 
 static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int flags)
@@ -1874,7 +1881,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
 		di->cache.flags = cache.flags;
-		cache.health = bq27xxx_battery_read_health(di);
 
 		/*
 		 * On gauges with signed current reporting the current must be
@@ -2092,7 +2098,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_pwr_avg(di, val);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		ret = bq27xxx_simple_value(di->cache.health, val);
+		ret = bq27xxx_battery_read_health(di, val);
 		break;
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ27XXX_MANUFACTURER;
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index d743270799d75..5180dc9f17064 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -49,7 +49,6 @@ struct bq27xxx_access_methods {
 struct bq27xxx_reg_cache {
 	int capacity;
 	int flags;
-	int health;
 };
 
 struct bq27xxx_device_info {
-- 
2.39.2


