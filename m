Return-Path: <linux-kernel+bounces-45752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEBF8434EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A043E289A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB243D0BC;
	Wed, 31 Jan 2024 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td4WUMu+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88B3D0B3;
	Wed, 31 Jan 2024 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677397; cv=none; b=B7HvCFaYhHa8m1WZRQJRwjyIWllqwCLAp8PryGrDYgi44547cnAiJZPDMJ3wA1hha8AaAWul+hQNNL8kuKMDiEUAJtgnK50tl+xwT3nwVGp6SBUZc4wMbdYNHhkHdr+OneNa5ZCaxcftB2srXxzN5z4rvLFbj3HdERTZnOJvkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677397; c=relaxed/simple;
	bh=3A3KWNJcACtPoEMNnBT3nWG60WJk0RJJbmzMM+Klf5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8bARrehmFk/G9zEjAnISAVumNVcHKPBtEzYD9YbMtCjRbI2hSUnDFFk/4LNcfSsd/V2/3EoNZTFo3ADnylNZ+9AHuCfP/my3YqJuurhdoMvT5GU/C+XNjI8uhtSZe8wQAHnnslv47UnGAA8smg1EIdF1F9rvVYUhp6oB19nx1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td4WUMu+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706677396; x=1738213396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3A3KWNJcACtPoEMNnBT3nWG60WJk0RJJbmzMM+Klf5c=;
  b=Td4WUMu+CCHY8qqu/K4VfmVMlWuMnPgtLJBDCaiqX2M7W3BOUBNRe69r
   cWy/L/mXGjD/EVn1I3kUS5or5I7j3RZ7uZpPsClnnEGoobAii3M2UsX5V
   9pUFqLH7s6NSPRRs0GZZ+PBXN5HGuKAOAUQCFvtzRLWVT7eDDYOlgCFXG
   DMot532C0CYZZ6/b/uZJ01gIQ3Q2EWpi1z5ijq1SHh0UpRUWdK5J0c0rv
   CijBXbV7+YbyEtJRvxuCGpNnW4hCzlnLm9KosoHrMCfc8SdVuxinI62Ni
   9f+0bXBtgod3ExZzoFPuIjHhg/hvjHBjk0qm6Xv6J4dN3xPlkEEcwbHGa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22004111"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="22004111"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="36737953"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 30 Jan 2024 21:03:12 -0800
Date: Wed, 31 Jan 2024 12:59:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: update initialization of port_hdr driver
Message-ID: <ZbnTwcomGXOGs9SG@yilunxu-OptiPlex-7050>
References: <20240122172433.537525-1-matthew.gerlach@linux.intel.com>
 <Za8ibeJc82Xkbpct@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401241106550.77559@sj-4150-psse-sw-opae-dev2>
 <ZbjC501oRClByual@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300825020.112016@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2401300825020.112016@sj-4150-psse-sw-opae-dev2>

On Tue, Jan 30, 2024 at 09:13:56AM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 30 Jan 2024, Xu Yilun wrote:
> 
> > On Wed, Jan 24, 2024 at 11:40:05AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > 
> > > 
> > > On Tue, 23 Jan 2024, Xu Yilun wrote:
> > > 
> > > > On Mon, Jan 22, 2024 at 09:24:33AM -0800, Matthew Gerlach wrote:
> > > > > Revision 2 of the Device Feature List (DFL) Port feature has
> > > > > slightly different requirements than revision 1. Revision 2
> > > > > does not need the port to reset at driver startup. In fact,
> > > > 
> > > > Please help illustrate what's the difference between Revision 1 & 2, and
> > > > why revision 2 needs not.
> > > 
> > > I will update the commit message to clarify the differences between revision
> > > 1 and 2.
> > > 
> > > > 
> > > > > performing a port reset during driver initialization can cause
> > > > > driver race conditions when the port is connected to a different
> > > > 
> > > > Please reorganize this part, in this description there seems be a
> > > > software racing bug and the patch is a workaround. But the fact is port
> > > > reset shouldn't been done for a new HW.
> > > 
> > > Reorganizing the commit message a bit will help to clarify why port reset
> > > should not be performed during driver initialization with revision 2 of the
> > > hardware.
> > > 
> > > > 
> > > > BTW: Is there a way to tell whether the port is connected to a different
> > > > PF? Any guarantee that revision 3, 4 ... would need a port reset or not?
> > > 
> > > The use of revision 2 of the port_hdr IP block indicates that the port can
> > > be connected multiple PFs, but there is nothing explicitly stating which PFs
> > 
> > Sorry, I mean any specific indicator other than enumerate the revision
> > number? As you said below, checking revision number may not make further
> > things right, then you need to amend code each time.
> 
> Using a revision number to indicate the level of functionality for a
> particular IP block seems to be a widely used approach. What other indicator

If you still want to make the existing driver work, some capability indication
would have more compatibility. That's more reasonable approach. Or you
need to change existing behavior for each new revision, that's not
actually widely used.

> of functionality level did you have in mind?

I'm not trying to make the design. You tell me.

If finally no indicator could be used, we have to use revision number. That's
OK but make SW work harder, so I'm asking if anything could be done to
avoid that.

> 
> The revision number of an IP block would change when new functionality is
> added to an IP block or the behavior of the IP block changes. It would be
> expected that SW might need to change in order to use the new functionality
> or to handle the change in behavior of the IP block. Ideally the new
> revision of an IP block would be compatible with existing SW, but that
> cannot be guaranteed.

People make the IP block, and be compatible should be the concern if it
want upstream support.

Thanks,
Yilun

> 
> Thanks,
> Matthew
> 
> > 
> > Thanks,
> > Yilun
> > 
> > > the port is connected to.
> > > 
> > > It is hard to predict the requirements and implementation of a future
> > > revision of an IP block. If a requirement of a future revision is to work
> > > with existing software, then the future revision would not require a port
> > > reset at driver initialization.
> > > 
> > 

