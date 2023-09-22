Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA2F7AB400
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjIVOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:45:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41D2100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:44:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2CA4DA7;
        Fri, 22 Sep 2023 07:45:32 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC7F3F67D;
        Fri, 22 Sep 2023 07:44:53 -0700 (PDT)
Message-ID: <63713cac-605a-c647-baf7-b172c02f8336@arm.com>
Date:   Fri, 22 Sep 2023 16:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com, tim.c.chen@linux.intel.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
 <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
 <7c6dd2ec-b9a9-b364-5a29-05336127e519@linux.vnet.ibm.com>
 <xhsmhfs3fve7k.mognet@vschneid.remote.csb>
 <bd8a3c47-80f5-61f3-b884-85a7ee92767d@linux.vnet.ibm.com>
 <xhsmha5tjvfgm.mognet@vschneid.remote.csb>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <xhsmha5tjvfgm.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 14:22, Valentin Schneider wrote:
> On 15/09/23 23:40, Shrikanth Hegde wrote:
>> On 9/15/23 5:30 PM, Valentin Schneider wrote:
>>> On 14/09/23 23:26, Shrikanth Hegde wrote:
>>>> On 9/14/23 9:51 PM, Valentin Schneider wrote:
>>>>> On 13/09/23 17:18, Shrikanth Hegde wrote:
>>>>>> sysctl_sched_energy_aware is available for the admin to disable/enable
>>>>>> energy aware scheduling(EAS). EAS is enabled only if few conditions are
>>>>>> met by the platform. They are, asymmetric CPU capacity, no SMT,
>>>>>> valid cpufreq policy, frequency invariant load tracking. It is possible
>>>>>> platform when booting may not have EAS capability, but can do that after.
>>>>>> For example, changing/registering the cpufreq policy.
>>>>>>
>>>>>> At present, though platform doesn't support EAS, this sysctl is still
>>>>>> present and it ends up calling rebuild of sched domain on write to 1 and
>>>>>> NOP when writing to 0. That is confusing and un-necessary.
>>>>>>
>>>>>
>>>>
>>>> Hi Valentin, Thanks for taking a look at this patch.
>>>>
>>>>> But why would you write to it in the first place? Or do you mean to use
>>>>> this as an indicator for userspace that EAS is supported?
>>>>>
>>>>
>>>> Since this sysctl is present and its value being 1, it gives the
>>>> impression to the user that EAS is supported when it is not.
>>>> So its an attempt to correct that part.
>>>>
>>>
>>> Ah, I see. Then how about just making the sysctl return 0 when EAS isn't
>>> supported? And on top of it, prevent all writes when EAS isn't supported
>>> (perf domains cannot be built, so there would be no point in forcing a
>>> rebuild that will do nothing).
>>
>> Yes. That's another way. Thats what I had as possible approach in
>> https://lore.kernel.org/lkml/d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com/
>>
> 
> Thanks for the link; and apologies for bringing up topics that have been
> discussed already.
> 
>>
>>
>>>
>>> I can never remember how to properly use the sysctl API, so that's a very
>>> crude implementation, but something like so?
>>>
>>> ---
>>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 05a5bc678c089..dadfc5afc4121 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -230,9 +230,28 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
>>>   	if (write && !capable(CAP_SYS_ADMIN))
>>>   		return -EPERM;
>>>
>>> +	if (!sched_energy_enabled()) {
>>
>> Use of sched_energy_enabled won't work as Pierre has indicated.
>>
>> Instead this can be done by adding those checks in a helper function to
>> do similar checks as done build_perf_domains.
>>
>> I can send v4 with this approach if it makes more sense. Please let me know.
>>
> 
> So what I'm thinking is the standard approach seems to be to keep the knobs
> visible, but change how reads/writes to them are handled.
> 
> For instance, SMT support has
> 
>    /sys/devices/system/cpu/smt
>      /control
>      /active
> 
> And a system with CONFIG_HOTPLUG_SMT=y but no actual hardware SMT will
> have:
> 
>      /control = notsupported
>      /active  = 0


Having such interface for EAS would be ideal no ?
/active:
would be the equivalent of the current sysctl_sched_energy_aware

/control:
would show whether CONFIG_SCHED_DEBUG was set and all the conditions
to have EAS enabled are satisfied.

Possible states for SMT:
---
static const char *smt_states[] = {
	[CPU_SMT_ENABLED]		= "on",             // EAS possible and running
	[CPU_SMT_DISABLED]		= "off",            // EAS possible and not running
	[CPU_SMT_FORCE_DISABLED]	= "forceoff",       // not applicable for EAS
	[CPU_SMT_NOT_SUPPORTED]		= "notsupported",   // system with smt or not asymmetric or no freq invariance
	[CPU_SMT_NOT_IMPLEMENTED]	= "notimplemented", // CONFIG_SCHED_DEBUG=n
};
---


> 
> So IMO it would make sense to keep sched_energy_aware around, but make it
> read 0 and prevent writes for systems that have the software support
> compiled but don't have the actual hardware support.
> 
> In a pinch it also helps to know if CONFIG_ENERGY_MODEL was selected,
> though that's obvious enough with CONFIG_SCHED_DEBUG=y.
> 
