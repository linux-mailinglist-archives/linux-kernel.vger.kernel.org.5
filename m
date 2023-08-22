Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95178783C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjHVI7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHVI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:59:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36965E70
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:58:34 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVNWc2JN6z1L9V8;
        Tue, 22 Aug 2023 16:57:00 +0800 (CST)
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 16:58:27 +0800
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <vschneid@redhat.com>, Phil Auld <pauld@redhat.com>,
        <vdonnefort@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, <xiafukun@huawei.com>,
        "Chenhui (Judy)" <judy.chenhui@huawei.com>, <tanghui20@huawei.com>
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com>
 <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <875y774wvp.ffs@tglx>
 <CAKfTPtAzTy4KPrBNRA4cMeTonxn5EKLEAg0b9iH5ecJkAMEStw@mail.gmail.com>
 <87pm5f2qm2.ffs@tglx>
 <CAKfTPtBSx7h1caR9g8wEK5GG2JMfSBRqSzLgjRUjrnp1Zc-ssg@mail.gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <6620fb0a-19c1-526c-77b9-61098f59256d@huawei.com>
Date:   Tue, 22 Aug 2023 16:58:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBSx7h1caR9g8wEK5GG2JMfSBRqSzLgjRUjrnp1Zc-ssg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+Cc other colleagues who are testing the modification Thomas gave)

Kindly ping

Does Thomas's modification look all right ? I can help to send the patch.
Also other colleagues from my department are doing some stress tests base on
this modification.

Thanks,
Xiongfeng

On 2023/6/29 16:30, Vincent Guittot wrote:
> On Thu, 29 Jun 2023 at 00:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Wed, Jun 28 2023 at 14:35, Vincent Guittot wrote:
>>> On Wed, 28 Jun 2023 at 14:03, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>> No, because this is fundamentally wrong.
>>>>
>>>> If the CPU is on the way out, then the scheduler hotplug machinery
>>>> has to handle the period timer so that the problem Xiongfeng analyzed
>>>> does not happen in the first place.
>>>
>>> But the hrtimer was enqueued before it starts to offline the cpu
>>
>> It does not really matter when it was enqueued. The important point is
>> that it was enqueued on that outgoing CPU for whatever reason.
>>
>>> Then, hrtimers_dead_cpu should take care of migrating the hrtimer out
>>> of the outgoing cpu but :
>>> - it must run on another target cpu to migrate the hrtimer.
>>> - it runs in the context of the caller which can be throttled.
>>
>> Sure. I completely understand the problem. The hrtimer hotplug callback
>> does not run because the task is stuck and waits for the timer to
>> expire. Circular dependency.
>>
>>>> sched_cpu_wait_empty() would be the obvious place to cleanup armed CFS
>>>> timers, but let me look into whether we can migrate hrtimers early in
>>>> general.
>>>
>>> but for that we must check if the timer is enqueued on the outgoing
>>> cpu and we then need to choose a target cpu.
>>
>> You're right. I somehow assumed that cfs knows where it queued stuff,
>> but obviously it does not.
> 
> scheduler doesn't know where hrtimer enqueues the timer
> 
>>
>> I think we can avoid all that by simply taking that user space task out
>> of the picture completely, which avoids debating whether there are other
>> possible weird conditions to consider alltogether.
> 
> yes, the offline sequence should not be impacted by the caller context
> 
>>
>> Something like the untested below should just work.
>>
>> Thanks,
>>
>>         tglx
>> ---
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1490,6 +1490,13 @@ static int cpu_down(unsigned int cpu, en
>>         return err;
>>  }
>>
>> +static long __cpu_device_down(void *arg)
>> +{
>> +       struct device *dev = arg;
>> +
>> +       return cpu_down(dev->id, CPUHP_OFFLINE);
>> +}
>> +
>>  /**
>>   * cpu_device_down - Bring down a cpu device
>>   * @dev: Pointer to the cpu device to offline
>> @@ -1502,7 +1509,12 @@ static int cpu_down(unsigned int cpu, en
>>   */
>>  int cpu_device_down(struct device *dev)
>>  {
>> -       return cpu_down(dev->id, CPUHP_OFFLINE);
>> +       unsigned int cpu = cpumask_any_but(cpu_online_mask, dev->id);
>> +
>> +       if (cpu >= nr_cpu_ids)
>> +               return -EBUSY;
>> +
>> +       return work_on_cpu(cpu, __cpu_device_down, dev);
> 
> The comment for work_on_cpu :
> 
>  * It is up to the caller to ensure that the cpu doesn't go offline.
>  * The caller must not hold any locks which would prevent @fn from completing.
> 
> make me wonder if this should be done only once the hotplug lock is
> taken so the selected cpu will not go offline
> 
>>  }
>>
>>  int remove_cpu(unsigned int cpu)
> .
> 
