Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0D7A1A92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjIOJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjIOJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:29:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0431FE0;
        Fri, 15 Sep 2023 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694770174; x=1726306174;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N2GcRzHvPFKWmclNrZGH3J6zZ3cVlBtcbtnwJQ0dWz4=;
  b=IeGQOVxj5J4/hNgzY/qSJHPIlnvt83emZZgE7fGCZJRT1LdU3iX28SKP
   wxUwQDRZQX8hAPyHdjdTQcCu/kudcYtHg7dxoggVoqeju6qWUvinyx6Q3
   HB6hyVIiKA9O/gltHisUVnPyDx++EnrAEhLDqYcFd4eTXSjdKsuAShcI4
   y4b8RapQo+EC1KtAlM0/u2uCeLiCyz1Qy74S64uK2LjVF7h1Rxp6OK+A9
   Wy/n9W9mSmFqMRZCj01s0EfBlG9002cq7xGMy5uinbXDnNoWTsCYU9+1H
   4RRu8eqb24yRL0AhJKHUFYlZKR0KfZYU96SJ8C5BvN+WIm6T4OVXxjuA4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379124197"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="379124197"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918592672"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="918592672"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:26:00 -0700
Date:   Fri, 15 Sep 2023 12:25:57 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH tty v1 01/74] serial: core: Provide port lock wrappers
In-Reply-To: <20230914183831.587273-2-john.ogness@linutronix.de>
Message-ID: <d5cac09c-177d-9e24-8e28-7b31abcc1e@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-95333392-1694769962=:2347"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-95333392-1694769962=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 14 Sep 2023, John Ogness wrote:

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
> @@ -588,6 +588,85 @@ struct uart_port {
>  	void			*private_data;		/* generic platform data pointer */
>  };
>  
> +/**
> + * uart_port_lock - Lock the UART port
> + * @up:		Pointer to UART port structure
> + */
> +static inline void uart_port_lock(struct uart_port *up)
> +{
> +	spin_lock(&up->lock);
> +}
> +
> +/**
> + * uart_port_lock_irq - Lock the UART port and disable interrupts
> + * @up:		Pointer to UART port structure
> + */
> +static inline void uart_port_lock_irq(struct uart_port *up)
> +{
> +	spin_lock_irq(&up->lock);
> +}
> +
> +/**
> + * uart_port_lock_irqsave - Lock the UART port, save and disable interrupts
> + * @up:		Pointer to UART port structure
> + * @flags:	Pointer to interrupt flags storage
> + */
> +static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
> +{
> +	spin_lock_irqsave(&up->lock, *flags);
> +}
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
> +
> +/**
> + * uart_port_unlock - Unlock the UART port
> + * @up:		Pointer to UART port structure
> + */
> +static inline void uart_port_unlock(struct uart_port *up)
> +{
> +	spin_unlock(&up->lock);
> +}
> +
> +/**
> + * uart_port_unlock_irq - Unlock the UART port and re-enable interrupts
> + * @up:		Pointer to UART port structure
> + */
> +static inline void uart_port_unlock_irq(struct uart_port *up)
> +{
> +	spin_unlock_irq(&up->lock);
> +}
> +
> +/**
> + * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
> + * @up:		Pointer to UART port structure
> + * @flags:	The saved interrupt flags for restore
> + */
> +static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
> +{
> +	spin_unlock_irqrestore(&up->lock, flags);
> +}
> +
>  static inline int serial_port_in(struct uart_port *up, int offset)
>  {
>  	return up->serial_in(up, offset);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-95333392-1694769962=:2347--
