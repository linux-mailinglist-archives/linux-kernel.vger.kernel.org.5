Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C177EC1BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbjKOL4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343745AbjKOL4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:56:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AAD185;
        Wed, 15 Nov 2023 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049379; x=1731585379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L6qaJ3+rKPeVp+q5HB8PXSZDCg0Q2iPlZERycRqy9VA=;
  b=QoBVV7T2Wlv96tp0OvC35hxB3cm/f6r/x+YeQ2g5N2mjrSH+H8Uj3Qls
   hFB5diUYRWN/odNR5TYUfS5Tm73jX9vir9BS/+2b+r4kxYXEdxda+UqTw
   GDoXdA8c2N9B6p0gMxve4+nCoBF2E6p4EL+9FOiAA9C0Aw8d/S18EKyne
   d5opUjEfvfXkJJTm2j+z4UUsiIEgaIMf8m2E0Bmqr37S2AFOZtiEivA2z
   U4s51Jhm1F24EJex7hrqbJCfBG/827dMrz78e4YZKOwvegJUF+LTezevN
   shtOZIL6uNu1usY9rUMO6OfusNInFaHCQ9AsHqwziaTT8wlYe4uvmG36n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393720201"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393720201"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753481"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753481"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:56:15 -0800
Message-ID: <361e8a7a-ff82-4baf-9996-1a46994545ca@linux.intel.com>
Date:   Wed, 15 Nov 2023 19:56:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 5/7] net/sched: taprio: fix delayed switching to
 new schedule after timer expiry
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
 <20231107112023.676016-6-faizal.abdul.rahim@linux.intel.com>
 <20231109115052.xz2vhaknno6nycbo@skbuf>
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231109115052.xz2vhaknno6nycbo@skbuf>
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



On 9/11/2023 7:50 pm, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:21AM -0500, Faizal Rahim wrote:
>> If a new GCL is triggered and the new admin base time falls before the
>> expiry of advance_timer (current running entry from oper),
>> taprio_start_sched() resets the current advance_timer expiry to the
>> new admin base time. However, upon expiry, advance_sched() doesn't
>> immediately switch to the admin schedule. It continues running entries
>> from the old oper schedule, and only switches to the new admin schedule
>> much later. Ideally, if the advance_timer is shorten to align with the
>> new admin base time, when the timer expires, advance_sched() should
>> trigger switch_schedules() at the beginning.
>>
>> To resolve this issue, set the cycle_time_correction to a non-initialized
>> value in taprio_start_sched(). advance_sched() will use it to initiate
>> switch_schedules() at the beginning.
>>
>> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
> 
> Did the commit you blame really introduce this issue, or was it your
> rework to trigger switch_schedules() based on the correction?
> 

Ohh actually this issue happens even without my whole patch set.

>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   net/sched/sch_taprio.c | 21 ++++++++++++++++++---
>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index f18a5fe12f0c..01b114edec30 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -1379,14 +1379,19 @@ static void setup_first_end_time(struct taprio_sched *q,
>>   }
>>   
>>   static void taprio_start_sched(struct Qdisc *sch,
>> -			       ktime_t start, struct sched_gate_list *new)
>> +			       ktime_t new_base_time,
>> +			       struct sched_gate_list *new)
>>   {
>>   	struct taprio_sched *q = qdisc_priv(sch);
>> -	ktime_t expires;
>> +	struct sched_gate_list *oper = NULL;
>> +	ktime_t expires, start;
>>   
>>   	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
>>   		return;
>>   
>> +	oper = rcu_dereference_protected(q->oper_sched,
>> +					 lockdep_is_held(&q->current_entry_lock));
>> +
>>   	expires = hrtimer_get_expires(&q->advance_timer);
>>   	if (expires == 0)
>>   		expires = KTIME_MAX;
>> @@ -1395,7 +1400,17 @@ static void taprio_start_sched(struct Qdisc *sch,
>>   	 * reprogram it to the earliest one, so we change the admin
>>   	 * schedule to the operational one at the right time.
>>   	 */
>> -	start = min_t(ktime_t, start, expires);
>> +	start = min_t(ktime_t, new_base_time, expires);
>> +
>> +	if (expires != KTIME_MAX &&
>> +	    ktime_compare(start, new_base_time) == 0) {
>> +		/* Since timer was changed to align to the new admin schedule,
>> +		 * setting the variable below to a non-initialized value will
> 
> I find the wording "setting the variable below to a non-initialized value"
> confusing. 0 is non-initialized? You're talking about a value different
> than INIT_CYCLE_TIME_CORRECTION. What about "setting a specific cycle
> correction will indicate ..."?
> 

Sure

>> +		 * indicate to advance_sched() to call switch_schedules() after
>> +		 * this timer expires.
>> +		 */
>> +		oper->cycle_time_correction = 0;
> 
> Why 0 and not ktime_sub(new_base_time, oper->cycle_end_time)? Doesn't
> the precise correction value make a difference?
> 

Negative correction and its calculation is a separate problem handled in 
different patch.

My intention is to highlight a specific issue and address it with a single 
patch. The core problem stemmed from the new admin schedule not making an 
immediate transition in advance_sched().

I'll rework this patch to focus specifically on resolving this problem 
while gradually aligning with the overall series. Importantly, I won't be 
removing anything from this patch in the process.

Is that okay ?

>> +	}
>>   
>>   	hrtimer_start(&q->advance_timer, start, HRTIMER_MODE_ABS);
>>   }
>> -- 
>> 2.25.1
>>
> 
