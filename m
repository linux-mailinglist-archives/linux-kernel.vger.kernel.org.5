Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2613A7F409F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjKVIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjKVIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:54:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C9E1A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:54:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D42C433C7;
        Wed, 22 Nov 2023 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700643239;
        bh=kEOLmSI8N/wxIr2gL+9Mff19BUqTjsdYUEN6axFJQWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4Lmicgpv1rZNdbPiUOaKGnRIh68vd7af14vbLtFQlt9lXPBsSgVxMmg1M8Di9yy0
         KROVL66Ok1UMvGBPBXCjPTFzCm8g2IrpWjC+7UWNNeHHCnzvOIvS8XXjUV4pOt1kq0
         e8DOSzFC4BEZmIJg0coHmXeKKW97mUlY2YiCRAp4=
Date:   Wed, 22 Nov 2023 08:53:56 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     linux-kernel@vger.kernel.org, Nipun.Gupta@amd.com,
        puneet.gupta@amd.com, nikhil.agarwal@amd.com, michal.simek@amd.com,
        git@amd.com
Subject: Re: [PATCH 2/2] cdx: Create resource debugfs file for cdx device
Message-ID: <2023112232-crawfish-twig-0937@gregkh>
References: <20231122080300.3727388-1-abhijit.gangurde@amd.com>
 <20231122080300.3727388-2-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122080300.3727388-2-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 01:33:00PM +0530, Abhijit Gangurde wrote:
> resource debugfs file contains host addresses of CDX device resources.
> Each line of the resource file describe a region with start, end and
> flag fields.
> 
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
>  drivers/cdx/cdx.c           | 42 ++++++++++++++++++++++++++++++++++++-
>  include/linux/cdx/cdx_bus.h |  2 ++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 4edf64f9e98d..e01376272ed3 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -65,6 +65,7 @@
>  #include <linux/cdx/cdx_bus.h>
>  #include <linux/iommu.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/debugfs.h>
>  #include "cdx.h"
>  
>  /* Default DMA mask for devices on a CDX bus */
> @@ -75,6 +76,8 @@
>  static DEFINE_IDA(cdx_controller_ida);
>  /* Lock to protect controller ops */
>  static DEFINE_MUTEX(cdx_controller_lock);
> +/* Debugfs dir for cdx bus */
> +static struct dentry *cdx_debugfs_dir;
>  
>  static char *compat_node_name = "xlnx,versal-net-cdx";
>  
> @@ -149,6 +152,7 @@ static int cdx_unregister_device(struct device *dev,
>  			cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
>  	} else {
>  		cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
> +		debugfs_remove_recursive(cdx_dev->debugfs_dir);
>  		kfree(cdx_dev->driver_override);
>  		cdx_dev->driver_override = NULL;
>  	}
> @@ -552,6 +556,34 @@ static const struct attribute_group *cdx_dev_groups[] = {
>  	NULL,
>  };
>  
> +static int cdx_debug_resource_show(struct seq_file *s, void *data)
> +{
> +	struct cdx_device *cdx_dev = s->private;
> +	int i;
> +
> +	for (i = 0; i < MAX_CDX_DEV_RESOURCES; i++) {
> +		struct resource *res =  &cdx_dev->res[i];
> +
> +		seq_printf(s, "0x%016llx 0x%016llx 0x%016llx\n",
> +			   (unsigned long long)res->start,
> +			   (unsigned long long)res->end,
> +			   (unsigned long long)res->flags);

Why not just use %pR or %pr instead of creating your own style of
format?

thanks,

greg k-h
