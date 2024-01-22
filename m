Return-Path: <linux-kernel+bounces-32247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F683590E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42741C2168E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7D4C83;
	Mon, 22 Jan 2024 01:01:06 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48232641
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885266; cv=none; b=NtKUqK+VpGmLXN3ymp/Q+mJElKnnxRshxYX0EQwTUQsLfrCbgxqWRek19JufCFS1YQeUCDFRqZVmDlsnHlR8N0pI9XUnaf4AtxbFxaxssocB0fousiGM7nLWp+6/pNXQB2iHksjQeKYqd2iLaIfMuUsZSTCGzWRPg1ymIGVsuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885266; c=relaxed/simple;
	bh=WHuF8WryLfu8JX/60dlBPk8CVS136b4yvUfGBE1UZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tMuKgjxTT1TYyTUGp2rXvy6h8xkWlKPKVG5wSc5w0faWkcscOdvCuzms4GvXezJJavg3M+Pl4eNB3+SRbZYT70OSuI/ahrkAfFXGDucAT15XmjY/brzCM7+MgH0ZEWLmQoCr2/W85npbW0r7Qbm3Sd5C+W1RZVmWfmmoHAcyXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-77-65adbe43af5d
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
Subject: [PATCH v7 3/8] mm/rmap: Recognize read-only TLB entries during batched TLB flush
Date: Mon, 22 Jan 2024 10:00:35 +0900
Message-Id: <20240122010040.74346-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
References: <20240122010040.74346-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsXC9ZZnka7zvrWpBre+KlnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+PrPKeC49IVHz7tYGxgfCDWxcjJISFgItG+6AVjFyMHmN01JQEkzCagLnHj
	xk9mEFtEwEziYOsf9i5GLg5mgY9MEqu/d7CAJIQFIiWuvPkMVsQioCqxc9ljZpA5vAKmEvda
	uCDGy0us3nAArIQTaM6UX11MILYQUMncDzsZQWZKCDSzS2zuP8MO0SApcXDFDZYJjLwLGBlW
	MQpl5pXlJmbmmOhlVOZlVugl5+duYgTGwrLaP9E7GD9dCD7EKMDBqMTD68C+NlWINbGsuDL3
	EKMEB7OSCC+/6qpUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJM
	HJxSDYyLj7dlnOONTfeyrlUNXfxgcpBxyxJBcdvn18oaUntkTq8vSIwIYv6V7yf7dVvzum8/
	2+PileyNgiZyqjdF77DjXrJ9362pT27oXN5Y1fgh/P5sp+3LFDaUn9nzrVVn2ccZi59ZTGs0
	0AudNd9Jew9nWKKPxZQah6D1h5dGSswR4H/1y7b5x0olluKMREMt5qLiRAClHd/2gQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwf5v4hZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyvs5zKjguXfHh0w7GBsYHYl2MHBwSAiYSXVMSuhg5OdgE
	1CVu3PjJDGKLCJhJHGz9w97FyMXBLPCRSWL19w4WkISwQKTElTefwYpYBFQldi57zAwyh1fA
	VOJeCxdIWEJAXmL1hgNgJZxAc6b86mICsYWASuZ+2Mk4gZFrASPDKkaRzLyy3MTMHFO94uyM
	yrzMCr3k/NxNjMDAXlb7Z+IOxi+X3Q8xCnAwKvHwOrCvTRViTSwrrsw9xCjBwawkwsuvuipV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgXH1b4H7U2L1
	xfrqGgT3SCwsabBvOXDW3zi6j/3ttJuH3uSufiqcwSStlBP25lvu5Ta9q+vPvLeLipD4fsnp
	6nOuIyXL65cZX2ROL/G57i/ibluhZda/wb9jpd4KHocnz1JEqj8ZGbNdFW9O9cuurvk0Ia7E
	uW0q+1Y2iYLWfiP5JeLsbHamSizFGYmGWsxFxYkAE0ppnGgCAAA=
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


