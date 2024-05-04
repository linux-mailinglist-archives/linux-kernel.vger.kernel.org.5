Return-Path: <linux-kernel+bounces-168510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 297498BB967
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBEB1F235D1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5311711;
	Sat,  4 May 2024 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="urEKxfxZ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA9AD2D;
	Sat,  4 May 2024 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714795808; cv=fail; b=MsqK+uhGVWCoM6BQOv0JQmmSy4IjChi3eD2iEtCjkcLukpNpraAKNEBcu1aDpDa/BmaXyELVOsxKeStKqPYTszjL/tYmu9jHoVjBBQhTKOmNh2KaT4sVt9Wu+NZebFofq6aLabAS1iwVDr31hxzRApbc+hzajGIA74M5ZE6Xozs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714795808; c=relaxed/simple;
	bh=T6LqmC8KjubqCKBRcwvfF/f0uQKDI/yjfdkab4z2p6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjOd1vFo5G4aQNmJneRPPvPixevyoQ14gFH9CMxWp1x9uVhHR9REb6aGq8pHVocyDpKgOOaDPyd4VPMpCNvcAJguZsUttVPnVg9nxvcrk7lQPp47St8fHzBPin3DDBLMI2nC3JjpUxEZY5qaeYHMyVTpgRAAOAgevZJNm7bjei8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=urEKxfxZ; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1NktpEZdBHbf5QI+G6RXP8+DejFW/J5mVIFQjksEQjaIT+8n/8LQbC2WCGscpu5ZmPEYjZJaq/f3w0U4p3p47b1gdKeYFUlnna4TDb/wKA247atfcrezSkcW+0Cst7Y4HFi/WRW0opuLyi838cwqBzJGtr6JhJzq+RGhC9zp/gMHfGcUeewaPsqMsT5iO5dFKRP/uqPW/reiqklKF4Fcx3m2gkG6SK+2mWGGHqHC3dzEfKVUxsExBgHYxDBcInrvH8H1NZkCqwQyXg9oCDFcrb9mi4DOocUy5LiS17vTvT+GK/uDH2LZLmsNHwHCKlpheiY+Q9ExpBvdVhKLgDmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyNjBkinITYKq6JTnZa6yDwIkidf0Wg7TqqPqWiBmtk=;
 b=k5hDf4wGxR0YgUW9db2kR0gi3VplqbaJCbGVuhgasz72H//GMhGa7UmJr8AuVov1CiN9bERLZX3tix++cpbLRAeQFTrQlkOuKfxK6oA/B/GNii0ZNu6AAoSAoYqxuMl4khpTCPFBO8kBAIVBDc9vrnNSmVQJlxjLvUZwTJkFwjrRIIk3JghFeaKGeTdWzDlxU3z/y1gnV7Mw68Ji70DG3PXk7qAQ8ckrQWEUJL7NAyjR6qpV5c3BknmQVAMki2dIUsQyc72wJCBw5Be3H4Ge4z150bP4xNYWWf8sUhP5M+Ig1omMm8f27TtKboluwWmh5+jgZaoxBeDgIbtjNEByZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyNjBkinITYKq6JTnZa6yDwIkidf0Wg7TqqPqWiBmtk=;
 b=urEKxfxZGgBu9mdsgbA0bBHk6wMMxvsHlTcsuTP2PNmA3LbNbq2QYv3/CIZrRWFbXXATmFEzA5DJj0DHB6cqnbreTR4BtKGCtgvbhZO8MUfYiV0rXC/AEK5T9IEQ8VPqI1abKVPXwJwLsxbwoTrOpTKiANGsY0Md/mI+6rjm8hU=
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Sat, 4 May
 2024 04:09:58 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::41) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Sat, 4 May 2024 04:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sat, 4 May 2024 04:09:57 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 23:09:52 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <linux-perf-users@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sandipan.das@amd.com>, <alexander.shishkin@linux.intel.com>,
	<irogers@google.com>, <gustavoars@kernel.org>, <kprateek.nayak@amd.com>,
	<ravi.bangoria@amd.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v2 2/2] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Sat, 4 May 2024 09:39:35 +0530
