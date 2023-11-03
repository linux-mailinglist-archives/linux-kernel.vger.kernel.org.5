Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AEA7E01F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjKCK43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjKCK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:56:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD68187;
        Fri,  3 Nov 2023 03:56:17 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMHjR1XVzzvQX3;
        Fri,  3 Nov 2023 18:56:11 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 18:56:14 +0800
Message-ID: <a5105853-6b36-7221-0d06-e726d33492fb@huawei.com>
Date:   Fri, 3 Nov 2023 18:56:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/5] cpufreq: intel_pstate: Add ->offline and ->online
 callbacks
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
References: <4169555.5IIHXK4Dsd@kreacher> <2786976.RHVxHup3hB@kreacher>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2786976.RHVxHup3hB@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/25 1:43, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Add ->offline and ->online driver callbacks to prepare for taking a
> CPU offline and to restore its working configuration when it goes
> back online, respectively, to avoid invoking the ->init callback on
> every CPU online which is quite a bit of unnecessary overhead.
> 
> Define ->offline and ->online so that they can be used in the
> passive mode as well as in the active mode and because ->offline
> will do the majority of ->stop_cpu work, the passive mode does
> not need that callback any more, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Typo fixes and changelog edits (Doug).
> 
> ---
>  drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3d18934fa975..98836ac299db 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
>  	return 0;
>  }
>  
> -static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
> +static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
>  {
> +	pr_debug("CPU %d going offline\n", policy->cpu);
> +
> +	intel_pstate_exit_perf_limits(policy);
> +
> +	/*
> +	 * If the CPU is an SMT thread and it goes offline with the performance
> +	 * settings different from the minimum, it will prevent its sibling
> +	 * from getting to lower performance levels, so force the minimum
> +	 * performance on CPU offline to prevent that from happening.
> +	 */
>  	if (hwp_active)
>  		intel_pstate_hwp_force_min_perf(policy->cpu);
>  	else
>  		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
> +
> +	return 0;
> +}
> +
> +static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
> +{
> +	pr_debug("CPU %d going online\n", policy->cpu);
> +
> +	intel_pstate_init_acpi_perf_limits(policy);
> +
> +	if (hwp_active)
> +		wrmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST,
> +			      all_cpu_data[policy->cpu]->hwp_req_cached);
> +
> +	return 0;
>  }

On Ice Lake server, there seems a bug when CONFIG_X86_INTEL_PSTATE=y and
not configure intel_pstate=xxx in command line.

Although the Performance tuner is used, the CPU have the lowest
frequency in scaling_cur_freq after the CPU goes offline and then goes
online, running the same infinite loop load.

How to produce:

echo performance > /sys/devices/system/cpu/cpu12/cpufreq/scaling_governor

cat while_true.c
#include <stdio.h>
void main(void)
{
        while(1);
}


[root@localhost freq_test]# cat test.sh
#!/bin/bash

cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_governor
taskset -c ${1} ./while_true &
sleep 1s

cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq

echo 0 > /sys/devices/system/cpu/cpu${1}/online

sleep 1s
cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq

sleep 1s

echo 1 > /sys/devices/system/cpu/cpu${1}/online
cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq

taskset -c ${1} ./while_true &

sleep 1s
cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq

sleep 1s
cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq

sleep 1s
cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq


[root@localhost freq_test]# sh test.sh 40
2300000
performance
2299977
cat: /sys/devices/system/cpu/cpu40/cpufreq/scaling_cur_freq: Device or
resource busy
2300000
2300022
2300000
2299953
[root@localhost freq_test]# sh test.sh 50
2300000
performance
2300000
cat: /sys/devices/system/cpu/cpu50/cpufreq/scaling_cur_freq: Device or
resource busy
2300000
2299977
2300022
2299977
[root@localhost freq_test]# sh test.sh 20
2300000
performance
2299977
cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or
resource busy
800000
800000
800000
799992
[root@localhost freq_test]# sh test.sh 21
2300000
performance
2300000
cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or
resource busy
800000
800000
800000
800000

[root@localhost freq_test]# cat
/sys/devices/system/cpu/cpu21/cpufreq/scaling_max_freq
2300000
[root@localhost freq_test]# cat
/sys/devices/system/cpu/cpu21/cpufreq/scaling_min_freq
800000

>  
>  static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
>  {
> -	pr_debug("CPU %d exiting\n", policy->cpu);
> +	pr_debug("CPU %d stopping\n", policy->cpu);
>  
>  	intel_pstate_clear_update_util_hook(policy->cpu);
>  	if (hwp_active)
>  		intel_pstate_hwp_save_state(policy);
> -
> -	intel_cpufreq_stop_cpu(policy);
>  }
>  
>  static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	intel_pstate_exit_perf_limits(policy);
> +	pr_debug("CPU %d exiting\n", policy->cpu);
>  
>  	policy->fast_switch_possible = false;
>  
> @@ -2398,6 +2421,8 @@ static struct cpufreq_driver intel_pstate = {
>  	.init		= intel_pstate_cpu_init,
>  	.exit		= intel_pstate_cpu_exit,
>  	.stop_cpu	= intel_pstate_stop_cpu,
> +	.offline	= intel_pstate_cpu_offline,
> +	.online		= intel_pstate_cpu_online,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_pstate",
>  };
> @@ -2652,7 +2677,8 @@ static struct cpufreq_driver intel_cpufreq = {
>  	.fast_switch	= intel_cpufreq_fast_switch,
>  	.init		= intel_cpufreq_cpu_init,
>  	.exit		= intel_cpufreq_cpu_exit,
> -	.stop_cpu	= intel_cpufreq_stop_cpu,
> +	.offline	= intel_pstate_cpu_offline,
> +	.online		= intel_pstate_cpu_online,
>  	.update_limits	= intel_pstate_update_limits,
>  	.name		= "intel_cpufreq",
>  };
