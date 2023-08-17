Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843077F1D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348746AbjHQIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348740AbjHQIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:05 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38232D7F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:08:58 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-c5-64ddd598e29a
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 1/6] mm/rmap: Recognize non-writable TLB entries during TLB batch flush
Date:   Thu, 17 Aug 2023 17:05:54 +0900
Message-Id: <20230817080559.43200-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817080559.43200-1-byungchul@sk.com>
References: <20230817080559.43200-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe6Mq3dTDDYsU7OYs34Nm8WLDe2M
        Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsru96yGhxvPcAk8XvH0DZOVOsLE7O
        msziwOuxYFOpx+YVWh6L97xk8ti0qpPNY9OnSeweJ2b8ZvHY+dDSY97JQI/3+66yeWz9Zefx
        eZOcx7v5b9kCeKK4bFJSczLLUov07RK4Mlbe3MhUcESvomXWDMYGxvtqXYycHBICJhILD81i
        h7E37LnGCGKzCahL3LjxkxnEFhEwkzjY+geohouDWWAZk8TdA+dYQRLCAhES+5Y8BWtgEVCV
        mN82lwXE5hUwldiz6gHUUHmJ1RsOAA3i4OAEGrT5rypIWAio5MPedawgMyUELrNJPN19mRGi
        XlLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus0EvOz93ECAziZbV/oncwfroQfIhRgINR
        iYfXYdedFCHWxLLiytxDjBIczEoivD28t1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9K08R
        EkhPLEnNTk0tSC2CyTJxcEo1MNY+3OTYNOXJsTsXbDgfP9x/5T+/291TCnqn5RV/F21Nefoo
        795/xVaGjUaM96ZEPgnI+Z27Vyj3s1bM/5uz606emX2GW27W8vbCtGvBK07yne4IPGSzr9nZ
        XWqeY3vMt03V7y7MCAoWvuv2fmZRID+TmGYS/5qPj9gM5f30jurdfn82jP2P8GolluKMREMt
        5qLiRABVsmrZXgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsXC5WfdrDvj6t0Ugw+/pS3mrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugStj5c2NTAVH9CpaZs1gbGC8r9bF
        yMkhIWAisWHPNUYQm01AXeLGjZ/MILaIgJnEwdY/7F2MXBzMAsuYJO4eOMcKkhAWiJDYt+Qp
        WAOLgKrE/La5LCA2r4CpxJ5VD9ghhspLrN5wAGgQBwcn0KDNf1VBwkJAJR/2rmOdwMi1gJFh
        FaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmBILqv9M3EH45fL7ocYBTgYlXh4HXbdSRFiTSwr
        rsw9xCjBwawkwtvDeytFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoR
        TJaJg1OqgTE+4q5e/bfvPSlK2VXf7JpnrpGwfrfxgXN2duMdjf2/5nxSmBGj+cj9xood2ic8
        FpRdqMn8IBKR57Xobojn0w/+zd8tp4anO3BLCbb8/Ku5OTB2jeoXY1Y5o/vfjM4JrWt925Pl
        Id0hHXBKt9ct0GobO4up7bt1zg8//ZgonbL/+bHDCr+271ViKc5INNRiLipOBAC0ccGjRQIA
        AA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functionally, no change. This is a preparation for CONFIG_MIGRC that
requires to recognize non-writable TLB entries and makes use of them to
batch more aggressively or even skip TLB flushes.

While at it, changed struct tlbflush_unmap's ->flush_required(boolean)
to ->nr_flush_required(int) in order to take into account not only
whether it has been requested or not, but also the exact number of the
requests. That will be used in CONFIG_MIGRC implementation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h |  2 ++
 arch/x86/mm/tlb.c               |  7 +++++++
 include/linux/mm_types_task.h   |  4 ++--
 include/linux/sched.h           |  1 +
 mm/internal.h                   |  4 ++++
 mm/rmap.c                       | 29 ++++++++++++++++++++++++-----
 6 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 75bfaa421030..63504cde364b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -279,6 +279,8 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 267acf27480a..69d145f1fff1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1265,6 +1265,13 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	put_cpu();
 }
 
+void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+	cpumask_clear(&bsrc->cpumask);
+}
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 5414b5c6a103..6f3bb757eb46 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -59,8 +59,8 @@ struct tlbflush_unmap_batch {
 	 */
 	struct arch_tlbflush_unmap_batch arch;
 
-	/* True if a flush is needed. */
-	bool flush_required;
+	/* The number of flush requested. */
+	int nr_flush_required;
 
 	/*
 	 * If true then the PTE was dirty when unmapped. The entry must be
diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..2232b2cdfce8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1322,6 +1322,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_nowr;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6d97ac..b90d516ad41f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -840,6 +840,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc_nowr(void);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -850,6 +851,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc_nowr(void)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index 19392e090bec..d18460a48485 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -605,6 +605,22 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+
+void fold_ubc_nowr(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_nowr = &current->tlb_ubc_nowr;
+
+	if (!tlb_ubc_nowr->nr_flush_required)
+		return;
+
+	arch_tlbbatch_fold(&tlb_ubc->arch, &tlb_ubc_nowr->arch);
+	tlb_ubc->writable = tlb_ubc->writable || tlb_ubc_nowr->writable;
+	tlb_ubc->nr_flush_required += tlb_ubc_nowr->nr_flush_required;
+	tlb_ubc_nowr->nr_flush_required = 0;
+	tlb_ubc_nowr->writable = false;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -615,11 +631,12 @@ void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 
-	if (!tlb_ubc->flush_required)
+	fold_ubc_nowr();
+	if (!tlb_ubc->nr_flush_required)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
-	tlb_ubc->flush_required = false;
+	tlb_ubc->nr_flush_required = 0;
 	tlb_ubc->writable = false;
 }
 
@@ -627,8 +644,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_nowr = &current->tlb_ubc_nowr;
 
-	if (tlb_ubc->writable)
+	if (tlb_ubc->writable || tlb_ubc_nowr->writable)
 		try_to_unmap_flush();
 }
 
@@ -644,15 +662,16 @@ void try_to_unmap_flush_dirty(void)
 
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval)
 {
-	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
 	bool writable = pte_dirty(pteval);
 
 	if (!pte_accessible(mm, pteval))
 		return;
 
+	tlb_ubc = pte_write(pteval) ? &current->tlb_ubc : &current->tlb_ubc_nowr;
 	arch_tlbbatch_add_mm(&tlb_ubc->arch, mm);
-	tlb_ubc->flush_required = true;
+	tlb_ubc->nr_flush_required += 1;
 
 	/*
 	 * Ensure compiler does not re-order the setting of tlb_flush_batched
-- 
2.17.1

