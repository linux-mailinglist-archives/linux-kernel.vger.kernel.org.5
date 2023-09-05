Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BBF792760
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238759AbjIEQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354618AbjIEM4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:56:43 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A961E9;
        Tue,  5 Sep 2023 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693918598;
        bh=455XTvC9ol/LhrdApr3vB/fUeAmbr04fqAzjMIGtI98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=azEd68gv6XhyBJ5BYvepfRRBcO1bi1xUu9m9kZ0GWGdMASBhIWWqQQjTlZXWv5o1L
         ZJ7p96OPgm+iEyhmR5RvjsI/wjsU/pvKT0AxiLjvsw1w929Rkesu1zOL6Co1DhWsX8
         THxfZERNoD86M1gAzwup6mJnPGN6suW4p0iHbuVDkWDWPAdU8P33Km2JUTzuEIs+9O
         Ktd9944/Ra6eTui31IB1bJPp3ig+NZ+UskJvvHteoT1YO/WHLCOo5+l4ZKmy/y8s+7
         onVbzIOcbMzzw5eodILtMrlR9Cu/eER6SrZOW2TSzXXeISLNUCtswgyTRAE1zMrwWf
         K2zCeoLPSv1Bw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rg59f0yrdz1N0T;
        Tue,  5 Sep 2023 08:56:38 -0400 (EDT)
Message-ID: <7beb35c3-217a-d3c3-8e75-a1212500d2ac@efficios.com>
Date:   Tue, 5 Sep 2023 08:57:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] Fix srcu_struct node grpmask overflow on 64-bit
 systems
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230904122114.66757-1-arefev@swemel.ru>
 <a60cf690-2af7-1eee-c1c1-3433d16a1939@efficios.com>
 <40593b16-8232-27fc-808a-37bad7457dc0@efficios.com>
 <751d2afd-fc91-400d-8889-187031f2bbf0@paulmck-laptop>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <751d2afd-fc91-400d-8889-187031f2bbf0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 09:58, Paul E. McKenney wrote:
> On Mon, Sep 04, 2023 at 08:58:48AM -0400, Mathieu Desnoyers wrote:
>> On 9/4/23 08:42, Mathieu Desnoyers wrote:
>>> On 9/4/23 08:21, Denis Arefev wrote:
>>>> The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
>>>> is subject to overflow due to a failure to cast operands to a larger
>>>> data type before performing arithmetic.
>>>>
>>>> The maximum result of this subtraction is defined by the RCU_FANOUT
>>>> or other srcu level-spread values assigned by rcu_init_levelspread(),
>>>> which can indeed cause the signed 32-bit integer literal ("1") to
>>>> overflow
>>>> when shifted by any value greater than 31.
>>>
>>> We could expand on this:
>>>
>>> The maximum result of this subtraction is defined by the RCU_FANOUT
>>> or other srcu level-spread values assigned by rcu_init_levelspread(),
>>> which can indeed cause the signed 32-bit integer literal ("1") to overflow
>>> when shifted by any value greater than 31 on a 64-bit system.
>>>
>>> Moreover, when the subtraction value is 31, the 1 << 31 expression results
>>> in 0xffffffff80000000 when the signed integer is promoted to unsigned long
>>> on 64-bit systems due to type promotion rules, which is certainly not the
>>> intended result.
> 
> Thank you both!  Could you please also add something to the effect of:
> "Given default Kconfig options, this bug affects only systems with more
> than 512 CPUs."?

Hi Paul,

I'm trying to understand this "NR_CPUS > 512 CPUs" default Kconfig lower 
bound from kernel/rcu/Kconfig and rcu_node_tree.h. Is that on a 32-bit 
or 64-bit architecture ? Also, I suspect that something like x86-64 
MAXSMP (or an explicit NR_CPUS) needs to be selected over a default 
Kconfig to support that many CPUs.

Thanks,

Mathieu


> 
> 							Thanx, Paul
> 
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> With the commit message updated with my comment above, please also add:
>>>
>>> Fixes: c7e88067c1 ("srcu: Exact tracking of srcu_data structures
>>> containing callbacks")
>>> Cc: <stable@vger.kernel.org> # v4.11
>>
>> Sorry, the line above should read:
>>
>> Cc: <stable@vger.kernel.org> # v4.11+
>>
>> Thanks,
>>
>> Mathieu
>>
>>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>
>>> Thanks!
>>>
>>> Mathieu
>>>
>>>>
>>>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>>>> ---
>>>> v3: Changed the name of the patch, as suggested by
>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>    kernel/rcu/srcutree.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>> index 20d7a238d675..6c18e6005ae1 100644
>>>> --- a/kernel/rcu/srcutree.c
>>>> +++ b/kernel/rcu/srcutree.c
>>>> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct
>>>> srcu_struct *ssp, gfp_t gfp_flags)
>>>>                    snp->grplo = cpu;
>>>>                snp->grphi = cpu;
>>>>            }
>>>> -        sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
>>>> +        sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
>>>>        }
>>>>        smp_store_release(&ssp->srcu_sup->srcu_size_state,
>>>> SRCU_SIZE_WAIT_BARRIER);
>>>>        return true;
>>>> @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct
>>>> srcu_struct *ssp, struct srcu_node *snp
>>>>        int cpu;
>>>>        for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
>>>> -        if (!(mask & (1 << (cpu - snp->grplo))))
>>>> +        if (!(mask & (1UL << (cpu - snp->grplo))))
>>>>                continue;
>>>>            srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>>>>        }
>>>
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

