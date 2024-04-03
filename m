Return-Path: <linux-kernel+bounces-129734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC9896F41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FD28252E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334B8146D53;
	Wed,  3 Apr 2024 12:48:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0951EEF9;
	Wed,  3 Apr 2024 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148521; cv=none; b=p2c6uDB0z1hlIDm+Zihzx54KPt1jOAdlCgUvrbdihEJ+cLCwT8w8YYWqKHiY/rAWz/+Ud0BVXEwazPNSVK9CtVTihTGI7dnDzvF9Oj6x1qLINZUvtpFx5EkVYrAMfV+qcreMptyQ2tpYjNSBnJOLH5Y/1TH0oisY99Hlhf7qG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148521; c=relaxed/simple;
	bh=PYlvBMrQ4HW2xqH/K7Y6/nSBj4Fe4xVbdSMQHX2JE0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZbO6bTXVc9nYwp1LogjH4zIMcEhNeBBIe7KH0XPPu+qSvCqxS3ormfst8zUL11mLphmss8sa9iQxHc8sfkSJZTOQMUtaBe5YJZ3ml9A6vmtrHi6CSTyLxN5djEEh45ld4BcFIupjfVQAPSnX829001WS2UYb6aymqcogF+QmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 405AA1007;
	Wed,  3 Apr 2024 05:49:10 -0700 (PDT)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2B003F64C;
	Wed,  3 Apr 2024 05:48:37 -0700 (PDT)
Message-ID: <1737b288-8550-407e-b501-469011b2a8cd@arm.com>
Date: Wed, 3 Apr 2024 13:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] thermal: gov_power_allocator: Allow binding
 without trip points
Content-Language: en-US
To: Nikita Travkin <nikitos.tr@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru>
 <20240403-gpa-no-cooling-devs-v2-2-79bdd8439449@trvn.ru>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240403-gpa-no-cooling-devs-v2-2-79bdd8439449@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 12:31, Nikita Travkin via B4 Relay wrote:
> From: Nikita Travkin <nikita@trvn.ru>
> 
> IPA probe function was recently refactored to perform extra error checks
> and make sure the thermal zone has trip points necessary for the IPA
> operation. With this change, if a thermal zone is probed such that it
> has no trip points that IPA can use, IPA will fail and the TZ won't be
> created. This is the case if a platform defines a TZ without cooling
> devices and only with "hot"/"critical" trip points, often found on some
> Qualcomm devices [1].
> 
> Documentation across IPA code (notably get_governor_trips() kerneldoc)
> suggests that IPA is supposed to handle such TZ even if it won't
> actually do anything.
> 
> This commit partially reverts the previous change to allow IPA to bind
> to such "empty" thermal zones.
> 
> [1] arch/arm64/boot/dts/qcom/sc7180.dtsi#n4776
> 
> Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip points earlier")
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   drivers/thermal/gov_power_allocator.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index ec637071ef1f..e25e48d76aa7 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -679,11 +679,6 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   		return -ENOMEM;
>   
>   	get_governor_trips(tz, params);
> -	if (!params->trip_max) {
> -		dev_warn(&tz->device, "power_allocator: missing trip_max\n");
> -		kfree(params);
> -		return -EINVAL;
> -	}
>   
>   	ret = check_power_actors(tz, params);
>   	if (ret < 0) {
> @@ -714,9 +709,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>   	else
>   		params->sustainable_power = tz->tzp->sustainable_power;
>   
> -	estimate_pid_constants(tz, tz->tzp->sustainable_power,
> -			       params->trip_switch_on,
> -			       params->trip_max->temperature);
> +	if (params->trip_max)
> +		estimate_pid_constants(tz, tz->tzp->sustainable_power,
> +				       params->trip_switch_on,
> +				       params->trip_max->temperature);
>   
>   	reset_pid_controller(params);
>   
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

