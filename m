Return-Path: <linux-kernel+bounces-16989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 411848246EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501781C22327
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E2C25578;
	Thu,  4 Jan 2024 17:12:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5DE2556C;
	Thu,  4 Jan 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3805BC15;
	Thu,  4 Jan 2024 09:12:53 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E29513F64C;
	Thu,  4 Jan 2024 09:12:04 -0800 (PST)
Message-ID: <a42ae8dd-383c-43c0-88b4-101303d6f548@arm.com>
Date: Thu, 4 Jan 2024 18:11:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] OPP: Add API to update EM after adjustment of voltage
 for OPPs
To: Lukasz Luba <lukasz.luba@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, sboyd@kernel.org, nm@ti.com,
 linux-samsung-soc@vger.kernel.org, daniel.lezcano@linaro.org,
 rafael@kernel.org, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, xuewen.yan94@gmail.com, mhiramat@kernel.org,
 qyousef@layalina.io, wvw@google.com
References: <20231220110339.1065505-1-lukasz.luba@arm.com>
 <20231220110339.1065505-2-lukasz.luba@arm.com>
 <20231226051228.oe7rpgf34nwgr5ah@vireshk-i7>
 <9c1fa923-403f-4c98-b03e-37e467366284@arm.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <9c1fa923-403f-4c98-b03e-37e467366284@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/01/2024 11:38, Lukasz Luba wrote:
> Hi Viresh,
> 
> On 12/26/23 05:12, Viresh Kumar wrote:
>> On 20-12-23, 11:03, Lukasz Luba wrote:
>>> There are device drivers which can modify voltage values for OPPs. It
>>> could be due to the chip binning and those drivers have specific chip
>>> knowledge about this. This adjustment can happen after Energy Model is
>>> registered, thus EM can have stale data about power.
>>>
>>> Introduce new API function which can be used by device driver which
>>> adjusted the voltage for OPPs. The implementation takes care about
>>> calculating needed internal details in the new EM table ('cost' field).
>>> It plugs in the new EM table to the framework so other subsystems would
>>> use the correct data.
>>>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   drivers/opp/of.c       | 69 ++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/pm_opp.h |  6 ++++
>>>   2 files changed, 75 insertions(+)
>>>
>>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>>> index 81fa27599d58..992434c0b711 100644
>>> --- a/drivers/opp/of.c
>>> +++ b/drivers/opp/of.c
>>> @@ -1596,3 +1596,72 @@ int dev_pm_opp_of_register_em(struct device
>>> *dev, struct cpumask *cpus)
>>>       return ret;
>>>   }
>>>   EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
>>> +
>>> +/**
>>> + * dev_pm_opp_of_update_em() - Update Energy Model with new power
>>> values
>>> + * @dev        : Device for which an Energy Model has to be registered
>>> + *
>>> + * This uses the "dynamic-power-coefficient" devicetree property to
>>> calculate
>>> + * power values for EM. It uses the new adjusted voltage values
>>> known for OPPs
>>> + * which have changed after boot.
>>> + */
>>> +int dev_pm_opp_of_update_em(struct device *dev)
>>
>> I don't see anything OPP or OF related in this function, I don't think
>> it needs
>> to be part of the OPP core. You just want to reuse _get_power() I
>> guess, which
>> can be exported then.
>>
>> This should really be part of the EM core instead.
>>
> 
> Thank you for having a look at this. OK, that makes sense.
> When I finish the EM runtime modification core features and get them
> merged, I'll continue to work on this patch set. I'll try to follow
> your comment here and export that function (with a different name
> probably).

Just to make sure: If this is the case then you could also add
em_dev_compute_costs() with this new patch instead providing it with the
'Introduce runtime modifiable Energy Model' patch-set?

This would keep dev_pm_opp_of_update_em() and em_dev_compute_costs()
together. IIRC, all the other new EM interfaces you already use with
your 'modifiable EM' use case: '[PATCH v5 14/23] PM: EM: Support late
CPUs booting and capacity adjustment'.



