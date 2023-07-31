Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C539769B53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjGaPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGaPwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8C1713;
        Mon, 31 Jul 2023 08:52:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F78611B6;
        Mon, 31 Jul 2023 15:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD72C433C7;
        Mon, 31 Jul 2023 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690818749;
        bh=lKEFTpJ7QnKtXZmNh6BU0LSStWE7LBVzT3jA1H66E8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uiadaHaYCCnbNGfobUYY9yh2phrkolxwMmuH6XnjmVzLSSnWBConfxnU3wPh55rLg
         rEDJX+JqiCNfjnb/chn3Q+KQuUGJBQpcxxzf5gajwZRoNYvGOnWnqo3OTU9SCNEu8O
         HEb85RML1fDxzk10gggVUfjb+JVkfjERVzOsD0iI=
Date:   Mon, 31 Jul 2023 17:52:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Subject: Re: [PATCH v9 01/10] serial: sc16is7xx: fix broken port 0 uart init
Message-ID: <2023073148-marshy-extenuate-2d45@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
 <20230725142343.1724130-2-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725142343.1724130-2-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:23:33AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The sc16is7xx_config_rs485() function is called only for the second
> port (index 1, channel B), causing initialization problems for the
> first port.
> 
> For the sc16is7xx driver, port->membase and port->mapbase are not set,
> and their default values are 0. And we set port->iobase to the device
> index. This means that when the first device is registered using the
> uart_add_one_port() function, the following values will be in the port
> structure:
>     port->membase = 0
>     port->mapbase = 0
>     port->iobase  = 0
> 
> Therefore, the function uart_configure_port() in serial_core.c will
> exit early because of the following check:
> 	/*
> 	 * If there isn't a port here, don't do anything further.
> 	 */
> 	if (!port->iobase && !port->mapbase && !port->membase)
> 		return;
> 
> Typically, I2C and SPI drivers do not set port->membase and
> port->mapbase.
> 
> The max310x driver sets port->membase to ~0 (all ones). By
> implementing the same change in this driver, uart_configure_port() is
> now correctly executed for all ports.
> 
> Fixes: dfeae619d781 ("serial: sc16is7xx")

That commit is in a very old 3.x release.

> Cc: <stable@vger.kernel.org> # 6.1.x

But you say this should only go to 6.1.y?  Why?  What is wrong with the
older kernels?

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 2e7e7c409cf2..8ae2afc76a9b 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1436,6 +1436,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
>  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
>  		s->p[i].port.iobase	= i;
> +		s->p[i].port.membase	= (void __iomem *)~0;

That's a magic value, some comment should be added here to explain why
setting all bits is ok.  Why does this work exactly?  You only say that
the max310x driver does this, but not why it does this at all.

confused,

greg k-h
