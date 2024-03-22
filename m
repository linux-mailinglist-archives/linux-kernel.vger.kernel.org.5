Return-Path: <linux-kernel+bounces-111289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3386886A42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6489FB25AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF253A1DD;
	Fri, 22 Mar 2024 10:26:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FD6383B9;
	Fri, 22 Mar 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103199; cv=none; b=ugcTLSAxS/VZr9jCCYHDlHt8TjaYm6h82JNSABOewcPMumRUxe58KEUCcc/Ej88TSimrNxxqvCk4eQ+4b3GoXWb1iem/elp5L/ip8Klcza7MjtjSvv9z0Fg9/eif7RhKPkgB71TkBn8RFkX8NCsApXcbqdJj9hBPkoLjpeDoQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103199; c=relaxed/simple;
	bh=Ds03oLET/hRdyhwQHQMkZUp2gcya9keGaXB9J1w3L6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6BChEMsAx4+z/TVEbWRK1CobU1eVfvJ5AaXq8NDKLDQQg56NjxycspERQv92crilrHrnL9tTvuGLPw4mJvkE6jAy5qxOGZqYhik2qvxDCeWwZCRS41JurFD0+IbXA6X3WL88XKKgX90KLai2fumr6EUAs2j6f2DGrmLrtKeDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E050D1007;
	Fri, 22 Mar 2024 03:27:09 -0700 (PDT)
Received: from [10.57.71.57] (unknown [10.57.71.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763BF3F64C;
	Fri, 22 Mar 2024 03:26:33 -0700 (PDT)
Message-ID: <baa31f2d-98a9-4d37-a86e-e13ce7ab0081@arm.com>
Date: Fri, 22 Mar 2024 10:26:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PM: EM: Add em_dev_update_chip_binning()
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>
Cc: dietmar.eggemann@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
 daniel.lezcano@linaro.org, rafael@kernel.org, viresh.kumar@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 m.szyprowski@samsung.com, mhiramat@kernel.org
References: <20240314140421.3563571-1-lukasz.luba@arm.com>
 <20240314140421.3563571-4-lukasz.luba@arm.com>
 <aefbb61c-8e15-4e40-9459-30bbbcb8d6f5@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <aefbb61c-8e15-4e40-9459-30bbbcb8d6f5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 3/14/24 14:32, Christian Loehle wrote:
> On 14/03/2024 14:04, Lukasz Luba wrote:
>> Add a function which allows to modify easily the EM after the new voltage
>> information is available. The device drivers for the chip can adjust
>> the voltage values after setup. The voltage for the same frequency in OPP
>> can be different due to chip binning. The voltage impacts the power usage
>> and the EM power values can be updated to reflect that.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h |  5 ++++
>>   kernel/power/energy_model.c  | 51 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 770755df852f1..d30d67c2f07cf 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -172,6 +172,7 @@ struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
>>   void em_table_free(struct em_perf_table __rcu *table);
>>   int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
>>   			 int nr_states);
>> +int em_dev_update_chip_binning(struct device *dev);
>>   
>>   /**
>>    * em_pd_get_efficient_state() - Get an efficient performance state from the EM
>> @@ -387,6 +388,10 @@ int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
>>   {
>>   	return -EINVAL;
>>   }
>> +static inline int em_dev_update_chip_binning(struct device *dev)
>> +{
>> +	return -EINVAL;
>> +}
>>   #endif
>>   
>>   #endif
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 6960dd7393b2d..1494a909844a4 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -808,3 +808,54 @@ static void em_update_workfn(struct work_struct *work)
>>   {
>>   	em_check_capacity_update();
>>   }
>> +
>> +/**
>> + * em_dev_update_chip_binning() - Update Energy Model with new values after
>> + *			the new voltage information is present in the OPPs.
>> + * @dev		: Device for which the Energy Model has to be updated.
>> + *
>> + * This function allows to update easily the EM with new values available in
>> + * the OPP framework and DT. It can be used after the chip has been properly
>> + * verified by device drivers and the voltages adjusted for the 'chip binning'.
>> + * It uses the "dynamic-power-coefficient" DT property to calculate the power
>> + * values for EM. For power calculation it uses the new adjusted voltage
>> + * values known for OPPs, which might be changed after boot.
>> + */
>> +int em_dev_update_chip_binning(struct device *dev)
>> +{
>> +	struct em_perf_table __rcu *em_table;
>> +	struct em_perf_domain *pd;
>> +	int i, ret;
>> +
>> +	if (IS_ERR_OR_NULL(dev))
>> +		return -EINVAL;
>> +
>> +	pd = em_pd_get(dev);
>> +	if (!pd) {
>> +		dev_warn(dev, "Couldn't find Energy Model %d\n", ret);
> 
> ret is uninitialized at this point, I guess just
> +		dev_warn(dev, "Couldn't find Energy Model\n");
> already contains everything relevant.
> 

Good catch, thanks! Yes, I agree it contains enough. I'm going
to send v2 with this.

Regards,
Lukasz

