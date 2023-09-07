Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34593797B94
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbjIGSWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjIGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9719E92
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:21:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06704143D;
        Thu,  7 Sep 2023 03:34:53 -0700 (PDT)
Received: from [10.57.92.139] (unknown [10.57.92.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BE23F67D;
        Thu,  7 Sep 2023 03:34:11 -0700 (PDT)
Message-ID: <08e39be6-2815-4385-7703-7acc93f85c7f@arm.com>
Date:   Thu, 7 Sep 2023 12:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        peterz@infradead.org, mingo@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org, yu.c.chen@intel.com
References: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
 <b81e3d8f-88e3-e7b5-0dbc-78268193db7e@arm.com>
 <d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com>
Content-Language: en-US
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <d2c945d6-c4f0-a096-0623-731b11484f51@linux.vnet.ibm.com>
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

Hello Shrikanth,

On 9/6/23 13:35, Shrikanth Hegde wrote:
> 
> 
> On 9/5/23 7:33 PM, Pierre Gondois wrote:
>> Hello Shrikanth,
>> I tried the patch (on a platform using the cppc_cpufreq driver). The
>> platform
>> normally has EAS enabled, but the patch removed the sched_energy_aware
>> sysctl.
>> It seemed the following happened (in the below order):
>>
>> 1. sched_energy_aware_sysctl_init()
>> Doesn't set sysctl_sched_energy_aware as cpufreq_freq_invariance isn't set
>> and arch_scale_freq_invariant() returns false
>>
>> 2. cpufreq_register_driver()
>> Sets cpufreq_freq_invariance during cpufreq initialization
>> sched_energy_set()
>>
>> 3. sched_energy_set()
>> Is called with has_eas=0 since build_perf_domains() doesn't see the
>> platform
>> as EAS compatible. Indeed sysctl_sched_energy_aware=0.
>> So with sysctl_sched_energy_aware=0 and has_eas=0, sched_energy_aware
>> sysctl
>> is not enabled even though EAS should be possible.
>>
>>
>> On 9/1/23 08:52, Shrikanth Hegde wrote:
>>> Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
>>> some of the architectures. IIUC its meant to either force rebuild the
>>> perf domains or cleanup the perf domains by echoing 1 or 0 respectively.
>>
>> There is a definition of the sysctl at:
>> Documentation/admin-guide/sysctl/kernel.rst::sched_energy_aware
> [...]
>>>
>>>
>>> +static unsigned int sysctl_sched_energy_aware;
>>> +static struct ctl_table_header *sysctl_eas_header;
>>
>> The variables around the presence/absence of EAS are:
>> - sched_energy_present:
>> EAS is up and running
>>
>> - sysctl_sched_energy_aware:
>> The user wants to use EAS (or not). Doesn't mean EAS can run on the
>> platform.
>>
>> - sched_energy_set/partition_sched_domains_locked's "has_eas":
>> Local variable. Represent whether EAS can run on the platform.
>>
>> IMO it would be simpler to (un)register sched_energy_aware sysctl
>> in partition_sched_domains_locked(), based on the value of "has_eas".
>> This would allow to let all the logic as it is right now, inside
>> build_perf_domains(), and then advertise sched_energy_aware sysctl
>> if EAS can run on the platform.
>> sched_energy_aware_sysctl_init() would be deleted then.
>>
>>
> yes. that is true. and there is no variable which holds the info if the system
> is capable of EAS.
> 
> Retrospecting, the reason for starting this patch series was this,
> sysctl_sched_energy_aware didnt make sense on power10 platform since it
> has SMT and symmetric CPU capacities.  with current code writing 1 to
> it cause rebuild of sched domains but EAS wouldn't be possible.
> 
> 
> Possible Approaches:
> 
> 1.
> Make this sysctl write as NOP if the platform doesn't has EAS capabilities at
> the moment.  Do those checks in sched_energy_aware_handler before handling  the
> change in value. Return EINVAL.  And Update sysctl description that on such
> platforms value change is NOP. Relatively simpler change.
> 
> 2.
> Current patch approach, remove the sysctl completely on non supported
> architectures and re-enable it if the system becomes capable of doing EAS.
> With the current patch, instead of using sched_energy_update, use another
> variable called sched_energy_change_in_sysctl(maybe different name).  I think
> that would handle all the cases. Another variable can be avoided by encoding
> the info in sysctl_sched_energy_aware itself in the handler call, since it
> takes only 1 or 0 as the value. upper bits are free to use. update the sysctl
> as well with this behavior. plus minor cleanup to remove the init of sysctl.
> 

FWIW I think it makes more sense to remove the sysctl if EAS isn't possible on
the platform, as this patch intends to do.
 From a code perspective I m not sure I follow exactly your intend. I can test
your v3 if necessary,

Regards,
Pierre

