Return-Path: <linux-kernel+bounces-69343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1FF858798
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFAF1C24EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096613B281;
	Fri, 16 Feb 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9aORXxF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984712CDBC;
	Fri, 16 Feb 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117443; cv=fail; b=K4OR7Z1gQwA32AYRpqOdYBcVUYbKdscjh71JLbWQHayH+bgDXlSGfZXDi/2Bx6CVWtrWn8L+k3bkI9U7No2jhyQxS54vGCManOBEOx+A3GMBb8GMbJhrAtE6+42ur5Eq5nJUf5TicmSYDBVCurXA20KKPxLQZpSCEDV04GhxePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117443; c=relaxed/simple;
	bh=XWR+MoJFO+9JW3+++ZPONqLbVsYJYwNMSwjEnFTEt1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NM7qV3lgYM5dTCMEA1mYIY45LONFi5fD/n8n4LAb96q2U6yRt9sRuWv8UGCWvcFQc/pYem7iTejdKM+74YGPDhcWpZ7NlJ9oRyppN5Yy9ZQGb9inbjdIpuaVIa60Hrkxp4Hs2cKBD99/vv6BMDpMdunqobu2iyak+jvOIk07GfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9aORXxF; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lODax7YDQ7KLWsDBmmgt8LJlwzZp7wILcs60Tb6GHrzALBX0TjIesR8SpDDVItutFL+MwKE7L1wGmPxNxT5GWy6owsKCoaOGvY7lAJ5gp7PFuHmwk5ltXU4g9pRMGJ5i3LX5JV+CXF4+QcWpVz69fs5kdaHgxU14muU3Lo7JT8Fhn7sWBbUD2hEfmPtIjxz16c4SL/P4tgUvv3f7rVHCl8m9hT6Jwz7XYHZ9iZQjPHXlaFftgqapy6yuHTf0o5pEE7+G+45a4bFYnocJjv+YVY3zjLn/fWbCt2pYy/r3u9JodtWmzUWyly38+tsBbPrY1vC6hWpp+IVyxeJyTUMwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TLFoh5mULNMLicNYMfzMUl4EXxf3HKm4PczU7NzRw4=;
 b=kLr8bjCrqqZnqDoKc8yv7/R54+Od0xYzwm9qc/MWhP8QAYiawmlpA8bIBLLRzA9d9t/QtXFp7eTAU6rp4dqpsVlBQD7Gg4zYkN8Kgqa8igdDomMDPu/iLMb4QEkqcqoor7l1Kp/NxTzN8L9l3sgYCD8mwBSD3OZAVGfXwxAcTWAaZoISwSUniqmtsDUIzn/jBTZZ/5f9UKtSvGW2vWz4yDCgPZ0TgV/kOzDD0kv+dcP5vm4zNr0nhqnzYorKzNSUEV8Qh3tll1r7/97RRqKeMcuKjYV1tg1eaE4Y4TzxF17pqJ8BjrOAmtDxSzuUEJBIbfthy4QicmaKzzlMkOuZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TLFoh5mULNMLicNYMfzMUl4EXxf3HKm4PczU7NzRw4=;
 b=j9aORXxFnB/bemuZjPJpeVslunfb9Y4ozgEfiQFWf3fAlRC7KZu8oet6ACmtftNj4MrGjuU9vOEjVxb6e2DQs0W3bHeqrsVUWZrKetDmiBXXzYxpdRuy0r1pBtoMGAgFt9v8wvleAldN9y7w7Q2tN8g40PfsuA6kmaGJ0NQVpKbAiKiBJO+W/X4oRuiah94DBuQTUOWeuEu4GGQotXOKsTYxddCui8brxu7cf2bdB0UARJJgIxnbD/vxyXxxm6/7wZHRv8HjY08lf246Sbfxq7jXpASPtRzRPK8nbMJD9nTj121s1wqcuIeIf2BoAPYe7hWqrZ0wnm70AJgackoqQQ==
