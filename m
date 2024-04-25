Return-Path: <linux-kernel+bounces-159169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7258B2A31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DBEB259D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E98154BE0;
	Thu, 25 Apr 2024 20:54:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764611720;
	Thu, 25 Apr 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078475; cv=none; b=hVY9nY196sOlxSA5UkhHgKOcPHfl2fgnTEM8rMUgSBJwd5tgqoy6udTi+27YD/CdGCay+iccC9Ouwvv2Ajzw+Yx7h+X1WNtHjL9aAvl7cUSj6fZPB26adzQ4qAnj2CsqqWeRuLPyCpYZ35prgMbsSdBpw8dJNvDWFe1EuV7aoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078475; c=relaxed/simple;
	bh=Ln6jSr30HJLbKHl6Ffl7zzzn7xZ/vqKzjdgoixZhPyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Red/QolloJCp9tvezvlP6HNsqyNHkKiYBBjtyBLfvnRYnjJBUV8TRunjlSvq+nCkyMikKrEbl/xGGy0tGcH0IVZzKUZ0J48VlbLJ4zb0EpVQm2qpjwbq4qx6HPWSgxS18uOJqKPXomNoENwoKEof8O+RYzdgbh1fxxVGpYNmH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC1AD2F;
	Thu, 25 Apr 2024 13:55:00 -0700 (PDT)
Received: from [10.57.64.58] (unknown [10.57.64.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0F7D3F73F;
	Thu, 25 Apr 2024 13:54:31 -0700 (PDT)
Message-ID: <c99f1b95-edad-4a27-8bdf-76164955348f@arm.com>
Date: Thu, 25 Apr 2024 21:54:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] thermal/debugfs: Avoid printing zero duration for
 mitigation events in progress
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <3297002.44csPzL39Z@kreacher> <7659098.EvYhyI6sBW@kreacher>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7659098.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/25/24 15:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a thermal mitigation event is in progress, its duration value has
> not been updated yet, so 0 will be printed as the event duration by
> tze_seq_show() which is confusing.
> 
> Avoid doing that by marking the beginning of the event with the
> KTIME_MIN duration value and making tze_seq_show() compute the current
> event duration on the fly, in which case '>' will be printed instead of
> '=' in the event duration value field.
> 
> Similarly, for trip points that have been crossed on the down, mark
> the end of mitigation with the KTIME_MAX timestamp value and make
> tze_seq_show() compute the current duration on the fly for the trip
> points still involved in the mitigation, in which cases the duration
> value printed by it will be prepended with a '>' character.
> 
> Fixes: 7ef01f228c9f ("thermal/debugfs: Add thermal debugfs information for mitigation episodes")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_debugfs.c |   39 ++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -552,6 +552,7 @@ static struct tz_episode *thermal_debugf
>   
>   	INIT_LIST_HEAD(&tze->node);
>   	tze->timestamp = now;
> +	tze->duration = KTIME_MIN;
>   
>   	for (i = 0; i < tz->num_trips; i++) {
>   		tze->trip_stats[i].min = INT_MAX;
> @@ -680,6 +681,9 @@ void thermal_debug_tz_trip_down(struct t
>   	tze->trip_stats[trip_id].duration =
>   		ktime_add(delta, tze->trip_stats[trip_id].duration);
>   
> +	/* Mark the end of mitigation for this trip point. */
> +	tze->trip_stats[trip_id].timestamp = KTIME_MAX;
> +
>   	/*
>   	 * This event closes the mitigation as we are crossing the
>   	 * last trip point the way down.
> @@ -754,15 +758,25 @@ static int tze_seq_show(struct seq_file
>   	struct thermal_trip_desc *td;
>   	struct tz_episode *tze;
>   	const char *type;
> +	u64 duration_ms;
>   	int trip_id;
> +	char c;
>   
>   	tze = list_entry((struct list_head *)v, struct tz_episode, node);
>   
> -	seq_printf(s, ",-Mitigation at %lluus, duration=%llums\n",
> -		   ktime_to_us(tze->timestamp),
> -		   ktime_to_ms(tze->duration));
> +	if (tze->duration == KTIME_MIN) {
> +		/* Mitigation in progress. */
> +		duration_ms = ktime_to_ms(ktime_sub(ktime_get(), tze->timestamp));
> +		c = '>';
> +	} else {
> +		duration_ms = ktime_to_ms(tze->duration);
> +		c = '=';
> +	}
> +
> +	seq_printf(s, ",-Mitigation at %lluus, duration%c%llums\n",
> +		   ktime_to_us(tze->timestamp), c, duration_ms);
>   
> -	seq_printf(s, "| trip |     type | temp(°mC) | hyst(°mC) |  duration  |  avg(°mC) |  min(°mC) |  max(°mC) |\n");
> +	seq_printf(s, "| trip |     type | temp(°mC) | hyst(°mC) |  duration   |  avg(°mC) |  min(°mC) |  max(°mC) |\n");

So this one more space accounts for the new 'c' symbol in the rows
below that header, for the 'duration' column. Make sense.

>   
>   	for_each_trip_desc(tz, td) {
>   		const struct thermal_trip *trip = &td->trip;
> @@ -794,12 +808,25 @@ static int tze_seq_show(struct seq_file
>   		else
>   			type = "hot";
>   
> -		seq_printf(s, "| %*d | %*s | %*d | %*d | %*lld | %*d | %*d | %*d |\n",
> +		if (trip_stats->timestamp != KTIME_MAX) {
> +			/* Mitigation in progress. */
> +			ktime_t delta = ktime_sub(ktime_get(),
> +						  trip_stats->timestamp);
> +
> +			delta = ktime_add(delta, trip_stats->duration);
> +			duration_ms = ktime_to_ms(delta);
> +			c = '>';
> +		} else {
> +			duration_ms = ktime_to_ms(trip_stats->duration);
> +			c = ' ';
> +		}
> +
> +		seq_printf(s, "| %*d | %*s | %*d | %*d | %c%*lld | %*d | %*d | %*d |\n",
>   			   4 , trip_id,
>   			   8, type,
>   			   9, trip->temperature,
>   			   9, trip->hysteresis,
> -			   10, ktime_to_ms(trip_stats->duration),
> +			   c, 10, duration_ms,
>   			   9, trip_stats->avg,
>   			   9, trip_stats->min,
>   			   9, trip_stats->max);
> 
> 
> 
> 

The comments in code in this particular case helps, since treating
the KTIME_MIN/MAX values might become not obvious after a while.
That LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

