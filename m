Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C37785E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHKDQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjHKDPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:15:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D930F2;
        Thu, 10 Aug 2023 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691723733; x=1723259733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1Innp5KVvYlO8WEPYJXvVrGQbYPYKLKRdIHOXxRaxrU=;
  b=CzGMevctmKDyi6DjWIBbOCSoZWB6GbmBDSBJMCv4fPMrv/Y0MpCq2xeA
   vD1WCERU+f1XloBZ4CjjCUveJns0bMS74pOqq+YLARq2n39RPRuwn4mAZ
   4wo/Aa/vbM9BYNf1PxiZVPQQqHb258mJHI9NQw/FIF0IBlm7HLHvGPwCG
   8cOtvWOqR0RweSosXVcAoE02+euVqhiR7jWrtk1Po8517i/W7vvq960gI
   uSpV6sjA2iDxqV3xsKONpFub+tMOurf+J7iKQ5WASJC3zCPi3Du31eeqA
   c9i5jj7fbHi05cMg14Ps6AeIiuiUrAWfJ2vG3PnVHioxZunxcwzNv6KjB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375294795"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="375294795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="762039197"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="762039197"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 20:15:30 -0700
Date:   Fri, 11 Aug 2023 11:13:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 3/3] fpga: region: make fpga_region_class a static const
 structure
Message-ID: <ZNWnTxcRtx+tcQqF@yilunxu-OptiPlex-7050>
References: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
 <20230810172210.6338-3-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810172210.6338-3-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10 at 21:22:10 +0400, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the fpga_region_class structure to be declared at build
> time placing it into read-only memory, instead of having to be
> dynamically allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  drivers/fpga/fpga-region.c | 64 ++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index ccf6fdab1360..01cf4c2f83d1 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -16,21 +16,6 @@
>  #include <linux/spinlock.h>
>  
>  static DEFINE_IDA(fpga_region_ida);
> -static struct class *fpga_region_class;
> -
> -struct fpga_region *
> -fpga_region_class_find(struct device *start, const void *data,
> -		       int (*match)(struct device *, const void *))
> -{
> -	struct device *dev;
> -
> -	dev = class_find_device(fpga_region_class, start, data, match);
> -	if (!dev)
> -		return NULL;
> -
> -	return to_fpga_region(dev);
> -}
> -EXPORT_SYMBOL_GPL(fpga_region_class_find);
>  
>  /**
>   * fpga_region_get - get an exclusive reference to an fpga region
> @@ -179,6 +164,34 @@ static struct attribute *fpga_region_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(fpga_region);
>  
> +static void fpga_region_dev_release(struct device *dev)
> +{
> +	struct fpga_region *region = to_fpga_region(dev);
> +
> +	ida_free(&fpga_region_ida, region->dev.id);
> +	kfree(region);
> +}
> +
> +static const struct class fpga_region_class = {
> +	.name = "fpga_region",
> +	.dev_groups = fpga_region_groups,
> +	.dev_release = fpga_region_dev_release,
> +};

Same concern as previous patches。

Thanks,
Yilun

> +
> +struct fpga_region *
> +fpga_region_class_find(struct device *start, const void *data,
> +		       int (*match)(struct device *, const void *))
> +{
> +	struct device *dev;
> +
> +	dev = class_find_device(&fpga_region_class, start, data, match);
> +	if (!dev)
> +		return NULL;
> +
> +	return to_fpga_region(dev);
> +}
> +EXPORT_SYMBOL_GPL(fpga_region_class_find);
> +
>  /**
>   * fpga_region_register_full - create and register an FPGA Region device
>   * @parent: device parent
> @@ -216,7 +229,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
>  
> -	region->dev.class = fpga_region_class;
> +	region->dev.class = &fpga_region_class;
>  	region->dev.parent = parent;
>  	region->dev.of_node = parent->of_node;
>  	region->dev.id = id;
> @@ -279,33 +292,18 @@ void fpga_region_unregister(struct fpga_region *region)
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_unregister);
>  
> -static void fpga_region_dev_release(struct device *dev)
> -{
> -	struct fpga_region *region = to_fpga_region(dev);
> -
> -	ida_free(&fpga_region_ida, region->dev.id);
> -	kfree(region);
> -}
> -
>  /**
>   * fpga_region_init - init function for fpga_region class
>   * Creates the fpga_region class and registers a reconfig notifier.
>   */
>  static int __init fpga_region_init(void)
>  {
> -	fpga_region_class = class_create("fpga_region");
> -	if (IS_ERR(fpga_region_class))
> -		return PTR_ERR(fpga_region_class);
> -
> -	fpga_region_class->dev_groups = fpga_region_groups;
> -	fpga_region_class->dev_release = fpga_region_dev_release;
> -
> -	return 0;
> +	return class_register(&fpga_region_class);
>  }
>  
>  static void __exit fpga_region_exit(void)
>  {
> -	class_destroy(fpga_region_class);
> +	class_unregister(&fpga_region_class);
>  	ida_destroy(&fpga_region_ida);
>  }
>  
> -- 
> 2.34.1
> 
