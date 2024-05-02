Return-Path: <linux-kernel+bounces-166256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FD8B981F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90878B246F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD6156771;
	Thu,  2 May 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zZsYLufi"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD55644E;
	Thu,  2 May 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643571; cv=fail; b=QHlLPsyQkxAreqPXJ7AJKfNKAsxN1bLFwVfuRgC1ArO9a7alau0RwGVeufubb7Yzse2KMLUGi+epLu3kio7QtYV3HTM+M2vZAYWW4skHpqwPwWmWXPkIFKAFn+W8fWX6oFSp9+JeXyLvPDM4FzZ/VKCXa4H305Z7SR4wVjpUdWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643571; c=relaxed/simple;
	bh=6iwEzhG4bHX5ibXXMGL4mKfx8uDicQXRxcQguXZghrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hif5dHztysjguHH5NhAARsmshxTw6cELIinoqZUt9IHbjFPnh0YbaOhe37oAWZTvi0tDEPvk3jZYotYCVoX/gH3Bpl4ptAthpMN7EzKVUxvSKdIOlyZT0YMGnbjI215LFHxHcNy9EdOry3Q4Dq66vNGry8a+Gh5SWyZ/a+VNX/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zZsYLufi; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxuiRq8VhyyWsc4uC2uPtHYpKjeFKdyLYrfYcjgzw0MwDNAJmrGl2zZr9GebxtObwMJv0AlY5d5aw04stsZyOtWlTM8MRY5aY/szRWp5uZ2KMYKWukMRqXT1xh36RcEXbplBZx3ya6x+Ol0aJaAHEpLd5qBOC9JabIc6+1cQFfQvfQsI5l1eN9BqcjjCirRc4fvnx6MjO4Le98TmPylXuqoa4v3m+ScM/icfG+A326RFQ/SFNRJaaWgRlyQYAQvXZOzSrBFNAUHMr+vIjaBe20pnGmEA3ZLJQT5wg6px55rS9W/iCk+ouXDOPY/mwOE1//ayWNdqAYUetbU1Gj00XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxRSNwTJiVNU/sNkdfqTJok2Wf9CF8PyX1ph712TswU=;
 b=nBfyu7qMi5Acqi+PbKILD3TJl2EwCS2NFvOFqVu/+iS1b3fM9ZilFf+lVCO8RSKUetd6wXT3DNJN+5UiKrpQ1UA/67J/uhQv1EipudJn6c/yRKD+4aOPauWeEFNqZvaLay81OU256o3KUct+Zx50KL3u2pWXadLXKRfsoiHPBHS9AzcT53eHx14r1n4NT0mENgHN1qMGUFJBbaJb0GvODAJjHH89SvCs0fGmuQd/kOS538TJQJLTSrGM8flB8G88/X6x0A0qakVml3vA1jgaBCAKAlNy6ClQJkdtF+7k7W8cKupj1+Q5bc6EEM/IAgSkgQRywQDX7yivFk6EASVmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxRSNwTJiVNU/sNkdfqTJok2Wf9CF8PyX1ph712TswU=;
 b=zZsYLufiafxUZLvg8K61ncO684FbdBKhuto5uRSvJAOqG0c2dwB2+1YivBX95GCvsbiSib6nL0EkAOz32XDs7HZi1hRJ1LH43jirIgKdLW0P4hwVL1PFLKoebN7oAOSrQT0YAyZ/+dV+wdD3zv7RSOQydU8QjdtvSTsf8i4qpJE=
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 09:52:44 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::72) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 09:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 09:52:43 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 04:52:37 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <ananth.narayan@amd.com>,
	<gautham.shenoy@amd.com>, <linux-perf-users@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sandipan.das@amd.com>, <alexander.shishkin@linux.intel.com>,
	<irogers@google.com>, <gustavoars@kernel.org>, <kprateek.nayak@amd.com>,
	<ravi.bangoria@amd.com>, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH 2/2] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Thu, 2 May 2024 15:21:15 +0530
