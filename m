Return-Path: <linux-kernel+bounces-83218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D7869064
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A97B2521A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191913A871;
	Tue, 27 Feb 2024 12:24:12 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BC13A87C;
	Tue, 27 Feb 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036651; cv=none; b=olDd9VgBuwwj23NdWs250Q1koMC5JZyIedCHyQYdIXYIbX09DeCUQveSZPQWoquB7KikqH8zbbxrZITV32t8KiVmmKjqBRHnEzUC0FqNp9ZpySCLTwEqIdT7xk5LqxRKw4DYFRZe4nkpKuGmJYbzEL9NMSilqZJAyzWD43Q6ik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036651; c=relaxed/simple;
	bh=XmQNdGvAVl5AAkeFtTJFaS+zs3Qq10OsYrM3/rPz1Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gagOBYjpOYWVSvUme/dqAKdsvvtaE+IoNlYW9iVcNtBzKbquSzse/kHZESZAhiyI2D4z8IdFve9Fc22vsK4ZZwWrPkUd6rGtUbv7jdIUtiWNFlQe4vZzAJCwCYeKQW8zuV1oiu+T/PMtvJ5RGbigMR9WXcWkjJovmTfBy31Fjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tkc3Y1XNHz1b15p;
	Tue, 27 Feb 2024 20:19:05 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D6701A016B;
	Tue, 27 Feb 2024 20:24:03 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 27 Feb
 2024 20:24:02 +0800
Message-ID: <0457e84d-0ea7-2c77-0098-49bcb4e43b71@huawei.com>
Date: Tue, 27 Feb 2024 20:24:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cpufreq: CPPC: Resolve the large frequency discrepancy
 from cpuinfo_cur_freq
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
CC: Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<rafael@kernel.org>, <sumitg@nvidia.com>, <zengheng4@huawei.com>,
	<yang@os.amperecomputing.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <lnocwcitdbmgcyhd2dlczgdlhtfw4pfot2br2i3hqscnvr3xgq@nuxlauxum3nr>
 <d0f47e9d-6a58-8b46-89be-b3182abb69f0@huawei.com> <ZZwAmqp6hcmMF8aN@arm.com>
 <6505bdcb-5a5f-cba6-483b-75c51414a9c6@huawei.com>
 <ZaaOQzCpBjmW71xf@e129154.nice.arm.com>
 <a84a9749-97a5-a207-dfd3-8322a5a992d9@huawei.com>
 <Zbyi40XtqbqXm0CL@e129154.nice.arm.com>
 <4f66c62e-b089-a125-5a8d-4a98d4181618@huawei.com>
 <ZcYEjMO7IhSaLAAF@e129154.nice.arm.com>
 <532d8a81-a42e-f818-332f-2d93acac1e26@huawei.com>
 <hzfmwbqhhsk7oz6l7pcokdedp3foqdkw7lqh6xjbx4k3erkscx@sjyqnchz7gnp>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <hzfmwbqhhsk7oz6l7pcokdedp3foqdkw7lqh6xjbx4k3erkscx@sjyqnchz7gnp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/2/21 0:11, Vanshidhar Konda 写道:
