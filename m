Return-Path: <linux-kernel+bounces-116667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD888A342
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE66B3089F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9212F38A;
	Mon, 25 Mar 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfAGKLSr"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E841134405;
	Mon, 25 Mar 2024 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352927; cv=fail; b=NHYTMd9C3oLAB/PSU/F7crpARoL0cZELfI9SfHKooKkWncJBOaL7KSJwbJfZLbz53yfChovkRMTAymbiD8vB+SmS0iAXTn5ELeeRg1TrhpCOuA3o8u2Z9cz/yJcUcolnyEBiztj2nUz9ImGBrs2De6Jya+GWbCjBURVjEJh9J48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352927; c=relaxed/simple;
	bh=ZeBGMbe5I31fxmeNsIZYTK7CBk+DqBiLdc1wTFwsAC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+CfPwBKshmJuiaOoRPGd6lkiBKRoqRi8+taery0mqQHCc45cV1z7f4qWVN36FQWn1EWUC5j1ovr8MO2Qws44+e8hUjzEXe5n3Dr4ZkoQiWR0Y9KGPCX6QmNFZ5iAiQtHKzhMA3BdOKq9Hz1OGXwUPYummAPAtVULC4MYwlez38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfAGKLSr; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYXaZWeO3DCyZ2kKCftrUpLPgJ92WSkq6VdR9TqMyh6o5MISmLiy2d+v3PCgBDdtpna8DD3l+RXumuUUzci2vY4scH8FIWiJdpf5swj7NIQnzrGm8ULfeVOtFGlq5lsuVS593pdp/tE+eMJ1YIFJgoPdAjno31vhsKowfjIuDh8VKH3J4buJwzgxC/4MJOxAaGtns/usVFvm1X0ncgp2a3fjQMDhvpM2+iTLv1pxax1myCZsP1k5S9Hq44vQpHCZj+ubP95/9z/RT8Fmc/gnUjjKNhRtH6w6UBN3aIeGKscNVnWlgdWpvVnQt+7+UZOGX1KjYM0jesa81POpIWTW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaPKXUR/oBoPHHk5BQtKRwvb7ua7McQkYZlHRHnkdNc=;
 b=JVEDbJrUTTkAJnYWOKTk6/VJJf8lF4aSb12DT3Fn2asZD7tYWM+71nu9zU4r9CjWHV/FQkqe3+nVaTl7Mir0aUTyKbKVDoHDWX34pHHRWx/vCIh+ikgWGdSqOhKwyEoqLwI1UQNH0tEJD9m7006AQL9L/di+eVDGeM7NeqJ6VBuaI3nHYJULro44boAhNXq9uve+JzNeMkBjU8hT5/e0P1jOXjvJyvXKxB3rMJORCa+BmAFw3hSuKI7y/0CZYNqz5NuRt7mq31D28noIGAQiImgVd2vrRY4xH95CP6WzkgLBQSRN/lVyE0PZb7zw62QoKONVieAIMH6e3g/ecuJLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaPKXUR/oBoPHHk5BQtKRwvb7ua7McQkYZlHRHnkdNc=;
 b=UfAGKLSr7DQSTAcS+hvfG134uFLeu4YaLJsznZ+GStVAGLLaTacmAeoqpt0wkV6EXD8V19cA/g2RVIKe2zdjs/A8fN+Je5ORqciwjpmLsuN66nLQrs3wY8jhs6pLwcVMnJ8aeTG7M9PAYRchBdzXZffZ2s8S4aiVfY6J8i1Bh+o=
Received: from MW4PR04CA0310.namprd04.prod.outlook.com (2603:10b6:303:82::15)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:48:44 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::74) by MW4PR04CA0310.outlook.office365.com
 (2603:10b6:303:82::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 07:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 07:48:43 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:48:38 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<eranian@google.com>, <irogers@google.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/2] perf/x86/amd/core: Add ref-cycles event for Zen 4 and later
Date: Mon, 25 Mar 2024 13:17:54 +0530
Message-ID: <089155f19f7c7e65aeb1caa727a882e2ca9b8b04.1711352180.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711352180.git.sandipan.das@amd.com>
References: <cover.1711352180.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 87858d3a-357c-4555-15c2-08dc4c9ffee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IOC1PKbdG2fD4CvOTNyZYdo7+xgIHN8SjWFVJMY5WmJ0sTg47sbMqWUtHoe4yOOWF/y+b+A7AECuJbjWecALV3K9rrlnCzbCTouaFztNGwby+oXXmigq9nUnxL7IMEoY3HwD9bMekTSK8hBR3CU5LpQiLySi0vKf8UkHYIjciLUdXaTxiABODM08jcJHTO7auuroWjlS+dwLpIxs4ef6/osXSW/10c4P95Myj11MEtwWtKk1ylTKuc8B/7OG5UENEMy2YZMbg2gU7xxBnsu6qRZd7jEWKerZvjdbrTFWv5g6bN3dz5xz58EmUiawEdXO7CSB4PC9C/+LYGo5OXXneww/cGSP/j0pFhaDc2MQSdVX5uPzwiP0086o63XoPRAVBfAY2IaCtT7qRhpmLStaccRuYMr0G9ILhGNknWtj3r8fIibYd12WcdPaTRl6cKUMl4pDUlxZmS/PxRC2U9JX8DaWtm32PxSzKjR6qtxxxM0qhTaRoblKg12S6gwmP+V/UdPr1RBZTXras9NgY6N/nZhfUJZdPj4sTDT9doUXFu8dfL3jgevsSYEtOEobW++3xxSbV+H/PQZcgFr2HDAlCttiFBn1L4YnI9oT6oasrOdEfvXTkJgWZ4fMsikJ0sTVo8XngIQ+SFx10A4k7XKjsAzgNDvj8lPZFb1W023be9TnhaWQ3lzTuPmGeP63lPdzg29DpKMCwbRUeeowlCuS3103zfCuoD+9tE3LsZovRCurpv23JB89IDKzNkHqLzM6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:48:43.8182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87858d3a-357c-4555-15c2-08dc4c9ffee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

Add the "ref-cycles" event for AMD processors based on Zen 4 and later
microarchitectures. The backing event is based on PMCx120 which counts
cycles not in halt state in P0 frequency (same as MPERF).

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index afe4a809f2ed..685bfa860d67 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -273,8 +273,23 @@ static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
 };
 
+static const u64 amd_zen4_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x0964,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
+	[PERF_COUNT_HW_REF_CPU_CYCLES]		= 0x100000120,
+};
+
 static u64 amd_pmu_event_map(int hw_event)
 {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN4) || boot_cpu_data.x86 >= 0x1a)
+		return amd_zen4_perfmon_event_map[hw_event];
+
 	if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
 		return amd_zen2_perfmon_event_map[hw_event];
 
-- 
2.34.1


