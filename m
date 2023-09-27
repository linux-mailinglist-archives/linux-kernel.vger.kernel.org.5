Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114B7B04F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjI0NIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjI0NIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:08:17 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F50F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:08:15 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a1d0fee86aso65524697b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820094; x=1696424894;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oyma3Y3WVl/XK+YRtAfrHKUuW9SzNWyBuyZtWbmEnY=;
        b=oS32ush4pxFaaxh2L7Etn/4DSGmJ2Dqr1s4KlsCYqB3Q83XFpUMlfhoCCmCSFke+Ig
         Q/PBpOCJNwJdn/WVbrPFWFo0e1INEiHtbkmS1IbIdioCnHPIRVd2Kmi8+dMOxJrOh5JP
         uH0mTJ3fK7jvnE72ZCgrhaH7PbfiIMzWl9R8g2LpCPWGQD7QiVrxvOkyQogqfQxj3U6S
         CL2/YS+7dPk0LKJJZtyxrkO03inhf/e+p0UzHhYvBZfad4Ra7AbNcdfgoW47NLS/g0Rq
         lfTJSmUXSyGl0KowmKEtBONUcsu/H44Frttz/cZ5Y8d0mQB7sCHQCWS4ULCbxTwKJMMQ
         D1pQ==
X-Gm-Message-State: AOJu0YyqLAm+31hkUSbzEVGMfmrDByBbre2suc+gDwAxgRRPqb2/8tV+
        TGXfXj15O+TwKGOvtG00DnA=
X-Google-Smtp-Source: AGHT+IG9z9LCSYoqykV8sw4N3Qza+cK5+Iy/SS4HDteDosKGxVqznKRYPZ5rLadnK4Lq5BOBhuEVCg==
X-Received: by 2002:a81:9c48:0:b0:589:f8c7:244 with SMTP id n8-20020a819c48000000b00589f8c70244mr1920931ywa.33.1695820093989;
        Wed, 27 Sep 2023 06:08:13 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id z5-20020a81a245000000b00583e52232f1sm3650358ywg.112.2023.09.27.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:08:13 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:08:10 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com,
        yu.c.chen@intel.com
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Message-ID: <20230927130810.GD37422@maniforge>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
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

On Wed, Sep 27, 2023 at 09:53:13AM +0530, K Prateek Nayak wrote:
> Hello David,

Hi Prateek,

> Some more test results (although this might be slightly irrelevant with
> next version around the corner)

Excellent, thanks for running these tests. The results are certainly
encouraging, and it seems clear that we could really improve the feature
by adding some of the logic you've experimented with to v5 (whether it's
the rq->avg_idle check, the per-shard overload, etc). I know that I owe
at least you and Chenyu more substantive responses on this and a few of
other emails that have been sent over the last week or two. I apologize
for the latency in my responses. I'm still at Kernel Recipes, but plan
to focus on this for the next couple of weeks after I'm back stateside.
I originally intended to revisit this _last_ week after my PTO, but got
caught up in helping with some sched_ext related stuff.

Just wanted to give you and everyone else a heads up that I haven't been
ignoring this intentionally, I've just been preempted a lot with travel
this month.

All of the work you folks are putting in is extremely helpful and
appreciated. I'm excited by the improvements we're making to
SHARED_RUNQ, and think that a lot of this can and should be folded into
v5.

So with that said, please feel free to keep experimenting and
discussing, and I'll rejoin the convo full time as soon as I can (which
should be either Friday or next week).

- David

