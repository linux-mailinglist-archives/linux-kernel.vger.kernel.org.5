Return-Path: <linux-kernel+bounces-151244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD28AABAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7711F218BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92927BB01;
	Fri, 19 Apr 2024 09:44:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C63768EA;
	Fri, 19 Apr 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519844; cv=none; b=ET0hpzlrAsdSn1T7bPUzxtliVd+S5sE4Pnyp6GC3NJ+LAAV5dAV4E5VLQeXhZYXD1gu+pvaNLn03LIEkyHxPDfysRFXt0zY00pRjQcVBqB7VcHmKl7Omuc2m1vTe2IwUMLJIflVDuR2EMi/ADqrCztP+B1t/sy47WByOGQWCSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519844; c=relaxed/simple;
	bh=BJFS29e56mow5kaa0ewq08lqx6I1KrgW0SO4p5o7cOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCmudpIThtDZDXqE9eVkag3JmKKfJ24cJK3xXpCsAW87l8JBjiyHY808eDWG2UptFAhcYUTIWW1jmogRoVpAhDgnWOSFSit7V7t3550+m+aWzPbjI3vazHvos9daFr8Fj1GBhbCE0vH7ifE/rfWvfMKzkEpneXGDAOn8uAK1M3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C731E2F;
	Fri, 19 Apr 2024 02:44:30 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97FD83F792;
	Fri, 19 Apr 2024 02:44:01 -0700 (PDT)
Message-ID: <d949f374-fd54-4f6b-9d15-6cc35b1f226e@arm.com>
Date: Fri, 19 Apr 2024 10:44:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/16] thermal: core: Introduce .manage() callback for
 thermal governors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3242862.5fSG56mABF@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3242862.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a new thermal governor callback called .manage() that will be
> invoked once per thermal zone update after processing all of the trip
> points in the core.
> 
> This will allow governors that look at multiple trip points together
> to check all of them in a consistent configuration, so they don't need
> to play tricks with skipping .throttle() invocations that they are not
> interested in and they can avoid carrying out the same computations for
> multiple times in one cycle.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c |    3 +++
>   drivers/thermal/thermal_core.h |    2 ++
>   2 files changed, 5 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -516,6 +516,9 @@ void __thermal_zone_device_update(struct
>   			governor->trip_crossed(tz, &td->trip, false);
>   	}
>   
> +	if (governor->manage)
> +		governor->manage(tz);
> +
>   	monitor_thermal_zone(tz);
>   }
>   
> Index: linux-pm/drivers/thermal/thermal_core.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.h
> +++ linux-pm/drivers/thermal/thermal_core.h
> @@ -31,6 +31,7 @@ struct thermal_trip_desc {
>    * @unbind_from_tz:	callback called when a governor is unbound from a
>    *			thermal zone.
>    * @trip_crossed:	called for trip points that have just been crossed
> + * @manage:	called on thermal zone temperature updates
>    * @throttle:	callback called for every trip point even if temperature is
>    *		below the trip point temperature
>    * @update_tz:	callback called when thermal zone internals have changed, e.g.
> @@ -44,6 +45,7 @@ struct thermal_governor {
>   	void (*trip_crossed)(struct thermal_zone_device *tz,
>   			     const struct thermal_trip *trip,
>   			     bool crossed_up);
> +	void (*manage)(struct thermal_zone_device *tz);
>   	int (*throttle)(struct thermal_zone_device *tz,
>   			const struct thermal_trip *trip);
>   	void (*update_tz)(struct thermal_zone_device *tz,
> 
> 
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

