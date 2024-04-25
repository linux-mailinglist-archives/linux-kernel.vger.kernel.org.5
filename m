Return-Path: <linux-kernel+bounces-158801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D68B2512
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C892832D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B8214AD36;
	Thu, 25 Apr 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="NXXWc0fc"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18F149E0A;
	Thu, 25 Apr 2024 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058803; cv=none; b=iBptSMK0LIzxTb6d6jK9QljVXkZ3nihc/VsYc4pRlX9LFNSpURV2jfJ/JeImQdacuepLcelABKx7/6FnmUJG37/1sYHu9WViGjddrrHIBpPjiZREirH9ud2yj7OyYJ1nrLCivqlXbD0VIt/XDOuOGH23o8inr7WuuUt1E3dZoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058803; c=relaxed/simple;
	bh=KW0Nkti79XbKCumQk4b9EtfcbKYjbSCL9yD0xbL3PJY=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=uWe++ZndIPv+4mTgMbykppQvJQAiuEDMHJfNqKnhdgR8oNseYh/DW35fU8m1cGkNXFuiy+BnUDJQEpTSUG8NM1r/1sKYXy9Tvqr+AJEpNoioIcongtJjlqVUzPuZZIbJUyQpQ2Q6tmPNO/5EGhrNAD554Y0NCfgxdAc8gSMvvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=NXXWc0fc; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=2pZRkuVDIwUEfDKVZREz6rLgGL1jQIqIXjSG7zaftQk=; b=NXXWc0fcXcJd6xK3EPs4GcCmUU
	RZmbmgmWM5Uh0hz2/SdKzgjCLXDm1YXHkmWg84PFX+M0kM3MKbGfBG70vOMXudAyVZ6OSvgk+Fnv8
	9m6vLLH+bgDsDwsfkR5D6zSkcn6U/aLCE9sm0/hdXzY1fYGdN8ZfN/03c6g0NYikpssw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:36886 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1s00z5-0003UQ-NR; Thu, 25 Apr 2024 11:26:07 -0400
Date: Thu, 25 Apr 2024 11:26:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Konstantin Pugin <rilian.la.te@ya.ru>
Cc: krzk@kernel.org, conor@kernel.org, lkp@intel.com, vz@mleia.com,
 robh@kernel.org, jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
 manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
 u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, Konstantin Pugin
 <ria.freelander@gmail.com>, Andy Shevchenko <andy@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Herve Codina
 <herve.codina@bootlin.com>, Andrew Jones <ajones@ventanamicro.com>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak
 <lech.perczak@camlingroup.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20240425112602.57610aad643525a0e9973ff6@hugovil.com>
In-Reply-To: <20240424191908.32565-4-rilian.la.te@ya.ru>
References: <20240424191908.32565-1-rilian.la.te@ya.ru>
	<20240424191908.32565-4-rilian.la.te@ya.ru>
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
	* -2.7 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v8 3/3] serial: sc16is7xx: add support for EXAR
 XR20M1172 UART
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 24 Apr 2024 22:18:54 +0300
Konstantin Pugin <rilian.la.te@ya.ru> wrote:

Hi Konstantin,

> From: Konstantin Pugin <ria.freelander@gmail.com>
> 
> XR20M1172 register set is mostly compatible with SC16IS762, but it has
> a support for additional division rates of UART with special DLD register.

-> "... but it supports additional division rates with special..."

> So, add handling this register by appropriate devicetree bindings.

I am not sure about this, support for DLD is added in the driver,
not in device tree. You can probably drop that sentence?

> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
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

Remove "Register".

Also, DLD register needs EFR[4] = 1 to be accessed, so maybe add this
to the comment:

/* Divisor Fractional (requires EFR[4] = 1) */


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

This still breaks compilation. I noted in V7 of the patch to fix this,
but obviously you didn't do it, altough you mention that you would do
it in your reply to me, and you also mention doing it in your cover
letter...

This means you didn't test your patchset V8 before sending it. You
really need to properly test _before_ sending a new patchset.


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
> 2.44.0
> 
> 
> 


-- 
Hugo Villeneuve

