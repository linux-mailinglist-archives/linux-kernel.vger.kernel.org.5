Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F4786026
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238246AbjHWSvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjHWSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:51:16 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE153E6C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692816668;
        bh=+oyFscryHWwnJ3Q3wx4qSyw+x48kiiaBuX7988nq8Yk=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=W4gcGk4zDTs+ZwyGYf2iyuaAGPmZIWrIbrkjLcvzaE9vtD2o1jtsDhDPTpEONm4ch
         oZdEO2PuiUU/sEoiI6XqtST+6Qkpcl21h1Faw15GYHuTkZYccd9SR3dgil3HosRXN6
         0sPC6x9Kn9kIsJY8+U9zLeXBFaQldwz7J0N/l1cHUu0EewYwevUBv3g0r1JEXh0vLv
         7yWkMGT3q45kWEqte1DqeRq9SMmm+QYVo0ds9h/a1NGoumCechIOWky1URJkSbPq3P
         ZTDdUb9J7Cbh/ck+2EfKPk8bkuET/8d4MuyNeCFU6z7GiL8/EopgM8uA3xxsFGSIfy
         KnfM5unv+hY/g==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RWFfh486Nz1MKY;
        Wed, 23 Aug 2023 14:51:08 -0400 (EDT)
Message-ID: <c7fe33f9-51bd-80e8-cb0e-1cefb20a61b9@efficios.com>
Date:   Wed, 23 Aug 2023 14:52:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v3 2/3] sched: Introduce cpus_share_l2c
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230822113133.643238-1-mathieu.desnoyers@efficios.com>
 <20230822113133.643238-3-mathieu.desnoyers@efficios.com>
 <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
In-Reply-To: <04be42cb-0e8b-25f7-a34b-41b2873f39d4@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/23 11:26, Mathieu Desnoyers wrote:
> On 8/22/23 07:31, Mathieu Desnoyers wrote:
>> Introduce cpus_share_l2c to allow querying whether two logical CPUs
>> share a common L2 cache.
>>
>> Considering a system like the AMD EPYC 9654 96-Core Processor, the L1
>> cache has a latency of 4-5 cycles, the L2 cache has a latency of at
>> least 14ns, whereas the L3 cache has a latency of 50ns [1]. Compared to
>> this, I measured the RAM accesses to a latency around 120ns on my
>> system [2]. So L3 really is only 2.4x faster than RAM accesses.
>> Therefore, with this relatively slow access speed compared to L2, the
>> scheduler will benefit from only considering CPUs sharing an L2 cache
>> for the purpose of using remote runqueue locking rather than queued
>> wakeups.
> 
> So I did some more benchmarking to figure out whether the reason for 
> this speedup is the latency delta between L2 and L3, or is due to the 
> number of hw threads contending on the rq locks.
> 
> I tried to force grouping of those "skip ttwu queue" groups by a subset 
> of the LLC id, basically by taking the LLC id and adding the cpu number 
> modulo N, where N is chosen based on my machine topology.
> 
> The end result is that I have similar numbers for groups of 1, 2, 4 HW 
> threads (which use rq locks and skip queued ttwu within the group). 
> Starting with group of size 8, the performance starts to degrade.
> 
> So I wonder: do machines with more than 4 HW threads per L2 cache exist? 
> If it's the case, there we should think about grouping not only by L2 
> cache, but also sub-divide this group so the number of hw threads per 
> group is at most 4.
> 
> Here are my results with the hackbench test-case:
> 
> Group cpus by 16 hw threads:
> 
> Time: 49s
> 
> - group cpus by 8 hw threads: (llc_id + cpu modulo 2)
> 
> Time: 39s
> 
> - group cpus by 4 hw threads: (llc_id + cpu modulo 4)
> 
> Time: 34s
> 
> - group cpus by 2 hw threads: (llc_id + cpu modulo 8)
> (expect same as L2 grouping on this machine)
> 
> Time: 34s
> 
> - group cpus by 1 hw threads: (cpu)
> 
> Time: 33s

One more interesting data point: I tried modifying the grouping
so that I would explicitly group by hw threads which sit in different
L3, and even on different NUMA nodes for some
(group id = cpu_id % 192). This is expected to generate really _bad_
cache locality for the runqueue locks within a group.

The result for these groups of 3 HW threads is about 33s with the
hackbench benchmark, which seems to confirm that the cause of the
speedup is reduction of the contention on the rq locks by making the
groups smaller, and therefore reducing the likelihood of contention for 
the rq locks, rather than by improving cache locality from L3 to L2.

So grouping by shared L2 only happens to make the group size OK, but
this benchmark does not significantly benefit from having all runqueue
locks on the same L2.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

