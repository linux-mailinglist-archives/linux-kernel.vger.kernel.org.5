Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83D7CD148
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjJRA3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRA3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:29:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76CA4;
        Tue, 17 Oct 2023 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697588933; x=1698193733; i=linosanfilippo@gmx.de;
        bh=kPs0cEAAD7er/7MuIimw3M4hGwf1nKIAilx1GxoxzPw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:
         In-Reply-To;
        b=o8ir53hhVL134F55UnlRaD5Lgw1CX38kuAXAHfMpnK/SARMhg9wHHrdIyh05+DuC
         paQmQaKxPr36rlLYHjW2A0nKtI+X7o1kPFp7A1g/fYflT/iaF2QLtrX7Tfa8RKwvB
         ynOi9oOmq435EFHcmMOwf984RmAOQ+OnrsqF0nns7NIhkG6YzBDrI6YpThdzO7rjG
         lzV2Vhih4HSOcnMY9dftQvjZvi6F/aiD3aifXwSQKAFFQv6Q5K5sYfaR4ke0pzmX3
         OKM+gvLt+6T5qf6Psiv1LbB7/T5XRjQAnu693FCZlmUshdIXHiuystbiOteMZIarB
         huROqPtbnivlVawYdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.21.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1rPE6w2DQR-00cROj; Wed, 18
 Oct 2023 02:28:53 +0200
Subject: Re: [PATCH V2 2/2] tty: serial: uartps: Add rs485 support to uartps
 driver
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
        michal.simek@amd.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
        shubhrajyoti.datta@amd.com, manion05gk@gmail.com
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
 <20231011145602.3619616-3-manikanta.guntupalli@amd.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <cb663c4d-b9b7-9c9b-1566-02c41dd01425@gmx.de>
Date:   Wed, 18 Oct 2023 02:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20231011145602.3619616-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vRMakVEVvjcV/ODbZycIfaTSkWvcPNTKMk7G+ix13++DlVAzjwE
 SzzwNHu9mG8eNfk0J2VzLjLctlcKIgHtMbh4F5b6yuAfqBsJXW9rcCCRdv7POyBJDt5KcaQ
 yt8F7gtflLrOcRQzMy+mupPP+fOVqUt+e9J3jce5riH1sawFeJXiPKx4MLdoScXfkZuqSXg
 0PdUB+0u3RcEKhLb0RFMg==
UI-OutboundReport: notjunk:1;M01:P0:7JpT6JrJF9I=;6heus26Ioh/HlByf86XkG/1CpGZ
 ZD3qDACmO9A9LnS+ItBISgS05dE9nOrWY+XfJlE3kYUZXLSDpZ0Wj5QvjRsIh5RBCY+eqdJvB
 qfi4AnFDsJ1wwn8E0KNEIxwzNwkIMsPLU14Qto726yXieGw+2mtUVOgqL1NvOJtC/3bf98wnB
 ajGwnpdo70q3gTjFCQ5rWxVzX0kH7IibVMgpy6d9wIu4ShAcqYi04CmpAqHUIWz0E26X63b7u
 lb7gCqf6+b/3vEHk8stFg0lK0IGTnfzVH4eimNetwdGBboIzUvfzt4ucxAGh+G4oOx2WcmeeK
 Gd0CKfb2TZ+1s+5trWtg0T/pR+MvWMQd21QdUtW9M8E+rF6OSiOV/4DNu/ebIsoVxsOVDL5Zt
 t8CDb1oXML/OU3CJezR3YFpvIkpGJnChBQEQvcw8CSaw5L8I1vxKaoUs+XxWzlQxySzdN8Kpk
 4Cf7vq4Q31sy/2o8B4J9IIw83+XaLsAEoU1H3DGAHMPnE0D7pe7DXrECqbJdXXqDQZmp7WNjh
 fA1L7/veUmDdcO5rmpCZzJmLrt9qJtpdYLO3Dhrk48euMHjsLU7GdlJUzXwQzP8pv1wHps7hu
 S4w+nXiAyHh6AXjc+PBK9NouopyW5Jk4xZ8+yoX8R7+9j/l9rQoVyA83lzhpbSs4D9HzY3f8B
 zao5gaz62dYW7m0FXrMRVB093hNRvNmSdzZjtbS/naVDVlJAa5vkHa7om2MamqRDHDY5+ip8A
 9tUV18+rMpaq5Bl/G3mXig3s2xnNOQ9OIoVsZX335Xdck1/ZvQ9hJflw0EI8wsIXd0UPgJIc7
 iMXMS561eG2/VAlbxGj6Wec9pZnRy69nuTIYvygtTkpGDB0JAlIxXltcq4xnSVVprKoM5MQDd
 BX/rDPFGcB66Mvu1W+TWrZEoApyQwHnWAJkeY9VOU2TtChh+SNB3tff1XRcPuGYED1b+H58A6
 abVqBw==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.23 at 16:56, Manikanta Guntupalli wrote:
