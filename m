Return-Path: <linux-kernel+bounces-112019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5961A88743D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC21C21E35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15557F7ED;
	Fri, 22 Mar 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QVRAKzAU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7765D72F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711140500; cv=none; b=YfmUXdCVJCG/R6jS8fHPwSwjGeOTnpVzQz84nyuhrrE8sapmU9Pcr6/BEVBMjHKUjBb7Rm+FktkpF12zTqEwtnftUGxQG1pLZgPhjtduRR8tkTSVBml+lReNkMJleOXaqARmuREHW1v/DXeXWtrzQdQu6UeZzrnf1fhrp4iJRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711140500; c=relaxed/simple;
	bh=Uf9dSpYITp6bxdnwZZqCFp6GDVfEBgn7BjvTh1fsU0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q8UxtldhPo/87Woe/IKPnSn/l+p1cMzrr+5wVXFfO1hQov3GfG5lSqWQmN9laY178apDfrveNJpyfR4gATloX41KGklZaSsAaABUubcaoPk43KNLUTKALOpJiGKUZf4EqIZuqJOEd/QHOdGeoxPkyAOMEiNcUJxmcH940KY2bUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QVRAKzAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52B0C433C7;
	Fri, 22 Mar 2024 20:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711140499;
	bh=Uf9dSpYITp6bxdnwZZqCFp6GDVfEBgn7BjvTh1fsU0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QVRAKzAUPqWp2P8fFfJjymQCiqf8/IWwd1wmqWmnRlxsqAjKHpKVO/2FMY54BdYVe
	 MtuhTuaPMg1SbalsaWAguHK6KathmRCmewglEhgp1kUsqyLrxGR7rhkCkBiCs/cIST
	 Foh0xWAZf8YKEf1Z8kAQrZNZWmXaYiyM/6VzFqZo=
Date: Fri, 22 Mar 2024 13:48:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Matthew Wilcox
 <willy@infradead.org>, Rik van Riel <riel@surriel.com>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Axel Rasmussen <axelrasmussen@google.com>, Yang Shi
 <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, "Kirill A . Shutemov"
 <kirill@shutemov.name>, Andrew Jones <andrew.jones@linux.dev>, Vlastimil
 Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Christoph Hellwig <hch@infradead.org>,
 linux-riscv@lists.infradead.org, James Houghton <jthoughton@google.com>,
 David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrea Arcangeli <aarcange@redhat.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 12/12] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-Id: <20240322134818.9b312f77629f79fcf1564b6f@linux-foundation.org>
In-Reply-To: <20240321220802.679544-13-peterx@redhat.com>
References: <20240321220802.679544-1-peterx@redhat.com>
	<20240321220802.679544-13-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 18:08:02 -0400 peterx@redhat.com wrote:

> From: Peter Xu <peterx@redhat.com>
> 
> Now follow_page() is ready to handle hugetlb pages in whatever form, and
> over all architectures.  Switch to the generic code path.
> 
> Time to retire hugetlb_follow_page_mask(), following the previous
> retirement of follow_hugetlb_page() in 4849807114b8.
> 
> There may be a slight difference of how the loops run when processing slow
> GUP over a large hugetlb range on cont_pte/cont_pmd supported archs: each
> loop of __get_user_pages() will resolve one pgtable entry with the patch
> applied, rather than relying on the size of hugetlb hstate, the latter may
> cover multiple entries in one loop.
> 
> A quick performance test on an aarch64 VM on M1 chip shows 15% degrade over
> a tight loop of slow gup after the path switched.  That shouldn't be a
> problem because slow-gup should not be a hot path for GUP in general: when
> page is commonly present, fast-gup will already succeed, while when the
> page is indeed missing and require a follow up page fault, the slow gup
> degrade will probably buried in the fault paths anyway.  It also explains
> why slow gup for THP used to be very slow before 57edfcfd3419 ("mm/gup:
> accelerate thp gup even for "pages != NULL"") lands, the latter not part of
> a performance analysis but a side benefit.  If the performance will be a
> concern, we can consider handle CONT_PTE in follow_page().
> 
> Before that is justified to be necessary, keep everything clean and simple.
> 

mm/gup.c:33:21: warning: 'follow_hugepd' declared 'static' but never defined [-Wunused-function]
   33 | static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
      |                     ^~~~~~~~~~~~~

--- a/mm/gup.c~mm-gup-handle-hugepd-for-follow_page-fix
+++ a/mm/gup.c
@@ -30,10 +30,12 @@ struct follow_page_context {
 	unsigned int page_mask;
 };
 
+#ifdef CONFIG_HAVE_FAST_GUP
 static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 				  unsigned long addr, unsigned int pdshift,
 				  unsigned int flags,
 				  struct follow_page_context *ctx);
+#endif
 
 static inline void sanity_check_pinned_pages(struct page **pages,
 					     unsigned long npages)
_


This looks inelegant.

That's two build issues so far.  Please be more expansive in the
Kconfig variations when testing.  Especially when mucking with pgtable
macros.



