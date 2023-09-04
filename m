Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810147917A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbjIDM5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIDM5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:57:37 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C19133;
        Mon,  4 Sep 2023 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693832253;
        bh=bRUFW1g/1Azskommok7qV2fv/XfzfAIWR8+N+fSYWSI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ufbLnGW6knPsxyPkd05SYSmAtFqPc9BB+EmV6+oaQ1ko2YGk6TsPBN52H2TKad+os
         u0Ji4QvAM4K5lrNghxpApzI6npa25jex0uXPSI/XT3OLa4yP0jbN+bujXJoNHyPQ5H
         h9Kx59AU4euCdxBzI5Odo004N5yGRGKsbsW9v49VYbKMOSkAzUwoG1OudS/Uu3v+qT
         cynHT0FzYzuy3cZHyED4xHE+ADvp5QtZSapYGZG1kPtTEi5CzaoDziOGIhUzwYjgC1
         NRGQ53RE9HvtF+aimhD8CBGMxzuA0MWus/zJQKGQn1fR0JSZRLCb1hdBIncL0pHF43
         SW41aiRn9Z1sA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RfTF90QfLz1NM8;
        Mon,  4 Sep 2023 08:57:33 -0400 (EDT)
Message-ID: <40593b16-8232-27fc-808a-37bad7457dc0@efficios.com>
Date:   Mon, 4 Sep 2023 08:58:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] Fix srcu_struct node grpmask overflow on 64-bit
 systems
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230904122114.66757-1-arefev@swemel.ru>
 <a60cf690-2af7-1eee-c1c1-3433d16a1939@efficios.com>
In-Reply-To: <a60cf690-2af7-1eee-c1c1-3433d16a1939@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 08:42, Mathieu Desnoyers wrote:
> On 9/4/23 08:21, Denis Arefev wrote:
>> The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
>> is subject to overflow due to a failure to cast operands to a larger
>> data type before performing arithmetic.
>>
>> The maximum result of this subtraction is defined by the RCU_FANOUT
>> or other srcu level-spread values assigned by rcu_init_levelspread(),
>> which can indeed cause the signed 32-bit integer literal ("1") to 
>> overflow
>> when shifted by any value greater than 31.
> 
> We could expand on this:
> 
> The maximum result of this subtraction is defined by the RCU_FANOUT
> or other srcu level-spread values assigned by rcu_init_levelspread(),
> which can indeed cause the signed 32-bit integer literal ("1") to overflow
> when shifted by any value greater than 31 on a 64-bit system.
> 
> Moreover, when the subtraction value is 31, the 1 << 31 expression results
> in 0xffffffff80000000 when the signed integer is promoted to unsigned long
> on 64-bit systems due to type promotion rules, which is certainly not the
> intended result.
> 
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> With the commit message updated with my comment above, please also add:
> 
> Fixes: c7e88067c1 ("srcu: Exact tracking of srcu_data structures 
> containing callbacks")
> Cc: <stable@vger.kernel.org> # v4.11

Sorry, the line above should read:

Cc: <stable@vger.kernel.org> # v4.11+

Thanks,

Mathieu

> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Thanks!
> 
> Mathieu
> 
>>
>> Signed-off-by: Denis Arefev <arefev@swemel.ru>
>> ---
>> v3: Changed the name of the patch, as suggested by
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>   kernel/rcu/srcutree.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 20d7a238d675..6c18e6005ae1 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct 
>> srcu_struct *ssp, gfp_t gfp_flags)
>>                   snp->grplo = cpu;
>>               snp->grphi = cpu;
>>           }
>> -        sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
>> +        sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
>>       }
>>       smp_store_release(&ssp->srcu_sup->srcu_size_state, 
>> SRCU_SIZE_WAIT_BARRIER);
>>       return true;
>> @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct 
>> srcu_struct *ssp, struct srcu_node *snp
>>       int cpu;
>>       for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
>> -        if (!(mask & (1 << (cpu - snp->grplo))))
>> +        if (!(mask & (1UL << (cpu - snp->grplo))))
>>               continue;
>>           srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>>       }
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

