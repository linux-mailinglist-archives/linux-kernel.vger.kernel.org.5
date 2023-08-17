Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D577FBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353567AbjHQQJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353491AbjHQQI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:08:27 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FD2D4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692288505;
        bh=Vyu0yIccaebM/aIoj04Pq2AuKTpkTa2NuHZQ3PxoWik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XvVl1DvQfn/hoxYqK2HfgZz0OfEHi8ienJb9fhRbQ0i+dkWY3cltu53xBtX9944Fu
         MKdwC3mArwsDfyuGEUv67OHLjdz4eLeQ5OFhhUm80iu96/JLTlz35pTEzV/uGCRz6c
         o96PZgSR1eU+AjE3dIGrqlU3Vc2TNNjyKqzB81gyqBMQ3lvmD4RWLnJ0J52bckg6RW
         RyZ6yVzd4A7XbsnFW6jl8kN7Hn8tmYmwos0YU6yxIaHNP7Ken7ttprcKtMlfUR6x2G
         pPBGgyqP4foQBqqbcbLYnazZcF/LzVn1qnXSMUd8ajqcpRr/qAzu7xWGWF0Gxy87D+
         8kju6c6AfMcRQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RRVKj1TDxz1Ls6;
        Thu, 17 Aug 2023 12:08:25 -0400 (EDT)
Message-ID: <e52d3f53-97dc-2081-5124-5e13e29d2603@efficios.com>
Date:   Thu, 17 Aug 2023 12:09:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] sched: ttwu_queue_cond: perform queued wakeups
 across different L2 caches
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
References: <20230817153515.143932-1-mathieu.desnoyers@efficios.com>
 <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 12:01, Vincent Guittot wrote:
> On Thu, 17 Aug 2023 at 17:34, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Skipping queued wakeups for all logical CPUs sharing an LLC means that
>> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
>> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
>> runqueues within the same group for each wakeup, causing contention on
>> the runqueue locks.
[...]
>>
>> -bool cpus_share_cache(int this_cpu, int that_cpu);
>> +bool cpus_share_cluster(int this_cpu, int that_cpu);   /* Share L2. */
>> +bool cpus_share_cache(int this_cpu, int that_cpu);     /* Share LLC. */
> 
> I think that Yicong is doing what you want with
> cpus_share_lowest_cache() which points to cluster when available or
> LLC otherwise
> https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/t/#m0ab9fa0fe0c3779b9bbadcfbc1b643dce7cb7618
> 

AFAIU (please correct me if I'm wrong) my AMD EPYC machine has sockets 
consisting of 12 clusters, each cluster having its own L3 cache.

What I am trying to achieve here is really to implement "cpus_share_l2": 
I want this to match only when the cpus have a common L2 cache. L3 
appears to be a group which is either:

- too large (16 hw threads) or
- have a too high access latency.

I'm not certain which (or if both) of those reasons explain why
grouping by L2 is better here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

