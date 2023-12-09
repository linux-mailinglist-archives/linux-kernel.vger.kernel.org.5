Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20280B50E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 16:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjLIP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 10:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjLIP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 10:29:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BAFB;
        Sat,  9 Dec 2023 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702135778; x=1733671778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DrDxsHAvENsxX7mbYnl09JQ4cUEtmC2dirXnkaw6HZc=;
  b=WVTvsVVzyHmKOi9Zq4W/4dUXNlB4zIUCTIjXcpUy8gsdjefU/7nrly1f
   41zIxmrxMrfHQqUEnyULQEo17fVmW7f558RFRpmxmN9jHc33ooLV4d/rT
   PE+stOoFTTXfvHBwxTPinS92KpAC0yc1vFSYjZYli1CAXXXrh14PaGjfb
   cuMwX95n9vZbENDpRhVYIVwoNmHRcaRdr/AKyjVtV6PPqzQ8zeUepc/vS
   wqiXHZXKFU7KUkoxfUlLV59osbECJVK59Iq/nhsv4i4Lf4FSfkthCiYsP
   izQo45phFmPKyB4mF0D2yRqi4t2sYQga4KDlYBxJmC35mtRHsvtTehjo6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1387975"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1387975"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 07:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1103890949"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1103890949"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 09 Dec 2023 07:29:35 -0800
Date:   Sat, 9 Dec 2023 23:27:18 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] fpga: add a module owner field to
 fpga_manager and fpga_manager_ops
Message-ID: <ZXSHVguFadvfaUcO@yilunxu-OptiPlex-7050>
References: <20231124162807.238724-1-marpagan@redhat.com>
 <20231124162807.238724-2-marpagan@redhat.com>
 <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
 <7004d215-5185-4cce-a51e-42e131a30453@redhat.com>
 <ZWsgFViqdJuC7N1d@yilunxu-OptiPlex-7050>
 <5a8819ad-3551-475e-a645-1a300d3373f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a8819ad-3551-475e-a645-1a300d3373f1@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> I feel the scope of the protection is unclear to me in this patch. What
> >>> data should be protected from concurrent access by this mutex? From the
> >>> code seems the racing of mgr dev should be protected but apparently it
> >>> doesn't have to.
> >>
> >> The mutex is there to ensure the lifetime of the manager device and
> >> its context (struct fpga_manager) if fpga_mgr_get() happens to run
> >> concurrently with the removal of the low-level module.
> >>
> >>>
> >>> And with this mutex, the get/put/unregister() for one mgr should be
> >>> exclusive with another mgr, but that also seems not necessary.
> >>>
> >>
> >> I decided to use a static mutex because I thought putting the mutex
> >> in the manager's context would be unsafe since its life would be tied
> >> to the manager's life. For instance, consider the following sequence:
> >>
> >> - A removes the low-level control module, and delete_module progresses
> >> up to the point when it calls the module's exit function, which in turn
> >> calls fpga_mgr_unregister().
> >>
> >> - fpga_mgr_unregister() takes the mutex but gets descheduled before
> >> completing the unregistering of the manager device.
> >>
> >> - Meanwhile, B wants to get the manager (it is still there) and calls
> >> fpga_mgr_get(), which tries to take the mutex but gets suspended since
> >> it is held by A.
> >>
> >> - A resumes and fpga_mgr_unregister() releases the manager device and
> > 
> > The lifecycle of the manager device is not entirely decided by
> > fpga_mgr_unregister(), this func just puts/decreases the device
> > refcount.
> 
> Right, but here I'm considering the case where no one has previously
> taken the manager device. In that specific case, the refcount will be

I don't think this is valid, anyone should firstly get the manager
device via get_device() then try to access its context.

> decremented to zero, and the device (with its context) will be released.

If no one has taken the manager device, the device & its context are
safe to be released.