Message-ID: <20240502095115.177713-3-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
References: <20240502095115.177713-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 121484b4-eb5c-4528-0ac6-08dc6a8d9d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wm8mXC1mtYTCPpXYDL6HKXMHrrmK/KLHmN7BAcOzC+GB1LLZbCdqWNMn20lC?=
 =?us-ascii?Q?RAwkM6acE5dA9Smk83egBVRejqwdn7fyObPMGK6Iaxksb8qXBxN0m/Socgzo?=
 =?us-ascii?Q?zfD8Pjm4tbrKMIzPjAASCeN2WQ1UykSrPaYkc9VYBnDnARgAr13NfiHImYsc?=
 =?us-ascii?Q?UIEuDsh4ocz3S+tX7WneRY9sXNnFsMqWroJmF3tDSlYsIqm5KnsHkJ8KKSSr?=
 =?us-ascii?Q?TavRKdLD++KzvhffynVXGflGy7MJSQOgqvAS3Kr3ytEzAxRdheuoqpoeo093?=
 =?us-ascii?Q?r7P1Ohg7SHsTgfIA5cI7opwpcFtcPazp5gMlXu0uUWDz35sa9404LpRV6ZG9?=
 =?us-ascii?Q?ARSWnFdQniSRnRilOEgg6OnwcsBijd15Hiz5ZUbZc75ietJeO/WkZ752befd?=
 =?us-ascii?Q?omXjzNET1OjbtgMRhf6LokAmvuoDIT/cq1K50xVl0ULAyIckeUMePzCPNrDz?=
 =?us-ascii?Q?PiP9urVSZ8gjwYmlpWnNHCgOIMk/zJDwthcWIp4kz9m48cYZ67939ftTR4nA?=
 =?us-ascii?Q?1TgbqLRcC8efdmvoABUYbPCVmJBcFWlZ774vtVrusG7kdPRwyoFtqYlZpJtD?=
 =?us-ascii?Q?sx54JfxTG5tEkrueSBSaaacakJ+yoNeseS34GQ2Bp0yfikH+qnF3KNTqnofK?=
 =?us-ascii?Q?UEtH6q5LedRopn65VVi8eyhkD/hXtpHybquY8uF+RTPf0CHkBzFZ0VKd5s3d?=
 =?us-ascii?Q?SAadv2UHLAa1we6u290twR1HISznueSwJV486BEh9Fa+J3IV9qYRCWACbHpM?=
 =?us-ascii?Q?8MquvRtCxNWEo1d4yB9bB80/AhhdM+YVeSMtOR6S+UG7mbyRbdX7n1J2PLzF?=
 =?us-ascii?Q?ipqG7Nf8wmiX7/J7aDuqYaLf/PBQ2ti/KaGRUgPOThC5bacSylhlCXRCTqaX?=
 =?us-ascii?Q?REquj7BMkR1T3hyS9THlIFw8fxLG3ce7R2ut+cQYOpoqr8IRhhvc//TXN9MI?=
 =?us-ascii?Q?QEBH4vfjBO9VsHf5ow9BihqjtM0+Kn6dlF9S2JiUPI9pFrhDB45GNDZyI5b7?=
 =?us-ascii?Q?ZZrwxmMow2mtC3QENknNRjgD649/et8Y2tPuYD3XarAHGt04vKk0Hby7NjXE?=
 =?us-ascii?Q?SEyu20MR6Pq0PMSW8brg6eldoL2MGhjOLzYr7Xj/D1CGTQ8cVKwRp+96hyG9?=
 =?us-ascii?Q?N94x2Fv3a5WNWy17sr0nFDJmWz/KQndxIBsPrAa67/UDj2mttWCigeQnhsfc?=
 =?us-ascii?Q?L1+4FnAFq1XcQe1B1mbIM1DRTIsk25suRZULUzfXwh6oaGS6SLbVzM2FEnaS?=
 =?us-ascii?Q?QjRk0txzOHw1MnGP+yPMOLTWE7zeQ8EZYD4KT8HXhPBvZ8hPwuO9iN2WH+on?=
 =?us-ascii?Q?3fJ9hlj2syQ0r2VQowPi7Hdt9eWd/1YS7mZXlYtSNZwn8TBZ5UAp5hl6NM0Q?=
 =?us-ascii?Q?eYxX50Mb1tV8fMUxgXvZke+QswsB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:52:43.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121484b4-eb5c-4528-0ac6-08dc6a8d9d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

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
+static inline cpumask_t *get_rapl_pmu_cpumask(int cpu)
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
+	cpumask_t *cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -551,7 +568,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -564,6 +581,8 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	cpumask_t *cpumask = get_rapl_pmu_cpumask(cpu);
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
+	target = cpumask_any_and(&rapl_cpu_mask, cpumask);
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


