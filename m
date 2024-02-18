Return-Path: <linux-kernel+bounces-70329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55256859627
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB071C20AB1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C1C1C69F;
	Sun, 18 Feb 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWJ1naDu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCA1B268;
	Sun, 18 Feb 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708250966; cv=none; b=reKuXV9FNFjkAoXvelB48gqM04ecCQ3RHqLelSdGA49Xba7XdabknxOJym1yV5y/0Iw73dUsB/MBCRTLRhC8TUzBE5rmpZR9rJfeT8+RsFuZ9f28Yo+4OjXJUEIpdUtnQ1aHEdcdH8//MgEUOWHXIyhBHlXN3sCnW3pFZVLaVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708250966; c=relaxed/simple;
	bh=gpO1hWemLGbG90Ib1MxMCi6X7rW07hi3Fb31+1OFqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snjnLiVjs2yj3+veQWVWNm1YTAcVhfHw19c/BjvS0Ev/u7fVrdtHGkVDmOm7OloIFoOif8/3nYRzCZBr8te1PhBgz96hqoNtUMKGnmNLeGl/virs9qV3kTwNV6WWG2xylqSUtITaZTaG5q8CW8lUcRHRopLbh+5tH7voSrqS6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWJ1naDu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708250965; x=1739786965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gpO1hWemLGbG90Ib1MxMCi6X7rW07hi3Fb31+1OFqKk=;
  b=HWJ1naDuGuhUzu7fsVbKrf7FYZGB3k2pAXABYC+xf705t66nyrImLZzk
   PeTuIwwFJAS6r9YGWYSQ0dHlyvi/SXNSdrL0vVezq1rg1Kmq7+SKSCW0t
   FOBlJzwNNg+dOzl6w1+Wc5XXiNRLnnwtlkMl8jmsL65PTWuGpQ8V3HTM9
   r7MDC4e2ubylHf/vbT+NXLe7BaCc49BBg4mGhC0zmdgUFC0VKBVNJ9J2Q
   ind6RVfA8lWYz6pmU+UoYeURpDQcGVAN0tVa1TnKvHsz/3VDIo7KgoBoV
   hqtlXLMl6ysrJcQkR+OXLc07Q4ZmVjAPbCpGBX6alRG0O/tqJ9xK8Lnfp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2206283"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2206283"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="8904755"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 18 Feb 2024 02:09:20 -0800
Date: Sun, 18 Feb 2024 18:05:29 +0800
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
Message-ID: <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
 <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>

On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
> 
> 
> On 2024-02-04 06:15, Xu Yilun wrote:
> > On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2024-01-30 05:31, Xu Yilun wrote:
> >>>> +#define fpga_mgr_register_full(parent, info) \
> >>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>>  struct fpga_manager *
> >>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>> +			 struct module *owner);
> >>>>  
> >>>> +#define fpga_mgr_register(parent, name, mops, priv) \
> >>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
> >>>>  struct fpga_manager *
> >>>> -fpga_mgr_register(struct device *parent, const char *name,
> >>>> -		  const struct fpga_manager_ops *mops, void *priv);
> >>>> +__fpga_mgr_register(struct device *parent, const char *name,
> >>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
> >>>> +
> >>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>>>  
> >>>> +#define devm_fpga_mgr_register_full(parent, info) \
> >>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
> >>>>  struct fpga_manager *
> >>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
> >>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
> >>>> +			      struct module *owner);
> >>>
> >>> Add a line here. I can do it myself if you agree.
> >>
> >> Sure, that is fine by me. I also spotted a typo in the commit log body
> >> (in taken -> is taken). Do you want me to send a v6, or do you prefer
> >> to fix that in place?
> > 
> > No need, I can fix it.
> > 
> >>
> >>>
> >>> There is still a RFC prefix for this patch. Are you ready to get it merged?
> >>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
> >>
> >> I'm ready for the patch to be merged. However, I recently sent an RFC
> >> to propose a safer implementation of try_module_get() that would
> >> simplify the code and may also benefit other subsystems. What do you
> >> think?
> >>
> >> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
> > 
> > I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
> > proposal is applied before the end of this cycle, we could re-evaluate
> > this patch.
> 
> That's fine by me.

Sorry, I still found issues about this solution.

void fpga_mgr_unregister(struct fpga_manager *mgr)
{
        dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);

        /*
         * If the low level driver provides a method for putting fpga into
         * a desired state upon unregister, do it.
         */
        fpga_mgr_fpga_remove(mgr);

        mutex_lock(&mgr->mops_mutex);

        mgr->mops = NULL;

        mutex_unlock(&mgr->mops_mutex);

        device_unregister(&mgr->dev);
}

Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
fpga_manager dev without mops, this is not what the user want and cause
problem when using this fpga_manager dev for other FPGA APIs.

I have this concern when I was reviewing the same improvement for fpga
bridge. The change for fpga bridge seems workable, the mutex keeps hold
until fpga_bridge_put(). But I somewhat don't prefer the unregistration
been unnecessarily blocked for long term.

I think your try_module_get_safe() patch may finally solve the invalid
module owner issue. Some options now, we ignore the invalid module owner
issue (it exists before this change) and merge the rest of the
improvements, or we wait for your patch accepted then re-evaluate. I
prefer the former.

Thanks,
Yilun

> 
> Thanks,
> Marco
> 

