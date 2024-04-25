Return-Path: <linux-kernel+bounces-158343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D028B1E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2758F1F23140
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FB08526C;
	Thu, 25 Apr 2024 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dX2Dfu5m"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479D84FA2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039164; cv=fail; b=kdWf90tjn2q/2HRzYDpngSliIjCBJL7sQDKOhkn/YRcLdt9jKlfqtB75TM6MGG4y5He/kNP/NngQic3SEk6/K+ymofIyrs64rLShNh6m0TXkz10q/2McoWX4ZbwnL/gD84w58SuWdq+RsOv02ycH1dVPSlvyHvOFMzCtODIclWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039164; c=relaxed/simple;
	bh=mK+DRjZoLhjYjpSE3nFwV6JR/F39peg4avsjBJX13xY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p4D8zs5PjcF55SAFwZ+GfMkuobg1GgaUF16LmwMKO2ZF4/twSbQnscu3PZaqu3t3NR1eUHtgo8usd7txj9y1mE/9MHvdvkg8Nq1K/Rb5qoSn008NrK5pyvVFKXpan/3dbxXCxziIxFyft5X7nNPW+f/vSLNIjGs8HEFyHn8elrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dX2Dfu5m; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUVtRHqRMwPuFO7JDJBltTfU2nRbzSinqGSUL+agUkYf4BALcAz0E7z0KcSptCb+ZPctCABukaesQIW7LElb9NeCaAn/OB52ZJvCWh/5rQTnsZcsznvpE7cMr9an/csQA8MAKah3MmTci7YMEoZqd5SeBt5KVkQMhf7QvnOUVBFQrwGNV8+AAYnQJopUkQFINitXxxQArLNGbH/xhTgPScHSC9W4ylmHI7bv6mGpwJH5WT6ficPP4AHDY9Ni93JA6n59orEHsHvT09lepNuJQ2IJ8EZCKGprEO78QxpQMSeiHSin643wDBvlEE/0pT0FeHCcuP+Up9xd0LFCwT4ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWhYMdm8lOQiPflkUhg0HOmWZiWhzRPD21nupTrWFfc=;
 b=BCqmNDZCJbyHh+uK0KWTK4V1wDdp6MVQHG8VAeAeNoJDhrs3/duZl+jufdJoFi/PFXOWJu7gfqxBxoW/ZHdSBffGgjtvMa/pMHJXD/peZ7s11kA2OUoyBkUeOdJug9rKhfRXe7DPco+MyyWSyfBQF1mTkOnyM62s0mDVagcIvvChpYRWcMw58Hz1GqIIGrsHjIxFlzZuWdgR+tKGh0g6Myi+/+WWsBrENiYEoO6ajt7DLZj+9FVzUO7MitNlhu+bA9PLcqMIjyvwotlZ5WjFDXHhy6B21p7x2Si/YBbBMXhNkXSOPUg8nQa0ivovT7Tp0Cv+7FEYfJLMZak8gVbflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWhYMdm8lOQiPflkUhg0HOmWZiWhzRPD21nupTrWFfc=;
 b=dX2Dfu5mUhctyelFxi3mFyfG1p5DgjFU91qmGcmVsuSJrpFViVDvWgKzSBejRB8fHCrKbJ2w9P/bghk+uj40N/4Pd1DW6hbyTNCadl4BiA66HRn0uA1KM9L2lDXB6dFYEAW6VcGI4tBrsLf/Di8hQCVWUs+S6AyNKZJEZIHLh7Q=
