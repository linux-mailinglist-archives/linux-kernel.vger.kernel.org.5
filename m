Return-Path: <linux-kernel+bounces-71090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2326485A085
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B789B2170E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFED25577;
	Mon, 19 Feb 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="o+pdkKRl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67A25601;
	Mon, 19 Feb 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337189; cv=fail; b=Wo49Dgn2LiZV5R5PqkyBoc81ZuOSwXyzRIotyU4UGhFYoDj10EcOaby0PI7jYYMzeT/P7yzOzRjOFiC8+UeNmF5a8EO4nZz/XsiczwfDAq2FLsvzweMclnizJOtwmy1xhDKHd089tFIs/9LyTQWXKlcEkcwxrugU1mhaI4f5+uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337189; c=relaxed/simple;
	bh=QllKm+DOC1RbYYaWSN5KO3kt7XUxMDQTwy7n0sTeHDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WfJ8JhgWlyJAIukXPEjRWbY4eUgndgkXZ+/WIyK1jHuJXho/vWyIe0mCN2inCg3G+7jjQy59hI4Xfw3p4BN1HKS8PBnTfnrha1habMMGbLNZ3nnI3sO2ShDeTaq8PWVViXlUY4fK/wa563/9yXK8/u3WWlgxg5b4WasFURzcOGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=o+pdkKRl; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqn/78Zvsx2ywBBicMI6Nl1xq8+fnLpaRPFUOBjaZSqpoFR7LXMEBqbOralYCCurxofvdP1vZmrp/O86tgWanNt2SvuZ/zRQ05n6wHjijTMvIUCc9bSpn9JEe2FNTUmEfsa/5OUDgIMUD4yxPSWpZiEeTKOSMuP9YrBZYh7Sfo0kIa5DGSWFjOc4HwX6UNYdb8AqOXIKwaLD3YvFdN3gg7TP2RIEf2aB3mqS0yNN5iYIVU68vnKHDyvqCbOvnEOHR/kpC1/zo69ZhM1yN0VBCrj965mMVgZvO2YFHP3MTC//RG9LlMZeX+pVQPeNqEfxuuebRNuqBYiPtbUg+yr3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s1BDnDuHDBjX0mFYs3eWGmuhP6tZtmlxgTcXFK0frg=;
 b=njmR1xYDJK1V6t1teStzMXO5NUhIA/vJThkdlhLHbzsPi+buChaz4tacD/zXCBZThtfS7HblF/7qFKkQdmUWT8MWs/bMLhCDt0c8ePItsCXrpl35M3CJ8q/0x6EmAySoTQ0BVGP/1TMKrjvnvVHCL/drMuoXibAqBw4q2iE5vgxcf4Ld799X+LV8sGXi+PQTsu9lXDIbEsggMSVtU4Ckrn01vP6AwR6XFkW7HtK6SBL0eVWj/U5ljVCHxLF7vaWs4hroKBunBO8cmI5goXNWtC4XM+DFWRrd+qD+QjJ2JhwYXjgl9DXTvHHshqANc8kEYYsMpwujhUafQHZomEv09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s1BDnDuHDBjX0mFYs3eWGmuhP6tZtmlxgTcXFK0frg=;
 b=o+pdkKRl9exbhN+6i1x2I3lOZWFWqbIN0T1irIpk64tqMyJuZSXbWPBOHvCAVkVEbbdPiVql0rtd4ip/SZbK5DkOBADrQ5LdMbCwRy9pnG0ruSrI64yhoJotRBNqop8MESXZEjN2i9sAOHOEeXZpXvFgnRkiQwg1Ks2MoCHeNLI=
