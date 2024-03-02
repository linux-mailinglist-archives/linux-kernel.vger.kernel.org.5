Return-Path: <linux-kernel+bounces-89592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6BA86F26B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E142824D2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74523AC16;
	Sat,  2 Mar 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H0WKFuZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C914010;
	Sat,  2 Mar 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709412523; cv=none; b=A9kEwNdAhzmAX789BTtOqMu1vKTRIjWMsjLxzovnHKzuHEYVH4dtmDOrXuWnj8XGyLNa9rDnQyErTuZ5LfxAy+oq7aOrfrMYHigOaplE9PE8g37oupa9PENAy1fxQNxZQsdIXwRr71d2G4EoTvbkPBLtHwblZSmt3G/Z4oSUCwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709412523; c=relaxed/simple;
	bh=KkrDPfDl9MTHCtUdGHigMdKyuR/xnsZt/Vhf4rD7NXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzR0zA33Fv56hxfPRaK2e3kLjR9SY7ECgoUO4hBZt655ZybVj9TwxNQYIsDUD/ry7u6AAcTx7FA8wgS/EOCNtdaX0YMtNzsyw/xH3sLFbWMm2uZ+DZaW2kz2iLsB+m6uAiFwPIsa0hFQi9tgH0LN68HE3x+8hmGbCaeYRViD3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H0WKFuZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCFAC433F1;
	Sat,  2 Mar 2024 20:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709412522;
	bh=KkrDPfDl9MTHCtUdGHigMdKyuR/xnsZt/Vhf4rD7NXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0WKFuZPFiFTFwjASROakBdIJ5w39aA7rfgBSeTUhklxqZP08rOwt3ihpoOLg7X0L
	 xYsQ+GvhhGoHSCCHyy9AGEjqKleVe7dUzC4hne+rJfDhO+IdeK7LEMA/GiCVWl604X
	 TouQ8TlOJ9Fmf1lqvXb5Hxx7BuiP4+9UDSJySd08=
Date: Sat, 2 Mar 2024 21:48:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: Lock console when calling into driver before
 registration
Message-ID: <2024030214-buffing-obtuse-8dc8@gregkh>
References: <20240226192329.3281301-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226192329.3281301-1-pcc@google.com>

On Mon, Feb 26, 2024 at 11:23:26AM -0800, Peter Collingbourne wrote:
> During the handoff from earlycon to the real console driver, we have
> two separate drivers operating on the same device concurrently. In the
> case of the 8250 driver these concurrent accesses cause problems due
> to the driver's use of banked registers, controlled by LCR.DLAB. It is
> possible for the setup(), config_port(), pm() and set_mctrl() callbacks
> to set DLAB, which can cause the earlycon code that intends to access
> TX to instead access DLL, leading to missed output and corruption on
> the serial line due to unintended modifications to the baud rate.
> 
> In particular, for setup() we have:
> 
> univ8250_console_setup()
> -> serial8250_console_setup()
> -> uart_set_options()
> -> serial8250_set_termios()
> -> serial8250_do_set_termios()
> -> serial8250_do_set_divisor()
> 
> For config_port() we have:
> 
> serial8250_config_port()
> -> autoconfig()
> 
> For pm() we have:
> 
> serial8250_pm()
> -> serial8250_do_pm()
> -> serial8250_set_sleep()
> 
> For set_mctrl() we have (for some devices):
> 
> serial8250_set_mctrl()
> -> omap8250_set_mctrl()
> -> __omap8250_set_mctrl()
> 
> To avoid such problems, let's make it so that the console is locked
> during pre-registration calls to these callbacks, which will prevent
> the earlycon driver from running concurrently.
> 
> Remove the partial solution to this problem in the 8250 driver
> that locked the console only during autoconfig_irq(), as this would
> result in a deadlock with the new approach. The console continues
> to be locked during autoconfig_irq() because it can only be called
> through uart_configure_port().
> 
> Although this patch introduces more locking than strictly necessary
> (and in particular it also locks during the call to rs485_config()
> which is not affected by this issue as far as I can tell), it follows
> the principle that it is the responsibility of the generic console
> code to manage the earlycon handoff by ensuring that earlycon and real
> console driver code cannot run concurrently, and not the individual
> drivers.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Link: https://linux-review.googlesource.com/id/I7cf8124dcebf8618e6b2ee543fa5b25532de55d8

