Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE67F5C03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjKWKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:12:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20474BC;
        Thu, 23 Nov 2023 02:12:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso952536e87.2;
        Thu, 23 Nov 2023 02:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700734373; x=1701339173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSzcGsR12Bka54XZ6rswtH5TghxihsOmy1TzXesau9Q=;
        b=NDE/5f+0VE2fdJLJa0f03SEWXP3y6/6XDPkGq9+lDjbHE3+WKmZxgH0bn+wIKplrrW
         +9AJLnAu5yd8olnbO880oDB3VPdLiouNUKM36fOVx788ZWHfF4xv+cM3JNtCeV9F0tdx
         SJq2TVYP6t0e/muyX+0ZOUZ9qYBH0nqpn1bLoQkTTWRyBYRmZH3+0iu9vv40ozWvj5d1
         huhQ0Jptye/PpoJsJml7yLApnMJSOPfEl6pNbdkSTb5U/vGsRB3ZHXsO4vWmYfwaFh5L
         21SldY1omQ1xBcROe9Go9oO10Z69U4uSngQlgauRiU7BKmcU6dZ01AMrkdDWYp08bjCM
         UdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700734373; x=1701339173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSzcGsR12Bka54XZ6rswtH5TghxihsOmy1TzXesau9Q=;
        b=AN/1uQHyVKpCDw0/pZOOo5EueF/ZOH2BuU//Fizc6GjbsreJbCXyUP0bwd5lNkiwte
         s6qJRD6ViyJ3kqtb44PyoEiYnyKMdmhzFF3qLo3FFO7AQ782WFdJSB/Twvt0c0XnKqPu
         x6EorhJTfe0OjqIZbFnSMK75EzQqcWIfUITke5Hd6r8A1fHgyLyEoLDILoLO3d+3yZYw
         D+9eU206tsg1L6pboN76XFSgH0RPmGsF2rofQ0u1ehASNhoY9RXKTQ/rFDBCgwblzabo
         MhYaDHbKaP/I2TgsmlvDN5wlLX7ZeN0HvbDC+qFZK82OGtky+arelyEY84N0/drIVpov
         0TcQ==
X-Gm-Message-State: AOJu0YwgfT9mriB0lhX0VCTQ+r5ghSiLIPV+FkMalVMf7lcJQDcvB+rg
        as6L9NboYZNHM72ChpNankY=
X-Google-Smtp-Source: AGHT+IGuVcMYF1AJtvzoDCxh96M1MRBrGHqCQvxbVJiV87fxLcd1l+rahWb0etAmuYGzUHsYHcsCOA==
X-Received: by 2002:a19:5519:0:b0:504:4165:54ab with SMTP id n25-20020a195519000000b00504416554abmr1920923lfe.56.1700734373112;
        Thu, 23 Nov 2023 02:12:53 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i33-20020a0565123e2100b0050aab0d19e3sm143778lfv.123.2023.11.23.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:12:52 -0800 (PST)
Date:   Thu, 23 Nov 2023 13:12:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: Re: [PATCH 0/7] MIPS: mm: Fix some memory-related issues
Message-ID: <b6jchnvezyy54lsq6mko572ltpjpudtobmfadtkjzhg6smni37@p24ye4uew2sz>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
 <20231122102900.68216218f77b61e342f37627@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122102900.68216218f77b61e342f37627@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:29:00AM -0800, Andrew Morton wrote:
> On Wed, 22 Nov 2023 21:23:58 +0300 Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > Just recently I've rebased my MIPS32-related work from kernel 6.5-rc4 onto
> > the latest kernel 6.7-rc1 and immediately got into a bootup-time
> > mm-related bug (see patches 3-5 in this series). After fixing it I decided
> > it was time to submit for review the generic MIPS code fixes which I have
> > been collecting in my local repo for the last year. I was going to submit
> > them a bit later after I finished working on a patchset with my SoC
> > arch-specific changes, but since it was getting bigger and bigger, it
> > turned to be reasonable to spill out the generic part of series right away
> > especially seeing it might get to be useful in the most recent kernel.
> 

> It would have been better to separate out the two tiny unrelated MM
> patches from this series. 

One of them isn't completely unrelated to the series content. The
biggest problem I fixed in the patch
[PATCH 3/7] mips: Fix max_mapnr being uninitialized on early stages
Link: https://lore.kernel.org/linux-mips/20231122182419.30633-4-fancer.lancer@gmail.com/
of this series. I was sure that it was a correct fix at least for
having the pfn_valid() method working incorrectly, but I had doubts
whether the memory mapped IO pages were supposed to be left
uninitialized by the arch code relying on the init_unavailable_range()
doing that especially seeing it was printing a warning about having
unavailable ranges. If it turned out to be incorrect I would have
needed to drop the patch
[PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
Link: https://lore.kernel.org/linux-mips/20231122182419.30633-6-fancer.lancer@gmail.com/
and fix that problem too in the framework of the MIPS arch.

My alternative assumption regarding that problem was that the
arch-code should have used memblock_reserve() method for the IO
ranges, so then the calls-chain:
mem_init()
+-> memblock_free_all()
    +-> free_low_memory_core_early()
        +-> memmap_init_reserved_pages()
            +-> memmap_init_reserved_pages(v)
                +-> for_each_reserved_mem_region(region)
                    +-> reserve_bootmem_region(start, end, nid);
would have properly initialized the IO-pages reserved earlier by means
of the memblock_reserve() method. But it turned out that
reserve_bootmem_region() was available only when
CONFIG_DEFERRED_STRUCT_PAGE_INIT was enabled which didn't seem to be
widespreadly utilized in the arch code. Not finding a better option I
decided to stick to the solution relying on the
init_unavailable_range() method doing the trick and just fix the
method kdoc. Seeing you accepted the patch
[PATCH 5/7] mm/mm_init.c: Extend init unavailable range doc info
it was a correct decision.

> I'll steal them - if they later turn up via
> the MIPS tree then that's OK.

Ok. Thanks for picking them up. I'll drop those two patches from the
series on v2.

-Serge(y)

