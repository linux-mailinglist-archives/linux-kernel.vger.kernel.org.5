Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE6A7931EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbjIEWXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIEWXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:23:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB51D185;
        Tue,  5 Sep 2023 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693952622; x=1725488622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PZ8K/Y6fP2+GV/U6uh2DerdNLUjBinIKc22XgnQErp0=;
  b=O08x02vUr3X9Igtack++7Rxn8Lv52jtfz/1mlIiONX/OgRSyie/rxbdi
   XVtbcJm7PnlmdeybtsfBNgZOIluL8smG3T844lG1SqHSvvYvSZwntEmpb
   459SFn0y+Sm8tYtybZc/WniH2l/uxxcAQ8wmYIU1EGKMa8tBRdcZm9YiI
   x0D+hmHYxd7xzZswr8ztv/5bOuqpu+r9mMP2NnAFmDtLLR601glXmgW11
   mront3sBeL2KRu9l12PGVzgQD03rUssEsmEn7U1dfzJg2I+T/g6x7/lid
   HErD+62oplzKrTHQM4zbFeafX2D/Pm8wanusUdx1piiGUH2DhpeEA/Wly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443306960"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="443306960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 15:23:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734820249"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="734820249"
Received: from yjie-desk1.jf.intel.com (HELO [10.24.100.126]) ([10.24.100.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 15:23:41 -0700
Message-ID: <3b798806-d144-58a8-6fa3-e893299bc690@linux.intel.com>
Date:   Tue, 5 Sep 2023 15:23:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to
 minimum
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
 <02d8a574-a07a-f595-aee2-13908df74e68@linux.intel.com>
 <CAJZ5v0i4_PnCJGkkMzBMF9GX3N6LLNQdnuyX6nRzWHy_f9T=3A@mail.gmail.com>
From:   Keyon Jie <yang.jie@linux.intel.com>
In-Reply-To: <CAJZ5v0i4_PnCJGkkMzBMF9GX3N6LLNQdnuyX6nRzWHy_f9T=3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,LOTS_OF_MONEY,MONEY_NOHTML,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 11:30, Rafael J. Wysocki wrote:
> On Tue, Sep 5, 2023 at 8:17 PM Keyon Jie <yang.jie@linux.intel.com> wrote:
>>
>>
>>
>> On 8/29/23 01:57, Greg KH wrote:
>>> On Mon, Aug 28, 2023 at 04:35:13PM -0700, Keyon Jie wrote:
>>>>
>>>>
>>>> On 8/22/23 04:46, Rafael J. Wysocki wrote:
>>>>> On Sun, Aug 20, 2023 at 10:46 PM Doug Smythies <dsmythies@telus.net> wrote:
>>>>>>
>>>>>> The intel_pstate CPU frequency scaling driver does not
>>>>>> use policy->cur and it is 0.
>>>>>> When the CPU frequency is outdated arch_freq_get_on_cpu()
>>>>>> will default to the nominal clock frequency when its call to
>>>>>> cpufreq_quick_getpolicy_cur returns the never updated 0.
>>>>>> Thus, the listed frequency might be outside of currently
>>>>>> set limits. Some users are complaining about the high
>>>>>> reported frequency, albeit stale, when their system is
>>>>>> idle and/or it is above the reduced maximum they have set.
>>>>>>
>>>>>> This patch will maintain policy_cur for the intel_pstate
>>>>>> driver at the current minimum CPU frequency.
>>>>>>
>>>>>> Reported-by: Yang Jie <yang.jie@linux.intel.com>
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
>>>>>> Signed-off-by: Doug Smythies <dsmythies@telus.net>
>>>>>> ---
>>>>>>
>>>>>> v1 -> v2:
>>>>>>       * v1 was a completely different approach, programming around
>>>>>>         the issue rather than fixing it at the source.
>>>>>>         reference:
>>>>>>         https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
>>>>>>       * v2 does not fix an issue with the intel_cpufreq CPU scaling
>>>>>>         driver (A.K.A. the intel_pstate driver in passive mode) and
>>>>>>         the schedutil CPU frequency scaling governor when HWP is enabled
>>>>>>         where limit changes are not reflected in the stale listed frequencies.
>>>>>>         A fix for that will be some future patch.
>>>>>>
>>>>>> ---
>>>>>>     drivers/cpufreq/intel_pstate.c | 5 +++++
>>>>>>     1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>>>>> index 8ca2bce4341a..08284dee583a 100644
>>>>>> --- a/drivers/cpufreq/intel_pstate.c
>>>>>> +++ b/drivers/cpufreq/intel_pstate.c
>>>>>> @@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>>>>>>                            intel_pstate_clear_update_util_hook(policy->cpu);
>>>>>>                    intel_pstate_hwp_set(policy->cpu);
>>>>>>            }
>>>>>> +       /* policy current is never updated with the intel_pstate driver
>>>>>> +        * but it is used as a stale frequency value. So, keep it within
>>>>>> +        * limits.
>>>>>> +        */
>>>>>> +       policy->cur = policy->min;
>>>>>>
>>>>>>            mutex_unlock(&intel_pstate_limits_lock);
>>>>>>
>>>>>> --
>>>>>
>>>>> Applied as 6.6 material, with some mailer-induced white space damage
>>>>> fixed and the new comment adjusted to the kernel coding style.
>>>>>
>>>>> Thanks!
>>>>
>>>> Hi Doug and Rafael,
>>>>
>>>> Thank you for making the fix happen.
>>>>
>>>> Hi Greg,
>>>>
>>>> Will this be picked to the stable linux-6.1.y and linux-6.4.y kernel, it
>>>> could benefit to users there.
>>>
>>> Sure, when it hits Linus's tree, please follow the instructions in:
>>>       https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>> for how to get it merged.
>>
>> Thank you Greg.
>>
>> Hi Rafael,
>>
>> As the issue happens from the 5.18 onward kernels, we need the fix to be
>> picked for stable kernels after that, could you please help to add "Cc:
>> stable@vger.kernel.org" in the sign-off area when you send it to the
>> mainline?
> 
> It's already merged, as commit d51847acb018 ("cpufreq: intel_pstate:
> set stale CPU frequency to minimum").
> 
> Please feel free to send an inclusion request for it to stable@vger.kernel.org

Thank you Rafael, will do.

Thanks,
~Keyon

> 
> Thanks!
