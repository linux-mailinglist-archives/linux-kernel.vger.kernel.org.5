Return-Path: <linux-kernel+bounces-22322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EBF829C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F1BB270D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64D04C3A5;
	Wed, 10 Jan 2024 14:10:30 +0000 (UTC)
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9F64E1D5;
	Wed, 10 Jan 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanmierlo.com
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
	(authenticated user m.brock@vanmierlo.com)
	by connect.vanmierlo.com (Kerio Connect 10.0.3 patch 1) with ESMTPA;
	Wed, 10 Jan 2024 14:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jan 2024 14:39:46 +0100
From: Maarten Brock <m.brock@vanmierlo.com>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, gregkh@linuxfoundation.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jirislaby@kernel.org,
 linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com,
 srinivas.goud@amd.com, shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V8 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
In-Reply-To: <20240110111107.3645284-4-manikanta.guntupalli@amd.com>
References: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
 <20240110111107.3645284-4-manikanta.guntupalli@amd.com>
Message-ID: <6302479f8f991c98d55b2f887c0f356f@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Manikanta Guntupalli wrote on 2024-01-10 12:11:
> Changes for V8:
> Use hrtimer instead of timer list.
> Simplify cdns_rs485_tx_setup() and cdns_rs485_rx_setup().
> Update argument of cdns_rts_gpio_enable() in cdns_uart_set_mctrl().
> Add cdns_calc_after_tx_delay() to calculate required delay after tx.
> Add hrtimer setup in cdns_rs485_config().
> Move enable TX Empty interrupt and rs485 rx callback scheduling part to
> cdns_uart_handle_tx().
> ---
>  drivers/tty/serial/xilinx_uartps.c | 241 ++++++++++++++++++++++++++++-
>  1 file changed, 233 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c
> b/drivers/tty/serial/xilinx_uartps.c
> index aafcc2179e0e..3247fd3e91fd 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -193,6 +195,10 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>   * @clk_rate_change_nb:	Notifier block for clock changes
>   * @quirks:		Flags for RXBS support.
>   * @cts_override:	Modem control state override
> + * @gpiod_rts:		Pointer to the gpio descriptor
> + * @rs485_tx_started:	RS485 tx state
> + * @tx_timer:		Timer for tx

start_tx_timer ?

> + * @stop_tx_timer:	Timer for stop tx
>   */
>  struct cdns_uart {
>  	struct uart_port	*port;
> @@ -203,10 +209,22 @@ struct cdns_uart {
>  	struct notifier_block	clk_rate_change_nb;
>  	u32			quirks;
>  	bool cts_override;
> +	struct gpio_desc	*gpiod_rts;
> +	bool			rs485_tx_started;
> +	struct hrtimer		tx_timer;
> +	struct hrtimer		stop_tx_timer;
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
> +	bool enable;
> +
> +	enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_ON_SEND;
> +	cdns_rts_gpio_enable(cdns_uart, enable);
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
> +	bool enable;
> +
> +	enable = cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND;
> +	cdns_rts_gpio_enable(cdns_uart, enable);
> +
> +	cdns_uart->rs485_tx_started = false;
> +}
> +
>  /**
>   * cdns_uart_tx_empty -  Check whether TX is empty
>   * @port: Handle to the uart port structure
> @@ -320,6 +387,37 @@ static unsigned int cdns_uart_tx_empty(struct
> uart_port *port)
>  	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
>  }
> 
> +/**
> + * cdns_rs485_rx_callback - Timer rx callback handler for rs485.
> + * @t: Handle to the hrtimer structure
> + */
> +static enum hrtimer_restart cdns_rs485_rx_callback(struct hrtimer *t)
> +{
> +	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, 
> tx_timer);
> +
> +	/*
> +	 * Default Rx should be setup, because Rx signaling path
> +	 * need to enable to receive data.
> +	 */
> +	cdns_rs485_rx_setup(cdns_uart);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +/**
> + * cdns_calc_after_tx_delay - calculate delay required for after tx.
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static u64 cdns_calc_after_tx_delay(struct cdns_uart *cdns_uart)
> +{
> +	/*
> +	 * Frame time + stop bit time + rs485.delay_rts_after_send
> +	 */
> +	return cdns_uart->port->frame_time
> +	       + DIV_ROUND_UP(cdns_uart->port->frame_time, 7)
> +	       + (u64)cdns_uart->port->rs485.delay_rts_after_send * 
> NSEC_PER_MSEC;
> +}
> +
>  /**
>   * cdns_uart_handle_tx - Handle the bytes to be Txed.

s/Txed/transmitted

>   * @dev_id: Id of the UART port
> @@ -328,6 +426,7 @@ static unsigned int cdns_uart_tx_empty(struct
> uart_port *port)
>  static void cdns_uart_handle_tx(void *dev_id)
>  {
>  	struct uart_port *port = (struct uart_port *)dev_id;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  	struct circ_buf *xmit = &port->state->xmit;
>  	unsigned int numbytes;

I recommend to also check uart_tx_stopped() for disabling the TXEMPTY 
interrupt.

-	if (uart_circ_empty(xmit)) {
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		/* Disable the TX Empty interrupt */
		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
		return;
	}

