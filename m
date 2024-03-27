Return-Path: <linux-kernel+bounces-121911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C6C88EF43
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BB11F344F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F8152186;
	Wed, 27 Mar 2024 19:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VR1KKxmk"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339B14D44C;
	Wed, 27 Mar 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567975; cv=none; b=r6+cV0zTk26hLdkCRZQQjJdEl9oxfCmzofbhrZfDiKnD0AGeF7qoNw248sTvZwsVVTl7YZcC5Ov2sOsnjc3xZwQcn83FqwEgU0c5LcR2hx8qe+4qIiBhw/JZsmr8DJvp5uR4+vVFVih/5qfEmhwtm9SiBbF11nzWRJCCSHS9ZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567975; c=relaxed/simple;
	bh=Os7YZZRCGSP4NjzbD4f0fGXEJhfQIiP7fALw+P57UKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WycLI3TJK+caqmKuaIgU3n5MiA5Yb+bo6HGYiE13cUmqoJznbvtuUBa6qpHldO+cG8ieoMzrvuD+WTPHQU0tn+xCBkchz4GNn6YhtmA4abvBWIThglFYyU7COW1yK2/NlNzJkLDXMCPffuIeYDWnhNeVb+eaHjgW5ISKqA39Nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VR1KKxmk; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Mar 2024 12:32:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711567970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mi9KgqnvD5sPg3g6jo5E4/Llgztv5BH5/sWBg8KHfpg=;
	b=VR1KKxmkjQkIMfImy9P99BjJ4ecW68Lw3mfy/CS/1QGjwScdYy+A6UxK7ZjDErYMJXLc21
	OduELkySTh20Qf+KpmUBagXs2zBwT5O9lEI79ZSuFzfN5tlicCtVt/7c9xGIBuqjwb0Z4q
	AhgOd9M7ko10JPNJRH9u1JV9HqwqQ0k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: region: add owner module and take its refcount
Message-ID: <20240327193235.rsusnknmouknjgyg@4VRSMR2-DT.corp.robot.car>
References: <20240327160022.202934-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327160022.202934-1-marpagan@redhat.com>
X-Migadu-Flow: FLOW_OUT


