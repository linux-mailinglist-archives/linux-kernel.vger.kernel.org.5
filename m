Return-Path: <linux-kernel+bounces-89073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63A86EA34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0301C2481C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC43C680;
	Fri,  1 Mar 2024 20:19:54 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 325C63C067
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324394; cv=none; b=q3+B0prnO+Y87Cn8qJhwAOAEVFCY1n3WDJ+JcrXu5rmYcol/1P3xZ1rGrrhe6PGU17/6b1Hm08fN+6pN1YimlO/0hjmDoSnaUTwzgn+aLGIVIJxVmQXqGcDo8Vity55BsYT/Faezdm9xKQVqVTjrv67PGvEflmqWyKyUyvw6nVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324394; c=relaxed/simple;
	bh=dmdQvBgGcFUSe5KL71t4XKvpm2QFV83YwaoViTYlKAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hgb/z2rcXJXOLhGNYh0R0M7FRf/5oC6eeF3HKwlHkrpL+hsQQpk9erGjVbW/Gc0Wqodj52ezGl76PBTiwp9RZ+RK37+evOnqpSO9GryD6fdkqvdmokdPdUbLTM7kMZ7M7BeYOpDiZqQPrTPsF/vNQZWX05KdkzPCgzYMnfSiBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 45205 invoked by uid 1000); 1 Mar 2024 15:19:47 -0500
Date: Fri, 1 Mar 2024 15:19:47 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
  Alim Akhtar <alim.akhtar@samsung.com>, linux-usb@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] usb: ehci-exynos: Use devm_clk_get_enabled()
 helpers
Message-ID: <d3c72bbf-2dd2-4d7f-9882-08710baa3f3a@rowland.harvard.edu>
References: <20240301193831.3346-1-linux.amoon@gmail.com>
 <20240301193831.3346-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301193831.3346-2-linux.amoon@gmail.com>

On Sat, Mar 02, 2024 at 01:08:08AM +0530, Anand Moon wrote:
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
>  drivers/usb/host/ehci-exynos.c | 30 +++++-------------------------
>  1 file changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index f644b131cc0b..05aa3d9c2a3b 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -159,19 +159,12 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>  
>  	err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
>  	if (err)
> -		goto fail_clk;
> -
> -	exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
> -
> -	if (IS_ERR(exynos_ehci->clk)) {
> -		dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> -		err = PTR_ERR(exynos_ehci->clk);
> -		goto fail_clk;
> -	}
> +		goto fail_io;
>  
> -	err = clk_prepare_enable(exynos_ehci->clk);
> -	if (err)
> -		goto fail_clk;
> +	exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
> +	if (IS_ERR(exynos_ehci->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
> +				  "Failed to get usbhost clock\n");

What about the usb_put_hcd(hcd) call that used to happen here?

Alan Stern

>  
>  	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(hcd->regs)) {
> @@ -223,8 +216,6 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>  	exynos_ehci_phy_disable(&pdev->dev);
>  	pdev->dev.of_node = exynos_ehci->of_node;
>  fail_io:
> -	clk_disable_unprepare(exynos_ehci->clk);
> -fail_clk:
>  	usb_put_hcd(hcd);
>  	return err;
>  }
> @@ -240,8 +231,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
>  
>  	exynos_ehci_phy_disable(&pdev->dev);
>  
> -	clk_disable_unprepare(exynos_ehci->clk);
> -
>  	usb_put_hcd(hcd);
>  }
>  
> @@ -249,7 +238,6 @@ static void exynos_ehci_remove(struct platform_device *pdev)
>  static int exynos_ehci_suspend(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
> -	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
>  
>  	bool do_wakeup = device_may_wakeup(dev);
>  	int rc;
> @@ -260,25 +248,17 @@ static int exynos_ehci_suspend(struct device *dev)
>  
>  	exynos_ehci_phy_disable(dev);
>  
> -	clk_disable_unprepare(exynos_ehci->clk);
> -
>  	return rc;
>  }
>  
>  static int exynos_ehci_resume(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
> -	struct exynos_ehci_hcd *exynos_ehci = to_exynos_ehci(hcd);
>  	int ret;
>  
> -	ret = clk_prepare_enable(exynos_ehci->clk);
> -	if (ret)
> -		return ret;
> -
>  	ret = exynos_ehci_phy_enable(dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to enable USB phy\n");
> -		clk_disable_unprepare(exynos_ehci->clk);
>  		return ret;
>  	}
>  
> -- 
> 2.43.0
> 

