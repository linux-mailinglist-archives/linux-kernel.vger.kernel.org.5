Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B727E5A8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjKHPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:54:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFF1BFF;
        Wed,  8 Nov 2023 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699458869; x=1730994869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/7OrYkQxqjhutA002dXdv4dY2ZysV2Oh0Kjailiud7M=;
  b=dKDFxchXVB6s2n2Vm6G9veQq3o6ZBdjHRCH6+V2mEYpDa0EO0Mit0KjX
   2HuW4TIn/1Iu099J8uXJVrw/wwn32fnQZvKQak4xDtMLUh0Zb/HwXfnRe
   Mv65VCbIEbVq/B8yNP1mO1RrLOuqT18ZCqv53uwxX+Quyk0hdUTmOxyKB
   SE8E83DZSRXnXxueb9HdKwEPZKnpXmq7e3IDcKt6FHHveVq50wyIEjc38
   qLI478kpljV/19DrPgyUUoflHp1J7jeJ3wHN2qcGIjhFZ+X8kFcQCHcO7
   AP3PcMWH3g+CrHwsHerf7ptbVO8RXD0dWR2Y5mKnA8Y8OIJVFHb0JE2Rh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476020979"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="476020979"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 07:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="1094537716"
X-IronPort-AV: E=Sophos;i="6.03,286,1694761200"; 
   d="scan'208";a="1094537716"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 08 Nov 2023 07:54:26 -0800
Date:   Wed, 8 Nov 2023 23:52:52 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
> 
> 
> On 2023-10-30 09:32, Xu Yilun wrote:
> > On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
> >> Remove unnecessary module reference counting from the core components
> >> of the subsystem. Low-level driver modules cannot be removed before
> >> core modules since they use their exported symbols.
> > 
> > Could you help show the code for this conclusion?
> > 
> > This is different from what I remember, a module cannot be removed when
> > its exported symbols are being used by other modules. IOW, the core
> > modules cannot be removed when there exist related low-level driver
> > modules. But the low-level driver modules could be removed freely
> > without other protecting mechanism.
> >
> 
> My understanding was that we wanted to remove module reference counting
> from the fpga core and ease it from the responsibility of preventing
> low-level driver modules from being unloaded. 

FPGA core needs to prevent low-level driver module unloading sometimes,
e.g. when region reprograming is in progress. That's why we get fpga
region driver modules & bridge modules in fpga_region_program_fpga().

But we try best to get them only necessary. Blindly geting them all the
time results in no way to unload all modules (core & low level modules).

> 
> If we want to keep reference counting in the fpga core, we could add a
> struct module *owner field in the struct fpga_manager_ops (and others
> core *_ops) so that the low-level driver can set it to THIS_MODULE.
> In this way, we can later use it in fpga_mgr_register() to bump up the

Yes, we should pass the module owner in fpga_mgr_register(), but could
not bump up its refcount at once.

> refcount of the low-level driver module by calling
> try_module_get(mgr->mops->owner) directly when it registers the manager.
> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
> to allow unloading the low-level driver module.

As mentioned above, that makes problem. Most of the low level driver
modules call fpga_mgr_unregister() on module_exit(), but bumping up
their module refcount prevents module_exit() been executed. That came
out to be a dead lock.

> 
> In this way, it would no longer be necessary to call try_module_get()
> in fpga_mrg_get() since we could use a kref (included in the struct
> fpga_manager) to do refcounting for the in-kernel API users. Only when
> the kref reaches zero fpga_mgr_unregister() would succeed and put the
> low-level driver module.
> 
> I think this approach would be safer since it would avoid the crash
> that can currently happen if the low-level driver module is removed
> right when executing try_module_get() in fpga_mrg_get(). The possible
> caveat is that it would be required to call fpga_mgr_unregister()
> before being able to remove the low-level driver module.
> 
> >>
> >> For more context, refer to this thread:
> >> https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
> >>
> >> Other changes:
> >>
> >> In  __fpga_bridge_get(): do a (missing ?) get_device() and bind the
> > 
> > I think get_device() is in (of)_fpga_bridge_get() -> class_find_device()
> > and put_device() correspond to it.
> >
> 
> You are right. I missed that one.
>  
> > But the code style here is rather misleading, the put_device() should be
> > moved out to (of)_fpga_bridge_get().
> >
> 
> Right, I'll improve the (of)_fpga_bridge_get() style for the next version.
> 
> >> image to the bridge only after the mutex has been acquired.
> > 
> > This is good to me.
> > 
> >>
> >> In __fpga_mgr_get(): do a get_device(). Currently, get_device() is
> >> called when allocating an image in fpga_image_info_alloc().
> >> However, since there are still two (of_)fpga_mgr_get() functions
> >> exposed by the core, I think they should behave as expected.
> > 
> > Same as fpga bridge.
> > 
> >>
> >> In fpga_region_get() / fpga_region_put(): call get_device() before
> >> acquiring the mutex and put_device() after having released the mutex
> >> to avoid races.
> > 
> > Could you help elaborate more about the race?
> > 
> 
> I accidentally misused the word race. My concern was that memory might
> be released after the last put_device(), causing mutex_unlock() to be
> called on a mutex that does not exist anymore. It should not happen
> for the moment since the region does not use devres, but I think it
> still makes the code more brittle.

It makes sense.

