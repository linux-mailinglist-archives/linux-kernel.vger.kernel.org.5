Return-Path: <linux-kernel+bounces-24492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0682BD60
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A51C25447
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A556B9D;
	Fri, 12 Jan 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WlVKOnSW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27776168B5;
	Fri, 12 Jan 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705052414; x=1736588414;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mYZ8szFmxn+ynEuSW/tRuoGiph0TTNr3kjNUdauc12s=;
  b=WlVKOnSWgY91qw3lIjkeAPJe9c9gnGP9HkRkM6bhU1FqVQ01fvLT0uOA
   pfnXSEj7rvF/p4MNpfaqoidCyLsmcuOH4b8s0v9TjKtCuyxl3pK/lIHYx
   cwwUkuBnTrseJgQokEeo+mtkXvJ73x5Ol6MU7ls7rCXLr+DeZT5G2SfRV
   FsqylqPgXjnRx1cQknHk0AJ5sZDluC74KZMDIBp/2noc/BXFKiHJDQh/H
   GZ4XGfo80EiOaigNDAVVg/fQ0bbxPtChLk7tKjtFU/BkxwU4hsrYZXZDD
   5oHf1lBEk+WiWRbpCtR/f0zW+JC2chfUy537R6Anobcn9sNcb4jpV7RG1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6493353"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6493353"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 01:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="786283497"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="786283497"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.141])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 01:40:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Jan 2024 11:40:04 +0200 (EET)
To: John Ogness <john.ogness@linutronix.de>
cc: Gui-Dong Han <2045gemini@gmail.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Tony Lindgren <tony@atomide.com>, 
    l.sanfilippo@kunbus.com, tglx@linutronix.de, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, baijiaju1990@outlook.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix atomicity violation in uart_tiocmget
In-Reply-To: <87msta7vbe.fsf@jogness.linutronix.de>
Message-ID: <4a52df23-71c3-59c7-fee4-e7cde526d249@linux.intel.com>
References: <20240112075732.16730-1-2045gemini@gmail.com> <87msta7vbe.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jan 2024, John Ogness wrote:

> On 2024-01-12, Gui-Dong Han <2045gemini@gmail.com> wrote:
> > In uart_tiocmget():
> >     result = uport->mctrl;
> >     uart_port_lock_irq(uport);
> >     result |= uport->ops->get_mctrl(uport);
> >     uart_port_unlock_irq(uport);
> >     ...
> >     return result;
> >
> > In uart_update_mctrl():
> >     uart_port_lock_irqsave(port, &flags);
> >     ...
> >     port->mctrl = (old & ~clear) | set;
> >     ...
> >     uart_port_unlock_irqrestore(port, flags);
> >
> > An atomicity violation is identified due to the concurrent execution of
> > uart_tiocmget() and uart_update_mctrl(). After assigning
> > result = uport->mctrl, the mctrl value may change in uart_update_mctrl(),
> > leading to a mismatch between the value returned by
> > uport->ops->get_mctrl(uport) and the mctrl value previously read.
> > This can result in uart_tiocmget() returning an incorrect value.
> >
> > This possible bug is found by an experimental static analysis tool
> > developed by our team, BassCheck[1]. This tool analyzes the locking APIs
> > to extract function pairs that can be concurrently executed, and then
> > analyzes the instructions in the paired functions to identify possible
> > concurrency bugs including data races and atomicity violations. The above
> > possible bug is reported when our tool analyzes the source code of
> > Linux 5.17.
> >
> > To address this issue, it is suggested to move the line
> > result = uport->mctrl inside the uart_port_lock block to ensure atomicity
> > and prevent the mctrl value from being altered during the execution of
> > uart_tiocmget(). With this patch applied, our tool no longer reports the
> > bug, with the kernel configuration allyesconfig for x86_64. Due to the
> > absence of the requisite hardware, we are unable to conduct runtime
> > testing of the patch. Therefore, our verification is solely based on code
> > logic analysis.
> >
> > [1] https://sites.google.com/view/basscheck/
> >
> > Fixes: 559c7ff4e324 ("serial: core: Use port lock wrappers")
> 
> It fixes c5f4644e6c8b ("[PATCH] Serial: Adjust serial locking").

That commit only extracted the locks from ->get_mctrl() into the caller
but this assignment was outside both pre and post that commit (the issue 
goes all the way back into history.git domain into 33c0d1b0c3eb ("[PATCH] 
Serial driver stuff") which introduced ->mctrl).

-- 
 i.

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 80085b151b34..a9e39416d877 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1085,8 +1085,8 @@ static int uart_tiocmget(struct tty_struct *tty)
> >  		goto out;
> >  
> >  	if (!tty_io_error(tty)) {
> > -		result = uport->mctrl;
> >  		uart_port_lock_irq(uport);
> > +		result = uport->mctrl;
> >  		result |= uport->ops->get_mctrl(uport);
> >  		uart_port_unlock_irq(uport);
> >  	}
> 
> Looking over the RMW accesses to @mctrl, I expect you will also need
> this hunk:
> 
> @@ -2242,6 +2242,7 @@ uart_set_options(struct uart_port *port, struct console *co,
>  {
>  	struct ktermios termios;
>  	static struct ktermios dummy;
> +	unsigned long flags;
>  
>  	/*
>  	 * Ensure that the serial-console lock is initialised early.
> @@ -2279,7 +2280,9 @@ uart_set_options(struct uart_port *port, struct console *co,
>  	 * some uarts on other side don't support no flow control.
>  	 * So we set * DTR in host uart to make them happy
>  	 */
> +	uart_port_lock_irqsave(port, &flags);
>  	port->mctrl |= TIOCM_DTR;
> +	uart_port_unlock_irqrestore(port, flags);
>  
>  	port->ops->set_termios(port, &termios, &dummy);
>  	/*
> 
> FWIW,
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 

