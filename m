Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F17E7691
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjKJB3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjKJB3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:29:43 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7969544B9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:29:41 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-e7-654d8784771a
Date:   Fri, 10 Nov 2023 10:29:35 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, david@redhat.com,
        peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231110012935.GC72073@system.software.com>
References: <20231109045908.54996-1-byungchul@sk.com>
 <20231109045908.54996-3-byungchul@sk.com>
 <ZUzuUf7JfhybYBgg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUzuUf7JfhybYBgg@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC9ZZnoW5Lu2+qwcGrBhZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CVMfPi
        PPaCoyIVDzZPYmxg/MjfxcjJISFgItExtYsFxp585jcjiM0ioCrxaPkBJhCbTUBd4saNn8xd
        jBwcIgIaEm+2GHUxcnEwC7xmknj2fx9YjbBAtMSpD/vYQWxeAQuJ+asPMYEUCQl0M0ps7//C
        CpEQlDg58wnYMmYBLYkb/14ygQxlFpCWWP6PA8TkBLphyRljkApRAWWJA9uOg42REFjHLvHm
        VRcrxJ2SEgdX3GCZwCgwC8nUWUimzkKYuoCReRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYAwu
        q/0TvYPx04XgQ4wCHIxKPLwXrvukCrEmlhVX5h5ilOBgVhLhvWACFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cDI0pmiVmlctvphQO3XxhBOszdGN35P
        aVBqNk08emrF+82vBRuKNjKrWKoVp0fqM5UHnMgMvuMhJa8RwZb3RXOT8kKp1e5/+/Na9yzr
        NjOJnM0xTWBJeuy9XXNYb95Ztmc/Z9jZ/FwDmdOvcifVLPz6pnQl90cVnqakGSfP/Dq29Q7z
        r4QihQolluKMREMt5qLiRADDnOFpvQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsXC5WfdrNvS7ptqMOO1nMWc9WvYLD5v+Mdm
        8WJDO6PF1/W/mC2efupjsTg89ySrxeVdc9gs7q35z2pxftdaVosdS/cxWVw6sIDJ4vquh4wW
        x3sPMFls3jSV2eL3D6C6OVOsLE7OmsziIOjxvbWPxWPBplKPzSu0PBbvecnksWlVJ5vHpk+T
        2D3enTvH7nFixm8Wj50PLT3mnQz0eL/vKpvH4hcfmDy2/rLz+LxJzuPd/LdsAfxRXDYpqTmZ
        ZalF+nYJXBkzL85jLzgqUvFg8yTGBsaP/F2MnBwSAiYSk8/8ZgSxWQRUJR4tP8AEYrMJqEvc
        uPGTuYuRg0NEQEPizRajLkYuDmaB10wSz/7vA6sRFoiWOPVhHzuIzStgITF/9SEmkCIhgW5G
        ie39X1ghEoISJ2c+YQGxmQW0JG78e8kEMpRZQFpi+T8OEJMT6IYlZ4xBKkQFlCUObDvONIGR
        dxaS5llImmchNC9gZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGFHLav9M3MH45bL7IUYB
        DkYlHt4L131ShVgTy4orcw8xSnAwK4nwXjABCvGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9N
        EBJITyxJzU5NLUgtgskycXBKNTC2zd9nXy3X2pXw+/Oy82/TBCf23DgrMcMq0/lBzKd7n5Kn
        bGP2POOvqKQplDl3VsbyqttPjvb9kjxeF31goll12c4aQ4Z3vDMWZ3SLpgiWn5n5LPtw3+o0
        Ts7DX1XDj7yz2PvlWVlk6HMzg4jHsRKp330FJytfK7OQnmO6uHb3faX3FSz8MdpKLMUZiYZa
        zEXFiQDuQ/krpAIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 02:36:01PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 09, 2023 at 01:59:07PM +0900, Byungchul Park wrote:
> > +++ b/include/linux/page-flags.h
> > @@ -136,6 +136,7 @@ enum pageflags {
> >  	PG_arch_2,
> >  	PG_arch_3,
> >  #endif
> > +	PG_migrc,		/* Page is under migrc's control */
> >  	__NR_PAGEFLAGS,
> 
> Yeah; no.  We're out of page flags.  And CXL is insufficiently

I should've forced migrc to work only for 64bit arch. I missed it while
I removed kconifg for it. However, lemme try to avoid the additonal page
flag anyway if possible.

> compelling to add more.  If you use CXL, you don't care about
> performance, by definition.
> 
> > @@ -589,6 +590,9 @@ TESTCLEARFLAG(Young, young, PF_ANY)
> >  PAGEFLAG(Idle, idle, PF_ANY)
> >  #endif
> >  
> > +TESTCLEARFLAG(Migrc, migrc, PF_ANY)
> > +__PAGEFLAG(Migrc, migrc, PF_ANY)
> 
> Why PF_ANY?

PF_HEAD looks more fit on the purpose. I will change it to PF_HEAD.

> > +/*
> > + * Initialize the page when allocated from buddy allocator.
> > + */
> > +static inline void migrc_init_page(struct page *p)
> > +{
> > +	__ClearPageMigrc(p);
> > +}
> 
> This flag should already be clear ... ?

That should be initialized either on allocation or on free.

> > +/*
> > + * Check if the folio is pending for TLB flush and then clear the flag.
> > + */
> > +static inline bool migrc_unpend_if_pending(struct folio *f)
> > +{
> > +	return folio_test_clear_migrc(f);
> > +}
> 
> If you named the flag better, you wouldn't need this wrapper.

I will.

> > +static void migrc_mark_pending(struct folio *fsrc, struct folio *fdst)
> > +{
> > +	folio_get(fsrc);
> > +	__folio_set_migrc(fsrc);
> > +	__folio_set_migrc(fdst);
> > +}
> 
> This is almost certainly unsafe.  By using the non-atomic bit ops, you
> stand the risk of losing a simultaneous update to any other bit in this
> word.  Like, say, someone trying to lock the folio?

fdst is not exposed yet so safe to use non-atomic in here IMHO. While..
fsrc's PG_locked is owned by the migration context and the folio has
been successfully unmapped, so I thought it'd be safe but yeah I'm not
convinced if fsrc is safe here for real. I will change it to atomic.

> > +++ b/mm/page_alloc.c
> > @@ -1535,6 +1535,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >  
> >  	set_page_owner(page, order, gfp_flags);
> >  	page_table_check_alloc(page, order);
> > +
> > +	for (i = 0; i != 1 << order; ++i)
> > +		migrc_init_page(page + i);
> 
> No.

I will change it.

Appreciate your feedback.

	Byungchul
