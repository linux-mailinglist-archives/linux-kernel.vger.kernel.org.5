Return-Path: <linux-kernel+bounces-88610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20E86E422
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5DE1F24397
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC76BFDB;
	Fri,  1 Mar 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdUy8HJe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EF91FDD;
	Fri,  1 Mar 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306216; cv=none; b=cYpSEWeIF3KJpD3H8J2RdZjxP26aLVyjae2nOsrxb4N2xZHjJwqJIGNJtRcNTUGwHrYP8HTihZrmBgDDpnLOGkT+hWK9zZ+rujqgEOe+VqtAgO726Lho5UsAZPm7ws2k5y30PLq9q7BZe/lEhD236CWjYL9FG2IFpjMmt+NEY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306216; c=relaxed/simple;
	bh=J2Vds4mlqs77XbVSxBgLgpHcoivpOW6VW8MgVYY5Mtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrUZbUZXNWwbm1IzNnKJR5CYGC7WYeTUMfmorbUlHStdKDuxJdIDlp/rPqOvqsRqXWVt3lHW/wYMUfKtOB8L5vqnL7cUYKEueKQzbMP3+41+WzsjIH6z+Ek55VU5w0oK+Oj0w8Wu3zHdH1o8BHYwFIy8lbCfrKszJP19dPdeB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdUy8HJe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709306215; x=1740842215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J2Vds4mlqs77XbVSxBgLgpHcoivpOW6VW8MgVYY5Mtg=;
  b=kdUy8HJePdLvpGR+MwDMWxbd4Xgbf1QLqJWPDKRi5v3ec7UNXeC9d3CD
   Harz2PH26afax95uckxHx5I7hLxDyjYvcSnF8IeHsTsJ9vwNdj1P0FQEw
   f4Fm7nIg7/m6U/smgXgm9sqjwCJOHw+1DgD7C5gB5RgZTZ6nF+xVsHrBN
   NKMJysC/+IfXNOc1Dcd39OfQGYElyAuZQHgNfKdhZVZYsf7bcAbM5Nl5l
   VlHcZ2/AiYngEP6e0/y62VepK/jRkif79yskSuHDd6/vzvphhQmFLaYu2
   Ut4R+39goSxx2Km4jhJj+xJoO6lWrDMqlAa2LpMf2RSGiKjr0CocYSXdG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3698456"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="3698456"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 07:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8363650"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2024 07:16:50 -0800
Date: Fri, 1 Mar 2024 23:12:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Message-ID: <ZeHwatupHVmC2N2+@yilunxu-OptiPlex-7050>
References: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
 <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
 <ae3cd81b-82af-4977-91d7-fa809c6fc45a@redhat.com>
 <Zd7cff43ffbJOGNY@yilunxu-OptiPlex-7050>
 <0c885ff2-44bc-4158-b5dd-3d7513cb2857@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c885ff2-44bc-4158-b5dd-3d7513cb2857@redhat.com>

