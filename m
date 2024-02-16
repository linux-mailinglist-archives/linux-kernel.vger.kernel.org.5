Return-Path: <linux-kernel+bounces-69344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A459B85879A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5F1F244F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED31420DF;
	Fri, 16 Feb 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dQahUiDq"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FE428E2B;
	Fri, 16 Feb 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117444; cv=fail; b=JkwAx5+Sl3XVb5R2TVUXvjeCJkNi/ycdFvlmWQtv5rDf/IYZWq4XtDvvYyRv1iqDEZENfiuPLK21WiW+IMBqOnyQEgBUhIl/PzP58kdvXGAUcwkO6c1/tlq0cQ5/YoC4rbUIdYUan3WFZhrMVxPiCMar2F1/j2uF2LSuMpdreg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117444; c=relaxed/simple;
	bh=Kq9kcWSzz99RjadiEOh9X6cnLmU2DnCd5X/gkulYVGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hvyit3Lb0v2SgBYBpYxsbODvD6ZPNhNblLAeD2wi3BEnaVfEre1WCMpjim+BhzhlIpN9ayItWZ3bOhDXeelDxGeET/0nubIsJj/gt7cBaRpV4RhGvtuh5vH6tn376Qq2gdCVsykDfz+tafZSrMbw90bXSuAz5HM9APAAgnJAIzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dQahUiDq; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5mzISjJxgFFrEGsVilqXDXyrIetsT3JQOv5MBiiK2q9KQ77roU9JKcuSDrDwOmjEalqMjGIsoZr7U0Jf4ifReeq09ESB8WWy8EbdbKP2GACMyC7HC2frqhH0t7zRT9iL88FvfGYVp5MrIQjNeTm6P/NqjCbQZgNQjcXUfYWzkLRkVz2RlOefggQIGjZQwjcOKSt99YQhF2yNScNeoyVBEp6U0raMAuybRIADFnWQakA2lEp31CUPZXyM7Rpop5a1kyCOHnpMZ0cPRKpSxR+2LeUFou7L4hT4gx60HXESjDm5Zq5p7SQDnn2prPF2avbyOI3xlPY1pNj73RCiGeOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib9mxsSAtU2mhYDf85ZEwBOQjpS3vHaPQJ2of6NpVn4=;
 b=DELgqMOFsP18/v/HyLntr6A/r0hwolmbDntwc9NIZksscb4ynTn+fl26x7dIrtcs7jnffrPqcyP6lEGQe4wK1VvUKIGKtgDWa73hwgHawsNR0JTys05IDDXwcCbJcw6HVnGAscMRA9Y9Av7IosmQnrDRpE6gTYba/ag5wtmTIps16r9ibabruV1Wq86spLBNdNOApjYZ3R72D+zwtZxnURv6bjoHxWkRLyLdT4eQBQ8l2dcQk4m9LCh107xxubroljhRNAR2jDiV9VhxTfe8PT3Kj5FEjCyjRGT3DVdRdQCNVfMSyoZAIyD0ip53pyUUwSpOyZAjrvviCs+UNQw7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib9mxsSAtU2mhYDf85ZEwBOQjpS3vHaPQJ2of6NpVn4=;
 b=dQahUiDqTZVtU4Rd0OT7aw2hCMK1Xjn9pq3tics46+kOtuUDij3p1o3tenTiGGaeA7ASvooMwhSMuMcOGdqrKfxha3zF0CNbm0bAtVXdsTqcC/P8zQ+IldMiQVtsqDMbVFUc1dUG8qYNkxNMPbFSqIEVVf8nrgGFU7505ipCWH69cGDJsIvHfdy1+R3i/NvWHo76s/Wlt5nRfj2uY5W5DiqsSAUoLvkiRKRpFAfXjqiAk380Zk+bPUWfvCk+QxJ6xGRb88cfoUB55sjApBGfsiVEl66LiUUUjkZF0HseSom5VlbfVn1zC3vXTtwpbROgc1SFkHkCFYMPsshjzA4LtA==
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 21:04:00 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::fe) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 21:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.0 via Frontend Transport; Fri, 16 Feb 2024 21:03:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 13:03:36 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 16 Feb 2024 13:03:34 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Pohsun Su <pohsuns@nvidia.com>
Subject: [PATCH v2 0/2] clocksource: fix Tegra234 SoC Watchdog Timer.
Date: Sat, 17 Feb 2024 05:02:56 +0800
Message-ID: <20240216210258.24855-1-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 34294383-fe2a-4323-c9c8-08dc2f32cc3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ma7ll0jXyxdDt+mD+M9KmoaV0hNjYjIOLHATjxFwPVftCKE/HWnBbAItzoxJFsDpqJ1p0OS9fja6E5APmNcNGyaHzSyyk1xEjw8wlEx8tc1KiyzKxvDKLbbCN4MhdF1TGb8YnynhtqkiCxuN7zXyecqAb9T83HVdSxkE1Z939ongZeDbXZHyzLcuex2sUttRYzTEJT6f5k3Z//2QqustNjeI4e5026do1lU13ronyUWrMHJk++DDSeNEngEVCT1oXqfXKpB5X2J/6RPBhilJgol27XU4V5FOBbG0lkGXN3kFutNKhKHdtu/odz0S5nhB35Wex9hvBO5ksaJgc+Mz3DVrKhRYjTRy6NvUcdZ2FJGgd3u+1QgLpmlnNRqGoZPoAvDxF3zR08+WPeT8Vnl+AyXAzAmw+iNpGsxazhLfjymZqGXeTSstZyB6y3fmw/2TAMtDXAkt1OuR8MxXV3Cpvq9jBEjvQwaUi4fXfv8qtSGoy/xYte4SZ8ZzQOhdWjRWIIxSEZYRnVc0TKTGfBoQ72A8DPaowgkVEJPGZi0yNx+q61Zdzhoq5B41jTalgUzLyyUNnSafdKFyRCce4MrnStVc+IXACl5ucM0kTsEE8AgfrKIq5j5N0uhJcAuXBJzoOdB7u1LyER2RQOYQtl1PIPY5iFMkG0Or1cMtWnp53Xg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230273577357003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36860700004)(46966006)(40470700004)(2906002)(4326008)(8676002)(8936002)(70586007)(70206006)(5660300002)(82740400003)(83380400001)(26005)(16526019)(478600001)(336012)(426003)(41300700001)(107886003)(2616005)(1076003)(7696005)(6636002)(54906003)(110136005)(316002)(6666004)(36756003)(86362001)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:03:59.9767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34294383-fe2a-4323-c9c8-08dc2f32cc3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

