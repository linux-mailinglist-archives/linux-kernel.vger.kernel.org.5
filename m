Return-Path: <linux-kernel+bounces-67595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D63856DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6B1288989
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8413A247;
	Thu, 15 Feb 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfoMT3Pc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB795DF16;
	Thu, 15 Feb 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025962; cv=none; b=gbyve6cEcxYooWROUkEq1l5oAUq1aCme1myWX/5U6ncRwgD+ZpLNs7wjPRiupX9Wi5D7doKPaOAMFjTObFEMmCqFII+L/QwIPbtRcHgM3dC4k124vhw+xBslbyVriiC62UoYxD5UVFFV6B9So5df2Lc4WXGMymj2aw7RK2otOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025962; c=relaxed/simple;
	bh=YFOR+Arlx5FVrIxE5bHInAvHuwbTq/fqX8EsZFHTlqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htFMaqxGOQW2RUC0yIWYhQqHD7sYSN4dDTURKqA4RpdYEZxuHO4J6ALWyq4qnDv3CyW+/Nlc+ekgfVWsUBa/z2SJjtyByNnN3/G8bkaEXI3GiX3oEc0N6pqG4W31y6pbVN1zNJsJYElfiAnc42nqLX3PvX7zXE8qvE5sWC0iT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfoMT3Pc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708025960; x=1739561960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YFOR+Arlx5FVrIxE5bHInAvHuwbTq/fqX8EsZFHTlqY=;
  b=mfoMT3PcAKmaDxXh0z42NtHtywpjsEzQgFlubfoQYh5svODWLE7FCwIk
   6yoSjhc9UYZ4XhbY12z32Xuyz3dkonX8RS65cBL+q/DI114e1RIUk3MJj
   Rd/fnI9WoQYfE0HigAtnWypVsVo2w0tk9JeZLdKKsLc1WIXq9trcJFyP5
   eQ6UMxYDDAPtGSLNbBePbE15k/voQ6gjwC8nRcsWBI9OyeLCktpQl2Hs4
   N1vIqtCgef7qL17GBStCCJDKcmLjmUB/cxNQ5n+9KIyjYTgMU12tqmv/y
   xGT03YXYRdylHgYWtHH2U8X6YcfnGtmuGTwTs2TN81noFK0SqzfW6VTmi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5948995"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5948995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912218874"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912218874"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:39:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahZh-00000004sNG-0DXo;
	Thu, 15 Feb 2024 21:39:13 +0200
Date: Thu, 15 Feb 2024 21:39:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andy Shevchenko <andy@black.fi.intel.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Maxime Ripard <mripard@kernel.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: Add 8250 port clock update method
Message-ID: <Zc5oYJY6W_MCpwhN@smile.fi.intel.com>
References: <20200723003357.26897-1-Sergey.Semin@baikalelectronics.ru>
 <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>
 <ZczD7KPbeRnY4CFc@black.fi.intel.com>
 <raryiklwhctwxcfj3ulbnjcl32owagiccmxpwzmszlh3vm343y@h2ehupm7uiga>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <raryiklwhctwxcfj3ulbnjcl32owagiccmxpwzmszlh3vm343y@h2ehupm7uiga>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 15, 2024 at 10:32:18PM +0300, Serge Semin wrote:
> On Wed, Feb 14, 2024 at 03:45:16PM +0200, Andy Shevchenko wrote:
> > On Thu, Jul 23, 2020 at 03:33:54AM +0300, Serge Semin wrote:
> > > Some platforms can be designed in a way so the UART port reference clock
> > > might be asynchronously changed at some point. In Baikal-T1 SoC this may
> > > happen due to the reference clock being shared between two UART ports, on
> > > the Allwinner SoC the reference clock is derived from the CPU clock, so
> > > any CPU frequency change should get to be known/reflected by/in the UART
> > > controller as well. But it's not enough to just update the
> > > uart_port->uartclk field of the corresponding UART port, the 8250
> > > controller reference clock divisor should be altered so to preserve
> > > current baud rate setting. All of these things is done in a coherent
> > > way by calling the serial8250_update_uartclk() method provided in this
> > > patch. Though note that it isn't supposed to be called from within the
> > > UART port callbacks because the locks using to the protect the UART port
> > > data are already taken in there.

..

