Return-Path: <linux-kernel+bounces-151864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39DF8AB4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70FB1C22189
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A313BC37;
	Fri, 19 Apr 2024 18:16:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C9137920;
	Fri, 19 Apr 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550601; cv=none; b=G1jtCzY5ryV40NVH7fA4wqewdqx2tdNwhZW2AMRoeT52fS/QLKV1GQz/VVHiyqnzN47zE2nd0T6vzSiYUSjJXRX0cOWiHe1tIsavhK/7YnGrjUP71aeQ+r8e1kESj1rW7Z9jRc0XnHkhIYTxJdY+eWxHaCT7hTzuQEYORL/jua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550601; c=relaxed/simple;
	bh=LCDBb0+cBge6lTflKm2wNezAMCx7jK2wKOdmZaK4KcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy/Y74wfWkVIkgY1oemvTY8cOHcwBo3GAO5hxhNHULTfink/k9nvLftU/J/8Q0oA+ixjIfJDtv2cWlFEvcqLjpttuHC3LchQvtxbNjYVdwtmLt7ew6JkNjml85ILB1PQg4zoWP4fyaCs2cLYBRaGwofXdzqR9CTn5B/W9ZeEBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD422F;
	Fri, 19 Apr 2024 11:17:05 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC223F792;
	Fri, 19 Apr 2024 11:16:35 -0700 (PDT)
Message-ID: <16a47cb9-a567-482a-a875-9070ce9973bf@arm.com>
Date: Fri, 19 Apr 2024 19:16:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed()
 instead of .throttle()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <15186663.tv2OnDr8pf@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <15186663.tv2OnDr8pf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 18:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notifying user space about trip points that have not been crossed is
> not particuarly useful, so modity the User Space governor to use the

s/particuarly/particularly/

s/modity/modify/

> .trip_crossed() callback, which is only invoked for trips that have been
> crossed, instead of .throttle() that is invoked for all trips in a
> thermal zone every time the zone is updated.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Note: I am not actually sure if there is user space depending on the
> current behavior that can be broken by this change.
> 
> I can easily imagine trying to implement a complicated governor in user
> space that will look at all of the trips in the thermal zone regardless
> of whether or not they are crossed, which can be kind of helped by the
> current behavior of the user space governor.
> 
> However, the total overhead caused by it is considerable and quite
> arguably it may not be acceptable at least in some cases.

If there is a such user space governor - it should not rely on
notifications from each trip. It should rather read from sysfs
the list of all trips during setup and just act on those which
have been crossed in runtime, IMO.

Therefore, I agree with the proposed change.

> 
> ---
>   drivers/thermal/gov_user_space.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_user_space.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_user_space.c
> +++ linux-pm/drivers/thermal/gov_user_space.c
> @@ -26,11 +26,13 @@ static int user_space_bind(struct therma
>    * notify_user_space - Notifies user space about thermal events
>    * @tz: thermal_zone_device
>    * @trip: trip point
> + * @crossed_up: whether or not the trip has been crossed on the way up
>    *
>    * This function notifies the user space through UEvents.
>    */
> -static int notify_user_space(struct thermal_zone_device *tz,
> -			     const struct thermal_trip *trip)
> +static void notify_user_space(struct thermal_zone_device *tz,
> +			      const struct thermal_trip *trip,
> +			      bool crossed_up)
>   {
>   	char *thermal_prop[5];
>   	int i;
> @@ -46,13 +48,11 @@ static int notify_user_space(struct ther
>   	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
>   	for (i = 0; i < 4; ++i)
>   		kfree(thermal_prop[i]);
> -
> -	return 0;
>   }
>   
>   static struct thermal_governor thermal_gov_user_space = {
>   	.name		= "user_space",
> -	.throttle	= notify_user_space,
> +	.trip_crossed	= notify_user_space,
>   	.bind_to_tz	= user_space_bind,
>   };
>   THERMAL_GOVERNOR_DECLARE(thermal_gov_user_space);
> 
> 
> 

LGTM w/ the spelling fixes applied

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

