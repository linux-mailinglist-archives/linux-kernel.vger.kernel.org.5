Return-Path: <linux-kernel+bounces-2741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E474A816133
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E371F266FC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540F481C0;
	Sun, 17 Dec 2023 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qjnovyJs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F14654F;
	Sun, 17 Dec 2023 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPo33fa+NlJtW0a6+euYsE7DWkvcO5/H1KerAvi1tWwJQuuWH5RF+ZgA03FH7FMRIvxljgQnIDUgaPKOJ0KK7uGzAeM6bcfhssh41FJr246iVvW81vbW32VwEo5wg7+3A+E0caAIC5oxRZH99VCPiycf8OCtKAie7KpqTYRBjHvwTe97a2he7e0ia4GM0eBPrie5EP7qQ2cYbykGMmsLoxFgsyf8uWowLzWXoILtI0p25WU2EiENn8pWfRD2dl9Gj36GNPiFRR3vzmFMtwiZdzoYt585rlfhi0zXzmlfdjFBoqk0/+15UpbMIZsqjfTr4BRVS8OtCegRd8NUniX2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eo7ojfjoAaEajf+ncOHJPmHUNqXulD9sOKy5D6mNvM=;
 b=e+wEtJ3XgacGFe+aZKs4H+YeJerBfPFP+sQMYs0AUo2X97wWHT/MZCR/GZ6NCIUX2MzdQIyx0fElcfvuoV81+X+heY+f4ce6qnJ7lFeUztfSV2MiBSCWkZ7q9RruLrI2dmFRDa6Qu+yxPt4dkIjytwzAsLV7/7P7+qZ2xf0ugWDXdDCXD9Tt9rz2PZuQPfWNgqgiG29fv0Or3m1jLDnW/WqKx/d6q+w1g4Pr9Zaln+TogfJ8aKh9BjVaHJC9cgk2emXVZuEeghS/nWdPVKP4RAAIkmoFYlGgKFr8H+ouSWF5ayyo7Lq/jiP8RvgCqAh5iTPJ8SrtfT1C1ecRBtWF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eo7ojfjoAaEajf+ncOHJPmHUNqXulD9sOKy5D6mNvM=;
 b=qjnovyJs3uZM8K/3UeTj8NodAP0pQCo16eRxTGnPwTLh4xE6V11XHCnL+I/1Bat7Lr6BQpAuxd+Bl+PfdiS/UXqaCXRTYRkxMBMIJzrFsMoN95F82/Z4cc9Nrv+0ZP+C9T4neQS7mOEFekU8zw4WfY7v8PaBh057gVLIbxeAJ1w=
Received: from BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) by BL1PR12MB5110.namprd12.prod.outlook.com
 (2603:10b6:208:312::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 17:26:53 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::9f) by BL0PR1501CA0006.outlook.office365.com
 (2603:10b6:207:17::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32 via Frontend
 Transport; Sun, 17 Dec 2023 17:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 17:26:53 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 17 Dec
 2023 11:26:47 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 3/3] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Sun, 17 Dec 2023 22:55:45 +0530
Message-ID: <602bb64ca452b843a3df8376f731f07e92039589.1702833179.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702833179.git.sandipan.das@amd.com>
References: <cover.1702833179.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BL1PR12MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2406684a-4c45-4383-9270-08dbff255c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PO5cczoITIdCrnfvmwX/lTZ/ESc3dxneJPgPYmKvRoyPZmf+7ZgY8POs6atPRL4QRSXrvOvhXSogywYwXVss48a7uTYuOgLfBD5JQJNCjlIcbyH6x6C9g0VlHNcdHHJ/OcJH9BYR7TnLqNmioh9ycFhPa5k7ezBlBIp4C5R0t8K2CmK9HVVL7JNTOt3Ol2f089gSP6Jc2lB1VAqIKkip/tAZ5iJ6D8symaUDO9s5Ai5SOMdhlNa134DuWpQzl69q5YYQPWmSWL2EaZLm9VYGB3S1qkdE06C4lwdEQU4753LgJ0tSjR+xQ9weAA5nsXVr+5vjDxCNAXX0vjfx+Ki93gm8SmT8MaJt59wzcOXBuHfxFkTBzcTV1Sr5sh3fipYaQOpKv8/HQb2LsuT/poOewtFROyl03UmQBMcvSQYvGm1LzEXXrHuJpXTrwSIqTN+TLE/GF53AOwTPXeQ+w5Ut9Rio32lRP3hRkQZhluwIfjKH+HpM7OShiC1b08o6dobFw8MTxa/5b+Y+e2dejq1e28qfNDiulyhrNkNeI+YUjbjcHTwjlRUa8i7HVGVGBv5XJbnEP4hoiWIzzFNyuruesa1UZ5AgCVsZkx+tDSYQ0T0TqFwxHONoa1GveGhd0yv4ICMl4fzd4npWazkh32kaekhuCMPrB8lyBH+7j76092Ede4B0ph5F2ni0sArJr0DEPDyRFPt9/DlSZB+gkq+00pp8b7xKeXS2HG11jpUuZe7AsT7C3/WS3d9em0Ps4AjR48Ti40vTXenwBDlVZewQFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(426003)(16526019)(336012)(26005)(2616005)(40460700003)(356005)(82740400003)(36756003)(86362001)(81166007)(47076005)(83380400001)(44832011)(5660300002)(7696005)(36860700001)(8936002)(8676002)(4326008)(70586007)(70206006)(54906003)(316002)(110136005)(7416002)(966005)(2906002)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 17:26:53.0794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2406684a-4c45-4383-9270-08dbff255c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110

When bringing a CPU online, some of the PMC and LBR related registers
are reset. The same is done when a CPU is taken offline although that
is unnecessary. This currently happens in the "cpu_dead" callback which
is also incorrect as the callback runs on a control CPU instead of the
one that is being taken offline. This also affects hibernation and
suspend to RAM on some platforms as reported in the link below.

Link: https://lore.kernel.org/all/20231026170330.4657-3-mario.limonciello@amd.com/
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/amd/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ffdfaee08b08..63514c311f44 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
-- 
2.34.1


