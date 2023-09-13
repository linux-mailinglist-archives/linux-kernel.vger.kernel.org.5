Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA979EE65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjIMQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjIMQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:37:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F271198B;
        Wed, 13 Sep 2023 09:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21303C433C9;
        Wed, 13 Sep 2023 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694623034;
        bh=jTsdWR7yXTa22nqC9l81Q4ikkwMkf244QTTcwAuulKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIvo8WIupXFFwm6NTL1IrX4XxodJAeNYiPXgwOZZF41czBywUs9OXQq4Jg0oO1VpU
         /NRNns+ZNtjSoP8VbPuK0TkQESRURJhqjUe72fYlBvtvuhwzITLnpuGfCrKHIUN9PH
         mh4p+aBI+zMrrY+htMyX0MJkRXlqQknpLEdxSVw4=
Date:   Wed, 13 Sep 2023 18:37:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     guojinhui <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] driver core: platform: set numa_node before
 platform_add_device()
Message-ID: <2023091351-clarify-prototype-710c@gregkh>
References: <20230913083825.2670-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913083825.2670-1-guojinhui.liam@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 04:38:25PM +0800, guojinhui wrote:
> From: "guojinhui" <guojinhui.liam@bytedance.com>
> 
> platform_add_device creates numa_node attribute of sysfs according to
> whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> of the device before creating numa_node attribute of sysfs.
> 
> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> Signed-off-by: guojinhui <guojinhui.liam@bytedance.com>
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

#ifdef do not belong in .c files if at all possible.

Why can't this be an acpi call instead?  Why does this have to be in the
driver core?  Platform drivers shouldn't know anything about acpi, this
feels really odd.

> +static inline void platform_set_dev_node(struct platform_device *pdev)

Also, it's not "platform_set", it is acpi-specifc, right?  Again, the
ACPI core should handle this for its ACPI-platform devices, the driver
core shouldn't care at all.

thanks,

greg k-h
