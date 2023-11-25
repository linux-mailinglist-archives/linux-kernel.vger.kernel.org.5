Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF47F897F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjKYJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjKYJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:13:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD15D72;
        Sat, 25 Nov 2023 01:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700903621; x=1732439621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3Xt5NNBkLMVWOGSutrChD/KMdbnzFiDM72X/z4oXI8=;
  b=QDRkfiGUl2GprRjxPmZhSv9uEVVzbaKTaLUKnRwULCB88HDYZ9+voXGe
   nugT1a8I3eLxcFG4ebE8R3QGdZhdrEbD2PtxGdEQNrShEgej1tyXwXmvb
   z133HmLJEWrZNxwANv+oYzilAmwwFkQEMLJl/eO8cYhooMTFSbsDCrfML
   v2rJjzPr5BltToxyTiP9dHWHIr2pTn5iXrpGEuhXsQsCcVEqqR62ZN9NC
   DkafGH8+uVMbRs/SV5vFY0rHt1jpmzM26nzgFRGTPRAVBDaWh+zDyZqb3
   LvopsU33aC+9M6YdI5BG8/OzVXFyI6I7KMDL1hUhrYdLiMqmK+xcVrvf/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="478709898"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="478709898"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:13:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="833880324"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="833880324"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 25 Nov 2023 01:13:39 -0800
Date:   Sat, 25 Nov 2023 17:11:42 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] fpga: add a module owner field to
 fpga_manager and fpga_manager_ops
Message-ID: <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
References: <20231124162807.238724-1-marpagan@redhat.com>
 <20231124162807.238724-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124162807.238724-2-marpagan@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:28:06PM +0100, Marco Pagani wrote:
