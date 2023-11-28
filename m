Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B582D7FB88F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjK1Kvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjK1Kvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:51:31 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B612C;
        Tue, 28 Nov 2023 02:51:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50aab20e828so7511986e87.2;
        Tue, 28 Nov 2023 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701168695; x=1701773495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNEUOBXfrdKNTWWSvUVA7lfmeos5tu5SxNOhY4Azl50=;
        b=kXDhmQeQkx9nC5k79XXYWBlD0EivdDu6CDaqU/tC3QIaWryLTG+WcqCuYIQFVnN6MZ
         LzbyP4FyQyAnfbbr7UpGHeRqu+bqR01FhLYJoMxG3PRB8KsBkofKrwTN6Y9WTR4Hx0R8
         Fu+o3wwS94wcx02BADcGMUtzgiErVsdFMfxESzJHiX0DCyEQnbOyAT+s5w0x39TZh08H
         6sjFH3/Wt60CUmcB18kFL5Y7tiyeYVl7/qjwzC4Drs/FY857TmzDLgCC+bVz4GldVyov
         ddsG5qi0x/QrBNe9gWzwx1DFs0Gb60nkZXiDGEOLlngih3A1mdORh8Oqup3GBOJoWaNW
         1UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168695; x=1701773495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNEUOBXfrdKNTWWSvUVA7lfmeos5tu5SxNOhY4Azl50=;
        b=KazzzBqX5O0UjsKy3sdkHH/ehsYNo6PbSRJQjwgnaSib6oQt+K3JV7oWvOZ4hwGnUH
         FataGT/un7NZraXeFhak0HVQHqMoRBftc3AeHhcuSM+39kdDBaz25msyPnwHC7XRqD5L
         gfmqI9yO7HF9neu3wrIC7sXhXP2u5K7zWLjilS88CTa/eZ34856gp/28ifaLqeKik/Kh
         N6fS05Q4Qkvy9pPIPAdYQrjO1rhaaghUWw73g0So5VZ5ClP2V143qUpoNSWrGGXAeRTo
         o9uUV0R3VXVYmYn9j2kfq/kH5jaduYqgitxv01ntx8yj1G0NhU/h2OntwcSh/Gcthxrw
         XwzQ==
X-Gm-Message-State: AOJu0YxSpROiJNwxpnK0wel2U2xM1W/jL0usgYTba2fCS0aNoLKL6F/F
        JgRescVy4D5xjhgzejxGC2U=
X-Google-Smtp-Source: AGHT+IEY9HIvIc6F3rmlF7DVA+fGqyD/uUP3sfqZVAd6Z0x6sP+QY9VXBhd07sqmFifUIssAv3ki6Q==
X-Received: by 2002:ac2:5234:0:b0:50b:bced:b802 with SMTP id i20-20020ac25234000000b0050bbcedb802mr652300lfl.27.1701168694990;
        Tue, 28 Nov 2023 02:51:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q9-20020a0565123a8900b0050abbda2c52sm1815933lfu.157.2023.11.28.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 02:51:34 -0800 (PST)
Date:   Tue, 28 Nov 2023 13:51:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <z6r4jvuo63deg5ezzrxiewuzgdfwvcluzp45r4gmu7vwx6fmlm@d5r6phck2ovh>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-6-fancer.lancer@gmail.com>
 <20231123101854.GF636165@kernel.org>
 <ehlzzv37o4exdn4smmu653wzjdotzdv3dhr3bduvemxssp37ro@sgegnyprquk4>
 <20231124081900.GG636165@kernel.org>
 <h3g6ynqem6h6hefmdawzaspvzf4u5fwfh7rken3ogy5ucr5z5t@d5gagi2ql4ee>
 <20231128071339.GJ636165@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128071339.GJ636165@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:13:39AM +0200, Mike Rapoport wrote:
