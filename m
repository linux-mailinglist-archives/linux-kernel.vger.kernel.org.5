Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B47A07B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbjINOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjINOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:48:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5112107
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:47:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-412195b1e9aso6251801cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694702870; x=1695307670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVH4DXY9VF/SCkIPvYlOVDAfZbiQJThhKSQDc5LVcNw=;
        b=dEvl/vwF9QLdyP21dSwoqqBIUNG9CCWp3ih3YesEMGvEVSA0eI4OLmBNP0ZQ1YC4PQ
         mVuFiH74BnvXyugbCUlOEWKFlrqVvECq1UGU1nKUNpCennn8EMK4WcyEr0wTqU7mqB0N
         PVfPGVjl1Rx1brWu9fCKtKpx1pRbjWgdOKCb5qJOY/RzYfa3aDECsLW67t+BUPdiKNoQ
         BUro0N17TwHa4GXQvTQQ2W4Saeg0vfLaoxiSAMi9A6pkNHO5IhEaGauPlNIaTFqayTp3
         6p4Nngcx0q3qR/861ZwMCXGyRKnsBbhKUTS/4D5Cf0W86o90lD9HxeqvGAf1Xpg2JC+1
         14Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702870; x=1695307670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVH4DXY9VF/SCkIPvYlOVDAfZbiQJThhKSQDc5LVcNw=;
        b=oO0VYd1uvxTMhxmuDFShWCZUmsHky2yS7dQh0rVry1ildYwALry1ik6V/bw4wPyB1R
         pgoVA4qlUgLEY85Fx3fx0zKIE+LrWw1Pyl0eRGZTMP4mmXb2LwxXOyp9//z4PqgfrMpm
         rSUUnr1a3I1IAwump7S4jzzGDhtyde0sObB7d7bqupcoj3WMaYm8aA51a1SXEPrl8PsS
         Hp5pw3ao7x8FxqwlKX7Q4W6viY1S5sKgPmElFSoPqv+Nhdsda61695FN9PFEhUfVCPFn
         6QEshMYF/bEeR85y/g+Mp7Lls7pY9CVYr8NP1LeH6ZBSqos50mW4W1zDubgnKlSapPfA
         J4Tw==
X-Gm-Message-State: AOJu0YyHxCKJ9/AJ9+CwFW0BLs6YmsvgBfnayqKJELJpQw9hP+038tBT
        vyrDeQLFtdwobOb012TlZ9adWw==
X-Google-Smtp-Source: AGHT+IEt1zAFPp8vU2TdyP2OWeytKqjErJa3k/doeFoZjHyShNPhYbqgSpaDFyBCJJnOpwKe+tZScw==
X-Received: by 2002:a05:622a:50f:b0:405:56bb:343b with SMTP id l15-20020a05622a050f00b0040556bb343bmr5702051qtx.41.1694702870337;
        Thu, 14 Sep 2023 07:47:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:35bb])
        by smtp.gmail.com with ESMTPSA id m4-20020ac807c4000000b00410ab3c78efsm493569qth.11.2023.09.14.07.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:47:50 -0700 (PDT)
Date:   Thu, 14 Sep 2023 10:47:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: page_alloc: fix freelist movement during block
 conversion
Message-ID: <20230914144749.GF48476@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-6-hannes@cmpxchg.org>
 <5911bf29-b2a0-9016-7071-68334e7d680d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5911bf29-b2a0-9016-7071-68334e7d680d@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:52:17PM +0200, Vlastimil Babka wrote:
> On 9/11/23 21:41, Johannes Weiner wrote:
> > @@ -1638,26 +1629,62 @@ static int move_freepages(struct zone *zone,
> >  	return pages_moved;
> >  }
> >  
> > -int move_freepages_block(struct zone *zone, struct page *page,
> > -				int migratetype, int *num_movable)
> > +static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> > +				      unsigned long *start_pfn,
> > +				      unsigned long *end_pfn,
> > +				      int *num_free, int *num_movable)
> >  {
> > -	unsigned long start_pfn, end_pfn, pfn;
> > -
> > -	if (num_movable)
> > -		*num_movable = 0;
> > +	unsigned long pfn, start, end;
> >  
> >  	pfn = page_to_pfn(page);
> > -	start_pfn = pageblock_start_pfn(pfn);
> > -	end_pfn = pageblock_end_pfn(pfn) - 1;
> > +	start = pageblock_start_pfn(pfn);
> > +	end = pageblock_end_pfn(pfn) - 1;
> 
> >  	/* Do not cross zone boundaries */
> > -	if (!zone_spans_pfn(zone, start_pfn))
> > -		start_pfn = zone->zone_start_pfn;
> > -	if (!zone_spans_pfn(zone, end_pfn))
> > -		return 0;
> > +	if (!zone_spans_pfn(zone, start))
> > +		start = zone->zone_start_pfn;
> > +	if (!zone_spans_pfn(zone, end))
> > +		return false;
> 
> This brings me back to my previous suggestion - if we update the end, won't
> the whole "block straddles >1 zones" situation to check for go away?
> 
> Hm or is it actually done because we have a problem by representing
> pageblock migratetype with multiple zones, since there's a single
> pageblock_bitmap entry per the respective pageblock range of pfn's, so one
> zone's migratetype could mess with other's? And now it matters if we want
> 100% match of freelist vs pageblock migratetype?

Yes, it's not safe to change a shared bitmap entry with only one of
the two zones locked.

So I think my range adjustment isn't a complete fix. It's okay for the
case I was directly encountering, where DMA starts with pfn 1 and pfn
0 belongs to nobody. But if the block straddles two genuine zones, a
race is possible.

> (I think even before this series it could have mattered for
> MIGRATETYPE_ISOLATE, is it broken in those corner cases?)

Yes, I think this is buggy indeed.

start_isolate_page_range() calls isolate_single_pageblock() on block
boundaries. It actually does round up to the zone start if the pfn is
below it, since b2c9e2fbba32 ("mm: make alloc_contig_range work at
pageblock granularity") from Zi last year. But it will still set the
migratetype on a straddling block.

And I don't see any handling for the end of the block being in another
zone. It won't move free pages due to the above, but it appears to set
the isolate migratetype in an unlocked zone.

Since nobody has complained about this, I wonder if blocks truly
straddling two different zones isn't just rare but actually
non-existent. The DMA and DMA32 boundaries should naturally align to
multiples of the pageblock order, but there might be exceptions with
ZONE_MOVABLE. Maybe somebody remembers situations where this occurs?

> But in that case we might not be detecting the situation properly for the
> later of the two zones in a pageblock, because if start_pfn is not spanned
> we adjust it and continue? Hmm...

I think what needs to happen is return false in both cases and reject
operation on blocks whose pages are in two different zones. None of
the callers expect it, and don't hold both zone locks that would be
necessary to safely move pages and adjust the migratetype.

This would fix the isolate race, as well as the freelist race that
this series is trying to eliminate.

It would mean that a straddling block can still be stolen from during
fallback, but cannot be claimed entirely and will stay MOVABLE.

It's not perfect, but certainly sounds a lot more reasonable than a
double zone locking scheme for all callers.