On Wed, Mar 27, 2024 at 05:00:20PM +0100, Marco Pagani wrote:
> The current implementation of the fpga region assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the region
> during programming if the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_region
> struct and use it to take the module's refcount. Modify the functions for
> registering a region to take an additional owner module parameter and
> rename them to avoid conflicts. Use the old function names for helper
> macros that automatically set the module that registers the region as the
> owner. This ensures compatibility with existing low-level control modules
> and reduces the chances of registering a region without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga region.
> 
> Other changes: unlock the mutex before calling put_device() in
> fpga_region_put() to avoid potential use after release issues.
> 
> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Xu Yilun <yilun.xu@intel.com>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
> 
> v2:
> - Fixed typo in the documentation sets -> set
> - Renamed owner pointer get_br_owner -> br_owner
> ---
>  Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
>  drivers/fpga/fpga-region.c                    | 26 +++++++++++--------
>  include/linux/fpga/fpga-region.h              | 13 +++++++---
>  3 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
> index dc55d60a0b4a..77190a5ef330 100644
> --- a/Documentation/driver-api/fpga/fpga-region.rst
> +++ b/Documentation/driver-api/fpga/fpga-region.rst
> @@ -46,13 +46,16 @@ API to add a new FPGA region
>  ----------------------------
>  
>  * struct fpga_region - The FPGA region struct
> -* struct fpga_region_info - Parameter structure for fpga_region_register_full()
> -* fpga_region_register_full() -  Create and register an FPGA region using the
> +* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
> +* __fpga_region_register_full() -  Create and register an FPGA region using the
>    fpga_region_info structure to provide the full flexibility of options
> -* fpga_region_register() -  Create and register an FPGA region using standard
> +* __fpga_region_register() -  Create and register an FPGA region using standard
>    arguments
>  * fpga_region_unregister() -  Unregister an FPGA region
>  
> +Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
> +automatically set the module that registers the FPGA region as the owner.
> +
>  The FPGA region's probe function will need to get a reference to the FPGA
>  Manager it will be using to do the programming.  This usually would happen
>  during the region's probe function.
> @@ -82,10 +85,10 @@ following APIs to handle building or tearing down that list.
>     :functions: fpga_region_info
>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_register_full
> +   :functions: __fpga_region_register
>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
> -   :functions: fpga_region_register
> +   :functions: __fpga_region_register_full
>  
>  .. kernel-doc:: drivers/fpga/fpga-region.c
>     :functions: fpga_region_unregister
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b364a929425c..1beb7415c2dc 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>  	}
>  
>  	get_device(dev);
> -	if (!try_module_get(dev->parent->driver->owner)) {
> +	if (!try_module_get(region->br_owner)) {
>  		put_device(dev);
>  		mutex_unlock(&region->mutex);
>  		return ERR_PTR(-ENODEV);
> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
>  
>  	dev_dbg(dev, "put\n");
>  
> -	module_put(dev->parent->driver->owner);
> -	put_device(dev);
> +	module_put(region->br_owner);
>  	mutex_unlock(&region->mutex);
> +	put_device(dev);
>  }
>  
>  /**
> @@ -181,14 +181,16 @@ static struct attribute *fpga_region_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_region);
>  
>  /**
> - * fpga_region_register_full - create and register an FPGA Region device
> + * __fpga_region_register_full - create and register an FPGA Region device
>   * @parent: device parent
>   * @info: parameters for FPGA Region
> + * @owner: owner module containing the get_bridges function
>   *
>   * Return: struct fpga_region or ERR_PTR()
>   */
>  struct fpga_region *
> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
> +			    struct module *owner)
>  {
>  	struct fpga_region *region;
>  	int id, ret = 0;
> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  	region->compat_id = info->compat_id;
>  	region->priv = info->priv;
>  	region->get_bridges = info->get_bridges;
> +	region->br_owner = owner;
>  
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
>  
>  /**
> - * fpga_region_register - create and register an FPGA Region device
> + * __fpga_region_register - create and register an FPGA Region device
>   * @parent: device parent
>   * @mgr: manager that programs this region
>   * @get_bridges: optional function to get bridges to a list
> + * @owner: owner module containing get_bridges function
>   *
>   * This simple version of the register function should be sufficient for most users.
>   * The fpga_region_register_full() function is available for users that need to
> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>   * Return: struct fpga_region or ERR_PTR()
>   */
>  struct fpga_region *
> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> -		     int (*get_bridges)(struct fpga_region *))
> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
>  {
>  	struct fpga_region_info info = { 0 };
>  
>  	info.mgr = mgr;
>  	info.get_bridges = get_bridges;
>  
> -	return fpga_region_register_full(parent, &info);
> +	return __fpga_region_register_full(parent, &info, owner);
>  }
> -EXPORT_SYMBOL_GPL(fpga_region_register);
> +EXPORT_SYMBOL_GPL(__fpga_region_register);
>  
>  /**
>   * fpga_region_unregister - unregister an FPGA region
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 9d4d32909340..d175babc3d68 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -36,6 +36,7 @@ struct fpga_region_info {
>   * @mgr: FPGA manager
>   * @info: FPGA image info
>   * @compat_id: FPGA region id for compatibility check.
> + * @br_owner: module containing the get_bridges function
>   * @priv: private data
>   * @get_bridges: optional function to get bridges to a list
>   */
> @@ -46,6 +47,7 @@ struct fpga_region {
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
>  	struct fpga_compat_id *compat_id;
> +	struct module *br_owner;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
>  };
> @@ -58,12 +60,17 @@ fpga_region_class_find(struct device *start, const void *data,
>  
>  int fpga_region_program_fpga(struct fpga_region *region);
>  
> +#define fpga_region_register_full(parent, info) \
> +	__fpga_region_register_full(parent, info, THIS_MODULE)
>  struct fpga_region *
> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info);
> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
> +			    struct module *owner);
>  
> +#define fpga_region_register(parent, mgr, get_bridges) \
> +	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
>  struct fpga_region *
> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> -		     int (*get_bridges)(struct fpga_region *));
> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> +		       int (*get_bridges)(struct fpga_region *), struct module *owner);
>  void fpga_region_unregister(struct fpga_region *region);
>  
>  #endif /* _FPGA_REGION_H */
> 
> base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
> -- 
> 2.44.0
> 

