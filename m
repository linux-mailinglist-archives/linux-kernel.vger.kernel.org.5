Return-Path: <linux-kernel+bounces-111560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C014886DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FED31C2306A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCBE46546;
	Fri, 22 Mar 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Thg7yh9E"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D24AEC3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114939; cv=fail; b=cTxQ+VEkS9INeY4kemPFDGKs0zQuEa3JA9/KznpwVpPzCGxR7BLrdeDwf8+J35YYXgLIboy9yGbZgolr+l2cBAqAxPML25rAI3z5dfE0TmkpsSwdNVGieIU25K4WbkdEH9w7AeVzWwQlXPtI6DiLcVCPCpAHcrIM1goCw3H08C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114939; c=relaxed/simple;
	bh=W1HjeTfyhEaRveDpA9omGl/Lss89PQkvrF0QYtjkslU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W19WBqkZAKzryzj6w2MObY5SgcHQJrzw1aZOI0KnPuFM5+IyhXuOjYbFXN+ehtINIF4m8QNjPHPvpT6mhwyE9WGgMhSJoqvS8yteDrRwsyehfxTH8tWRyWNPOutKUUfVdy8DzlfbYo909f9+wny97xDAW4RvOcxvAUdHnrNNIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Thg7yh9E; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIwxtDDmcBUdlSxnU3OFshgcOls3fMT8iY4ce3FFvuBPT7mGWvvptLz2TUBvApg4/GxViuYVBroqQUMJWlpvVDuB7r56FWT3xiy94VJsIu8fth+iiRGadwMdGrYHoxmh2gT5RZtQxZANkbD+XaYeEh8OJFwrZ6O93aftIOC9g9/yvTzJbQ8nh/ffyilt109+UiX6d/14k7V8rM2Vt4yG2sqsIwM6w25Jzg+zyAYZJk7JbAtFJWQA5XzwkjZpfWGMhBlYCmIZ6JZ1EYI8ut/nsDSNtgUDW/iLhRWkOH8wpn/DfEYzCcJfyODXTXL16raAUO1TvyXn+OBowcfTC3Wz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yCrqzq9sHOsri1AJVcOxx4bjXkPZ1chVv/ajXAPZHs=;
 b=I1e1mEPDd12cOlPQ4nAYh2RsZTsZPMZDWctMHdDMsMRcLWdr1dhd27D9PhXjK8nZrYMSO0LSaYWkNgW1KMggu6QWhEMeyU1sNaLl6X0m7lN/A/bQ8MU+Bmo7Q87aI7x4jCqg5kfKCIVOfioBLdFJNR9UB3kXgTYjfpo3clxwWoY/6hNtKKlLCyAqU6fLI8sft60v4c6Bvq/jjDawvYg49bYL5vftDXCgxB4FubA+MpqP1sPRTTEDC22byzKkJSh1QmmZtchdbBrJ4blenf9srcnMKlVnqCx9iS9C8ZsZbzstu2f5YNKCVM9hYpc1mDdIOhNbZjI47nRBTnDkGNGpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yCrqzq9sHOsri1AJVcOxx4bjXkPZ1chVv/ajXAPZHs=;
 b=Thg7yh9EMtfRoNuUQVq4GsLy0o7ztMDbcf8YV/IjjqJiXucT8C71FIr8ZPB2HUICNy4ptPm8Cwt7FUKrVPL1K2M6ExYHDJHHe9BFN4EYXOM1mZXcbNvDWc67rrwwUxHpWQDTuLxMrp76321gXtwP8JLjnhGAwtDAg7EOo2POitY=