> > > +/*
> > > + * Note in order to avoid the tty port mutex deadlock don't use the next method
> > > + * within the uart port callbacks. Primarily it's supposed to be utilized to
> > > + * handle a sudden reference clock rate change.
> > > + */
> > > +void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
> > > +{
> > > +	struct uart_8250_port *up = up_to_u8250p(port);
> > > +	unsigned int baud, quot, frac = 0;
> > > +	struct ktermios *termios;
> > > +	unsigned long flags;
> > > +
> > > +	mutex_lock(&port->state->port.mutex);
> > > +
> > > +	if (port->uartclk == uartclk)
> > > +		goto out_lock;
> > > +
> > > +	port->uartclk = uartclk;
> > > +	termios = &port->state->port.tty->termios;
> > > +
> > > +	baud = serial8250_get_baud_rate(port, termios, NULL);
> > > +	quot = serial8250_get_divisor(port, baud, &frac);
> > > +
> > > +	serial8250_rpm_get(up);
> > > +	spin_lock_irqsave(&port->lock, flags);
> > > +
> > > +	uart_update_timeout(port, termios->c_cflag, baud);
> > > +
> > > +	serial8250_set_divisor(port, baud, quot, frac);
> > > +	serial_port_out(port, UART_LCR, up->lcr);
> > > +	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
> > > +
> > > +	spin_unlock_irqrestore(&port->lock, flags);
> > > +	serial8250_rpm_put(up);
> > > +
> > > +out_lock:
> > > +	mutex_unlock(&port->state->port.mutex);
> > 
> 
> > While looking for something else I have stumbled over this function.
> > My Q is, since it has some duplications with
> > serial8250_do_set_termios(), can we actually call the latter (or
> > derevative that can be called in both) in the above code instead of
> > duplicating some lines?
> > 
> > 	if (port UART clock has to be updated)
> > 	  call (unlocked version of) serial8250_do_set_termios()
> > 
> > Serge, what do you think?
> 
> What an old thread you've digged out.)

Indeed :-)

> Well, AFAIR I didn't create a common baud-rate/clock-update method
> because the baud-rate change was just a two stages action:
> 1. calculate divisor+quot couple based on the new clock,
> 2. update the divisor+quot (+ update the timeout).
> The first stage didn't need to have the IRQsafe lock being held and
> the runtime-PM being enabled, meanwhile the later one needed those.
> So unless the nested locking or try-lock-based pattern is implemented
> each stage required dedicated function introduced, which would have
> been an overkill for that. But even if I got to implement the
> try-lock-based solution with a single function containing both stages
> I still couldn't avoid having the serial8250_get_baud_rate() and
> serial8250_get_divisor() methods executed in the atomic context, which
> isn't required for them and which would needlessly pro-long the CPU
> executing with the IRQs disabled. As you well know it's better to
> speed up the atomic context execution as much as possible. 
> 
> Secondly I didn't know much about the tty/serial subsystem internals
> back then. So I was afraid to break some parts I didn't aware of if
> the baud-rate/ref-clock change code had some implicit dependencies
> from the surrounding code and vice-versa (like the LCR DLAB flag
> state).
> 
> Finally frankly it didn't seem like that much worth bothering about.
> Basically AFAICS there were only four methods which invocation I
> would have needed to move to a separate function:
> 
> serial8250_get_baud_rate();
> serial8250_get_divisor();
> // spin-lock
> uart_update_timeout(port, termios->c_cflag, baud);
> serial8250_set_divisor(port, baud, quot, frac);
> // spin-unlock
> 
> So I decided to take a simplest and safest path, and created a
> dedicated method for the just the ref-clock updates case leaving the
> baud-rate change task implemented in the framework of the standard
> serial8250_do_set_termios() method.
> 
> 
> Regarding doing vise-versa and calling the serial8250_do_set_termios()
> method from serial8250_update_uartclk() instead. To be honest I didn't
> consider that option. That might work though, but AFAICS the
> serial8250_do_set_termios() function will do much more than it's
> required in case if the ref-clock has changed.

My point here is that the idea behind clock change is most likely to be
followed up by ->set_termios(). Why to do it differently if it's the case?
And note, ->set_termios() can be called as many times as needed, so if nothing
changes in between it's also fine. But this makes intention much clearer.
Do you agree?

-- 
With Best Regards,
Andy Shevchenko



