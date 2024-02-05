Return-Path: <linux-kernel+bounces-53820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8799C84A6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A328A6F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850D5C8F0;
	Mon,  5 Feb 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sTjdErzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD665C5F4;
	Mon,  5 Feb 2024 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161601; cv=none; b=FMAcqSpJbrIaU2w37jZJe6BPj7iCiJrjquu48e8ezVtFAIW5dBN5BrqV0pPZ16/TO6Xv+exQWI5EMXjjJYX5jmDbb5yxo28LRNNzFH+CLpB+W12g5/PYqhO1Sik2lXI6B8/Pu0wbFAppru1cptycphIowOXYzKcMNMm7StD6dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161601; c=relaxed/simple;
	bh=RKS0Zwmm+lqDuahv6NxZpCmj50fOgiMp59F2U0j90YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDJDvGpLgV/wJ4tbSQauxYTxUAtQupVWlZc7LfZOg8lVgYBLyVkPKDpHNnvcLbYvQP5No413ZgIpXdxkfmIKR3EmZRzUUEJwAit7klmOpqQAMqK8de3qCIGrFyY87DEJNB8TdHm7w3YtXGED0bIDo7obAeaN4tSONEpCvHPSKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sTjdErzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0CBC433F1;
	Mon,  5 Feb 2024 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707161600;
	bh=RKS0Zwmm+lqDuahv6NxZpCmj50fOgiMp59F2U0j90YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTjdErzzPM4vkK1sRQumMXvJhuoQOw2mMVKfaj1GpyFnCS1p757d3nfA9inzTi4RE
	 ow5i/bqMj+urQi5swwaPJgQEmshbhGBU8IuK0dVO9y+WBCAl8rdiP8oZlMmFKGLgOm
	 YqFn50H6RTbv3soY2aA4uDLk30mlIhGzpB9LnNAk=
Date: Mon, 5 Feb 2024 19:33:17 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
	badolevishal1116@gmail.com, mintupatel89@gmail.com
Subject: Re: [PATCH v4] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2024020555-usable-hardy-345e@gregkh>
References: <20240205170747.19748-1-vimal.kumar32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205170747.19748-1-vimal.kumar32@gmail.com>

On Mon, Feb 05, 2024 at 10:37:45PM +0530, Vimal Kumar wrote:
> Sometimes kernel suspend transitions can be aborted unconditionally by
> manipulating pm_abort_suspend value using "hard" wakeup triggers or
> through "pm_system_wakeup()".
> 
> There is no way to trace the source path of module or subsystem which
> aborted the suspend transitions. This change will create a list of
> wakeup sources aborting suspend in progress through "hard" events as
> well as subsytems aborting suspend using "pm_system_wakeup()".
> 
> Example: Existing suspend failure logs:
> [  349.708359] PM: Some devices failed to suspend, or early wake event detected
> [  350.327842] PM: suspend exit
> 
> Suspend failure logs with this change:
> [  518.761835] PM: Some devices failed to suspend, or early wake event detected
> [  519.486939] PM: wakeup source or subsystem uart_suspend_port aborted suspend
> [  519.500594] PM: suspend exit
> 
> Here we can clearly identify the module triggerring abort suspend.
> 
> Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> ---
> Changes in v4:
> - Changed GFP_KERNEL flag to GFP_ATOMIC
> - Changed mutex_lock to raw_spin_lock

why raw?


> ---
>  drivers/base/power/wakeup.c | 100 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index a917219feea6..b04794557eef 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -73,6 +73,16 @@ static struct wakeup_source deleted_ws = {
> 
>  static DEFINE_IDA(wakeup_ida);
> 
> +#ifdef CONFIG_PM_DEBUG
> +static DEFINE_RAW_SPINLOCK(pm_abort_suspend_list_lock);
> +
> +struct pm_abort_suspend_source {
> +	struct list_head list;
> +	char *source_triggering_abort_suspend;
> +};
> +static LIST_HEAD(pm_abort_suspend_list);
> +#endif
> +
>  /**
>   * wakeup_source_create - Create a struct wakeup_source object.
>   * @name: Name of the new wakeup source.
> @@ -575,6 +585,54 @@ static void wakeup_source_activate(struct wakeup_source *ws)
> 	trace_wakeup_source_activate(ws->name, cec);
>  }
> 
> +#ifdef CONFIG_PM_DEBUG

Please do not add #ifdef to .c files, this makes this file even messier.

> @@ -590,8 +648,13 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
> 	if (!ws->active)
> 		wakeup_source_activate(ws);
> 
> -	if (hard)
> +	if (hard) {
> +#ifdef CONFIG_PM_DEBUG
> +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> +			pm_abort_suspend_source_add(ws->name);
> +#endif

Especially for stuff like this, if you write your .h files properly, no
#ifdef are needed.



> 		pm_system_wakeup();
> +	}
>  }
> 
>  /**
> @@ -893,12 +956,47 @@ bool pm_wakeup_pending(void)
> 		pm_print_active_wakeup_sources();
> 	}
> 
> +#ifdef CONFIG_PM_DEBUG
> +	if (atomic_read(&pm_abort_suspend) > 0) {
> +		struct pm_abort_suspend_source *info;
> +
> +		raw_spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
> +		list_for_each_entry(info, &pm_abort_suspend_list, list) {
> +			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
> +					info->source_triggering_abort_suspend);
> +		}
> +		raw_spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
> +		pm_abort_suspend_list_clear();
> +	}
> +#endif
> +
> 	return ret || atomic_read(&pm_abort_suspend) > 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> 
>  void pm_system_wakeup(void)
>  {
> +
> +#ifdef CONFIG_PM_DEBUG
> +#ifdef CONFIG_DEBUG_INFO
> +	if (pm_suspend_target_state != PM_SUSPEND_ON) {
> +		char *source_name = kasprintf(GFP_ATOMIC,
> +					"%ps",
> +					__builtin_return_address(0));
> +		if (!source_name)
> +			goto exit;
> +
> +		if (strcmp(source_name, "pm_wakeup_ws_event"))
> +			pm_abort_suspend_source_add(source_name);
> +
> +		kfree(source_name);
> +	}
> +exit:
> +#else
> +	if (pm_suspend_target_state != PM_SUSPEND_ON)
> +		pm_pr_dbg("Some wakeup source or subsystem aborted suspend\n");
> +#endif
> +#endif

Would you want to maintain this #ifdef nesting mess for the next 20
years?  Please do not do this.

thanks,

greg k-h

