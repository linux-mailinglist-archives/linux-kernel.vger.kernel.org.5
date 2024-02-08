Return-Path: <linux-kernel+bounces-57624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9EB84DB8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7BF1C23F16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA12692E6;
	Thu,  8 Feb 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbGl1k6Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05167A00;
	Thu,  8 Feb 2024 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381418; cv=none; b=gQ5yWfk5eFLCqUwo7J5q7XztLqdpycEfzVSPnmbfkLKsUdqkMPKFl0IB9w3AG9JVUbmeHHQP2xmu9oUMwGYuAmSAQdx/C8RF5TIwJEGcYKRYe27rrocBkIRNeaZdGMDKesM8FAW6TTS4S+T+bzAybYMu8dznks9et1g++oOjGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381418; c=relaxed/simple;
	bh=t76IVYiXbKWkaw8zun2yu9J1QljUKHZoKZYIX0zYaBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5mNhIvNoFZkJhyS/RKKljzAf1Y6nz/hrStyIJHF/57l6okp7EYYzsMQA1XMgy5N0EefXqz0naJoQ+U6XWwEAUk9kbIg40GHADxZS3lVdEnxX2HDqHbv1pK5bQ7jpnpCcrFewYJpCBa+7jbySzfcGHbdzDqZksEYiI7V2ESnCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbGl1k6Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707381416; x=1738917416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t76IVYiXbKWkaw8zun2yu9J1QljUKHZoKZYIX0zYaBc=;
  b=IbGl1k6ZLwNaUVhM7mgtooKcH90wp7USXDww8ksZX+1nzHr49h2NmT5W
   5NGJ/lQMuBcRii/+b4JiRzSSsuxoDlfwCyiUMm9iyRmTBJUPNoW7AG0ME
   El9sNB7tDbId0RjakS/j/Hs2t6pvH8edmcrfufvrXu5g5qs7/479ZpWwX
   QQu7/xgXw0QjCcjj+6+hEkYkSqiz8WgBoaHZBQnSjvYUp5SPxJybRhibY
   NMsI+nbDax8nLEvpvzCBTcFeqkr36Cw2chohMGVUV9Al+wJa3GBLiCQYX
   9d0PLLL/78bQ+xnGVrZjI8jRfWPyE2WrfmcewJTl9sadthlNI4lDBhCYl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12538387"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="12538387"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6228569"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:36:52 -0800
Date: Thu, 8 Feb 2024 09:36:50 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 3/6] thermal: intel: Discard trip tables after zone
 registration
Message-ID: <ZcSSoptcq/wejWFu@linux.intel.com>
References: <2728491.mvXUDI8C0e@kreacher>
 <2324499.ElGaqSPkdT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2324499.ElGaqSPkdT@kreacher>

