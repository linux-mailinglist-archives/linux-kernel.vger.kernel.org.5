Return-Path: <linux-kernel+bounces-131310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B16898607
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FEE28E66C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3182D72;
	Thu,  4 Apr 2024 11:26:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EA8286B;
	Thu,  4 Apr 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229998; cv=none; b=OcTY1ZyCplUCTnrmUZ3nLKJVDlUIf5GO64KXiyoQiBfrg5gF/pqPMqyzBRZzDex1zUwHE2rz1vDrDUninYpJYLyByJD/PUht2HfJglVGbwzq6mY3tTEFtGxaW+MxgMLxB2BSWI36vsuxjzvz8ItIeMeiN/ahB5s2Dvzb5xxLX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229998; c=relaxed/simple;
	bh=l2B8DsM6rv9m6KxY3JGKVlChYIWsAzS5o8y7YJPs8Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXyAApCZBuRJJCn+Vd/EyFefOJK8w73xwumP13XaNooIMOtpJ+c7EiGSn7djfSRXpsINHOmrLcLJPVeLOhU8Mj+tYUXv/tzjGFHmCaPYTgtEURnVYq/v9X8s+Qd1FBnqnZolPVMDgGb0MYS7LQK+oUch0lymRnnpD0V9YBea+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AAA7FEC;
	Thu,  4 Apr 2024 04:27:06 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BD103F7B4;
	Thu,  4 Apr 2024 04:26:34 -0700 (PDT)
Message-ID: <6f950b18-4ff7-4570-957d-49b46167c12e@arm.com>
Date: Thu, 4 Apr 2024 12:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] thermal: gov_step_wise: Simplify checks related to
 passive trips
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <5766468.DvuYhMxLoT@kreacher> <2318465.ElGaqSPkdT@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2318465.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 19:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it more clear from the code flow that the passive polling status
> updates only take place for passive trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |   14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -92,15 +92,13 @@ static void thermal_zone_trip_update(str
>   		if (instance->initialized && old_target == instance->target)
>   			continue;
>   
> -		if (old_target == THERMAL_NO_TARGET &&
> -		    instance->target != THERMAL_NO_TARGET) {
> -			/* Activate a passive thermal instance */
> -			if (trip->type == THERMAL_TRIP_PASSIVE)
> +		if (trip->type == THERMAL_TRIP_PASSIVE) {
> +			/* If needed, update the status of passive polling. */
> +			if (old_target == THERMAL_NO_TARGET &&
> +			    instance->target != THERMAL_NO_TARGET)
>   				tz->passive++;
> -		} else if (old_target != THERMAL_NO_TARGET &&
> -			   instance->target == THERMAL_NO_TARGET) {
> -			/* Deactivate a passive thermal instance */
> -			if (trip->type == THERMAL_TRIP_PASSIVE)
> +			else if (old_target != THERMAL_NO_TARGET &&
> +				 instance->target == THERMAL_NO_TARGET)
>   				tz->passive--;
>   		}
>   
> 
> 
> 

The patch looks good, although I got some warning while applying with
my b4 tool:
BADSIG: DKIM/rjwysocki.net

Anyway, it looks like false warning IMO.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

