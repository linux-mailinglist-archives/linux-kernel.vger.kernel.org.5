Return-Path: <linux-kernel+bounces-13213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7B820134
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CC9283812
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7A12E57;
	Fri, 29 Dec 2023 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MwpB82ti"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF1712E46
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F4DC433C7;
	Fri, 29 Dec 2023 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703878833;
	bh=x/31GYYADrrkOz+dAeFPF0HkXxzTd9bKJExqTsjAEHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MwpB82ti8zhaqHuRlk9IXcgG6+UYDLqYoLPvrG7Yp8U947QVhHnL308cg/EdxkAiP
	 A4BffvNWehyXzGATmYvetCRiTXNzBkm942/VdQMAITIfdC2XFnAObx2COVPUU5hu5F
	 0DXIQ6vnHQYKW3PgK09hO80OnTy1nyKD1ARITCHw=
Date: Fri, 29 Dec 2023 11:40:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, "zhaoyang.huang"
 <zhaoyang.huang@unisoc.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com,
 Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCHv6 1/1] mm: optimization on page allocation when CMA
 enabled
Message-Id: <20231229114032.64d5320a97a7c776e10e8acf@linux-foundation.org>
In-Reply-To: <CAGWkznGbGciTocrqMowepCc=aStYFHPt8RPGYjWxQ4TRG1ZqXQ@mail.gmail.com>
References: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
	<20231107172820.GA3745089@cmpxchg.org>
	<CAGWkznGbGciTocrqMowepCc=aStYFHPt8RPGYjWxQ4TRG1ZqXQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 16:55:19 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> > > +static bool use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
> > > +{
> > > +     unsigned long watermark;
> > > +     bool cma_first = false;
> > > +
> > > +     watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> > > +     /* check if GFP_MOVABLE pass previous zone_watermark_ok via the help of CMA */
> > > +     if (zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA))) {
> > > +             /*
> > > +              * Balance movable allocations between regular and CMA areas by
> > > +              * allocating from CMA when over half of the zone's free memory
> > > +              * is in the CMA area.
> > > +              */
> ok, thanks for point out.
> Could we simple it like this, which will mis-judge kmalloc within
> ioctl as GFP_USER. I think it is ok as it is rare
>              if (current_is_kswapd() || !current->mm)
>                  gfp_flags = GFP_KERNEL;
>              else
>                  gfp_flags = GFP_USER;
>             free_pages = zone_page_state(zone, NR_FREE_PAGES);
>             free_pages -= zone->lowmem_reserve[gfp_zone(gfp_flags)];
>             free_pages -= wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
>             cma_first = free_pages > zone_page_state(zone, NR_FREE_PAGES) / 2);
> 

This went all quiet.  Do we feel that "mm: optimization on page
allocation when CMA enabled" should be merged as-is, or dropped in the
expectation that something based on Johannes's suggestion will be
developed?


