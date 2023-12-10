Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CB80BA2F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 11:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjLJKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 05:35:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335AE10B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 02:35:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD13BC433C7;
        Sun, 10 Dec 2023 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702204505;
        bh=kWjoRMAFe6f0i1po6kYqlLe9wp8VQklHs8gl4ogzYKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPZ/FFgahWdiTEo5htUEqFWGr1LrNeTLuV6uXOZ4g3wMBbekBwxI4pXlAROerwmum
         DXYlBNgFKTqLIaekdF7ktBlBMCrOBtPFOlSV5Nilf56Ce4ahgC70CtmF1WhHe0uRHs
         4RP9/ihAuxXIsXMJMGYx6MhvO6VPBpLrIZnJvGEE=
Date:   Sun, 10 Dec 2023 11:35:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vimal Kumar <vimal.kumar32@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com
Subject: Re: [PATCH v2] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2023121037-unroasted-gradation-a47f@gregkh>
References: <20231210100303.491-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210100303.491-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 03:33:01PM +0530, Vimal Kumar wrote:
> +#define MAX_SUSPEND_ABORT_LEN 256

What does this number mean?

> +static DEFINE_RAW_SPINLOCK(abort_suspend_lock);

Why is this a "raw" spinlock?  What requires this?

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
> @@ -575,6 +584,56 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  	trace_wakeup_source_activate(ws->name, cec);
>  }
>  
> +/**
> + * abort_suspend_list_clear - Clear pm_abort_suspend_list.
> + *
> + * The pm_abort_suspend_list will be cleared when system PM exits.
> + */
> +void abort_suspend_list_clear(void)
> +{
> +	struct pm_abort_suspend_source *info, *tmp;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> +	list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
> +		list_del(&info->list);
> +		kfree(info);
> +	}
> +	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(abort_suspend_list_clear);
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
> +	struct pm_abort_suspend_source *info;
> +	unsigned long flags;
> +
> +	info = kmalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return;
> +
> +	/* Initialize the list within the struct if it's not already initialized */
> +	if (list_empty(&info->list))
> +		INIT_LIST_HEAD(&info->list);

How can this list head not be initialized already?

> +
> +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
> +	if (!info->source_triggering_abort_suspend) {
> +		kfree(info);
> +		return;
> +	}
> +
> +	raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> +	list_add_tail(&info->list, &pm_abort_suspend_list);
> +	raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> +}
> +
>  /**
>   * wakeup_source_report_event - Report wakeup event using the given source.
>   * @ws: Wakeup source to report the event for.
> @@ -590,8 +649,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
>  	if (!ws->active)
>  		wakeup_source_activate(ws);
>  
> -	if (hard)
> +	if (hard) {
> +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> +			pm_abort_suspend_source_add(ws->name);
>  		pm_system_wakeup();
> +	}
>  }
>  
>  /**
> @@ -877,6 +939,7 @@ bool pm_wakeup_pending(void)
>  {
>  	unsigned long flags;
>  	bool ret = false;
> +	struct pm_abort_suspend_source *info;
>  
>  	raw_spin_lock_irqsave(&events_lock, flags);
>  	if (events_check_enabled) {
> @@ -893,12 +956,29 @@ bool pm_wakeup_pending(void)
>  		pm_print_active_wakeup_sources();
>  	}
>  
> +	if (atomic_read(&pm_abort_suspend) > 0) {
> +		raw_spin_lock_irqsave(&abort_suspend_lock, flags);
> +		list_for_each_entry(info, &pm_abort_suspend_list, list) {
> +			pm_pr_dbg("wakeup source or subsystem %s aborted suspend\n",
> +					info->source_triggering_abort_suspend);
> +		}
> +		raw_spin_unlock_irqrestore(&abort_suspend_lock, flags);
> +	}

After you print them all out, why not remove them from the list now?
Why wait until later?

> +
>  	return ret || atomic_read(&pm_abort_suspend) > 0;
>  }
>  EXPORT_SYMBOL_GPL(pm_wakeup_pending);
>  
>  void pm_system_wakeup(void)
>  {
> +	char buf[MAX_SUSPEND_ABORT_LEN];

You never actually check to ensure that you do not overflow this value,
right?  And are you _SURE_ you can put a string this big on the stack?

> +
> +	if (pm_suspend_target_state != PM_SUSPEND_ON) {
> +		sprintf(buf, "%ps", __builtin_return_address(0));
> +		if (strcmp(buf, "pm_wakeup_ws_event"))

This is _VERY_ fragile, you are relying on a specific symbol to never
change its name, which is not going to work in the long run, AND this
will not work if you don't have symbols in your kernel, right?

How was this tested?

And again, why is this even needed, who will use it?  What tools will
consume it?  Who will rely on it?

thanks,

greg k-h
