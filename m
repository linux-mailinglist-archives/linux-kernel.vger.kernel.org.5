Return-Path: <linux-kernel+bounces-57603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699484DB47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE593B2114B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEE6A33F;
	Thu,  8 Feb 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvOZuqj1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DF6A03F;
	Thu,  8 Feb 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380553; cv=none; b=OLKE3JdIqfvPhjacAKQ4UVvwflt8F7+iVfb+sy8BKEi9XJKa6cImBtrQ5O3TfE7rLC8vmWzTmV/ZUBWzMrxQNnKc1akAFAOlw4bH9XMq1lLS5tiZAwM48g0B0GCWvocGkZX4+K6UZTgKS/V8RQOArS7vyvg1Mq5kztFjyPbl3Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380553; c=relaxed/simple;
	bh=qOZaEMdkcUVVl1kqdqTAfhJZVkgvdp0nC1uG5eTs4ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJtkOo9x+3NaFGxmKiZ5PW8Y+jqCcdHIvgNRDZ8mDiBNJ3qMxiBw+13JA66pZfm0EjsTBSk5LpO0NQUO+gIe3u2TKFH+5NglxBDMx7QYhxxQ3AeIbWunlld8lLwAR5nHtBAG+2gbLjsZahL+0HqQPw1LHTLdQ0iLwI1faILNjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvOZuqj1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380551; x=1738916551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qOZaEMdkcUVVl1kqdqTAfhJZVkgvdp0nC1uG5eTs4ho=;
  b=YvOZuqj19IMQkQXkPVtC03oYZgW4zsCvkOJhSpna/f63G0vkb8duRBv5
   v60wctykBuuOamz2mwTxpnqFZkTUyEPnMj5WzH8dqJlqJmoRfcsonT9L9
   6q7jK9ajj1T4Ke39aBOxCtOHSxSeHOC1vtwana0CohdUAjFlVGbCgzPVQ
   JfGKpkJ+bEY1iin1FaU5e4hd0PQ8iOLZ7lB0rLlyhEz2pD+xCZ15f+kI1
   ZPm89dbjX9ZRbwUR4AT3sXECOgfNZ+4ppG4e46xUqLI9xI8xwE2+C7ZAe
   uHqBbzRhLYB8liQ9MEPHvViXlZCRw/6rSPapNK5gkdaj++9L8+erGi9JN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4953401"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="4953401"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="39014953"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:22:28 -0800
Date: Thu, 8 Feb 2024 09:22:25 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 2/6] thermal: ACPI: Discard trip table after zone
 registration
Message-ID: <ZcSPQW0VF8ooBxOR@linux.intel.com>
References: <2728491.mvXUDI8C0e@kreacher>
 <4905992.31r3eYUQgx@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4905992.31r3eYUQgx@kreacher>

