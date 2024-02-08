Return-Path: <linux-kernel+bounces-57673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D836C84DC10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D1E1C2504B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3096BB3C;
	Thu,  8 Feb 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqDrmenk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BB6BB2C;
	Thu,  8 Feb 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382332; cv=none; b=Gj/kRlYL/tfFtWW2z9AeQzCs1kdW4yf5SnIDcXc6Uyn9e0MzavRa98ypHMnSrHA17epCogFa4ChpG1S9Z4fWhZG7drEWaF3SoNY/2VrnpiguZ1v8LGo1NEXGfz6Nc/W/lu1my7syglt9rstW9EKEuLwSQMQgVBRay3ShzRO6CzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382332; c=relaxed/simple;
	bh=XBQ/LHCWFF2ciAgalCoUU0twHFrN7kN9P2TDY0SaCGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3jT8noSGLy77kOdUnZ4Yblg5BBx1qTgaLwcnW9cd5EbE5StGFSxodCCu8s86uPE2Ijx2ln9zzv44bfo6dQLx6uY+pUSYMBSw0aICmgFYoBT3aEw2Nvxew0JPm0j+L95+KeSp932LlJWlDRinnz8ejcI9ZvV5lILl6uy6KNIPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqDrmenk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382331; x=1738918331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XBQ/LHCWFF2ciAgalCoUU0twHFrN7kN9P2TDY0SaCGw=;
  b=OqDrmenk5gYg6K6LFt/OEHhMjU5Brnp42ZB61rDxsfRoTXzGxb+XaaVC
   3kOtq2Fmrvt+4IVicFK67I7x9NDGYcVvaT95LQ8OQsXL2wsxE6pvBNwgt
   TfwtW/TdxwReoomczxCCPfjUhnFkBSb+em0vDraELPjC5hiZFKHPg/vEn
   3qcjYgXxGzo9bk1Pp2RKYoIyzsocf23RoNI6s9sVK+4Ac0HR1wDc5buAU
   lKeqpSC88qAs/EX51TK5WAWtk8CAA/yIFBr3Y/8CJAAoyhfxm18d3VFMc
   lOY8B9ZM1i49NzMkUrcd4uA5aqEVubkHMl+GZek+AIetlKCXHh6uIJ/eQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1470873"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1470873"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="32669107"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:52:00 -0800
Date: Thu, 8 Feb 2024 09:51:58 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 6/6] thermal: intel: Adjust ops handling during
 thermal zone registration
Message-ID: <ZcSWLvqza+P7q3uF@linux.intel.com>
References: <2728491.mvXUDI8C0e@kreacher>
 <3284830.aeNJFYEL58@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3284830.aeNJFYEL58@kreacher>

