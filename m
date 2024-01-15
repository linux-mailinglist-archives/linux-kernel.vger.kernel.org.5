Return-Path: <linux-kernel+bounces-26160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340BC82DC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E14B218D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E20175BF;
	Mon, 15 Jan 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNuSjlCh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C7175B7;
	Mon, 15 Jan 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h1zJVN/StgdtGJ+KvowsDPSUZpuVAQLtb4Gk0WK6sxU=; b=aNuSjlChQOa5cvpTN5zXyWQTQs
	P71JqXtroWZ63bfc4xkj1dF/AqNZArT6Ohf9opFouJrwod6mEL/QCECd9A9YiOByYWqgANJ51MIxB
	NgXvJ/qbRyEMsKUE9ANEEQ7t2ColgxlZ4X0DEfa49MW/SxKD7E+r070K/jdaiWDyfeuKfrwawA2kP
	iZjdPET9Nz5F9Qy5Z7jiU2Zh2n46cyC8T8UlIRO0F1ZU5nsjzRaXDfz6j4hEKg3CYr31HCVmHlAyE
	0Ws04qhwYB6ZOVBBRVziJCG/yrQWDb+ULrqYDN3TbwGGi0G3UdAfNyBxsA1i3pPGVZMlR7Co49WoH
	7LK+S/Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPOZO-00A0HG-59; Mon, 15 Jan 2024 15:08:10 +0000
Date: Mon, 15 Jan 2024 15:08:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, usama.anjum@collabora.com,
	jiaqiyan@google.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
	shy828301@gmail.com, jthoughton@google.com, jane.chu@oracle.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: mm/memory-failure.c: fix
 hugetlbfs hwpoison handling
Message-ID: <ZaVKWox1/yTLThma@casper.infradead.org>
References: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
 <03168121-080f-41e4-a242-02638f5787f7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03168121-080f-41e4-a242-02638f5787f7@linux.dev>

On Mon, Jan 15, 2024 at 08:02:51PM +0800, Muchun Song wrote:
> On 2024/1/13 02:08, Sidhartha Kumar wrote:
> > has_extra_refcount() makes the assumption that the page cache adds a ref
> > count of 1 and subtracts this in the extra_pins case. Commit a08c7193e4f1
> > (mm/filemap: remove hugetlb special casing in filemap.c) modifies
> > __filemap_add_folio() by calling folio_ref_add(folio, nr); for all cases
> > (including hugtetlb) where nr is the number of pages in the folio. We
> > should adjust the number of references coming from the page cache by
> > subtracing the number of pages rather than 1.
> > 
> > In hugetlbfs_read_iter(), folio_test_has_hwpoisoned() is testing the wrong
> > flag as, in the hugetlb case, memory-failure code calls
> > folio_test_set_hwpoison() to indicate poison. folio_test_hwpoison() is the
> > correct function to test for that flag.
> > 
> > After these fixes, the hugetlb hwpoison read selftest passes all cases.
> > 
> > Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
> > Closes: https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/T/#m8e1469119e5b831bbd05d495f96b842e4a1c5519
> > Cc: <stable@vger.kernel.org> # 6.7+
> > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> > 
> > v1 -> v2:
> >      move ref_count adjustment to if(extra_pins) block as that represents
> >      ref counts from the page cache per Miaohe Lin.
> > 
> >   fs/hugetlbfs/inode.c | 2 +-
> >   mm/memory-failure.c  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 36132c9125f9..3a248e4f7e93 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >   		} else {
> >   			folio_unlock(folio);
> > -			if (!folio_test_has_hwpoisoned(folio))
> > +			if (!folio_test_hwpoison(folio))
> >   				want = nr;
> >   			else {
> >   				/*
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index d8c853b35dbb..ef7ae73b65bd 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -976,7 +976,7 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
> >   	int count = page_count(p) - 1;
> >   	if (extra_pins)
> > -		count -= 1;
> > +		count -= folio_nr_pages(page_folio(p));
> 
> IIUC, It seems than this also fix shmem of THP, because has_extra_refcount()
> is called
> from me_pagecache_clean(), right?

Usually we split THPs before we get to this point, but we always poison
an entire hugetlb page.  This should probably change, but it's not high
on my list of things to do.