> In RS485 half duplex configuration, DriverEnable and ReceiverEnable
> shorted to each other, and at a time, any node acts as either a driver
> or a receiver. Use either xlnx,phy-ctrl-gpios or RTS to control
> RS485 phy as driver or a receiver.

This is a very specific hardware setup. RS485 is supposed to work with var=
ious
hardware configurations though. So the above assumptions must not be hardc=
oded
in the RS485 implementation (as it is in cdns_rs485_rx_setup() and cdns_rs=
485_tx_setup()
IIUC)

>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Modify optional gpio name to xlnx,phy-ctrl-gpios.
> Update commit description.
> Add support for RTS, delay_rts_before_send and delay_rts_after_send in R=
S485 mode.
> ---
>  drivers/tty/serial/xilinx_uartps.c | 116 ++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xil=
inx_uartps.c
> index 8e521c69a959..abddcf1a8bf4 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/iopoll.h>
> +#include <linux/gpio.h>
>
>  #define CDNS_UART_TTY_NAME	"ttyPS"
>  #define CDNS_UART_NAME		"xuartps"
> @@ -193,6 +194,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
>   * @clk_rate_change_nb:	Notifier block for clock changes
>   * @quirks:		Flags for RXBS support.
>   * @cts_override:	Modem control state override
> + * @gpiod:		Pointer to the gpio descriptor
>   */
>  struct cdns_uart {
>  	struct uart_port	*port;
> @@ -203,10 +205,19 @@ struct cdns_uart {
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
> @@ -305,6 +316,42 @@ static void cdns_uart_handle_rx(void *dev_id, unsig=
ned int isrstatus)
>  	tty_flip_buffer_push(&port->state->port);
>  }
>
> +/**
> + * cdns_rs485_tx_setup - Tx setup specific to rs485
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_tx_setup(struct cdns_uart *cdns_uart)
> +{
> +	u32 val;
> +
> +	if (cdns_uart->gpiod) {

If both RTS_ON_SEND and RTS_AFTER_SEND are supported than you have to set =
the
GPIO value here depending on which one is currently configured. Note that
userspace may change RTS mode via TIOCSRS485 ioctl.

> +		gpiod_set_value(cdns_uart->gpiod, 1);
> +	} else {
> +		val =3D readl(cdns_uart->port->membase + CDNS_UART_MODEMCR);
> +		val &=3D ~CDNS_UART_MODEMCR_RTS;
> +		writel(val, cdns_uart->port->membase + CDNS_UART_MODEMCR);

Same for the native RTS case.

> +	}
> +}
> +
> +/**
> + * cdns_rs485_rx_setup - Rx setup specific to rs485
> + * @cdns_uart: Handle to the cdns_uart
> + */
> +static void cdns_rs485_rx_setup(struct cdns_uart *cdns_uart)
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

See above.


> +}
> +
> +static unsigned int cdns_uart_tx_empty(struct uart_port *port);
> +
>  /**
>   * cdns_uart_handle_tx - Handle the bytes to be Txed.
>   * @dev_id: Id of the UART port
> @@ -313,12 +360,20 @@ static void cdns_uart_handle_rx(void *dev_id, unsi=
gned int isrstatus)
>  static void cdns_uart_handle_tx(void *dev_id)
>  {
>  	struct uart_port *port =3D (struct uart_port *)dev_id;
> +	struct cdns_uart *cdns_uart =3D port->private_data;
>  	struct circ_buf *xmit =3D &port->state->xmit;
> +	unsigned long time_out;
>  	unsigned int numbytes;
>
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		cdns_rs485_tx_setup(cdns_uart);
> +		if (cdns_uart->port->rs485.delay_rts_before_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_before_send);
> +	}
> +
>  	if (uart_circ_empty(xmit)) {
>  		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
> -		return;
> +		goto rs485_rx_setup;
>  	}
>
>  	numbytes =3D port->fifosize;
> @@ -332,6 +387,23 @@ static void cdns_uart_handle_tx(void *dev_id)
>
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
> +
> +rs485_rx_setup:
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
> +		time_out =3D jiffies + usecs_to_jiffies(TX_TIMEOUT);
> +		/* Wait for tx completion */
> +		while ((cdns_uart_tx_empty(cdns_uart->port) !=3D TIOCSER_TEMT) &&
> +		       time_before(jiffies, time_out))
> +			cpu_relax();
> +
> +		/*
> +		 * Default Rx should be setup, because RX signaling path
> +		 * need to enable to receive data.
> +		 */
> +		cdns_rs485_rx_setup(cdns_uart);
> +		if (cdns_uart->port->rs485.delay_rts_after_send)
> +			mdelay(cdns_uart->port->rs485.delay_rts_after_send);
> +	}
>  }
>
>  /**
> @@ -829,6 +901,9 @@ static int cdns_uart_startup(struct uart_port *port)
>  		(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST))
>  		cpu_relax();
>
> +	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED)
> +		cdns_rs485_rx_setup(cdns_uart);
> +
>  	/*
>  	 * Clear the RX disable bit and then set the RX enable bit to enable
>  	 * the receiver.
> @@ -1455,6 +1530,25 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
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
> +	port->rs485 =3D *rs485;
> +

This assignment is not needed, the serial core will do that.

> +	if (rs485->flags & SER_RS485_ENABLED)
> +		dev_dbg(port->dev, "Setting UART to RS485\n");
> +
> +	return 0;
> +}
> +
>  /**
>   * cdns_uart_probe - Platform driver probe
>   * @pdev: Pointer to the platform device structure
> @@ -1597,9 +1691,28 @@ static int cdns_uart_probe(struct platform_device=
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
> +	cdns_uart_data->gpiod =3D devm_gpiod_get_optional(&pdev->dev, "xlnx,ph=
y-ctrl",
> +							GPIOD_OUT_LOW);
> +	if (IS_ERR(cdns_uart_data->gpiod)) {
> +		rc =3D PTR_ERR(cdns_uart_data->gpiod);
> +		dev_err(port->dev, "xuartps: devm_gpiod_get_optional failed\n");
> +		goto err_out_clk_notifier;
> +	}
> +

If using the GPIO is optional, why not fall back to the use of the native =
RTS?

> +	if (cdns_uart_data->gpiod) {
> +		gpiod_direction_output(cdns_uart_data->gpiod, GPIOD_OUT_LOW);
> +		gpiod_set_value(cdns_uart_data->gpiod, 0);

You already set both of these attributes when you requested the GPIO.

> +	}
> +
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT)=
;
>  	pm_runtime_set_active(&pdev->dev);
> @@ -1646,6 +1759,7 @@ static int cdns_uart_probe(struct platform_device =
*pdev)
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +err_out_clk_notifier:
>  #ifdef CONFIG_COMMON_CLK
>  	clk_notifier_unregister(cdns_uart_data->uartclk,
>  			&cdns_uart_data->clk_rate_change_nb);
>

Regards,
Lino
