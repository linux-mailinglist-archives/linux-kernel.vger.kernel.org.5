Return-Path: <linux-kernel+bounces-110507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB2E885FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B9E283CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312D12BF3E;
	Thu, 21 Mar 2024 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XeMVcSIn"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA285280;
	Thu, 21 Mar 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042604; cv=none; b=OoBXu1vaeZKkTwG6WT/wKZzTh4m5n4dHIHHXV6qgoHI3Oa7hkBYAojF/hetLcP/dLRgIHDhxtxJBiYlkGs5aknjQwN+GkeRlP2td48nVk9yiNls9z7PWTNiej/wXDos29113PUmvgUGUDJ68s4BtyT1XnX9znVLSMWQlhKFofrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042604; c=relaxed/simple;
	bh=RFvBsqa/3JFBaa4jNrJPtyU6QDHYomYpWFT4Lw4g8Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrG1saTVvSRcQX2X0A1AU6bGHSu3KBhcgECWCPFXAVoppDO5lUnB5AhTHXwrbTMbnRaqM8I1lmnIRNowSWfuMi1iOaX74nzOzXVYDNk9R270bRtx8Yb9l8uIMBoI4uqHwguR4/LkRBoPnpQP7JF/q9a+gCAqgpZsafEQkhj/Yi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XeMVcSIn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Mar 2024 10:36:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711042599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y5w1qSUWkIUtztCQfl7Wbh3eNB4qvllxjN3yTPK86ec=;
	b=XeMVcSInmP3YHq3330Pehuhl97rvYacVlg27wr4yMsXm6AduXOoZCZstyE8GuYLnFQlGY0
	ts17C00QSpZfo5M8IizApyf4+e5xFSvbmgkIQryzqgDaLho1RrzKAAzKg4GQHjfrG+QnfH
	U7lUOiif9A6kvFik8/1Ulab+ZmPqsj4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alan Tull <atull@opensource.altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: bridge: add owner module and take its refcount
