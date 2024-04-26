Return-Path: <linux-kernel+bounces-160180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0818B3A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125631F2457D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CE148FE0;
	Fri, 26 Apr 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D4g+WnOb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08B148831
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142715; cv=none; b=lTzKgyB34sQdo1nu5mPC2499EP6tIpszt0x4g0LmrzHCdPh738L5/qYBPg9HoUv7iHgleF/egd3WFt7A2XQor6boWBcnokCl27IpLAD+F9Iz4M9PenCKe+uA+TsqyUDFaMTrcL4Zvu1+kMqUyoMB/nnpUnUjTx025YSJRazbSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142715; c=relaxed/simple;
	bh=nMWKx35vFMzktdIGZuoIEs17uH263FtlfQQILCkbp34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAoHgQUv05ELy6f8GRo57I7lJpAvr+OkeBi1/uxlvJFgYpRXJu2P6BEoOAeg8APAwJKIcKmZEglTBr2THobGNLfBm9M5RsVLcGRn33yTJSsY/9yQIigWfrkoXZtAQBfnZfNvf/548bMcEAyBsjJSZE0hfJiOZwZ8aI5jxTfpkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D4g+WnOb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5xao1faSLSLg0StYuxJJ8KUL1V23wgo3qyoN0YuKNr8=; b=D4g+WnOba5ewplYbiUpqL0OM87
	0MRzHx47bxn/V4Qa5spqbIR364xnBh9JfepXuF8jyGySd8A8pZ+H6r2qYfEeuerd4sOtcKzqlYOVu
	AabUF3EG+/v1J2JfpwcqT9db+NpVdaNLwS3vJPSgOxAU2osU2MUTnnycIY8rA8HukYnKgSdcZ4L37
	E6oQejNp/b8yzkzlsHL1n5q6KiFl4wi2pfJekzlduFmafXG4LilZJC4IxIwOrx2q81lvyUa3baHKO
	wezsagK/b5j3avamBA5CmIZHXR79ukfVOcG463vBnwOioDbPKg2lZQ5S0VMZZ4Q4knXXJKIUN0q5a
	E1/1Wllw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mp2-00000005Pl2-103M;
	Fri, 26 Apr 2024 14:45:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/4] mm: Delay the check for a NULL anon_vma
Date: Fri, 26 Apr 2024 15:45:01 +0100
Message-ID: <20240426144506.1290619-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426144506.1290619-1-willy@infradead.org>
References: <20240426144506.1290619-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking the anon_vma early in the fault path where all page
faults pay the cost, delay it until we know we're going to need the
anon_vma to be filled in.  This will have a slight negative effect on the
first fault in an anonymous VMA, but it shortens every other page fault.
It also makes the code slightly cleaner as the anon and file backed
fault handling look more similar.

The Intel kernel test bot reports a 3x improvement in vm-scalability
throughput with the small-allocs-mt test.  This is clearly an extreme
situation that won't be replicated in any real-world workload, but it's
a nice win.

https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.com/

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/huge_memory.c |  6 ++++--
 mm/memory.c      | 29 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 19000fc2c43c..8261b5669397 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1057,11 +1057,13 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	gfp_t gfp;
 	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	vm_fault_t ret;
 
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return VM_FAULT_FALLBACK;
-	if (unlikely(anon_vma_prepare(vma)))
-		return VM_FAULT_OOM;
+	ret = vmf_anon_prepare(vmf);
+	if (ret)
+		return ret;
 	khugepaged_enter_vma(vma, vma->vm_flags);
 
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
diff --git a/mm/memory.c b/mm/memory.c
index 6647685fd3c4..7dc112d3a7e4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3214,6 +3214,21 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 	return VM_FAULT_RETRY;
 }
 
+/**
+ * vmf_anon_prepare - Prepare to handle an anonymous fault.
+ * @vmf: The vm_fault descriptor passed from the fault handler.
+ *
+ * When preparing to insert an anonymous page into a VMA from a
+ * fault handler, call this function rather than anon_vma_prepare().
+ * If this vma does not already have an associated anon_vma and we are
+ * only protected by the per-VMA lock, the caller must retry with the
+ * mmap_lock held.  __anon_vma_prepare() will look at adjacent VMAs to
+ * determine if this VMA can share its anon_vma, and that's not safe to
+ * do with only the per-VMA lock held for this VMA.
+ *
+ * Return: 0 if fault handling can proceed.  Any other value should be
+ * returned to the caller.
+ */
 vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -4434,8 +4449,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	/* Allocate our own private page. */
-	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
+	ret = vmf_anon_prepare(vmf);
+	if (ret)
+		return ret;
 	/* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault */
 	folio = alloc_anon_folio(vmf);
 	if (IS_ERR(folio))
@@ -5823,15 +5839,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_start_read(vma))
 		goto inval;
 
-	/*
-	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
-	 * This check must happen after vma_start_read(); otherwise, a
-	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
-	 * from its anon_vma.
-	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
-		goto inval_end_read;
-
 	/* Check since vm_start/vm_end might change before we lock the VMA */
 	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
 		goto inval_end_read;
-- 
2.43.0


