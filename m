Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECE7EC1BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbjKOL4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbjKOL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:56:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0324F123;
        Wed, 15 Nov 2023 03:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700049402; x=1731585402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R0mXXm6p5XT6FEWcco9xQ+q5sm5FNZi/lrOuokDfPIc=;
  b=eWb8rl9OtUZZVvXTXmlmxxD2C9aHKr4f1FNKKHZ1O4d4yzRNdcZ0X5E3
   Fea0TF0Z0nSMqX6EiSWqlYcGAIinfsiyBMHkGUiuhqI4gGl0lXvwGtVGP
   vUTG6h8gg99u/BK8dyF+0G08ABisQ53nVC6m3MXivYbhyKQNUUOUkatqX
   pHh5OTNsoptgDV3Vmg5mXxJFQlYsUb6S6WUMUOBFQo01UAohzpG71Kg5g
   UDqiDgpOf1RcC2vDK3bM9kp3MhJxIWYyD7IrmMF27Bd1Xmc9yXzvpsQdR
   UHv6kcHUeL4Pvp2ljd2/bu8wZbXjuggmJbL/rm8hibM74PhaARGmMXzWG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="393720233"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="393720233"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="908753522"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="908753522"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.214.157.166]) ([10.214.157.166])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:56:38 -0800
Message-ID: <ee7624e7-02e0-4fee-b4ac-48e7c79cd221@linux.intel.com>
Date:   Wed, 15 Nov 2023 19:56:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 6/7] net/sched: taprio: fix q->current_entry is
 NULL before its expiry
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
 <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-7-faizal.abdul.rahim@linux.intel.com>
 <20231109115527.loaz76xp5wxwbqav@skbuf>
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231109115527.loaz76xp5wxwbqav@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 7:55 pm, Vladimir Oltean wrote:
> On Tue, Nov 07, 2023 at 06:20:22AM -0500, Faizal Rahim wrote:
>> Fix the issue of prematurely setting q->current_entry to NULL in the
>> setup_first_end_time() function when a new admin schedule arrives
>> while the oper schedule is still running but hasn't transitioned yet.
>> This premature setting causes problems because any reference to
>> q->current_entry, such as in taprio_dequeue(), will result in NULL
>> during this period, which is incorrect. q->current_entry should remain
>> valid until the currently running entry expires.
>>
>> To address this issue, only set q->current_entry to NULL when there is
>> no oper schedule currently running.
>>
>> Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
> 
> The "Fixes" tag represents the commit where the code started becoming a
> problem, not when the code that you're changing was first introduced.
> 
> I find it hard to believe that the problem was in commit 5a781ccbd19e
> ("tc: Add support for configuring the taprio scheduler"), because we
> didn't support admin -> oper dynamic schedules back then.
> 

My bad, will update accordingly.

>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   net/sched/sch_taprio.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index 01b114edec30..c60e9e7ac193 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -1375,7 +1375,8 @@ static void setup_first_end_time(struct taprio_sched *q,
>>   			first->gate_close_time[tc] = ktime_add_ns(base, first->gate_duration[tc]);
>>   	}
>>   
>> -	rcu_assign_pointer(q->current_entry, NULL);
>> +	if (!hrtimer_active(&q->advance_timer))
>> +		rcu_assign_pointer(q->current_entry, NULL);
>>   }
>>   
>>   static void taprio_start_sched(struct Qdisc *sch,
>> -- 
>> 2.25.1
>>
