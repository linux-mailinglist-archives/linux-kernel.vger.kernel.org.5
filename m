Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93A792B87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbjIEQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354691AbjIENeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:34:25 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119AECDE;
        Tue,  5 Sep 2023 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693920809;
        bh=BoY6s8f3+X2a/QzwjJUE/2tdJK5myHMz1Bnu+Le5KlQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LIWlO2U/9nlZ+Jfq9zqkXhYVaXim1nofT3VcmHfvO/6vLLBJzwhczDLMimRyedN4e
         xzJvtMhrrVFCj4CEX5t2g6K7O65P0b3urgGpyjK71oC+sf5eZd5IuJ5oztrc93jDVT
         kbTGcqA/l1PGKIuZ7OfUIKL3xRZ0jkLdBJHzGLSxIZXBxlpmBt5EbY5AD1r9er7fQv
         0mYMO/6JOslPP2aByYfXSaQagm6svOpxN5h7QYyY9Erwvzcsq1ZDWNGoZK6cgqDDO1
         gtq1P8qUA6vKXRr5q/mdqYu/sc+228YgB4Ryl1F5CgJSzD+wTIKimWxvlEpcXp+NYa
         JWEWNoczuvzgQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Rg6091KKdz1NPY;
        Tue,  5 Sep 2023 09:33:29 -0400 (EDT)
Message-ID: <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
Date:   Tue, 5 Sep 2023 09:34:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] The value may overflow
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     David Laight <David.Laight@aculab.com>,
        Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
 <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
 <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 09:26, Paul E. McKenney wrote:
> On Tue, Sep 05, 2023 at 08:26:51AM -0400, Mathieu Desnoyers wrote:
>> On 9/5/23 05:31, David Laight wrote:
>>> From: Mathieu Desnoyers
>>>> Sent: 04 September 2023 11:24
>>>>
>>>> On 9/4/23 05:42, Denis Arefev wrote:
>>>>> The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
>>>>> is subject to overflow due to a failure to cast operands to a larger
>>>>> data type before performing arithmetic
>>>>
>>>> The patch title should identify more precisely its context, e.g.:
>>>>
>>>> "srcu: Fix srcu_struct node grpmask overflow on 64-bit systems"
>>>>
>>>> Also, as I stated in my reply to the previous version, the patch commit
>>>> message should describe the impact of the bug it fixes.
>>>
>>> And is the analysis complete?
>>> Is 1UL right for 32bit archs??
>>> Is 64 bits even enough??
>>
>> I understand from include/linux/rcu_node_tree.h and kernel/rcu/Kconfig
>> RCU_FANOUT and RCU_FANOUT_LEAF ranges that a 32-bit integer is sufficient to
>> hold the mask on 32-bit architectures, and a 64-bit integer is enough on
>> 64-bit architectures given the current implementation.
>>
>> At least this appears to be the intent. I did not do a thorough analysis of
>> the various parameter limits.
> 
> Mathieu has it right.
> 
> 32-bit kernels are unaffected by this bug.
> 
> RCU_FANOUT_LEAF defaults to 16, which means that a 64-bit kernel would
> need more than 32 leaf rcu_node structures for the parent rcu_node
> structure to need more than 32 bit to track its children.  This means
> that more than 32*16=512 CPUs are required for this bug to affect 64-bit
> systems.  And there really are systems this big, so I am surprised that
> this has not shown up long ago.  But it would not be the first time that
> objective reality surprised me.  ;-)

So with a 64-bit kernel, RCU_FANOUT_LEAF=16, if we have exactly 32 leaf 
rcu_node structures (exactly 512 CPUs), we end up in the situation where 
the type promotion from signed integer (32-bit) to unsigned long will 
carry the sign, and thus create a mask of 0xffffffff80000000.

So if this weird mask is indeed an issue we should state that 
configurations _starting from 512 CPUs_ are affected, not just those 
with more than 512 CPUs.

Thanks,

Mathieu


> 
> 							Thanx, Paul
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> 	David
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>>>>> ---
>>>>> v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
>>>>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>     kernel/rcu/srcutree.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>>>> index 20d7a238d675..6c18e6005ae1 100644
>>>>> --- a/kernel/rcu/srcutree.c
>>>>> +++ b/kernel/rcu/srcutree.c
>>>>> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>>>>>     				snp->grplo = cpu;
>>>>>     			snp->grphi = cpu;
>>>>>     		}
>>>>> -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
>>>>> +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
>>>>>     	}
>>>>>     	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
>>>>>     	return true;
>>>>> @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>>>>>     	int cpu;
>>>>>
>>>>>     	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
>>>>> -		if (!(mask & (1 << (cpu - snp->grplo))))
>>>>> +		if (!(mask & (1UL << (cpu - snp->grplo))))
>>>>>     			continue;
>>>>>     		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>>>>>     	}
>>>>
>>>> --
>>>> Mathieu Desnoyers
>>>> EfficiOS Inc.
>>>> https://www.efficios.com
>>>
>>> -
>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>>> Registration No: 1397386 (Wales)
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

