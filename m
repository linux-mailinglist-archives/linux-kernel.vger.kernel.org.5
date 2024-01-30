Return-Path: <linux-kernel+bounces-44034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C360841C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F9BB24A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24D4F1EE;
	Tue, 30 Jan 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fe3J+soW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D224EB41;
	Tue, 30 Jan 2024 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599296; cv=none; b=rtkx2mcfuF8AmhVC8/0yX/0IQBaKxl/eJWXivRrapM6RHtijwnaShUbAWMcBkpCbvvClFK1F842pVX8olP1ssB+ZYbnC+Rq1Bjbrnaod3OXIsMezinrV1U5jeGQoRRgmjOhhfQBrQEq2jRVz7qYUu93idepLnBDHYJ1v444FBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599296; c=relaxed/simple;
	bh=tSB6EPHkugRg1IchrfqLds1PZx5JuhXbsW6yBlZ7EVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eawGO07tIuVunNpApA+msUT93r0s2doxdRf/6zDAmSZVWGuq1qveHRaGvXA3ww7EaQ4crxsveH+HjKiG0RngFMdITlv2PzFcRMslSpeok4kJjAleS7xVyN6X0XNR2I3D5DWS8xek8yxH7GI5hmI6Q2W/s6aRUhNIjV1GrN20hrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fe3J+soW; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706599294; x=1738135294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tSB6EPHkugRg1IchrfqLds1PZx5JuhXbsW6yBlZ7EVM=;
  b=Fe3J+soWgONhjFNe1ExFTy3EoqNSC1s8mttPLi1mRsBAc/8qjhyjhRMc
   0scaiIPvOyLz6E23ti4TirpIU9ckwrgwo+yuinLRdZw2pdTGLBRbvXDer
   bYB3VDGlOmhj2qUpWeA2zaL/8yQFUJ/VVNnrpuostdv3xWtFG3jw0wHED
   YR1CxUayjeLRlXyHV+N8lDG+78WeK3icCFuecgEEJilGYozcm81fIut5O
   Zfe91i4URZH2oholoSRHr+yUWEwfzS2A+4H/3ftQemcGRBfHYnHchGnnv
   Jl8RKLy6i+qOV6BlxMbCXuOn+3f2mypFDDeORL3OkfBhdE/IIGYVAtUVO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393624513"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="393624513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737681679"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737681679"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.115])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:21:32 -0800
Date: Tue, 30 Jan 2024 08:21:30 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 08/10] PM: sleep: Move some assignments from under a
 lock
Message-ID: <Zbijetaso8dpog9m@linux.intel.com>
References: <5770175.DvuYhMxLoT@kreacher>
 <3750318.MHq7AAxBmi@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3750318.MHq7AAxBmi@kreacher>

On Mon, Jan 29, 2024 at 05:27:33PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The async_error and pm_transition variables are set under dpm_list_mtx
> in multiple places in the system-wide device PM core code, which is
> unnecessary and confusing, so rearrange the code so that the variables
> in question are set before acquiring the lock.
> 
> While at it, add some empty code lines around locking to improve the
> consistency of the code.
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
>  drivers/base/power/main.c |   28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -707,9 +707,9 @@ static void dpm_noirq_resume_devices(pm_
>  	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
>  
>  	async_error = 0;
> +	pm_transition = state;
>  
>  	mutex_lock(&dpm_list_mtx);
> -	pm_transition = state;
>  
>  	/*
>  	 * Trigger the resume of "async" devices upfront so they don't have to
> @@ -847,9 +847,9 @@ void dpm_resume_early(pm_message_t state
>  	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
>  
>  	async_error = 0;
> +	pm_transition = state;
>  
>  	mutex_lock(&dpm_list_mtx);
> -	pm_transition = state;
>  
>  	/*
>  	 * Trigger the resume of "async" devices upfront so they don't have to
> @@ -1012,10 +1012,11 @@ void dpm_resume(pm_message_t state)
>  	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
>  	might_sleep();
>  
> -	mutex_lock(&dpm_list_mtx);
>  	pm_transition = state;
>  	async_error = 0;
>  
> +	mutex_lock(&dpm_list_mtx);
> +
>  	/*
>  	 * Trigger the resume of "async" devices upfront so they don't have to
>  	 * wait for the "non-async" ones they don't depend on.
> @@ -1294,10 +1295,12 @@ static int dpm_noirq_suspend_devices(pm_
>  	int error = 0;
>  
>  	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
> -	mutex_lock(&dpm_list_mtx);
> +
>  	pm_transition = state;
>  	async_error = 0;
>  
> +	mutex_lock(&dpm_list_mtx);
> +
>  	while (!list_empty(&dpm_late_early_list)) {
>  		struct device *dev = to_device(dpm_late_early_list.prev);
>  
> @@ -1320,7 +1323,9 @@ static int dpm_noirq_suspend_devices(pm_
>  		if (error || async_error)
>  			break;
>  	}
> +
>  	mutex_unlock(&dpm_list_mtx);
> +
>  	async_synchronize_full();
>  	if (!error)
>  		error = async_error;
> @@ -1470,11 +1475,14 @@ int dpm_suspend_late(pm_message_t state)
>  	int error = 0;
>  
>  	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
> -	wake_up_all_idle_cpus();
> -	mutex_lock(&dpm_list_mtx);
> +
>  	pm_transition = state;
>  	async_error = 0;
>  
> +	wake_up_all_idle_cpus();
> +
> +	mutex_lock(&dpm_list_mtx);
> +
>  	while (!list_empty(&dpm_suspended_list)) {
>  		struct device *dev = to_device(dpm_suspended_list.prev);
>  
> @@ -1498,7 +1506,9 @@ int dpm_suspend_late(pm_message_t state)
>  		if (error || async_error)
>  			break;
>  	}
> +
>  	mutex_unlock(&dpm_list_mtx);
> +
>  	async_synchronize_full();
>  	if (!error)
>  		error = async_error;
> @@ -1745,9 +1755,11 @@ int dpm_suspend(pm_message_t state)
>  	devfreq_suspend();
>  	cpufreq_suspend();
>  
> -	mutex_lock(&dpm_list_mtx);
>  	pm_transition = state;
>  	async_error = 0;
> +
> +	mutex_lock(&dpm_list_mtx);
> +
>  	while (!list_empty(&dpm_prepared_list)) {
>  		struct device *dev = to_device(dpm_prepared_list.prev);
>  
> @@ -1771,7 +1783,9 @@ int dpm_suspend(pm_message_t state)
>  		if (error || async_error)
>  			break;
>  	}
> +
>  	mutex_unlock(&dpm_list_mtx);
> +
>  	async_synchronize_full();
>  	if (!error)
>  		error = async_error;
> 
> 
> 
> 

