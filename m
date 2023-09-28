Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F17B1CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjI1MtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjI1MtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:49:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C5DE139;
        Thu, 28 Sep 2023 05:49:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EFDD1FB;
        Thu, 28 Sep 2023 05:49:55 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5283F5A1;
        Thu, 28 Sep 2023 05:49:15 -0700 (PDT)
Message-ID: <93262faa-7089-f2a2-3df7-058c338adfc6@arm.com>
Date:   Thu, 28 Sep 2023 14:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq
 driver
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        vschneid@redhat.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org
References: <20230918112937.493352-1-pierre.gondois@arm.com>
 <20230928071810.hkdmuoaasrv4b2oq@vireshk-i7>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230928071810.hkdmuoaasrv4b2oq@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh, Dietmar,

On 9/28/23 09:18, Viresh Kumar wrote:
> On 18-09-23, 13:29, Pierre Gondois wrote:
>> The Energy Aware Scheduler (EAS) relies on the schedutil governor.
>> When moving to/from the schedutil governor, sched domains must be
>> rebuilt to allow re-evaluating the enablement conditions of EAS.
>> This is done through sched_cpufreq_governor_change().
>>
>> Having a cpufreq governor assumes having a cpufreq driver running.
>> Inserting/removing a cpufreq driver should trigger a re-evaluation
>> of EAS enablement conditions, avoiding to see EAS enabled when
>> removing a running cpufreq driver.
>>
>> Add a sched_cpufreq_governor_change() call in cpufreq driver removal
>> path.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 60ed89000e82..0a4979c34fd1 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1673,6 +1673,8 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
>>   		cpufreq_driver->exit(policy);
>>   		policy->freq_table = NULL;
>>   	}
>> +
>> +	sched_cpufreq_governor_change(policy, policy->governor);
> 
> This is called from many paths. Consider using cpufreq_remove_dev() instead,
> before the policy is freed.

Another solution would be to call sched_cpufreq_governor_change()
from cpufreq_schedutil's init()/exit() callbacks. This would make
more sense as EAS/schedutil cpufreq are tightly bound, and it would
allow to cover all the possible paths.

When tried locally, it seems to cover all scenarios:
- insmod/rmmod a cpufreq driver
- changing the governor policy
- offlining all the CPUs of a pd

Dietmar:
The function would be static to cpufreq_schedutil, and the name can
be changed at the same time to (unless you think of a better name ?):
   static void sugov_check_eas_state(void);

Regards,
Pierre
