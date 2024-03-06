Return-Path: <linux-kernel+bounces-93711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37E8733AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFDB1C213D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257275FB95;
	Wed,  6 Mar 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rC1SNHtn"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F35F549;
	Wed,  6 Mar 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719756; cv=fail; b=IRwz9pKXhKPr3MBuTcWgQiYiKd4MVJByG60eHKXLOKU5XU/Y+11qKFBtTfwEN7UwpBtXz+YRnr6xqNJFTnCh/M06L0tG+pURJjrwt//3GaJnzYw9LzWaI9TSMnsoRCq2HgpejE6U6FvjMrOwXjafz4lO3Bh7+7iOO5aSadD4j0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719756; c=relaxed/simple;
	bh=oSpMdFmOHhQ+Z/fCey7nFjMsg//2gLZzg4fyUGwMf9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+RXeb9mSb7adVxmlv2qY8EFzAUAxeZMuGaR22asdTlWoX5/cT2sWuwAb4q0w7zcHXOC+6h0PvcnVZH61ZSjhve5fi+9qtT/ENw+bzpX9AwdwBibIlQGKDWSQiGDhRp7atv74eVCSyuoPk+vFphfLsVlTcURsdr6oKGjzgDi3WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rC1SNHtn; arc=fail smtp.client-ip=40.107.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnjR1gGdSXRR07fhItvPo87Er+WVnvXrcsOgDVJMvDcD2+g18HKYIASh3CoyQ4QtmjK8unqhyjVtlTmnWU/Ar9lnF89Fm8+YUYEd4B7V/NL5PS5ptz1uhJ0D7+VSNHrB7jgEP8tyhbU3BIkbd8Pqe0//Uf8VsypFekJ/5Jdxqhs2ncQsKG2xnIYNhFmpwW2YVnSNcm/xlWg/qj9b9OU2F2cPfvgwF/A1JOy8XykxAOnhKRWCQRRShTygbRBcIYFJrZ3Yg1quFmij0lnn0C2SkF1Mc4RWfFFayWA9O2Jk3GGcD//MTDC2qAsAj45P7DHEZK15O3leQDXWQlLCaZtEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKQHTXeQFBEUyficpLq6A1GXpMFqK/kks6u59mcG2eg=;
 b=IEdbwcx3BjtJXQsvRTZnSpFhCTDYfdsWGLVxjgMYymE64TyG4D9segoyX1xHxki+yYu3V0UNLt1OzNnTErkwPgvP/xG6hbgSqcQASjl5MPw6BU/ZfO3dDJUk6ZCTldEwIHM2/EUt69Kx6VUma+k5Yy3YmT7rWzGhDIu39bYwiv63+GoFPB25qMXIc6+gEXW7BtNZeRXtbtTEoUoPqCOLgNSNZcPVyOvYulGfjWrqQy2MEWdgMfqThKxWg6tV4A0Il5GaXjpAb+Ccn7aMn2Fpyf8Yr2yv5yRaZHWUa8aH0qHQ0zep29usjLI+8zGMlUSemh6g/Hq5aXAG03ffDJpNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKQHTXeQFBEUyficpLq6A1GXpMFqK/kks6u59mcG2eg=;
 b=rC1SNHtnR3KBCdka576fc+oxjrEPJ7P56yV3m2YDTIHD5HgBjP21AgbMiAj7LR2fo0LP+IK/6t+BQHEOS7wYzkVxhVyRs8yeQ9vQOPCxqC7KmfM8ewkWheILQXCA8sIJCCXhIKvBgozvKYOaVOy64IwsuZuwjpoqgJg3LpR45zs=
