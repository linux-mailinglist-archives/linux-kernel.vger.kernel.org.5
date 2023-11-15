Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923147EC1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjKOLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbjKOLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:55:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B8CC;
        Wed, 15 Nov 2023 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049311; x=1731585311;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5d7wdOlrdZD9uZZJ/q32HHZkqEvQWjCC2nVfcDplrmQ=;
  b=blnQAWAqQEg+NWf+GMVYqnOSiJTl39QdKkIYjpZyuIfvLHKPTdq20rz6
   qpAOy/0Zz8Jtq4BjvLPdFnXhRTqR/T8CUCK2AwB91GYTn73UKgqKyeBCh
   mgNay9MqaLabhhE58eSg039CgnCWB+IdpR2D4c8CC7q8XjfZa9L3Vc0MD
   MRGA7GP7p1KnnBNncovPV348H8J9RZK2ngzpmxQyCr9duOpkWgK0ahn74
   fCZMI2BuKZQPr9VjHb9TE4bHli41pGc4i5WpIfUwTDwb3gfcHzquHVZ6U
   JPYleN2kCmGlsO/wlxuPcMIT1uG4EGxDGo94Grwr4ROE1tGWaJsdRbupl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393719987"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393719987"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753381"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753381"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:55:07 -0800
Message-ID: <27189622-372b-41d9-96ff-710f3a24d1b2@linux.intel.com>
Date:   Wed, 15 Nov 2023 19:55:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/7] net/sched: taprio: fix cycle time adjustment
 for next entry
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
 <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-3-faizal.abdul.rahim@linux.intel.com>
 <20231108232038.dhk64dtsxrw2p6h7@skbuf>
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231108232038.dhk64dtsxrw2p6h7@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 7:20 am, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:18AM -0500, Faizal Rahim wrote:
>> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension:
>> "the Cycle Time Extension variable allows this extension of the last old
>> cycle to be done in a defined way. If the last complete old cycle would
>> normally end less than OperCycleTimeExtension nanoseconds before the new
>> base time, then the last complete cycle before AdminBaseTime is reached
>> is extended so that it ends at AdminBaseTime."
> 
> So far, so good.
> 
>> The current taprio implementation does not extend the last old cycle in
>> the defined manner specified in the Qbv Spec. This is part of the fix
>> covered in this patch.
> 
> In the discussion on v1, I said that prior to commit a1e6ad30fa19
> ("net/sched: taprio: calculate guard band against actual TC gate close
> time"), the last entry's next->close_time actually used to include the
> oper schedule's correction, but it no longer does. This points to a
> regression, and not to something that was never there. Am I wrong?

That is correct, that patch you mentioned is a regression to some of the 
extension correction logic.

The regression caused by the patch you mentioned is resolved by 
("net/sched: taprio: update impacted fields during cycle time adjustment").
Here's a snippet:
		if (cycle_corr_active(oper->cycle_time_correction) &&
		    (next->gate_mask & BIT(tc)))
			next->gate_close_time[tc] = end_time;

The `end_time` here is already corrected. The corrected `gate_close_time` 
is then used by taprio_dequeue_from_txq() -> taprio_entry_allows_tx(), 
which now takes dynamic scheduling into account.


However, the extension logic had other issues even before that patch. 
Example, in should_change_schedules(), it didn't consider if the next entry 
is the last one in the oper cycle before extending the schedule.
Although this comes as no surprise as there was already a FIXME tag in 
should_change_schedules().


This patch primarily addresses the should_change_schedules() logic using 
the new get_cycle_time_correction().


>> Here are the changes made:
>>
>> 1. A new API, get_cycle_time_correction(), has been added to return the
> 
> I would call an "API" an interface between two distinct software layers,
> based on an agreed-upon contract. Not a function in sch_taprio.c which
> is called by another function in sch_taprio.c.

Alright, my use of the term "API" was a bit casual without much 
consideration – my mistake.

>> correction value. If it returns a non-initialize value, it indicates
>> changes required for the next entry schedule, and upon the completion
>> of the next entry's duration, entries will be loaded from the new admin
>> schedule.
> 
> This paragraph doesn't really help. It gets the reader lost in
> irrelevant details which are actually not that hard to deduce from the
> code with some good naming. Actually I find it poor naming to say
> "non-initialize value" when what you mean is "!= INIT_CYCLE_TIME_CORRECTION".
> I think I would name this a "specific" or "valid" cycle correction, when
> it takes a value different from CYCLE_TIME_CORRECTION_UNSPEC.

Will rename

>>
>> 2. Store correction values in cycle_time_correction:
>> a) Positive correction value/extension
>> We calculate the correction between the last operational cycle and the
>> new admin base time. Note that for positive correction to take place,
>> the next entry should be the last entry from oper and the new admin base
>> time falls within the next cycle time of old oper.
>>
>> b) Negative correction value
>> The new admin base time starts earlier than the next entry's end time.
>>
>> c) Zero correction value
>> The new admin base time aligns exactly with the old cycle.
>>
>> 3. When cycle_time_correction is set to a non-initialized value, it is
>> used to:
>> a) Indicate that cycle correction is active to trigger adjustments in
>> affected fields like interval and cycle_time. A new API,
>> cycle_corr_active(), has been created to help with this purpose.
> 
> Again, it's exaggerated to call this an "API".
> Although, what you can do is provide a kerneldoc-style comment above the
> functions which you wish to describe, and remove this explanation from
> the commit message.