> On Mon, Feb 19, 2024 at 08:15:50PM +0800, lihuisong (C) wrote:
>>
>> 在 2024/2/9 18:55, Beata Michalska 写道:
>>> On Tue, Feb 06, 2024 at 04:02:15PM +0800, lihuisong (C) wrote:
>>>> 在 2024/2/2 16:08, Beata Michalska 写道:
>>>>> On Wed, Jan 17, 2024 at 05:18:40PM +0800, lihuisong (C) wrote:
>>>>>
>>>>> Hi ,
>>>>>
>>>>> Again, apologies for delay,
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> 在 2024/1/16 22:10, Beata Michalska 写道:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Apologies for jumping in so late....
>>>>>>>
>>>>>>> On Wed, Jan 10, 2024 at 03:09:48PM +0800, lihuisong (C) wrote:
>>>>>>>> Hi Ionela,
>>>>>>>>
>>>>>>>> 在 2024/1/8 22:03, Ionela Voinescu 写道:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Friday 05 Jan 2024 at 15:04:47 (+0800), lihuisong (C) wrote:
>>>>>>>>>> Hi Vanshi,
>>>>>>>>>>
>>>>>>>>>> 在 2024/1/5 8:48, Vanshidhar Konda 写道:
>>>>>>>>>>> On Thu, Jan 04, 2024 at 05:36:51PM +0800, lihuisong (C) wrote:
>>>>>>>>>>>> 在 2024/1/4 1:53, Ionela Voinescu 写道:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tuesday 12 Dec 2023 at 15:26:17 (+0800), Huisong Li wrote:
>>>>>>>>>>>>>> Many developers found that the cpu current frequency is 
>>>>>>>>>>>>>> greater than
>>>>>>>>>>>>>> the maximum frequency of the platform, please see [1], 
>>>>>>>>>>>>>> [2] and [3].
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> In the scenarios with high memory access pressure, the 
>>>>>>>>>>>>>> patch [1] has
>>>>>>>>>>>>>> proved the significant latency of cpc_read() which is 
>>>>>>>>>>>>>> used to obtain
>>>>>>>>>>>>>> delivered and reference performance counter cause an 
>>>>>>>>>>>>>> absurd frequency.
>>>>>>>>>>>>>> The sampling interval for this counters is very critical and
>>>>>>>>>>>>>> is expected
>>>>>>>>>>>>>> to be equal. However, the different latency of cpc_read() 
>>>>>>>>>>>>>> has a direct
>>>>>>>>>>>>>> impact on their sampling interval.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Would this [1] alternative solution work for you?
>>>>>>>>>>>> It would work for me AFAICS.
>>>>>>>>>>>> Because the "arch_freq_scale" is also from AMU core and 
>>>>>>>>>>>> constant
>>>>>>>>>>>> counter, and read together.
>>>>>>>>>>>> But, from their discuss line, it seems that there are some 
>>>>>>>>>>>> tricky
>>>>>>>>>>>> points to clarify or consider.
>>>>>>>>>>> I think the changes in [1] would work better when CPUs may 
>>>>>>>>>>> be idle. With
>>>>>>>>>>> this
>>>>>>>>>>> patch we would have to wake any core that is in idle state 
>>>>>>>>>>> to read the
>>>>>>>>>>> AMU
>>>>>>>>>>> counters. Worst case, if core 0 is trying to read the CPU 
>>>>>>>>>>> frequency of
>>>>>>>>>>> all
>>>>>>>>>>> cores, it may need to wake up all the other cores to read 
>>>>>>>>>>> the AMU
>>>>>>>>>>> counters.
>>>>>>>>>>    From the approach in [1], if all CPUs (one or more cores) 
>>>>>>>>>> under one policy
>>>>>>>>>> are idle, they still cannot be obtained the CPU frequency, 
>>>>>>>>>> right?
>>>>>>>>>> In this case, the [1] API will return 0 and have to back to call
>>>>>>>>>> cpufreq_driver->get() for cpuinfo_cur_freq.
>>>>>>>>>> Then we still need to face the issue this patch mentioned.
>>>>>>>>> With the implementation at [1], arch_freq_get_on_cpu() will 
>>>>>>>>> not return 0
>>>>>>>>> for idle CPUs and the get() callback will not be called to 
>>>>>>>>> wake up the
>>>>>>>>> CPUs.
>>>>>>>> Right, arch_freq_get_on_cpu() will not return 0 for idle CPUs.
>>>>>>>> However, for no-housekeeping CPUs, it will return 0 and have to 
>>>>>>>> call get()
>>>>>>>> callback, right?
>>>>>>>>> Worst case, arch_freq_get_on_cpu() will return a frequency 
>>>>>>>>> based on the
>>>>>>>>> AMU counter values obtained on the last tick on that CPU. But 
>>>>>>>>> if that CPU
>>>>>>>>> is not a housekeeping CPU, a housekeeping CPU in the same 
>>>>>>>>> policy will be
>>>>>>>>> selected, as it would have had a more recent tick, and 
>>>>>>>>> therefore a more
>>>>>>>>> recent frequency value for the domain.
>>>>>>>> But this frequency is from the last tick,
>>>>>>>> this last tick is probably a long time ago and it doesn't update
>>>>>>>> 'arch_freq_scale' for some reasons like CPU dile.
>>>>>>>> In addition, I'm not sure if there is possible that 
>>>>>>>> amu_scale_freq_tick() is
>>>>>>>> executed delayed under high stress case.
>>>>>>>> It also have an impact on the accuracy of the cpu frequency we 
>>>>>>>> query.
>>>>>>>>> I understand that the frequency returned here will not be up 
>>>>>>>>> to date,
>>>>>>>>> but there's no proper frequency feedback for an idle CPU. If 
>>>>>>>>> one only
>>>>>>>>> wakes up a CPU to sample counters, before the CPU goes back to 
>>>>>>>>> sleep,
>>>>>>>>> the obtained frequency feedback is meaningless.
>>>>>>>>>
>>>>>>>>>>> For systems with 128 cores or more, this could be very 
>>>>>>>>>>> expensive and
>>>>>>>>>>> happen
>>>>>>>>>>> very frequently.
>>>>>>>>>>>
>>>>>>>>>>> AFAICS, the approach in [1] would avoid this cost.
>>>>>>>>>> But the CPU frequency is just an average value for the last 
>>>>>>>>>> tick period
>>>>>>>>>> instead of the current one the CPU actually runs at.
>>>>>>>>>> In addition, there are some conditions to use 
>>>>>>>>>> 'arch_freq_scale' in this
>>>>>>>>>> approach.
>>>>>>>>> What are the conditions you are referring to?
>>>>>>>> It depends on the housekeeping CPUs.
>>>>>>>>>> So I'm not sure if this approach can entirely cover the 
>>>>>>>>>> frequency
>>>>>>>>>> discrepancy issue.
>>>>>>>>> Unfortunately there is no perfect frequency feedback. By the 
>>>>>>>>> time you
>>>>>>>>> observe/use the value of scaling_cur_freq/cpuinfo_cur_freq, 
>>>>>>>>> the frequency
>>>>>>>>> of the CPU might have already changed. Therefore, an average 
>>>>>>>>> value might
>>>>>>>>> be a better indication of the recent performance level of a CPU.
>>>>>>>> An average value for CPU frequency is ok. It may be better if 
>>>>>>>> it has not any
>>>>>>>> delaying.
>>>>>>>>
>>>>>>>> The original implementation for cpuinfo_cur_freq can more 
>>>>>>>> reflect their
>>>>>>>> meaning in the user-guide [1]. The user-guide said:
>>>>>>>> "cpuinfo_cur_freq : Current frequency of the CPU as obtained 
>>>>>>>> from the
>>>>>>>> hardware, in KHz.
>>>>>>>> This is the frequency the CPU actually runs at."
>>>>>>>>
>>>>>>>>
>>>>>>>> [1]https://www.kernel.org/doc/Documentation/cpu-freq/user-guide.txt 
>>>>>>>>
>>>>>>>>
>>>>>>>>> Would you be able to test [1] on your platform and usecase?
>>>>>>>> I has tested it on my platform (CPU number: 64, SMT: off and 
>>>>>>>> CPU base
>>>>>>>> frequency: 2.7GHz).
>>>>>>>> Accoding to the testing result,
>>>>>>>> 1> I found that patch [1] and [2] cannot cover the no 
>>>>>>>> housekeeping CPUs.
>>>>>>>> They still have to face the large frequency discrepancy issue 
>>>>>>>> my patch
>>>>>>>> mentioned.
>>>>>>>> 2> Additionally, the frequency value of all CPUs are almost the 
>>>>>>>> same by
>>>>>>>> using the 'arch_freq_scale' factor way. I'm not sure if it is ok.
>>>>>>>>
>>>>>>>> The patch [1] has been modified silightly as below:
>>>>>>>> -->
>>>>>>>> @@ -1756,7 +1756,10 @@ static unsigned int
>>>>>>>> cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
>>>>>>>>    {
>>>>>>>>           unsigned int new_freq;
>>>>>>>>
>>>>>>>> -       new_freq = cpufreq_driver->get(policy->cpu);
>>>>>>>> +       new_freq = arch_freq_get_on_cpu(policy->cpu);
>>>>>>>> +       if (!new_freq)
>>>>>>>> +               new_freq = cpufreq_driver->get(policy->cpu);
>>>>>>>> +
>>>>>>> As pointed out this change will not make it to the next version 
>>>>>>> of the patch.
>>>>>>> So I'd say you can safely ignore it and assume that 
>>>>>>> arch_freq_get_on_cpu will
>>>>>>> only be wired for sysfs nodes for scaling_cur_freq/cpuinfo_cur_freq
>>>>>>>>           if (!new_freq)
>>>>>>>>                   return 0;
>>>>>>>>
>>>>>>>> And the result is as follows:
>>>>>>>> *case 1:**No setting the nohz_full and cpufreq use performance 
>>>>>>>> governor*
>>>>>>>> *--> Step1: *read 'cpuinfo_cur_freq' in no pressure
>>>>>>>>     0: 2699264     2: 2699264     4: 2699264     6: 2699264
>>>>>>>>     8: 2696628    10: 2696628    12: 2696628    14: 2699264
>>>>>>>>    16: 2699264    18: 2696628    20: 2699264    22: 2696628
>>>>>>>>    24: 2699264    26: 2696628    28: 2699264    30: 2696628
>>>>>>>>    32: 2696628    34: 2696628    36: 2696628    38: 2696628
>>>>>>>>    40: 2699264    42: 2699264    44: 2696628    46: 2696628
>>>>>>>>    48: 2696628    50: 2699264    52: 2699264    54: 2696628
>>>>>>>>    56: 2696628    58: 2696628    60: 2696628    62: 2696628
>>>>>>>>    64: 2696628    66: 2699264    68: 2696628    70: 2696628
>>>>>>>>    72: 2699264    74: 2696628    76: 2696628    78: 2699264
>>>>>>>>    80: 2696628    82: 2696628    84: 2699264    86: 2696628
>>>>>>>>    88: 2696628    90: 2696628    92: 2696628    94: 2699264
>>>>>>>>    96: 2696628    98: 2699264   100: 2699264   102: 2696628
>>>>>>>> 104: 2699264   106: 2699264   108: 2699264   110: 2696628
>>>>>>>> 112: 2699264   114: 2699264   116: 2699264   118: 2699264
>>>>>>>> 120: 2696628   122: 2699264   124: 2696628   126: 2699264
>>>>>>>> Note: the frequency of all CPUs are almost the same.
>>>>>>> Were you expecting smth else ?
>>>>>> The frequency of each CPU might have a different value.
>>>>>> All value of all CPUs is the same under high pressure.
>>>>>> I don't know what the phenomenon is on other platform.
>>>>>> Do you know who else tested it?
>>>>> So I might have rushed a bit with my previous comment/question: 
>>>>> apologies for
>>>>> that.
>>>>> The numbers above: those are on a fairly idle/lightly loaded 
>>>>> system right?
>>>> Yes.
>>>>> Would you mind having another go with just the arch_freq_get_on_cpu
>>>>> implementation beign added and dropping the changes in the cpufreq 
>>>>> and
>>>> All my tests are done when cpufreq policy is "performance" and OS 
>>>> isn't on a
>>>> high load.
>>>> Reading "scaling_cur_freq" or "scaling_cur_freq" for each physical 
>>>> core on
>>>> platform
>>>>
>>>> The testing result for "cpuinfo_cur_freq" with your changes on a 
>>>> fairly idle
>>>> and high loaded system can also be found in this thread.
>>>> *A: the result with your changes*
>>>> --> Reading "scaling_cur_freq"
>>>>   0: 2688720     2: 2696628     4: 2699264     6: 2696628
>>>>   8: 2699264    10: 2696628    12: 2699264    14: 2699264
>>>>  16: 2699264    18: 2696628    20: 2696628    22: 2696628
>>>>  24: 2699264    26: 2696628    28: 2696628    30: 2696628
>>>>  32: 2699264    34: 2691356    36: 2696628    38: 2699264
>>>>  40: 2699264    42: 2696628    44: 2696628    46: 2699264
>>>>  48: 2699264    50: 2696628    52: 2696628    54: 2696628
>>>>  56: 2696628    58: 2699264    60: 2691356    62: 2696628
>>>>  64: 2696628    66: 2696628    68: 2696628    70: 2696628
>>>>  72: 2696628    74: 2696628    76: 2699264    78: 2696628
>>>>  80: 2696628    82: 2696628    84: 2699264    86: 2696628
>>>>  88: 2625456    90: 2696628    92: 2699264    94: 2696628
>>>>  96: 2696628    98: 2696628   100: 2699264   102: 2699264
>>>> 104: 2699264   106: 2696628   108: 2699264   110: 2696628
>>>> 112: 2699264   114: 2699264   116: 2696628   118: 2696628
>>>> 120: 2696628   122: 2699264   124: 2696628   126: 2696628
>>>> -->Reading  "cpuinfo_cur_freq"
>>>>   0: 2696628     2: 2696628     4: 2699264     6: 2688720
>>>>   8: 2699264    10: 2700000    12: 2696628    14: 2698322
>>>>  16: 2699264    18: 2699264    20: 2696628    22: 2699264
>>>>  24: 2699264    26: 2699264    28: 2699264    30: 2699264
>>>>  32: 2699264    34: 2693992    36: 2696628    38: 2696628
>>>>  40: 2699264    42: 2699264    44: 2699264    46: 2696628
>>>>  48: 2696628    50: 2699264    52: 2696628    54: 2696628
>>>>  56: 2699264    58: 2699264    60: 2696628    62: 2699264
>>>>  64: 2696628    66: 2699264    68: 2696628    70: 2699264
>>>>  72: 2696628    74: 2696628    76: 2696628    78: 2693992
>>>>  80: 2696628    82: 2696628    84: 2696628    86: 2696628
>>>>  88: 2696628    90: 2699264    92: 2696628    94: 2699264
>>>>  96: 2699264    98: 2696628   100: 2699264   102: 2699264
>>>> 104: 2691356   106: 2699264   108: 2699264   110: 2699264
>>>> 112: 2699264   114: 2696628   116: 2699264   118: 2699264
>>>> 120: 2696628   122: 2696628   124: 2696628   126: 2696628
>>>>
>>>> *B: the result without your changes*
>>>> -->Reading "scaling_cur_freq"
>>>>   0: 2698245     2: 2706690     4: 2699649     6: 2702105
>>>>   8: 2704362    10: 2697993    12: 2701672    14: 2704362
>>>>  16: 2701052    18: 2701052    20: 2694385    22: 2699650
>>>>  24: 2706802    26: 2702389    28: 2698299    30: 2698299
>>>>  32: 2697333    34: 2697993    36: 2701337    38: 2699328
>>>>  40: 2700330    42: 2700330    44: 2698019    46: 2697697
>>>>  48: 2699659    50: 2701700    52: 2703401    54: 2701700
>>>>  56: 2704013    58: 2697658    60: 2695000    62: 2697666
>>>>  64: 2697902    66: 2701052    68: 2698245    70: 2695789
>>>>  72: 2701315    74: 2696655    76: 2693666    78: 2695317
>>>>  80: 2704912    82: 2699649    84: 2698245    86: 2695454
>>>>  88: 2697966    90: 2697959    92: 2699319    94: 2700680
>>>>  96: 2695317    98: 2698996   100: 2700000   102: 2700334
>>>> 104: 2701320   106: 2695065   108: 2700986   110: 2703960
>>>> 112: 2697635   114: 2704421   116: 2700680   118: 2702040
>>>> 120: 2700334   122: 2697993   124: 2700334   126: 2705351
>>>> -->Reading "cpuinfo_cur_freq"
>>>>   0: 2696853     2: 2695454     4: 2699649     6: 2706993
>>>>   8: 2706060    10: 2704362    12: 2704362    14: 2697658
>>>>  16: 2707719    18: 2697192    20: 2702456    22: 2699650
>>>>  24: 2705782    26: 2698299    28: 2703061    30: 2705802
>>>>  32: 2700000    34: 2700671    36: 2701337    38: 2697658
>>>>  40: 2700330    42: 2700330    44: 2699672    46: 2697697
>>>>  48: 2703061    50: 2696610    52: 2692542    54: 2704406
>>>>  56: 2695317    58: 2699331    60: 2698996    62: 2702675
>>>>  64: 2704912    66: 2703859    68: 2699649    70: 2698596
>>>>  72: 2703908    74: 2703355    76: 2697658    78: 2695317
>>>>  80: 2702105    82: 2707719    84: 2702105    86: 2699649
>>>>  88: 2697966    90: 2691525    92: 2701700    94: 2700680
>>>>  96: 2695317    98: 2698996   100: 2698666   102: 2700334
>>>> 104: 2690429   106: 2707590   108: 2700986   110: 2701320
>>>> 112: 2696283   114: 2692881   116: 2697627   118: 2704421
>>>> 120: 2698996   122: 2696321   124: 2696655   126: 2695000
>>>>
>>> So in both cases : whether you use arch_freq_get_on_cpu or not
>>> (so with and without the patch) you get roughly the same frequencies
>>> on all cores - or am I missing smth from the dump above ?
>> The changes in "with/without your changes" I said is your patch 
>> intruduced arch_freq_get_on_cpu.
>> I just test them according to your requesting.
>>> And those are reflecting max freq you have provided earlier (?)
>> I know it is an average frequency for the last tickfor using 
>> arch_freq_get_on_cpu.
>> I have no any doubt that the freq is maximum value on performance 
>> governor.
>> I just want to say the difference between having or not having your 
>> patch.
>> The frequency values of all cores from cpuinfo_cur_freq and
>> scaling_cur_freq are almost the same if use this arch_freq_get_on_cpu 
>> on my platform.
>> However, the frequency values of all cores are different if doesn't 
>> use this arch_freq_get_on_cpu and just use .get().
>>> Note that the arch_freq_get_on_cpu will return an average frequency for
>>> the last tick, so even if your system is roughly idle with your 
>>> performance
>>> governor those numbers make sense (some/most of the cores might be idle
>>> but you will see the last freq the core was running at before going 
>>> to idle).
>>> I do not think there is an agreement what should be shown for idle 
>>> core when
>>> querying their freq through sysfs. Showing last known freq makes 
>>> sense, even
>>> more than waking up core just to try to get one.
>> I'm not opposed to using frequency scale factor to get CPU frequency. 
>> But it better be okay.
>>>
>>> @Ionela: Please jump in if I got things wrong.
>>>
>>>>> then read 'scaling_cur_freq', doing several reads in some intervals ?
>>>> It seems that above phenomenon has not a lot to do with reading 
>>>> intervals.
>>>>> The change has been tested on RD-N2 model (Neoverse N2 ref platform),
>>>>> it has also been discussed here [1]
>>>> I doesn't get the testing result on this platform in its thread.
>>> It might be missing exact numbers but the conclusions should be here 
>>> [1]
>>>
>>>>>>>> *--> Step 2: *read 'cpuinfo_cur_freq' in the high memory access 
>>>>>>>> pressure.
>>>>>>>>     0: 2696628     2: 2696628     4: 2696628     6: 2696628
>>>>>>>>     8: 2696628    10: 2696628    12: 2696628    14: 2696628
>>>>>>>>    16: 2696628    18: 2696628    20: 2696628    22: 2696628
>>>>>>>>    24: 2696628    26: 2696628    28: 2696628    30: 2696628
>>>>>>>>    32: 2696628    34: 2696628    36: 2696628    38: 2696628
>>>>>>>>    40: 2696628    42: 2696628    44: 2696628    46: 2696628
>>>>>>>>    48: 2696628    50: 2696628    52: 2696628    54: 2696628
>>>>>>>>    56: 2696628    58: 2696628    60: 2696628    62: 2696628
>>>>>>>>    64: 2696628    66: 2696628    68: 2696628    70: 2696628
>>>>>>>>    72: 2696628    74: 2696628    76: 2696628    78: 2696628
>>>>>>>>    80: 2696628    82: 2696628    84: 2696628    86: 2696628
>>>>>>>>    88: 2696628    90: 2696628    92: 2696628    94: 2696628
>>>>>>>>    96: 2696628    98: 2696628   100: 2696628   102: 2696628
>>>>>>>> 104: 2696628   106: 2696628   108: 2696628   110: 2696628
>>>>>>>> 112: 2696628   114: 2696628   116: 2696628   118: 2696628
>>>>>>>> 120: 2696628   122: 2696628   124: 2696628   126: 2696628
>>>>>>>>
>>>>>>>> *Case 2: setting nohz_full and cpufreq use ondemand governor*
>>>>>>>> There is "isolcpus=1-10,41-50 nohz_full=1-10,41-50 
>>>>>>>> rcu_nocbs=1-10,41-50" in
>>>>>>>> /proc/cmdline.
>>>>>>> Right, so if I remember correctly nohz_full implies rcu_nocbs, 
>>>>>>> so no need to
>>>>>>> set that one.
>>>>>>> Now, afair, isolcpus will make the selected CPUs to disappear 
>>>>>>> from the
>>>>>>> schedulers view (no balancing, no migrating), so unless you 
>>>>>>> affine smth
>>>>>>> explicitly to those CPUs, you will not see much of an activity 
>>>>>>> there.
>>>>>> Correct.
>>>>>>> Need to double check though as it has been a while ...
>>>>>>>> *--> Step 1: *setting ondemand governor to all policy and query
>>>>>>>> 'cpuinfo_cur_freq' in no pressure case.
>>>>>>>> And the frequency of CPUs all are about 400MHz.
>>>>>>>> *--> Step 2:* read 'cpuinfo_cur_freq' in the high memory access 
>>>>>>>> pressure.
>>>>>>>> The high memory access pressure is from the command: "stress-ng 
>>>>>>>> -c 64
>>>>>>>> --cpu-load 100% --taskset 0-63"
>>>>>>> I'm not entirely convinced that this will affine to isolated 
>>>>>>> cpus, especially
>>>>>>> that the affinity mask spans all available cpus. If that is the 
>>>>>>> case, no wonder
>>>>>>> your isolated cpus are getting wasted being idle. But I would 
>>>>>>> have to double
>>>>>>> check how this is being handled.
>>>>>>>> The result:
>>>>>>>>    0: 2696628     1:  400000     2:  400000     3: 400909
>>>>>>>>    4:  400000     5:  400000     6:  400000     7: 400000
>>>>>>>>    8:  400000     9:  400000    10:  400600    11: 2696628
>>>>>>>> 12: 2696628    13: 2696628    14: 2696628    15: 2696628
>>>>>>>> 16: 2696628    17: 2696628    18: 2696628    19: 2696628
>>>>>>>> 20: 2696628    21: 2696628    22: 2696628    23: 2696628
>>>>>>>> 24: 2696628    25: 2696628    26: 2696628    27: 2696628
>>>>>>>> 28: 2696628    29: 2696628    30: 2696628    31: 2696628
>>>>>>>> 32: 2696628    33: 2696628    34: 2696628    35: 2696628
>>>>>>>> 36: 2696628    37: 2696628    38: 2696628    39: 2696628
>>>>>>>> 40: 2696628    41:  400000    42:  400000    43: 400000
>>>>>>>> 44:  400000    45:  398847    46:  400000    47: 400000
>>>>>>>> 48:  400000    49:  400000    50:  400000    51: 2696628
>>>>>>>> 52: 2696628    53: 2696628    54: 2696628    55: 2696628
>>>>>>>> 56: 2696628    57: 2696628    58: 2696628    59: 2696628
>>>>>>>> 60: 2696628    61: 2696628    62: 2696628    63: 2699264
>>>>>>>>
>>>>>>>> Note:
>>>>>>>> (1) The frequency of 1-10 and 41-50 CPUs work on the lowest 
>>>>>>>> frequency.
>>>>>>>>        It turned out that nohz full was already work.
>>>>>>>>        I guess that stress-ng cannot use the CPU in the range 
>>>>>>>> of nohz full.
>>>>>>>>        Because the CPU frequency will be increased to 2.7G by 
>>>>>>>> binding CPU to
>>>>>>>> other application.
>>>>>>>> (2) The frequency of the nohz full core is calculated by get() 
>>>>>>>> callback
>>>>>>>> according to ftrace.
>>>>>>> It is as there is no sched tick on those, and apparently there 
>>>>>>> is nothing
>>>>>>> running on them either.
>>>>>> Yes.
>>>>>> If we select your approach and the above phenomenon is normal,
>>>>>> the large frequency discrepancy issue can be resolved for CPUs 
>>>>>> with sched
>>>>>> tick by the way.
>>>>>> But the nohz full cores still have to face this issue. So this 
>>>>>> patch is also
>>>>>> needed.
>>>>>>
>>>>> Yes, nohz cores full have to be handled by the cpufreq driver.
>>>> Correct. So we still have to face the issue in this patch and push 
>>>> this
>>>> patch.
>>>> Beata, would you please review this patch?
>>> Just to clarify for my benefit (apologies but I do have to contex 
>>> switch
>>> pretty often these days): by reviewing this patch do you mean:
>>> 1) review your changes (if so I think there are few comments already 
>>> to be
>>> addressed, but I can try to have another look)
>> Currently, the main comments is that my patch will wake up CPU to get 
>> frequency.
>> BTW, the core's always been wakened up to get the frequency for FFH 
>> way in cppc_acpi. please see cpc_read_ffh().
>> So it may be acceptable. After all, we don't query CPU frequency very 
>> often.
>
> Today's implementation of cpc_read_ffh() wakes up the core to read AMU
> counters - this is far from ideal. According to the architecture
> specification the CPU_CYCLES and CNT_CYCLES counters in AMU do not
> increment when the core is in WFI or WFE. If we cache the value of the
> AMU counter before a PE goes idle, we may be able to avoid waking up a
> PE just to read the AMU counters. I'm wondering if it makes sense to
> cache the value in cpu_do_idle() and return this cached value if
> idle_cpu() returns true.
It just might be useful for the idle state from WFI, right?
What about other idle states?
it will be a little complex.

The 'cpuinfo_cur_freq' is feedback for CPU frequency, and we firstly 
need to ensure that its function is ok.
What's more, I guess that user don't query CPU frequency very often when 
OS system is in idle.
Because it is not the center of attention.
 From the point of view, it is acceptable to wake up the core to read 
AMU counters and fundamentally resolve this issue .
What do you think?
>
>> But your patch doesn't meet the non-housekeeping cpus.
>
> For non-housekeeping CPUs may be it is better to just invoke
> cpufreq->get() call?

Then we're still going to have this issue.

>
> Thanks,
> Vanshi
>
>>> 2) review changes for AMU-based arch_freq_get_on_cpu ?
>>>
>>> *note: I will still try to have a look at the non-housekeeping cpus 
>>> case
>> I am very much hope that this issue my patch mentioned can be 
>> resolved ASAP.
>> So what's your plan about non-housekeeping cpus case?
>>>
>>> ---
>>> [1] 
>>> https://lore.kernel.org/lkml/691d3eb2-cd93-f0fc-a7a4-2a8c0d44262c@nvidia.com/
>>> ---
>>>
>>> BR
>>> Beata
>>>>
>>>> /Huisong
>>> [...]
>>> .
> .

