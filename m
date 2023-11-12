Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F372A7E9247
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjKLTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:38:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9652582;
        Sun, 12 Nov 2023 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699817880; x=1700422680; i=linosanfilippo@gmx.de;
        bh=SosxGtIlvr6WP7BkRq90xyNCWQxhQ44ePKDPeAlBZo0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Po5Tg47a7ZqRy6WT6pH52WYQcQRimnYDrHs7oYSJtL1cBYofTS1W8Jt9rbdJOJ3J
         wPWkFqfYc8NIr8mLVt7hlQvIwCD/vupr4UDTjXfsWDs3A6aZxlQD0ehURmZLz+WsE
         CmALLVUpVA0vYLGmOHfvuiH7Lr6npaB2XbzJMZE2Lt3VhJLMnX1KPd3ZLkQaqzind
         SKJRB4cfow/DwV37vq+3FfHP2wVgZTgu+15ONFAzuqFSb8xfg+1BPR3SvjwEdH0Ts
         bxI4jBRfU6H1cRaDlSA9/L0bTGM956ixls8mHMwwAeqGDT1jse5JncDJmhfjq+Cwk
         pF4uCkbUgOKVpf0mGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1recEk38ZB-00cvh6; Sun, 12
 Nov 2023 20:37:59 +0100
Message-ID: <97bfc5ee-6c07-4e4b-8192-f46c701a0604@gmx.de>
Date:   Sun, 12 Nov 2023 20:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
Content-Language: en-US
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
        michal.simek@amd.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
        shubhrajyoti.datta@amd.com, manion05gk@gmail.com
References: <20231024144847.2316941-1-manikanta.guntupalli@amd.com>
 <20231024144847.2316941-3-manikanta.guntupalli@amd.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20231024144847.2316941-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8J/F3bid1loWbfp/82mcI7J9lCork/uFtlxkRd3uOaucWXIb4L
 BJDfbkrW5mpD7MyawdFr8GIykmQLm6fCcOBq5603jzEk7s6X5BRvPf9EkW2iIYr/70QHJZ5
 BgsLQTbSBO9tYb9mfYPrRRGSxKGayirttRF3qG0+rkVjdWVr3gZRrHt0CacnPOJtbkm5jYZ
 zHNJaUqzWPNsWLMJJokmQ==
UI-OutboundReport: notjunk:1;M01:P0:bkWpB6KQmog=;0KsOviSbexOI/uQJwXG6Z2EDiV8
 bsTCk9wLNIEUEhGjktvTz84Vf1HnNC/0jpcX0dDxjbu/U0GvKcOS06+sA/BYQmHeV5X9MraJP
 a4w6w06saq0Mi+DsRhsBPfYHUfdC0E5GFI8RXnowt0Kt1wUF9pNZGmfLLDXeW1uWdWBc5Kncn
 /cqHxwbtKC+f9KohUtOk6QMoalpW32cMzns+zj1KBaPtnBSS5zGG/UuZFNQwXH7EpXlE3HHDz
 9IIJUeFDSpnlgkYRC9BSgEYV8zIWslOCL3z0zlPrEZ6fngtZBO46GUXdFTVlVQaU33g45rcLL
 XtthJBo8cpV9UfACtGtXM/kfXOKpMnJbJzoZGam4hrravWJBWEAEhJK6aN0eqIeEcF0L9c4nQ
 q4Rt82XABSGfRW7TbLAYIlG5bPkhAbQkWMX+uSzEFQqkI0GbB4ncqdZXScrQbSZBY4ieVKdrR
 Mtwh13KmSC4z2fL6fOvdYYOaSW67X5WwYh4g1d3YGgtNm6ZvkB82DLO3Y3Bm2kQH/Fm4pO5vR
 TkaqBLpf5Uodl4cp0p4XcV17Y4xVYhD9LA/Ijk1ZQX46lOU242cF2+8YT6IVsASrfHAHHHJpx
 YPhVAUfiRAo/THzlgN0HbIsnjjqV5QSp7JqQ7x7RGb7tP28VPTO/NMUT3BRwP4rLq66hmJSNF
 CyYJ+HsrH3y3JhDxTQ5KeR7tc44NUSIrL8jXtaY3GYUwqR9BQqd4VJP5rErcpiloUWKlAtJx+
 o76mOrbOtC+5ky7k/BmnUBYKXJSMvJ05hP9vPdo5yoReBk5lEXL9vRpgU5CVPbRQR9MuxXMMu
 M3DkcIs2vnWQvkvrgCbUEkIIvixPvGciIPxMvaKiCPvPn2WWIkCDq9/ieJ8hKoUmI3h+Ik0gV
 4v/b9VsxD3vhYTtiNQTAtGW/01L/b+zZj7gWnHHQZuGfqGkpmHrqHNriRVwnWOwHJYELkt43t
 Xz/M2w==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24.10.23 16:48, Manikanta Guntupalli wrote:
> Add rs485 support to uartps driver. Use either rts-gpios or RTS
> to control RS485 phy as driver or a receiver.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
> Add support for RTS, delay_rts_before_send and delay_rts_after_send in R=
S485 mode.
> Changes for V3:
> Modify optional gpio name to rts-gpios.
> Update commit description.
> Move cdns_uart_tx_empty function to avoid prototype statement.
> Remove assignment of struct serial_rs485 to port->rs485 as
> serial core performs that.
> Switch to native RTS in non GPIO case.
> Handle rs485 during stop tx.
> Remove explicit calls to configure gpio direction and value,
> as devm_gpiod_get_optional performs that by using GPIOD_OUT_LOW argument=
.
> Update implementation to support configuration of GPIO/RTS value
> based on user configuration of SER_RS485_RTS_ON_SEND and
> SER_RS485_RTS_AFTER_SEND. Move implementation to start_tx from handle_tx=
.
> ---
>  drivers/tty/serial/xilinx_uartps.c | 180 ++++++++++++++++++++++++++---
>  1 file changed, 165 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xil=
inx_uartps.c
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
> +struct serial_rs485 cdns_rs485_supported =3D {
> +	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
> +		 SER_RS485_RTS_AFTER_SEND,
> +	.delay_rts_before_send =3D 1,
> +	.delay_rts_after_send =3D 1,
> +};
> +
>  #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
>  		clk_rate_change_nb)
>
> @@ -305,6 +318,79 @@ static void cdns_uart_handle_rx(void *dev_id, unsig=
ned int isrstatus)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>
> +/**
> + * cdns_rs485_config_gpio_rts_high - Configure GPIO/RTS to high
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_config_gpio_rts_high(struct cdns_uart *cdns_uart=
)
> +{
> +	u32 val;
> +
> +	if (cdns_uart->gpiod) {
> +		gpiod_set_value(cdns_uart->gpiod, 1);
> +	} else {
> +		val =3D readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +		val &=3D ~CDNS_UART_MODEMCR_RTS;
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
> +		val =3D readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +		val |=3D CDNS_UART_MODEMCR_RTS;
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
> +	status =3D readl(port->membase + CDNS_UART_SR) &
> +		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
> +	return (status =3D=3D CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
> +}
> +
>  /**
>   * cdns_uart_handle_tx - Handle the bytes to be Txed.
>   * @dev_id: Id of the UART port
> @@ -571,6 +657,8 @@ static int cdns_uart_clk_notifier_cb(struct notifier=
_block *nb,
>  static void cdns_uart_start_tx(struct uart_port *port)
>  {
>  	unsigned int status;
> +	unsigned long time_out;
> +	struct cdns_uart *cdns_uart =3D port->private_data;
>
>  	if (uart_tx_stopped(port))
>  		return;
> @@ -589,8 +677,31 @@ static void cdns_uart_start_tx(struct uart_port *po=
rt)
>
>  	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
>
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		cdns_rs485_tx_setup(cdns_uart);
> +		if (cdns_uart->port->rs485.delay_rts_before_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_before_send);

So, this will be executed each time (including the rts_before_send delay) =
the core wants
to send data? This is not how it is supposed to work: The tx setup (and th=
e
delay before send) has to be done once when transmission starts. Note that=
 when sending
a bulk of data the core may call cdns_uart_start_tx() several times before
it eventually calls cdns_uart_stop_tx() to stop the transmission.


> +	}
> +
>  	cdns_uart_handle_tx(port);
>
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +		/* Wait for tx completion */
> +		while ((cdns_uart_tx_empty(cdns_uart->port) !=3D TIOCSER_TEMT) &&
> +		       time_before(jiffies, time_out))
> +			cpu_relax();
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
> @@ -602,6 +713,14 @@ static void cdns_uart_start_tx(struct uart_port *po=
rt)
>  static void cdns_uart_stop_tx(struct uart_port *port)
>  {
>  	unsigned int regval;
> +	struct cdns_uart *cdns_uart =3D port->private_data;
> +
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (cdns_uart->port->rs485.delay_rts_after_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
> +
> +		cdns_rs485_rx_setup(cdns_uart);
> +	}
>
>  	regval =3D readl(port->membase + CDNS_UART_CR);
>  	regval |=3D CDNS_UART_CR_TX_DIS;
> @@ -626,21 +745,6 @@ static void cdns_uart_stop_rx(struct uart_port *por=
t)
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
> -	status =3D readl(port->membase + CDNS_UART_SR) &
> -		       (CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE);
> -	return (status =3D=3D CDNS_UART_SR_TXEMPTY) ? TIOCSER_TEMT : 0;
> -}
> -
>  /**
>   * cdns_uart_break_ctl - Based on the input ctl we have to start or sto=
p
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
> + * cdns_rs485_config - Called when an application calls TIOCSRS485 ioct=
l.
> + * @port: Pointer to the uart_port structure
> + * @termios: Pointer to the ktermios structure
> + * @rs485: Pointer to the serial_rs485 structure
> + *
> + * Return: 0
> + */
> +static int cdns_rs485_config(struct uart_port *port, struct ktermios *t=
ermios,
> +			     struct serial_rs485 *rs485)
> +{
> +	if (rs485->flags & SER_RS485_ENABLED)
> +		dev_dbg(port->dev, "Setting UART to RS485\n");
> +
> +	return 0;
> +}

