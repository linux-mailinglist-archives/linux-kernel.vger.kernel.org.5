Return-Path: <linux-kernel+bounces-38095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F63D83BAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5716B21FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903E17BBD;
	Thu, 25 Jan 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxBMI6Ow"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292E12E54;
	Thu, 25 Jan 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168458; cv=none; b=uQOUsMbciyylHC76ADVHzOYGz0CPSePn3pmuUVcpUK4BA6xo84rgHJhMOaVT4xRvFgq+g5lXUBsKnMWQSzN/khmkY4bk5f3HqYPR02qxRQZ0oZfF+A5td8FC99KpXjKQeWLmM3+3l2N92S9jUAwZ7+Qn8TuYSXwfDJKxinvmV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168458; c=relaxed/simple;
	bh=r3JtH1Ui6kSD1qodWct9HfimeEcB9akkZ4WQUOcpEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiIxHD2azegZkJTrBP7ICOSsfPjZBj7QXhagoka2kggfaXIvsYRR8z1HxM5DC0kfB3ZVasF3bc9Y3N4g2hDAAIgy6EEbuBRClZheoNQ9vAhS5cbAsmSxiNCkaDKP78fW+84IdreMPU/lQxysWvEAQko7+Ekt3pOM+FsDtWBvSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxBMI6Ow; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168456; x=1737704456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3JtH1Ui6kSD1qodWct9HfimeEcB9akkZ4WQUOcpEMY=;
  b=LxBMI6Owc5OgGoQoBxMFw0H1Gl6Kj27cBdN4sUMeROQxO/d8z4NOc/yy
   xoNNy+seFU2mqmE+nWHwsx1LXorHyoyqA5cEMKcxELvrvkvmkENv5vOom
   V6n6OlL+KM/ndBHU3djkri2ivOoCRORR+6fr/7lVlymE+x310TUggsAB8
   6NljKd6X9bZZ6b6dTuUMg/CB2XYF2jWq9EbCSqySl8Eser866keCYpHO7
   CXt3XHkxH6IXMdI58SDpsNqrRUPil2iHEwuDWiEjtaEfPugkj0D7tKmzW
   LFzeTeTYM4lifXUZ9rEcjfBeLdNO0TxOnnVXuwcXQje8hNWx3+J0l8yrL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400943284"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400943284"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2137835"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:40:54 -0800
Date: Thu, 25 Jan 2024 08:40:50 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 02/12] PM: sleep: Relocate two device PM core functions
Message-ID: <ZbIQgnhstsdzk5/K@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <4876491.GXAFRqVoOG@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4876491.GXAFRqVoOG@kreacher>

On Mon, Jan 22, 2024 at 12:24:21PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move is_async() and dpm_async_fn() in the PM core to a more suitable
> place.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/base/power/main.c |   58 +++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -578,6 +578,35 @@ bool dev_pm_skip_resume(struct device *d
>  	return !dev->power.must_resume;
>  }
>  
> +static bool is_async(struct device *dev)
> +{
> +	return dev->power.async_suspend && pm_async_enabled
> +		&& !pm_trace_is_enabled();
> +}
> +
> +static bool dpm_async_fn(struct device *dev, async_func_t func)
> +{
> +	reinit_completion(&dev->power.completion);
> +
> +	if (is_async(dev)) {
> +		dev->power.async_in_progress = true;
> +
> +		get_device(dev);
> +
> +		if (async_schedule_dev_nocall(func, dev))
> +			return true;
> +
> +		put_device(dev);
> +	}
> +	/*
> +	 * Because async_schedule_dev_nocall() above has returned false or it
> +	 * has not been called at all, func() is not running and it is safe to
> +	 * update the async_in_progress flag without extra synchronization.
> +	 */
> +	dev->power.async_in_progress = false;
> +	return false;
> +}
> +
>  /**
>   * device_resume_noirq - Execute a "noirq resume" callback for given device.
>   * @dev: Device to handle.
> @@ -664,35 +693,6 @@ Out:
>  	}
>  }
>  
> -static bool is_async(struct device *dev)
> -{
> -	return dev->power.async_suspend && pm_async_enabled
> -		&& !pm_trace_is_enabled();
> -}
> -
> -static bool dpm_async_fn(struct device *dev, async_func_t func)
> -{
> -	reinit_completion(&dev->power.completion);
> -
> -	if (is_async(dev)) {
> -		dev->power.async_in_progress = true;
> -
> -		get_device(dev);
> -
> -		if (async_schedule_dev_nocall(func, dev))
> -			return true;
> -
> -		put_device(dev);
> -	}
> -	/*
> -	 * Because async_schedule_dev_nocall() above has returned false or it
> -	 * has not been called at all, func() is not running and it is safe to
> -	 * update the async_in_progress flag without extra synchronization.
> -	 */
> -	dev->power.async_in_progress = false;
> -	return false;
> -}
> -
>  static void async_resume_noirq(void *data, async_cookie_t cookie)
>  {
>  	struct device *dev = data;
> 
> 
> 
> 

