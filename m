Return-Path: <linux-kernel+bounces-11037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8681E074
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022C51F22092
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED351C29;
	Mon, 25 Dec 2023 12:31:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250D1E481;
	Mon, 25 Dec 2023 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanmierlo.com
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
	(authenticated user m.brock@vanmierlo.com)
	by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
	Mon, 25 Dec 2023 13:31:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Dec 2023 13:31:16 +0100
From: Maarten Brock <m.brock@vanmierlo.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 hugo@hugovil.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de, lukas@wunner.de,
 p.rosenberger@kunbus.com, stable@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v6 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
In-Reply-To: <20231225113524.8800-2-l.sanfilippo@kunbus.com>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
 <20231225113524.8800-2-l.sanfilippo@kunbus.com>
Message-ID: <5177a7aef77a6b77a6e742a2fdd52a0e@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Lino Sanfilippo wrote on 2023-12-25 12:35:
> diff --git a/drivers/tty/serial/serial_core.c 
> b/drivers/tty/serial/serial_core.c
> index f1348a509552..d155131f221d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1402,6 +1402,16 @@ static void uart_set_rs485_termination(struct
> uart_port *port,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
>  }
> 
> +static void uart_set_rs485_rx_during_tx(struct uart_port *port,
> +					const struct serial_rs485 *rs485)
> +{
> +	if (!(rs485->flags & SER_RS485_ENABLED))
> +		return;
> +

How about checking port->rs485_rx_during_tx_gpio here against NULL 
instead of
before every call?

> +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
> +}
> +
>  static int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
> @@ -1413,12 +1423,17 @@ static int uart_rs485_config(struct uart_port 
> *port)
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
> @@ -1457,6 +1472,7 @@ static int uart_set_rs485_config(struct
> tty_struct *tty, struct uart_port *port,
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
>  	uart_set_rs485_termination(port, &rs485);
> +	uart_set_rs485_rx_during_tx(port, &rs485);
> 
>  	uart_port_lock_irqsave(port, &flags);
>  	ret = port->rs485_config(port, &tty->termios, &rs485);
> @@ -1468,8 +1484,14 @@ static int uart_set_rs485_config(struct
> tty_struct *tty, struct uart_port *port,
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

This does not look like restoring.
Further this looks suspiciously like duplicated code.

>  		return ret;
> +	}
> 
>  	if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
>  		return -EFAULT;
> diff --git a/drivers/tty/serial/stm32-usart.c 
> b/drivers/tty/serial/stm32-usart.c
> index 3048620315d6..ec9a72a5bea9 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -226,10 +226,7 @@ static int stm32_usart_config_rs485(struct
> uart_port *port, struct ktermios *ter
> 
>  	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
> 
> -	if (port->rs485_rx_during_tx_gpio)
> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
> -	else
> +	if (!port->rs485_rx_during_tx_gpio)

Should the ! be there?

>  		rs485conf->flags |= SER_RS485_RX_DURING_TX;
> 
>  	if (rs485conf->flags & SER_RS485_ENABLED) {

Kind Regards
Maarten Brock


