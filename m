Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE257DB52F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJ3Idp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3Idn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:33:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CA4A7;
        Mon, 30 Oct 2023 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698654821; x=1730190821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pTZZVILTDl6CV7QwDr4uJHllsVXgMnf93/esVbMn9js=;
  b=OgebuEnjktFkB8ArkTmZ6VYFwr4cb6C/Y2YFspJeiZpqGtPQlj87G07U
   8zIftoLe9xdb+AXgFB150qEClDZaMmDX9xGHWoGIPnFFK+To9dgi4/Yvq
   xoPtiPjXpqe7NOsy2J1lcfap5PgkF72/Sd+cr6rILguwqyCcWCM1lqOh6
   aEtmaaWDrUdNzhp7o1FPJy0s+tmI4qW3mryBcx83h/GVGFpvY9vGN/cL7
   FPaC0/C1jh+UfgAjecuRNZjdx7ZME2wbkF2GnXLMt3n0JHDAWkR11UgOQ
   Nf5elaxQi46ejROXsyYF5sUXELkJHUTvKy1YYR53sstcPmbsZoMykMZQb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="387846748"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="387846748"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 01:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="825990939"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="825990939"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 01:33:37 -0700
Date:   Mon, 30 Oct 2023 16:32:16 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
References: <20231027152928.184012-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027152928.184012-1-marpagan@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
> Remove unnecessary module reference counting from the core components
> of the subsystem. Low-level driver modules cannot be removed before
> core modules since they use their exported symbols.

Could you help show the code for this conclusion?

This is different from what I remember, a module cannot be removed when
its exported symbols are being used by other modules. IOW, the core
modules cannot be removed when there exist related low-level driver
modules. But the low-level driver modules could be removed freely
without other protecting mechanism.

> 
> For more context, refer to this thread:
> https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
> 
> Other changes:
> 
> In  __fpga_bridge_get(): do a (missing ?) get_device() and bind the

I think get_device() is in (of)_fpga_bridge_get() -> class_find_device()
and put_device() correspond to it.

But the code style here is rather misleading, the put_device() should be
moved out to (of)_fpga_bridge_get().

> image to the bridge only after the mutex has been acquired.

This is good to me.

> 
> In __fpga_mgr_get(): do a get_device(). Currently, get_device() is
> called when allocating an image in fpga_image_info_alloc().
> However, since there are still two (of_)fpga_mgr_get() functions
> exposed by the core, I think they should behave as expected.

Same as fpga bridge.

> 
> In fpga_region_get() / fpga_region_put(): call get_device() before
> acquiring the mutex and put_device() after having released the mutex
> to avoid races.

Could you help elaborate more about the race?

Thanks,
Yilun

> 
> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 24 +++++++-----------------
>  drivers/fpga/fpga-mgr.c    |  8 +-------
>  drivers/fpga/fpga-region.c | 14 ++++----------
>  3 files changed, 12 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index a024be2b84e2..3bcc9c9849c5 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -58,30 +58,21 @@ EXPORT_SYMBOL_GPL(fpga_bridge_disable);
>  static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>  					     struct fpga_image_info *info)
>  {
> -	struct fpga_bridge *bridge;
> -	int ret = -ENODEV;
> -
> -	bridge = to_fpga_bridge(dev);
> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>  
> -	bridge->info = info;
> +	get_device(dev);
>  
>  	if (!mutex_trylock(&bridge->mutex)) {
> -		ret = -EBUSY;
> -		goto err_dev;
> +		dev_dbg(dev, "%s: FPGA Bridge already in use\n", __func__);
> +		put_device(dev);
> +		return ERR_PTR(-EBUSY);
>  	}
>  
> -	if (!try_module_get(dev->parent->driver->owner))
> -		goto err_ll_mod;
> +	bridge->info = info;
>  
>  	dev_dbg(&bridge->dev, "get\n");
>  
>  	return bridge;
> -
> -err_ll_mod:
> -	mutex_unlock(&bridge->mutex);
> -err_dev:
> -	put_device(dev);
> -	return ERR_PTR(ret);
>  }
>  
>  /**
> @@ -93,7 +84,7 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>   * Return:
>   * * fpga_bridge struct pointer if successful.
>   * * -EBUSY if someone already has a reference to the bridge.
> - * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
> + * * -ENODEV if @np is not an FPGA Bridge.
>   */
>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>  				       struct fpga_image_info *info)
> @@ -146,7 +137,6 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
>  	dev_dbg(&bridge->dev, "put\n");
>  
>  	bridge->info = NULL;
> -	module_put(bridge->dev.parent->driver->owner);
>  	mutex_unlock(&bridge->mutex);
>  	put_device(&bridge->dev);
>  }
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 06651389c592..6c355eafd18f 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -670,14 +670,9 @@ static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>  
>  	mgr = to_fpga_manager(dev);
>  
> -	if (!try_module_get(dev->parent->driver->owner))
> -		goto err_dev;
> +	get_device(&mgr->dev);
>  
>  	return mgr;
> -
> -err_dev:
> -	put_device(dev);
> -	return ERR_PTR(-ENODEV);
>  }
>  
>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
> @@ -727,7 +722,6 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>   */
>  void fpga_mgr_put(struct fpga_manager *mgr)
>  {
> -	module_put(mgr->dev.parent->driver->owner);
>  	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b364a929425c..c299956cafdc 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -41,22 +41,17 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
>   * Return:
>   * * fpga_region struct if successful.
>   * * -EBUSY if someone already has a reference to the region.
> - * * -ENODEV if can't take parent driver module refcount.
>   */
>  static struct fpga_region *fpga_region_get(struct fpga_region *region)
>  {
>  	struct device *dev = &region->dev;
>  
> +	get_device(dev);
> +
>  	if (!mutex_trylock(&region->mutex)) {
>  		dev_dbg(dev, "%s: FPGA Region already in use\n", __func__);
> -		return ERR_PTR(-EBUSY);
> -	}
> -
> -	get_device(dev);
> -	if (!try_module_get(dev->parent->driver->owner)) {
>  		put_device(dev);
> -		mutex_unlock(&region->mutex);
> -		return ERR_PTR(-ENODEV);
> +		return ERR_PTR(-EBUSY);
>  	}
>  
>  	dev_dbg(dev, "get\n");
> @@ -75,9 +70,8 @@ static void fpga_region_put(struct fpga_region *region)
>  
>  	dev_dbg(dev, "put\n");
>  
> -	module_put(dev->parent->driver->owner);
> -	put_device(dev);
>  	mutex_unlock(&region->mutex);
> +	put_device(dev);
>  }
>  
>  /**
> -- 
> 2.41.0
> 
