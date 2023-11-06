Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B397E190E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjKFDES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFDER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:04:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC8B100;
        Sun,  5 Nov 2023 19:04:11 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SNx0d3fpBzPnvV;
        Mon,  6 Nov 2023 11:00:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 6 Nov 2023 11:03:34 +0800
Message-ID: <f1d7a59b-5f99-344a-15d3-0d1625923057@huawei.com>
Date:   Mon, 6 Nov 2023 11:03:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/5] cpufreq: intel_pstate: Add ->offline and ->online
 callbacks
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <4169555.5IIHXK4Dsd@kreacher> <2786976.RHVxHup3hB@kreacher>
 <a5105853-6b36-7221-0d06-e726d33492fb@huawei.com>
 <CAAYoRsUrun69UQmx1VR+0CcuM0oyQC-Sm6zAS-TETLdAyHo9Sw@mail.gmail.com>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAAYoRsUrun69UQmx1VR+0CcuM0oyQC-Sm6zAS-TETLdAyHo9Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/3 23:56, Doug Smythies wrote:
> On Fri, Nov 3, 2023 at 3:57 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>> On 2020/8/25 1:43, Rafael J. Wysocki wrote:
>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>
>>> Add ->offline and ->online driver callbacks to prepare for taking a
>>> CPU offline and to restore its working configuration when it goes
>>> back online, respectively, to avoid invoking the ->init callback on
>>> every CPU online which is quite a bit of unnecessary overhead.
>>>
>>> Define ->offline and ->online so that they can be used in the
>>> passive mode as well as in the active mode and because ->offline
>>> will do the majority of ->stop_cpu work, the passive mode does
>>> not need that callback any more, so drop it.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> -> v2: Typo fixes and changelog edits (Doug).
>>>
>>> ---
>>>  drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
>>>  1 file changed, 32 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>> index 3d18934fa975..98836ac299db 100644
>>> --- a/drivers/cpufreq/intel_pstate.c
>>> +++ b/drivers/cpufreq/intel_pstate.c
>>> @@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
>>>       return 0;
>>>  }
>>>
>>> -static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>> +static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
>>>  {
>>> +     pr_debug("CPU %d going offline\n", policy->cpu);
>>> +
>>> +     intel_pstate_exit_perf_limits(policy);
>>> +
>>> +     /*
>>> +      * If the CPU is an SMT thread and it goes offline with the performance
>>> +      * settings different from the minimum, it will prevent its sibling
>>> +      * from getting to lower performance levels, so force the minimum
>>> +      * performance on CPU offline to prevent that from happening.
>>> +      */
>>>       if (hwp_active)
>>>               intel_pstate_hwp_force_min_perf(policy->cpu);
>>>       else
>>>               intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
>>> +{
>>> +     pr_debug("CPU %d going online\n", policy->cpu);
>>> +
>>> +     intel_pstate_init_acpi_perf_limits(policy);
>>> +
>>> +     if (hwp_active)
>>> +             wrmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST,
>>> +                           all_cpu_data[policy->cpu]->hwp_req_cached);
>>> +
>>> +     return 0;
>>>  }
>>
>> On Ice Lake server, there seems a bug when CONFIG_X86_INTEL_PSTATE=y and
>> not configure intel_pstate=xxx in command line.
>>
>> Although the Performance tuner is used, the CPU have the lowest
>> frequency in scaling_cur_freq after the CPU goes offline and then goes
>> online, running the same infinite loop load.
>>
>> How to produce:
>>
>> echo performance > /sys/devices/system/cpu/cpu12/cpufreq/scaling_governor
>>
>> cat while_true.c
>> #include <stdio.h>
>> void main(void)
>> {
>>         while(1);
>> }
>>
>>
>> [root@localhost freq_test]# cat test.sh
>> #!/bin/bash
>>
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_governor
>> taskset -c ${1} ./while_true &
>> sleep 1s
>>
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>
>> echo 0 > /sys/devices/system/cpu/cpu${1}/online
>>
>> sleep 1s
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>
>> sleep 1s
>>
>> echo 1 > /sys/devices/system/cpu/cpu${1}/online
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>
>> taskset -c ${1} ./while_true &
>>
>> sleep 1s
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>
>> sleep 1s
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>
>> sleep 1s
>> cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>
>>
>> [root@localhost freq_test]# sh test.sh 40
>> 2300000
>> performance
>> 2299977
>> cat: /sys/devices/system/cpu/cpu40/cpufreq/scaling_cur_freq: Device or
>> resource busy
>> 2300000
>> 2300022
>> 2300000
>> 2299953
>> [root@localhost freq_test]# sh test.sh 50
>> 2300000
>> performance
>> 2300000
>> cat: /sys/devices/system/cpu/cpu50/cpufreq/scaling_cur_freq: Device or
>> resource busy
>> 2300000
>> 2299977
>> 2300022
>> 2299977
>> [root@localhost freq_test]# sh test.sh 20
>> 2300000
>> performance
>> 2299977
>> cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or
>> resource busy
>> 800000
>> 800000
>> 800000
>> 799992
>> [root@localhost freq_test]# sh test.sh 21
>> 2300000
>> performance
>> 2300000
>> cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or
>> resource busy
>> 800000
>> 800000
>> 800000
>> 800000
>>
>> [root@localhost freq_test]# cat
>> /sys/devices/system/cpu/cpu21/cpufreq/scaling_max_freq
>> 2300000
>> [root@localhost freq_test]# cat
>> /sys/devices/system/cpu/cpu21/cpufreq/scaling_min_freq
>> 800000
> 
> Hi,
> 
> I followed your "how to reproduce" notes exactly.
> So far, I have been unable to reproduce your issue.

It seems that this issue is platform-specific.

The following CPU family has the issue:

1、Products formerly Haswell

2、Model name:            Intel(R) Xeon(R) Platinum 8380 CPU @
2.30GHz(Ice Lake server)

But the following CPU family do not have the issue:

1、Model name:                         Intel(R) Xeon(R) CPU E5-2620 v2 @
2.10GHz

2、Model name:     Intel(R) Xeon(R) CPU E5-2698 v3 @ 2.30GHz

> 
> I am using kernel 6.6.
> My processor is:
> Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> 
> Results:
> root@s19:/home/doug/pstate# ./test.sh 8
> 800000
> performance
> 4799994
> cat: /sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq: Device or
> resource busy
> 4799999
> 4800000
> 4800001
> 4799996
> root@s19:/home/doug/pstate# ./test.sh 7
> 800000
> performance
> 4800001
> cat: /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq: Device or
> resource busy
> 4799967
> 4800028
> 4800006
> 4799997
> root@s19:/home/doug/pstate# ./test.sh 6
> 800000
> performance
> 4800001
> cat: /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq: Device or
> resource busy
> 4799983
> 4800001
> 4799993
> 4800002
> root@s19:/home/doug/pstate# ./test.sh 5
> 800000
> performance
> 4799990
> cat: /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq: Device or
> resource busy
> 4800006
> 4800002
> 4800011
> 4799980
> root@s19:/home/doug/pstate# ./test.sh 4
> 4799940
> performance
> 4799985
> cat: /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq: Device or
> resource busy
> 4799975
> 4799994
> 4799984
> 4799996
> root@s19:/home/doug/pstate# ./test.sh 3
> 4799986
> performance
> 4799990
> cat: /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq: Device or
> resource busy
> 4799976
> 4800015
> 4800000
> 4799995
> 
> ... Doug
> 
