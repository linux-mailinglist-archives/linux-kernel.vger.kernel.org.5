Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8467EDB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjKPGAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:00:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E61A3;
        Wed, 15 Nov 2023 21:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700114399; x=1731650399;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yqNTN5tjzfYsbL0Q7/p7O3csQ921ZhQxl4METIL5Alg=;
  b=GaQoFwMldnu4obuH8RT2ZKjkBt2eEeU+3RufbauC0C9K+8x7y+2AnXLF
   mutwGMgFT2GuA4M8x81yDm6xjaHt1OpTZg6mLLg04jikupFatKrcd8uh5
   aIe75uvAut0XicB9wAq9pTqokpHkK9jkTJ16LBrRZAP04LsNmChyXPx3+
   LcDU2QSlTFP7pIGUxRFBerss0Ou3nHyuYvu1vad63Dwo4EqF/99TgNF3w
   BvC/v9ULaVlkNFZ/S2nFqqL6PVmK5BjQ/BE2BbL5kx5kt3Dwdo+kEabz3
   hbdbldD/fzXdUzQTaj/u3X21L5ahvH67zu7bLfxxSDSvdtVWcaOtrogHL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="12578046"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="12578046"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758721355"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="758721355"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.215.144.23]) ([10.215.144.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:59:54 -0800
Message-ID: <51f1c4d7-6bc5-4ee8-bd6a-1a71b2dd5d5b@linux.intel.com>
Date:   Thu, 16 Nov 2023 13:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/7] net/sched: taprio: fix too early schedules
 switching
To:     Simon Horman <horms@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com>
 <20231107112023.676016-2-faizal.abdul.rahim@linux.intel.com>
 <20231112103112.GK705326@kernel.org>
Content-Language: en-US
From:   "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20231112103112.GK705326@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2023 6:31 pm, Simon Horman wrote:
> On Tue, Nov 07, 2023 at 06:20:17AM -0500, Faizal Rahim wrote:
>> In the current taprio code for dynamic schedule change,
>> admin/oper schedule switching happens immediately when
>> should_change_schedules() is true. Then the last entry of
>> the old admin schedule stops being valid anymore from
>> taprio_dequeue_from_txq’s perspective.
>>
>> To solve this, we have to delay the switch_schedules() call via
>> the new cycle_time_correction variable. The variable serves 2
>> purposes:
>> 1. Upon entering advance_sched(), if the value is set to a
>> non-initialized value, it indicates that we need to change
>> schedule.
>> 2. Store the cycle time correction value which will be used for
>> negative or positive correction.
>>
>> Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>> ---
>>   net/sched/sch_taprio.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
>> index 2e1949de4171..dee103647823 100644
>> --- a/net/sched/sch_taprio.c
>> +++ b/net/sched/sch_taprio.c
>> @@ -41,6 +41,7 @@ static struct static_key_false taprio_have_working_mqprio;
>>   #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
>>   #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
>>   #define TAPRIO_FLAGS_INVALID U32_MAX
>> +#define INIT_CYCLE_TIME_CORRECTION S64_MIN
>>   
>>   struct sched_entry {
>>   	/* Durations between this GCL entry and the GCL entry where the
>> @@ -75,6 +76,7 @@ struct sched_gate_list {
>>   	ktime_t cycle_end_time;
>>   	s64 cycle_time;
>>   	s64 cycle_time_extension;
>> +	s64 cycle_time_correction;
>>   	s64 base_time;
>>   };
>>   
>> @@ -940,8 +942,10 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>>   	admin = rcu_dereference_protected(q->admin_sched,
>>   					  lockdep_is_held(&q->current_entry_lock));
>>   
>> -	if (!oper)
>> +	if (!oper || oper->cycle_time_correction != INIT_CYCLE_TIME_CORRECTION) {
> 
> Hi Faizal,
> 
> The first condition above expects that oper may be NULL, but the line below
> dereferences it unconditionally. This doesn't seem correct, one way or the
> other.
> 

Thanks for pointing this out, sorry for this blunder.
Will update.

> As flagged by Smatch and Coccinelle.
> 
>> +		oper->cycle_time_correction = INIT_CYCLE_TIME_CORRECTION;
>>   		switch_schedules(q, &admin, &oper);
>> +	}
>>   
>>   	/* This can happen in two cases: 1. this is the very first run
>>   	 * of this function (i.e. we weren't running any schedule
> 
> ...
> 
