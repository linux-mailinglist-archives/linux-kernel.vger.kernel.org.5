Return-Path: <linux-kernel+bounces-20383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40E827DF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47856286ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AFB8F5A;
	Tue,  9 Jan 2024 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGNU35rE"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A968F40;
	Tue,  9 Jan 2024 04:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704775411; x=1736311411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOMwNKvIfjv4Fsetfkvjkj+JAgBBt815NJyzX5jdaxU=;
  b=EGNU35rE2gdABmn5wMQ8aF0AaErrKCjvjbjgt7yM8CQ5JgRsuWY2JvRM
   ruvUeGuENccAPuxSH2FKygQaHEbQm6nbR9Oi433w71UNlXSDEQjevUTRi
   iTg8m9C86ISqYtFi8APgKdTDRPpmBasgccogW853Iu6PU0nN9w0njH4E6
   7YTwtot4Nk9bo0PfBEuQCGtWNDSsifcuVa3ikL6eWEVbpKQPoM61C+I/7
   vqWMcWf7zrmizpmlDNrv5I9hikR8O85LEVsQvHML7Fa/0Y03G9Hqnk1W+
   y3Aoe53GDaGhQo0D0N9HNIw/y8Tto0bhSwIlVvEWUJxA0A0tZuBYEgElg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="462361466"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="462361466"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 20:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905021361"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="905021361"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2024 20:43:28 -0800
Date: Tue, 9 Jan 2024 12:40:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Message-ID: <ZZzOPwV5laWA0Jv/@yilunxu-OptiPlex-7050>
References: <20240105231526.109247-1-marpagan@redhat.com>
 <20240105231526.109247-2-marpagan@redhat.com>
 <ZZu7Uf3kC1i3zho3@yilunxu-OptiPlex-7050>
 <c2026945-76ab-4224-b3af-b6991e16d282@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2026945-76ab-4224-b3af-b6991e16d282@redhat.com>

