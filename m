Return-Path: <linux-kernel+bounces-105553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358987E007
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D5BB20E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957561F94D;
	Sun, 17 Mar 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b92MQ+KJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEED1EF0D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710708409; cv=none; b=PzzGBCfC5Z8Rt8Fahfo46eSGGj/FCzo5kIBoA6QiWxHSeVPIo8YtbMNE5P0B+fnt5E9JAbwSD+RvYop42ynYd6to8Bd6/HnGMIqSTwOBp8b8vxT70BiklFAFqZi3VBr/4HqJz41h9Ehqd23U3+bEYRnAtiUPRnTn39x+a+YH2rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710708409; c=relaxed/simple;
	bh=MR/e1rNpFem2d28l9M1/gFdtZHul48yHvn/tMsBQq9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGPi8F1+GK1hR5cP+RxxIONpO8Ei/M6ozuqVC/qAJs13/Ww63xTkJ6B4GaJ+5gXBiXG4N5i0QQGRNTh5u3tQaPLt2nJEkqsHaoolY71GhZfpEWX4BqW3gKwNy4bgN4ViYZr38MfTYLVmUJpFFfHUoxIIsxxQ7lYljvu1P4LQNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b92MQ+KJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v6PWbj/mXZq7FDrSc1NJ3BLmb2CI422t7EcGhIN71c0=; b=b92MQ+KJGg4tspLYmBItbm4l83
	IkbCPvs2rjvKRjIPRJwzYv1dmMvG7WpuxZ/EEl3BaJYW9DUo1U7ZVIunZHp+7f/J16AhmNhl/VYli
	E7GYw/x3YBvKCcDtb6EFui+Tc6rgX3kI2+fNWRUNLWTiwmxG9ZrmoJ5tNgjzGbn09zr/nVTRuSDe9
	MgA4ci1rda8vUT3xsrQUJ/2mxgxOKsRGknRsch8ER4w3EDmU/2G8k1WUB6cQXOy9MZmLjTa1RtnFk
	TQgLY+pw7DChRU0ziEFKl9IjBaUPtd2iE8UMq6h+zlG7LJ8yHaj5jrLESfL+kUbncOwxW6AhoQdXS
	10xMDw+w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxOt-0000000FZ76-21n6;
	Sun, 17 Mar 2024 20:46:35 +0000
Date: Sun, 17 Mar 2024 20:46:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZfdWq0FLpCf3jY0g@casper.infradead.org>
References: <20240314083921.1146937-1-zhaoyang.huang@unisoc.com>
 <ZfRDJTrFJq3KSbIB@casper.infradead.org>
 <CAGWkznGiVrqMs9fX2WGG9QsfTm72ffFj-cWXSUo3azrgeBOgAg@mail.gmail.com>
 <ZfWzxOq7JupJtZtg@casper.infradead.org>
 <CAGWkznG8dAorMG_qRDe5+NH9H1gj8qFbif_v+ztEcjQVu-fjXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznG8dAorMG_qRDe5+NH9H1gj8qFbif_v+ztEcjQVu-fjXQ@mail.gmail.com>

On Sun, Mar 17, 2024 at 12:07:40PM +0800, Zhaoyang Huang wrote:
> Could it be this scenario, where folio comes from pte(thread 0), local
> fbatch(thread 1) and page cache(thread 2) concurrently and proceed
> intermixed without lock's protection? Actually, IMO, thread 1 also
> could see the folio with refcnt==1 since it doesn't care if the page
> is on the page cache or not.
> 
> madivise_cold_and_pageout does no explicit folio_get thing since the
> folio comes from pte which implies it has one refcnt from pagecache

Mmm, no.  It's implicit, but madvise_cold_or_pageout_pte_range()
does guarantee that the folio has at least one refcount.

Since we get the folio from vm_normal_folio(vma, addr, ptent);
we know that there is at least one mapcount on the folio.  refcount
is always >= mapcount.  Since we hold pte_offset_map_lock(), we
know that mapcount (and therefore refcount) cannot be decremented 
until we call pte_unmap_unlock(), which we don't do until we have
called folio_isolate_lru().

Good try though, took me a few minutes of looking at it to convince
myself that it was safe.

Something to bear in mind is that if the race you outline is real,
failing to hold a refcount on the folio leaves the caller susceptible
to the VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio); if the other
thread calls folio_put().

I can't understand any of the scenarios you outline below.
Please try again without relying on indentation.

> #thread 0(madivise_cold_and_pageout)        #1
> (lru_add_drain->fbatch_release_pages)
> #2(read_pages->filemap_remove_folios)
> refcnt == 1(represent page cache)
> 
> refcnt==2(another one represent LRU)
>    folio comes from page cache
> folio_isolate_lru
> release_pages
>                  filemap_free_folio
> 
> 
>                              refcnt==1(decrease the one of page cache)
> 
>  folio_put_testzero == true
> 
>   <No lruvec_del_folio>
> 
>  list_add(folio->lru, pages_to_free) //current folio will break LRU's
> integrity since it has not been deleted
> 
> In case of gmail's wrap, split above chart to two parts
> 
> #thread 0(madivise_cold_and_pageout)        #1
> (lru_add_drain->fbatch_release_pages)
> refcnt == 1(represent page cache)
> 
> refcnt==2(another one represent LRU)
> folio_isolate_lru                                               release_pages
> 
>  folio_put_testzero == true
> 
>   <No lruvec_del_folio>
> 
>  list_add(folio->lru, pages_to_free)
> 
>  //current folio will break LRU's integrity since it has not been
> deleted
> 
> #1 (lru_add_drain->fbatch_release_pages)
> #2(read_pages->filemap_remove_folios)
> refcnt==2(another one represent LRU)
>    folio comes from page cache
> release_pages
>                  filemap_free_folio
> 
>                             refcnt==1(decrease the one of page cache)
>  folio_put_testzero == true
>  <No lruvec_del_folio>
>  list_add(folio->lru, pages_to_free)
> //current folio will break LRU's integrity since it has not been deleted
> >
> > >    #0 folio_isolate_lru          #1 release_pages
> > > BUG_ON(!folio_refcnt)
> > >                                          if (folio_put_testzero())
> > >    folio_get(folio)
> > >    if (folio_test_clear_lru())

