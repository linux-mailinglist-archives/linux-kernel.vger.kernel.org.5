Return-Path: <linux-kernel+bounces-44019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC2841C48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A7B1C24341
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536434C60E;
	Tue, 30 Jan 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRPxINLe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ECD4F1EA;
	Tue, 30 Jan 2024 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598177; cv=none; b=aid86MKNdRmSGucBBvsCK+baWUzZu/0vwRZKr/LnYZMJnzu71odvc1KZFj5gcH8M6Esi8KVydhNHPYJmMB/k4zU38fMJ6BQp5Xx/Z8UEfDY45S0JW9xdLsG59ohmqNDxM64XAu6Dm1hhy4pPWmY4nyFQZ0ghgg/uDia5xFtmCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598177; c=relaxed/simple;
	bh=AEZ7a4tJowAP2F0Ky8MCjN2LuXRMiR/y3YCMbr8vtYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaCuAl7kO1Whuh/KdJSLaToJtZLqhcvY72IOePJDDKxF/mnbs3p/SGbjiybVTMm+DVLJHOiv+w7C3X4Tyu3ieiYuNd27to1rtKhdY6KhpquftmsgxjQVFcby82hPKJi8CCgTc4FfnAEJ56aVzCbesJFUr9FTHUO5aVtgUkp2cEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRPxINLe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706598176; x=1738134176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AEZ7a4tJowAP2F0Ky8MCjN2LuXRMiR/y3YCMbr8vtYQ=;
  b=iRPxINLe81FXk8Dh6UVEFqecR3g9/K4ppJ8EK/P3avpXUTBbnYT3hfqc
   HgS8rncAyFJJC32yCj5luV8UNsi6qidSVPrXiafTdqDrQszDWuvxbtdAe
   5C2bak6SivP7lG6T6TsY+Dd69NlRc5wEnqXSJkbZqeBwJnDH9GlkLulrQ
   /mnJP50Nt1xXtKt87k/GwZKZBNc93Ya+FnrCBNRj952zUCKc6ncaGJY1R
   75R1Hyh7keuTuoPFlTLrqfI9dfWOwHuJddqqUBj2mA9KFtUTcNVaUmK7b
   l7Hyjr3osQ1YBpZQzPrrpp8sM2p+TPoiA0INFuYolmlsRjtAHohQ87MTM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3064200"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3064200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737679411"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737679411"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.42.115])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:02:53 -0800
Date: Tue, 30 Jan 2024 08:02:51 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 03/10] PM: sleep: stats: Use unsigned int for success
 and failure counters
Message-ID: <ZbifGzqpXauGyGwc@linux.intel.com>
References: <5770175.DvuYhMxLoT@kreacher>
 <2941406.e9J7NaK4W3@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2941406.e9J7NaK4W3@kreacher>

On Mon, Jan 29, 2024 at 05:13:14PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Change the type of the "success" and "fail" fields in struct
> suspend_stats to unsigned int, because they cannot be negative.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
> 
> v1 -> v2: New patch.
> 
> ---
>  include/linux/suspend.h |    4 ++--
>  kernel/power/main.c     |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -56,8 +56,8 @@ enum suspend_stat_step {
>  
>  struct suspend_stats {
>  	unsigned int step_failures[SUSPEND_NR_STEPS];
> -	int	success;
> -	int	fail;
> +	unsigned int success;
> +	unsigned int fail;
>  #define	REC_FAILED_NUM	2
>  	int	last_failed_dev;
>  	char	failed_devs[REC_FAILED_NUM][40];
> Index: linux-pm/kernel/power/main.c
> ===================================================================
> --- linux-pm.orig/kernel/power/main.c
> +++ linux-pm/kernel/power/main.c
> @@ -339,8 +339,8 @@ static ssize_t _name##_show(struct kobje
>  }								\
>  static struct kobj_attribute _name = __ATTR_RO(_name)
>  
> -suspend_attr(success, "%d\n");
> -suspend_attr(fail, "%d\n");
> +suspend_attr(success, "%u\n");
> +suspend_attr(fail, "%u\n");
>  suspend_attr(last_hw_sleep, "%llu\n");
>  suspend_attr(total_hw_sleep, "%llu\n");
>  suspend_attr(max_hw_sleep, "%llu\n");
> @@ -458,7 +458,7 @@ static int suspend_stats_show(struct seq
>  	last_step = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
>  	last_step %= REC_FAILED_NUM;
>  
> -	seq_printf(s, "success: %d\nfail: %d\n",
> +	seq_printf(s, "success: %u\nfail: %u\n",
>  		   suspend_stats.success, suspend_stats.fail);
>  
>  	for (step = SUSPEND_FREEZE; step <= SUSPEND_NR_STEPS; step++)
> 
> 
> 
> 

