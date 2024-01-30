Return-Path: <linux-kernel+bounces-44033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2754C841C78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8DA1C25493
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C854EB49;
	Tue, 30 Jan 2024 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uel/6Lg+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369555C2D;
	Tue, 30 Jan 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599217; cv=none; b=FMFejVP9fsS+LpJl0l1lq6LHCKbO7Q3uKvkRCtaaCxiRKpE87lqTlEH/Dpanig2Ki8XbdgD7/lqtTMEdTuvY5uDuJuOlYjTek1euRJpO03VMmdPTU+zi/APAEUhfL/gFuHsmd3kYU0baIm/XMEqaXmbsnwvttbDVslEZRZ3CX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599217; c=relaxed/simple;
	bh=50of1iRlpyR0+qBELyvikrNaqZ2J5lBZByuAj1ASK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx8N7iHlyyWd6RAjQC3ddl2gRtjsZL0OSvjOjXzUB8I9eDnGdA/WKrgR8DQTKQ+zqUD5hyVxNRGD02rohc4WiPmHjuIyauxV1t+qr+Q5ee74/l24bRX1qdbryk9DvVzEcSddNCd+asEDViB2u2GuIUC9AjTO2Q2GCpx4Mjx21Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uel/6Lg+; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706599215; x=1738135215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=50of1iRlpyR0+qBELyvikrNaqZ2J5lBZByuAj1ASK+w=;
  b=Uel/6Lg+JOIYhGj0igtH7gl3GDIb7XVrccBuuBCWHm4kMwwW6ThF/GTt
   B8h60Y07cf7/67CCYvYAaFj4NSmCGbdgKFK9gPzxi2U2+JCkh/60MyjOc
   81QdugcbKTzP3spFBUH40FcBJq4MRXPB7wfqPPIGZMqD9LzmOESFBr31e
   AqrtAECVW4r1YZQ9K1tl/yAGQJ9g6/lS8uW0uOczVTEvR276RyZHRppvr
   xpMY4DwYm9ynchbwaIKrc3BNkuImPSZCxVK1Kc2tB9oFAqQXn4qwYRtEI
   /HDcRvn+YEnAfHoD94ctAm/Sc4HI3WfXEHNMExFua8l30vKDe6mJnrQZM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="434366340"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="434366340"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="29802214"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:20:13 -0800
Date: Tue, 30 Jan 2024 08:20:10 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 05/10] PM: sleep: stats: Call dpm_save_failed_step()
 at most once per phase
Message-ID: <ZbijKpi2CvwoV/gB@linux.intel.com>
References: <5770175.DvuYhMxLoT@kreacher>
 <23401570.6Emhk5qWAg@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23401570.6Emhk5qWAg@kreacher>

On Mon, Jan 29, 2024 at 05:24:04PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the handling of two or more devices fails in one suspend-resume
> phase, it should be counted once in the statistics which is not
> guaranteed to happen during system-wide resume of devices due to
> the possible asynchronous execution of device callbacks.
> 
> Address this by using the async_error static variable during system-wide
> device resume to indicate that there has been a device resume error and
> the given suspend-resume phase should be counted as failing.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
> 
> v1 -> v2: No changes.
> 
> ---
>  drivers/base/power/main.c |   20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -685,7 +685,7 @@ Out:
>  	TRACE_RESUME(error);
>  
>  	if (error) {
> -		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> +		async_error = error;
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
>  	}
> @@ -705,6 +705,9 @@ static void dpm_noirq_resume_devices(pm_
>  	ktime_t starttime = ktime_get();
>  
>  	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
> +
> +	async_error = 0;
> +
>  	mutex_lock(&dpm_list_mtx);
>  	pm_transition = state;
>  
> @@ -734,6 +737,9 @@ static void dpm_noirq_resume_devices(pm_
>  	mutex_unlock(&dpm_list_mtx);
>  	async_synchronize_full();
>  	dpm_show_time(starttime, state, 0, "noirq");
> +	if (async_error)
> +		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
> +
>  	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
>  }
>  
> @@ -815,7 +821,7 @@ Out:
>  	complete_all(&dev->power.completion);
>  
>  	if (error) {
> -		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
> +		async_error = error;
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async early" : " early", error);
>  	}
> @@ -839,6 +845,9 @@ void dpm_resume_early(pm_message_t state
>  	ktime_t starttime = ktime_get();
>  
>  	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
> +
> +	async_error = 0;
> +
>  	mutex_lock(&dpm_list_mtx);
>  	pm_transition = state;
>  
> @@ -868,6 +877,9 @@ void dpm_resume_early(pm_message_t state
>  	mutex_unlock(&dpm_list_mtx);
>  	async_synchronize_full();
>  	dpm_show_time(starttime, state, 0, "early");
> +	if (async_error)
> +		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
> +
>  	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
>  }
>  
> @@ -971,7 +983,7 @@ static void device_resume(struct device
>  	TRACE_RESUME(error);
>  
>  	if (error) {
> -		dpm_save_failed_step(SUSPEND_RESUME);
> +		async_error = error;
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async" : "", error);
>  	}
> @@ -1030,6 +1042,8 @@ void dpm_resume(pm_message_t state)
>  	mutex_unlock(&dpm_list_mtx);
>  	async_synchronize_full();
>  	dpm_show_time(starttime, state, 0, NULL);
> +	if (async_error)
> +		dpm_save_failed_step(SUSPEND_RESUME);
>  
>  	cpufreq_resume();
>  	devfreq_resume();
> 
> 
> 

