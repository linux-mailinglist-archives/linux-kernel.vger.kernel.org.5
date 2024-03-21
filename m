Return-Path: <linux-kernel+bounces-110309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9700885CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D861F21EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F6112C53F;
	Thu, 21 Mar 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzSn3kGo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BC12C7E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037043; cv=none; b=VNFxfcTSQF6KpeDw3nBsvX7O986pgHKzZbiNuj7u3/nyPouOPrzjbESTBBFC/iJvq7RC1LjZA/55zLnybLHTZfdVVpIH+/EAWvQlhdseeBt8yOjEdvrHfDxtwO3pJzhKezRhELuafzLZvLITIT0LdfBEyIDVlCrmEchE3v+z+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037043; c=relaxed/simple;
	bh=EqVkPHeS52yQJkvMAQqCZ7VsibbQAMl03ZJEyFrzkQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHsAnT/kD5/6uH8OrpuZF798nfB420BsAgs1tDMScEDF5miIJCZPFkMKwNDnnv5miRN5/gJjXohtOW26Sxv5mXfsZTJh3YNeSe3s6579Up/dE8EmN1/gzXodVadgNCY8b7XpGJr13LzNYAGSXFPc1hy9i170IuFQ0WHAOjh6Fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fzSn3kGo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X4zP7bOt9aFfiZj3Kbm1qwQHpwNl/4ORsgZCeBn0NbY=; b=fzSn3kGo+M5viTVcPwz//RbdMM
	4NIff+NJ3wzRKLeQBW/CNM40FAMVXu+el/afBBpYvWTqfUhsyliRw1LjB9Mmy1VX/Opc4TPLlvxf+
	mcWxwPUlsrBkDl9QQxq6N//YhUpk8Oj8HMl8N6OLbgtMCwf1HbOiDz6yTl+VukDjvSTQUbXjye2Df
	ISjkTpAr1tzeGN7U7dTK4WO6xCYTsq8HGHpRsyWk5CuQUR5i+i4SiK7yAj+ZNIjv1Fw1TUKl5ELTm
	vAxWosSkIk9UWiz1jNxjz1EHatZGzHTHeLWL+Nx0e1HcMiB8BC/4bzfwu77PXBg4MRm6EAyDNRpfw
	dLeQnDEw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnKtR-000000074eD-1uQ4;
	Thu, 21 Mar 2024 16:03:49 +0000
Date: Thu, 21 Mar 2024 16:03:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Svetly Todorov <svetly.todorov@memverge.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregory.price@memverge.com, wangkefeng.wang@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
	naoya.horiguchi@linux.dev
Subject: Re: [PATCH v3] kpageflags: respect folio head-page flag placement
Message-ID: <ZfxaZa8f0UUY0dCZ@casper.infradead.org>
References: <20240320-kpageflags-svetly-v3-1-b6725843bfa7@memverge.com>
 <Zfs33TNtHvnjDX3J@casper.infradead.org>
 <c1425f97-0d9b-441e-a06b-ea00d75a2e73@memverge.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1425f97-0d9b-441e-a06b-ea00d75a2e73@memverge.com>

On Wed, Mar 20, 2024 at 04:40:43PM -0700, Svetly Todorov wrote:
> 
> Hi Matthew,
> 
> > I have a somewhat different patch for this.  Let me know what you think.
> > It depends on a few other patches in my tree, so probably won't compile
> > for you.
> I don't have extensive experience with folios or anything but on the
> whole it looks good to me. I like the use of `mapping` to dodge the
> compound_head() checks. Beyond that, only a few things caught my eye.

Thanks for your careful review.

> > -	if (PageKsm(page))
> > +	if (mapping & PAGE_MAPPING_KSM)
> >   		u |= 1 << KPF_KSM;
> This might need an #ifdef?
> Say mapping is movable and anon -- then (mapping & PAGE_MAPPING_KSM) is
> true. Before, we called PageKsm, which falls through to a PG_ksm check.
> If !CONFIG_KSM then that flag is always false. But now, we're liable to
> report KPF_KSM even if !CONFIG_KSM.

I'm not sure where you see a PG_ksm check:

static __always_inline bool folio_test_ksm(const struct folio *folio)
{
        return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
                                PAGE_MAPPING_KSM;
}

static __always_inline bool PageKsm(const struct page *page)
{
        return folio_test_ksm(page_folio(page));
}

There's no such thing as a movable anon page -- the two bits in the
bottom of the mapping pointer mean:

00	file (or NULL)
01	anon
10	movable
11	KSM

Perhaps it might be clearer to say that anon pages are inherently
movable; the movable type really means that the reset of the mapping
pointer refers to a movable_operations instead of a mapping or anon_vma.

> >   	/*
> >   	 * compound pages: export both head/tail info
> >   	 * they together define a compound page's start/end pos and order
> >   	 */
> > -	if (PageHead(page))
> > -		u |= 1 << KPF_COMPOUND_HEAD;
> > -	if (PageTail(page))
> > +	if (page == &folio->page)
> > +		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
> > +	else
> >   		u |= 1 << KPF_COMPOUND_TAIL;
> This makes sense but it'd require changes to the documentation.
> I ran a python3 memhog to see if anonymous pages are currently reported
> as COMPOUND_HEAD or COMPOUND_TAIL and it seems to be a no on both.
> But with this, I think every pfn will have one of the two set.
> Unless you can have a page outside of a folio -- not sure.

I see your confusion.  We have three cases; head, tail and neither
(obviously a page is never both head & tail).  If a page is neither,
it's order-0 and it is the only page in the folio.  So we handle head
or neither in the first leg of the 'if' where we set KPF_COMPOUND_HEAD
if PG_head is set, and tail in the 'else' leg.

> Also, in
> > -	if (page_is_idle(page))
> > +#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
> > +	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
> > +#else
> > +	if (folio_test_idle(folio))
> >   		u |= 1 << KPF_IDLE;
> > +#endif
> > 
> and
> > -	if (PageSwapCache(page))
> > +#define SWAPCACHE ((1 << PG_swapbacked) | (1 << PG_swapcache))
> > +	if ((k & SWAPCACHE) == SWAPCACHE)
> >   		u |= 1 << KPF_SWAPCACHE;
> >   	u |= kpf_copy_bit(k, KPF_SWAPBACKED,	PG_swapbacked);
> it seems to me like the #ifdef/#define could be supplanted by
> folio_test_idle and folio_test_swapcache. But I guess those would
> require extra folio_flags queries and an #include <page_idle.h>.
> So if this is more performant, I can understand the design.

It's not so much the performance as it is the atomicity.  I'm doing my
best to get an atomic snapshot of the flags and report a consistent
state, even if it might be stale by the time the user sees it.

