Return-Path: <linux-kernel+bounces-51998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DD84928B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1741F215EC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEFDB670;
	Mon,  5 Feb 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0vWJC2Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08438F40;
	Mon,  5 Feb 2024 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707101735; cv=none; b=nFPV4VcF2oIs/wt/VW7QAUG2Il8HCUZvDjqY+/ru2IQdjcKxtNIvRxlW2KdXjJn7AaenFIz5gyejtymrxf/lXaObufkkdqizBwZJr14mQsynTY8C79hxDmas7W+wccgdIAXk6odLEk22CiJ/Hov7YYdbHgs5Ni++ysMymJoEa5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707101735; c=relaxed/simple;
	bh=4AEV8Os8oxrL8TTjB0jQgYbL/z8pFobotn5bWihXYBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6L68c1i1oclAsK1SQTt2VAaxjG0iI0M65qoeIbnnbLxVl6DMBmTpVWlReg+1ts5Fap3gl3Dq2o6tS0RfYn72NBJtPYhlDPpCaBKOK6/YoRVjkRSAtv+5D3gomLjKfCgL1aDMcvWvjkBmCMn/w43Ez9D1sRDa45P2EiBxF893FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0vWJC2Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707101734; x=1738637734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4AEV8Os8oxrL8TTjB0jQgYbL/z8pFobotn5bWihXYBM=;
  b=g0vWJC2Z9hRPJzUXtC/ILMudRyGdSWsDMjjK+rkazxqBhHHvqZi4qdoj
   A8vxlDF53oGwFLaGaVp9hfk7l5LWxsjR88SyHKkwOm8KUO7MmIcrucugn
   gQHo7yyW8kG6u/TF4QOa1Mtte0f/ME+5yxda1uBjSEO5xhlk3R8ysp32z
   czIKodm9oyM/aJvKBIrbOUh0O2LYGPSHoRdmDNQQWA0oPAsM9dtjCDSdK
   eweYXsuR1bpatF3ZprBLlY5s0nQKPjHYPgJ34pTmONgMRqR/zaO+gmIcp
   KCClILwU1+4VhIkmDab8JwaUQtHdG41Lu21Panxc+jdDn3Daiejv5VEt9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="336185"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="336185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:55:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="892042"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2024 18:55:31 -0800
Date: Mon, 5 Feb 2024 10:51:57 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr driver
Message-ID: <ZcBNTdOulDvlIxmY@yilunxu-OptiPlex-7050>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com>
 <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2>
 <ZbjC501oRClByual@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300825020.112016@sj-4150-psse-sw-opae-dev2>
 <ZbnTwcomGXOGs9SG@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401311433120.112016@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2401311433120.112016@sj-4150-psse-sw-opae-dev2>

On Wed, Jan 31, 2024 at 03:53:23PM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Wed, 31 Jan 2024, Xu Yilun wrote:
> 
> > On Tue, Jan 30, 2024 at 09:13:56AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > 
> > > 
> > > On Tue, 30 Jan 2024, Xu Yilun wrote:
> > > 
> > > > On Wed, Jan 24, 2024 at 11:40:05AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > > > 
> > > > > 
> > > > > On Tue, 23 Jan 2024, Xu Yilun wrote:
> > > > > 
> > > > > > On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
> > > > > > > Revision 2 of the Device Feature List (DFL) Port feature has
> > > > > > > slightly different requirements than revision 1. Revision 2
> > > > > > > does not need the port to reset at driver startup. In fact,
> > > > > > 
> > > > > > Please help illustrate what's the difference between Revision 1 & 2, and
> > > > > > why revision 2 needs not.
> > > > > 
> > > > > I will update the commit message to clarify the differences between revision
> > > > > 1 and 2.
> > > > > 
> > > > > > 
> > > > > > > performing a port reset during driver initialization can cause
> > > > > > > driver race conditions when the port is connected to a different
> > > > > > 
> > > > > > Please reorganize this part, in this description there seems be a
> > > > > > software racing bug and the patch is a workaround. But the fact is port
> > > > > > reset shouldn't been done for a new HW.
> > > > > 
> > > > > Reorganizing the commit message a bit will help to clarify why port reset
> > > > > should not be performed during driver initialization with revision 2 of the
> > > > > hardware.
> > > > > 
> > > > > > 
> > > > > > BTW: Is there a way to tell whether the port is connected to a different
> > > > > > PF? Any guarantee that revision 3, 4 ... would need a port reset or not?
> > > > > 
> > > > > The use of revision 2 of the port_hdr IP block indicates that the port can
> > > > > be connected multiple PFs, but there is nothing explicitly stating which PFs
> > > > 
> > > > Sorry, I mean any specific indicator other than enumerate the revision
> > > > number? As you said below, checking revision number may not make further
> > > > things right, then you need to amend code each time.
> > > 
> > > Using a revision number to indicate the level of functionality for a
> > > particular IP block seems to be a widely used approach. What other indicator
> > 
> > If you still want to make the existing driver work, some capability indication
> > would have more compatibility. That's more reasonable approach. Or you
> > need to change existing behavior for each new revision, that's not
> > actually widely used.
> 
> I understand some capability indication would be better for compatibility
> implementation. A revision number change is not as explicit or precise as
> capability lists.
> 
> > 
> > > of functionality level did you have in mind?
> > 
> > I'm not trying to make the design. You tell me.
> 
> One could use parameter blocks introduced in version 1 of the Device Feature
> Header (DFH), or capability registers could be added the IP block.
> In this particular case it seems the least impact to upstreamed software is
> to keep the DFH and the register map unchanged, except for an incremented
> revision number field.
> 
> > 
> > If finally no indicator could be used, we have to use revision number. That's
> > OK but make SW work harder, so I'm asking if anything could be done to
> > avoid that.
> 
> In this case, I don't think anything else can be done without bigger impacts
> to the SW.

Changing the existing SW is not a problem, repeat the same change every time
is a problem. So if we make sure port reset is no longer needed after
version 1, then this patch is OK. Otherwise, please re-evaluate.

Thanks,
Yilun

> 
> > 
> > > 
> > > The revision number of an IP block would change when new functionality is
> > > added to an IP block or the behavior of the IP block changes. It would be
> > > expected that SW might need to change in order to use the new functionality
> > > or to handle the change in behavior of the IP block. Ideally the new
> > > revision of an IP block would be compatible with existing SW, but that
> > > cannot be guaranteed.
> > 
> > People make the IP block, and be compatible should be the concern if it
> > want upstream support.
> 
> Agreed, and making sure some capability mechanism exists when an IP is
> created would be a great start.
> 
> Thanks,
> Matthew
> 
> > 
> > Thanks,
> > Yilun
> > 
> > > 
> > > Thanks,
> > > Matthew
> > > 
> > > > 
> > > > Thanks,
> > > > Yilun
> > > > 
> > > > > the port is connected to.
> > > > > 
> > > > > It is hard to predict the requirements and implementation of a future
> > > > > revision of an IP block. If a requirement of a future revision is to work
> > > > > with existing software, then the future revision would not require a port
> > > > > reset at driver initialization.
> > > > > 
> > > > 
> > 
> > 

