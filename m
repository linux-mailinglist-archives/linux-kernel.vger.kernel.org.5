Return-Path: <linux-kernel+bounces-142956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C08A3280
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A051C24173
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D91482E2;
	Fri, 12 Apr 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNLlyNlB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DB82483
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935911; cv=none; b=Ylp3KR+ZfQtrdznliX1ohzZPfFtIYD1UMXtLMC4NUI+YQWL3Y6CsoTp37lzFE3tU1qwDOdgatAtu2roYEiKjqtgvMee42WptDJAtOxdS18J/r7fBPPqLiJrdG24RrpuARSMq6ezYSiCWRLrYKM92HyipEzOgzow1XgEV/J+uPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935911; c=relaxed/simple;
	bh=fxOsyAZN/Y0EBYA8XDAHlVF82X1Qljg2usjjioUiscU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q20YydzX8F8xPmafZ7c4+yE2p7C5jmJyRWMFJYOY+u/8gTDJDZHOTOwP5rm9fYVJEK7vAq24Zu3PTNVMlwC7JCLCqeQhBT51GulEsnY6Ll2wPNyQ23y/T/9Zi4WVjhT2xl+zFyDaWG3zT6nJdH8a8jskJ6GFzMvcjsEvJXSPoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fNLlyNlB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uCkSvQiw+ysUllFREDR3X8kNT4uKsvHC3oW/1LGjanA=; b=fNLlyNlBnYqv3CMRBqfQuNVJf/
	eTdhwFvoaxLFmRnwC5vSQh9pl9DxW6gOJ8hsiC5rgI55seYENfyz+kKjQzYeM0aq8c0s+5o6pFNPA
	zQr9ytQzdq+AaXbM0u8fM95dqCV2edxmNT3ElktITHE4e19eRa+21L0K9YDmwFfYm3m9kTwOWeJg+
	3Rd/1tYh4e//iwdxF0qI/EUS3OKILXCxDVVAQIDKyIYsomyIIt3B0/kyGhw3FqUe3XAF+/7COcyhU
	0mTGzFXysy/R2cEv9dHCNqm1DhsMXnMd+rhiTp7rFKqyCszLeqbF5eqMAVX1Ect0kpdlEX3B8tNuU
	Cq2PP9vw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvIsT-00000009WUb-0bj9;
	Fri, 12 Apr 2024 15:31:45 +0000
Date: Fri, 12 Apr 2024 16:31:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhlT4eG05mUcOQQJ@casper.infradead.org>
References: <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
 <ZhlCVOz7qaDtldfL@casper.infradead.org>
 <CAJuCfpGGUD6ev-KFhON2D2RqQRZSgjxFXvkNqeux-LrJw4L+iw@mail.gmail.com>
 <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhlQ_4Ve0vYNbWbl@casper.infradead.org>

On Fri, Apr 12, 2024 at 04:19:27PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 12, 2024 at 09:53:29AM -0500, Suren Baghdasaryan wrote:
> > Unless vmf_anon_prepare() already explains why vma->anon_vma poses a
> > problem for per-vma locks, we should have an explanation there. This
> > comment would serve that purpose IMO.
> 
> I'll do you one better; here's some nice kernel-doc for
> vmd_anon_prepare():

And here's a followup patch to fix some minor issues in uffd.

 - Rename lock_vma() to uffd_lock_vma() because it really is uffd
   specific.
 - Remove comment referencing unlock_vma() which doesn't exist.
 - Fix the comment about lock_vma_under_rcu() which I just made
   incorrect.

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f6267afe65d1..a32171158c38 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -56,17 +56,16 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
 
 #ifdef CONFIG_PER_VMA_LOCK
 /*
- * lock_vma() - Lookup and lock vma corresponding to @address.
+ * uffd_lock_vma() - Lookup and lock vma corresponding to @address.
  * @mm: mm to search vma in.
  * @address: address that the vma should contain.
  *
- * Should be called without holding mmap_lock. vma should be unlocked after use
- * with unlock_vma().
+ * Should be called without holding mmap_lock.
  *
  * Return: A locked vma containing @address, -ENOENT if no vma is found, or
  * -ENOMEM if anon_vma couldn't be allocated.
  */
-static struct vm_area_struct *lock_vma(struct mm_struct *mm,
+static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 				       unsigned long address)
 {
 	struct vm_area_struct *vma;
@@ -74,9 +73,8 @@ static struct vm_area_struct *lock_vma(struct mm_struct *mm,
 	vma = lock_vma_under_rcu(mm, address);
 	if (vma) {
 		/*
-		 * lock_vma_under_rcu() only checks anon_vma for private
-		 * anonymous mappings. But we need to ensure it is assigned in
-		 * private file-backed vmas as well.
+		 * We know we're going to need to use anon_vma, so check
+		 * that early.
 		 */
 		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
 			vma_end_read(vma);
@@ -107,7 +105,7 @@ static struct vm_area_struct *uffd_mfill_lock(struct mm_struct *dst_mm,
 {
 	struct vm_area_struct *dst_vma;
 
-	dst_vma = lock_vma(dst_mm, dst_start);
+	dst_vma = uffd_lock_vma(dst_mm, dst_start);
 	if (IS_ERR(dst_vma) || validate_dst_vma(dst_vma, dst_start + len))
 		return dst_vma;
 
@@ -1437,7 +1435,7 @@ static int uffd_move_lock(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int err;
 
-	vma = lock_vma(mm, dst_start);
+	vma = uffd_lock_vma(mm, dst_start);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
@@ -1452,7 +1450,7 @@ static int uffd_move_lock(struct mm_struct *mm,
 	}
 
 	/*
-	 * Using lock_vma() to get src_vma can lead to following deadlock:
+	 * Using uffd_lock_vma() to get src_vma can lead to following deadlock:
 	 *
 	 * Thread1				Thread2
 	 * -------				-------
@@ -1474,7 +1472,7 @@ static int uffd_move_lock(struct mm_struct *mm,
 	err = find_vmas_mm_locked(mm, dst_start, src_start, dst_vmap, src_vmap);
 	if (!err) {
 		/*
-		 * See comment in lock_vma() as to why not using
+		 * See comment in uffd_lock_vma() as to why not using
 		 * vma_start_read() here.
 		 */
 		down_read(&(*dst_vmap)->vm_lock->lock);

