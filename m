Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18EE7F6551
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbjKWRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbjKWRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:22:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6B10E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:22:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F4C433CB;
        Thu, 23 Nov 2023 17:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700760173;
        bh=G7RyxxldpkBta3vjct+FTHwrUBS7ezgm7MJZlLcquUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gz8ck2NUUbXG+PzqfOcq33AsfzDljII7eysMOLTTMy3hDr/Z3q+A74NRiCwqAWrWP
         uIwYHEYFtPjdbaKt+x7xe5wPHvAMbDH7suKmepHmuVcI36CzZD5IjE+csqZoXNt1ng
         ziD60vpp1Nce1pZ6dmWeODP3LwZ76FXx0TLZi6zo=
Date:   Thu, 23 Nov 2023 14:14:47 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Paukrt <tomaspaukrt@email.cz>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] serial: core: Add option to enable RS485 mode via
 GPIO
Message-ID: <2023112323-masculine-map-642d@gregkh>
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
 <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
 <2cZ.ZZqF.1YADr1CLFoQ.1bMn3d@seznam.cz>
 <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
 <3Nj.ZZr}.5RaPRe7D8AB.1bMzDm@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3Nj.ZZr}.5RaPRe7D8AB.1bMzDm@seznam.cz>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 10:45:20PM +0100, Tomas Paukrt wrote:
> Add an option to enable the RS485 mode at boot time based on
> the state of a GPIO pin (DIP switch or configuration jumper).
> The GPIO is defined by the device tree property "rs485-mode-gpio".
> 
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  drivers/tty/serial/serial_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f1348a5..f1bf0b9 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3603,6 +3603,18 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	}
> 
>  	/*
> +	 * Enable the RS485 mode based on the state of a GPIO pin.
> +	 */
> +	desc = devm_gpiod_get_optional(dev, "rs485-mode", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-mode-gpio\n");
> +	if (desc) {
> +		if (gpiod_get_value(desc))
> +			rs485conf->flags |= SER_RS485_ENABLED;
> +		devm_gpiod_put(dev, desc);
> +	}
> +
> +	/*
>  	 * Disabling termination by default is the safe choice:  Else if many
>  	 * bus participants enable it, no communication is possible at all.
>  	 * Works fine for short cables and users may enable for longer cables.
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
