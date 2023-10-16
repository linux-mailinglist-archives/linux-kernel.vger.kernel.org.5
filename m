Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DC57CB351
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjJPTYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjJPTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:24:43 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D2A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1697484277;
        bh=Z3f3fZEY91HAlKBHOM6V0oi/muY0h7esgdTKiJIgvpg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J9TmQk3iaQjuKga7kEKkWtVs2rdFj3pYozZj6qLXpOCuT4+p6gf922wTCrPIS3EYk
         OMW/ci2En4TpwClVnM0LUNNmqOipoi4Lb81kT6qCS0jQSY9dHAEY0kKdTeqNXNUQ0r
         jgQDAGvJo9ziM9V0+6GyMX1B81eekV3kYPVgiGXs1UI4wVuRfi6qyZewxlYXdP6Qb0
         ZmmzJ5YdKJaCm8dRGTUK94ioF4MHtHAWgec9PJynWJQouSx3vgLgFOCcqAS90gMxYd
         7azbLufJjsvNR+FUemGH3GENHJmOFB9MtqRxboqEpuV/H3guyoVjUYsCuUtvHCsu86
         ZlgWR12hRR+SQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4S8RrP3gk7z1XRr;
        Mon, 16 Oct 2023 15:24:37 -0400 (EDT)
Message-ID: <be4f14be-0872-420d-9639-ad64961f7477@efficios.com>
Date:   Mon, 16 Oct 2023 15:24:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/fair: Introduce WAKEUP_BIAS_PREV_IDLE to reduce
 migrations
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231012203626.1298944-1-mathieu.desnoyers@efficios.com>
 <ZSwI4UTrXLNEWwKM@chenyu5-mobl2.ccr.corp.intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZSwI4UTrXLNEWwKM@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-15 11:44, Chen Yu wrote:
> On 2023-10-12 at 16:36:26 -0400, Mathieu Desnoyers wrote:
>> Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature to reduce the
>> task migration rate.
>>
>> For scenarios where the system is under-utilized (CPUs are partly idle),
>> eliminate frequent task migrations from almost idle CPU to completely
>> idle CPUs by introducing a bias towards the previous CPU if it is idle
>> or almost idle in select_idle_sibling(). Use 1% of the CPU capacity
>> of the previously used CPU as CPU utilization "almost idle" cutoff.
>>
>> +
>> +/*
>> + * A runqueue is considered almost idle if:
>> + *
>> + *   cpu_util_without(cpu, p) / 1024 <= 1% * capacity_of(cpu)
> 
> util_avg is in the range [0:1024], thus cpu_util_without(cpu, p) / 1024
> is <= 1, and 1% * cap is 10, so 1 <= 10 is always true.
> I suppose you want to compare:
>   (cpu_util_without(cpu, p) / capacity_orig_of(cpu)) <= 1% ->
>      cpu_util_without(cpu, p) * 100 <= capacity_orig_of(cpu) ?

Good point!

Now that I have fixed this, I come back to a situation where:

- load_avg works, probably because it multiplies by the weight, and 
therefore when there are few tasks on the runqueue it reflects the fact 
that the runqueue is almost idle. Even though it happens to work, it 
does not appear to be an elegant solution.

- util_avg and runnable_avg do not work. Probably because they take into 
account both running/runnable and recently blocked tasks, so they cannot 
be used to provide a clear picture of the very-short-term idleness 
status for the purpose of selecting a prev rq.

I wonder if there are any rq stats I can use which do not include 
recently blocked tasks ?

Thanks,

Mathieu


> 
> thanks,
> Chenyu
>   
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

