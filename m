Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FFC7A0E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbjINT3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjINT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:29:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACEE26AB;
        Thu, 14 Sep 2023 12:29:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A303FC433C7;
        Thu, 14 Sep 2023 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694719748;
        bh=hNAY8MGYf8YcUA4vUEpZaRVEM+yzGB604aBLvFxOsT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxcrE226jsia0S3OIWHpfgtZ/AoKg0fTDExE9v9F1PNvhRw0uvpE8Va/msOBLScs9
         gpOk7cXfKnBHScKDhQrGdrE5/hJtQaAx1W0vJXNKgxwzf3D3jpyD17hVbJC075Eqnx
         +8JtylLCHswVV53CHy8hAp5JKHzgx/i6dR8lGuRw=
Date:   Thu, 14 Sep 2023 21:29:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] driver core: platform: set numa_node before
 platform_add_device()
Message-ID: <2023091440-worried-raider-7c85@gregkh>
References: <20230914150612.3440-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914150612.3440-1-guojinhui.liam@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:06:12PM +0800, Jinhui Guo wrote:
> platform_add_device() creates the numa_node attribute of sysfs according
> to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> of device before creating numa_node attribute of sysfs.
> 
> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>  drivers/acpi/acpi_platform.c | 4 +---
>  drivers/base/platform.c      | 1 +
>  include/linux/acpi.h         | 5 +++++
>  3 files changed, 7 insertions(+), 3 deletions(-)
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
> index 76bfcba25003..35c891075d95 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -841,6 +841,7 @@ struct platform_device *platform_device_register_full(
>  			goto err;
>  	}
>  
> +	set_dev_node(&pdev->dev, ACPI_NODE_GET(ACPI_COMPANION(&pdev->dev)));
>  	ret = platform_device_add(pdev);
>  	if (ret) {
>  err:
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a73246c3c35e..6a349d53f19e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -477,6 +477,10 @@ static inline int acpi_get_node(acpi_handle handle)
>  	return 0;
>  }
>  #endif
> +
> +#define ACPI_NODE_GET(adev) ((adev) && (adev)->handle ? \
> +	acpi_get_node((adev)->handle) : NUMA_NO_NODE)
> +
>  extern int pnpacpi_disabled;
>  
>  #define PXM_INVAL	(-1)
> @@ -770,6 +774,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
>  #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
>  #define ACPI_HANDLE(dev)		(NULL)
>  #define ACPI_HANDLE_FWNODE(fwnode)	(NULL)
> +#define ACPI_NODE_GET(adev)		NUMA_NO_NODE
>  
>  #include <acpi/acpi_numa.h>
>  
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
