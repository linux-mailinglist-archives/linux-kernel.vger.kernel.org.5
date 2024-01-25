Return-Path: <linux-kernel+bounces-38107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B583BB04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099321C241DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BBB13FE5;
	Thu, 25 Jan 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXxvNR03"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385917580;
	Thu, 25 Jan 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169216; cv=none; b=ZhgyAQdRoOmYvV2rjp2fYftoyA1eaA46EA2599SmEYpee5DWYI7n6o1tyx85gJnkFp12SZj5CUfbTfnF8z8bz/8p30At+tZ38yh725sBoqXZE8ox8p+nxSFAgGbUCH5Z055GfFll+2hmZchee5nyIkrSy1oVwlbufl0xcBqFrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169216; c=relaxed/simple;
	bh=RyEcBC0IbL1iRAjODm0+kJkhISFOYH43kPnfU1p06II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skzAlKoGSWevO8/euGV62OzozZKDSSFtzUhEDbrGVgMo3z6+QT+HWIbneNkP69eHNmbGcLKhv/i2SvChvc7FOCdssU83UKmwRH+PWs15YTWsNiNQfbaNBaCbMvbawTSuom8/LMh4Ud0nPKeLKTHMJ51zVaBmITxzxLQ+4QlBhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXxvNR03; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706169215; x=1737705215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RyEcBC0IbL1iRAjODm0+kJkhISFOYH43kPnfU1p06II=;
  b=XXxvNR03xX916V1oqqqYHRMlEiWY3ETYa0STra5XCzvbaI2j4II9zFIX
   MDlxcaiH0moY/m5t3CMzV1ZuO7DMeTApZIMQaHreNTrdbjwueEbK4XoOW
   H0KZdyM6Bha160pKnsSIU02qW1EhiktfhlrrQm0Z0FGLozXSns+YIl9Rp
   wv4A9vwX1jm+fC9V1DmxVcR+tZF76k0yclinuLQuNJ1lTM13LRVEF5eH1
   V09OGYM+cdk+hNT6OCY0pDGPSSv+N/nT1HjFGjz/0qx9xBd78ELyrZMz7
   bOKfRqB8XyfHWvpDmw2mmNy67FYR3YHXGtIw2//5jyapS1PCjagbb3UnW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="23553179"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="23553179"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:53:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2316380"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:53:32 -0800
Date: Thu, 25 Jan 2024 08:53:30 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 06/12] PM: sleep: stats: Define suspend_stats next to
 the code using it
Message-ID: <ZbITekHgmZl9TmCu@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <2266871.iZASKD2KPV@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2266871.iZASKD2KPV@kreacher>

