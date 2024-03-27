Return-Path: <linux-kernel+bounces-121283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8A88E4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B41C2AD89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD0A13D8B2;
	Wed, 27 Mar 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vnlu+KBx"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BB51311A7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542718; cv=none; b=atqfYBDOp/RMTkvu6CRA4PH/p+tvmbVrx1B5LzptsJKBazPpNfAwZtEE0hDhePd+BtEItfCjku418X6oIysnIYIeQByAdbMh8LTbxZ1OrY2JOG4s+h9EvkKU8/kmj57YBCZV6QUhDDlj9fu8GuIdRUx0Uhrs1br0fUQDXApJfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542718; c=relaxed/simple;
	bh=jI8j+Hk7jO97k2/0wPNbWPlKYub9zJxqLVA5E2Xe8+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeEAPyVuu4DqqVzsR+iBeASnRSF3BPMq9wuPJbthAZAhwxNehkV4mwC9QuvwF6ljY5Jmume8S9RqGpELs5aKcY18xUQQISTPvoYqGkv0VjYM5iYfpHCiNU/CDGIEzysAfktMcNlunT63rF/xrwfdeXGgU6Fg5qHZJl1zmRsjR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vnlu+KBx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NLZi73Xb4ep908R2UXV6rktiIulOxpZuvd/TS5KeEy4=; b=vnlu+KBxz0A/LWrNCJWqk+pOMj
	FqC3Hme8EZRafost80noqjORFBRzKICIGLAvtFPgVKInoFqzVbb2gB825R3qGetjUztfDMzH6RjFy
	RmuGURgTIWwtHoOo4P5VMwkcJe1iSxTbg4feNAf87bl4RKYxSTwq6YRr2pwyPO7ZFtdgZDc6S5Nej
	1AoZaOlltlgWw3JirOg9Q2jlR/u6lP2HODPT5J0t5pMZB2pEYhbJ1cY7YIG0AoRkpDHnDDSRIJ1ES
	NZSeiL9wxmjtgFnjaZs+PHZQDxgTWE+wf32ZAcozbJ//v14kiyVDGQSmp1n97hWkY4xKA4aHM+haC
	OixDqVuw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpSRZ-00000003qY9-10f2;
	Wed, 27 Mar 2024 12:31:49 +0000
Date: Wed, 27 Mar 2024 12:31:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZgQRtQ60mrvOUKXo@casper.infradead.org>
References: <Zfj_-LbiIsAVWcPX@casper.infradead.org>
 <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org>
 <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org>
 <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
 <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org>
 <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>

On Wed, Mar 27, 2024 at 09:25:59AM +0800, Zhaoyang Huang wrote:
> > Ignoring any other thread, you're basically saying that there's a
> > refcount imbalance here.  Which means we'd hit an assert (that folio
> > refcount went below zero) in the normal case where another thread wasn't
> > simultaneously trying to do anything.
> Theoretically Yes but it is rare in practice as aops->readahead will
> launch all pages to IO under most scenarios.

Rare, but this path has been tested.

> read_pages
>     aops->readahead[1]
> ...
>     while (folio = readahead_folio)[2]
>         filemap_remove_folio
> 
> IMO, according to the comments of readahead_page, the refcnt
> represents page cache dropped in [1] makes sense for two reasons, '1.
> The folio is going to do IO and is locked until IO done;2. The refcnt
> will be added back when found again from the page cache and then serve
> for PTE or vfs' while it doesn't make sense in [2] as the refcnt of
> page cache will be dropped in filemap_remove_folio
> 
>  * Context: The page is locked and has an elevated refcount.  The caller
>  * should decreases the refcount once the page has been submitted for I/O
>  * and unlock the page once all I/O to that page has completed.
>  * Return: A pointer to the next page, or %NULL if we are done.

Follow the refcount through.

In page_cache_ra_unbounded():

                folio = filemap_alloc_folio(gfp_mask, 0);
(folio has refcount 1)
                ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
(folio has refcount 2)

Then we call read_pages()
First we call ->readahead() which for some reason stops early.
Then we call readahead_folio() which calls folio_put()
(folio has refcount 1)
Then we call folio_get()
(folio has refcount 2)
Then we call filemap_remove_folio()
(folio has refcount 1)
Then we call folio_unlock()
Then we call folio_put()
(folio has refcount 0 and is freed)

Yes, other things can happen in there to increment the refcount, so this
folio_put() might not be the last put, but we hold the folio locked the
entire time, so many things which might be attempted will block on the
folio lock.  In particular, nobody can remove it from the page cache,
so its refcount cannot reach 0 until the last folio_put() of the
sequence.

