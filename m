Return-Path: <linux-kernel+bounces-160120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBDE8B3963
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C4F1C23CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21391148313;
	Fri, 26 Apr 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VD+4bGCK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B3146D69
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140056; cv=none; b=U6kdyXwYw7tT0jlo8+Jo0fIlo+NJsZBpzLAmkcBojsfP6/vCeIg9yFdHREpDIaYlvr7ux/PLke6ypE8mpRgJYtqxT3M+36ssNhRBPRGmoH3hNKsy7Vmbwh4Ye4BZUAf1QRW5YgJY/DZPLW3RjoIJeG3tPUMFItKcvvkygDoUG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140056; c=relaxed/simple;
	bh=XG/ITZHUHRwOx7mOZq0RfxiHJeiT1Z7hpVSrLorAzHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGqXXOaK6kBSl9zqUU0uLfKGQxL192xn1DneC5amRYwFtK7EA2aGOIydoEt/gi7LKUYML+KnCm7dXfldw2vYlO5WKZKKJxreBPMlWaChlnyWnSJ0ME+oG3JTs/J18ATIYeYcJ9AYoYySqzKRAatYGjKQNshX2dhBI0PisHYgMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VD+4bGCK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ozktkBb65QqgX3MHrht7P71tJ771tCL0v98m2ZOYQyg=; b=VD+4bGCKYLvG+aIbvzz6Nmz2r7
	O40nBwFLoq/L5Dc7DIbY3oxbli0QlzmSFEe9PcV0ma4OpAa9i1NOf4Udt4IGxvoNsCPY5XfeuF2kl
	Rrv0YnRtYwJEXCD4NSk3eVUpTk4eVrjJomf8KZFzvmK5ioEW2gZ7rottPPUdBvwqywc8n+MCn3r3q
	xxNHFs4QFF+Rg3ZNetkZAHkW4SrfHfOXQW+vyOYEJv8ktcrzqw/Tls/IQLtbEIp/0vbd6X+I1gzuO
	fzRS/lz74+3mindtdyOVDM3n+ZsL2Yyywu1dSiW4Xm+0jQ/uTOm8jQoIwbuivUWYB5EGImXnuDaaO
	6KVbYEEg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0M82-00000005Kll-2grR;
	Fri, 26 Apr 2024 14:00:42 +0000
Date: Fri, 26 Apr 2024 15:00:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZiuzikG6-jDpbitv@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhinCD-PoblxGFm0@casper.infradead.org>

On Fri, Apr 12, 2024 at 04:14:16AM +0100, Matthew Wilcox wrote:
> Suren, what would you think to this?
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6e2fe960473d..e495adcbe968 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5821,15 +5821,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>         if (!vma_start_read(vma))
>                 goto inval;
> 
> -       /*
> -        * find_mergeable_anon_vma uses adjacent vmas which are not locked.
> -        * This check must happen after vma_start_read(); otherwise, a
> -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
> -        * from its anon_vma.
> -        */
> -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> -               goto inval_end_read;
> -
>         /* Check since vm_start/vm_end might change before we lock the VMA */
>         if (unlikely(address < vma->vm_start || address >= vma->vm_end))
>                 goto inval_end_read;
> 
> That takes a few insns out of the page fault path (good!) at the cost
> of one extra trip around the fault handler for the first fault on an
> anon vma.  It makes the file & anon paths more similar to each other
> (good!)
> 
> We'd need some data to be sure it's really a win, but less code is
> always good.

Intel's 0day got back to me with data and it's ridiculously good.
Headline figure: over 3x throughput improvement with vm-scalability
https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.com/

I can't see why it's that good.  It shouldn't be that good.  I'm
seeing big numbers here:

      4366 ±  2%    +565.6%      29061        perf-stat.overall.cycles-between-cache-misses

and the code being deleted is only checking vma->vm_ops and
vma->anon_vma.  Surely that cache line is referenced so frequently
during pagefault that deleting a reference here will make no difference
at all?

We've clearly got an inlining change.  viz:

     72.57           -72.6        0.00        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     73.28           -72.6        0.70        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     72.55           -72.5        0.00        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     69.93           -69.9        0.00        perf-profile.calltrace.cycles-pp.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     69.12           -69.1        0.00        perf-profile.calltrace.cycles-pp.down_read_killable.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     68.78           -68.8        0.00        perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault
     65.78           -65.8        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma.do_user_addr_fault
     65.43           -65.4        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read_killable.lock_mm_and_find_vma

     11.22           +86.5       97.68        perf-profile.calltrace.cycles-pp.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.14           +86.5       97.66        perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      3.17 ±  2%     +94.0       97.12        perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      3.45 ±  2%     +94.1       97.59        perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00           +98.2       98.15        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +98.2       98.16        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe

so maybe the compiler has been able to eliminate some loads from
contended cachelines?

    703147           -87.6%      87147 ±  2%  perf-stat.ps.context-switches
    663.67 ±  5%   +7551.9%      50783        vm-scalability.time.involuntary_context_switches
 1.105e+08           -86.7%   14697764 ±  2%  vm-scalability.time.voluntary_context_switches

indicates to me that we're taking the mmap rwsem far less often (those
would be accounted as voluntary context switches).

So maybe the cache miss reduction is a consequence of just running for
longer before being preempted.

I still don't understand why we have to take the mmap_sem less often.
Is there perhaps a VMA for which we have a NULL vm_ops, but don't set
an anon_vma on a page fault?

