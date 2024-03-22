Return-Path: <linux-kernel+bounces-111562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996D886DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6FB2814E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3454D5A5;
	Fri, 22 Mar 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NZ8yxvnm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41F4CB35
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114946; cv=fail; b=pet99gjTZPjlrhICP46vTtW+Yv2duXGq8yaWbBmBM+AWWGjBGdvsg7KnJBK7Bl3soAJkFFszBMjkXX2pggEBFkbwIbXVz5UqnqCmYEE1nXGMYSKnEBHmJhI/SPs15HH5LZqQOgyqtbhfSUk10PJgz2SsvQSv3pFcu/PDEF8mbO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114946; c=relaxed/simple;
	bh=+RNCTd8pQaeDEgfgTdAYkgyppQfD0r8pO5TZ0hrjF7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn5BtxtNnpMUX/lnS7+RiK+Q6vAUh1RRQXlabaWBMd3LaFfxugHkdyE3++dt2y/ZYDxSAGNOjcSoZpGDZ3/aGbn4HvCnUQ1Dd2OAPegdxBOBzZKPU4OL9EB8MEqY5plYS4m1Bq0KCNFkiDaBy7Cc0NNgvvbWnM5+KMj3oEbC0WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NZ8yxvnm; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr86tSXdm17UB5byk4JvKOZyk5nwfmU/Jjuj5z9vxexUkYSWdNzc54z71WDYkgbehHSI3N3yAK0EuM164KYoAMwTkpIvBkpPRC6raAr6kgKFfdL+exzQGjiP55qsLyx2+E4yHyEERIApJDvvzyuit8hb4wPOaJrWHJNq+FXQWz5PghhSPHGrfNi6E0+Dmg5U1OBkQDNxRtduorslXS7OSmkpmxTakLW5xVbUXdQomk7zcLwFJWou6TXbdb4rfMO5VJGNUigBj7eRTY11M28qodQKklZUMi0dSEwM1UYiiWlg/UjveHkb+J6xG2RB7uJHPLZjT+Id6Cb1iRWbWAqlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh5Zt00A4UzSofpCIr7N+JpcQnxoTSP2zOvPLzf+H7g=;
 b=Qz7Lt3phTvudjwNuA0Po88xa6qzoAzG8pQFEIOHStjjLx54G98GQUwpBUB8RdXfdS6R8WO99tGD9Ov/3knCliIa++kiXSG4U1pAOKOdzpz+7h3ile82euAmolSmy5afYJzUCeysbC/xojuskY1kotV9fOYn2bLMV0qAixI+iZFSEY47OPbT5SBC2Y8g/exzJWxPGFPVWJnIixnPJ3gpyzcc6Y9ixEItySK088aubq/kuL2Pr9OD6nbpUAjXya9IY5Lw/h2LIl8TDQqIopGb8ls3dd0wvUORP3D/vA0Va+T58klBN0LZ+rwtF6WIgB1H0pBiNLBELlKX3PGpCWU6tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh5Zt00A4UzSofpCIr7N+JpcQnxoTSP2zOvPLzf+H7g=;
 b=NZ8yxvnmJ4BrIiJQVnOoloMsgglQCxJvK1sePdAfOJViAuKo1qS/3iB/Lx0Rx9Vx+MNAuV59/fuWIYMMpCsS5w+FXno+wuf8/7PV5takNhCGM9b0Bs/UKRJjnbfzHLoXuKGeaseHxauZxn+iFe2RzwFUr0298+Mwm+/IVqMrEwY=