So what if userspace changes the RS485 configuration? When does it take ef=
fect?

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
> @@ -1597,9 +1722,23 @@ static int cdns_uart_probe(struct platform_device=
 *pdev)
>  	port->private_data =3D cdns_uart_data;
>  	port->read_status_mask =3D CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRI=
G |
>  			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
> +	port->rs485_config =3D cdns_rs485_config;
> +	port->rs485_supported =3D cdns_rs485_supported;
>  	cdns_uart_data->port =3D port;
>  	platform_set_drvdata(pdev, port);
>
> +	rc =3D uart_get_rs485_mode(port);
> +	if (rc)
> +		goto err_out_clk_notifier;
> +
> +	cdns_uart_data->gpiod =3D devm_gpiod_get_optional(&pdev->dev, "rts",
> +							GPIOD_OUT_LOW);
> +	if (IS_ERR(cdns_uart_data->gpiod)) {
> +		rc =3D PTR_ERR(cdns_uart_data->gpiod);
> +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");

Why bail out with an error if having cdns_uart_data->gpiod is only optiona=
l?

> +		goto err_out_clk_notifier;
> +	}
> +
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT)=
;
>  	pm_runtime_set_active(&pdev->dev);
> @@ -1638,6 +1777,16 @@ static int cdns_uart_probe(struct platform_device=
 *pdev)
>  	cdns_uart_data->cts_override =3D of_property_read_bool(pdev->dev.of_no=
de,
>  							     "cts-override");
>
> +	if (cdns_uart_data->port->rs485.flags & SER_RS485_ENABLED) {
> +		if (!cdns_uart_data->gpiod) {
> +			val =3D readl(cdns_uart_data->port->membase
> +				    + CDNS_UART_MODEMCR);
> +			val |=3D CDNS_UART_MODEMCR_RTS;
> +			writel(val, cdns_uart_data->port->membase
> +			       + CDNS_UART_MODEMCR);
> +		}
> +	}

This covers the RTS_AFTER_SEND mode. What if SER_RS485_RTS_ON_SEND is conf=
igured instead
(as it is the default set by uart_get_rs485_mode())? What if cdns_uart_dat=
a->gpiod exists?
Why not simply call cdns_rs485_rx_setup() which covers all these cases?
Note that uart_add_one_port() will call into the serial core and eventuall=
y result in an
initial call to the ports rs485_config function (see uart_rs485_config()).=
 So maybe put the
initial configuration into that function and remove the above code. Howeve=
r
in this case

cdns_uart_data->cts_override =3D of_property_read_bool(pdev->dev.of_node,
							     "cts-override");
should be called before uart_add_one_port().


Regards,
Lino
