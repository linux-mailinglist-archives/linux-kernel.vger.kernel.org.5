Return-Path: <linux-kernel+bounces-80446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C11386687F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC75D1F211DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D011B7F6;
	Mon, 26 Feb 2024 03:06:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE411CB8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916798; cv=none; b=Vp5omee6YqENxz431cg4Hbnsk164/JZThK33ddKXlYwPv846H/drYnxbHdX1kxYS49yrycmv6rlhTcZ0C/4AlT/jjarlVJqEaGZATiqNpI/wwHZiBC+ni0yV2QZ7ErcTqrzj2gBQu7GGW1uLDDSqevLS54wpkBAQcn5DWE5tLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916798; c=relaxed/simple;
	bh=WHuF8WryLfu8JX/60dlBPk8CVS136b4yvUfGBE1UZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZMezWL0LSDe/gpYg54k3BXfDn2v4zXWJrI+PNuQR6ESQhwXXn6n7eoiqCOBFohdzifItL4h4rgC4DnYY+lllEP3+Wfr6IA94H2bPYfYIH7pIifWlc83pXJUTiowpElDdbI5Nk/QcH5EQ9/5Jt0dtRxkolZWfMzT9owmXrSh6nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-32-65dc002f6be1
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
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
Subject: [RESEND PATCH v8 3/8] mm/rmap: Recognize read-only TLB entries during batched TLB flush
Date: Mon, 26 Feb 2024 12:06:08 +0900
Message-Id: <20240226030613.22366-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoa4+w51Ug8NXLS3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	13lOBcelKz582sHYwPhArIuRk0NCwETiy66TrDD2mZe/GUFsNgF1iRs3fjKD2CICZhIHW/+w
	g9jMAneZJA70s4HYwgIJEg+nzWMCsVkEVCUOn4Go5xUwlTg8YSHUTHmJ1RsOAMU5ODiB5rz/
	bwgSFgIq+dt7FWgVF1DJezaJE38OMELUS0ocXHGDZQIj7wJGhlWMQpl5ZbmJmTkmehmVeZkV
	esn5uZsYgWG/rPZP9A7GTxeCDzEKcDAq8fAu+HA7VYg1say4MvcQowQHs5IIb7jMzVQh3pTE
	yqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjDVc17fHpHDM1vip
	1c0s8nhT0EpZt02LFl3InXXdeEMsC/f+t82Fu1aonZkVb8v5j6vsV57bUY6Fwc8sGdZGfbZf
	67JQoGOSxJMTjK/S174xDou/mSInM0+fadZjNdZpYaq7p9u0lO65sqdb2MLRuNIzdU/+LsUa
	jfOWLlrblJwULwpN0GEMUWIpzkg01GIuKk4EALCYTpR3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfV4PZ3PYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZXyd51RwXLriw6cdjA2MD8S6GDk5JARMJM68/M0IYrMJqEvcuPGTGcQWETCT
	ONj6hx3EZha4yyRxoJ8NxBYWSJB4OG0eE4jNIqAqcfgMRD2vgKnE4QkLWSFmykus3nAAKM7B
	wQk05/1/Q5CwEFDJ396rjBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDOJltX8m
	7mD8ctn9EKMAB6MSD++CD7dThVgTy4orcw8xSnAwK4nwhsvcTBXiTUmsrEotyo8vKs1JLT7E
	KM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgDLfQf3L+fFbP6oyusxLzttvzPdJcJr97
	ScDHgA/qEcmONkwr7/z9cOH7/fm1pZfvz/sgFbvYeTG3S/t1QbmXp82FA56ceN7pYWzxU3fH
	/6YgsQkdSlmvwkVXvJ8iMtPoStaDkj7+locqHgmzLln5O58/HNJVepZVq0Q2YNnvJ8/cDc5M
	Wqv7U4mlOCPRUIu5qDgRANgmFc1eAgAA
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


