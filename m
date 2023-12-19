Return-Path: <linux-kernel+bounces-4892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B2E818362
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D171CB22551
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769912B61;
	Tue, 19 Dec 2023 08:31:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031211739;
	Tue, 19 Dec 2023 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BAE41FB;
	Tue, 19 Dec 2023 00:32:00 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1ABB3F738;
	Tue, 19 Dec 2023 00:31:13 -0800 (PST)
Message-ID: <1ccd7a20-0479-46f7-a968-57a18f0c0152@arm.com>
Date: Tue, 19 Dec 2023 08:32:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/23] PM: EM: Use runtime modified EM for CPUs energy
 estimation in EAS
Content-Language: en-US
To: Xuewen Yan <xuewen.yan94@gmail.com>, Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-10-lukasz.luba@arm.com>
 <20231217175923.wxmfocgckpaytptb@airbuntu>
 <CAB8ipk_5TjUTrZ-nrGAwYMugLJFF72MvvRDzPJqaCayNwCm1wg@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_5TjUTrZ-nrGAwYMugLJFF72MvvRDzPJqaCayNwCm1wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Qais and Xuewen,

On 12/19/23 04:03, Xuewen Yan wrote:
> On Mon, Dec 18, 2023 at 1:59 AM Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 11/29/23 11:08, Lukasz Luba wrote:
>>> The new Energy Model (EM) supports runtime modification of the performance
>>> state table to better model the power used by the SoC. Use this new
>>> feature to improve energy estimation and therefore task placement in
>>> Energy Aware Scheduler (EAS).
>>
>> nit: you moved the code to use the new runtime em table instead of the one
>> parsed at boot.
>>
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   include/linux/energy_model.h | 16 ++++++++++++----
>>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>>> index 1e618e431cac..94a77a813724 100644
>>> --- a/include/linux/energy_model.h
>>> +++ b/include/linux/energy_model.h
>>> @@ -238,6 +238,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>>                                unsigned long max_util, unsigned long sum_util,
>>>                                unsigned long allowed_cpu_cap)
>>>   {
>>> +     struct em_perf_table *runtime_table;
>>>        unsigned long freq, scale_cpu;
>>>        struct em_perf_state *ps;
>>>        int cpu, i;
>>> @@ -255,7 +256,14 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>>         */
>>>        cpu = cpumask_first(to_cpumask(pd->cpus));
>>>        scale_cpu = arch_scale_cpu_capacity(cpu);
>>> -     ps = &pd->table[pd->nr_perf_states - 1];
>>> +
>>> +     /*
>>> +      * No rcu_read_lock() since it's already called by task scheduler.
>>> +      * The runtime_table is always there for CPUs, so we don't check.
>>> +      */
>>
>> WARN_ON(rcu_read_lock_held()) instead?
> 
> I agree, or SCHED_WARN_ON(!rcu_read_lock_held()) ?

I disagree here. This is a sched function in hot path and as comment
says:

-----------------------
  * This function must be used only for CPU devices. There is no validation,
  * i.e. if the EM is a CPU type and has cpumask allocated. It is called 
from
  * the scheduler code quite frequently and that is why there is not checks.
-----------------------

We don't have to put the checks or warnings everywhere in the kernel
functions. Especially hot one like this one.

As you might not notice, we don't even check if the pd->cpus is not NULL

Regards,
Lukasz

