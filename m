Return-Path: <linux-kernel+bounces-100390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55548796C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB8D1F21FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728647B3E5;
	Tue, 12 Mar 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="at9TKOD/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAA7AE64;
	Tue, 12 Mar 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254884; cv=none; b=Cj8nX6L9XsjmHlVdGH/0hFidufEVqp91UUGSVFXoIbwKWmEmfGjdh4N6+RNpooWmhPCWLhscw9GnMSe5WZqlj/im4k3nDSppb4cvb4Q5YOi+GerHmrekPvOLS8dBEER2qHQVu+ur44PGsg11qoofQDq0JDGUFGbT2MmCQKcwjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254884; c=relaxed/simple;
	bh=fEINzAiktCG3XHXmtvP7Mjk56YzH3FwISqVHGQh27hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/0kq5j1QROH9RFV2RIeRzIvLDCcOvWbIoMK9MSiVpnXzdsSPwW9uZ8A1KRzi2Xmt584zuEI0Y7h4oAwaaWz7N1d9Vpya9TqtAI8fP2LpdqaMP0kK4PyrlG2sI4CudJKiE8/AJ/BHPVpp2poHzOg+KUYA3dGBVH4hilO7PhntUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=at9TKOD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD5C433F1;
	Tue, 12 Mar 2024 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710254883;
	bh=fEINzAiktCG3XHXmtvP7Mjk56YzH3FwISqVHGQh27hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=at9TKOD/vmb9sCs1S1IIi5Q6Ozr0G0q5S1fYyPU61qamjo1kmdijScUrAMIy1YS1t
	 cFAN47HJyJ73HudtHJL6vxeRRePvHlDRE+Z9Z4QDGID1AYY6H5Jw84MramdEIm7byC
	 iDLU559/6cZz5nkPSxDXiWs0LiYQj+MyXv14OmSU=
Date: Tue, 12 Mar 2024 15:47:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: j@jannau.net
Cc: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, regressions@lists.linux.dev
Subject: Re: [PATCH] spi: Restore delays for non-GPIO chip select
Message-ID: <2024031242-boned-enactment-fb7d@gregkh>
References: <20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net>

On Mon, Mar 11, 2024 at 11:53:17PM +0100, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> SPI controller with integrated chip select handling still need to adhere
> to SPI device's CS setup, hold and inactive delays. For controller
> without set_cs_timing spi core shall handle the delays to avoid
> duplicated delay handling in each controller driver.
> Fixes a regression for the out of tree SPI controller and SPI HID
> transport on Apple M1/M1 Pro/Max notebooks.
> 
> Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> #regzbot ^introduced 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9
> ---
>  drivers/spi/spi.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f2170f4b5077..71be2ba8402f 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1042,10 +1042,14 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  	if (spi->mode & SPI_CS_HIGH)
>  		enable = !enable;
>  
> -	if (spi_is_csgpiod(spi)) {
> -		if (!spi->controller->set_cs_timing && !activate)
> -			spi_delay_exec(&spi->cs_hold, NULL);
> +	/*
> +	 * Handle chip select delays for GPIO based CS or controllers without
> +	 * programmable chip select timing.
> +	 */
> +	if ((spi_is_csgpiod(spi) || !spi->controller->set_cs_timing) && !activate)
> +		spi_delay_exec(&spi->cs_hold, NULL);
>  
> +	if (spi_is_csgpiod(spi)) {
>  		if (!(spi->mode & SPI_NO_CS)) {
>  			/*
>  			 * Historically ACPI has no means of the GPIO polarity and
> @@ -1079,16 +1083,16 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  		if ((spi->controller->flags & SPI_CONTROLLER_GPIO_SS) &&
>  		    spi->controller->set_cs)
>  			spi->controller->set_cs(spi, !enable);
> -
> -		if (!spi->controller->set_cs_timing) {
> -			if (activate)
> -				spi_delay_exec(&spi->cs_setup, NULL);
> -			else
> -				spi_delay_exec(&spi->cs_inactive, NULL);
> -		}
>  	} else if (spi->controller->set_cs) {
>  		spi->controller->set_cs(spi, !enable);
>  	}
> +
> +	if (spi_is_csgpiod(spi) || !spi->controller->set_cs_timing) {
> +		if (activate)
> +			spi_delay_exec(&spi->cs_setup, NULL);
> +		else
> +			spi_delay_exec(&spi->cs_inactive, NULL);
> +	}
>  }
>  
>  #ifdef CONFIG_HAS_DMA
> 
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240311-spi-cs-delays-regression-fd7309fc0eff
> 
> Best regards,
> -- 
> Janne Grunau <j@jannau.net>
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