> @@ -347,6 +446,16 @@ static void cdns_uart_handle_tx(void *dev_id)
> 
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
> +
> +	/* Enable the TX Empty interrupt */
> +	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + 
> CDNS_UART_IER);
> +
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
> +	    (uart_circ_empty(xmit) || uart_tx_stopped(port))) {
> +		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
> +		hrtimer_start(&cdns_uart->tx_timer,
> +			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), 
> HRTIMER_MODE_REL);
> +	}
>  }
> 
>  /**
> @@ -579,6 +688,21 @@ static int cdns_uart_clk_notifier_cb(struct
> notifier_block *nb,
>  }
>  #endif
> 
> +/**
> + * cdns_rs485_tx_callback - Timer tx callback handler for rs485.
> + * @t: Handle to the hrtimer structure
> + */
> +static enum hrtimer_restart cdns_rs485_tx_callback(struct hrtimer *t)
> +{
> +	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart, 
> tx_timer);
> +
> +	uart_port_lock(cdns_uart->port);
> +	cdns_uart_handle_tx(cdns_uart->port);
> +	uart_port_unlock(cdns_uart->port);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
>  /**
>   * cdns_uart_start_tx -  Start transmitting bytes
>   * @port: Handle to the uart port structure
> @@ -586,6 +710,7 @@ static int cdns_uart_clk_notifier_cb(struct
> notifier_block *nb,
>  static void cdns_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int status;
> +	struct cdns_uart *cdns_uart = port->private_data;
> 
>  	if (uart_tx_stopped(port))
>  		return;
> @@ -604,10 +729,38 @@ static void cdns_uart_start_tx(struct uart_port 
> *port)
> 

Maybe add comment here that the following clears the interrupt flag.

>  	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
> 
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (!cdns_uart->rs485_tx_started) {
> +			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
> +			cdns_rs485_tx_setup(cdns_uart);

Move cdns_rs485_tx_setup() out of this if clause to make sure DE is 
always active.

> +			return hrtimer_start(&cdns_uart->tx_timer,
> +					     ms_to_ktime(port->rs485.delay_rts_before_send),
> +					     HRTIMER_MODE_REL);
> +		} else {
> +			if (hrtimer_get_remaining(&cdns_uart->tx_timer))
> +				hrtimer_cancel(&cdns_uart->tx_timer);

You intend to stop the timer for cdns_rs485_rx_callback() here, but...
What if the tx_timer is started for cdns_rs485_tx_callback()?

> +		}
> +	}
>  	cdns_uart_handle_tx(port);
> +}
> 
> -	/* Enable the TX Empty interrupt */
> -	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
> +/**
> + * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for 
> rs485.
> + * @t: Handle to the timer list structure
> + */
> +static enum hrtimer_restart cdns_rs485_stop_tx_callback(struct hrtimer 
> *t)
> +{
> +	unsigned int regval;
> +	struct cdns_uart *cdns_uart = container_of(t, struct cdns_uart,
> stop_tx_timer);
> +
> +	cdns_rs485_rx_setup(cdns_uart);
> +
> +	regval = readl(cdns_uart->port->membase + CDNS_UART_CR);
> +	regval |= CDNS_UART_CR_TX_DIS;
> +	/* Disable the transmitter */
> +	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
> +
> +	return HRTIMER_NORESTART;
>  }
> 
>  /**
> @@ -617,11 +770,21 @@ static void cdns_uart_start_tx(struct uart_port 
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
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (cdns_uart->rs485_tx_started)
> +			hrtimer_start(&cdns_uart->stop_tx_timer,
> +				      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)),
> +				      HRTIMER_MODE_REL);

Why do you want to wait here? Should disabling the transmitter not be 
enough?
My guess and hope is that it will result in the current transmission 
running to
completion and then fire the TXEMPTY interrupt which will then start the 
timer for
cdns_rs485_rx_callback(). I see no need for a separate timer here.

> +		else
> +			cdns_rs485_stop_tx_callback(&cdns_uart->stop_tx_timer);
> +	} else {
> +		regval = readl(port->membase + CDNS_UART_CR);
> +		regval |= CDNS_UART_CR_TX_DIS;
> +		/* Disable the transmitter */
> +		writel(regval, port->membase + CDNS_UART_CR);
> +	}
>  }
> 
>  /**
> @@ -829,6 +992,9 @@ static int cdns_uart_startup(struct uart_port 
> *port)
>  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
>  		cpu_relax();
> 
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
> +		cdns_rs485_rx_setup(cdns_uart);
> +
>  	/*
>  	 * Clear the RX disable bit and then set the RX enable bit to enable
>  	 * the receiver.
> @@ -888,6 +1054,7 @@ static void cdns_uart_shutdown(struct uart_port 
> *port)
>  {
>  	int status;
>  	unsigned long flags;
> +	struct cdns_uart *cdns_uart = port->private_data;
> 
>  	uart_port_lock_irqsave(port, &flags);
> 
> @@ -903,6 +1070,11 @@ static void cdns_uart_shutdown(struct uart_port 
> *port)
>  	uart_port_unlock_irqrestore(port, flags);
> 
>  	free_irq(port->irq, port);
> +
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		hrtimer_cancel(&cdns_uart->tx_timer);
> +		hrtimer_cancel(&cdns_uart->stop_tx_timer);
> +	}

Should you not do this much earlier in this function?

>  }
> 
>  /**
> @@ -1032,7 +1204,7 @@ static void cdns_uart_set_mctrl(struct uart_port
> *port, unsigned int mctrl)
>  	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
> 
>  	if (mctrl & TIOCM_RTS)
> -		val |= CDNS_UART_MODEMCR_RTS;
> +		cdns_rts_gpio_enable(cdns_uart_data, mctrl & TIOCM_RTS);

Move this out of the if clause so the gpio can also get cleared.
On top of that it should be inverted.
But if there is no gpio defined this call will create a glitch on the 
RTS pin.
cdns_rts_gpio_enable() can set CDNS_UART_MODEMCR_RTS to lower the RTS 
pin and
then val will clear CDNS_UART_MODEMCR_RTS again leaving the RTS pin 
high.
I suggest to use this instead:
	if (mctrl & TIOCM_RTS)
		val |= CDNS_UART_MODEMCR_RTS;
+	if (cdns_uart->gpiod_rts) {
+		gpiod_set_value(cdns_uart->gpiod_rts, !(mctrl & TIOCM_RTS));

>  	if (mctrl & TIOCM_DTR)
>  		val |= CDNS_UART_MODEMCR_DTR;
>  	if (mctrl & TIOCM_LOOP)
> @@ -1455,6 +1627,42 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
> +	struct cdns_uart *cdns_uart = port->private_data;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		dev_dbg(port->dev, "Setting UART to RS485\n");
> +		/* Make sure auto RTS is disabled */
> +		val = readl(port->membase + CDNS_UART_MODEMCR);
> +		val &= ~CDNS_UART_MODEMCR_FCM;
> +		writel(val, port->membase + CDNS_UART_MODEMCR);
> +
> +		/* Timer setup */
> +		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC, 
> HRTIMER_MODE_REL);
> +		hrtimer_init(&cdns_uart->stop_tx_timer, CLOCK_MONOTONIC, 
> HRTIMER_MODE_REL);
> +		cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
> +		cdns_uart->stop_tx_timer.function = &cdns_rs485_stop_tx_callback;
> +
> +		/* Disable transmitter and make Rx setup*/
> +		cdns_uart_stop_tx(port);
> +	} else {
> +		hrtimer_cancel(&cdns_uart->tx_timer);
> +		hrtimer_cancel(&cdns_uart->stop_tx_timer);
> +	}
> +	return 0;
> +}
> +
>  /**
>   * cdns_uart_probe - Platform driver probe
>   * @pdev: Pointer to the platform device structure
> @@ -1597,9 +1805,23 @@ static int cdns_uart_probe(struct 
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
> @@ -1618,6 +1840,8 @@ static int cdns_uart_probe(struct platform_device 
> *pdev)
>  		console_port = port;
>  	}
>  #endif
> +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED)
> +		cdns_rs485_rx_setup(cdns_uart_data);
> 
>  	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
>  	if (rc) {
> @@ -1646,6 +1870,7 @@ static int cdns_uart_probe(struct platform_device 
> *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +err_out_clk_notifier:
>  #ifdef CONFIG_COMMON_CLK
>  	clk_notifier_unregister(cdns_uart_data->uartclk,
>  			&cdns_uart_data->clk_rate_change_nb);

This is getting big and some modifications are not rs485 related.
I suggest to split them and get those applied first.
My first modification would be to add support for the rts gpio.

Kind regards,
Maarten Brock


