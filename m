Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD1779F57
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjHLKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHLKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E535B1;
        Sat, 12 Aug 2023 03:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4F9463814;
        Sat, 12 Aug 2023 10:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957DFC433C8;
        Sat, 12 Aug 2023 10:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691837448;
        bh=i5aKrqJF82Za0FYZk+bsOk/F6cJbt1imYmY9lcQzpBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKvBiBnddgm9GpVdyr19x3K43EviktrHFzBy4dAC68toXy7SwJdFhpq5RbQPG3Gew
         RnI2GVIXldtt+I4ANNOQKKXHdNrVxEpHt7vnlOVQ/UHf0JEKeDyiEYpnUTfost9g9+
         XfYQxsUW8EYYM6TbDVa621XmdwgWrU97vrKnrR7Y=
Date:   Sat, 12 Aug 2023 12:50:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     linux-serial@vger.kernel.org, opendmb@gmail.com,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <2023081221-truth-footsie-b5ab@gregkh>
References: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:14:01PM -0700, Justin Chen wrote:
> The 8250 bcm7271 UART is not a direct match to PORT_16550A. The
> Fifo is 32 and rxtrig values are {1, 8, 16, 30}. Create a PORT_BCM7271
> to better capture the HW CAPS.
> 
> Default the rxtrig level to 8.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/tty/serial/8250/8250_bcm7271.c | 4 +---
>  drivers/tty/serial/8250/8250_port.c    | 8 ++++++++
>  include/uapi/linux/serial_core.h       | 3 +++
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
> index d4b05d7ad9e8..aa5aff046756 100644
> --- a/drivers/tty/serial/8250/8250_bcm7271.c
> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> @@ -1042,7 +1042,7 @@ static int brcmuart_probe(struct platform_device *pdev)
>  	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
>  
>  	memset(&up, 0, sizeof(up));
> -	up.port.type = PORT_16550A;
> +	up.port.type = PORT_BCM7271;
>  	up.port.uartclk = clk_rate;
>  	up.port.dev = dev;
>  	up.port.mapbase = mapbase;
> @@ -1056,8 +1056,6 @@ static int brcmuart_probe(struct platform_device *pdev)
>  		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
>  	up.port.dev = dev;
>  	up.port.private_data = priv;
> -	up.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
> -	up.port.fifosize = 32;
>  
>  	/* Check for a fixed line number */
>  	ret = of_alias_get_id(np, "serial");
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 16aeb1420137..a6259a264041 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -322,6 +322,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes   = {2, 66, 130, 194},
>  		.flags          = UART_CAP_FIFO,
>  	},
> +	[PORT_BCM7271] = {
> +		.name		= "bcm7271_uart",
> +		.fifo_size	= 32,
> +		.tx_loadsz	= 32,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> +		.rxtrig_bytes	= {1, 8, 16, 30},
> +		.flags		= UART_CAP_FIFO | UART_CAP_AFE
> +	},
>  };
>  
>  /* Uart divisor latch read */
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 281fa286555c..369f845a3d1d 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -279,4 +279,7 @@
>  /* Sunplus UART */
>  #define PORT_SUNPLUS	123
>  
> +/* Broadcom 7271 UART */
> +#define PORT_BCM7271    124

Why is this new id required?  What in userspace is going to use it and
why can't the generic value be used instead?

thanks,

greg k-h
