Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017247E62FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjKIE73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjKIE7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:59:24 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBD39258E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 20:59:21 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-fc-654c67269bde
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v4 1/3] mm/rmap: Recognize read-only TLB entries during batched TLB flush
Date:   Thu,  9 Nov 2023 13:59:06 +0900
Message-Id: <20231109045908.54996-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109045908.54996-1-byungchul@sk.com>
References: <20231109045908.54996-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoa5auk+qwcEeQ4s569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsri+6yGjxfHeA0wW
        mzdNZbb4/QOobs4UK4uTsyazOAh4fG/tY/FYsKnUY/MKLY/Fe14yeWxa1cnmsenTJHaPd+fO
        sXucmPGbxWPnQ0uPeScDPd7vu8rmsfWXncfnTXIe7+a/ZQvgi+KySUnNySxLLdK3S+DKWPpm
        KUvBLZWKGU82MjcwrpPrYuTgkBAwkfi3SKSLkRPM/PnhCDuIzSagLnHjxk9mEFtEwEziYOsf
        oDgXB7PAAyaJuW9XMIIkhAWCJY4vPswGYrMIqEo8Pf8OLM4rYCox/dlrNoih8hKrNxwAG8QJ
        NOjP1O1gthBQzdTP+xlBhkoIvGeTWL3zADtEg6TEwRU3WCYw8i5gZFjFKJSZV5abmJljopdR
        mZdZoZecn7uJERj2y2r/RO9g/HQh+BCjAAejEg/vjb/eqUKsiWXFlbmHGCU4mJVEeC+Y+KQK
        8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYPT8pP7/aYei
        U/SlDunlQY9LNsmFfHg7/+30m4X1ys+ved37HL1ddsZO/dp835oVMXlJ7zy1HF7en/pfoGfJ
        y3NVxi49jsF9Vnvyr20xvFHSe6SBq17ovaX604Jn931y9Dm09ssqeL6c8UKLcYbpLJnpXMrW
        rxgVlZp2v3Lf7/nzTJHTHOVLi5RYijMSDbWYi4oTAYrWpb13AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrKuW7pNqsPeLgsWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBlL3yxlKbilUjHjyUbmBsZ1cl2MnBwSAiYSPz8cYQex2QTUJW7c+MkMYosImEkc
        bP0DFOfiYBZ4wCQx9+0KRpCEsECwxPHFh9lAbBYBVYmn59+BxXkFTCWmP3vNBjFUXmL1hgNg
        gziBBv2Zuh3MFgKqmfp5P+MERq4FjAyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAsN4We2f
        iTsYv1x2P8QowMGoxMObMMU7VYg1say4MvcQowQHs5II7wUTn1Qh3pTEyqrUovz4otKc1OJD
        jNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRpsSs+z6tFvLflbdjphjF8GqW+tws7ao
        06hU4rRf+N1vJT0u7HcW3bi/8bbas6z927zZWYvlD5gsfJDPw3vvx2YW3QNNlUUrXvj8s240
        553ae1I6xLdr06F7l/fVP6iv9PPb33WsW/RQrAVLtfxRnQuFKjU2j0wPae4MTJDxiudJttl+
        +9BzJZbijERDLeai4kQAgfMvLV8CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functionally, no change. This is a preparation for migrc mechanism that
requires to recognize read-only TLB entries and makes use of them to
batch more aggressively.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h |  3 +++
 arch/x86/mm/tlb.c               | 11 +++++++++++
 include/linux/sched.h           |  1 +
 mm/internal.h                   |  4 ++++
 mm/rmap.c                       | 30 +++++++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..5c618a8821de 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -292,6 +292,9 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..d3c89a3d91eb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1274,6 +1274,17 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	put_cpu();
 }
 
+void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+}
+
+void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..8a31527d9ed8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1324,6 +1324,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index 30cf724ddbce..9764b240e259 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -861,6 +861,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc_ro(void);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -871,6 +872,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc_ro(void)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index 9f795b93cf40..c787ae94b4c6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -605,6 +605,28 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+
+void fold_ubc_ro(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+
+	if (!tlb_ubc_ro->flush_required)
+		return;
+
+	/*
+	 * Fold tlb_ubc_ro's data to tlb_ubc.
+	 */
+	arch_tlbbatch_fold(&tlb_ubc->arch, &tlb_ubc_ro->arch);
+	tlb_ubc->flush_required = true;
+
+	/*
+	 * Reset tlb_ubc_ro's data.
+	 */
+	arch_tlbbatch_clear(&tlb_ubc_ro->arch);
+	tlb_ubc_ro->flush_required = false;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -615,6 +637,7 @@ void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 
+	fold_ubc_ro();
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -645,13 +668,18 @@ void try_to_unmap_flush_dirty(void)
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 				      unsigned long uaddr)
 {
-	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc;
 	int batch;
 	bool writable = pte_dirty(pteval);
 
 	if (!pte_accessible(mm, pteval))
 		return;
 
+	if (pte_write(pteval) || writable)
+		tlb_ubc = &current->tlb_ubc;
+	else
+		tlb_ubc = &current->tlb_ubc_ro;
+
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
 	tlb_ubc->flush_required = true;
 
-- 
2.17.1

