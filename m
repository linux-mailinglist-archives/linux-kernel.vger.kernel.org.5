Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA176E9E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbjHCNSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHCNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:18:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79CF272E;
        Thu,  3 Aug 2023 06:18:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8262D113E;
        Thu,  3 Aug 2023 06:18:59 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.78.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43BBD3F6C4;
        Thu,  3 Aug 2023 06:18:15 -0700 (PDT)
Date:   Thu, 3 Aug 2023 14:18:02 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        kajetan.puchalski@arm.com
Subject: Re: [RFC/RFT][PATCH v1 0/2] cpuidle: teo: Do not check timers
 unconditionally every time
Message-ID: <ZMupCqOA+v6QGdWN@e126311.manchester.arm.com>
References: <4511619.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4511619.LvFx2qVVIh@kreacher>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Aug 01, 2023 at 09:35:15PM +0200, Rafael J. Wysocki wrote:
> Hi Folks,
> 
> This is on top of the fixes series posted previously:
> 
> https://lore.kernel.org/linux-pm/4515817.LvFx2qVVIh@kreacher/
> 
> (I'll put it all into one git branch tomorrow).
> 
> I started to play with the idea described here
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0hQh2Pg_uXxj8KBRw3oLS1WdsU+rUafBAAq7dRdbRwYSA@mail.gmail.com/
> 
> and this is the result.
> 
> Note that this is completely experimental, even though it doesn't kill any of
> the test boxes I've run it on.
> 
> Patch [1/2] moves the tick_nohz_get_sleep_length() call in teo_select() after
> a preliminary idle state selection based on statistics and patch [2/2] adds
> checks to avoid it completely if the idle state selected so far is shallow
> enough.
> 
> I would appreciate checking if this actually makes any difference.
> 
> Thanks!

As mentioned in the other thread I did some testing with these two
patches on top as well, here are the results:

1. Geekbench 6

+---------------------------+---------------+-----------------+-------------------+
|          metric           |      teo      |     teo_tick    |    teo_tick_rfc   |
+---------------------------+---------------+-----------------+-------------------+
|      multicore_score      | 3320.9 (0.0%) | 3303.3 (-0.53%) |  3293.6 (-0.82%)  |
|           score           | 1415.7 (0.0%) | 1417.7 (0.14%)  |  1423.4 (0.54%)   |
|      CPU_total_power      | 2421.3 (0.0%) | 2429.3 (0.33%)  |  2442.2 (0.86%)   |
|  latency (AsyncTask #1)   | 49.41μ (0.0%) | 51.07μ (3.36%)  |   50.1μ (1.4%)    |
| latency (labs.geekbench6) | 65.63μ (0.0%) | 77.47μ (18.03%) | 55.82μ (-14.95%)  |
| latency (surfaceflinger)  | 39.46μ (0.0%) | 36.94μ (-6.39%) |  35.79μ (-9.28%)  |
+---------------------------+---------------+-----------------+-------------------+

Ie the big picture is all right, the latency either improves with these
patches or the spike in the previous patchset was an anomaly, either way
seems fine. Not sure where the change in the score is coming from but
for the record the line plots of the 3 iterations for both the tick
variants look the same while they're slightly distinct from the pure 'teo'
variant. It's still a below 1% gap so not the end of the world if
there's benefits elsewhere.

+-------------------+---------+------------+--------+
|      kernel       | cluster | idle_state |  time  |
+-------------------+---------+------------+--------+
|        teo        | little  |    0.0     | 146.75 |
|      teo_tick     | little  |    0.0     |  63.5  |
|     teo_tick_rfc  | little  |    0.0     | 62.48  |
|        teo        | little  |    1.0     | 53.75  |
|      teo_tick     | little  |    1.0     | 146.78 |
|     teo_tick_rfc  | little  |    1.0     | 147.14 |
+-------------------+---------+------------+--------+

The idle numbers look pretty much the same as the previous variant which
confirms that the change for the little cluster residency is caused by
the previous changes but also that these two patches don't affect it.

2. JetNews

+-----------------+---------------+----------------+-------------------+
|     metric      |      teo      |    teo_tick    |    teo_tick_rfc   |
+-----------------+---------------+----------------+-------------------+
|       fps       |  86.2 (0.0%)  |  86.4 (0.16%)  |   86.0 (-0.28%)   |
|    janks_pc     |  0.8 (0.0%)   |  0.8 (-0.66%)  |   0.8 (-1.37%)    |
| CPU_total_power | 185.2 (0.0%)  | 178.2 (-3.76%) |   182.2 (-1.6%)   |
+-----------------+---------------+----------------+-------------------+

Pretty much no change here, the power is still better than in base teo.

+-------------------+---------+------------+-------+
|      kernel       | cluster | idle_state | time  |
+-------------------+---------+------------+-------+
|        teo        |   mid   |    -1.0    | 21.63 |
|     teo_tick      |   mid   |    -1.0    | 21.57 |
|    teo_tick_rfc   |   mid   |    -1.0    | 17.66 |
|        teo        |   big   |    -1.0    | 8.81  |
|     teo_tick      |   big   |    -1.0    | 8.55  |
|    teo_tick_rfc   |   big   |    -1.0    | 12.04 |
+-------------------+---------+------------+-------+

This part slightly stands out so could be worth noting. For some reason
the trace registers a few seconds less running time (-1 means 'not
idle') on the mid cores but a few seconds more on the big cores. This
wasn't the case for the 'teo_tick' variant before so looks like it's
caused by these two patches. Doesn't seem to be an issue though, just
interesting.

TLDR:
Does not blow up, looks okay :)
