Return-Path: <linux-kernel+bounces-117932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2C88B5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDD0C45D17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680E15BAFA;
	Mon, 25 Mar 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ry2DyffB"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FF524B4;
	Mon, 25 Mar 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398697; cv=none; b=CJRNaP/dCub0+BEzb2BL0WGbsXFb2pbjMDa1aaKJm17F1/A9ZNviyD0D7uFWYgDIaM/3D1ChEGDU5cb+c4tseMf+Q6nPPnX0Eg6TslexZggC7NQQV87sk/q9brbQ5Cm+PTzE2gpveWk9FJvu63DYNpQ8BGBuo4kH370Kz/JCh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398697; c=relaxed/simple;
	bh=ib27D1WDbl2uIi4POR7MmfTkKZ9dpPi28dK+vAPHHuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7ghI/jLJOduw3soZNNfW3dRUjLi2mV7oR9frbp84ty/l+8Hu6AhvXNyEhZjtTNcuZ8cICTjQPZEYPpzzsH2M+sElFOzwf0GeXPGZbfEs+Ykq0HI4lzVv1ejrmCBYD8tbyGFJEGTI5saAusDt+WuLLCOztQEWVeRaqiLy0tCTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ry2DyffB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVWwh062143;
	Mon, 25 Mar 2024 15:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711398692;
	bh=I5LRNzLxsZsIRTc5pfXoIv0jOyNKWzMyWuv24BZ0nQ0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ry2DyffBx9Xb7PhO9ceHJ8LLpZZps2RPHyIFHIcMF1ynRoVI/FLQggS+Pg5zNd3cq
	 OaR2uknvwxBpxKESdla3Swc8NCS2LlIQPEbBO0AK/lrEn8Y04C5pfko6dcKo+vgGsm
	 mdBWt12tX17SG5KupeQf7QrKJMvnkTfv/gXBGkcE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PKVWmj115357
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 15:31:32 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 15:31:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 15:31:31 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVUHf004442;
	Mon, 25 Mar 2024 15:31:31 -0500
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 4/6] power: supply: bq27xxx: Move energy reading out of update loop
Date: Mon, 25 Mar 2024 15:31:27 -0500
Message-ID: <20240325203129.150030-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325203129.150030-1-afd@ti.com>
References: <20240325203129.150030-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Most of the functions that read values return a status and put the value
itself in an a function parameter. Update energy reading to match.

As energy is not checked for changes as part of the update loop,
remove the read of this from the periodic update loop. This saves
I2C/1W bandwidth. It also means we do not have to cache it, fresh
values are read when requested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 11 ++++++-----
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 799ee0aa9ef79..eae2b9a60f407 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1639,7 +1639,8 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di,
  * Return the battery Available energy in µWh
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di)
+static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di,
+				       union power_supply_propval *val)
 {
 	int ae;
 
@@ -1654,7 +1655,9 @@ static int bq27xxx_battery_read_energy(struct bq27xxx_device_info *di)
 	else
 		ae *= 1000;
 
-	return ae;
+	val->intval = ae;
+
+	return 0;
 }
 
 /*
@@ -1867,8 +1870,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
-		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-			cache.energy = bq27xxx_battery_read_energy(di);
 		di->cache.flags = cache.flags;
 		cache.health = bq27xxx_battery_read_health(di);
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
@@ -2084,7 +2085,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
-		ret = bq27xxx_simple_value(di->cache.energy, val);
+		ret = bq27xxx_battery_read_energy(di, val);
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 1c67fa46013b3..5c75abf3cf069 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -49,7 +49,6 @@ struct bq27xxx_access_methods {
 struct bq27xxx_reg_cache {
 	int cycle_count;
 	int capacity;
-	int energy;
 	int flags;
 	int health;
 };
-- 
2.39.2


