Return-Path: <linux-kernel+bounces-33771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E225F836F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1938B26AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD224F1EF;
	Mon, 22 Jan 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rKSMLV0v"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25114EB55
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944010; cv=none; b=eKc7EUtnhD4UYXDg08QPuNYu+ZdavKx7z7M/Cpx4YbXByubgC1eTLWCE38H85qBGrLUlSkfIyH7WOWWO/c0xkVkSa28j6ux1SWlSEJPHRH6jOOF8eL9TAmh5WHdl62k8chnfzVmVNWk133uEGIowhkisgGvuWeTiyTRjOgHuhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944010; c=relaxed/simple;
	bh=O6WmXGDzoFWYK4x7y1L/BceegL+wy3DhVCOxC1jYijg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMtr9yRehQnNoE51KSbMt5Cde5T5e+etNBj/RX9z8akhsQYSQWMzOdfgSVOJhPy3RC6AWUHOd/g/x6tMrsDmmGFCn74np9MSfhHIfnQgqNzIVdDhE9AZ0vI4YFLCjBV7jNonXFXYS3tNinawPTbVhjWiH/kv33l5IQ9cSlLA7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rKSMLV0v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QZnq9d/ql8GroW98ZcPl4rKdarm4gbQiACxhNouKKyk=; b=rKSMLV0vZOiq4t5//yK/ML7/k0
	qcJHPgoem3o2uSvaXatcJXk2JsoZ8aC8lTfQWFynshAf+GS4MMHtWhvXNCV7ff3rURgl5qRBFhFdC
	ZTkTMORo1WgjUIEysDLtcnoC0tO4O830pVxou3tR5mwzvI8lCqhNHwuvVakBSnhjCf/ePemx1lpV5
	igP4rJuaOZ6LRXQ3yfum55VLEWx+VgBmuUvmZPludQ0h1CLTPlA2fIJMdVqIsYVz8MhMkXxGUaIid
	tTarsXHOaKJX2kgDeBkwnBLdiZuQekLF4whxJTJoB5ePyF2usKy4Yr+mfD3o+jIZkx2MQv0TbJXnd
	ntsZWp3A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRxxt-00000000WB2-0xp6;
	Mon, 22 Jan 2024 17:20:05 +0000
Date: Mon, 22 Jan 2024 17:20:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 28/40] mm/memory: page_remove_rmap() ->
 folio_remove_rmap_pte()
Message-ID: <Za6jxXIFjnCnyvPE@casper.infradead.org>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-29-david@redhat.com>
 <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
 <007e83fa-16c7-4700-b326-ee8cb7809f9f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007e83fa-16c7-4700-b326-ee8cb7809f9f@redhat.com>

On Mon, Jan 22, 2024 at 06:01:58PM +0100, David Hildenbrand wrote:
> > And folio_mark_dirty() is doing more than just setting teh PG_dirty bit. In my
> > equivalent change, as part of the contpte series, I've swapped set_page_dirty()
> > for folio_mark_dirty().
> 
> Good catch, that should be folio_mark_dirty(). Let me send a fixup.
> 
> (the difference in naming for both functions really is bad)

It really is, and I don't know what to do about it.

We need a function that literally just sets the flag.  For every other
flag, that's folio_set_FLAG.  We can't use __folio_set_flag because that
means "set the flag non-atomically".

We need a function that does all of the work involved with tracking
dirty folios.  I chose folio_mark_dirty() to align with
folio_mark_uptodate() (ie mark is not just 'set" but also "do some extra
work").

But because we're converting from set_page_dirty(), the OBVIOUS rename
is to folio_set_dirty(), which is WRONG.

So we're in the part of the design space where the consistent naming and
the-obvious-thing-to-do-is-wrong are in collision, and I do not have a
good answer.

Maybe we can call the first function _folio_set_dirty(), and we don't
have a folio_set_dirty() at all?  We don't have a folio_set_uptodate(),
so there's some precedent there.

