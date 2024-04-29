Return-Path: <linux-kernel+bounces-163066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212AF8B6479
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB61B20B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E41836D5;
	Mon, 29 Apr 2024 21:21:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C14181D0E;
	Mon, 29 Apr 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425700; cv=none; b=svcgdSUGIshQg6KUU3IwJCpxP6Qil+CVF3JVnVruBS607y1AiDmjd4sj/O0z07VCKQUFnY4S4/e2fjkAD4612mwuYWXFE14icrS7neoKPkaCNItBbIXn7vMQnt7D4eKOmSbAPLtg6XUdMBjOsrKmTSGP02lDRrefhVqwF4z62Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425700; c=relaxed/simple;
	bh=AKYwwoQR9CknzQcaa5xw+jnj1z5MmTM/A5lVQmuKnqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7NSuCmzhKzLoBPacuCSN0oO4TOk0GvCvUToobfoADLOP6K9uD+yqFjgr3q7QP4ryTryaBPKo54kaApl2Kb8ComvhnXZ4lCAR0KIi8vvYV3M27KhIcJWqw2Q0/EYe5cWs0Rxw3xXv2xwMz3VIJG75i0Il+dhEv2kF3vWENORJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F3F2F4;
	Mon, 29 Apr 2024 14:22:02 -0700 (PDT)
