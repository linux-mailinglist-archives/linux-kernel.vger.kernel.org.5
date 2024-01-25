Return-Path: <linux-kernel+bounces-38098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0583BAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96B128AB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF4134AB;
	Thu, 25 Jan 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esI5VnS4"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F4134AA;
	Thu, 25 Jan 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168574; cv=none; b=YD8XXphSPo+4eKsw4zAmr6woj4Ec/u1HeTrQSek5gZayJB4NHSiCwYCLYN/aAGCsuUg0/zD7XJiYBBmYYLFbWZShpZ2vTjUw2EXnJW+fIRLS+HyMUFqwAOYo8ObkrlH6WERK7VGyzYKiFSwLxN56062qjgQbUsTMFQ1EZW55U+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168574; c=relaxed/simple;
	bh=DuNQY5tpkFsuCyheCVjMDRjjhKmB1cwgaWJc5iVs+8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxWx772neezl1YORL+l0rBgy71KPhUNdOp7Zrmr6k2UajS2ROxfTFEN1zOEF/JIrzPn/hI8JrSWovjXFHHQq2Ar2Hjut9TN8F44ZxzoNCP678/MdREwg3FJhJT+bzI+pLMg7GMP0kj9ixPQksFk9/R/a1Q5VQIC5BMULMrFcXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esI5VnS4; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168573; x=1737704573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DuNQY5tpkFsuCyheCVjMDRjjhKmB1cwgaWJc5iVs+8k=;
  b=esI5VnS4GBkQ5d+rft+fcLgk4OLpAhuJqV1WJnxXydoOQiAt1XzUglwQ
   HF6J6f/xtw4wQQthjCZ3y/SE/1zLqFakYA5KeLyfMBP5FUvLSiGIdXCFQ
   98PzVzfwGP06J0bjD5vjK8F5Zd8EZ7PZfP49tiazlOVkzwd4BGjI4M0lu
   T1HVYVajEK3+IRV9f9DQXuJtuSr1BLMejKVnnxhqZAEHjzM40Mb+iV8pw
   QKBmV63Gz6Z+oDmHZ+q7x0O52NDJO6aOhpp9NRNqP4QMDQQ45AIO8caA1
   Y/oIaNMfr+Y+rorJVvkpIiysjk15Y3ZJXYlofLzxVeojhO40EH1AFUO4o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405834431"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405834431"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:42:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2274533"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:42:39 -0800
Date: Thu, 25 Jan 2024 08:42:37 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 04/12] PM: sleep: stats: Use an array of step failure
 counters
Message-ID: <ZbIQ7Z5T2xGqzwmu@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <2932420.e9J7NaK4W3@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2932420.e9J7NaK4W3@kreacher>

