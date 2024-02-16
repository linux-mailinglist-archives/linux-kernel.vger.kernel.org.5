Return-Path: <linux-kernel+bounces-68425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA2857A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D00B243AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F811C68F;
	Fri, 16 Feb 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH+Z5ojf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E71C2AD;
	Fri, 16 Feb 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078376; cv=none; b=Mminsbmh9kco8DL6U9vMHmXFHDNAgKA6sRIfBNzzNV8VQGKJBIixhzeIRlEENJp3PXgTsoBGFiA6LYEc9ZLOGo6dOLz0rKQW3gW13u8iyNuXxwdAih5T9ORD1IrWPm8FMSaD0MmDG1VrMLiczeBPumVnl+GVKGd3lwtEnTjZzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078376; c=relaxed/simple;
	bh=pD+T+OI+k9DeYvh40FmpgO7ATobiBnn71HQgox1KK0s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m5rdDRl8DFMd+YHzLcC3ARdCghl/WZB4fTvjyNB/BFP5g/34oZduMZ3dhShq3Byo2g22Ur8Y776G1juC2cveEApfvrwTdT1IdEAEPLVRfr+QJjWK3kEOMG7JUChRIyiUh5b/wHNwhsfHZXsmHo6dATBUK2uF3ZHGiJI9SVKjqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH+Z5ojf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708078375; x=1739614375;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pD+T+OI+k9DeYvh40FmpgO7ATobiBnn71HQgox1KK0s=;
  b=mH+Z5ojfT3F34ZbPiK5FdqpascKE2BfkVv5lx4ZyKOfqWJD287n+jA4v
   UQOHb/xuao12j7/rmra1j3kl842kGSOx/nREkEOyM03Bj943ZGWnnZOYg
   SJl70uT2LyqgrSzfvsTkXsoOAJdahbJCsFOY6D12v9PV5ooUFeJOmTCPs
   Fym4LdFY3jpXjxUyvoFxWLaNfy7MA++p5Ske5fzsEJtrqhDN/y/Q0+9En
   qLAqJh1DM7oUJDFJrv7yQBriZXRTO9VnpK5Kaap7dfiu66fahHPNqdTMg
   zSbEvRAdBAc+wqKew9i8BW4lGFbguCQNFDXuMmwB6FL442ZX4B7hWTzAC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2069396"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2069396"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 02:12:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="8404669"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 02:12:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 12:12:44 +0200 (EET)
To: Leonardo Bras <leobras@redhat.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Tony Lindgren <tony@atomide.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    John Ogness <john.ogness@linutronix.de>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Florian Fainelli <florian.fainelli@broadcom.com>, 
    Shanker Donthineni <sdonthineni@nvidia.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/4] tty/serial8250: Make use of IRQ_HANDLED_MANY
 interface
In-Reply-To: <20240216075948.131372-6-leobras@redhat.com>
Message-ID: <8c080e51-6ae5-0e8a-69f6-ca3666164248@linux.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-6-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Feb 2024, Leonardo Bras wrote:

> For every TX byte an IRQ is requested.
> On threaded IRQs, the handler calls serial8250_tx_chars can send multiple
> bytes, limited to it's queue size (tx_loadsz).

Perhaps I'm missing something here but I don't understand what this tries 
to say.

- 8250 driver gets TX empty IRQ
- We write x bytes to FIFO
- UART blasts those bits to wire, eventually emptying FIFO
- We get the next TX empty IRQ

What in this makes "for every TX byte an IRQ is requested" true? There's 
one IRQ only for every x bytes TX'ed as far as I can tell!?!

-- 
 i.

