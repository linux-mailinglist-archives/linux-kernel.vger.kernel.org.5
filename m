Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D47FC264
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjK1Nwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbjK1Nwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:52:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662B1B9;
        Tue, 28 Nov 2023 05:52:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50aab20e828so7745906e87.2;
        Tue, 28 Nov 2023 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701179564; x=1701784364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zdp8wM5mdcJ2pPETgwdkiP9a0VP/a2KaBQAJWAJ1d/o=;
        b=GerNxo1p8yZnEE/GUH/Ozq+7VC8IVgmO2Vh+7/HPYKeo9uwoeu66GHAjckfoSsCYwB
         yLg4G2iYLX2GWjY+grQOqYmvg5HeIbKkmfAHrbDSFOoVn1j4XI+UfGA+e3JwHIa2rSFO
         bZZaj2CmWoFVW171YEY5brG76in7lXx5R9EJ2sJ6tJhkHqnVk0QoXXx24FQftgE/ger/
         weW1zZ32t8DNRSRzvPGtseTzUj8jpoK8Ov0xrs7yyXMJvPZTw8wwAfqF6fdHnq+78Pcr
         P/SHeH0XtA95/JtcQN+eXHojBskfvuod+3tT7RL+ar3LDLrEAuSPmChYeESErPEBcO4g
         AzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701179564; x=1701784364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zdp8wM5mdcJ2pPETgwdkiP9a0VP/a2KaBQAJWAJ1d/o=;
        b=vWZ2D4AczOitiUKnHc2qbquZgNq8c/U54Fx7prLk4P0rUB1W88KNKwIQ8Cim62WnD7
         Bqh6ZMje7FrsKjlFXJ6kkaY8HG2Wr0qBMd4cIaIwQEyDDAs1eGg6D1KFAf+Jhlp82kbv
         kCc+NJKZhACB4wmABR07+Stc97nrqVB1buPVOdmjaBHAUAxBaatnAxeSLvCD/10+jVy9
         GquHmqV3F73iHC7QwC+Xmkis780vGyKYGJE4CPy3eaS6/jXCzpjd0iKJYrTRsFvtbAH0
         68UfCUeA4VzOvrFuZLd5ddh5O9Kh4tT2z7QF4wGOojApUg4vDq7tdhHu2P3zHoLNRD10
         73Sw==
X-Gm-Message-State: AOJu0YzMq/27bTPrapJp214LD8jkBg5rFM3Unst4O+v2ruf+h0/NuND9
        /vikY2ZkS1+1FWqsJfD6wSE=
X-Google-Smtp-Source: AGHT+IEvs+w+SpLiVGQgshh970Y5yEF981x0ef7grRlpiuoGJL/zdRsNPa7GzE16nhyKpWySFcaTLQ==
X-Received: by 2002:a05:6512:2242:b0:50b:a995:24e2 with SMTP id i2-20020a056512224200b0050ba99524e2mr8860155lfu.21.1701179563757;
        Tue, 28 Nov 2023 05:52:43 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f20-20020a05651232d400b0050ba6e6db5fsm1372205lfg.262.2023.11.28.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 05:52:43 -0800 (PST)
