Return-Path: <linux-kernel+bounces-57659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E336484DBE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97308281BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC56BFB1;
	Thu,  8 Feb 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVc7MMkU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC36BFA1;
	Thu,  8 Feb 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382140; cv=none; b=GVxbr5cgakMOTWzoEuazmM/8pZQyte5BJk/sepuNMEQGRf0l1O1Rl1oTmvAii676espUBDERlhRh64YPQhrH1VpzCgbetNBAHIOzG78SWWDAj3ZmQaQ8hj5Ni5Lvhmoq/S1pM6+Je1Jz+ACgHwwvE89dLSA9LMVdggHN2Gd/Ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382140; c=relaxed/simple;
	bh=A8risXt2YQC/LWIdp/0fHWzodspwG8pM44llSrUmEYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV5GexdDd44JSGBqD3UWVNuGy1CUY2hsEanyKxgXQLaRbYLTLAssB+5l9p1EAY31Ca8iQ+QCcT/okGiaOtx9TgMhdFWPC5XtjbNP182neH1p0/5QlfdHFlTTSISK+NlZXTrCofDdAW1LhH4QvkQPlrRjDxplmQR9uT2nUXVxXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVc7MMkU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382138; x=1738918138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A8risXt2YQC/LWIdp/0fHWzodspwG8pM44llSrUmEYs=;
  b=XVc7MMkUm6VqXzRnoq7xBtXcLK3KTWp27WZnbcSM6ZQPxo+fkJ+/1xyN
   bZKTG8gd+hBsIikasx3802kydMl7Gv3qWnAj82ekgXmTcuU/QYVK0o/FI
   HEnSdeu3WzSZlw8Ji9LoeSS5vtffntk0y2vyggBEfVo4wYW1ewpvIkd+q
   B9FycHaRzQOouQIUxZxBYMQigJvYxfF5MaED2ifVCsbjrH2L9uWupoblz
   xw9NRpYIdTLV67vgY9s4nIbaMT1VPijABerwtM2gzZg6Sc3EejAMsM+U3
   Z/peoyxlbDqsHh3ICnVw02AJYYPTvl5/fUJiyTXqTKlTGzB0zaVxY1lLz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1328231"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1328231"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1588143"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:48:54 -0800
Date: Thu, 8 Feb 2024 09:48:51 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 4/6] thermal: core: Store zone ops in struct
 thermal_zone_device
Message-ID: <ZcSVc4WiS0TkUEmu@linux.intel.com>
References: <2728491.mvXUDI8C0e@kreacher>
 <1888343.tdWV9SEqCh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1888343.tdWV9SEqCh@kreacher>