> 
> On 9/1/2023 12:41 AM, David Vernet wrote:
> > On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> > 
> > Hi Prateek,
> > 
> >> Even with the two patches, I still observe the following lock
> >> contention when profiling the tbench 128-clients run with IBS:
> >>
> >>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
> >>      - 10.94% native_queued_spin_lock_slowpath
> >>         - 10.73% _raw_spin_lock
> >>            - 9.57% __schedule
> >>                 schedule_idle
> >>                 do_idle
> >>               + cpu_startup_entry
> >>            - 0.82% task_rq_lock
> >>                 newidle_balance
> >>                 pick_next_task_fair
> >>                 __schedule
> >>                 schedule_idle
> >>                 do_idle
> >>               + cpu_startup_entry
> >>
> >> Since David mentioned rq->avg_idle check is probably not the right step
> >> towards the solution, this experiment introduces a per-shard
> >> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
> >> notifies of the possibility of one or more rq covered in the shard's
> >> domain having a queued task. shard's overload flag is set at the same
> >> time as "rq->rd->overload", and is cleared when shard's list is found
> >> to be empty.
> > 
> > I think this is an interesting idea, but I feel that it's still working
> > against the core proposition of SHARED_RUNQ, which is to enable work
> > conservation.
> > 
> I have some more numbers. This time I'm accounting the cost for peeking
> into the shared-runq and have two variants - one that keeps the current
> vanilla flow from your v3 and the other that moves the rq->avg_idle
> check before looking at the shared-runq. Following are the results:
> 
> -> Without EEVDF
> 
> o tl;dr
> 
> - With avg_idle check, the improvements observed with shared-runq
>   aren't as large but they are still noticeable.
> 
> - Most regressions are gone nad the others aren't as bad with the
>   introduction of shared-runq
> 
> o Kernels
> 
> base			: tip is at commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs bandwidth in use")
> shared_runq		: base + correct time accounting with v3 of the series without any other changes
> shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
> 			  (the rd->overload check still remains below the shared_runq access)
> 
> o Benchmarks
> 
> ==================================================================
> Test          : hackbench
> Units         : Normalized time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> ==================================================================
> Case:           base[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>  1-groups     1.00 [ -0.00]( 2.64)     0.90 [ 10.20]( 8.79)             0.93 [  7.08]( 3.87)
>  2-groups     1.00 [ -0.00]( 2.97)     0.85 [ 15.06]( 4.86)             0.96 [  4.47]( 2.22)
>  4-groups     1.00 [ -0.00]( 1.84)     0.93 [  7.38]( 2.63)             0.94 [  6.07]( 1.02)
>  8-groups     1.00 [ -0.00]( 1.24)     0.97 [  2.83]( 2.69)             0.98 [  1.82]( 1.01)
> 16-groups     1.00 [ -0.00]( 3.31)     1.03 [ -2.93]( 2.46)             1.02 [ -1.61]( 1.34)
> 
> 
> ==================================================================
> Test          : tbench
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:   base[pct imp](CV)     shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>     1     1.00 [  0.00]( 1.08)     0.98 [ -1.89]( 0.48)              0.99 [ -0.73]( 0.70)
>     2     1.00 [  0.00]( 0.69)     0.99 [ -1.48]( 0.24)              0.98 [ -1.62]( 0.85)
>     4     1.00 [  0.00]( 0.70)     0.97 [ -2.87]( 1.34)              0.98 [ -2.15]( 0.48)
>     8     1.00 [  0.00]( 0.85)     0.97 [ -3.17]( 1.56)              0.99 [ -1.32]( 1.09)
>    16     1.00 [  0.00]( 2.18)     0.91 [ -8.70]( 0.27)              0.98 [ -2.03]( 1.28)
>    32     1.00 [  0.00]( 3.84)     0.51 [-48.53]( 2.52)              1.01 [  1.41]( 3.83)
>    64     1.00 [  0.00]( 7.06)     0.38 [-62.49]( 1.89)              1.05 [  5.33]( 4.09)
>   128     1.00 [  0.00]( 0.88)     0.41 [-58.92]( 0.28)              1.01 [  0.54]( 1.65)
>   256     1.00 [  0.00]( 0.88)     0.97 [ -2.56]( 1.78)              1.00 [ -0.48]( 0.33)
>   512     1.00 [  0.00]( 0.07)     1.00 [  0.06]( 0.04)              0.98 [ -1.51]( 0.44)
>  1024     1.00 [  0.00]( 0.30)     0.99 [ -1.35]( 0.90)              1.00 [ -0.24]( 0.41)
> 
> 
> ==================================================================
> Test          : stream-10
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:      base[pct imp](CV)      shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>  Copy     1.00 [  0.00]( 8.87)     1.00 [  0.31]( 5.27)                1.09 [  9.11]( 0.58)
> Scale     1.00 [  0.00]( 6.80)     0.99 [ -0.81]( 7.20)                1.00 [  0.49]( 5.67)
>   Add     1.00 [  0.00]( 7.24)     0.99 [ -1.13]( 7.02)                1.02 [  2.06]( 6.36)
> Triad     1.00 [  0.00]( 5.00)     0.96 [ -4.11]( 9.37)                1.03 [  3.46]( 4.41)
> 
> 
> ==================================================================
> Test          : stream-100
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:      base[pct imp](CV)     shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>  Copy     1.00 [  0.00]( 0.45)     1.00 [  0.32]( 1.88)              1.04 [  4.02]( 1.45)
> Scale     1.00 [  0.00]( 4.40)     0.98 [ -1.76]( 6.46)              1.01 [  1.28]( 1.00)
>   Add     1.00 [  0.00]( 4.97)     0.98 [ -1.85]( 6.01)              1.03 [  2.75]( 0.24)
> Triad     1.00 [  0.00]( 0.24)     0.96 [ -3.82]( 6.41)              0.99 [ -1.10]( 4.47)
> 
> 
> ==================================================================
> Test          : netperf
> Units         : Normalized Througput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:        base[pct imp](CV)      shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>  1-clients     1.00 [  0.00]( 0.46)     0.98 [ -2.37]( 0.08)              0.99 [ -1.32]( 0.37)
>  2-clients     1.00 [  0.00]( 0.75)     0.98 [ -2.04]( 0.33)              0.98 [ -1.57]( 0.50)
>  4-clients     1.00 [  0.00]( 0.84)     0.97 [ -3.25]( 1.01)              0.99 [ -0.77]( 0.54)
>  8-clients     1.00 [  0.00]( 0.78)     0.96 [ -4.18]( 0.68)              0.99 [ -0.77]( 0.63)
> 16-clients     1.00 [  0.00]( 2.56)     0.84 [-15.71]( 6.33)              1.00 [ -0.35]( 0.58)
> 32-clients     1.00 [  0.00]( 1.03)     0.35 [-64.92]( 8.90)              0.98 [ -1.92]( 1.67)
> 64-clients     1.00 [  0.00]( 2.69)     0.26 [-74.05]( 6.56)              0.98 [ -2.46]( 2.42)
> 128-clients    1.00 [  0.00]( 1.91)     0.25 [-74.81]( 3.67)              0.99 [ -1.50]( 2.15)
> 256-clients    1.00 [  0.00]( 2.21)     0.92 [ -7.73]( 2.29)              0.98 [ -1.51]( 1.85)
> 512-clients    1.00 [  0.00](45.18)     0.96 [ -4.06](52.89)              0.98 [ -2.49](49.22)
> 
> 
> ==================================================================
> Test          : schbench
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:        base[pct imp](CV)     shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>   1             1.00 [ -0.00](12.03)     1.04 [ -4.35](34.64)              1.13 [-13.04]( 2.25)
>   2             1.00 [ -0.00]( 9.36)     1.00 [ -0.00]( 4.56)              1.12 [-11.54](12.83)
>   4             1.00 [ -0.00]( 1.95)     1.00 [ -0.00](13.36)              0.93 [  6.67]( 9.10)
>   8             1.00 [ -0.00]( 9.01)     0.97 [  2.70]( 4.68)              1.03 [ -2.70](12.11)
>  16             1.00 [ -0.00]( 3.08)     1.02 [ -2.00]( 3.01)              1.00 [ -0.00]( 7.33)
>  32             1.00 [ -0.00]( 0.75)     1.03 [ -2.60]( 8.20)              1.09 [ -9.09]( 4.24)
>  64             1.00 [ -0.00]( 2.15)     0.91 [  9.20]( 1.03)              1.01 [ -0.61]( 7.14)
> 128             1.00 [ -0.00]( 5.18)     1.05 [ -4.57]( 7.74)              1.01 [ -0.57]( 5.62)
> 256             1.00 [ -0.00]( 4.18)     1.06 [ -5.87](51.02)              1.10 [ -9.51](15.82)
> 512             1.00 [ -0.00]( 2.10)     1.03 [ -3.36]( 2.88)              1.06 [ -5.87]( 1.10)
> 
> 
> ==================================================================
> Test          : Unixbench
> Units         : Various, Throughput
> Interpretation: Higher is better
> Statistic     : AMean, Hmean (Specified)
> ==================================================================
>                                                 base                  shared_runq             shared_runq_idle_check
> Hmean     unixbench-dhry2reg-1            41407024.82 (   0.00%)    41211208.57 (  -0.47%)     41354094.87 (  -0.13%)
> Hmean     unixbench-dhry2reg-512        6249629291.88 (   0.00%)  6245782129.00 (  -0.06%)   6236514875.97 (  -0.21%)
> Amean     unixbench-syscall-1              2922580.63 (   0.00%)     2928021.57 *  -0.19%*      2895742.17 *   0.92%*
> Amean     unixbench-syscall-512            7606400.73 (   0.00%)     8390396.33 * -10.31%*      8236409.00 *  -8.28%*
> Hmean     unixbench-pipe-1                 2574942.54 (   0.00%)     2610825.75 *   1.39%*      2531492.38 *  -1.69%*
> Hmean     unixbench-pipe-512             364489246.31 (   0.00%)   366388360.22 *   0.52%*    360160487.66 *  -1.19%*
> Hmean     unixbench-spawn-1                   4428.94 (   0.00%)        4391.20 (  -0.85%)         4541.06 (   2.53%)
> Hmean     unixbench-spawn-512                68883.47 (   0.00%)       69143.38 (   0.38%)        69776.01 *   1.30%*
> Hmean     unixbench-execl-1                   3878.47 (   0.00%)        3861.63 (  -0.43%)         3873.96 (  -0.12%)
> Hmean     unixbench-execl-512                11638.84 (   0.00%)       12758.38 *   9.62%*        14001.23 *  20.30%*
> 
> 
> ==================================================================
> Test          : ycsb-mongodb
> Units         : Throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> tip                     : 1.00 (var: 1.41%)
> shared_runq             : 0.99 (var: 0.84%)  (diff: -1.40%)
> shared_runq_idle_check  : 1.00 (var: 0.79%)  (diff:  0.00%)
> 
> 
> ==================================================================
> Test          : DeathStarBench
> Units         : %diff, relative to base
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> pinning      scaling   eevdf   shared_runq    shared_runq_idle_check
> 1CDD            1       0%       -0.39%              -0.09%
> 2CDD            2       0%       -0.31%              -1.73%
> 4CDD            4       0%        3.28%               0.60%
> 8CDD            8       0%        4.35%               2.98% 
>  
> 
> -> With EEVDF
> 
> o tl;dr
> 
> - Same as what was observed without EEVDF  but shared_runq shows
>   serious regression with multiple more variants of tbench and
>   netperf now.
> 
> o Kernels
> 
> eevdf			: tip:sched/core at commit b41bbb33cf75 ("Merge branch 'sched/eevdf' into sched/core")
> shared_runq		: eevdf + correct time accounting with v3 of the series without any other changes
> shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
> 			  (the rd->overload check still remains below the shared_runq access)
> 
> ==================================================================
> Test          : hackbench
> Units         : Normalized time in seconds
> Interpretation: Lower is better
> Statistic     : AMean
> ==================================================================
> Case:          eevdf[pct imp](CV)    shared_runq[pct imp](CV)  shared_runq_idle_check[pct imp](CV)
>  1-groups     1.00 [ -0.00]( 1.89)     0.95 [  4.72]( 8.98)         0.99 [  0.83]( 3.77)
>  2-groups     1.00 [ -0.00]( 2.04)     0.86 [ 13.87]( 2.59)         0.95 [  4.92]( 1.98)
>  4-groups     1.00 [ -0.00]( 2.38)     0.96 [  4.50]( 3.44)         0.98 [  2.45]( 1.93)
>  8-groups     1.00 [ -0.00]( 1.52)     1.01 [ -0.95]( 1.36)         0.96 [  3.97]( 0.89)
> 16-groups     1.00 [ -0.00]( 3.44)     1.00 [ -0.00]( 1.59)         0.96 [  3.91]( 3.36)
> 
> 
> ==================================================================
> Test          : tbench
> Units         : Normalized throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:  eevdf[pct imp](CV)    shared_runq[pct imp](CV)  shared_runq_idle_check[pct imp](CV)
>     1     1.00 [  0.00]( 0.18)     1.00 [  0.15]( 0.59)         0.98 [ -1.76]( 0.74)
>     2     1.00 [  0.00]( 0.63)     0.97 [ -3.44]( 0.91)         0.98 [ -1.93]( 1.27)
>     4     1.00 [  0.00]( 0.86)     0.95 [ -4.86]( 0.85)         0.99 [ -1.15]( 0.77)
>     8     1.00 [  0.00]( 0.22)     0.94 [ -6.44]( 1.31)         0.99 [ -1.00]( 0.97)
>    16     1.00 [  0.00]( 1.99)     0.86 [-13.68]( 0.38)         1.00 [ -0.47]( 0.99)
>    32     1.00 [  0.00]( 4.29)     0.48 [-52.21]( 0.53)         1.01 [  1.24]( 6.66)
>    64     1.00 [  0.00]( 1.71)     0.35 [-64.68]( 0.44)         0.99 [ -0.66]( 0.70)
>   128     1.00 [  0.00]( 0.65)     0.40 [-60.32]( 0.95)         0.98 [ -2.15]( 1.25)
>   256     1.00 [  0.00]( 0.19)     0.72 [-28.28]( 1.88)         0.99 [ -1.39]( 2.50)
>   512     1.00 [  0.00]( 0.20)     0.79 [-20.59]( 4.40)         1.00 [ -0.42]( 0.38)
>  1024     1.00 [  0.00]( 0.29)     0.80 [-20.24]( 0.64)         0.99 [ -0.51]( 0.20)
> 
> 
> ==================================================================
> Test          : stream-10
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:     eevdf[pct imp](CV)    shared_runq[pct imp](CV)   shared_runq_idle_check[pct imp](CV)
>  Copy     1.00 [  0.00]( 4.32)     0.94 [ -6.40]( 8.05)          1.01 [  1.39]( 4.58)
> Scale     1.00 [  0.00]( 5.21)     0.98 [ -2.15]( 6.79)          0.95 [ -4.54]( 7.35)
>   Add     1.00 [  0.00]( 6.25)     0.97 [ -2.64]( 6.47)          0.97 [ -3.08]( 7.49)
> Triad     1.00 [  0.00](10.74)     1.01 [  0.92]( 7.40)          1.01 [  1.25]( 8.76)
> 
> 
> ==================================================================
> Test          : stream-100
> Units         : Normalized Bandwidth, MB/s
> Interpretation: Higher is better
> Statistic     : HMean
> ==================================================================
> Test:     eevdf[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>  Copy     1.00 [  0.00]( 0.70)     1.00 [ -0.07]( 0.70)         1.00 [  0.47]( 0.94)
> Scale     1.00 [  0.00]( 6.55)     1.02 [  1.72]( 4.83)         1.03 [  2.96]( 1.00)
>   Add     1.00 [  0.00]( 6.53)     1.02 [  1.53]( 4.77)         1.03 [  3.19]( 0.90)
> Triad     1.00 [  0.00]( 6.66)     1.00 [  0.06]( 6.29)         0.99 [ -0.70]( 5.79)
> 
> 
> ==================================================================
> Test          : netperf
> Units         : Normalized Througput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> Clients:       eevdf[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>  1-clients     1.00 [  0.00]( 0.46)     1.02 [  1.73]( 0.31)           0.99 [ -0.81]( 0.24)
>  2-clients     1.00 [  0.00]( 0.38)     0.99 [ -0.68]( 1.17)           0.99 [ -0.87]( 0.45)
>  4-clients     1.00 [  0.00]( 0.72)     0.97 [ -3.38]( 1.38)           0.99 [ -1.26]( 0.47)
>  8-clients     1.00 [  0.00]( 0.98)     0.94 [ -6.30]( 1.84)           1.00 [ -0.44]( 0.45)
> 16-clients     1.00 [  0.00]( 0.70)     0.56 [-44.08]( 5.11)           0.99 [ -0.83]( 0.49)
> 32-clients     1.00 [  0.00]( 0.74)     0.35 [-64.92]( 1.98)           0.98 [ -2.14]( 2.14)
> 64-clients     1.00 [  0.00]( 2.24)     0.26 [-73.79]( 5.72)           0.97 [ -2.57]( 2.44)
> 128-clients    1.00 [  0.00]( 1.72)     0.25 [-74.91]( 6.72)           0.96 [ -3.66]( 1.48)
> 256-clients    1.00 [  0.00]( 4.44)     0.68 [-31.60]( 5.42)           0.96 [ -3.61]( 3.64)
> 512-clients    1.00 [  0.00](52.42)     0.67 [-32.81](48.45)           0.96 [ -3.80](55.24)
> 
> 
> ==================================================================
> Test          : schbench
> Units         : Normalized 99th percentile latency in us
> Interpretation: Lower is better
> Statistic     : Median
> ==================================================================
> #workers:   eevdf[pct imp](CV)    shared_runq[pct imp](CV)    shared_runq_idle_check[pct imp](CV)
>   1         1.00 [ -0.00]( 2.28)     1.00 [ -0.00]( 6.19)          0.84 [ 16.00](20.83)
>   2         1.00 [ -0.00]( 6.42)     0.89 [ 10.71]( 2.34)          0.96 [  3.57]( 4.17)
>   4         1.00 [ -0.00]( 3.77)     0.97 [  3.33]( 7.35)          1.00 [ -0.00]( 9.12)
>   8         1.00 [ -0.00](13.83)     1.03 [ -2.63]( 6.96)          0.95 [  5.26]( 6.93)
>  16         1.00 [ -0.00]( 4.37)     1.02 [ -2.13]( 4.17)          1.02 [ -2.13]( 3.53)
>  32         1.00 [ -0.00]( 8.69)     0.96 [  3.70]( 5.23)          0.98 [  2.47]( 4.43)
>  64         1.00 [ -0.00]( 2.30)     0.96 [  3.85]( 2.34)          0.92 [  7.69]( 4.14)
> 128         1.00 [ -0.00](12.12)     0.97 [  3.12]( 3.31)          0.93 [  6.53]( 5.31)
> 256         1.00 [ -0.00](26.04)     1.87 [-86.57](33.02)          1.63 [-62.73](40.63)
> 512         1.00 [ -0.00]( 5.62)     1.04 [ -3.80]( 0.35)          1.09 [ -8.78]( 2.56)
>  
> ==================================================================
> Test          : Unixbench
> Units         : Various, Throughput
> Interpretation: Higher is better
> Statistic     : AMean, Hmean (Specified)
> ==================================================================
> 
>                                              eevdf                   shared_runq             shared_runq_idle_check
> Hmean     unixbench-dhry2reg-1            41248390.97 (   0.00%)    41245183.04 (  -0.01%)    41297801.58 (   0.12%)
> Hmean     unixbench-dhry2reg-512        6239969914.15 (   0.00%)  6236534715.56 (  -0.06%)  6237356670.12 (  -0.04%)
> Amean     unixbench-syscall-1              2968518.27 (   0.00%)     2893792.10 *   2.52%*     2799609.00 *   5.69%*
> Amean     unixbench-syscall-512            7790656.20 (   0.00%)     8489302.67 *  -8.97%*     7685974.47 *   1.34%*
> Hmean     unixbench-pipe-1                 2535689.01 (   0.00%)     2554662.39 *   0.75%*     2521853.23 *  -0.55%*
> Hmean     unixbench-pipe-512             361385055.25 (   0.00%)   365752991.35 *   1.21%*   358310503.28 *  -0.85%*
> Hmean     unixbench-spawn-1                   4506.26 (   0.00%)        4566.00 (   1.33%)        4242.52 *  -5.85%*
> Hmean     unixbench-spawn-512                69380.09 (   0.00%)       69554.52 (   0.25%)       69413.14 (   0.05%)
> Hmean     unixbench-execl-1                   3824.57 (   0.00%)        3782.82 *  -1.09%*        3832.10 (   0.20%)
> Hmean     unixbench-execl-512                12288.64 (   0.00%)       13248.40 (   7.81%)       12661.78 (   3.04%)
>  
> ==================================================================
> Test          : ycsb-mongodb
> Units         : Throughput
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> eevdf                   : 1.00 (var: 1.41%)
> shared_runq             : 0.98 (var: 0.84%)  (diff: -2.40%)
> shared_runq_idle_check  : 0.97 (var: 0.79%)  (diff: -3.06%)
> 
> 
> ==================================================================
> Test          : DeathStarBench
> Units         : %diff, relative to eevdf
> Interpretation: Higher is better
> Statistic     : AMean
> ==================================================================
> pinning      scaling   eevdf   shared_runq    shared_runq_idle_check
> 1CDD            1       0%       -0.85%             -1.56%
> 2CDD            2       0%       -0.60%             -1.22%
> 4CDD            4       0%        2.87%              0.02%
> 8CDD            8       0%        0.36%              1.57%
> 
> 
> --
> Thanks and Regards,
> Prateek