Message-ID: <20240321173624.c3p7r3l2rvjq6vvt@4VRSMR2-DT.corp.robot.car>
References: <20240319172026.76142-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319172026.76142-1-marpagan@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 19, 2024 at 06:20:24PM +0100, Marco Pagani wrote:
> The current implementation of the fpga bridge assumes that the low-level
> module registers a driver for the parent device and uses its owner pointer
> to take the module's refcount. This approach is problematic since it can
> lead to a null pointer dereference while attempting to get the bridge if
> the parent device does not have a driver.
> 
> To address this problem, add a module owner pointer to the fpga_bridge
> struct and use it to take the module's refcount. Modify the function for
> registering a bridge to take an additional owner module parameter and
> rename it to avoid conflicts. Use the old function name for a helper macro
> that automatically sets the module that registers the bridge as the owner.
> This ensures compatibility with existing low-level control modules and
> reduces the chances of registering a bridge without setting the owner.
> 
> Also, update the documentation to keep it consistent with the new interface
> for registering an fpga bridge.
> 
> Other changes: opportunistically move put_device() from __fpga_bridge_get()
> to fpga_bridge_get() and of_fpga_bridge_get() to improve code clarity since
> the bridge device is taken in these functions.
> 
> Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Xu Yilun <yilun.xu@intel.com>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
> 
> v2:
> - Split out protection against races while taking the mod's refcount
> ---
>  Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
>  drivers/fpga/fpga-bridge.c                    | 57 ++++++++++---------
>  include/linux/fpga/fpga-bridge.h              | 10 +++-
>  3 files changed, 43 insertions(+), 31 deletions(-)
> 
> diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
> index 604208534095..d831d5ab6b0d 100644
> --- a/Documentation/driver-api/fpga/fpga-bridge.rst
> +++ b/Documentation/driver-api/fpga/fpga-bridge.rst
> @@ -6,9 +6,12 @@ API to implement a new FPGA bridge
>  
>  * struct fpga_bridge - The FPGA Bridge structure
>  * struct fpga_bridge_ops - Low level Bridge driver ops
> -* fpga_bridge_register() - Create and register a bridge
> +* __fpga_bridge_register() - Create and register a bridge
>  * fpga_bridge_unregister() - Unregister a bridge
>  
> +The helper macro ``fpga_bridge_register()`` automatically sets
> +the module that registers the bridge as the owner.
> +
>  .. kernel-doc:: include/linux/fpga/fpga-bridge.h
>     :functions: fpga_bridge
>  
> @@ -16,7 +19,7 @@ API to implement a new FPGA bridge
>     :functions: fpga_bridge_ops
>  
>  .. kernel-doc:: drivers/fpga/fpga-bridge.c
> -   :functions: fpga_bridge_register
> +   :functions: __fpga_bridge_register
>  
>  .. kernel-doc:: drivers/fpga/fpga-bridge.c
>     :functions: fpga_bridge_unregister
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 79c473b3c7c3..8ef395b49bf8 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_disable);
>  
> -static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
> +static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
>  					     struct fpga_image_info *info)
>  {
>  	struct fpga_bridge *bridge;
> -	int ret = -ENODEV;
>  
> -	bridge = to_fpga_bridge(dev);
> +	bridge = to_fpga_bridge(bridge_dev);
>  
>  	bridge->info = info;
>  
> -	if (!mutex_trylock(&bridge->mutex)) {
> -		ret = -EBUSY;
> -		goto err_dev;
> -	}
> +	if (!mutex_trylock(&bridge->mutex))
> +		return ERR_PTR(-EBUSY);
>  
> -	if (!try_module_get(dev->parent->driver->owner))
> -		goto err_ll_mod;
> +	if (!try_module_get(bridge->br_ops_owner)) {
> +		mutex_unlock(&bridge->mutex);
> +		return ERR_PTR(-ENODEV);
> +	}
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
> @@ -98,13 +91,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>  				       struct fpga_image_info *info)
>  {
> -	struct device *dev;
> +	struct fpga_bridge *bridge;
> +	struct device *bridge_dev;
>  
> -	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
> -	if (!dev)
> +	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
> +	if (!bridge_dev)
>  		return ERR_PTR(-ENODEV);
>  
> -	return __fpga_bridge_get(dev, info);
> +	bridge = __fpga_bridge_get(bridge_dev, info);
> +	if (IS_ERR(bridge))
> +		put_device(bridge_dev);
> +
> +	return bridge;
>  }
>  EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
>  
> @@ -125,6 +123,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
>  struct fpga_bridge *fpga_bridge_get(struct device *dev,
>  				    struct fpga_image_info *info)
>  {
> +	struct fpga_bridge *bridge;
>  	struct device *bridge_dev;
>  
>  	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
> @@ -132,7 +131,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
>  	if (!bridge_dev)
>  		return ERR_PTR(-ENODEV);
>  
> -	return __fpga_bridge_get(bridge_dev, info);
> +	bridge = __fpga_bridge_get(bridge_dev, info);
> +	if (IS_ERR(bridge))
> +		put_device(bridge_dev);
> +
> +	return bridge;
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_get);
>  
> @@ -146,7 +149,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
>  	dev_dbg(&bridge->dev, "put\n");
>  
>  	bridge->info = NULL;
> -	module_put(bridge->dev.parent->driver->owner);
> +	module_put(bridge->br_ops_owner);
>  	mutex_unlock(&bridge->mutex);
>  	put_device(&bridge->dev);
>  }
> @@ -316,18 +319,19 @@ static struct attribute *fpga_bridge_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_bridge);
>  
>  /**
> - * fpga_bridge_register - create and register an FPGA Bridge device
> + * __fpga_bridge_register - create and register an FPGA Bridge device
>   * @parent:	FPGA bridge device from pdev
>   * @name:	FPGA bridge name
>   * @br_ops:	pointer to structure of fpga bridge ops
>   * @priv:	FPGA bridge private data
> + * @owner:	owner module containing the br_ops
>   *
>   * Return: struct fpga_bridge pointer or ERR_PTR()
>   */
>  struct fpga_bridge *
> -fpga_bridge_register(struct device *parent, const char *name,
> -		     const struct fpga_bridge_ops *br_ops,
> -		     void *priv)
> +__fpga_bridge_register(struct device *parent, const char *name,
> +		       const struct fpga_bridge_ops *br_ops,
> +		       void *priv, struct module *owner)
>  {
>  	struct fpga_bridge *bridge;
>  	int id, ret;
> @@ -357,6 +361,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>  
>  	bridge->name = name;
>  	bridge->br_ops = br_ops;
> +	bridge->br_ops_owner = owner;
>  	bridge->priv = priv;
>  
>  	bridge->dev.groups = br_ops->groups;
> @@ -386,7 +391,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>  
>  	return ERR_PTR(ret);
>  }
> -EXPORT_SYMBOL_GPL(fpga_bridge_register);
> +EXPORT_SYMBOL_GPL(__fpga_bridge_register);
>  
>  /**
>   * fpga_bridge_unregister - unregister an FPGA bridge
> diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
> index 223da48a6d18..94c4edd047e5 100644
> --- a/include/linux/fpga/fpga-bridge.h
> +++ b/include/linux/fpga/fpga-bridge.h
> @@ -45,6 +45,7 @@ struct fpga_bridge_info {
>   * @dev: FPGA bridge device
>   * @mutex: enforces exclusive reference to bridge
>   * @br_ops: pointer to struct of FPGA bridge ops
> + * @br_ops_owner: module containing the br_ops
>   * @info: fpga image specific information
>   * @node: FPGA bridge list node
>   * @priv: low level driver private date
> @@ -54,6 +55,7 @@ struct fpga_bridge {
>  	struct device dev;
>  	struct mutex mutex; /* for exclusive reference to bridge */
>  	const struct fpga_bridge_ops *br_ops;
> +	struct module *br_ops_owner;
>  	struct fpga_image_info *info;
>  	struct list_head node;
>  	void *priv;
> @@ -79,10 +81,12 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
>  			       struct fpga_image_info *info,
>  			       struct list_head *bridge_list);
>  
> +#define fpga_bridge_register(parent, name, br_ops, priv) \
> +	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
>  struct fpga_bridge *
> -fpga_bridge_register(struct device *parent, const char *name,
> -		     const struct fpga_bridge_ops *br_ops,
> -		     void *priv);
> +__fpga_bridge_register(struct device *parent, const char *name,
> +		       const struct fpga_bridge_ops *br_ops, void *priv,
> +		       struct module *owner);
>  void fpga_bridge_unregister(struct fpga_bridge *br);
>  
>  #endif /* _LINUX_FPGA_BRIDGE_H */
> 
> base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
> -- 
> 2.44.0
> 

