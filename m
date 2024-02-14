Return-Path: <linux-kernel+bounces-65292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B6854AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A4428455E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A1854BCC;
	Wed, 14 Feb 2024 13:45:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747E1CABA;
	Wed, 14 Feb 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918324; cv=none; b=Lx6Ufh9fSJl7wEC6l9e/T43bBdQov9M+AKtH0GWEl+sbZNOmCONeluMDAakzbuRhJyQNU0cN4yXeOL8RweBhJu7Jzd288cikGKG0xEAY0gixUwD36FbqFRMNfKrQquNP3USSBFTAsVed27iLznNA7JXbUXkigbVOVnhJrf6NLXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918324; c=relaxed/simple;
	bh=Sm09XkASGhFVi6HsGs5xp2nue2uw0MDJruPEPfw8aLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWlUPO2qoxYXAmISU/pMSAqHBzAaTi8UgPVhotoClDgq8SNgL84hiqjevnoTnnXFNXNQFSKucCsjDOTZ4P1hRrzSwC0rbmSp1mQM9ohsc1cd4fX7BW4zvwudXIXvmtyH+YHZ5aLwmTJfbXhHItf1LEEavNYXQnjcQss1I6OBeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2104668"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2104668"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 05:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935616662"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935616662"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2024 05:45:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 36400195; Wed, 14 Feb 2024 15:45:16 +0200 (EET)
Date: Wed, 14 Feb 2024 15:45:16 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: Add 8250 port clock update method
Message-ID: <ZczD7KPbeRnY4CFc@black.fi.intel.com>
References: <20200723003357.26897-1-Sergey.Semin@baikalelectronics.ru>
 <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>

On Thu, Jul 23, 2020 at 03:33:54AM +0300, Serge Semin wrote:
> Some platforms can be designed in a way so the UART port reference clock
> might be asynchronously changed at some point. In Baikal-T1 SoC this may
> happen due to the reference clock being shared between two UART ports, on
> the Allwinner SoC the reference clock is derived from the CPU clock, so
> any CPU frequency change should get to be known/reflected by/in the UART
> controller as well. But it's not enough to just update the
> uart_port->uartclk field of the corresponding UART port, the 8250
> controller reference clock divisor should be altered so to preserve
> current baud rate setting. All of these things is done in a coherent
> way by calling the serial8250_update_uartclk() method provided in this
> patch. Though note that it isn't supposed to be called from within the
> UART port callbacks because the locks using to the protect the UART port
> data are already taken in there.

..

> +/*
> + * Note in order to avoid the tty port mutex deadlock don't use the next method
> + * within the uart port callbacks. Primarily it's supposed to be utilized to
> + * handle a sudden reference clock rate change.
> + */
> +void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	unsigned int baud, quot, frac = 0;
> +	struct ktermios *termios;
> +	unsigned long flags;
> +
> +	mutex_lock(&port->state->port.mutex);
> +
> +	if (port->uartclk == uartclk)
> +		goto out_lock;
> +
> +	port->uartclk = uartclk;
> +	termios = &port->state->port.tty->termios;
> +
> +	baud = serial8250_get_baud_rate(port, termios, NULL);
> +	quot = serial8250_get_divisor(port, baud, &frac);
> +
> +	serial8250_rpm_get(up);
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	serial8250_set_divisor(port, baud, quot, frac);
> +	serial_port_out(port, UART_LCR, up->lcr);
> +	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +	serial8250_rpm_put(up);
> +
> +out_lock:
> +	mutex_unlock(&port->state->port.mutex);

While looking for something else I have stumbled over this function.
My Q is, since it has some duplications with
serial8250_do_set_termios(), can we actually call the latter (or
derevative that can be called in both) in the above code instead of
duplicating some lines?

	if (port UART clock has to be updated)
	  call (unlocked version of) serial8250_do_set_termios()

Serge, what do you think?

> +}

-- 
With Best Regards,
Andy Shevchenko



