Return-Path: <linux-kernel+bounces-38123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FF283BB29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F6F1C2512B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF817551;
	Thu, 25 Jan 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxUNIcyd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD40E17BA9;
	Thu, 25 Jan 2024 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169656; cv=none; b=hpRDALAMsj0gzgQADixvOHxrIif20B5aC+6xOqjczQdE6xgzv7wlXMDBO9A2BTtMr1qNrPcauyuA3uXtz2Tzz3A6UHsMabYk8eXCsVbGltxUjjFw/10Zk4nq3u2ORRdXl1EN6voSfu0SyU3l1lmo37/mX+hSsrrAIWx5OsDUX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169656; c=relaxed/simple;
	bh=F9/G401OlOp2TMBz9e7CH/PQuSGM0woS/H9KkQV4uIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTI19pXP9uG1zJy5HThGIPMTMQHTDpD280ZFzYhpS5DEp/+sutyqkyoaypOLbbhCTBUmccKUEA+vpJGWRxGZBsqI+4R2pMAmr/gnpuIqMfFBpHKVdDF33STxyRE0+/DGM4xfRuI8f+E5Lg4SOaGePF/BpgjgxJBqaIhpTWel8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxUNIcyd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706169655; x=1737705655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F9/G401OlOp2TMBz9e7CH/PQuSGM0woS/H9KkQV4uIY=;
  b=RxUNIcydAWnGfHLQYR/+kk7rnLco/rt1XRmXQK6Rr6GFAD8l/mQ1INQM
   KrLOJYP57vaelYWy3WYppaR5HaNd/2pFomicYJOB6LmePi4tDqlqU4ovL
   0l7R4AaWe3SUN9Z1N4Zd+3fHzhrITkkZWm3C+3NVyDjljTWlQC/tiFAT6
   jvBkgd9U2Icp0YhYnsGMBD8h47AQl/qdDF3GC1h3cKRkR0pwIHH9p4LgN
   EhDjdYw/s7k3wNB381oSBQ1nHinJpT1EmD0es+Hpgk97JJGMFndsAFY2e
   PBj7tQyPWxyaa/2m9td7mA9CraOBT4BNhBp87+PSIUOIVsKHiJqH7LU4i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20639198"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20639198"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:00:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20975173"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:00:49 -0800
Date: Thu, 25 Jan 2024 09:00:47 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 11/12] PM: sleep: Move devices to new lists earlier in
 each suspend phase
Message-ID: <ZbIVL4WRqx42BX5C@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <3476604.QJadu78ljV@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3476604.QJadu78ljV@kreacher>

On Mon, Jan 22, 2024 at 12:42:46PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> During a system-wide suspend of devices, dpm_noirq_suspend_devices(),
> dpm_suspend_late() and dpm_suspend() move devices from one list to
> another.  They do it with each device after its PM callback in the
> given suspend phase has run or has been scheduled for asynchronous
> execution, in case it is deleted from the current list in the
> meantime.
> 
> However, devices can be moved to a new list before invoking their PM
> callbacks (which usually is the case for the devices whose callbacks
> are executed asynchronously anyway), because doing so does not affect
> the ordering of that list.  In either case, each device is moved to
> the new list after the previous device has been moved to it or gone
> away, and if a device is removed, it does not matter which list it is
> in at that point, because deleting an entry from a list does not change
> the ordering of the other entries in it.
> 
> Accordingly, modify the functions mentioned above to move devices to
> new lists without waiting for their PM callbacks to run regardless of
> whether or not they run asynchronously.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/base/power/main.c |   24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1304,18 +1304,12 @@ static int dpm_noirq_suspend_devices(pm_
>  	while (!list_empty(&dpm_late_early_list)) {
>  		struct device *dev = to_device(dpm_late_early_list.prev);
>  
> +		list_move(&dev->power.entry, &dpm_noirq_list);
>  		get_device(dev);
>  		mutex_unlock(&dpm_list_mtx);
>  
>  		error = device_suspend_noirq(dev);
>  
> -		mutex_lock(&dpm_list_mtx);
> -
> -		if (!error && !list_empty(&dev->power.entry))
> -			list_move(&dev->power.entry, &dpm_noirq_list);
> -
> -		mutex_unlock(&dpm_list_mtx);
> -
>  		put_device(dev);
>  
>  		mutex_lock(&dpm_list_mtx);
> @@ -1486,19 +1480,13 @@ int dpm_suspend_late(pm_message_t state)
>  	while (!list_empty(&dpm_suspended_list)) {
>  		struct device *dev = to_device(dpm_suspended_list.prev);
>  
> +		list_move(&dev->power.entry, &dpm_late_early_list);
>  		get_device(dev);
>  
>  		mutex_unlock(&dpm_list_mtx);
>  
>  		error = device_suspend_late(dev);
>  
> -		mutex_lock(&dpm_list_mtx);
> -
> -		if (!list_empty(&dev->power.entry))
> -			list_move(&dev->power.entry, &dpm_late_early_list);
> -
> -		mutex_unlock(&dpm_list_mtx);
> -
>  		put_device(dev);
>  
>  		mutex_lock(&dpm_list_mtx);
> @@ -1763,19 +1751,13 @@ int dpm_suspend(pm_message_t state)
>  	while (!list_empty(&dpm_prepared_list)) {
>  		struct device *dev = to_device(dpm_prepared_list.prev);
>  
> +		list_move(&dev->power.entry, &dpm_suspended_list);
>  		get_device(dev);
>  
>  		mutex_unlock(&dpm_list_mtx);
>  
>  		error = device_suspend(dev);
>  
> -		mutex_lock(&dpm_list_mtx);
> -
> -		if (!error && !list_empty(&dev->power.entry))
> -			list_move(&dev->power.entry, &dpm_suspended_list);
> -
> -		mutex_unlock(&dpm_list_mtx);
> -
>  		put_device(dev);
>  
>  		mutex_lock(&dpm_list_mtx);
> 
> 
> 
> 

