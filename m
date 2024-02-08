Return-Path: <linux-kernel+bounces-57516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7A84DA10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17A3FB21A96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938569D11;
	Thu,  8 Feb 2024 06:26:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41967E63
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373589; cv=none; b=nb/ntcPThuvVqQW/mzTvIwqzETrKUmupoZKpKVLS9D0/JiQU5hRbAiKaEVm7iseuj57n7Y1dXJ+WZkqvEUX8SzffZDOJRM8D63Vi1/4ILLHVgMapH6U56znU8/1/d6BgKQqhsFTBM7nflQIe77ndcETdsjTAIml3SX2Cg7RMVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373589; c=relaxed/simple;
	bh=WHuF8WryLfu8JX/60dlBPk8CVS136b4yvUfGBE1UZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OK3zgtJ3BccpqgH2HrGdDLM/PrumDhJ81/JmoGOz8Dyo7fz8kcyhxMXYB4ZD1C7VSmsk7bHADqhCCcrDPRDDCl3ne8gYxOjgR6+HO6fSsnmD880FA083zNki9ECPc9yZn9B0ZISCG4PBcfuC//HoWIPEbfIYS6UCvg7titiJzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7d-65c4740bc993
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
Subject: [RESEND PATCH v7 3/8] mm/rmap: Recognize read-only TLB entries during batched TLB flush
Date: Thu,  8 Feb 2024 15:26:03 +0900
Message-Id: <20240208062608.44351-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208062608.44351-1-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnoS53yZFUg6bNAhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AdRxctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnls/WXn0Tj1GpvH501yHu/mv2UL4I/isklJ
	zcksSy3St0vgyvg6z6nguHTFh087GBsYH4h1MXJySAiYSHx+9JcFxu75PZURxGYTUJe4ceMn
	M4gtImAmcbD1D3sXIxcHs8BHJonV3zvAGoQFEiT6zyxkBbFZBFQlmv90gDXzCphKzN2xkhFi
	qLzE6g0HwAZxAg3aue0UWL0QUM2L2ZPZQIZKCPxnk5jbv50dokFS4uCKGywTGHkXMDKsYhTK
	zCvLTczMMdHLqMzLrNBLzs/dxAiMh2W1f6J3MH66EHyIUYCDUYmH90T54VQh1sSy4srcQ4wS
	HMxKIrxmOw6kCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCU
	amAMk/hgllfEfM3ljXTHGzsDk7yyw2KLzQRM34RWCbRbBc87bbdnhrGmfvHHgO27fqWeiuOe
	vYSf6+YE6fXXJFdPcYz5c+Wp3KOPwva7HnTzL3rZWBClty15kXkzm5POtis3d7+2Wzf95Qa+
	Z1s88v1aZ4jsm9rL/1kzwbb3Cks+s+aFTTH8/P1KLMUZiYZazEXFiQB5E/uagwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrMtdciTVYPkEZos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZX+c5FRyXrvjwaQdjA+MDsS5GTg4JAROJnt9TGUFsNgF1
	iRs3fjKD2CICZhIHW/+wdzFycTALfGSSWP29gwUkISyQINF/ZiEriM0ioCrR/KcDrJlXwFRi
	7o6VjBBD5SVWbzgANogTaNDObafA6oWAal7Mnsw2gZFrASPDKkaRzLyy3MTMHFO94uyMyrzM
	Cr3k/NxNjMDgXlb7Z+IOxi+X3Q8xCnAwKvHwnig/nCrEmlhWXJl7iFGCg1lJhNdsx4FUId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsbT6Qs2PjP8zBge
	GnD61x6zpztS2dVYI/78MDKWPyPr0e73o/j8M9srfp8+2R5ee/PFGmZbs31Wwgsdznr/WiIf
	spbRtHRVS+M7d89Mn+bwqU9M7ex3fI70eij2oMR7bbU3R5PUlJvi3Bcy9nL9jG3xyUpr0FGe
	PZ/PNfi0/oxJHG86vXQbTZRYijMSDbWYi4oTAeOGLtNqAgAA
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


