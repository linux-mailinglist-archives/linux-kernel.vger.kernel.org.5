Return-Path: <linux-kernel+bounces-111561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F19886DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7161F2358E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FA44CE11;
	Fri, 22 Mar 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kz0+6BDG"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150546453
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114944; cv=fail; b=iu7OvJeVUEX3pLY2YJBk81+zY+Dgw2oCGm3GKryBhwCoQ5VRszLgkwTYGHmW9FS2zb7dqrQMzKVTZBLHzphQt+oxyH1LXeEUVUG7Wf1aPQ4/fIdkZNllkRsfLZcN9ItA+qQMwNVHnoEaaF/dRelLQZDTjcQM4Ef5NbgDRqaSdMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114944; c=relaxed/simple;
	bh=lLttpVyp9CNyC47TmjjvLuT2h3YWOVTqdFxRexQ321g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww2+QaDPvbJ6ERMdbgAIhqI2XDxODm9xJZE0WkMOVO+Iu2t4XLno+AVZReGspsWPEwpaAUofKiAumBKruFo2zJ5I0kMIXe9q0IPXFW5l43vByzBeI/W8PyDpcbojBVydCjnpqMZ+eCwktPz6mLfNhoTQjhSq24p/Btnr5GNQbXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kz0+6BDG; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsX2fPegotGGbr83I7aVzMeitXUU2jeLguIdpyReox/SBL4f27e7y03bdeh3EqaoOXX7UsoguorCceIvDHq1aC+XAs0LGf7ZTisqaAJJIN7UwSBWEDWdbmQd46TYdsAqRegHO1p8NRtCeZ02lTrC6LKlhzggCXpccg3efUni3Hqqc4FROnFb7oATTZDUdJce09zMEAM802Fe9qw/GCLYVApNN1AADn6yWmWRkONFKrmDAQ5YmTw8kMtBVSKnacmZ1b5kaH38plyVYlvHYD4vjK0I18kU38zN0CY8dGoRh8KxN7Q/Z2SCUk5KMw444F/zGE1XejmM2Gg9pFGsY99Lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=copNey14adIGuPfh1ufOVjHXKM/gu/rKRgaPgtawcZ4=;
 b=SI6bvXw491u6xP69dtuoycLsyaxfYs7qEplEiGqJKXMkyp+NFd6tADpUWP99EHiantQhQ/vwav/sRETevsEoPnBlDZuZ7UmZhoc5HSoqbOdSgSvcPMnELXpXcC/dtoFboLBZ6SuTdvHkcZ4oSI9Sj178US+Pb10SRdtweA6UV2uvaIHxNGECPtk6co2Jv98fALNYqIy6Xc+HndX9IVkWH6r+Z3T/7Af+sbQ8dWNsjKicpxQprcboQ9Rkh5pmZ2eWcZ3w+el3Og4Ve9MLCYqDCbkRNorXj9HMLkGgaBwiicqs5BnuZJ/PKaDE4pXxBgDmklq7Y7LFkVjo58f/OxnRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=copNey14adIGuPfh1ufOVjHXKM/gu/rKRgaPgtawcZ4=;
 b=kz0+6BDG5GptJn99x2CA3Tk9On8tjorxjiLrcvjkwz6H0itPx7yXJlM2EJaz4r4JpVUWvOcUNszhGqTkdbc/yK8AhkGqmWTQRuFNK+zIrYfomMF/4gwjjdv9YPTFFon0Q4oMacSB3WIEwybDoOp9ZhXke5InQE+4MYKGg33m7E0=
Received: from DS7PR03CA0109.namprd03.prod.outlook.com (2603:10b6:5:3b7::24)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 13:42:19 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::45) by DS7PR03CA0109.outlook.office365.com
 (2603:10b6:5:3b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 13:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 13:42:19 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 08:42:10 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"Mel Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Bharata B Rao <bharata@amd.com>, Johannes Weiner <jweiner@fb.com>, "kernel
 test robot" <oliver.sang@intel.com>, Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH 2 1/1] sched/numa: Increase the VMA accessing PID bits
Date: Fri, 22 Mar 2024 19:11:13 +0530
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6713c0cd-9808-4efa-c66f-08dc4a75e545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GIAQbR81jGJZ2B/DTuEKZlKH8RsF2qXpoyiuruHU7IXDDgPPFzWY21PdbkMayMg1W8Kv/0KnvmKtu1lzviraqcNspjpvvcdJGxPlr8Nh5lopXncMTk6mFfVKCTfOBaQlcx9vzm49t3LbcS6nP7ifbYVUszbnnZV08LxQtDTXQLDQNMW6PlylKX5a//tG4qw0a8Deqbsyz1LtxVG8uYlN1bdGWkTL6ZwxW2rebUrGcvJa5diP3c/oH1v2Wl6VzlyhHTgrzv7W6K8qlI73HqHvnq8ADKqn48UQs++x39lkoD07qiy6QmYCs7cQqDtlem3xY6LYH2wPZ74rWUOW40xrVneWPrQNnpjRk6DMwglxOdB18cqTI8vrdwylyZJoykcs+u7vN26Pr99LExauEPWXuBiFVijQ7dOjC3B07aZ5s7xYRAXIaotfG9R6Aj1VGtDW47oVnxIcFebNOFz3BZblM/18L15MEJ06Ms/IcBjtwfRJQHBg9N5VSOT0dmurURrvy6D9m1p5vJ2F8thyvFaJzmOXeJpIGBnXnV56FHAHFGsGsAgFLBor3CspX4yIbnQRRxl1E0MjNmhP5J6PPk/80p2ogATm/dsMx/ivBVOd+/uk0NSgUQzZZiHFdmBl1GpQWNsQuAgvovV+H4M65mMZqCznO77BC3COdB3QLk9N3cI+kTB5Aw3llNEZvKkgn9nhE9M+m/KXpgxaopnjIOP7+LKYUbp9JN60Spa79i0FxGVUbSsCsVP3FDgOba+5Ovzy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 13:42:19.5139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6713c0cd-9808-4efa-c66f-08dc4a75e545
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

Currently we use 64 bits to track tasks accessing VMA.

This increases probability of false positive cases and thus
potentially increase unnecssary scanning of VMA though task
had not accessed VMA. Increase it to 128 bits.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 include/linux/mm.h       | 29 ++++++++++++++++++++++++++---
 include/linux/mm_types.h |  7 ++++++-
 kernel/sched/fair.c      | 21 ++++++++++++++++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

There could be better idea than having array of 2 long variables for 128
bits?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..d8ff7233cf9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1741,13 +1741,26 @@ static inline int folio_xchg_access_time(struct folio *folio, int time)
 	return last_time << PAGE_ACCESS_TIME_BUCKETS;
 }
 
