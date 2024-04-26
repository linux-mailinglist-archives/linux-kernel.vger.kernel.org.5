Return-Path: <linux-kernel+bounces-160287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BE78B3B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770341F217FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C0149C7B;
	Fri, 26 Apr 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jE+HT8fE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E197148FF0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145331; cv=none; b=RYZl1MFOdnftLy+DTE4yiWdppnIfK2yQ/1O9QNyuEgbKZHBR+qSXVTopaxHh9lU6ImyzyLLxTQGO/OBaXESGBhGgMkWvJMAUzoXotvKyKeDnvvr6Y5oFiD+BJA+JkFg8uGNx07TKDwv7gujOiA3lODHDBXENAvh4Q6vexSVu4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145331; c=relaxed/simple;
	bh=B9S+VgIc4hHSvEtMfMzv55OnFnUMC5C0EuUCYvhoK+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeSMMH+h7SYfj/9F1Br4RLNzd4cR57aMyU50HNYlH/wi0rMXDmy9vM8UHU0ISDyTixQC1eR2Wp7s5Dl87nxKp8A5dN/bIczGFcYxLqzV6sAd8mU/N8yAg0WLOClcqT6JErDxd/Xm54sA2sY14J2s5EkIO6ACDNbVi/D6iEStJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jE+HT8fE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5+JV8nGNDt7Yb0J1C93bew3ffEU+OKReUrVUHx6lRBY=; b=jE+HT8fEk5nk3WgGMTjsyJxmHt
	RFv/JBKSxfDB7yTJ27NOxG5to192JMyfyKkkZ0bQI/YN4HPRsvQge5CaLYs9sG3IVDRabru6mRDLT
	ZEwUAzogWDtfsjWnWU2iMlLb217tXbci8JwOA684kwuKr6KCdyyZgPL7Uy8K6YuCcGH9YXz0KYRBJ
	u93vvpac5T2s4ZJoMXqr7rDlibkgYS8ZZgXjJcPgWmlhEAebwkRbm9ati6SWpQjAxggHEg8hl+TrR
	5lvTrm+kvXpWlgZewTlHbOaUX+6X6jzS0BTKMt06NzcB3mwvJXzVBE1tsaKjMJftBXXsZqFKA0t7g
	EmcymXpA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NVG-00000005U9x-0lSp;
	Fri, 26 Apr 2024 15:28:46 +0000
Date: Fri, 26 Apr 2024 16:28:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZivILlyRv7rNMldQ@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZiuzikG6-jDpbitv@casper.infradead.org>
 <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com>

On Fri, Apr 26, 2024 at 08:07:45AM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 26, 2024 at 7:00 AM Matthew Wilcox <willy@infradead.org> wrote:
> > Intel's 0day got back to me with data and it's ridiculously good.
> > Headline figure: over 3x throughput improvement with vm-scalability
> > https://lore.kernel.org/all/202404261055.c5e24608-oliver.sang@intel.com/
> >
> > I can't see why it's that good.  It shouldn't be that good.  I'm
> > seeing big numbers here:
> >
> >       4366 ą  2%    +565.6%      29061        perf-stat.overall.cycles-between-cache-misses
> >
> > and the code being deleted is only checking vma->vm_ops and
> > vma->anon_vma.  Surely that cache line is referenced so frequently
> > during pagefault that deleting a reference here will make no difference
> > at all?
> 
> That indeed looks overly good. Sorry, I didn't have a chance to run
> the benchmarks on my side yet because of the ongoing Android bootcamp
> this week.

No problem.  Darn work getting in the way of having fun ;-)

> > I still don't understand why we have to take the mmap_sem less often.
> > Is there perhaps a VMA for which we have a NULL vm_ops, but don't set
> > an anon_vma on a page fault?
> 
> I think the only path in either do_anonymous_page() or
> do_huge_pmd_anonymous_page() that skips calling anon_vma_prepare() is
> the "Use the zero-page for reads" here:
> https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L4265. I
> didn't look into this particular benchmark yet but will try it out
> once I have some time to benchmark your change.

Yes, Liam and I had just brainstormed that as being a plausible
explanation too.  I don't know how frequent it is to use anon memory
read-only.  Presumably it must happen often enough that we've bothered
to implement the zero-page optimisation.  But probably not nearly as
often as this benchmark makes it happen ;-)