On Mon, Jan 22, 2024 at 12:27:21PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using a set of individual struct suspend_stats fields
> representing suspend step failure counters, use an array of counters
> indexed by enum suspend_stat_step for this purpose, which allows
> dpm_save_failed_step() to increment the appropriate counter
> automatically, so that its callers don't need to do that directly.
> 
> It also allows suspend_stats_show() to carry out a loop over the
> counters array to print their values.
> 
> Because the counters cannot become negative, use unsigned int for
> representing them.
> 
> The only user-observable impact of this change is a different
> ordering of entries in the suspend_stats debugfs file which is not
> expected to matter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/base/power/main.c |   22 ++++++++-----------
>  include/linux/suspend.h   |   13 +++--------
>  kernel/power/main.c       |   51 ++++++++++++++++++++++++----------------------
>  kernel/power/suspend.c    |    1 
>  4 files changed, 40 insertions(+), 47 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -49,20 +49,14 @@ enum suspend_stat_step {
>  	SUSPEND_SUSPEND_NOIRQ,
>  	SUSPEND_RESUME_NOIRQ,
>  	SUSPEND_RESUME_EARLY,
> -	SUSPEND_RESUME
> +	SUSPEND_RESUME,
> +	SUSPEND_NR_STEPS
>  };
>  
>  struct suspend_stats {
> +	unsigned int step_failures[SUSPEND_NR_STEPS];
>  	int	success;
>  	int	fail;
> -	int	failed_freeze;
> -	int	failed_prepare;
> -	int	failed_suspend;
> -	int	failed_suspend_late;
> -	int	failed_suspend_noirq;
> -	int	failed_resume;
> -	int	failed_resume_early;
> -	int	failed_resume_noirq;
>  #define	REC_FAILED_NUM	2
>  	int	last_failed_dev;
>  	char	failed_devs[REC_FAILED_NUM][40];
> @@ -95,6 +89,7 @@ static inline void dpm_save_failed_errno
>  
>  static inline void dpm_save_failed_step(enum suspend_stat_step step)
>  {
> +	suspend_stats.step_failures[step]++;
>  	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
>  	suspend_stats.last_failed_step++;
>  	suspend_stats.last_failed_step %= REC_FAILED_NUM;
> Index: linux-pm/kernel/power/main.c
> ===================================================================
> --- linux-pm.orig/kernel/power/main.c
> +++ linux-pm/kernel/power/main.c
> @@ -341,18 +341,28 @@ static struct kobj_attribute _name = __A
>  
>  suspend_attr(success, "%d\n");
>  suspend_attr(fail, "%d\n");
> -suspend_attr(failed_freeze, "%d\n");
> -suspend_attr(failed_prepare, "%d\n");
> -suspend_attr(failed_suspend, "%d\n");
> -suspend_attr(failed_suspend_late, "%d\n");
> -suspend_attr(failed_suspend_noirq, "%d\n");
> -suspend_attr(failed_resume, "%d\n");
> -suspend_attr(failed_resume_early, "%d\n");
> -suspend_attr(failed_resume_noirq, "%d\n");
>  suspend_attr(last_hw_sleep, "%llu\n");
>  suspend_attr(total_hw_sleep, "%llu\n");
>  suspend_attr(max_hw_sleep, "%llu\n");
>  
> +#define suspend_step_attr(_name, step)		\
> +static ssize_t _name##_show(struct kobject *kobj,		\
> +		struct kobj_attribute *attr, char *buf)		\
> +{								\
> +	return sprintf(buf, "%u\n",				\
> +		       suspend_stats.step_failures[step]);	\
> +}								\
> +static struct kobj_attribute _name = __ATTR_RO(_name)
> +
> +suspend_step_attr(failed_freeze, SUSPEND_FREEZE);
> +suspend_step_attr(failed_prepare, SUSPEND_PREPARE);
> +suspend_step_attr(failed_suspend, SUSPEND_SUSPEND);
> +suspend_step_attr(failed_suspend_late, SUSPEND_SUSPEND_LATE);
> +suspend_step_attr(failed_suspend_noirq, SUSPEND_SUSPEND_NOIRQ);
> +suspend_step_attr(failed_resume, SUSPEND_RESUME);
> +suspend_step_attr(failed_resume_early, SUSPEND_RESUME_EARLY);
> +suspend_step_attr(failed_resume_noirq, SUSPEND_RESUME_NOIRQ);
> +
>  static ssize_t last_failed_dev_show(struct kobject *kobj,
>  		struct kobj_attribute *attr, char *buf)
>  {
> @@ -439,6 +449,7 @@ static const struct attribute_group susp
>  static int suspend_stats_show(struct seq_file *s, void *unused)
>  {
>  	int i, index, last_dev, last_errno, last_step;
> +	enum suspend_stat_step step;
>  
>  	last_dev = suspend_stats.last_failed_dev + REC_FAILED_NUM - 1;
>  	last_dev %= REC_FAILED_NUM;
> @@ -446,22 +457,14 @@ static int suspend_stats_show(struct seq
>  	last_errno %= REC_FAILED_NUM;
>  	last_step = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
>  	last_step %= REC_FAILED_NUM;
> -	seq_printf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
> -			"%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
> -			"success", suspend_stats.success,
> -			"fail", suspend_stats.fail,
> -			"failed_freeze", suspend_stats.failed_freeze,
> -			"failed_prepare", suspend_stats.failed_prepare,
> -			"failed_suspend", suspend_stats.failed_suspend,
> -			"failed_suspend_late",
> -				suspend_stats.failed_suspend_late,
> -			"failed_suspend_noirq",
> -				suspend_stats.failed_suspend_noirq,
> -			"failed_resume", suspend_stats.failed_resume,
> -			"failed_resume_early",
> -				suspend_stats.failed_resume_early,
> -			"failed_resume_noirq",
> -				suspend_stats.failed_resume_noirq);
> +
> +	seq_printf(s, "success: %d\nfail: %d\n",
> +		   suspend_stats.success, suspend_stats.fail);
> +
> +	for (step = SUSPEND_FREEZE; step < SUSPEND_NR_STEPS; step++)
> +		seq_printf(s, "failed_%s: %u\n", suspend_step_names[step],
> +			   suspend_stats.step_failures[step]);
> +
>  	seq_printf(s,	"failures:\n  last_failed_dev:\t%-s\n",
>  			suspend_stats.failed_devs[last_dev]);
>  	for (i = 1; i < REC_FAILED_NUM; i++) {
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -367,7 +367,6 @@ static int suspend_prepare(suspend_state
>  	if (!error)
>  		return 0;
>  
> -	suspend_stats.failed_freeze++;
>  	dpm_save_failed_step(SUSPEND_FREEZE);
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
>   Restore:
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -686,7 +686,6 @@ Out:
>  	TRACE_RESUME(error);
>  
>  	if (error) {
> -		suspend_stats.failed_resume_noirq++;
>  		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
> @@ -817,7 +816,6 @@ Out:
>  	complete_all(&dev->power.completion);
>  
>  	if (error) {
> -		suspend_stats.failed_resume_early++;
>  		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async early" : " early", error);
> @@ -974,7 +972,6 @@ static void device_resume(struct device
>  	TRACE_RESUME(error);
>  
>  	if (error) {
> -		suspend_stats.failed_resume++;
>  		dpm_save_failed_step(SUSPEND_RESUME);
>  		dpm_save_failed_dev(dev_name(dev));
>  		pm_dev_err(dev, state, async ? " async" : "", error);
> @@ -1323,10 +1320,9 @@ static int dpm_noirq_suspend_devices(pm_
>  	if (!error)
>  		error = async_error;
>  
> -	if (error) {
> -		suspend_stats.failed_suspend_noirq++;
> +	if (error)
>  		dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
> -	}
> +
>  	dpm_show_time(starttime, state, error, "noirq");
>  	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, false);
>  	return error;
> @@ -1509,8 +1505,8 @@ int dpm_suspend_late(pm_message_t state)
>  	async_synchronize_full();
>  	if (!error)
>  		error = async_error;
> +
>  	if (error) {
> -		suspend_stats.failed_suspend_late++;
>  		dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
>  		dpm_resume_early(resume_event(state));
>  	}
> @@ -1789,10 +1785,10 @@ int dpm_suspend(pm_message_t state)
>  	async_synchronize_full();
>  	if (!error)
>  		error = async_error;
> -	if (error) {
> -		suspend_stats.failed_suspend++;
> +
> +	if (error)
>  		dpm_save_failed_step(SUSPEND_SUSPEND);
> -	}
> +
>  	dpm_show_time(starttime, state, error, NULL);
>  	trace_suspend_resume(TPS("dpm_suspend"), state.event, false);
>  	return error;
> @@ -1943,11 +1939,11 @@ int dpm_suspend_start(pm_message_t state
>  	int error;
>  
>  	error = dpm_prepare(state);
> -	if (error) {
> -		suspend_stats.failed_prepare++;
> +	if (error)
>  		dpm_save_failed_step(SUSPEND_PREPARE);
> -	} else
> +	else
>  		error = dpm_suspend(state);
> +
>  	dpm_show_time(starttime, state, error, "start");
>  	return error;
>  }
> 
> 
> 
> 