Date:   Tue, 28 Nov 2023 16:52:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>, Marc Zyngier <maz@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mips: dmi: Fix early remap on MIPS32
Message-ID: <fvbe4625dgh57c3njx7fhd6vlnfxynzipfz43ieu2txflc2q4r@xzvrrmmktxsb>
References: <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c1c0a409-902e-4609-ae84-8939226b4fa0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1c0a409-902e-4609-ae84-8939226b4fa0@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On Tue, Nov 28, 2023 at 01:41:51PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 27, 2023, at 17:23, Serge Semin wrote:
> > On Fri, Nov 24, 2023 at 10:03:49PM +0000, Jiaxun Yang wrote:
> >> 在2023年11月24日十一月 下午6:52，Serge Semin写道：
> >> > On Thu, Nov 23, 2023 at 05:33:31PM +0000, Jiaxun Yang wrote:
> >> >> 
> >> [...]
> >> >> Actually dmi_setup() is called before cpu_cache_init().
> >> >
> >> > To preliminary sum the discussion, indeed there can be issues on the
> >> > platforms which have DMI initialized on the cached region. Here are
> >> > several solutions and additional difficulties I think may be caused by
> >> > implementing them:
> >> 
> >> Thanks for such detailed conclusion!
> >> I'd prefer go solution 1, with comments below.
> >> >
> >> > 1. Use unmapped cached region utilization in the MIPS32 ioremap_prot()
> >> > method.
> >> > This solution a bit clumsy than it looks on the first glance.
> >> > ioremap_prot() can be used for various types of the cachability
> >> > mapping. Currently it's a default-cacheable CA preserved in the
> >> > _page_cachable_default variable and Write-combined CA saved in
> >> > boot_cpu_data.writecombine. Based on that we would have needed to use
> >> > the unmapped cached region utilized for the IO-remaps called with the
> >> > "_page_cachable_default" mapping flags passed only. The rest of the IO
> >> > range mappings, including the write-combined ones, would have been
> >> > handled by VM means. This would have made the ioremap_prot() a bit
> >> > less maintainable, but still won't be that hard to implement (unless I
> >> > miss something):
> >> > --- a/arch/mips/mm/ioremap.c
> >> > +++ b/arch/mips/mm/ioremap.c
> >> >         /*
> >> > -        * Map uncached objects in the low 512mb of address space using KSEG1,
> >> > -        * otherwise map using page tables.
> >> > +        * Map uncached/default-cached objects in the low 512mb of address
> >> > +        * space using KSEG1/KSEG0, otherwise map using page tables.
> >> >          */
> >> > -       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr) &&
> >> > -           flags == _CACHE_UNCACHED)
> >> > -               return (void __iomem *) CKSEG1ADDR(phys_addr);
> >> > +       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr)) {
> >> > +               if (flags == _CACHE_UNCACHED)
> >> > +                       return (void __iomem *) CKSEG1ADDR(phys_addr);
> >> > +               else if (flags == _page_cachable_default)
> >> > +                       return (void __iomem *) CKSEG0ADDR(phys_addr);
> >> > +       }
> >> >
> >> > Currently I can't figure out what obvious problems it may cause. But
> >> > It seems suspicious that the cacheable IO-mapping hasn't been
> >> > implemented by the unmapped cacheable region in the first place. In
> >> > anyway this solution looks more dangerous than solution 2. because it
> >> > affects all the MIPS32 platforms at once.
> >> 
> >> I just made a quick grep in tree, and it seems like we don't have much
> >> user of ioremap_cache (as well as ioremap_uc/wc) here so I think it is
> >> a safe assumption.
> >
> > I wouldn't say there aren't much users. ioremap_wc() and it's
> > devm-version is widely utilized in the GPU and network and some other
> > subsystems. ioremap_cache() isn't widespread indeed. In anyway even a
> > single user must be supported in safely calling the method if it's
> > provided by the arch-code, otherwise the method could be considered as
> > just a bogus stub to have the kernel successfully built. I bet you'll
> > agree with that. But that's not the point in this case.
> 

> ioremap_wc() is useful for mapping PCI attached memory such as frame
> buffers, 

Thanks for clarification. That's actually the reason why I originally
added the ioremap_wc() support to the MIPS32 arch. In one of the
projects we had SM750/SM768-based graphic cards attached to the
MIPS32-based SoC. Using ioremap_wc() for the framebuffer significantly
improved the graphic subsystem performance indeed. It was mostly
required for the SM750 chips though, which provided a narrow and slow
PCIe Gen.1 x1 interface.

> but ioremap_cache() is generally underspecified because the
> resulting pointer is neither safe to dereference nor to pass into
> readl()/writel()/memcpy_fromio() on all architectures.

I don't know about ARM64 (which for instance has it utilized to access
the DMI region), but at least in case of MIPS32 (a fortiori MIPS64
seeing the ioremap_cache() method actually returns a pointer to the
uncached region) I don't see a reason why it wouldn't be safe in both
cases described by you. All IO and memory regions are accessed by the
generic load and store instructions. The only difference is that the
MMIO-space accessors normally implies additional barriers, which just
slow down the execution, but shouldn't cause any other problem. Could
you clarify why do you think otherwise?

> 
> There was an effort to convert the remaining ioremap_cache() calls
> into memremap() a few years ago, not sure if that's still being worked
> on but it would be the right thing to do.

I see. Thanks for the pointing out to that. I guess it could be done
for MIPS too (at least on our MIPS32 platform DMI is just a memory
region pre-initialized by the bootloader), but the conversion would
require much efforts. Alas currently I can't afford to get it
implemented in the framework of this patchset. (I saved your note in
my MIPS TODO list though. Let's hope eventually I'll be able to get
back to this topic.)

-Serge(y)

> 
>      Arnd
