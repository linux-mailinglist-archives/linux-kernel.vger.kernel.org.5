Return-Path: <linux-kernel+bounces-116537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BE88A074
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE432C36D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8775806;
	Mon, 25 Mar 2024 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="exjU2ECM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFB24CE1B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711344282; cv=none; b=ROpR+W9hdQus5055qeFXWydIM3OqbDy8kY3yzw7g6v3P+wmNARytoG1oqGZQHwzrx8XpFC0Al+B3TF28HB44m04YuFek931kO1hsnKjbcKilRUUAChq3Tn9Dx1buRIDXDIxJJGWqOBYQCBtAQGcm2l+3Dvh9VGwOzErcdcHfIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711344282; c=relaxed/simple;
	bh=+I8XMdQ4NHe9kmLh9aD9Qoh7nAryb/Cqbe0MGF3wVrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfcz9w3b3WJOVVNGuzyQjnq02DYZNWfSVHpj6mL8Ef57hp/fYYwbycaXOy7EH6At6CQZcs8Ux1mf7qR2ed89EScC+tFSSE2t01bC8fWEqUBOZuiig9cfJ2HBUmhe6C/Va9j71ITdECLjwLdn0PA6OqXSRKFOq3m6oXZ2I+CJrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=exjU2ECM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WkG50pNPcUCBXYHBUiw48oCBdPvRGtbIEGmeVzsnW+I=; b=exjU2ECMqvCwhEIpfCbFQl7mqU
	QIYI1V5XtOEjgqkFKArMY61SBe5KyJNsqWRosKKt8h3y+ZxH9p3gb/WxyFakoslFQ/spqtKGYWOnw
	7nYh1QiCHphBgQ258s09BI6ZqpvSTJO81Q1BW7SL4BYYOC3reEfBLvgoex7pA9iNYIyFsTTbpf4HG
	3anWsTE6uD+EHH1OYIcVKeDp15zTOHrxhRJmb8wTHl1ixdNi4UE3Tn784vxSkvwFxoAqufeRpcDbg
	5mpg1UGlIojow7a3CKm0HonG3HfBnG2NZq8TwYQL3icKtEl08w0t5Jqhbhd2RO3Zf5lt6xw9HA15P
	EYTQAujw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rocp0-0000000FkWy-0660;
	Mon, 25 Mar 2024 05:24:34 +0000
Date: Mon, 25 Mar 2024 05:24:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vishal Moola <vishal.moola@gmail.com>,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [RFC] mm: page-flags.h: remove the bias against tail pages
Message-ID: <ZgEKkd9nc9rdfzCK@casper.infradead.org>
References: <20240325045519.222458-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325045519.222458-1-jhubbard@nvidia.com>

On Sun, Mar 24, 2024 at 09:55:19PM -0700, John Hubbard wrote:
> commit 1d798ca3f1643 ("mm: make compound_head() robust") added
> page->compound_head and the associated "unlikely" check for a tail page
> in compound_head():
> 
> 	if (unlikely(head & 1))
> 		return (struct page *) (head - 1);
> 	return page;
> 
> That worked nicely in 2015. However, in the 8.5 years since then, things
> have changed: folios and huge pages are heavily used, with more uses
> coming. See for example the various THP enhancements being proposed. And
> hugetlbfs remains alive and well. And large folios are being plumbed
> into everything.
> 
> With that in mind, remove the "unlikely" attribute when checking for a
> tail page in compound_head(), and let normal CPU branch prediction do
> what it may.

> Is this reasonable? I haven't gone out and gathered test data, because
> the original patch to create this just assumed that compound pages were
> uncommon, and so now it's time to stop making that assumption. I think
> that's sufficient reasoning here to leave out the compiler hint, right?

It's complicated.  On the one hand, it's "more likely" because there are
more tail pages than there are head pages or order-0 pages.  On the
other hand, a _lot_ of the time we call compound_head(), it's done with
a non-tail page because we tend to pass around head pages (eg,
pmd_page() on hugetlbfs, or looking up a folio in the page cache and
passing &folio->page to some function that's not yet converted.

On the third hand, does the compiler really do much with the annotation?

Before your patch:

    27d6:       a8 01                   test   $0x1,%al
    27d8:       75 02                   jne    27dc <clear_refs_pte_range+0x9c>
    27da:       eb 59                   jmp    2835 <clear_refs_pte_range+0xf5>
    27dc:       49 8b 44 24 08          mov    0x8(%r12),%rax
    27e1:       a8 01                   test   $0x1,%al
    27e3:       75 6f                   jne    2854 <clear_refs_pte_range+0x114>
    27e5:       eb 73                   jmp    285a <clear_refs_pte_range+0x11a>

With your patch:

    1ee6:       a8 01                   test   $0x1,%al
    1ee8:       75 02                   jne    1eec <clear_refs_pte_range+0x9c>
    1eea:       eb 5f                   jmp    1f4b <clear_refs_pte_range+0xfb>
    1eec:       49 8b 44 24 08          mov    0x8(%r12),%rax
    1ef1:       a8 01                   test   $0x1,%al
    1ef3:       75 50                   jne    1f45 <clear_refs_pte_range+0xf5>
    1ef5:       eb 6c                   jmp    1f63 <clear_refs_pte_range+0x113>

Looks pretty much the same.  bloat-o-meter says:

$ ./scripts/bloat-o-meter before.o after.o
add/remove: 0/0 grow/shrink: 2/4 up/down: 32/-48 (-16)
Function                                     old     new   delta
gather_stats.constprop                       730     753     +23
smaps_hugetlb_range                          635     644      +9
smaps_page_accumulate                        342     338      -4
clear_refs_pte_range                         339     328     -11
pagemap_hugetlb_range                        422     407     -15
smaps_pte_range                             1406    1388     -18
Total: Before=20066, After=20050, chg -0.08%

(I was looking at clear_refs_pte_range above).  This seems marginal.
The benefits of removing a call to compound_head are much less
ambiguous:

$ ./scripts/bloat-o-meter before.o .build/fs/proc/task_mmu.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-101 (-101)
Function                                     old     new   delta
clear_refs_pte_range                         339     238    -101
Total: Before=20066, After=19965, chg -0.50%

I'd describe that as replacing four calls to compound_head() with two:

-               page = pmd_page(*pmd);
+               folio = page_folio(pmd_page(*pmd));

                /* Clear accessed and referenced bits. */
                pmdp_test_and_clear_young(vma, addr, pmd);
-               test_and_clear_page_young(page);
-               ClearPageReferenced(page);
+               folio_test_clear_young(folio);
+               folio_clear_referenced(folio);
..
-               page = vm_normal_page(vma, addr, ptent);
-               if (!page)
+               folio = vm_normal_folio(vma, addr, ptent);
+               if (!folio)
                        continue;

                /* Clear accessed and referenced bits. */
                ptep_test_and_clear_young(vma, addr, pte);
-               test_and_clear_page_young(page);
-               ClearPageReferenced(page);
+               folio_test_clear_young(folio);
+               folio_clear_referenced(folio);

I'm not saying this patch is necessarily wrong, I just think it's
"not proven".

