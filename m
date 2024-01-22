Return-Path: <linux-kernel+bounces-33824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B877836F09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD14D1F2D5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B15674B;
	Mon, 22 Jan 2024 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VuT1zM71"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA256743
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944757; cv=none; b=lD1v+K+7cc7SxlEjxLm1f0MdIgHeePSPuSA9mWcIXSZRB5tfaVRIqSHe/AheDhp+nvCafiz3l8WdDUFUJHh/XQJWYDXF9hrJe7tjaZ8ptzXUG2Fd6BF4TfjtU0d2SGGYi5tl74LYDxntc/W6PZcI5HCzr2aBpOFYevJYWPMWLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944757; c=relaxed/simple;
	bh=DO8NTrgfc4HqCUVR3zw2WBLs3BibO1sk1S45PfcjkKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwJZFGodnBUZXhJK6wDL5ELsKDZWxXp6e5aeWsHCstASHPWFAJqdWoKAnVLqG27wird0q9p5PuHTs4braqPlhG0EicIBkrBWZo8Zwc0X2fuVnA0Xb0BjUpz9zob3o/bEPms8O2twSKnK/BCzRpWeEyEwe3WAit5Iud8L6AprwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VuT1zM71; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ffjimZag3duj0z7SQ/ynHQbRhQyfj6VmeeSdQ1qniX4=; b=VuT1zM716OnFaEMTxjmmBUK4il
	RoZivoynyI45CYLoCRZmqiKtnwPGNvCyG3dNDSkGqLWSmMKQIxaMbOMEZCVB0dp2slbZzghsjYENN
	P9vtMQybR6eM2WYbtLBJQ2hPSlfCLKblfewYBTDV73fj4gHJxlKvQB7Og4/oMF+QSOMq9RPN9sLQP
	OwIJ6uTHOE0I/ERe9s2kA2l+nMsObHnDtyMD35/8NX5yCH2TYzE1Oqzk3s0nOmDckI2D4AQWgl7wD
	Pc5r6pjprq39jHLNaiocQLj8V8ibSL9C9o74HYbC0i68JshFoEIJiOUaRwVJH+6UU6O8yfC1Rn3TU
	2BR4LRCg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRy9v-00000000Xhw-2rDo;
	Mon, 22 Jan 2024 17:32:31 +0000
Date: Mon, 22 Jan 2024 17:32:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 28/40] mm/memory: page_remove_rmap() ->
 folio_remove_rmap_pte()
Message-ID: <Za6mr0OW9DW0y9Gn@casper.infradead.org>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-29-david@redhat.com>
 <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
 <007e83fa-16c7-4700-b326-ee8cb7809f9f@redhat.com>
 <Za6jxXIFjnCnyvPE@casper.infradead.org>
 <c8763420-69c8-4e22-ab87-ad702d5abb34@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8763420-69c8-4e22-ab87-ad702d5abb34@arm.com>

On Mon, Jan 22, 2024 at 05:26:00PM +0000, Ryan Roberts wrote:
> On 22/01/2024 17:20, Matthew Wilcox wrote:
> > On Mon, Jan 22, 2024 at 06:01:58PM +0100, David Hildenbrand wrote:
> >>> And folio_mark_dirty() is doing more than just setting teh PG_dirty bit. In my
> >>> equivalent change, as part of the contpte series, I've swapped set_page_dirty()
> >>> for folio_mark_dirty().
> >>
> >> Good catch, that should be folio_mark_dirty(). Let me send a fixup.
> >>
> >> (the difference in naming for both functions really is bad)
> > 
> > It really is, and I don't know what to do about it.
> > 
> > We need a function that literally just sets the flag.  For every other
> > flag, that's folio_set_FLAG.  We can't use __folio_set_flag because that
> > means "set the flag non-atomically".
> > 
> > We need a function that does all of the work involved with tracking
> > dirty folios.  I chose folio_mark_dirty() to align with
> > folio_mark_uptodate() (ie mark is not just 'set" but also "do some extra
> > work").
> > 
> > But because we're converting from set_page_dirty(), the OBVIOUS rename
> > is to folio_set_dirty(), which is WRONG.
> > 
> > So we're in the part of the design space where the consistent naming and
> > the-obvious-thing-to-do-is-wrong are in collision, and I do not have a
> > good answer.
> > 
> > Maybe we can call the first function _folio_set_dirty(), and we don't
> > have a folio_set_dirty() at all?  We don't have a folio_set_uptodate(),
> > so there's some precedent there.
> 
> Is there anything stopping us from renaming set_page_dirty() to
> mark_page_dirty() (or page_mark_dirty())? For me the folio naming is consistent,
> but the page names suck; presumably PageSetDirty() and set_page_dirty()... yuk.

Well, laziness.  There's about 150 places where we mention
set_page_dirty() and all of them need to be converted to
folio_mark_dirty().  I don't particularly like converting code twice;
I get the impression it annoys people.

The important thing is what does it look like when someone writes
a new filesystem in 2030.  I fear that they may get confused and
call folio_set_dirty(), not realising that they should be calling
folio_mark_dirty().  It doesn't help that btrfs have decided to introduce
btrfs_folio_set_dirty().

I think MM people can afford to add a leading '_' to folio_set_dirty()
so that's my current favourite option for fixing this mess.