Received: from [10.57.64.131] (unknown [10.57.64.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380383F793;
	Mon, 29 Apr 2024 14:21:35 -0700 (PDT)
Message-ID: <c29247b8-89d4-404a-b294-81f19720e236@arm.com>
Date: Mon, 29 Apr 2024 22:21:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Move passive polling management to the
 core
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <5938055.MhkbZ0Pkbq@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <5938055.MhkbZ0Pkbq@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 4/25/24 15:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Passive polling is enabled by setting the 'passive' field in
> struct thermal_zone_device to a positive value so long as the
> 'passive_delay_jiffies' field is greater than zero.  It causes
> the thermal core to actively check the thermal zone temperature
> periodically which in theory should be done after crossing a
> passive trip point on the way up in order to allow governors to
> react more rapidly to temperature changes and adjust mitigation
> more precisely.
> 
> However, the 'passive' field in struct thermal_zone_device is currently
> managed by governors which is quite problematic.  First of all, only
> two governors, Step-Wise and Power Allocator, update that field at
> all, so the other governors do not benefit from passive polling,
> although in principle they should.  Moreover, if the zone governor is
> changed from, say, Step-Wise to Fair-Share after 'passive' has been
> incremented by the former, it is not going to be reset back to zero by
> the latter even if the zone temperature falls down below all passive
> trip points.
> 
> For this reason, make handle_thermal_trip() increment 'passive'
> to enable passive polling for the given thermal zone whenever a
> passive trip point is crossed on the way up and decrement it
> whenever a passive trip point is crossed on the way down.  Also
> remove the 'passive' field updates from governors and additionally
> clear it in thermal_zone_device_init() to prevent passive polling
> from being enabled after a system resume just beacuse it was enabled
> before suspending the system.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This has been mentioned here:
> 
> https://lore.kernel.org/linux-pm/61560bc6-d453-4b0c-a4ea-b375d547b143@linaro.org/
> 
> and I need someone to double check if the Power Allocator governor does not
> need to be adjusted more for this change.
> 
> ---
>   drivers/thermal/gov_power_allocator.c |   12 +++++++-----
>   drivers/thermal/gov_step_wise.c       |   10 ----------
>   drivers/thermal/thermal_core.c        |   10 ++++++++--
>   3 files changed, 15 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -389,6 +389,9 @@ static void handle_thermal_trip(struct t
>   		if (tz->temperature < trip->temperature - trip->hysteresis) {
>   			list_add(&td->notify_list_node, way_down_list);
>   			td->notify_temp = trip->temperature - trip->hysteresis;
> +
> +			if (trip->type == THERMAL_TRIP_PASSIVE)
> +				tz->passive--;

This gets negative values and than the core switches to fast 'polling'
mode. The values is decremented from 0 each time the
thermal_zone_device_enable() is called.

Then IPA is actually called every 100ms after boot w/ low temp,
while it should 1s.

Please see the logs below:
'short log' after boot
----------------------------------------------

[    1.632670] thermal_sys: TZ: tz_id=0 passive-- = -1
[    1.637984] thermal_sys: TZ: tz_id=0 passive-- = -2
[    1.643641] thermal_sys: TZ: tz_id=1 passive-- = -1
----------------------------------------------

long log with call stack dumped
----------------------------------------------

[    1.632973] thermal_sys: TZ: tz_id=0 passive-- = -1
[    1.638295] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5+ #28
[    1.645409] Hardware name: Radxa ROCK 4SE (DT)
[    1.650376] Call trace:
[    1.653109]  dump_backtrace+0x9c/0x100
[    1.657309]  show_stack+0x20/0x38
[    1.661017]  dump_stack_lvl+0xc0/0xd0
[    1.665119]  dump_stack+0x18/0x28
[    1.668828]  __thermal_zone_device_update+0x1fc/0x550
[    1.674484]  thermal_zone_device_set_mode+0x64/0xc0
[    1.679943]  thermal_zone_device_enable+0x1c/0x30
[    1.685206]  thermal_of_zone_register+0x34c/0x590
[    1.690473]  devm_thermal_of_zone_register+0x6c/0xc0
[    1.696031]  rockchip_thermal_probe+0x238/0x5e8
[    1.701106]  platform_probe+0x70/0xe8
[    1.705208]  really_probe+0xc4/0x278
[    1.709205]  __driver_probe_device+0x80/0x140
[    1.714078]  driver_probe_device+0x48/0x130
[    1.718756]  __driver_attach+0x7c/0x138
[    1.723045]  bus_for_each_dev+0x80/0xf0
[    1.727342]  driver_attach+0x2c/0x40
[    1.731340]  bus_add_driver+0xec/0x1f8
[    1.735539]  driver_register+0x68/0x138
[    1.739828]  __platform_driver_register+0x30/0x48
[    1.745093]  rockchip_thermal_driver_init+0x24/0x38
[    1.750551]  do_one_initcall+0x50/0x2d8
[    1.754844]  kernel_init_freeable+0x204/0x440
[    1.759722]  kernel_init+0x28/0x140
[    1.763631]  ret_from_fork+0x10/0x20
[    1.767802] thermal_sys: TZ: tz_id=0 passive-- = -2
[    1.773086] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5+ #28
[    1.780196] Hardware name: Radxa ROCK 4SE (DT)
[    1.785162] Call trace:
[    1.787893]  dump_backtrace+0x9c/0x100
[    1.792087]  show_stack+0x20/0x38
[    1.795795]  dump_stack_lvl+0xc0/0xd0
[    1.799895]  dump_stack+0x18/0x28
[    1.803604]  __thermal_zone_device_update+0x1fc/0x550
[    1.809257]  thermal_zone_device_set_mode+0x64/0xc0
[    1.814715]  thermal_zone_device_enable+0x1c/0x30
[    1.819977]  thermal_of_zone_register+0x34c/0x590
[    1.825242]  devm_thermal_of_zone_register+0x6c/0xc0
[    1.830799]  rockchip_thermal_probe+0x238/0x5e8
[    1.835874]  platform_probe+0x70/0xe8
[    1.839973]  really_probe+0xc4/0x278
[    1.843972]  __driver_probe_device+0x80/0x140
[    1.848846]  driver_probe_device+0x48/0x130
[    1.853524]  __driver_attach+0x7c/0x138
[    1.857813]  bus_for_each_dev+0x80/0xf0
[    1.862110]  driver_attach+0x2c/0x40
[    1.866109]  bus_add_driver+0xec/0x1f8
[    1.870307]  driver_register+0x68/0x138
[    1.874597]  __platform_driver_register+0x30/0x48
[    1.879861]  rockchip_thermal_driver_init+0x24/0x38
[    1.885317]  do_one_initcall+0x50/0x2d8
[    1.889609]  kernel_init_freeable+0x204/0x440
[    1.894486]  kernel_init+0x28/0x140
[    1.898394]  ret_from_fork+0x10/0x20
[    1.902879] thermal_sys: TZ: tz_id=1 passive-- = -1
[    1.908172] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5+ #28
[    1.915282] Hardware name: Radxa ROCK 4SE (DT)
[    1.920248] Call trace:
[    1.922979]  dump_backtrace+0x9c/0x100
[    1.927176]  show_stack+0x20/0x38
[    1.930883]  dump_stack_lvl+0xc0/0xd0
[    1.934982]  dump_stack+0x18/0x28
[    1.938691]  __thermal_zone_device_update+0x1fc/0x550
[    1.944342]  thermal_zone_device_set_mode+0x64/0xc0
[    1.949801]  thermal_zone_device_enable+0x1c/0x30
[    1.955063]  thermal_of_zone_register+0x34c/0x590
[    1.960328]  devm_thermal_of_zone_register+0x6c/0xc0
[    1.965886]  rockchip_thermal_probe+0x238/0x5e8
[    1.970951]  platform_probe+0x70/0xe8
[    1.975049]  really_probe+0xc4/0x278
[    1.979039]  __driver_probe_device+0x80/0x140
[    1.983911]  driver_probe_device+0x48/0x130
[    1.988589]  __driver_attach+0x7c/0x138
[    1.992880]  bus_for_each_dev+0x80/0xf0
[    1.997176]  driver_attach+0x2c/0x40
[    2.001173]  bus_add_driver+0xec/0x1f8
[    2.005372]  driver_register+0x68/0x138
[    2.009663]  __platform_driver_register+0x30/0x48
[    2.014927]  rockchip_thermal_driver_init+0x24/0x38
[    2.020383]  do_one_initcall+0x50/0x2d8
[    2.024674]  kernel_init_freeable+0x204/0x440
[    2.029549]  kernel_init+0x28/0x140
[    2.033456]  ret_from_fork+0x10/0x20

------------------------------------------


IMO we should check something like:
----------------------8<--------------------------
if (tz->passive)
	tz->passive--;
--------------------->8---------------------------
because we start from '0' as init value.

>   		} else {
>   			td->threshold -= trip->hysteresis;
>   		}
> @@ -402,8 +405,10 @@ static void handle_thermal_trip(struct t
>   		td->notify_temp = trip->temperature;
>   		td->threshold -= trip->hysteresis;
>   
> -		if (trip->type == THERMAL_TRIP_CRITICAL ||
> -		    trip->type == THERMAL_TRIP_HOT)
> +		if (trip->type == THERMAL_TRIP_PASSIVE)
> +			tz->passive++;

Also, we have to make sure here, that we are align after some change
and be able to return with value to 0 (to switch to 'passive'
slow checks).

Regards,
Lukasz

