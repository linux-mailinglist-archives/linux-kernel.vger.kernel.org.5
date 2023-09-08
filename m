Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0276179834E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjIHHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:41:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27A431990;
        Fri,  8 Sep 2023 00:40:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B7BC15;
        Fri,  8 Sep 2023 00:41:33 -0700 (PDT)
Received: from [192.168.2.82] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBAEC3F64C;
        Fri,  8 Sep 2023 00:40:52 -0700 (PDT)
Message-ID: <44fc6d03-c663-53de-e4f7-e56687c5718d@arm.com>
Date:   Fri, 8 Sep 2023 09:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 02:17, Qais Yousef wrote:
> On 09/07/23 15:08, Peter Zijlstra wrote:
>> On Mon, Aug 28, 2023 at 12:31:56AM +0100, Qais Yousef wrote:

[...]

> But for the 0.8 and 1.25 margin problems, actually the problem is that 25% is
> too aggressive/fast and wastes power. I'm actually slowing things down as
> a result of this series. And I'm expecting some not to be happy about it on
> their systems. The response_time_ms was my way to give back control. I didn't
> see how I can make things faster and slower at the same time without making
> decisions on behalf of the user/sysadmin.
> 
> So the connection I see between PELT and the margins or headrooms in
> fits_capacity() and map_util_perf()/dvfs_headroom is that they expose the need
> to manage the perf/power trade-off of the system.
> 
> Particularly the default is not good for the modern systems, Cortex-X is too
> powerful but we still operate within the same power and thermal budgets.
> 
> And what was a high end A78 is a mid core today. So if you look at today's
> mobile world topology we really have a tiy+big+huge combination of cores. The
> bigs are called mids, but they're very capable. Fits capacity forces migration
> to the 'huge' cores too soon with that 80% margin. While the 80% might be too
> small for the tiny ones as some workloads really struggle there if they hang on
> for too long. It doesn't help that these systems ship with 4ms tick. Something
> more to consider changing I guess.

If this is the problem then you could simply make the margin (headroom)
a function of cpu_capacity_orig?

[...]

> There's a question that I'm struggling with if I may ask. Why is it perceived
> our constant response time (practically ~200ms to go from 0 to max) as a good
> fit for all use cases? Capability of systems differs widely in terms of what
> performance you get at say a util of 512. Or in other words how much work is
> done in a unit of time differs between system, but we still represent that work
> in a constant way. A task ran for 10ms on powerful System A would have done

PELT (util_avg) is uarch & frequency invariant.

So e.g. a task with util_avg = 256 could have a runtime/period

on big CPU (capacity = 1024) of 4ms/16ms

on little CPU (capacity = 512) of 8ms/16ms

The amount of work in invariant (so we can compare between asymmetric
capacity CPUs) but the runtime obviously differs according to the capacity.

[...]
