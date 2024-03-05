Return-Path: <linux-kernel+bounces-91817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C607871700
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21CC1F238C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B89F7E771;
	Tue,  5 Mar 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFDziI/S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAED7E564;
	Tue,  5 Mar 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624132; cv=none; b=Pp+KtOmFqrm4SJ6M5TouhWJMViABsjhoOJVEWjj+2u57OXyIcGS745PaokMdvSZB0Gln07Q/TjOffE4BJyWrbZvU7hHCpx9Tq/8BWqqNJ4A41ePeUg0zq12cn1FMlwDe1V7uoXw5QD0jdcGwTg4hiZlYHnl5dppgkasvbx8JF18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624132; c=relaxed/simple;
	bh=9mE8JGFRmIiaAXwJrEkI8C/6vowaKjT3QgtdT5nxS10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htC0wlel3fKDI8uuLuSJZUUsCpEfclc1HuO3X/0nI6K4++uzDTqv7sBOzszKXz1KpNc9KzgwEc16Lo88N+7iAKNRkvqyS9Sv7s3Rx0XFcn9rv/CNQVuP/Ex2BePLFj0XuZUbT2fexthC8kcVs0Fn28rKK/MgkjFV9/ir8ZypKqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFDziI/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CDAC433F1;
	Tue,  5 Mar 2024 07:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709624132;
	bh=9mE8JGFRmIiaAXwJrEkI8C/6vowaKjT3QgtdT5nxS10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFDziI/SFGMNLoO162znoeRmfJIet1EyZZ0jpgaU7j8q27USEhFhaiAvUsrqIpfNA
	 hzzdPWE2+S4AZbj9gb67MpaHvd3/n2VyaPlIGR9F+67muyX5ehwkneDNFUE3g1wUgL
	 Hlm6gxPjqlDH6mzIsg1FGrtjk2Am8a9ofXDn9kdM=
Date: Tue, 5 Mar 2024 07:35:28 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: jirislaby@kernel.org, u.kleine-koenig@pengutronix.de,
	ilpo.jarvinen@linux.intel.com, shenwei.wang@nxp.com,
	alexander.sverdlin@siemens.com, robert.hodaszi@digi.com,
	robh@kernel.org, tglx@linutronix.de, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, frank.li@nxp.com
Subject: Re: [PATCH V2] tty: serial: fsl_lpuart: avoid idle preamble pending
 if CTS is enabled
Message-ID: <2024030517-paging-voter-6054@gregkh>
References: <20240305015706.1050769-1-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305015706.1050769-1-sherry.sun@nxp.com>

On Tue, Mar 05, 2024 at 09:57:06AM +0800, Sherry Sun wrote:
> If the remote uart device is not connected or not enabled after booting
> up, the CTS line is high by default. At this time, if we enable the flow
> control when opening the device(for example, using “stty -F /dev/ttyLP4
> crtscts” command), there will be a pending idle preamble(first writing 0
> and then writing 1 to UARTCTRL_TE will queue an idle preamble) that
> cannot be sent out, resulting in the uart port fail to close(waiting for
> TX empty), so the user space stty will have to wait for a long time or
> forever.
> 
> This is an LPUART IP bug(idle preamble has higher priority than CTS),
> here add a workaround patch to enable TX CTS after enabling UARTCTRL_TE,
> so that the idle preamble does not get stuck due to CTS is deasserted.
> 
> Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. Move the "restore control register" comment message to the appropriate place.
> 2. Add Fixes tag.
> ---
>  drivers/tty/serial/fsl_lpuart.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 5ddf110aedbe..bbcbc91482af 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2345,9 +2345,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	lpuart32_write(&sport->port, bd, UARTBAUD);
>  	lpuart32_serial_setbrg(sport, baud);
> -	lpuart32_write(&sport->port, modem, UARTMODIR);
> -	lpuart32_write(&sport->port, ctrl, UARTCTRL);
> +	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
> +	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
>  	/* restore control register */
> +	lpuart32_write(&sport->port, ctrl, UARTCTRL);
> +	/* re-enable the CTS if needed */
> +	lpuart32_write(&sport->port, modem, UARTMODIR);
>  
>  	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
>  		sport->is_cs7 = true;
> -- 
> 2.37.1
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

