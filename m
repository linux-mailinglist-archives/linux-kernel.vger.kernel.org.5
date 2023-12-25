Return-Path: <linux-kernel+bounces-11036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6381E066
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19AD1C20DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEC251C2A;
	Mon, 25 Dec 2023 12:10:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C651028;
	Mon, 25 Dec 2023 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanmierlo.com
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
	(authenticated user m.brock@vanmierlo.com)
	by connect.vanmierlo.com (Kerio Connect 10.0.2 patch 1) with ESMTPA;
	Mon, 25 Dec 2023 13:10:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Dec 2023 13:10:09 +0100
From: m.brock@vanmierlo.com
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com,
 srinivas.goud@amd.com, shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V7 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
In-Reply-To: <20231218094415.2503672-4-manikanta.guntupalli@amd.com>
References: <20231218094415.2503672-1-manikanta.guntupalli@amd.com>
 <20231218094415.2503672-4-manikanta.guntupalli@amd.com>
Message-ID: <4d8031d25ac3d38ef1807896fe9a6a9f@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Manikanta Guntupalli wrote on 2023-12-18 10:44:
>  drivers/tty/serial/xilinx_uartps.c | 222 +++++++++++++++++++++++++++--
>  1 file changed, 213 insertions(+), 9 deletions(-)
> 
> @@ -203,10 +209,22 @@ struct cdns_uart {
>  	struct notifier_block	clk_rate_change_nb;
>  	u32			quirks;
>  	bool cts_override;
> +	struct gpio_desc	*gpiod_rts;
> +	bool			rs485_tx_started;
> +	struct timer_list	timer;

start_tx_timer

> +	struct timer_list	stop_tx_timer;

struct hrtimer maybe?

>  };
>  struct cdns_platform_data {
>  	u32 quirks;
>  };
> +
> +struct serial_rs485 cdns_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +		 SER_RS485_RTS_AFTER_SEND,
> +	.delay_rts_before_send = 1,
> +	.delay_rts_after_send = 1,
> +};
> +
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
>  		clk_rate_change_nb)
> 
> @@ -305,6 +323,55 @@ static void cdns_uart_handle_rx(void *dev_id,
> unsigned int isrstatus)
>  	tty_flip_buffer_push(&port->state->port);
>  }
> 
> +/**
> + * cdns_rts_gpio_enable - Configure RTS/GPIO to high/low
> + * @cdns_uart: Handle to the cdns_uart
> + * @enable: Value to be set to RTS/GPIO
> + */
> +static void cdns_rts_gpio_enable(struct cdns_uart *cdns_uart, bool 
> enable)
> +{
> +	u32 val;
> +
> +	if (cdns_uart->gpiod_rts) {
> +		gpiod_set_value(cdns_uart->gpiod_rts, enable);
> +	} else {
> +		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +		if (enable)
> +			val &= ~CDNS_UART_MODEMCR_RTS;
> +		else
> +			val |= CDNS_UART_MODEMCR_RTS;
> +		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +	}
> +}
> +
> +/**
> + * cdns_rs485_tx_setup - Tx setup specific to rs485
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_tx_setup(struct cdns_uart *cdns_uart)
> +{
> +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND)
> +		cdns_rts_gpio_enable(cdns_uart, 1);
> +	else
> +		cdns_rts_gpio_enable(cdns_uart, 0);

Maybe simply:
	bool enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND;
	cdns_rts_gpio_enable(cdns_uart, enable);

> +
> +	cdns_uart->rs485_tx_started = true;
> +}
> +
> +/**
> + * cdns_rs485_rx_setup - Rx setup specific to rs485
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
> +{
> +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +		cdns_rts_gpio_enable(cdns_uart, 1);
> +	else
> +		cdns_rts_gpio_enable(cdns_uart, 0);

Same here

> +
> +	cdns_uart->rs485_tx_started = false;
> +}
> +
>  /**
>   * cdns_uart_tx_empty -  Check whether TX is empty
>   * @port: Handle to the uart port structure
> @@ -579,6 +646,44 @@ static int cdns_uart_clk_notifier_cb(struct
> notifier_block *nb,
>  }
>  #endif
> 
> +/**
> + * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
> + * @t: Handle to the timer list structure
> + */
> +static void cdns_rs485_rx_callback(struct timer_list *t)
> +{
> +	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, timer);
> +
> +	/*
> +	 * Default Rx should be setup, because Rx signaling path
> +	 * need to enable to receive data.
> +	 */
> +	cdns_rs485_rx_setup(cdns_uart);
> +}
> +
> +/**
> + * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
> + * @t: Handle to the timer list structure
> + */
> +static void cdns_rs485_tx_callback(struct timer_list *t)
> +{
> +	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, timer);
> +
> +	uart_port_lock(cdns_uart->port);
> +	cdns_uart_handle_tx(cdns_uart->port);
> +
> +	/* Enable the TX Empty interrupt */
> +	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + 
> CDNS_UART_IER);
> +	uart_port_unlock(cdns_uart->port);
> +
> +	if (uart_circ_empty(&cdns_uart->port->state->xmit) ||
> +	    uart_tx_stopped(cdns_uart->port)) {
> +		timer_setup(&cdns_uart->timer, cdns_rs485_rx_callback, 0);

You really should not do this here. This belongs in 
cdns_uart_handle_tx() which
is also called from the TXEMPTY handler. And make sure TXEMPTY is true 
and on
top you also must account for the time it takes for the last character 
to leave
the transmitter including the stopbit.

See also em485 code in 8250_port.c:
	stop_delay = p->port.frame_time + DIV_ROUND_UP(p->port.frame_time, 7);

> +		mod_timer(&cdns_uart->timer, jiffies +
> +			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
> +	}

Should you not stop the stop_tx_timer in case it is still running when a 
new
transmission is requested?

> +}
> +
>  /**
>   * cdns_uart_start_tx -  Start transmitting bytes
>   * @port: Handle to the uart port structure
> @@ -586,6 +691,7 @@ static int cdns_uart_clk_notifier_cb(struct
> notifier_block *nb,
>  static void cdns_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int status;
> +	struct cdns_uart *cdns_uart = port->private_data;
> 
>  	if (uart_tx_stopped(port))
>  		return;
> @@ -604,10 +710,40 @@ static void cdns_uart_start_tx(struct uart_port 
> *port)
> 
>  	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
> 
> -	cdns_uart_handle_tx(port);
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (!cdns_uart->rs485_tx_started) {
> +			timer_setup(&cdns_uart->timer,
> +				    cdns_rs485_tx_callback, 0);

On a single line

> +			cdns_rs485_tx_setup(cdns_uart);
> +			mod_timer(&cdns_uart->timer, jiffies +
> +				  msecs_to_jiffies(port->rs485.delay_rts_before_send));
> +		} else {
> +			if (!timer_pending(&cdns_uart->timer))
> +				mod_timer(&cdns_uart->timer, jiffies);
> +		}
> +	} else {
> +		cdns_uart_handle_tx(port);
> 
> -	/* Enable the TX Empty interrupt */
> -	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
> +		/* Enable the TX Empty interrupt */
> +		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
> +	}
> +}
> +
> +/**
> + * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for 
> rs485.
> + * @t: Handle to the timer list structure
> + */
> +static void cdns_rs485_stop_tx_callback(struct timer_list *t)
> +{
> +	unsigned int regval;
> +	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, 
> stop_tx_timer);
> +
> +	cdns_rs485_rx_setup(cdns_uart);
> +
> +	regval = readl(cdns_uart->port->membase + CDNS_UART_CR);
> +	regval |= CDNS_UART_CR_TX_DIS;
> +	/* Disable the transmitter */

