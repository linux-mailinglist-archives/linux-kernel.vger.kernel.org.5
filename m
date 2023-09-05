Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92B792D52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjIESUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbjIESTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:19:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BACF9D;
        Tue,  5 Sep 2023 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693937946; x=1725473946;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OJSFhDmct7oPXZQb2l3WGeV9v9ga9tNiVzoHRU4k9cg=;
  b=mOOb4+FHtNblDOiLvctj+5dhs1b6fYT58hw+KafiqXEmE6gTMeSU5UJE
   xs63Q6ArHCzMATMmyLPslrZS4k4jKsaxLZidEmoSnr1qN4ZS1UX9eFqNN
   sw16KC/SPvCnRui49EGnrr9dFlb9zgdO4Rjh5r+Cvg+QY7saKRGk7rMTy
   WyaelmEktCOBC0dg5O7S2HQpmmhMk9ASSF4ZD4w/0aLRPTtq8UZRFoSNE
   xozbh2Yw+Wv1Lp5I9FyX7cLJyL4qfpvwR9zeAGoUDCoxT3Lhiqaz1WKro
   Rke3s4e+0w45/m54YJlxSXzgolVFgrhqfApAkzIpqZ4x9G3WnLQKfIhfK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361901615"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="361901615"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:17:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="717963958"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="717963958"
Received: from yjie-desk1.jf.intel.com (HELO [10.24.100.126]) ([10.24.100.126])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 11:17:56 -0700
Message-ID: <02d8a574-a07a-f595-aee2-13908df74e68@linux.intel.com>
Date:   Tue, 5 Sep 2023 11:17:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to
 minimum
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <001d01d9d3a7$71736f50$545a4df0$@telus.net>
 <CAJZ5v0g=TEY0+dL9AGh1cYNnwQ=L6G8CRxXVD0AyWsaK5aDsdA@mail.gmail.com>
 <9665af79-d439-e05a-5333-62f71a2ac55c@linux.intel.com>
 <2023082901-moonscape-album-b7cc@gregkh>
Content-Language: en-US
From:   Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <2023082901-moonscape-album-b7cc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,LOTS_OF_MONEY,MONEY_NOHTML,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/23 01:57, Greg KH wrote:
> On Mon, Aug 28, 2023 at 04:35:13PM -0700, Keyon Jie wrote:
>>
>>
>> On 8/22/23 04:46, Rafael J. Wysocki wrote:
>>> On Sun, Aug 20, 2023 at 10:46 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>>
>>>> The intel_pstate CPU frequency scaling driver does not
>>>> use policy->cur and it is 0.
>>>> When the CPU frequency is outdated arch_freq_get_on_cpu()
>>>> will default to the nominal clock frequency when its call to
>>>> cpufreq_quick_getpolicy_cur returns the never updated 0.
>>>> Thus, the listed frequency might be outside of currently
>>>> set limits. Some users are complaining about the high
>>>> reported frequency, albeit stale, when their system is
>>>> idle and/or it is above the reduced maximum they have set.
>>>>
>>>> This patch will maintain policy_cur for the intel_pstate
>>>> driver at the current minimum CPU frequency.
>>>>
>>>> Reported-by: Yang Jie <yang.jie@linux.intel.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
>>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>>      * v1 was a completely different approach, programming around
>>>>        the issue rather than fixing it at the source.
>>>>        reference:
>>>>        https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
>>>>      * v2 does not fix an issue with the intel_cpufreq CPU scaling
>>>>        driver (A.K.A. the intel_pstate driver in passive mode) and
>>>>        the schedutil CPU frequency scaling governor when HWP is enabled
>>>>        where limit changes are not reflected in the stale listed frequencies.
>>>>        A fix for that will be some future patch.
>>>>
>>>> ---
>>>>    drivers/cpufreq/intel_pstate.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>>> index 8ca2bce4341a..08284dee583a 100644
>>>> --- a/drivers/cpufreq/intel_pstate.c
>>>> +++ b/drivers/cpufreq/intel_pstate.c
>>>> @@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>>>                           intel_pstate_clear_update_util_hook(policy->cpu);
>>>>                   intel_pstate_hwp_set(policy->cpu);
>>>>           }
>>>> +       /* policy current is never updated with the intel_pstate driver
>>>> +        * but it is used as a stale frequency value. So, keep it within
>>>> +        * limits.
>>>> +        */
>>>> +       policy->cur = policy->min;
>>>>
>>>>           mutex_unlock(&intel_pstate_limits_lock);
>>>>
>>>> --
>>>
>>> Applied as 6.6 material, with some mailer-induced white space damage
>>> fixed and the new comment adjusted to the kernel coding style.
>>>
>>> Thanks!
>>
>> Hi Doug and Rafael,
>>
>> Thank you for making the fix happen.
>>
>> Hi Greg,
>>
>> Will this be picked to the stable linux-6.1.y and linux-6.4.y kernel, it
>> could benefit to users there.
> 
> Sure, when it hits Linus's tree, please follow the instructions in:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to get it merged.

Thank you Greg.

Hi Rafael,

As the issue happens from the 5.18 onward kernels, we need the fix to be 
picked for stable kernels after that, could you please help to add "Cc: 
stable@vger.kernel.org" in the sign-off area when you send it to the 
mainline?

Thank you,
~Keyon

> 
> thanks,
> 
> greg k-h
