Return-Path: <linux-kernel+bounces-7973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1CB81AFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AF5288627
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B215AE7;
	Thu, 21 Dec 2023 08:03:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B49817992;
	Thu, 21 Dec 2023 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 344B82F4;
	Thu, 21 Dec 2023 00:03:58 -0800 (PST)
Received: from [10.57.87.53] (unknown [10.57.87.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BA4B3F738;
	Thu, 21 Dec 2023 00:03:10 -0800 (PST)
Message-ID: <fe2f856b-c9c4-41b9-b569-079657b05b79@arm.com>
Date: Thu, 21 Dec 2023 08:04:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] OPP: Add API to update EM after adjustment of voltage
 for OPPs
Content-Language: en-US
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org, viresh.kumar@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20231220110339.1065505-1-lukasz.luba@arm.com>
 <20231220110339.1065505-2-lukasz.luba@arm.com>
 <CAB8ipk9PQbS=bjZ8F8brCfdXOgz6HUT0on2K1ZDLAaOhV9OpZw@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk9PQbS=bjZ8F8brCfdXOgz6HUT0on2K1ZDLAaOhV9OpZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/21/23 07:28, Xuewen Yan wrote:
> On Wed, Dec 20, 2023 at 7:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> There are device drivers which can modify voltage values for OPPs. It
>> could be due to the chip binning and those drivers have specific chip
>> knowledge about this. This adjustment can happen after Energy Model is
>> registered, thus EM can have stale data about power.
>>
>> Introduce new API function which can be used by device driver which
>> adjusted the voltage for OPPs. The implementation takes care about
>> calculating needed internal details in the new EM table ('cost' field).
>> It plugs in the new EM table to the framework so other subsystems would
>> use the correct data.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/opp/of.c       | 69 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pm_opp.h |  6 ++++
>>   2 files changed, 75 insertions(+)
>>
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index 81fa27599d58..992434c0b711 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -1596,3 +1596,72 @@ int dev_pm_opp_of_register_em(struct device *dev, struct cpumask *cpus)
>>          return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
>> +
>> +/**
>> + * dev_pm_opp_of_update_em() - Update Energy Model with new power values
>> + * @dev                : Device for which an Energy Model has to be registered
>> + *
>> + * This uses the "dynamic-power-coefficient" devicetree property to calculate
>> + * power values for EM. It uses the new adjusted voltage values known for OPPs
>> + * which have changed after boot.
>> + */
>> +int dev_pm_opp_of_update_em(struct device *dev)
>> +{
>> +       struct em_perf_table __rcu *runtime_table;
>> +       struct em_perf_state *table, *new_table;
>> +       struct em_perf_domain *pd;
>> +       int ret, table_size, i;
>> +
>> +       if (IS_ERR_OR_NULL(dev))
>> +               return -EINVAL;
>> +
>> +       pd = em_pd_get(dev);
>> +       if (!pd) {
>> +               dev_warn(dev, "Couldn't find Energy Model %d\n", ret);
>> +               return -EINVAL;
>> +       }
>> +
>> +       runtime_table = em_allocate_table(pd);
>> +       if (!runtime_table) {
>> +               dev_warn(dev, "new EM allocation failed\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       new_table = runtime_table->state;
>> +
>> +       table = em_get_table(pd);
>> +       /* Initialize data based on older EM table */
>> +       table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
>> +       memcpy(new_table, table, table_size);
>> +
>> +       em_put_table();
>> +
>> +       /* Update power values which might change due to new voltage in OPPs */
>> +       for (i = 0; i < pd->nr_perf_states; i++) {
>> +               unsigned long freq = new_table[i].frequency;
>> +               unsigned long power;
>> +
>> +               ret = _get_power(dev, &power, &freq);
>> +               if (ret)
>> +                       goto failed;
> 
> Need we use the EM_SET_ACTIVE_POWER_CB(em_cb, _get_power) and call
> em_cb->active_power?
> 

No, not in this case. It's not like registration of EM, when there
is a need to also pass the callback function. As you can see this code
operates locally and the call _get_power() just simply gets the
power in straight way. Later the whole 'runtime_table' is passed to the
EM framework to 'swap' the pointers under RCU.

Thanks Xuewen for having a look at this!


