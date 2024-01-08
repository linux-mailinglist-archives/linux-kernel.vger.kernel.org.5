Return-Path: <linux-kernel+bounces-19249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF1826A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA92B22390
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFD01173A;
	Mon,  8 Jan 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRKoWluq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54261170D;
	Mon,  8 Jan 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704705029; x=1736241029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lTpVUtunivciSu+IzxCih4cIwXqRv53jcbZaSx4AzZk=;
  b=TRKoWluqeM9Sda8vmLHe28f0Fz8PziGlJKgwWi2G4TN6hEBAnH3hb3oG
   wDWkXiagiSK4ISJEguVL7sXYZL/ZF6YEAQS78pAy21/95alRSKJN1/drE
   zcws7WGpMSXLLcLriHeQwjs/8WvgFtcbqdYR4S17vcWeC+0s8+Cu0Ei4c
   e81+g5psTIoBZMmMtFOypRqyJ4nkbn5YZrFnYGJcLhd79O+R8hxQ60XJ2
   rMscpUZtLPSzfDVcP3XoLlTTjBSISQtOoXWDxX68L1W4KFsOdruaV3WpC
   LSc6gfuuGiG1Z+CoWTpNqpw7Bamx8gQR4Sugk1HkwNrNpfY+lZHfeDx7U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="16429533"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="16429533"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 01:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028351864"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028351864"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jan 2024 01:10:25 -0800
Date: Mon, 8 Jan 2024 17:07:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Message-ID: <ZZu7Uf3kC1i3zho3@yilunxu-OptiPlex-7050>
References: <20240105231526.109247-1-marpagan@redhat.com>
 <20240105231526.109247-2-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105231526.109247-2-marpagan@redhat.com>

