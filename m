Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383867F80CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbjKXSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbjKXSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:52:40 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF9119B1;
        Fri, 24 Nov 2023 10:52:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c876f1e44dso27787511fa.0;
        Fri, 24 Nov 2023 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700851964; x=1701456764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qDe7TowA3pJtD1uz4Cwe7404XRpp6gaX2/cNA2FANqc=;
        b=ePFQEcgvIshJ2JjcsayMwHRuJE4Rw+9J0HqH565+xA5siEZmTMEMQLNP/9Tu7VoJuc
         tYcbT4wzIzlxgDZQTd0de+pZF741t+WI4r/yJOQeN9FB+F57QSioEusp1hwZIXTQIQyt
         tSdTMS8D82dozSfgz51Oz5irXQ3pqsHe3WigDGQHSIU6Xmg/lNSKz2bYxoOZ2OfflxvH
         7MpqosJ6kBhUt0jP45umdsdhFc9Umavvg/kHW22zdb3udIB5/AFsXxtZur5o1ffJZEe6
         oEwtF83/Go3bPpmCSZ+WieF/VSe2oGpTZXdu4Fpo+BKgQ1zoOzMshxB0DNMZ0zJVFKbg
         sVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851964; x=1701456764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDe7TowA3pJtD1uz4Cwe7404XRpp6gaX2/cNA2FANqc=;
        b=u72u50P75i2cvdYU7/MRJ+vk21ZWX3UKGMtFVBFs9KO8OkLx7ejieOhWvYutdTZ1AN
         hNH0XPVIht/F3gMwtas39+yzCKyf+AO4Y51aUiLDCsrtzF5r7k+03Ja+oprRREuKe28e
         9IgGK4tSX47KqSWfLaHNNrFAFUaMaBuw4Fk4aFcHKKhxCU0Q74pbELe0pSO2UL3TKDUg
         Im0kJd7w6P38Om0D6kLWwSkP1ydO/dil3oe3jsMLobKxQtNyrIOh1CUUOJIjjZ1oQsAq
         E7tAO+wGPQtEqHUBVBLCSsNOaobm2W6wv2r/5XdWT0ImsZgJaq96mCoUpT1oNv/gSne+
         O4Dw==
X-Gm-Message-State: AOJu0YzR96GlusWdtQUmx39dcZZC2FnlmdsNh/upeocbCq/h19v759Gh
        fyi22+tQHq2bANGCh0tHsEG2IDJ7/kjAXw==
X-Google-Smtp-Source: AGHT+IGNg0R9xRLui1G628JhZhsnFL5EYLQEFEhNy7iHbcv6BTEAWMuZjGGNIgaIcnw8R56mCGC5pA==
X-Received: by 2002:a2e:b2d1:0:b0:2bc:d5f1:b9cf with SMTP id 17-20020a2eb2d1000000b002bcd5f1b9cfmr3058491ljz.27.1700851963901;
        Fri, 24 Nov 2023 10:52:43 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f6-20020a2eb5a6000000b002b47a15a2eesm585074ljn.45.2023.11.24.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:52:43 -0800 (PST)
Date:   Fri, 24 Nov 2023 21:52:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122182419.30633-2-fancer.lancer@gmail.com>
 <b996b542-4cd3-4f9d-b221-00b2d5ef224e@app.fastmail.com>
 <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 05:33:31PM +0000, Jiaxun Yang wrote:
> 
> 
> 在2023年11月23日十一月 下午4:07，Thomas Bogendoerfer写道：
> > On Thu, Nov 23, 2023 at 03:07:09PM +0000, Jiaxun Yang wrote:
> >> 
> [...]
> >
> > the problem with all 32bit unmapped segments is their limitations in
> > size. But there is always room to try to use unmapped and fall back
> > to mapped, if it doesn't work. But I doubt anybody is going to
> > implement that.
> 
> Yep, I guess fallback should be implemented for ioremap_cache as well.
> 
> >
> >> >> AFAIK for Loongson DMI is located at cached memory so using ioremap_uc
> >> >> blindly will cause inconsistency.
> >> >
> >> > why ?
> >> 
> >> Firmware sometimes does not flush those tables from cache back to memory.
> >> For Loongson systems (as well as most MTI systems) cache is enabled by
> >> firmware.
> >
> > kernel flushes all caches on startup, so there shouldn't be a problem.
> 
> Actually dmi_setup() is called before cpu_cache_init().

To preliminary sum the discussion, indeed there can be issues on the
platforms which have DMI initialized on the cached region. Here are
several solutions and additional difficulties I think may be caused by
implementing them:

1. Use unmapped cached region utilization in the MIPS32 ioremap_prot()
method.
This solution a bit clumsy than it looks on the first glance.
ioremap_prot() can be used for various types of the cachability
mapping. Currently it's a default-cacheable CA preserved in the
_page_cachable_default variable and Write-combined CA saved in
boot_cpu_data.writecombine. Based on that we would have needed to use
the unmapped cached region utilized for the IO-remaps called with the
"_page_cachable_default" mapping flags passed only. The rest of the IO
range mappings, including the write-combined ones, would have been
handled by VM means. This would have made the ioremap_prot() a bit
less maintainable, but still won't be that hard to implement (unless I
miss something):
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
        /*
-        * Map uncached objects in the low 512mb of address space using KSEG1,
-        * otherwise map using page tables.
+        * Map uncached/default-cached objects in the low 512mb of address
+        * space using KSEG1/KSEG0, otherwise map using page tables.
         */
-       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr) &&
-           flags == _CACHE_UNCACHED)
-               return (void __iomem *) CKSEG1ADDR(phys_addr);
+       if (IS_LOW512(phys_addr) && IS_LOW512(last_addr)) {
+               if (flags == _CACHE_UNCACHED)
+                       return (void __iomem *) CKSEG1ADDR(phys_addr);
+               else if (flags == _page_cachable_default)
+                       return (void __iomem *) CKSEG0ADDR(phys_addr);
+       }

Currently I can't figure out what obvious problems it may cause. But
It seems suspicious that the cacheable IO-mapping hasn't been
implemented by the unmapped cacheable region in the first place. In
anyway this solution looks more dangerous than solution 2. because it
affects all the MIPS32 platforms at once.

2. Convert dmi_remap_early() to ioremap_uc() (actually just ioremap()
as noted by Arnd).
As Jiaxun correctly noted this may cause problems on the platforms
which don't flush caches before jumping out to the kernel. Thomas said
that kernel flushes the caches early on boot, but Jiaxun noted that
it's still done after early DMI setup. So the issue with solution 2 is
that the setup_arch() method calls dmi_setup() before it flushes the
caches by means of the cpu_cache_init() method. I guess it can be
fixed just by moving the dmi_setup() method invocation to be after the
cpu_cache_init() is called. This solution looks much less invasive
than solution 1.

So what do you think? What solution do you prefer? Perhaps
alternative?

-Serge(y)

> 
> Thanks
> >
> > Thomas.
> >
> > -- 
> > Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> > good idea.                                                [ RFC1925, 2.3 ]
> 
> -- 
> - Jiaxun