> 
> However, you got me thinking about how the mutex is causing the problem
> in this case.
> 
> > 
> > Remember fpga_mgr_get() gets the device via
> > class_find_device()->get_device(). I assume if the valid device pointer
> > could be returned by class_find_device(), it would never be released by
> > other nice players. So I have no worry about the per manager mutex.
> > 
> >> its context, including the mutex on which B is suspended.
> >>
> >> We could mitigate this specific case using mutex_trylock(). However,
> >> there will still be other problematic cases, like if fpga_mgr_get()
> >> gets suspended right before taking the mutex and then delete_module
> >> proceeds up to when fpga_mgr_unregister() frees the manager device
> >> and its context.
> >>
> >>> I think the mgr->owner & mgr->ops should be protected from concurrent
> >>> access of delete_module & fpga_mgr_get/put(), so how about:
> >>>
> >>> struct fpga_manager_ops {
> >>> 	struct module *owner;
> >>> 	...
> >>> };
> >>>
> >>> struct fpga_manager {
> >>> 	...
> >>> 	struct mutex mops_lock;
> >>> 	const struct fpga_manager_ops *mops;
> >>> 	...
> >>> };
> >>>
> >>>
> >>> static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> >>> {
> >>> 	struct fpga_manager *mgr;
> >>>
> >>> 	mgr = to_fpga_manager(dev);
> >>>
> >>> 	mutex_lock(&mgr->mops_lock);
> >>>
> >>> 	if (!mgr->mops || !try_module_get(mgr->mops->owner))
> >>> 		mgr = ERR_PTR(-ENODEV);
> >>>
> >>> 	mutex_unlock(&mgr->mops_lock);
> >>> 		
> >>> 	return mgr;
> >>> }
> >>>
> >>> void fpga_mgr_unregister(struct fpga_manager *mgr)
> >>> {
> >>> 	fpga_mgr_fpga_remove(mgr);	
> >>>
> >>> 	mutex_lock(&mgr->ops_lock);
> >>> 	mgr->mops = NULL;
> >>> 	mutex_unlock(&mgr->ops_lock);
> >>>
> >>> 	device_unregister(&mgr->dev);	
> >>> }
> >>>
> >>> Not actually tested.
> >>>
> >>
> >> I think protecting the only the ops is not enough for the same reasons.
> >> If fpga_mgr_get() gets suspended right after class_find_device(),and
> >> meanwhile the low-level module is removed, it resumes with a reference
> >> to a manager device that no longer exists.
> >>
> >> In a certain sense, however, using a mutex seems like a mitigation
> >> that does not solve the problem at its root. I honestly still think
> >> that taking the module's refcount right when registering the manager
> >> is the only way that is both safe and robust against code changes.
> > 
> > I would nak either. As mentioned above, that makes rmmod vendor module
> > impossible. Introducing another user interface to release the module's
> > refcount is also a bad idea. Who decides to take the ref, who releases
> > it. A user has no knowledge of what is happening inside and should not
> > enforce.
> > 
> >> However, my proposal was rejected.
> >>
> >> So, if you prefer, I can drop the mutex entirely in the next version,
> >> and we leave the responsibility of keeping all kernel pieces to the
> > 
> > No, please try to fix it. Could you please reconsider my proposal?
> > 
> 
> I have considered it and thought about it. However, I don't think we need a
> mutex to protect mgr->mops. This is because the low-level module's refcount has
> already been decremented when fpga_mgr_unregister() is called by the module's
> exit function. So, when we get to the point of executing fpga_mgr_unregister(),
> any concurrent call to try_module_get() will fail (if no one has taken the

Are you still taking care of your previous finding [1]? It says:

  To be clear, you should only use try_module_get() *iff* you are 100% sure
  the module already does exist ...

IIUC, if you do nothing on fpga_mgr_unregister(), the low-level module may
just disappear and any copy of the owner pointer became invalid. Then
try_module_get() would not fail but panic.

[1] 557aafac1153 ("kernel/module: add documentation for try_module_get()")

Thanks,
Yilun

> module before) without the need to check mops first.
> 
> If we assume (as you pointed out) that class_find_device() can be safely
> executed concurrently with device_unregister() (returning either a valid dev
> pointer or null) and, consequently, the manager context is guaranteed to exist
> after that point. Then, we should be good without the mutex if we call
> try_module_get() on a copy of the owner pointer stored in the manager context.
> 
> >> user. It will still be an improvement over taking the low-level
> >> module's refcount through the parent device's driver pointer.
> >>
> 
> Thanks,
> Marco
> 
> 