This set of patches includes a fix for watchdog for it may not bark
due to self-pinging and adds WDIOC_GETTIMELEFT support.

--
Patchset v2 fixes a compilation error, a warning and updates copyright:

drivers/clocksource/timer-tegra186.c:263:22: error:
    implicit declaration of function 'FIELD_GET'
    [-Werror=implicit-function-declaration]
drivers/clocksource/timer-tegra186.c:414:15: warning:
    variable 'irq' set but not used [-Wunused-but-set-variable]

--
Differences between v2 and v1:

[PATCH v2 1/2] clocksource/drivers/timer-tegra186: add
 WDIOC_GETTIMELEFT support

 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
+ * Copyright (c) 2019-2024 NVIDIA Corporation. All rights reserved.
  */

+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>

[PATCH v2 2/2] clocksource/drivers/timer-tegra186: fix watchdog
 self-pinging.

 	struct tegra186_timer *tegra;
-	unsigned int irq;
 	int err;
 
 	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);

 	if (err < 0)
 		return err;
 
-	irq = err;
-
 	/* create a watchdog using a preconfigured timer */
 	tegra->wdt = tegra186_wdt_create(tegra, 0);
 	if (IS_ERR(tegra->wdt)) {

Pohsun Su (2):
  clocksource/drivers/timer-tegra186: add WDIOC_GETTIMELEFT support
  clocksource/drivers/timer-tegra186: fix watchdog self-pinging.

 drivers/clocksource/timer-tegra186.c | 71 ++++++++++++++++++----------
 1 file changed, 45 insertions(+), 26 deletions(-)

-- 
2.17.1