Message-ID: <20240504040935.123007-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZjS0Uio+nvZLLmyb@gmail.com>
References: <ZjS0Uio+nvZLLmyb@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 92376844-4f1b-467d-acf1-08dc6bf00fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkZHZseHRRea8nVMiBQvFVOY+GnRWjmd3sb9bkGlnUa/8Uh4ZOsztWTgWHd1?=
 =?us-ascii?Q?M0eISjkJm+gXvomtXcFVT8FX5GQoUuJeMTj7WDkWfS0s/KiKIJpJ6Wudy5xo?=
 =?us-ascii?Q?41liyzV9GvzTeLDSXrejDA1il1CtXWNv3OxjwAfthSR8KIarx7ZK+j4OcNOJ?=
 =?us-ascii?Q?tNntiLa2XD7PspzMVdj1yso+G3OALfgMXIY5hwO+P3hrChKYd6iS4qMgSw4d?=
 =?us-ascii?Q?WYIDh1KaYHjsBYb3V9LMrm/O1x2B61XtkzPLesUYoOgTl5kCkMd0OSKF/GNF?=
 =?us-ascii?Q?8Sks8vhL2cGJHYmz7rVz9Q3FtuFcztaNZpy5pYC3okruYXvKQwdPOAq7YvFh?=
 =?us-ascii?Q?2FPCzga/0UM4dT32zHbNEIvWEv0z0CDnu+aL/6O1A1iTFOPsIJpu/+JtO8T3?=
 =?us-ascii?Q?Oc4H9lZuEtjh7JJZmmP0OFiIl9CBGEPxh5hoTdurawZ3kZyV1fyVUCThLd0s?=
 =?us-ascii?Q?VwSvUWx6zDlJ+EJ2dI7TqWNHjlgLhkrkG8e5qUxPJaVQIKHASDMAJsokDksY?=
 =?us-ascii?Q?mJehclBN4w4vPn6DnsmbgrcQcrACZ695CeLEUvM88Me7X7xkErVJort1tW6/?=
 =?us-ascii?Q?wofuU7pyIZZq0dJC8hfZ4pIuMkX9OUgwap/pdcz2u/d07CkWsHamZqHYMg77?=
 =?us-ascii?Q?ZUGJkAo6VIaMsFCc18LidUNs7zPDIKnem6addxGEhO7n6rzLTyVddbRwtN/i?=
 =?us-ascii?Q?7BlVkLRjKIJCD3nED2nJgFcg4cXLJbWRyOiBRICZCbWwIEBPFAOgir4N2Vso?=
 =?us-ascii?Q?ZixPNci+VmIMCkDx8ugt7WQjHsK4qdvU8tx2Yp4VRQIZzWyQOr6TAfb813lO?=
 =?us-ascii?Q?XNTCdKdweviT/DxI05R1yljO9akHQD7EKXSMul/H9zaHt3iYULdNBCM85e0g?=
 =?us-ascii?Q?OCM54G4RAd7jGPEEPEDMy7kHYRb2V++E0y/0gbjiOBoziGa6FAhn4wd9ME1p?=
 =?us-ascii?Q?XxT7x+hPc3+pNRAiRegu03XMkJaukzylCPbY5XQBZojUqmxnLomZSOua3gVR?=
 =?us-ascii?Q?e/xsGE3KrM/Y/JYjpcTf7/9hle5iZ6AwJFPtpaH7X1wRXq8EySV7oe3BCs8E?=
 =?us-ascii?Q?vsXPHcIs5BMcrsGDvCR30uqi9Pyj5d/e0gqZzFYi8xCTw161s9K+Wr/ctwW6?=
 =?us-ascii?Q?oq/cNWF/ONc7BjftwlfixRG35BTOiS461WAkF2OPs/DbYANGCP+L73sBYnQM?=
 =?us-ascii?Q?FBUfSiBX5Ryxig082M0+dsXcDmCHfIJZ1SU7XM9SGZMnwg+YqyCP/UvJ8bVD?=
 =?us-ascii?Q?tRfxtCWn0J+dQbzRwhsCTjNaIhCPJCs5mir87WrHQa+2JioEzB1fgqHdyWtn?=
 =?us-ascii?Q?uVXUHSJI3U851twvyIzWiXE1zCppYLNcTOhRVARZu+a7cN1J5RX/cJPF3VAc?=
 =?us-ascii?Q?52NYcGvYfBykeXRPDydrt8LwsRUF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 04:09:57.9070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92376844-4f1b-467d-acf1-08dc6bf00fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros, no longer 
return the package cpumask and package id, instead they return the CCD 
(Core Complex Die) mask and id respectively. This leads to the energy-pkg 
event scope to be modified to CCD instead of package.

Replacing these macros with their package counterparts fixes the
energy-pkg event for AMD CPUs.

However due to the difference between the scope of energy-pkg event for 
Intel and AMD CPUs, we have to replace these macros conditionally only for
AMD CPUs.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

Before:
$ cat /sys/devices/power/cpumask
0,8,16,24,32,40,48,56,64,72,80,88.

The expected cpumask here is supposed to be just "0", as it is a package 
scope event, only one CPU will be collecting the event for all the CPUs in 
the package.

After:
$ cat /sys/devices/power/cpumask
0

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
---
v1->v2:
* Fix the const qualifier discarded error (kernel test bot)
* Change the cpumask variable name from cpumask to rapl_pmu_cpumask
---
 arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 46e673585560..d77bf7959a43 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -102,6 +102,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -139,9 +143,21 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+static inline unsigned int get_rapl_pmu_idx(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
+}
+
+static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
+					 topology_die_cpumask(cpu);
+}
+
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -542,6 +558,7 @@ static struct perf_msr amd_rapl_msrs[] = {
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -551,7 +568,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -564,6 +581,8 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -578,14 +597,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -676,6 +695,9 @@ static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
 
+	if (rapl_pmu_is_pkg_scope())
+		nr_rapl_pmu = topology_max_packages();
+
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
-- 
2.34.1