On Mon, Feb 05, 2024 at 10:18:02PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code requires thermal zone creators to pass pointers to
> writable ops to thermal_zone_device_register_with_trips() which needs
> to modify the target struct thermal_zone_device_ops object if the
> "critical" operation in it is NULL.
> 
> Moreover, the callers of thermal_zone_device_register_with_trips() are
> required to hold on to the struct thermal_zone_device_ops object passed
> to it until the given thermal zone is unregistered.
> 
> Both of these requirements are quite inconvenient, so modify struct
> thermal_zone_device to contain struct thermal_zone_device_ops as field and
> make thermal_zone_device_register_with_trips() copy the contents of the
> struct thermal_zone_device_ops passed to it via a pointer (which can be
> const now) to that field.  Also adjust the code using thermal zone ops
> accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/thermal/thermal_core.c    |   40 +++++++++++++++++++-------------------
>  drivers/thermal/thermal_helpers.c |   10 ++++-----
>  drivers/thermal/thermal_hwmon.c   |    4 +--
>  drivers/thermal/thermal_sysfs.c   |   12 +++++------
>  drivers/thermal/thermal_trip.c    |    4 +--
>  include/linux/thermal.h           |    6 ++---
>  6 files changed, 38 insertions(+), 38 deletions(-)
> 
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -182,7 +182,7 @@ struct thermal_zone_device {
>  	int prev_low_trip;
>  	int prev_high_trip;
>  	atomic_t need_update;
> -	struct thermal_zone_device_ops *ops;
> +	struct thermal_zone_device_ops ops;
>  	struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;
>  	void *governor_data;
> @@ -318,14 +318,14 @@ struct thermal_zone_device *thermal_zone
>  					const struct thermal_trip *trips,
>  					int num_trips, int mask,
>  					void *devdata,
> -					struct thermal_zone_device_ops *ops,
> +					const struct thermal_zone_device_ops *ops,
>  					const struct thermal_zone_params *tzp,
>  					int passive_delay, int polling_delay);
>  
>  struct thermal_zone_device *thermal_tripless_zone_device_register(
>  					const char *type,
>  					void *devdata,
> -					struct thermal_zone_device_ops *ops,
> +					const struct thermal_zone_device_ops *ops,
>  					const struct thermal_zone_params *tzp);
>  
>  void thermal_zone_device_unregister(struct thermal_zone_device *tz);
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -356,9 +356,9 @@ static void handle_critical_trips(struct
>  	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
>  
>  	if (trip->type == THERMAL_TRIP_CRITICAL)
> -		tz->ops->critical(tz);
> -	else if (tz->ops->hot)
> -		tz->ops->hot(tz);
> +		tz->ops.critical(tz);
> +	else if (tz->ops.hot)
> +		tz->ops.hot(tz);
>  }
>  
>  static void handle_thermal_trip(struct thermal_zone_device *tz,
> @@ -493,8 +493,8 @@ static int thermal_zone_device_set_mode(
>  		return ret;
>  	}
>  
> -	if (tz->ops->change_mode)
> -		ret = tz->ops->change_mode(tz, mode);
> +	if (tz->ops.change_mode)
> +		ret = tz->ops.change_mode(tz, mode);
>  
>  	if (!ret)
>  		tz->mode = mode;
> @@ -867,8 +867,8 @@ static void bind_cdev(struct thermal_coo
>  	struct thermal_zone_device *pos = NULL;
>  
>  	list_for_each_entry(pos, &thermal_tz_list, node) {
> -		if (pos->ops->bind) {
> -			ret = pos->ops->bind(pos, cdev);
> +		if (pos->ops.bind) {
> +			ret = pos->ops.bind(pos, cdev);
>  			if (ret)
>  				print_bind_err_msg(pos, cdev, ret);
>  		}
> @@ -1184,8 +1184,8 @@ void thermal_cooling_device_unregister(s
>  
>  	/* Unbind all thermal zones associated with 'this' cdev */
>  	list_for_each_entry(tz, &thermal_tz_list, node) {
> -		if (tz->ops->unbind)
> -			tz->ops->unbind(tz, cdev);
> +		if (tz->ops.unbind)
> +			tz->ops.unbind(tz, cdev);
>  	}
>  
>  	mutex_unlock(&thermal_list_lock);
> @@ -1199,13 +1199,13 @@ static void bind_tz(struct thermal_zone_
>  	int ret;
>  	struct thermal_cooling_device *pos = NULL;
>  
> -	if (!tz->ops->bind)
> +	if (!tz->ops.bind)
>  		return;
>  
>  	mutex_lock(&thermal_list_lock);
>  
>  	list_for_each_entry(pos, &thermal_cdev_list, node) {
> -		ret = tz->ops->bind(tz, pos);
> +		ret = tz->ops.bind(tz, pos);
>  		if (ret)
>  			print_bind_err_msg(tz, pos, ret);
>  	}
> @@ -1224,8 +1224,8 @@ int thermal_zone_get_crit_temp(struct th
>  {
>  	int i, ret = -EINVAL;
>  
> -	if (tz->ops->get_crit_temp)
> -		return tz->ops->get_crit_temp(tz, temp);
> +	if (tz->ops.get_crit_temp)
> +		return tz->ops.get_crit_temp(tz, temp);
>  
>  	if (!tz->trips)
>  		return -EINVAL;
> @@ -1276,7 +1276,7 @@ thermal_zone_device_register_with_trips(
>  					const struct thermal_trip *trips,
>  					int num_trips, int mask,
>  					void *devdata,
> -					struct thermal_zone_device_ops *ops,
> +					const struct thermal_zone_device_ops *ops,
>  					const struct thermal_zone_params *tzp,
>  					int passive_delay, int polling_delay)
>  {
> @@ -1350,10 +1350,10 @@ thermal_zone_device_register_with_trips(
>  	tz->id = id;
>  	strscpy(tz->type, type, sizeof(tz->type));
>  
> -	if (!ops->critical)
> -		ops->critical = thermal_zone_device_critical;
> +	tz->ops = *ops;
> +	if (!tz->ops.critical)
> +		tz->ops.critical = thermal_zone_device_critical;
>  
> -	tz->ops = ops;
>  	tz->device.class = thermal_class;
>  	tz->devdata = devdata;
>  	memcpy(tz->trips, trips, num_trips * sizeof(trips[0]));
> @@ -1439,7 +1439,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_re
>  struct thermal_zone_device *thermal_tripless_zone_device_register(
>  					const char *type,
>  					void *devdata,
> -					struct thermal_zone_device_ops *ops,
> +					const struct thermal_zone_device_ops *ops,
>  					const struct thermal_zone_params *tzp)
>  {
>  	return thermal_zone_device_register_with_trips(type, NULL, 0, 0, devdata,
> @@ -1501,8 +1501,8 @@ void thermal_zone_device_unregister(stru
>  
>  	/* Unbind all cdevs associated with 'this' thermal zone */
>  	list_for_each_entry(cdev, &thermal_cdev_list, node)
> -		if (tz->ops->unbind)
> -			tz->ops->unbind(tz, cdev);
> +		if (tz->ops.unbind)
> +			tz->ops.unbind(tz, cdev);
>  
>  	mutex_unlock(&thermal_list_lock);
>  
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -123,8 +123,8 @@ trip_point_temp_store(struct device *dev
>  	trip = &tz->trips[trip_id];
>  
>  	if (temp != trip->temperature) {
> -		if (tz->ops->set_trip_temp) {
> -			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
> +		if (tz->ops.set_trip_temp) {
> +			ret = tz->ops.set_trip_temp(tz, trip_id, temp);
>  			if (ret)
>  				goto unlock;
>  		}
> @@ -174,8 +174,8 @@ trip_point_hyst_store(struct device *dev
>  	trip = &tz->trips[trip_id];
>  
>  	if (hyst != trip->hysteresis) {
> -		if (tz->ops->set_trip_hyst) {
> -			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
> +		if (tz->ops.set_trip_hyst) {
> +			ret = tz->ops.set_trip_hyst(tz, trip_id, hyst);
>  			if (ret)
>  				goto unlock;
>  		}
> @@ -250,10 +250,10 @@ emul_temp_store(struct device *dev, stru
>  
>  	mutex_lock(&tz->lock);
>  
> -	if (!tz->ops->set_emul_temp)
> +	if (!tz->ops.set_emul_temp)
>  		tz->emul_temperature = temperature;
>  	else
> -		ret = tz->ops->set_emul_temp(tz, temperature);
> +		ret = tz->ops.set_emul_temp(tz, temperature);
>  
>  	if (!ret)
>  		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -26,8 +26,8 @@ int get_tz_trend(struct thermal_zone_dev
>  {
>  	enum thermal_trend trend;
>  
> -	if (tz->emul_temperature || !tz->ops->get_trend ||
> -	    tz->ops->get_trend(tz, trip, &trend)) {
> +	if (tz->emul_temperature || !tz->ops.get_trend ||
> +	    tz->ops.get_trend(tz, trip, &trend)) {
>  		if (tz->temperature > tz->last_temperature)
>  			trend = THERMAL_TREND_RAISING;
>  		else if (tz->temperature < tz->last_temperature)
> @@ -75,7 +75,7 @@ EXPORT_SYMBOL(get_thermal_instance);
>   * temperature and fill @temp.
>   *
>   * Both tz and tz->ops must be valid pointers when calling this function,
> - * and the tz->ops->get_temp callback must be provided.
> + * and the tz->ops.get_temp callback must be provided.
>   * The function must be called under tz->lock.
>   *
>   * Return: On success returns 0, an error code otherwise
> @@ -88,7 +88,7 @@ int __thermal_zone_get_temp(struct therm
>  
>  	lockdep_assert_held(&tz->lock);
>  
> -	ret = tz->ops->get_temp(tz, temp);
> +	ret = tz->ops.get_temp(tz, temp);
>  
>  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
>  		for_each_trip(tz, trip) {
> @@ -132,7 +132,7 @@ int thermal_zone_get_temp(struct thermal
>  
>  	mutex_lock(&tz->lock);
>  
> -	if (!tz->ops->get_temp) {
> +	if (!tz->ops.get_temp) {
>  		ret = -EINVAL;
>  		goto unlock;
>  	}
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -70,7 +70,7 @@ void __thermal_zone_set_trips(struct the
>  
>  	lockdep_assert_held(&tz->lock);
>  
> -	if (!tz->ops->set_trips)
> +	if (!tz->ops.set_trips)
>  		return;
>  
>  	for_each_trip(tz, trip) {
> @@ -114,7 +114,7 @@ void __thermal_zone_set_trips(struct the
>  	 * Set a temperature window. When this window is left the driver
>  	 * must inform the thermal core via thermal_zone_device_update.
>  	 */
> -	ret = tz->ops->set_trips(tz, low, high);
> +	ret = tz->ops.set_trips(tz, low, high);
>  	if (ret)
>  		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
>  }
> Index: linux-pm/drivers/thermal/thermal_hwmon.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_hwmon.c
> +++ linux-pm/drivers/thermal/thermal_hwmon.c
> @@ -80,7 +80,7 @@ temp_crit_show(struct device *dev, struc
>  
>  	mutex_lock(&tz->lock);
>  
> -	ret = tz->ops->get_crit_temp(tz, &temperature);
> +	ret = tz->ops.get_crit_temp(tz, &temperature);
>  
>  	mutex_unlock(&tz->lock);
>  
> @@ -132,7 +132,7 @@ thermal_hwmon_lookup_temp(const struct t
>  static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *tz)
>  {
>  	int temp;
> -	return tz->ops->get_crit_temp && !tz->ops->get_crit_temp(tz, &temp);
> +	return tz->ops.get_crit_temp && !tz->ops.get_crit_temp(tz, &temp);
>  }
>  
>  int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> 
> 
> 

