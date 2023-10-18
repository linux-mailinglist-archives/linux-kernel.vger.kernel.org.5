Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A47CD9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjJRKz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjJRJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:40:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F5FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:40:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9QkC1clCz15NY3;
        Wed, 18 Oct 2023 17:37:39 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 17:40:21 +0800
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <yu.c.chen@intel.com>,
        <gautham.shenoy@amd.com>, <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        <yangyicong@hisilicon.com>
Subject: Re: [PATCH v10 3/3] sched/fair: Use candidate prev/recent_used CPU if
 scanning failed for cluster wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <20231012121707.51368-1-yangyicong@huawei.com>
 <20231012121707.51368-4-yangyicong@huawei.com>
 <CAKfTPtAdtjZobtrf846kDzscAZTrFxw21SQJbbHU0Cw35vggEQ@mail.gmail.com>
 <33d8d0c1-da40-278b-5b84-ecb983ee9d34@huawei.com>
 <CAKfTPtD2b6Ky+fqZoCEs5oy+d_c3KLCwmSdSfusEKUwAKZ1R_g@mail.gmail.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <c82d8cb4-97eb-b5c5-36f4-d9477da045aa@huawei.com>
Date:   Wed, 18 Oct 2023 17:40:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtD2b6Ky+fqZoCEs5oy+d_c3KLCwmSdSfusEKUwAKZ1R_g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 23:23, Vincent Guittot wrote:
> On Mon, 16 Oct 2023 at 14:55, Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> Hi Vincent,
>>
>> On 2023/10/13 23:04, Vincent Guittot wrote:
>>> On Thu, 12 Oct 2023 at 14:19, Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>
>>>> Chen Yu reports a hackbench regression of cluster wakeup when
>>>> hackbench threads equal to the CPU number [1]. Analysis shows
>>>> it's because we wake up more on the target CPU even if the
>>>> prev_cpu is a good wakeup candidate and leads to the decrease
>>>> of the CPU utilization.
>>>>
>>>> Generally if the task's prev_cpu is idle we'll wake up the task
>>>> on it without scanning. On cluster machines we'll try to wake up
>>>> the task in the same cluster of the target for better cache
>>>> affinity, so if the prev_cpu is idle but not sharing the same
>>>> cluster with the target we'll still try to find an idle CPU within
>>>> the cluster. This will improve the performance at low loads on
>>>> cluster machines. But in the issue above, if the prev_cpu is idle
>>>> but not in the cluster with the target CPU, we'll try to scan an
>>>> idle one in the cluster. But since the system is busy, we're
>>>> likely to fail the scanning and use target instead, even if
>>>> the prev_cpu is idle. Then leads to the regression.
>>>>
>>>> This patch solves this in 2 steps:
>>>> o record the prev_cpu/recent_used_cpu if they're good wakeup
>>>>   candidates but not sharing the cluster with the target.
>>>> o on scanning failure use the prev_cpu/recent_used_cpu if
>>>>   they're still idle
>>>>
>>>> [1] https://lore.kernel.org/all/ZGzDLuVaHR1PAYDt@chenyu5-mobl1/
>>>> Reported-by: Chen Yu <yu.c.chen@intel.com>
>>>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>>>> ---
>>>>  kernel/sched/fair.c | 19 ++++++++++++++++++-
>>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 4039f9b348ec..f1d94668bd71 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7392,7 +7392,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>         bool has_idle_core = false;
>>>>         struct sched_domain *sd;
>>>>         unsigned long task_util, util_min, util_max;
>>>> -       int i, recent_used_cpu;
>>>> +       int i, recent_used_cpu, prev_aff = -1;
>>>>
>>>>         /*
>>>>          * On asymmetric system, update task utilization because we will check
>>>> @@ -7425,6 +7425,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>
>>>>                 if (cpus_share_resources(prev, target))
>>>>                         return prev;
>>>> +
>>>> +               prev_aff = prev;
>>>>         }
>>>>
>>>>         /*
>>>> @@ -7457,6 +7459,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>
>>>>                 if (cpus_share_resources(recent_used_cpu, target))
>>>>                         return recent_used_cpu;
>>>> +       } else {
>>>> +               recent_used_cpu = -1;
>>>>         }
>>>>
>>>>         /*
>>>> @@ -7497,6 +7501,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>         if ((unsigned)i < nr_cpumask_bits)
>>>>                 return i;
>>>>
>>>> +       /*
>>>> +        * For cluster machines which have lower sharing cache like L2 or
>>>> +        * LLC Tag, we tend to find an idle CPU in the target's cluster
>>>> +        * first. But prev_cpu or recent_used_cpu may also be a good candidate,
>>>> +        * use them if possible when no idle CPU found in select_idle_cpu().
>>>> +        */
>>>> +       if ((unsigned int)prev_aff < nr_cpumask_bits &&
>>>> +           (available_idle_cpu(prev_aff) || sched_idle_cpu(prev_aff)))
>>>
>>> Hasn't prev_aff (i.e. prev) been already tested as idle ?
>>>
>>>> +               return prev_aff;
>>>> +       if ((unsigned int)recent_used_cpu < nr_cpumask_bits &&
>>>> +           (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)))
>>>> +               return recent_used_cpu;
>>>
>>> same here
>>>
>>
>> It was thought that there maybe a small potential race window here that the prev/recent_used
>> CPU becoming non-idle after scanning, discussed in [1]. I think the check here won't be
>> expensive so added it here. It should be redundant and can be removed.
> 
> I agree that there is a race but the whole function
> select_idle_sibling() is made of possible races because by the time it
> selects a CPU this one can become non-idle. It would be good to have
> some figures showing that these redundant checks make a difference.
> 

Got it. Actually I see no difference for these two checks on my machine. So I would like
to remove this.

Thanks.

>>
>> [1] https://lore.kernel.org/all/ZIams6s+qShFWhfQ@BLR-5CG11610CF.amd.com/
>>
>> Thanks.
>>
>>>
>>>> +
>>>>         return target;
>>>>  }
>>>>
>>>> --
>>>> 2.24.0
>>>>
>>>
