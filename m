Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C37AA4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjIUWNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjIUWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:13:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9256658F;
        Thu, 21 Sep 2023 15:04:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBADDA7;
        Thu, 21 Sep 2023 15:05:12 -0700 (PDT)
Received: from [192.168.178.106] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47E6C3F59C;
        Thu, 21 Sep 2023 15:04:34 -0700 (PDT)
Message-ID: <0f486d81-ec0f-22f0-a7cd-942da3288d6e@arm.com>
Date:   Fri, 22 Sep 2023 00:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Content-Language: en-US
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     vschneid@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230918112937.493352-1-pierre.gondois@arm.com>
 <ebc8f4cd-1ac6-e7c8-8e20-53bca964ce56@arm.com>
 <e25d912a-906d-82da-5b09-f2256ebfbfe3@arm.com>
 <0b3c7c1b-9905-cded-dc86-17296a10152a@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <0b3c7c1b-9905-cded-dc86-17296a10152a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 07:29, Shrikanth Hegde wrote:
> 
> On 9/19/23 1:19 PM, Pierre Gondois wrote:
>>
>> On 9/19/23 01:03, Dietmar Eggemann wrote:
>>> On 18/09/2023 13:29, Pierre Gondois wrote:

[...]

>>> Rebuilding SDs when inserting the driver is already covered by
>>>
>>>    cpufreq_online()
>>>      cpufreq_set_policy()
>>>        sched_cpufreq_governor_change()
>>>          if (old or new gov eq. schedutil)
>>>            schedule_work(&rebuild_sd_work)
>>>
>>> So what's missing is only a sched_cpufreq_governor_change() call when
>>> removing the driver, right?
>>
>> Yes exact, removing a cpufreq driver (e.g. `rmmod cppc_cpufreq.ko`) goes
>> through:
>> cpufreq_remove_dev()
>> \-__cpufreq_offline()
>>
>> so the path you mentioned is not used in this case.

But IMHO the name of sched_cpufreq_governor_change() is now misleading
when called from the driver removal path. It's not the governor which
has changed. We want to disable EAS when unloading the driver in (3):

 ...
 if (!arch_scale_freq_invariant()) {
  if (sched_debug()) {
   pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking
            not yet supported",
   cpumask_pr_args(cpu_map));
  }
  goto free;
 }
 ...

> One Doubt, while looking through code. Not well versed with this area. 
> 
> cpuhp_cpufreq_offline is being registered with CPU hotplug. That ends up 
> calling cpufreq_offline. This may cause non desired issues.
> 1. rebuild of sched domains twice instead, once by CPU hotplug and once by this.

That's possible when you CPU hp out the last CPU of a policy (or Perf
Domain (PD).

Otherwise `cpuhp_cpufreq_offline -> cpufreq_offline() ->
__cpufreq_offline()` returns early in `if (!policy_is_inactive(policy))`
condition.

partition_sched_domains_locked() does:

 (1) detach_destroy_domains()
 (2) build_sched_domains()
 (3) build_perf_domains()

But only the first workqueue event (from cpuset_hotplug_workfn or
rebuild_sd_workfn) will rebuild Sched Domains and PDs (1)-(3), the
second one will only build PDs (3) again.
That's not nice but AFAICS it is not functional incorrect.

> 2. offline/online of CPU (non-SMT) may not disabling EAS.

Can't see this issue right now. When we offline the last CPU of a PD on
a 2 PD system, EAS should be stopped since the root domain does not have
any asymmetric CPU capacities left and when we online it again, EAS
should be started (sched_energy_set()).
