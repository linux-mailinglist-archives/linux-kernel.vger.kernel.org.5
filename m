Return-Path: <linux-kernel+bounces-160332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B9A8B3C11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A801C23D76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216B149E0B;
	Fri, 26 Apr 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fS3UbrvO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD9148FE5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146624; cv=none; b=Xns7Ce5CVTqmB5qMByXDBlg7YsmIuJInIjWvo/+Xc7jzB/6dNHAsxPUAyct0fzg7kQhUxsPRHZI+5PV5+kQfjj1MTzGEkU5zUfbIlqncEMk5Uaiwp6iridwGe7+1085cDkJqBsuu9GEb2HBpNmBFfyVOiTK7zHtPsrbk/l6VUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146624; c=relaxed/simple;
	bh=GdLcr74WLo/Hh0HW8mGcoH4pOw2ZLI4PuPpZEnA9Dso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t++EwPLbXSr6jINZ3/fHi9hfo+iU+zt/9xqlOXDlIvWzmAsOoGPNyTW6VBlX0XRu8ja3btmgSskBhuGvaEd24w9GV3ccZo1gzPVjIaf+ExxmKuGa+MNZiRnUNv1Oh174P3iKWbBll8Fb3RR7MsWQsxJB1XfvB/zObH2JLyFmX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fS3UbrvO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rmx/bNaH6jOY5MArnPPn/57lIrpuzyHqYg+CoUfdaWI=; b=fS3UbrvOeyZMD2muMoPGGgC1n4
	IzIDuZX+8heQ3k1uxFxvcXcB82bAyTAwYnrKs72KIo1cykz+yMwIlvsY+z8otw5/hl5CpF8kgtklo
	muKEndxlm37F9aYgSU1/yqAzKjZ5yQqGAH+tna4spCG+lqJLTNh5pebl7bbxVeH4EvO9s4BSNRHSE
	2KR21R5zxTLB/tLI5IK+WeQw0hTYz4clqdUAErxQNINBWVjFjzd7gTxvQ06PWxt/T5BvNSSJ8MWCv
	7O0mGn/tgup6kJm1XOQ+SJ7ePo3j68XdUScyzhSEPV8VzQu3PMLCWzsk0Jptfg1lRYSlvlnJbOtsC
	5uiu5k1g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Nq7-00000005W77-24sM;
	Fri, 26 Apr 2024 15:50:19 +0000
Date: Fri, 26 Apr 2024 16:50:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZivNOxf06cu0J9OQ@casper.infradead.org>
References: <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZiuzikG6-jDpbitv@casper.infradead.org>
 <CAJuCfpH+O0NYtTrGKSY6FjBOcWpyKXB+_4rsSRjcewSXUWVfCQ@mail.gmail.com>
 <ZivILlyRv7rNMldQ@casper.infradead.org>
 <CAJuCfpEqJV9Lv+36xNK+vnpsR5DhQ0kCK3CW7tLFWbbbSCH8yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEqJV9Lv+36xNK+vnpsR5DhQ0kCK3CW7tLFWbbbSCH8yg@mail.gmail.com>

On Fri, Apr 26, 2024 at 08:32:06AM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 26, 2024 at 8:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > I think the only path in either do_anonymous_page() or
> > > do_huge_pmd_anonymous_page() that skips calling anon_vma_prepare() is
> > > the "Use the zero-page for reads" here:
> > > https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L4265. I
> > > didn't look into this particular benchmark yet but will try it out
> > > once I have some time to benchmark your change.
> >
> > Yes, Liam and I had just brainstormed that as being a plausible
> > explanation too.  I don't know how frequent it is to use anon memory
> > read-only.  Presumably it must happen often enough that we've bothered
> > to implement the zero-page optimisation.  But probably not nearly as
> > often as this benchmark makes it happen ;-)
> 
> I also wonder if some of this improvement can be attributed to the
> last patch in your series
> (https://lore.kernel.org/all/20240426144506.1290619-5-willy@infradead.org/).
> I assume it was included in the 0day testing?

Patch 4 was where I expected to see the improvement too.  But I think
what's going on is that this benchmark evaded all our hard work on
page fault scalability.  Because it's read-only, it never assigned an
anon_vma and so all its page faults fell back to taking the mmap_sem.
So patch 4 will have no effect on this benchmark.

The report from 0day is pretty clear they bisected the performance
improvement to patch 2.

