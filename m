Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF77FF026
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbjK3Naf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345496AbjK3Nad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:30:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAAC10DF;
        Thu, 30 Nov 2023 05:30:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc8e37b5fso1409699e87.0;
        Thu, 30 Nov 2023 05:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701351037; x=1701955837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HqDTLfvEDRJ0H20HipHAAOT5JGHS4JK04/Hk+h/sChg=;
        b=eMdcXjnPeYWYYfBuIWWDnTiM45Hgyj32i6TJy+nKp5Eq9Oac9mj1eCiHWwM9g+REpg
         UC3/ct3KlDjMAwlaATkCGFI2IK5Z1rcqHuxLE+IH41DRdxiyrOIFzTEzHuspFhoJCzyG
         05BqEosMojf5AmroENNqxpx3TLXSXHejGs6WUnuC97HgDUwNnKi9T1brOxU9mfKrOzUc
         pCgxW/R4ujlFRPN09cFb6g/OZ00ioQ6+7b77FC3Kv6eZ6HdxO3JSadKSapbWJoJBbR9h
         YI3oMH2AdlUn+w0fFA1gEREUQ3BzzsClYkwHkdY0yK8iofcZ3YS1KjKyhOLv3AVKjPtO
         JVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351037; x=1701955837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqDTLfvEDRJ0H20HipHAAOT5JGHS4JK04/Hk+h/sChg=;
        b=iJFz277U+LDSc3GmqS60B+tn3fKLhq7cJwL4BDGljbZvrRd2GG5utjz4KPkJkMsN12
         j3tE5OVqCTJ0Uya6FmPKCkh5ERG3qJqvmbQHarEujmGVc8ZH5v+F+H/mlhmyXkgeUR7A
         TIrKpT5weXSIFU2F0+dEF4AfcK5KFbEn59zlBIOnIpBn0ky9FG3KdOI4mHXHIrw20WnU
         tUgm/rGCtZE87MAtXZkwAbTOCOlNPf/qioBs/6hqWoA42bA9AP+ljPZNOjRxE2IN2IrZ
         Y2Hh3LdJ1rmJq3j1c745yUfB9kR0Iw8yb04a75moqAEdeZNJZQ0bPf+PMOQ/41mUk4oT
         FaLQ==
X-Gm-Message-State: AOJu0YzXdbK8VxDfaY4o/Gc7O6MrCxJo1+3+9qyAEKnXJhU+QFKEGnWW
        2eO+DarRcjzMTegraRppgUQ=
X-Google-Smtp-Source: AGHT+IEoPfSp7hiaD7P0WupsEafuXYKXqvvKIN1Skgi+VDGy4z2zn5rCYEUaWlmq517DFVlXc8Bn2A==
X-Received: by 2002:a05:6512:448:b0:50b:b9c9:eb5b with SMTP id y8-20020a056512044800b0050bb9c9eb5bmr5359896lfk.27.1701351036406;
        Thu, 30 Nov 2023 05:30:36 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512028c00b0050aaa0eaafdsm169116lfp.103.2023.11.30.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:30:35 -0800 (PST)
Date:   Thu, 30 Nov 2023 16:30:33 +0300
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
Message-ID: <3gjwgqdv7jqvxcooxhoniwzr6ww4jddqfw3r4sesicom3vnx4q@2dfslawba3b3>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-6-fancer.lancer@gmail.com>
 <20231123101854.GF636165@kernel.org>
 <ehlzzv37o4exdn4smmu653wzjdotzdv3dhr3bduvemxssp37ro@sgegnyprquk4>
 <20231124081900.GG636165@kernel.org>
 <h3g6ynqem6h6hefmdawzaspvzf4u5fwfh7rken3ogy5ucr5z5t@d5gagi2ql4ee>
 <20231128071339.GJ636165@kernel.org>
 <z6r4jvuo63deg5ezzrxiewuzgdfwvcluzp45r4gmu7vwx6fmlm@d5r6phck2ovh>
 <20231129061400.GK636165@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129061400.GK636165@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 08:14:00AM +0200, Mike Rapoport wrote:
> On Tue, Nov 28, 2023 at 01:51:32PM +0300, Serge Semin wrote:
> > On Tue, Nov 28, 2023 at 09:13:39AM +0200, Mike Rapoport wrote:
> > > On Fri, Nov 24, 2023 at 02:18:44PM +0300, Serge Semin wrote:
> > 
> > > Do you mind posting your physical memory layout?
> > 
> > I actually already did in response to the last part of your previous
> > message. You must have missed it. Here is the copy of the message:
>  
> Sorry, for some reason I didn't scroll down your previous mail :)
> 
> > > On Fri, Nov 24, 2023 at 02:18:44PM +0300, Serge Semin wrote:
> > > > On Fri, Nov 24, 2023 at 10:19:00AM +0200, Mike Rapoport wrote:
> > > > ...
> > > > > 
> > > > > My guess is that your system has a hole in the physical memory mappings and
> > > > > with FLATMEM that hole will have essentially unused struct pages, which are
> > > > > initialized by init_unavailable_range().  But from mm perspective this is
> > > > > still a hole even though there's some MMIO ranges in that hole.
> > > > 
> > > > Absolutely right. Here is the physical memory layout in my system.
> > > > 0     - 128MB: RAM
> > > > 128MB - 512MB: Memory mapped IO
> > > > 512MB - 768MB..8.256GB: RAM
> > > > 
> > > > > 
> > > > > Now, if that hole is large you are wasting memory for unused memory map and
> > > > > it maybe worth considering using SPARSEMEM.
> > > > 
> > > > Do you think it's worth to move to the sparse memory configuration in
> > > > order to save the 384MB of mapping with the 16K page model? AFAIU flat
> > > > memory config is more performant. Performance is critical on the most
> > > > of the SoC applications especially when using the 10G ethernet or
> > > > the high-speed PCIe devices.
> > 
> > Could you also answer to my question above regarding using the
> > sparsemem instead on my hw memory layout?
>  

> Currently MIPS defines section size to 256MB, so with your memory layout
> with SPARSMEM there will be two sections of 256MB, at 0 and at 512MB, so
> you'll save memory map for 256M which is roughly 1M with 16k pages.
> 
> It's possible 
> 
> With SPARSEMEM the pfn_to_page() and page_to_pfn() are a bit longer in
> terms of assembly instructions, but I really doubt you'll notice any
> performance difference in real world applications.

Ok. Thank you very much for the comprehensive response. I'll give a
good thought towards moving our platform to the sparse memory config. Most
likely it will be done together with reducing SECTION_SIZE_BITS to
128MB in order to save a few more low-memory space. This will be
mostly useful it XPA is enabled and 8GB memory is available. Such case
requires a lot of low-memory for mapping, which is of just 128MB in
our device.

-Serge(y)

> 
> > > With FLATMEM the memory map exists for that
> > > hole and hence pfn_valid() returns 1 for the MMIO range as well. That makes
> > > __update_cache() to check folio state and that check would fail if the memory
> > > map contained garbage. But since the hole in the memory map is initialized
> > > with init_unavailable_range() you get a valid struct page/struct folio and
> > > everything is fine.
> > 
> > Right. That's what currently happens on MIPS32 and that's what I had
> > to fix in the framework of this series by the next patch:
> > Link: https://lore.kernel.org/linux-mips/20231122182419.30633-4-fancer.lancer@gmail.com/
> > flatmem version of the pfn_valid() method has been broken due to
> > max_mapnr being uninitialized before mem_init() is called. So
> > init_unavailable_range() didn't initialize the pages on the early
> > bootup stage. Thus afterwards, when max_mapnr has finally got a valid
> > value any attempts to call the __update_cache() method on the MMIO
> > memory hole caused the unaligned access crash.
> 
> The fix for max_mapnr makes pfn_valid()==1 for the entire memory map and
> this fixes up the struct pages in the hole.
>  
> > > 
> > > With that, the init_unavailable_range() docs need not mention IO space at
> > > all, they should mention holes within FLATMEM memory map.
> > 
> > Ok. I'll resend the patch with mentioning flatmem holes instead of
> > mentioning the IO-spaces.
> > 
> > > 
> > > As for SPARSEMEM, if the hole does not belong to any section, pfn_valid()
> > > will be false for it and __update_cache() won't try to access memory map.
> > 
> > Ah, I see. In case of the SPARSEMEM config an another version of
> > pfn_valid() will be called. It's defined in the include/linux/mmzone.h
> > header file. Right? If so then no problem there indeed.
>  
> Yes, SPARSMEM uses pfn_valid() defined in include/linux/mmzone.h
> 
> > -Serge(y)
> 
> -- 
> Sincerely yours,
> Mike.
