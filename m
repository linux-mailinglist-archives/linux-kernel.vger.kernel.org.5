Return-Path: <linux-kernel+bounces-149560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4328E8A92E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747A41C20E23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0637867D;
	Thu, 18 Apr 2024 06:15:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C06A342
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420955; cv=none; b=ksEtiStG30glGZFjC50ZTIbrRA6aEb9gAACvePGyPpjMWrEXMykWdC6qCUGuAn5fvBaATbFlcnwiZGcTuHtEuwuQZ6nDrORhlH/euZl9VOkFfQc15HVPHhePxOGjkXOz17gzdpP/AYiZILab2VUaFzGURB2vUVJuWK4BjLQ1naQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420955; c=relaxed/simple;
	bh=nFEwIdxPpEU/jSrmUycRSefaSLySE4H3AerBO2506MY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oh8TqjvXUlv1h/qJN55QYqTAa2iVdSW/Lc3AHWQTRsVKh3IcMoMFD0Az6TMvv57fNR8wruCf61dNMk0D9QUQ1Cf3K7zVCy19gRgXgf50TSpTUjDkpbeLTIC2B8RSRM0VW+R7h8vTVIBZhRSMuWP+fb1iErXHmpzJ1kMsFWO0vZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-07-6620ba92c178
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
Subject: [PATCH v9 rebase on mm-unstable 3/8] mm/rmap: recognize read-only tlb entries during batched tlb flush
Date: Thu, 18 Apr 2024 15:15:31 +0900
Message-Id: <20240418061536.11645-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240418061536.11645-1-byungchul@sk.com>
References: <20240418061536.11645-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnoe7kXQppBlt2MlnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	21unMBfMlK74NvEuewPjDrEuRk4OCQETiaefFzHC2NPnXmMHsdkE1CVu3PjJDGKLCJhJHGz9
	AxZnFrjLJHGgnw3EFhbIl+h80A4WZxFQlTjUPp0FxOYVMJWYu+cwM8RMeYnVGw6A2ZxAc/rf
	HwLaxcEhBFRz4W9IFyMXUMl7NolZj5exQtRLShxccYNlAiPvAkaGVYxCmXlluYmZOSZ6GZV5
	mRV6yfm5mxiBgb+s9k/0DsZPF4IPMQpwMCrx8J48IJ8mxJpYVlyZe4hRgoNZSYS3RVg2TYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOj5E7xS06LruUu
	8JG6cW1i7gWB3YefrnnmmDBvXsTW8xeCl0ndVdz3JLdk4vcJU0SfcP+fwfx15/L9Ibn57Dwv
	5+sv+9uzQSf8xP/OE3qHzng7CIVfmcBvdmZWCX9/5UXZq/0/DppFRHxzO/raLzum9qTXN8W2
	AHuP5VZrvb+G9l9K+lo345dbgBJLcUaioRZzUXEiANIT2614AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrDtpl0KaQd9WE4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZdzeOoW5YKZ0xbeJd9kbGHeIdTFyckgImEhMn3uNHcRmE1CXuHHjJzOILSJg
	JnGw9Q9YnFngLpPEgX42EFtYIF+i80E7WJxFQFXiUPt0FhCbV8BUYu6ew8wQM+UlVm84AGZz
	As3pf3+IsYuRg0MIqObC35AJjFwLGBlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbxsto/
	E3cwfrnsfohRgINRiYf3xAH5NCHWxLLiytxDjBIczEoivC3CsmlCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjNndBcw/Xn/9m5u14OucFfrPOcL9XMX6
	32jxMhpOvDz5/grFtH+bJhZOnmJbsKFJ9NuOypznyZ9WV96q0Z4ue/RY4ZS3nIeL272KV8l9
	0kkMv63mw+d//7nqglllO878KlkYIRN4jfnmW7GXp7J5nfxnTcxi5dbd8UoqPPqSDa8N74fs
	4qUeOUosxRmJhlrMRcWJALjcXcFfAgAA
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
index 4118b3f959c3..f9f8091f354f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1339,6 +1339,7 @@ struct task_struct {
 #endif
 
 	struct tlbflush_unmap_batch	tlb_ubc;
+	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/mm/internal.h b/mm/internal.h
index c6483f73ec13..b34d9e627132 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1100,6 +1100,7 @@ extern struct workqueue_struct *mm_percpu_wq;
 void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
+void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -1110,6 +1111,9 @@ static inline void try_to_unmap_flush_dirty(void)
 static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 {
 }
+static inline void fold_ubc(struct tlbflush_unmap_batch *dst, struct tlbflush_unmap_batch *src)
+{
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..c37ff1648cf1 100644
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


