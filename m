Return-Path: <linux-kernel+bounces-116666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C4388A23F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D44D1C38952
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB412FB08;
	Mon, 25 Mar 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UWq0mkU9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38831495E5;
	Mon, 25 Mar 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352913; cv=fail; b=rSb6mq5iZ702zDmJh+1/XndQ+TLJ+ikuN2ZUwnovDQBlyy5SVTgXJRtSNqHEtQJovQcD9BFRsn01+CWwi+ZZOFp8KZ4ORDAhrXNus7w6uqpW9TDkTMnEWflzuzCYp0ryiODSOY5a4c0t/fPEstrxlymqmrucaXGqh9xoFXXFhtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352913; c=relaxed/simple;
	bh=Rsa7YMwPbDlpcdLjjyZ9dXk6Z1OIlQW5hBzneem24KE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay58kL9ynODnyLm+Idet6VMQZkwBlgcQSiNpwtf0IEcNCK9tcWmpO0k9722cQbbGv0h5PeJHoY7T1SRHxRcbXiuEt1k2j16VOcb+JniZn4e81Ann5t27EssUQCDJ5AIjmIiszAndDA29yp6nRwnnEToKqwSXYEpSTczO9o0LpuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UWq0mkU9; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIahj0tabMovROT0Bvx10yjafFCA2KGIr7GCPCp2gsgvBVagz6XSfbTRZi+Ag7CF2F2KH0jXOWIrk2n+d6V9eQyCVMqcpo5vAMCXD4ZY8mKkGnK6pi5FyTq6gA9XEumBFp5fJ80kW+9Om97texAzuTLYyIT8jnbsK2AmG+WqaSrptubm9U4NEJQLTaHqJiBzZEW2zf8j9eV9HTCwrZT/UwwrcsjSBeT7SDFTXEXO6y6bIIXlHgA2KJIWauMcRLVs0xlIPluGX+kpKTzprF8hW+WyYPF7BpPrdNt/zxH7Fj0voCHjTsVOINy7yyCPUoz2wZ/t48HV1+K6iint/uVTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAL6DVz0AaMNSEvHKDxxRc6I6/kbeiezbQBQD46KmGo=;
 b=DaSbs9f5do1zVgpjcUgvWCas58XPNFsXzEJIZnybiREbMPIU4u/fPdYUbrhVXbJKfPdZbJ3qtrWZM4CdREoyqaKnDN0uL/PsRr4Abe0dEjj18OznqePHJZr4V2FedoZLiADneE3pWbaxdLq8MU3HvfDy5vmpbJppSuOzyeigHbt4XC9yL+eG+4HL8f3V/DBhO2rDNq4VeYB7jlIjXOOUrrKzDAsqE4R9mgD78BCh1WV9F6OsOILtCg8/aZTDiSN2jBqLSWIq7ruJH5NCWXH6FK45mWPr2Q3OPwJ9W8VfabdFKH9YrIiIIyd8kjkvQwfzpa4M9KfwszbPHkXHFkA3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAL6DVz0AaMNSEvHKDxxRc6I6/kbeiezbQBQD46KmGo=;
 b=UWq0mkU9iaDKgXrMYM3HJqdCTajLyJD6f/DwtBvsBKeSjNZ7hSbd7DlOEHbqljPLRCsl1Mt2IkCbtOUSmK2txeJoaQXy5gcg3+lx5IFhsibbZb3JB/t6PlJHTUQN/8RRQozMk7lTdPo9W13/lEmZ7IuQQw8JUPig6MTBe2zOeLM=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:48:26 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::7) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 25 Mar 2024 07:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 07:48:26 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:48:20 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<eranian@google.com>, <irogers@google.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/2] perf/x86/amd/core: Update stalled-cycles-* events for Zen 2 and later
Date: Mon, 25 Mar 2024 13:17:53 +0530
Message-ID: <03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 4192e421-c279-4213-e81a-08dc4c9ff45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W7LaUPuyIbv/mLQcqvy40BG85VUcVqZO/e3ioUglk4SFVECg4dnOIenxp4PJ6qo4VVufHPyyjm5Td/JAI7Z2RTZ702EAN2ScOan1bm61X7n4dNV3hoyG6/eAU6agQx2B+wJyzRuxhoe1XtV+C49YB7V8pXtn5MslBGNpMRTOvY863lvpQ1ONFqoLzlDwwAMKx7A/tTu1jNxg197d5cK6+O40s/vs2s9+ahRvtn7Lpg3Ia4/nDfPsW1Wl9PtgtUrXLbRb1MGGmQLPza+dQXZQS7E94h0d7sqTyEE2VhNVhePTQ/ra5S0Db/SAJeE/sMRuoxy/SkV5Xn5qvpzMtwopg7Cf+KN98At4e0IaMknQUEtfm6iulIANlQtb2NjWTDeb4hZxekTFNsePZdp6dvsvYgImxL/G8f5lOiyXb9/N3iQadyyOPEeLYtj6ZxkBLpMToqSLrxJfbdpmdhFE9oP7kw6CjKJbxt465k5eL1zBG7SjGqCwYi/12DW8wN1ePZHkGZO26PpwUI5lBxnGnr/moRj1Ztx3JaoslzZO8XurZhzUOJ+TVEnUFRuohnJhYiH0JaW2UFREuEXQbvy7j/O4QNiZIvf40kj/ZSrzgQ+UxM2CaYReTRFMUMlqwnltf+g3p3dU9VO0f+d1U1xNBL3p03mlXm3glZRFgIwgYxylueL8+ABxgfzG9DURj4KdaBcryJego6KCCSRR0kIVlX2arvUlrZBmnzYd5WY1toyy/ANy3BcT5l6uBSyeogBkN4UH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:48:26.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4192e421-c279-4213-e81a-08dc4c9ff45c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

AMD processors based on Zen 2 and later microarchitectures do not
support PMCx087 (instruction pipe stalls) which is used as the backing
event for "stalled-cycles-frontend" and "stalled-cycles-backend". Use
PMCx0A9 (cycles where micro-op queue is empty) instead to count frontend
stalls and remove the entry for backend stalls since there is no direct
replacement.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aec16e581f5b..afe4a809f2ed 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -250,7 +250,7 @@ static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
 /*
  * AMD Performance Monitor Family 17h and later:
  */
-static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
+static const u64 amd_zen1_perfmon_event_map[PERF_COUNT_HW_MAX] =
 {
 	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
@@ -262,10 +262,24 @@ static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x0187,
 };
 
+static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x0964,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
+};
+
 static u64 amd_pmu_event_map(int hw_event)
 {
-	if (boot_cpu_data.x86 >= 0x17)
-		return amd_f17h_perfmon_event_map[hw_event];
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
+		return amd_zen2_perfmon_event_map[hw_event];
+
+	if (cpu_feature_enabled(X86_FEATURE_ZEN1))
+		return amd_zen1_perfmon_event_map[hw_event];
 
 	return amd_perfmon_event_map[hw_event];
 }
-- 
2.34.1


