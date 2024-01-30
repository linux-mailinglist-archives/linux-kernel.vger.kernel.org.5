Return-Path: <linux-kernel+bounces-44056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D551841CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0340628B0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C253E08;
	Tue, 30 Jan 2024 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdj96ZmL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750952F93;
	Tue, 30 Jan 2024 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600307; cv=none; b=GXriqtXewMo7sEh357qWbHilmDjAjbvCvJIl5PjIdjg5/9hzqcq0J7e23CmSrMLUZ+PV4vYNKwCqxqazBOrcYj3drldYyGbMtU7XS8yeSXgeac6+/LY3jlIzwyw3sejQ5TY+4g1a4iK3H77dgQ582SCWgQVZjrBBb6DN4QQVlUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600307; c=relaxed/simple;
	bh=znyPKd/ZI1h+ecSrM7JeO+wpDKxmEq9nh6DeNAt61OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdArU9+pNejV/yYPSXlkRVaMPYtzWbqYpPCnIUK0a+E5hRAWE93mDdUE7uJl0Bk7W6S//nz93o4iD8kFGujmb6NkvDGZ+AVJOOLb9O5iIXCYX4q88Q5tcS7o3Hhfqf1FmNQmJF8UN6Ppys4vDCzcEd9vAyslHLfcRPkyRkjGVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdj96ZmL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706600305; x=1738136305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=znyPKd/ZI1h+ecSrM7JeO+wpDKxmEq9nh6DeNAt61OU=;
  b=jdj96ZmLH6Hi514x1/T8agrlbT5v0GWhGRW+r55O2AKglzr5NclS9EIq
   E7LDgG+tsDDb4XUhN5hXaOkN7QHBUOWmW8wNsHweiEQZ1wfsVJ9qzLSWG
   orf6fhRIhl0wuRgbkWGIRWD03YEqx433dh7Zjj9/g515Yj/yajPx3MD+Y
   /8EJlqHjDmP4My720T/y3sqge6oOYqK4Zyn1HWF2TVFvjTcv9nglECC91
   M+ATuT4wOoo+3YMtwmYt53PHFz/HUf0Zi3H7z0xzCVc380wWLRYv9vJyA
   MF62ydOFFJW3yErpYuIjCIIZQQyiwWlKpaqy/vwx9zywqAn72y9pD1PuF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2132020"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2132020"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961172875"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961172875"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.115])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:37:55 -0800
Date: Tue, 30 Jan 2024 08:37:53 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 10/10] PM: sleep: Call dpm_async_fn() directly in each
 suspend phase
Message-ID: <ZbinUdw3Cm58EfkE@linux.intel.com>
References: <5770175.DvuYhMxLoT@kreacher>
 <2203732.Icojqenx9y@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2203732.Icojqenx9y@kreacher>

