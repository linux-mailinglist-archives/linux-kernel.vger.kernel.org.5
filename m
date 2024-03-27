Return-Path: <linux-kernel+bounces-121587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9052088EA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436B6286ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEE1130A43;
	Wed, 27 Mar 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tZ0PZlXl"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF712FB3F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555392; cv=fail; b=rTAlkYs2nLlLQpjBCU8DdALuoQMrZNsps2BiPvLtCdt50l7yg6i+Fyr7wsULYs0LDSp2dRWo/89zpv5pgOT0ACF+K1rMHUVHXRNrYB/9hyMBNJGxRlTcfZ+Kt7O60X3M8MBK7B/wWcX9X/mFblYoiE2Nz7juLUnqjNWYfT6WWK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555392; c=relaxed/simple;
	bh=rWcnmNxdSuIWB7RDTOgF8JwEsPaXMpNpJNDDHc8J6/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUWl/P4T/cBdh8E0k6pocBbyuA2E6BLsl2R1CDalUCcG0/GZp42HmCVob0oSLcpwNsh8Mlw0HnkMeKYezQZ+3Db8cjIkD22O2WzxD+6RWO/BisJtVvlbz43tNZVT4D9YBZeTnrnKzs+1QYEWChmVXGFAX0SebBzuCX1s/4N4I74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tZ0PZlXl; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcNaBmyjFDboQEOLiQaHNvqeUIKErtyGaKugJAXbyXKU68F0sC92gHy0rptnC2TKcaekgUNWQLAwyQgr94Oxrll6TbihytKi0LrAFPCVjUPu5y07CpMtajzHjDqxBabWKqZmeQA8fEi7ZQmH1JEjGxiLux37JT/7pfjDSBZSRGe0smrUDmzwyLBqNDc5e+U2XnUIhFqrqOMCpd9y6j7eqUY4jmiF1imhiG/XY7xwD25jfQgWrag9W4bHQVt1bOUsTY9EaOTrZqdfG600F10PqCOHjD2veJGzbLliAXw6vSsV6ykwmI0SE2sc9D4ch/NwLIw0+LwIWQTdJf3xaXau0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AUXEFoq/QmHSSeo/GLYanz16736yol9UJ6K9AoaAGA=;
 b=mLc9DFKjrlluCYRjvw+uymZ1xMovkfrQQSLYgzsNa70VhlmRf470xNrIrCLkhJhdPncQSe8CEvkI3/Qd8ZwAFVbZWWmv0agNwIT3ORI2obKtJqPYOJhRnBtxXeBIv7awUWS0KzFoW55X5uWCLTjOHr4rPURCe5QD69zE+ZbV0RRszx2ezefM8cOfVT0FNhSjCA4XLGzf/6GLzcatPnT4hzVQaM4VD99SO/EJbdOrbqxZmI/9nZcD8LrkXNh4FP6idWaow6m0w3NuBhWmNiIXCD4bSQ+wzstkqWw+Uy9f+c24vVKSALKEwyEPwpyB9kEaAA3YqkbxuXcDQMz1Q8sK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUXEFoq/QmHSSeo/GLYanz16736yol9UJ6K9AoaAGA=;
 b=tZ0PZlXlalmlTYtbpsOAGtD2hYNYxWI84Q8hBsr+R3nhlUxgFiHbzcTsLj+A58ITmgrNkAKil+tbRmTDN02ZC4XsvyiewPF8h5sbvTSESOTnEuzXkUckLEGMgXrGWfT1KZY+gh79JizTeOvqEycX9ichTF7aSyJg0xis6fkjQgU=
