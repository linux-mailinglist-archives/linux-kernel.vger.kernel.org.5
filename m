Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0A7A4101
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbjIRGXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbjIRGXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:23:41 -0400
X-Greylist: delayed 577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Sep 2023 23:23:33 PDT
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC7E6;
        Sun, 17 Sep 2023 23:23:33 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id AD2884403F6;
        Mon, 18 Sep 2023 09:13:45 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1695017625;
        bh=Jkjkzg9+FWNM+WB3mmUntEF1fe6JQVYGAp+gupXTDJY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Y3oGG3qHY8fQsIe5PHgjs3LNVmtf7Ri83TiHiCRWIUnD55zq3AVrYr6RtXoz5c2Xy
         B5JDQNHaZV4oV3+87w8djkFun8KovoESmz74DTYTT+aFyiCY/taf0q59kox7iLR5NC
         BLuYrPTPp+AzIzWJF6NE0ZQJX4CSz98/GNZg6KSOtstfXqhxFGlhypRp6QWyc1NB9g
         rAzPGE3e7/JVOIOoTNKPlfyYnT3ZhLnZ7/v3DDYl2nP9DfOEAArsIXedIkknnvnfRk
         ltEzYLDpgtf0a2+nnWIXhWDdccrGh7W23J4pmljZHdipS0Yz5aLlhWJGhEvDHDoVBl
         O+jajhadsu9Xg==
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-25-john.ogness@linutronix.de>
User-agent: mu4e 1.9.21; emacs 29.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty v1 24/74] serial: digicolor: Use port lock wrappers
Date:   Mon, 18 Sep 2023 09:13:03 +0300
In-reply-to: <20230914183831.587273-25-john.ogness@linutronix.de>
Message-ID: <87il88m2jk.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Sep 14 2023, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
>
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.
>
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
>
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
>
> Converted with coccinelle. No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/tty/serial/digicolor-usart.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
> index 128b5479e813..5004125f3045 100644
> --- a/drivers/tty/serial/digicolor-usart.c
> +++ b/drivers/tty/serial/digicolor-usart.c
> @@ -133,7 +133,7 @@ static void digicolor_uart_rx(struct uart_port *port)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  
>  	while (1) {
>  		u8 status, ch, ch_flag;
> @@ -172,7 +172,7 @@ static void digicolor_uart_rx(struct uart_port *port)
>  				 ch_flag);
>  	}
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	tty_flip_buffer_push(&port->state->port);
>  }
> @@ -185,7 +185,7 @@ static void digicolor_uart_tx(struct uart_port *port)
>  	if (digicolor_uart_tx_full(port))
>  		return;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  
>  	if (port->x_char) {
>  		writeb_relaxed(port->x_char, port->membase + UA_EMI_REC);
> @@ -211,7 +211,7 @@ static void digicolor_uart_tx(struct uart_port *port)
>  		uart_write_wakeup(port);
>  
>  out:
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  }
>  
>  static irqreturn_t digicolor_uart_int(int irq, void *dev_id)
> @@ -333,7 +333,7 @@ static void digicolor_uart_set_termios(struct uart_port *port,
>  		port->ignore_status_mask |= UA_STATUS_OVERRUN_ERR
>  			| UA_STATUS_PARITY_ERR | UA_STATUS_FRAME_ERR;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  
>  	uart_update_timeout(port, termios->c_cflag, baud);
>  
> @@ -341,7 +341,7 @@ static void digicolor_uart_set_termios(struct uart_port *port,
>  	writeb_relaxed(divisor & 0xff, port->membase + UA_HBAUD_LO);
>  	writeb_relaxed(divisor >> 8, port->membase + UA_HBAUD_HI);
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  }
>  
>  static const char *digicolor_uart_type(struct uart_port *port)
> @@ -398,14 +398,14 @@ static void digicolor_uart_console_write(struct console *co, const char *c,
>  	int locked = 1;
>  
>  	if (oops_in_progress)
> -		locked = spin_trylock_irqsave(&port->lock, flags);
> +		locked = uart_port_trylock_irqsave(port, &flags);
>  	else
> -		spin_lock_irqsave(&port->lock, flags);
> +		uart_port_lock_irqsave(port, &flags);
>  
>  	uart_console_write(port, c, n, digicolor_uart_console_putchar);
>  
>  	if (locked)
> -		spin_unlock_irqrestore(&port->lock, flags);
> +		uart_port_unlock_irqrestore(port, flags);
>  
>  	/* Wait for transmitter to become empty */
>  	do {


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
