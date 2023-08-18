Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6758780A83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376446AbjHRKwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359170AbjHRKvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:51:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF930C2;
        Fri, 18 Aug 2023 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692355908; x=1723891908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NasYqMbJN04Siu00UXGAENlSJ0u2H0gH+U2YTbLmkKw=;
  b=nBB+QyXlEvh93SuR95BKQzmAPr6pWz9KG7N85ONyjl2b+lV4yMddKhWM
   5fkf1uDXprAdSNReasxyHSmZbFy3dVMCoCn+a/ScXOJbcODRKnycHUPAO
   hBXKfjVEFO/NGfDcmfn/BEj2rD4czXSGPZ0yeavG0RWlCtnP1GABj7aR0
   YqKiv6jnnbtuOXpetdEBpLMS9t47veIDPAYR/g6BlIUNFS3Aguli1gQgL
   QCLfXaRHZUF6s57f19RiPQDFd2gOgerObMeApcZFrLvLwX4zeitDaarJ3
   qu89RkTt0EYLAJVlSBlgxbNfx+MLhVCWKzT2GcmKXQqs+zSOB0r42V1du
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376833201"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="376833201"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 03:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="805113206"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="805113206"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2023 03:51:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWx4w-004UHC-1D;
        Fri, 18 Aug 2023 13:51:42 +0300
Date:   Fri, 18 Aug 2023 13:51:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaacmanjarres@google.com, rmk+kernel@armlinux.org.uk,
        hdegoede@redhat.com, ulf.hansson@linaro.org, rafael@kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] of/platform: increase refcount of fwnode
Message-ID: <ZN9NPiOscOPXJom+@smile.fi.intel.com>
References: <20230818015932.2650041-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818015932.2650041-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:59:32AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> commit 0f8e5651095b
> ("of/platform: Propagate firmware node by calling device_set_node()")
> use of_fwnode_handle to replace of_node_get, which introduces a side
> effect that the refcount is not increased. Then the out of tree
> jailhouse hypervisor enable/disable test will trigger kernel dump in
> of_overlay_remove, with the following sequence
> "
>    of_changeset_revert(&overlay_changeset);
>    of_changeset_destroy(&overlay_changeset);
>    of_overlay_remove(&overlay_id);
> "
> 
> So increase the refcount to avoid issues.

...

> This patch also release the refcount when releasing amba device to avoid
> refcount leakage.

> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -528,6 +528,7 @@ static void amba_device_release(struct device *dev)
>  {
>  	struct amba_device *d = to_amba_device(dev);
>  
> +	of_node_put(d->dev.of_node);
>  	if (d->res.parent)
>  		release_resource(&d->res);
>  	mutex_destroy(&d->periphid_lock);

As I said, this change should be in a separate patch with the correct Fixes tag.

> index 267d8c9a5612..d328bbb679c7 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -175,7 +175,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
>  	}
>  
>  	/* setup generic device info */
> -	device_set_node(&dev->dev, of_fwnode_handle(np));
> +	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
>  	dev->dev.parent = parent ? : &platform_bus;
>  
>  	if (bus_id)
> @@ -273,7 +273,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>  
>  	/* setup generic device info */
> -	device_set_node(&dev->dev, of_fwnode_handle(node));
> +	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(node)));
>  	dev->dev.parent = parent ? : &platform_bus;
>  	dev->dev.platform_data = platform_data;
>  	if (bus_id)

Without AMBA changes,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
thank you for fixing this!

-- 
With Best Regards,
Andy Shevchenko