+static inline int pid_array_idx(int pid_bit)
+{
+	return (pid_bit / BITS_PER_LONG);
+}
+
+static inline int pid_bit_idx(int pid_bit)
+{
+	return (pid_bit % BITS_PER_LONG);
+}
+
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 	unsigned int pid_bit;
 
-	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG));
-	if (vma->numab_state && !test_bit(pid_bit, &vma->numab_state->pids_active[1])) {
-		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
+	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG * NR_PID_ARRAY));
+
+	if (vma->numab_state && !test_bit(pid_bit_idx(pid_bit),
+				&vma->numab_state->pids_active[1][pid_array_idx(pid_bit)])) {
+		__set_bit(pid_bit_idx(pid_bit),
+				&vma->numab_state->pids_active[1][pid_array_idx(pid_bit)]);
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
@@ -1800,6 +1813,16 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
 	return false;
 }
 
+static inline int pid_array_idx(int pid_bit)
+{
+	return 0;
+}
+
+static inline int pid_bit_idx(int pid_bit)
+{
+	return 0;
+}
+
 static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 {
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..34bb8e1f0e1c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -574,6 +574,11 @@ struct vma_lock {
 	struct rw_semaphore lock;
 };
 
+#define NR_PID_ARRAY	2
+#define NR_TRACKED_PIDS	(BITS_PER_LONG * NR_PID_ARRAY)
+
+#define NR_ACCESS_PID_HIST     2
+
 struct vma_numab_state {
 	/*
 	 * Initialised as time in 'jiffies' after which VMA
@@ -598,7 +603,7 @@ struct vma_numab_state {
 	 * Window moves after next_pid_reset has expired approximately
 	 * every VMA_PID_RESET_PERIOD jiffies:
 	 */
-	unsigned long pids_active[2];
+	unsigned long pids_active[NR_ACCESS_PID_HIST][NR_PID_ARRAY];
 
 	/* MM scan sequence ID when scan first started after VMA creation */
 	int start_scan_seq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6a16129f9a5c..63086ca00430 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3159,7 +3159,8 @@ static void reset_ptenuma_scan(struct task_struct *p)
 
 static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	unsigned long pids;
+	int pid_bit, pid_aidx, i;
+	unsigned long pids = 0;
 	/*
 	 * Allow unconditional access first two times, so that all the (pages)
 	 * of VMAs get prot_none fault introduced irrespective of accesses.
@@ -3169,8 +3170,13 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
 	if ((READ_ONCE(current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2)
 		return true;
 
-	pids = vma->numab_state->pids_active[0] | vma->numab_state->pids_active[1];
-	if (test_bit(hash_32(current->pid, ilog2(BITS_PER_LONG)), &pids))
+	pid_bit = hash_32(current->pid, ilog2(BITS_PER_LONG * NR_PID_ARRAY));
+	pid_aidx = pid_array_idx(pid_bit);
+
+	for (i = 0; i < NR_ACCESS_PID_HIST; i++)
+		pids |= vma->numab_state->pids_active[i][pid_aidx];
+
+	if (test_bit(pid_bit_idx(pid_bit), &pids))
 		return true;
 
 	/*
@@ -3204,6 +3210,7 @@ static void task_numa_work(struct callback_head *work)
 	struct vma_iterator vmi;
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
+	int i;
 
 	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
 
@@ -3341,8 +3348,12 @@ static void task_numa_work(struct callback_head *work)
 				time_after(jiffies, vma->numab_state->pids_active_reset)) {
 			vma->numab_state->pids_active_reset = vma->numab_state->pids_active_reset +
 				msecs_to_jiffies(VMA_PID_RESET_PERIOD);
-			vma->numab_state->pids_active[0] = READ_ONCE(vma->numab_state->pids_active[1]);
-			vma->numab_state->pids_active[1] = 0;
+
+			for (i = 0; i < NR_PID_ARRAY; i++) {
+				vma->numab_state->pids_active[0][i] =
+					READ_ONCE(vma->numab_state->pids_active[1][i]);
+				vma->numab_state->pids_active[1][i] = 0;
+			}
 		}
 
 		/* Do not rescan VMAs twice within the same sequence. */
-- 
2.34.1


