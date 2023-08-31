Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B303078F327
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbjHaTOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjHaTOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:14:52 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2486E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:14:48 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a741f46fadso714252b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693509288; x=1694114088;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKQNR25aGF0ZTPxeMhChJGWQzBCVRA6DhkoN17k7mmA=;
        b=C6LhETBcuyXIK4oEGx6Zf8B2M3N5Nbjs3rJZqJmQTV5H6AmwXeT3LdDqNFn4kVag7w
         tsh+wVuI9tGA57S2sQOZIA3x0/Ljj/bs234kSOxNqj7Ftgnf/eOIyCoEq0sbV9WlSFIx
         ckr3Vb9tyhOsB4pMPLQGMKstBXjvH1TlGQrqjHydUjgPUzEQs6rmH+jcI/gI+HIh5g5P
         4qtlDt0/LtTtqvbu2tHsnN+CEvdXdczwn/AJILjToGJWV3pN++iCSyYnNAVsI8GmmVTf
         GPkFEJypvBHO969DVqkklW1ubH8jr87BcH9KN0+iwGxmkwuo7FpTy2FdcunP0aM83z1C
         H4uQ==
X-Gm-Message-State: AOJu0YxrCnm9D+wjVLsJZz7/TbRhc0MlstYM7ByIk/VV8BMwzvp9REaK
        ABLe3vGqsnD1DCzyP20Qwt4=
X-Google-Smtp-Source: AGHT+IFkga06RtEzVOMqIZ1q828PMrseDCQZ+c8dHnBkuw9X4BpfkfBbHGZSLwyc1XDMDRHLRCNDVw==
X-Received: by 2002:a05:6808:1384:b0:3a7:71fd:57cc with SMTP id c4-20020a056808138400b003a771fd57ccmr688653oiw.12.1693509287990;
        Thu, 31 Aug 2023 12:14:47 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:2cd8])
        by smtp.gmail.com with ESMTPSA id k4-20020a0cf284000000b0065160a2c8f0sm823283qvl.138.2023.08.31.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:14:47 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:14:44 -0500
From:   David Vernet <void@manifault.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com,
        tim.c.chen@intel.com
Subject: Re: [PATCH v3 7/7] sched: Shard per-LLC shared runqueues
Message-ID: <20230831191444.GD531917@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
 <20230809221218.163894-8-void@manifault.com>
 <ZO7e5YaS71cXVxQN@chenyu5-mobl2>
 <20230831000147.GA506447@maniforge>
 <ZPBvN9W6RYOr51zQ@chenyu5-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPBvN9W6RYOr51zQ@chenyu5-mobl2>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:45:11PM +0800, Chen Yu wrote:
> On 2023-08-30 at 19:01:47 -0500, David Vernet wrote:
> > On Wed, Aug 30, 2023 at 02:17:09PM +0800, Chen Yu wrote:
> > > 
> > > 5. Check the L2 cache miss rate.
> > > perf stat -e l2_rqsts.references,l2_request.miss sleep 10
> > > The results show that the L2 cache miss rate is nearly the same with/without
> > > shared_runqueue enabled.
> > 
> > As mentioned below, I expect it would be interesting to also collect
> > icache / iTLB numbers. In my experience, poor uop cache locality will
> > also result in poor icache locality, though of course that depends on a
> > lot of other factors like alignment, how many (un)conditional branches
> > you have within some byte window, etc. If alignment, etc were the issue
> > though, we'd likely observe this also without SHARED_RUNQ.
> >
> 
> [snip...] 
> 
> > 
> > Interesting. As mentioned above, I expect we also see an increase in
> > iTLB and icache misses?
> > 
> 
> This is a good point, according to the perf topdown:
> 
> SHARED_RUNQ is disabled:
> 
>      13.0 %  tma_frontend_bound
>       6.7 %  tma_fetch_latency
>        0.3 %  tma_itlb_misses
>        0.7 %  tma_icache_misses
> 
> itlb miss ratio is 13.0% * 6.7% * 0.3%
> icache miss ratio is 13.0% * 6.7% * 0.7%
> 
> SHARED_RUNQ is enabled:
>      20.0 %  tma_frontend_bound
>       11.6 %  tma_fetch_latency
>        0.9 %  tma_itlb_misses
>        0.5 %  tma_icache_misses
> 
> itlb miss ratio is 20.0% * 11.6% * 0.9%
> icache miss ratio is 20.0% * 11.6% * 0.5%
> 
> So both icache and itlb miss ratio increase, and itlb miss increases more,
> although the bottleneck is neither icache nor itlb.
> And as you mentioned below, it depends on other factors, including the hardware
> settings, icache size, tlb size, DSB size, eg.