okay

>>
>> b) Transition to the new admin schedule at the beginning of
>> advance_sched(). A new API, should_change_sched(), has been introduced
>> for this purpose.
> 
> This should have been done since patch 1, not here.

Understood. My bad - that would have been a better choice.

>> 4. Remove the previous definition of should_change_scheds() API. A new
>> should_change_sched() API has been introduced, but it serves a
>> completely different purpose than the one that was removed.
> 
> So don't name it the same!
> 
>>
>> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   net/sched/sch_taprio.c | 105 +++++++++++++++++++++++++++--------------
>>   1 file changed, 70 insertions(+), 35 deletions(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index dee103647823..ed32654b46f5 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -259,6 +259,14 @@ static int duration_to_length(struct taprio_sched *q, u64 duration)
>>   	return div_u64(duration * PSEC_PER_NSEC, atomic64_read(&q->picos_per_byte));
>>   }
>>   
>> +static bool cycle_corr_active(s64 cycle_time_correction)
>> +{
>> +	if (cycle_time_correction == INIT_CYCLE_TIME_CORRECTION)
>> +		return false;
>> +	else
>> +		return true;
>> +}
>> +
> 
> Could look like this:
> 
> static bool cycle_corr_active(struct sched_gate_list *oper)
> {
> 	return oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION;
> }
> 
>>   /* Sets sched->max_sdu[] and sched->max_frm_len[] to the minimum between the
>>    * q->max_sdu[] requested by the user and the max_sdu dynamically determined by
>>    * the maximum open gate durations at the given link speed.
>> @@ -888,38 +896,59 @@ static bool should_restart_cycle(const struct sched_gate_list *oper,
>>   	return false;
>>   }
>>   
>> -static bool should_change_schedules(const struct sched_gate_list *admin,
>> -				    const struct sched_gate_list *oper,
>> -				    ktime_t end_time)
>> +static bool should_change_sched(struct sched_gate_list *oper)
>>   {
>> -	ktime_t next_base_time, extension_time;
>> +	bool change_to_admin_sched = false;
>>   
>> -	if (!admin)
>> -		return false;
>> +	if (oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
>> +		/* The recent entry ran is the last one from oper */
>> +		change_to_admin_sched = true;
>> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
> 
> Don't make a function called should_change_sched() stateful. Don't make
> this function reset the value of oper->cycle_time_correction, since that
> practically equates with actually starting the schedule change.
> 
> The oper->cycle_time_correction assignment actually belongs to
> switch_schedules(), in my opinion.
> 
> And if you make should_change_sched() stateless, then surprise-surprise,
> it will contain the exact same logic, and return the exact same thing,
> as cycle_corr_active(). I think that naming this single function
> sched_change_pending() and providing a kerneldoc comment as to why it is
> implemented the way it is should be sufficient.
> 

I intentionally made should_change_schedule() slightly different from 
cycle_corr_active() and, unfortunately, stateful by resetting 
oper->cycle_time_correction. My aim was to have two functions with clear 
names reflecting their intentions based on usage.

