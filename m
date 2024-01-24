Return-Path: <linux-kernel+bounces-37473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561EB83B08C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5332824E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA6912BE9B;
	Wed, 24 Jan 2024 17:54:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AFA1272DA;
	Wed, 24 Jan 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118855; cv=none; b=qVXpRoaIWr225A5cKHtO0Wm+knsLZtUpLSUA+Fx0q96t6INb4uFxtB8swslSHRCU+QIMxG64QuQLJQQ0sSROZg+1OKPAA+KvmjCU8xynOVb1e+i6zAA0Tm61V+bDOi9beY0cXmKDsw4Rq/Wl1U6Hq03L5kmPGHuP6G8r2jBN1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118855; c=relaxed/simple;
	bh=+NONbWTocWQCFSmXz/ZrgHt/3lh03Pdyeei+QNw+NsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7v79koGl6iskmPJ64wl+KstY4iL08mwQPW0yGeSVEL6y/B0nkoG1V3i/hnMeuat1iGeXg9iLjK+tQ9jG3Yi8mG8lQAE21T262jSoeru5hQJ2IQlMi+1y13r5tcsgdUhP7Da1CPIITLsMuIpYVS+ZHB0XaozOE5s/lkaUxIpFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A4E1FB;
	Wed, 24 Jan 2024 09:54:57 -0800 (PST)
Received: from [172.27.245.81] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20BE53F762;
	Wed, 24 Jan 2024 09:54:09 -0800 (PST)
Message-ID: <1f8914cb-fc66-4068-8f7c-4d13b2454f7d@arm.com>
Date: Wed, 24 Jan 2024 17:54:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: power_allocator: initialize
 params->sustainable_power in the bind callback
Content-Language: en-US
To: Di Shen <di.shen@unisoc.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, rafael@kernel.org,
 linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com, zhanglyra@gmail.com,
 orsonzhai@gmail.com, cindygm567@gmail.com, daniel.lezcano@linaro.org
References: <20240124114930.12231-1-di.shen@unisoc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240124114930.12231-1-di.shen@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Di,

Thanks for the patch. The code looks good, but let's
adjust the description.

So 1st line (subject):
thermal: power_allocator: Avoid overwriting PID coefficients from setup time

On 1/24/24 11:49, Di Shen wrote:
> If we set the PID constants k_* via sysfs before the IPA algorithm is

I would say:
'When the PID coefficients k_* are set via sysfs before the IPA
algorithm is triggered then the coefficients would be overwritten after
IPA throttle() is called. The old configuration values might be
different than the new values estimated by the IPA internal algorithm.'

I would also add something like this:
'There might be a time delay when this overwriting happens. It
depends on the thermal zone temperature value. The temperature value
needs to cross the first trip point value then IPA algorithms start
operating. Although, the PID coefficients setup time should not be
affected or linked to any later operating phase and values must not be
overwritten.'

Then we can drop this description from here...

> triggered, the constants would be changed after IPA is triggered which
> means the k_* are set fail.
> 
> The process is as follow:
> set k_* via sysfs
>      |
> set emul_temp via sysfs(temperature > switch_on_temp)
>      |
> throttle()
>      |
> temp > switch_on
>      |
> allocate_power
>      |
> pid_controller
>      |
> get_sustainable_power
>      |
> if (sustainable_power != params->sustainable_power)
> because the params->sustainable_power is not initialized first,
> so params->sustainable_power = 0, the condition is true, then
> call the estimate_pid_constants().
> 		|
> 	estimate_pid_constants
> 		|
> The k_* are overwritten, the k_* we set before are invalid.
> 
> For example:
> unisoc:/sys/class/thermal/thermal_zone0 # cat policy
> power_allocator
> unisoc:/sys/class/thermal/thermal_zone0 # cat temp
> 32722
> unisoc:/sys/class/thermal/thermal_zone0 # cat k_po
> 307
> unisoc:/sys/class/thermal/thermal_zone0 # cat k_pu
> 614
> unisoc:/sys/class/thermal/thermal_zone0 # cat k_i
> 61
> unisoc:/sys/class/thermal/thermal_zone0 # cat k_*
> 0
> 61
> 307
> 614
> 
> unisoc:/sys/class/thermal/thermal_zone0 # echo 300 > k_po
> unisoc:/sys/class/thermal/thermal_zone0 # echo 600 > k_pu
> unisoc:/sys/class/thermal/thermal_zone0 # echo 60 >k_i
> unisoc:/sys/class/thermal/thermal_zone0 # cat k_*
> 0
> 60
> 300
> 600
> 
> unisoc:/sys/class/thermal/thermal_zone0 # echo 70001 > emul_temp
> unisoc:/sys/class/thermal/thermal_zone0 # cat k_*
> 0
> 61
> 307
> 614
> unisoc:/sys/class/thermal/thermal_zone0 # echo 0 > emul_temp

.. up to here.


> 
> This patch initializes params->sustainable_power when the governor
> binds to thermal zone to avoid overwriting k_*.
> 
> The basic function won't be affected, as the k_* still can be estimated
> if the sustainable_power is modified.
> 
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>   drivers/thermal/gov_power_allocator.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 81e061f183ad..1b17dc4c219c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -711,6 +711,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   
>   	if (!tz->tzp->sustainable_power)
>   		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
> +	else
> +		params->sustainable_power = tz->tzp->sustainable_power;
>   
>   	estimate_pid_constants(tz, tz->tzp->sustainable_power,
>   			       params->trip_switch_on,

The code LGTM. Please sent next version of the patch.

Regards,
Lukasz