> Add a module *owner field to the fpga_manager_ops and fpga_manager
> structs to protect the fpga manager against the unloading of the
> low-level control module while someone is holding a reference to the
> manager device. Low-level control modules should statically set the
> owner field of the fpga_manager_ops struct to THIS_MODULE. Then, when
> the manager is registered using fpga_mgr_register(), the value is copied
> into the owner field of the fpga_manager struct (that contains the
> device context). In this way, the manager can later use it in
> fpga_mgr_get() to take the low-level module's refcount. To prevent races
> while unloading the low-level control module, fpga_mgr_get() and part of
> the fpga_mgr_unregister() methods are protected with a mutex.
> 
> Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()
> and of_fpga_mgr_get() to improve code clarity.
> 
> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c       | 56 +++++++++++++++++++++++++----------
>  include/linux/fpga/fpga-mgr.h |  4 +++
>  2 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 06651389c592..608605d59860 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -21,6 +21,8 @@
>  static DEFINE_IDA(fpga_mgr_ida);
>  static const struct class fpga_mgr_class;
>  
> +static DEFINE_MUTEX(mgr_lock);
> +
>  struct fpga_mgr_devres {
>  	struct fpga_manager *mgr;
>  };
> @@ -667,17 +669,15 @@ ATTRIBUTE_GROUPS(fpga_mgr);
>  static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>  {
>  	struct fpga_manager *mgr;
> +	struct module *owner;
>  
>  	mgr = to_fpga_manager(dev);
> +	owner = mgr->owner;
>  
> -	if (!try_module_get(dev->parent->driver->owner))
> -		goto err_dev;
> +	if (owner && !try_module_get(owner))

No need to test owner == NULL, try_module_get() does this.

> +		mgr = ERR_PTR(-ENODEV);
>  
>  	return mgr;
> -
> -err_dev:
> -	put_device(dev);
> -	return ERR_PTR(-ENODEV);
>  }
>  
>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
> @@ -693,12 +693,22 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>   */
>  struct fpga_manager *fpga_mgr_get(struct device *dev)
>  {
> -	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
> -						   fpga_mgr_dev_match);
> +	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
> +	struct device *mgr_dev;
> +
> +	mutex_lock(&mgr_lock);
> +
> +	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
>  	if (!mgr_dev)
> -		return ERR_PTR(-ENODEV);
> +		goto out;
> +
> +	mgr = __fpga_mgr_get(mgr_dev);
> +	if (IS_ERR(mgr))
> +		put_device(mgr_dev);
>  
> -	return __fpga_mgr_get(mgr_dev);
> +out:
> +	mutex_unlock(&mgr_lock);
> +	return mgr;
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
>  
> @@ -711,13 +721,22 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
>   */
>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>  {
> -	struct device *dev;
> +	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
> +	struct device *mgr_dev;
> +
> +	mutex_lock(&mgr_lock);
> +
> +	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
> +	if (!mgr_dev)
> +		goto out;
>  
> -	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
> -	if (!dev)
> -		return ERR_PTR(-ENODEV);
> +	mgr = __fpga_mgr_get(mgr_dev);
> +	if (IS_ERR(mgr))
> +		put_device(mgr_dev);
>  
> -	return __fpga_mgr_get(dev);
> +out:
> +	mutex_unlock(&mgr_lock);
> +	return mgr;
>  }
>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>  
> @@ -727,7 +746,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>   */
>  void fpga_mgr_put(struct fpga_manager *mgr)
>  {
> -	module_put(mgr->dev.parent->driver->owner);
> +	module_put(mgr->owner);
>  	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> @@ -806,6 +825,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  
>  	mgr->name = info->name;
>  	mgr->mops = info->mops;
> +	mgr->owner = info->mops->owner;
>  	mgr->priv = info->priv;
>  	mgr->compat_id = info->compat_id;
>  
> @@ -888,7 +908,11 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  	 */
>  	fpga_mgr_fpga_remove(mgr);
>  
> +	mutex_lock(&mgr_lock);
> +
>  	device_unregister(&mgr->dev);
> +
> +	mutex_unlock(&mgr_lock);

Why this part should be protected rather than the whole
fpga_mgr_unregister()?

I feel the scope of the protection is unclear to me in this patch. What
data should be protected from concurrent access by this mutex? From the
code seems the racing of mgr dev should be protected but apparently it
doesn't have to.

And with this mutex, the get/put/unregister() for one mgr should be
exclusive with another mgr, but that also seems not necessary.

I think the mgr->owner & mgr->ops should be protected from concurrent
access of delete_module & fpga_mgr_get/put(), so how about:

struct fpga_manager_ops {
	struct module *owner;
	...
};

struct fpga_manager {
	...
	struct mutex mops_lock;
	const struct fpga_manager_ops *mops;
	...
};


static struct fpga_manager *__fpga_mgr_get(struct device *dev)
{
	struct fpga_manager *mgr;

	mgr = to_fpga_manager(dev);

	mutex_lock(&mgr->mops_lock);

	if (!mgr->mops || !try_module_get(mgr->mops->owner))
		mgr = ERR_PTR(-ENODEV);

	mutex_unlock(&mgr->mops_lock);
		
	return mgr;
}

void fpga_mgr_unregister(struct fpga_manager *mgr)
{
	fpga_mgr_fpga_remove(mgr);	

	mutex_lock(&mgr->ops_lock);
	mgr->mops = NULL;
	mutex_unlock(&mgr->ops_lock);

	device_unregister(&mgr->dev);	
}

Not actually tested.

Thanks,
Yilun

>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 54f63459efd6..eaf6e072dbc0 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -162,6 +162,7 @@ struct fpga_manager_info {
>   * @write_complete: set FPGA to operating state after writing is done
>   * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>   * @groups: optional attribute groups.
> + * @owner: owner module.
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
> + * @owner: owner module.
>   * @priv: low level driver private date
>   */
>  struct fpga_manager {
> @@ -210,6 +213,7 @@ struct fpga_manager {
>  	enum fpga_mgr_states state;
>  	struct fpga_compat_id *compat_id;
>  	const struct fpga_manager_ops *mops;
> +	struct module *owner;
>  	void *priv;
>  };
>  
> -- 
> 2.42.0
> 
> 
