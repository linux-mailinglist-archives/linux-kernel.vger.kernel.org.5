Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C579B7BF5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442863AbjJJIcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442876AbjJJIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:32:29 -0400
Received: from outbound-smtp44.blacknight.com (outbound-smtp44.blacknight.com [46.22.136.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BAA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:32:28 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id A0BB3F846C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:32:26 +0100 (IST)
Received: (qmail 8011 invoked from network); 10 Oct 2023 08:32:26 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPA; 10 Oct 2023 08:32:26 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/6] sched/numa: Trace decisions related to skipping VMAs
Date:   Tue, 10 Oct 2023 09:31:40 +0100
Message-Id: <20231010083143.19593-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231010083143.19593-1-mgorman@techsingularity.net>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA Balancing skip or scans VMAs for a variety of reasons. In preparation
for completing scans of VMAs regardless of PID access, trace the reasons
why a VMA was skipped. In a later patch, the tracing will be used to track
if a VMA was forcibly scanned.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched/numa_balancing.h |  8 +++++
 include/trace/events/sched.h         | 50 ++++++++++++++++++++++++++++
 kernel/sched/fair.c                  | 17 +++++++---
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..c127a1509e2f 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -15,6 +15,14 @@
 #define TNF_FAULT_LOCAL	0x08
 #define TNF_MIGRATE_FAIL 0x10
 
+enum numa_vmaskip_reason {
+	NUMAB_SKIP_UNSUITABLE,
+	NUMAB_SKIP_SHARED_RO,
+	NUMAB_SKIP_INACCESSIBLE,
+	NUMAB_SKIP_SCAN_DELAY,
+	NUMAB_SKIP_PID_INACTIVE,
+};
+
 #ifdef CONFIG_NUMA_BALANCING
 extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..b0d0dbf491ea 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -664,6 +664,56 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
 );
 
+#ifdef CONFIG_NUMA_BALANCING
+#define NUMAB_SKIP_REASON					\
+	EM( NUMAB_SKIP_UNSUITABLE,		"unsuitable" )	\
+	EM( NUMAB_SKIP_SHARED_RO,		"shared_ro" )	\
+	EM( NUMAB_SKIP_INACCESSIBLE,		"inaccessible" )	\
+	EM( NUMAB_SKIP_SCAN_DELAY,		"scan_delay" )	\
+	EMe(NUMAB_SKIP_PID_INACTIVE,		"pid_inactive" )
+
+/* Redefine for export. */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+NUMAB_SKIP_REASON
+
+/* Redefine for symbolic printing. */
+#undef EM
+#undef EMe
+#define EM(a, b)	{ a, b },
+#define EMe(a, b)	{ a, b }
+
+TRACE_EVENT(sched_skip_vma_numa,
+
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma,
+		 enum numa_vmaskip_reason reason),
+
+	TP_ARGS(mm, vma, reason),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, numa_scan_offset)
+		__field(unsigned long, vm_start)
+		__field(unsigned long, vm_end)
+		__field(enum numa_vmaskip_reason, reason)
+	),
+
+	TP_fast_assign(
+		__entry->numa_scan_offset	= mm->numa_scan_offset;
+		__entry->vm_start		= vma->vm_start;
+		__entry->vm_end			= vma->vm_end;
+		__entry->reason			= reason;
+	),
+
+	TP_printk("numa_scan_offset=%lX vm_start=%lX vm_end=%lX reason=%s",
+		  __entry->numa_scan_offset,
+		  __entry->vm_start,
+		  __entry->vm_end,
+		  __print_symbolic(__entry->reason, NUMAB_SKIP_REASON))
+);
+#endif /* CONFIG_NUMA_BALANCING */
 
 /*
  * Tracepoint for waking a polling cpu without an IPI.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81405627b9ed..0535c57f6a77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3227,6 +3227,7 @@ static void task_numa_work(struct callback_head *work)
 	do {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
 			continue;
 		}
 
@@ -3237,15 +3238,19 @@ static void task_numa_work(struct callback_head *work)
 		 * as migrating the pages will be of marginal benefit.
 		 */
 		if (!vma->vm_mm ||
-		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ)))
+		    (vma->vm_file && (vma->vm_flags & (VM_READ|VM_WRITE)) == (VM_READ))) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SHARED_RO);
 			continue;
+		}
 
 		/*
 		 * Skip inaccessible VMAs to avoid any confusion between
 		 * PROT_NONE and NUMA hinting ptes
 		 */
-		if (!vma_is_accessible(vma))
+		if (!vma_is_accessible(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_INACCESSIBLE);
 			continue;
+		}
 
 		/* Initialise new per-VMA NUMAB state. */
 		if (!vma->numab_state) {
@@ -3267,12 +3272,16 @@ static void task_numa_work(struct callback_head *work)
 		 * delay the scan for new VMAs.
 		 */
 		if (mm->numa_scan_seq && time_before(jiffies,
-						vma->numab_state->next_scan))
+						vma->numab_state->next_scan)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_SCAN_DELAY);
 			continue;
+		}
 
 		/* Do not scan the VMA if task has not accessed */
-		if (!vma_is_accessed(vma))
+		if (!vma_is_accessed(vma)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_PID_INACTIVE);
 			continue;
+		}
 
 		/*
 		 * RESET access PIDs regularly for old VMAs. Resetting after checking
-- 
2.35.3

