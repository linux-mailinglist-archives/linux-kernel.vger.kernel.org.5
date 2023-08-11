Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DF7785CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHKDMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHKDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:12:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAF2722;
        Thu, 10 Aug 2023 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691723532; x=1723259532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R0cVCAmjdhuKUT2bA+/8NwDGCtyxdM9aSZgqdQJYyZY=;
  b=HqGIkhqocaq+GyZCkRZ8frkV5+xGWVEkvoKH0es0QyfAnC9H35S7bkPE
   uDiTVrz6K2/w+HGIhdrXHjVjL5bOouQKimxTLzKGRHR2DUswWjqe6hY50
   buXwAevG88QljuryfQBEkXdguXID5l4yxLWP64y+1nQsd14DzI0mgeY3r
   8okR0LfZbMeKgSQSp3UPLPlETu3ztBDyz/Q0R0XYUPF1IFBrrlh9iyREq
   ofBIsQ9us1d1wjIXWLju3+Nere4YFW/6RU9it7wv6vzQLxngs+FtPr66v
   RJLAOzzABBMMP2DpBeEfT5fSY127B+OKUgv22+ts7RPRgDF80PE/JhtvD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351898439"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351898439"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 20:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906284310"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="906284310"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2023 20:12:08 -0700
Date:   Fri, 11 Aug 2023 11:09:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] fpga: bridge: make fpga_bridge_class a static const
 structure
Message-ID: <ZNWmhLCeEu07AMPK@yilunxu-OptiPlex-7050>
References: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-10 at 21:22:08 +0400, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the fpga_bridge_class structure to be declared at build
> time placing it into read-only memory, instead of having to be
> dynamically allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  drivers/fpga/fpga-bridge.c | 106 ++++++++++++++++++-------------------
>  1 file changed, 52 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index a6c25dee9cc1..6e38ddaf16cf 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -14,7 +14,6 @@
>  #include <linux/spinlock.h>
>  
>  static DEFINE_IDA(fpga_bridge_ida);
> -static struct class *fpga_bridge_class;

Could we still use the forward declaration, to avoid moving too
much code block.

>  
>  /* Lock for adding/removing bridges to linked lists*/
>  static DEFINE_SPINLOCK(bridge_list_lock);
> @@ -84,6 +83,53 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>  	return ERR_PTR(ret);
>  }
>  
> +static ssize_t name_show(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> +
> +	return sprintf(buf, "%s\n", bridge->name);
> +}
> +
> +static ssize_t state_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> +	int state = 1;
> +
> +	if (bridge->br_ops && bridge->br_ops->enable_show) {
> +		state = bridge->br_ops->enable_show(bridge);
> +		if (state < 0)
> +			return state;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
> +}
> +
> +static DEVICE_ATTR_RO(name);
> +static DEVICE_ATTR_RO(state);
> +
> +static struct attribute *fpga_bridge_attrs[] = {
> +	&dev_attr_name.attr,
> +	&dev_attr_state.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(fpga_bridge);
> +
> +static void fpga_bridge_dev_release(struct device *dev)
> +{
> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> +
> +	ida_free(&fpga_bridge_ida, bridge->dev.id);
> +	kfree(bridge);
> +}
> +
> +static const struct class fpga_bridge_class = {
> +	.name = "fpga_bridge",
> +	.dev_groups = fpga_bridge_groups,
> +	.dev_release = fpga_bridge_dev_release,
> +};

Insert them between __fpga_bridge_get() and of_fpga_bridge_get() is not
preferred. See below comments.

> +
>  /**
>   * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
>   *
> @@ -99,7 +145,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>  {
>  	struct device *dev;
>  
> -	dev = class_find_device_by_of_node(fpga_bridge_class, np);
> +	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
>  	if (!dev)
>  		return ERR_PTR(-ENODEV);
>  
> @@ -126,7 +172,7 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
>  {
>  	struct device *bridge_dev;
>  
> -	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
> +	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
>  				       fpga_bridge_dev_match);
>  	if (!bridge_dev)
>  		return ERR_PTR(-ENODEV);
> @@ -281,39 +327,6 @@ int fpga_bridge_get_to_list(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_get_to_list);
>  
> -static ssize_t name_show(struct device *dev,
> -			 struct device_attribute *attr, char *buf)
> -{
> -	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> -
> -	return sprintf(buf, "%s\n", bridge->name);
> -}
> -
> -static ssize_t state_show(struct device *dev,
> -			  struct device_attribute *attr, char *buf)
> -{
> -	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> -	int state = 1;
> -
> -	if (bridge->br_ops && bridge->br_ops->enable_show) {
> -		state = bridge->br_ops->enable_show(bridge);
> -		if (state < 0)
> -			return state;
> -	}
> -
> -	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
> -}
> -
> -static DEVICE_ATTR_RO(name);
> -static DEVICE_ATTR_RO(state);
> -
> -static struct attribute *fpga_bridge_attrs[] = {
> -	&dev_attr_name.attr,
> -	&dev_attr_state.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(fpga_bridge);
> -
>  /**
>   * fpga_bridge_register - create and register an FPGA Bridge device
>   * @parent:	FPGA bridge device from pdev
> @@ -359,7 +372,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>  	bridge->priv = priv;
>  
>  	bridge->dev.groups = br_ops->groups;
> -	bridge->dev.class = fpga_bridge_class;
> +	bridge->dev.class = &fpga_bridge_class;
>  	bridge->dev.parent = parent;
>  	bridge->dev.of_node = parent->of_node;
>  	bridge->dev.id = id;
> @@ -407,29 +420,14 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
>  
> -static void fpga_bridge_dev_release(struct device *dev)
> -{
> -	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> -
> -	ida_free(&fpga_bridge_ida, bridge->dev.id);
> -	kfree(bridge);
> -}
> -

How about put the fpga_bridge_class definition here?

Thanks,
Yilun

>  static int __init fpga_bridge_dev_init(void)
>  {
> -	fpga_bridge_class = class_create("fpga_bridge");
> -	if (IS_ERR(fpga_bridge_class))
> -		return PTR_ERR(fpga_bridge_class);
> -
> -	fpga_bridge_class->dev_groups = fpga_bridge_groups;
> -	fpga_bridge_class->dev_release = fpga_bridge_dev_release;
> -
> -	return 0;
> +	return class_register(&fpga_bridge_class);
>  }
>  
>  static void __exit fpga_bridge_dev_exit(void)
>  {
> -	class_destroy(fpga_bridge_class);
> +	class_unregister(&fpga_bridge_class);
>  	ida_destroy(&fpga_bridge_ida);
>  }
>  
> -- 
> 2.34.1
> 
