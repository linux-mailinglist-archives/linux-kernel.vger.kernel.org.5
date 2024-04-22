Return-Path: <linux-kernel+bounces-153277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2621C8ACBD4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D79285C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FD41465BD;
	Mon, 22 Apr 2024 11:15:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5314658F;
	Mon, 22 Apr 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784508; cv=none; b=DHlAZgEfZJ/9bpRKoXh5WGxnUODYrOyyWNYzM1z6PhPqX46NtUsUud7Hux70Egk9C6Bbjc2epq477OPsXyb1X+/btEhMn1hAnGAq7gp+EAZRaStK2OGjaoJW91LKBmst9o0baSHdl7NQGHQ69/J1E/5hAptY6+4ZWFIK9pqqa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784508; c=relaxed/simple;
	bh=afWU35eQev2NDUVQ0DQmt6zhLxwVAFT56hjj7hhapOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6GSiN24CG+AFf39zSseHMq7snrJV+yjPeu4X9QtRPmqpWjz8UfQs+KxycMxYMo09huFhN1LQphJfvw5h06AN+oxs9UfQ584Q1y5CedhrxCDrU9N/j1hmklQyXy0Bkb67gB22pPMGygNJ0U0UMmyrtu4lx6O7cg2uB126/1whTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82ADF339;
	Mon, 22 Apr 2024 04:15:34 -0700 (PDT)
Received: from [10.57.75.149] (unknown [10.57.75.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570AB3F7BD;
	Mon, 22 Apr 2024 04:15:05 -0700 (PDT)
Message-ID: <bf96cf30-3698-424d-8d6c-722514529005@arm.com>
Date: Mon, 22 Apr 2024 12:15:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal/debugfs: Clean up
 thermal_debug_update_temp()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <4918025.31r3eYUQgx@kreacher> <2185763.irdbgypaU6@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2185763.irdbgypaU6@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 14:10, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that it is not necessary to compute tze in every iteration of the
> for () loop in thermal_debug_update_temp() because it is the same for all
> trips, so compute it once before the loop starts.
> 
> Also use a trip_stats local variable to make the code in that loop easier
> to follow and move the trip_id variable definition into that loop because
> it is not used elsewhere in the function.
> 
> While at it, change to order of local variable definitions in the function
> to follow the reverse-xmas-tree pattern.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_debugfs.c |   21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -679,9 +679,9 @@ out:
>   void thermal_debug_update_temp(struct thermal_zone_device *tz)
>   {
>   	struct thermal_debugfs *thermal_dbg = tz->debugfs;
> -	struct tz_episode *tze;
>   	struct tz_debugfs *tz_dbg;
> -	int trip_id, i;
> +	struct tz_episode *tze;
> +	int i;
>   
>   	if (!thermal_dbg)
>   		return;
> @@ -693,15 +693,16 @@ void thermal_debug_update_temp(struct th
>   	if (!tz_dbg->nr_trips)
>   		goto out;
>   
> +	tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
> +
>   	for (i = 0; i < tz_dbg->nr_trips; i++) {
> -		trip_id = tz_dbg->trips_crossed[i];
> -		tze = list_first_entry(&tz_dbg->tz_episodes, struct tz_episode, node);
> -		tze->trip_stats[trip_id].count++;
> -		tze->trip_stats[trip_id].max = max(tze->trip_stats[trip_id].max, tz->temperature);
> -		tze->trip_stats[trip_id].min = min(tze->trip_stats[trip_id].min, tz->temperature);
> -		tze->trip_stats[trip_id].avg = tze->trip_stats[trip_id].avg +
> -			(tz->temperature - tze->trip_stats[trip_id].avg) /
> -			tze->trip_stats[trip_id].count;
> +		int trip_id = tz_dbg->trips_crossed[i];
> +		struct trip_stats *trip_stats = &tze->trip_stats[trip_id];
> +
> +		trip_stats->max = max(trip_stats->max, tz->temperature);
> +		trip_stats->min = min(trip_stats->min, tz->temperature);
> +		trip_stats->avg += (tz->temperature - trip_stats->avg) /
> +					++trip_stats->count;
>   	}
>   out:
>   	mutex_unlock(&thermal_dbg->lock);
> 
> 
> 
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

