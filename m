Return-Path: <linux-kernel+bounces-122495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D805A88F882
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A6C1F24E09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F050279;
	Thu, 28 Mar 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gyEAHABQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25606849C;
	Thu, 28 Mar 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610550; cv=none; b=Esm4oQ6bxDjQAo/AwghyDz7QpVAFPxw15AtDAwCxKxd12MsboUgCUcW8BOfgyIFDDMlG56sjTaYuLyZ5mRPjpDf2Odrrjb3pm3scg9eVdJpqGtcCle3gu0wdk7mI1Vr7J+k4gRkeYS32ebtT+LJMudTPmYkJ5mJe0EgC44MS5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610550; c=relaxed/simple;
	bh=hiuS5t2lQWNJFOtvJipQHkQ+4rNrV1yVGvL5Ol0zhKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpak4TIKK3Bo5YFZYom7TjepyAnt0dCeEB3CbgkytOWkbgpjukuWfSwASxGb2AR+SalpPWRMAy/c9Rf1AvMIQIWoW95kVBkRnh142LUEHSpfgcYp1poQSB8AIEObeSIUNhEbSL7vVk4LpXGiDge/qnBqWmvR5P5OR7Tz3tDB43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gyEAHABQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08251C433C7;
	Thu, 28 Mar 2024 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711610549;
	bh=hiuS5t2lQWNJFOtvJipQHkQ+4rNrV1yVGvL5Ol0zhKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyEAHABQAOXEaDE2eUHd+AvzyH/aWOHeeO+fh5qBiDREXjVngZB5Adj0TtNccYEM7
	 KHjq51WVF199wxpVIpQMwmGmLfW3bNGFRXx05M5FIeYdh/7qkyxd7dBQk4Kg3YKTZA
	 hDp/xaz5XlV1gcGT7c3uUo/pN46cC+jlohAHmAxc=
Date: Thu, 28 Mar 2024 08:22:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 4/7] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <2024032859-subscript-marshy-7508@gregkh>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-5-tony@atomide.com>
 <20240328063152.bjkdtdsu42cqbgf3@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328063152.bjkdtdsu42cqbgf3@dhruva>

On Thu, Mar 28, 2024 at 12:01:52PM +0530, Dhruva Gole wrote:
> Hi,
> 
> On Mar 27, 2024 at 12:59:38 +0200, Tony Lindgren wrote:
> > We can now add hardware based addressing for serial ports. Starting with
> > commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> > enable runtime PM"), and all the related fixes to this commit, the serial
> > core now knows to which serial port controller the ports are connected.
> > 
> > The serial ports can be addressed with DEVNAME:0.0 style naming. The names
> > are something like 00:04:0.0 for a serial port on qemu, and something like
> > 2800000.serial:0.0 on platform device using systems like ARM64 for example.
> > 
> > The DEVNAME is the unique serial port hardware controller device name, AKA
> > the name for port->dev. The 0.0 are the serial core controller id and port
> > id.
> > 
> > Typically 0.0 are used for each controller and port instance unless the
> > serial port hardware controller has multiple controllers or ports.
> > 
> > Using DEVNAME:0.0 style naming actually solves two long term issues for
> > addressing the serial ports:
> > 
> > 1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
> >    issue where depending on the BIOS settings, the kernel serial port ttyS
> >    instance number may change if HSUART is enabled
> > 
> > 2. Device tree using architectures no longer necessarily need to specify
> >    aliases to find a specific serial port, and we can just allocate the
> 
> This is GOOD!
> 
> >    ttyS instance numbers dynamically in whatever probe order
> > 
> > To do this, let's match the hardware addressing style console name to
> > the character device name used, and add a preferred console using the
> > character device name.
> > 
> > Note that when using console=DEVNAME:0.0 style kernel command line, the
> > 8250 serial console gets enabled later compared to using console=ttyS
> > naming for ISA ports. This is because the serial port DEVNAME to character
> > device mapping is not known until the serial driver probe time. If used
> > together with earlycon, this issue is avoided.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/tty/serial/serial_base.h     | 16 +++++++
> >  drivers/tty/serial/serial_base_bus.c | 66 ++++++++++++++++++++++++++++
> >  drivers/tty/serial/serial_core.c     |  4 ++
> >  3 files changed, 86 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> > --- a/drivers/tty/serial/serial_base.h
> > +++ b/drivers/tty/serial/serial_base.h
> > @@ -45,3 +45,19 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
> >  
> >  int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
> >  void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
> > +
> > +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> > +
> > +int serial_base_add_preferred_console(struct uart_driver *drv,
> > +				      struct uart_port *port);
> > +
> > +#else
> > +
> > +static inline
> > +int serial_base_add_preferred_console(struct uart_driver *drv,
> > +				      struct uart_port *port)
> > +{
> > +	return 0;
> > +}
> > +
> > +#endif
> > diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> > --- a/drivers/tty/serial/serial_base_bus.c
> > +++ b/drivers/tty/serial/serial_base_bus.c
> > @@ -8,6 +8,7 @@
> >   * The serial core bus manages the serial core controller instances.
> >   */
> >  
> > +#include <linux/cleanup.h>
> >  #include <linux/container_of.h>
> >  #include <linux/device.h>
> >  #include <linux/idr.h>
> > @@ -204,6 +205,71 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
> >  	put_device(&port_dev->dev);
> >  }
> >  
> > +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> > +
> > +static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
> > +				       int port_id)
> > +{
> > +	int ret;
> > +
> > +	ret = add_preferred_console_match(match, dev_name, port_id);
> > +	if (ret == -ENOENT)
> > +		return 0;
> > +
> > +	return ret;
> 
> Can we do this instead?
> return (ret == -ENOENT ? 0 : ret);

No, please no.

Just spell it out, like was done here, dealing with ? : is a pain to
read and follow and the generated code should be identical.

Only use ? : in places where it's the only way to do it (i.e. as
function parameters or in printk-like lines.)

Write for people first, compilers second.

thanks,

greg k-h

