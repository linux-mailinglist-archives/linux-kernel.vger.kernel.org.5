Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA77B6993
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjJCM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJCM4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:56:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4032DB8;
        Tue,  3 Oct 2023 05:56:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E43C433C7;
        Tue,  3 Oct 2023 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696337766;
        bh=P59DIcTo4FzG58FgS8nftjaP4bwHuF5VoRmUVEhZMPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0eREALR8VLdselMS61TC2lTtnDrh36evlgLQL8Iawi3p1KRu7WY/ivxtWvsIZQzuS
         78twgbM3ck7Nn97GeX3k8BiHm4Mlop3yiEE/l3mpEqCFVLrwOvbHb+wCfk3C37oyFq
         z5lIRsM/Dox4yZ7nSSjY8CRkwkjMqh83vfAPEwS8=
Date:   Tue, 3 Oct 2023 14:56:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 3/5] drivers/tty/serial: add driver for the ESP32 UART
Message-ID: <2023100348-visitor-browse-3142@gregkh>
References: <20230928151631.149333-1-jcmvbkbc@gmail.com>
 <20230928151631.149333-4-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928151631.149333-4-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 08:16:29AM -0700, Max Filippov wrote:
> Add driver for the UART controllers of the Espressif ESP32 and ESP32S3
> SoCs. Hardware specification is available at the following URLs:
> 
>   https://www.espressif.com/sites/default/files/documentation/esp32_technical_reference_manual_en.pdf
>   (Chapter 13 UART Controller)
>   https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf
>   (Chapter 26 UART Controller)
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - rework brk handling in esp32_uart_rxint
> - only increment port->icount.rx in case insert_flip_char() is called
> - use HZ instead of msecs_to_jiffies(1000) in esp32_uart_put_char_sync
> - add early return to esp32_uart_transmit_buffer
> - use request_irq/free_irq instead of devm_* versions
> - add blank lines before certain return statements
> 
> Changes v1->v2:
> - redefine register fields using BIT and GENMASK
> - drop _MASK suffix from register field definitions
> - drop *_SHIFT definitions where possible
> - drop unused rxfifo_full_thrhd_mask and txfifo_empty_thrhd_mask
> - split register reads/writes and bitwise operations into multiple lines
> - use u8 instead of unsigned char in internal functions
> - add timeout to esp32_uart_put_char_sync
> - use uart_port_tx_limited in esp32_uart_transmit_buffer
> - use IRQ_RETVAL in esp32_uart_int
> - disable clock in esp32_uart_startup in case devm_request_irq fails
> - rearrange devm_request_irq with enabling IRQs in the UART registers
> - drop empty esp32_uart_release_port and esp32_uart_request_port
> - simplify esp32_uart_tx_empty
> - mask out unsupported CMSPAR flag in termios->c_cflag in
>   esp32_uart_set_termios
> - invoke uart_update_timeout in esp32_uart_set_termios
> - drop MODULE_DESCRIPTION
> - rearrange esp32_uart_set_baud: return bool indicating whether baud
>   rate was set or not, use it in the esp32_uart_set_termios to set the
>   default 115200
> - turn 'locked' into bool in esp32_uart_console_write
> - turn num_read into unsigned int in esp32_uart_earlycon_read
> 
>  drivers/tty/serial/Kconfig       |  13 +
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/esp32_uart.c  | 741 +++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 758 insertions(+)
>  create mode 100644 drivers/tty/serial/esp32_uart.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index bdc568a4ab66..d9ca6b268f01 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1578,6 +1578,19 @@ config SERIAL_NUVOTON_MA35D1_CONSOLE
>  	  but you can alter that using a kernel command line option such as
>  	  "console=ttyNVTx".
>  
> +config SERIAL_ESP32
> +	tristate "Espressif ESP32 UART support"
> +	depends on XTENSA_PLATFORM_ESP32 || (COMPILE_TEST && OF)
> +	select SERIAL_CORE
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	help
> +	  Driver for the UART controllers of the Espressif ESP32xx SoCs.
> +	  When earlycon option is enabled the following kernel command line
> +	  snippets may be used:
> +	    earlycon=esp32s3uart,mmio32,0x60000000,115200n8,40000000
> +	    earlycon=esp32uart,mmio32,0x3ff40000,115200n8
> +
>  endmenu
>  
>  config SERIAL_MCTRL_GPIO
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 138abbc89738..7b73137df7f3 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
>  obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
>  obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
>  obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
> +obj-$(CONFIG_SERIAL_ESP32)	+= esp32_uart.o
>  
>  # GPIOLIB helpers for modem control lines
>  obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
> diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
> new file mode 100644
> index 000000000000..bb5471e8b6b6
> --- /dev/null
> +++ b/drivers/tty/serial/esp32_uart.c
> @@ -0,0 +1,741 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Same license and copyright question as I had on the ACM patch.

thanks,

greg k-h