Received: from CH5P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::28)
 by CH3PR12MB8710.namprd12.prod.outlook.com (2603:10b6:610:173::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 13:42:20 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d2) by CH5P221CA0010.outlook.office365.com
 (2603:10b6:610:1f2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 13:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 13:42:20 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 08:42:14 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"Mel Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Bharata B Rao <bharata@amd.com>, Johannes Weiner <jweiner@fb.com>, "kernel
 test robot" <oliver.sang@intel.com>, Raghavendra K T
	<raghavendra.kt@amd.com>, Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song
	<muchun.song@linux.dev>
Subject: [RFC PATCH 3 1/1] sched/numa: Convert 256MB VMA scan limit notion
Date: Fri, 22 Mar 2024 19:11:14 +0530
Message-ID: <88d16815ef4cc2b6c08b4bb713b25421b5589bc7.1710829750.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1710829750.git.raghavendra.kt@amd.com>
References: <cover.1710829750.git.raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CH3PR12MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9ea2fd-4581-4047-a387-08dc4a75e5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EskT9wZtOFKidGtrvCT+aD2amW0blQN5boDJcCgClXGFwoX6fHURWTUBqGlTdkoRAVaDglOx1UHLTEtjp3+Dej4Fa9ph5Q9gFugqiRHav4NBmv5/o5N0trVG+FjabjDVOCEY3chuKEJYb0Uu2w6csx4/yBOxvaEtJHnNlfvPOjJzO5hZYALCSNWZv0gETthH1efWUNTvyluKY4+Opy5Ok09rGygY2E6niN8gnXEBqRXBB+QJQQ+3/KNlgyoTUT7N5sz78e1/c+hpRgHTHClpZcbTki5UsBkFaZbAX+Wuh710bcm9fSNo2PJ/FaerCX8uC6zEUpH+GJJf1LmTNWKsHCxMXdBd/dtPm6+o8ABtWyuM/mzlRta6V1so8WdKBibjQDmhnIbIziBC+gkqzhwuU6upT5HAt9TgcYv43CWozQfXbtDFt8VgVTqDCXY97VpKhhdnvHhqmH5uAlKwBeeuBbl22pT8oTjo+gw8q4stYZKfhqHpHZibNQ6FoQF9McTPQfnbScnWZJV8JEkXHqpGJrMi3Lu76UAZS2Qqdwq+Yq5TOdO10Gbxv8MAo1VOsbbEQswZYBgtzWtp04GfOiwkyH37x6rVkS8RJCREaHPmEU2d8d4PkYfM6nIy6CyQKjI5zQ78INaoUT1NpnpEIKTbVHFMmEZoaDZXwNNJ+Kl9QyghJjAlCidSbeFL0TY7VBCg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 13:42:20.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9ea2fd-4581-4047-a387-08dc4a75e5a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8710

Currently VMA scanning to introduce PROT_NONE faults to track
tasks's page access pattern is limited to 256MB. This limit works
well for 4K pages. However in cases like VMAs with hugepages, there
is an opportunity to scale up.

One idea is to convert 256MB scanning notion to 64K 4K PTE scanning.
Thus when a 2MB huge page is scanned, we account only 1PMD scan.

However, CPUs could spend more time in migrations than optimally
needed in some cases (mostly microbenchmarks).

Benchmarks with hugepages/THP=on such as hashjoin have shown
good benefit.

TODO:
 - Introduce ratelimiting logic similar to one in CXL case.
 - Tune scan rate to dynamically adopt to rate of migrations.

Inspired by Mels suggestion [1],
"Scan based on page table updates, not address ranges to mitigate
   problems with THP vs base page updates"

[1] Link: https://lore.kernel.org/lkml/20220128052851.17162-1-bharata@amd.com/T/#m38f6bf64f484eb98562f64ed02be86f2768d6fff

Suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/hugetlb.h |  3 +-
 include/linux/mm.h      | 16 +++++++-
 kernel/sched/fair.c     | 15 ++++---
 mm/hugetlb.c            |  9 +++++
 mm/mempolicy.c          | 11 +++++-
 mm/mprotect.c           | 87 +++++++++++++++++++++++++++++++++--------
 6 files changed, 115 insertions(+), 26 deletions(-)

Note: I think we can do better without passing a struct to get
the detail of how much memory is covered with current VMA scanning.

Currently change_prot_numa returns how many pages succesfully scanned
But we do not get to know how much memory range is covered in the scan.

Ideas??

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c1ee640d87b1..eb6987148e44 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -278,7 +278,8 @@ int pud_huge(pud_t pud);
 long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
-
+long hugetllb_effective_scanned_ptes(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end);
 bool is_hugetlb_entry_migration(pte_t pte);
 bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..8c5490db007d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -549,6 +549,10 @@ struct vm_fault {
 					 */
 };
 
+struct pte_info {
+	long nr_huge_pte;
+};
+
 /*
  * These are the virtual MM functions - opening of an area, closing and
  * unmapping it (needed to keep files on disk up-to-date etc), pointer
@@ -2547,8 +2551,15 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 extern long change_protection(struct mmu_gather *tlb,
+ 			      struct vm_area_struct *vma, unsigned long start,
+ 			      unsigned long end, unsigned long cp_flags);
+extern long change_protection_n(struct mmu_gather *tlb,
 			      struct vm_area_struct *vma, unsigned long start,
-			      unsigned long end, unsigned long cp_flags);
+			      unsigned long end, unsigned long cp_flags,
+			      struct pte_info *info);
+extern long effective_scanned_ptes(struct vm_area_struct *vma,
+				unsigned long start, unsigned long end,
+				struct pte_info *info);
 extern int mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	  struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	  unsigned long start, unsigned long end, unsigned long newflags);
@@ -3535,6 +3546,9 @@ void vma_set_file(struct vm_area_struct *vma, struct file *file);
 #ifdef CONFIG_NUMA_BALANCING
 unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end);
+unsigned long change_prot_numa_n(struct vm_area_struct *vma,
+			unsigned long start, unsigned long end,
+			struct pte_info *info);
 #endif
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..3646a0e14bd4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3200,8 +3200,9 @@ static void task_numa_work(struct callback_head *work)
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
-	long pages, virtpages;
+	long pages, virtpages, ptes_to_scan, e_scanned_ptes;
 	struct vma_iterator vmi;
+	struct pte_info info = {0};
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
 
@@ -3248,6 +3249,8 @@ static void task_numa_work(struct callback_head *work)
 
 	pages = sysctl_numa_balancing_scan_size;
 	pages <<= 20 - PAGE_SHIFT; /* MB in pages */
+	/* Consider total number of PTEs to scan rather than sticking to 256MB */
+	ptes_to_scan = pages;
 	virtpages = pages * 8;	   /* Scan up to this much virtual space */
 	if (!pages)
 		return;
@@ -3366,7 +3369,7 @@ static void task_numa_work(struct callback_head *work)
 			start = max(start, vma->vm_start);
 			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
 			end = min(end, vma->vm_end);
-			nr_pte_updates = change_prot_numa(vma, start, end);
+			nr_pte_updates = change_prot_numa_n(vma, start, end, &info);
 
 			/*
 			 * Try to scan sysctl_numa_balancing_size worth of
@@ -3376,12 +3379,14 @@ static void task_numa_work(struct callback_head *work)
 			 * PTEs, scan up to virtpages, to skip through those
 			 * areas faster.
 			 */
+			e_scanned_ptes -= effective_scanned_ptes(vma, start, end, &info);
+
 			if (nr_pte_updates)
-				pages -= (end - start) >> PAGE_SHIFT;
-			virtpages -= (end - start) >> PAGE_SHIFT;
+				ptes_to_scan -= e_scanned_ptes;
 
+			virtpages -= e_scanned_ptes;
 			start = end;
-			if (pages <= 0 || virtpages <= 0)
+			if (ptes_to_scan <= 0 || virtpages <= 0)
 				goto out;
 
 			cond_resched();
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..a5bb13457398 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6996,6 +6996,15 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	return pages > 0 ? (pages << h->order) : pages;
 }
 
