Return-Path: <linux-kernel+bounces-127388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB69894A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22281C22429
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729517C6D;
	Tue,  2 Apr 2024 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQaVlFg0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3B17BBA;
	Tue,  2 Apr 2024 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033339; cv=none; b=bhPimYtXDTXR5UWtXwzGDHcBaGLif2fqcJG1xTPy34A9N41iWLKey63hxDvOV6kBSUGYnDx2bawWTCgi9UHg6XlBDiLt8JFClTFZJB3kMQqbuaZk9pFJ8ALLhc/ZfpwB5yJ3iLqEUs8Zj6ISF4QGpTQ1B2Q14iq3dTdcy9s/uBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033339; c=relaxed/simple;
	bh=9dnJjfacnC5NIXeRU42Rs8bqYi+ZfEdAnf1tJGX8DCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy2SFSV9vACHj21c8qtKQYufNaUu8b785KjgRX9Et7iWmJnRfPBKCU5Mlz6RNVzAYW46JJvWu5q1VE27X0zilw94yX1dhyBbRhYlua6J6mf0wA7zTKb5220MFgQsZYc0Fsvrf98w/9ZZEkDbN9iMt90dS+2l/bP1hRfwvAjLEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQaVlFg0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712033337; x=1743569337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9dnJjfacnC5NIXeRU42Rs8bqYi+ZfEdAnf1tJGX8DCc=;
  b=FQaVlFg0oLACqi4CtmMTHoHJ0zrqTj50S3M2l695jDqFds6K2B3gX2Bp
   B86tH0mWyUFbEua76H8zbY5IiCi3v9RCFwMFK5C+uZQk6nO9puCOPmfJW
   eOpK+YzuuLW+FvPgQi+GevJyE/3V0GNCPbeDvW9F9V9QOIbbei/43wLOX
   DtXcxUFXP2fZjJ70FtOGfcTj+RorkLSQqw4jFAAFEnFsiLh8r7PbinQyp
   Wejg99OKpyKwJx5RebCUx5xm8I9Kn1u6nj9uWxa0Ucp9UuOgaG13ye7zr
   siJR1NOPmzmc8ZzmudP7klHWxCMJKCObnGtyDG6+KVdoTzZgQWbVfaTDh
   Q==;
X-CSE-ConnectionGUID: LkR//19HQR2ci2V1gQmFmw==
X-CSE-MsgGUID: 2MvqGf7YQViSQWnT0TamUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24639104"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="24639104"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 21:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22601807"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 01 Apr 2024 21:48:54 -0700
Date: Tue, 2 Apr 2024 12:44:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tim Whisonant <tim.whisonant@intel.com>,
	Ananda Ravuri <ananda.ravuri@intel.com>
Subject: Re: [PATCH] fpga: add DFL driver for CXL Cache IP block
Message-ID: <ZguNE7mnDwNaT+/7@yilunxu-OptiPlex-7050>
References: <20240308172327.1970160-1-matthew.gerlach@linux.intel.com>
 <ZflkK/VZO0wqiAhz@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2403281549070.340749@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2403281549070.340749@sj-4150-psse-sw-opae-dev2>

On Fri, Mar 29, 2024 at 08:34:49AM -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 19 Mar 2024, Xu Yilun wrote:
> 
> > On Fri, Mar 08, 2024 at 09:23:27AM -0800, Matthew Gerlach wrote:
> > > From: Tim Whisonant <tim.whisonant@intel.com>
> > > 
> > > Add a Device Feature List (DFL) driver for the
> > > Intel CXL Cache IP block. The driver
> > > provides a means of accessing the device MMIO and the
> > 
> > Why the device MMIO should be accessed by userspace?
> 
> The definition of the MMIO space is actually dependent on the the custom
> logic in the FPGA image. Given the variability of the custom logic
> implemented in the FPGA, it seems burdensome to handle the variability in
> kernel code.
> 
> > 
> > > capability to pin buffers and program their physical
> > > addresses into the HE-Cache registers. User interface
> > 
> > Are these registers also exposed to userspace?
> 
> These registers are currently exposed to user space as well. It probably
> make sense to be consistent and let user space code handle these registers,
> like all custom logic registers, in user space.
> 
> > 
> > And this patch to support a new device/IP, please firstly describe
> > what the device/IP is doing.  I think not everyone(including me) here
> > is familar with CXL standard and how this IP block is implementing CXL
> > functionality.  Some reference documentation is also helpful.
> 
> This is very good feedback. There are actually multiple IP blocks involved
> here. There is a Hard IP block (HIP), and there is a FPGA/soft IP block
> interfacing the HIP, and then there is custom logic implementing a desired
> application.
> 
> > 
> > After a quick skim of this patch, I can see user is trying to write a
> > set of physical addrs to some register, but have no idea why this
> > should be done. i.e. Do not reiterate what the code literally does.
> 
> In this case, the physical addresses are being written to the custom,
> application logic in the FPGA and should be moved to user space.
> 
> If all MMIO to the custom logic is moved to user space, then this driver is
> not really about CXL and hardware. This driver just provides services of
> pinning/unpinning memory with numa node awareness. In this case, the driver
> name is wrong because there is nothing related to CXL nor any specific
> hardware implementation.

If this is not related to any hardware implementation. I'm afraid it is not
just the naming. From the limited knowledge I've got, you just want an
interface in memory management system, not in FPGA/DFL. You may send a
patch to MM people (or VFIO) for review, their opinions are determinative.
But my opinion is the patch is far from being ready to send. Some
questions I can quickly think of, FYI:

1. A justification why a physical address(CPU's perspective) is needed in
   userspace?

2. If question #1 is related to device requirement, why a device needs a
CPU physical address, rather than IOVA.

> 
> > 
> > > is exposed via /dev/dfl-cxl-cache.X as described in
> > > include/uapi/linux/fpga-dfl.h.
> > 
> > And please split the patch, e.g. first add a skeleton of bus driver,
> > then add the skeleton of char interface, then add the functionalities
> > one by one.  This gives chances to clearly describe each function, and
> > why add it, etc.
> 
> If this driver is only implementing a char interface to memory management,
> does it make sense to split the code into separate patches?

In general, it is alway good to split the whole code into small patches.
That makes better understanding. But since it seems to be a different
story now, the most important thing is to clearly tell the use case, what's
the existing solution kernel have, why they are not fit for you? what
are the possible options? why you choose this option? A general word that
application logic demands is not helpful.

Thanks,
Yilun

