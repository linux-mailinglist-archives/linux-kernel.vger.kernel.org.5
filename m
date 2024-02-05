Return-Path: <linux-kernel+bounces-51993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98184926C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 03:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995FFB21395
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70A9449;
	Mon,  5 Feb 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU8cl9ku"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F68F49;
	Mon,  5 Feb 2024 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100520; cv=none; b=PAbEN4k/hoav+3hLpACGbAY4kfzvItdqmuwKweN/Owz40JX4DacpToui3DnqTRpXruWoa902IF2dv60r+2l8+YTGqtRX/QhsFW7/cRGhadl71Qw7pz164C1SE33wEHmd2ez+tQzp643VBEBQTOueemlGtTjn5S3owTWSJ7X7BKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100520; c=relaxed/simple;
	bh=dr9DDXAdyJ3pofZryHHuOExHQj18z6GN6Uo15RMgnGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOFikHWKDNsy0uXU1Qakis7PriMPbJjw2SzEVvDL9zWiVrDqoLDYd/YbwcetooF7PULSQx5Z9Wy0iM8M+ellnhZN8CqPjmZICBv7uAgQwPdfPjKlAusqkY6+xp/UG+Nw7tclJZ74GqIwLZ2N3vFKOg8z1LvcltJ1J6wvv+IHLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU8cl9ku; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707100518; x=1738636518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dr9DDXAdyJ3pofZryHHuOExHQj18z6GN6Uo15RMgnGE=;
  b=bU8cl9ku77XvPknmX2Z3J8clMdML2+8fP02DhAUnEK7jEKTg+Smu9fDs
   HJf5KG9fApx3vfID6twUUMgdTE7Ry3DalB1kU7TlyW1gRkYogpCZeucSy
   G0Kg7W2D+MHz8VYgex620vldLzx6Nv2V8Wf1pAYVJDpuk+XVEjJe4HtCp
   rtHU5slC3qvgqf5JRcFQj6HO7/iw25UOa8djFv3YsBhuC4WcLm8qog0rd
   IzVbBByeJg8C3nkOtjOH7GqxjHLfO6iv1DIRJWnvwBOkIOMOXRldw40g6
   RjWg1K+r5YNT5tMfOE4Es8E1RNnqCaQAeeQQdILtBYjQ+ZuLCnSvRBWqh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11794809"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11794809"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="802734"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2024 18:35:15 -0800
Date: Mon, 5 Feb 2024 10:31:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Message-ID: <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>
 <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>
 <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>

On Wed, Jan 31, 2024 at 04:26:27PM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Wed, 31 Jan 2024, Xu Yilun wrote:
> 
> > On Tue, Jan 30, 2024 at 10:00:16AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > 
> > > 
> > > On Tue, 30 Jan 2024, Xu Yilun wrote:
> > > 
> > > > On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
> > > > > Revision 2 of the Device Feature List (DFL) Port feature
> > > > > adds support for connecting the contents of the port to
> > > > > multiple PCIe Physical Functions (PF).
> > > > > 
> > > > > This new functionality requires changing the port reset
> > > > > behavior during FPGA and software initialization from
> > > > > revision 1 of the port feature. With revision 1, the initial
> > > > > state of the logic inside the port was not guaranteed to
> > > > > be valid until a port reset was performed by software during
> > > > > driver initialization. With revision 2, the initial state
> > > > > of the logic inside the port is guaranteed to be valid,
> > > > > and a port reset is not required during driver initialization.
> > > > > 
> > > > > This change in port reset behavior avoids a potential race
> > > > > condition during PCI enumeration when a port is connected to
> > > > > multiple PFs. Problems can occur if the driver attached to
> > > > > the PF managing the port asserts reset in its probe function
> > > > > when a driver attached to another PF accesses the port in its
> > > > > own probe function. The potential problems include failed or hung
> > > > 
> > > > Only racing during probe functions? I assume any time port_reset()
> > > > would fail TLPs for the other PF. And port_reset() could be triggered
> > > > at runtime by ioctl().
> > > 
> > > Yes, a port_reset() triggered by ioctl could result in failed TLP for the
> > > other PFs. The user space SW performing the ioctl needs to ensure all PFs
> > > involved are properly quiesced before the port_reset is performed.
> > 
> > How would user get an insight into other PF drivers to know everything
> > is quiesced?  I mean do we need driver level management for this?
> 
> Since this is an FPGA, the number of other PFs and the drivers bound to
> those PFs depends on the FPGA image. There would also be user space software
> stacks involved with the other PFs as well. The user would have to ensure
> all the SW stacks and drivers are quiesced as appropriate for the FPGA

User may not know everything about the device, they only get part of the
controls that drivers grant. This is still true for vfio + userspace
drivers.

> image. I don't think the driver performing the port_reset() can know all the

Other PF drivers should know their own components. They should be aware
that their devices are being reset. 

> components to be able to provide any meaningful management.

If the reset provider and reset consumer are not in the same driver,
they should interact with each other. IIRC, some reset controller class
works for this purpose.

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
> > > 
> > > Do you want me to update the commit message with this information?
> > > 
> > > Thanks,
> > > Matthew
> > 
> > 