But I dislike the mutex itself. The purpose is to exclusively grab the
device, but a mutex is too much heavy for this. The lock/unlock of mutex
scattered in different functions is also an uncommon style. Maybe some
atomic count should be enough.

Thanks,
Yilun


> 
> > Thanks,
> > Yilun
> > 
> >>
> >> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/fpga-bridge.c | 24 +++++++-----------------
> >>  drivers/fpga/fpga-mgr.c    |  8 +-------
> >>  drivers/fpga/fpga-region.c | 14 ++++----------
> >>  3 files changed, 12 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> >> index a024be2b84e2..3bcc9c9849c5 100644
> >> --- a/drivers/fpga/fpga-bridge.c
> >> +++ b/drivers/fpga/fpga-bridge.c
> >> @@ -58,30 +58,21 @@ EXPORT_SYMBOL_GPL(fpga_bridge_disable);
> >>  static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
> >>  					     struct fpga_image_info *info)
> >>  {
> >> -	struct fpga_bridge *bridge;
> >> -	int ret = -ENODEV;
> >> -
> >> -	bridge = to_fpga_bridge(dev);
> >> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> >>  
> >> -	bridge->info = info;
> >> +	get_device(dev);
> >>  
> >>  	if (!mutex_trylock(&bridge->mutex)) {
> >> -		ret = -EBUSY;
> >> -		goto err_dev;
> >> +		dev_dbg(dev, "%s: FPGA Bridge already in use\n", __func__);
> >> +		put_device(dev);
> >> +		return ERR_PTR(-EBUSY);
> >>  	}
> >>  
> >> -	if (!try_module_get(dev->parent->driver->owner))
> >> -		goto err_ll_mod;
> >> +	bridge->info = info;
> >>  
> >>  	dev_dbg(&bridge->dev, "get\n");
> >>  
> >>  	return bridge;
> >> -
> >> -err_ll_mod:
> >> -	mutex_unlock(&bridge->mutex);
> >> -err_dev:
> >> -	put_device(dev);
> >> -	return ERR_PTR(ret);
> >>  }
> >>  
> >>  /**
> >> @@ -93,7 +84,7 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
> >>   * Return:
> >>   * * fpga_bridge struct pointer if successful.
> >>   * * -EBUSY if someone already has a reference to the bridge.
> >> - * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
> >> + * * -ENODEV if @np is not an FPGA Bridge.
> >>   */
> >>  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
> >>  				       struct fpga_image_info *info)
> >> @@ -146,7 +137,6 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
> >>  	dev_dbg(&bridge->dev, "put\n");
> >>  
> >>  	bridge->info = NULL;
> >> -	module_put(bridge->dev.parent->driver->owner);
> >>  	mutex_unlock(&bridge->mutex);
> >>  	put_device(&bridge->dev);
> >>  }
> >> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> >> index 06651389c592..6c355eafd18f 100644
> >> --- a/drivers/fpga/fpga-mgr.c
> >> +++ b/drivers/fpga/fpga-mgr.c
> >> @@ -670,14 +670,9 @@ static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> >>  
> >>  	mgr = to_fpga_manager(dev);
> >>  
> >> -	if (!try_module_get(dev->parent->driver->owner))
> >> -		goto err_dev;
> >> +	get_device(&mgr->dev);
> >>  
> >>  	return mgr;
> >> -
> >> -err_dev:
> >> -	put_device(dev);
> >> -	return ERR_PTR(-ENODEV);
> >>  }
> >>  
> >>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
> >> @@ -727,7 +722,6 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
> >>   */
> >>  void fpga_mgr_put(struct fpga_manager *mgr)
> >>  {
> >> -	module_put(mgr->dev.parent->driver->owner);
> >>  	put_device(&mgr->dev);
> >>  }
> >>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
> >> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> >> index b364a929425c..c299956cafdc 100644
> >> --- a/drivers/fpga/fpga-region.c
> >> +++ b/drivers/fpga/fpga-region.c
> >> @@ -41,22 +41,17 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
> >>   * Return:
> >>   * * fpga_region struct if successful.
> >>   * * -EBUSY if someone already has a reference to the region.
> >> - * * -ENODEV if can't take parent driver module refcount.
> >>   */
> >>  static struct fpga_region *fpga_region_get(struct fpga_region *region)
> >>  {
> >>  	struct device *dev = &region->dev;
> >>  
> >> +	get_device(dev);
> >> +
> >>  	if (!mutex_trylock(&region->mutex)) {
> >>  		dev_dbg(dev, "%s: FPGA Region already in use\n", __func__);
> >> -		return ERR_PTR(-EBUSY);
> >> -	}
> >> -
> >> -	get_device(dev);
> >> -	if (!try_module_get(dev->parent->driver->owner)) {
> >>  		put_device(dev);
> >> -		mutex_unlock(&region->mutex);
> >> -		return ERR_PTR(-ENODEV);
> >> +		return ERR_PTR(-EBUSY);
> >>  	}
> >>  
> >>  	dev_dbg(dev, "get\n");
> >> @@ -75,9 +70,8 @@ static void fpga_region_put(struct fpga_region *region)
> >>  
> >>  	dev_dbg(dev, "put\n");
> >>  
> >> -	module_put(dev->parent->driver->owner);
> >> -	put_device(dev);
> >>  	mutex_unlock(&region->mutex);
> >> +	put_device(dev);
> >>  }
> >>  
> >>  /**
> >> -- 
> >> 2.41.0
> >>
> > 
> 
