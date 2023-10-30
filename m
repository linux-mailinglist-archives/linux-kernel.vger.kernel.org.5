Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D9F7DB486
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjJ3HlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjJ3HlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:41:13 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D1E8C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:41:10 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-a0-653f5a7fd692
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v3 1/3] mm/rmap: Recognize non-writable TLB entries during TLB batch flush
Date:   Mon, 30 Oct 2023 16:25:38 +0900
Message-Id: <20231030072540.38631-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231030072540.38631-1-byungchul@sk.com>
References: <20231030072540.38631-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnoW59lH2qwc0XohZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CVsfzK
        BuaC/4YV7dP5GhgvaXYxcnJICJhI7HoxhR3GbuycxAhiswmoS9y48ZMZxBYRMJM42PoHqIaL
        g1ngAZPE3LcrwIqEBUIk3jzfA1TEwcEioCrx9FMhiMkrYCrxb00+xEh5idUbDoCN4QQa8/l4
        FxuILQRUsv3/YWaQkRICr9kkdj6ZxQTRIClxcMUNlgmMvAsYGVYxCmXmleUmZuaY6GVU5mVW
        6CXn525iBIb8sto/0TsYP10IPsQowMGoxMMbEG6XKsSaWFZcmXuIUYKDWUmEl9nRJlWINyWx
        siq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC1CKYLBMHp1QDY+IXr84XNSJXTEuD
        vLd3PN8sc3yNJ9fSLtX5pwzKdi+p1ohMkb8955mPVT1/xqykuzNVb01lZn+Wtb7wzJnGb4du
        7rx/WiY47XHlNu5pkbetE4Ky739ecmznUvtm3v/bi6dHrYsXuvv4TpbBjDniH8uX7BHMjPuZ
        4Gf9WU89b5uV6gGJ+muSl5RYijMSDbWYi4oTAXQBTrZ1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrFsfZZ9qcHgNm8Wc9UDi84Z/bBYv
        NrQzWnxd/4vZ4umnPhaLw3NPslpc3jWHzeLemv+sFud3rWW12LF0H5PFpQMLmCyu73rIaHG8
        9wCTxeZNU5ktfv8Aqpszxcri5KzJLA6CHt9b+1g8Fmwq9di8Qstj8Z6XTB6bVnWyeWz6NInd
        4925c+weJ2b8ZvHY+dDSY97JQI/3+66yeSx+8YHJY+svO4/Pm+Q83s1/yxbAH8Vlk5Kak1mW
        WqRvl8CVsfzKBuaC/4YV7dP5GhgvaXYxcnJICJhINHZOYgSx2QTUJW7c+MkMYosImEkcbP3D
        3sXIxcEs8IBJYu7bFWBFwgIhEm+e7wEq4uBgEVCVePqpEMTkFTCV+LcmH2KkvMTqDQfAxnAC
        jfl8vIsNxBYCKtn+/zDzBEauBYwMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQIDeFntn4k7
        GL9cdj/EKMDBqMTDGxBulyrEmlhWXJl7iFGCg1lJhJfZ0SZViDclsbIqtSg/vqg0J7X4EKM0
        B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgfGWTadS34YNYRHOmm6veExjEtaLi4etfBTy
        U7xCOkr1k0N4QRjH4epj/YZmr9y+Vq/8MaExRHzarU3h6nv+CBXZFGozinpY3es5kL/jgHzW
        /e0F/6+7bLguyXOPPcd5vxr707vvzjrfrnvg1KUm9VdHs6v/75ELf+84fTzDL5/iGuG7zuUY
        kxJLcUaioRZzUXEiALVVoOhcAgAA
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
 arch/x86/mm/tlb.c               |  7 ++++++
 include/linux/mm_types_task.h   |  4 ++--
 include/linux/sched.h           |  1 +
 mm/internal.h                   | 14 ++++++++++++
 mm/rmap.c                       | 39 ++++++++++++++++++++++++++++-----
 6 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..9d1361d2119c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -292,6 +292,8 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..314cd9912a88 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1274,6 +1274,13 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
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
index aa44fff8bb9d..35ba9425d48d 100644
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
index 77f01ac385f7..63189c023357 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1324,6 +1324,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_nowr;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724ddbce..e20d5b223901 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -861,6 +861,9 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc_nowr(void);
+int nr_flush_required(void);
+int nr_flush_required_nowr(void);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -871,6 +874,17 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc_nowr(void)
+{
+}
+static inline int nr_flush_required(void)
+{
+	return 0;
+}
+static inline int nr_flush_required_nowr(void)
+{
+	return 0;
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index 9f795b93cf40..a045f3b57c60 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -605,6 +605,32 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
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
+int nr_flush_required(void)
+{
+	return current->tlb_ubc.nr_flush_required;
+}
+
+int nr_flush_required_nowr(void)
+{
+	return current->tlb_ubc_nowr.nr_flush_required;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -615,11 +641,12 @@ void try_to_unmap_flush(void)
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
 
@@ -627,8 +654,9 @@ void try_to_unmap_flush(void)
 void try_to_unmap_flush_dirty(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_nowr = &current->tlb_ubc_nowr;
 
-	if (tlb_ubc->writable)
+	if (tlb_ubc->writable || tlb_ubc_nowr->writable)
 		try_to_unmap_flush();
 }
 
@@ -645,15 +673,16 @@ void try_to_unmap_flush_dirty(void)
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 				      unsigned long uaddr)
 {
-	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
 	bool writable = pte_dirty(pteval);
 
 	if (!pte_accessible(mm, pteval))
 		return;
 
+	tlb_ubc = pte_write(pteval) || writable ? &current->tlb_ubc : &current->tlb_ubc_nowr;
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
-	tlb_ubc->flush_required = true;
+	tlb_ubc->nr_flush_required += 1;
 
 	/*
 	 * Ensure compiler does not re-order the setting of tlb_flush_batched
-- 
2.17.1