On Mon, Jan 08, 2024 at 06:24:55PM +0100, Marco Pagani wrote:
> 
> 
> On 2024-01-08 10:07, Xu Yilun wrote:
> > On Sat, Jan 06, 2024 at 12:15:26AM +0100, Marco Pagani wrote:
> >> Add a module owner field to the fpga_manager struct to take the
> >> low-level control module refcount instead of assuming that the parent
> >> device has a driver and using its owner pointer. The owner is now
> >> passed as an additional argument at registration time. To this end,
> >> the functions for registration have been modified to take an additional
> >> owner parameter and renamed to avoid conflicts. The old function names
> >> are now used for helper macros that automatically set the module that
> >> registers the fpga manager as the owner. This ensures compatibility
> >> with existing low-level control modules and reduces the chances of
> >> registering a manager without setting the owner.
> >>
> >> To detect when the owner module pointer becomes stale, set the mops
> >> pointer to null during fpga_mgr_unregister() and test it before taking
> >> the module's refcount. Use a mutex to protect against a crash that can
> >> happen if __fpga_mgr_get() gets suspended between testing the mops
> >> pointer and taking the refcount while the low-level module is being
> >> unloaded.
> >>
> >> Other changes: opportunistically move put_device() from __fpga_mgr_get()
> >> to fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since
> >> the device refcount in taken in these functions.
> >>
> >> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> >> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/fpga-mgr.c       | 93 ++++++++++++++++++++++-------------
> >>  include/linux/fpga/fpga-mgr.h | 80 +++++++++++++++++++++++++++---
> >>  2 files changed, 134 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> >> index 06651389c592..d7bfbdfdf2fc 100644
> >> --- a/drivers/fpga/fpga-mgr.c
> >> +++ b/drivers/fpga/fpga-mgr.c
> >> @@ -664,20 +664,20 @@ static struct attribute *fpga_mgr_attrs[] = {
> >>  };
> >>  ATTRIBUTE_GROUPS(fpga_mgr);
> >>  
> >> -static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> >> +static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
> >>  {
> >>  	struct fpga_manager *mgr;
> >>  
> >> -	mgr = to_fpga_manager(dev);
> >> +	mgr = to_fpga_manager(mgr_dev);
> >>  
> >> -	if (!try_module_get(dev->parent->driver->owner))
> >> -		goto err_dev;
> >> +	mutex_lock(&mgr->mops_mutex);
> >>  
> >> -	return mgr;
> >> +	if (!mgr->mops || !try_module_get(mgr->mops_owner))
> > 
> > Why move the owner out of struct fpga_manager_ops? The owner within the
> > ops struct makes more sense to me, it better illustrates what the mutex
> > is protecting.
> >
> 
> I think having the owner in fpga_manager_ops made sense when it was
> meant to be set while initializing the struct in the low-level module.
> However, since the owner is now passed as an argument and set at
> registration time, keeping it in the FPGA manager context seems more
> straightforward to me.

That's OK. But then why not directly check mops_owner here?

> 
>  
> >> +		mgr = ERR_PTR(-ENODEV);
> >>  
> >> -err_dev:
> >> -	put_device(dev);
> >> -	return ERR_PTR(-ENODEV);
> >> +	mutex_unlock(&mgr->mops_mutex);
> >> +
> >> +	return mgr;
> >>  }
> >>  
> >>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
> >> @@ -693,12 +693,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
> >>   */
> >>  struct fpga_manager *fpga_mgr_get(struct device *dev)
> >>  {
> >> -	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
> >> -						   fpga_mgr_dev_match);
> >> +	struct fpga_manager *mgr;
> >> +	struct device *mgr_dev;
> >> +
> >> +	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
> >>  	if (!mgr_dev)
> >>  		return ERR_PTR(-ENODEV);
> >>  
> >> -	return __fpga_mgr_get(mgr_dev);
> >> +	mgr = __fpga_mgr_get(mgr_dev);
> >> +	if (IS_ERR(mgr))
> >> +		put_device(mgr_dev);
> >> +
> >> +	return mgr;
> >>  }
> >>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
> >>  
> >> @@ -711,13 +717,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
> >>   */
> >>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
> >>  {
> >> -	struct device *dev;
> >> +	struct fpga_manager *mgr;
> >> +	struct device *mgr_dev;
> >>  
> >> -	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
> >> -	if (!dev)
> >> +	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
> >> +	if (!mgr_dev)
> >>  		return ERR_PTR(-ENODEV);
> >>  
> >> -	return __fpga_mgr_get(dev);
> >> +	mgr = __fpga_mgr_get(mgr_dev);
> >> +	if (IS_ERR(mgr))
> >> +		put_device(mgr_dev);
> >> +
> >> +	return mgr;
> >>  }
> >>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
> >>  
> >> @@ -727,7 +738,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
> >>   */
> >>  void fpga_mgr_put(struct fpga_manager *mgr)
> >>  {
> >> -	module_put(mgr->dev.parent->driver->owner);
> >> +	module_put(mgr->mops_owner);
> >>  	put_device(&mgr->dev);
> >>  }
> >>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> >> @@ -766,9 +777,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
> >>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> >>  
> >>  /**
> >> - * fpga_mgr_register_full - create and register an FPGA Manager device
> >> + * __fpga_mgr_register_full - create and register an FPGA Manager device
> >>   * @parent:	fpga manager device from pdev
> >>   * @info:	parameters for fpga manager
> >> + * @owner:	owner module containing the ops
> >>   *
> >>   * The caller of this function is responsible for calling fpga_mgr_unregister().
> >>   * Using devm_fpga_mgr_register_full() instead is recommended.
> >> @@ -776,7 +788,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> >>   * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> >>   */
> >>  struct fpga_manager *
> >> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
> >> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >> +			 struct module *owner)
> >>  {
> >>  	const struct fpga_manager_ops *mops = info->mops;
> >>  	struct fpga_manager *mgr;
> >> @@ -803,6 +816,9 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
> >>  	}
> >>  
> >>  	mutex_init(&mgr->ref_mutex);
> >> +	mutex_init(&mgr->mops_mutex);
> >> +
> >> +	mgr->mops_owner = owner;
> >>  
> >>  	mgr->name = info->name;
> >>  	mgr->mops = info->mops;
> >> @@ -841,14 +857,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
> >>  
> >>  	return ERR_PTR(ret);
> >>  }
> >> -EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
> >> +EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
> >>  
> >>  /**
> >> - * fpga_mgr_register - create and register an FPGA Manager device
> >> + * __fpga_mgr_register - create and register an FPGA Manager device
> >>   * @parent:	fpga manager device from pdev
> >>   * @name:	fpga manager name
> >>   * @mops:	pointer to structure of fpga manager ops
> >>   * @priv:	fpga manager private data
> >> + * @owner:	owner module containing the ops
> >>   *
> >>   * The caller of this function is responsible for calling fpga_mgr_unregister().
> >>   * Using devm_fpga_mgr_register() instead is recommended. This simple
> >> @@ -859,8 +876,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
> >>   * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> >>   */
> >>  struct fpga_manager *
> >> -fpga_mgr_register(struct device *parent, const char *name,
> >> -		  const struct fpga_manager_ops *mops, void *priv)
> >> +__fpga_mgr_register(struct device *parent, const char *name,
> >> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
> >>  {
> >>  	struct fpga_manager_info info = { 0 };
> >>  
> >> @@ -868,9 +885,9 @@ fpga_mgr_register(struct device *parent, const char *name,
> >>  	info.mops = mops;
> >>  	info.priv = priv;
> >>  
> >> -	return fpga_mgr_register_full(parent, &info);
> >> +	return __fpga_mgr_register_full(parent, &info, owner);
> >>  }
> >> -EXPORT_SYMBOL_GPL(fpga_mgr_register);
> >> +EXPORT_SYMBOL_GPL(__fpga_mgr_register);
> >>  
> >>  /**
> >>   * fpga_mgr_unregister - unregister an FPGA manager
> >> @@ -888,6 +905,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
> >>  	 */
> >>  	fpga_mgr_fpga_remove(mgr);
> >>  
> >> +	mutex_lock(&mgr->mops_mutex);
> >> +
> >> +	mgr->mops = NULL;

Same here, is it better set mgr->mops_owner = NULL?

> >> +
> >> +	mutex_unlock(&mgr->mops_mutex);
> >> +
> >>  	device_unregister(&mgr->dev);
> >>  }
> >>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
> >> @@ -900,9 +923,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
> >>  }
> >>  
> >>  /**
> >> - * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
> >> + * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
> >>   * @parent:	fpga manager device from pdev
> >>   * @info:	parameters for fpga manager
> >> + * @owner:	owner module containing the ops
> >>   *
> >>   * Return:  fpga manager pointer on success, negative error code otherwise.
> >>   *
> >> @@ -910,7 +934,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
> >>   * function will be called automatically when the managing device is detached.
> >>   */
> >>  struct fpga_manager *
> >> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
> >> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >> +			      struct module *owner)
> >>  {
> >>  	struct fpga_mgr_devres *dr;
> >>  	struct fpga_manager *mgr;
> >> @@ -919,7 +944,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
> >>  	if (!dr)
> >>  		return ERR_PTR(-ENOMEM);
> >>  
> >> -	mgr = fpga_mgr_register_full(parent, info);
> >> +	mgr = __fpga_mgr_register_full(parent, info, owner);
> >>  	if (IS_ERR(mgr)) {
> >>  		devres_free(dr);
> >>  		return mgr;
> >> @@ -930,14 +955,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
> >>  
> >>  	return mgr;
> >>  }
> >> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
> >> +EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
> >>  
> >>  /**
> >> - * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> >> + * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> >>   * @parent:	fpga manager device from pdev
> >>   * @name:	fpga manager name
> >>   * @mops:	pointer to structure of fpga manager ops
> >>   * @priv:	fpga manager private data
> >> + * @owner:	owner module containing the ops
> >>   *
> >>   * Return:  fpga manager pointer on success, negative error code otherwise.
> >>   *
> >> @@ -946,8 +972,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
> >>   * device is detached.
> >>   */
> >>  struct fpga_manager *
> >> -devm_fpga_mgr_register(struct device *parent, const char *name,
> >> -		       const struct fpga_manager_ops *mops, void *priv)
> >> +__devm_fpga_mgr_register(struct device *parent, const char *name,
> >> +			 const struct fpga_manager_ops *mops, void *priv,
> >> +			 struct module *owner)
> >>  {
> >>  	struct fpga_manager_info info = { 0 };
> >>  
> >> @@ -955,9 +982,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
> >>  	info.mops = mops;
> >>  	info.priv = priv;
> >>  
> >> -	return devm_fpga_mgr_register_full(parent, &info);
> >> +	return __devm_fpga_mgr_register_full(parent, &info, owner);
> >>  }
> >> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
> >> +EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
> >>  
> >>  static void fpga_mgr_dev_release(struct device *dev)
> >>  {
> >> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> >> index 54f63459efd6..967540311462 100644
> >> --- a/include/linux/fpga/fpga-mgr.h
> >> +++ b/include/linux/fpga/fpga-mgr.h
> >> @@ -201,6 +201,8 @@ struct fpga_manager_ops {
> >>   * @state: state of fpga manager
> >>   * @compat_id: FPGA manager id for compatibility check.
> >>   * @mops: pointer to struct of fpga manager ops
> >> + * @mops_mutex: protects mops from low-level module removal

Same here, change the doc if needed.

> >> + * @mops_owner: module containing the mops
> >>   * @priv: low level driver private date
> >>   */
> >>  struct fpga_manager {
> >> @@ -210,6 +212,8 @@ struct fpga_manager {
> >>  	enum fpga_mgr_states state;
> >>  	struct fpga_compat_id *compat_id;
> >>  	const struct fpga_manager_ops *mops;
> >> +	struct mutex mops_mutex;
> >> +	struct module *mops_owner;
> >>  	void *priv;
> >>  };
> >>  
> >> @@ -222,6 +226,7 @@ void fpga_image_info_free(struct fpga_image_info *info);
> >>  int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info);
> >>  
> >>  int fpga_mgr_lock(struct fpga_manager *mgr);
> >> +
> > 
> > Why adding a line?
> >
> 
> I'll remove the line.
>  
> >>  void fpga_mgr_unlock(struct fpga_manager *mgr);
> >>  
> >>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
> >> @@ -230,18 +235,81 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
> >>  
> >>  void fpga_mgr_put(struct fpga_manager *mgr);
> >>  
> >> +/**
> >> + * fpga_mgr_register_full - create and register an FPGA Manager device
> >> + * @parent:	fpga manager device from pdev
> >> + * @info:	parameters for fpga manager
> >> + *
> >> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> >> + * Using devm_fpga_mgr_register_full() instead is recommended.
> >> + *
> >> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> >> + */
> > 
> > No need to duplicate the doc, just remove it.
> > Same for the rest of code.
> 
> Do you mean keeping the kernel-doc comments only for the __fpga_mgr_*
> functions in fpga-mgr.c?
> 
> > 
> >> +#define fpga_mgr_register_full(parent, info) \
> >> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> >> +
> > 
> > Delete the line, and ...
> > 
> >>  struct fpga_manager *
> >> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >> +			 struct module *owner);
> > 
> > Add a line here, to make the related functions packed.
> > Same for the rest of code.
> 
> Do you prefer having the macro just above the function prototype? Like:
> 
> #define devm_fpga_mgr_register(parent, name, mops, priv) \
> 	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> struct fpga_manager *
> __devm_fpga_mgr_register(struct device *parent, const char *name,
> 			 const struct fpga_manager_ops *mops, void *priv,
> 			 struct module *owner);

Yes, that's it.

Thanks,
Yilun

> 
> > 
> >> +/**
> >> + * fpga_mgr_register - create and register an FPGA Manager device
> >> + * @parent:	fpga manager device from pdev
> >> + * @name:	fpga manager name
> >> + * @mops:	pointer to structure of fpga manager ops
> >> + * @priv:	fpga manager private data
> >> + *
> >> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> >> + * Using devm_fpga_mgr_register() instead is recommended. This simple
> >> + * version of the register function should be sufficient for most users. The
> >> + * fpga_mgr_register_full() function is available for users that need to pass
> >> + * additional, optional parameters.
> >> + *
> >> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> >> + */
> >> +#define fpga_mgr_register(parent, name, mops, priv) \
> >> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >>  
> >>  struct fpga_manager *
> >> -fpga_mgr_register(struct device *parent, const char *name,
> >> -		  const struct fpga_manager_ops *mops, void *priv);
> >> +__fpga_mgr_register(struct device *parent, const char *name,
> >> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> >> +
> >>  void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>  
> >> +/**
> >> + * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
> >> + * @parent:	fpga manager device from pdev
> >> + * @info:	parameters for fpga manager
> >> + *
> >> + * Return:  fpga manager pointer on success, negative error code otherwise.
> >> + *
> >> + * This is the devres variant of fpga_mgr_register_full() for which the unregister
> >> + * function will be called automatically when the managing device is detached.
> >> + */
> >> +#define devm_fpga_mgr_register_full(parent, info) \
> >> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
> >> +
> >>  struct fpga_manager *
> >> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >> +			      struct module *owner);
> >> +/**
> >> + * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> >> + * @parent:	fpga manager device from pdev
> >> + * @name:	fpga manager name
> >> + * @mops:	pointer to structure of fpga manager ops
> >> + * @priv:	fpga manager private data
> >> + *
> >> + * Return:  fpga manager pointer on success, negative error code otherwise.
> >> + *
> >> + * This is the devres variant of fpga_mgr_register() for which the
> >> + * unregister function will be called automatically when the managing
> >> + * device is detached.
> >> + */
> >> +#define devm_fpga_mgr_register(parent, name, mops, priv) \
> >> +	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >> +
> >>  struct fpga_manager *
> >> -devm_fpga_mgr_register(struct device *parent, const char *name,
> >> -		       const struct fpga_manager_ops *mops, void *priv);
> >> +__devm_fpga_mgr_register(struct device *parent, const char *name,
> >> +			 const struct fpga_manager_ops *mops, void *priv,
> >> +			 struct module *owner);
> >>  
> >>  #endif /*_LINUX_FPGA_MGR_H */
> >> -- 
> >> 2.43.0
> >>
> >>
> > 
> 

