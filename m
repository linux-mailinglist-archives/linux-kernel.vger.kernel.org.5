Return-Path: <linux-kernel+bounces-89982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA486F89C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AE1C20C5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFAD1854;
	Mon,  4 Mar 2024 02:39:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592E419A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519988; cv=none; b=HTzjNWuDya4R1/Q6HY9gOp9Mn1LdT9DL65uxR2ekotd2mKB/Cn4QivVpzHzED8sQ+ERkhtx6xx+OJsO6F/p+Ryfdv9+3qCfsW0haV3YfJuDIkREoa7yNSEUEoxXquKFrfppAe//CIpbs7IL1dZwMO72SyYPctL2aa+ZPYr3lvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519988; c=relaxed/simple;
	bh=mzaSVeh4brKuSCIYyR/KgsMXISsvCDhXVxVlfuIfANk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTR7nFdFjYYydxzRrgm9xr5wBIPOgR1cxA8JLFt2902k4zSBclqRKYdWnwJwKDWkg9NCEDxhw2ePlISlci7ctxhzgybHYfYF90TrFsQaiGncxXLoUo3TWGDu7UhLVIU/pPTiGwO9nkL++xjyngmV5ZkTTTKWp3et8WGsax0u2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-2a-65e5346b883a
Date: Mon, 4 Mar 2024 11:39:34 +0900
From: Byungchul Park <byungchul@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [RESEND PATCH v8 0/8] Reduce TLB flushes by 94% by improving
 folio migration
Message-ID: <20240304023934.GA13332@system.software.com>
References: <20240226030613.22366-1-byungchul@sk.com>
 <20240229092810.GC64252@system.software.com>
 <54053f0d-024b-4064-8d82-235cc71b61f8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54053f0d-024b-4064-8d82-235cc71b61f8@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsXC9ZZnoW6OydNUg4NbxC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	nb9PGAu+ild8vXOeqYFxiVAXIyeHhICJRPe1M4ww9qennSwgNouAisT/CQvB4mwC6hI3bvxk
	BrFFBDQkNrVtALK5OJgF3jJJTJnTzAaSEBaIlljWNYUdxOYVsJC41TKDDaRISGAGo8Tq5ivM
	EAlBiZMzn4BtYBbQkrjx7yVTFyMHkC0tsfwfB0iYU8BO4t+kc2CLRQWUJQ5sO84EMkdCYB27
	xLQjN9ghLpWUOLjiBssERoFZSMbOQjJ2FsLYBYzMqxiFMvPKchMzc0z0MirzMiv0kvNzNzEC
	Y3FZ7Z/oHYyfLgQfYhTgYFTi4c3ofJIqxJpYVlyZe4hRgoNZSYS35hdQiDclsbIqtSg/vqg0
	J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUAyPnZ62GOPkPrPNPlnhGCKx+/Gtv
	8bfXU+3/1jzNLNizUdydv6fU8OfNKY2hVRwxD3iWcjKnGl//cmUNY13xkTXP5L/ZTWXM6TMO
	33bt6YO3HWdK3HvrqxT5e4P+OBvE7Pzh+3Jzsf+7mIk+wdk//ITns510M2kPbinek/liPeeM
	5O3yyqXSVUosxRmJhlrMRcWJAMUelSDBAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RW0hTYQDH+c45OzsbGx6XsQ+Foiko81oofFBI1EMfGaIgBBW0Qx5yOadt
	KioFmmUoJfMymHOVZanpwu2MTEVkTGTtQcUskTAhcKQPteWFzMtsMyLffvwv/B/+DKkwU7GM
	Vl/OG/ScTkVLKWnu6frU4kw/n+EJKpFt0E6jdUeIRiuOhwBtDm6TyL/WTKGJJz4Rmhu10WjJ
	vi9CM6NvRGj41TiBPri7COR97CbQs6V1GrkEM4m87WaAdrbCYZ+1jTobjX89aKbwiPWLGHcJ
	FdjVp8bdY6sEFvobaSystYrxj+lpMX5v2aHwU18+Dox/onH3SpDAb7ezcZ15nsbrwrG8qCvS
	M4W8TlvJG9KzNdKixb1lULaprNpcnCFqwUtFE5AwkM2Ea/5GKsIUmwD3Tc9BhGk2ES4s/CYj
	HMMmQaHBEWYpQ7LfCdhuq6cjxhH2KuxpahdHWM4i+Pm+hY6EFKwFwIH6j+RfIxr6OpYPFkhW
	DRdCq0QTYMIcB3tDTESWsNkw1Dp9MHyUjYfuIS9hAnLrobb1UNv6v90FyH4Qo9VXlnBaXVaa
	sbioWq+tSrtRWiKA8Fk9d3dbhsHG3AUPYBmgkslN9mVeIeIqjdUlHgAZUhUjv7MdluSFXHUN
	byi9bqjQ8UYPiGMolVJ+8TKvUbA3uXK+mOfLeMM/l2AksbXgxey5lsmMLXNV51TAXRC1l0K9
	RhqX83jcKVuSN2+kISEA+F0mpzM5q6CtJsXpHW2+Z42/xLWdJ775TROWTHvLu15DzteUxHFZ
	GROQBpduKedvD6RKnBVD6QV1IadRNqvuS/Y74aP8zj7Zz2saamrsxEZH0J7umlDZcydVlLGI
	O6kmDUbuDyUPXjKoAgAA
