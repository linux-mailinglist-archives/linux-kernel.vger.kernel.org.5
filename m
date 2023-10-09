Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB87BD953
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbjJILNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbjJILNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:13:31 -0400
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44B94
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:13:30 -0700 (PDT)
Message-ID: <5a3342ef-f14f-173c-630f-6b474bded257@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696850008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6bujvWT1GknYcY3g+1JFcsWNbwZNp5LaRrzpNwllk3A=;
        b=wLkUIYxmmn6cmeSEYoCHAKeBvBQK14NDRGt9x2Qs/LQkAGw12ppUiQDu4TIdxvqjvl92Yw
        bQdY16/YjA9VxyQeH3tXV42nghOY5yuae7RD/CAEjrOV1A+oWhkpEx2mDTBocPO4NjAHkq
        tPWvUVo4OVfaO9xKrpZyytyWdqklQXE=
Date:   Mon, 9 Oct 2023 19:13:18 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] sched/rt: Move sched_rt_entity::back to under the
 CONFIG_RT_GROUP_SCHED block
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231005162317.3343678-1-yajun.deng@linux.dev>
 <20231005162317.3343678-3-yajun.deng@linux.dev> <ZSPS+jMcJEd+ZR28@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ZSPS+jMcJEd+ZR28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/9 18:16, Ingo Molnar wrote:
> * Yajun Deng <yajun.deng@linux.dev> wrote:
>
>> The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
>> So move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block. It
>> will save a few bytes.
>>
>> Also, init child when parent isn't NULL in init_tg_rt_entry().
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>>   include/linux/sched.h |  2 +-
>>   kernel/sched/rt.c     | 18 +++++++++---------
>>   2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 292c31697248..d0fe56603e60 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -597,8 +597,8 @@ struct sched_rt_entity {
>>   	unsigned short			on_rq;
>>   	unsigned short			on_list;
>>   
>> -	struct sched_rt_entity		*back;
>>   #ifdef CONFIG_RT_GROUP_SCHED
>> +	struct sched_rt_entity		*back;
>>   	struct sched_rt_entity		*parent;
>>   	/* rq on which this entity is (to be) queued: */
>>   	struct rt_rq			*rt_rq;
> Title claims this change - the rest of the changes should be in a separate
> patch:


Okay. I will send v2.

>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 642edbd24ffb..7b3105b875f1 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -233,8 +233,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>>   
>>   	if (!parent)
>>   		rt_se->rt_rq = &rq->rt;
>> -	else
>> +	else {
>>   		rt_se->rt_rq = parent->my_q;
>> +		parent->back = rt_se;
>> +	}
>>   
>>   	rt_se->my_q = rt_rq;
>>   	rt_se->parent = parent;
>> @@ -1441,23 +1443,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
>>    */
>>   static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>>   {
>> -	struct sched_rt_entity *back = NULL;
>> +	struct sched_rt_entity *root = NULL;
>>   	unsigned int rt_nr_running;
>>   
>> -	for_each_sched_rt_entity(rt_se) {
>> -		rt_se->back = back;
>> -		back = rt_se;
>> -	}
>> +	for_each_sched_rt_entity(rt_se)
>> +		root = rt_se;
>>   
>> -	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
>> +	rt_nr_running = rt_rq_of_se(root)->rt_nr_running;
>>   
>> -	rt_se = back;
>> +	rt_se = root;
>>   	for_each_sched_rt_entity_back(rt_se) {
>>   		if (on_rt_rq(rt_se))
>>   			__dequeue_rt_entity(rt_se, flags);
>>   	}
>>   
>> -	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
>> +	dequeue_top_rt_rq(rt_rq_of_se(root), rt_nr_running);
>>   }
>>   
>>   static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
>> -- 
>> 2.25.1
> Thanks,
>
> 	Ingo