Why do you want to do this?

> +	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
>  }
> 
>  /**
> @@ -617,11 +753,19 @@ static void cdns_uart_start_tx(struct uart_port 
> *port)
>  static void cdns_uart_stop_tx(struct uart_port *port)
>  {
>  	unsigned int regval;
> +	struct cdns_uart *cdns_uart = port->private_data;
> 
> -	regval = readl(port->membase + CDNS_UART_CR);
> -	regval |= CDNS_UART_CR_TX_DIS;
> -	/* Disable the transmitter */
> -	writel(regval, port->membase + CDNS_UART_CR);
> +	if ((cdns_uart->port->rs485.flags & SER_RS485_ENABLED) &&
> +	    !timer_pending(&cdns_uart->stop_tx_timer) &&
> +	    cdns_uart->rs485_tx_started) {
> +		mod_timer(&cdns_uart->stop_tx_timer, jiffies +
> +			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));

Why try to adhere to the rts delay here? The original code doesn't seem 
to care
if the fifo is still filled either. Or was it already broken?

I did not yet find out exactly when this struct uart_ops .stop_tx is 
called.

> +	} else {
> +		regval = readl(port->membase + CDNS_UART_CR);
> +		regval |= CDNS_UART_CR_TX_DIS;
> +		/* Disable the transmitter */
> +		writel(regval, port->membase + CDNS_UART_CR);
> +	}
>  }
> 
>  /**
> @@ -829,6 +973,12 @@ static int cdns_uart_startup(struct uart_port 
> *port)
>  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
>  		cpu_relax();
> 
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		timer_setup(&cdns_uart->stop_tx_timer,
> +			    cdns_rs485_stop_tx_callback, 0);
> +		cdns_rs485_rx_setup(cdns_uart);
> +	}
> +
>  	/*
>  	 * Clear the RX disable bit and then set the RX enable bit to enable
>  	 * the receiver.
> @@ -888,6 +1038,7 @@ static void cdns_uart_shutdown(struct uart_port 
> *port)
>  {
>  	int status;
>  	unsigned long flags;
> +	struct cdns_uart *cdns_uart = port->private_data;
> 
>  	uart_port_lock_irqsave(port, &flags);
> 
> @@ -903,6 +1054,11 @@ static void cdns_uart_shutdown(struct uart_port 
> *port)
>  	uart_port_unlock_irqrestore(port, flags);
> 
>  	free_irq(port->irq, port);
> +
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		del_timer_sync(&cdns_uart->timer);
> +		del_timer_sync(&cdns_uart->stop_tx_timer);
> +	}
>  }
> 
>  /**
> @@ -1032,7 +1188,7 @@ static void cdns_uart_set_mctrl(struct uart_port
> *port, unsigned int mctrl)
>  	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
> 
>  	if (mctrl & TIOCM_RTS)
> -		val |= CDNS_UART_MODEMCR_RTS;
> +		cdns_rts_gpio_enable(cdns_uart_data, 1);

First passing 1 here is wrong. It should be 0.
Also there is no call with the opposite value here.

But this call could modify the MODEMCR register however its result is
immediately overwritten in the lines below with a wrong value in val.
Keep as-is and maybe add the following instead:

+	if (cdns_uart->gpiod_rts)
+		gpiod_set_value(cdns_uart->gpiod_rts, !(mctrl & TIOCM_RTS));

>  	if (mctrl & TIOCM_DTR)
>  		val |= CDNS_UART_MODEMCR_DTR;
>  	if (mctrl & TIOCM_LOOP)
> @@ -1455,6 +1611,37 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
>  /* Temporary variable for storing number of instances */
>  static int instances;
> 
> +/**
> + * cdns_rs485_config - Called when an application calls TIOCSRS485 
> ioctl.
> + * @port: Pointer to the uart_port structure
> + * @termios: Pointer to the ktermios structure
> + * @rs485: Pointer to the serial_rs485 structure
> + *
> + * Return: 0
> + */
> +static int cdns_rs485_config(struct uart_port *port, struct ktermios 
> *termios,
> +			     struct serial_rs485 *rs485)
> +{
> +	u32 val;
> +	unsigned int ctrl_reg;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		dev_dbg(port->dev, "Setting UART to RS485\n");
> +		/* Make sure auto RTS is disabled */
> +		val = readl(port->membase + CDNS_UART_MODEMCR);
> +		val &= ~CDNS_UART_MODEMCR_FCM;
> +		writel(val, port->membase + CDNS_UART_MODEMCR);
> +		/* Disable transmitter and make Rx setup*/
> +		cdns_uart_stop_tx(port);
> +	} else {
> +		/* Disable the TX and RX */
> +		ctrl_reg = readl(port->membase + CDNS_UART_CR);
> +		ctrl_reg |= CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS;
> +		writel(ctrl_reg, port->membase + CDNS_UART_CR);

Why would you disable the transmitter and receiver here?

> +	}
> +	return 0;
> +}
> +
>  /**
>   * cdns_uart_probe - Platform driver probe
>   * @pdev: Pointer to the platform device structure
> @@ -1597,9 +1784,23 @@ static int cdns_uart_probe(struct 
> platform_device *pdev)
>  	port->private_data = cdns_uart_data;
>  	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG 
> |
>  			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
> +	port->rs485_config = cdns_rs485_config;
> +	port->rs485_supported = cdns_rs485_supported;
>  	cdns_uart_data->port = port;
>  	platform_set_drvdata(pdev, port);
> 
> +	rc = uart_get_rs485_mode(port);
> +	if (rc)
> +		goto err_out_clk_notifier;
> +
> +	cdns_uart_data->gpiod_rts = devm_gpiod_get_optional(&pdev->dev, 
> "rts",
> +							    GPIOD_OUT_LOW);
> +	if (IS_ERR(cdns_uart_data->gpiod_rts)) {
> +		rc = PTR_ERR(cdns_uart_data->gpiod_rts);
> +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
> +		goto err_out_clk_notifier;
> +	}
> +
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, 
> UART_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_set_active(&pdev->dev);
> @@ -1618,6 +1819,8 @@ static int cdns_uart_probe(struct platform_device 
> *pdev)
>  		console_port = port;
>  	}
>  #endif
> +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
> +		cdns_rs485_rx_setup(cdns_uart_data);
> 
>  	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
>  	if (rc) {
> @@ -1646,6 +1849,7 @@ static int cdns_uart_probe(struct platform_device 
> *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +err_out_clk_notifier:
>  #ifdef CONFIG_COMMON_CLK
>  	clk_notifier_unregister(cdns_uart_data->uartclk,
>  			&cdns_uart_data->clk_rate_change_nb);

Kind Regards,
Maarten Brock


