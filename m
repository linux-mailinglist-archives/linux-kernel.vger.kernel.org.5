Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897E7F69EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjKXApJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXApH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:45:07 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB252D46
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:45:13 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-357d0d15b29so119685ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700786713; x=1701391513; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjvlNJZCYVj3BK/c/qbMtW/UyhsFITEp4fF0Uz8Mao8=;
        b=Bc9Tqz5H3ZS23EAjFw7671QpKqrxMT/wpxfMezDyGzdGCgtc4qq7ZyWgdRb6RHGP9f
         3qlXskG63nF0mNdqMS3LCs3JUTEfNAgnB+I6mB8gyXsH0tcvrfeKvwM2SomFAgIeRExf
         9pvfgus404w1uMAUqsjfjSIC2bvPM0EBNONYnaTfMyIOaHNTdylYGp7z77/RczfcnFHr
         kPUS9GG/SJSg5h6370Ie0ataKwsNkIc3Lf2zoj+ZB99Yr69IGi1q0FKhhAQQPBo6VEOk
         Wr6NnuHJY+XWlPFWCDSzo984MJuiD2XCng0UlWkcjva/dtHFrAZWcZVZIWTDYkleHuhr
         +5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700786713; x=1701391513;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjvlNJZCYVj3BK/c/qbMtW/UyhsFITEp4fF0Uz8Mao8=;
        b=C6hiZUTQtLmJOTpuFNxPA8LA3GFRFAFCrw5pAHHzuFoYTEtzpBnRtuFhcfsiqEziOi
         OE4dsmL/3PrEp8+J+1IryD1lsnvSTBAzP0tCLqg9QG9BU3ckrPdDm35qnAKzt4KJV5Lv
         2k3oaOuCmKQhZ3Ti38zat1H3P9+vb8XlwMQV73jCA6QytPnBDJERgYsHUv5Mt9lN4cCP
         qADw1fde4I+MJKnzagi+RmNIrSZgTZHKDiTMylylIljHdRFKYV7wtkf/BDiNMx416S06
         biyZigQkl7/3SFk2lFzUNJcD+TYiZ6xyH71PwJmYb9nfjBYtW28eIdcSewz63ZIKoREg
         rZHA==
X-Gm-Message-State: AOJu0YwQVpx8D9w1w0VPJdEDW6lGsQ08h8XbD9XyhpKaHWPVFiQHWZZ1
        S4GQKQlHvB+zAqu7tPOgqaB/Qw==
X-Google-Smtp-Source: AGHT+IFp5Vt0r4dxgxouGwH8qybG/NW6TxiUxTw6TyLOqXsKdt6ktNcxwvwHx0LVMlBIFEYNytErDQ==
X-Received: by 2002:a05:6e02:1687:b0:357:4335:77fe with SMTP id f7-20020a056e02168700b00357433577femr452960ila.27.1700786713087;
        Thu, 23 Nov 2023 16:45:13 -0800 (PST)
Received: from [2620:0:1008:15:ab09:50a5:ec6d:7b5c] ([2620:0:1008:15:ab09:50a5:ec6d:7b5c])
        by smtp.gmail.com with ESMTPSA id q4-20020a631f44000000b005acd5d7e11bsm1919194pgm.35.2023.11.23.16.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:45:11 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:45:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 00/21] remove the SLAB allocator
In-Reply-To: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
Message-ID: <b4d53ec4-482d-23ec-b73f-dfbc58ccc149@google.com>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023, Vlastimil Babka wrote:

> Changes from v1:
> - Added new Patch 01 to fix up kernel docs build (thanks Marco Elver)
> - Additional changes to Kconfig user visible texts in Patch 02 (thanks Kees
>   Cook)
> - Whitespace fixes and other fixups (thanks Kees)
> 
> The SLAB allocator has been deprecated since 6.5 and nobody has objected
> so far. As we agreed at LSF/MM, we should wait with the removal until
> the next LTS kernel is released. This is now determined to be 6.6, and
> we just missed 6.7, so now we can aim for 6.8 and start exposing the
> removal to linux-next during the 6.7 cycle. If nothing substantial pops
> up, will start including this in slab-next later this week.
> 

I agree with the decision to remove the SLAB allocator, same as at LSF/MM.  
Thanks for doing this, Vlastimil!

