Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21976BF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjHAVx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:53:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9A3103;
        Tue,  1 Aug 2023 14:53:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB137D75;
        Tue,  1 Aug 2023 14:54:07 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.77.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6003E3F59C;
        Tue,  1 Aug 2023 14:53:22 -0700 (PDT)
Date:   Tue, 1 Aug 2023 22:53:12 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 0/3] cpuidle: teo: Avoid stopping scheduler tick too
 often
Message-ID: <ZMl+yH42Ir0AZzoX@e126311.manchester.arm.com>
References: <4515817.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4515817.LvFx2qVVIh@kreacher>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

> Hi Folks,
> 
> Patch [1/3] in this series is a v3 of this patch posted last week:
> 
> https://lore.kernel.org/linux-pm/4506480.LvFx2qVVIh@kreacher/
> 
> Patch [2/3] (this is the second version of it) addresses some bail out paths
> in teo_select() in which the scheduler tick may be stopped unnecessarily too.
> 
> Patch [3/3] replaces a structure field with a local variable (while at it)
> and it is the same as its previous version.
> 
> According to this message:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com/
> 
> this series significantly reduces the number of cases in which the governor
> requests stopping the tick when the selected idle state is shallow, which is
> incorrect.
> 
> Thanks!
> 
> 

I did some initial testing with this on Android (Pixel 6, Android 13).

1. Geekbench 6

+---------------------------+---------------+-----------------+
|          metric           |      teo      |     teo_tick    |
+---------------------------+---------------+-----------------+
|      multicore_score      | 3320.9 (0.0%) | 3303.3 (-0.53%) |
|           score           | 1415.7 (0.0%) | 1417.7 (0.14%)  |
|      CPU_total_power      | 2421.3 (0.0%) | 2429.3 (0.33%)  |
|  latency (AsyncTask #1)   | 49.41μ (0.0%) | 51.07μ (3.36%)  |
| latency (labs.geekbench6) | 65.63μ (0.0%) | 77.47μ (18.03%) |
| latency (surfaceflinger)  | 39.46μ (0.0%) | 36.94μ (-6.39%) |
+---------------------------+---------------+-----------------+

So the big picture for this workload looks roughly the same, the
differences are too small for me to be confident in saying that the
score/power difference is the result of the patches and not something
random in the system.
Same with the latency, the difference for labs.gb6 stands out but that's
a pretty irrelevant task that sets up the benchmark, not the benchmark
itself so not the biggest deal I think.

+---------------+---------+------------+--------+
|     kernel    | cluster | idle_state |  time  |
+---------------+---------+------------+--------+
|      teo      | little  |    0.0     | 146.75 |
|      teo      | little  |    1.0     | 53.75  |
|    teo_tick   | little  |    0.0     |  63.5  |
|    teo_tick   | little  |    1.0     | 146.78 |
+---------------+---------+------------+--------+

+---------------+-------------+------------+
|     kernel    |    type     | count_perc |
+---------------+-------------+------------+
|   teo         |  too deep   |   2.034    |
|   teo         | too shallow |   15.791   |
|   teo_tick    |  too deep   |    2.16    |
|   teo_tick    | too shallow |   20.881   |
+---------------+-------------+------------+

The difference shows up in the idle numbers themselves, looks like we
get a big shift towards deeper idle on our efficiency cores (little
cluster) and more missed wakeups overall, both too deep & too shallow.

Notably, the percentage of too shallow sleeps on the performance cores has
more or less doubled (2% + 0.8% -> 4.3% + 1.8%). This doesn't
necessarily have to be an issue but I'll do more testing just in case.

2. JetNews (Light UI workload)

+------------------+---------------+----------------+
|      metric      |      teo      |    teo_tick    |
+------------------+---------------+----------------+
|       fps        |  86.2 (0.0%)  |  86.4 (0.16%)  |
|     janks_pc     |  0.8 (0.0%)   |  0.8 (-0.00%)  |
| CPU_total_power  | 185.2 (0.0%)  | 178.2 (-3.76%) |
+------------------+---------------+----------------+

For the UI side, the frame data comes out the same on both variants but
alongside better power usage which is nice to have.

+---------------+---------+------------+-------+
|    kernel     | cluster | idle_state | time  |
+---------------+---------+------------+-------+
|      teo      | little  |    0.0     | 25.06 |
|      teo      | little  |    1.0     | 12.21 |
|      teo      |   mid   |    0.0     | 38.32 |
|      teo      |   mid   |    1.0     | 17.82 |
|      teo      |   big   |    0.0     | 30.45 |
|      teo      |   big   |    1.0     | 38.5  |
|    teo_tick   | little  |    0.0     | 23.18 |
|    teo_tick   | little  |    1.0     | 14.21 |
|    teo_tick   |   mid   |    0.0     | 36.31 |
|    teo_tick   |   mid   |    1.0     | 19.88 |
|    teo_tick   |   big   |    0.0     | 27.13 |
|    teo_tick   |   big   |    1.0     | 42.09 |
+---------------+---------+------------+-------+

+---------------+-------------+------------+
|    kernel     |    type     | count_perc |
+---------------+-------------+------------+
|      teo      |  too deep   |   0.992    |
|      teo      | too shallow |   17.085   |
|   teo_tick    |  too deep   |   0.945    |
|   teo_tick    | too shallow |   15.236   |
+---------------+-------------+------------+

For the idle stuff here all 3 clusters shift a bit towards deeper idle
but the overall miss rate is lower across the board which is perfectly
fine.

TLDR:
Mostly no change for a busy workload, no change + better power for a UI
one. The patches make sense to me & the results look all right so no big
problems at this stage. I'll do more testing (including the RFC you sent
out a moment ago) over the next few days and send those out as well.

Short of bumping into any other problems along the way, feel free to
grab this if you'd like:
Reviewed-and-tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
