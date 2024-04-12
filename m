Return-Path: <linux-kernel+bounces-142802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31A8A304B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60615B2373D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8586128;
	Fri, 12 Apr 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rMMjDlI5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE38219FF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931418; cv=none; b=SV0PUve6TqoQ0VfauHodyo+SccesOjJL4o+9OfAApZ6ld4gWyvxnfkYYN3e8YP1/oylXyyFwv5cac8TfhIE2XhH64uwotSj0gqB3CMwjzc61PzEgz+y8ebs9pFKlgT/4BSEpUEr/GWWl1xYKNAmh514dej10L3HHW9FTnO2K/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931418; c=relaxed/simple;
	bh=X4nBdSAsysJI15feVd2/IGXjrv/5r6OXvSP85hdtXnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAl09m8XRWJGh3UYFVwhvcTVcN9CK3tugyb7Gkg+z7p5SnvVlm7UqC1MeJSmxhBAl0pU2VX1JbIPCMu8n3tFRCtQv9DKU6J1z8t/6k2hXLYvZ32xb73NPfqy332mR6YoFOnSbC3It/H3fKjiqbLVlmqOaiz40GW26bilcFFRlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rMMjDlI5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9XUEwsNrmwFS+p7W60FkPz2435AkFdskzYLram0Y5Po=; b=rMMjDlI54eaUpy5OL5nSWfkC23
	FehjGUZqbI9e/lAI9EOrn8i52GbhtJL7oGdZjxdoTVQ7w0vv11p5Wy4FK6dqUJCUy7L1/SEAuCvqE
	3270273qJeR+Oql+gYffuogIozJ5Hwq57BMbrPBf9HVZv11WmDYgAGU1C1rOmuecU5DCHzs9SNEbb
	8MZcVUPgb8rwDhcgRTwPBmFRhrK1fk0G4gKTBQnDpV7C51KXMntCzciG04wGb2fTjqk1AFeIt+qG+
	pGiHHCitqVA1fJItD1N0HGiU98DR2d4d7WqmHndRBLHXlbV17MBgpUOxDTqxL/8QhcHf6hDPP/TLa
	BoiD6Dqw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvHi0-00000009P8j-3kM6;
	Fri, 12 Apr 2024 14:16:53 +0000
Date: Fri, 12 Apr 2024 15:16:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhlCVOz7qaDtldfL@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
 <ZhhV3PKgEX9d7_vA@casper.infradead.org>
 <ZhhaRXHKk7w_hKgi@x1n>
 <Zhhd-A7w1A8JUadM@casper.infradead.org>
 <ZhinCD-PoblxGFm0@casper.infradead.org>
 <ZhkrY5tkxgAsL1GF@x1n>
 <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpG7YkQ2giKiv07TetTn=QHK9x723vnLaTjDCaQjUvAavw@mail.gmail.com>

On Fri, Apr 12, 2024 at 06:06:46AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Apr 12, 2024 at 04:14:16AM +0100, Matthew Wilcox wrote:
> > > -       /*
> > > -        * find_mergeable_anon_vma uses adjacent vmas which are not locked.
> > > -        * This check must happen after vma_start_read(); otherwise, a
> > > -        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
> > > -        * from its anon_vma.
> > > -        */
> > > -       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> > > -               goto inval_end_read;
> > > -
> > >         /* Check since vm_start/vm_end might change before we lock the VMA */
> > >         if (unlikely(address < vma->vm_start || address >= vma->vm_end))
> > >                 goto inval_end_read;
> > >
> > > That takes a few insns out of the page fault path (good!) at the cost
> > > of one extra trip around the fault handler for the first fault on an
> > > anon vma.  It makes the file & anon paths more similar to each other
> > > (good!)
> > >
> > > We'd need some data to be sure it's really a win, but less code is
> > > always good.
> 
> I agree, if we make this change we should keep this comment and maybe
> move it into vmf_anon_prepare()

Most of the comment makes no sense if you move it out of
lock_vma_under_rcu().  It's justifying where it needs to be in that
function.  If it's no longer in that function, there's not much left of
the comment.  What part do you think is valuable and needs to be retained?