On Mon, Jan 22, 2024 at 12:31:20PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is not necessary to define struct suspend_stats in a header file and the
> suspend_stats variable in the core device system-wide PM code.  They both
> can be defined in kernel/power/main.c, next to the sysfs and debugfs code
> accessing suspend_stats, which can be static.
> 
> Modify the code in question in accordance with the above observation and
> replace the static inline functions manipulating suspend_stats with
> regular ones defined in kernel/power/main.c.
> 
> While at it, move the enum suspend_stat_step to the end of suspend.h which
> is a more suitable place for it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/base/power/main.c |    1 
>  include/linux/suspend.h   |   70 +++++++++----------------------------------
>  kernel/power/main.c       |   74 +++++++++++++++++++++++++++++++++++++---------
>  kernel/power/power.h      |    2 +
>  kernel/power/suspend.c    |    7 ----
>  5 files changed, 80 insertions(+), 74 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -40,60 +40,6 @@ typedef int __bitwise suspend_state_t;
>  #define PM_SUSPEND_MIN		PM_SUSPEND_TO_IDLE
>  #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
>  
> -enum suspend_stat_step {
> -	SUSPEND_NONE = 0,
> -	SUSPEND_FREEZE,
> -	SUSPEND_PREPARE,
> -	SUSPEND_SUSPEND,
> -	SUSPEND_SUSPEND_LATE,
> -	SUSPEND_SUSPEND_NOIRQ,
> -	SUSPEND_RESUME_NOIRQ,
> -	SUSPEND_RESUME_EARLY,
> -	SUSPEND_RESUME,
> -	SUSPEND_NR_STEPS
> -};
> -
> -struct suspend_stats {
> -	unsigned int step_failures[SUSPEND_NR_STEPS];
> -	unsigned int fail;
> -#define	REC_FAILED_NUM	2
> -	int	last_failed_dev;
> -	char	failed_devs[REC_FAILED_NUM][40];
> -	int	last_failed_errno;
> -	int	errno[REC_FAILED_NUM];
> -	int	last_failed_step;
> -	u64	last_hw_sleep;
> -	u64	total_hw_sleep;
> -	u64	max_hw_sleep;
> -	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
> -};
> -
> -extern struct suspend_stats suspend_stats;
> -
> -static inline void dpm_save_failed_dev(const char *name)
> -{
> -	strscpy(suspend_stats.failed_devs[suspend_stats.last_failed_dev],
> -		name,
> -		sizeof(suspend_stats.failed_devs[0]));
> -	suspend_stats.last_failed_dev++;
> -	suspend_stats.last_failed_dev %= REC_FAILED_NUM;
> -}
> -
> -static inline void dpm_save_failed_errno(int err)
> -{
> -	suspend_stats.errno[suspend_stats.last_failed_errno] = err;
> -	suspend_stats.last_failed_errno++;
> -	suspend_stats.last_failed_errno %= REC_FAILED_NUM;
> -}
> -
> -static inline void dpm_save_failed_step(enum suspend_stat_step step)
> -{
> -	suspend_stats.step_failures[step]++;
> -	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
> -	suspend_stats.last_failed_step++;
> -	suspend_stats.last_failed_step %= REC_FAILED_NUM;
> -}
> -
>  /**
>   * struct platform_suspend_ops - Callbacks for managing platform dependent
>   *	system sleep states.
> @@ -621,4 +567,20 @@ static inline void queue_up_suspend_work
>  
>  #endif /* !CONFIG_PM_AUTOSLEEP */
>  
> +enum suspend_stat_step {
> +	SUSPEND_NONE = 0,
> +	SUSPEND_FREEZE,
> +	SUSPEND_PREPARE,
> +	SUSPEND_SUSPEND,
> +	SUSPEND_SUSPEND_LATE,
> +	SUSPEND_SUSPEND_NOIRQ,
> +	SUSPEND_RESUME_NOIRQ,
> +	SUSPEND_RESUME_EARLY,
> +	SUSPEND_RESUME,
> +	SUSPEND_NR_STEPS
> +};
> +
> +void dpm_save_failed_dev(const char *name);
> +void dpm_save_failed_step(enum suspend_stat_step step);
> +
>  #endif /* _LINUX_SUSPEND_H */
> Index: linux-pm/kernel/power/main.c
> ===================================================================
> --- linux-pm.orig/kernel/power/main.c
> +++ linux-pm/kernel/power/main.c
> @@ -95,19 +95,6 @@ int unregister_pm_notifier(struct notifi
>  }
>  EXPORT_SYMBOL_GPL(unregister_pm_notifier);
>  
> -void pm_report_hw_sleep_time(u64 t)
> -{
> -	suspend_stats.last_hw_sleep = t;
> -	suspend_stats.total_hw_sleep += t;
> -}
> -EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
> -
> -void pm_report_max_hw_sleep(u64 t)
> -{
> -	suspend_stats.max_hw_sleep = t;
> -}
> -EXPORT_SYMBOL_GPL(pm_report_max_hw_sleep);
> -
>  int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
>  {
>  	int ret;
> @@ -319,6 +306,67 @@ static ssize_t pm_test_store(struct kobj
>  power_attr(pm_test);
>  #endif /* CONFIG_PM_SLEEP_DEBUG */
>  
> +#define REC_FAILED_NUM	2
> +
> +struct suspend_stats {
> +	unsigned int step_failures[SUSPEND_NR_STEPS];
> +	unsigned int fail;
> +	int last_failed_dev;
> +	char failed_devs[REC_FAILED_NUM][40];
> +	int last_failed_errno;
> +	int errno[REC_FAILED_NUM];
> +	int last_failed_step;
> +	u64 last_hw_sleep;
> +	u64 total_hw_sleep;
> +	u64 max_hw_sleep;
> +	enum suspend_stat_step failed_steps[REC_FAILED_NUM];
> +};
> +
> +static struct suspend_stats suspend_stats;
> +
> +void dpm_save_failed_dev(const char *name)
> +{
> +	strscpy(suspend_stats.failed_devs[suspend_stats.last_failed_dev],
> +		name, sizeof(suspend_stats.failed_devs[0]));
> +	suspend_stats.last_failed_dev++;
> +	suspend_stats.last_failed_dev %= REC_FAILED_NUM;
> +}
> +
> +void dpm_save_failed_step(enum suspend_stat_step step)
> +{
> +	suspend_stats.step_failures[step]++;
> +	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
> +	suspend_stats.last_failed_step++;
> +	suspend_stats.last_failed_step %= REC_FAILED_NUM;
> +}
> +
> +void dpm_save_errno(int err)
> +{
> +	if (!err) {
> +		suspend_stats.step_failures[SUSPEND_NONE]++;
> +		return;
> +	}
> +
> +	suspend_stats.fail++;
> +
> +	suspend_stats.errno[suspend_stats.last_failed_errno] = err;
> +	suspend_stats.last_failed_errno++;
> +	suspend_stats.last_failed_errno %= REC_FAILED_NUM;
> +}
> +
> +void pm_report_hw_sleep_time(u64 t)
> +{
> +	suspend_stats.last_hw_sleep = t;
> +	suspend_stats.total_hw_sleep += t;
> +}
> +EXPORT_SYMBOL_GPL(pm_report_hw_sleep_time);
> +
> +void pm_report_max_hw_sleep(u64 t)
> +{
> +	suspend_stats.max_hw_sleep = t;
> +}
> +EXPORT_SYMBOL_GPL(pm_report_max_hw_sleep);
> +
>  static const char * const suspend_step_names[] = {
>  	[SUSPEND_NONE] = "",
>  	[SUSPEND_FREEZE] = "freeze",
> Index: linux-pm/kernel/power/power.h
> ===================================================================
> --- linux-pm.orig/kernel/power/power.h
> +++ linux-pm/kernel/power/power.h
> @@ -327,3 +327,5 @@ static inline void pm_sleep_enable_secon
>  	suspend_enable_secondary_cpus();
>  	cpuidle_resume();
>  }
> +
> +void dpm_save_errno(int err);
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -616,12 +616,7 @@ int pm_suspend(suspend_state_t state)
>  
>  	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
>  	error = enter_state(state);
> -	if (error) {
> -		suspend_stats.fail++;
> -		dpm_save_failed_errno(error);
> -	} else {
> -		suspend_stats.step_failures[SUSPEND_NONE]++;
> -	}
> +	dpm_save_errno(error);
>  	pr_info("suspend exit\n");
>  	return error;
>  }
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -60,7 +60,6 @@ static LIST_HEAD(dpm_suspended_list);
>  static LIST_HEAD(dpm_late_early_list);
>  static LIST_HEAD(dpm_noirq_list);
>  
> -struct suspend_stats suspend_stats;
>  static DEFINE_MUTEX(dpm_list_mtx);
>  static pm_message_t pm_transition;
>  
> 
> 
> 
> 

