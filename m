Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6B7C6065
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjJKWhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjJKWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:37:20 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2560C6;
        Wed, 11 Oct 2023 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=AYz1EPrm1Fqih3X2Rnu7bOSa8uMT4hUtRWPajXMNV2A=; b=W83zvwiucyvyA08VAiLSuRRMWG
        kMcp8kjSKqz/q615DYRkbMrE3FAJCN8n1L1t/HyM1pn5dxjbZryzY7oe+aygqciPnYqmh9IYbEu5M
        KAMZDMkiG5WhVd0d5kOfC4665c0Ph9Dt40H7KYJSPu4trtquXfVlEe0Gp+yhkaTe3D0w=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37416 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qqhp3-0007ag-1r; Wed, 11 Oct 2023 18:36:57 -0400
Date:   Wed, 11 Oct 2023 18:36:56 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
Message-Id: <20231011183656.5111ba32ec0c9d43171662a1@hugovil.com>
In-Reply-To: <20231011181544.7893-2-l.sanfilippo@kunbus.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
        <20231011181544.7893-2-l.sanfilippo@kunbus.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 1/6] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 20:15:39 +0200
Lino Sanfilippo <l.sanfilippo@kunbus.com> wrote:

> Both the imx and stm32 driver set the rx-during-tx GPIO in the
> rs485_config() function by means of gpiod_set_value(). Since rs485_config()
> is called with the port lock held, this can be an problem in case that
> setting the GPIO line can sleep (e.g. if a GPIO expander is used which is
> connected via SPI or I2C).
> 
> Avoid this issue by setting the GPIO outside of the port lock in the serial
> core and by using gpiod_set_value_cansleep() instead of gpiod_set_value().

Hi Lino,
it seems to me that both drivers were already using
gpiod_set_value_cansleep()? Maybe update your commit
message if this is the case.

> 
> Since now both the term and the rx-during-tx GPIO are set within the serial
> core use a common function uart_set_rs485_gpios() to set both.
> 
> With moving it into the serial core setting the rx-during-tx GPIO is now
> automatically done for all drivers that support such a GPIO.
> 
> Fixes: c54d48543689 ("serial: stm32: Add support for rs485 RX_DURING_TX output GPIO")
> Fixes: ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/imx.c         |  4 ----
>  drivers/tty/serial/serial_core.c | 10 ++++++----
>  drivers/tty/serial/stm32-usart.c |  5 +----
>  3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 13cb78340709..edb2ec6a5567 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1947,10 +1947,6 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
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
> index 7bdc21d5e13b..ef0500be3553 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1391,14 +1391,16 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>  	memset(rs485->padding1, 0, sizeof(rs485->padding1));
>  }
>  
> -static void uart_set_rs485_termination(struct uart_port *port,
> -				       const struct serial_rs485 *rs485)
> +static void uart_set_rs485_gpios(struct uart_port *port,
> +				 const struct serial_rs485 *rs485)
>  {
>  	if (!(rs485->flags & SER_RS485_ENABLED))
>  		return;
>  
>  	gpiod_set_value_cansleep(port->rs485_term_gpio,
>  				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
> +	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> +				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
>  }
>  
>  static int uart_rs485_config(struct uart_port *port)
> @@ -1407,7 +1409,7 @@ static int uart_rs485_config(struct uart_port *port)
>  	int ret;
>  
>  	uart_sanitize_serial_rs485(port, rs485);
> -	uart_set_rs485_termination(port, rs485);
> +	uart_set_rs485_gpios(port, rs485);

Suggestion: define a new function to handle rx_during_tx, to keep
uart_set_rs485_termination(), which is more self-documenting than
uart_set_rs485_gpios().

ex: 
 	uart_set_rs485_termination(port, rs485);
 +	uart_set_rs485_rx_during_tx(port, rs485);

Hugo.


>  
>  	ret = port->rs485_config(port, NULL, rs485);
>  	if (ret)
> @@ -1449,7 +1451,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
>  	if (ret)
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
> -	uart_set_rs485_termination(port, &rs485);
> +	uart_set_rs485_gpios(port, &rs485);
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, &tty->termios, &rs485);
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 5e9cf0c48813..8eb13bf055f2 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -226,10 +226,7 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
>  
>  	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>  
> -	if (port->rs485_rx_during_tx_gpio)
> -		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
> -					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
> -	else
> +	if (!port->rs485_rx_during_tx_gpio)
>  		rs485conf->flags |= SER_RS485_RX_DURING_TX;
>  
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
> -- 
> 2.40.1
> 
