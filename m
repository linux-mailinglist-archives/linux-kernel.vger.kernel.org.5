Return-Path: <linux-kernel+bounces-105681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC8587E28F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495C31C20F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1F51EB21;
	Mon, 18 Mar 2024 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JAE4AHGL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B981DDF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732507; cv=none; b=XUjCgeCiD3mmmKNvWN+raoOtRAqrkW3uhmS23+Gr+KzddbJHHI5q0F1PqyRQ660X09gvvGsogREjeHAeJN4o07vj+iL7Ujfrx+rhOgEfZkEsMGicVrwDlb8ZUQgGAdbrT3gqw/NJZWhACl58/PE9ILp0c9dX5zzjUwST4FEjKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732507; c=relaxed/simple;
	bh=n+IvaFg5pDR8fyHm+L0s6tr64Pxcm4bGuDa/VfNWVXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2PRp8G6lfpAiVHy7g+tqOFFzOdtauohVrpGOoqzmTSuEQMyA6irEvCsp1COlJ1vyhOOeeoAriCHrzzDTZHE6TRjwSL32uz9D4i9LZMEz4EcaCpDdFHF3hynDUSzXU4eWpXoYs9mD2zUMb9LinHPa6Q2H1VMqGUICTC0jb9FDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JAE4AHGL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Mywcfnh5NNAq/uHuTcHdgmDU+e61uebZtDEUql6Qjmw=; b=JAE4AHGLLAA2zK2ofDzl5hLk36
	/+4V+3CniMhm7baMAv5R3LEgDXySCbFUc8wFAhzff4ybeXNCp+1u/D7iy9sF+zDr/5W9lHtHB3RSC
	cjrL9rNzpQuabd26vq4jFlTPKXQVR0G9U9b1Umfj+oEMDXjYsFEzGdFngM7HEN2AKklbpYfkofe28
	wYfVIVcLeKDE45So9YsTtH9LhnxC/gyTxiE0HUV0QHxd4/Za0rTExc5Gl9n+lQrI14SXT+DPjUkl3
	lT1dNIk5fsx5BUoXW3NnI0QtHavIVC5Q51QGk3BrUA/jj+NMdtTk6I+V5OoNcqSuGDopwL04KM7q/
	po/8tNzw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm3fW-0000000GDq7-21up;
	Mon, 18 Mar 2024 03:28:10 +0000
Date: Mon, 18 Mar 2024 03:28:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: reply: [PATCH] mm: fix a race scenario in folio_isolate_lru
Message-ID: <Zfe0yl2QTV1zSS1n@casper.infradead.org>
References: <b88ce9ecad0d456d8adbc78e42ec713a@BJMBX01.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b88ce9ecad0d456d8adbc78e42ec713a@BJMBX01.spreadtrum.com>

On Mon, Mar 18, 2024 at 01:37:04AM +0000, 黄朝阳 (Zhaoyang Huang) wrote:
> >On Sun, Mar 17, 2024 at 12:07:40PM +0800, Zhaoyang Huang wrote:
> >> Could it be this scenario, where folio comes from pte(thread 0), local
> >> fbatch(thread 1) and page cache(thread 2) concurrently and proceed
> >> intermixed without lock's protection? Actually, IMO, thread 1 also
> >> could see the folio with refcnt==1 since it doesn't care if the page
> >> is on the page cache or not.
> >>
> >> madivise_cold_and_pageout does no explicit folio_get thing since the
> >> folio comes from pte which implies it has one refcnt from pagecache
> >
> >Mmm, no.  It's implicit, but madvise_cold_or_pageout_pte_range()
> >does guarantee that the folio has at least one refcount.
> >
> >Since we get the folio from vm_normal_folio(vma, addr, ptent); we know that
> >there is at least one mapcount on the folio.  refcount is always >= mapcount.
> >Since we hold pte_offset_map_lock(), we know that mapcount (and therefore
> >refcount) cannot be decremented until we call pte_unmap_unlock(), which we
> >don't do until we have called folio_isolate_lru().
> >
> >Good try though, took me a few minutes of looking at it to convince myself that
> >it was safe.
> >
> >Something to bear in mind is that if the race you outline is real, failing to hold a
> >refcount on the folio leaves the caller susceptible to the
> >VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio); if the other thread calls
> >folio_put().
> Resend the chart via outlook.
> I think the problem rely on an special timing which is rare, I would like to list them below in timing sequence.
> 
> 1. thread 0 calls folio_isolate_lru with refcnt == 1

(i assume you mean refcnt == 2 here, otherwise none of this makes sense)

> 2. thread 1 calls release_pages with refcnt == 2.(IMO, it could be 1 as release_pages doesn't care if the folio is used by page cache or fs)
> 3. thread 2 decrease refcnt to 1 by calling filemap_free_folio.(as I mentioned in 2, thread 2 is not mandatary here)
> 4. thread 1 calls folio_put_testzero and pass.(lruvec->lock has not been take here)

But there's already a bug here.

Rearrange the order of this:

2. thread 1 calls release_pages with refcount == 2 (decreasing refcount to 1)
3. thread 2 decrease refcount to 0 by calling filemap_free_folio
1. thread 0 calls folio_isolate_lru() and hits the BUG().

> 5. thread 0 clear folio's PG_lru by calling folio_test_clear_lru. The folio_get behind has no meaning there.
> 6. thread 1 failed in folio_test_lru and leave the folio on the LRU.
> 7. thread 1 add folio to pages_to_free wrongly which could break the LRU's->list and will have next folio experience list_del_invalid
> 
> #thread 0(madivise_cold_and_pageout)        #1(lru_add_drain->fbatch_release_pages)       #2(read_pages->filemap_remove_folios)
> refcnt == 1(represent page cache)             refcnt==2(another one represent LRU)          folio comes from page cache

This is still illegible.  Try it this way:

Thread 0	Thread 1	Thread 2
madvise_cold_or_pageout_pte_range
		lru_add_drain
		fbatch_release_pages
				read_pages
				filemap_remove_folio

Some accuracy in your report would also be appreciated.  There's no
function called madivise_cold_and_pageout, nor is there a function called
filemap_remove_folios().  It's a little detail, but it's annoying for
me to try to find which function you're actually referring to.  I have
to guess, and it puts me in a bad mood.

At any rate, these three functions cannot do what you're proposing.
In read_page(), when we call filemap_remove_folio(), the folio in
question will not have the uptodate flag set, so can never have been
put in the page tables, so cannot be found by madvise().

Also, as I said in my earlier email, madvise_cold_or_pageout_pte_range()
does guarantee that the refcount on the folio is held and can never
decrease to zero while folio_isolate_lru() is running.  So that's two
ways this scenario cannot happen.


