Return-Path: <linux-kernel+bounces-10917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC781DEBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567441F2155B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161C4C8E;
	Mon, 25 Dec 2023 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T69GDhwH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3154A28;
	Mon, 25 Dec 2023 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703487682; x=1735023682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZhK/9udaaE/o0MDMf8RxIqIuU0E8zzHRHiAakzMZ8Zs=;
  b=T69GDhwH1PaucQmy4AUiDW7ScM4SmVTBPsoQG+h++/nz1MuNGNmN8g6A
   UMPKjL4ffBQGCsC0Dcy51mrA3ymdXbbxBDPVqocNEGibSYdtc2R9QOnTA
   j3cpkNxkh4CFUDyPhJ8lx0fXxEn10oN4nzepsqXfzdkYn3gB41LKXB2+r
   v5BR+EkspDxUk90kzuDiz4qvfvwNggi+OspQCfTaAccL+pNCf1HT0w5oZ
   yzAnb3X+annvQTSOJuYQP5ovX3nYHR+3M30i7jyxQcOotKPJE1PKqFwk2
   8usenq8d1dEPFKEWdVUmXOWly9aDsU7CvyGyFNMOwkhzImtoEyvr5EHJe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="9669362"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="9669362"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:01:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="753878539"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="753878539"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 24 Dec 2023 23:01:18 -0800
Date: Mon, 25 Dec 2023 14:58:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/2] fpga: add an owner field and use it to take
 the low-level module's refcount
Message-ID: <ZYkoIdrbqJ9w+EHg@yilunxu-OptiPlex-7050>
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-2-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218202809.84253-2-marpagan@redhat.com>

On Mon, Dec 18, 2023 at 09:28:08PM +0100, Marco Pagani wrote:
> Add a module owner field to the fpga_manager_ops struct and use it to
> take the low-level control module's refcount instead of relying on the
> parent device's driver pointer. Low-level control modules should
> statically set the owner field to THIS_MODULE. To detect when the owner

Don't be so strict, people could pass in any owner module they think it
is correct.

> module pointer becomes stale, set the mops pointer to null during
> fpga_mgr_unregister() (called by the low-level module exit function) and

No need the side note, people could call fpga_mgr_unregister() at any
time they think it is correct.

> test it before taking the module's refcount. Use a mutex to avoid a
> crash that can happen if __fpga_mgr_get() gets suspended between testing
> the mops pointer and taking the low-level refcount and then resumes when
> the low-level module has already been freed.
> 
> Thanks to Xu Yilun for suggesting the locking pattern.

I appreciate that but don't put it in changelog. A Suggested-by is
appropriate.

> 
> Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()

Opportunistically move put_device() ...

The point is, try to imply the *Other* changes are simple and relative to
the main change, or we should split the patch.

Sorry but seeing the actual change, please split. The whole change is
small and the put_device() part contributes 40% code ...

Thanks,
Yilun

> and of_fpga_mgr_get() to improve code clarity.
> 
> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 50 ++++++++++++++++++++++++-----------
>  include/linux/fpga/fpga-mgr.h |  4 +++
>  2 files changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 06651389c592..a32b7d40080d 100644
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
> +	if (!mgr->mops || !try_module_get(mgr->mops->owner))
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
> +	module_put(mgr->mops->owner);
>  	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> @@ -803,6 +814,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  	}
>  
>  	mutex_init(&mgr->ref_mutex);
> +	mutex_init(&mgr->mops_mutex);
>  
>  	mgr->name = info->name;
>  	mgr->mops = info->mops;
> @@ -888,6 +900,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
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
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 54f63459efd6..b4d9413cb444 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -162,6 +162,7 @@ struct fpga_manager_info {
>   * @write_complete: set FPGA to operating state after writing is done
>   * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>   * @groups: optional attribute groups.
> + * @owner: owner module containing the ops.
>   *
>   * fpga_manager_ops are the low level functions implemented by a specific
>   * fpga manager driver.  The optional ones are tested for NULL before being
> @@ -184,6 +185,7 @@ struct fpga_manager_ops {
>  			      struct fpga_image_info *info);
>  	void (*fpga_remove)(struct fpga_manager *mgr);
>  	const struct attribute_group **groups;
> +	struct module *owner;
>  };
>  
>  /* FPGA manager status: Partial/Full Reconfiguration errors */
> @@ -201,6 +203,7 @@ struct fpga_manager_ops {
>   * @state: state of fpga manager
>   * @compat_id: FPGA manager id for compatibility check.
>   * @mops: pointer to struct of fpga manager ops
> + * @mops_mutex: protects mops from low-level module removal
>   * @priv: low level driver private date
>   */
>  struct fpga_manager {
> @@ -209,6 +212,7 @@ struct fpga_manager {
>  	struct mutex ref_mutex;
>  	enum fpga_mgr_states state;
>  	struct fpga_compat_id *compat_id;
> +	struct mutex mops_mutex;
>  	const struct fpga_manager_ops *mops;
>  	void *priv;
>  };
> -- 
> 2.43.0
> 
> 