Received: from AS8PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:20b:310::32)
 by DU0PR02MB8739.eurprd02.prod.outlook.com (2603:10a6:10:3ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 10:06:22 +0000
Received: from AMS1EPF00000047.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::41) by AS8PR04CA0027.outlook.office365.com
 (2603:10a6:20b:310::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Mon, 19 Feb 2024 10:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000047.mail.protection.outlook.com (10.167.16.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 10:06:22 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Feb
 2024 11:06:21 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 19 Feb 2024 11:06:21 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 1D64D146F3;
	Mon, 19 Feb 2024 11:06:20 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
	by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 41JA6J2i048781;
	Mon, 19 Feb 2024 18:06:19 +0800
Received: (from chenhuiz@localhost)
	by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 41JA6JD2048780;
	Mon, 19 Feb 2024 18:06:19 +0800
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, Hermes Zhang <Hermes.Zhang@axis.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: bq27xxx: Introduce parameter to config cache regs
Date: Mon, 19 Feb 2024 18:05:40 +0800
Message-ID: <20240219100541.48453-1-Hermes.Zhang@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000047:EE_|DU0PR02MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed88a4d-816c-45a9-4255-08dc31326ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pSSRNIekvYWDTA0DuVMQUkwqeP8K41pvZFjtvV8CVInNCnt3TKQUBi6rWXBtQg6sFHD/2vAeSwWN0a1HQN2Zo1jyHvAcOAxdbSE6gOMWUFNZh8jUpOtJCFGmoQT6Uh0+mouCfLnf3HOnDeVGSXAJwKrJrkAGLjwntdrRVfyNcKA6zkjqVBevwe4KMI6nplcqKDNlJKYXX8Fguf/ZoQqThy5QLINiAmHEzuXw/KwZJ0MXQw4m/UDPNWxE5H5o6fvpvhmX6u7LUWajX7zv5wmzSwkKi/+MDbhg/kKdhSZBxLzUHzxQuQFHq/sCeWaCNSp8ZxhLiYkWhP6g+DMnAWpXnTbblhvfdlvbvQtlL6amVgOQzCikCsG51Ho3TMGHuqwFSMtLUovd2xB8RnWgZ89RNlAV3d+MyyBwX6LjpALgdAPMEvMCVM4IBJMaARILdzGIKWsJjURy6Dd1N/MohbRDi/pMoQ/k81mSpxj7mo0++EoxZyv/YN2NyDJUPO85gve5HDRP/2TewAY9YnHcddClSXo5BJ/Q+7Nwx15BsdDVKnqh13zG8NvbFq44pP26jcK1Y5Xm/nJyrLN8vpDELQoMQ2SL6nc1mcpfIrrGqwdB1ztcyxNmn669LsF5nyOTeF7nkrLPT+3Hh62BVZ5/+i+Z6juEwbctYpbn4qChZsfMf7Q=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(36860700004)(46966006)(40470700004)(83380400001)(81166007)(356005)(86362001)(82740400003)(478600001)(316002)(6916009)(42186006)(54906003)(70206006)(70586007)(1076003)(26005)(2616005)(426003)(336012)(6666004)(36756003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 10:06:22.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed88a4d-816c-45a9-4255-08dc31326ca1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8739

Since all of the regs in the bq27xxx_reg_cache are now cached, a simple
property read (such as temperature) will need nine I2C transmissions.
Introduce a new module parameter to enable the reg cache to be configured,
which decrease the amount of unnecessary I2C transmission and preventing
the error -16 (EBUSY) happen when working on an I2C bus that is shared by
many devices.

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
 drivers/power/supply/bq27xxx_battery.c | 65 +++++++++++++++++++-------
 include/linux/power/bq27xxx_battery.h  |  9 ++++
 2 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 1c4a9d137744..45fd956ec961 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1100,6 +1100,11 @@ module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval, 0644);
 MODULE_PARM_DESC(poll_interval,
 		 "battery poll interval in seconds - 0 disables polling");
 
+static unsigned int bq27xxx_cache_mask = 0xFF;
+module_param(bq27xxx_cache_mask, uint, 0644);
+MODULE_PARM_DESC(bq27xxx_cache_mask,
+		 "mask for bq27xxx reg cache - 0 disables reg cache");
+
 /*
  * Common code for BQ27xxx devices
  */
@@ -1842,21 +1847,29 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	if ((cache.flags & 0xff) == 0xff)
 		cache.flags = -1; /* read error */
 	if (cache.flags >= 0) {
-		cache.temperature = bq27xxx_battery_read_temperature(di);
-		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)
+		if (bq27xxx_cache_mask & BQ27XXX_CACHE_TEMP)
+			cache.temperature = bq27xxx_battery_read_temperature(di);
+		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR &&
+			bq27xxx_cache_mask & BQ27XXX_CACHE_TTE)
 			cache.time_to_empty = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
-		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR)
+		if (di->regs[BQ27XXX_REG_TTECP] != INVALID_REG_ADDR &&
+			bq27xxx_cache_mask & BQ27XXX_CACHE_TTECP)
 			cache.time_to_empty_avg = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
-		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR)
+		if (di->regs[BQ27XXX_REG_TTF] != INVALID_REG_ADDR &&
+			bq27xxx_cache_mask & BQ27XXX_CACHE_TTF)
 			cache.time_to_full = bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
 