Received: from AM7PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:20b:100::33)
 by DB9PR02MB7035.eurprd02.prod.outlook.com (2603:10a6:10:1fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 10:09:09 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:100:cafe::de) by AM7PR02CA0023.outlook.office365.com
 (2603:10a6:20b:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 10:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 10:09:09 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 6 Mar
 2024 11:09:08 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 6 Mar
 2024 11:09:08 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 6 Mar 2024 11:09:08 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2D7FA15BE0;
	Wed,  6 Mar 2024 11:09:07 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
	by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 426A96b31914286;
	Wed, 6 Mar 2024 18:09:06 +0800
Received: (from chenhuiz@localhost)
	by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 426A967A1914285;
	Wed, 6 Mar 2024 18:09:06 +0800
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, Hermes Zhang <Hermes.Zhang@axis.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] power: supply: bq27xxx: Divide the reg cache to each register
Date: Wed, 6 Mar 2024 18:09:03 +0800
Message-ID: <20240306100904.1914263-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|DB9PR02MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1fe342-7b12-4f2f-f1ad-08dc3dc576e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lqMsVWE77M3TfdTYBkwzfMQ8BkxZ/kl9AiBlH4rlnVxJa+Dxz7pEJSenR2EEkVTouMTCIleB67jxnc0YzjYSlPPEB5ng1dHVnKYYAZLNRGrkrxkgOA5ckjKfB9jumaVsd+4dgrQGGRrlKMdOvgOOV1gLesXIl8LOCA6GFZyvXc0CfcasrpK2UbEZL+TXgPglK3hpJs0lzbQPVcsjqQT8ijoapEj7LQQAv9h4Na52So82SoUkFwXIG7cA9d1ZiR7XFwN1NFmAFB7DdZE1VWp9NjLynoLfz1X/B3hBdWNCtU+ETncYioMHCQYJe7073kJ/ru6dZxOcUyGcxBEGCZ7Gi1Q2IqIySoHiXdfo3WIhDN8OrI9ZzggT0CQ+6DsSqoT1UudKUdnMKy1p5uVjRtuOtvIVKn9fvFb/fg16qEdcsO+7fKR+LLQ8BmLVYnYOnfbEud9QbDyuHlMMYIdRnm1PGl7WAz1K/lzySyyXQ04ojsdYaDNnQfcnciOBBmReMGjAwlc+KemqJ24KndwhnMHgYJzm99NvaBM2dD6HXr8nePTlYV/F857qUCdIB3DHR6MrheTLlpLT3LIaRtXiRUBqCOWnrfLjrTLG3j94W10sqwjDkpLFgWhbTW+Gy9fNbLTApKYH4vFDP1sjbSFlGbaCQW2hJU6o3qKLBHxfeM9zuAbHzQwBtYMd3F9YAeycJtKBSR3/mqy1rUxK3RKybOHWkX4a/yM/I0Z9IAapiT+32oiy+wYxyq0/hUPv3LFpnJZE
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:09:09.2088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1fe342-7b12-4f2f-f1ad-08dc3dc576e5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7035

The reg cache used to be grouped and activated for each property
access, regardless of whether it was part of the group. That will
lead to a significant increase in I2C transmission.
Divide the cache group and create a cache for every register. The
cache won't work until the register has been fetched. This will help
in reducing the quantity of pointless I2C communication and avoiding
the error -16 (EBUSY) that occurs while using an I2C bus that is
shared by many devices.

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
v2:
 - Refactor implementation.

 drivers/power/supply/bq27xxx_battery.c | 231 +++++++++++++++++--------
 include/linux/power/bq27xxx_battery.h  |  30 ++--
 2 files changed, 179 insertions(+), 82 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1c4a9d137744..cc724322f4f0 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1746,14 +1746,16 @@ static bool bq27xxx_battery_capacity_inaccurate(struct bq27xxx_device_info *di,
 
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
+	int flags = di->cache[CACHE_REG_FLAGS].value;
+
 	/* Unlikely but important to return first */
-	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
+	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
 		return POWER_SUPPLY_HEALTH_OVERHEAT;
-	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
+	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
 		return POWER_SUPPLY_HEALTH_COLD;
-	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
+	if (unlikely(bq27xxx_battery_dead(di, flags)))
 		return POWER_SUPPLY_HEALTH_DEAD;
-	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, di->cache.flags)))
+	if (unlikely(bq27xxx_battery_capacity_inaccurate(di, flags)))
 		return POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
 
 	return POWER_SUPPLY_HEALTH_GOOD;
