Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5D07A6B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjISTQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:16:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146759D;
        Tue, 19 Sep 2023 12:16:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2F1C433C8;
        Tue, 19 Sep 2023 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695150970;
        bh=jf+VEtEVDip16BygVcd1gg6eYv9qfsttIJH+Gqr6U3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reHoaaC0L+T06Lbrc+bcdJAKJM4JMHS9YsU9sfplgt3Sw9jHEa1m5o3/J9G1/JL88
         qaf2fDgQI31zADN7roR0GDMWqKeXyjx/WYldlsCaGDkSesVgV7TqTKOgR+cqKqSb87
         kzMc7k4UR84aAGB0/4nRnB+d2k2TgBxxfHkuaKB0=
Date:   Tue, 19 Sep 2023 21:16:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty v1 01/74] serial: core: Provide port lock wrappers
Message-ID: <2023091933-dollar-unwell-3ffd@gregkh>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-2-john.ogness@linutronix.de>
 <ZQmvMMRvnUxh1NJn@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQmvMMRvnUxh1NJn@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:24:48PM +0200, Petr Mladek wrote:
> On Thu 2023-09-14 20:43:18, John Ogness wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > When a serial port is used for kernel console output, then all
> > modifications to the UART registers which are done from other contexts,
> > e.g. getty, termios, are interference points for the kernel console.
> > 
> > So far this has been ignored and the printk output is based on the
> > principle of hope. The rework of the console infrastructure which aims to
> > support threaded and atomic consoles, requires to mark sections which
> > modify the UART registers as unsafe. This allows the atomic write function
> > to make informed decisions and eventually to restore operational state. It
> > also allows to prevent the regular UART code from modifying UART registers
> > while printk output is in progress.
> > 
> > All modifications of UART registers are guarded by the UART port lock,
> > which provides an obvious synchronization point with the console
> > infrastructure.
> > 
> > Provide wrapper functions for spin_[un]lock*(port->lock) invocations so
> > that the console mechanics can be applied later on at a single place and
> > does not require to copy the same logic all over the drivers.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  include/linux/serial_core.h | 79 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index bb6f073bc159..f1d5c0d1568c 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > +/**
> > + * uart_port_lock_irqsave - Lock the UART port, save and disable interrupts
> > + * @up:		Pointer to UART port structure
> > + * @flags:	Pointer to interrupt flags storage
> > + */
> > +static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
> > +{
> > +	spin_lock_irqsave(&up->lock, *flags);
> > +}
> 
> IMHO, it would have been better to pass the flags variable directly
> via a macro as it is done in most *_lock_*_irqsafe() APIs. I mean
> something like:
> 
> /**
>  * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
>  * @up:		Pointer to UART port structure
>  * @flags:	Interrupt flags storage
>  *
>  * Returns: True if lock was acquired, false otherwise
>  */
> #define uart_port_lock_irqsave(up, flags)		\
> ({							\
> 	local_irq_save(flags);				\
> 	uart_port_lock(lock)				\
> })
> 
> > +
> > +/**
> > + * uart_port_trylock - Try to lock the UART port
> > + * @up:		Pointer to UART port structure
> > + *
> > + * Returns: True if lock was acquired, false otherwise
> > + */
> > +static inline bool uart_port_trylock(struct uart_port *up)
> > +{
> > +	return spin_trylock(&up->lock);
> > +}
> > +
> > +/**
> > + * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
> > + * @up:		Pointer to UART port structure
> > + * @flags:	Pointer to interrupt flags storage
> > + *
> > + * Returns: True if lock was acquired, false otherwise
> > + */
> > +static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
> > +{
> > +	return spin_trylock_irqsave(&up->lock, *flags);
> > +}
> 
> Similar here:
> 
> /**
>  * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
>  * @up:		Pointer to UART port structure
>  * @flags:	Interrupt flags storage
>  *
>  * Returns: True if lock was acquired, false otherwise
>  */
> #define uart_port_trylock_irqsave(up, flags)			\
> ({								\
> 	bool __ret;						\
> 								\
> 	local_irq_save(flags);					\
> 	__ret = uart_port_trylock(lock)				\
> 	if (!__ret)						\
> 		local_irq_restore(flags);			\
> 	__ret;							\
> })

What is the difference here of a macro vs. an inline function going to
do for the resulting binary?  The important thing is now we have wrapper
functions, people can tweak them all they want to see if we can get
better results :)

thanks for the review!

greg k-h
