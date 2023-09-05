Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE12792B5B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjIEQwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354707AbjIENlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:41:53 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D630191;
        Tue,  5 Sep 2023 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693921308;
        bh=eB17XpzIhCLGdd/SxKMDLZj90A8HQtu4wR50LZ5h4Ik=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wG0U0maObxsRUs540ZiQ1zIAuwv58t7F6sNhb8+dWh1W5TC5LuUzn3Ci+gFPeWRDJ
         jwgo5032RJwvSY8rh74LARVQajV2+ZgBIdc1IpObLTOpZ5uNlgYqAfsoXb3Cwglv0y
         fxynybLsCrG1Q5jpeu4cxU9XRFS7SKd04fwotEio8I8unagYYbEmQXsRkTGw6d7CU3
         rmyP2TYVf1NBt37wrgufs0TRKXxiL62Dg7UzuU2wYCiZI2qh2Kv1jR/UJnoRN4WLTA
         HiNKYMGSQ5LN1ICMyo2c82CvW4sG92YIOyyJvBOZrBr0b+6Fj9IWbEG1BXal+dgzaS
         dRTc0lSLe54LQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rg69m1DFRz1NKK;
        Tue,  5 Sep 2023 09:41:48 -0400 (EDT)
Message-ID: <2613d958-8e8a-c302-8779-8719a10c82e5@efficios.com>
Date:   Tue, 5 Sep 2023 09:43:04 -0400
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
 <7beb35c3-217a-d3c3-8e75-a1212500d2ac@efficios.com>
 <98c676a6-3c11-48f1-b7cb-81356c362680@paulmck-laptop>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <98c676a6-3c11-48f1-b7cb-81356c362680@paulmck-laptop>
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

On 9/5/23 09:38, Paul E. McKenney wrote:
> On Tue, Sep 05, 2023 at 08:57:53AM -0400, Mathieu Desnoyers wrote:
>> On 9/4/23 09:58, Paul E. McKenney wrote:
>>> On Mon, Sep 04, 2023 at 08:58:48AM -0400, Mathieu Desnoyers wrote:
>>>> On 9/4/23 08:42, Mathieu Desnoyers wrote:
>>>>> On 9/4/23 08:21, Denis Arefev wrote:
>>>>>> The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
>>>>>> is subject to overflow due to a failure to cast operands to a larger
>>>>>> data type before performing arithmetic.
>>>>>>
>>>>>> The maximum result of this subtraction is defined by the RCU_FANOUT
>>>>>> or other srcu level-spread values assigned by rcu_init_levelspread(),
>>>>>> which can indeed cause the signed 32-bit integer literal ("1") to
>>>>>> overflow
>>>>>> when shifted by any value greater than 31.
>>>>>
>>>>> We could expand on this:
>>>>>
>>>>> The maximum result of this subtraction is defined by the RCU_FANOUT
>>>>> or other srcu level-spread values assigned by rcu_init_levelspread(),
>>>>> which can indeed cause the signed 32-bit integer literal ("1") to overflow
>>>>> when shifted by any value greater than 31 on a 64-bit system.
>>>>>
>>>>> Moreover, when the subtraction value is 31, the 1 << 31 expression results
>>>>> in 0xffffffff80000000 when the signed integer is promoted to unsigned long
>>>>> on 64-bit systems due to type promotion rules, which is certainly not the
>>>>> intended result.
>>>
>>> Thank you both!  Could you please also add something to the effect of:
>>> "Given default Kconfig options, this bug affects only systems with more
>>> than 512 CPUs."?
>>
>> Hi Paul,
>>
>> I'm trying to understand this "NR_CPUS > 512 CPUs" default Kconfig lower
>> bound from kernel/rcu/Kconfig and rcu_node_tree.h. Is that on a 32-bit or
>> 64-bit architecture ? Also, I suspect that something like x86-64 MAXSMP (or
>> an explicit NR_CPUS) needs to be selected over a default Kconfig to support
>> that many CPUs.
> 
> 64-bit only.  I believe that 32-bit kernels are unaffected by this bug.
> 
> The trick is that RCU reshapes the rcu_node tree in rcu_init_geometry(),
> which is invoked during early boot from rcu_init().  This reshaping is
> based on nr_cpu_ids.  So if NR_CPUS is (say) 4096, there will be enough
> rcu_node structures allocated at build time to accommodate 4096 CPUs
> (259 of them, 256 leaf nodes, four internal nodes, and one root node),
> but only assuming dense numbering of CPUs.  If rcu_init_geometry() sees
> that nr_cpu_ids is (say) 64, it will use only five of them, that is,
> four leaf nodes and one root node.  The leaf nodes will need to shift
> by at most 16, and the root node by at most 4.
> 
> But the possibility of sparse CPU numbering (perhaps to your point)
> means that the bug can occur in 64-bit kernels booted on systems with
> 512 CPUs or fewer if that system has sparse CPU IDs.  For example,
> there have been systems that disable all but one hardware thread per
> core, but leave places in the CPU numbering for those disabled threads.
> Such a system with four hardware threads per core could have a CPU 516
> (and thus be affected by this bug) with as few as 129 CPUs.
> 
> So a better request would be for something like: "Given default Kconfig
> options, this bug affects only 64-bit systems having at least one CPU
> for which smp_processor_id() returns 512 or greater."
> 
> Does that help, or am I missing your point?