Received: from DM6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:5:80::14) by
 LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.29; Fri, 16 Feb 2024 21:03:58 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::b6) by DM6PR08CA0001.outlook.office365.com
 (2603:10b6:5:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 21:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 21:03:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 13:03:46 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 16 Feb 2024 13:03:44 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Pohsun Su <pohsuns@nvidia.com>
Subject: [PATCH v2 1/2] clocksource/drivers/timer-tegra186: add WDIOC_GETTIMELEFT support
Date: Sat, 17 Feb 2024 05:02:57 +0800
Message-ID: <20240216210258.24855-2-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216210258.24855-1-pohsuns@nvidia.com>
References: <20240216210258.24855-1-pohsuns@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: e03ee489-eb75-4e68-e760-08dc2f32cae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	edubU2GvUw0DSrUIA60YHjmq8QZwEO/HKixL0VVNQ0cD2FQ1OxOyJsx8ElkMBGV8BQkH4GMjL4cKgT9oWL5RbBUItfEmbePttjYLxxNuAQ1oeGzirdHZXTOuXe6JzSXlayue55/86HZebpxP4u4J/jhWhtiRauDwW28NY3f3gum7Bf0v/pDPHLsN7kWYzSJTuM/L9IF0Dz5lOcIbWGi369VKgp6bM6YgF/JJp2Sy9ROTxEQT/WbCkdijr2YwOIeTWpZPKcONRId7aHefZ/r1T6wsh8ccPUP7wX1XLC+iqiODSlP4j1w1u2jSWhsWxULCx/aS6J3VnD4Q9bqMmAyreKqN93YplZkGvy2XW8ovEiNIZF4nIqLuCBUu86PmTgW2bYz8aWcM5vKc91jZ1rWL2Q1Tqd6iBN+RajffK5CgES/v3qcZCw6uuPWcNipBvr6ROFGtgYurkGdHIeMNW7i/6cxaUO5C4OxzPvVUdHq0JCCox2zFaE8k5Ybg/0ViKs3T1O5O/S2jR3BHuQt1hZEXHtvP7D+2idMz6+SYsOCEBvclJWJXXC7HxvnXUKYQeh0awjQj4qwOGnI8ArpehOYlnwCnfXSpuI1c+TGgtu7o4SXhItM4wynP/K1bx+GpHW/z0GodBLHKauo3f6spMw93sjnb3uG1YB+O3HejvJH5nVU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(36860700004)(451199024)(46966006)(40470700004)(5660300002)(41300700001)(8936002)(4326008)(8676002)(2906002)(86362001)(82740400003)(356005)(7636003)(83380400001)(54906003)(36756003)(2616005)(7696005)(6636002)(1076003)(426003)(6666004)(110136005)(107886003)(16526019)(70206006)(478600001)(70586007)(336012)(316002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:03:57.7427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03ee489-eb75-4e68-e760-08dc2f32cae7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

This change adds support for WDIOC_GETTIMELEFT so userspace
programs can get the number of seconds before system reset by
the watchdog timer via ioctl.

Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 44 +++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 304537dadf2c..8f516366da86 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
+ * Copyright (c) 2019-2024 NVIDIA Corporation. All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -29,6 +30,7 @@
 
 #define TMRSR 0x004
 #define  TMRSR_INTR_CLR BIT(30)
+#define  TMRSR_PCV GENMASK(28, 0)
 
 #define TMRCSSR 0x008
 #define  TMRCSSR_SRC_USEC (0 << 0)
@@ -45,6 +47,9 @@
 #define  WDTCR_TIMER_SOURCE_MASK 0xf
 #define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
 
+#define WDTSR 0x004
+#define  WDTSR_CURRENT_EXPIRATION_COUNT GENMASK(14, 12)
+
 #define WDTCMDR 0x008
 #define  WDTCMDR_DISABLE_COUNTER BIT(1)
 #define  WDTCMDR_START_COUNTER BIT(0)
@@ -234,12 +239,49 @@ static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
 	return 0;
 }
 
+static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
+	u32 timeleft;
+	u32 expiration;
+
+	if (!watchdog_active(&wdt->base)) {
+		/* return zero if the watchdog timer is not activated. */
+		return 0;
+	}
+
+	/*
+	 * System power-on reset occurs on the fifth expiration of the watchdog timer and so
+	 * when the watchdog timer is configured, the actual value programmed into the counter
+	 * is 1/5 of the timeout value. Once the counter reaches 0, expiration count will be
+	 * increased by 1 and the down counter restarts.
+	 * Hence to get the time left before system reset we must combine 2 parts:
+	 * 1. value of the current down counter
+	 * 2. (number of counter expirations remaining) * (timeout/5)
+	 */
+
+	/* Get the current number of counter expirations. Should be a value between 0 and 4. */
+	expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
+
+	/* Convert the current counter value to seconds, rounding up to the nearest second. */
+	timeleft = FIELD_GET(TMRSR_PCV, readl_relaxed(wdt->tmr->regs + TMRSR));
+	timeleft = (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;
+
+	/*
+	 * Calculate the time remaining by adding the time for the counter value
+	 * to the time of the counter expirations that remain.
+	 */
+	timeleft += wdt->base.timeout * (4 - expiration) / 5;
+	return timeleft;
+}
+
 static const struct watchdog_ops tegra186_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = tegra186_wdt_start,
 	.stop = tegra186_wdt_stop,
 	.ping = tegra186_wdt_ping,
 	.set_timeout = tegra186_wdt_set_timeout,
+	.get_timeleft = tegra186_wdt_get_timeleft,
 };
 
 static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
-- 
2.17.1


