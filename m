Return-Path: <linux-kernel+bounces-123044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F7890166
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BEA1F248D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD48172F;
	Thu, 28 Mar 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aSw1bPJv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC17E10C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635183; cv=none; b=cmyGH4YN1WGyGc520OB4paNwqf4aXNgGKWxaOO905EFho2ebBKTp+H5+TqhFN/lqH8kJ0TCqG3+cYmnr8HpTn0MuhnskmLo6bGPwEybFn6WPzIM4qmWCCm380h67QqVVmpjz36xUNeabGUcgXUP7FqDJmhSwGpHcz61WbyhL8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635183; c=relaxed/simple;
	bh=vGm+HT3Ib63mObN1zAwD7VdLLJDq+gJbUTgKUnwQ6JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjswDX1HR1U8uLs8n21fmuG94MpIQap34jVNg4JDIOQAbO7bjBVNuWQ9r1mKvUBHl5tckCD/tPR1rEmW1lyZVDItjCF4KFd9p8xFl/plKhfRzZaeALneV0xyNRW1geDxaN7GKEM8rOPNu89FYY5pkpsZWoqbz77hX2h1VhEgJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aSw1bPJv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6M0JjTgPpVxG5fBfSzA5TFEpVDFwxFOSbAPU01cFVuA=; b=aSw1bPJv1K6haWj1FpTAbHPJMN
	Eu+x2QWdUimWeLeVSyrDjrdFbBU/WWogT56C+BfDLR2Wy8mRXog1B60RFetdRlNMSvdjnkDxCM+ZP
	RxcO2FD6tdf0QZwGMkE4seB1rFn8a2xohtovgS/6g/7CjQNCAR57mhULH0F8+6DfkhA6kaYcz8RtK
	o0OvHvRXvkmIpYfwBXxZSAS8R0DCHnmlgeMi9KsjRFQljYteX8hjf0y9UTrMlfX0stBASwAMlfK+g
	74rzUrv3VNaV8MlUaKb/JSKQ4SNyK1Mkd0eZ7gUmX/voOKpQ/+RmLDBHBw4gXLBMrdpGV+UbWJy40
	zTs+5jrA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpqUv-00000006UyX-43Jl;
	Thu, 28 Mar 2024 14:12:53 +0000
Date: Thu, 28 Mar 2024 14:12:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
Message-ID: <ZgV65ercduTnVWCA@casper.infradead.org>
References: <Zfz4_GJAHRInB8ul@casper.infradead.org>
 <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
 <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org>
 <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
 <ZgQRtQ60mrvOUKXo@casper.infradead.org>
 <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>
 <ZgThg-pzQzRl3ckF@casper.infradead.org>
 <CAGWkznEMCXQSe10E-pbdxk2uFgQO038wH6g=iojtSU6-N+GJdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznEMCXQSe10E-pbdxk2uFgQO038wH6g=iojtSU6-N+GJdg@mail.gmail.com>

On Thu, Mar 28, 2024 at 12:03:02PM +0800, Zhaoyang Huang wrote:
> On Thu, Mar 28, 2024 at 11:18 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Mar 28, 2024 at 09:27:31AM +0800, Zhaoyang Huang wrote:
> > > ok, I missed the refcnt from alloc_pages. However, I still think it is
> > > a bug to call readahead_folio in read_pages as the refcnt obtained by
> > > alloc_pages should be its final guard which is paired to the one which
> > > checked in shrink_folio_list->__remove_mapping->folio_ref_freeze(2)(this
> > > 2 represent alloc_pages & page cache). If we removed this one without
> >
> > __remove_mapping()  requires that the caller holds the folio locked.
> > Since the readahead code unlocks the folio, __remove_mapping() cannot
> > be run because the caller of __remove_mapping() will wait for the folio
> > lock.
> repost the whole timing sequence to make it more clear and fix
> incorrect description of previous feedback

I can't understand what you think the problem is here.  Please try
again.

> Follow the refcount through.
> 
> In page_cache_ra_unbounded():
> 
>                 folio = filemap_alloc_folio(gfp_mask, 0);
> (folio has refcount 1)
>                 ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
> (folio has refcount 2, PG_lru)
> 
> Then we call read_pages()
> First we call ->readahead() which for some reason stops early.
> Then we call readahead_folio() which calls folio_put()
> (folio has refcount 1)
> Then we call folio_get()
> (folio has refcount 2)
> Then we call filemap_remove_folio()
> (folio has refcount 1)
> Then we call folio_unlock()
> Then we call folio_put()
> 
> Amending steps for previous timing sequence below where [1] races with
> [2] that has nothing to do with __remove_mapping(). IMO, no file_folio
> should be freed by folio_put as the refcnt obtained by alloc_pages
> keep it always imbalanced until shrink_folio_list->__remove_mapping,
> where the folio_ref_freeze(2) implies the refcnt of alloc_pages and
> isolation should be the last two. release_pages is a special scenario
> that the refcnt of alloc_pages is freed implicitly in
> delete_from_page_cache_batch->filemap_free_folio.
> 
>     folio_put()
>     {
>          if(folio_put_test_zero())
> *** we should NOT be here as the refcnt of alloc_pages should NOT be dropped ***
>          if (folio_test_lru())
> ***  preempted here with refcnt == 0 and pass PG_lru check ***
> [1]
>          lruvec_del_folio()
> Then thread_isolate call folio_isolate_lru()
>       folio_isolate_lru()
>       {
>          folio_test_clear_lru()
>          folio_get()
> [2]
>          lruvec_del_folio()
>       }
> --------------------------------------------------------------------------------------------
> shrink_folio_list()
> {
>     __remove_mapping()
>     {
>         refcount = 1 + folio_nr_pages;
> *** the refcount = 1 + 1 implies there should be only the refcnt of
> alloc_pages and previous isolation for a no-busy folio as all PTE has
> gone***
>         if (!folio_ref_freeze(refcount))
>              goto keeplock;
>      }
> }

