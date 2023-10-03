Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E723B7B6990
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjJCMzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJCMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:55:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D69BB;
        Tue,  3 Oct 2023 05:55:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4032C433C7;
        Tue,  3 Oct 2023 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696337744;
        bh=P5HAuBgxGI7bLQdS/saddx7K+nwsRkflpdceF8t9ZAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wH/Iwdc7gbCmfe4iekNoygjRVVzdsJCWkZ4QMi4rKni7WKMwRAMBCtajMm3EfcLsG
         J8drX2Y+/V+oRW6+l/ODC3B9sPYJy6weVIB6SXNIvSDj6hhBP679wJTHUOwOC41iGS
         TI2IypZGfZwVK7AO8skVqcqUd9UtIV3qIHTX6XOI=
Date:   Tue, 3 Oct 2023 14:55:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 5/5] drivers/tty/serial: add ESP32S3 ACM device driver
Message-ID: <2023100326-crushing-septic-4856@gregkh>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
 <20230928151631.149333-6-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151631.149333-6-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 08:16:31AM -0700, Max Filippov wrote:
> Add driver for the ACM  controller of the Espressif ESP32S3 Soc.

Odd extra space :(

> Hardware specification is available at the following URL:
> 
>   https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
>   (Chapter 33 USB Serial/JTAG Controller)

I don't understand this driver, "ACM" is a USB host <-> gadget protocol,
why do you need a platform serial driver for this?

> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - use HZ instead of msecs_to_jiffies(1000) in esp32_acm_put_char_sync
> - add early return to esp32_acm_transmit_buffer
> - use request_irq/free_irq instead of devm_* versions
> 
> Changes v1->v2:
> - redefine register fields using BIT and GENMASK
> - drop _MASK suffix from register field definitions
> - drop *_SHIFT definitions where possible
> - split register reads/writes and bitwise operations into multiple lines
> - use u8 instead of unsigned char in internal functions
> - add timeout to esp32_acm_put_char_sync
> - use uart_port_tx_limited in esp32_acm_transmit_buffer
> - use IRQ_RETVAL in esp32_acm_int
> - drop esp32s3_acm_console_putchar and esp32s3_acm_earlycon_putchar
> - turn num_read into unsigned int in esp32_acm_earlycon_read
> - drop MODULE_DESCRIPTION
> 
>  drivers/tty/serial/Kconfig       |  14 +
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/esp32_acm.c   | 459 +++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 477 insertions(+)
>  create mode 100644 drivers/tty/serial/esp32_acm.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index d9ca6b268f01..85807db8f7ce 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1591,6 +1591,20 @@ config SERIAL_ESP32
>  	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
>  	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
>  
> +config SERIAL_ESP32_ACM
> +	tristate "Espressif ESP32 USB ACM support"
> +	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
> +	select SERIAL_CORE
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	help
> +	  Driver for the CDC ACM controllers of the Espressif ESP32S3 SoCs
> +	  that share separate USB controller with the JTAG adapter.
> +	  The device name used for this controller is ttyACM.
> +	  When earlycon option is enabled the following kernel command line
> +	  snippet may be used:
> +	    earlycon=esp32s3acm,mmio32,0x60038000
> +
>  endmenu
>  
>  config SERIAL_MCTRL_GPIO
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 7b73137df7f3..970a292ca418 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
>  obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
>  obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
>  obj-$(CONFIG_SERIAL_ESP32)	+= esp32_uart.o
> +obj-$(CONFIG_SERIAL_ESP32_ACM)	+= esp32_acm.o
>  
>  # GPIOLIB helpers for modem control lines
>  obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
> diff --git a/drivers/tty/serial/esp32_acm.c b/drivers/tty/serial/esp32_acm.c
> new file mode 100644
> index 000000000000..f02abd2ac65e
> --- /dev/null
> +++ b/drivers/tty/serial/esp32_acm.c
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Why "or later"?  I have to ask, sorry.

And no copyright information?  That's fine, but be sure your company's
lawyers are ok with it...

> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/console.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/tty_flip.h>
> +#include <asm/serial.h>
> +
> +#define DRIVER_NAME	"esp32s3-acm"
> +#define DEV_NAME	"ttyACM"

There is already a ttyACM driver in the kernel, will this conflict with
that one?  And are you using the same major/minor numbers for it as
well?  If so, how is this going to work?

> +#define UART_NR		4
> +
> +#define ESP32S3_ACM_TX_FIFO_SIZE	64
> +
> +#define USB_SERIAL_JTAG_EP1_REG		0x00
> +#define USB_SERIAL_JTAG_EP1_CONF_REG	0x04
> +#define USB_SERIAL_JTAG_WR_DONE				BIT(0)
> +#define USB_SERIAL_JTAG_SERIAL_IN_EP_DATA_FREE		BIT(1)
> +#define USB_SERIAL_JTAG_INT_ST_REG	0x0c
> +#define USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ST	BIT(2)
> +#define USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ST		BIT(3)
> +#define USB_SERIAL_JTAG_INT_ENA_REG	0x10
> +#define USB_SERIAL_JTAG_SERIAL_OUT_RECV_PKT_INT_ENA	BIT(2)
> +#define USB_SERIAL_JTAG_SERIAL_IN_EMPTY_INT_ENA		BIT(3)
> +#define USB_SERIAL_JTAG_INT_CLR_REG	0x14
> +#define USB_SERIAL_JTAG_IN_EP1_ST_REG	0x2c
> +#define USB_SERIAL_JTAG_IN_EP1_WR_ADDR			GENMASK(8, 2)
> +#define USB_SERIAL_JTAG_OUT_EP1_ST_REG	0x3c
> +#define USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT		GENMASK(22, 16)
> +
> +static const struct of_device_id esp32s3_acm_dt_ids[] = {
> +	{
> +		.compatible = "esp,esp32s3-acm",
> +	}, { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, esp32s3_acm_dt_ids);
> +
> +static struct uart_port *esp32s3_acm_ports[UART_NR];
> +
> +static void esp32s3_acm_write(struct uart_port *port, unsigned long reg, u32 v)
> +{
> +	writel(v, port->membase + reg);
> +}
> +
> +static u32 esp32s3_acm_read(struct uart_port *port, unsigned long reg)
> +{
> +	return readl(port->membase + reg);
> +}
> +
> +static u32 esp32s3_acm_tx_fifo_free(struct uart_port *port)
> +{
> +	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_EP1_CONF_REG);
> +
> +	return status & USB_SERIAL_JTAG_SERIAL_IN_EP_DATA_FREE;
> +}
> +
> +static u32 esp32s3_acm_tx_fifo_cnt(struct uart_port *port)
> +{
> +	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_IN_EP1_ST_REG);
> +
> +	return FIELD_GET(USB_SERIAL_JTAG_IN_EP1_WR_ADDR, status);
> +}
> +
> +static u32 esp32s3_acm_rx_fifo_cnt(struct uart_port *port)
> +{
> +	u32 status = esp32s3_acm_read(port, USB_SERIAL_JTAG_OUT_EP1_ST_REG);
> +
> +	return FIELD_GET(USB_SERIAL_JTAG_OUT_EP1_REC_DATA_CNT, status);
> +}
> +
> +/* return TIOCSER_TEMT when transmitter is not busy */
> +static unsigned int esp32s3_acm_tx_empty(struct uart_port *port)
> +{
> +	return esp32s3_acm_tx_fifo_cnt(port) == 0 ? TIOCSER_TEMT : 0;
> +}
> +
> +static void esp32s3_acm_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +}

Do you have to have empty functions for callbacks that do nothing?

> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -248,4 +248,7 @@
>  /* Espressif ESP32 UART */
>  #define PORT_ESP32UART	124
>  
> +/* Espressif ESP32 ACM */
> +#define PORT_ESP32ACM	125

Why are these defines needed?  What in userspace is going to require
them?  If nothing, please do not add them.

thanks,

greg k-h