On Sat, Jan 06, 2024 at 12:15:26AM +0100, Marco Pagani wrote:
> Add a module owner field to the fpga_manager struct to take the
> low-level control module refcount instead of assuming that the parent
> device has a driver and using its owner pointer. The owner is now
> passed as an additional argument at registration time. To this end,
> the functions for registration have been modified to take an additional
> owner parameter and renamed to avoid conflicts. The old function names
> are now used for helper macros that automatically set the module that
> registers the fpga manager as the owner. This ensures compatibility
> with existing low-level control modules and reduces the chances of
> registering a manager without setting the owner.
> 
> To detect when the owner module pointer becomes stale, set the mops
> pointer to null during fpga_mgr_unregister() and test it before taking
> the module's refcount. Use a mutex to protect against a crash that can
> happen if __fpga_mgr_get() gets suspended between testing the mops
> pointer and taking the refcount while the low-level module is being
> unloaded.
> 
> Other changes: opportunistically move put_device() from __fpga_mgr_get()
> to fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since
> the device refcount in taken in these functions.
> 
> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 93 ++++++++++++++++++++++-------------
>  include/linux/fpga/fpga-mgr.h | 80 +++++++++++++++++++++++++++---
>  2 files changed, 134 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 06651389c592..d7bfbdfdf2fc 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -664,20 +664,20 @@ static struct attribute *fpga_mgr_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(fpga_mgr);
>  
> -static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> +static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
>  {
>  	struct fpga_manager *mgr;
>  
> -	mgr = to_fpga_manager(dev);
> +	mgr = to_fpga_manager(mgr_dev);
>  
> -	if (!try_module_get(dev->parent->driver->owner))
> -		goto err_dev;
> +	mutex_lock(&mgr->mops_mutex);
>  
> -	return mgr;
> +	if (!mgr->mops || !try_module_get(mgr->mops_owner))

Why move the owner out of struct fpga_manager_ops? The owner within the
ops struct makes more sense to me, it better illustrates what the mutex
is protecting.

> +		mgr = ERR_PTR(-ENODEV);
>  
> -err_dev:
> -	put_device(dev);
> -	return ERR_PTR(-ENODEV);
> +	mutex_unlock(&mgr->mops_mutex);
> +
> +	return mgr;
>  }
>  
>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
> @@ -693,12 +693,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>   */
>  struct fpga_manager *fpga_mgr_get(struct device *dev)
>  {
> -	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
> -						   fpga_mgr_dev_match);
> +	struct fpga_manager *mgr;
> +	struct device *mgr_dev;
> +
> +	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
>  	if (!mgr_dev)
>  		return ERR_PTR(-ENODEV);
>  
> -	return __fpga_mgr_get(mgr_dev);
> +	mgr = __fpga_mgr_get(mgr_dev);
> +	if (IS_ERR(mgr))
> +		put_device(mgr_dev);
> +
> +	return mgr;
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
>  
> @@ -711,13 +717,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
>   */
>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>  {
> -	struct device *dev;
> +	struct fpga_manager *mgr;
> +	struct device *mgr_dev;
>  
> -	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
> -	if (!dev)
> +	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
> +	if (!mgr_dev)
>  		return ERR_PTR(-ENODEV);
>  
> -	return __fpga_mgr_get(dev);
> +	mgr = __fpga_mgr_get(mgr_dev);
> +	if (IS_ERR(mgr))
> +		put_device(mgr_dev);
> +
> +	return mgr;
>  }
>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>  
> @@ -727,7 +738,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>   */
>  void fpga_mgr_put(struct fpga_manager *mgr)
>  {
> -	module_put(mgr->dev.parent->driver->owner);
> +	module_put(mgr->mops_owner);
>  	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> @@ -766,9 +777,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>  
>  /**
> - * fpga_mgr_register_full - create and register an FPGA Manager device
> + * __fpga_mgr_register_full - create and register an FPGA Manager device
>   * @parent:	fpga manager device from pdev
>   * @info:	parameters for fpga manager
> + * @owner:	owner module containing the ops
>   *
>   * The caller of this function is responsible for calling fpga_mgr_unregister().
>   * Using devm_fpga_mgr_register_full() instead is recommended.
> @@ -776,7 +788,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>   * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>   */
>  struct fpga_manager *
> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> +			 struct module *owner)
>  {
>  	const struct fpga_manager_ops *mops = info->mops;
>  	struct fpga_manager *mgr;
> @@ -803,6 +816,9 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  	}
>  
>  	mutex_init(&mgr->ref_mutex);
> +	mutex_init(&mgr->mops_mutex);
> +
> +	mgr->mops_owner = owner;
>  
>  	mgr->name = info->name;
>  	mgr->mops = info->mops;
> @@ -841,14 +857,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
> +EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
>  
>  /**
> - * fpga_mgr_register - create and register an FPGA Manager device
> + * __fpga_mgr_register - create and register an FPGA Manager device
>   * @parent:	fpga manager device from pdev
>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
> + * @owner:	owner module containing the ops
>   *
>   * The caller of this function is responsible for calling fpga_mgr_unregister().
>   * Using devm_fpga_mgr_register() instead is recommended. This simple
> @@ -859,8 +876,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
>   * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>   */
>  struct fpga_manager *
> -fpga_mgr_register(struct device *parent, const char *name,
> -		  const struct fpga_manager_ops *mops, void *priv)
> +__fpga_mgr_register(struct device *parent, const char *name,
> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
>  {
>  	struct fpga_manager_info info = { 0 };
>  
> @@ -868,9 +885,9 @@ fpga_mgr_register(struct device *parent, const char *name,
>  	info.mops = mops;
>  	info.priv = priv;
>  
> -	return fpga_mgr_register_full(parent, &info);
> +	return __fpga_mgr_register_full(parent, &info, owner);
>  }
> -EXPORT_SYMBOL_GPL(fpga_mgr_register);
> +EXPORT_SYMBOL_GPL(__fpga_mgr_register);
>  
>  /**
>   * fpga_mgr_unregister - unregister an FPGA manager
> @@ -888,6 +905,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  	 */
>  	fpga_mgr_fpga_remove(mgr);
>  
> +	mutex_lock(&mgr->mops_mutex);
> +
> +	mgr->mops = NULL;
> +
> +	mutex_unlock(&mgr->mops_mutex);
> +
>  	device_unregister(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
> @@ -900,9 +923,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>  }
>  
>  /**
> - * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
> + * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
>   * @parent:	fpga manager device from pdev
>   * @info:	parameters for fpga manager
> + * @owner:	owner module containing the ops
>   *
>   * Return:  fpga manager pointer on success, negative error code otherwise.
>   *
> @@ -910,7 +934,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>   * function will be called automatically when the managing device is detached.
>   */
>  struct fpga_manager *
> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> +			      struct module *owner)
>  {
>  	struct fpga_mgr_devres *dr;
>  	struct fpga_manager *mgr;
> @@ -919,7 +944,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
>  	if (!dr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	mgr = fpga_mgr_register_full(parent, info);
> +	mgr = __fpga_mgr_register_full(parent, info, owner);
>  	if (IS_ERR(mgr)) {
>  		devres_free(dr);
>  		return mgr;
> @@ -930,14 +955,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
>  
>  	return mgr;
>  }
> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
> +EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
>  
>  /**
> - * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> + * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
>   * @parent:	fpga manager device from pdev
>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
> + * @owner:	owner module containing the ops
>   *
>   * Return:  fpga manager pointer on success, negative error code otherwise.
>   *
> @@ -946,8 +972,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
>   * device is detached.
>   */
>  struct fpga_manager *
> -devm_fpga_mgr_register(struct device *parent, const char *name,
> -		       const struct fpga_manager_ops *mops, void *priv)
> +__devm_fpga_mgr_register(struct device *parent, const char *name,
> +			 const struct fpga_manager_ops *mops, void *priv,
> +			 struct module *owner)
>  {
>  	struct fpga_manager_info info = { 0 };
>  
> @@ -955,9 +982,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
>  	info.mops = mops;
>  	info.priv = priv;
>  
> -	return devm_fpga_mgr_register_full(parent, &info);
> +	return __devm_fpga_mgr_register_full(parent, &info, owner);
>  }
> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
> +EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
>  
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 54f63459efd6..967540311462 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -201,6 +201,8 @@ struct fpga_manager_ops {
>   * @state: state of fpga manager
>   * @compat_id: FPGA manager id for compatibility check.
>   * @mops: pointer to struct of fpga manager ops
> + * @mops_mutex: protects mops from low-level module removal
> + * @mops_owner: module containing the mops
>   * @priv: low level driver private date
>   */
>  struct fpga_manager {
> @@ -210,6 +212,8 @@ struct fpga_manager {
>  	enum fpga_mgr_states state;
>  	struct fpga_compat_id *compat_id;
>  	const struct fpga_manager_ops *mops;
> +	struct mutex mops_mutex;
> +	struct module *mops_owner;
>  	void *priv;
>  };
>  
> @@ -222,6 +226,7 @@ void fpga_image_info_free(struct fpga_image_info *info);
>  int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info);
>  
>  int fpga_mgr_lock(struct fpga_manager *mgr);
> +

Why adding a line?

>  void fpga_mgr_unlock(struct fpga_manager *mgr);
>  
>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
> @@ -230,18 +235,81 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>  
>  void fpga_mgr_put(struct fpga_manager *mgr);
>  
> +/**
> + * fpga_mgr_register_full - create and register an FPGA Manager device
> + * @parent:	fpga manager device from pdev
> + * @info:	parameters for fpga manager
> + *
> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> + * Using devm_fpga_mgr_register_full() instead is recommended.
> + *
> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> + */

No need to duplicate the doc, just remove it.
Same for the rest of code.

> +#define fpga_mgr_register_full(parent, info) \
> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> +

Delete the line, and ...

>  struct fpga_manager *
> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> +			 struct module *owner);

Add a line here, to make the related functions packed.
Same for the rest of code.

> +/**
> + * fpga_mgr_register - create and register an FPGA Manager device
> + * @parent:	fpga manager device from pdev
> + * @name:	fpga manager name
> + * @mops:	pointer to structure of fpga manager ops
> + * @priv:	fpga manager private data
> + *
> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> + * Using devm_fpga_mgr_register() instead is recommended. This simple
> + * version of the register function should be sufficient for most users. The
> + * fpga_mgr_register_full() function is available for users that need to pass
> + * additional, optional parameters.
> + *
> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> + */
> +#define fpga_mgr_register(parent, name, mops, priv) \
> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>  
>  struct fpga_manager *
> -fpga_mgr_register(struct device *parent, const char *name,
> -		  const struct fpga_manager_ops *mops, void *priv);
> +__fpga_mgr_register(struct device *parent, const char *name,
> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> +
>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>  
> +/**
> + * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
> + * @parent:	fpga manager device from pdev
> + * @info:	parameters for fpga manager
> + *
> + * Return:  fpga manager pointer on success, negative error code otherwise.
> + *
> + * This is the devres variant of fpga_mgr_register_full() for which the unregister
> + * function will be called automatically when the managing device is detached.
> + */
> +#define devm_fpga_mgr_register_full(parent, info) \
> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
> +
>  struct fpga_manager *
> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> +			      struct module *owner);
> +/**
> + * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> + * @parent:	fpga manager device from pdev
> + * @name:	fpga manager name
> + * @mops:	pointer to structure of fpga manager ops
> + * @priv:	fpga manager private data
> + *
> + * Return:  fpga manager pointer on success, negative error code otherwise.
> + *
> + * This is the devres variant of fpga_mgr_register() for which the
> + * unregister function will be called automatically when the managing
> + * device is detached.
> + */
> +#define devm_fpga_mgr_register(parent, name, mops, priv) \
> +	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> +
>  struct fpga_manager *
> -devm_fpga_mgr_register(struct device *parent, const char *name,
> -		       const struct fpga_manager_ops *mops, void *priv);
> +__devm_fpga_mgr_register(struct device *parent, const char *name,
> +			 const struct fpga_manager_ops *mops, void *priv,
> +			 struct module *owner);
>  
>  #endif /*_LINUX_FPGA_MGR_H */
> -- 
> 2.43.0
> 
> 

