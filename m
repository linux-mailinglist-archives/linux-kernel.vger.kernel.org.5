Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76F080B36C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 10:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjLIJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLIJVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:21:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D110EF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 01:21:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE71C433C9;
        Sat,  9 Dec 2023 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702113675;
        bh=GHtn58eD2jpCO2AzqaP68FDeBAK7xcIaZwcHN9lMI74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBPHABb2Pc1rU3GNdRWKglpuqnztsDfUljGR2L6aV8wc7ayomxxuYWCv5zkDnOnqn
         Ie+xGib9iARFyAbM25wuu4OJ4rddJLFlqBbPKXJTvGzXQL2tg2EGKAM5LsJFTYiuae
         VTHxSYf9RLoPMV4HHGFGn7sX4VwSiRVlKfRmJOS4=
Date:   Sat, 9 Dec 2023 10:21:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vimal Kumar <vimal.kumar32@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chinmoyghosh2001@gmail.com, badolevishal1116@gmail.com,
        mintupatel89@gmail.com
Subject: Re: [PATCH] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <2023120907-unlucky-playmaker-e27e@gregkh>
References: <20231209081056.1497-1-vimal.kumar32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209081056.1497-1-vimal.kumar32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 01:40:54PM +0530, Vimal Kumar wrote:
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
> [  519.486939] Abort: ws or subsystem uart_suspend_port aborted suspend
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
>  drivers/base/power/wakeup.c | 75 ++++++++++++++++++++++++++++++++++++-
>  include/linux/suspend.h     |  2 +
>  kernel/power/suspend.c      |  1 +
>  3 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index a917219feea6..f640034cab6d 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -73,6 +73,13 @@ static struct wakeup_source deleted_ws = {
>  
>  static DEFINE_IDA(wakeup_ida);
>  
> +struct pm_abort_suspend_source {
> +	struct list_head list;     //linux kernel list implementation

Nit, we know this is a list implementation, no need to comment that.

Also did you run checkpatch on this?  You need a ' ' after "//" to be
correct.

> +	char *source_triggering_abort_suspend;
> +};
> +
> +LIST_HEAD(pm_abort_suspend_list);

No blank line needed, and also, shouldn't this be static?

> +
>  /**
>   * wakeup_source_create - Create a struct wakeup_source object.
>   * @name: Name of the new wakeup source.
> @@ -575,6 +582,53 @@ static void wakeup_source_activate(struct wakeup_source *ws)
>  	trace_wakeup_source_activate(ws->name, cec);
>  }
>  
> +/**
> + * clear_abort_suspend_list: To clear the list containing sources which
> + * aborted suspend transitions.
> + * Functionality: The list will be cleared every time system PM exits as we
> + * can find sources which aborted suspend in the current suspend transisions.

This isn't the correct way to write kernel doc formats, please see the
documentation for how to do it.

> + */
> +void clear_abort_suspend_list(void)
> +{
> +	struct pm_abort_suspend_source *info, *tmp;
> +
> +	if (!list_empty(&pm_abort_suspend_list))

Why check this, doesn't the list loop work properly here?

> +		list_for_each_entry_safe(info, tmp, &pm_abort_suspend_list, list) {
> +			list_del(&info->list);
> +			kfree(info);
> +		}

No locking at all for this list?

> +}
> +EXPORT_SYMBOL_GPL(clear_abort_suspend_list);

Global functions should be "subsystem_action", not "action_something"
like you did here.  Otherwise this gets really messy very quickly.

> +
> +/**
> + * pm_add_abort_suspend_source: add sources who aborted system suspend transitions.
> + * @func_name: Name of the WS or subsystem which needs to added in the list
> + */
> +void pm_add_abort_suspend_source(const char *source_name)
> +{
> +	struct pm_abort_suspend_source *info = NULL;
> +
> +	info = kmalloc(sizeof(struct pm_abort_suspend_source), GFP_KERNEL);
> +	if (unlikely(!info)) {

Only ever use unlikely/likely if you have documented proof that the code
is faster (i.e. you can measure it.)  For normal calls like this, the
compiler and the processor knows better than you, so no need to do
anything.

> +		pr_err("Failed to alloc memory for pm_abort_suspend_source info\n");
> +		return;
> +	}
> +
> +	/* Initialize the list within the struct if it's not already initialized */
> +	if (list_empty(&info->list))
> +		INIT_LIST_HEAD(&info->list);
> +
> +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
> +	if (unlikely(!info->source_triggering_abort_suspend)) {

Again, don't use likely/unlikely

> +		pr_err("Failed to get abort_suspend source_name\n");
> +		kfree(info);
> +		return;
> +	}
> +
> +	list_add_tail(&info->list, &pm_abort_suspend_list);
> +}
> +EXPORT_SYMBOL_GPL(pm_add_abort_suspend_source);
> +
>  /**
>   * wakeup_source_report_event - Report wakeup event using the given source.
>   * @ws: Wakeup source to report the event for.
> @@ -590,8 +644,11 @@ static void wakeup_source_report_event(struct wakeup_source *ws, bool hard)
>  	if (!ws->active)
>  		wakeup_source_activate(ws);
>  
> -	if (hard)
> +	if (hard) {
> +		if (pm_suspend_target_state != PM_SUSPEND_ON)
> +			pm_add_abort_suspend_source(ws->name);
>  		pm_system_wakeup();
> +	}
>  }
>  
>  /**
> @@ -893,12 +950,28 @@ bool pm_wakeup_pending(void)
>  		pm_print_active_wakeup_sources();
>  	}
>  
> +	if (atomic_read(&pm_abort_suspend) > 0) {
> +		if (!list_empty(&pm_abort_suspend_list))
> +			list_for_each_entry(info, &pm_abort_suspend_list, list) {
> +				log_suspend_abort_reason("ws or subsystem %s aborted suspend\n",

What is "ws"?

And again, no locking is just not going to work.

But step back, are you _sure_ you really need this information?  Who is
going to use it?  Where are they going to use it?  And when are they
going to use it?

thanks,

greg k-h