> When this happens, the handler return IRQ_HANDLED with reduces the
> unhandled IRQ counter only by 1, even though many requests have been
> handled at once.
> 
> This causes the unhandled IRQ counter to go up until it reaches the maximum
> and causes the registered IRQ to be disabled, thus breaking the serial
> console.
> 
> Make use of the newly introduced IRQ_HANDLED_MANY interface to return the
> number of requests handled, so the unhandled IRQ counter can get decreased
> accordingly.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  include/linux/serial_8250.h         |  2 +-
>  drivers/tty/serial/8250/8250_core.c | 13 ++++++++-----
>  drivers/tty/serial/8250/8250_port.c | 16 ++++++++++------
>  3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index ec46e3b49ee99..c9d4271b71d70 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -200,7 +200,7 @@ int fsl8250_handle_irq(struct uart_port *port);
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
>  u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
>  void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
> -void serial8250_tx_chars(struct uart_8250_port *up);
> +int serial8250_tx_chars(struct uart_8250_port *up);
>  unsigned int serial8250_modem_status(struct uart_8250_port *up);
>  void serial8250_init_port(struct uart_8250_port *up);
>  void serial8250_set_defaults(struct uart_8250_port *up);
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index ae637155fe7cd..2fab9102eec45 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -110,7 +110,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>  {
>  	struct irq_info *i = dev_id;
>  	struct list_head *l, *end = NULL;
> -	int pass_counter = 0, handled = 0;
> +	int pass_counter = 0, handled_total = 0;
>  
>  	pr_debug("%s(%d): start\n", __func__, irq);
>  
> @@ -120,15 +120,18 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>  	do {
>  		struct uart_8250_port *up;
>  		struct uart_port *port;
> +		int handled;
>  
>  		up = list_entry(l, struct uart_8250_port, list);
>  		port = &up->port;
>  
> -		if (port->handle_irq(port)) {
> -			handled = 1;
> +		handled = port->handle_irq(port);
> +		if (handled) {
> +			handled_total += handled;
>  			end = NULL;
> -		} else if (end == NULL)
> +		} else if (end == NULL) {
>  			end = l;
> +		}
>  
>  		l = l->next;
>  
> @@ -140,7 +143,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>  
>  	pr_debug("%s(%d): end\n", __func__, irq);
>  
> -	return IRQ_RETVAL(handled);
> +	return IRQ_RETVAL_MANY(handled_total);
>  }
>  
>  /*
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f799c34f1603c..74d53507a73d4 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1802,7 +1802,7 @@ u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
>  }
>  EXPORT_SYMBOL_GPL(serial8250_rx_chars);
>  
> -void serial8250_tx_chars(struct uart_8250_port *up)
> +int serial8250_tx_chars(struct uart_8250_port *up)
>  {
>  	struct uart_port *port = &up->port;
>  	struct circ_buf *xmit = &port->state->xmit;
> @@ -1810,15 +1810,15 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  
>  	if (port->x_char) {
>  		uart_xchar_out(port, UART_TX);
> -		return;
> +		return 0;
>  	}
>  	if (uart_tx_stopped(port)) {
>  		serial8250_stop_tx(port);
> -		return;
> +		return 0;
>  	}
>  	if (uart_circ_empty(xmit)) {
>  		__stop_tx(up);
> -		return;
> +		return 0;
>  	}
>  
>  	count = up->tx_loadsz;
> @@ -1858,6 +1858,9 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  	 */
>  	if (uart_circ_empty(xmit) && !(up->capabilities & UART_CAP_RPM))
>  		__stop_tx(up);
> +
> +	/* Return number of chars sent */
> +	return up->tx_loadsz - count;
>  }
>  EXPORT_SYMBOL_GPL(serial8250_tx_chars);
>  
> @@ -1923,6 +1926,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  	bool skip_rx = false;
>  	unsigned long flags;
>  	u16 status;
> +	int handled = 0;
>  
>  	if (iir & UART_IIR_NO_INT)
>  		return 0;
> @@ -1956,14 +1960,14 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  	serial8250_modem_status(up);
>  	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
>  		if (!up->dma || up->dma->tx_err)
> -			serial8250_tx_chars(up);
> +			handled = serial8250_tx_chars(up);
>  		else if (!up->dma->tx_running)
>  			__stop_tx(up);
>  	}
>  
>  	uart_unlock_and_check_sysrq_irqrestore(port, flags);
>  
> -	return 1;
> +	return handled ? : 1;
>  }
>  EXPORT_SYMBOL_GPL(serial8250_handle_irq);
>  
> 