-		cache.charge_full = bq27xxx_battery_read_fcc(di);
-		cache.capacity = bq27xxx_battery_read_soc(di);
-		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
+		if (bq27xxx_cache_mask & BQ27XXX_CACHE_CHARGE_FULL)
+			cache.charge_full = bq27xxx_battery_read_fcc(di);
+		if (bq27xxx_cache_mask & BQ27XXX_CACHE_CAPACITY)
+			cache.capacity = bq27xxx_battery_read_soc(di);
+		if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR &&
+			bq27xxx_cache_mask & BQ27XXX_CACHE_ENERGY)
 			cache.energy = bq27xxx_battery_read_energy(di);
 		di->cache.flags = cache.flags;
 		cache.health = bq27xxx_battery_read_health(di);
-		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
+		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR &&
+			bq27xxx_cache_mask & BQ27XXX_CACHE_CYCT)
 			cache.cycle_count = bq27xxx_battery_read_cyct(di);
 
 		/*
@@ -2004,6 +2017,7 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 {
 	int ret = 0;
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
+	int tmp;
 
 	mutex_lock(&di->lock);
 	if (time_is_before_jiffies(di->last_update + 5 * HZ))
@@ -2027,24 +2041,37 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 		ret = bq27xxx_battery_current_and_status(di, val, NULL, NULL);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		ret = bq27xxx_simple_value(di->cache.capacity, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_CAPACITY ?
+				di->cache.capacity : bq27xxx_battery_read_soc(di);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 		ret = bq27xxx_battery_capacity_level(di, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
-		ret = bq27xxx_simple_value(di->cache.temperature, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_TEMP ?
+				di->cache.temperature : bq27xxx_battery_read_temperature(di);
+		ret = bq27xxx_simple_value(tmp, val);
 		if (ret == 0)
 			val->intval -= 2731; /* convert decidegree k to c */
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
-		ret = bq27xxx_simple_value(di->cache.time_to_empty, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_TTE ?
+				di->cache.time_to_empty :
+				bq27xxx_battery_read_time(di, BQ27XXX_REG_TTE);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
-		ret = bq27xxx_simple_value(di->cache.time_to_empty_avg, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_TTECP ?
+				di->cache.time_to_empty_avg :
+				bq27xxx_battery_read_time(di, BQ27XXX_REG_TTECP);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
-		ret = bq27xxx_simple_value(di->cache.time_to_full, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_TTF ?
+				di->cache.time_to_full :
+				bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_TECHNOLOGY:
 		if (di->opts & BQ27XXX_O_MUL_CHEM)
@@ -2059,7 +2086,9 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 			ret = bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
-		ret = bq27xxx_simple_value(di->cache.charge_full, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_CHARGE_FULL ?
+				di->cache.charge_full : bq27xxx_battery_read_fcc(di);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = bq27xxx_simple_value(di->charge_design_full, val);
@@ -2072,10 +2101,14 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		return -EINVAL;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
-		ret = bq27xxx_simple_value(di->cache.cycle_count, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_CYCT ?
+				di->cache.cycle_count : bq27xxx_battery_read_cyct(di);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_ENERGY_NOW:
-		ret = bq27xxx_simple_value(di->cache.energy, val);
+		tmp = bq27xxx_cache_mask & BQ27XXX_CACHE_ENERGY ?
+				di->cache.energy : bq27xxx_battery_read_energy(di);
+		ret = bq27xxx_simple_value(tmp, val);
 		break;
 	case POWER_SUPPLY_PROP_POWER_AVG:
 		ret = bq27xxx_battery_pwr_avg(di, val);
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 7d8025fb74b7..29d1e7107ee2 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -4,6 +4,15 @@
 
 #include <linux/power_supply.h>
 
+#define BQ27XXX_CACHE_TEMP        (1 << 0)
+#define BQ27XXX_CACHE_TTE         (1 << 1)
+#define BQ27XXX_CACHE_TTECP       (1 << 2)
+#define BQ27XXX_CACHE_TTF         (1 << 3)
+#define BQ27XXX_CACHE_CHARGE_FULL (1 << 4)
+#define BQ27XXX_CACHE_CYCT        (1 << 5)
+#define BQ27XXX_CACHE_CAPACITY    (1 << 6)
+#define BQ27XXX_CACHE_ENERGY      (1 << 7)
+
 enum bq27xxx_chip {
 	BQ27000 = 1, /* bq27000, bq27200 */
 	BQ27010, /* bq27010, bq27210 */
-- 
2.39.2


