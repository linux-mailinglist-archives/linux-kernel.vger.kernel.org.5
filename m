Return-Path: <linux-kernel+bounces-23088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B83782A784
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523B51C22D35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7ECC8C7;
	Thu, 11 Jan 2024 06:23:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687D63D8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e8-659f85c8eef1
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	xhao@linux.alibaba.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: [v5 3/7] mm/rmap: Recognize read-only TLB entries during batched TLB flush
Date: Thu, 11 Jan 2024 15:07:53 +0900
Message-Id: <20240111060757.13563-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240111060757.13563-1-byungchul@sk.com>
References: <20240111060757.13563-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnoe6J1vmpBi8W8VnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	2LxpKrPF7x9AdXOmWFmcnDWZxUHA43trH4vHgk2lHptXaHks3vOSyWPTqk42j02fJrF7vDt3
	jt3jxIzfLB47H1p6zDsZ6PF+31U2j62/7Dw+b5LzeDf/LVsAXxSXTUpqTmZZapG+XQJXxtd5
	TgXHpSs+fNrB2MD4QKyLkZNDQsBEYsrSBkYY+27PBGYQm01AXeLGjZ9gtoiAmcTB1j/sXYxc
	HMwCD5gk5r5dAdYgLBAscej9NlYQm0VAVWLO33dARRwcvAKmEn+mQM2Xl1i94QDYHE6gORcO
	z2IEKRECKnnUVgcyUkLgPZvEm4sTmSHqJSUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwK
	veT83E2MwJBfVvsnegfjpwvBhxgFOBiVeHgfLJqXKsSaWFZcmXuIUYKDWUmEV+HznFQh3pTE
	yqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjPKH1Z8pHNc4dKyz
	tOrYkmuah7aJnXLVqlb+zbRD79/NCo32CTs5mnNDWFI6WDp4Vh+TZOt3f2/8wJ7v8fo9c96/
	/jRrNXNBQZ7NUSEFzvf6xYsYdA6xstr/6oh0qJTs2fKB876p/jGbrFNBNls2Bfu6G15i9NCd
	I1rMlvt95+RHG2Ru3GsyV2Ipzkg01GIuKk4EALcZgJl1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrHuidX6qwedPTBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGSxedNUZovfP4Dq5kyxsjg5azKLg6DH99Y+Fo8Fm0o9Nq/Q8li85yWTx6ZVnWwemz5N
	Yvd4d+4cu8eJGb9ZPHY+tPSYdzLQ4/2+q2wei198YPLY+svO4/MmOY9389+yBfBHcdmkpOZk
	lqUW6dslcGV8nedUcFy64sOnHYwNjA/Euhg5OSQETCTu9kxgBrHZBNQlbtz4CWaLCJhJHGz9
	w97FyMXBLPCASWLu2xWMIAlhgWCJQ++3sYLYLAKqEnP+vgMq4uDgFTCV+DMFaqa8xOoNB8Dm
	cALNuXB4FiNIiRBQyaO2ugmMXAsYGVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEBvCy2j8T
	dzB+uex+iFGAg1GJh9fg5bxUIdbEsuLK3EOMEhzMSiK8Cp/npArxpiRWVqUW5ccXleakFh9i
	lOZgURLn9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwVoZaMSzSWsZ4hOEQn9GVW1w7NggdLGs8
	eOidjG+ES85q2YbXR716b6R8id/HrFf/Qu+5hVLa0kkWz6Ia97bpTbigEnXP9hRb8J62+3Ok
	suo5TyhV/Vh36Pn7pJcHZr8XLes59rV16uKvpUHz7tf0335oIN51f4b7CvbzHstOspqfcDwp
	GNyxUYmlOCPRUIu5qDgRAM7hR7pcAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change. This is a preparation for migrc mechanism that
requires to recognize read-only TLB entries and makes use of them to
batch more aggressively. Plus, the newly introduced API, fold_ubc() will
be used by migrc mechanism when manipulating tlb batch data.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/internal.h         |  4 ++++
 mm/rmap.c             | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..0317e7a65151 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1328,6 +1328,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..b880f1e78700 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -923,6 +923,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -933,6 +934,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..da36f23ff7b0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -605,6 +605,28 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+
+void fold_ubc(struct tlbflush_unmap_batch *dst,
+	      struct tlbflush_unmap_batch *src)
+{
+	if (!src->flush_required)
+		return;
+
+	/*
+	 * Fold src to dst.
+	 */
+	arch_tlbbatch_fold(&dst->arch, &src->arch);
+	dst->writable = dst->writable || src->writable;
+	dst->flush_required = true;
+
+	/*
+	 * Reset src.
+	 */
+	arch_tlbbatch_clear(&src->arch);
+	src->flush_required = false;
+	src->writable = false;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -614,7 +636,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
+	fold_ubc(tlb_ubc, tlb_ubc_ro);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -645,13 +669,18 @@ void try_to_unmap_flush_dirty(void)
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


