Return-Path: <linux-kernel+bounces-54938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7284B52D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64F01C24A08
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BB213172C;
	Tue,  6 Feb 2024 12:15:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40075130E38;
	Tue,  6 Feb 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221731; cv=none; b=icsh3HxXCEja3AJppqHIQqLOr5C8toqKXLiJpgb0MmuGu8gaoc27rJX6y+WVlqqL1/jR2UA/BerNctpBtHFXNabgQV6DbGIQyGctSzsneCadGVICqZi2I6rfta4cNYrhqK6arXDvvCY3+/sT0d9/3uJrDtQhQsbqbDrGB8i1A7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221731; c=relaxed/simple;
	bh=BjMJKDhMrrtvzpcwuLRNsqgqogyscOG5UwwZZkmzDmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD4sTD2yH5btFRfekZTw4agoVMWjJxsga/Ko6VOrPKzga5Q0iJTVkM0zqlwZ7bV3pJK/44RDQcEwjCfCC/k+Xj7StsAD2B86PuDqZ2eJIzG/HrAQncsJN4VC7r1LMQRshvI0xcHNy9GeMYH4xaOckU6m7sMMMbrj8yu0Mo97CxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 735F91FB;
	Tue,  6 Feb 2024 04:16:07 -0800 (PST)
Received: from [10.57.8.150] (unknown [10.57.8.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 537273F762;
	Tue,  6 Feb 2024 04:15:23 -0800 (PST)
Message-ID: <62f4258a-6739-4a3b-8fc3-09e04ea55dab@arm.com>
Date: Tue, 6 Feb 2024 12:15:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] thermal: power_allocator: Avoid overwriting PID
 coefficients from setup time
Content-Language: en-US
To: Di Shen <cindygm567@gmail.com>, Di Shen <di.shen@unisoc.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 xuewen.yan@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
References: <1f8914cb-fc66-4068-8f7c-4d13b2454f7d@arm.com>
 <20240125062331.28943-1-di.shen@unisoc.com>
 <CAHYJL4oBPJ=pL2GT+-j398-TsmRG9D3rwFZyo7KaHvewQk4n0w@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAHYJL4oBPJ=pL2GT+-j398-TsmRG9D3rwFZyo7KaHvewQk4n0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Di,

On 2/4/24 02:55, Di Shen wrote:
> Hi Lukasz,
> 
> On Thu, Jan 25, 2024 at 2:24 PM Di Shen <di.shen@unisoc.com> wrote:
>>
>> When the PID coefficients k_* are set via sysfs before the IPA
>> algorithm is triggered then the coefficients would be overwritten after
>> IPA throttle() is called. The old configuration values might be
>> different than the new values estimated by the IPA internal algorithm.
>>
>> There might be a time delay when this overwriting happens. It
>> depends on the thermal zone temperature value. The temperature value
>> needs to cross the first trip point value then IPA algorithms start
>> operating. Although, the PID coefficients setup time should not be
>> affected or linked to any later operating phase and values must not be
>> overwritten.
>>
>> This patch initializes params->sustainable_power when the governor
>> binds to thermal zone to avoid overwriting k_*. The basic function won't
>> be affected, as the k_* still can be estimated if the sustainable_power
>> is modified.
>>
>> Signed-off-by: Di Shen <di.shen@unisoc.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 81e061f183ad..1b17dc4c219c 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -711,6 +711,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
>>
>>          if (!tz->tzp->sustainable_power)
>>                  dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
>> +       else
>> +               params->sustainable_power = tz->tzp->sustainable_power;
>>
>>          estimate_pid_constants(tz, tz->tzp->sustainable_power,
>>                                 params->trip_switch_on,
>> --
>> 2.17.1
>>
> 
> Any comments on patchv2?
> Looking forward to hearing from you. Thanks!

My apologies I was out-of-office.

That v2 patch looks good. Although, please resend it as a new
message, not as a response to the v1. In that way it's easier to
pick it up by maintainers. You can use a tag:
[RESEND][PATCH v2] .....

You can add
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