+long hugetllb_effective_scanned_ptes(struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	return (end - start) >> (PAGE_SHIFT + h->order);
+}
+
+
 /* Return true if reservation was successful, false otherwise.  */
 bool hugetlb_reserve_pages(struct inode *inode,
 					long from, long to,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..103eca1858e7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -631,8 +631,9 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
  * an architecture makes a different choice, it will need further
  * changes to the core.
  */
-unsigned long change_prot_numa(struct vm_area_struct *vma,
-			unsigned long addr, unsigned long end)
+unsigned long change_prot_numa_n(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long end,
+			struct pte_info *info)
 {
 	struct mmu_gather tlb;
 	long nr_updated;
@@ -647,6 +648,12 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 	return nr_updated;
 }
+
+unsigned long change_prot_numa(struct vm_area_struct *vma,
+			unsigned long addr, unsigned long end)
+{
+	return change_prot_numa_n(vma, addr, end, NULL);
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 81991102f785..8e43506705e0 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -352,9 +352,10 @@ pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
 		err;							\
 	})
 
-static inline long change_pmd_range(struct mmu_gather *tlb,
+static inline long change_pmd_range_n(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
-		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags,
+		struct pte_info *info)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -431,14 +432,25 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 	if (range.start)
 		mmu_notifier_invalidate_range_end(&range);
 
-	if (nr_huge_updates)
+	if (nr_huge_updates) {
 		count_vm_numa_events(NUMA_HUGE_PTE_UPDATES, nr_huge_updates);
+		if (info)
+			info->nr_huge_pte = nr_huge_updates;
+		}
 	return pages;
 }
 