Received: from PH7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::23)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 09:59:20 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::4) by PH7P220CA0099.outlook.office365.com
 (2603:10b6:510:32d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 09:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 09:59:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 04:59:18 -0500
Received: from xsjpmteam52.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 04:59:18 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: Move FIRMWARE_VERSION_MASK to xlnx-zynqmp.h
Date: Thu, 25 Apr 2024 02:59:13 -0700
Message-ID: <20240425095913.919390-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ronak.jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5bd509-c9d4-4b80-9ef2-08dc650e5ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJdImQfaM0TRkba0wdDpaT3Xrbur6TMqUe/S80hopWbvleflZ9RXRjRK3ym3?=
 =?us-ascii?Q?lDwzP+APznRBkY8MwqqVLch2q4Wz+IoqWSmCImr2nXIhB7EgMGlonguoGZAj?=
 =?us-ascii?Q?aFkAYc4dcmZwShsTOhMF0olFgt5+tGlXR0z8taBGLwFnmLOaeQnHo+/sXu/6?=
 =?us-ascii?Q?pmr/3qmMI7+L/S3RbhwVv3q5Rlr++LjVjnKFDsjTA6RsUhY6OlU/3PdD2ny9?=
 =?us-ascii?Q?/+MuD94Vpd1H2IYZ7sVBGJ2QXyJMIm+L18IkhoYFtgSU5s6YLc5Z6JPRPGux?=
 =?us-ascii?Q?Q0O/I9FIFgU3G/IWfqE2G9yWww24RmVUgY+KZ37iUW+oLBMA5SYyZSc8HVqg?=
 =?us-ascii?Q?QkRjtdkGt/AC/EwXEpoz9yqn7gf6tMEaYMWRH9erHC6U33DiR45jmvW30WDh?=
 =?us-ascii?Q?fbkmsSurPScQYjfm+fkzN3p/uoJbUXVFzBkyI0Li3OflwQcmIvdI+TxSthia?=
 =?us-ascii?Q?O7qmtvAuJUPhhNglspBJn/vyMi1OQyqC7qjy7WodWdj5CYzEXiT50Y+U/uDB?=
 =?us-ascii?Q?FibjFbEIf/Cy1PUmj2cyzvM/sRxyiQk0LyNMqk5fHqMok7NiVF0YwEf50XAC?=
 =?us-ascii?Q?u5pg8diQ3r8R8QwXkXF7I5GxVdxMXCYXep0kmR58SGGNUkJiuPF3RDgrPX4C?=
 =?us-ascii?Q?pNTHoF6XQvEQub/ysVJ7gXHY1K3VbsSHDG6XSeIrgRExe/P1UzkjO10T1UA8?=
 =?us-ascii?Q?hojT4OQgrD1h9bRtgHtDg+N+5IEUVSDhBtLue5HHtqEIcnIlCQPRT4pvg1Zc?=
 =?us-ascii?Q?z3CDxQv+gUZ2A56ngx1U0egovo+A03HCZCP8sCFZPd14rFb2wEvwDTyPCVNC?=
 =?us-ascii?Q?WKjVIf6cSE1/Q1uy/4E2r9ESZeb7gy1vXHbTczeReXG4dHjtxO03RASrwtG2?=
 =?us-ascii?Q?cMg5lnYB9dkWhEIXFqLSkaDWR66jJkVfzK/3l9drjMDbE7vIFgDPkfLjbh1i?=
 =?us-ascii?Q?TBxyG4Zf1isxG56BbRisWki3oHD32PcTMWjsFc6lj6/asd/4NlhCPQ95/rW/?=
 =?us-ascii?Q?gGxvXz2+krNzWefOE3ZbEsV1mqUggCrV5POou3NaM5TGYBGU3l4v8MkgPNYK?=
 =?us-ascii?Q?XrbWzcenkp+ESsU9bMM0gnQ3eotKUwIjXmXiRLTMu5BsBE+QjuL0VlQnNz2O?=
 =?us-ascii?Q?0DJ0SucBySQOExGOKH9Ejshfp1eqoE6pfSAZ+HgtQWLunXFK0sFa7XaX4EWF?=
 =?us-ascii?Q?cbbze2TIV7vOff7d6aUMdXcdz56LWTB1MB5hmJkw2kcRuj+2n7p043bmBi/K?=
 =?us-ascii?Q?ujnzKm+uwC1aYnMi1YBwiAMAjtqbIxpvlO3FAnd0qhPvvBDtJSzIRMDH+bm0?=
 =?us-ascii?Q?5g1hVLz6hkky47WrgSpwqPVJWKN14wuAdNLz8udehkkn5PzFdwmavedgnuIr?=
 =?us-ascii?Q?MlKo5w9gWic9b4zKuAVYu3tNVtdA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:59:19.3547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5bd509-c9d4-4b80-9ef2-08dc650e5ffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637

Move FIRMWARE_VERSION_MASK macro to xlnx-zynqmp.h so that other
drivers can use it for verifying the supported firmware version.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 3 ---
 drivers/soc/xilinx/xlnx_event_manager.c | 1 -
 include/linux/firmware/xlnx-zynqmp.h    | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9bc45357e1a8..add8acf66a9c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -41,9 +41,6 @@
 /* IOCTL/QUERY feature payload size */
 #define FEATURE_PAYLOAD_SIZE		2
 
-/* Firmware feature check version mask */
-#define FIRMWARE_VERSION_MASK		GENMASK(15, 0)
-
 static bool feature_check_enabled;
 static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 253299e4214d..9d89b5a40f97 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -35,7 +35,6 @@ static int event_manager_availability = -EACCES;
 
 #define MAX_BITS	(32U) /* Number of bits available for error mask */
 
-#define FIRMWARE_VERSION_MASK			(0xFFFFU)
 #define REGISTER_NOTIFIER_FIRMWARE_VERSION	(2U)
 
 static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1a069a56c961..d7d07afc0532 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -52,6 +52,9 @@
 #define API_ID_MASK		GENMASK(7, 0)
 #define MODULE_ID_MASK		GENMASK(11, 8)
 
+/* Firmware feature check version mask */
+#define FIRMWARE_VERSION_MASK		0xFFFFU
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
-- 
2.25.1


