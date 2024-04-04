Return-Path: <linux-kernel+bounces-131298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A192B8985DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31800B2517E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD4823AC;
	Thu,  4 Apr 2024 11:15:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CF80C09;
	Thu,  4 Apr 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229324; cv=none; b=aMsG51pn8kyvhzLn5/hK8u5H5VIY1DOao8dXwvx2alNCDBs6TWprwjSwulc+F2Drg5iLfUJzyIS5YqWqJ7UExbFiYVWflyba1GNvabonnEGDlMcBf9eiwIaGLj4SOGq3x4HThD0AVAJrRAaf6QSPsnzh//7lyXXrBn2ajIjTw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229324; c=relaxed/simple;
	bh=Gb6TQcZhy8zvbAqHNSQ5R13gtVldiV+tKWL8vvqYeV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZPLdZKv8wgsrhfb7HpW9FEtYlnhS+RHn3qP7gn2p9B9Tg7L81RhQUfNyuUejGIC5hRK7K1jIEZj0r0sKs6Y8KXI6P0rsto1mf70Bn1+3btF9Rzk5ABULd9jYcg/Mzoznuj4upncMhgYwDslptSbrtYbefOMi4aSASYIWQTjlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4E9FEC;
	Thu,  4 Apr 2024 04:15:52 -0700 (PDT)
Received: from [10.57.73.43] (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2B373F7B4;
	Thu,  4 Apr 2024 04:15:20 -0700 (PDT)
Message-ID: <7ebaa870-64d0-4944-bf62-d4ef1a97a1a9@arm.com>
Date: Thu, 4 Apr 2024 12:15:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] thermal: gov_step_wise: Simplify
 get_target_state()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <5766468.DvuYhMxLoT@kreacher> <4907519.31r3eYUQgx@kreacher>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <4907519.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 4/3/24 19:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The step-wise governor's get_target_state() function contains redundant
> braces, redundant parens and a redundant next_target local variable, so
> get rid of all that stuff.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/gov_step_wise.c |   27 ++++++++++-----------------
>   1 file changed, 10 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -32,7 +32,6 @@ static unsigned long get_target_state(st
>   {
>   	struct thermal_cooling_device *cdev = instance->cdev;
>   	unsigned long cur_state;
> -	unsigned long next_target;
>   
>   	/*
>   	 * We keep this instance the way it is by default.
> @@ -40,32 +39,26 @@ static unsigned long get_target_state(st
>   	 * cdev in use to determine the next_target.
>   	 */
>   	cdev->ops->get_cur_state(cdev, &cur_state);
> -	next_target = instance->target;
>   	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
>   
>   	if (!instance->initialized) {
> -		if (throttle) {
> -			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
> -		} else {
> -			next_target = THERMAL_NO_TARGET;
> -		}
> +		if (throttle)
> +			return clamp(cur_state + 1, instance->lower, instance->upper);
>   
> -		return next_target;
> +		return THERMAL_NO_TARGET;
>   	}
>   
>   	if (throttle) {
>   		if (trend == THERMAL_TREND_RAISING)
> -			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
> -	} else {
> -		if (trend == THERMAL_TREND_DROPPING) {
> -			if (cur_state <= instance->lower)
> -				next_target = THERMAL_NO_TARGET;
> -			else
> -				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
> -		}
> +			return clamp(cur_state + 1, instance->lower, instance->upper);
> +	} else if (trend == THERMAL_TREND_DROPPING) {
> +		if (cur_state <= instance->lower)
> +			return THERMAL_NO_TARGET;
> +
> +		return clamp(cur_state - 1, instance->lower, instance->upper);
>   	}
>   
> -	return next_target;
> +	return instance->target;
>   }
>   
>   static void thermal_zone_trip_update(struct thermal_zone_device *tz,
> 
> 
> 

LGTM,

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

