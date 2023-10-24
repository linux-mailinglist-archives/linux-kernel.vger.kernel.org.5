Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D483B7D549E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJXPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJXPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:03:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C9111;
        Tue, 24 Oct 2023 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698159798; x=1729695798;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r47g194hEkB5Z9PKa+y8DVJGAzdshQtZiIXJLW56A0E=;
  b=KMUkGJTrWEJy4S5SRml2QtKxO6DyKAac1HQxqsV2qfO+oeD1l5js9N87
   C0XMRRQsOVu0HK6Ta2m0+sVr2RA1WOWQvc6BZGQTjCgLqp4RUhsY3VSK2
   LcdNCHLNGXWTsiupw1P5GZqMQgUs1xxCFuAdp4nSCLXoccyd8uyVvSJIA
   qjSJKmDXRLEvnif+tsqROWWX0/c8kYVOdRmPo2E8JR0GPKTPhcKWcZ4sP
   6etVQVxVnqsitHCjxTHSWWGE9A0rMEgIsiwX13Q9s5p8BW3pG4c5CflUf
   nvYx83CYdflW9uqmEdjLrpSAZ4EeOEbA45awbc1vnyKIGy8N/G6apTD0a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389927615"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="389927615"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1089849125"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="1089849125"
Received: from nkraljev-mobl.ger.corp.intel.com ([10.249.41.91])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:02:14 -0700
Date:   Tue, 24 Oct 2023 18:02:12 +0300 (EEST)
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
Subject: Re: [PATCH V3 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
In-Reply-To: <20231024144847.2316941-3-manikanta.guntupalli@amd.com>
Message-ID: <f48b4dda-f78e-ce2b-39dd-af82db4b84@linux.intel.com>
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com> <20231024144847.2316941-3-manikanta.guntupalli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Manikanta Guntupalli wrote:

> Add rs485 support to uartps driver. Use either rts-gpios or RTS
> to control RS485 phy as driver or a receiver.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
> Add support for RTS, delay_rts_before_send and delay_rts_after_send in RS485 mode.
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
> ---
>  drivers/tty/serial/xilinx_uartps.c | 180 ++++++++++++++++++++++++++---
>  1 file changed, 165 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 9c13dac1d4d1..32229cf5c508 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -23,6 +23,9 @@
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/iopoll.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
>  
>  #define CDNS_UART_TTY_NAME	"ttyPS"
>  #define CDNS_UART_NAME		"xuartps"
> @@ -193,6 +196,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>   * @clk_rate_change_nb:	Notifier block for clock changes
>   * @quirks:		Flags for RXBS support.
>   * @cts_override:	Modem control state override
> + * @gpiod:		Pointer to the gpio descriptor
>   */
>  struct cdns_uart {
>  	struct uart_port	*port;
> @@ -203,10 +207,19 @@ struct cdns_uart {
>  	struct notifier_block	clk_rate_change_nb;
>  	u32			quirks;
>  	bool cts_override;
> +	struct gpio_desc	*gpiod;
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
> @@ -305,6 +318,79 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>  
> +/**
> + * cdns_rs485_config_gpio_rts_high - Configure GPIO/RTS to high
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_config_gpio_rts_high(struct cdns_uart *cdns_uart)
> +{
> +	u32 val;
> +
> +	if (cdns_uart->gpiod) {
> +		gpiod_set_value(cdns_uart->gpiod, 1);
> +	} else {
> +		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +		val &= ~CDNS_UART_MODEMCR_RTS;
> +		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +	}
> +}
> +
> +/**
> + * cdns_rs485_config_gpio_rts_low - Configure GPIO/RTS to low
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_config_gpio_rts_low(struct cdns_uart *cdns_uart)
> +{
> +	u32 val;
> +
> +	if (cdns_uart->gpiod) {
> +		gpiod_set_value(cdns_uart->gpiod, 0);
> +	} else {
> +		val = readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +		val |= CDNS_UART_MODEMCR_RTS;
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
> +		cdns_rs485_config_gpio_rts_high(cdns_uart);
> +	else
> +		cdns_rs485_config_gpio_rts_low(cdns_uart);
> +}
> +
> +/**
> + * cdns_rs485_rx_setup - Rx setup specific to rs485
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
> +{
> +	if (cdns_uart->port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +		cdns_rs485_config_gpio_rts_high(cdns_uart);
> +	else
> +		cdns_rs485_config_gpio_rts_low(cdns_uart);
> +}
> +
> +/**
> + * cdns_uart_tx_empty -  Check whether TX is empty
> + * @port: Handle to the uart port structure
> + *
> + * Return: TIOCSER_TEMT on success, 0 otherwise
> + */
> +static unsigned int cdns_uart_tx_empty(struct uart_port *port)
> +{
> +	unsigned int status;
> +
> +	status = readl(port->membase + CDNS_UART_SR) &
> +		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);

Split to two lines since you need two lines anyway.

> +	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
> +}
> +
>  /**
>   * cdns_uart_handle_tx - Handle the bytes to be Txed.
>   * @dev_id: Id of the UART port
> @@ -571,6 +657,8 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
>  static void cdns_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int status;
> +	unsigned long time_out;
> +	struct cdns_uart *cdns_uart = port->private_data;
>  
>  	if (uart_tx_stopped(port))
>  		return;
> @@ -589,8 +677,31 @@ static void cdns_uart_start_tx(struct uart_port *port)
>  
>  	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
>  
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		cdns_rs485_tx_setup(cdns_uart);
> +		if (cdns_uart->port->rs485.delay_rts_before_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_before_send);
> +	}
> +
>  	cdns_uart_handle_tx(port);
>  
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		time_out = jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +		/* Wait for tx completion */
> +		while ((cdns_uart_tx_empty(cdns_uart->port) != TIOCSER_TEMT) &&
> +		       time_before(jiffies, time_out))
> +			cpu_relax();

Use iopoll.h helper instead of handcrafted delay loop ?

> +
> +		if (cdns_uart->port->rs485.delay_rts_after_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
> +
> +		/*
> +		 * Default Rx should be setup, because RX signaling path
> +		 * need to enable to receive data.
> +		 */
> +		cdns_rs485_rx_setup(cdns_uart);
> +	}
> +
>  	/* Enable the TX Empty interrupt */
>  	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
>  }
> @@ -602,6 +713,14 @@ static void cdns_uart_start_tx(struct uart_port *port)
>  static void cdns_uart_stop_tx(struct uart_port *port)
>  {
>  	unsigned int regval;
> +	struct cdns_uart *cdns_uart = port->private_data;
> +
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (cdns_uart->port->rs485.delay_rts_after_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
> +
> +		cdns_rs485_rx_setup(cdns_uart);
> +	}
>  
>  	regval = readl(port->membase + CDNS_UART_CR);
>  	regval |= CDNS_UART_CR_TX_DIS;
> @@ -626,21 +745,6 @@ static void cdns_uart_stop_rx(struct uart_port *port)
>  	writel(regval, port->membase + CDNS_UART_CR);
>  }
>  
> -/**
> - * cdns_uart_tx_empty -  Check whether TX is empty
> - * @port: Handle to the uart port structure
> - *
> - * Return: TIOCSER_TEMT on success, 0 otherwise
> - */
> -static unsigned int cdns_uart_tx_empty(struct uart_port *port)
> -{
> -	unsigned int status;
> -
> -	status = readl(port->membase + CDNS_UART_SR) &
> -		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
> -	return (status == CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
> -}

This is just a relocation of code? Move it in another patch in the 
series, don't put it within the feature patch..

> -
>  /**
>   * cdns_uart_break_ctl - Based on the input ctl we have to start or stop
>   *			transmitting char breaks
> @@ -829,6 +933,9 @@ static int cdns_uart_startup(struct uart_port *port)
>  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
>  		cpu_relax();
>  
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
> +		cdns_rs485_rx_setup(cdns_uart);
> +
>  	/*
>  	 * Clear the RX disable bit and then set the RX enable bit to enable
>  	 * the receiver.
> @@ -1455,6 +1562,23 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
> +	if (rs485->flags & SER_RS485_ENABLED)
> +		dev_dbg(port->dev, "Setting UART to RS485\n");
> +
> +	return 0;
> +}
> +
>  /**
>   * cdns_uart_probe - Platform driver probe
>   * @pdev: Pointer to the platform device structure
> @@ -1463,6 +1587,7 @@ static int instances;
>   */
>  static int cdns_uart_probe(struct platform_device *pdev)
>  {
> +	u32 val;
>  	int rc, id, irq;
>  	struct uart_port *port;
>  	struct resource *res;
> @@ -1597,9 +1722,23 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	port->private_data = cdns_uart_data;
>  	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
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
> +	cdns_uart_data->gpiod = devm_gpiod_get_optional(&pdev->dev, "rts",
> +							GPIOD_OUT_LOW);
> +	if (IS_ERR(cdns_uart_data->gpiod)) {
> +		rc = PTR_ERR(cdns_uart_data->gpiod);
> +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
> +		goto err_out_clk_notifier;
> +	}
> +
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_set_active(&pdev->dev);
> @@ -1638,6 +1777,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
>  							     "cts-override");
>  
> +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (!cdns_uart_data->gpiod) {

Combine the if conditions into a single if.

> +			val = readl(cdns_uart_data->port->membase
> +				    + CDNS_UART_MODEMCR);

One line.

> +			val |= CDNS_UART_MODEMCR_RTS;
> +			writel(val, cdns_uart_data->port->membase
> +			       + CDNS_UART_MODEMCR);

Ditto.

> +		}
> +	}
> +
>  	instances++;
>  
>  	return 0;
> @@ -1646,6 +1795,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +err_out_clk_notifier:
>  #ifdef CONFIG_COMMON_CLK
>  	clk_notifier_unregister(cdns_uart_data->uartclk,
>  			&cdns_uart_data->clk_rate_change_nb);
> 

-- 
 i.

