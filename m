Return-Path: <linux-kernel+bounces-24486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97782BD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177DE283C96
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAF25D8F2;
	Fri, 12 Jan 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rydvb3T5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AEzFwmBq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5029D19;
	Fri, 12 Jan 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705051831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsJm0Dt+4QCHLYUugRSs3pkknp/phG3zkBZz27KM1Ig=;
	b=rydvb3T58EelH6LUAXLox4lkS/WS5IsTwEEusnGX+SWwCLZ51Eec7pJAfq4Grk8JdmkHgp
	LgKkuRWo6plqO5nMW277n1ExH6J1RKWVnWtM4rENOzv0aYC0Qb3pktYHy2A+aQZkY2FwnS
	Bd6zo8MhgXCe/RP2beH9XhgUia2vcfLJ4WU/uCUiFXqzV7jWFZB3kzfvSwc8YuXKhpECiZ
	TLM/1SZw0X+Z27jBOCZvzss7Lm0wJ51QrEs5AqRPn2UNcwg3qSSmcvTZ9Qbw27QaT/nr81
	+XGgAKml+/WE9CG++WoixwX4cL2Fh/EtbUf0kF3vtm2OPeMUNQEbPMQaFUuJYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705051831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zsJm0Dt+4QCHLYUugRSs3pkknp/phG3zkBZz27KM1Ig=;
	b=AEzFwmBqZVFmDXROhQRHd2DtOUtsRCHylHkcLx9B3dwCWC23fTYvUj4bhWi/IdNqm6LJpJ
	AwQB6rbxrYtw/lCg==
To: Gui-Dong Han <2045gemini@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, tony@atomide.com,
 l.sanfilippo@kunbus.com, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 baijiaju1990@outlook.com, Gui-Dong Han <2045gemini@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix atomicity violation in uart_tiocmget
In-Reply-To: <20240112075732.16730-1-2045gemini@gmail.com>
References: <20240112075732.16730-1-2045gemini@gmail.com>
Date: Fri, 12 Jan 2024 10:36:29 +0106
Message-ID: <87msta7vbe.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-12, Gui-Dong Han <2045gemini@gmail.com> wrote:
> In uart_tiocmget():
>     result = uport->mctrl;
>     uart_port_lock_irq(uport);
>     result |= uport->ops->get_mctrl(uport);
>     uart_port_unlock_irq(uport);
>     ...
>     return result;
>
> In uart_update_mctrl():
>     uart_port_lock_irqsave(port, &flags);
>     ...
>     port->mctrl = (old & ~clear) | set;
>     ...
>     uart_port_unlock_irqrestore(port, flags);
>
> An atomicity violation is identified due to the concurrent execution of
> uart_tiocmget() and uart_update_mctrl(). After assigning
> result = uport->mctrl, the mctrl value may change in uart_update_mctrl(),
> leading to a mismatch between the value returned by
> uport->ops->get_mctrl(uport) and the mctrl value previously read.
> This can result in uart_tiocmget() returning an incorrect value.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> to extract function pairs that can be concurrently executed, and then
> analyzes the instructions in the paired functions to identify possible
> concurrency bugs including data races and atomicity violations. The above
> possible bug is reported when our tool analyzes the source code of
> Linux 5.17.
>
> To address this issue, it is suggested to move the line
> result = uport->mctrl inside the uart_port_lock block to ensure atomicity
> and prevent the mctrl value from being altered during the execution of
> uart_tiocmget(). With this patch applied, our tool no longer reports the
> bug, with the kernel configuration allyesconfig for x86_64. Due to the
> absence of the requisite hardware, we are unable to conduct runtime
> testing of the patch. Therefore, our verification is solely based on code
> logic analysis.
>
> [1] https://sites.google.com/view/basscheck/
>
> Fixes: 559c7ff4e324 ("serial: core: Use port lock wrappers")

It fixes c5f4644e6c8b ("[PATCH] Serial: Adjust serial locking").

> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 80085b151b34..a9e39416d877 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1085,8 +1085,8 @@ static int uart_tiocmget(struct tty_struct *tty)
>  		goto out;
>  
>  	if (!tty_io_error(tty)) {
> -		result = uport->mctrl;
>  		uart_port_lock_irq(uport);
> +		result = uport->mctrl;
>  		result |= uport->ops->get_mctrl(uport);
>  		uart_port_unlock_irq(uport);
>  	}

Looking over the RMW accesses to @mctrl, I expect you will also need
this hunk:

@@ -2242,6 +2242,7 @@ uart_set_options(struct uart_port *port, struct console *co,
 {
 	struct ktermios termios;
 	static struct ktermios dummy;
+	unsigned long flags;
 
 	/*
 	 * Ensure that the serial-console lock is initialised early.
@@ -2279,7 +2280,9 @@ uart_set_options(struct uart_port *port, struct console *co,
 	 * some uarts on other side don't support no flow control.
 	 * So we set * DTR in host uart to make them happy
 	 */
+	uart_port_lock_irqsave(port, &flags);
 	port->mctrl |= TIOCM_DTR;
+	uart_port_unlock_irqrestore(port, flags);
 
 	port->ops->set_termios(port, &termios, &dummy);
 	/*

FWIW,
Reviewed-by: John Ogness <john.ogness@linutronix.de>