On Mon, Feb 05, 2024 at 10:16:59PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the thermal core creates and uses its own copy of the trips
> table passed to thermal_zone_device_register_with_trips(), it is not
> necessary to hold on to a local copy of it any more after the given
> thermal zone has been registered.
> 
> Accordingly, modify Intel thermal drivers to discard the trips tables
> passed to thermal_zone_device_register_with_trips() after thermal zone
> registration, for example by storing them in local variables which are
> automatically discarded when the zone registration is complete.
> 
> Also make some additional code simplifications unlocked by the above
> changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |    6 -
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h         |    1 
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    6 -
>  drivers/thermal/intel/intel_pch_thermal.c                            |   21 ++---
>  drivers/thermal/intel/intel_quark_dts_thermal.c                      |   12 +--
>  drivers/thermal/intel/intel_soc_dts_iosf.c                           |   38 +++-------
>  drivers/thermal/intel/intel_soc_dts_iosf.h                           |    1 
>  drivers/thermal/intel/x86_pkg_temp_thermal.c                         |   35 +++------
>  8 files changed, 48 insertions(+), 72 deletions(-)
> 
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -179,8 +179,6 @@ struct int34x_thermal_zone *int340x_ther
>  	for (i = 0; i < trip_cnt; ++i)
>  		zone_trips[i].hysteresis = hyst;
>  
> -	int34x_zone->trips = zone_trips;
> -
>  	int34x_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
>  
>  	int34x_zone->zone = thermal_zone_device_register_with_trips(
> @@ -190,6 +188,8 @@ struct int34x_thermal_zone *int340x_ther
>  							int34x_zone->ops,
>  							&int340x_thermal_params,
>  							0, 0);
> +	kfree(zone_trips);
> +
>  	if (IS_ERR(int34x_zone->zone)) {
>  		ret = PTR_ERR(int34x_zone->zone);
>  		goto err_thermal_zone;
> @@ -203,7 +203,6 @@ struct int34x_thermal_zone *int340x_ther
>  err_enable:
>  	thermal_zone_device_unregister(int34x_zone->zone);
>  err_thermal_zone:
> -	kfree(int34x_zone->trips);
>  	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
>  err_trips_alloc:
>  	kfree(int34x_zone->ops);
> @@ -217,7 +216,6 @@ void int340x_thermal_zone_remove(struct
>  {
>  	thermal_zone_device_unregister(int34x_zone->zone);
>  	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
> -	kfree(int34x_zone->trips);
>  	kfree(int34x_zone->ops);
>  	kfree(int34x_zone);
>  }
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -20,7 +20,6 @@ struct active_trip {
>  
>  struct int34x_thermal_zone {
>  	struct acpi_device *adev;
> -	struct thermal_trip *trips;
>  	int aux_trip_nr;
>  	struct thermal_zone_device *zone;
>  	struct thermal_zone_device_ops *ops;
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -233,10 +233,6 @@ static int get_trip_temp(struct proc_the
>  	return temp;
>  }
>  
> -static struct thermal_trip psv_trip = {
> -	.type = THERMAL_TRIP_PASSIVE,
> -};
> -
>  static struct thermal_zone_device_ops tzone_ops = {
>  	.get_temp = sys_get_curr_temp,
>  	.set_trip_temp	= sys_set_trip_temp,
> @@ -251,6 +247,7 @@ static int proc_thermal_pci_probe(struct
>  {
>  	struct proc_thermal_device *proc_priv;
>  	struct proc_thermal_pci *pci_info;
> +	struct thermal_trip psv_trip = { 0 };
>  	int irq_flag = 0, irq, ret;
>  	bool msi_irq = false;
>  
> @@ -288,6 +285,7 @@ static int proc_thermal_pci_probe(struct
>  	}
>  
>  	psv_trip.temperature = get_trip_temp(pci_info);
> +	psv_trip.type = THERMAL_TRIP_PASSIVE;
>  
>  	pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
>  							1, 1, pci_info,
> Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> @@ -84,7 +84,6 @@ struct pch_thermal_device {
>  	void __iomem *hw_base;
>  	struct pci_dev *pdev;
>  	struct thermal_zone_device *tzd;
> -	struct thermal_trip trips[PCH_MAX_TRIPS];
>  	bool bios_enabled;
>  };
>  
> @@ -94,7 +93,8 @@ struct pch_thermal_device {
>   * passive trip temperature using _PSV method. There is no specific
>   * passive temperature setting in MMIO interface of this PCI device.
>   */
> -static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
> +static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
> +				     struct thermal_trip *trip)
>  {
>  	struct acpi_device *adev;
>  	int temp;
> @@ -106,8 +106,8 @@ static int pch_wpt_add_acpi_psv_trip(str
>  	if (thermal_acpi_passive_trip_temp(adev, &temp) || temp <= 0)
>  		return 0;
>  
> -	ptd->trips[trip].type = THERMAL_TRIP_PASSIVE;
> -	ptd->trips[trip].temperature = temp;
> +	trip->type = THERMAL_TRIP_PASSIVE;
> +	trip->temperature = temp;
>  	return 1;
>  }
>  #else
> @@ -159,6 +159,7 @@ static const char *board_names[] = {
>  static int intel_pch_thermal_probe(struct pci_dev *pdev,
>  				   const struct pci_device_id *id)
>  {
> +	struct thermal_trip ptd_trips[PCH_MAX_TRIPS] = { 0 };
>  	enum pch_board_ids board_id = id->driver_data;
>  	struct pch_thermal_device *ptd;
>  	int nr_trips = 0;
> @@ -220,21 +221,21 @@ read_trips:
>  	trip_temp = readw(ptd->hw_base + WPT_CTT);
>  	trip_temp &= 0x1FF;
>  	if (trip_temp) {
> -		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
> -		ptd->trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
> +		ptd_trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
> +		ptd_trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
>  	}
>  
>  	trip_temp = readw(ptd->hw_base + WPT_PHL);
>  	trip_temp &= 0x1FF;
>  	if (trip_temp) {
> -		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
> -		ptd->trips[nr_trips++].type = THERMAL_TRIP_HOT;
> +		ptd_trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
> +		ptd_trips[nr_trips++].type = THERMAL_TRIP_HOT;
>  	}
>  
> -	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
> +	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, &ptd_trips[nr_trips]);
>  
>  	ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
> -							   ptd->trips, nr_trips,
> +							   ptd_trips, nr_trips,
>  							   0, ptd, &tzd_ops,
>  							   NULL, 0, 0);
>  	if (IS_ERR(ptd->tzd)) {
> Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
> @@ -105,7 +105,6 @@ struct soc_sensor_entry {
>  	u32 store_ptps;
>  	u32 store_dts_enable;
>  	struct thermal_zone_device *tzone;
> -	struct thermal_trip trips[QRK_MAX_DTS_TRIPS];
>  };
>  
>  static struct soc_sensor_entry *soc_dts;
> @@ -320,6 +319,7 @@ static void free_soc_dts(struct soc_sens
>  
>  static struct soc_sensor_entry *alloc_soc_dts(void)
>  {
> +	struct thermal_trip trips[QRK_MAX_DTS_TRIPS] = { 0 };
>  	struct soc_sensor_entry *aux_entry;
>  	int err;
>  	u32 out;
> @@ -362,14 +362,14 @@ static struct soc_sensor_entry *alloc_so
>  			goto err_ret;
>  	}
>  
> -	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = get_trip_temp(QRK_DTS_ID_TP_CRITICAL);
> -	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
> +	trips[QRK_DTS_ID_TP_CRITICAL].temperature = get_trip_temp(QRK_DTS_ID_TP_CRITICAL);
> +	trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
>  
> -	aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
> -	aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
> +	trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
> +	trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
>  
>  	aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
> -								   aux_entry->trips,
> +								   trips,
>  								   QRK_MAX_DTS_TRIPS,
>  								   wr_mask,
>  								   aux_entry, &tzone_ops,
> Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -129,22 +129,6 @@ err_restore_ptps:
>  	return status;
>  }
>  
> -static int configure_trip(struct intel_soc_dts_sensor_entry *dts,
> -			  int thres_index, enum thermal_trip_type trip_type,
> -			  int temp)
> -{
> -	int ret;
> -
> -	ret = update_trip_temp(dts->sensors, thres_index, temp);
> -	if (ret)
> -		return ret;
> -
> -	dts->trips[thres_index].temperature = temp;
> -	dts->trips[thres_index].type = trip_type;
> -
> -	return 0;
> -}
> -
>  static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
>  			     int temp)
>  {
> @@ -218,6 +202,7 @@ static void remove_dts_thermal_zone(stru
>  }
>  
>  static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
> +				struct thermal_trip *trips,
>  				bool critical_trip)
>  {
>  	int writable_trip_cnt = SOC_MAX_DTS_TRIPS;
> @@ -254,7 +239,7 @@ static int add_dts_thermal_zone(int id,
>  	}
>  	dts->trip_mask = trip_mask;
>  	snprintf(name, sizeof(name), "soc_dts%d", id);
> -	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
> +	dts->tzone = thermal_zone_device_register_with_trips(name, trips,
>  							     SOC_MAX_DTS_TRIPS,
>  							     trip_mask,
>  							     dts, &tzone_ops,
> @@ -315,14 +300,15 @@ EXPORT_SYMBOL_GPL(intel_soc_dts_iosf_int
>  
>  static void dts_trips_reset(struct intel_soc_dts_sensors *sensors, int dts_index)
>  {
> -	configure_trip(&sensors->soc_dts[dts_index], 0, 0, 0);
> -	configure_trip(&sensors->soc_dts[dts_index], 1, 0, 0);
> +	update_trip_temp(sensors, 0, 0);
> +	update_trip_temp(sensors, 1, 0);
>  }
>  
>  struct intel_soc_dts_sensors *
>  intel_soc_dts_iosf_init(enum intel_soc_dts_interrupt_type intr_type,
>  			bool critical_trip, int crit_offset)
>  {
> +	struct thermal_trip trips[SOC_MAX_DTS_SENSORS][SOC_MAX_DTS_TRIPS] = { 0 };
>  	struct intel_soc_dts_sensors *sensors;
>  	int tj_max;
>  	int ret;
> @@ -350,11 +336,13 @@ intel_soc_dts_iosf_init(enum intel_soc_d
>  
>  		sensors->soc_dts[i].sensors = sensors;
>  
> -		ret = configure_trip(&sensors->soc_dts[i], 0,
> -				     THERMAL_TRIP_PASSIVE, 0);
> +		ret = update_trip_temp(sensors, 0, 0);
>  		if (ret)
>  			goto err_reset_trips;
>  
> +		trips[i][0].type = THERMAL_TRIP_PASSIVE;
> +		trips[i][0].temperature = 0;
> +
>  		if (critical_trip) {
>  			trip_type = THERMAL_TRIP_CRITICAL;
>  			temp = sensors->tj_max - crit_offset;
> @@ -362,13 +350,17 @@ intel_soc_dts_iosf_init(enum intel_soc_d
>  			trip_type = THERMAL_TRIP_PASSIVE;
>  			temp = 0;
>  		}
> -		ret = configure_trip(&sensors->soc_dts[i], 1, trip_type, temp);
> +		ret = update_trip_temp(sensors, 1, temp);
>  		if (ret)
>  			goto err_reset_trips;
> +
> +		trips[i][1].type = trip_type;
> +		trips[i][1].temperature = temp;
>  	}
>  
>  	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> -		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i], critical_trip);
> +		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i], trips[i],
> +					   critical_trip);
>  		if (ret)
>  			goto err_remove_zone;
>  	}
> Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.h
> +++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
> @@ -29,7 +29,6 @@ struct intel_soc_dts_sensor_entry {
>  	int id;
>  	u32 store_status;
>  	u32 trip_mask;
> -	struct thermal_trip trips[SOC_MAX_DTS_TRIPS];
>  	struct thermal_zone_device *tzone;
>  	struct intel_soc_dts_sensors *sensors;
>  };
> Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -53,7 +53,6 @@ struct zone_device {
>  	u32				msr_pkg_therm_high;
>  	struct delayed_work		work;
>  	struct thermal_zone_device	*tzone;
> -	struct thermal_trip		*trips;
>  	struct cpumask			cpumask;
>  };
>  
> @@ -268,17 +267,13 @@ static int pkg_thermal_notify(u64 msr_va
>  	return 0;
>  }
>  
> -static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
> +static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
> +				       struct thermal_trip *trips, int num_trips)
>  {
> -	struct thermal_trip *trips;
>  	unsigned long thres_reg_value;
>  	u32 mask, shift, eax, edx;
>  	int ret, i;
>  
> -	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
> -	if (!trips)
> -		return ERR_PTR(-ENOMEM);
> -
>  	for (i = 0; i < num_trips; i++) {
>  
>  		if (i) {
> @@ -291,10 +286,8 @@ static struct thermal_trip *pkg_temp_the
>  
>  		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
>  				   &eax, &edx);
> -		if (ret < 0) {
> -			kfree(trips);
> -			return ERR_PTR(ret);
> -		}
> +		if (ret < 0)
> +			return ret;
>  
>  		thres_reg_value = (eax & mask) >> shift;
>  
> @@ -307,11 +300,12 @@ static struct thermal_trip *pkg_temp_the
>  			 __func__, cpu, i, trips[i].temperature);
>  	}
>  
> -	return trips;
> +	return 0;
>  }
>  
>  static int pkg_temp_thermal_device_add(unsigned int cpu)
>  {
> +	struct thermal_trip trips[MAX_NUMBER_OF_TRIPS] = { 0 };
>  	int id = topology_logical_die_id(cpu);
>  	u32 eax, ebx, ecx, edx;
>  	struct zone_device *zonedev;
> @@ -336,21 +330,19 @@ static int pkg_temp_thermal_device_add(u
>  	if (!zonedev)
>  		return -ENOMEM;
>  
> -	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
> -	if (IS_ERR(zonedev->trips)) {
> -		err = PTR_ERR(zonedev->trips);
> +	err = pkg_temp_thermal_trips_init(cpu, tj_max, trips, thres_count);
> +	if (err)
>  		goto out_kfree_zonedev;
> -	}
>  
>  	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
>  	zonedev->cpu = cpu;
>  	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
> -			zonedev->trips, thres_count,
> +			trips, thres_count,
>  			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
>  			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
>  	if (IS_ERR(zonedev->tzone)) {
>  		err = PTR_ERR(zonedev->tzone);
> -		goto out_kfree_trips;
> +		goto out_kfree_zonedev;
>  	}
>  	err = thermal_zone_device_enable(zonedev->tzone);
>  	if (err)
> @@ -369,8 +361,6 @@ static int pkg_temp_thermal_device_add(u
>  
>  out_unregister_tz:
>  	thermal_zone_device_unregister(zonedev->tzone);
> -out_kfree_trips:
> -	kfree(zonedev->trips);
>  out_kfree_zonedev:
>  	kfree(zonedev);
>  	return err;
> @@ -457,10 +447,9 @@ static int pkg_thermal_cpu_offline(unsig
>  	raw_spin_unlock_irq(&pkg_temp_lock);
>  
>  	/* Final cleanup if this is the last cpu */
> -	if (lastcpu) {
> -		kfree(zonedev->trips);
> +	if (lastcpu)
>  		kfree(zonedev);
> -	}
> +
>  	return 0;
>  }
>  
> 
> 
> 
> 