Received: from CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::25)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 13:42:14 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::b) by CH5P221CA0023.outlook.office365.com
 (2603:10b6:610:1f2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 13:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 13:42:13 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 08:42:05 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"Mel Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Bharata B Rao <bharata@amd.com>, Johannes Weiner <jweiner@fb.com>, "kernel
 test robot" <oliver.sang@intel.com>, Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH 1 1/1] sched/numa: Hot VMA and shared VMA optimization
Date: Fri, 22 Mar 2024 19:11:12 +0530
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a25b20d-b470-4229-5cfa-08dc4a75e1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Of+hS44OpIixN9Re06fwROfSf+A0Tt4VCvWKCrlv9rXrGDZbuB4JMBVRnJM59VYfyrVH4X3UaG1XV1mddgJuBnDO7UaC/8ZpLdSoJoh/zfYV0f+e8gq/kVz01vdPNRLMs8pKQDcy3eA12homIcMGQ2TyKM4m/SSlnIn8+7fs4SBvuesrGpRb7Bz4x1CpTv0NKTlWUbDydc49ljjiAlDxfqPA3fgz+3oKhWgkJ0KQijJagRJuyTLKfYSJxFObWKYiLZ4SD3uXYAPlLgluIpxh7i4Uzc4MIshq8aSwcfIhN0UQGIqKh4TH2uUfFnlPsQGP/A5ltOEIkHkuE1GCMsEaYg28mzDmWoGcpl6S7uXjE4svIL/q8NTw37vcXfSXdoZ6vAIDX7mlFLiS3Og1h7eC2vUA1j4Q4yyFQZsJa1k9WE/q9Gpe8CaGRGsP78cRBDqe2nxWCTVvtrul1N7c6K11eGFQVlUpHAQIRipAgiYhhooWXDcoePA/BZkAPHmoIfOwwgURKygRk6z2EOLZc7Jyy5hZrxaWQBE57cA7805JpEVrZvA0t1O2xTj6pOLPrfzP+aojgLSXuVP7L2kUscvnZUm3X8LKkmlnK72oOPwAu7Fl/jSlJ2mME/yVRl1hFszAlCtJZkjynIfI70Hxgr1yfzYzhp0bOcMySmVT9AcgxR1TgmLlcxOhVgi3lLGrIJJr3X33NnvRhXU5Py7JRGtEuNnP4H2bXpsjaaFz4NiXF2HXtc8O3sU5bnSvv3PSQ/u
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 13:42:13.4809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a25b20d-b470-4229-5cfa-08dc4a75e1b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

Optimizations are based on history of PIDs accessing VMA.

- Increase tasks' access history windows (PeterZ) from 2 to 4.
( This patch is from Peter Zijlstra <peterz@infradead.org>)

Idea: A task is allowed to scan a VMA if:
- VMA was very recently accessed as indicated by the latest
  access PIDs information (hot VMA).
- VMA is shared by more than 2 tasks. Here whole history of VMA's
access PIDs is considered using bitmap_weight().

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
I will split the patset and post if we find this pathset useful
going further. First patch is from PeterZ.

 include/linux/mm.h       | 12 ++++++---
 include/linux/mm_types.h | 11 +++++---
 kernel/sched/fair.c      | 58 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..1bf1df064b60 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1744,10 +1744,14 @@ static inline int folio_xchg_access_time(struct folio *folio, int time)
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 	unsigned int pid_bit;
-
-	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
-	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->pids_active[1])) {
-		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
+	unsigned long *pids, pid_idx;
+
+	if (vma->numab_state) {
+		pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
+		pid_idx = READ_ONCE(vma->numab_state->pids_active_idx);
+		pids = vma->numab_state->pids_active + pid_idx;
+		if (!test_bit(pid_bit, pids))
+			__set_bit(pid_bit, pids);
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..050ceef1e9d5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -574,6 +574,7 @@ struct vma_lock {
 	struct rw_semaphore lock;
 };
 
+#define NR_ACCESS_PID_HIST	4
 struct vma_numab_state {
 	/*
 	 * Initialised as time in 'jiffies' after which VMA
@@ -588,17 +589,21 @@ struct vma_numab_state {
 	 */
 	unsigned long pids_active_reset;
 
+	/* Points to current active PID tracking index. */
+	unsigned long pids_active_idx;
+
 	/*
 	 * Approximate tracking of PIDs that trapped a NUMA hinting
 	 * fault. May produce false positives due to hash collisions.
 	 *
-	 *   [0] Previous PID tracking
-	 *   [1] Current PID tracking
+	 *   [pids_active_idx - 1] Previous PID tracking
+	 *   [pids_active_idx] Current PID tracking
 	 *
+	 * Whole array is used in a rotating manner to track latest PIDs.
 	 * Window moves after next_pid_reset has expired approximately
 	 * every VMA_PID_RESET_PERIOD jiffies:
 	 */
-	unsigned long pids_active[2];
+	unsigned long pids_active[NR_ACCESS_PID_HIST];
 
 	/* MM scan sequence ID when scan first started after VMA creation */
 	int start_scan_seq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..ed329b2f4d53 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3157,9 +3157,44 @@ static void reset_ptenuma_scan(struct task_struct *p)
 	p->mm->numa_scan_offset = 0;
 }
 
+static inline bool vma_test_access_pid_history(struct vm_area_struct *vma)
+{
+	unsigned int i, pid_bit;
+	unsigned long pids = 0;
+
+	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
+
+	for (i = 0; i < NR_ACCESS_PID_HIST; i++)
+		pids  |= vma->numab_state->pids_active[i];
+
+	return test_bit(pid_bit, &pids);
+}
+
+static inline bool vma_accessed_recent(struct vm_area_struct *vma)
+{
+	unsigned long *pids, pid_idx;
+
+	pid_idx = vma->numab_state->pids_active_idx;
+	pids = vma->numab_state->pids_active + pid_idx;
+
+	return (bitmap_weight(pids, BITS_PER_LONG) >= 1);
+}
+
+#define SHARED_VMA_THRESH	3
+
+static inline bool vma_shared_access(struct vm_area_struct *vma)
+{
+	int i;
+	unsigned long pids = 0;
+
+	for (i = 0; i < NR_ACCESS_PID_HIST; i++)
+		pids  |= vma->numab_state->pids_active[i];
+
+	return (bitmap_weight(&pids, BITS_PER_LONG) >= SHARED_VMA_THRESH);
+}
+
 static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	unsigned long pids;
 	/*
 	 * Allow unconditional access first two times, so that all the (pages)
 	 * of VMAs get prot_none fault introduced irrespective of accesses.
@@ -3169,8 +3204,16 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
 		return true;
 
-	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
-	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
+	/* Check if the current task had historically accessed VMA. */
+	if (vma_test_access_pid_history(vma))
+		return true;
+
+	/* Check at least one task had accessed VMA recently. */
+	if (vma_accessed_recent(vma))
+		return true;
+
+	/* Check if VMA is shared by many tasks. */
+	if (vma_shared_access(vma))
 		return true;
 
 	/*
@@ -3202,6 +3245,7 @@ static void task_numa_work(struct callback_head *work)
 	unsigned long nr_pte_updates = 0;
 	long pages, virtpages;
 	struct vma_iterator vmi;
+	unsigned long pid_idx;
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
 
@@ -3341,8 +3385,12 @@ static void task_numa_work(struct callback_head *work)
 				time_after(jiffies, vma->numab_state->pids_active_reset)) {
 			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-			vma->numab_state->pids_active[0] = READ_ONCE(vma->numab_state->pids_active[1]);
-			vma->numab_state->pids_active[1] = 0;
+
+			pid_idx = vma->numab_state->pids_active_idx;
+			pid_idx = (pid_idx + 1) % NR_ACCESS_PID_HIST;
+
+			vma->numab_state->pids_active_idx = pid_idx;
+			vma->numab_state->pids_active[pid_idx] = 0;
 		}
 
 		/* Do not rescan VMAs twice within the same sequence. */
-- 
2.34.1


