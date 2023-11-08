Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E07E4FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjKHEMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHEMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:12:20 -0500
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BD8210CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 20:12:17 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-42-654b0a9d8f88
Date:   Wed, 8 Nov 2023 13:12:08 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Message-ID: <20231108041208.GA40954@system.software.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
 <63C530D3-3A1D-4BE9-8AA7-EFF5B895BE80@vmware.com>
 <20231030125129.GD81877@system.software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030125129.GD81877@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsXC9ZZnoe5cLu9Ug7+zdCzmrF/DZvF5wz82
        ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
        bN40ldni9w+gujlTrCxOzprM4iDg8b21j8VjwaZSj80rtDwW73nJ5LFpVSebx6ZPk9g93p07
        x+5xYsZvFo+dDy095p0M9Hi/7yqbx9Zfdh6fN8l5vJv/li2AL4rLJiU1J7MstUjfLoEro7P9
        GnvBN66KJ9/vszcwruLoYuTkkBAwkfjQPZkJxv7U8QzMZhFQkVh05QsziM0moC5x48ZPMFtE
        QFHi0P57jCA2s8A7VonvnzRBbGGBaIlPe1+xg9i8AhYSC+c/AprDxSEkcIRRYuudXSwQCUGJ
        kzOfsEA0q0v8mXcJaCgHkC0tsfwfB0RYXqJ562ywXZwClhLfVxwG2yUqoCxxYNtxsJkSAtvY
        JX4t/gB1tKTEwRU3WCYwCs5CsmIWkhWzEFbMQrJiASPLKkahzLyy3MTMHBO9jMq8zAq95Pzc
        TYzAqF1W+yd6B+OnC8GHGAU4GJV4eF94eqUKsSaWFVfmHmKU4GBWEuH9a++RKsSbklhZlVqU
        H19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoExTezjfzeBU2mv+JNuTG++
        0qjFeqrin+2m7RJuLnkePZvfcU9X5RP68f7Tm8Kizm3dWcYXdthv7rimYfkx+zbHJLdYhbUf
        dtgv17h4Ofr1DPnTcWFB31zbzf4fTomUCw830buz60146TmLLO6rt4u7TzwTtL62o3RH9dxD
        yYvfbFtgsrZap+2hEktxRqKhFnNRcSIA2bMZMNYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsXC5WfdrDuXyzvVYOk2MYs569ewWXze8I/N
        4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
        jvceYLLYvGkqs8XvH0B1c6ZYWZycNZnFQdDje2sfi8eCTaUem1doeSze85LJY9OqTjaPTZ8m
        sXu8O3eO3ePEjN8sHjsfWnrMOxno8X7fVTaPxS8+MHls/WXn8XmTnMe7+W/ZAvijuGxSUnMy
        y1KL9O0SuDI626+xF3zjqnjy/T57A+Mqji5GTg4JAROJTx3PmEBsFgEViUVXvjCD2GwC6hI3
        bvwEs0UEFCUO7b/HCGIzC7xjlfj+SRPEFhaIlvi09xU7iM0rYCGxcP4joDlcHEICRxgltt7Z
        xQKREJQ4OfMJC0SzusSfeZeAhnIA2dISy/9xQITlJZq3zgbbxSlgKfF9xWGwXaICyhIHth1n
        msDINwvJpFlIJs1CmDQLyaQFjCyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcxAmNwWe2fiTsY
        v1x2P8QowMGoxMP7wtMrVYg1say4MvcQowQHs5II7197j1Qh3pTEyqrUovz4otKc1OJDjNIc
        LErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxnsiss9i/PSeMNSsjD1VWPus9lKu0qn9VbmX
        m51YOb3LTbic1lifrTkgc0ZkHtvfG3O+rZXmibkVVWYxV/4Af993h4N1sYlKMz+Ee+s4X/G7
        FlDycOm7r5735K9/KJnZf2tDZc3W1S/12y/sy47QN90/5dN6PqatZ1qsjinEv1OYFvRW9BR/
        hhJLcUaioRZzUXEiABSiR+69AgAA
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:51:30PM +0900, Byungchul Park wrote:
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 6c264d2f969c..75dc48b6e15f 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3359,6 +3359,19 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
> > > 	if (vmf->page)
> > > 		folio = page_folio(vmf->page);
> > > 
> > > +	/*
> > > +	 * This folio has its read copy to prevent inconsistency while
> > > +	 * deferring TLB flushes. However, the problem might arise if
> > > +	 * it's going to become writable.
> > > +	 *
> > > +	 * To prevent it, give up the deferring TLB flushes and perform
> > > +	 * TLB flush right away.
> > > +	 */
> > > +	if (folio && migrc_pending_folio(folio)) {
> > > +		migrc_unpend_folio(folio);
> > > +		migrc_try_flush_free_folios(NULL);
> > 
> > So many potential function calls… Probably they should have been combined
> > into one and at least migrc_pending_folio() should have been an inline
> > function in the header.
> 
> I will try to change it as you mention.
> 
> > > +	}
> > > +
> > 
> > What about mprotect? I thought David has changed it so it can set writable
> > PTEs.
> 
> I will check it out.

I found mprotect stuff is already performing TLB flushes needed for it.
So some redundant TLB flushes might happen by migrc but it's not that
harmful I think. Thanks.

	Byungchul
