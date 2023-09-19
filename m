Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FB97A6694
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjISOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjISOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:24:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D97AD;
        Tue, 19 Sep 2023 07:24:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BB82E1FF1D;
        Tue, 19 Sep 2023 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695133488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EN9onM0BUTlMJdHe2/ryT6BwqQBjIKXe4LSsDr/eSBk=;
        b=IaYCWTc+MRDbYLygYZIG7kfgsuGWDVzUI3QHpVxRvEE77gdyJcWAa5M0W9jP5dARUxbRi7
        uallohGNriE2pG9cYu5AWTOoTf1SPJIgu5jT9G76LNIBtFxjpvyuVsjJxnDK/Bf6LzsKYt
        Jf2YjvloxZPbnlW7gdE2y8T43LJgxjc=
Received: from suse.cz (dhcp219.suse.cz [10.100.51.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 93CCC2C142;
        Tue, 19 Sep 2023 14:24:48 +0000 (UTC)
Date:   Tue, 19 Sep 2023 16:24:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty v1 01/74] serial: core: Provide port lock wrappers
Message-ID: <ZQmvMMRvnUxh1NJn@alley>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914183831.587273-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-09-14 20:43:18, John Ogness wrote:
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
> Provide wrapper functions for spin_[un]lock*(port->lock) invocations so
> that the console mechanics can be applied later on at a single place and
> does not require to copy the same logic all over the drivers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/serial_core.h | 79 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index bb6f073bc159..f1d5c0d1568c 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> +/**
> + * uart_port_lock_irqsave - Lock the UART port, save and disable interrupts
> + * @up:		Pointer to UART port structure
> + * @flags:	Pointer to interrupt flags storage
> + */
> +static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
> +{
> +	spin_lock_irqsave(&up->lock, *flags);
> +}

IMHO, it would have been better to pass the flags variable directly
via a macro as it is done in most *_lock_*_irqsafe() APIs. I mean
something like:

/**
 * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
 * @up:		Pointer to UART port structure
 * @flags:	Interrupt flags storage
 *
 * Returns: True if lock was acquired, false otherwise
 */
#define uart_port_lock_irqsave(up, flags)		\
({							\
	local_irq_save(flags);				\
	uart_port_lock(lock)				\
})

> +
> +/**
> + * uart_port_trylock - Try to lock the UART port
> + * @up:		Pointer to UART port structure
> + *
> + * Returns: True if lock was acquired, false otherwise
> + */
> +static inline bool uart_port_trylock(struct uart_port *up)
> +{
> +	return spin_trylock(&up->lock);
> +}
> +
> +/**
> + * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
> + * @up:		Pointer to UART port structure
> + * @flags:	Pointer to interrupt flags storage
> + *
> + * Returns: True if lock was acquired, false otherwise
> + */
> +static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
> +{
> +	return spin_trylock_irqsave(&up->lock, *flags);
> +}

Similar here:

/**
 * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
 * @up:		Pointer to UART port structure
 * @flags:	Interrupt flags storage
 *
 * Returns: True if lock was acquired, false otherwise
 */
#define uart_port_trylock_irqsave(up, flags)			\
({								\
	bool __ret;						\
								\
	local_irq_save(flags);					\
	__ret = uart_port_trylock(lock)				\
	if (!__ret)						\
		local_irq_restore(flags);			\
	__ret;							\
})

I do not resist on this rather cosmetic change. The current code seems
to be doing what is expected. Feel free to keep it and use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am sorry for the late review. I have made a quick look on Monday
    and it looked straightforward. I have got this idea today when
    having a closer look.
