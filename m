Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB367C8474
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMLfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjJMLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:35:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2D59B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:34:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3BFE11FB;
        Fri, 13 Oct 2023 04:35:39 -0700 (PDT)
Received: from [10.57.80.116] (unknown [10.57.80.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AADC3F7A6;
        Fri, 13 Oct 2023 04:34:56 -0700 (PDT)
Message-ID: <1891aa6c-037f-46a1-9584-17aaa63e4e74@arm.com>
Date:   Fri, 13 Oct 2023 12:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
Content-Language: en-US
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231004123454.15691-1-anna-maria@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anna-Maria

On 10/4/23 13:34, Anna-Maria Behnsen wrote:
> Hi,
> 

[snip]

> 
> 
> Testing
> ~~~~~~~
> 
> Enqueue
> ^^^^^^^
> 
> The impact of wasting cycles during enqueue by using the heuristic in
> contrast to always queuing the timer on the local CPU was measured with a
> micro benchmark. Therefore a timer is enqueued and dequeued in a loop with
> 1000 repetitions on a isolated CPU. The time the loop takes is measured. A
> quarter of the remaining CPUs was kept busy. This measurement was repeated
> several times. With the patch queue the average duration was reduced by
> approximately 25%.
> 
> 	145ns	plain v6
> 	109ns	v6 with patch queue
> 
> 
> Furthermore the impact of residence in deep idle states of an idle system
> was investigated. The patch queue doesn't downgrade this behavior.
> 
> dbench test
> ^^^^^^^^^^^
> 
> A dbench test starting X pairs of client servers are used to create load on
> the system. The measurable value is the throughput. The tests were executed
> on a zen3 machine. The base is the tip tree branch timers/core which is
> based on a v6.6-rc1.
> 
> governor menu
> 
> X pairs	timers/core	pull-model	impact
> ----------------------------------------------
> 1	353.19 (0.19)	353.45 (0.30)	0.07%
> 2	700.10 (0.96)	687.00 (0.20)	-1.87%
> 4	1329.37 (0.63)	1282.91 (0.64)	-3.49%
> 8	2561.16 (1.28)	2493.56	(1.76)	-2.64%
> 16	4959.96 (0.80)	4914.59 (0.64)	-0.91%
> 32	9741.92 (3.44)	8979.83 (1.13)	-7.82%
> 64	16535.40 (2.84)	16388.47 (4.02)	-0.89%
> 128	22136.83 (2.42)	23174.50 (1.43)	4.69%
> 256	39256.77 (4.48)	38994.00 (0.39)	-0.67%
> 512	36799.03 (1.83)	38091.10 (0.63)	3.51%
> 1024	32903.03 (0.86)	35370.70 (0.89)	7.50%
> 
> 
> governor teo
> 
> X pairs	timers/core	pull-model	impact
> ----------------------------------------------
> 1	350.83 (1.27)	352.45 (0.96)	0.46%
> 2	699.52 (0.85)	690.10 (0.54)	-1.35%
> 4	1339.53 (1.99)	1294.71 (2.71)	-3.35%
> 8	2574.10 (0.76)	2495.46 (1.97)	-3.06%
> 16	4898.50 (1.74)	4783.06 (1.64)	-2.36%
> 32	9115.50 (4.63)	9037.83 (1.58)	-0.85%
> 64	16663.90 (3.80)	16042.00 (1.72)	-3.73%
> 128	25044.93 (1.11)	23250.03 (1.08)	-7.17%
> 256	38059.53 (1.70)	39658.57 (2.98)	4.20%
> 512	36369.30 (0.39)	38890.13 (0.36)	6.93%
> 1024	33956.83 (1.14)	35514.83 (0.29)	4.59%
> 
> 
> 
> Ping Pong Oberservation
> ^^^^^^^^^^^^^^^^^^^^^^^
> 
> During testing on a mostly idle machine a ping pong game could be observed:
> a process_timeout timer is expired remotely on a non idle CPU. Then the CPU
> where the schedule_timeout() was executed to enqueue the timer comes out of
> idle and restarts the timer using schedule_timeout() and goes back to idle
> again. This is due to the fair scheduler which tries to keep the task on
> the CPU which it previously executed on.
> 
> 

I have tested this on my 2 Arm boards with mainline kernel
and almost-mainline. On both platforms it looks stable.
The results w/ your patchset looks better.

1. rockpi4b - mainline kernel (but no UI)

Limiting the cpumask for only 4 Little CPUs and setting
performance governor for cpufreq and menu for idle.

1.1. perf bench sched pipe

w/o patchset vs. w/ patchset
avg [ops/sec]:
(more is better)
23012.33 vs. 23154.33 (+0.6%)

avg [usecs/op]:
(less is better)
43.453 vs. 43.187 (-0.6%)

1.2. perf bench sched messaging
(less is better)

w/o patchset vs. w/ patchset
avg total time [s]:
2.7855 vs. 2.7005 (-3.1%)

2. pixel6 (kernel v5.18 with backported patchset)

2.1 Speedometer 2.0 (JS test running in Chrome browser)

w/o patchset vs. w/ patchset
149 vs. 146 (-2%)

2.2 Geekbench 5
(more is better)

Single core
w/o patchset vs. w/ patchset
1025 vs. 1017 (-0.7%)

Multi core
w/o patchset vs. w/ patchset
2756 vs. 2813 (+2%)


The performance looks good. Only one test 'Speedometer'
has some interesting lower score.

Fill free to add:

Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