> On Fri, Nov 24, 2023 at 02:18:44PM +0300, Serge Semin wrote:
> > On Fri, Nov 24, 2023 at 10:19:00AM +0200, Mike Rapoport wrote:
> > > On Thu, Nov 23, 2023 at 01:42:39PM +0300, Serge Semin wrote:
> > > > On Thu, Nov 23, 2023 at 12:18:54PM +0200, Mike Rapoport wrote:
> > > > > On Wed, Nov 22, 2023 at 09:24:03PM +0300, Serge Semin wrote:
> > > > > > Besides of the already described reasons the pages backended memory holes
> > > > > > might be persistent due to having memory mapped IO spaces behind those
> > > > > > ranges in the framework of flatmem kernel config. Add such note to the
> > > > > > init_unavailable_range() method kdoc in order to point out to one more
> > > > > > reason of having the function executed for such regions.
> > > > > > 
> > > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > > > 
> > > > > > ---
> > > > > > 
> > > > > > Please let me know if the IO-space pages must be initialized somehow
> > > > > > differently rather relying on free_area_init() executing the
> > > > > > init_unavailable_range() method.
> > > > > 
> > > > 
> > > > > Maybe I'm missing something, but why do you need struct pages in the
> > > > > IO space?
> > > > 
> > > > In my case at the very least that's due to having a SRAM device
> > > > available in the middle of the MMIO-space. The region is getting
> > > > mapped using the ioremap_wc() method (Uncached Write-Combine CA),
> > > > which eventually is converted to calling get_vm_area() and
> > > > ioremap_page_range() (see ioremap_prot() function on MIPS), which in
> > > > its turn use the page structs for mapping. Another similar case is
> > > > using ioremap_wc() in the PCIe outbound ATU space mapping of
> > > > the graphic/video cards framebuffers.
> > > 
> > > ioremap_page_range() does not need struct pages, but rather physical
> > > addresses.
> > 
> > Unless I miss something or MIPS32 is somehow special/wrong in that
> > matter, but from my just got experience it actually does at least in
> > the framework of the __update_cache() implementation which is called
> > in the set_ptes() method (former set_pte_at()), which in its turn
> > is eventually invoked by vmap_range_noflush() and finally by
> > ioremap_page_range(). See the patch
> > [PATCH 3/7] mips: Fix max_mapnr being uninitialized on early stages
> > Link: https://lore.kernel.org/linux-mips/20231122182419.30633-4-fancer.lancer@gmail.com/
> > of this series and the stack-trace of the bug fixed by that patch.
> > 
> > Is it wrong that on MIPS32 ioremap_page_range() eventually relies on
> > the page structs? It has been like that for, I don't know, long time.
> > If so then the sparse memory config might be broken on MIPS32..(
>  

> Do you mind posting your physical memory layout?

I actually already did in response to the last part of your previous
message. You must have missed it. Here is the copy of the message:

> On Fri, Nov 24, 2023 at 02:18:44PM +0300, Serge Semin wrote:
> > On Fri, Nov 24, 2023 at 10:19:00AM +0200, Mike Rapoport wrote:
> > ...
> > > 
> > > My guess is that your system has a hole in the physical memory mappings and
> > > with FLATMEM that hole will have essentially unused struct pages, which are
> > > initialized by init_unavailable_range().  But from mm perspective this is
> > > still a hole even though there's some MMIO ranges in that hole.
> > 
> > Absolutely right. Here is the physical memory layout in my system.
> > 0     - 128MB: RAM
> > 128MB - 512MB: Memory mapped IO
> > 512MB - 768MB..8.256GB: RAM
> > 
> > > 
> > > Now, if that hole is large you are wasting memory for unused memory map and
> > > it maybe worth considering using SPARSEMEM.
> > 
> > Do you think it's worth to move to the sparse memory configuration in
> > order to save the 384MB of mapping with the 16K page model? AFAIU flat
> > memory config is more performant. Performance is critical on the most
> > of the SoC applications especially when using the 10G ethernet or
> > the high-speed PCIe devices.
> ...

Could you also answer to my question above regarding using the
sparsemem instead on my hw memory layout?

> 
> If I understand correctly, you have a hole in your RAM and there is MMIO
> region somewhere in that hole.

Absolutely right. Please see my messages above.

> With FLATMEM the memory map exists for that
> hole and hence pfn_valid() returns 1 for the MMIO range as well. That makes
> __update_cache() to check folio state and that check would fail if the memory
> map contained garbage. But since the hole in the memory map is initialized
> with init_unavailable_range() you get a valid struct page/struct folio and
> everything is fine.

Right. That's what currently happens on MIPS32 and that's what I had
to fix in the framework of this series by the next patch:
Link: https://lore.kernel.org/linux-mips/20231122182419.30633-4-fancer.lancer@gmail.com/
flatmem version of the pfn_valid() method has been broken due to
max_mapnr being uninitialized before mem_init() is called. So
init_unavailable_range() didn't initialize the pages on the early
bootup stage. Thus afterwards, when max_mapnr has finally got a valid
value any attempts to call the __update_cache() method on the MMIO
memory hole caused the unaligned access crash.

> 
> With that, the init_unavailable_range() docs need not mention IO space at
> all, they should mention holes within FLATMEM memory map.

Ok. I'll resend the patch with mentioning flatmem holes instead of
mentioning the IO-spaces.

> 
> As for SPARSEMEM, if the hole does not belong to any section, pfn_valid()
> will be false for it and __update_cache() won't try to access memory map.

Ah, I see. In case of the SPARSEMEM config an another version of
pfn_valid() will be called. It's defined in the include/linux/mmzone.h
header file. Right? If so then no problem there indeed.

-Serge(y)

>   
> > > > In general having the pages array defined for the IO-memory is
> > > > required for mapping the IO-space other than just uncached (my sram
> > > > case for example) or, for instance, with special access attribute for
> > > > the user-space (if I am not missing something in a way VM works in
> > > > that case).
> > > 
> > 
> > > No, struct pages are not required to map IO space. If you need to map MMIO
> > > to userspace there's remap_pfn_range() for that.
> > 
> > Is this correct for both flat and sparse memory config? In anyway
> > please see my comment above about the problem I recently got.
> > 
> > > 
> > > My guess is that your system has a hole in the physical memory mappings and
> > > with FLATMEM that hole will have essentially unused struct pages, which are
> > > initialized by init_unavailable_range().  But from mm perspective this is
> > > still a hole even though there's some MMIO ranges in that hole.
> > 
> > Absolutely right. Here is the physical memory layout in my system.
> > 0     - 128MB: RAM
> > 128MB - 512MB: Memory mapped IO
> > 512MB - 768MB..8.256GB: RAM
> > 
> > > 
> > > Now, if that hole is large you are wasting memory for unused memory map and
> > > it maybe worth considering using SPARSEMEM.
> > 
> > Do you think it's worth to move to the sparse memory configuration in
> > order to save the 384MB of mapping with the 16K page model? AFAIU flat
> > memory config is more performant. Performance is critical on the most
> > of the SoC applications especially when using the 10G ethernet or
> > the high-speed PCIe devices.
> > 
> > -Serge(y)
> > 
> > >  
> > > > -Serge(y)
> > > > 
> > > > > 
> > > > > > ---
> > > > > >  mm/mm_init.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > > > > index 077bfe393b5e..3fa33e2d32ba 100644
> > > > > > --- a/mm/mm_init.c
> > > > > > +++ b/mm/mm_init.c
> > > > > > @@ -796,6 +796,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> > > > > >   * - physical memory bank size is not necessarily the exact multiple of the
> > > > > >   *   arbitrary section size
> > > > > >   * - early reserved memory may not be listed in memblock.memory
> > > > > > + * - memory mapped IO space
> > > > > >   * - memory layouts defined with memmap= kernel parameter may not align
> > > > > >   *   nicely with memmap sections
> > > > > >   *
> > > > > > -- 
> > > > > > 2.42.1
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > Sincerely yours,
> > > > > Mike.
> > > > > 
> > > 
> > > -- 
> > > Sincerely yours,
> > > Mike.
> 
> -- 
> Sincerely yours,
> Mike.
