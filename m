Return-Path: <linux-kernel+bounces-142932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB418A323B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C841F25D22
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF382483;
	Fri, 12 Apr 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TewO1ChV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661481487C6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935176; cv=none; b=LBKRUOH/H6dYKokPKg/GwfLzXzAC8INXPKSf7zg2v+BMjxUaAI7/M8+7QF6VwNMNntIb7oExpOHeaX0CdM9eRL6+fXwjv3gn7UPHoEZuF/uXk8NR3VjKgKFO7p92lVXTL5oWHP9dg9T8BPBi4HV36L4rDgKiAO3jab87HCuTLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935176; c=relaxed/simple;
	bh=PbKlGesAILRM8egOcOsHeXdQ4cD9J0LY94ZDaOSVUjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQi/G/zEBYcsVhP7j14148+AyystykAm2oWXfaRil3YRoC9Nm6T/+luGN9YhH8VNCOtQVRMHiyoISKoCNmtVNspgdHBYrOaYLdcyYBx+BuutYhxT2LDI+t/PklniATfDefKonDG9peAmpsBZPUsd7GnOC+FCvgRklnpJ7CG/y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TewO1ChV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DGzof1GGkX+qr1HYb79Xnt9O/wZA8sRs08uMtKKlZes=; b=TewO1ChVJSortfw0EVN1FWaF3V
	9e+5Nf+DUlIDtfXF35qysW/QHL5h6l86zbSKK8tiO//XPCRMp0WElDoyREyQozRKrn25Hk39cgfL3
	HEOr1BhQOJnE57vhTbankwEpehQ915Qj4G05UmNRz4Ug71bCdM5s5pI8algyZzLZRH+53f2lmrys+
	pFhmYIbeK8rnh1BW2VZFcT6g57cEuMjBYCr1bOaJRAE1J5eVjptbuq09B3UTPq5GtO7u2eagLC8At
	BC5/WzWW6/A+77TP9+E18DBvv7/OD3gT7IOL4adO7BdO1JnNF04JQ52UaNlEC9MWy/Fe9MUwzOWeO
	C4oqdq3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvIgZ-00000009UqM-3aUy;
	Fri, 12 Apr 2024 15:19:27 +0000
Date: Fri, 12 Apr 2024 16:19:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
References: <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org>
 <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>

On Fri, Apr 12, 2024 at 09:53:29AM -0500, Suren Baghdasaryan wrote:
> Unless vmf_anon_prepare() already explains why vma->anon_vma poses a
> problem for per-vma locks, we should have an explanation there. This
> comment would serve that purpose IMO.

I'll do you one better; here's some nice kernel-doc for
vmd_anon_prepare():

commit f89a1cd17f13
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Fri Apr 12 10:41:02 2024 -0400

    mm: Delay the check for a NULL anon_vma
    
    Instead of checking the anon_vma early in the fault path where all page
    faults pay the cost, delay it until we know we're going to need the
    anon_vma to be filled in.  This will have a slight negative effect on the
    first fault in an anonymous VMA, but it shortens every other page fault.
    It also makes the code slightly cleaner as the anon and file backed
    fault handling look more similar.
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d8d2ed80b0bf..718f91f74a48 100644
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
index 6e2fe960473d..46b509c3bbc1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3213,6 +3213,21 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
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
@@ -4437,8 +4452,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
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
@@ -5821,15 +5837,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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

