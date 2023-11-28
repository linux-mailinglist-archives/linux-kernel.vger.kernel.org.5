Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503C7FB97F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjK1LeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjK1LeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:34:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC791A5;
        Tue, 28 Nov 2023 03:34:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7272188e87.0;
        Tue, 28 Nov 2023 03:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701171249; x=1701776049; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HinylyjMIV3zakyLQJjGGG/zA6qqtkTIM5z3ZBjPgUw=;
        b=TzMd6X1e60RedeDp8HpShngardyf8Qvpt/VVm2W5npSSboXzc143/RhKu8nqXqW3V7
         Iew7MpTnt1p4HjaIyM4AeGgHRhBKY72yaSTtBXHkt9NJhF117rxFhZMPRyv6tZ2ftRk8
         LkuRyXBbvPaUfh3z5NkCiU/y4HEcByowM0KnF1Q0dfdGOkzs3pd2LwGWDPvSd4Zhjxj1
         AFvM+Fx5M0YvJbXbTI059k1pT6E+A1R2ORvY/aLQErB+bIKfg5/yFmELXm6ReXOs1To9
         Ag8+QC+miHCiSBKZ0SNTka2MQBVUJ0SDBSLg6nKBlgF77Rx7O2JpUefH062ItjCvR90B
         SBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701171249; x=1701776049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HinylyjMIV3zakyLQJjGGG/zA6qqtkTIM5z3ZBjPgUw=;
        b=gD6vJTDluYwzwWoRVn2RNijKe/Ll/+Kf9OObHb7YppPK8d4DiS7iSkFJ8I4GlmAEkU
         x2tcUSymzFvgw9hpNDNXergVuCOMz+uNht4t8Ol/KSWfCUhpa1W2tXiuDkBUGQKBw945
         Kqdu6aGbG9Fv3kpRgUJ5Kaa0aUaWbXh6ebvxH8p9N+yFz7fB9hrhjpvsia3pnbFnb9Dq
         OjBgzYsQQPGRXauL/TbiXoLuqRQAl3qfXPWvBhe814Ri99JaZ2zGO2byr9/fvd6SrwjC
         MK5d3nFpHxL0y6DiNOQkML3SOYC5LYrFRBlNSWDkejI72TmYE1iB6g5FJANa74PAaeXS
         FjSQ==
X-Gm-Message-State: AOJu0YwW6i+j+i+RsWD6P1f22xuy1I/6bVHUdgaTr44a4m11+oKfLSLZ
        yTkw/5fUOmzoxX4zo+0Yyl4=
X-Google-Smtp-Source: AGHT+IGE5qifJckMD+F1s0FDK+EpXSW5ug9B4iWKSn8uouCdGMtyGXXLIyjxoyEEXslH/qHIkCjT9w==
X-Received: by 2002:ac2:4c48:0:b0:507:b7db:1deb with SMTP id o8-20020ac24c48000000b00507b7db1debmr11909699lfk.38.1701171249157;
        Tue, 28 Nov 2023 03:34:09 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k20-20020ac24574000000b00507a8789b43sm1820151lfm.269.2023.11.28.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:34:08 -0800 (PST)
Date:   Tue, 28 Nov 2023 14:34:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <3pgnihbrp5orh4tmj45fipbfoxdwzjh6uefitdpcea2vgkarcm@d56gv3areswl>
References: <c7cuvhuu6py5vxhhvkhekv6ned5sro4a3wzzn7v45oahfw42ud@gyqmucagt5e2>
 <8ca730b9-fa8c-46ea-bdc5-158da0f29c3a@app.fastmail.com>
 <ZV9Fq1ihUm1Rn6yO@alpha.franken.de>
 <d6d7e27a-b1a1-48af-be6c-aa9097c48992@app.fastmail.com>
 <ZV94rifAIF2p9Nej@alpha.franken.de>
 <245d3985-9085-4be0-8c74-d95d06334584@app.fastmail.com>
 <3iksuovvsln3cw3xpmjd7f7xixfvwaneu4ok56fnookvyolpco@wrxxew3thgnq>
 <dfda70b6-3291-462f-bc87-06dcc87bd068@app.fastmail.com>
 <ysij22pivneyg7tk3bv3hti3tsgbzglb6pin3my7r3bokzxjj6@jrjmu45gbupr>
 <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c73d9dbf-b637-47ff-ae2d-6f8987345410@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:08:11PM +0000, Jiaxun Yang wrote:
> 
> 
> 在2023年11月27日十一月 下午4:23，Serge Semin写道：
> [...]
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
> > agree with that. But that's not the point in this case,
> >
> > A bit later you also noted:
> >
> > On Fri, Nov 24, 2023 at 10:34:49PM +0000, Jiaxun Yang wrote:
> >> A nip, _page_cachable_default is set in cpu_cache_init() as well. We'd
> >> better move it to cpu-probe.c, or give it a reasonable default value.
> >
> > Right. Thanks. To be honest I haven't noticed that before your
> > message. _page_cachable_default is indeed initialized in the
> > cpu_cache_init() method, several steps after it would be used in the
> > framework of dmi_remap_early(). On the other hand ioremap_cache() is
> > defined as ioremap_prot() with the _page_cachable_default variable
> > passed. So my code will still correctly work unless
> > _page_cachable_default is pre-initialized with something other than
> > zero. On the other hand we can't easily change its default value
> > because it will affect and likely break the r3k (CPU_R3000) and Octeon
> > based platforms, because it's utilized to initialize the
> > protection-map table. Of course we can fix the r3k_cache_init() and
> > octeon_cache_init() methods too so they would get the
> > _page_cachable_default variable back to zero, but it will also make
> > things around it more complicated.
> >
> > Also note, moving the _page_cachable_default initialization to the
> > earlier stages like cpu_probe() won't work better because the field
> > value may get change for instance in the framework of the smp_setup()
> > function (see cps_smp_setup()).
> >
> > So after all the considerations above this solution now looks even
> > clumsier than before.( Any idea how to make it better?
> 

> I think the best solution maybe just use CKSEG0 to setup map here.
> 
> Btw I was thinking about 64 bit here, I thought for 64bit we would
> just embedded prot into XKPHYS, however I quickly figure out
> ioremap_cache was never implemented properly on 64-bit system,
> so does ioremap_wc.
> 
> > u64 base = (flags == _CACHE_UNCACHED ? IO_BASE : UNCAC_BASE);
> 
> Which is always uncached mapping.

Indeed. Thanks for pointing that out. In the last days several times I
was looking at that line and for some reason UNCAC_BASE seemed as
CAC_BASE to me.) Based on what both IO_BASE and UNCAC_BASE are defined
as of the uncached region anyway, then it should be safe for any
currently supported MIPS64 (including the Loongson's) to use ioremap()
in place of dmi_early_remap(). So basically my current patch in the
subject won't change the method semantics. Let's not to try to fix a
problem which doesn't exist then, and keep the patch as is especially
seeing that the alternatives might still cause some troubles. Will you
be ok with that?

-Serge(y)

> 
> >> 
> [...]
> >
> > Note the memory might be clobbered even before dmi_setup() for
> > instance by means of the early_memtest() method. In anyway it would be
> > better if the system booloader would have already reserved the DMI
> > memory (in DTB) or it would have been done by the platform-specific
> > plat_mem_setup() method.
> 
> Unfortunately, too many machines are shipped with those badly designed
> firmware. We rely on dmi_setup code to scan and preserve dmi table from
> random location in memory.
> 
> >
> >> The second is we may have some early quirks depends on DMI
> >> information.
> >
> > Which quirks do you mean to be dependent in between the current
> > dmi_setup() call place and the cpu_cache_init() method invocation?
> 
> I think we don't have any for now.
> 
> -- 
> - Jiaxun
