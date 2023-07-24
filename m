Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2E75E9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGXCy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGXCyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:54:25 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10449107;
        Sun, 23 Jul 2023 19:54:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R8N9Q3qm7z4f3mWg;
        Mon, 24 Jul 2023 09:38:50 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbEo1r1kmzauOg--.11345S3;
        Mon, 24 Jul 2023 09:38:51 +0800 (CST)
Subject: Re: [PATCH 1/2] rcu: Delete a redundant check in check_cpu_stall()
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
References: <20230721075716.857-1-thunder.leizhen@huaweicloud.com>
 <20230721075716.857-2-thunder.leizhen@huaweicloud.com>
 <11e9e09a-c47f-4690-a7c5-9a08913c3e5d@paulmck-laptop>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <042c0f6d-3579-228c-dea4-5f2c880a43f7@huaweicloud.com>
Date:   Mon, 24 Jul 2023 09:38:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <11e9e09a-c47f-4690-a7c5-9a08913c3e5d@paulmck-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBnHbEo1r1kmzauOg--.11345S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfXr1xXry7AFyDWFykKrg_yoW8tFyDpF
        W8J3WjgFs5GF1IkwnFyw1kJryUZa1jgryUt3WDWryFy3sIy3WfKFyDWFyrWFWFvr93Xw4S
        qw1vqwnrCw4jyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/22 6:37, Paul E. McKenney wrote:
> On Fri, Jul 21, 2023 at 03:57:15PM +0800, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> j = jiffies;
>> js = READ_ONCE(rcu_state.jiffies_stall);			(1)
>> if (ULONG_CMP_LT(j, js))					(2)
>> 	return;
>>
>> if (cmpxchg(&rcu_state.jiffies_stall, js, jn) == js)		(3)
>> 	didstall = true;
>>
>> if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {	(4)
>> 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
>> 	WRITE_ONCE(rcu_state.jiffies_stall, jn);
>> }
>>
>> For ease of description, the pseudo code is extracted as above. First,
>> assume that only one CPU is operating, the condition 'didstall' is true
>> means that (3) succeeds. That is, the value of rcu_state.jiffies_stall
>> must be 'jn'.
>>
>> Then, assuming that another CPU is also operating at the same time, there
>> are two cases:
>> 1. That CPU sees the updated result at (1), it returns at (2).
>> 2. That CPU does not see the updated result at (1), it fails at (3) and
>>    cmpxchg returns jn. So that, didstall cannot be true.
> 
> The history behind this one is that there are races in which the stall
> can end in the midst of check_cpu_stall().  For example, when the activity
> of producing the stall warning breaks things loose.
> 
> And yes, long ago, I figured that if things had been static for so
> many seconds, they were unlikely to change, and thus omitted any and
> all synchronization.  The Linux kernel taught me better.  ;-)

Okay, got it, thank you

> 
> 							Thanx, Paul
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/rcu/tree_stall.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index cc884cd49e026a3..371713f3f7d15d9 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -794,7 +794,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
>>  			rcu_ftrace_dump(DUMP_ALL);
>>  		didstall = true;
>>  	}
>> -	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
>> +	if (didstall) {
>>  		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
>>  		WRITE_ONCE(rcu_state.jiffies_stall, jn);
>>  	}
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei

