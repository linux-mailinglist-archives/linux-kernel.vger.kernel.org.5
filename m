Return-Path: <linux-kernel+bounces-38096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7383BAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087FBB227BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136312E43;
	Thu, 25 Jan 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRvs+oHA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129E12B9B;
	Thu, 25 Jan 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168506; cv=none; b=YOp5QU4uFC08SN3wxmOoMW3Kr7rG2rYEy3xsFEKWFl4Zo9qVLdCNt35p+jjJm+UdlMJIPcLqsJMhIQ7/bDN+6L2Gwmm5BK5WLchZwUhHETgVDWvK6t8o3Sk3pnpz4kYAMafU5/Q/MalZB0c3hjMGotefrHZltXJS7L1iyOp7CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168506; c=relaxed/simple;
	bh=twm95oVJajxgTVAEIQSwnlagcCC7/JijghHUC6bblzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhK2Gp8PefxulYhjjB12a6x8DU9V0WX74AhGIz7x1COE2EDGTvjJ+U2psT2sTxQaO88y8JhFes/rxE5gQvwabP5cAmg0fU0atE2+CiJiiEE+EU5w2mrq2qk5C9CweRLyEal3SdOys1OILuZh/k5qXXU0oleBYc3q72iLlujY8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRvs+oHA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168505; x=1737704505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=twm95oVJajxgTVAEIQSwnlagcCC7/JijghHUC6bblzw=;
  b=FRvs+oHAnLYr9ipLgDWIrNV+aR2z15gJoe6FUZR36Q5jmaZVSzKoJfry
   4FRMPgpC6mSgrxXdJUY4qyz69DyTev5qA3wMcW6FrRcA7rV7tFmNzEhDS
   bZf//U1c0ntM4zlgnEenM6VnW2Pz/JrkGoAF9cRqDwYjhfScpb594ZK18
   9PDmZrW+bAhDnJeqWQ8P5gIVIOeh3uRtjBO1SY/0M/SROEaljyYCCzoVg
   ZlU23Bw/oLdXnqEOze08ZHILImveYHJzMdRChYoeqkku8a4qNLauD7Bxu
   cAe+83LtRcAMYUk/xqBaHFi8+mcopPjh28bWUp34Duv6+PhnqZRofJDFM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15618916"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15618916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="736236400"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736236400"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:41:42 -0800
Date: Thu, 25 Jan 2024 08:41:39 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 03/12] PM: sleep: stats: Use array of suspend step
 names
Message-ID: <ZbIQs2R0ybg/54Zy@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <2183940.irdbgypaU6@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2183940.irdbgypaU6@kreacher>

On Mon, Jan 22, 2024 at 12:25:45PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace suspend_step_name() in the suspend statistics code with an array
> of suspend step names which has fewer lines of code and less overhead.
> 
> While at it, remove two unnecessary line breaks in suspend_stats_show()
> for a more consistent code layout.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  include/linux/suspend.h |    3 ++-
>  kernel/power/main.c     |   48 +++++++++++++++++-------------------------------
>  2 files changed, 19 insertions(+), 32 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -41,7 +41,8 @@ typedef int __bitwise suspend_state_t;
>  #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
>  
>  enum suspend_stat_step {
> -	SUSPEND_FREEZE = 1,
> +	SUSPEND_NONE = 0,
> +	SUSPEND_FREEZE,
>  	SUSPEND_PREPARE,
>  	SUSPEND_SUSPEND,
>  	SUSPEND_SUSPEND_LATE,
> Index: linux-pm/kernel/power/main.c
> ===================================================================
> --- linux-pm.orig/kernel/power/main.c
> +++ linux-pm/kernel/power/main.c
> @@ -319,25 +319,17 @@ static ssize_t pm_test_store(struct kobj
>  power_attr(pm_test);
>  #endif /* CONFIG_PM_SLEEP_DEBUG */
>  
> -static char *suspend_step_name(enum suspend_stat_step step)
> -{
> -	switch (step) {
> -	case SUSPEND_FREEZE:
> -		return "freeze";
> -	case SUSPEND_PREPARE:
> -		return "prepare";
> -	case SUSPEND_SUSPEND:
> -		return "suspend";
> -	case SUSPEND_SUSPEND_NOIRQ:
> -		return "suspend_noirq";
> -	case SUSPEND_RESUME_NOIRQ:
> -		return "resume_noirq";
> -	case SUSPEND_RESUME:
> -		return "resume";
> -	default:
> -		return "";
> -	}
> -}
> +static const char * const suspend_step_names[] = {
> +	[SUSPEND_NONE] = "",
> +	[SUSPEND_FREEZE] = "freeze",
> +	[SUSPEND_PREPARE] = "prepare",
> +	[SUSPEND_SUSPEND] = "suspend",
> +	[SUSPEND_SUSPEND_LATE] = "suspend_late",
> +	[SUSPEND_SUSPEND_NOIRQ] = "suspend_noirq",
> +	[SUSPEND_RESUME_NOIRQ] = "resume_noirq",
> +	[SUSPEND_RESUME_EARLY] = "resume_early",
> +	[SUSPEND_RESUME] = "resume",
> +};
>  
>  #define suspend_attr(_name, format_str)				\
>  static ssize_t _name##_show(struct kobject *kobj,		\
> @@ -392,16 +384,14 @@ static struct kobj_attribute last_failed
>  static ssize_t last_failed_step_show(struct kobject *kobj,
>  		struct kobj_attribute *attr, char *buf)
>  {
> -	int index;
>  	enum suspend_stat_step step;
> -	char *last_failed_step = NULL;
> +	int index;
>  
>  	index = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
>  	index %= REC_FAILED_NUM;
>  	step = suspend_stats.failed_steps[index];
> -	last_failed_step = suspend_step_name(step);
>  
> -	return sprintf(buf, "%s\n", last_failed_step);
> +	return sprintf(buf, "%s\n", suspend_step_names[step]);
>  }
>  static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
>  
> @@ -477,26 +467,22 @@ static int suspend_stats_show(struct seq
>  	for (i = 1; i < REC_FAILED_NUM; i++) {
>  		index = last_dev + REC_FAILED_NUM - i;
>  		index %= REC_FAILED_NUM;
> -		seq_printf(s, "\t\t\t%-s\n",
> -			suspend_stats.failed_devs[index]);
> +		seq_printf(s, "\t\t\t%-s\n", suspend_stats.failed_devs[index]);
>  	}
>  	seq_printf(s,	"  last_failed_errno:\t%-d\n",
>  			suspend_stats.errno[last_errno]);
>  	for (i = 1; i < REC_FAILED_NUM; i++) {
>  		index = last_errno + REC_FAILED_NUM - i;
>  		index %= REC_FAILED_NUM;
> -		seq_printf(s, "\t\t\t%-d\n",
> -			suspend_stats.errno[index]);
> +		seq_printf(s, "\t\t\t%-d\n", suspend_stats.errno[index]);
>  	}
>  	seq_printf(s,	"  last_failed_step:\t%-s\n",
> -			suspend_step_name(
> -				suspend_stats.failed_steps[last_step]));
> +		   suspend_step_names[suspend_stats.failed_steps[last_step]]);
>  	for (i = 1; i < REC_FAILED_NUM; i++) {
>  		index = last_step + REC_FAILED_NUM - i;
>  		index %= REC_FAILED_NUM;
>  		seq_printf(s, "\t\t\t%-s\n",
> -			suspend_step_name(
> -				suspend_stats.failed_steps[index]));
> +			   suspend_step_names[suspend_stats.failed_steps[index]]);
>  	}
>  
>  	return 0;
> 
> 
> 