On Mon, Feb 05, 2024 at 10:20:32PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, thermal zone creators can discard the operations
> structure after the zone registration is complete, or it can be made
> read-only.
> 
> Accordingly, make int340x_thermal_zone_add() use a local variable to
> represent thermal zone operations, so it is freed automatically upon the
> function exit, and make the other Intel thermal drivers use const zone
> operations structures.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |   26 ++--------
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h         |    1 
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    2 
>  drivers/thermal/intel/intel_pch_thermal.c                            |    2 
>  drivers/thermal/intel/intel_quark_dts_thermal.c                      |    2 
>  drivers/thermal/intel/intel_soc_dts_iosf.c                           |    2 
>  drivers/thermal/intel/x86_pkg_temp_thermal.c                         |    2 
>  7 files changed, 11 insertions(+), 26 deletions(-)
> 
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -61,12 +61,6 @@ static void int340x_thermal_critical(str
>  	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
>  }
>  
> -static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
> -	.get_temp       = int340x_thermal_get_zone_temp,
> -	.set_trip_temp	= int340x_thermal_set_trip_temp,
> -	.critical	= int340x_thermal_critical,
> -};
> -
>  static inline void *int_to_trip_priv(int i)
>  {
>  	return (void *)(long)i;
> @@ -126,6 +120,11 @@ static struct thermal_zone_params int340
>  struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
>  						     int (*get_temp) (struct thermal_zone_device *, int *))
>  {
> +	const struct thermal_zone_device_ops zone_ops = {
> +		.set_trip_temp = int340x_thermal_set_trip_temp,
> +		.critical = int340x_thermal_critical,
> +		.get_temp = get_temp ? get_temp : int340x_thermal_get_zone_temp,
> +	};
>  	struct int34x_thermal_zone *int34x_zone;
>  	struct thermal_trip *zone_trips;
>  	unsigned long long trip_cnt = 0;
> @@ -140,16 +139,6 @@ struct int34x_thermal_zone *int340x_ther
>  
>  	int34x_zone->adev = adev;
>  
> -	int34x_zone->ops = kmemdup(&int340x_thermal_zone_ops,
> -				   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
> -	if (!int34x_zone->ops) {
> -		ret = -ENOMEM;
> -		goto err_ops_alloc;
> -	}
> -
> -	if (get_temp)
> -		int34x_zone->ops->get_temp = get_temp;
> -
>  	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
>  	if (ACPI_SUCCESS(status)) {
>  		int34x_zone->aux_trip_nr = trip_cnt;
> @@ -185,7 +174,7 @@ struct int34x_thermal_zone *int340x_ther
>  							acpi_device_bid(adev),
>  							zone_trips, trip_cnt,
>  							trip_mask, int34x_zone,
> -							int34x_zone->ops,
> +							&zone_ops,
>  							&int340x_thermal_params,
>  							0, 0);
>  	kfree(zone_trips);
> @@ -205,8 +194,6 @@ err_enable:
>  err_thermal_zone:
>  	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
>  err_trips_alloc:
> -	kfree(int34x_zone->ops);
> -err_ops_alloc:
>  	kfree(int34x_zone);
>  	return ERR_PTR(ret);
>  }
> @@ -216,7 +203,6 @@ void int340x_thermal_zone_remove(struct
>  {
>  	thermal_zone_device_unregister(int34x_zone->zone);
>  	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
> -	kfree(int34x_zone->ops);
>  	kfree(int34x_zone);
>  }
>  EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -22,7 +22,6 @@ struct int34x_thermal_zone {
>  	struct acpi_device *adev;
>  	int aux_trip_nr;
>  	struct thermal_zone_device *zone;
> -	struct thermal_zone_device_ops *ops;
>  	void *priv_data;
>  	struct acpi_lpat_conversion_table *lpat_table;
>  };
> Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
> @@ -131,7 +131,7 @@ static void pch_critical(struct thermal_
>  		thermal_zone_device_type(tzd));
>  }
>  
> -static struct thermal_zone_device_ops tzd_ops = {
> +static const struct thermal_zone_device_ops tzd_ops = {
>  	.get_temp = pch_thermal_get_temp,
>  	.critical = pch_critical,
>  };
> Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
> +++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
> @@ -292,7 +292,7 @@ static int sys_change_mode(struct therma
>  	return ret;
>  }
>  
> -static struct thermal_zone_device_ops tzone_ops = {
> +static const struct thermal_zone_device_ops tzone_ops = {
>  	.get_temp = sys_get_curr_temp,
>  	.set_trip_temp = sys_set_trip_temp,
>  	.change_mode = sys_change_mode,
> Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -233,7 +233,7 @@ static int get_trip_temp(struct proc_the
>  	return temp;
>  }
>  
> -static struct thermal_zone_device_ops tzone_ops = {
> +static const struct thermal_zone_device_ops tzone_ops = {
>  	.get_temp = sys_get_curr_temp,
>  	.set_trip_temp	= sys_set_trip_temp,
>  };
> Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -168,7 +168,7 @@ static int sys_get_curr_temp(struct ther
>  	return 0;
>  }
>  
> -static struct thermal_zone_device_ops tzone_ops = {
> +static const struct thermal_zone_device_ops tzone_ops = {
>  	.get_temp = sys_get_curr_temp,
>  	.set_trip_temp = sys_set_trip_temp,
>  };
> Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -166,7 +166,7 @@ sys_set_trip_temp(struct thermal_zone_de
>  }
>  
>  /* Thermal zone callback registry */
> -static struct thermal_zone_device_ops tzone_ops = {
> +static const struct thermal_zone_device_ops tzone_ops = {
>  	.get_temp = sys_get_curr_temp,
>  	.set_trip_temp = sys_set_trip_temp,
>  };
> 
> 
> 

