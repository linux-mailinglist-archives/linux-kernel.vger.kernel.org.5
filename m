Return-Path: <linux-kernel+bounces-55279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EC84BA23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909D7281614
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5CE134732;
	Tue,  6 Feb 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhyWM16U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB112E1E9;
	Tue,  6 Feb 2024 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234781; cv=none; b=X+og8HHcPmZCMFR22ihFbZz+jXj4umrD5RmzYb8XSN++J8KobK6zGmuSa1N8i2HjpAm7sNXcrBTe7QpgLNSzQFb2YsUI7tKRmMLrXQMv9VjzIHQmWUSdfcDqbPRBmyDdfWiFKLhZWlpVOsIK7gdJZt4JIHACs+l+BkZtBPHcqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234781; c=relaxed/simple;
	bh=iMjKhqyLc9HRK1lQLj/s8JSymOEov70ODtIti2ry6Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdCqlZ8b26KXb1mH+Sen8mn2DTymIUwlkm9QRbASWN9GnRnYB8mtjPUF4acYrxHEsqtIVUCroEjROa9CsM0IGdpEoUEaKbu0grasJsfk+ukw8QiK1ON251T5e/QM07PiZ6UcwyeWwuT1h/8rKu+3rN9uV4Y4z0qdhNtSdOZcWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhyWM16U; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707234780; x=1738770780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iMjKhqyLc9HRK1lQLj/s8JSymOEov70ODtIti2ry6Vc=;
  b=PhyWM16Uuz0ST7DkmpxVPcbAx1Pn0Pjz8FMhr4xTrvQMvbl8/pTRSw4o
   q/AVcCbkwm3AA0Ty/C0Cw4MGK4gezwxzIYpqyyq9PVffvCgk1/zjcwC/M
   L/Jw0MUekvQvRm8EQ5FCcU4k5dyba8V6CRln82PDU7fnnUl2JKmRFY5Rn
   /obhkGAUKTjxuvPP/vBqL0xGn1lfGE7UU3ZEHJF7GW+uGOIvvkw3aJ1+C
   Yis2zmVorVcqVWVZn9TrJUt7YJviiopv+MKngRvOCaM7vCBEk724XWcP4
   xymXM6TMF2IEfoXooMLFYxuu67rLpn78xh8pFcPOw4YjJnLQY3pgNZ+Co
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11511906"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11511906"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:52:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="933501465"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="933501465"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:52:57 -0800
Date: Tue, 6 Feb 2024 16:52:55 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: Re: [PATCH] thermal/intel: Fix intel_tcc_get_temp() to support
 negative CPU temperature
Message-ID: <ZcJV143vaglGGYnX@linux.intel.com>
References: <20240206015409.619127-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206015409.619127-1-rui.zhang@intel.com>

On Tue, Feb 06, 2024 at 09:54:09AM +0800, Zhang Rui wrote:
> CPU temperature can be negative in some cases. Thus the negative CPU
> temperature should not be considered as a failure.
> 
> Fix intel_tcc_get_temp() and its users to support negative CPU
> temperature.
> 
> Fixes: a3c1f066e1c5 ("thermal/intel: Introduce Intel TCC library")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  .../intel/int340x_thermal/processor_thermal_device.c |  8 ++++----
>  drivers/thermal/intel/intel_tcc.c                    | 12 ++++++------
>  drivers/thermal/intel/x86_pkg_temp_thermal.c         |  8 ++++----
>  include/linux/intel_tcc.h                            |  2 +-
>  4 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 649f67fdf345..d75fae7b7ed2 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -176,14 +176,14 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
>  					 int *temp)
>  {
>  	int cpu;
> -	int curr_temp;
> +	int curr_temp, ret;
>  
>  	*temp = 0;
>  
>  	for_each_online_cpu(cpu) {
> -		curr_temp = intel_tcc_get_temp(cpu, false);
> -		if (curr_temp < 0)
> -			return curr_temp;
> +		ret = intel_tcc_get_temp(cpu, &curr_temp, false);
> +		if (ret < 0)
> +			return ret;
>  		if (!*temp || curr_temp > *temp)
>  			*temp = curr_temp;
>  	}
> diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
> index 2e5c741c41ca..5e8b7f34b395 100644
> --- a/drivers/thermal/intel/intel_tcc.c
> +++ b/drivers/thermal/intel/intel_tcc.c
> @@ -103,18 +103,19 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
>  /**
>   * intel_tcc_get_temp() - returns the current temperature
>   * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
> + * @temp: pointer to the memory for saving cpu temperature.
>   * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
>   *
>   * Get the current temperature returned by the CPU core/package level
>   * thermal sensor, in degrees C.
>   *
> - * Return: Temperature in degrees C on success, negative error code otherwise.
> + * Return: 0 on success, negative error code otherwise.
>   */
> -int intel_tcc_get_temp(int cpu, bool pkg)
> +int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
>  {
>  	u32 low, high;
>  	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
> -	int tjmax, temp, err;
> +	int tjmax, err;
>  
>  	tjmax = intel_tcc_get_tjmax(cpu);
>  	if (tjmax < 0)
> @@ -131,9 +132,8 @@ int intel_tcc_get_temp(int cpu, bool pkg)
>  	if (!(low & BIT(31)))
>  		return -ENODATA;
>  
> -	temp = tjmax - ((low >> 16) & 0x7f);
> +	*temp = tjmax - ((low >> 16) & 0x7f);
>  
> -	/* Do not allow negative CPU temperature */
> -	return temp >= 0 ? temp : -ENODATA;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index 11a7f8108bbb..61c3d450ee60 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -108,11 +108,11 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
>  static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
>  {
>  	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
> -	int val;
> +	int val, ret;
>  
> -	val = intel_tcc_get_temp(zonedev->cpu, true);
> -	if (val < 0)
> -		return val;
> +	ret = intel_tcc_get_temp(zonedev->cpu, &val, true);
> +	if (ret < 0)
> +		return ret;
>  
>  	*temp = val * 1000;
>  	pr_debug("sys_get_curr_temp %d\n", *temp);
> diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
> index f422612c28d6..8ff8eabb4a98 100644
> --- a/include/linux/intel_tcc.h
> +++ b/include/linux/intel_tcc.h
> @@ -13,6 +13,6 @@
>  int intel_tcc_get_tjmax(int cpu);
>  int intel_tcc_get_offset(int cpu);
>  int intel_tcc_set_offset(int cpu, int offset);
> -int intel_tcc_get_temp(int cpu, bool pkg);
> +int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
>  
>  #endif /* __INTEL_TCC_H__ */
> -- 
> 2.34.1
> 
> 

