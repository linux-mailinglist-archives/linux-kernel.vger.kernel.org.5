Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F467DCB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjJaKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjJaKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:47:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE183;
        Tue, 31 Oct 2023 03:47:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466BEC433C7;
        Tue, 31 Oct 2023 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698749232;
        bh=ZmuRbV2seYSv3d+8oixIkvV1jxp6dhCpYX7zgrslYeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejByAtdYCxcTAa8g4wiPR5vquftL3cBxk3N7WJUXE+ktF3A6zBShFhCwsPqAXumDU
         i0GKeCGnTVTHJ1QFy6W1p/5lhQ6SU2FrvFbMHnMmBVNwIZatI+wR/gjTitUDe0z2dz
         U9Qa5Iro88N3u3EmuATGlEYXo90aKtHA6hQX5FkM=
Date:   Tue, 31 Oct 2023 11:47:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ronald Wahl <rwahl@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH v2] serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit
Message-ID: <2023103101-versus-tribesman-610e@gregkh>
References: <20231031102024.9973-1-rwahl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031102024.9973-1-rwahl@gmx.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:20:24AM +0100, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> This fixes commit 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX
> interrupt after DMA enable") which unfortunately set the
> UART_HAS_RHR_IT_DIS bit in the UART_OMAP_IER2 register and never
> cleared it.
> 
> Fixes: 439c7183e5b9 ("serial: 8250: 8250_omap: Disable RX interrupt after DMA enable")
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
> V2: - add Fixes: tag
>     - fix author
> 
>  drivers/tty/serial/8250/8250_omap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ca972fd37725..c7ab2963040b 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -914,7 +914,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
>  	if (priv->habit & UART_HAS_RHR_IT_DIS) {
>  		reg = serial_in(p, UART_OMAP_IER2);
>  		reg &= ~UART_OMAP_IER2_RHR_IT_DIS;
> -		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
> +		serial_out(p, UART_OMAP_IER2, reg);
>  	}
> 
>  	dmaengine_tx_status(rxchan, cookie, &state);
> @@ -1060,7 +1060,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
>  	if (priv->habit & UART_HAS_RHR_IT_DIS) {
>  		reg = serial_in(p, UART_OMAP_IER2);
>  		reg |= UART_OMAP_IER2_RHR_IT_DIS;
> -		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
> +		serial_out(p, UART_OMAP_IER2, reg);
>  	}
> 
>  	dma_async_issue_pending(dma->rxchan);
> --
> 2.41.0
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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
