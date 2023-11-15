Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED817EC1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbjKOLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbjKOLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:55:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD45F11D;
        Wed, 15 Nov 2023 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049338; x=1731585338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0bNj6nZns+IPxkElK71jO22u6HEoHngQKYSy+Ymgh70=;
  b=YSZURYg8Z49IImOTRLLbrRLT7vHjNQ4Qtp4zbzJ1B5LOslfgb2hn5a49
   7S4QFV8lUHt2DdABMHLaqdDH2VqpPAIzDAASFWXw4nKAthySel8rJLRcO
   XRSj2hwWYcq0T/SQhQ8VOXZCpoTM5rD/1XvAvfl6ol3ORGHHmKXQ/Pg/i
   c4t/3Jf7e+fbe5W8prWWzxcE2ddBdfE+T9GZSSgxwbcLqAc4R8ILi+pL+
   pPfxnjtjOkajVFY4TlceC09D0QKx7Bi1x1cISfvZtPCRboDTn7ydpPbmT
   d4uTx4j/MkLrkl5kISHVV7qk8huqGqU+4ALXoYrT+BD36+rkhju735piX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393720069"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393720069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:55:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753433"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753433"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:55:34 -0800
Message-ID: <b0228bde-4e8f-42c7-9c08-4a282ae2ba0d@linux.intel.com>
Date:   Wed, 15 Nov 2023 19:55:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 3/7] net/sched: taprio: update impacted fields
 during cycle time adjustment
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-4-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-4-faizal.abdul.rahim@linux.intel.com>
 <20231108234112.umxjgvqajnxjr6lj@skbuf>
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231108234112.umxjgvqajnxjr6lj@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 7:41 am, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:19AM -0500, Faizal Rahim wrote:
>> Update impacted fields in advance_sched() if cycle_corr_active()
>> is true, which indicates that the next entry is the last entry
>> from oper that it will run.
>>
>> Update impacted fields:
>>
>> 1. gate_duration[tc], max_open_gate_duration[tc]
>> Created a new API update_open_gate_duration().The API sets the
>> duration based on the last remaining entry, the original value
>> was based on consideration of multiple entries.
>>
>> 2. gate_close_time[tc]
>> Update next entry gate close time according to the new admin
>> base time
>>
>> 3. max_sdu[tc], budget[tc]
>> Restrict from setting to max value because there's only a single
>> entry left to run from oper before changing to the new admin
>> schedule, so we shouldn't set to max.
>>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> The commit message shouldn't be a text-to-speech output of the commit body.
> Say very shortly how the system should behave, what's wrong such that it
> doesn't behave as expected, what's the user-visible impact of the bug,
> and try to identify why the bug happened.
> 
> In this case, what happened is that commit a306a90c8ffe ("net/sched:
> taprio: calculate tc gate durations"), which introduced the impacted
> fields you are changing, never took dynamic schedule changes into
> consideration. So this commit should also appear in the Fixes: tag.

Got it.

>> ---
>>   net/sched/sch_taprio.c | 49 +++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index ed32654b46f5..119dec3bbe88 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -288,7 +288,8 @@ static void taprio_update_queue_max_sdu(struct taprio_sched *q,
>>   		/* TC gate never closes => keep the queueMaxSDU
>>   		 * selected by the user
>>   		 */
>> -		if (sched->max_open_gate_duration[tc] == sched->cycle_time) {
>> +		if (sched->max_open_gate_duration[tc] == sched->cycle_time &&
>> +		    !cycle_corr_active(sched->cycle_time_correction)) {
>>   			max_sdu_dynamic = U32_MAX;
>>   		} else {
>>   			u32 max_frm_len;
>> @@ -684,7 +685,8 @@ static void taprio_set_budgets(struct taprio_sched *q,
>>   
>>   	for (tc = 0; tc < num_tc; tc++) {
>>   		/* Traffic classes which never close have infinite budget */
>> -		if (entry->gate_duration[tc] == sched->cycle_time)
>> +		if (entry->gate_duration[tc] == sched->cycle_time &&
>> +		    !cycle_corr_active(sched->cycle_time_correction))
>>   			budget = INT_MAX;
>>   		else
>>   			budget = div64_u64((u64)entry->gate_duration[tc] * PSEC_PER_NSEC,
>> @@ -896,6 +898,32 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
>>   	return false;
>>   }
>>   
>> +/* Open gate duration were calculated at the beginning with consideration of
>> + * multiple entries. If cycle time correction is active, there's only a single
>> + * remaining entry left from oper to run.
>> + * Update open gate duration based on this last entry.
>> + */
>> +static void update_open_gate_duration(struct sched_entry *entry,
>> +				      struct sched_gate_list *oper,
>> +				      int num_tc,
>> +				      u64 open_gate_duration)
>> +{
>> +	int tc;
>> +
>> +	if (!entry || !oper)
>> +		return;
>> +
>> +	for (tc = 0; tc < num_tc; tc++) {
>> +		if (entry->gate_mask & BIT(tc)) {
>> +			entry->gate_duration[tc] = open_gate_duration;
>> +			oper->max_open_gate_duration[tc] = open_gate_duration;
>> +		} else {
>> +			entry->gate_duration[tc] = 0;
>> +			oper->max_open_gate_duration[tc] = 0;
>> +		}
>> +	}
>> +}
>> +
>>   static bool should_change_sched(struct sched_gate_list *oper)
>>   {
>>   	bool change_to_admin_sched = false;
>> @@ -1010,13 +1038,28 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   			/* The next entry is the last entry we will run from
>>   			 * oper, subsequent ones will take from the new admin
>>   			 */
>> +			u64 new_gate_duration =
>> +				next->interval + oper->cycle_time_correction;
>> +			struct qdisc_size_table *stab =
>> +				rtnl_dereference(q->root->stab);
>> +
> 
> The lockdep annotation for this RCU accessor is bogus.
> rtnl_dereference() is the same as rcu_dereference_protected(..., lockdep_rtnl_is_held()),
> which cannot be true in a hrtimer callback, as the rtnetlink lock is a
> sleepable mutex and hrtimers run in atomic context.
> 
> Running with lockdep enabled will tell you as much:
> 
> $ ./test_taprio_cycle_extension.sh
> Testing config change with a delay of 5250000000 ns between schedules
> [  100.734925]
> [  100.736703] =============================
> [  100.740780] WARNING: suspicious RCU usage
> [  100.744857] 6.6.0-10114-gca572939947f #1495 Not tainted
> [  100.750162] -----------------------------
> [  100.754236] net/sched/sch_taprio.c:1064 suspicious rcu_dereference_protected() usage!
> [  100.762155]
> [  100.762155] other info that might help us debug this:
> [  100.762155]
> [  100.770242]
> [  100.770242] rcu_scheduler_active = 2, debug_locks = 1
> [  100.776851] 1 lock held by swapper/0/0:
> [  100.780756]  #0: ffff3d9784b83b00 (&q->current_entry_lock){-...}-{3:3}, at: advance_sched+0x44/0x59c
> [  100.790099]
> [  100.790099] stack backtrace:
> [  100.794477] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-10114-gca572939947f #1495
> [  100.802346] Hardware name: LS1028A RDB Board (DT)
> [  100.807072] Call trace:
> [  100.809531]  dump_backtrace+0xf4/0x140
> [  100.813305]  show_stack+0x18/0x2c
> [  100.816638]  dump_stack_lvl+0x60/0x80
> [  100.820321]  dump_stack+0x18/0x24
> [  100.823654]  lockdep_rcu_suspicious+0x170/0x210
> [  100.828210]  advance_sched+0x384/0x59c
> [  100.831978]  __hrtimer_run_queues+0x200/0x430
> [  100.836360]  hrtimer_interrupt+0xdc/0x39c
> [  100.840392]  arch_timer_handler_phys+0x3c/0x4c
> [  100.844862]  handle_percpu_devid_irq+0xb8/0x28c
> [  100.849417]  generic_handle_domain_irq+0x2c/0x44
> [  100.854060]  gic_handle_irq+0x4c/0x110
> [  100.857830]  call_on_irq_stack+0x24/0x4c
> [  100.861775]  el1_interrupt+0x74/0xc0
> [  100.865370]  el1h_64_irq_handler+0x18/0x24
> [  100.869489]  el1h_64_irq+0x64/0x68
> [  100.872909]  arch_local_irq_enable+0x8/0xc
> [  100.877032]  cpuidle_enter+0x38/0x50
> [  100.880629]  do_idle+0x1ec/0x280
> [  100.883877]  cpu_startup_entry+0x34/0x38
> [  100.887822]  kernel_init+0x0/0x1a0
> [  100.891245]  start_kernel+0x0/0x3b0
> [  100.894756]  start_kernel+0x2f8/0x3b0
> [  100.898439]  __primary_switched+0xbc/0xc4
> 
> What I would do is:
> 
> 			struct qdisc_size_table *stab;
> 
> 			rcu_read_lock();
> 			stab = rcu_dereference(q->root->stab);
> 			taprio_update_queue_max_sdu(q, oper, stab);
> 			rcu_read_unlock();
> 
>>   			oper->cycle_end_time = new_base_time;
>>   			end_time = new_base_time;
>> +
>> +			update_open_gate_duration(next, oper, num_tc,
>> +						  new_gate_duration);
>> +			taprio_update_queue_max_sdu(q, oper, stab);
>>   		}
>>   	}
>>   
>>   	for (tc = 0; tc < num_tc; tc++) {
>> -		if (next->gate_duration[tc] == oper->cycle_time)
>> +		if (cycle_corr_active(oper->cycle_time_correction) &&
>> +		    (next->gate_mask & BIT(tc)))
>> +			/* Set to the new base time, ensuring a smooth transition
>> +			 * to the new schedule when the next entry finishes.
>> +			 */
>> +			next->gate_close_time[tc] = end_time;
>> +		else if (next->gate_duration[tc] == oper->cycle_time)
>>   			next->gate_close_time[tc] = KTIME_MAX;
>>   		else
>>   			next->gate_close_time[tc] = ktime_add_ns(entry->end_time,
>> -- 
>> 2.25.1
>>
> 

Will update, thanks.
