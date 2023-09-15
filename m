Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73CA7A1A32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjIOJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjIOJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:16:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D210C3;
        Fri, 15 Sep 2023 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694769410; x=1726305410;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vZq7A/gz70wd7tTFMBwNyA9QmwBFlSJ2HI2SHAFevfQ=;
  b=Z7z4EblfFpLzuVhAtM4TXs/Cu7Tx6ITDxkzIKPGQhzNxd8t8af8Kzo2e
   yic+wUwi+ujsR/zgtO6+MIQRD5cAber2/5hPbpyl42C+eRknY+CjOensX
   znots5p5k9+C9relZ3QhMsIXRg5JQpiVlYCrePLnNa4LXbUb801jNV+35
   49RyBLMC13T2FxgdWcQ7popQL5HDP/xaGmLBW1ra6O2l8WyioEvP2CTn8
   IRvbE3oVwNIP91viIhxs48aJ1G/TWizztXHtP/guYkSMB/Zdj6JAEofug
   J6xX8VhyzTbFiafzxrfjwXb6r+PrRRD7BC3HZn2OggPvxHWW0bVQMcq2Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443269597"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="443269597"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="810452200"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="810452200"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 02:16:47 -0700
Date:   Fri, 15 Sep 2023 12:16:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH tty v1 08/74] serial: 8250_dw: Use port lock wrappers
In-Reply-To: <20230914183831.587273-9-john.ogness@linutronix.de>
Message-ID: <e0fa1eab-5a46-cf6a-46b0-42e236db2077@linux.intel.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de> <20230914183831.587273-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1284566438-1694769409=:2347"
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

--8323329-1284566438-1694769409=:2347
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
>  drivers/tty/serial/8250/8250_dw.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f4cafca1a7da..95d45dce0880 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -263,20 +263,20 @@ static int dw8250_handle_irq(struct uart_port *p)
>  	 * so we limit the workaround only to non-DMA mode.
>  	 */
>  	if (!up->dma && rx_timeout) {
> -		spin_lock_irqsave(&p->lock, flags);
> +		uart_port_lock_irqsave(p, &flags);
>  		status = serial_lsr_in(up);
>  
>  		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
>  			(void) p->serial_in(p, UART_RX);
>  
> -		spin_unlock_irqrestore(&p->lock, flags);
> +		uart_port_unlock_irqrestore(p, flags);
>  	}
>  
>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>  	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
> -		spin_lock_irqsave(&p->lock, flags);
> +		uart_port_lock_irqsave(p, &flags);
>  		status = serial_lsr_in(up);
> -		spin_unlock_irqrestore(&p->lock, flags);
> +		uart_port_unlock_irqrestore(p, flags);
>  
>  		if (status & (UART_LSR_DR | UART_LSR_BI)) {
>  			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1284566438-1694769409=:2347--
