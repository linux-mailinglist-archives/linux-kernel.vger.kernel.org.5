Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1079D76A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbjILRSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbjILRSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:18:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13BF410E9;
        Tue, 12 Sep 2023 10:18:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B402C15;
        Tue, 12 Sep 2023 10:19:11 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C327E3F738;
        Tue, 12 Sep 2023 10:18:32 -0700 (PDT)
Message-ID: <356ec193-5c89-4f7e-5e43-d600dff68cf9@arm.com>
Date:   Tue, 12 Sep 2023 19:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <44fc6d03-c663-53de-e4f7-e56687c5718d@arm.com>
 <20230908140757.haewcuwsumphcv7p@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230908140757.haewcuwsumphcv7p@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 16:07, Qais Yousef wrote:
> On 09/08/23 09:40, Dietmar Eggemann wrote:
>> On 08/09/2023 02:17, Qais Yousef wrote:
>>> On 09/07/23 15:08, Peter Zijlstra wrote:
>>>> On Mon, Aug 28, 2023 at 12:31:56AM +0100, Qais Yousef wrote:

[...]

>>> And what was a high end A78 is a mid core today. So if you look at today's
>>> mobile world topology we really have a tiy+big+huge combination of cores. The
>>> bigs are called mids, but they're very capable. Fits capacity forces migration
>>> to the 'huge' cores too soon with that 80% margin. While the 80% might be too
>>> small for the tiny ones as some workloads really struggle there if they hang on
>>> for too long. It doesn't help that these systems ship with 4ms tick. Something
>>> more to consider changing I guess.
>>
>> If this is the problem then you could simply make the margin (headroom)
>> a function of cpu_capacity_orig?
> 
> I don't see what you mean. instead of capacity_of() but keep the 80%?
> 
> Again, I could be delusional and misunderstanding everything, but what I really
> see fits_capacity() is about is misfit detection. But a task is not really
> misfit until it actually has a util above the capacity of the CPU. Now due to
> implementation details there can be a delay between the task crossing this
> capacity and being able to move it. Which what I believe this headroom is
> trying to achieve.
> 
> I think we can better define this by tying this headroom to the worst case
> scenario it takes to actually move this misfit task to the right CPU. If it can
> continue to run without being impacted with this delay and crossing the
> capacity of the CPU it is on, then we should not trigger misfit IMO.


Instead of:

  fits_capacity(unsigned long util, unsigned long capacity)

      return approximate_util_avg(util, TICK_USEC) < capacity;

just make 1280 in:

  #define fits_capacity(cap, max) ((cap) * 1280 < (max) * 1024)

dependent on cpu's capacity_orig or the capacity diff to the next higher
capacity_orig.

Typical example today: {little-medium-big capacity_orig} = {128, 896, 1024}

896÷128 = 7

1024/896 = 1.14

to achieve higher margin on little and lower margin on medium.

[...]

