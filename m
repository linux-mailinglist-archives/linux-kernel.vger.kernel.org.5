Return-Path: <linux-kernel+bounces-100525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8919687991F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECCD2820E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235137E0EE;
	Tue, 12 Mar 2024 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jYe8NXlh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E915BF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261520; cv=none; b=YhekNo71qQC0uEFk3zrPloNtg9w5s0nXvoGnmttrD90a6cXL2QF365UuECNUex81U5UMoT8e6hEVSdtIY9Of/ffJnY7gETvWdtQm6+Myt7phfc9BrhKlIgM1Ok3L59MPt65XC7jz+byWWskHqco5AvHBp20FC//Ncxkv7HHKx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261520; c=relaxed/simple;
	bh=2Ney3Be8zQ+ahSZrL4rbdZbA6XT2or+RZEEolylCT6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeG50liojE1JROWyK6l5Io4ncDUYkLYrNU2uHtXXWa4RalNFZDpP2CERv+Nn6KS4mUSW7x2+/NcIe68iy/YHM7q9MDEYQf/X+byC0YjTG3A7kNM1OaPGmL+mLrVyfpjEQ16lxTFATnCAXSRjc9uD/vFaw+5+h9kfLJ7BZe+XRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jYe8NXlh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8LxRhGuwXJFpATs069eW/+reuCwEH54tH10y+l407N4=; b=jYe8NXlha4EYzdWWFia+M3+OgZ
	zcOr25Z8IhZ7NogxmHSvhJBS4mlncMVYqEA4ZTB0ctlMv62PpDh+A4O2uExc+OQyuSYVQLnxXZQFn
	vHmjzdp/5IwVV3oRbpUX5P9gMOmUfw0rFRIfJh6DofHPQ0Milb7vIGn/QehrzX3eTD2dmN+20PqCR
	x0d6t0Y8A9Eb1cIJok8pYcxtFfX63bOCfsyemI1wb4a0rkpqA0cVOUuwWX53m60MW2ElMvGow0+6X
	pgULWQrqUXt/XJ0LvA1AQqwDvqCw2ao2/VMK97VIZVIJJQTHnjPkC04Fq+4VhCezk/WwbWM7FD86p
	uJxSzQAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk596-00000003RNz-1xJ1;
	Tue, 12 Mar 2024 16:38:32 +0000
Date: Tue, 12 Mar 2024 16:38:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
	"\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Message-ID: <ZfCFCGkrLVpySa6X@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
 <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>

On Tue, Mar 12, 2024 at 11:51:13AM -0400, Zi Yan wrote:
> On 12 Mar 2024, at 10:19, Matthew Wilcox wrote:
> 
> > On Tue, Mar 12, 2024 at 10:13:16AM -0400, Zi Yan wrote:
> >> On 11 Mar 2024, at 23:45, Matthew Wilcox wrote:
> >>> Much more important: You're doing this with a positive refcount, which
> >>> breaks the (undocumented) logic in deferred_split_scan() that a folio
> >>> with a positive refcount will not be removed from the list.
> >>
> >> What is the issue here? I thought as long as the split_queue_lock is held,
> >> it should be OK to manipulate the list.
> >
> > I just worked this out yesterday:
> > https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.org/
> > (the last chunk, starting with Ryan asking me "what about the first bug
> > you found")
> 
> Hmm, like you said a folio with a positive refcount will not be removed
> from ds_queue->split_queue, it will have no chance going to the separate
> list in deferred_list_scan() and list_del_init() will not corrupt
> that list.

You've misread it.  Folios with a _zero_ refcount are not removed from
the list in deferred_split_scan.  Folios with a positive refcount are
removed from the per-node or per-cgroup list _at which point there is
an undocumented assumption_ that they will not be removed from the
local list because they have a positive refcount.

> So it should be safe. Or the issue is that before migration
> adding a refcount, the folio is removed from ds_queue->split_queue
> and put on the list in deferred_list_scan(), as a result, any manipulation
> of folio->_deferred_list could corrupt the list. Basically,
> !list_empty(&folio->_deferred_list) cannot tell if the folio is on
> ds_queue->split_queue or another list. I am not sure about why "a positive
> refcount" is related here.
> 
> That makes me wonder whether ds_queue->split_queue_lock is also needed
> for list_for_each_entry_safe() in deferred_split_scan(). Basically,
> ds_queue->split_queue_lock protects folio->_deferred_list in addition to
> ds_queue->split_queue.
> 
> 
> 
> >>> Maximally important: Wer shouldn't be doing any of this!  This folio is
> >>> on the deferred split list.  We shouldn't be migrating it as a single
> >>> entity; we should be splitting it now that we're in a context where we
> >>> can do the right thing and split it.  Documentation/mm/transhuge.rst
> >>> is clear that we don't split it straight away due to locking context.
> >>> Splitting it on migration is clearly the right thing to do.
> >>>
> >>> If splitting fails, we should just fail the migration; splitting fails
> >>> due to excess references, and if the source folio has excess references,
> >>> then migration would fail too.
> >>
> >> You are suggesting:
> >> 1. checking if the folio is on deferred split list or not
> >> 2. if yes, split the folio
> >> 3. if split fails, fail the migration as well.
> >>
> >> It sounds reasonable to me. The split folios should be migrated since
> >> the before-split folio wants to be migrated. This split is not because
> >> no new page cannot be allocated, thus the split folios should go
> >> into ret_folios list instead of split_folios list.
> >
> > Yes, I'm happy for the split folios to be migrated.  Bonus points if you
> > want to figure out what order to split the folio to ;-)  I don't think
> > it's critical.
> 
> 
> --
> Best Regards,
> Yan, Zi