Received: from BN8PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:d4::33)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 16:03:07 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::8) by BN8PR04CA0059.outlook.office365.com
 (2603:10b6:408:d4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 16:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 16:03:06 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 11:03:02 -0500
From: Bharata B Rao <bharata@amd.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <mgorman@techsingularity.net>,
	<raghavendra.kt@amd.com>, <ying.huang@intel.com>,
	<dave.hansen@linux.intel.com>, <hannes@cmpxchg.org>, Bharata B Rao
	<bharata@amd.com>
Subject: [RFC PATCH 1/2] sched/numa: Fault count based NUMA hint fault latency
Date: Wed, 27 Mar 2024 21:32:36 +0530
Message-ID: <20240327160237.2355-2-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327160237.2355-1-bharata@amd.com>
References: <20240327160237.2355-1-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2827f9d1-2fc9-4dae-f3e2-08dc4e776449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ehGtlpiB3Err3B7iveBbR0QE4YwYn9Kr1YsgjLKbh5Ir1LM9mUZ1WxC1sszw5c0UolEDNtLF1jPlSK6FUOVs4Q08VGyisCfdPZ+lkF8FBmBBqtNEpPPdHCXYFzvNA64L4JzkUxK3NP3wn0JABUK192GTmSdZH9Uhe2dtwHwQGoxSZDNwVkJsidO9Rpkwe7lzHinTju7vXfOUZJ91ZMUhjho28xtL0O22ZIj/7tx4zEYCDnSA0tXPNHPxk02KgXaO4uJjstZQFvn61Wk1r4vlqMksJ9/7xk0Zk4dbRoZGPuE7UTGLxZ1SMJbxdqZH+vsu3Cpk5oVaQZBL9LV6jmoRP92TVGRb3DHZ/4220xaf/wWgCwMn71tLYRktKcjBZY29pz+JMEzRl2a/kxhjFDZmBWpBOHMUJkCCuowyiwInxnyhpjayp2bexmm3N6DlGEm7acrhgTKQ0fiE0zYvCTH7IGTZxz8IEZN5Lzb86O11FJ1L59YyBKjQE+HSYpMUf82fTRB4f80nuGTmh5z5Ol4AHTfXD7lwZrXXmv/FZy/2qDd/3hNGUI5+HusTA9ESm1px541owhAAIHAPFhGZ80OlPrTnMHzc42RkuwHswuH1XbrMrQyjuEHTBXMoJhpXuQXHSlTqtT3y+kQCK5rOlPVpM7E2QwLnHkzpaCRJGz92KU9nfzub6/GMqNuIXRBXYoeesDxb04HqCxTHW7XyvMZehj2Up84Y28H6Bc0b52z0WMXWUlej0/5U3yafAAaaPG6m
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:03:06.9940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2827f9d1-2fc9-4dae-f3e2-08dc4e776449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

For memory tiering mode, the hint fault latency determines
if the page is considered hot enough to be promoted. This
latency value depends on absolute time and is the difference
between the scanning time and the fault time. The default
value of the threshold used to categorize the page as hot
is 1s.

When the address space is huge, pages may not be accessed
right after they are scanned. Hence the hint fault latency
is found to be, most of the times, way beyond the current
threshold thereby resulting in a very low number of page
promotions.

To address this problem, convert the absolute time based hint
fault latency in to a relative metric based. Use the number
of hint faults that have occurred between the scan time and
the page's fault time as the threshold.

TODO: The existing threshold adjustment logic, which is based
on time based hint fault latency has been removed for now.

Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/mm.h       | 23 ++++---------
 include/linux/mm_types.h |  3 ++
 kernel/sched/debug.c     |  2 +-
 kernel/sched/fair.c      | 73 +++++++++++-----------------------------
 kernel/sched/sched.h     |  1 +
 mm/huge_memory.c         |  3 +-
 mm/memory.c              |  2 ++
 mm/mprotect.c            |  5 +--
 8 files changed, 37 insertions(+), 75 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..cb1e79f2920b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1656,17 +1656,7 @@ static inline int folio_nid(const struct folio *folio)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
-/* page access time bits needs to hold at least 4 seconds */
-#define PAGE_ACCESS_TIME_MIN_BITS	12
-#if LAST_CPUPID_SHIFT < PAGE_ACCESS_TIME_MIN_BITS
-#define PAGE_ACCESS_TIME_BUCKETS				\
-	(PAGE_ACCESS_TIME_MIN_BITS - LAST_CPUPID_SHIFT)
-#else
-#define PAGE_ACCESS_TIME_BUCKETS	0
-#endif
-
-#define PAGE_ACCESS_TIME_MASK				\
-	(LAST_CPUPID_MASK << PAGE_ACCESS_TIME_BUCKETS)
+#define PAGE_FAULT_COUNT_BUCKETS	16
 
 static inline int cpu_pid_to_cpupid(int cpu, int pid)
 {
@@ -1732,13 +1722,12 @@ static inline void page_cpupid_reset_last(struct page *page)
 }
 #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
 
-static inline int folio_xchg_access_time(struct folio *folio, int time)
+static inline int folio_xchg_fault_count(struct folio *folio, int count)
 {
-	int last_time;
+	int last_count;
 
-	last_time = folio_xchg_last_cpupid(folio,
-					   time >> PAGE_ACCESS_TIME_BUCKETS);
-	return last_time << PAGE_ACCESS_TIME_BUCKETS;
+	last_count = folio_xchg_last_cpupid(folio, count >> PAGE_FAULT_COUNT_BUCKETS);
+	return last_count << PAGE_FAULT_COUNT_BUCKETS;
 }
 
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
@@ -1756,7 +1745,7 @@ static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 	return folio_nid(folio); /* XXX */
 }
 
