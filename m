Return-Path: <linux-kernel+bounces-12966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCCA81FD68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FD1C20D79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759D5669;
	Fri, 29 Dec 2023 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiQTcVbY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D023A4;
	Fri, 29 Dec 2023 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703833354; x=1735369354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LSvcQG3U5KLGAazpVSYk1Ga5VrUD6NmAFmtR76jg2NM=;
  b=hiQTcVbYe75ZaXEdPFno8/L5gezyXbK5BICsGSJMweq9yAG6Pf6YhZCq
   b/E7C7Le3obbZSEGwdiApPbveSSs8EO9ZUrXUuLnTDciYJbGnEA6HVbj6
   Si4tG27m+eur84QedpxJU59QQF4VV5PKW+4hH9p6JvtskMbANmHTGw2+N
   ldGk1YnVONg2YADtWfjgkZc3YZvgckt0qk16PkjLImsxL9fevZizsWKYD
   2MrPMStOEv/y1vlcYZY9Be8aACdwzQDLVIrFlk9G2VTBP7BQC1pAfJww0
   l7gXCXQh+3iZgh3zOMkHuWUbWeKbToteWg11CWLKzK6fkj/s00QVdeNY0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381600831"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="381600831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 23:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="27070934"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.82])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 23:02:31 -0800
Date: Thu, 28 Dec 2023 21:29:45 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Youngmin Nam <youngmin.nam@samsung.com>, rafael@kernel.org,
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com,
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/3] async: Introduce async_schedule_dev_nocall()
Message-ID: <ZY3auVvVzxwTmAX8@linux.intel.com>
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher>
 <6019796.lOV4Wx5bFT@kreacher>
 <4874693.GXAFRqVoOG@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4874693.GXAFRqVoOG@kreacher>

On Wed, Dec 27, 2023 at 09:38:23PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In preparation for subsequent changes, introduce a specialized variant
> of async_schedule_dev() that will not invoke the argument function
> synchronously when it cannot be scheduled for asynchronous execution.
> 
> The new function, async_schedule_dev_nocall(), will be used for fixing
> possible deadlocks in the system-wide power management core code.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   12 ++++++++----
>  include/linux/async.h     |    2 ++
>  kernel/async.c            |   29 +++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/kernel/async.c
> ===================================================================
> --- linux-pm.orig/kernel/async.c
> +++ linux-pm/kernel/async.c
> @@ -244,6 +244,35 @@ async_cookie_t async_schedule_node(async
>  EXPORT_SYMBOL_GPL(async_schedule_node);
>  
>  /**
> + * async_schedule_dev_nocall - A simplified variant of async_schedule_dev()
> + * @func: function to execute asynchronously
> + * @dev: device argument to be passed to function
> + *
> + * @dev is used as both the argument for the function and to provide NUMA
> + * context for where to run the function.
> + *
> + * If the asynchronous execution of @func is scheduled successfully, return
> + * true. Otherwise, do nothing and return false, unlike async_schedule_dev()
> + * that will run the function synchronously then.
> + */
> +bool async_schedule_dev_nocall(async_func_t func, struct device *dev)
> +{
> +	struct async_entry *entry;
> +
> +	entry = kzalloc(sizeof(struct async_entry), GFP_KERNEL);

Is GFP_KERNEL intended here ? I think it's not safe since will
be called from device_resume_noirq() .

Regards
Stanislaw


