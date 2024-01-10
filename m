Return-Path: <linux-kernel+bounces-21900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62085829649
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0689B1F257A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936B3EA76;
	Wed, 10 Jan 2024 09:26:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8C320E;
	Wed, 10 Jan 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 730C62F4;
	Wed, 10 Jan 2024 01:26:51 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F108D3F64C;
	Wed, 10 Jan 2024 01:26:03 -0800 (PST)
Message-ID: <821be71b-97e8-444a-900b-48fc5d88829f@arm.com>
Date: Wed, 10 Jan 2024 09:27:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To: Di Shen <di.shen@unisoc.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, wvw@google.com,
 tkjos@google.com, xuewen.yan@unisoc.com, zhanglyra@gmail.com,
 orsonzhai@gmail.com
References: <20240109112736.32566-1-di.shen@unisoc.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240109112736.32566-1-di.shen@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Di,

On 1/9/24 11:27, Di Shen wrote:
> Commit 0952177f2a1f ("thermal/core/power_allocator: Update once
> cooling devices when temp is low") adds an update flag to avoid
> the thermal event is triggered when there is no need, and
> thermal cdev would be updated once when temperature is low.
> 
> But when the trips are writable, and switch_on_temp is set
> to be a higher value, the cooling device state may not be
> reset to 0, because last_temperature is smaller than the
> switch_on_temp.
> 
> For example:
> First:
> switch_on_temp=70 control_temp=85;
> Then userspace change the trip_temp:
> switch_on_temp=45 control_temp=55 cur_temp=54
> 
> Then userspace reset the trip_temp:
> switch_on_temp=70 control_temp=85 cur_temp=57 last_temp=54
> 
> At this time, the cooling device state should be reset to 0.
> However, because cur_temp(57) < switch_on_temp(70)
> last_temp(54) < switch_on_temp(70)  ---->  update = false,
> update is false, the cooling device state can not be reset.
> 
> Considering tz->passive can also be represented the temperature
> status, this patch modifies the update flag with tz->passive.
> 
> When the first time the temperature drops below switch_on, the
> states of cooling devices can be reset once(because tz->passive = 1),
> and the tz->passive is updated to 0. In the next round, because
> tz->passive is 0, the cdev->state would not be updated.
> 
> By using the tz->passive as the "update" flag, the issue above
> can be solved, and the cooling devices can be update only once
> when the temperature is low.
> 
> Fixes: <0952177f2a1f> (thermal/core/power_allocator: Update once cooling devices when temp is low)

This should be:
Fixes: 0952177f2a1f ("thermal/core/power_allocator: Update once cooling 
devices when temp is low")
Cc: <stable@vger.kernel.org> # v5.13+

> Signed-off-by: Di Shen <di.shen@unisoc.com>
> 
> ---
> V6:
> Compared to the previous version:
> - Not change the thermal core.
> - Not add new variables and function.
> - Use tz->passive as "update" flag to indicates whether the cooling
>    device should be reset.
> 
> V5: [5]
> - Simplify the reset ops, make it no return value and no specific
>    trip ID as argument.
> - Extend the commit message.
> 
> V4: [4]
> - Compared to V3, handle it in thermal core instead of in governor.
> - Add an ops to the governor structure, and call it when a trip
>    point is changed.
> - Define reset ops for power allocator.
> 
> V3: [3]
> - Add fix tag.
> 
> V2: [2]
> - Compared to v1, do not revert.
> - Add a variable(last_switch_on_temp) in power_allocator_params
>    to record the last switch_on_temp value.
> - Adds a function to renew the update flag and update the
>    last_switch_on_temp when thermal trips are writable.
> 
> V1: [1]
> - Revert commit 0952177f2a1f.
> 
> [1] https://lore.kernel.org/all/20230309135515.1232-1-di.shen@unisoc.com/
> [2] https://lore.kernel.org/all/20230315093008.17489-1-di.shen@unisoc.com/
> [3] https://lore.kernel.org/all/20230320095620.7480-1-di.shen@unisoc.com/
> [4] https://lore.kernel.org/all/20230619063534.12831-1-di.shen@unisoc.com/
> [5] https://lore.kernel.org/all/20230710033234.28641-1-di.shen@unisoc.com/
> ---
> ---
>   drivers/thermal/gov_power_allocator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 83d4f451b1a9..931cd88425e4 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -693,7 +693,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz,
>   
>   	trip = params->trip_switch_on;
>   	if (trip && tz->temperature < trip->temperature) {
> -		update = tz->last_temperature >= trip->temperature;
> +		update = tz->passive;
>   		tz->passive = 0;
>   		reset_pid_controller(params);
>   		allow_maximum_power(tz, update);

That small change LGTM.

Please send v7 and add Wei as 'Suggested-by:' for this compact solution
suggestion.

Regards,
Lukasz

