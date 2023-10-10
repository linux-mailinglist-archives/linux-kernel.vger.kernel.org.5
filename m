Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3E7BF7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjJJJoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJJJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:43:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD10A4;
        Tue, 10 Oct 2023 02:43:50 -0700 (PDT)
Date:   Tue, 10 Oct 2023 09:43:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696931029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AchlrEzZ1wWeq/8zfA509m/azLJBpnkCn8kNXwAt+Lw=;
        b=ZEMZjnIjQvuuJi2Evp/ohp/PZT/IKsCLcCfBdfoAfzcxWW6SeLd3rH+GavApZiHQxvsAQp
        MG/LrY8akJXrVqS3tHsY/Ok1OqRce6E0LsP3R9n8H+f6UtVtqbzrtQ5ljvLKOpJeu9Lw5L
        FqNIDE0SItG1HmpubFn1IdH4NiuVRcciT615zfn9r1tgNpq7vwTbbRh2jeGryFwjIyEzj0
        WTAmi8Lg06w4mtEqJP9LpfwStYQeaqgQ7C+UZp4CaM2Ep+93N7Pakq7isCZxCMCVkZLHiF
        B7Os9KeawdZhX2khjONm34HIRMX4P/e46EX2NhNAl8owS3zS7jq3dONFzCT8rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696931029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AchlrEzZ1wWeq/8zfA509m/azLJBpnkCn8kNXwAt+Lw=;
        b=u6ajUWsPXwy4TtYXWfryQcYpoeTKCtNg/0wT2dOW5A5KhcsogiLBtMBpaATnmrHR1F4xKS
        Pv6H3U9/p1KCFFDA==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Trace decisions related to skipping VMAs
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010083143.19593-4-mgorman@techsingularity.net>
References: <20231010083143.19593-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <169693102843.3135.16734388613957578875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ed2da8b725b932b1e2b2f4835bb664d47ed03031
Gitweb:        https://git.kernel.org/tip/ed2da8b725b932b1e2b2f4835bb664d47ed03031
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Tue, 10 Oct 2023 09:31:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 11:10:00 +02:00

sched/numa: Trace decisions related to skipping VMAs

NUMA balancing skips or scans VMAs for a variety of reasons. In preparation
for completing scans of VMAs regardless of PID access, trace the reasons
why a VMA was skipped. In a later patch, the tracing will be used to track
if a VMA was forcibly scanned.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231010083143.19593-4-mgorman@techsingularity.net
---
 include/linux/sched/numa_balancing.h |  8 ++++-
 include/trace/events/sched.h         | 50 +++++++++++++++++++++++++++-
 kernel/sched/fair.c                  | 17 ++++++---
 3 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762..c127a15 100644
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
index a13d5d0..d82a04d 100644
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
index 6b47edc..31cfdb0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3210,6 +3210,7 @@ static void task_numa_work(struct callback_head *work)
 	do {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
+			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
 			continue;
 		}
 
@@ -3220,15 +3221,19 @@ static void task_numa_work(struct callback_head *work)
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
@@ -3250,12 +3255,16 @@ static void task_numa_work(struct callback_head *work)
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
