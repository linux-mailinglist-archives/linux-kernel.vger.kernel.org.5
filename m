Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D57A623E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjISMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:12:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A3E3;
        Tue, 19 Sep 2023 05:12:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD00C433C9;
        Tue, 19 Sep 2023 12:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695125543;
        bh=AFPLIFGXLWjw+0e/AtMKe0zpKJuMhC228OrlJTVOcQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp9KXJK4C9ujRIw+cq2kcj4fiAyk6Wt2bWZex8pIQqKeJc/8Y6j1fny3ip6k00TAb
         L0XgEGURDvrztnTp1aW9mOvmA7mdp9ut9SeM93uwevpZfUDpRhfPGLKryS1Nr+imm1
         1QNPk2KkEpIV4ufXanEsSA6zbytT4M6vtIcZs5qo=
Date:   Tue, 19 Sep 2023 14:12:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, lizefan.x@bytedance.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7] driver core: platform: set numa_node before
 platform_device_add()
Message-ID: <2023091942-punk-naturist-8028@gregkh>
References: <20230919120341.533-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919120341.533-1-guojinhui.liam@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 08:03:41PM +0800, Jinhui Guo wrote:
> Setting the devices' numa_node needs to be done in
> platform_device_register_full(), because that's where the
> platform device object is allocated.
> 
> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>

The test robot did not report the original problem, that was a problem
with your potential change.

> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/

Likewise, this is not a real issue, it was a problem with your previous
submission.

> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
> V6 -> V7
>   1. Fix bug directly by adding numa_node to struct
>      platform_device_info (suggested by Rafael J. Wysocki).
>   2. Remove reviewer name.
> 
> V5 -> V6:
>   1. Update subject to correct function name platform_device_add().
>   2. Provide a more clear and accurate description of the changes
>      made in commit (suggested by Rafael J. Wysocki).
>   3. Add reviewer name.
> 
> V4 -> V5:
>   Add Cc: stable line and changes from the previous submited patches.
> 
> V3 -> V4:
>   Refactor code to be an ACPI function call (suggested by Greg Kroah-Hartman).
> 
> V2 -> V3:
>   Fix Signed-off name.
> 
> V1 -> V2:
>   Fix compile error without enabling CONFIG_ACPI.
> ---
> 
>  drivers/acpi/acpi_platform.c    |  5 ++---
>  drivers/base/platform.c         |  4 ++++
>  include/linux/platform_device.h | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 48d15dd785f6..1ae7449f70dc 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -168,6 +168,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>  	pdevinfo.num_res = count;
>  	pdevinfo.fwnode = acpi_fwnode_handle(adev);
>  	pdevinfo.properties = properties;
> +	platform_devinfo_set_node(&pdevinfo, acpi_get_node(adev->handle));
>  
>  	if (acpi_dma_supported(adev))
>  		pdevinfo.dma_mask = DMA_BIT_MASK(32);
> @@ -178,11 +179,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
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
> index 76bfcba25003..c733bfb26149 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
>  {
>  	int ret;
>  	struct platform_device *pdev;
> +	int numa_node = platform_devinfo_get_node(pdevinfo);
>  
>  	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
>  	if (!pdev)
> @@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
>  			goto err;
>  	}
>  
> +	if (numa_node >= 0)
> +		set_dev_node(&pdev->dev, numa_node);

Why not just always set it?  Why check?  Would that matter?


> +
>  	ret = platform_device_add(pdev);
>  	if (ret) {
>  err:
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7a41c72c1959..78e11b79f1af 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -132,10 +132,36 @@ struct platform_device_info {
>  		u64 dma_mask;
>  
>  		const struct property_entry *properties;
> +
> +#ifdef CONFIG_NUMA
> +		int numa_node;	/* NUMA node this platform device is close to plus 1 */
> +#endif

Why #ifdef?

And why an int?

And why +1?

And what do you mean by "close to"?

And why would a platform device care about a numa node?  These are
devices that should NEVER care about numa things as they are not on a
real bus, or should care about performance things.  If they are, then
the device is on the wrong bus, right?

What device are you having numa problems with?  Why would acpi devices
care?

The node number in the device itself should be all that you need here,
no need to duplicate it, right?

thanks,

greg k-h