On Mon, Jan 29, 2024 at 05:29:41PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Simplify the system-wide suspend of devices by invoking dpm_async_fn()
> directly from the main loop in each suspend phase instead of using an
> additional wrapper function for running it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
> 
> v1 -> v2: No changes.
> 
> ---
>  drivers/base/power/main.c |   61 ++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1192,7 +1192,7 @@ static void dpm_superior_set_must_resume
>  }
>  
>  /**
> - * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
> + * device_suspend_noirq - Execute a "noirq suspend" callback for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being suspended asynchronously.
> @@ -1200,7 +1200,7 @@ static void dpm_superior_set_must_resume
>   * The driver of @dev will not receive interrupts while this function is being
>   * executed.
>   */
> -static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
> +static int device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
>  {
>  	pm_callback_t callback = NULL;
>  	const char *info = NULL;
> @@ -1277,18 +1277,10 @@ static void async_suspend_noirq(void *da
>  {
>  	struct device *dev = data;
>  
> -	__device_suspend_noirq(dev, pm_transition, true);
> +	device_suspend_noirq(dev, pm_transition, true);
>  	put_device(dev);
>  }
>  
> -static int device_suspend_noirq(struct device *dev)
> -{
> -	if (dpm_async_fn(dev, async_suspend_noirq))
> -		return 0;
> -
> -	return __device_suspend_noirq(dev, pm_transition, false);
> -}
> -
>  static int dpm_noirq_suspend_devices(pm_message_t state)
>  {
>  	ktime_t starttime = ktime_get();
> @@ -1305,10 +1297,15 @@ static int dpm_noirq_suspend_devices(pm_
>  		struct device *dev = to_device(dpm_late_early_list.prev);
>  
>  		list_move(&dev->power.entry, &dpm_noirq_list);
> +
> +		if (dpm_async_fn(dev, async_suspend_noirq))
> +			continue;
> +
>  		get_device(dev);
> +
>  		mutex_unlock(&dpm_list_mtx);
>  
> -		error = device_suspend_noirq(dev);
> +		error = device_suspend_noirq(dev, state, false);
>  
>  		put_device(dev);
>  
> @@ -1369,14 +1366,14 @@ static void dpm_propagate_wakeup_to_pare
>  }
>  
>  /**
> - * __device_suspend_late - Execute a "late suspend" callback for given device.
> + * device_suspend_late - Execute a "late suspend" callback for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being suspended asynchronously.
>   *
>   * Runtime PM is disabled for @dev while this function is being executed.
>   */
> -static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
> +static int device_suspend_late(struct device *dev, pm_message_t state, bool async)
>  {
>  	pm_callback_t callback = NULL;
>  	const char *info = NULL;
> @@ -1447,18 +1444,10 @@ static void async_suspend_late(void *dat
>  {
>  	struct device *dev = data;
>  
> -	__device_suspend_late(dev, pm_transition, true);
> +	device_suspend_late(dev, pm_transition, true);
>  	put_device(dev);
>  }
>  
> -static int device_suspend_late(struct device *dev)
> -{
> -	if (dpm_async_fn(dev, async_suspend_late))
> -		return 0;
> -
> -	return __device_suspend_late(dev, pm_transition, false);
> -}
> -
>  /**
>   * dpm_suspend_late - Execute "late suspend" callbacks for all devices.
>   * @state: PM transition of the system being carried out.
> @@ -1481,11 +1470,15 @@ int dpm_suspend_late(pm_message_t state)
>  		struct device *dev = to_device(dpm_suspended_list.prev);
>  
>  		list_move(&dev->power.entry, &dpm_late_early_list);
> +
> +		if (dpm_async_fn(dev, async_suspend_late))
> +			continue;
> +
>  		get_device(dev);
>  
>  		mutex_unlock(&dpm_list_mtx);
>  
> -		error = device_suspend_late(dev);
> +		error = device_suspend_late(dev, state, false);
>  
>  		put_device(dev);
>  
> @@ -1582,12 +1575,12 @@ static void dpm_clear_superiors_direct_c
>  }
>  
>  /**
> - * __device_suspend - Execute "suspend" callbacks for given device.
> + * device_suspend - Execute "suspend" callbacks for given device.
>   * @dev: Device to handle.
>   * @state: PM transition of the system being carried out.
>   * @async: If true, the device is being suspended asynchronously.
>   */
> -static int __device_suspend(struct device *dev, pm_message_t state, bool async)
> +static int device_suspend(struct device *dev, pm_message_t state, bool async)
>  {
>  	pm_callback_t callback = NULL;
>  	const char *info = NULL;
> @@ -1716,18 +1709,10 @@ static void async_suspend(void *data, as
>  {
>  	struct device *dev = data;
>  
> -	__device_suspend(dev, pm_transition, true);
> +	device_suspend(dev, pm_transition, true);
>  	put_device(dev);
>  }
>  
> -static int device_suspend(struct device *dev)
> -{
> -	if (dpm_async_fn(dev, async_suspend))
> -		return 0;
> -
> -	return __device_suspend(dev, pm_transition, false);
> -}
> -
>  /**
>   * dpm_suspend - Execute "suspend" callbacks for all non-sysdev devices.
>   * @state: PM transition of the system being carried out.
> @@ -1752,11 +1737,15 @@ int dpm_suspend(pm_message_t state)
>  		struct device *dev = to_device(dpm_prepared_list.prev);
>  
>  		list_move(&dev->power.entry, &dpm_suspended_list);
> +
> +		if (dpm_async_fn(dev, async_suspend))
> +			continue;
> +
>  		get_device(dev);
>  
>  		mutex_unlock(&dpm_list_mtx);
>  
> -		error = device_suspend(dev);
> +		error = device_suspend(dev, state, false);
>  
>  		put_device(dev);
>  
> 
> 
> 

