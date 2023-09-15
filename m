Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABE7A1A20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjIOJPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:15:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26F898;
        Fri, 15 Sep 2023 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694769297; x=1726305297;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CeM5K/VFy1Wo5gVfxA3wNMmKSXfxOKlo5AiwsitcOPU=;
  b=QKu/Qfg7k9YKzEvDyxKE8KgRWcAxAMRZFkD0FAsLkEDh5DCUncMAp9Yn
   DZitoJySSofuZXjv912bKUbEADbG0ShZ+Z4jvyEA9lTLgUfjrcQ6pYtMR
   j3/ChGt/jOON3CUX0VLBGU3u5lOXYxT+dEv9MB5wejNc7Z7j2GARE4oMw
   9FlcV3nDE4jfPzeM3S7vz7zPLht98jooimzTF9LndeT+/yfXV7FPmH5Tq
   9okpZR19ZoVgfTIaXfe8dC4s49hhFfXYpK2vgLqovXtCtsXOmuXnAFgei
   dDuOJzKqNy0MO5CyqavR41Ioq2Sd4AK7o4M/bKexskvHI/dYdIU8BOIzp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369523756"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="369523756"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744905421"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744905421"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:14:54 -0700
Date:   Fri, 15 Sep 2023 12:14:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH tty v1 07/74] serial: 8250_dma: Use port lock wrappers
In-Reply-To: <20230914183831.587273-8-john.ogness@linutronix.de>
Message-ID: <2410ffe1-d89c-8598-3e41-8ba2454088d@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2032124865-1694769296=:2347"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2032124865-1694769296=:2347
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
>  drivers/tty/serial/8250/8250_dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 7fa66501792d..8b30ca8fdd3f 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -22,7 +22,7 @@ static void __dma_tx_complete(void *param)
>  	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
>  				UART_XMIT_SIZE, DMA_TO_DEVICE);
>  
> -	spin_lock_irqsave(&p->port.lock, flags);
> +	uart_port_lock_irqsave(&p->port, &flags);
>  
>  	dma->tx_running = 0;
>  
> @@ -35,7 +35,7 @@ static void __dma_tx_complete(void *param)
>  	if (ret || !dma->tx_running)
>  		serial8250_set_THRI(p);
>  
> -	spin_unlock_irqrestore(&p->port.lock, flags);
> +	uart_port_unlock_irqrestore(&p->port, flags);
>  }
>  
>  static void __dma_rx_complete(struct uart_8250_port *p)
> @@ -70,7 +70,7 @@ static void dma_rx_complete(void *param)
>  	struct uart_8250_dma *dma = p->dma;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&p->port.lock, flags);
> +	uart_port_lock_irqsave(&p->port, &flags);
>  	if (dma->rx_running)
>  		__dma_rx_complete(p);
>  
> @@ -80,7 +80,7 @@ static void dma_rx_complete(void *param)
>  	 */
>  	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
>  		p->dma->rx_dma(p);
> -	spin_unlock_irqrestore(&p->port.lock, flags);
> +	uart_port_unlock_irqrestore(&p->port, flags);
>  }
>  
>  int serial8250_tx_dma(struct uart_8250_port *p)

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2032124865-1694769296=:2347--
