Return-Path: <linux-kernel+bounces-100342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32CA8795F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537771F23BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6F7AE72;
	Tue, 12 Mar 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUbazpkA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9B7A72D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253208; cv=none; b=SQS00jaf4ptGBcmHJd+AR8wJHIM2L5HWGo+njk1/dWWDQ0yvUAGX1cRYdoGATV0tr+rrhYoE50/b2iTuKgUBnPh4YnyFbAG94vrp1dPJK8wu8qQKUPivMu/vVaXHbVD5jMLh+zyNvZTPUK5nce3aPVdp5hXZc2ratW+aivYHT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253208; c=relaxed/simple;
	bh=4aMdJ1vwMV/UVilscGcMh1+5ZJ9UaJVk1jA/7rQVzEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asvXBZ1IpranMRmdCDgudH918WKhuPukJMAnECT5izA3zSrwa5vr1VYxnAnRi1zudRD7da5b9u9yrxDXj+vlum4DSiveWcLn/56FsRIZFYWM9b5xOusvHmW2Qk2gE4mNsT/wJ/MmdpnYUnsAFg0ovTgb5TAm2pQXMD63pnEjbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CUbazpkA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l/F1ZKWhMDUisBwzFqHOzTQVBfOlCsMKFxt2AA8pr80=; b=CUbazpkAh/aPR8nK6maOby3BVR
	3t/HoxMdqjrqrtCfSou1QGgAIkH73ejMHp78BvGZLlz0dhB9tvWWq2+6mlUPaIUpLLmoHPACgD9vl
	HuLfr0PC5lWRaBIPUx6GxNuqmThUhORGHz8MH3neAKyEVxsvXVbfdDcNIDCU2ZWaPAINOsH5r2IUf
	unDcl9P3HG0rR0zfPaR5kkt4EB7ZnEbvDYpjHFiGcNjChuAbHlvg9YuHjPkUtttSHDpt2wLkzPcAe
	rWn1UNCKgE+seH2C/0OhezrD5Lmn38gknYccbfQUWx4JXgB5ZV2XQ3BJoeBnAF9XyTPZjvSYMyVOo
	JQ61ui3g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk2yz-00000003Bxt-46V7;
	Tue, 12 Mar 2024 14:19:58 +0000
Date: Tue, 12 Mar 2024 14:19:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
	"\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Message-ID: <ZfBkjf4z-jpaNk6c@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>

On Tue, Mar 12, 2024 at 10:13:16AM -0400, Zi Yan wrote:
> On 11 Mar 2024, at 23:45, Matthew Wilcox wrote:
> > Much more important: You're doing this with a positive refcount, which
> > breaks the (undocumented) logic in deferred_split_scan() that a folio
> > with a positive refcount will not be removed from the list.
> 
> What is the issue here? I thought as long as the split_queue_lock is held,
> it should be OK to manipulate the list.

I just worked this out yesterday:
https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.org/
(the last chunk, starting with Ryan asking me "what about the first bug
you found")

> > Maximally important: Wer shouldn't be doing any of this!  This folio is
> > on the deferred split list.  We shouldn't be migrating it as a single
> > entity; we should be splitting it now that we're in a context where we
> > can do the right thing and split it.  Documentation/mm/transhuge.rst
> > is clear that we don't split it straight away due to locking context.
> > Splitting it on migration is clearly the right thing to do.
> >
> > If splitting fails, we should just fail the migration; splitting fails
> > due to excess references, and if the source folio has excess references,
> > then migration would fail too.
> 
> You are suggesting:
> 1. checking if the folio is on deferred split list or not
> 2. if yes, split the folio
> 3. if split fails, fail the migration as well.
> 
> It sounds reasonable to me. The split folios should be migrated since
> the before-split folio wants to be migrated. This split is not because
> no new page cannot be allocated, thus the split folios should go
> into ret_folios list instead of split_folios list.

Yes, I'm happy for the split folios to be migrated.  Bonus points if you
want to figure out what order to split the folio to ;-)  I don't think
it's critical.



