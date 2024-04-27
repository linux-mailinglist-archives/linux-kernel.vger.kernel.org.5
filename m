Return-Path: <linux-kernel+bounces-161060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D3C8B4689
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0487A1C217F7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B34F896;
	Sat, 27 Apr 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aSWa5snQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FF4F61D;
	Sat, 27 Apr 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225992; cv=fail; b=DPwFu54gv0S/Wx8oUeqCzFbBnC7DV5rDJ1RSf1xLKhjQb75/R7Q9GxJ8Y3C+Qyq+QU2gBPdJNSaLhbK7RQtZBcT8kNDWP15Z/v4obrLCRlmpCoMM2tUU7uFPzpvVBafC6T/kRuS8wTGG/Ff/3B4AVyHTJBZs6MTtxpGkk1Qp4WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225992; c=relaxed/simple;
	bh=3KzZir9ZebkkfwcvdVMfJAyjKSnxrIkdoOZq39YMsqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3FabPuGPgSY+91VaLx1p5oe6oLTcInoWW4M8zbE4DJaGYnzcCXC6kCIaF97+mbxQP4eQGgbxl6FksbcRh3k5rfEwtgqGdxUm617e97j2DYjkiWu15bGeT+i0/j4IDuQgOiBU26A3Vs3oe4GyjxBWesBXuihKiaMmsdkC+eWcHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aSWa5snQ; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g29Lje0u6vzTJulUvq8EZppZbodJG7h9cc7kU2qg5ea07Y8yuo/rUPxW7nXXAP0/dtdc1FTOvg/cWC0mvvue5EQs9mJJC9uMPKxfIiXfcTfIexyw4L0R3DGyexXRXfFTl9gfFuMhLwxKXRjNSHpSedGcbwkzTQ8N2Vd4e1MV0DR+o0A+9w2/qTku+bxwMR5xZAQt/VsTXIONtAexq0XUHdDAuyQ1qdwC2z2EJ3tBV3Fh3/eygziinrNpvR2nTNy61lWMzgBEdC0DJ+RLndWXRbpelKueL5MWyPX5ovVkij/CuNQRwAQ0pBUV8yXBpavtv0dgTDDvIBWauYYv9AyICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2bS/o2FdF909UMNdNgWxw74U42UcCPJjHvrtArdOp0=;
 b=YsF+lzHht8jhktuIXCiQZ+eyaIFk2vmyBYuL/8tXILNJOdfDVGZ644bgLSlNLtxhB3aKVy4msatmiW1N4jhXr+qixCeT2tsScQdGENaJY9yF//zv3EIiDNjZmt+TG3JDR8TQ+GMiMisxPX/5Cezd4BF8xADFxLwBbU2GaN6CQt4F5ldUL+zKmvVrmu0cHImEvhDQEH2w+KveFQlZ2r7eusD9TGfXUh1qyK4P/mjLU/zcWRgIQttCKeMIFu3TI+lPV+hBHYy54jgZM8uhHXydnjyXGk+p9Xq4ngK4wNs2lkw1pZzNIGWakBAx539WsrSHJnEEoghfsK/xEcodMd3+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2bS/o2FdF909UMNdNgWxw74U42UcCPJjHvrtArdOp0=;
 b=aSWa5snQgZu6bNDp8JChDfjFiizHcbisMaFZFZIQrZV0uqe8U7iEtSUUloPawTmDZ7PG3w1dP6Zd4W53j/k2GjyJ0995imN6LR1/YehIGC0q16GjkrFr55iwdghqYiN068k9qLDb/YZAQhJWzmdiBrXawUQnXoTfRGtKBCP5y4o=
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 13:53:06 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::da) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Sat, 27 Apr 2024 13:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sat, 27 Apr 2024 13:53:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 08:53:01 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: amd-pstate: fix code format problems
Date: Sat, 27 Apr 2024 21:52:49 +0800
Message-ID: <20240427135249.2160493-1-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ca6fed-549c-4e80-1500-08dc66c15d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DNJy2YEG63dcbeR/WLm2ESpM4CSfLO/un6iEQ5NSWwLAGOdV8LkI1TKzCcT3?=
 =?us-ascii?Q?exqdHYBMDL0sGLqhx1yBgRD5zUVn3aCcTbAM3t8s00t6z88uGgX1g0T7wnDB?=
 =?us-ascii?Q?9U953B2Mx/h96KBbae50BFfFAbgMX/7zf58mjT3D8gRVp9fJf56GFF7zNlI7?=
 =?us-ascii?Q?RMoq/RKrh4QM92Amvek1SElE48cCUMxpgLH0uV6PDxJfBUhlXTPYTx4fc12U?=
 =?us-ascii?Q?mhm/U9dBEDV8D5qipfHw7fcbuEcq1b3lHjYh4mMAbL63Dr3mOMdGhfmgoUuf?=
 =?us-ascii?Q?E7JZFlgYwX8vGIvaGWCiGLQuWKGleUwQiSkdKuhap7YItbhrqSsY0K/lNvHd?=
 =?us-ascii?Q?IeqA4MHS+iqEKUuPoAB9b3jHOxkAhtRilSoCaasUcJAdRuA2MCCvC3aH7EaK?=
 =?us-ascii?Q?/+1rw+GgDwoUSHziaH2Z2pARuEe2rgHDslngeb30xjE3ZxaqWHqD0AQSn2cZ?=
 =?us-ascii?Q?x7GjjQhNDS72JW6UAWXenEbAAIiFzy161g0KiHYHRJJ8kEHnQmPvsfGFv67O?=
 =?us-ascii?Q?6VWOabaQnD7R2mSbPvH5+CEkhqB6BdetDHXdfiaqKFOf9Zw01x4fo9e/ZiBe?=
 =?us-ascii?Q?/5ICpWGix9h2CXpEhPWRNJ1N5Fy/TKcxq95fWGHfDVL0UrQBhb7l9hlRKDef?=
 =?us-ascii?Q?SAGD3RprBX16msKB8bYhGNefb4rdynlPj4Jk37oahuy9fc1osVktaLzgtRkF?=
 =?us-ascii?Q?eHektS1swyVsfY1wjlVCQUTHfwqx1zXUi3dtrpLd7kqsdZLiwQKzfUsrYMeR?=
 =?us-ascii?Q?q++ceYq15SIXNobmh2AugytrMFR9K8cpHbZzU48Zx/D2ORnuC6vEVkquRpSP?=
 =?us-ascii?Q?p3l1jrnTG+Fy/XRQ03IMuzplXvGhO4XFlf4mwILJ2fYruhRMpeL5K8vTj+Aq?=
 =?us-ascii?Q?gHheAaS56X6ydP8q2bP5XJVI/Ca8Exnj9a+SJDzVngR79pgKAE8DjnAGmNLc?=
 =?us-ascii?Q?PJSEBMnyoiF+q/szPaxOb0aXnBmww6Uno9enWno1RSlzAVGYIQ8wrTdOfT68?=
 =?us-ascii?Q?ghVOmsOHGCJQFibH5VlQd909JYudm4miYx2RETozJQL8Dz6udi2cczmw/vK7?=
 =?us-ascii?Q?bT/7frLBgh3wM4OE8x5o0+95weETVCT6Ye6Oo7dLY8wDWLUNrl08dX/dQsnH?=
 =?us-ascii?Q?LiKEtoaSikOg1dZ7yH1jAhovHm3oFSlxcK2qBEBF8kmrrBdeeSgRbe+2VsDt?=
 =?us-ascii?Q?OTw90r4/t5PEnSw0OnopUVxbA6DK0BJeRnnRqIW3+gzVSWNZdScshIs7C0eb?=
 =?us-ascii?Q?aa+ShwlU4LD1oVmamKZ3CprDx22CSIzlF39yDsdqJDLJVJd8QNkbFE36z3+G?=
 =?us-ascii?Q?1xFdqu5PGTeXOOrMpxYNvb021F3yIKFZvpuKHReaxItBv69XP3FBKQbfJ61q?=
 =?us-ascii?Q?L5tRN5rjXhiem323GK9RC6nth4Nl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 13:53:05.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca6fed-549c-4e80-1500-08dc66c15d05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

get some code format problems fixed in the amd-pstate driver.

Changes Made:

- Fixed incorrect comment format in the functions.

- Removed unnecessary blank line.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404271148.HK9yHBlB-lkp@intel.com/
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 83a29b257794..85656342a101 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -792,7 +792,7 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
-/**
+/*
  * Get pstate transition delay time from ACPI tables that firmware set
  * instead of using hardcode value directly.
  */
@@ -807,7 +807,7 @@ static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
 	return transition_delay_ns / NSEC_PER_USEC;
 }
 
-/**
+/*
  * Get pstate transition latency value from ACPI tables that firmware
  * set instead of using hardcode value directly.
  */
@@ -822,7 +822,7 @@ static u32 amd_pstate_get_transition_latency(unsigned int cpu)
 	return transition_latency;
 }
 
-/**
+/*
  * amd_pstate_init_freq: Initialize the max_freq, min_freq,
  *                       nominal_freq and lowest_nonlinear_freq for
  *                       the @cpudata object.
@@ -843,7 +843,6 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	u32 boost_ratio, lowest_nonlinear_ratio;
 	struct cppc_perf_caps cppc_perf;
 
-
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
 		return ret;
-- 
2.34.1


