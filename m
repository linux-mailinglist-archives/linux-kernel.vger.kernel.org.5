Return-Path: <linux-kernel+bounces-16978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E98246C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DA1F22125
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D742555D;
	Thu,  4 Jan 2024 16:55:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6AD2231F;
	Thu,  4 Jan 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A241DC15;
	Thu,  4 Jan 2024 08:55:59 -0800 (PST)
Received: from [10.57.88.128] (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7932E3F64C;
	Thu,  4 Jan 2024 08:55:11 -0800 (PST)
Message-ID: <22c8d702-dc11-4e25-bb2d-0d29b0481991@arm.com>
Date: Thu, 4 Jan 2024 16:56:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, rafael@kernel.org,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <ff68662a-6206-4bea-9307-071a50b368f9@arm.com>
 <bf11d4a5-44e0-4e76-b795-dbbb2b338d12@arm.com>
 <52655f7d-4056-42eb-a3c4-1eb8e21ea259@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <52655f7d-4056-42eb-a3c4-1eb8e21ea259@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 16:30, Dietmar Eggemann wrote:
> On 20/12/2023 09:42, Lukasz Luba wrote:
>>
>>
>> On 12/12/23 18:50, Dietmar Eggemann wrote:
>>> On 29/11/2023 12:08, Lukasz Luba wrote:
> 
> [...]
> 
>>>> With this optimization, the em_cpu_energy() should run faster on the Big
>>>> CPU by 1.43x and on the Little CPU by 1.69x.
>>>
>>> Where are those precise numbers are coming from? Which platform was it?
>>
>> That was mainline big.Little board rockpi4 b w/ rockchip 3399, present
> 
> IMHO, you should mention the platform here so people don't wonder.
> 
>> quite a few commercial devices (e.g. chromebooks or plenty other seen in
>> DT). The numbers are from measuring the time it takes to run this
>> function em_cpu_cost() in a loop for mln of times. Thus, the instruction
>> cache and data cache should be hot, but the operation would impact the
>> different score.
> 
> [...]
> 
>>> Can you not keep the existing comment and only change:
>>>
>>> (a) that ps->cap id ps->performance in (2) and
>>>
>>> (b) that:
>>>
>>>             *             ps->power * cpu_max_freq   cpu_util
>>>             *   cpu_nrg = ------------------------ * ---------     (3)
>>>             *                    ps->freq            scale_cpu
>>>
>>>                           <---- (old) ps->cost --->
>>>
>>>       is now
>>>
>>>                   ps->power * cpu_max_freq       1
>>>       ps-> cost = ------------------------ * ----------
>>>                           ps->freq            scale_cpu
>>>
>>>                   <---- (old) ps->cost --->
>>>
>>> and (c) that (4) has changed to:
>>>
>>>            *   pd_nrg = ps->cost * \Sum cpu_util                   (4)
>>>
>>> which avoid the division?
>>>
>>> Less changes is always much nicer since it makes it so much easier to
>>> detect history and review changes.
>>
>> I'm open to change that, but I will have to contact you offline
>> what you mean. This comment section in code is really tricky to
>> handle right.
> 
> OK, the changes you showed me offline LGTM.
> 
> [...]
> 

All good then. Thank you for the comments. I'll send v6.

