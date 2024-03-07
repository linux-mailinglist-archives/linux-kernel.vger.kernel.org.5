Return-Path: <linux-kernel+bounces-96319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C490F875A2C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A3228250E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9228D13EFE6;
	Thu,  7 Mar 2024 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nnFBp+2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8A13E7D5;
	Thu,  7 Mar 2024 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850045; cv=none; b=E9bHEAXKD1KPEwUd1AiyFUqCWUdiZxCzvQIC6K279L7fImvUokBgD7hKDETywQUApM5WkXSIs8lWx9FuWb96b0DlwPnoeuCUfVavyZjs8yjXHKXuNNIc/xA9pJLu1dQlvA56MMXhHkaIk0/54yBFIYX2fiMpcjN2lwosbjjF4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850045; c=relaxed/simple;
	bh=euN6uPY1w19nOJ53WO0te5FrAb+DgOrEI+3EeaafPW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbxzXc+swwabxXZYs9zKiFehRfG5Zd8G+95DVVim94arFqAIu4A7LyZ9JTyu+d1fqfcw+gnWU5gdms7/4IBYxKJKpzsKrKsPRRrfdzlSGWytocmefRX2i82lAYEiNCM14xITPzQ5VDeeXhebKrtgmJBgTN3hK2E5NN6XvKO9Lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nnFBp+2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED16C433C7;
	Thu,  7 Mar 2024 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709850045;
	bh=euN6uPY1w19nOJ53WO0te5FrAb+DgOrEI+3EeaafPW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnFBp+2Fxc9tr/I7DoGuks82dlPkN/TrT7G4vg81YqEwO02qFNe3atQbgI9erKW41
	 244heT/71/ZcPOFxDhXShKRVQLBERrxOmg+WsShgWb7UFfATp80ePtqjmsixKXhajG
	 eLfa5uYXDDAeKTIyh5SWBxamrTXKSJGpfgm8MIuY=
Date: Thu, 7 Mar 2024 22:20:42 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vimal Kumar <vimal.kumar32@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
	badolevishal1116@gmail.com, mintupatel89@gmail.com
Subject: Re: [PATCH v5] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2024030729-easiest-brewing-2b31@gregkh>
References: <20240210055243.8508-1-vimal.kumar32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240210055243.8508-1-vimal.kumar32@gmail.com>

On Sat, Feb 10, 2024 at 11:22:41AM +0530, Vimal Kumar wrote:
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
> Changes in v5:
> - Removed CONFIG_PM_DEBUG
> - Moved conditional directives to .h file
> - Used spin_lock instead of raw_spin_lock
> ---
>  drivers/base/power/power.h  | 14 ++++++
>  drivers/base/power/wakeup.c | 86 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index 922ed457db19..ace190358eb3 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -168,3 +168,17 @@ static inline void device_pm_init(struct device *dev)
> 	device_pm_sleep_init(dev);
> 	pm_runtime_init(dev);
>  }
> +
> +#ifdef CONFIG_DEBUG_INFO
> +
> +static inline char *pm_abort_suspend_source_name(void)
> +{
> +	char *source_name = kasprintf(GFP_ATOMIC, "%pS", __builtin_return_address(0));

This is a cool hack, but no error checking?

> +	return source_name;
> +}
> +
> +#else
> +
> +	static inline char *pm_abort_suspend_source_name(void) { return NULL; }

Odd indentation, why?

