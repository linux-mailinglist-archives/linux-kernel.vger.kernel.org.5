Return-Path: <linux-kernel+bounces-155676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9938AF57F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A19CB22598
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA513DDA6;
	Tue, 23 Apr 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="oCtLD2ur"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA5208A9;
	Tue, 23 Apr 2024 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893309; cv=none; b=ObXJPVVYpsBvHtlEKjnSfr8iYsxSQv6N9G0g56JDKpv3fjJFjzRrSG8hJGDcBn9czbpJfgBkzx2npRrbdy6NKeV8P2Vf1CkSVZrX4isThDEzNI1esnYknMbvlcwinQMeuYnzNxb+OdxYi6wn4CX2WIQF0wznWBrXk55+kwr3ggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893309; c=relaxed/simple;
	bh=4a9Q/2jICpSrOf9hG5+Cy1JYXTOR5/P5A1ZegvcjXTM=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=l/qjqiUaelB/MDUnfZprDz6NkGbd64i1/tRce2SE1xqIHE/A8yIgop01m1Fd5lxdZ5o0Zs9IX7zfs7SpB2seA1tkDa7l/BmBICac745KGlsCAvo8q7/gqOsnCErMrS9HM0OhBrCwR9/vkJY1W/gJuT+DflmlTQJ5Tqk4T7fP/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=oCtLD2ur; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=ZVLtan6rCyFQnPj29Gc+EyD+F7wqAiDd7n4A/kz1w0E=; b=oCtLD2uriSwNaCH+c0ML0vLof2
	oGkuxmcgmVuBX5clGj0uk2fdovevP1VshQCQj5p/Gp/2ut9Plr8RKBOn/C+BhOz6mjKmagTvcRxiI
	rfRJb3Pbk2O2U1e5aleRQfUVwunkqyTt8SouKddYFIHh0vxAYWT+zZFn31QaWpAURSKA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45948 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rzJw6-0007tt-7g; Tue, 23 Apr 2024 13:28:06 -0400
Date: Tue, 23 Apr 2024 13:28:05 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Konstantin Pugin <ria.freelander@gmail.com>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
 robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
 manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
 u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Anup Patel
 <apatel@ventanamicro.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Lech Perczak
 <lech.perczak@camlingroup.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20240423132805.aad4ee158df616b5626c1718@hugovil.com>
In-Reply-To: <20240422133219.2710061-4-ria.freelander@gmail.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
	<20240422133219.2710061-4-ria.freelander@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v7 3/3] serial: sc16is7xx: add support for EXAR
 XR20M1172 UART
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 22 Apr 2024 16:32:15 +0300
Konstantin Pugin <ria.freelander@gmail.com> wrote:

Hi Konstantin,

> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.
> So, add handling this register by appropriate devicetree bindings.
> 
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>  drivers/tty/serial/Kconfig         |  3 +-
>  drivers/tty/serial/sc16is7xx.c     | 61 ++++++++++++++++++++++++++++--
>  drivers/tty/serial/sc16is7xx.h     |  1 +
>  drivers/tty/serial/sc16is7xx_i2c.c |  1 +
>  drivers/tty/serial/sc16is7xx_spi.c |  1 +
>  5 files changed, 62 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4fdd7857ef4d..9d0438cfe147 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1029,7 +1029,7 @@ config SERIAL_SC16IS7XX_CORE
>  	select SERIAL_SC16IS7XX_SPI if SPI_MASTER
>  	select SERIAL_SC16IS7XX_I2C if I2C
>  	help
> -	  Core driver for NXP SC16IS7xx UARTs.
> +	  Core driver for NXP SC16IS7xx and compatible UARTs.
>  	  Supported ICs are:
>  
>  	    SC16IS740
> @@ -1038,6 +1038,7 @@ config SERIAL_SC16IS7XX_CORE
>  	    SC16IS752
>  	    SC16IS760
>  	    SC16IS762
> +	    XR20M1172 (Exar)
>  
>  	  The driver supports both I2C and SPI interfaces.
>  
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index dfcc804f558f..09c9e52d7ec2 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -10,6 +10,7 @@
>  #undef DEFAULT_SYMBOL_NAMESPACE
>  #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> @@ -68,6 +69,7 @@
>  /* Special Register set: Only if ((LCR[7] == 1) && (LCR != 0xBF)) */
>  #define SC16IS7XX_DLL_REG		(0x00) /* Divisor Latch Low */
>  #define SC16IS7XX_DLH_REG		(0x01) /* Divisor Latch High */
> +#define XR20M117X_DLD_REG		(0x02) /* Divisor Fractional Register */
>  
>  /* Enhanced Register set: Only if (LCR == 0xBF) */
>  #define SC16IS7XX_EFR_REG		(0x02) /* Enhanced Features */
> @@ -221,6 +223,20 @@
>  #define SC16IS7XX_TCR_RX_HALT(words)	((((words) / 4) & 0x0f) << 0)
>  #define SC16IS7XX_TCR_RX_RESUME(words)	((((words) / 4) & 0x0f) << 4)
>  
> +/*
> + * Divisor Fractional Register bits (EXAR extension).
> + * EXAR hardware is mostly compatible with SC16IS7XX, but supports additional feature:
> + * 4x and 8x divisor, instead of default 16x. It has a special register to program it.
> + * Bits 0 to 3 is fractional divisor, it used to set value of last 16 bits of
> + * uartclk * (16 / divisor) / baud, in case of default it will be uartclk / baud.
> + * Bits 4 and 5 used as switches, and should not be set to 1 simultaneously.
> + */
> +
> +#define XR20M117X_DLD_16X			0
> +#define XR20M117X_DLD_DIV_MASK			GENMASK(3, 0)
> +#define XR20M117X_DLD_8X			BIT(4)
> +#define XR20M117X_DLD_4X			BIT(5)
> +
>  /*
>   * TLR register bits
>   * If TLR[3:0] or TLR[7:4] are logical 0, the selectable trigger levels via the
> @@ -523,6 +539,13 @@ const struct sc16is7xx_devtype sc16is762_devtype = {
>  };
>  EXPORT_SYMBOL_GPL(sc16is762_devtype);
>  
> +const struct sc16is7xx_devtype xr20m1172_devtype = {
> +	.name		= "XR20M1172",
> +	.nr_gpio	= 8,
> +	.nr_uart	= 2,
> +};
> +EXPORT_SYMBOL_GPL(xr20m1172_devtype);
> +
>  static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
>  	return reg == SC16IS7XX_RHR_REG;
>  }
>  
> +static bool sc16is7xx_has_dld(struct device *dev)
> +{
> +	struct sc16is7xx_port *s = dev_get_drvdata(dev);
> +
> +	if (s->devtype == &xr20m1172_devtype)
> +		return true;
> +	return false;
> +}
> +
>  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>  {
>  	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> -	u8 lcr;
> +	unsigned long clk = port->uartclk, div, div16;
> +	bool has_dld = sc16is7xx_has_dld(port->dev);
> +	u8 dld_mode = XR20M117X_DLD_16X;
>  	u8 prescaler = 0;
> -	unsigned long clk = port->uartclk, div = clk / 16 / baud;
> +	u8 divisor = 16;
> +	u8 lcr;
> +
> +	if (has_dld && DIV_ROUND_CLOSEST(clk, baud) < 16)
> +		divisor = rounddown_pow_of_two(DIV_ROUND_CLOSEST(clk, baud));
> +
> +	div16 = (clk * 16) / divisor / baud;
> +	div = div16 / 16;
>  
>  	if (div >= BIT(16)) {
>  		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
>  		div /= 4;
>  	}
>  
> +	/* Count additional divisor for EXAR devices */
> +	if (divisor == 8)
> +		dld_mode = XR20M117X_DLD_8X;
> +	if (divisor == 4)
> +		dld_mode = XR20M117X_DLD_4X;
> +	dld_mode |= FIELD_PREP(XR20M117X_DLD_DIV_MASK, div16);
> +
>  	/* Enable enhanced features */
>  	sc16is7xx_efr_lock(port);
>  	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
> @@ -587,12 +635,14 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>  	regcache_cache_bypass(one->regmap, true);
>  	sc16is7xx_port_write(port, SC16IS7XX_DLH_REG, div / 256);
>  	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
> +	if (has_dld)
> +		sc16is7xx_port_write(port, XR20M117X_DLD_REG, dld_mode);
>  	regcache_cache_bypass(one->regmap, false);
>  
>  	/* Restore LCR and access to general register set */
>  	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
>  
> -	return DIV_ROUND_CLOSEST(clk / 16, div);
> +	return DIV_ROUND_CLOSEST(clk / divisor, div);
>  }
>  
>  static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
> @@ -1002,6 +1052,8 @@ static void sc16is7xx_set_termios(struct uart_port *port,
>  				  const struct ktermios *old)
>  {
>  	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
> +	bool has_dld = sc16is7xx_has_dld(port->dev);
> +	u8 divisor = has_dld ? 4 : 16

You are missing a semicolumn here, and compilation aborts. Looks like
you didn't test.

Hugo.


>  	unsigned int lcr, flow = 0;
>  	int baud;
>  	unsigned long flags;
> @@ -1084,7 +1136,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
>  	/* Get baud rate generator configuration */
>  	baud = uart_get_baud_rate(port, termios, old,
>  				  port->uartclk / 16 / 4 / 0xffff,
> -				  port->uartclk / 16);
> +				  port->uartclk / divisor);
>  
>  	/* Setup baudrate generator */
>  	baud = sc16is7xx_set_baud(port, baud);
> @@ -1684,6 +1736,7 @@ void sc16is7xx_remove(struct device *dev)
>  EXPORT_SYMBOL_GPL(sc16is7xx_remove);
>  
>  const struct of_device_id __maybe_unused sc16is7xx_dt_ids[] = {
> +	{ .compatible = "exar,xr20m1172",	.data = &xr20m1172_devtype, },
>  	{ .compatible = "nxp,sc16is740",	.data = &sc16is74x_devtype, },
>  	{ .compatible = "nxp,sc16is741",	.data = &sc16is74x_devtype, },
>  	{ .compatible = "nxp,sc16is750",	.data = &sc16is750_devtype, },
> diff --git a/drivers/tty/serial/sc16is7xx.h b/drivers/tty/serial/sc16is7xx.h
> index afb784eaee45..eb2e3bc86f15 100644
> --- a/drivers/tty/serial/sc16is7xx.h
> +++ b/drivers/tty/serial/sc16is7xx.h
> @@ -28,6 +28,7 @@ extern const struct sc16is7xx_devtype sc16is750_devtype;
>  extern const struct sc16is7xx_devtype sc16is752_devtype;
>  extern const struct sc16is7xx_devtype sc16is760_devtype;
>  extern const struct sc16is7xx_devtype sc16is762_devtype;
> +extern const struct sc16is7xx_devtype xr20m1172_devtype;
>  
>  const char *sc16is7xx_regmap_name(u8 port_id);
>  
> diff --git a/drivers/tty/serial/sc16is7xx_i2c.c b/drivers/tty/serial/sc16is7xx_i2c.c
> index 3ed47c306d85..839de902821b 100644
> --- a/drivers/tty/serial/sc16is7xx_i2c.c
> +++ b/drivers/tty/serial/sc16is7xx_i2c.c
> @@ -46,6 +46,7 @@ static const struct i2c_device_id sc16is7xx_i2c_id_table[] = {
>  	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
>  	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
>  	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
> +	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, sc16is7xx_i2c_id_table);
> diff --git a/drivers/tty/serial/sc16is7xx_spi.c b/drivers/tty/serial/sc16is7xx_spi.c
> index 73df36f8a7fd..2b278282dbd0 100644
> --- a/drivers/tty/serial/sc16is7xx_spi.c
> +++ b/drivers/tty/serial/sc16is7xx_spi.c
> @@ -69,6 +69,7 @@ static const struct spi_device_id sc16is7xx_spi_id_table[] = {
>  	{ "sc16is752",	(kernel_ulong_t)&sc16is752_devtype, },
>  	{ "sc16is760",	(kernel_ulong_t)&sc16is760_devtype, },
>  	{ "sc16is762",	(kernel_ulong_t)&sc16is762_devtype, },
> +	{ "xr20m1172",	(kernel_ulong_t)&xr20m1172_devtype, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
> -- 
> 2.34.1
> 
> 
> 


-- 
Hugo Villeneuve