Thanks for collecting these stats. Good to know that things are making
sense and the data we're collecting are telling a consistent story.

> > This is something we deal with in HHVM. Like any other JIT engine /
> > compiler, it is heavily front-end CPU bound, and has very poor icache,
> > iTLB, and uop cache locality (also lots of branch resteers, etc).
> > SHARED_RUNQ actually helps this workload quite a lot, as explained in
> > the cover letter for the patch series. It makes sense that it would: uop
> > locality is really bad even without increasing CPU util. So we have no
> > reason not to migrate the task and hop on a CPU.
> >
> 
> I see, this makes sense.
>  
> > > I wonder, if SHARED_RUNQ can consider that, if a task is a long duration one,
> > > say, p->avg_runtime >= sysctl_migration_cost, maybe we should not put such task
> > > on the per-LLC shared runqueue? In this way it will not be migrated too offen
> > > so as to keep its locality(both in terms of L1/L2 cache and DSB).
> > 
> > I'm hesitant to apply such heuristics to the feature. As mentioned
> > above, SHARED_RUNQ works very well on HHVM, despite its potential hit to
> > icache / iTLB / DSB locality. Those hhvmworker tasks run for a very long
> > time, sometimes upwards of 20+ms. They also tend to have poor L1 cache
> > locality in general even when they're scheduled on the same core they
> > were on before they were descheduled, so we observe better performance
> > if the task is migrated to a fully idle core rather than e.g. its
> > hypertwin if it's available. That's not something we can guarantee with
> > SHARED_RUNQ, but it hopefully illustrates the point that it's an example
> > of a workload that would suffer with such a heuristic.
> >
> 
> OK, the hackbench is just a microbenchmark to help us evaluate
> what the impact SHARED_RUNQ could bring. If such heuristic heals
> hackbench but hurts the real workload then we can consider
> other direction.
>  
> > Another point to consider is that performance implications that are a
> > result of Intel micro architectural details don't necessarily apply to
> > everyone. I'm not as familiar with the instruction decode pipeline on
> > AMD chips like Zen4. I'm sure they have a uop cache, but the size of
> > that cache, alignment requirements, the way that cache interfaces with
> > e.g. their version of the MITE / decoder, etc, are all going to be quite
> > different.
> >
> 
> Yes, this is true.
>  
> > In general, I think it's difficult for heuristics like this to suit all
> > possible workloads or situations (not that you're claiming it is). My
> > preference is to keep it as is so that it's easier for users to build a
> > mental model of what outcome they should expect if they use the feature.
> > Put another way: As a user of this feature, I'd be a lot more surprised
> > to see that I enabled it and CPU util stayed low, vs. enabling it and
> > seeing higher CPU util, but also degraded icache / iTLB locality.
> >
> 
> Understand.
>  
> > Let me know what you think, and thanks again for investing your time
> > into this.
> > 
> 
> Let me run other benchmarks to see if others are sensitive to
> the resource locality.

Great, thank you Chenyu.

FYI, I'll be on vacation for over a week starting later today, so my
responses may be delayed.

Thanks in advance for working on this. Looking forward to seeing the
results when I'm back at work.

Thanks,
David
