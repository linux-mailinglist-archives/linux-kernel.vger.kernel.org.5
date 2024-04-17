Return-Path: <linux-kernel+bounces-148053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA18A7D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729E6B20EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FB96F068;
	Wed, 17 Apr 2024 07:34:23 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B1B6BB56
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339262; cv=none; b=al90QGI8ygIuaAXGQzhnsp9VAL3/8c/nQm1eh8oLQvqX1OJDa9/qHQDXw1D1d41hfPtJ3gzeVFkSFInFXnXHojvYcGaStsqEbtHYE/KF95dwp+DeIWiaTjCGB2f5pARnWKnrWZZ+4yt9JVZMEhgh8M9c/dCKsH6Wi+LjHA7HT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339262; c=relaxed/simple;
	bh=02cOaCrEAguODxPW9vC2szkGEgfN5B2WX9+iVHZabDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jBNIR5es0MsfuS5Act3w88kRiqPjrDyBkEoXDJWqm7QH2/qN8JrlcO7Od6ugFo/vbIiZtbfEi8TwOjUpGIpkkU09hWoZT0YsiWBXcI3Q5jAza6QDYc1Xe5ksPBVe7SnOuxYNYqDXyTeRRwkovlmMgmmvkuGxFS4l13ZcQb2TlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-9d-661f77e24455
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
Subject: [PATCH v9 3/8] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Wed, 17 Apr 2024 16:18:42 +0900
Message-Id: <20240417071847.29584-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe6jcvk0g+8LJC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	3uWrmApmSldc27CHvYFxh1gXIyeHhICJxNaZX9lg7KNrusBsNgF1iRs3fjKD2CICZhIHW/+w
	g9jMAneZJA70g9UIC0RKPN33FizOIqAqce/RCbB6XgFTifXvOxghZspLrN5wACzOCTRnc/Ma
	sF4hoJrvJz4C2VxANe/ZJO5enwx1hKTEwRU3WCYw8i5gZFjFKJSZV5abmJljopdRmZdZoZec
	n7uJERj6y2r/RO9g/HQh+BCjAAejEg+vQZRcmhBrYllxZe4hRgkOZiUR3hZh2TQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjIkCzxZaf/OrKtnl/qVj
	kUek2TajHp99civ2phkp19+rXuMedmLBAwn2xYHM185e4Fk8wW7WjA+TukxrNW9PTU/9duDD
	vr4na1mVmIz2fprTvVVBuz1DqeSvYFutnHpI7OusJCe1pzVJy86xvLnvPPcbg5xakO2zwm2f
	//ItPRVTXvVQsUqLQYmlOCPRUIu5qDgRAFoa4LF5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7NoOMbr8Wc9WvYLD5v+Mdm
	8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4njvASaL
	+fc+s1ls3jSV2eL4lKmMFr9/ABWfnDWZxUHQ43trH4vHzll32T0WbCr12LxCy2PxnpdMHptW
	dbJ5bPo0id3j3blz7B4nZvxm8Zh3MtDj/b6rbB6LX3xg8tj6y86jceo1No/Pm+QC+KO4bFJS
	czLLUov07RK4MvYuX8VUMFO64tqGPewNjDvEuhg5OSQETCSOruliA7HZBNQlbtz4yQxiiwiY
	SRxs/cMOYjML3GWSONAPViMsECnxdN9bsDiLgKrEvUcnwOp5BUwl1r/vYISYKS+xesMBsDgn
	0JzNzWvAeoWAar6f+Mg2gZFrASPDKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMBAXlb7Z+IO
	xi+X3Q8xCnAwKvHwGkTJpQmxJpYVV+YeYpTgYFYS4W0Rlk0T4k1JrKxKLcqPLyrNSS0+xCjN
	waIkzusVnpogJJCeWJKanZpakFoEk2Xi4JRqYDznvqdLebNf1O7N+48ZhvUndxeJ+V2u08uL
	6db9vUEt9In0w5kCliUlYdmOZrcWPj/tbnbMJOd+MPv7wzOeRancuv3oOqOW2MH/IQ8Oa2zT
	epL/SG3/rvj9P9MdH6y58NE683qAvIuK3/ILC0suPlog3drL8YRf/XCeteTMtcle7lN/BTYc
	MFZiKc5INNRiLipOBAB1cBaHYAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Functionally, no change.  This is a preparation for migrc mechanism that
requires to recognize read-only tlb entries and handle them in a
different way.  The newly introduced API, fold_ubc(), will be used by
migrc mechanism.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/sched.h |  1 +
 mm/internal.h         |  4 ++++
 mm/rmap.c             | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..823d83b24364 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1334,6 +1334,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..bbaf1fd97b1c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1019,6 +1019,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1029,6 +1030,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index 3746a5531018..2542bfe1a947 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -635,6 +635,28 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
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
@@ -644,7 +666,9 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 void try_to_unmap_flush(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
 
+	fold_ubc(tlb_ubc, tlb_ubc_ro);
 	if (!tlb_ubc->flush_required)
 		return;
 
@@ -675,13 +699,18 @@ void try_to_unmap_flush_dirty(void)
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


