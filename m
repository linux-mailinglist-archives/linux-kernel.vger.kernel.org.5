Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4C78A890
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjH1JLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjH1JKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925ABCC0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2623F62BB6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7404C433C8;
        Mon, 28 Aug 2023 09:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693213815;
        bh=8yrmvm8nMieA6Xf/3wi7F5BOnndbMfYhjU1I43kEeeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDWqQ45OOvzgEOQ0T1wnOVq3x9fBOQ7EcFsIvAIfexk1awYbO3dYxwKX51f6CNX6W
         yva5MKGODL4mwSCcKvhmUaJD3usi9SsW6Dw9bCiwGKWQ8KxEOPj5RqdktD5waRf0Wn
         mI2XE9yq3nV7/ccrBr6qy+mg6xECzXTH0hiL/jFR1qs6RSvI6X3bWRkiMYmNQReGEr
         zfrsOI3eUaNz6ufUsb2HDuuDmhZecUktGldii3xozx3akgKeRKRoB/nK8wiiQNcKDn
         gYqX4pfWsMckj1wpXC87ii9Cz11fn0sN7Ol1VR/qoIJL7VqHtPYB8agGUav+pap/YN
         Y49o2Y9Ic2pMA==
Date:   Mon, 28 Aug 2023 12:09:41 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        mike.kravetz@oracle.com, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com
Subject: Re: [v3 3/4] memblock: introduce MEMBLOCK_RSRV_NOINIT_VMEMMAP flag
Message-ID: <20230828090941.GD3223@kernel.org>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-4-usama.arif@bytedance.com>
 <20230828074729.GC3223@kernel.org>
 <2be1ab83-f047-245f-68ad-62c4478914a5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be1ab83-f047-245f-68ad-62c4478914a5@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:52:10PM +0800, Muchun Song wrote:
> 
> 
> On 2023/8/28 15:47, Mike Rapoport wrote:
> > On Fri, Aug 25, 2023 at 12:18:35PM +0100, Usama Arif wrote:
> > > For reserved memory regions marked with this flag,
> > > reserve_bootmem_region is not called during memmap_init_reserved_pages.
> > > This can be used to avoid struct page initialization for
> > > regions which won't need them, for e.g. hugepages with
> > > HVO enabled.
> > > 
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > > ---
> > >   include/linux/memblock.h | 10 ++++++++++
> > >   mm/memblock.c            | 32 +++++++++++++++++++++++++++-----
> > >   2 files changed, 37 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index f71ff9f0ec81..6d681d053880 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -40,6 +40,8 @@ extern unsigned long long max_possible_pfn;
> > >    * via a driver, and never indicated in the firmware-provided memory map as
> > >    * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
> > >    * kernel resource tree.
> > > + * @MEMBLOCK_RSRV_NOINIT_VMEMMAP: memory region for which struct pages are
> > > + * not initialized (only for reserved regions).
> > >    */
> > >   enum memblock_flags {
> > >   	MEMBLOCK_NONE		= 0x0,	/* No special request */
> > > @@ -47,6 +49,8 @@ enum memblock_flags {
> > >   	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
> > >   	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> > >   	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> > > +	/* don't initialize struct pages associated with this reserver memory block */
> > > +	MEMBLOCK_RSRV_NOINIT_VMEMMAP	= 0x10,
> > The flag means that struct page shouldn't be initialized, it may be used
> > not only by vmemmap optimizations.
> > Please drop _VMEMMAP.
> 
> The area at where the struct pages located is vmemmap, I think the
> "vmemap" suffix does not mean that it is for "vmemmap optimization",
> it could specify the target which will not be initialized. For me,
> MEMBLOCK_RSRV_NOINIT does not tell me what should not be initialized,
> memblock itself or its struct page (aka vmemmap pages)? So maybe
> the suffix is better to keep?

In general case the area is memmap rather than vmemmap, so a better suffix
then would be _MEMMAP. I'm not too fond of that either, but I cannot think
of better name.
 
> > 
> > And I agree with Muchun's remarks about the comments.
> > 
> > 
> > 
> > >   };
> > >   /**
> > > @@ -125,6 +129,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
> > >   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
> > >   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
> > >   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> > > +int memblock_reserved_mark_noinit_vmemmap(phys_addr_t base, phys_addr_t size);
> > memblock does not care about vmemmap, please drop _vmemmap here and below as well.
> > >   void memblock_free_all(void);
> > >   void memblock_free(void *ptr, size_t size);
> > > @@ -259,6 +264,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
> > >   	return m->flags & MEMBLOCK_NOMAP;
> > >   }
> > > +static inline bool memblock_is_noinit_vmemmap(struct memblock_region *m)
> > memblock_is_reserved_noinit please.
> > 
> > > +{
> > > +	return m->flags & MEMBLOCK_RSRV_NOINIT_VMEMMAP;
> > > +}
> > > +
> > >   static inline bool memblock_is_driver_managed(struct memblock_region *m)
> > >   {
> > >   	return m->flags & MEMBLOCK_DRIVER_MANAGED;
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > > index 43cb4404d94c..a9782228c840 100644
> > > --- a/mm/memblock.c
> > > +++ b/mm/memblock.c
> > > @@ -991,6 +991,23 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
> > >   	return memblock_setclr_flag(&memblock.memory, base, size, 0, MEMBLOCK_NOMAP);
> > >   }
> > > +/**
> > > + * memblock_reserved_mark_noinit_vmemmap - Mark a reserved memory region with flag
> > > + * MEMBLOCK_RSRV_NOINIT_VMEMMAP.
> > this should be about what marking RSRV_NOINIT does, not what flag it uses
> > 
> > > + * @base: the base phys addr of the region
> > > + * @size: the size of the region
> > > + *
> > > + * struct pages will not be initialized for reserved memory regions marked with
> > > + * %MEMBLOCK_RSRV_NOINIT_VMEMMAP.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +int __init_memblock memblock_reserved_mark_noinit_vmemmap(phys_addr_t base, phys_addr_t size)
> > > +{
> > > +	return memblock_setclr_flag(&memblock.reserved, base, size, 1,
> > > +				    MEMBLOCK_RSRV_NOINIT_VMEMMAP);
> > > +}
> > > +
> > >   static bool should_skip_region(struct memblock_type *type,
> > >   			       struct memblock_region *m,
> > >   			       int nid, int flags)
> > > @@ -2107,13 +2124,18 @@ static void __init memmap_init_reserved_pages(void)
> > >   		memblock_set_node(start, end, &memblock.reserved, nid);
> > >   	}
> > > -	/* initialize struct pages for the reserved regions */
> > > +	/*
> > > +	 * initialize struct pages for reserved regions that don't have
> > > +	 * the MEMBLOCK_RSRV_NOINIT_VMEMMAP flag set
> > > +	 */
> > >   	for_each_reserved_mem_region(region) {
> > > -		nid = memblock_get_region_node(region);
> > > -		start = region->base;
> > > -		end = start + region->size;
> > > +		if (!memblock_is_noinit_vmemmap(region)) {
> > > +			nid = memblock_get_region_node(region);
> > > +			start = region->base;
> > > +			end = start + region->size;
> > > -		reserve_bootmem_region(start, end, nid);
> > > +			reserve_bootmem_region(start, end, nid);
> > > +		}
> > >   	}
> > >   }
> > > -- 
> > > 2.25.1
> > > 
> 

-- 
Sincerely yours,
Mike.
