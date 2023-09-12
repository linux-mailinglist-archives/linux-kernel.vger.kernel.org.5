Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E9C79C964
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjILIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjILIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:11:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49ED10CA;
        Tue, 12 Sep 2023 01:11:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EF5C433C8;
        Tue, 12 Sep 2023 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694506312;
        bh=86DRriTPA8s3y0wTZiZ9RpDhVjbzsr/+auYV4gwpeRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJUnZGpAxXe3T43MFIEaLN3gAgGj6Yec9hhpNSmAAhvgXEdShkfB8vpxW35TOXrxw
         c+hD7iWXhl8eA550i6gFxITfSy96lby8AD4ImDTZwc5vsoysXC9v5nMVSqOryiIQH7
         zFHHbJ0p/etx1Mxftp3SP/iLY9LIKuGar9zY12Xc=
Date:   Tue, 12 Sep 2023 10:11:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "guojinhui.liam" <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: set numa_node before
 platform_add_device()
Message-ID: <2023091258-matrix-imitation-cc70@gregkh>
References: <20230912070900.1862-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912070900.1862-1-guojinhui.liam@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:09:00PM +0800, guojinhui.liam wrote:
> platform_add_device creates numa_node attribute of sysfs according to
> whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> of the device before creating numa_node attribute of sysfs.

Why?  What will this allow to happen differently?  What is broken with
the current code?

> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Signed-off-by: guojinhui.liam <guojinhui.liam@bytedance.com>

Please use your name here, and not your email alias, as the first part
of the signed-off-by line.

And also, please fix up your email client to have the correct name as
well.

> ---
>  drivers/acpi/acpi_platform.c | 4 +---
>  drivers/base/platform.c      | 4 ++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 48d15dd785f6..adcbfbdc343f 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>  	if (IS_ERR(pdev))
>  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
>  			PTR_ERR(pdev));
> -	else {
> -		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> +	else
>  		dev_dbg(&adev->dev, "created platform device %s\n",
>  			dev_name(&pdev->dev));
> -	}
>  
>  	kfree(resources);
>  
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba25003..355abf91930a 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
>  {
>  	int ret;
>  	struct platform_device *pdev;
> +	struct acpi_device *adev = to_acpi_device_node(pdevinfo->fwnode);
>  
>  	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
>  	if (!pdev)
> @@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
>  			goto err;
>  	}
>  
> +	if (adev)
> +		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));

Are you sure that this platform code can always call acpi functions?

thanks,

greg k-h
