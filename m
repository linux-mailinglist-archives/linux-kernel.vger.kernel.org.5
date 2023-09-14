Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89D79F971
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjINELy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjINELv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:11:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BEF0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:11:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-770ef0da4c2so35274085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694664706; x=1695269506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kV04tcnrYTzmZQ+4D62UjKXC4NsGdv1pxs9lANackDE=;
        b=TD6MNiycx+uNT0Erb4Nmx941zun+8WtUZxmWnN+S3cGV+SL0DnZMEbxzJzMvptmd3j
         fk3RQy5xRYYqzS5Z7syqPUJnZeFlK0N4uj8eBia8y5u57UyVDfyyXxInPbKAT73Wv5q2
         UxsfNa+UwCLN115Of5+zqt5RZmcP9U56uRnBZjCo1kYSdAJL54uKeGT1MAU7GzE5tOCp
         TZU1SqSLKgm3o85hZlAINceelS6ZUXoO9f0C+kyEXvo7kbNONpNLFiIcBQe6epedgkJE
         q3Syg21U096d2WPFiiLprXM99UEtpNOHpYKMow/xK78yKsn9AMyNj6jK1CsHF+Srfw26
         ZDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694664706; x=1695269506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV04tcnrYTzmZQ+4D62UjKXC4NsGdv1pxs9lANackDE=;
        b=kiQ+o5BgCQ9isT/1HTrcSy/WuNPjc+BDWoEG9aY/hMNwfVvR0GeISr73KziGF9TFjX
         wXsBkG1idSKpNWJzx8k7+D1UNQYYgBXvy41qxl13F0/xyhWEsnlHDa0lvyHqVDxBrJUA
         F1gBz6eiPRiifrHXTVf+CtJPPKoS0r6BY5YPOjceeHZHiBl/DULsXEYYCWrP66qWOEZV
         9CcOwQI9Szx/JAAcp2zrBilZG9hrJE7panlag+PtdI6n1pHT8mDDsNUPmhYaZvzN8F42
         rXAO8CFA9Uoe5hKE6HbBFATlmlrmLNfXegf4j9Tk9TI+1BVVfEDetiBTquD0NQT7RU+8
         JU/A==
X-Gm-Message-State: AOJu0YyKmgU9yTbVJsTBq8jE7KSefviNtEPOHV17fuh6eeCj28wMhNaW
        DBKBzikU+96eQhvIhbC0KeVU5w==
X-Google-Smtp-Source: AGHT+IHRzWgAVZPS3bRs6Gq7GqufufOvpMXtORh9uXQhdTBv4S/AkL+kBiRFI3OK3wKH4oYWu4J/nA==
X-Received: by 2002:a05:620a:1789:b0:75b:23a0:e7a1 with SMTP id ay9-20020a05620a178900b0075b23a0e7a1mr5161953qkb.2.1694664706122;
        Wed, 13 Sep 2023 21:11:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:35bb])
        by smtp.gmail.com with ESMTPSA id 27-20020a05620a079b00b00767b24f68edsm213124qka.62.2023.09.13.21.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 21:11:45 -0700 (PDT)
Date:   Thu, 14 Sep 2023 00:11:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: page_alloc: consolidate free page accounting
Message-ID: <20230914041144.GD48476@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-7-hannes@cmpxchg.org>
 <37dbd4d0-c125-6694-dec4-6322ae5b6dee@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dbd4d0-c125-6694-dec4-6322ae5b6dee@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:18:17PM +0200, Vlastimil Babka wrote:
> Pageblock migratetype is set under zone->lock but there are
> places that read it outside of zone->lock and then trust it to perform the
> freelist placement. See for example __free_pages_ok(), or free_unref_page()
> in the cases it calls free_one_page(). These determine pageblock migratetype
> before taking the zone->lock. Only for has_isolate_pageblock() cases we are
> more careful, because previously isolation was the only case where precision
> was needed. So I think this warning is going to trigger?

Good catch on these two. It didn't get the warning, but the code is
indeed not quite right. The fix looks straight-forward: move the
lookup in those two cases into the zone->lock.

__free_pages_ok() is used

- when freeing >COSTLY order pages that aren't THPs
- when bootstrapping the allocator
- when allocating with alloc_pages_exact()
- when "accepting" unaccepted vm host memory before first use

none of which are too hot to tolerate the bitmap access inside the
lock instead of outside. free_one_page() is used in the isolated pages
and pcp-contended paths, both of which are exceptions as well.

Plus, it saves two branches (under the lock) in those paths to test
for the isolate conditions.

And a double lookup in case there *is* isolation.

I checked the code again and didn't see any other instances like the
two here. But I'll double check tomorrow and then send a fix.

> > @@ -757,23 +783,21 @@ static inline void __free_one_page(struct page *page,
> >  	VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
> >  
> >  	VM_BUG_ON(migratetype == -1);
> > -	if (likely(!is_migrate_isolate(migratetype)))
> > -		__mod_zone_freepage_state(zone, 1 << order, migratetype);
> > -
> >  	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
> >  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
> >  
> >  	while (order < MAX_ORDER) {
> > -		if (compaction_capture(capc, page, order, migratetype)) {
> > -			__mod_zone_freepage_state(zone, -(1 << order),
> > -								migratetype);
> > +		int buddy_mt;
> > +
> > +		if (compaction_capture(capc, page, order, migratetype))
> >  			return;
> > -		}
> >  
> >  		buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
> >  		if (!buddy)
> >  			goto done_merging;
> >  
> > +		buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
> 
> You should assume buddy_mt equals migratetype, no? It's the same assumption
> as the VM_WARN_ONCE() I've discussed?

Ah, you're right, that lookup can be removed.

Actually, that section is brainfarts. There is an issue with updating
the buddy type before removing it from the list. I was confused why
this didn't warn for me, but it's because on my test setup, the
pageblock_order == MAX_ORDER since I don't have hugetlb compiled in.

The fix looks simple. I'll test it, with pb order 9 as well, and
follow-up.

> > @@ -801,9 +825,9 @@ static inline void __free_one_page(struct page *page,
> >  		 * merge with it and move up one order.
> >  		 */
> >  		if (page_is_guard(buddy))
> > -			clear_page_guard(zone, buddy, order, migratetype);
> > +			clear_page_guard(zone, buddy, order);
> >  		else
> > -			del_page_from_free_list(buddy, zone, order);
> > +			del_page_from_free_list(buddy, zone, order, buddy_mt);
> 
> Ugh so this will add account_freepages() call to each iteration of the
> __free_one_page() hot loop, which seems like a lot of unnecessary overhead -
> as long as we are within pageblock_order the migratetype should be the same,
> and thus also is_migrate_isolate() and is_migrate_cma() tests should return
> the same value so we shouldn't need to call __mod_zone_page_state()
> piecemeal like this.

Good point, this is unnecessarily naive. The net effect on the
counters from the buddy merging is nil. That's true even when we go
beyond the page block, because we don't merge isolated/cma blocks with
anything except their own.

I'll move the accounting out into a single call.

Thanks for your thorough review!
