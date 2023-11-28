Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C357FB263
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbjK1HNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343764AbjK1HNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:13:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488B138
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:13:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCC6C433C7;
        Tue, 28 Nov 2023 07:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701155633;
        bh=IAmUZcFaVB6MmvVExaG8kzHoLyfFSQRpUzr1m1lRIkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6WQ8FwO8/butwJcmjzgFlyNd5SS6M/+gXRWbqGKHkwlghDbdydfU3In6q0t4H9hL
         wjVOKmZrEAzpcPmAzz3wG0+GtX0ChN54XQXGgD0N6/LNVl9QWqHLFBTe3V2AJB0JUv
         9bMATdMqYqHYjrJCTeaqQVBbSa5v4kRlFPZeStR+r0DIdzkxGYPZay8tqBh/3u+12N
         QXImKdMnpKHWbrdeDyfgTxnTQdhMYkN+oQGm8bkMS7anlH/Lxcub0S/H+R8SfaTsxX
         VBOwQOMI245ETsHOtUEB6Tf/6mZdnuCPtzGzrcn5h6pBgLvDFw/WkvmdSMErbL84eU
         BNREH1X4wIYLQ==
Date:   Tue, 28 Nov 2023 09:13:39 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
Message-ID: <20231128071339.GJ636165@kernel.org>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-6-fancer.lancer@gmail.com>
 <20231123101854.GF636165@kernel.org>
 <ehlzzv37o4exdn4smmu653wzjdotzdv3dhr3bduvemxssp37ro@sgegnyprquk4>
 <20231124081900.GG636165@kernel.org>
 <h3g6ynqem6h6hefmdawzaspvzf4u5fwfh7rken3ogy5ucr5z5t@d5gagi2ql4ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h3g6ynqem6h6hefmdawzaspvzf4u5fwfh7rken3ogy5ucr5z5t@d5gagi2ql4ee>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:18:44PM +0300, Serge Semin wrote:
> On Fri, Nov 24, 2023 at 10:19:00AM +0200, Mike Rapoport wrote:
> > On Thu, Nov 23, 2023 at 01:42:39PM +0300, Serge Semin wrote:
> > > On Thu, Nov 23, 2023 at 12:18:54PM +0200, Mike Rapoport wrote:
> > > > On Wed, Nov 22, 2023 at 09:24:03PM +0300, Serge Semin wrote:
> > > > > Besides of the already described reasons the pages backended memory holes
> > > > > might be persistent due to having memory mapped IO spaces behind those
> > > > > ranges in the framework of flatmem kernel config. Add such note to the
> > > > > init_unavailable_range() method kdoc in order to point out to one more
> > > > > reason of having the function executed for such regions.
> > > > > 
> > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Please let me know if the IO-space pages must be initialized somehow
> > > > > differently rather relying on free_area_init() executing the
> > > > > init_unavailable_range() method.
> > > > 
> > > 
> > > > Maybe I'm missing something, but why do you need struct pages in the
> > > > IO space?
> > > 
> > > In my case at the very least that's due to having a SRAM device
> > > available in the middle of the MMIO-space. The region is getting
> > > mapped using the ioremap_wc() method (Uncached Write-Combine CA),
> > > which eventually is converted to calling get_vm_area() and
> > > ioremap_page_range() (see ioremap_prot() function on MIPS), which in
> > > its turn use the page structs for mapping. Another similar case is
> > > using ioremap_wc() in the PCIe outbound ATU space mapping of
> > > the graphic/video cards framebuffers.
> > 
> > ioremap_page_range() does not need struct pages, but rather physical
> > addresses.
> 
> Unless I miss something or MIPS32 is somehow special/wrong in that
> matter, but from my just got experience it actually does at least in
> the framework of the __update_cache() implementation which is called
> in the set_ptes() method (former set_pte_at()), which in its turn
> is eventually invoked by vmap_range_noflush() and finally by
> ioremap_page_range(). See the patch
> [PATCH 3/7] mips: Fix max_mapnr being uninitialized on early stages
> Link: https://lore.kernel.org/linux-mips/20231122182419.30633-4-fancer.lancer@gmail.com/
> of this series and the stack-trace of the bug fixed by that patch.
> 
> Is it wrong that on MIPS32 ioremap_page_range() eventually relies on
> the page structs? It has been like that for, I don't know, long time.
> If so then the sparse memory config might be broken on MIPS32..(
 
Do you mind posting your physical memory layout?

If I understand correctly, you have a hole in your RAM and there is MMIO
region somewhere in that hole. With FLATMEM the memory map exists for that
hole and hence pfn_valid() returns 1 for the MMIO range as well. That makes
__update_cache() to check folio state and that check would fail if the memory
map contained garbage. But since the hole in the memory map is initialized
with init_unavailable_range() you get a valid struct page/struct folio and
everything is fine.

With that, the init_unavailable_range() docs need not mention IO space at
all, they should mention holes within FLATMEM memory map.

As for SPARSEMEM, if the hole does not belong to any section, pfn_valid()
will be false for it and __update_cache() won't try to access memory map.
  
> > > In general having the pages array defined for the IO-memory is
> > > required for mapping the IO-space other than just uncached (my sram
> > > case for example) or, for instance, with special access attribute for
> > > the user-space (if I am not missing something in a way VM works in
> > > that case).
> > 
> 
> > No, struct pages are not required to map IO space. If you need to map MMIO
> > to userspace there's remap_pfn_range() for that.
> 
> Is this correct for both flat and sparse memory config? In anyway
> please see my comment above about the problem I recently got.
> 
> > 
> > My guess is that your system has a hole in the physical memory mappings and
> > with FLATMEM that hole will have essentially unused struct pages, which are
> > initialized by init_unavailable_range().  But from mm perspective this is
> > still a hole even though there's some MMIO ranges in that hole.
> 
> Absolutely right. Here is the physical memory layout in my system.
> 0     - 128MB: RAM
> 128MB - 512MB: Memory mapped IO
> 512MB - 768MB..8.256GB: RAM
> 
> > 
> > Now, if that hole is large you are wasting memory for unused memory map and
> > it maybe worth considering using SPARSEMEM.
> 
> Do you think it's worth to move to the sparse memory configuration in
> order to save the 384MB of mapping with the 16K page model? AFAIU flat
> memory config is more performant. Performance is critical on the most
> of the SoC applications especially when using the 10G ethernet or
> the high-speed PCIe devices.
> 
> -Serge(y)
> 
> >  
> > > -Serge(y)
> > > 
> > > > 
> > > > > ---
> > > > >  mm/mm_init.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > > > index 077bfe393b5e..3fa33e2d32ba 100644
> > > > > --- a/mm/mm_init.c
> > > > > +++ b/mm/mm_init.c
> > > > > @@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> > > > >   * - physical memory bank size is not necessarily the exact multiple of the
> > > > >   *   arbitrary section size
> > > > >   * - early reserved memory may not be listed in memblock.memory
> > > > > + * - memory mapped IO space
> > > > >   * - memory layouts defined with memmap= kernel parameter may not align
> > > > >   *   nicely with memmap sections
> > > > >   *
> > > > > -- 
> > > > > 2.42.1
> > > > > 
> > > > 
> > > > -- 
> > > > Sincerely yours,
> > > > Mike.
> > > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
