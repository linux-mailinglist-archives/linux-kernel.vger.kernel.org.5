Return-Path: <linux-kernel+bounces-89595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20686F273
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 21:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0481C20BCB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C540C09;
	Sat,  2 Mar 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UgMqkU+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5BD21100;
	Sat,  2 Mar 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709413136; cv=none; b=RL1W7TPOlvVdeq/i/17WErlKCUGdjYrqa7P5sYJAijEmhJH9+TOmh/pTseTTF/giw3AhOhcJ0py9e9CX17TpioPQNRImyyIG5EMRcZp8nBjXFA4yxmv6jvE97SpOe3cP6+uFGW3dLCRseH3QE/b/pQJkjIMChrGW+oluT3arx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709413136; c=relaxed/simple;
	bh=o+tr4CCbud8uzLtDh5MolTBCwG3kPTB0Bhx8jY/shKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbE6KLWzmiHcXOSerGOSKsJQHzyrjoW3R6CPXiEKodUUvA/lxDYe9Gw/I+j9+vGtSDe3PFNmQX0O+k7kFI3JZ68hz8/s8VQaxKBtPzF9vh3/KCpmmzaSfq266QlwWeD1TnMhM/vj6GJQpXNvwJ3S/4UOkeXs5/fP21XjQ21tHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UgMqkU+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485ABC433C7;
	Sat,  2 Mar 2024 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709413135;
	bh=o+tr4CCbud8uzLtDh5MolTBCwG3kPTB0Bhx8jY/shKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgMqkU+niNfrrsJKR325G2D+2tAy9twT34HdNKjDPPnzNigNMvu3vA2hb62A57nq0
	 PEMsKrj7r3EL2UOTajmaknqRQV/d2JCtFJ9pWYRVcF/57lRl/p8lzob7OmHi5mEfNC
	 4qrR2eTAghx7wO456Nvia8+/Eo8/UCKAhz4WW+Ok=
Date: Sat, 2 Mar 2024 21:58:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 03/14] serial: port: Introduce a common helper to read
 properties
Message-ID: <2024030259-playback-starlit-a472@gregkh>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226142514.1485246-4-andriy.shevchenko@linux.intel.com>