@@ -1778,7 +1780,7 @@ static int bq27xxx_battery_current_and_status(
 	struct bq27xxx_device_info *di,
 	union power_supply_propval *val_curr,
 	union power_supply_propval *val_status,
-	struct bq27xxx_reg_cache *cache)
+	struct bq27xxx_cache_reg *reg)
 {
 	bool single_flags = (di->opts & BQ27XXX_O_ZERO);
 	int curr;
@@ -1790,8 +1792,8 @@ static int bq27xxx_battery_current_and_status(
 		return curr;
 	}
 
-	if (cache) {
-		flags = cache->flags;
+	if (reg) {
+		flags = reg->value;
 	} else {
 		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
 		if (flags < 0) {
@@ -1832,57 +1834,128 @@ static int bq27xxx_battery_current_and_status(
 	return 0;
 }
 
-static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
+static int bq27xxx_cached_reg_value_unlocked(struct bq27xxx_device_info *di,
+					     enum bq27xxx_cache_registers item)
 {
-	union power_supply_propval status = di->last_status;
-	struct bq27xxx_reg_cache cache = {0, };
-	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
-
-	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
-	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
-	if (cache.flags >= 0) {
-		cache.temperature = bq27xxx_battery_read_temperature(di);
+	struct bq27xxx_cache_reg *reg;
+	int tmp = -EINVAL;
+
+	reg = &di->cache[item];
+
+	if (time_is_after_jiffies(reg->last_update + 5 * HZ))
+		return reg->value;
+
+	switch (item) {
+	case CACHE_REG_TEMPERATURE:
+		tmp = bq27xxx_battery_read_temperature(di);
+		break;
+	case CACHE_REG_TIME_TO_EMPTY:
 		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
-			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+			tmp = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		break;
+	case CACHE_REG_TIME_TO_EMPTY_AVG:
 		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
-			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+			tmp = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		break;
+	case CACHE_REG_TIME_TO_FULL:
 		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
-			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
-
-		cache.charge_full = bq27xxx_battery_read_fcc(di);
-		cache.capacity = bq27xxx_battery_read_soc(di);
-		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
-			cache.energy = bq27xxx_battery_read_energy(di);
-		di->cache.flags = cache.flags;
-		cache.health = bq27xxx_battery_read_health(di);
+			tmp = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+		break;
+	case CACHE_REG_CHARGE_FULL:
+		tmp = bq27xxx_battery_read_fcc(di);
+		break;
+	case CACHE_REG_CYCLE_COUNT:
 		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
-			cache.cycle_count = bq27xxx_battery_read_cyct(di);
-
-		/*
-		 * On gauges with signed current reporting the current must be
-		 * checked to detect charging <-> discharging status changes.
-		 */
-		if (!(di->opts & BQ27XXX_O_ZERO))
-			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
-
-		/* We only have to read charge design full once */
-		if (di->charge_design_full <= 0)
-			di->charge_design_full = bq27xxx_battery_read_dcap(di);
+			tmp = bq27xxx_battery_read_cyct(di);
+		break;
+	case CACHE_REG_CAPACITY:
+		tmp = bq27xxx_battery_read_soc(di);
+		break;
+	case CACHE_REG_ENERGY:
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+			tmp = bq27xxx_battery_read_energy(di);
+		break;
+	case CACHE_REG_FLAGS:
+		bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
+
+		tmp = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
+		if ((tmp & 0xff) == 0xff)
+			tmp = -1; /* read error */
+		break;
+	default:
+		break;
+	}
+
+	/* only update cache value when successful */
+	if (tmp >= 0) {
+		reg->value = tmp;
+		reg->last_update = jiffies;
 	}
 
-	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags) ||
+	return tmp;
+}
+
+static int bq27xxx_cached_reg_value(struct bq27xxx_device_info *di,
+				    enum bq27xxx_cache_registers item)
+{
+	int ret;
+
+	mutex_lock(&di->lock);
+	ret = bq27xxx_cached_reg_value_unlocked(di, item);
+	mutex_unlock(&di->lock);
+
+	return ret;
+}
+
+static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
+{
+	union power_supply_propval status = di->last_status;
+	int old_flags, flags;
+	int old_capacity, capacity;
+
+	old_capacity = di->cache[CACHE_REG_CAPACITY].value;
+	capacity = old_capacity;
+
+	old_flags = di->cache[CACHE_REG_FLAGS].value;
+	flags = bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_FLAGS);
+
+	if (flags < 0)
+		goto out;
+
+	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TEMPERATURE);
+	if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_EMPTY);
+	if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_EMPTY_AVG);
+	if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_TIME_TO_FULL);
+
+	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CHARGE_FULL);
+	bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CAPACITY);
+	if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_ENERGY);
+	if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
+		bq27xxx_cached_reg_value_unlocked(di, CACHE_REG_CYCLE_COUNT);
+
+	/*
+	 * On gauges with signed current reporting the current must be
+	 * checked to detect charging <-> discharging status changes.
+	 */
+	if (!(di->opts & BQ27XXX_O_ZERO))
+		bq27xxx_battery_current_and_status(di, NULL, &status,
+						   &di->cache[CACHE_REG_FLAGS]);
+
+	/* We only have to read charge design full once */
+	if (di->charge_design_full <= 0)
+		di->charge_design_full = bq27xxx_battery_read_dcap(di);
+
+out:
+	if ((old_capacity != capacity) || (old_flags != flags) ||
 	    (di->last_status.intval != status.intval)) {
 		di->last_status.intval = status.intval;
 		power_supply_changed(di->bat);
 	}
 