For instance, this:
	if (should_change_schedule(oper)) {
    		oper->cycle_end_time = new_base_time;
    		end_time = new_base_time;

is less intuitive than this:
	if (cycle_corr_active(oper->cycle_time_correction)) {
    		oper->cycle_end_time = new_base_time;
    		end_time = new_base_time;

And this:
	if (!oper || should_change_sched(oper))
	   	switch_schedules(q, &admin, &oper);

reads clearer than:
	if (!oper || cycle_corr_active(oper->cycle_time_correction))
		switch_schedules(q, &admin, &oper);


Normally I prefer clear function names that don't need comments for 
explanation. But I probably overthink it, seems to have more cons than 
pros. Will replace with a single sched_change_pending() as suggested, thanks.


>> +	}
>>   
>> -	next_base_time = sched_base_time(admin);
>> +	return change_to_admin_sched;
>> +}
>>   
>> -	/* This is the simple case, the end_time would fall after
>> -	 * the next schedule base_time.
>> -	 */
>> -	if (ktime_compare(next_base_time, end_time) <= 0)
>> +static bool should_extend_cycle(const struct sched_gate_list *oper,
>> +				ktime_t new_base_time,
>> +				ktime_t entry_end_time,
>> +				const struct sched_entry *entry)
>> +{
>> +	ktime_t next_cycle_end_time = ktime_add_ns(oper->cycle_end_time,
>> +						   oper->cycle_time);
>> +	bool extension_supported = oper->cycle_time_extension > 0 ? true : false;
> 
> "? true : false" is redundant. Just "extension_supported = oper->cycle_time_extension > 0"
> is enough.

Ooops sorry for this blunder. Will change.

>> +	s64 extension_limit = oper->cycle_time_extension;
>> +
>> +	if (extension_supported &&
>> +	    list_is_last(&entry->list, &oper->entries) &&
>> +	    ktime_before(new_base_time, next_cycle_end_time) &&
>> +	    ktime_sub(new_base_time, entry_end_time) < extension_limit)
>>   		return true;
>> +	else
>> +		return false;
> 
> Style nitpick:
> 
> 	return extension_supported &&
> 	       list_is_last(&entry->list, &oper->entries) &&
> 	       ktime_before(new_base_time, next_cycle_end_time) &&
> 	       ktime_sub(new_base_time, entry_end_time) < extension_limit;
> 
>> +}
>>   
>> -	/* This is the cycle_time_extension case, if the end_time
>> -	 * plus the amount that can be extended would fall after the
>> -	 * next schedule base_time, we can extend the current schedule
>> -	 * for that amount.
>> -	 */
>> -	extension_time = ktime_add_ns(end_time, oper->cycle_time_extension);
>> +static s64 get_cycle_time_correction(const struct sched_gate_list *oper,
>> +				     ktime_t new_base_time,
>> +				     ktime_t entry_end_time,
>> +				     const struct sched_entry *entry)
>> +{
>> +	s64 correction = INIT_CYCLE_TIME_CORRECTION;
>>   
>> -	/* FIXME: the IEEE 802.1Q-2018 Specification isn't clear about
>> -	 * how precisely the extension should be made. So after
>> -	 * conformance testing, this logic may change.
>> -	 */
>> -	if (ktime_compare(next_base_time, extension_time) <= 0)
>> -		return true;
>> +	if (!entry || !oper)
>> +		return correction;
> 
> This function is called as follows:
> 
> 	oper->cycle_time_correction = get_cycle_time_correction(oper, ...);
> 
> So, "oper" cannot be NULL if we dereference "oper" in the left hand side
> of the assignment and expect the kernel not to crash, no?
> 
> "entry" - assigned from the "next" variable in advance_sched() - should
> not be NULL either, from the way in which it is assigned.

My bad on the oper null check.
Will remove both.

>>   
>> -	return false;
>> +	if (ktime_compare(new_base_time, entry_end_time) <= 0) {
>> +		/* negative or zero correction */
> 
> At least for me, it would be helpful if you could transplant the
> explanation from the commit message ("The new admin base time starts
> earlier than the next entry's end time") into an expanded comment here.
> I am easily confused about the "ktime_compare(a, b) <= 0" construction.
> 
>> +		correction = ktime_sub(new_base_time, entry_end_time);
>> +	} else if (ktime_after(new_base_time, entry_end_time) &&
>> +		   should_extend_cycle(oper, new_base_time,
>> +				       entry_end_time, entry)) {
>> +		/* positive correction */
> 
> Same here - move the explanation from the commit message to the comment,
> please.

Will do.

> 
>> +		correction = ktime_sub(new_base_time, entry_end_time);
>> +	}
>> +
>> +	return correction;
>>   }
>>   
>>   static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>> @@ -942,10 +971,8 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   	admin = rcu_dereference_protected(q->admin_sched,
>>   					  lockdep_is_held(&q->current_entry_lock));
>>   
>> -	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
>> -		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>> +	if (!oper || should_change_sched(oper))
>>   		switch_schedules(q, &admin, &oper);
>> -	}
>>   
>>   	/* This can happen in two cases: 1. this is the very first run
>>   	 * of this function (i.e. we weren't running any schedule
>> @@ -972,6 +999,22 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   	end_time = ktime_add_ns(entry->end_time, next->interval);
>>   	end_time = min_t(ktime_t, end_time, oper->cycle_end_time);
>>   
>> +	if (admin) {
>> +		ktime_t new_base_time = sched_base_time(admin);
>> +
>> +		oper->cycle_time_correction =
>> +			get_cycle_time_correction(oper, new_base_time,
>> +						  end_time, next);
>> +
>> +		if (cycle_corr_active(oper->cycle_time_correction)) {
>> +			/* The next entry is the last entry we will run from
>> +			 * oper, subsequent ones will take from the new admin
>> +			 */
>> +			oper->cycle_end_time = new_base_time;
>> +			end_time = new_base_time;
>> +		}
>> +	}
>> +
>>   	for (tc = 0; tc < num_tc; tc++) {
>>   		if (next->gate_duration[tc] == oper->cycle_time)
>>   			next->gate_close_time[tc] = KTIME_MAX;
>> @@ -980,14 +1023,6 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   								 next->gate_duration[tc]);
>>   	}
>>   
>> -	if (should_change_schedules(admin, oper, end_time)) {
>> -		/* Set things so the next time this runs, the new
>> -		 * schedule runs.
>> -		 */
>> -		end_time = sched_base_time(admin);
>> -		oper->cycle_time_correction = 0;
>> -	}
>> -
>>   	next->end_time = end_time;
>>   	taprio_set_budgets(q, oper, next);
>>   
>> -- 
>> 2.25.1
>>