Why is a link to a gerrit review with no context other than this same
commit needed here?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/8250/8250_port.c |  6 ------
>  drivers/tty/serial/serial_core.c    | 12 ++++++++++++
>  kernel/printk/printk.c              | 21 ++++++++++++++++++---
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 8ca061d3bbb9..1d65055dde27 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1329,9 +1329,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  		inb_p(ICP);
>  	}
>  
> -	if (uart_console(port))
> -		console_lock();
> -
>  	/* forget possible initially masked and pending IRQ */
>  	probe_irq_off(probe_irq_on());
>  	save_mcr = serial8250_in_MCR(up);
> @@ -1371,9 +1368,6 @@ static void autoconfig_irq(struct uart_8250_port *up)
>  	if (port->flags & UPF_FOURPORT)
>  		outb_p(save_ICP, ICP);
>  
> -	if (uart_console(port))
> -		console_unlock();
> -
>  	port->irq = (irq > 0) ? irq : 0;
>  }
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index d6a58a9e072a..ff85ebd3a007 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2608,7 +2608,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  			port->type = PORT_UNKNOWN;
>  			flags |= UART_CONFIG_TYPE;
>  		}
> +		/* Synchronize with possible boot console. */
> +		if (uart_console(port))
> +			console_lock();
>  		port->ops->config_port(port, flags);
> +		if (uart_console(port))
> +			console_unlock();
>  	}
>  
>  	if (port->type != PORT_UNKNOWN) {
> @@ -2616,6 +2621,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  
>  		uart_report_port(drv, port);
>  
> +		/* Synchronize with possible boot console. */
> +		if (uart_console(port))
> +			console_lock();
> +
>  		/* Power up port for set_mctrl() */
>  		uart_change_pm(state, UART_PM_STATE_ON);
>  
> @@ -2632,6 +2641,9 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  
>  		uart_rs485_config(port);
>  
> +		if (uart_console(port))
> +			console_unlock();
> +
>  		/*
>  		 * If this driver supports console, and it hasn't been
>  		 * successfully registered yet, try to re-register it.
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index f2444b581e16..f51e4e5a869d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3263,6 +3263,21 @@ static int __init keep_bootcon_setup(char *str)
>  
>  early_param("keep_bootcon", keep_bootcon_setup);
>  
> +static int console_call_setup(struct console *newcon, char *options)
> +{
> +	int err;
> +
> +	if (!newcon->setup)
> +		return 0;
> +
> +	/* Synchronize with possible boot console. */
> +	console_lock();
> +	err = newcon->setup(newcon, options);
> +	console_unlock();
> +
> +	return err;
> +}
> +
>  /*
>   * This is called by register_console() to try to match
>   * the newly registered console with any of the ones selected
> @@ -3298,8 +3313,8 @@ static int try_enable_preferred_console(struct console *newcon,
>  			if (_braille_register_console(newcon, c))
>  				return 0;
>  
> -			if (newcon->setup &&
> -			    (err = newcon->setup(newcon, c->options)) != 0)
> +			err = console_call_setup(newcon, c->options);
> +			if (err != 0)

Didn't checkpatch complain about this?  It should be:
			if (err)
right?


>  				return err;
>  		}
>  		newcon->flags |= CON_ENABLED;
> @@ -3325,7 +3340,7 @@ static void try_enable_default_console(struct console *newcon)
>  	if (newcon->index < 0)
>  		newcon->index = 0;
>  
> -	if (newcon->setup && newcon->setup(newcon, NULL) != 0)
> +	if (console_call_setup(newcon, NULL) != 0)
>  		return;

No way to pass an error back here?

thanks,

greg k-h

