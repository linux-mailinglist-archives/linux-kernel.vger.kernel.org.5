Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCA37CA994
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjJPNej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjJPNe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:34:26 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79795F7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:34:19 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S8J4747qmz9tLh;
        Mon, 16 Oct 2023 15:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1697463255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2xnSAmfffMw1JEZfHs9irdbvghJqfqzKINyDeqt8dA=;
        b=kLRJrSnYAKn7M9MPg+QLteFMbvstR3r9IAQ5ANfvqNaKtCVRa8fizwwmnmrXtfHQTucRzd
        9KB67ycbuBGIQkpLangG/JADCICemo/EVbV/CEKp2RWeFZhjCe53pcDgoyQcD++EmPvmXW
        sb5htYfLvxOfFtQFAQnS2BbV2ttoFMXbuNaeVJ2bbdZ86VjwZHgUiODZw4XPPZpOlEEaHH
        v7jtJNVKeBRa3uo6Q/vChGAzi9fhivA+UaBBiMTwIMf81NO/FSp6iF+biycauQdBH1vFO6
        Rm+2sH+bgjTfPeQe8ey4xyThkSa7PQDeSPkrVZdjp8VPHA8wxiiYNXrgrV3MuQ==
Message-ID: <218a0365-e933-48fd-a930-ee277d416eac@mailbox.org>
Date:   Mon, 16 Oct 2023 15:33:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] sched/eevdf: Toggle eligibility through sched_feat
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Youssef Esmat <youssefesmat@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bsegall@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        wuyun.abel@bytedance.com
References: <20231013030213.2472697-1-youssefesmat@chromium.org>
 <20231015104428.GA11840@noisy.programming.kicks-ass.net>
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <20231015104428.GA11840@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t9a9zrkxms45qyej6m5shhymxssj7k8i
X-MBO-RS-ID: 29b591d5ff41d0545d4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/23 12:44, Peter Zijlstra wrote:
> On Thu, Oct 12, 2023 at 10:02:13PM -0500, Youssef Esmat wrote:
>> Interactive workloads see performance gains by disabling eligibility
>> checks (EEVDF->EVDF). Disabling the checks reduces the number of
>> context switches and delays less important work (higher deadlines/nice
>> values) in favor of more important work (lower deadlines/nice values).
>>
>> That said, that can add large latencies for some work loads and as the
>> default is eligibility on, but allowing it to be turned off when
>> beneficial.
>>
>> Signed-off-by: Youssef Esmat <youssefesmat@chromium.org>
>> Link: https://lore.kernel.org/lkml/CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com/
>> ---
>>   kernel/sched/fair.c     | 3 +++
>>   kernel/sched/features.h | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a751e552f253..16106da5a354 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -728,6 +728,9 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>   	s64 avg = cfs_rq->avg_vruntime;
>>   	long load = cfs_rq->avg_load;
>>   
>> +	if (!sched_feat(ENFORCE_ELIGIBILITY))
>> +		return 1;
>> +
>>   	if (curr && curr->on_rq) {
>>   		unsigned long weight = scale_load_down(curr->load.weight);
>>   
> 
> Right.. could you pretty please try:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/eevdf
> 
> as of yesterday or so.
> 
> It defaults to (EEVDF relevant features):
> 
> SCHED_FEAT(PLACE_LAG, true)
> SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
> SCHED_FEAT(PREEMPT_SHORT, true)
> SCHED_FEAT(PLACE_SLEEPER, false)
> SCHED_FEAT(GENTLE_SLEEPER, true)
> SCHED_FEAT(EVDF, false)
> SCHED_FEAT(DELAY_DEQUEUE, true)
> SCHED_FEAT(GENTLE_DELAY, true)
> 
> If that doesn't do well enough, could you please try, in order of
> preference:
> 
> 2) NO_GENTLE_DELAY
> 3) NO_DELAY_DEQUEUE, PLACE_SLEEPER
> 4) NO_DELAY_DEQUEUE, PLACE_SLEEPER, NO_GENTLE_SLEEPER

I'm very interested in this scheduler stuff, but I know nothing about 
the code.

Still, I ran some very quick benchmarks on a dual-core Skylake laptop 
running 6.6-rc6.
Base slice is 5 ms.

1) Without the recent patches from Peter's tree
2) With patches, default features
3) With patches, NO_GENTLE_DELAY
4) With patches, NO_DELAY_DEQUEUE + PLACE_SLEEPER
5) With patches, like 4) + NO_GENTLE_SLEEPER
6) With patches, like 5) + EVDF

   $ perf stat -r 7 -e cs,migrations,cache-misses,branch-misses -- perf 
bench sched messaging -g 20 -l 1000 -p

test  | seconds | cs   | migrations | cache miss | branch miss |
------|---------|------|------------|------------|-------------|
1)    |  2,90   | 192K |   6,7K     |   99M      |   60M       |
2)    |  2,97   | 226K |   6,9K     |  102M      |   61M       |
3)    |  3,00   | 247K |   6,9K     |  108M      |   62M       |
4)    |  2,92   | 182K |   7,2K     |  101M      |   60M       |
5)    |  2,94   | 203K |   6,8K     |  101M      |   60M       |
6)    |  2,79   |  84K |   6,4K     |   94M      |   57M       |


   $ stress-ng --bsearch 2 --matrix 2 --matrix-method prod --timeout 30 
--metrics-brief [results in bogo ops/s]

test  | bsearch | matrix |
------|---------|--------|
1)    |  392    |  588   |
2)    |  512    |  688   |
3)    |  512    |  663   |
4)    |  512    |  688   |
5)    |  511    |  686   |
6)    |  510    |  655   |

--

I don't know if this info is useful enough for you scheduler people, but 
I hope it helps.

Cheers,
Tor

> 
> I really don't like the EVDF option, and I think you'll end up
> regretting using it sooner rather than later, just to make this one
> benchmark you have happy.
> 
> I'm hoping the default is enough, but otherwise any of the above should
> be a *much* better scheduler.
> 
> Also, bonus points if you can create us a stand alone benchmark that
> captures your metric (al-la facebook's schbench) without the whole
> chrome nonsense, that'd be epic.
> 
