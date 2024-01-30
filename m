Return-Path: <linux-kernel+bounces-44052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD3B841CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0D2878F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0357B53803;
	Tue, 30 Jan 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiRWb7AX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FF26AC7;
	Tue, 30 Jan 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600217; cv=none; b=DxeklI4BFnMusg2FRpmjCwirj2+XUW1csJeXjAEWFtcP6dF3BT5YryS+APrga7TBkOI9M46GPboAmOT3frS6YvQc64HJrydK5h5B2AmfnfJ63+f+x+4BJGjF+EE6x5LB86xUR60+dc2oicUa6mvm60uWOR0flUVZSsh204CcBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600217; c=relaxed/simple;
	bh=G+bRbntiavY2HxGZZio4OD0txL1498KXB5DjrrXqw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlxKyEzbzf2fakuiuyvWdDU6da8pptMDIAxX7K9jE90ExJxFkKvmJQemMgN3PDmG4lrpvuSOTB47LIrHPqN/65J7l7cYptsIvda3f21bpRvFnz1e4pWRVkV4HU/IGH3nUvbHobbD4QzUR2D8JbUzoHTXms2cvuRYrSYpLArY22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiRWb7AX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706600216; x=1738136216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+bRbntiavY2HxGZZio4OD0txL1498KXB5DjrrXqw8U=;
  b=FiRWb7AXs88m3YExwPf8sElVwhNVqJ1Gn3Lpm48ApvD1s1rFYFXjlJAo
   8P/Eq2btrMLeNsoYyjsW7n3lnkh8Mv5yNupQyOj7J7ccuGhw85GXRoGgn
   uwFsKF8cj7D62zKHItmsYUSwkJdbR2QubuDfWZ2hkG7QDp5dSa7EeAERR
   QSw6KF2B6eakpjpm2XyScOn9INhI+xIy6Nqy8de3QmUE4noQ+QidRA3Wu
   OMgJcMcBrgNa+gnkaZZg7VZGeATBhOaumIrFTYpmFR45NnVxL/uxrOix4
   OPZRceLpMXI1UowWxXsHUItqA1nsZbsQo23AHO4oY0AuDJc5VA/x1nqkj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2131611"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="2131611"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="961172799"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="961172799"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.115])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:36:52 -0800
Date: Tue, 30 Jan 2024 08:36:50 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 07/10] PM: sleep: stats: Log errors right after
 running suspend callbacks
Message-ID: <ZbinEuC6IZqjDIpf@linux.intel.com>
References: <5770175.DvuYhMxLoT@kreacher>
 <2200952.Mh6RI2rZIc@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2200952.Mh6RI2rZIc@kreacher>

On Mon, Jan 29, 2024 at 05:25:48PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The error logging and failure statistics updates are carried out in two
> places in each system-wide device suspend phase, which is unnecessary
> code duplication, so do that in one place in each phase, right after
> invoking device suspend callbacks.
> 
> While at it, add "noirq" or "late" to the "async" string printed when
> the failing device callback in the "noirq" or "late" suspend phase,
> respectively, was run asynchronously.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/base/power/main.c |   49 ++++++++++++----------------------------------
>  1 file changed, 13 insertions(+), 36 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1244,6 +1244,8 @@ Run:
>  	error = dpm_run_callback(callback, dev, state, info);
>  	if (error) {
>  		async_error = error;
> +		dpm_save_failed_dev(dev_name(dev));
> +		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
>  		goto Complete;
>  	}
>  
> @@ -1273,14 +1275,8 @@ Complete:
>  static void async_suspend_noirq(void *data, async_cookie_t cookie)
>  {
>  	struct device *dev = data;
> -	int error;
> -
> -	error = __device_suspend_noirq(dev, pm_transition, true);
> -	if (error) {
> -		dpm_save_failed_dev(dev_name(dev));
> -		pm_dev_err(dev, pm_transition, " async", error);
> -	}
>  
> +	__device_suspend_noirq(dev, pm_transition, true);
>  	put_device(dev);
>  }
>  
> @@ -1312,12 +1308,8 @@ static int dpm_noirq_suspend_devices(pm_
>  
>  		mutex_lock(&dpm_list_mtx);
>  
> -		if (error) {
> -			pm_dev_err(dev, state, " noirq", error);
> -			dpm_save_failed_dev(dev_name(dev));
> -		} else if (!list_empty(&dev->power.entry)) {
> +		if (!error && !list_empty(&dev->power.entry))
>  			list_move(&dev->power.entry, &dpm_noirq_list);
> -		}
>  
>  		mutex_unlock(&dpm_list_mtx);
>  
> @@ -1437,6 +1429,8 @@ Run:
>  	error = dpm_run_callback(callback, dev, state, info);
>  	if (error) {
>  		async_error = error;
> +		dpm_save_failed_dev(dev_name(dev));
> +		pm_dev_err(dev, state, async ? " async late" : " late", error);
>  		goto Complete;
>  	}
>  	dpm_propagate_wakeup_to_parent(dev);
> @@ -1453,13 +1447,8 @@ Complete:
>  static void async_suspend_late(void *data, async_cookie_t cookie)
>  {
>  	struct device *dev = data;
> -	int error;
>  
> -	error = __device_suspend_late(dev, pm_transition, true);
> -	if (error) {
> -		dpm_save_failed_dev(dev_name(dev));
> -		pm_dev_err(dev, pm_transition, " async", error);
> -	}
> +	__device_suspend_late(dev, pm_transition, true);
>  	put_device(dev);
>  }
>  
> @@ -1500,11 +1489,6 @@ int dpm_suspend_late(pm_message_t state)
>  		if (!list_empty(&dev->power.entry))
>  			list_move(&dev->power.entry, &dpm_late_early_list);
>  
> -		if (error) {
> -			pm_dev_err(dev, state, " late", error);
> -			dpm_save_failed_dev(dev_name(dev));
> -		}
> -
>  		mutex_unlock(&dpm_list_mtx);
>  
>  		put_device(dev);
> @@ -1719,8 +1703,11 @@ static int __device_suspend(struct devic
>  	dpm_watchdog_clear(&wd);
>  
>   Complete:
> -	if (error)
> +	if (error) {
>  		async_error = error;
> +		dpm_save_failed_dev(dev_name(dev));
> +		pm_dev_err(dev, state, async ? " async" : "", error);
> +	}
>  
>  	complete_all(&dev->power.completion);
>  	TRACE_SUSPEND(error);
> @@ -1730,14 +1717,8 @@ static int __device_suspend(struct devic
>  static void async_suspend(void *data, async_cookie_t cookie)
>  {
>  	struct device *dev = data;
> -	int error;
> -
> -	error = __device_suspend(dev, pm_transition, true);
> -	if (error) {
> -		dpm_save_failed_dev(dev_name(dev));
> -		pm_dev_err(dev, pm_transition, " async", error);
> -	}
>  
> +	__device_suspend(dev, pm_transition, true);
>  	put_device(dev);
>  }
>  
> @@ -1778,12 +1759,8 @@ int dpm_suspend(pm_message_t state)
>  
>  		mutex_lock(&dpm_list_mtx);
>  
> -		if (error) {
> -			pm_dev_err(dev, state, "", error);
> -			dpm_save_failed_dev(dev_name(dev));
> -		} else if (!list_empty(&dev->power.entry)) {
> +		if (!error && !list_empty(&dev->power.entry))
>  			list_move(&dev->power.entry, &dpm_suspended_list);
> -		}
>  
>  		mutex_unlock(&dpm_list_mtx);
>  
> 
> 
> 

