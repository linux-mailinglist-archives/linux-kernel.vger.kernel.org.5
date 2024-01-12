Return-Path: <linux-kernel+bounces-24691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705282C0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B8AB23437
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736B6D1A9;
	Fri, 12 Jan 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B88b5jAL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aJ+PHM6K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C46A019;
	Fri, 12 Jan 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705066134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PpAnkyBikMPd+fkvnJS1FP8hHu1DaIJO182JY2898Q=;
	b=B88b5jALuLKzn77McNRQ8kARoRQQ1O+F5/G484snrPAXu2BwC9NiFygIlT80t57Lfb6kuB
	pB9WL9x7GFEba4aSiW8wxTUjWVc1L7kRn02efCFDMpBndpSxNaRN4xjRzo//Qvak4sSySL
	Ac9nOdY05N6loI9Zpu6zDtNXjnslPg+tN4W7D0jgZVS/gmvsAVZiKqluCq9enaCCXs3Ymd
	0Cxg2Ioc/XyXLJ73qIiEwAON4R6csC+CMhdPLWel6eWdaSMVbrBVdi2QEo1oaIwwxjirsN
	9MkkKkwZIfdsf0EnRnyKX6S+vTQ4w2fXkpQ3btUsZiPmWlu418auXh9Pdu+/Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705066134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PpAnkyBikMPd+fkvnJS1FP8hHu1DaIJO182JY2898Q=;
	b=aJ+PHM6Kk/LrQscByIkEzUBDPXW1pP/K1fg8c11IA7qfem/vbsshb0nwmgT32bitxTrDM5
	k2ezn9+xAJu7D1BQ==
To: Gui-Dong Han <2045gemini@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, tony@atomide.com,
 l.sanfilippo@kunbus.com, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 baijiaju1990@outlook.com, Gui-Dong Han <2045gemini@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix double fetch in
 uart_throttle/uart_unthrottle
In-Reply-To: <20240112121844.17580-1-2045gemini@gmail.com>
References: <20240112121844.17580-1-2045gemini@gmail.com>
Date: Fri, 12 Jan 2024 14:34:52 +0106
Message-ID: <87h6ji7ka3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-12, Gui-Dong Han <2045gemini@gmail.com> wrote:
> In uart_throttle() and uart_unthrottle():
>     if (port->status & mask) {
>         port->ops->throttle/unthrottle(port);
>         mask &= ~port->status;
>     }
>     // Code segment utilizing the mask value to determine UART behavior
>
> In uart_change_line_settings():
>     uart_port_lock_irq(uport);
>     // Code segment responsible for updating uport->status
>     uart_port_unlock_irq(uport);
>
> In the uart_throttle() and uart_unthrottle() functions, there is a double
> fetch issue due to concurrent execution with uart_change_line_settings().
> In uart_throttle() and uart_unthrottle(), the check
> if (port->status & mask) is made, followed by mask &= ~port->status,
> where the relevant bits are cleared. However, port->status may be modified
> in uart_change_line_settings(). The current implementation does not ensure
> atomicity in the access and modification of port->status and mask. This
> can result in mask being updated based on a modified port->status value,
> leading to improper UART actions.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.
>
> To resolve this double fetch, it is suggested to add a uart_port_lock pair
> in uart_throttle() and uart_unthrottle(). With this patch applied, our
> tool no longer reports the bug, with the kernel configuration allyesconfig
> for x86_64. Due to the absence of the requisite hardware, we are unable to
> conduct runtime testing of the patch. Therefore, our verification is
> solely based on code logic analysis.
>
> [1] https://sites.google.com/view/basscheck/
>
> Fixes: 391f93f2ec9f ("serial: core: Rework hw-assisted flow control support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 80085b151b34..9d905fdf2843 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -723,11 +723,13 @@ static void uart_throttle(struct tty_struct *tty)
>  		mask |= UPSTAT_AUTOXOFF;
>  	if (C_CRTSCTS(tty))
>  		mask |= UPSTAT_AUTORTS;
> -
> +
> +	uart_port_lock_irq(port);
>  	if (port->status & mask) {
>  		port->ops->throttle(port);
>  		mask &= ~port->status;
>  	}
> +	uart_port_unlock_irq(port);

You would also need to remove uart_port_lock_irq() out of all the
throttle() callbacks.

>  
>  	if (mask & UPSTAT_AUTORTS)
>  		uart_clear_mctrl(port, TIOCM_RTS);
> @@ -753,10 +755,12 @@ static void uart_unthrottle(struct tty_struct *tty)
>  	if (C_CRTSCTS(tty))
>  		mask |= UPSTAT_AUTORTS;
>  
> +	uart_port_lock_irq(port);
>  	if (port->status & mask) {
>  		port->ops->unthrottle(port);
>  		mask &= ~port->status;
>  	}
> +	uart_port_unlock_irq(port);

You would also need to remove uart_port_lock_irq() out of all the
unthrottle() callbacks.

John Ogness

