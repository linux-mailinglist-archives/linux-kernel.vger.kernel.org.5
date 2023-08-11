Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF47785D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjHKDOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:14:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC12D69;
        Thu, 10 Aug 2023 20:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691723659; x=1723259659;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLoxeYfm7WHipFkGf7RfyZpi481TiGg6SZGbgG20eOU=;
  b=Ie10cXZnt/zvouY9kRCNqDeID7HDIzQyxN8sHRWmwmufymhfEQWatZ01
   AP6CGrJUg1r3ajXHh8KDMbPKqeekmuHpVcMFb0mn4qYn8PDZqIi/h2z4h
   pEJn7z3/Mzg79KrEbQl4bv3VKBg7DPxS8HydWWAXVMTwY9MP8FpILdKVO
   67Le1zXDNUzeR4fxk6VdrqVUq1Wku6kEenxNpXNkQqnbh7Lms3dctZTT1
   M2FTZSkTo6srP06Y8QF9DVlH6ZINEFGo3UvuL+IoEqniGmGeG3Khrx2Mu
   m/ZQfy8N2lmIj05qsLIjcYS561tSqm2Q6vGbjPCHT9dDOWLVGx0RP32tx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437921672"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="437921672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="732517057"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="732517057"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2023 20:14:15 -0700
Date:   Fri, 11 Aug 2023 11:12:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/3] fpga: fpga-mgr: make fpga_mgr_class a static const
 structure
Message-ID: <ZNWnBCDgvimXmnkw@yilunxu-OptiPlex-7050>
References: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
 <20230810172210.6338-2-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810172210.6338-2-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10 at 21:22:09 +0400, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the fpga_mgr_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  drivers/fpga/fpga-mgr.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index eb583f86a0b9..cd5b7371495b 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -19,7 +19,6 @@
>  #include <linux/highmem.h>
>  
>  static DEFINE_IDA(fpga_mgr_ida);
> -static struct class *fpga_mgr_class;
>  
>  struct fpga_mgr_devres {
>  	struct fpga_manager *mgr;
> @@ -664,6 +663,20 @@ static struct attribute *fpga_mgr_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(fpga_mgr);
>  
> +static void fpga_mgr_dev_release(struct device *dev)
> +{
> +	struct fpga_manager *mgr = to_fpga_manager(dev);
> +
> +	ida_free(&fpga_mgr_ida, mgr->dev.id);
> +	kfree(mgr);
> +}
> +
> +static const struct class fpga_mgr_class = {
> +	.name = "fpga_manager",
> +	.dev_groups = fpga_mgr_groups,
> +	.dev_release = fpga_mgr_dev_release,
> +};

Same concern as fpga_bridge, keep the forward declaration and put the
definiton below.

Thanks,
Yilun

> +
>  static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>  {
>  	struct fpga_manager *mgr;
> @@ -693,7 +706,7 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>   */
>  struct fpga_manager *fpga_mgr_get(struct device *dev)
>  {
> -	struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
> +	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
>  						   fpga_mgr_dev_match);
>  	if (!mgr_dev)
>  		return ERR_PTR(-ENODEV);
> @@ -713,7 +726,7 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>  {
>  	struct device *dev;
>  
> -	dev = class_find_device_by_of_node(fpga_mgr_class, node);
> +	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>  	if (!dev)
>  		return ERR_PTR(-ENODEV);
>  
> @@ -809,7 +822,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  	mgr->priv = info->priv;
>  	mgr->compat_id = info->compat_id;
>  
> -	mgr->dev.class = fpga_mgr_class;
> +	mgr->dev.class = &fpga_mgr_class;
>  	mgr->dev.groups = mops->groups;
>  	mgr->dev.parent = parent;
>  	mgr->dev.of_node = parent->of_node;
> @@ -959,31 +972,16 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
>  }
>  EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>  
> -static void fpga_mgr_dev_release(struct device *dev)
> -{
> -	struct fpga_manager *mgr = to_fpga_manager(dev);
> -
> -	ida_free(&fpga_mgr_ida, mgr->dev.id);
> -	kfree(mgr);
> -}
> -
>  static int __init fpga_mgr_class_init(void)
>  {
>  	pr_info("FPGA manager framework\n");
>  
> -	fpga_mgr_class = class_create("fpga_manager");
> -	if (IS_ERR(fpga_mgr_class))
> -		return PTR_ERR(fpga_mgr_class);
> -
> -	fpga_mgr_class->dev_groups = fpga_mgr_groups;
> -	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
> -
> -	return 0;
> +	return class_register(&fpga_mgr_class);
>  }
>  
>  static void __exit fpga_mgr_class_exit(void)
>  {
> -	class_destroy(fpga_mgr_class);
> +	class_unregister(&fpga_mgr_class);
>  	ida_destroy(&fpga_mgr_ida);
>  }
>  
> -- 
> 2.34.1
> 
