Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5956C7DCB1E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjJaKr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjJaKr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:47:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7083;
        Tue, 31 Oct 2023 03:47:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D2C433C8;
        Tue, 31 Oct 2023 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698749273;
        bh=iF3C2e7LZaWn1k2ko938GDKkj0Hq9IqXqcDNFWqyPV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnnnGIc8En8kNKMwc4Mb1QKIENm0X9/WDtHWlvzJ5TCpG0hdwN37zNDRi5cUFqnJO
         xUjkHFxNCoBnIN6IIRbhs25TjMdF8kLgJCMhTPtGj8aTq51MaAOf785U8wBN6rwG4v
         sdzgXVVL2Ze48MeQSbUU8t5pJpTmh2xNWApYBYn8=
Date:   Tue, 31 Oct 2023 11:47:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ronald Wahl <rwahl@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: Re: [PATCH v2] serial: 8250: 8250_omap: Do not start RX DMA on THRI
 interrupt
Message-ID: <2023103137-sushi-playgroup-c2a5@gregkh>
References: <20231031102220.9997-1-rwahl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031102220.9997-1-rwahl@gmx.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 11:22:20AM +0100, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> Starting RX DMA on THRI interrupt is too early because TX may not have
> finished yet.
> 
> This change is inspired by commit 90b8596ac460 ("serial: 8250: Prevent
> starting up DMA Rx on THRI interrupt") and fixes DMA issues I had with
> an AM62 SoC that is using the 8250 OMAP variant.
> 
> Fixes: c26389f998a8 ("serial: 8250: 8250_omap: Add DMA support for UARTs on K3 SoCs")
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
> V2: - add Fixes: tag
>     - fix author
> 
>  drivers/tty/serial/8250/8250_omap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index c7ab2963040b..f2f59ec6b50b 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1282,10 +1282,11 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
> 
>  	status = serial_port_in(port, UART_LSR);
> 
> -	if (priv->habit & UART_HAS_EFR2)
> -		am654_8250_handle_rx_dma(up, iir, status);
> -	else
> -		status = omap_8250_handle_rx_dma(up, iir, status);
> +	if ((iir & 0x3f) != UART_IIR_THRI)
> +		if (priv->habit & UART_HAS_EFR2)
> +			am654_8250_handle_rx_dma(up, iir, status);
> +		else
> +			status = omap_8250_handle_rx_dma(up, iir, status);
> 
>  	serial8250_modem_status(up);
>  	if (status & UART_LSR_THRE && up->dma->tx_err) {
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
