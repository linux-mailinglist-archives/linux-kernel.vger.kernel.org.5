Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B633E781365
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379640AbjHRThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379677AbjHRThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2A1FCE;
        Fri, 18 Aug 2023 12:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9499061D1F;
        Fri, 18 Aug 2023 19:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11FC433C7;
        Fri, 18 Aug 2023 19:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692387434;
        bh=GRnDsiZDIrTxnnQBnvKXLxV8C2MgIDJvy4PYddFPUSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mGGbcRJSIx6/jRcrk9SaDr0pI/QnX+WxRGAC/HKLcBpehlCrfFXYp/j3FbdDolDRc
         vqAsUouGZnk5+W9NvAz5H+7RTAfTG8hQYIOjcN37laQlTKnzwtdY0RwH1lHiiKDsdT
         DWOTwOq2Obr5Fk1RE12ASbeKk3IkcDrmCsVAXUVE=
Date:   Fri, 18 Aug 2023 21:37:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <2023081859-contact-commuting-5d70@gregkh>
References: <1692306801-13191-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692306801-13191-1-git-send-email-justin.chen@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:13:18PM -0700, Justin Chen wrote:
> The 8250 BCM7271 UART is not a direct match to PORT_16550A and other
> generic ports do not match its hardware capabilities. PORT_ALTR matches
> the rx trigger levels, but its vendor configurations are not compatible.
> Unfortunately this means we need to create another port to fully capture
> the hardware capabilities of the BCM7271 UART.
> 
> To alleviate some latency pressures, we default the rx trigger level to 8.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Acked-by: Doug Berger <opendmb@gmail.com>
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
> index 16aeb1420137..9f05745e221b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -322,6 +322,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes   = {2, 66, 130, 194},
>  		.flags          = UART_CAP_FIFO,
>  	},
> +	[PORT_BCM7271] = {
> +		.name		= "Broadcom BCM7271 UART",
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
> index 281fa286555c..9646629496ab 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -144,6 +144,9 @@
>  /* Blackfin bf5xx */
>  #define PORT_BFIN	75
>  
> +/* Broadcom BCM7271 UART */
> +#define PORT_BCM7271    76
> +
>  /* Broadcom SB1250, etc. SOC */
>  #define PORT_SB1250_DUART	77
>  
> -- 
> 2.7.4
> 



Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
