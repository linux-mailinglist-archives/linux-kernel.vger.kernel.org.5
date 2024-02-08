Return-Path: <linux-kernel+bounces-57602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 870E184DB44
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2C61C21A22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7966A336;
	Thu,  8 Feb 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXdm7Kpr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C16A327;
	Thu,  8 Feb 2024 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380538; cv=none; b=AcM23LdPdGbK9xG+rFKbCyPUdQAT7k6zbZOVjv6R7fA2vlCXeGVs/0xAj2mmTHK/DqShMkqSEwGzsdPtpcyLonV1mJFBlRTOHAyTieQGDn0Ep61EQDdy2qqgLNRkkUN9oa5rOn9jQE8AxYpecYdbugDDBVX4G5ei0kt/8psQ2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380538; c=relaxed/simple;
	bh=SE/s3lYJpb9Q+n9pVf/ojtKtqy8zqqmwKN+tZ8ySURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArCNjTKBDyk6KwLa1qedSVVCOrU+cjH6OMASOHJP9p11uMT0jxkcf24fmhS9zOqYktuFQ7jxGkbyzSIt7HmqXalrVReH+o1nbLw5qAm8rqc8bK2T0nAszBwTvWz8wHbEJ5PbiOg4qEpn7HCT9GPXf2fsaVr7Hjf867xkZ1LbqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXdm7Kpr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380536; x=1738916536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SE/s3lYJpb9Q+n9pVf/ojtKtqy8zqqmwKN+tZ8ySURE=;
  b=mXdm7KprdbcG7Pi4CYJBAujOFoQYrwuB54H3xliX4sH9i8E40crKwk0j
   Pihaw1wgIjlKJ7bCpH6ccd6rbUcrJsAjFhtxo8kc+c2/Hs0aG0ionxlmZ
   AnE6NKwTMuAj6tSxbrQ/iLs1fJgGHbVZCRPKXb/FFMfG+f0HIhoFzvTTJ
   +tDDks+EwvjwxWSTncD29SyETAoG6k9YT83O9damAwywL7SznjaU6qeY/
   K8FbWG6AL0ouvVZMiMHUtP4cU5zR5Abpz4eNyRRbLgbqvgWvBRynr8cOK
   3/a8ZSp5HA2DvE8+gSwwDy5FSfWWteVDvbjzrtZVJQzl/al6lzMEI46RB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4953284"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="4953284"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:22:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="39014851"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:22:12 -0800
Date: Thu, 8 Feb 2024 09:22:09 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/6] thermal: core: Store zone trips table in struct
 thermal_zone_device
Message-ID: <ZcSPMRH34M5yG/IU@linux.intel.com>
References: <2728491.mvXUDI8C0e@kreacher>
 <5762433.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5762433.DvuYhMxLoT@kreacher>

On Mon, Feb 05, 2024 at 10:14:31PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code requires thermal zone creators to pass a pointer to a
> writable trips table to thermal_zone_device_register_with_trips() and
> that trips table is then used by the thermal core going forward.
> 
> Consequently, the callers of thermal_zone_device_register_with_trips()
> are required to hold on to the trips table passed to it until the given
> thermal zone is unregistered, at which point the trips table can be
> freed, but at the same time they are not allowed to access the cells in
> that table directly.  This is both error prone and confusing.
> 
> To address it, turn the trips table pointer in struct thermal_zone_device
> into a flex array (counted by its num_trips field), allocate it during
> thermal zone device allocation and copy the contents of the trips table
> supplied by the zone creator (which can be const now) into it.
> 
> This allows the callers of thermal_zone_device_register_with_trips() to
> drop their trip tables right after the zone registration.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/thermal/thermal_core.c |   16 +++++++++-------
>  include/linux/thermal.h        |   10 +++++-----
>  2 files changed, 14 insertions(+), 12 deletions(-)
> 
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -130,7 +130,6 @@ struct thermal_cooling_device {
>   * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
>   * @mode:		current mode of this thermal zone
>   * @devdata:	private pointer for device private data
> - * @trips:	an array of struct thermal_trip
>   * @num_trips:	number of trip points the thermal zone supports
>   * @passive_delay_jiffies: number of jiffies to wait between polls when
>   *			performing passive cooling.
> @@ -160,6 +159,7 @@ struct thermal_cooling_device {
>   * @poll_queue:	delayed work for polling
>   * @notify_event: Last notification event
>   * @suspended: thermal zone suspend indicator
> + * @trips:	array of struct thermal_trip objects
>   */
>  struct thermal_zone_device {
>  	int id;
> @@ -172,7 +172,6 @@ struct thermal_zone_device {
>  	struct thermal_attr *trip_hyst_attrs;
>  	enum thermal_device_mode mode;
>  	void *devdata;
> -	struct thermal_trip *trips;
>  	int num_trips;
>  	unsigned long passive_delay_jiffies;
>  	unsigned long polling_delay_jiffies;
> @@ -193,10 +192,11 @@ struct thermal_zone_device {
>  	struct list_head node;
>  	struct delayed_work poll_queue;
>  	enum thermal_notify_event notify_event;
> +	bool suspended;
>  #ifdef CONFIG_THERMAL_DEBUGFS
>  	struct thermal_debugfs *debugfs;
>  #endif
> -	bool suspended;
> +	struct thermal_trip trips[] __counted_by(num_trips);
>  };
>  
>  /**
> @@ -315,7 +315,7 @@ int thermal_zone_get_crit_temp(struct th
>  #ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register_with_trips(
>  					const char *type,
> -					struct thermal_trip *trips,
> +					const struct thermal_trip *trips,
>  					int num_trips, int mask,
>  					void *devdata,
>  					struct thermal_zone_device_ops *ops,
> @@ -375,7 +375,7 @@ void thermal_zone_device_critical(struct
>  #else
>  static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
>  					const char *type,
> -					struct thermal_trip *trips,
> +					const struct thermal_trip *trips,
>  					int num_trips, int mask,
>  					void *devdata,
>  					struct thermal_zone_device_ops *ops,
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1272,10 +1272,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
>   * IS_ERR*() helpers.
>   */
>  struct thermal_zone_device *
> -thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
> -					void *devdata, struct thermal_zone_device_ops *ops,
> -					const struct thermal_zone_params *tzp, int passive_delay,
> -					int polling_delay)
> +thermal_zone_device_register_with_trips(const char *type,
> +					const struct thermal_trip *trips,
> +					int num_trips, int mask,
> +					void *devdata,
> +					struct thermal_zone_device_ops *ops,
> +					const struct thermal_zone_params *tzp,
> +					int passive_delay, int polling_delay)
>  {
>  	struct thermal_zone_device *tz;
>  	int id;
> @@ -1322,7 +1325,7 @@ thermal_zone_device_register_with_trips(
>  	if (!thermal_class)
>  		return ERR_PTR(-ENODEV);
>  
> -	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
> +	tz = kzalloc(struct_size(tz, trips, num_trips), GFP_KERNEL);
>  	if (!tz)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1344,7 +1347,6 @@ thermal_zone_device_register_with_trips(
>  		result = id;
>  		goto free_tzp;
>  	}
> -
>  	tz->id = id;
>  	strscpy(tz->type, type, sizeof(tz->type));
>  
> @@ -1354,7 +1356,7 @@ thermal_zone_device_register_with_trips(
>  	tz->ops = ops;
>  	tz->device.class = thermal_class;
>  	tz->devdata = devdata;
> -	tz->trips = trips;
> +	memcpy(tz->trips, trips, num_trips * sizeof(trips[0]));
>  	tz->num_trips = num_trips;
>  
>  	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
> 
> 
> 
> 

