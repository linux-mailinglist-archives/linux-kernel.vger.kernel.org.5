Return-Path: <linux-kernel+bounces-134119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C258D89ADDD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 03:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC128245E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73C139B;
	Sun,  7 Apr 2024 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx6CT31a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB56FC3;
	Sun,  7 Apr 2024 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452765; cv=none; b=LZnBWQ0KI730G3KpILc4dg5n1ky+dgryvE6ffipZGPNMhOqJml5ELvIY6TM5QQx4Q0bo5wAQbDGRUlFXVl0m9GzVRcL2g9rHaKDS70ngkA7DGL23LVYqbpCPK+zGRCUlvv5uEJKoRBYkJ9yi8hkuItLqjdeqqm78Cg6bapS8Mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452765; c=relaxed/simple;
	bh=EdW60mHBwl6j1bdQXnTE1dcqnX3EarNCyIPxiB5zZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJvmYuDB2BecVyJHB2UOIwc807R4snqRQhCXH4vR/u813EKNjZsMnTolwzBQdXpZEpcKe0+VTp7Bywyo6aazcbf12Q4YcA8FEKDyV1rMfeagDKC5W29FP8GUv2JIqr9IpZ2ylbSyWb48b9rhSt/jv9Nu711xupAW80dhy4ogNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx6CT31a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFD8C433C7;
	Sun,  7 Apr 2024 01:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712452763;
	bh=EdW60mHBwl6j1bdQXnTE1dcqnX3EarNCyIPxiB5zZz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rx6CT31ag15WPbAuovBu+1CVEKrD7PVLzPyi3G+d+r9lNh0q164aLZ/o8xoLrgaxr
	 CuJn5T9qkUeNfyduv0isVnLBrUqZDfWN3J7i3fSwJzUmQm1GRBMYrCKU0MRAShBLOr
	 NTU1zvaaWgHZy1IzRs/0dBeS6h36I90hc2zZCfQ1zF/8ikr7h2pv4CTuwlspwlb6l2
	 gTjvjEIiknBQbytaVqXjX//7toqChLbnAfIrDUox+kGqRr7+nsR9+ysbUmGze9X8EM
	 qWOnxDwiaUpYXUbFGzrzVdvIdekJr1Qvyu6JSseiIo82KyzhwHpVSz1mrbgGuDWtU2
	 9T2ZxGdm/GuJQ==
Date: Sun, 7 Apr 2024 09:19:13 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: move ci_ulpi_init after the phy
 initialization
Message-ID: <20240407011913.GA168730@nchen-desktop>
References: <20240328-chipidea-phy-misc-v1-1-907d9de5d4df@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-chipidea-phy-misc-v1-1-907d9de5d4df@pengutronix.de>

On 24-04-02 08:23:43, Michael Grzeschik wrote:
> The function ci_usb_phy_init is already handling the
> hw_phymode_configure path which is also only possible after we have
> a valid phy. So we move the ci_ulpi_init after the phy initialization
> to be really sure to be able to communicate with the ulpi phy.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/chipidea/core.c | 8 ++++----
>  drivers/usb/chipidea/ulpi.c | 5 -----
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 835bf2428dc6e..bada13f704b62 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -1084,10 +1084,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	ret = ci_ulpi_init(ci);
> -	if (ret)
> -		return ret;
> -
>  	if (ci->platdata->phy) {
>  		ci->phy = ci->platdata->phy;
>  	} else if (ci->platdata->usb_phy) {
> @@ -1142,6 +1138,10 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>  		goto ulpi_exit;
>  	}
>  
> +	ret = ci_ulpi_init(ci);
> +	if (ret)
> +		return ret;
> +
>  	ci->hw_bank.phys = res->start;
>  
>  	ci->irq = platform_get_irq(pdev, 0);
> diff --git a/drivers/usb/chipidea/ulpi.c b/drivers/usb/chipidea/ulpi.c
> index dfec07e8ae1d2..89fb51e2c3ded 100644
> --- a/drivers/usb/chipidea/ulpi.c
> +++ b/drivers/usb/chipidea/ulpi.c
> @@ -68,11 +68,6 @@ int ci_ulpi_init(struct ci_hdrc *ci)
>  	if (ci->platdata->phy_mode != USBPHY_INTERFACE_MODE_ULPI)
>  		return 0;
>  
> -	/*
> -	 * Set PORTSC correctly so we can read/write ULPI registers for
> -	 * identification purposes
> -	 */
> -	hw_phymode_configure(ci);
>  
>  	ci->ulpi_ops.read = ci_ulpi_read;
>  	ci->ulpi_ops.write = ci_ulpi_write;
> 
> ---
> base-commit: 5bab5dc780c9ed0c69fc2f828015532acf4a7848
> change-id: 20240328-chipidea-phy-misc-b3f2bc814784
> 
> Best regards,
> -- 
> Michael Grzeschik <m.grzeschik@pengutronix.de>
> 

-- 

Thanks,
Peter Chen

