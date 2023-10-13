Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF37C883C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjJMPED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjJMPEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:04:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF13BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bkpVCw4M4TmudAbrNzO1zak+GqCkMswU+m1zihAXMT8=; b=MPRU7qimzOznnzeVU1CsVDQOPX
        J497Z2eqAsmxgyPKnKJ3gM9nuyHTFdo8+6oEh7kKukLSmrZf8o+vvRoLEZK45URRVxOTqRg0EvxCg
        ztm1APYPQ1L4+UVIIdZgjmJ1iZU4GRmdbS822Vm0GgRcT7jbZKUN5yD3g8lXTw77g4wAPrVJHhUVU
        MbJbER2RsDsvjJfxCzCgBM622cQUKwZq4esj/v1uBQdzaVo9HkZ/NPmw+fIZ4olFQcv9ZYFKHqIso
        5y92lqD3SFdpMyoyCkEVSM2rQQJueBY0GgNLKF9LBo58FNZBvarl7ExZppS/VitRbrRjA6t5Z4zDl
        jFyUuEGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrJgr-0061yU-AA; Fri, 13 Oct 2023 15:03:01 +0000
Date:   Fri, 13 Oct 2023 16:03:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] mm, kpageflags: support folio and fix output for
 compound pages
Message-ID: <ZSlcJWvTNi3rEcPf@casper.infradead.org>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
 <63d119f7-5adb-861a-00c2-69a92b19ef9b@redhat.com>
 <20231012150226.GA473412@u2004>
 <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86170ebf-cbe3-1cda-dcb4-87e18695f9cd@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:30:34PM +0200, David Hildenbrand wrote:
> On 12.10.23 17:02, Naoya Horiguchi wrote:
> > On Thu, Oct 12, 2023 at 10:33:04AM +0200, David Hildenbrand wrote:
> > > On 10.10.23 16:27, Naoya Horiguchi wrote:
> > > > Hi everyone,
> > > > 
> > > > This patchset addresses 2 issues in /proc/kpageflags.
> > > > 
> > > >     1. We can't easily tell folio from thp, because currently both pages are
> > > >        judged as thp, and
> > > >     2. we see some garbage data in records of compound tail pages because
> > > >        we use tail pages to store some internal data.
> > > > 
> > > > These issues require userspace programs to do additional work to understand
> > > > the page status, which makes situation more complicated.
> > > > 
> > > > This patchset tries to solve these by defining KPF_FOLIO for issue 1., and
> > > > by hiding part of page flag info on tail pages of compound pages for issue 2.
> > > > 
> > > > I think that technically some compound pages like thp/hugetlb/slab could be
> > > > considered as folio, but in this version KPF_FOLIO is set only on folios
> > > 
> > > At least thp+hugetlb are most certainly folios. Regarding slab, I suspect we
> > > no longer call them folios (cannot be mapped to user space). But Im not sure
> > > about the type hierarchy.
> > 
> > I'm not sure about the exact definition of "folio", and I think it's better
> > to make KPF_FOLIO set based on the definition.
> 
> Me neither. But in any case a THP *is* a folio. So you'd have to set that
> flag in any case.
> 
> And any order-0 page (i.e., anon, pagecache) is also a folio. What you seem
> to imply with folio is "large folio". So KPF_FOLIO is really wrong as far as
> I can tell.

Our type hierarchy is degenerate ... in both the neutral and negative
sense of the word.  A folio is simply not-a-tail-page.  So, as you said,
all head pages and all order-0 pages are folios.

But we're still struggling against the legacy of our "struct page is
everything" mistake, and trying to fix that too.  The general term I've
chosen for this is "memdesc", but we aren't very far down the route of
disentangling the various types from either page or folio.  I'd imagined
that we'd convert everything to folio, then get into splitting them out,
but at least for ptdesc and slab we've gone for the direct conversion
approach.

At some point we probably want to disentangle anon folios from file
folios, but that's a fair ways down the list, after turning folios into a
separate allocation from struct page.  At least on my list ... if someone
wants to do that as a matter of urgency, I'm sure they can be accomodated.
It's not an easy task, for sure.  Our needs are better expressed as
(in Java terms) Interfaces rather than subclasses.  Or Traits/Generics
if you've started learning Rust.

We definitely have the concept of "mappable to userspace" which applies
to anon, file, netmem, some device driver allocations, some vmalloc
allocations, but not slab, page tables, or free memory.  Those memdescs
need refcount, mapcount, dirty flag, lock flag, maybe mapping?

Then we have "managed by the LRU" which applies to anon & file only.
Those memdescs need refcount, lru, and a pile of flags.

There's definitely scope for reordering and shrinking the various
memdescs.  Once they're fully separated from struct page.  What we _call_
them is a separate struggle.  Try to imagine how shrink_folio_list()
works if filemem & anonmem have different types ...

> > > It does sound inconsistent. What exactly do you want to tell user space with
> > > the new flag?
> > 
> > The current most problematic behavior is to report folio as thp (order-2
> > pagecache page is definitely a folio but not a thp), and this is what the
> > new flag is intended to tell.
> 
> We are currently considering calling these sub-PMD sized THPs "small-sized
> THP". [1] Arguably, we're starting with the anon part where we won't get
> around exposing them to the user in sysfs.
> 
> So I wouldn't immediately say that these things are not THPs. They are not
> PMD-sized THP. A slab/hugetlb is certainly not a thp but a folio. Whereby
> slabs can also be order-0 folios, but hugetlb can't.

I think this is a mistake.  Users expect THPs to be PMD sized.  We already
have the term "large folio" in use for file-backed memory; why do we
need to invent a new term for anon large folios?

> Looking at other interfaces, we do expose:
> 
> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_HEAD        15
> include/uapi/linux/kernel-page-flags.h:#define KPF_COMPOUND_TAIL        16
> 
> So maybe we should just continue talking about compound pages or do we have
> to use both terms here in this interface?

I don;t know how easy it's going to be to distinguish between a head
and tail page in the Glorious Future once pages and folios are separated.
