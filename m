Return-Path: <linux-kernel+bounces-25716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B7582D4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0D52819D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996979FD;
	Mon, 15 Jan 2024 08:20:12 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3463CA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7f-65a4eab48a36
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v6 3/7] mm/rmap: Recognize read-only TLB entries during batched TLB flush
Date: Mon, 15 Jan 2024 17:19:49 +0900
Message-Id: <20240115081953.2521-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240115081953.2521-1-byungchul@sk.com>
References: <20240115081953.2521-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnoe6WV0tSDboXi1nMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+PrPKeC49IVHz7tYGxgfCDWxcjJISFgIvHl7ERWGPvasXWMIDabgLrEjRs/
	mUFsEQEziYOtf9i7GLk4mAU+Mkms/t7BApIQFoiUaFixF6yBRUBV4tjmN2ANvECDtm2dATVU
	XmL1hgNgcU4BU4l3H4+zg9hCQDUtd9exggyVEGhml7j+aAlUg6TEwRU3WCYw8i5gZFjFKJSZ
	V5abmJljopdRmZdZoZecn7uJERgPy2r/RO9g/HQh+BCjAAejEg/vj7+LU4VYE8uKK3MPMUpw
	MCuJ8FbfWZIqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1Oq
	gVHzRf2p6w7TWh/tPSadJTRDa14q24VzVforrpY+Vrrp+DqTIX6WrdMFDcMVM+reZp698f+z
	y5rapKVWeyYutX2xjbEm9UWMjt/ZK7LyMflerzS61bnmO0371bj32FfNCNeLNgoLD6feu3tC
	0uKxs+aE5E17k1QXJ0p8XcqwVSawVOj5Zp53nPJKLMUZiYZazEXFiQBlepJngwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrLvl1ZJUg+5VnBZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyvs5zKjguXfHh0w7GBsYHYl2MnBwSAiYS146tYwSx2QTU
	JW7c+MkMYosImEkcbP3D3sXIxcEs8JFJYvX3DhaQhLBApETDir1gDSwCqhLHNr8Ba+AFGrRt
	6wxWiKHyEqs3HACLcwqYSrz7eJwdxBYCqmm5u451AiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZ
	FXrJ+bmbGIHBvaz2z8QdjF8uux9iFOBgVOLh/fF3caoQa2JZcWXuIUYJDmYlEd7qO0tShXhT
	EiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhgbr0o4HFm85Kfq
	gQu/F6bd3ZnyYU7heQ/jhRv+XX/i9v7Dyplc1+Z/TvJpuKbSkDZ5h9VL/718xgfjHHtifQ5k
	/o0IP6rZ99dde3+x3I05j08dDlsUkhimK2t0VpypRvMU37q+NBd37ZSGyGMPb7tXfjdXm3BL
	WPDfoRmnyy+5T75r/Gu++ywtJZbijERDLeai4kQAJQwUJmoCAAA=
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


