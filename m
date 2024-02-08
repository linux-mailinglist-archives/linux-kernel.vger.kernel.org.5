Return-Path: <linux-kernel+bounces-58306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652584E44D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BEBB2566C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DCA7CF30;
	Thu,  8 Feb 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1n35/Xb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CF7CF25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407392; cv=none; b=AbBzKGgeZ5dNbr6By51o4h61RM5Vk71bYHIt6Hm0FSFCbjA4bCCgElOXODEiCdc8EWh1VGp6F/4w89b10H8ZR9LyqPskKe8gqKR/SO2ssMh7W6Df0xgZx0Hbi6xH4NiAS+YCsIBVI4CZhi4SOrAeLkX+i2VgQRDsJlK6IxsMwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407392; c=relaxed/simple;
	bh=f7FZTavM5z9s58ex+Gn9/33x91BrlHzsgkmIXYgOYjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKDimYVzrRJvDwncoWj9UInswp8Tu97Xy/NpD/Rpl4JlmqBNxod86klAqAITVOK0yY1+CIShi21yEZNDvzPO5TsDQAApt74kFHmAaQYZxjqRd2U7WpYAEPR80IAJtUBMawb+IA8ODkTOFVclZkd5pEWGj2+7fmDZW/A4heipHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I1n35/Xb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8InSULzEnAUdTmpoS9ssOSUDssOveuEGasLQle1XQDo=; b=I1n35/Xb45Ef2i3G6zJeGZvJLL
	2p56uybAIe4VSFtYe86EqxUETFwtdvR1K/Fs0zdFCxx57C3ijm9mYLYmtFLKdrVv9STMmy5qhXzCM
	AytuRSdktCqe0Kodheq6f+vLkrfdZy0zsszB6Fk+3d1yPXzYDzXUmTu3jL6e7ieytvZSBzlWh5c9w
	XGjbLu/1GSMLVVS4iPoMpoB7sRU+C3nVLCLsisFFZXqBIg2n+QZKnS4bCNuQjpZe4A9gIZhTeblTs
	3kBr0Zcd+5Ocm5lz5SpvtggG3Ipaz3A4b9v+ZeZjAiSvhdrzQ6v/05JApQCmBSqqDwc0X4ZksIDe4
	4/Jb95kg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY6ea-00000000b9S-16ZY;
	Thu, 08 Feb 2024 15:49:32 +0000
Date: Thu, 8 Feb 2024 15:49:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jane Chu <jane.chu@oracle.com>
Cc: Will Deacon <will@kernel.org>, Nanyong Sun <sunnanyong@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>, muchun.song@linux.dev,
	akpm@linux-foundation.org, anshuman.khandual@arm.com,
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Message-ID: <ZcT4DH7VE1XLBvVc@casper.infradead.org>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com>
 <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck>
 <ZcOQ-0pzA16AEbct@casper.infradead.org>
 <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com>

On Wed, Feb 07, 2024 at 06:24:52PM -0800, Jane Chu wrote:
> On 2/7/2024 6:17 AM, Matthew Wilcox wrote:
> > While this array of ~512 pages have been allocated to hugetlbfs, and one
> > would think that there would be no way that there could still be
> > references to them, another CPU can have a pointer to this struct page
> > (eg attempting a speculative page cache reference or
> > get_user_pages_fast()).  That means it will try to call
> > atomic_add_unless(&page->_refcount, 1, 0);
> > 
> > Actually, I wonder if this isn't a problem on x86 too?  Do we need to
> > explicitly go through an RCU grace period before freeing the pages
> > for use by somebody else?
> > 
> Sorry, not sure what I'm missing, please help.

Having written out the analysis, I now think it can't happen on x86,
but let's walk through it because it's non-obvious (and I think it
illustrates what people are afraid of on Arm).

CPU A calls either get_user_pages_fast() or __filemap_get_folio().
Let's do the latter this time.

        folio = filemap_get_entry(mapping, index);
filemap_get_entry:
	rcu_read_lock();
        folio = xas_load(&xas);
        if (!folio_try_get_rcu(folio))
                goto repeat;
        if (unlikely(folio != xas_reload(&xas))) {
                folio_put(folio);
                goto repeat;
        }
folio_try_get_rcu:
	folio_ref_try_add_rcu(folio, 1);
folio_ref_try_add_rcu:
        if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
                /* Either the folio has been freed, or will be freed. */
                return false;
folio_ref_add_unless:
        return page_ref_add_unless(&folio->page, nr, u);
page_ref_add_unless:
	atomic_add_unless(&page->_refcount, nr, u);

A rather deep callchain there, but for our purposes the important part
is: we take the RCU read lock, we look up a folio, we increment its
refcount if it's not zero, then check that looking up this index gets
the same folio; if it doesn't, we decrement the refcount again and retry
the lookup.

For this analysis, we can be preempted at any point after we've got the
folio pointer from xa_load().

> From hugetlb allocation perspective,  one of the scenarios is run time
> hugetlb page allocation (say 2M pages), starting from the buddy allocator
> returns compound pages, then the head page is set to frozen, then the
> folio(compound pages) is put thru the HVO process, one of which is
> vmemmap_split_pmd() in case a vmemmap page is a PMD page.
> 
> Until the HVO process completes, none of the vmemmap represented pages are
> available to any threads, so what are the causes for IRQ threads to access
> their vmemmap pages?

Yup, this sounds like enough, but it's not.  The problem is the person
who's looking up the folio in the pagecache under RCU.  They've got
the folio pointer and have been preempted.  So now what happens to our
victim folio?

Something happens to remove it from the page cache.  Maybe the file is
truncated, perhaps vmscan comes along and kicks it out.  Either way, it's
removed from the xarray and gets its refcount set to 0.  If the lookup
were to continue at this time, everything would be fine because it would
see a refcount of 0 and not increment it (in page_ref_add_unless()).
And this is where my analysis of RCU tends to go wrong, because I only
think of interleaving event A and B.  I don't think about B and then C
happening before A resumes.  But it can!  Let's follow the journey of
this struct page.

Now that it's been removed from the page cache, it's allocated by hugetlb,
as you describe.  And it's one of the tail pages towards the end of
the 512 contiguous struct pages.  That means that we alter vmemmap so
that the pointer to struct page now points to a different struct page
(one of the earlier ones).  Then the original page of vmemmap containing
our lucky struct page is returned to the page allocator.  At this point,
it no longer contains struct pages; it can contain literally anything.

Where my analysis went wrong was that CPU A _no longer has a pointer
to it_.  CPU A has a pointer into vmemmap.  So it will access the
replacement struct page (which definitely has a refcount 0) instead of
the one which has been freed.  I had thought that CPU A would access the
original memory which has now been allocated to someone else.  But no,
it can't because its pointer is virtual, not physical.


---

Now I'm thinking more about this and there's another scenario which I
thought might go wrong, and doesn't.  For 7 of the 512 pages which are
freed, the struct page pointer gathered by CPU A will not point to a
page with a refcount of 0.  Instead it will point to an alias of the
head page with a positive refcount.  For those pages, CPU A will see
folio_try_get_rcu() succeed.  Then it will call xas_reload() and see
the folio isn't there any more, so it will call folio_put() on something
which used to be a folio, and isn't any more.

But folio_put() calls folio_put_testzero() which calls put_page_testzero()
without asserting that the pointer is actually to a folio.
So everything's fine, but really only by coincidence; I don't think
anybody's thought about this scenario before (maybe Muchun has, but I
don't remember it being discussed).

