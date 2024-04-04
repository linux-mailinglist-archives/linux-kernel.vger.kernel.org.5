Return-Path: <linux-kernel+bounces-131479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D6898866
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6691F2383A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766D186AE5;
	Thu,  4 Apr 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Butq47HZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F118528D;
	Thu,  4 Apr 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235651; cv=none; b=nWXz2SyLhnKRdR7z1fNx+bcl2i3U4TXWHCZHNoPoODnQ93NsZa0AGU6kFynez03H9E3iDBz5KbaH8oQ4OnQWism9utHZS6sS6G7JlgwArvkwTWs58mOQAXsHqT8/4jVWtoOFXjGe8VQMBxbs9QwxWvupWf+JKkH3V9aIzpu9Z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235651; c=relaxed/simple;
	bh=U2Ze18IaiYym3G5T8VVewUxICdwroUYzwMPTeS27ubw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCh+jOlF68ZE8GJf9obp0W7wLYQMfJT1DvgpsjZlDEQtMhieaR90KaUEg05Kdvt1RFQY6K5p0HxPGZ4C+76jrSOHLeBFcSP9zXWH0wtyJtslcotkNjMg8yH0wpzFYmbYpbGVy9mD2M7UZ+LpycFkyuHinlwVWUf3wlAf4ITn3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Butq47HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FFBC433C7;
	Thu,  4 Apr 2024 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712235651;
	bh=U2Ze18IaiYym3G5T8VVewUxICdwroUYzwMPTeS27ubw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Butq47HZgP90PPp4KiQbstGLkbFYIyE5/PGSSFRZ1C7CCtxMZPaqR05OVLQgQ607c
	 yAPV8smmjPwbElzG7ZLm1voSWiiKPc+cV7kWm1ttZdynepinTrhvqOTbkJcr45aE5n
	 vL1GqqFHU4RWQdOTPlefn2brPMh/HN2gElLhggeE=
Date: Thu, 4 Apr 2024 15:00:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] usb: ehci-exynos: Use devm_clk_get_enabled()
 helpers
Message-ID: <2024040442-subscript-detective-8d12@gregkh>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404071350.4242-2-linux.amoon@gmail.com>

On Thu, Apr 04, 2024 at 12:43:17PM +0530, Anand Moon wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V2: drop the clk_disable_unprepare in suspend/resume functions
>     fix the usb_put_hcd return before the devm_clk_get_enabled
> ---
>  drivers/usb/host/ehci-exynos.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index f644b131cc0b..f00bfd0b13dc 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -159,20 +159,15 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>  
>  	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
>  	if (err)
> -		goto fail_clk;
> -
> -	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
> +		goto fail_io;
>  
> +	exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
>  	if (IS_ERR(exynos_ehci->clk)) {
> -		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> -		err = PTR_ERR(exynos_ehci->clk);
> -		goto fail_clk;
> +		usb_put_hcd(hcd);
> +		return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
> +				  "Failed to get usbhost clock\n");

Why is this logic changed?

If you want to call dev_err_probe(), that's great, but do NOT mix it up
with a commit that does something totally different.

When you say something like "while at it" in a changelog text, that is a
HUGE hint that it needs to be a separate commit.  Because of that reason
alone, I can't take these, you know better :(

thanks,

greg k-h