On Mon, Feb 05, 2024 at 10:15:50PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the thermal core creates and uses its own copy of the trips
> table passed to thermal_zone_device_register_with_trips(), it is not
> necessary to hold on to a local copy of it any more after the given
> thermal zone has been registered.
> 
> Accordingly, modify the ACPI thermal driver to store the trips table
> passed to thermal_zone_device_register_with_trips() in a local variable
> which is automatically discarded after the zone registration.
> 
> Also make some additional code simplifications unlocked by the above
> change.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/acpi/thermal.c |   57 +++++++++++++++++--------------------------------
>  1 file changed, 20 insertions(+), 37 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -47,6 +47,8 @@
>  
>  #define ACPI_THERMAL_TRIP_PASSIVE	(-1)
>  
> +#define ACPI_THERMAL_MAX_NR_TRIPS	(ACPI_THERMAL_MAX_ACTIVE + 3)
> +
>  /*
>   * This exception is thrown out in two cases:
>   * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
> @@ -112,7 +114,6 @@ struct acpi_thermal {
>  	unsigned long polling_frequency;
>  	volatile u8 zombie;
>  	struct acpi_thermal_trips trips;
> -	struct thermal_trip *trip_table;
>  	struct thermal_zone_device *thermal_zone;
>  	int kelvin_offset;	/* in millidegrees */
>  	struct work_struct thermal_check_work;
> @@ -451,26 +452,19 @@ fail:
>  	return false;
>  }
>  
> -static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
> +static void acpi_thermal_get_trip_points(struct acpi_thermal *tz)
>  {
> -	unsigned int count = 0;
>  	int i;
>  
> -	if (acpi_thermal_init_trip(tz, ACPI_THERMAL_TRIP_PASSIVE))
> -		count++;
> +	acpi_thermal_init_trip(tz, ACPI_THERMAL_TRIP_PASSIVE);
>  
>  	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> -		if (acpi_thermal_init_trip(tz, i))
> -			count++;
> -		else
> +		if (!acpi_thermal_init_trip(tz, i))
>  			break;
> -
>  	}
>  
>  	while (++i < ACPI_THERMAL_MAX_ACTIVE)
>  		tz->trips.active[i].trip.temp_dk = THERMAL_TEMP_INVALID;
> -
> -	return count;
>  }
>  
>  /* sys I/F for generic thermal sysfs support */
> @@ -662,13 +656,14 @@ static void acpi_thermal_zone_sysfs_remo
>  }
>  
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
> +					      const struct thermal_trip *trip_table,
>  					      unsigned int trip_count,
>  					      int passive_delay)
>  {
>  	int result;
>  
>  	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
> -								   tz->trip_table,
> +								   trip_table,
>  								   trip_count,
>  								   0, tz,
>  								   &acpi_thermal_zone_ops,
> @@ -823,10 +818,10 @@ static void acpi_thermal_free_thermal_zo
>  
>  static int acpi_thermal_add(struct acpi_device *device)
>  {
> +	struct thermal_trip trip_table[ACPI_THERMAL_MAX_NR_TRIPS] = { 0 };
>  	struct acpi_thermal_trip *acpi_trip;
>  	struct thermal_trip *trip;
>  	struct acpi_thermal *tz;
> -	unsigned int trip_count;
>  	int crit_temp, hot_temp;
>  	int passive_delay = 0;
>  	int result;
> @@ -848,21 +843,10 @@ static int acpi_thermal_add(struct acpi_
>  	acpi_thermal_aml_dependency_fix(tz);
>  
>  	/* Get trip points [_CRT, _PSV, etc.] (required). */
> -	trip_count = acpi_thermal_get_trip_points(tz);
> +	acpi_thermal_get_trip_points(tz);
>  
>  	crit_temp = acpi_thermal_get_critical_trip(tz);
> -	if (crit_temp != THERMAL_TEMP_INVALID)
> -		trip_count++;
> -
>  	hot_temp = acpi_thermal_get_hot_trip(tz);
> -	if (hot_temp != THERMAL_TEMP_INVALID)
> -		trip_count++;
> -
> -	if (!trip_count) {
> -		pr_warn(FW_BUG "No valid trip points!\n");
> -		result = -ENODEV;
> -		goto free_memory;
> -	}
>  
>  	/* Get temperature [_TMP] (required). */
>  	result = acpi_thermal_get_temperature(tz);
> @@ -881,13 +865,7 @@ static int acpi_thermal_add(struct acpi_
>  
>  	acpi_thermal_guess_offset(tz, crit_temp);
>  
> -	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
> -	if (!trip) {
> -		result = -ENOMEM;
> -		goto free_memory;
> -	}
> -
> -	tz->trip_table = trip;
> +	trip = trip_table;
>  
>  	if (crit_temp != THERMAL_TEMP_INVALID) {
>  		trip->type = THERMAL_TRIP_CRITICAL;
> @@ -923,9 +901,17 @@ static int acpi_thermal_add(struct acpi_
>  		trip++;
>  	}
>  
> -	result = acpi_thermal_register_thermal_zone(tz, trip_count, passive_delay);
> +	if (trip == trip_table) {
> +		pr_warn(FW_BUG "No valid trip points!\n");
> +		result = -ENODEV;
> +		goto free_memory;
> +	}
> +
> +	result = acpi_thermal_register_thermal_zone(tz, trip_table,
> +						    trip - trip_table,
> +						    passive_delay);
>  	if (result)
> -		goto free_trips;
> +		goto free_memory;
>  
>  	refcount_set(&tz->thermal_check_count, 3);
>  	mutex_init(&tz->thermal_check_lock);
> @@ -944,8 +930,6 @@ static int acpi_thermal_add(struct acpi_
>  flush_wq:
>  	flush_workqueue(acpi_thermal_pm_queue);
>  	acpi_thermal_unregister_thermal_zone(tz);
> -free_trips:
> -	kfree(tz->trip_table);
>  free_memory:
>  	acpi_thermal_free_thermal_zone(tz);
>  
> @@ -966,7 +950,6 @@ static void acpi_thermal_remove(struct a
>  
>  	flush_workqueue(acpi_thermal_pm_queue);
>  	acpi_thermal_unregister_thermal_zone(tz);
> -	kfree(tz->trip_table);
>  	acpi_thermal_free_thermal_zone(tz);
>  }
>  
> 
> 
> 

