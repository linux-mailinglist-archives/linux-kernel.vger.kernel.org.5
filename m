Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43C77FBB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352066AbjHQQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353571AbjHQQNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:13:44 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871094
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692288822;
        bh=H2EYKzqYP9tS0okUk7wtutuLbd0mQBf9SqLAFKguyN8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=tRwigFqtGynPkoda7J4wKC1kIM9ReqJTCqDXlgQ0MjbbCX5nZwim3WxoTQk1eUN13
         rLBzKyNhT5qSHCaw/mewblBDtwuONIm2D+JalXC7HaxaSF9ZMAYPMtr8vFmWAwEG0R
         1Yon0z16QjlKu5+fcaxI2KpjoEIJPzQcTTBSD/EnjtL7UaESr7BuNB5oSlzDQxmqXy
         RV0u9sVgRMHJs2cB9UVBBjuEAxo27l9so7HpQciaZ8L3o4MlWONN/3ExCWZynXpnau
         u/dU9p8prD+FKi2k6AW6WvdWeXWUmLZpZbOZwPoLUGX+H6rcbsESzl1nRwM9VuBogi
         PXFavnkK389Jg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RRVRp2Jrsz1LhK;
        Thu, 17 Aug 2023 12:13:42 -0400 (EDT)
Message-ID: <81a0b993-b613-1b35-ba43-13c7306b50e6@efficios.com>
Date:   Thu, 17 Aug 2023 12:14:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 1/1] sched: ttwu_queue_cond: perform queued wakeups
 across different L2 caches
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <e52d3f53-97dc-2081-5124-5e13e29d2603@efficios.com>
In-Reply-To: <e52d3f53-97dc-2081-5124-5e13e29d2603@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 12:09, Mathieu Desnoyers wrote:
> On 8/17/23 12:01, Vincent Guittot wrote:
>> On Thu, 17 Aug 2023 at 17:34, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> Skipping queued wakeups for all logical CPUs sharing an LLC means that
>>> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
>>> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
>>> runqueues within the same group for each wakeup, causing contention on
>>> the runqueue locks.
> [...]
>>>
>>> -bool cpus_share_cache(int this_cpu, int that_cpu);
>>> +bool cpus_share_cluster(int this_cpu, int that_cpu);   /* Share L2. */
>>> +bool cpus_share_cache(int this_cpu, int that_cpu);     /* Share LLC. */
>>
>> I think that Yicong is doing what you want with
>> cpus_share_lowest_cache() which points to cluster when available or
>> LLC otherwise
>> https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/t/#m0ab9fa0fe0c3779b9bbadcfbc1b643dce7cb7618
>>
> 
> AFAIU (please correct me if I'm wrong) my AMD EPYC machine has sockets 
> consisting of 12 clusters, each cluster having its own L3 cache.
> 
> What I am trying to achieve here is really to implement "cpus_share_l2": 
> I want this to match only when the cpus have a common L2 cache. L3 
> appears to be a group which is either:
> 
> - too large (16 hw threads) or
> - have a too high access latency.
> 
> I'm not certain which (or if both) of those reasons explain why
> grouping by L2 is better here.

Re-reading the patch you pointed me to, I notice:

"+ * Whether CPUs are share lowest cache, which means LLC on non-cluster
  + * machines and LLC tag or L2 on machines with clusters."

So this "share lowest cache" really means lowest in terms of number, 
e.g. L2 < L3, and not "lowest in the hierarchy" as is "closest to 
memory", correct ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

