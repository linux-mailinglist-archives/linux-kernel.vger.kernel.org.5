Return-Path: <linux-kernel+bounces-80196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA37862BA8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C61F216CC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63217BA0;
	Sun, 25 Feb 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GmF73RUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2751759E;
	Sun, 25 Feb 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877693; cv=none; b=Dd7eMfsi1ntW5mUsWIyKaYpdFf1GYM+mJpMyEHqQLGuG6YBH0bcUudj8yp1m0qHAA7L37CjXzysEIWI9eOTX6ipTZoLKXSDkDckm1EnEyyc75doOJyWUqfyzcLt08oTHQvqdiOJqy7cKPoUTspdrhGTLHA+RGFgRzyuYltu6lmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877693; c=relaxed/simple;
	bh=dCsBiSkwD7jwvTPXIamVXAx6k4Hr4GSxdeP32RRacfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaTbKQNKUlP1laJONG5LWyvUu3bPQlZyrr2qXwuiGU5854IJ/O4CB1Cmk+XNe2tl2/VY4PgH31lxxfqAMYDfb7OpfVpOzrv7Uv06EbWK80Di+GuQTISeDLzt0XCnJiBSUmn32GxvRIx2xdIGHRnO3zJjWjDAdjbcsWqhNhQMTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GmF73RUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C1DC433C7;
	Sun, 25 Feb 2024 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708877692;
	bh=dCsBiSkwD7jwvTPXIamVXAx6k4Hr4GSxdeP32RRacfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmF73RUrSeYAaZFww0eLj6mm9+yGCvi0DeuCsdGRjsJoo7DkJ6I4Y9TGACCAkzG9j
	 cZiUrfBFYHopHyalAyNWe9OuNPAAn2j7HAt/MbgQVXIf0J/xUoUmEchST7QTL9riES
	 TvL1ZccFvDicUlIVo3HS2Ic6dqWG/jnqyrrDyAoM=
Date: Sun, 25 Feb 2024 17:14:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 2/2] serial: bcm63xx-uart: fix tx after conversion to
 uart_port_tx_limited()
Message-ID: <2024022537-sprite-vocalize-fe3f@gregkh>
References: <20240225151426.1342285-1-jonas.gorski@gmail.com>
 <20240225151426.1342285-2-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225151426.1342285-2-jonas.gorski@gmail.com>

On Sun, Feb 25, 2024 at 04:14:26PM +0100, Jonas Gorski wrote:
> When bcm63xx-uart was converted to uart_port_tx_limited(), it implicitly
> added a call to stop_tx(). This causes garbage to be put out on the
> serial console. To fix this, pass UART_TX_NOSTOP in flags, and manually
> call stop_tx() ourselves analogue to how a similar issue was fixed in
> commit 7be50f2e8f20 ("serial: mxs-auart: fix tx").
> 
> Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/tty/serial/bcm63xx_uart.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
> index a3cefa153456..259fe5895032 100644
> --- a/drivers/tty/serial/bcm63xx_uart.c
> +++ b/drivers/tty/serial/bcm63xx_uart.c
> @@ -309,8 +309,8 @@ static void bcm_uart_do_tx(struct uart_port *port)
>  
>  	val = bcm_uart_readl(port, UART_MCTL_REG);
>  	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
> -
> -	pending = uart_port_tx_limited(port, ch, port->fifosize - val,
> +	pending = uart_port_tx_limited_flags(port, ch, UART_TX_NOSTOP,
> +		port->fifosize - val,
>  		true,
>  		bcm_uart_writel(port, ch, UART_FIFO_REG),
>  		({}));
> @@ -321,6 +321,9 @@ static void bcm_uart_do_tx(struct uart_port *port)
>  	val = bcm_uart_readl(port, UART_IR_REG);
>  	val &= ~UART_TX_INT_MASK;
>  	bcm_uart_writel(port, val, UART_IR_REG);
> +
> +	if (uart_tx_stopped(port))
> +		bcm_uart_stop_tx(port);
>  }
>  
>  /*
> -- 
> 2.34.1
> 
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

