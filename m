Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358B760DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGYIxs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 04:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGYIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:52:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48544A3;
        Tue, 25 Jul 2023 01:50:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R99cM5c2tz688wM;
        Tue, 25 Jul 2023 16:46:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 09:50:45 +0100
Date:   Tue, 25 Jul 2023 09:50:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v2] Documentation/page_tables: Add info about
 MMU/TLB and Page Faults
Message-ID: <20230725095044.00000d56@Huawei.com>
In-Reply-To: <23157760.6Emhk5qWAg@suse>
References: <20230723120721.7139-1-fmdefrancesco@gmail.com>
        <20230724105505.000060c7@Huawei.com>
        <23157760.6Emhk5qWAg@suse>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 13:21:40 +0200
"Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:

> On lunedì 24 luglio 2023 11:55:05 CEST Jonathan Cameron wrote:
> > On Sun, 23 Jul 2023 14:07:09 +0200
> > 
> > "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:  
> > > Extend page_tables.rst by adding a section about the role of MMU and TLB
> > > in translating between virtual addresses and physical page frames.
> > > Furthermore explain the concept behind Page Faults and how the Linux
> > > kernel handles TLB misses. Finally briefly explain how and why to disable
> > > the page faults handler.
> > > 
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Mike Rapoport <rppt@kernel.org>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>  
> > 
> > Hi Fabio,
> >   
> 
> Hi Jonathan,
> 
> > Some superficial comments...  
> 
> Maybe that they are "superficial", BTW they are indeed very welcome :-)
> 
> > > ---
> > > 
> > > v1->v2: Add further information about lower level functions in the page
> > > fault handler and add information about how and why to disable / enable
> > > the page fault handler (provided a link to a Ira's patch that make use
> > > of pagefault_disable() to prevent deadlocks).
> > > 
> > > This is an RFC PATCH because of two reasons:
> > > 
> > > 1) I've heard that there is consensus about the need to revise and
> > > extend the MM documentation, but I'm not sure about whether or not
> > > developers need these kind of introductory information.
> > > 
> > > 2) While preparing this little patch I decided to take a quicj look at  
> > 
> > Spell check your intro text.  
> 
> Sure, I'll s/quicj/quick/
> 
> > > the code and found out it currently is not how I thought I remembered
> > > it. I'm especially speaking about the x86 case. I'm not sure that I've
> > > been able to properly understand what I described as a difference in
> > > workflow compared to most of the other architecture.
> > > 
> > > Therefore, for the two reasons explained above, I'd like to hear from
> > > people actively involved in MM. If this is not what you want, feel free
> > > to throw it away. Otherwise I'd be happy to write more on this and other
> > > MM topics. I'm looking forward for comments on this small work.
> > > 
> > >  Documentation/mm/page_tables.rst | 87 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 87 insertions(+)
> > > 
> > > diff --git a/Documentation/mm/page_tables.rst
> > > b/Documentation/mm/page_tables.rst index 7840c1891751..2be56f50c88f 100644
> > > --- a/Documentation/mm/page_tables.rst
> > > +++ b/Documentation/mm/page_tables.rst
> > > @@ -152,3 +152,90 @@ Page table handling code that wishes to be
> > > architecture-neutral, such as the> 
> > >  virtual memory manager, will need to be written so that it traverses all   
> of
> > >  the currently five levels. This style should also be preferred for
> > >  architecture-specific code, so as to be robust to future changes.
> > > 
> > > +
> > > +
> > > +MMU, TLB, and Page Faults
> > > +=========================
> > > +
> > > +The Memory Management Unit (MMU) is a hardware component that handles
> > > virtual to +physical address translations. It uses a relatively small   
> cache
> > > in hardware  
> > It may use a relatively...
> > (I doubt Linux supports anything that doesn't have a TLB but they aren't
> > required by some architectures - just a performance optimization that you
> > 'can' add to an implementation.)  
> 
> Oh, I didn't know that Linux supports non-MMU architectures. However I suspect 
> that the vast majority have MMU and TLB. Is it correct? 

Yes - most do.

Note that you can have an MMU without a TLB as well (or turn the TLB off)
though I'd assume that anyone doing that is half way through implementing the
MMU and will add one later given how shockingly bad performance is without a TLB.

