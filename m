Return-Path: <linux-kernel+bounces-156487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F28B032E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E952D287ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA3157E78;
	Wed, 24 Apr 2024 07:26:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6947360;
	Wed, 24 Apr 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943604; cv=none; b=YfKAutAQoXz/KtrL1h/FtzIbYUpHqoMsIYrJ1nFqc7oJ5m51cJdP7b5TQDPegkoKULD85Rceyww4GnDPASikt6T4ZX0+N9BK4IMydpQczVTrVf6VGmYapB/rfc3ZddV91zHskr6KA+hPKjZO7On8FIx94f+n77fkmRIEBsSDGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943604; c=relaxed/simple;
	bh=iaiBma88Wg7RrGzKR4KWO3mS/NRsYch6lG9D0Epj3jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7z5reOCOAhvkBP9jcB0at6QUO5e3W0/hadKPytHGuNqv6oPYPoZVULh9NSeIw88gWbCsGAse5YePdJmY7jCLMU5hMgmkXtn79h9Y/RUUY5Uf5u2HiVJFbd7m6GFa9m69+kRPtaRFfrByZKF8wZUA1X+tFBgJ1mWgPhXhMq2jzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2792E339;
	Wed, 24 Apr 2024 00:27:08 -0700 (PDT)
Received: from [10.57.77.67] (unknown [10.57.77.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7533F64C;
	Wed, 24 Apr 2024 00:26:39 -0700 (PDT)
Message-ID: <1016c73b-9bcb-49b8-85a6-854476681558@arm.com>
Date: Wed, 24 Apr 2024 08:26:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: core: Introduce
 thermal_governor_trip_crossed()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <12426299.O9o76ZdvQC@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <12426299.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/24 20:01, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a wrapper around the .trip_crossed() governor callback invocation
> to reduce code duplications slightly and improve the code layout in
> __thermal_zone_device_update().
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> As requested in https://lore.kernel.org/linux-pm/3c169af3-e9c3-47c0-b343-48f699680009@linaro.org/
> 
> ---
>   drivers/thermal/thermal_core.c |   15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -450,6 +450,15 @@ static void thermal_zone_device_init(str
>   		pos->initialized = false;
>   }
>   
> +static void thermal_governor_trip_crossed(struct thermal_governor *governor,
> +					  struct thermal_zone_device *tz,
> +					  const struct thermal_trip *trip,
> +					  bool crossed_up)
> +{
> +	if (governor->trip_crossed)
> +		governor->trip_crossed(tz, trip, crossed_up);
> +}
> +
>   static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
>   				   const struct list_head *b)
>   {
> @@ -489,16 +498,14 @@ void __thermal_zone_device_update(struct
>   	list_for_each_entry(td, &way_up_list, notify_list_node) {
>   		thermal_notify_tz_trip_up(tz, &td->trip);
>   		thermal_debug_tz_trip_up(tz, &td->trip);
> -		if (governor->trip_crossed)
> -			governor->trip_crossed(tz, &td->trip, true);
> +		thermal_governor_trip_crossed(governor, tz, &td->trip, true);
>   	}
>   
>   	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
>   	list_for_each_entry(td, &way_down_list, notify_list_node) {
>   		thermal_notify_tz_trip_down(tz, &td->trip);
>   		thermal_debug_tz_trip_down(tz, &td->trip);
> -		if (governor->trip_crossed)
> -			governor->trip_crossed(tz, &td->trip, false);
> +		thermal_governor_trip_crossed(governor, tz, &td->trip, false);
>   	}
>   
>   	if (governor->manage)
> 
> 
> 

Good suggestion from Daniel. That code would probably be inlined anyway
by most of compilers today, so no harm & LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

