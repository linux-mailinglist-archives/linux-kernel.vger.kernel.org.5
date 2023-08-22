Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A378433F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjHVOGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjHVOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:06:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E0510C6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628A6657A7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546E1C433CA;
        Tue, 22 Aug 2023 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692713166;
        bh=j5DFII2COIaDGCWQAwQRp7Va8+E/6tH4aaZWWhX4ds4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0m6PasYFSCXNTw66eOU5YYBsldpPXlX0xi1uKbnZHXjd0e7WV64gq9pGaGWat4g9b
         DeDD7xPjl2gAwY/CBhOzZly9h0UDpX5fA+M5MTw6D8myiU517JZSktkVcE+RASJe5u
         hd2FfjSbiXjYSXlNZtqmjokRKAKqTtMZeUq2E9LM=
Date:   Tue, 22 Aug 2023 16:06:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Nipun.Gupta@amd.com, nikhil.agarwal@amd.com, puneet.gupta@amd.com,
        git@amd.com, michal.simek@amd.com
Subject: Re: [PATCH v3 1/5] cdx: Remove cdx controller list from cdx bus
 system
Message-ID: <2023082207-humped-unclasp-6058@gregkh>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
 <20230814102223.418046-2-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814102223.418046-2-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 03:52:19PM +0530, Abhijit Gangurde wrote:
> Remove xarray list of cdx controller. Instead, use platform bus
> to locate the cdx controller using compat string used by cdx
> controller platform driver.

You also now use an ida instead, right?  Do you need to mention that
here?

> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  drivers/cdx/cdx.c           | 39 ++++++++++++++++++++++++-------------
>  include/linux/cdx/cdx_bus.h |  2 ++
>  2 files changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index d2cad4c670a0..1c0f76cf4f15 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -60,7 +60,7 @@
>  #include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> -#include <linux/xarray.h>
> +#include <linux/idr.h>
>  #include <linux/cdx/cdx_bus.h>
>  #include <linux/iommu.h>
>  #include <linux/dma-map-ops.h>
> @@ -70,8 +70,10 @@
>  #define CDX_DEFAULT_DMA_MASK	(~0ULL)
>  #define MAX_CDX_CONTROLLERS 16
>  
> -/* CDX controllers registered with the CDX bus */
> -static DEFINE_XARRAY_ALLOC(cdx_controllers);
> +/* IDA for CDX controllers registered with the CDX bus */
> +DEFINE_IDA(cdx_controller_ida);

Why is this now a global variable?

thanks,

> +
> +static char *compat_node_name = "xlnx,versal-net-cdx";
>  
>  /**
>   * cdx_dev_reset - Reset a CDX device
> @@ -384,7 +386,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  			    const char *buf, size_t count)
>  {
>  	struct cdx_controller *cdx;
> -	unsigned long index;
> +	struct platform_device *pd;
> +	struct device_node *np;
>  	bool val;
>  
>  	if (kstrtobool(buf, &val) < 0)
> @@ -397,12 +400,19 @@ static ssize_t rescan_store(const struct bus_type *bus,
>  	cdx_unregister_devices(&cdx_bus_type);
>  
>  	/* Rescan all the devices */
> -	xa_for_each(&cdx_controllers, index, cdx) {
> -		int ret;
> +	for_each_compatible_node(np, NULL, compat_node_name) {
> +		if (!np)
> +			return -EINVAL;
>  
> -		ret = cdx->ops->scan(cdx);
> -		if (ret)
> -			dev_err(cdx->dev, "cdx bus scanning failed\n");
> +		pd = of_find_device_by_node(np);
> +		if (!pd)
> +			return -EINVAL;
> +
> +		cdx = platform_get_drvdata(pd);
> +		if (cdx && cdx->controller_registered && cdx->ops->scan)
> +			cdx->ops->scan(cdx);
> +
> +		put_device(&pd->dev);

What handles the locking here?  What if a new device is added , or
removed, while you iterate this?

And what about racing with the controller_registered flag?  Are you sure
that's needed?

thanks,

greg k-h