X-CFilter-Loop: Reflected

On Thu, Feb 29, 2024 at 10:33:44AM +0100, David Hildenbrand wrote:
> On 29.02.24 10:28, Byungchul Park wrote:
> > On Mon, Feb 26, 2024 at 12:06:05PM +0900, Byungchul Park wrote:
> > > Hi everyone,
> > > 
> > > While I'm working with a tiered memory system e.g. CXL memory, I have
> > > been facing migration overhead esp. TLB shootdown on promotion or
> > > demotion between different tiers. Yeah.. most TLB shootdowns on
> > > migration through hinting fault can be avoided thanks to Huang Ying's
> > > work, commit 4d4b6d66db ("mm,unmap: avoid flushing TLB in batch if PTE
> > > is inaccessible"). See the following link:
> > > 
> > > https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> > > 
> > > However, it's only for ones using hinting fault. I thought it'd be much
> > > better if we have a general mechanism to reduce the number of TLB
> > > flushes and TLB misses, that we can ultimately apply to any type of
> > > migration, I tried it only for tiering for now tho.
> > > 
> > > I'm suggesting a mechanism called MIGRC that stands for 'Migration Read
> > > Copy', to reduce TLB flushes by keeping source and destination of folios
> > > participated in the migrations until all TLB flushes required are done,
> > > only if those folios are not mapped with write permission PTE entries.
> > > 
> > > To achieve that:
> > > 
> > >     1. For the folios that map only to non-writable TLB entries, prevent
> > >        TLB flush at migration by keeping both source and destination
> > >        folios, which will be handled later at a better time.
> > > 
> > >     2. When any non-writable TLB entry changes to writable e.g. through
> > >        fault handler, give up migrc mechanism so as to perform TLB flush
> > >        required right away.
> > > 
> > > I observed a big improvement of TLB flushes # and TLB misses # at the
> > > following evaluation using XSBench like:
> > > 
> > >     1. itlb flush was reduced by 93.9%.
> > >     2. dtlb thread was reduced by 43.5%.
> > >     3. stlb flush was reduced by 24.9%.
> > 
> > Hi guys,
> 
> Hi,
> 
> > 
> > The TLB flush reduction is 25% ~ 94%, IMO, it's unbelievable.
> 
> Can't we find at least one benchmark that shows an actual improvement on
> some system?

XSBench is more like a real workload that is used for performance
analysis on high performance computing architectrues, not micro
benchmark only for testing TLB things.

XSBench : https://github.com/ANL-CESAR/XSBench

Not to mention TLB numbers, the performance improvement is a little but
clearly positive as you can see the result I shared.

	Byungchul

> Staring at the number TLB flushes is nice, but if it does not affect actual
> performance of at least one benchmark why do we even care?
> 
> "12 files changed, 597 insertions(+), 59 deletions(-)"
> 
> is not negligible and needs proper review.
> 
> That review needs motivation. The current numbers do not seem to be
> motivating enough :)
> 
> -- 
> Cheers,
> 
> David / dhildenb