On Mon, Feb 26, 2024 at 04:19:19PM +0200, Andy Shevchenko wrote:
> Several serial drivers want to read the same or similar set of
> the port properties. Make a common helper for them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/serial_port.c | 134 +++++++++++++++++++++++++++++++
>  include/linux/serial_core.h      |   1 +
>  2 files changed, 135 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> index 88975a4df306..ecc980e9dba6 100644
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -8,7 +8,10 @@
>  
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/serial_core.h>
>  #include <linux/spinlock.h>
>  
> @@ -82,6 +85,137 @@ void uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
>  }
>  EXPORT_SYMBOL(uart_remove_one_port);
>  
> +/**
> + * uart_read_port_properties - read firmware properties of the given UART port

I like, but:

> + * @port: corresponding port
> + * @use_defaults: apply defaults (when %true) or validate the values (when %false)

Using random booleans in a function is horrid.  Every time you see the
function call, or want to call it, you need to go and look up what the
boolean is and means.

Make 2 public functions here, one that does it with use_defaults=true
and one =false and then have them both call this one static function,
that way the function names themselves are easy to read and understand
and maintain over time.

thanks,

greg k-h


> + *
> + * The following device properties are supported:
> + *   - clock-frequency (optional)
> + *   - fifo-size (optional)
> + *   - no-loopback-test (optional)
> + *   - reg-shift (defaults may apply)
> + *   - reg-offset (value may be validated)
> + *   - reg-io-width (defaults may apply or value may be validated)
> + *   - interrupts (OF only)
> + *   - serial [alias ID] (OF only)
> + *
> + * If the port->dev is of struct platform_device type the interrupt line
> + * will be retrieved via platform_get_irq() call against that device.
> + * Otherwise it will be assigned by fwnode_irq_get() call. In both cases
> + * the index 0 of the resource is used.
> + *
> + * The caller is responsible to initialize the following fields of the @port
> + *   ->dev (must be valid)
> + *   ->flags
> + *   ->mapbase
> + *   ->mapsize
> + *   ->regshift (if @use_defaults is false)
> + * before calling this function. Alternatively the above mentioned fields
> + * may be zeroed, in such case the only ones, that have associated properties
> + * found, will be set to the respective values.
> + *
> + * If no error happened, the ->irq, ->mapbase, ->mapsize will be altered.
> + * The ->iotype is always altered.
> + *
> + * When @use_defaults is true and the respective property is not found
> + * the following values will be applied:
> + *   ->regshift = 0
> + * In this case IRQ must be provided, otherwise an error will be returned.
> + *
> + * When @use_defaults is false and the respective property is found
> + * the following values will be validated:
> + *   - reg-io-width (->iotype)
> + *   - reg-offset (->mapsize against ->mapbase)
> + *
> + * Returns: 0 on success or negative errno on failure
> + */
> +int uart_read_port_properties(struct uart_port *port, bool use_defaults)
> +{
> +	struct device *dev = port->dev;
> +	u32 value;
> +	int ret;
> +
> +	/* Read optional UART functional clock frequency */
> +	device_property_read_u32(dev, "clock-frequency", &port->uartclk);
> +
> +	/* Read the registers alignment (default: 8-bit) */
> +	ret = device_property_read_u32(dev, "reg-shift", &value);
> +	if (ret)
> +		port->regshift = use_defaults ? 0 : port->regshift;
> +	else
> +		port->regshift = value;
> +
> +	/* Read the registers I/O access type (default: MMIO 8-bit) */
> +	ret = device_property_read_u32(dev, "reg-io-width", &value);
> +	if (ret) {
> +		port->iotype = UPIO_MEM;
> +	} else {
> +		switch (value) {
> +		case 1:
> +			port->iotype = UPIO_MEM;
> +			break;
> +		case 2:
> +			port->iotype = UPIO_MEM16;
> +			break;
> +		case 4:
> +			port->iotype = device_is_big_endian(dev) ? UPIO_MEM32BE : UPIO_MEM32;
> +			break;
> +		default:
> +			if (!use_defaults) {
> +				dev_err(dev, "Unsupported reg-io-width (%u)\n", value);
> +				return -EINVAL;
> +			}
> +			port->iotype = UPIO_UNKNOWN;
> +			break;
> +		}
> +	}
> +
> +	/* Read the address mapping base offset (default: no offset) */
> +	ret = device_property_read_u32(dev, "reg-offset", &value);
> +	if (ret)
> +		value = 0;
> +
> +	/* Check for shifted address mapping overflow */
> +	if (!use_defaults && port->mapsize < value) {
> +		dev_err(dev, "reg-offset %u exceeds region size %pa\n", value, &port->mapsize);
> +		return -EINVAL;
> +	}
> +
> +	port->mapbase += value;
> +	port->mapsize -= value;
> +
> +	/* Read optional FIFO size */
> +	device_property_read_u32(dev, "fifo-size", &port->fifosize);
> +
> +	if (device_property_read_bool(dev, "no-loopback-test"))
> +		port->flags |= UPF_SKIP_TEST;
> +
> +	/* Get index of serial line, if found in DT aliases */
> +	ret = of_alias_get_id(dev_of_node(dev), "serial");
> +	if (ret >= 0)
> +		port->line = ret;
> +
> +	if (dev_is_platform(dev))
> +		ret = platform_get_irq(to_platform_device(dev), 0);
> +	else
> +		ret = fwnode_irq_get(dev_fwnode(dev), 0);
> +	if (ret == -EPROBE_DEFER)
> +		return ret;
> +	if (ret > 0)
> +		port->irq = ret;
> +	else if (use_defaults)
> +		/* By default IRQ support is mandatory */
> +		return ret;
> +	else
> +		port->irq = 0;
> +
> +	port->flags |= UPF_SHARE_IRQ;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(uart_read_port_properties);

EXPORT_SYMBOL_GPL()?  I have to ask :)

thanks,

greg k-h

