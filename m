Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67E97644DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjG0Eao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjG0Eak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCFA2704
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2214E61D0E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795EBC433C7;
        Thu, 27 Jul 2023 04:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690432238;
        bh=cN+k+eY48RuZH7BE4ZrCVHzS0bOPBIVzGLRlD7vjyww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6eqmwQwSMZmv8jExldU9cLEmN5EIjkUg+1l1EL5GwKBUgELResKOfVZuai6Vk09h
         srM4NrsiCIiNiYC9gRajGUQbIUWryYVsinkcwE2qxgBpvF3OlctoPnXzhzLytiR011
         wT5Ke1kG/dW19at3l9RyymaBR5KdBp1ZXRzNdBQGqUXKGdoaEwoxpMnGc+Up/BD4Da
         7q3+OgEGDHcPz/Ulg5IIfxlRGB4x+FhWpEActEgxGb76zqNmh1SwLlS7wyZBGK20d2
         pgo3zWVCdS6O8JmXbOYBEM/r5Jp1dJx/iihUJVBaP/rooodZbK5TpB02SoOhfxZI8N
         mx6fStbxSjqQQ==
Date:   Thu, 27 Jul 2023 07:30:02 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
Subject: Re: [External] Re: [RFC 2/4] mm/memblock: Add hugepage_size member
 to struct memblock_region
Message-ID: <20230727043002.GA1901145@kernel.org>
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
 <20230724134644.1299963-3-usama.arif@bytedance.com>
 <20230726110113.GT1901145@kernel.org>
 <440d4a0e-c1ea-864b-54cb-aab74858319a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440d4a0e-c1ea-864b-54cb-aab74858319a@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:02:21PM +0100, Usama Arif wrote:
> 
> On 26/07/2023 12:01, Mike Rapoport wrote:
> > On Mon, Jul 24, 2023 at 02:46:42PM +0100, Usama Arif wrote:
> > > This propagates the hugepage size from the memblock APIs
> > > (memblock_alloc_try_nid_raw and memblock_alloc_range_nid)
> > > so that it can be stored in struct memblock region. This does not
> > > introduce any functional change and hugepage_size is not used in
> > > this commit. It is just a setup for the next commit where huge_pagesize
> > > is used to skip initialization of struct pages that will be freed later
> > > when HVO is enabled.
> > > 
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > > ---
> > >   arch/arm64/mm/kasan_init.c                   |  2 +-
> > >   arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
> > >   arch/powerpc/platforms/pseries/setup.c       |  4 +-
> > >   arch/powerpc/sysdev/dart_iommu.c             |  2 +-
> > >   include/linux/memblock.h                     |  8 ++-
> > >   mm/cma.c                                     |  4 +-
> > >   mm/hugetlb.c                                 |  6 +-
> > >   mm/memblock.c                                | 60 ++++++++++++--------
> > >   mm/mm_init.c                                 |  2 +-
> > >   mm/sparse-vmemmap.c                          |  2 +-
> > >   tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
> > >   11 files changed, 56 insertions(+), 38 deletions(-)
> > > 
> > 
> > [ snip ]
> > 
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index f71ff9f0ec81..bb8019540d73 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -63,6 +63,7 @@ struct memblock_region {
> > >   #ifdef CONFIG_NUMA
> > >   	int nid;
> > >   #endif
> > > +	phys_addr_t hugepage_size;
> > >   };
> > >   /**
> > > @@ -400,7 +401,8 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
> > >   				      phys_addr_t start, phys_addr_t end);
> > >   phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
> > >   				      phys_addr_t align, phys_addr_t start,
> > > -				      phys_addr_t end, int nid, bool exact_nid);
> > > +				      phys_addr_t end, int nid, bool exact_nid,
> > > +				      phys_addr_t hugepage_size);
> > 
> > Rather than adding yet another parameter to memblock_phys_alloc_range() we
> > can have an API that sets a flag on the reserved regions.
> > With this the hugetlb reservation code can set a flag when HVO is
> > enabled and memmap_init_reserved_pages() will skip regions with this flag
> > set.
> > 
> 
> Hi,
> 
> Thanks for the review.
> 
> I think you meant memblock_alloc_range_nid/memblock_alloc_try_nid_raw and
> not memblock_phys_alloc_range?

Yes.
 
> My initial approach was to use flags, but I think it looks worse than what I
> have done in this RFC (I have pushed the flags prototype at
> https://github.com/uarif1/linux/commits/flags_skip_prep_init_gigantic_HVO,
> top 4 commits for reference (the main difference is patch 2 and 4 from
> RFC)). The major points are (the bigger issue is in patch 4):
> 
> - (RFC vs flags patch 2 comparison) In the RFC, hugepage_size is propagated
> from memblock_alloc_try_nid_raw through function calls. When using flags,
> the "no_init" boolean is propogated from memblock_alloc_try_nid_raw through
> function calls until the region flags are available in memblock_add_range
> and the new MEMBLOCK_NOINIT flag is set. I think its a bit more tricky to
> introduce a new function to set the flag in the region AFTER the call to
> memblock_alloc_try_nid_raw has finished as the memblock_region can not be
> found.
> So something (hugepage_size/flag information) still has to be propagated
> through function calls and a new argument needs to be added.

Sorry if I wasn't clear. I didn't mean to add flags parameter, I meant to
add a flag and a function that sets this flag for a range. So for
MEMBLOCK_NOINIT there would be 

int memblock_mark_noinit(phys_addr_t base, phys_addr_t size);

I'd just name this flag MEMBLOCK_RSRV_NOINIT to make it clear it controls
the reserved regions.

This won't require updating all call sites of memblock_alloc_range_nid()
and memblock_alloc_try_nid_raw() but only a small refactoring of
memblock_setclr_flag() and its callers.

> - (RFC vs flags patch 4 comparison) We can't skip initialization of the
> whole region, only the tail pages. We still need to initialize the
> HUGETLB_VMEMMAP_RESERVE_SIZE (PAGE_SIZE) struct pages for each gigantic
> page.
> In the RFC, hugepage_size from patch 2 was used in the for loop in
> memmap_init_reserved_pages in patch 4 to reserve
> HUGETLB_VMEMMAP_RESERVE_SIZE struct pages for every hugepage_size. This
> looks very simple and not hacky.

But this requires having hugetlb details in memblock which feels backwards
to me.

With memblock_mark_noinit() you can decide what parts of a gigantic page
should be initialized in __alloc_bootmem_huge_page() and mark as NOINIT
only relevant range.

> If we use a flag, there are 2 ways to initialize the
> HUGETLB_VMEMMAP_RESERVE_SIZE struct pages per hugepage:
> 
> 1. (implemented in github link patch 4) memmap_init_reserved_pages skips the
> region for initialization as you suggested, and then we initialize
> HUGETLB_VMEMMAP_RESERVE_SIZE struct pages per hugepage somewhere later (I
> did it in gather_bootmem_prealloc). When calling reserve_bootmem_region in
> gather_bootmem_prealloc, we need to skip early_page_uninitialised and this
> makes it look a bit hacky.
> 
> 2. We initialize the HUGETLB_VMEMMAP_RESERVE_SIZE struct pages per hugepage
> in memmap_init_reserved_pages itself. As we have used a flag and havent
> passed hugepage_size, we need to get the gigantic page size somehow. There
> doesnt seem to be a nice way to determine the gigantic page size in that
> function which is architecture dependent. I think gigantic page size can be
> given by PAGE_SIZE << (PUD_SHIFT - PAGE_SHIFT), but not sure if this is ok
> for all architectures? If we can use PAGE_SIZE << (PUD_SHIFT - PAGE_SHIFT)
> it will look much better than point 1.
> 
> Both the RFC patches and the github flags implementation work, but I think
> RFC patches look much cleaner. If there is a strong preference for the the
> github patches I can send it to mailing list?
> 
> Thanks,
> Usama

-- 
Sincerely yours,
Mike.
