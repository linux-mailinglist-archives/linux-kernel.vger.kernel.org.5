Return-Path: <linux-kernel+bounces-122720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B888FC09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1AE1C2D00A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846B6A00E;
	Thu, 28 Mar 2024 09:50:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A1651B6;
	Thu, 28 Mar 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619424; cv=none; b=dAiyS5kU8cQ3wTskbXoYYky0xfMgRGl1KZsdM7eThURD4uUUkTyp3GfqhlYxP+glHtJR2AH239vJVyiMvQ9L+5Qv+s0IMNZbmcPtKKVsX+nfHEmtzSYMlbe+GsqKdbrzk5E4ISOzjoHgegdKudHBgFnfgc2LJjq7b4qrg4vKloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619424; c=relaxed/simple;
	bh=34dy55diV+Qo54TTg/6m8LWWzKtrVmGDMbvaRXkv9Yk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+GTsfgFbV3aLbaH1WgCuNdOWyivj+m4hTvR7ltm4yixRqods88kFSs61DpgLT5d107LO3VZBzW5jO7bP41C/SFUwq9Bd7GSCHSDCxVXB4eegj6hk7BPxd4eyYwCPrim1CrJuz072areZ4K0XWxJT60idWlRX+7Yl9CZlcjsSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6667A339;
	Thu, 28 Mar 2024 02:50:50 -0700 (PDT)
Received: from [10.57.73.140] (unknown [10.57.73.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77E5B3F7BD;
	Thu, 28 Mar 2024 02:50:15 -0700 (PDT)
Message-ID: <3df783db-3243-4484-a429-4d3e64b9dbae@arm.com>
Date: Thu, 28 Mar 2024 09:50:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: gov_power_allocator: Allow binding without
 cooling devices
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, nikita@trvn.ru
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240321-gpa-no-cooling-devs-v1-1-5c9e0ef2062e@trvn.ru>
 <CAJZ5v0jAq=iMKzYBz-Ni6Zqpbgxp3_0UYpPiAoSLcfGNJ8ruhQ@mail.gmail.com>
 <1bfcb1cf-fc08-404b-be36-b5e1863f7c59@arm.com>
In-Reply-To: <1bfcb1cf-fc08-404b-be36-b5e1863f7c59@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/28/24 09:12, Lukasz Luba wrote:
> Hi Rafael,
> 
> On 3/27/24 15:25, Rafael J. Wysocki wrote:
>> On Thu, Mar 21, 2024 at 3:44 PM Nikita Travkin <nikita@trvn.ru> wrote:
>>>
>>> Commit e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip 
>>> points earlier")
>>> added a check that would fail binding the governer if there is no
>>> cooling devices bound to the thermal zone. Unfortunately this causes
>>> issues in cases when the TZ is bound to the governer before the cooling
>>> devices are attached to it. (I.e. when the tz is registered using
>>> thermal_zone_device_register_with_trips().)
>>>
>>> Additionally, the documentation across gov_power_allocator suggests it's
>>> intended to allow it to be bound to thermal zones without cooling
>>> devices (and thus without passive/active trip points), however the same
>>> change added a check for the trip point to be present, causing those TZ
>>> to fail probing.

This patch description is mixing trips and cooling devices and refers to
a commit which is only for guarding the trip points number to be
not less than 2. In IPA we require 2 trip points.

>>>
>>> Those changes cause all thermal zones to fail on some devices (such as
>>> sc7180-acer-aspire1) and prevent the kernel from controlling the cpu/gpu
>>> frequency based on the temperature, as well as losing all the other
>>> "informational" thermal zones if power_allocator is set as default.
>>>
>>> This commit partially reverts the referenced one by dropping the trip
>>> point check and by allowing the TZ to probe even if no actor buffer was
>>> allocated to allow those TZ to probe again.
>>>
>>> Fixes: e83747c2f8e3 ("thermal: gov_power_allocator: Set up trip 
>>> points earlier")

Not that commit.

>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> ---
>>> I've noticed that all thermal zones fail probing with -EINVAL on my
>>> sc7180 based Acer Aspire 1 since 6.8. This commit allows me to bring
>>> them back.
>>
>> Łukasz, any comments?
> 
> Let me check this today.
> 
>>
>>> ---
>>>   drivers/thermal/gov_power_allocator.c | 14 +++++---------
>>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/thermal/gov_power_allocator.c 
>>> b/drivers/thermal/gov_power_allocator.c
>>> index 1b17dc4c219c..4f2d7f3b7508 100644
>>> --- a/drivers/thermal/gov_power_allocator.c
>>> +++ b/drivers/thermal/gov_power_allocator.c
>>> @@ -679,11 +679,6 @@ static int power_allocator_bind(struct 
>>> thermal_zone_device *tz)
>>>                  return -ENOMEM;
>>>
>>>          get_governor_trips(tz, params);
>>> -       if (!params->trip_max) {
>>> -               dev_warn(&tz->device, "power_allocator: missing 
>>> trip_max\n");

This if() guards the binding of TZ with less than 2 trip points,
not the cooling devices.

>>> -               kfree(params);
>>> -               return -EINVAL;
>>> -       }
>>>
>>>          ret = check_power_actors(tz, params);
>>>          if (ret < 0) {
>>> @@ -693,7 +688,7 @@ static int power_allocator_bind(struct 
>>> thermal_zone_device *tz)
>>>          }
>>>
>>>          ret = allocate_actors_buffer(params, ret);
>>> -       if (ret) {

This if() is from different commit.

>>> +       if (ret && ret != -EINVAL) {

This is about 0 cooling devices in the thermal zone, but IPA won't work
so why to even fake and forward binding?

Rafael should we support binding with 0 cooling devices?

>>>                  dev_warn(&tz->device, "power_allocator: allocation 
>>> failed\n");
>>>                  kfree(params);
>>>                  return ret;
>>> @@ -714,9 +709,10 @@ static int power_allocator_bind(struct 
>>> thermal_zone_device *tz)
>>>          else
>>>                  params->sustainable_power = tz->tzp->sustainable_power;
>>>
>>> -       estimate_pid_constants(tz, tz->tzp->sustainable_power,
>>> -                              params->trip_switch_on,
>>> -                              params->trip_max->temperature);
>>> +       if (params->trip_max)

This is not supported, we need those 2 trip points.

>>> +               estimate_pid_constants(tz, tz->tzp->sustainable_power,
>>> +                                      params->trip_switch_on,
>>> +                                      params->trip_max->temperature);
>>>
>>>          reset_pid_controller(params);
>>>
>>>
>>> ---
>>> base-commit: e7528c088874326d3060a46f572252be43755a86
>>> change-id: 20240321-gpa-no-cooling-devs-c79ee3288325
>>>
>>> Best regards,
>>> -- 
>>> Nikita Travkin <nikita@trvn.ru>
>>>
> 

