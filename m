Return-Path: <linux-kernel+bounces-23099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CE82A7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FF3B2552F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5EED2F1;
	Thu, 11 Jan 2024 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsxqTA76"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C42D291;
	Thu, 11 Jan 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704954790; x=1736490790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7xbmZvEbmyc7ksU337RinXeAgvB7IFhPSPkTVHHFV4=;
  b=UsxqTA76gTWvdbOibE3MIWgV0IMPWJLuh+Z0aunZRj1sdCNUlDjcZ1+O
   iljFkWnr2yNrya7+MMgkOe+4Pfja3wRhf6z7BA3j09IwQ76mN1ohLC2s6
   m5pLp4C2RNHxMCG3gQsFFifhdDOfmBxFFtpC1GNILRWWagBcsTjDPPG9W
   +7jfyR3HSsLUsq7uNHRPcpvMkUN4nu90hzfKZNhka7ZxHbKMn+ffNfCOe
   v513140tTKLUUFTPAEiFPKJTYTyU5tyuut723vvXuDQvza077/jm+xJPh
   HntGmNWdGz3208NwMPSWlushDyeu54tn/Xf33f2MENyHjb0PjlQPbRGOS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5500751"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5500751"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 22:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="16943189"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jan 2024 22:33:07 -0800
Date: Thu, 11 Jan 2024 14:30:07 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v4 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Message-ID: <ZZ+K70C07MYVnYLR@yilunxu-OptiPlex-7050>
References: <20240105231526.109247-1-marpagan@redhat.com>
 <20240105231526.109247-2-marpagan@redhat.com>
 <ZZu7Uf3kC1i3zho3@yilunxu-OptiPlex-7050>
 <c2026945-76ab-4224-b3af-b6991e16d282@redhat.com>
 <ZZzOPwV5laWA0Jv/@yilunxu-OptiPlex-7050>
 <09b30741-b2eb-484a-bfe6-e1964d282e23@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b30741-b2eb-484a-bfe6-e1964d282e23@redhat.com>

On Tue, Jan 09, 2024 at 12:53:14PM +0100, Marco Pagani wrote:
> 
> 
> On 09/01/24 05:40, Xu Yilun wrote:
> > On Mon, Jan 08, 2024 at 06:24:55PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2024-01-08 10:07, Xu Yilun wrote:
> >>> On Sat, Jan 06, 2024 at 12:15:26AM +0100, Marco Pagani wrote:
> >>>> Add a module owner field to the fpga_manager struct to take the
> >>>> low-level control module refcount instead of assuming that the parent
> >>>> device has a driver and using its owner pointer. The owner is now
> >>>> passed as an additional argument at registration time. To this end,
> >>>> the functions for registration have been modified to take an additional
> >>>> owner parameter and renamed to avoid conflicts. The old function names
> >>>> are now used for helper macros that automatically set the module that
> >>>> registers the fpga manager as the owner. This ensures compatibility
> >>>> with existing low-level control modules and reduces the chances of
> >>>> registering a manager without setting the owner.
> >>>>
> >>>> To detect when the owner module pointer becomes stale, set the mops
> >>>> pointer to null during fpga_mgr_unregister() and test it before taking
> >>>> the module's refcount. Use a mutex to protect against a crash that can
> >>>> happen if __fpga_mgr_get() gets suspended between testing the mops
> >>>> pointer and taking the refcount while the low-level module is being
> >>>> unloaded.
> >>>>
> >>>> Other changes: opportunistically move put_device() from __fpga_mgr_get()
> >>>> to fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since
> >>>> the device refcount in taken in these functions.
> >>>>
> >>>> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
> >>>> Suggested-by: Xu Yilun <yilun.xu@intel.com>
> >>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >>>> ---
> >>>>  drivers/fpga/fpga-mgr.c       | 93 ++++++++++++++++++++++-------------
> >>>>  include/linux/fpga/fpga-mgr.h | 80 +++++++++++++++++++++++++++---
> >>>>  2 files changed, 134 insertions(+), 39 deletions(-)
> >>>>
> >>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> >>>> index 06651389c592..d7bfbdfdf2fc 100644
> >>>> --- a/drivers/fpga/fpga-mgr.c
> >>>> +++ b/drivers/fpga/fpga-mgr.c
> >>>> @@ -664,20 +664,20 @@ static struct attribute *fpga_mgr_attrs[] = {
> >>>>  };
> >>>>  ATTRIBUTE_GROUPS(fpga_mgr);
> >>>>  
> >>>> -static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> >>>> +static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
> >>>>  {
> >>>>  	struct fpga_manager *mgr;
> >>>>  
> >>>> -	mgr = to_fpga_manager(dev);
> >>>> +	mgr = to_fpga_manager(mgr_dev);
> >>>>  
> >>>> -	if (!try_module_get(dev->parent->driver->owner))
> >>>> -		goto err_dev;
> >>>> +	mutex_lock(&mgr->mops_mutex);
> >>>>  
> >>>> -	return mgr;
> >>>> +	if (!mgr->mops || !try_module_get(mgr->mops_owner))
> >>>
> >>> Why move the owner out of struct fpga_manager_ops? The owner within the
> >>> ops struct makes more sense to me, it better illustrates what the mutex
> >>> is protecting.
> >>>
> >>
> >> I think having the owner in fpga_manager_ops made sense when it was
> >> meant to be set while initializing the struct in the low-level module.
> >> However, since the owner is now passed as an argument and set at
> >> registration time, keeping it in the FPGA manager context seems more
> >> straightforward to me.
> > 
> > That's OK. But then why not directly check mops_owner here?
> >
> 
> We can do that, but it would impose a precondition since it would not
> allow registering a manager with a NULL ops owner. In that case, I think

No we should allow ops module owner = NULL, we should allow built-in
drivers.

I'm OK with the current implementation now.

> we need to make the precondition explicit and add a check in
> fpga_mgr_register_*() that prevents registering a manager with a NULL ops
> owner. Otherwise, the programmer could register a manager that cannot be
> taken.
>  

[...]

> >>>> +#define fpga_mgr_register_full(parent, info) \
> >>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>> +
> >>>
> >>> Delete the line, and ...
> >>>
> >>>>  struct fpga_manager *
> >>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>> +			 struct module *owner);
> >>>
> >>> Add a line here, to make the related functions packed.
> >>> Same for the rest of code.
> >>
> >> Do you prefer having the macro just above the function prototype? Like:
> >>
> >> #define devm_fpga_mgr_register(parent, name, mops, priv) \
> >> 	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >> struct fpga_manager *
> >> __devm_fpga_mgr_register(struct device *parent, const char *name,
> >> 			 const struct fpga_manager_ops *mops, void *priv,
> >> 			 struct module *owner);
> > 
> > Yes, that's it.
> 
> My only concern is that if we keep the kernel-doc comments only for the
> __fpga_mgr_register* functions in fpga-mgr.c, we would not get the docs
> for the helper macros that are the most likely to be used.

That's not a problem, people should be smart enough to find the doc and
know what the MACRO is doing. And usually function doc should be placed
near function source code rather than declaration.

Thanks,
Yilun

> 
> 
> >> [...]
> 
> 
> Thanks,
> Marco
> 

