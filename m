Return-Path: <linux-kernel+bounces-122463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FBC88F7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C8629003D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895EE219EB;
	Thu, 28 Mar 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="APQaEMhI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228E3DABF3;
	Thu, 28 Mar 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607540; cv=none; b=Y8pWIRWG6Gi3e2IojGwL966ZgtdBC7BdBGpNXWeZijBe3PkdC0Pu5D/0bT2t9g8tIWe9XQGUrJk6aEaZR5lQkYyqG6hQCZ+5DOhJr8vXA6u1WPW6SgUvJlpfmuhH6Q8JAlhpDHxyQBsWUkoRL6lSCFrFHUrtDDJyTzlinJd0mL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607540; c=relaxed/simple;
	bh=OsUBSm2i90tYUGXnZ3vAuOySBFQ46NgGqeHUyIxU3nQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skADVyiJ0OTf4ffmRU3IFv3rZYNalAENMBQcZkydTXZP5wJXjQOXBv1YFZ6xOfKvK7eGWPgBNidXYgVaJG+4IyLM2PCmO9qFokG9i4cS759or+rMhPjNmfZACkE6D9vruY273H+qZIMiKuP0xOF62ZEY1GggBMGmNMi3GwxKpTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=APQaEMhI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S6Vsvt005438;
	Thu, 28 Mar 2024 01:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711607514;
	bh=Varq16AyuV7edMRW5MfI/bQ6PPPGyf6i7eSGtxy4ZrE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=APQaEMhIoLf4rMvSDeZRunKMvqhSfek4X1vgLnOpxQkxBX2w9f2twjYzCO5OIa3yr
	 h1IcKqzx1SGbb3PjQgybikYTrWn7O85/rXo04xl2+mVtpyO5Z9q4idMrXIEoiM+BLw
	 vvB1nKUReDDI91QtZjqRdVrZ+uo26kwOxFr/KGEI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S6VsZ4110661
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 01:31:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 01:31:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 01:31:53 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S6VqYf002366;
	Thu, 28 Mar 2024 01:31:53 -0500
Date: Thu, 28 Mar 2024 12:01:52 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Petr Mladek
	<pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness
	<john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?=
	<ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 4/7] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20240328063152.bjkdtdsu42cqbgf3@dhruva>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-5-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240327110021.59793-5-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 27, 2024 at 12:59:38 +0200, Tony Lindgren wrote:
> We can now add hardware based addressing for serial ports. Starting with
> commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> enable runtime PM"), and all the related fixes to this commit, the serial
> core now knows to which serial port controller the ports are connected.
> 
> The serial ports can be addressed with DEVNAME:0.0 style naming. The names
> are something like 00:04:0.0 for a serial port on qemu, and something like
> 2800000.serial:0.0 on platform device using systems like ARM64 for example.
> 
> The DEVNAME is the unique serial port hardware controller device name, AKA
> the name for port->dev. The 0.0 are the serial core controller id and port
> id.
> 
> Typically 0.0 are used for each controller and port instance unless the
> serial port hardware controller has multiple controllers or ports.
> 
> Using DEVNAME:0.0 style naming actually solves two long term issues for
> addressing the serial ports:
> 
> 1. According to Andy Shevchenko, using DEVNAME:0.0 style naming fixes an
>    issue where depending on the BIOS settings, the kernel serial port ttyS
>    instance number may change if HSUART is enabled
> 
> 2. Device tree using architectures no longer necessarily need to specify
>    aliases to find a specific serial port, and we can just allocate the

This is GOOD!

>    ttyS instance numbers dynamically in whatever probe order
> 
> To do this, let's match the hardware addressing style console name to
> the character device name used, and add a preferred console using the
> character device name.
> 
> Note that when using console=DEVNAME:0.0 style kernel command line, the
> 8250 serial console gets enabled later compared to using console=ttyS
> naming for ISA ports. This is because the serial port DEVNAME to character
> device mapping is not known until the serial driver probe time. If used
> together with earlycon, this issue is avoided.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/serial_base.h     | 16 +++++++
>  drivers/tty/serial/serial_base_bus.c | 66 ++++++++++++++++++++++++++++
>  drivers/tty/serial/serial_core.c     |  4 ++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
> --- a/drivers/tty/serial/serial_base.h
> +++ b/drivers/tty/serial/serial_base.h
> @@ -45,3 +45,19 @@ void serial_ctrl_unregister_port(struct uart_driver *drv, struct uart_port *port
>  
>  int serial_core_register_port(struct uart_driver *drv, struct uart_port *port);
>  void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port);
> +
> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +
> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port);
> +
> +#else
> +
> +static inline
> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port)
> +{
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -8,6 +8,7 @@
>   * The serial core bus manages the serial core controller instances.
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/container_of.h>
>  #include <linux/device.h>
>  #include <linux/idr.h>
> @@ -204,6 +205,71 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
>  	put_device(&port_dev->dev);
>  }
>  
> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +
> +static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
> +				       int port_id)
> +{
> +	int ret;
> +
> +	ret = add_preferred_console_match(match, dev_name, port_id);
> +	if (ret == -ENOENT)
> +		return 0;
> +
> +	return ret;

Can we do this instead?
return (ret == -ENOENT ? 0 : ret);

> +}
> +
> +static int serial_base_add_prefcon(const char *name, int idx)
> +{
> +	const char *char_match __free(kfree) = NULL;
> +
> +	/* Handle the traditional character device name style console=ttyS0 */
> +	char_match = kasprintf(GFP_KERNEL, "%s%i", name, idx);
> +	if (!char_match)
> +		return -ENOMEM;
> +
> +	return serial_base_add_one_prefcon(char_match, name, idx);
> +}
> +
> +/**
> + * serial_base_add_preferred_console - Adds a preferred console
> + * @drv: Serial port device driver
> + * @port: Serial port instance
> + *
> + * Tries to add a preferred console for a serial port if specified in the
> + * kernel command line. Supports both the traditional character device such
> + * as console=ttyS0, and a hardware addressing based console=DEVNAME:0.0
> + * style name.
> + *
> + * Translates the kernel command line option using a hardware based addressing
> + * console=DEVNAME:0.0 to the serial port character device such as ttyS0.
> + * Cannot be called early for ISA ports, depends on struct device.
> + *
> + * Note that duplicates are ignored by add_preferred_console().
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int serial_base_add_preferred_console(struct uart_driver *drv,
> +				      struct uart_port *port)
> +{
> +	const char *port_match __free(kfree) = NULL;
> +	int ret;
> +
> +	ret = serial_base_add_prefcon(drv->dev_name, port->line);
> +	if (ret)
> +		return ret;
> +
> +	port_match = kasprintf(GFP_KERNEL, "%s:%i.%i", dev_name(port->dev),
> +			       port->ctrl_id, port->port_id);
> +	if (!port_match)
> +		return -ENOMEM;
> +
> +	/* Translate a hardware addressing style console=DEVNAME:0.0 */
> +	return serial_base_add_one_prefcon(port_match, drv->dev_name, port->line);
> +}
> +
> +#endif
> +
>  static int serial_base_init(void)
>  {
>  	int ret;
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3407,6 +3407,10 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
>  	if (ret)
>  		goto err_unregister_ctrl_dev;
>  
> +	ret = serial_base_add_preferred_console(drv, port);
> +	if (ret)
> +		goto err_unregister_port_dev;
> +

Looks okay otherwise,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

