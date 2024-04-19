Return-Path: <linux-kernel+bounces-151276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB918AAC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EFB232C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F68120F;
	Fri, 19 Apr 2024 09:56:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A37C081;
	Fri, 19 Apr 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520605; cv=none; b=NzHhVE0JNiTSc4OeKoJlzS3gFQdKNrSKEq7U7jwAzhpZkw4IaCyO4fP97fvNR2YNZ3LCKdDQL18+sx9NKaHuT9Zy3aR/XH7cwoi1zK6Zpg1H2va0Q6OmUNErqWPyHzQlVktx3t5gdi5gfuKXuKblhUfzpZEJeAHhKv3ZMAlikoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520605; c=relaxed/simple;
	bh=J3ax+lMVj12rToXsUM/WDkLNIOKZs1F4BILE6ioPOQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmBWR7VXBvTpWNrdg5IDdN6tb1zwttg4pAXNTFcmeM82CKOqa0x1GeTH23OGC2USkvVTp7ISMPKDR0FQ4Th8avtDxr2tnjGiAZ8cDVXL148DGIX8aF3FbGU+KKBkqoj5gmZ7kG+722/a1bCLfqIMLluqjMiSV55OMwKxkbzNLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 559E62F;
	Fri, 19 Apr 2024 02:57:10 -0700 (PDT)
Received: from [10.57.77.69] (unknown [10.57.77.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F7A3F792;
	Fri, 19 Apr 2024 02:56:40 -0700 (PDT)
Message-ID: <3e23d9e5-001e-4f89-80c4-68e36fb756dc@arm.com>
Date: Fri, 19 Apr 2024 10:56:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <1913649.CQOukoFCf9@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the passive field in struct thermal_zone_device is not
> used by the Power Allocator governor itself and so the ordering of
> its updates with respect to allow_maximum_power() or allocate_power()
> does not matter.
> 
> Accordingly, make power_allocator_manage() update that field right
> before returning, which allows the current value of it to be passed
> directly to allow_maximum_power() without using the additional update
> variable that can be dropped.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_power_allocator.c |    9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -747,21 +747,18 @@ static void power_allocator_manage(struc
>   {
>   	struct power_allocator_params *params = tz->governor_data;
>   	const struct thermal_trip *trip = params->trip_switch_on;
> -	bool update;
>   
>   	lockdep_assert_held(&tz->lock);
>   
>   	if (trip && tz->temperature < trip->temperature) {
> -		update = tz->passive;
> -		tz->passive = 0;
>   		reset_pid_controller(params);
> -		allow_maximum_power(tz, update);
> +		allow_maximum_power(tz, tz->passive);
> +		tz->passive = 0;
>   		return;
>   	}
>   
> -	tz->passive = 1;
> -
>   	allocate_power(tz, params->trip_max->temperature);
> +	tz->passive = 1;
>   }
>   
>   static struct thermal_governor thermal_gov_power_allocator = {
> 
> 
> 


LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