-	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
-		di->cache = cache;
-
-	di->last_update = jiffies;
-
 	if (!di->removed && poll_interval > 0)
 		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
 }
@@ -1934,29 +2007,32 @@ static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
 					  union power_supply_propval *val)
 {
 	int level;
+	int flags;
+
+	flags = di->cache[CACHE_REG_FLAGS].value;
 
 	if (di->opts & BQ27XXX_O_ZERO) {
-		if (di->cache.flags & BQ27000_FLAG_FC)
+		if (flags & BQ27000_FLAG_FC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		else if (di->cache.flags & BQ27000_FLAG_EDVF)
+		else if (flags & BQ27000_FLAG_EDVF)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
-		else if (di->cache.flags & BQ27000_FLAG_EDV1)
+		else if (flags & BQ27000_FLAG_EDV1)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 		else
 			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 	} else if (di->opts & BQ27Z561_O_BITS) {
-		if (di->cache.flags & BQ27Z561_FLAG_FC)
+		if (flags & BQ27Z561_FLAG_FC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		else if (di->cache.flags & BQ27Z561_FLAG_FDC)
+		else if (flags & BQ27Z561_FLAG_FDC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
 		else
 			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 	} else {
-		if (di->cache.flags & BQ27XXX_FLAG_FC)
+		if (flags & BQ27XXX_FLAG_FC)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
-		else if (di->cache.flags & BQ27XXX_FLAG_SOCF)
+		else if (flags & BQ27XXX_FLAG_SOCF)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
-		else if (di->cache.flags & BQ27XXX_FLAG_SOC1)
+		else if (flags & BQ27XXX_FLAG_SOC1)
 			level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
 		else
 			level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
@@ -2004,13 +2080,12 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 {
 	int ret = 0;
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
+	int flags;
+	int cache;
 
-	mutex_lock(&di->lock);
-	if (time_is_before_jiffies(di->last_update + 5 * HZ))
-		bq27xxx_battery_update_unlocked(di);
-	mutex_unlock(&di->lock);
+	flags = bq27xxx_cached_reg_value(di, CACHE_REG_FLAGS);
 
-	if (psp != POWER_SUPPLY_PROP_PRESENT && di->cache.flags < 0)
+	if (psp != POWER_SUPPLY_PROP_PRESENT && flags < 0)
 		return -ENODEV;
 
 	switch (psp) {
@@ -2021,30 +2096,40 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_voltage(di, val);
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
-		val->intval = di->cache.flags < 0 ? 0 : 1;
+		val->intval = flags < 0 ? 0 : 1;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = bq27xxx_simple_value(di->cache.capacity, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_CAPACITY);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		ret = bq27xxx_battery_capacity_level(di, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		ret = bq27xxx_simple_value(di->cache.temperature, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TEMPERATURE);
+
+		ret = bq27xxx_simple_value(cache, val);
 		if (ret == 0)
 			val->intval -= 2731; /* convert decidegree k to c */
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
-		ret = bq27xxx_simple_value(di->cache.time_to_empty, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_EMPTY);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
-		ret = bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_EMPTY_AVG);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
-		ret = bq27xxx_simple_value(di->cache.time_to_full, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_TIME_TO_FULL);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		if (di->opts & BQ27XXX_O_MUL_CHEM)
@@ -2059,7 +2144,9 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = bq27xxx_simple_value(di->cache.charge_full, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_CHARGE_FULL);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = bq27xxx_simple_value(di->charge_design_full, val);
@@ -2072,16 +2159,22 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		return -EINVAL;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
-		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_CYCLE_COUNT);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
-		ret = bq27xxx_simple_value(di->cache.energy, val);
+		cache = bq27xxx_cached_reg_value(di, CACHE_REG_ENERGY);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		ret = bq27xxx_simple_value(di->cache.health, val);
+		cache = bq27xxx_battery_read_health(di);
+
+		ret = bq27xxx_simple_value(cache, val);
 		break;
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ27XXX_MANUFACTURER;
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 7d8025fb74b7..617c8409d80f 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -46,17 +46,22 @@ struct bq27xxx_access_methods {
 	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, int len);
 };
 
-struct bq27xxx_reg_cache {
-	int temperature;
-	int time_to_empty;
-	int time_to_empty_avg;
-	int time_to_full;
-	int charge_full;
-	int cycle_count;
-	int capacity;
-	int energy;
-	int flags;
-	int health;
+struct bq27xxx_cache_reg {
+	int value;
+	unsigned long last_update;
+};
+
+enum bq27xxx_cache_registers {
+	CACHE_REG_TEMPERATURE = 0,
+	CACHE_REG_TIME_TO_EMPTY,
+	CACHE_REG_TIME_TO_EMPTY_AVG,
+	CACHE_REG_TIME_TO_FULL,
+	CACHE_REG_CHARGE_FULL,
+	CACHE_REG_CYCLE_COUNT,
+	CACHE_REG_CAPACITY,
+	CACHE_REG_ENERGY,
+	CACHE_REG_FLAGS,
+	CACHE_REG_MAX,
 };
 
 struct bq27xxx_device_info {
@@ -68,10 +73,9 @@ struct bq27xxx_device_info {
 	struct bq27xxx_dm_reg *dm_regs;
 	u32 unseal_key;
 	struct bq27xxx_access_methods bus;
-	struct bq27xxx_reg_cache cache;
+	struct bq27xxx_cache_reg cache[CACHE_REG_MAX];
 	int charge_design_full;
 	bool removed;
-	unsigned long last_update;
 	union power_supply_propval last_status;
 	struct delayed_work work;
 	struct power_supply *bat;
-- 
2.39.2


