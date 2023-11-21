Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172767F233F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjKUBmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUBmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:42:00 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EA6C7;
        Mon, 20 Nov 2023 17:41:55 -0800 (PST)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SZ6TY5vHZzsRMW;
        Tue, 21 Nov 2023 09:38:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 Nov 2023 09:41:53 +0800
Message-ID: <50c05422-20f1-7bc1-d245-76723d8e0ae0@huawei.com>
Date:   Tue, 21 Nov 2023 09:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix CPU lowest Frequency bug when
 offline/online for passive
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <zhaowenhui8@huawei.com>
References: <20231107025838.2806500-1-ruanjinjie@huawei.com>
 <6c078e43-5dba-b980-5890-18c7b7cf7157@huawei.com>
 <CAJZ5v0hotAjpCOnGZLKsA+nhsRMX7hhE6ZxrPbWoc5qb8XD6BQ@mail.gmail.com>
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAJZ5v0hotAjpCOnGZLKsA+nhsRMX7hhE6ZxrPbWoc5qb8XD6BQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/21 1:16, Rafael J. Wysocki wrote:
> On Mon, Nov 13, 2023 at 7:18 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> Ping.
> 
> I see the problem, but I'm not sure if the approach taken in the patch
> is the best one, as it has side effects.

Could you please make it more clear, what are the side effects? I'm not
sure about the possible negative effects of the patch.

> 
>> On 2023/11/7 10:58, Jinjie Ruan wrote:
>>> There is a bug in passive mode for intel pstate when
>>> CONFIG_X86_INTEL_PSTATE = y and configure intel_pstate = passive in command
>>> line. On Ice Lake server, although the performance tuner is used, the CPU
>>> have the lowest frequency in scaling_cur_freq after the CPU goes offline and
>>> then goes online, running the same infinite loop load.
>>>
>>> How to reproduce:
>>>
>>> cat while_true.c
>>>       #include <stdio.h>
>>>       void main(void)
>>>       {
>>>               while(1);
>>>       }
>>>
>>> [root@localhost freq_test]# cat test.sh
>>>       #!/bin/bash
>>>
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_governor
>>>       taskset -c ${1} ./while_true &
>>>       sleep 1s
>>>
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>
>>>       echo 0 > /sys/devices/system/cpu/cpu${1}/online
>>>
>>>       sleep 1s
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>
>>>       sleep 1s
>>>
>>>       echo 1 > /sys/devices/system/cpu/cpu${1}/online
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>
>>>       taskset -c ${1} ./while_true &
>>>
>>>       sleep 1s
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>
>>>       sleep 1s
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>
>>>       sleep 1s
>>>       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
>>>
>>> The CPU frequency is adjusted to the minimum after offline and online:
>>>
>>> [root@localhost freq_test]# sh test.sh 20
>>>       2300000
>>>       performance
>>>       2299977
>>>       cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or
>>>       resource busy
>>>       800000
>>>       800000
>>>       800000
>>>       799992
>>> [root@localhost freq_test]# sh test.sh 21
>>>       2300000
>>>       performance
>>>       2300000
>>>       cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or
>>>       resource busy
>>>       800000
>>>       800000
>>>       800000
>>>       800000
>>>
>>> As in __cpufreq_driver_target(), the cpufreq core will not call intel
>>> cpufreq's target() callback if the target freq is equal with policy->cur
>>> and do not set CPUFREQ_NEED_UPDATE_LIMITS flag, but the hardware also not
>>> proactively keep CPU with the policy->cur frequency. So also set
>>> CPUFREQ_NEED_UPDATE_LIMITS for passive mode. After applying this patch,
>>> the CPU frequency is consistent as what performance tuner expected after
>>> CPU offline and online as below:
>>>
>>> [root@localhost freq_test]# sh test.sh 20
>>>       2300000
>>>       performance
>>>       2300000
>>>       cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or resource busy
>>>       2300000
>>>       2300000
>>>       2299977
>>>       2299977
>>> [root@localhost freq_test]# sh test.sh 21
>>>       2300000
>>>       performance
>>>       2300000
>>>       cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or resource busy
>>>       2300000
>>>       2300000
>>>       2300000
>>>       2300000
>>> [root@localhost freq_test]# cat /sys/devices/system/cpu/intel_pstate/status
>>>       passive
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  drivers/cpufreq/intel_pstate.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>> index a534a1f7f1ee..73403f1292b0 100644
>>> --- a/drivers/cpufreq/intel_pstate.c
>>> +++ b/drivers/cpufreq/intel_pstate.c
>>> @@ -3091,7 +3091,7 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
>>>  }
>>>
>>>  static struct cpufreq_driver intel_cpufreq = {
>>> -     .flags          = CPUFREQ_CONST_LOOPS,
>>> +     .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
>>>       .verify         = intel_cpufreq_verify_policy,
>>>       .target         = intel_cpufreq_target,
>>>       .fast_switch    = intel_cpufreq_fast_switch,
> 
