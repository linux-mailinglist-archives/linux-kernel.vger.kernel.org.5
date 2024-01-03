Return-Path: <linux-kernel+bounces-15428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F075822BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5AE1F222BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C1218E2E;
	Wed,  3 Jan 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gxipcu4Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859618E0C;
	Wed,  3 Jan 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704280244; x=1735816244;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pj9WHV7vN3rtOcUAz5NT9Ykx5SZEIa8+tJWrnXtekEw=;
  b=Gxipcu4ZND5lpHo9PjBD8YP3JGo5llUsCEDgjNVhosWY109Z0nPldiHG
   olzH6dyQZc0/3n2bQ7RGff2nnS4vwp8LNTzFyE/Wn1z94U8CPTBE4j3Wu
   cfOtNJDDcmLwuipzAFX/x5i032DDr+POQfXBnxbpavd/We4dn0OLelsYh
   KRJ6M1GUQREMQIx56ujbXe3kLM8EEpDXNmiKxK/OUFIjdY47LVINTCKa4
   QJbfRMmWDDB5xvO4PZzo5/PiDnRKztABdH4UmaKyWZvJ1Lh9G5yLfhwty
   o9UduQovQxENUZjoy2lxLH4xdcE2E1IejaVEyMhgR0V0ICCkOP3SiUqQ9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="381959304"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="381959304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953202028"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953202028"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO myassin-mobl1.ger.corp.intel.com) ([10.251.211.32])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:10:39 -0800
Date: Wed, 3 Jan 2024 13:10:33 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, u.kleine-koenig@pengutronix.de, 
    shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com, 
    alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com, 
    hugo@hugovil.com, m.brock@vanmierlo.com, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, LinoSanfilippo@gmx.de, 
    Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v7 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
In-Reply-To: <20240103061818.564-2-l.sanfilippo@kunbus.com>
Message-ID: <485fbc21-d099-d316-2146-36fef116f894@linux.intel.com>
References: <20240103061818.564-1-l.sanfilippo@kunbus.com> <20240103061818.564-2-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Jan 2024, Lino Sanfilippo wrote:

> Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config().
> Since this function is called with the port lock held, this can be a
> problem in case that setting the GPIO line can sleep (e.g. if a GPIO
> expander is used which is connected via SPI or I2C).
> 
> Avoid this issue by moving the GPIO setting outside of the port lock into
> the serial core and thus making it a generic feature.
> 
> Also with commit c54d48543689 ("serial: stm32: Add support for rs485
> RX_DURING_TX output GPIO") the SER_RS485_RX_DURING_TX flag is only set if a
> rx-during-tx GPIO is _not_ available, which is wrong. Fix this, too.

This doesn't explain why it's wrong and I could figure it out myself 
either.

> Furthermore reset old GPIO settings in case that changing the RS485
> configuration failed.
> 
> Fixes: c54d48543689 ("serial: stm32: Add support for rs485 RX_DURING_TX output GPIO")
> Fixes: ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/imx.c         |  4 ----
>  drivers/tty/serial/serial_core.c | 26 ++++++++++++++++++++++++--
>  drivers/tty/serial/stm32-usart.c |  8 ++------
>  3 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 708b9852a575..9cffeb23112b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1943,10 +1943,6 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
>  	    rs485conf->flags & SER_RS485_RX_DURING_TX)
>  		imx_uart_start_rx(port);
>  
> -	if (port->rs485_rx_during_tx_gpio)
> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f1348a509552..d155131f221d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1402,6 +1402,16 @@ static void uart_set_rs485_termination(struct uart_port *port,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>  }
>  
> +static void uart_set_rs485_rx_during_tx(struct uart_port *port,
> +					const struct serial_rs485 *rs485)
> +{
> +	if (!(rs485->flags & SER_RS485_ENABLED))
> +		return;
> +
> +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
> +}
> +
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
> @@ -1413,12 +1423,17 @@ static int uart_rs485_config(struct uart_port *port)
>  
>  	uart_sanitize_serial_rs485(port, rs485);
>  	uart_set_rs485_termination(port, rs485);
> +	uart_set_rs485_rx_during_tx(port, rs485);
>  
>  	uart_port_lock_irqsave(port, &flags);
>  	ret = port->rs485_config(port, NULL, rs485);
>  	uart_port_unlock_irqrestore(port, flags);
> -	if (ret)
> +	if (ret) {
>  		memset(rs485, 0, sizeof(*rs485));
> +		/* unset GPIOs */
> +		gpiod_set_value_cansleep(port->rs485_term_gpio, 0);
> +		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);
> +	}
>  
>  	return ret;
>  }
> @@ -1457,6 +1472,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
>  	uart_set_rs485_termination(port, &rs485);
> +	uart_set_rs485_rx_during_tx(port, &rs485);
>  
>  	uart_port_lock_irqsave(port, &flags);
>  	ret = port->rs485_config(port, &tty->termios, &rs485);
> @@ -1468,8 +1484,14 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  			port->ops->set_mctrl(port, port->mctrl);
>  	}
>  	uart_port_unlock_irqrestore(port, flags);
> -	if (ret)
> +	if (ret) {
> +		/* restore old GPIO settings */
> +		gpiod_set_value_cansleep(port->rs485_term_gpio,
> +			!!(port->rs485.flags & SER_RS485_TERMINATE_BUS));
> +		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> +			!!(port->rs485.flags & SER_RS485_RX_DURING_TX));
>  		return ret;
> +	}
>  
>  	if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
>  		return -EFAULT;
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 3048620315d6..fc7fd40bca98 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -226,12 +226,6 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>  
>  	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>  
> -	if (port->rs485_rx_during_tx_gpio)
> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
> -	else
> -		rs485conf->flags |= SER_RS485_RX_DURING_TX;
> -
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>  		cr1 = readl_relaxed(port->membase + ofs->cr1);
>  		cr3 = readl_relaxed(port->membase + ofs->cr3);
> @@ -256,6 +250,8 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>  
>  		writel_relaxed(cr3, port->membase + ofs->cr3);
>  		writel_relaxed(cr1, port->membase + ofs->cr1);
> +
> +		rs485conf->flags |= SER_RS485_RX_DURING_TX;

Is it really intentional to force this on even if user requests it not to 
be enabled (and after GPIO set value code used the value user provided)?

Other than that, this change looks fine.

-- 
 i.