> +
> +#endif /* CONFIG_DEBUG_INFO */
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index a917219feea6..aae9a5329bcb 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -73,6 +73,14 @@ static struct wakeup_source deleted_ws = {
> 
>  static DEFINE_IDA(wakeup_ida);
> 
> +static DEFINE_SPINLOCK(pm_abort_suspend_list_lock);
> +
> +struct pm_abort_suspend_source {
> +	struct list_head list;
> +	char *source_triggering_abort_suspend;
> +};
> +static LIST_HEAD(pm_abort_suspend_list);
> +
>  /**
>   * wakeup_source_create - Create a struct wakeup_source object.
>   * @name: Name of the new wakeup source.
> @@ -575,6 +583,52 @@ static void wakeup_source_activate(struct wakeup_source *ws)
> 	trace_wakeup_source_activate(ws->name, cec);
>  }
> 
> +/**
> + * pm_abort_suspend_list_clear - Clear pm_abort_suspend_list.
> + *
> + * The pm_abort_suspend_list will be cleared when system PM exits.
> + */
> +static void pm_abort_suspend_list_clear(void)
> +{
> +	unsigned long flags;
> +	struct pm_abort_suspend_source *info, *tmp;
> +
> +	spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
> +	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
> +		list_del(&info->list);
> +		kfree(info);
> +	}
> +	spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
> +}
> +
> +/**
> + * pm_abort_suspend_source_add - Update pm_abort_suspend_list
> + * @source_name: Wakeup_source or function aborting suspend transitions.
> + *
> + * Add the source name responsible for updating the abort_suspend flag in the
> + * pm_abort_suspend_list.
> + */
> +static void pm_abort_suspend_source_add(const char *source_name)
> +{
> +	unsigned long flags;
> +	struct pm_abort_suspend_source *info;
> +
> +	info = kmalloc(sizeof(*info), GFP_ATOMIC);
> +	if (!info)
> +		return;
> +
> +	INIT_LIST_HEAD(&info->list);
> +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_ATOMIC);
> +	if (!info->source_triggering_abort_suspend) {
> +		kfree(info);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
> +	list_add_tail(&info->list, &pm_abort_suspend_list);
> +	spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
> +}
> +
>  /**
>   * wakeup_source_report_event - Report wakeup event using the given source.
>   * @ws: Wakeup source to report the event for.
> @@ -590,8 +644,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
> 	if (!ws->active)
> 		wakeup_source_activate(ws);
> 
> -	if (hard)
> +	if (hard) {
> +		if (pm_suspend_target_state != PM_SUSPEND_ON)

Why is this state special?

> +			pm_abort_suspend_source_add(ws->name);
> 		pm_system_wakeup();
> +	}
>  }
> 
>  /**
> @@ -893,12 +950,39 @@ bool pm_wakeup_pending(void)
> 		pm_print_active_wakeup_sources();
> 	}
> 
> +	if (atomic_read(&pm_abort_suspend) > 0) {
> +		struct pm_abort_suspend_source *info;
> +
> +		spin_lock_irqsave(&pm_abort_suspend_list_lock, flags);
> +		list_for_each_entry(info, &pm_abort_suspend_list, list) {
> +			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
> +					info->source_triggering_abort_suspend);

You should put the %s in quotes or something to make it obvious this is
a function name.

> +		}
> +		spin_unlock_irqrestore(&pm_abort_suspend_list_lock, flags);
> +		pm_abort_suspend_list_clear();

You just raced between printing the list and deleting it, why drop a
lock just to grab it again?  Why does this have to be a separate
function at all?

> +	}
> +
> 	return ret || atomic_read(&pm_abort_suspend) > 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_wakeup_pending);
> 
>  void pm_system_wakeup(void)
>  {
> +
> +	if (pm_suspend_target_state != PM_SUSPEND_ON) {
> +		char *source_name = pm_abort_suspend_source_name();
> +
> +		if (!source_name) {
> +			pm_pr_dbg("Some wakeup source or subsystem aborted suspend\n");

So if the config option is disabled, you will just get this message?
That's not going to be very helpful.  Or are you going to get it again
as you already get that today?

And why are you relying on CONFIG_DEBUG_INFO, where is that documented?

> +			goto exit;
> +		}
> +
> +		if (strcmp(source_name, "pm_wakeup_ws_event"))

You are relying on a function name here, that is not going to go well
over time.  What happens if they get out of sync?  What will keep that
in sync?  What documents this?  How is this going to be maintained
properly over time?

What is going to use this new kernel log message?

thanks,

greg k-h

