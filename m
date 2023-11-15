Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF807EC1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjKOL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbjKOL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:57:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652EA12C;
        Wed, 15 Nov 2023 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049424; x=1731585424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gU+Dv3Q+4CFNxj/wf+kPLc05Qtm3qrTvL9243w2RAPg=;
  b=R+B0I+WJ3lFeor5zE9DMvpVCa9lt1emn1YTizsnMy75D8g5pd68lMo2F
   vBbHW9jIOLQeM4Vpjo+JDjOeCfSqvU8zm3OhrxYtAZxtbrdDf3ifUnCsk
   toalAAPEQPL57qkDqyOqKfvt1f2Kff5VOW1OprnUTCbucZI//pDMiizeR
   I0Nb92/4ZUlz86biEKPeaojPAVT8VGZNj7xpcg3zqTrTKEsaPQMD+YTZ9
   npRQwVahLWPe3bZNsQOcHZwO66fWmNRLhT+VzD696i06IWrIoTtyfk3rF
   ks9yONZTdwAE93nkU77n1xiLnE3mKuA9Hw00VOGu5LsB2Odoc15TAlCW6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393720288"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393720288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753543"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753543"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:57:00 -0800
Message-ID: <e37c0ba6-292d-4afe-a563-a82691b1a8f3@linux.intel.com>
Date:   Wed, 15 Nov 2023 19:57:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 7/7] net/sched: taprio: enable cycle time
 adjustment for current entry
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
 <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-8-faizal.abdul.rahim@linux.intel.com>
 <20231109131840.wgfrzuk5kz4wtd2h@skbuf>
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231109131840.wgfrzuk5kz4wtd2h@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 9:18 pm, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:23AM -0500, Faizal Rahim wrote:
>> Handles cycle time adjustments for the current active entry
> 
> Use the imperative mood for commit messages, i.e. "handle".
> 
>> when new admin base time occurs quickly, either within the
>> current entry or the next one.
>>
>> Changes covers:
>> 1. Negative cycle correction or truncation
>> Occurs when the new admin base time falls before the expiry of the
>> current running entry.
>>
>> 2. Positive cycle correction or extension
>> Occurs when the new admin base time falls within the next entry,
>> and the current entry is the cycle's last entry. In this case, the
>> changes in taprio_start_sched() extends the schedule, preventing
>> old oper schedule from resuming and getting truncated in the next
>> advance_sched() call.
>>
>> 3. A new API, update_gate_close_time(), has been created to update
>> the gate_close_time of the current entry in the event of cycle
>> correction.
>>
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   net/sched/sch_taprio.c | 72 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 53 insertions(+), 19 deletions(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index c60e9e7ac193..56743754d42e 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -1379,41 +1379,75 @@ static void setup_first_end_time(struct taprio_sched *q,
>>   		rcu_assign_pointer(q->current_entry, NULL);
>>   }
>>   
>> +static void update_gate_close_time(struct sched_entry *current_entry,
>> +				   ktime_t new_end_time,
>> +				   int num_tc)
>> +{
>> +	int tc;
>> +
>> +	for (tc = 0; tc < num_tc; tc++) {
>> +		if (current_entry->gate_mask & BIT(tc))
>> +			current_entry->gate_close_time[tc] = new_end_time;
>> +	}
>> +}
>> +
>>   static void taprio_start_sched(struct Qdisc *sch,
>>   			       ktime_t new_base_time,
>> -			       struct sched_gate_list *new)
>> +			       struct sched_gate_list *admin)
>>   {
>>   	struct taprio_sched *q = qdisc_priv(sch);
>> +	ktime_t expires = hrtimer_get_expires(&q->advance_timer);
>> +	struct net_device *dev = qdisc_dev(q->root);
>> +	struct sched_entry *curr_entry = NULL;
>>   	struct sched_gate_list *oper = NULL;
>> -	ktime_t expires, start;
>>   
>>   	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
>>   		return;
>>   
>>   	oper = rcu_dereference_protected(q->oper_sched,
>>   					 lockdep_is_held(&q->current_entry_lock));
>> +	curr_entry = rcu_dereference_protected(q->current_entry,
>> +					       lockdep_is_held(&q->current_entry_lock));
>>   
>> -	expires = hrtimer_get_expires(&q->advance_timer);
>> -	if (expires == 0)
>> -		expires = KTIME_MAX;
>> +	if (hrtimer_active(&q->advance_timer)) {
>> +		oper->cycle_time_correction =
>> +			get_cycle_time_correction(oper, new_base_time,
>> +						  curr_entry->end_time,
>> +						  curr_entry);
>>   
>> -	/* If the new schedule starts before the next expiration, we
>> -	 * reprogram it to the earliest one, so we change the admin
>> -	 * schedule to the operational one at the right time.
>> -	 */
>> -	start = min_t(ktime_t, new_base_time, expires);
>> -
>> -	if (expires != KTIME_MAX &&
>> -	    ktime_compare(start, new_base_time) == 0) {
>> -		/* Since timer was changed to align to the new admin schedule,
>> -		 * setting the variable below to a non-initialized value will
>> -		 * indicate to advance_sched() to call switch_schedules() after
>> -		 * this timer expires.
> 
> I would appreciate not changing things that you've established in
> earlier changes. Try to keep stuff introduced earlier in a form that is
> as close as possible to the final form.
> 

Sorry for that, it occurred because I aimed to split a patch that 
specifically addressed a problem I identified, versus my entire patch set.

I'll keep that feedback in mind going forward.

>> +		if (cycle_corr_active(oper->cycle_time_correction)) {
>> +			/* This is the last entry we are running from oper,
>> +			 * subsequent entry will take from the new admin.
>> +			 */
>> +			ktime_t	now = taprio_get_time(q);
>> +			u64 gate_duration_left = ktime_sub(new_base_time, now);
> 
> What is special about "now" as a moment in time? Gate durations are
> calculated relative to the moment when the sched_entry begins.
> 

My reasoning behind using "now" is that, by the time taprio_start_sched() 
is called, "maybe" the entry has already run—up to 80% of its total 
duration, for example. So, if an extension is needed for this last entry, 
wouldn't it be more accurate to calculate the remaining 20% of the entry 
duration plus the duration to the new base time? That's the idea behind the 
calculation above.

In contrast, in the case of extension in `advance_sched()`, gate durations 
during correction are calculated using the full interval duration. This is 
because the entry hasn't run yet and will run for the entire interval 
duration. Hence, the logic in the code below makes sense for advance_sched():
      u64 new_gate_duration = next->interval + oper->cycle_time_correction;


Let me know what you think, my interpretation of what value gate_duration 
should be, in this scenario, could be wrong.


>> +			struct qdisc_size_table *stab =
>> +				rtnl_dereference(q->root->stab);
> 
> "q->root" is "sch".
> 
>> +			int num_tc = netdev_get_num_tc(dev);
> 
> It would be nice if you could pay some attention to the preferred
> variable declaration style, i.e. longer lines come first. If you cannot
> easily respect that, you could split the variable declarations from
> their initialization.
> 

Hmm, I usually try to follow that that reverse Christmas tree style, but in 
this scenario, ensuring the proper initialization value for the local 
variable seemed more important to me than adhering to that style.

I wasn't aware it was a set-in-stone kind of rule.
I'll make the change accordingly then.

>> +
>> +			oper->cycle_end_time = new_base_time;
>> +			curr_entry->end_time = new_base_time;
>> +			curr_entry->correction_active = true;
>> +
>> +			update_open_gate_duration(curr_entry, oper, num_tc,
>> +						  gate_duration_left);
> 
> Recalculating open gate durations with a cycle time correction seems
> very complicated, at least from this code path. What depends on this?
> The data path only looks at the gate_close_time. Can we get away with
> updating only the gate_close_time?
> 

Actually, it follows a similar logic to the earlier patches:
"net/sched: taprio: fix cycle time adjustment for next entry" and 
"net/sched: taprio: update impacted fields during cycle time adjustment." 
Those patches also involved recalculating gate duration with cycle time 
correction.

Skipping the update for max_open_gate_duration means max_sdu value will be 
incorrect. Neglecting gate_duration means entry->budget[tc] won't get the 
correct update. Both of these affect taprio_dequeue_from_txq() and 
taprio_enqueue().

By the way, weren't all these consequences part of your original concern in 
the comment back in v1?

The only difference in this patch is that it's handling the "current entry" 
instead of the "next entry" - like in advance_sched().

>> +			update_gate_close_time(curr_entry, new_base_time, num_tc);
>> +			taprio_update_queue_max_sdu(q, oper, stab);
>> +			taprio_set_budgets(q, oper, curr_entry);
> 
> There's a lot of duplication between the correction management from
> advance_sched() and the one from taprio_start_sched(). I wonder if some
> of it can go into a common function.
> 

Considered that, but it's not as doable as it seems.

I can't toss all of these into a single function and call it for both 
because there are some differences to navigate.
The common functions being called are taprio_update_queue_max_sdu(), 
update_open_gate_duration(), and taprio_set_budgets().
However, advance_sched() doesn't call update_gate_close_time(), and there 
are some differences in the order of where it's called in advance_sched().

Nevertheless, I'm all ears for suggestion on the common function.

>> +		}
>> +	}
>> +
>> +	if (!hrtimer_active(&q->advance_timer) ||
>> +	    cycle_corr_active(oper->cycle_time_correction)) {
>> +		/* Use new admin base time if :
>> +		 * 1. there's no active oper
>> +		 * 2. there's active oper and we will change to the new admin
>> +		 * schedule after the current entry from oper ends
>>   		 */
>> -		oper->cycle_time_correction = 0;
>> +		expires = new_base_time;
>>   	}
>>   
>> -	hrtimer_start(&q->advance_timer, start, HRTIMER_MODE_ABS);
>> +	hrtimer_start(&q->advance_timer, expires, HRTIMER_MODE_ABS);
>>   }
>>   
>>   static void taprio_set_picos_per_byte(struct net_device *dev,
>> -- 
>> 2.25.1
>>
> 