This is a good point, although not the one I was trying to make. See my 
explanation about impact of having exactly 512 wrt signed integer type 
promotion in a separate email. So your last phrasing "returns 512 or 
greater" is better. Previously it appeared that only systems with _more 
than_ 512 cpus were affected, which was off-by-one considering that 
systems with exactly 512 cpus are an issue as well.

Thanks,

Mathieu


> 
> 							Thanx, Paul
> 
>> Thanks,
>>
>> Mathieu
>>
>>
>>>
>>> 							Thanx, Paul
>>>
>>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> With the commit message updated with my comment above, please also add:
>>>>>
>>>>> Fixes: c7e88067c1 ("srcu: Exact tracking of srcu_data structures
>>>>> containing callbacks")
>>>>> Cc: <stable@vger.kernel.org> # v4.11
>>>>
>>>> Sorry, the line above should read:
>>>>
>>>> Cc: <stable@vger.kernel.org> # v4.11+
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Mathieu
>>>>>
>>>>>>
>>>>>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>>>>>> ---
>>>>>> v3: Changed the name of the patch, as suggested by
>>>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>> v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
>>>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>>     kernel/rcu/srcutree.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>>>> index 20d7a238d675..6c18e6005ae1 100644
>>>>>> --- a/kernel/rcu/srcutree.c
>>>>>> +++ b/kernel/rcu/srcutree.c
>>>>>> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct
>>>>>> srcu_struct *ssp, gfp_t gfp_flags)
>>>>>>                     snp->grplo = cpu;
>>>>>>                 snp->grphi = cpu;
>>>>>>             }
>>>>>> -        sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
>>>>>> +        sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
>>>>>>         }
>>>>>>         smp_store_release(&ssp->srcu_sup->srcu_size_state,
>>>>>> SRCU_SIZE_WAIT_BARRIER);
>>>>>>         return true;
>>>>>> @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct
>>>>>> srcu_struct *ssp, struct srcu_node *snp
>>>>>>         int cpu;
>>>>>>         for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
>>>>>> -        if (!(mask & (1 << (cpu - snp->grplo))))
>>>>>> +        if (!(mask & (1UL << (cpu - snp->grplo))))
>>>>>>                 continue;
>>>>>>             srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>>>>>>         }
>>>>>
>>>>
>>>> -- 
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> https://www.efficios.com
>>>>
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