-static inline long change_pud_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
+static inline long change_pmd_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
+{
+	return change_pmd_range_n(tlb, vma, pud, addr, end, newprot, cp_flags, NULL);
+}
+
+static inline long change_pud_range_n(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags,
+		struct pte_info *info)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -452,17 +464,26 @@ static inline long change_pud_range(struct mmu_gather *tlb,
 			return ret;
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		pages += change_pmd_range(tlb, vma, pud, addr, next, newprot,
-					  cp_flags);
+		pages += change_pmd_range_n(tlb, vma, pud, addr, next, newprot,
+					  cp_flags, info);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
 }
 
-static inline long change_p4d_range(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
+static inline long change_pud_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
 {
+
+	return change_pud_range_n(tlb, vma, p4d, addr, end, newprot, cp_flags, NULL);
+}
+
+static inline long change_p4d_range_n(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags,
+		struct pte_info *info)
+{
 	p4d_t *p4d;
 	unsigned long next;
 	long pages = 0, ret;
@@ -475,16 +496,24 @@ static inline long change_p4d_range(struct mmu_gather *tlb,
 			return ret;
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		pages += change_pud_range(tlb, vma, p4d, addr, next, newprot,
-					  cp_flags);
+		pages += change_pud_range_n(tlb, vma, p4d, addr, next, newprot,
+					  cp_flags, info);
 	} while (p4d++, addr = next, addr != end);
 
 	return pages;
 }
 
+static inline long change_p4d_range(struct mmu_gather *tlb,
+		struct vm_area_struct *vma, pgd_t *pgd, unsigned long addr,
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
+{
+	return change_p4d_range_n(tlb, vma, pgd, addr, end, newprot, cp_flags, NULL);
+}
+
 static long change_protection_range(struct mmu_gather *tlb,
 		struct vm_area_struct *vma, unsigned long addr,
-		unsigned long end, pgprot_t newprot, unsigned long cp_flags)
+		unsigned long end, pgprot_t newprot, unsigned long cp_flags,
+		struct pte_info *info)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -503,8 +532,8 @@ static long change_protection_range(struct mmu_gather *tlb,
 		}
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		pages += change_p4d_range(tlb, vma, pgd, addr, next, newprot,
-					  cp_flags);
+		pages += change_p4d_range_n(tlb, vma, pgd, addr, next, newprot,
+					  cp_flags, info);
 	} while (pgd++, addr = next, addr != end);
 
 	tlb_end_vma(tlb, vma);
@@ -512,9 +541,10 @@ static long change_protection_range(struct mmu_gather *tlb,
 	return pages;
 }
 
-long change_protection(struct mmu_gather *tlb,
+long change_protection_n(struct mmu_gather *tlb,
 		       struct vm_area_struct *vma, unsigned long start,
-		       unsigned long end, unsigned long cp_flags)
+		       unsigned long end, unsigned long cp_flags,
+			struct pte_info *info)
 {
 	pgprot_t newprot = vma->vm_page_prot;
 	long pages;
@@ -538,11 +568,34 @@ long change_protection(struct mmu_gather *tlb,
 						  cp_flags);
 	else
 		pages = change_protection_range(tlb, vma, start, end, newprot,
-						cp_flags);
+						cp_flags, info);
 
 	return pages;
 }
 
+long change_protection(struct mmu_gather *tlb,
+		       struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end, unsigned long cp_flags)
+{
+	return change_protection_n(tlb, vma, start, end, cp_flags, NULL);
+}
+
+long effective_scanned_ptes(struct vm_area_struct *vma, unsigned long start,
+		       unsigned long end, struct pte_info *info)
+{
+	long ptes = (end - start) >> PAGE_SHIFT;
+
+	if (is_vm_hugetlb_page(vma))
+		return hugetllb_effective_scanned_ptes(vma, start, end);
+
+	if (info && info->nr_huge_pte) {
+		ptes -= info->nr_huge_pte / HPAGE_PMD_SIZE;
+		ptes += info->nr_huge_pte;
+	}
+
+	return ptes;
+}
+
 static int prot_none_pte_entry(pte_t *pte, unsigned long addr,
 			       unsigned long next, struct mm_walk *walk)
 {
-- 
2.34.1


