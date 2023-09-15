Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F137A1FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjIONk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjIONk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:40:56 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BC72126;
        Fri, 15 Sep 2023 06:40:50 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ab3aa9ae33so1341450b6e.2;
        Fri, 15 Sep 2023 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694785250; x=1695390050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuoie5VydNZ436D0bI8YVDJgToS1nI2k6ynYpC3mhgE=;
        b=fOuhmyD4Ay9rxiFXuM2Mw345/JVv6Tc4reFWM9Ed4OVROAwDfeBnKRHkx8XKcKcTWH
         /lX3qwHGHUDqsMezyHSJdeneu1XNrZ9RIs43VBdi3EpPi+QNsq4MOLBWcTO3sDb/aNex
         guMfR08o6/qOa21aKasrUckiC86B1TBzWh+vIW4/7aX/yihEmbC5fXnEMCKf6BFItuTk
         +J6z8z+midVbWxIbIQw2UgRhiVisQY0EzRJydUs1jTR7LIbq78RBl2bKeWoF2h2dgih8
         AfJii8YK5VMKanXCUBsbbYDuGwNWS3z2wO7JojHB+l272To9LbngnBFO/BpXpwf24m3v
         m0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785250; x=1695390050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuoie5VydNZ436D0bI8YVDJgToS1nI2k6ynYpC3mhgE=;
        b=ds18xzLedXIwyunHfIYbma/vLVzAt88s7ZsU/ktYT7oEF+CnkXicZl3UUEeFeplK/C
         Db01UeGggk3N1s2p5ufkeT51wxM376WBW5QV7zEfOILdWM2k/r4VhPkxDdkrQQEFeImn
         sW8A3Whr5PrhdfZJRgxCQD4Njk2Gwuef/QVePx/q8BrGnjHFyhEXasfntmpEUJp23C0z
         s6iORYYqBLuSMEXGqWr+jUC75oi2bZrun1Ku9zhmF24vf4AP/IUDMOX593vaDHQ5/KRS
         jeqpw11LbxsqeAj8EfPDnt6dwXUj0p1lqGK8xjEt71UdP+eBhwQEV+6xtcgolI29UeuV
         ajRg==
X-Gm-Message-State: AOJu0Yxd+3f220UecO6haKTdLW4sG8sDnNw+VQriE5xMEM1Ne4d5rh2y
        cm/r73NWLnC5IPv3nbkNYMY=
X-Google-Smtp-Source: AGHT+IGtk627Jg1fLFcp7OwJGqqslQYVLGViQXPv5476HEUx2g+RS66kPxZS+S1wrworub7i9ijuCA==
X-Received: by 2002:a05:6808:1a86:b0:3a7:37ae:4a47 with SMTP id bm6-20020a0568081a8600b003a737ae4a47mr1683447oib.12.1694785249979;
        Fri, 15 Sep 2023 06:40:49 -0700 (PDT)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id ay33-20020a05622a22a100b0040ff121e011sm1180124qtb.2.2023.09.15.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 06:40:49 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:40:47 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH tty v1 32/74] serial: liteuart: Use port lock wrappers
Message-ID: <ZQRe378VK0194L5p@errol.ini.cmu.edu>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-33-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914183831.587273-33-john.ogness@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

On Thu, Sep 14, 2023 at 08:43:49PM +0206, John Ogness wrote:
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
> ---
>  drivers/tty/serial/liteuart.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index d881cdd2a58f..a25ab1efe38f 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -139,13 +139,13 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
>  	 * if polling, the context would be "in_serving_softirq", so use
>  	 * irq[save|restore] spin_lock variants to cover all possibilities
>  	 */
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
>  	if (isr & EV_RX)
>  		liteuart_rx_chars(port);
>  	if (isr & EV_TX)
>  		liteuart_tx_chars(port);
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	return IRQ_RETVAL(isr);
>  }
> @@ -195,10 +195,10 @@ static int liteuart_startup(struct uart_port *port)
>  		}
>  	}
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  	/* only enabling rx irqs during startup */
>  	liteuart_update_irq_reg(port, true, EV_RX);
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	if (!port->irq) {
>  		timer_setup(&uart->timer, liteuart_timer, 0);
> @@ -213,9 +213,9 @@ static void liteuart_shutdown(struct uart_port *port)
>  	struct liteuart_port *uart = to_liteuart_port(port);
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	if (port->irq)
>  		free_irq(port->irq, port);
> @@ -229,13 +229,13 @@ static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
>  	unsigned int baud;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  
>  	/* update baudrate */
>  	baud = uart_get_baud_rate(port, new, old, 0, 460800);
>  	uart_update_timeout(port, new->c_cflag, baud);
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  }
>  
>  static const char *liteuart_type(struct uart_port *port)
> @@ -382,9 +382,9 @@ static void liteuart_console_write(struct console *co, const char *s,
>  	uart = (struct liteuart_port *)xa_load(&liteuart_array, co->index);
>  	port = &uart->port;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> +	uart_port_lock_irqsave(port, &flags);
>  	uart_console_write(port, s, count, liteuart_putchar);
> -	spin_unlock_irqrestore(&port->lock, flags);
> +	uart_port_unlock_irqrestore(port, flags);
>  }
>  
>  static int liteuart_console_setup(struct console *co, char *options)
> -- 
> 2.39.2
> 
