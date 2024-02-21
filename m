Return-Path: <linux-kernel+bounces-74922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F485E011
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D7828A559
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5927FBD7;
	Wed, 21 Feb 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX9yqpzF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256C80052;
	Wed, 21 Feb 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526479; cv=none; b=YGq7JPqeKf9T7X6LCaYIJS5RazGS74eAkPskSWJhMB5njHCfOmmYFTm7F28vkkDaQQShMkZbZAjL15noOyJ5f2iUQSgPmq5ZknRcWgyQrnux9C/TD3N6RD+M68H3KP8OXYpZ4byATWx8AoxxhC+Gq71t7ZXk1ozCZuLFec+ZaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526479; c=relaxed/simple;
	bh=fGy1ZeYlSSA1oBp701WLKo8Ii38jlfVIpfInS3YAkG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqrcIY2CcBWs5R3J/4Ji/4tP8NU9sBh9YvswaDTlEkk7Bi1a24+xQMjX/OGRZm5c0wvmQveV6LuF17YNV4k2ceyGwz/AEysTb4JtC0ooTmC7fs4NrXkrhUm5weBWZ6Kd2vkwNENG5TuWux5Ldg/3pGYc9dSC2cUOUDmAlGI8WaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX9yqpzF; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708526477; x=1740062477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGy1ZeYlSSA1oBp701WLKo8Ii38jlfVIpfInS3YAkG0=;
  b=OX9yqpzFG/HhJHwYntijMEsD1WDOPQ0RbQl6UZ5mNceiVPKR81whzxwP
   KGNjozORukipANRZmqQgX4leGGsZmQAhygwFG72OAlqBTNpudhZIMw6sf
   rnIy3PR+EgJhLpGtIDRe2gYx/R57sV2S798jT8qExiB8fHNjd6U3S00ul
   dERcBe5+34dzaujzkk4vTIBGmXAV66hzmcNYzTxQChkSkoWBeWwzHkPvI
   hbKYxqN/+5LFFq2qcbIbVXWvGt7vwK0yHxjPn+8bvPCvgOIp+p26iIEmA
   gQbS6EIG2PVVgi1dfYHCvtuJ7GtVmz5i/kSsSGSUGJPuEWPtHioHoLRb5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20228461"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="20228461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5321684"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 21 Feb 2024 06:41:13 -0800
Date: Wed, 21 Feb 2024 22:37:17 +0800
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
Message-ID: <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
 <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>

On Tue, Feb 20, 2024 at 12:11:26PM +0100, Marco Pagani wrote:
> 
> 
> On 2024-02-18 11:05, Xu Yilun wrote:
> > On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2024-02-04 06:15, Xu Yilun wrote:
> >>> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
> >>>>
> >>>>
> >>>> On 2024-01-30 05:31, Xu Yilun wrote:
> >>>>>> +#define fpga_mgr_register_full(parent, info) \
> >>>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>>>>  struct fpga_manager *
> >>>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>>>> +			 struct module *owner);
> >>>>>>  
> >>>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
> >>>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >>>>>>  struct fpga_manager *
> >>>>>> -fpga_mgr_register(struct device *parent, const char *name,
> >>>>>> -		  const struct fpga_manager_ops *mops, void *priv);
> >>>>>> +__fpga_mgr_register(struct device *parent, const char *name,
> >>>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> >>>>>> +
> >>>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>>>>>  
> >>>>>> +#define devm_fpga_mgr_register_full(parent, info) \
> >>>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>>>>  struct fpga_manager *
> >>>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>>>> +			      struct module *owner);
> >>>>>
> >>>>> Add a line here. I can do it myself if you agree.
> >>>>
> >>>> Sure, that is fine by me. I also spotted a typo in the commit log body
> >>>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
> >>>> to fix that in place?
> >>>
> >>> No need, I can fix it.
> >>>
> >>>>
> >>>>>
> >>>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
> >>>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
> >>>>
> >>>> I'm ready for the patch to be merged. However, I recently sent an RFC
> >>>> to propose a safer implementation of try_module_get() that would
> >>>> simplify the code and may also benefit other subsystems. What do you
> >>>> think?
> >>>>
> >>>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
> >>>
> >>> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
> >>> proposal is applied before the end of this cycle, we could re-evaluate
> >>> this patch.
> >>
> >> That's fine by me.
> > 
> > Sorry, I still found issues about this solution.
> > 
> > void fpga_mgr_unregister(struct fpga_manager *mgr)
> > {
> >         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
> > 
> >         /*
> >          * If the low level driver provides a method for putting fpga into
> >          * a desired state upon unregister, do it.
> >          */
> >         fpga_mgr_fpga_remove(mgr);
> > 
> >         mutex_lock(&mgr->mops_mutex);
> > 
> >         mgr->mops = NULL;
> > 
> >         mutex_unlock(&mgr->mops_mutex);
> > 
> >         device_unregister(&mgr->dev);
> > }
> > 
> > Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
> > So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
> > fpga_manager dev without mops, this is not what the user want and cause
> > problem when using this fpga_manager dev for other FPGA APIs.
> 
> How about moving mgr->mops = NULL from fpga_mgr_unregister() to
> class->dev_release()? In that way, mops will be set to NULL only when the
> manager dev refcount reaches 0.

I'm afraid it doesn't help.  The lifecycle of the module and the fpga
mgr dev is different.

We use mops = NULL to indicate module has been freed or will be freed in no
time.  On the other hand mops != NULL means module is still there, so
that try_module_get() could be safely called.  It is possible someone
has got fpga mgr dev but not the module yet, at that time the module is
unloaded, then try_module_get() triggers crash.

> 
> If fpga_mgr_unregister() is called from module_exit(), we are sure that nobody
> got the manager dev earlier using fpga_mgr_get(), or it would have bumped up

No, someone may get the manager dev but not the module yet, and been
scheduled out.

> the module's refcount, preventing its removal in the first place. In this case,
> when device_unregister() is called, it will trigger dev_release() since the
> manager dev refcount has reached 0.
> 
> If fpga_mgr_unregister() is called elsewhere in the module that registered the
> manager (1), we have two subcases:
> 
> a) someone got the manager dev earlier and bumped the module's refcount. Hence,
> the ops are safe since the module cannot be removed until the manager dev is
> released by calling (the last) put_device(). This, in turn, will trigger
> class->dev_release().
> 
> b) no one got manager dev. In this case, class->dev_release() will be called
> immediately.
> 
> (1) The caller of fpga_mgr_register_*() is responsible for calling
> fpga_mgr_unregister(), as specified in the docs.
> 
> > I have this concern when I was reviewing the same improvement for fpga
> > bridge. The change for fpga bridge seems workable, the mutex keeps hold
> > until fpga_bridge_put(). But I somewhat don't prefer the unregistration
> > been unnecessarily blocked for long term.
> 
> I also don't like the idea of potentially blocking the unregistration, but I
> could not find a better solution for the bridge at the moment.
> 
> > I think your try_module_get_safe() patch may finally solve the invalid
> > module owner issue. Some options now, we ignore the invalid module owner
> > issue (it exists before this change) and merge the rest of the
> > improvements, or we wait for your patch accepted then re-evaluate. I
> > prefer the former.
> 
> Yeah, try_module_get_safe() would make things simpler and easier. I'm currently
> working on a series of selftests to demonstrate that the function is safe from
> deadlocks, as requested by the maintainer. I hope I can convince people of the
> advantages.
> 
> Thanks,
> Marco
> 

