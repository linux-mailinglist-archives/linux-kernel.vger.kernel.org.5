Return-Path: <linux-kernel+bounces-110623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0113886162
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A307285C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D6134431;
	Thu, 21 Mar 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ff7/4oH4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449613441F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051194; cv=none; b=atkUaQ5BJiVxPZKQgDqNWgU27ddIswvhh7m3pcabCwADosUUZuPgP5OFp4VQkKJklCXVbD7rQa8+iAVz5LZYvtIzaK5SS5wxb8rFZcIdwq49H/1ME4SwcHMeAXyO7k6cf7VlA3trFay+nwvVLQ3DXgFO21wQOCbtO3792cepsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051194; c=relaxed/simple;
	bh=z0wA0KLIzdreobgSK4RcmRycyOJQ6P5PXTREgfAUx3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPaEunieX/QVrlNtx4VL7qAB8pt42SmwSpmVPydYI7fXQOnsxDbf9DnVP+x8Hx5P9B+mlJE+znAwn8xFGX9B8LzVKMoNugcMlJIgL2oUQKpqv9Yti9Z+o/QuRsfsoyHHQQzsXpUTv8VbdVuJRzE2Krjnlp3wJi+ovf0CXAi8Vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ff7/4oH4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BYPwtyCYd5a4JYAUK9MQluNVapG0iz3U/+Y3po5f7DY=; b=Ff7/4oH45A2jTNadCdQVtTteKx
	GvDjUzmbI7lEkAktx9oWHQ81RLamkG6ExAICJUUhg155LXm0ylzDEHKTR9u0rI3DAEpkBIVGyZr4P
	NJe28imfM7bV3S2h8MfNysnm3habPiFSxr5enFrID713fhv8sUVVroA2OKSIsUQ7tsezkJK0d+gtp
	F3tPZwVPVxo7QQahLjompHhMnHd8jHkNjYGbg/X5c1QvJZT7EdNGzBkKXHBQ8XWs7ISCJKpY5vIiW
	ALjGJNPK+9zDOdGzkqj0fAtug+lqv9JTolICvWh99R/7Q4GE3vWl1bCP4GCXJSjcKFPT7ZSgHRadF
	NcIql1Ng==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnOZn-00000007Tdd-1WHx;
	Thu, 21 Mar 2024 19:59:47 +0000
Date: Thu, 21 Mar 2024 19:59:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Svetly Todorov <svetly.todorov@memverge.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregory.price@memverge.com, wangkefeng.wang@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
	naoya.horiguchi@linux.dev
Subject: Re: [PATCH v3] kpageflags: respect folio head-page flag placement
Message-ID: <ZfyRsyq03aYVcZ13@casper.infradead.org>
References: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>
 <Zfs33TNtHvnjDX3J@casper.infradead.org>
 <c1425f97-0d9b-441e-a06b-ea00d75a2e73@memverge.com>
 <ZfxaZa8f0UUY0dCZ@casper.infradead.org>
 <c2df31dc-185f-4bd1-9e58-b32e024241c3@memverge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2df31dc-185f-4bd1-9e58-b32e024241c3@memverge.com>

On Thu, Mar 21, 2024 at 12:08:01PM -0700, Svetly Todorov wrote:
> > > > -	if (PageKsm(page))
> > > > +	if (mapping & PAGE_MAPPING_KSM)
> > > >    		u |= 1 << KPF_KSM;
> > > This might need an #ifdef?
> > > Say mapping is movable and anon -- then (mapping & PAGE_MAPPING_KSM) is
> > > true. Before, we called PageKsm, which falls through to a PG_ksm check.
> > > If !CONFIG_KSM then that flag is always false. But now, we're liable to
> > > report KPF_KSM even if !CONFIG_KSM.
> > 
> > I'm not sure where you see a PG_ksm check:
> > 
> > static __always_inline bool folio_test_ksm(const struct folio *folio)
> > {
> >          return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
> >                                  PAGE_MAPPING_KSM;
> > }
> > 
> > static __always_inline bool PageKsm(const struct page *page)
> > {
> >          return folio_test_ksm(page_folio(page));
> > }
> My bad. What I meant was, if CONFIG_KSM is undefined, then
> 
> > #ifdef CONFIG_KSM
> > ...
> > static __always_inline bool PageKsm(struct page *page)
> > {
> > 	return folio_test_ksm(page_folio(page));
> > }
> 
> will fall through to
> 
> > # else
> > TESTPAGEFLAG_FALSE(Ksm, ksm)
> > #endif
> 
> And you're right -- there is no PG_ksm comparison --
> but the autogenerated PageKsm will always return false:

Yes, that's true.  Usually we care about this because we can optimise
out large chunks of code if a config option (eg CONFIG_KSM) is disabled.
In this case, we're talking about a couple of instructions, and it's
generally not worth optimising those out in order to add an ifdef in
the code.  We've got quite a long way with Linux without it becoming
overrun with ifdefs (compare, eg, the Mach source code), and long may
that continue ;-)

> > 00	file (or NULL)
> > 01	anon
> > 10	movable
> > 11	KSM
> > 
> > Perhaps it might be clearer to say that anon pages are inherently
> > movable; the movable type really means that the reset of the mapping
> > pointer refers to a movable_operations instead of a mapping or anon_vma.
> I see. I misunderstood how the flags are applied.
> I thought that 11 == (01 | 10) -- i.e. that KSM was an intersection of
> MOVABLE and ANON. But they're more like mutually-exclusive states. And
> I doubt that a page will end up in the KSM "state" if CONFIG_KSM is
> disabled. So we don't need to rely on PageKsm() for the CONFIG_KSM
> check.
> 
> That said, won't
> 
> 	if (mapping & PAGE_MAPPING_KSM)
> 
> return true even if a mapping is ANON (01) or MOVABLE (10)
> but not KSM (11)? Shouldn't this at least be
> 
> 	if (mapping & PAGE_MAPPING_KSM == PAGE_MAPPING_KSM)

Uh, yeah, that was a mistake.  This should do the trick:

        if (is_anon) {
                u |= 1 << KPF_ANON;
                if (mapping & PAGE_MAPPING_KSM)
                        u |= 1 << KPF_KSM;
        }

(all KSM pages are reported as anon pages as well, both before and after
this patch; see how folio_test_anon() only checks the bottom bit)

> > I see your confusion.  We have three cases; head, tail and neither
> > (obviously a page is never both head & tail).  If a page is neither,
> > it's order-0 and it is the only page in the folio.  So we handle head
> > or neither in the first leg of the 'if' where we set KPF_COMPOUND_HEAD
> > if PG_head is set, and tail in the 'else' leg.
> 
> Dumb mistake on my part. For some reason, I thought that every
> folio->page had its PG_head set.

At this point, it's bad naming, but it's not worth the churn of fixing
it; we have a better destination in mind, and we'll get there soon enough.

> Cool! Thanks for bearing with me. Beyond the KSM stuff, my only
> hangup is that this patch doesn't account for the handful of
> remaining per-page flags (KPF_HWPOISON, KPF_ARCH_*). Should I
> take this diff, tack those on in a second commit, and then put
> up a v4? Forgive me, I'm very green to the kernel dev process...

Oh, yes, that's a bug on my part.  HWPOISON is definitely per-page,
not per-folio (although the handling of it differs for hugetlb)
and I haven't looked at the PG_arch gunk yet.  We are trying to
sliminate the per-page flags, because there's no space for them in the
future (we'll have special handling for hwpoison because that really is
very special)

