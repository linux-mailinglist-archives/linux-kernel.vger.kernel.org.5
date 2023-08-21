Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEC37834A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHUVHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHUVHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:07:43 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFC712D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:07:32 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso26958045ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652052; x=1693256852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dQacKiLurV1KhiKqUcMclj3Blk3C5ciRarkpZ4fb2Q=;
        b=UuXll9nrbowzEk7gIW3wIDVaO92tV8JeKI5wZJr4l5cfcIT5RE+9QkQ6qGUxKwwc/l
         7qF8EYKRgr9Da3+rz0vVSU5XUc2inEL1xuyghc4pS1Kyr57cvUq3BFPOIhPf3fWo/itf
         5cZqLLCLCMAIvDeInjcmSlSSaih9YGY/T609277RR3MNML2cB1+xSdUzAbkD4KiyjDUB
         Ch5BWL2P8lbkEB72ngHsyAN0O62/9NNDy47EkYt55rbGPORusRZkkJ/jsYx4OhSXVWLC
         oOzG9drjN4I5ezWZ3FycfUtCTlnwWV0FzVQ8v92uGv46Eaoe8YF/Ms/TY3B1i6oxk31T
         UQjg==
X-Gm-Message-State: AOJu0YxZNO8qSFi+lGILK4+tx7hl87LgIe4RFN/igPn8EbqAopUeNIuQ
        tnWzka/6t4hOeA5SxW9F4os=
X-Google-Smtp-Source: AGHT+IFecUr3EwBjtJCL9C5gKjkmgVGFsErcMzgbX4EAMy+MQTH55g/Akiyj50l1tniL7PHZ3iZzrg==
X-Received: by 2002:a17:902:f54f:b0:1bc:7c69:925a with SMTP id h15-20020a170902f54f00b001bc7c69925amr9159484plf.33.1692652051969;
        Mon, 21 Aug 2023 14:07:31 -0700 (PDT)
Received: from snowbird ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001b89a6164desm7539543pld.118.2023.08.21.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:07:31 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:07:28 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
Message-ID: <ZOPSEJTzrow8YFix@snowbird>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821202829.2163744-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 21, 2023 at 10:28:27PM +0200, Mateusz Guzik wrote:
> To start I figured I'm going to bench about as friendly case as it gets
> -- statically linked *separate* binaries all doing execve in a loop.
> 
> I borrowed the bench from found here:
> http://apollo.backplane.com/DFlyMisc/doexec.c
> 
> $ cc -static -O2 -o static-doexec doexec.c
> $ ./static-doexec $(nproc)
> 
> It prints a result every second (warning: first line is garbage).
> 
> My test box is temporarily only 26 cores and even at this scale I run
> into massive lock contention stemming from back-to-back calls to
> percpu_counter_init (and _destroy later).
> 
> While not a panacea, one simple thing to do here is to batch these ops.
> Since the term "batching" is already used in the file, I decided to
> refer to it as "grouping" instead.
> 

Unfortunately it's taken me longer to get back to and I'm actually not
super happy with the results, I wrote a batch percpu allocation api.
It's better than the starting place, but I'm falling short on the free
path. I am/was also wrestling with the lifetime ideas (should these
lifetimes be percpus problem or call site bound like you've done).

What I like about this approach is you group the percpu_counter lock
which batching percpu allocations wouldn't be able to solve no matter
how well I do.

I'll review this more closely today.

> Even if this code could be patched to dodge these counters,  I would
> argue a high-traffic alloc/free consumer is only a matter of time so it
> makes sense to facilitate it.
> 
> With the fix I get an ok win, to quote from the commit:
> > Even at a very modest scale of 26 cores (ops/s):
> > before: 133543.63
> > after:  186061.81 (+39%)
> 
> > While with the patch these allocations remain a significant problem,
> > the primary bottleneck shifts to:
> > 
> >     __pv_queued_spin_lock_slowpath+1
> >     _raw_spin_lock_irqsave+57
> >     folio_lruvec_lock_irqsave+91
> >     release_pages+590
> >     tlb_batch_pages_flush+61
> >     tlb_finish_mmu+101
> >     exit_mmap+327
> >     __mmput+61
> >     begin_new_exec+1245
> >     load_elf_binary+712
> >     bprm_execve+644
> >     do_execveat_common.isra.0+429
> >     __x64_sys_execve+50
> >     do_syscall_64+46
> >     entry_SYSCALL_64_after_hwframe+110
> 
> I intend to do more work on the area to mostly sort it out, but I would
> not mind if someone else took the hammer to folio. :)
> 
> With this out of the way I'll be looking at some form of caching to
> eliminate these allocs as a problem.
> 

I'm not against caching, this is just my first thought. Caching will
have an impact on the backing pages of percpu. All it takes is 1
allocation on a page for the current allocator to pin n pages of memory.
A few years ago percpu depopulation was implemented so that limits the
amount of resident backing pages.

Maybe the right thing to do is preallocate pools of common sized
allocations so that way they can be recycled such that we don't have to
think too hard about fragmentation that can occur if we populate these
pools over time?

Also as you've pointed out, it wasn't just the percpu allocation being
the bottleneck, but percpu_counter's global lock too for hotplug
support. I'm hazarding a guess most use cases of percpu might have
additional locking requirements too such as percpu_counter.

Thanks,
Dennis

> Thoughts?
> 
> Mateusz Guzik (2):
>   pcpcntr: add group allocation/free
>   fork: group allocation of per-cpu counters for mm struct
> 
>  include/linux/percpu_counter.h | 19 ++++++++---
>  kernel/fork.c                  | 13 ++------
>  lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
>  3 files changed, 60 insertions(+), 33 deletions(-)
> 
> -- 
> 2.39.2
> 
