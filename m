Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E124C7F88F0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYHsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:47:57 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1DA103;
        Fri, 24 Nov 2023 23:48:04 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 6670A60BB6;
        Sat, 25 Nov 2023 07:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1700898483;
        bh=o4lIe4eNp1y/0VGduOx/UtfXBQ2vvGebZj9NwAsAxgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMngcpQfkXdPLMnolftdZDmK9QthJ3GsNPQp4WLBnjgFsSBpvt7MQq/FIF+vDLhsT
         2jCdrNjsf75rJvGELZpKCHXKA+t09W8rAiImry0jS5q2UYT/N64m1gagimsQ8oQvMV
         SYnIaS7UKmzTvVWgWNEnGHceu3qBYY+1WhLglg5axpAiBIXVFZm+ask+7AD3TqUopy
         lL/wI+riqnRVTqpwfb9i4TcfA7iS4Et1o18xjRVmovO+YfkppVRTyHmcenGyV0FGf9
         e6uk30VwrOs45UiLfCO6Lq0cNLQWIudBRWHbcN/JsXStBkRCKkjsWECPPeE6dzrsfU
         coAwMwlPXDyHA==
Date:   Sat, 25 Nov 2023 09:47:38 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, john.ogness@linutronix.de,
        tglx@linutronix.de, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        ke.wang@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH] serial: core: Use pm_runtime_get_sync() in
 uart_start()
Message-ID: <20231125074738.GJ5169@atomide.com>
References: <20231124122258.1050-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124122258.1050-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Xuewen Yan <xuewen.yan@unisoc.com> [231124 12:25]:
> The commit 84a9582fd203("serial: core: Start managing serial controllers to enable runtime PM")
> use the pm_runtime_get() after uart_port_lock() which would close the irq and disable preement.
> At this time,  pm_runtime_get may cause the following two problems:
> 
> (1) deadlock in try_to_wake_up:
> 
> uart_write()
> uart_port_lock() <<< get lock
> __uart_start
> __pm_runtime_resume
> rpm_resume
> queue_work_on
> try_to_wake_up
> _printk
> uart_console_write
> ...
> uart_port_lock() <<< wait forever
> 
> (2) scheduling while atomic:
> uart_write()
> uart_port_lock() <<< get lock
> __uart_start
> __pm_runtime_resume
> rpm_resume
> chedule() << sleep

Are these spinlock vs raw spinlock nesting warnings from lockdep? If so
can you please post the full warnings somewhere? Or if some extra steps
are needed to reproduce please describe that too.

Chances are very high that your serial port is already runtime active at
this point unless you manually idle it so that's why I'm wondering as
all that likely is happening here is a check on the runtime PM usage count.

> So let us use pm_runtime_get_sync() to prevent these.

We need to fix this some other way as we can't use pm_runtime_get_sync()
here. The sync call variants require setting pm_runtime_irq_safe() for the
device. And this is what we really want to avoid as it takes a permanent
usage count on the parent device.

What we want to do here is to get runtime PM to wake-up the device if idle
and try tx again after runtime PM resume as needed.

Just guessing at this point.. To me it sounds like the fix might be to
use a raw spinlock for uart_port_lock() and uart_port_unlock()?

Regards,

Tony


> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/tty/serial/serial_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f1348a509552..902f7ed35f4d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -145,7 +145,7 @@ static void __uart_start(struct uart_state *state)
>  	port_dev = port->port_dev;
>  
>  	/* Increment the runtime PM usage count for the active check below */
> -	err = pm_runtime_get(&port_dev->dev);
> +	err = pm_runtime_get_sync(&port_dev->dev);
>  	if (err < 0 && err != -EINPROGRESS) {
>  		pm_runtime_put_noidle(&port_dev->dev);
>  		return;
> @@ -159,7 +159,7 @@ static void __uart_start(struct uart_state *state)
>  	if (!pm_runtime_enabled(port->dev) || pm_runtime_active(port->dev))
>  		port->ops->start_tx(port);
>  	pm_runtime_mark_last_busy(&port_dev->dev);
> -	pm_runtime_put_autosuspend(&port_dev->dev);
> +	pm_runtime_put_sync_autosuspend(&port_dev->dev);
>  }
>  
>  static void uart_start(struct tty_struct *tty)
> -- 
> 2.25.1
> 
