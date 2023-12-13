Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C28113E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjLMN7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjLMN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:59:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A830FF;
        Wed, 13 Dec 2023 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702475869; x=1734011869;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UcwI/vM+xY5ePthrPSOpIJ1bKEuxaPU5CKcpVJRktmI=;
  b=CddND9qaOsgtgDlyC/OMz78QNBYJo9sosdGhXTLmk7Uq1AyeLXJo2nzw
   E9np6JseUy3rhKQqQRaOrwTup4TkjUjJWe7OadLX6HLV2J+oTlODZ8paW
   xxmxxJxf5+f4VCeIEtMPSSJNSEOCqfuy0X/miOTsw9tlwxjYq5abA0cAW
   AQ/2gH8TYDEdl+d5sV/ps6V4s5cz9nSOwPxf7/CGnVBJhYC9zrv3ZZsnD
   hp0USmWmp+5Zjf7p1p0GIxEoGsHs0lM7Tbp6SRz1fNmXCsayBZfG/51I1
   iZbExiEL3pUCmJGpmX80a0PUUqjyK0k1YJx0loUL8DRRS5uFKuft3SjNS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2046510"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="2046510"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802892488"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="802892488"
Received: from stetter-mobl1.ger.corp.intel.com ([10.252.50.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:57:43 -0800
Date:   Wed, 13 Dec 2023 15:57:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
cc:     git@amd.com, michal.simek@amd.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com,
        srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH V5 3/3] tty: serial: uartps: Add rs485 support to uartps
 driver
In-Reply-To: <20231213130023.606486-4-manikanta.guntupalli@amd.com>
Message-ID: <7919791e-f52f-eb35-ead-deea90cbe8@linux.intel.com>
References: <20231213130023.606486-1-manikanta.guntupalli@amd.com> <20231213130023.606486-4-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023, Manikanta Guntupalli wrote:

> Add rs485 support to uartps driver. Use either rts-gpios or RTS
> to control RS485 phy as driver or a receiver.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
> Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.
> 
> Changes for V3:
> Modify optional gpio name to rts-gpios.
> Update commit description.
> Move cdns_uart_tx_empty function to avoid prototype statement.
> Remove assignment of struct serial_rs485 to port->rs485 as
> serial core performs that.
> Switch to native RTS in non GPIO case.
> Handle rs485 during stop tx.
> Remove explicit calls to configure gpio direction and value,
> as devm_gpiod_get_optional performs that by using GPIOD_OUT_LOW argument.
> Update implementation to support configuration of GPIO/RTS value
> based on user configuration of SER_RS485_RTS_ON_SEND and
> SER_RS485_RTS_AFTER_SEND. Move implementation to start_tx from handle_tx.
> 
> Changes for V4:
> Create separate patch for cdns_uart_tx_empty relocation.
> Call cdns_rs485_rx_setup() before uart_add_one_port() in probe.
> Update gpio descriptor name to gpiod_rts.
> Instead of cdns_rs485_config_gpio_rts_high() and
> cdns_rs485_config_gpio_rts_low() functions for RTS/GPIO value
> configuration implement cdns_rts_gpio_enable().
> Disable auto rts and call cdns_uart_stop_tx() from cdns_rs485_config.
> Use timer instead of mdelay for delay_rts_before_send and delay_rts_after_send.
> Update cdns_uart_set_mctrl to support GPIO/RTS.
> 
> Changes for V5:
> None.
> ---
>  drivers/tty/serial/xilinx_uartps.c | 214 +++++++++++++++++++++++++++--
>  1 file changed, 205 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index aafcc2179e0e..3e1045896812 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -22,7 +22,9 @@
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/iopoll.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
>  
>  #define CDNS_UART_TTY_NAME	"ttyPS"
>  #define CDNS_UART_NAME		"xuartps"
> @@ -193,6 +195,10 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>   * @clk_rate_change_nb:	Notifier block for clock changes
>   * @quirks:		Flags for RXBS support.
>   * @cts_override:	Modem control state override
> + * @gpiod_rts:		Pointer to the gpio descriptor
> + * @rs485_tx_started:	RS485 tx state
> + * @timer:		Timer for tx and rx
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
> +	struct timer_list	timer;
> +	struct timer_list	stop_tx_timer;
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
> @@ -305,6 +323,55 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>  
> +/**
> + * cdns_rts_gpio_enable - Configure RTS/GPIO to high/low
> + * @cdns_uart: Handle to the cdns_uart
> + * @enable: Value to be set to RTS/GPIO
> + */
> +static void cdns_rts_gpio_enable(struct cdns_uart *cdns_uart, bool enable)
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
> +
> +	cdns_uart->rs485_tx_started = false;
> +}
> +
>  /**
>   * cdns_uart_tx_empty -  Check whether TX is empty
>   * @port: Handle to the uart port structure
> @@ -579,6 +646,42 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
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
> +	cdns_uart_handle_tx(cdns_uart->port);
> +
> +	/* Enable the TX Empty interrupt */
> +	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
> +
> +	if (uart_circ_empty(&cdns_uart->port->state->xmit) ||
> +	    uart_tx_stopped(cdns_uart->port)) {
> +		timer_setup(&cdns_uart->timer, cdns_rs485_rx_callback, 0);
> +		mod_timer(&cdns_uart->timer, jiffies +
> +			  msecs_to_jiffies(cdns_uart->port->rs485.delay_rts_after_send));
> +	}
> +}
> +
>  /**
>   * cdns_uart_start_tx -  Start transmitting bytes
>   * @port: Handle to the uart port structure
> @@ -586,6 +689,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
>  static void cdns_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int status;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  
>  	if (uart_tx_stopped(port))
>  		return;
> @@ -604,10 +708,40 @@ static void cdns_uart_start_tx(struct uart_port *port)
>  
>  	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
>  
> -	cdns_uart_handle_tx(port);
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (!cdns_uart->rs485_tx_started) {
> +			timer_setup(&cdns_uart->timer,
> +				    cdns_rs485_tx_callback, 0);
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
> + * cdns_rs485_stop_tx_callback - Timer stop tx callback handler for rs485.
> + * @t: Handle to the timer list structure
> + */
> +static void cdns_rs485_stop_tx_callback(struct timer_list *t)
> +{
> +	unsigned int regval;
> +	struct cdns_uart *cdns_uart = from_timer(cdns_uart, t, stop_tx_timer);
> +
> +	cdns_rs485_rx_setup(cdns_uart);
> +
> +	regval = readl(cdns_uart->port->membase + CDNS_UART_CR);
> +	regval |= CDNS_UART_CR_TX_DIS;
> +	/* Disable the transmitter */
> +	writel(regval, cdns_uart->port->membase + CDNS_UART_CR);
>  }
>  
>  /**
> @@ -617,11 +751,19 @@ static void cdns_uart_start_tx(struct uart_port *port)
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
> +	} else {
> +		regval = readl(port->membase + CDNS_UART_CR);
> +		regval |= CDNS_UART_CR_TX_DIS;
> +		/* Disable the transmitter */
> +		writel(regval, port->membase + CDNS_UART_CR);
> +	}
>  }
>  
>  /**
> @@ -829,6 +971,12 @@ static int cdns_uart_startup(struct uart_port *port)
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
> @@ -888,6 +1036,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
>  {
>  	int status;
>  	unsigned long flags;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  
>  	uart_port_lock_irqsave(port, &flags);
>  
> @@ -903,6 +1052,11 @@ static void cdns_uart_shutdown(struct uart_port *port)
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
> @@ -1032,7 +1186,7 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
>  
>  	if (mctrl & TIOCM_RTS)
> -		val |= CDNS_UART_MODEMCR_RTS;
> +		cdns_rts_gpio_enable(cdns_uart_data, 1);
>  	if (mctrl & TIOCM_DTR)
>  		val |= CDNS_UART_MODEMCR_DTR;
>  	if (mctrl & TIOCM_LOOP)
> @@ -1455,6 +1609,31 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
>  /* Temporary variable for storing number of instances */
>  static int instances;
>  
> +/**
> + * cdns_rs485_config - Called when an application calls TIOCSRS485 ioctl.
> + * @port: Pointer to the uart_port structure
> + * @termios: Pointer to the ktermios structure
> + * @rs485: Pointer to the serial_rs485 structure
> + *
> + * Return: 0
> + */
> +static int cdns_rs485_config(struct uart_port *port, struct ktermios *termios,
> +			     struct serial_rs485 *rs485)
> +{
> +	u32 val;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		dev_dbg(port->dev, "Setting UART to RS485\n");
> +		/* Make sure auto RTS is disabled */
> +		val = readl(port->membase + CDNS_UART_MODEMCR);
> +		val &= ~CDNS_UART_MODEMCR_FCM;
> +		writel(val, port->membase + CDNS_UART_MODEMCR);
> +		/* Disable transmitter and make Rx setup*/

Missing space.

> +		cdns_uart_stop_tx(port);
> +	}

So you provide no way to disable RS485 after it once gets enable?
Arguably that might not usually be a very useful thing to do in practice 
but API-wise this function is expected to be able to also turn RS485 off.

I didn't do a full review but having to add a timer smells like you could
reuse the existing em485 framework for timing, please check.


-- 
 i.