On Thu, Feb 29, 2024 at 11:37:10AM +0100, Marco Pagani wrote:
> 
> On 2024-02-28 08:10, Xu Yilun wrote:
> > On Tue, Feb 27, 2024 at 12:49:06PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2024-02-21 15:37, Xu Yilun wrote:
> >>> On Tue, Feb 20, 2024 at 12:11:26PM +0100, Marco Pagani wrote:
> >>>>
> >>>>
> >>>> On 2024-02-18 11:05, Xu Yilun wrote:
> >>>>> On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2024-02-04 06:15, Xu Yilun wrote:
> >>>>>>> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2024-01-30 05:31, Xu Yilun wrote:
> >>>>>>>>>> +#define fpga_mgr_register_full(parent, info) \
> >>>>>>>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>>>>>>>>  struct fpga_manager *
> >>>>>>>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>>>>>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>>>>>>>> +			 struct module *owner);
> >>>>>>>>>>  
> >>>>>>>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
> >>>>>>>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >>>>>>>>>>  struct fpga_manager *
> >>>>>>>>>> -fpga_mgr_register(struct device *parent, const char *name,
> >>>>>>>>>> -		  const struct fpga_manager_ops *mops, void *priv);
> >>>>>>>>>> +__fpga_mgr_register(struct device *parent, const char *name,
> >>>>>>>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> >>>>>>>>>> +
> >>>>>>>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>>>>>>>>>  
> >>>>>>>>>> +#define devm_fpga_mgr_register_full(parent, info) \
> >>>>>>>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>>>>>>>>  struct fpga_manager *
> >>>>>>>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>>>>>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>>>>>>>> +			      struct module *owner);
> >>>>>>>>>
> >>>>>>>>> Add a line here. I can do it myself if you agree.
> >>>>>>>>
> >>>>>>>> Sure, that is fine by me. I also spotted a typo in the commit log body
> >>>>>>>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
> >>>>>>>> to fix that in place?
> >>>>>>>
> >>>>>>> No need, I can fix it.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
> >>>>>>>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
> >>>>>>>>
> >>>>>>>> I'm ready for the patch to be merged. However, I recently sent an RFC
> >>>>>>>> to propose a safer implementation of try_module_get() that would
> >>>>>>>> simplify the code and may also benefit other subsystems. What do you
> >>>>>>>> think?
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
> >>>>>>>
> >>>>>>> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
> >>>>>>> proposal is applied before the end of this cycle, we could re-evaluate
> >>>>>>> this patch.
> >>>>>>
> >>>>>> That's fine by me.
> >>>>>
> >>>>> Sorry, I still found issues about this solution.
> >>>>>
> >>>>> void fpga_mgr_unregister(struct fpga_manager *mgr)
> >>>>> {
> >>>>>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
> >>>>>
> >>>>>         /*
> >>>>>          * If the low level driver provides a method for putting fpga into
> >>>>>          * a desired state upon unregister, do it.
> >>>>>          */
> >>>>>         fpga_mgr_fpga_remove(mgr);
> >>>>>
> >>>>>         mutex_lock(&mgr->mops_mutex);
> >>>>>
> >>>>>         mgr->mops = NULL;
> >>>>>
> >>>>>         mutex_unlock(&mgr->mops_mutex);
> >>>>>
> >>>>>         device_unregister(&mgr->dev);
> >>>>> }
> >>>>>
> >>>>> Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
> >>>>> So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
> >>>>> fpga_manager dev without mops, this is not what the user want and cause
> >>>>> problem when using this fpga_manager dev for other FPGA APIs.
> >>>>
> >>>> How about moving mgr->mops = NULL from fpga_mgr_unregister() to
> >>>> class->dev_release()? In that way, mops will be set to NULL only when the
> >>>> manager dev refcount reaches 0.
> >>>
> >>> I'm afraid it doesn't help.  The lifecycle of the module and the fpga
> >>> mgr dev is different.
> >>>
> >>> We use mops = NULL to indicate module has been freed or will be freed in no
> >>> time.  On the other hand mops != NULL means module is still there, so
> >>> that try_module_get() could be safely called.  It is possible someone
> >>> has got fpga mgr dev but not the module yet, at that time the module is
> >>> unloaded, then try_module_get() triggers crash.
> >>>
> >>>>
> >>>> If fpga_mgr_unregister() is called from module_exit(), we are sure that nobody
> >>>> got the manager dev earlier using fpga_mgr_get(), or it would have bumped up
> >>>
> >>> No, someone may get the manager dev but not the module yet, and been
> >>> scheduled out.
> >>>
> >>
> >> You are right. Overall, it's a bad idea. How about then using an additional 
> >> bool flag instead of "overloading" the mops pointer? Something like:
> >>
> >> get:
> >> 	if (!mgr->owner_valid || !try_module_get(mgr->mops_owner))
> >>
> >> remove:
> >> 	mgr->owner_valid = false;
> > 
> > I'm not quite sure which function is actually mentioned by "remove".  I
> > assume it should be fpga_mgr_unregister().
> 
> Yes, I was referring to fpga_mgr_unregister().
> 
> > IIUC this flag means no more reference to fpga mgr, but existing
> > references are still valid.
> 
> Yes.
> 
> > 
> > It works for me. But the name of this flag could be reconsidered to
> > avoid misunderstanding.  The owner is still valid (we still need to put
> > the owner) but allows no more reference.  Maybe "owner_inactive"?
> 
> Right, owner_valid might be misleading. How about removing any
> reference to the owner module and name the flag unreg?

the full name "unregistered" is better.

> 
> __fpga_mgr_get:
> 	if (mgr->unreg || !try_module_get(mgr->mops_owner))
> 		mgr = ERR_PTR(-ENODEV);
> 
> fpga_mgr_unregister:
>  	mgr->unreg = true;
> 
> > I still wanna this owner reference change been splitted, so that
> > we could simply revert it when the try_module_get_safe() got accepted.
> 
> I guess it may take some time to have try_module_get_safe() accepted.
> What do you prefer to do with the bridge and the region in the
> meantime?

This issue could happen in little chance. I actually don't have much
preference, either way is good to me.

Thanks,
Yilun

> 
> Thanks,
> Marco
> 

