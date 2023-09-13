Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCF79EF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjIMQrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIMQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5E1FF5;
        Wed, 13 Sep 2023 09:44:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7507FC433C8;
        Wed, 13 Sep 2023 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694623499;
        bh=YdvolG2o++I5uAQEd8PuhfuBfLfwYeJ286X6cm6379I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbMSN70gxGaSNUDN01jU4tkOT1pBfLQS5PiaxfgaNJdfUvrOhi1gQHBlm8Atjt4iv
         RENRi3gbY9puGlOir48vV6KdCHg2gh25ZQNkOtnvLOTRSZSxPmycSV+4mnBD/aMCSr
         WFvzhG5IO2y9+ZapPUGRfHbmZZ1t3ORd23oO/EUw=
Date:   Wed, 13 Sep 2023 18:44:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] driver core: platform: set numa_node before
 platform_add_device()
Message-ID: <2023091334-audacious-drudge-6001@gregkh>
References: <20230913115454.3073-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913115454.3073-1-guojinhui.liam@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 07:54:54PM +0800, Jinhui Guo wrote:
> From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
> 
> platform_add_device creates numa_node attribute of sysfs according to
> whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> of the device before creating numa_node attribute of sysfs.
> 
> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/acpi/acpi_platform.c |  4 +---
>  drivers/base/platform.c      | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
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
> index 76bfcba25003..206dc7b020cd 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -795,6 +795,18 @@ void platform_device_unregister(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(platform_device_unregister);
>  
> +#ifdef CONFIG_ACPI
> +static inline void platform_set_dev_node(struct platform_device *pdev)
> +{
> +	struct acpi_device *adev = to_acpi_device_node(pdev->dev.fwnode);
> +
> +	if (adev && adev->handle)
> +		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> +}
> +#else
> +static inline void platform_set_dev_node(struct platform_device *pdev) {}
> +#endif
> +
>  /**
>   * platform_device_register_full - add a platform-level device with
>   * resources and platform-specific data
> @@ -841,6 +853,7 @@ struct platform_device *platform_device_register_full(
>  			goto err;
>  	}
>  
> +	platform_set_dev_node(pdev);
>  	ret = platform_device_add(pdev);
>  	if (ret) {
>  err:
> -- 
> 2.20.1
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documetnation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
