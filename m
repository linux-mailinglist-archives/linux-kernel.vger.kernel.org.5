Return-Path: <linux-kernel+bounces-117934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DB588B588
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10DAC46B86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7456DCE8;
	Mon, 25 Mar 2024 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NzaQpG3J"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D94E1C1;
	Mon, 25 Mar 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398698; cv=none; b=jl7VsSPWP5xo0fIXFg9HFy5qdnSDuCiP186SqM+4wQPEuXdaRG7AIKInFY8S15OlMxW8PhdJ7erAac68XnV6fx/97gDS4q6Cx5UaqyY1QZqiC+FtiEUpJ1bcUz3OxEym4MNVd8whavJQvKFeBexPCKAzVqr7ObdlUYlAhzNkkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398698; c=relaxed/simple;
	bh=Unc05eMPVoAqms/FvEGJL04OOPSn9KeRoFE0X3BN2Tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oflY7JtNpXgQWwt+T3sKLQGBysPbxYxWZGrfIxHJp9UD+WUjwwN8cKyiVQ32fcfZ3CNfz/fIJURMl7Bot1bdhce5xfoCFFpRJbypPw49wxRzB5sAz7oGNJhzHZTJe3dwNPX0qNfasr70diqpaPqn3VoRXTyf9HtGbQ6GCnC4enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NzaQpG3J; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVWKX062139;
	Mon, 25 Mar 2024 15:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711398692;
	bh=a13e89s4Pbtq2HVyNW5w8C2tltN6lgPl0Yh6XBZGCZs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NzaQpG3JfnLF8LR081dx9gtx53xW28+63rW40zbCeioNreBWlTNaVpo01IpWKq7X3
	 hF9+LxHbyL9OJvxiVaQ4OAIi/IqhlW+GF3sZbMuDX6jQ5XhZMoEjjAV04Fy+C4jsn/
	 2Zl0pu4fmAmSjHkZHhdKsNCnG+LNJGLpn5mIhDPM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PKVVhv067474
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 15:31:31 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 15:31:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 15:31:31 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PKVUHe004442;
	Mon, 25 Mar 2024 15:31:31 -0500
From: Andrew Davis <afd@ti.com>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel
	<sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 3/6] power: supply: bq27xxx: Move charge reading out of update loop
Date: Mon, 25 Mar 2024 15:31:26 -0500
Message-ID: <20240325203129.150030-3-afd@ti.com>
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
itself in an a function parameter. Update charge reading to match.

As charge state is not checked for changes as part of the update loop,
remove the read of this from the periodic update loop. This saves
I2C/1W bandwidth. It also means we do not have to cache it, fresh
values are read when requested.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/bq27xxx_battery.c | 29 +++++++++++++++-----------
 include/linux/power/bq27xxx_battery.h  |  1 -
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index dcfe3c10e7ed3..799ee0aa9ef79 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1545,7 +1545,8 @@ static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
  * Return a battery charge value in µAh
  * Or < 0 if something fails.
  */
-static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
+static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg,
+				       union power_supply_propval *val)
 {
 	int charge;
 
@@ -1561,34 +1562,39 @@ static int bq27xxx_battery_read_charge(struct bq27xxx_device_info *di, u8 reg)
 	else
 		charge *= 1000;
 
-	return charge;
+	val->intval = charge;
+
+	return 0;
 }
 
 /*
  * Return the battery Nominal available capacity in µAh
  * Or < 0 if something fails.
  */
-static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di)
+static inline int bq27xxx_battery_read_nac(struct bq27xxx_device_info *di,
+					   union power_supply_propval *val)
 {
-	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
+	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC, val);
 }
 
 /*
  * Return the battery Remaining Capacity in µAh
  * Or < 0 if something fails.
  */
-static inline int bq27xxx_battery_read_rc(struct bq27xxx_device_info *di)
+static inline int bq27xxx_battery_read_rc(struct bq27xxx_device_info *di,
+					  union power_supply_propval *val)
 {
-	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_RC);
+	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_RC, val);
 }
 
 /*
  * Return the battery Full Charge Capacity in µAh
  * Or < 0 if something fails.
  */
-static inline int bq27xxx_battery_read_fcc(struct bq27xxx_device_info *di)
+static inline int bq27xxx_battery_read_fcc(struct bq27xxx_device_info *di,
+					   union power_supply_propval *val)
 {
-	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_FCC);
+	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_FCC, val);
 }
 
 /*
@@ -1860,7 +1866,6 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	if ((cache.flags & 0xff) == 0xff)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
-		cache.charge_full = bq27xxx_battery_read_fcc(di);
 		cache.capacity = bq27xxx_battery_read_soc(di);
 		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
 			cache.energy = bq27xxx_battery_read_energy(di);
@@ -2058,12 +2063,12 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		if (di->regs[BQ27XXX_REG_NAC] != INVALID_REG_ADDR)
-			ret = bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
+			ret = bq27xxx_battery_read_nac(di, val);
 		else
-			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
+			ret = bq27xxx_battery_read_rc(di, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = bq27xxx_simple_value(di->cache.charge_full, val);
+		ret = bq27xxx_battery_read_fcc(di, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = bq27xxx_battery_read_dcap(di, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e89ef989a5752..1c67fa46013b3 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -47,7 +47,6 @@ struct bq27xxx_access_methods {
 };
 
 struct bq27xxx_reg_cache {
-	int charge_full;
 	int cycle_count;
 	int capacity;
 	int energy;
-- 
2.39.2


