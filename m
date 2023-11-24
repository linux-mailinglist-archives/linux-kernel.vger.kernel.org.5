Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850C17F6DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjKXITL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbjKXITI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:19:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA7BD48
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:19:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B288C433D9;
        Fri, 24 Nov 2023 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700813954;
        bh=r0jJ6NYuoUAc6x48eoCiJUxmyoGuCEuvMzB7D/Sb8+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXs+mMJGkZJwl7lIbWcJ8egMkYzH1x9vLsBdwIfm1ong7POe91YWeP4fLxRSnmm58
         ALWKq+0PKbMjtYiIc21xK/RajleEWaV/Wafu2Si3FuLuJXPxDDDfO0UaDjRPjOflNY
         XFhWty4czKGTzMYKDPysf6zMNVlvHaqAHcifN69iDurSaELSgZ5BSTo9T9kV9viWAW
         e1mpPDf4Rlza2OjdnJ2h2Zsxw0FAs2NLGAmE+1sZDyDFqj2StFZ2MdjYbAZ5rIDnjD
         DjDA8fQHW7EAeEojurlmnyVGQXWsNQxRbi7yDjvGNZziislZdKvQRC+2lL1uRcAXaI
         LKjkQwsEIKwWA==
Date:   Fri, 24 Nov 2023 10:19:00 +0200
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
Message-ID: <20231124081900.GG636165@kernel.org>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-6-fancer.lancer@gmail.com>
 <20231123101854.GF636165@kernel.org>
 <ehlzzv37o4exdn4smmu653wzjdotzdv3dhr3bduvemxssp37ro@sgegnyprquk4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ehlzzv37o4exdn4smmu653wzjdotzdv3dhr3bduvemxssp37ro@sgegnyprquk4>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:42:39PM +0300, Serge Semin wrote:
> On Thu, Nov 23, 2023 at 12:18:54PM +0200, Mike Rapoport wrote:
> > On Wed, Nov 22, 2023 at 09:24:03PM +0300, Serge Semin wrote:
> > > Besides of the already described reasons the pages backended memory holes
> > > might be persistent due to having memory mapped IO spaces behind those
> > > ranges in the framework of flatmem kernel config. Add such note to the
> > > init_unavailable_range() method kdoc in order to point out to one more
> > > reason of having the function executed for such regions.
> > > 
> > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > ---
> > > 
> > > Please let me know if the IO-space pages must be initialized somehow
> > > differently rather relying on free_area_init() executing the
> > > init_unavailable_range() method.
> > 
> 
> > Maybe I'm missing something, but why do you need struct pages in the
> > IO space?
> 
> In my case at the very least that's due to having a SRAM device
> available in the middle of the MMIO-space. The region is getting
> mapped using the ioremap_wc() method (Uncached Write-Combine CA),
> which eventually is converted to calling get_vm_area() and
> ioremap_page_range() (see ioremap_prot() function on MIPS), which in
> its turn use the page structs for mapping. Another similar case is
> using ioremap_wc() in the PCIe outbound ATU space mapping of
> the graphic/video cards framebuffers.

ioremap_page_range() does not need struct pages, but rather physical
addresses.
 
> In general having the pages array defined for the IO-memory is
> required for mapping the IO-space other than just uncached (my sram
> case for example) or, for instance, with special access attribute for
> the user-space (if I am not missing something in a way VM works in
> that case).

No, struct pages are not required to map IO space. If you need to map MMIO
to userspace there's remap_pfn_range() for that.

My guess is that your system has a hole in the physical memory mappings and
with FLATMEM that hole will have essentially unused struct pages, which are
initialized by init_unavailable_range().  But from mm perspective this is
still a hole even though there's some MMIO ranges in that hole.

Now, if that hole is large you are wasting memory for unused memory map and
it maybe worth considering using SPARSEMEM.
 
> -Serge(y)
> 
> > 
> > > ---
> > >  mm/mm_init.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 077bfe393b5e..3fa33e2d32ba 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> > >   * - physical memory bank size is not necessarily the exact multiple of the
> > >   *   arbitrary section size
> > >   * - early reserved memory may not be listed in memblock.memory
> > > + * - memory mapped IO space
> > >   * - memory layouts defined with memmap= kernel parameter may not align
> > >   *   nicely with memmap sections
> > >   *
> > > -- 
> > > 2.42.1
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 

-- 
Sincerely yours,
Mike.