Whilst we are here, if talking about TLBs should consider also mentioning Page Walk Caches
which cache the result of part of the MMU page table walk and are also flushed
by (some) TLB Invalidations.

> 
> I'll change the statement to "it may use, and in the vast majority of 
> supported architecture it indeed uses [...]". How about this? Is it not yet 
> what you meant?

I'd flip that around and avoid mention of architectures - what matters here is
implementations of those architectures, not the architectures themselves
(for instance RiscV and ARM v8.5 are architectures, but they allow a lot of
flexibility on implementation - including what translation caches exist).

Also plural - there are normally multiple levels of TLB similar to how
we have L1 and L2 cache with different characteristics. Can also be multiple
parallel TLBs supporting different sizes of page etc.  This stuff gets really
complex on a modern system.

Perhaps:
"In most supported CPUs, the MMU uses relatively small hardware caches called
the Translation Lookaside Buffers (TLBs) and Page Walk Caches to speed up
these translations."

Probably need to describe a Page Walk Cache in more detail though as not
as obvious a concept as a TLB.

> 
> > > +called the Translation Lookaside Buffer (TLB) to speed up these
> > > translations. +When a process wants to access a memory location, the CPU
> > > provides a virtual +address to the MMU, which then uses the TLB to quickly
> > > find the corresponding +physical address.
> > > +
> > > +However, sometimes the MMU can't find a valid translation in the TLB.   
> This
> > > +could be because the process is trying to access a range of memory that
> > > it's not +allowed to, or because the memory hasn't been loaded into RAM
> > > yet.  
> > 
> > It might not find it because this is first attempt to do the translation and
> > the MMU hasn't filled the TLB entry yet, or a capacity eviction has   
> happened.
> 
> I thought that "[...] hasn't been loaded into RAM yet" would have covered all 
> cases comprising lazy allocation, copy-n-write, and swapped out pages. I 
> talked about the first two later in the text, but I forgot to speak about 
> swapped out page frames to persistent storage so I'll add it in the next 
> version.
> 
> However, I am thinking that is not the TLB misses that may cause an exception 
> to fault in memory, but it is the MMU itself if not able to fill the TLB with 
> the content of allocated page tables. If you confirm so, I'll need to rewrite 
> the first introductory paragraphs. Can you please confirm? 

That's correct - what matters is the MMU can't perform the translation (either
via cache or via page walk.)  As an aside there are software managed TLB architectures
in which the TLB is always filled by software but we can probably ignore those :)

> 
> > Basically failure to find it in the TLB doesn't mean we get a page fault
> > (unless you are on an ancient architecture where TLB entries are software
> > filled which is definitely not the case for most modern ones).  
> 
> Let me summarize so that you can confirm or deny whether or not I 
> understood...
> 
> 1) TLB misses don't cause page faults unless MMU is not able to find the 
> entries in the hierarchy of page tables. If it finds the entries is 
> transparently refills the TLB buffer with the found translations.

In most architectures that's right.  (It's computer arch - if there is a way
to do something differently, someone will have done it).

> 
> 2) Page faults happens only if MMU, after walking the hierarchy, cannot yet 
> find any suitable translation.

Yes, but suitable translation includes things like permissions faults and
related (the boundary there gets blurry between access control and tracking
of access via things like dirty bits in the page table)

> 
> > >  When this
> > > 
> > > +happens, the MMU triggers a page fault, which is a type of interrupt that  
> > 
> > Hmm. Whilst similar to an interrupt I'd argue that it's not one..  
> 
> 3) I shouldn't define it as an "interrupt" because it technically is not. How 
> about "exception" or "software exception"?

I'd just go with exception probably.

>  
> > > +signals the CPU to pause the current process and run a special function   
> to
> > > +handle the fault.  
> > 
> > ...
> > 
> > Jonathan  
> 
> I don't read any other comments on the second part of the RFC. Does it mean 
> that the second part is OK from your POV?
> 
> It would be of great help if you could set aside some more minutes and clear 
> the doubts I just expressed and answer the questions I asked :-)
> 
> Thanks for the comments,
> 
> Fabio
> 
> 
> 

