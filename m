Return-Path: <linux-kernel+bounces-128308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0589591F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133E51F22E30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FFB134CDC;
	Tue,  2 Apr 2024 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2IN4t4h"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B6F133426
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073615; cv=none; b=a4JXSNKrHFY1a5OQqbJrEkuDfsQnwVGSBP3OAT2+6fgao3iZ187NstTUKdBMxoMnNt9D8SxROMm9+tUHmtVhKDzH06BhFKL7X2VIVMkR1q4ZuH+Eo1p5UGQSPrIHYIA2kFB1BYuf0Ol8DK06bTiR7ZMT04PcVxHeOWKfImQvbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073615; c=relaxed/simple;
	bh=glPQcANoMPYmlHAantIAhv8Mlq5+J3XDSxE2rm8p4n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9TcR3sREL39niR1u+PAb/fblT+syUC1ia8lFyVTV/Rh9Qt81YuaMaJqqbfkQbx7Yy524xxIcWoNsvCYv2K6x5WA/IQPoeY4wixYtMLCq4+mbgAqN+E5eamBC1/0mLV6qkaCtLos1MPRO+SyZEAFeH8UBGyH05bTEgmISt3XRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R2IN4t4h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J1C2/bPg/F9WrdiBHSYL5RX039VeHvKnxuGgTbDm1H0=; b=R2IN4t4he6Ikh2eCoolYn2D1ln
	bR/xnpgwp5nTMZdagY0yP7uhv+3h48ujjYE5yB9UplVKqXGoqHhQDFx6Jkksdob89JG3X92Toiy2n
	tpdQXC31wQj8/IoO4Y+ZlLIelTem8wG91gEnWIZCkA/fbYyUxmEHFosVKc03Os3c8PAmqwJMB0gB9
	hyAJUfPQ7tDBLByuN78X7TsKnwe4D8xS+YIdylZ9PDwDcfTzdsT+W4Zn0ntQp+aMaESEJLalvpLlI
	gcDIt6Sh0qyQ2cSKN8hyf81O7nNdTQGTV5wXPOX30EbVaeNoRNVmi6sGvQxqceiq9vEjpBDFFKqBe
	GnoA5Zzw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgYO-00000003OYG-2Yps;
	Tue, 02 Apr 2024 16:00:04 +0000
Date: Tue, 2 Apr 2024 17:00:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, peterx@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 13/13] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-ID: <ZgwrhKuypBtSpKdI@casper.infradead.org>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-14-peterx@redhat.com>
 <adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com>
 <5d9dd9a7-e544-4741-944c-469b79c2c649@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9dd9a7-e544-4741-944c-469b79c2c649@redhat.com>

On Tue, Apr 02, 2024 at 05:26:28PM +0200, David Hildenbrand wrote:
> > The oops trigger is at mm/gup.c:778:
> > VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
> > 
> > So 2M passed ok, and its failing for 32M, which is cont-pmd. I'm guessing you're trying to iterate 2M into a cont-pmd folio and ending up with an unexpected tail page?
> 
> I assume we find the expected tail page, it's just that the check
> 
> VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
> 
> Doesn't make sense with hugetlb folios. We might have a tail page mapped in
> a cont-pmd entry. As soon as we call follow_huge_pmd() on "not the first
> cont-pmd entry", we trigger this check.
> 
> Likely this sanity check must also allow for hugetlb folios. Or we should
> just remove it completely.
> 
> In the past, we wanted to make sure that we never get tail pages of THP from
> PMD entries, because something would currently be broken (we don't support
> THP > PMD).

That was a practical limitation on my part.  We have various parts of
the MM which assume that pmd_page() returns a head page and until we
get all of those fixed, adding support for folios larger than PMD_SIZE
was only going to cause trouble for no significant wins.

I agree with you we should get rid of this assertion entirely.  We should
fix all the places which assume that pmd_page() returns a head page,
but that may take some time.

As an example, filemap_map_pmd() has:

       if (pmd_none(*vmf->pmd) && folio_test_pmd_mappable(folio)) {
                struct page *page = folio_file_page(folio, start);
                vm_fault_t ret = do_set_pmd(vmf, page);

and then do_set_pmd() has:

        if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
                return ret;

so we'd simply refuse to use a PMD to map a folio larger than PMD_SIZE.
There's a lot of work to be done to make this work generally (not to
mention figuring out how to handle mapcount for such folios ;-).

This particular case seems straightforward though.  Just remove the
assertion.