And thanks for deferring this until the next LTS kernel, it will give any 
last minute hold outs a full year to raise any issues in their switch to 
SLUB if they only only upgrade to LTS kernels at which point we'll have 
done our due diligence to make people aware of SLAB's deprecation in 6.6.

I've completed testing on v1 of the series, so feel free to add

Acked-by: David Rientjes <rientjes@google.com>
Tested-by: David Rientjes <rientjes@google.com>

to each patch so I don't spam the list unnecessarily.  I'll respond to 
individual changes that were not in v1.

Thanks again!

> To keep the series reasonably sized and not pull in people from other
> subsystems than mm and closely related ones, I didn't attempt to remove
> every trace of unnecessary reference to dead config options in external
> areas, nor in the defconfigs. Such cleanups can be sent to and handled
> by respective maintainers after this is merged.
> 
> Instead I have added some patches aimed to reap some immediate benefits
> of the removal, mainly by not having to split some fastpath code between
> slab_common.c and slub.c anymore. But that is also not an exhaustive
> effort and I expect more cleanups and optimizations will follow later.
> 
> Patch 09 updates CREDITS for the removed mm/slab.c. Please point out if
> I missed someone not yet credited.
> 
> Git version: https://git.kernel.org/vbabka/l/slab-remove-slab-v2r1
> 
> ---
> Vlastimil Babka (21):
>       mm/slab, docs: switch mm-api docs generation from slab.c to slub.c
>       mm/slab: remove CONFIG_SLAB from all Kconfig and Makefile
>       KASAN: remove code paths guarded by CONFIG_SLAB
>       KFENCE: cleanup kfence_guarded_alloc() after CONFIG_SLAB removal
>       mm/memcontrol: remove CONFIG_SLAB #ifdef guards
>       cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
>       mm/slab: remove CONFIG_SLAB code from slab common code
>       mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB ifdefs
>       mm/slab: remove mm/slab.c and slab_def.h
>       mm/slab: move struct kmem_cache_cpu declaration to slub.c
>       mm/slab: move the rest of slub_def.h to mm/slab.h
>       mm/slab: consolidate includes in the internal mm/slab.h
>       mm/slab: move pre/post-alloc hooks from slab.h to slub.c
>       mm/slab: move memcg related functions from slab.h to slub.c
>       mm/slab: move struct kmem_cache_node from slab.h to slub.c
>       mm/slab: move kfree() from slab_common.c to slub.c
>       mm/slab: move kmalloc_slab() to mm/slab.h
>       mm/slab: move kmalloc() functions from slab_common.c to slub.c
>       mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers
>       mm/slub: optimize alloc fastpath code layout
>       mm/slub: optimize free fast path code layout
> 
>  CREDITS                           |   12 +-
>  Documentation/core-api/mm-api.rst |    2 +-
>  arch/arm64/Kconfig                |    2 +-
>  arch/s390/Kconfig                 |    2 +-
>  arch/x86/Kconfig                  |    2 +-
>  include/linux/cpuhotplug.h        |    1 -
>  include/linux/slab.h              |   22 +-
>  include/linux/slab_def.h          |  124 --
>  include/linux/slub_def.h          |  204 --
>  kernel/cpu.c                      |    5 -
>  lib/Kconfig.debug                 |    1 -
>  lib/Kconfig.kasan                 |   11 +-
>  lib/Kconfig.kfence                |    2 +-
>  lib/Kconfig.kmsan                 |    2 +-
>  mm/Kconfig                        |   68 +-
>  mm/Kconfig.debug                  |   16 +-
>  mm/Makefile                       |    6 +-
>  mm/dmapool.c                      |    2 +-
>  mm/kasan/common.c                 |   13 +-
>  mm/kasan/kasan.h                  |    3 +-
>  mm/kasan/quarantine.c             |    7 -
>  mm/kasan/report.c                 |    1 +
>  mm/kfence/core.c                  |    4 -
>  mm/memcontrol.c                   |    6 +-
>  mm/mempool.c                      |    6 +-
>  mm/slab.c                         | 4026 -------------------------------------
>  mm/slab.h                         |  551 ++---
>  mm/slab_common.c                  |  231 +--
>  mm/slub.c                         |  617 +++++-
>  29 files changed, 815 insertions(+), 5134 deletions(-)
> ---
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> change-id: 20231120-slab-remove-slab-a76ec668d8c6
> 
> Best regards,
> -- 
> Vlastimil Babka <vbabka@suse.cz>
> 
> 