-static inline int folio_xchg_access_time(struct folio *folio, int time)
+static inline int folio_xchg_fault_count(struct folio *folio, int time)
 {
 	return 0;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..280043a08f25 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -922,6 +922,9 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads remapping PTEs. */
 		int numa_scan_seq;
+
+		/* Accummulated number of hint faults */
+		atomic_t hint_faults;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..cd6367cef6cb 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -369,7 +369,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
-	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
+	debugfs_create_u32("fault_count_threshold", 0644, numa, &sysctl_numa_balancing_fault_count_threshold);
 #endif
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..977584683f5f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1364,8 +1364,11 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
-/* The page with hint page fault latency < threshold in ms is considered hot */
-unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
+/*
+ * Page is considered hot if the number of hint faults between scan time and
+ * the page's fault time is less than this threshold.
+ */
+unsigned int sysctl_numa_balancing_fault_count_threshold = 1000000;
 
 struct numa_group {
 	refcount_t refcount;
@@ -1750,25 +1753,20 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
 }
 
 /*
- * For memory tiering mode, when page tables are scanned, the scan
- * time will be recorded in struct page in addition to make page
- * PROT_NONE for slow memory page.  So when the page is accessed, in
- * hint page fault handler, the hint page fault latency is calculated
- * via,
+ * For memory tiering mode, when page tables are scanned, the current
+ * hint fault count will be recorded in struct page in addition to
+ * make page PROT_NONE for slow memory page.  So when the page is
+ * accessed, in hint page fault handler, the hint page fault latency is
+ * calculated via,
  *
- *	hint page fault latency = hint page fault time - scan time
+ * hint page fault latency = current hint fault count - fault count at scan time
  *
  * The smaller the hint page fault latency, the higher the possibility
  * for the page to be hot.
  */
-static int numa_hint_fault_latency(struct folio *folio)
+static inline int numa_hint_fault_latency(struct folio *folio, int count)
 {
-	int last_time, time;
-
-	time = jiffies_to_msecs(jiffies);
-	last_time = folio_xchg_access_time(folio, time);
-
-	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
+	return count - folio_xchg_fault_count(folio, count);
 }
 
 /*
@@ -1794,35 +1792,6 @@ static bool numa_promotion_rate_limit(struct pglist_data *pgdat,
 	return false;
 }
 
-#define NUMA_MIGRATION_ADJUST_STEPS	16
-
-static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
-					    unsigned long rate_limit,
-					    unsigned int ref_th)
-{
-	unsigned int now, start, th_period, unit_th, th;
-	unsigned long nr_cand, ref_cand, diff_cand;
-
-	now = jiffies_to_msecs(jiffies);
-	th_period = sysctl_numa_balancing_scan_period_max;
-	start = pgdat->nbp_th_start;
-	if (now - start > th_period &&
-	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
-		ref_cand = rate_limit *
-			sysctl_numa_balancing_scan_period_max / MSEC_PER_SEC;
-		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
-		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
-		unit_th = ref_th * 2 / NUMA_MIGRATION_ADJUST_STEPS;
-		th = pgdat->nbp_threshold ? : ref_th;
-		if (diff_cand > ref_cand * 11 / 10)
-			th = max(th - unit_th, unit_th);
-		else if (diff_cand < ref_cand * 9 / 10)
-			th = min(th + unit_th, ref_th * 2);
-		pgdat->nbp_th_nr_cand = nr_cand;
-		pgdat->nbp_threshold = th;
-	}
-}
-
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu)
 {
@@ -1838,7 +1807,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	    !node_is_toptier(src_nid)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
-		unsigned int latency, th, def_th;
+		unsigned int latency;
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat)) {
@@ -1847,16 +1816,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 			return true;
 		}
 
-		def_th = sysctl_numa_balancing_hot_threshold;
-		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
-			(20 - PAGE_SHIFT);
-		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
-
-		th = pgdat->nbp_threshold ? : def_th;
-		latency = numa_hint_fault_latency(folio);
-		if (latency >= th)
+		latency = numa_hint_fault_latency(folio,
+						  atomic_read(&p->mm->hint_faults));
+		if (latency >= sysctl_numa_balancing_fault_count_threshold)
 			return false;
 
+		rate_limit = sysctl_numa_balancing_promote_rate_limit << \
+			(20 - PAGE_SHIFT);
 		return !numa_promotion_rate_limit(pgdat, rate_limit,
 						  folio_nr_pages(folio));
 	}
@@ -3444,6 +3410,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 			mm->numa_scan_seq = 0;
 		}
+		atomic_set(&mm->hint_faults, 0);
 	}
 	p->node_stamp			= 0;
 	p->numa_scan_seq		= mm ? mm->numa_scan_seq : 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..f975d643fa6a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2564,6 +2564,7 @@ extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
+extern unsigned int sysctl_numa_balancing_fault_count_threshold;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..7e62c3c2bbcb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2101,8 +2101,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 		    !toptier)
-			folio_xchg_access_time(folio,
-					       jiffies_to_msecs(jiffies));
+			folio_xchg_fault_count(folio, atomic_read(&mm->hint_faults));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/memory.c b/mm/memory.c
index 0bfc8b007c01..43a6358e6d31 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4927,6 +4927,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte_t pte, old_pte;
 	int flags = 0;
 
+	atomic_inc(&vma->vm_mm->hint_faults);
+
 	/*
 	 * The "pte" at this point cannot be used safely without
 	 * validation through pte_unmap_same(). It's of NUMA type but
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 81991102f785..30118fd492f4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -159,8 +159,9 @@ static long change_pte_range(struct mmu_gather *tlb,
 					continue;
 				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 				    !toptier)
-					folio_xchg_access_time(folio,
-						jiffies_to_msecs(jiffies));
+					folio_xchg_fault_count(folio,
+							atomic_read(&vma->vm_mm->hint_faults));
+
 			}
 
 			oldpte = ptep_modify_prot_start(vma, addr, pte);
-- 
2.25.1


