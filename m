Return-Path: <linux-kernel+bounces-70179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FCA859464
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E61F21BD4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A3717FF;
	Sun, 18 Feb 2024 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VO0JYDhF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924D15C0;
	Sun, 18 Feb 2024 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226833; cv=none; b=QVOsAyT3PHLHx1bwvri60Oy0+UahjOB9HR+19nh2wXGo/lVsh7mOEMcNYjro7lc8M2vkf9FWBAPm4CSaxpvSGyL+nzWwYTijnf2L9lLMz4C5hR2WVkl/I89EOKxwWqL9XYEMI1l5tmzC3+4j1WBzUcDRkFK+ATHPSWTW1z2mNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226833; c=relaxed/simple;
	bh=kEu7RUHLgNZwfVyNdolqNMnkH+oHU7TrRv26YvjrNkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXBINZIzHN5ikLwJNVNuVkQK3+3r6y1CVs1Ull7UM0RS6FGFrF78Z8ug1aDqY3qvAbbv2hRnkxWYba3HMnJLiLolOmujVQUQghncK9AEb/dJZ3ekLYm9SxjVKjUzQIEkqVD7spdhOmCIm/TJFy8tDjd+d5n7Aw292Jx7SYoTGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VO0JYDhF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708226832; x=1739762832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kEu7RUHLgNZwfVyNdolqNMnkH+oHU7TrRv26YvjrNkc=;
  b=VO0JYDhFjeMRFoD9pQohRBuk0OMGm6GDHiPgj3wS5YjS12lJBWuNvZ7K
   UMysbcRKhdV8J7ZSK+/gC8pzfWfnr4h13+w0kHs0PVCAo6OvVhffx0OsV
   sazAAOJx8OINSKyk/WNCbFaoF/sRkF44e7ia8bAa0lW0rY1Bsy8B7GKLj
   6407V3KbwC/4muxHMGpjWvHKcF4aMsaGENAgnBUtiHuy9N9dfjREYtAWI
   uD4eylB/3kbjiUTjI8GTMAvWYUdJvOtC8fjxnebWFtPzA+Dj2Gu/sn2ei
   smMRSg/3f5M7jH9D7BkiIPKN/qdb+htCFiVrmjdFEzBZ1IjGUyirIXHfx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2187942"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="2187942"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 19:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="27344386"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2024 19:27:09 -0800
Date: Sun, 18 Feb 2024 11:23:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Message-ID: <ZdF4JvYQQL8irnbW@yilunxu-OptiPlex-7050>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>
 <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>
 <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
 <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2402051600190.122158@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2402051600190.122158@sj-4150-psse-sw-opae-dev2>

On Wed, Feb 07, 2024 at 08:40:55AM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Mon, 5 Feb 2024, Xu Yilun wrote:
> 
> > On Wed, Jan 31, 2024 at 04:26:27PM -0800, matthew.gerlach@linux.intel.com wrote:
> > > 
> > > 
> > > On Wed, 31 Jan 2024, Xu Yilun wrote:
> > > 
> > > > On Tue, Jan 30, 2024 at 10:00:16AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > > > 
> > > > > 
> > > > > On Tue, 30 Jan 2024, Xu Yilun wrote:
> > > > > 
> > > > > > On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
> > > > > > > Revision 2 of the Device Feature List (DFL) Port feature
> > > > > > > adds support for connecting the contents of the port to
> > > > > > > multiple PCIe Physical Functions (PF).
> > > > > > > 
> > > > > > > This new functionality requires changing the port reset
> > > > > > > behavior during FPGA and software initialization from
> > > > > > > revision 1 of the port feature. With revision 1, the initial
> > > > > > > state of the logic inside the port was not guaranteed to
> > > > > > > be valid until a port reset was performed by software during
> > > > > > > driver initialization. With revision 2, the initial state
> > > > > > > of the logic inside the port is guaranteed to be valid,
> > > > > > > and a port reset is not required during driver initialization.
> > > > > > > 
> > > > > > > This change in port reset behavior avoids a potential race
> > > > > > > condition during PCI enumeration when a port is connected to
> > > > > > > multiple PFs. Problems can occur if the driver attached to
> > > > > > > the PF managing the port asserts reset in its probe function
> > > > > > > when a driver attached to another PF accesses the port in its
> > > > > > > own probe function. The potential problems include failed or hung
> > > > > > 
> > > > > > Only racing during probe functions? I assume any time port_reset()
> > > > > > would fail TLPs for the other PF. And port_reset() could be triggered
> > > > > > at runtime by ioctl().
> > > > > 
> > > > > Yes, a port_reset() triggered by ioctl could result in failed TLP for the
> > > > > other PFs. The user space SW performing the ioctl needs to ensure all PFs
> > > > > involved are properly quiesced before the port_reset is performed.
> > > > 
> > > > How would user get an insight into other PF drivers to know everything
> > > > is quiesced?  I mean do we need driver level management for this?
> > > 
> > > Since this is an FPGA, the number of other PFs and the drivers bound to
> > > those PFs depends on the FPGA image. There would also be user space software
> > > stacks involved with the other PFs as well. The user would have to ensure
> > > all the SW stacks and drivers are quiesced as appropriate for the FPGA
> > 
> > User may not know everything about the device, they only get part of the
> > controls that drivers grant. This is still true for vfio + userspace
> > drivers.
> 
> A user performing a port reset would have to know the impact to the specific
> FPGA image being run in order to ensure all SW stacks are ready for the
> reset.

We are not going to change the logic of the whole driver model just
because the device is backed up by an FPGA image.  The *driver* should be
fully responsible for matched devices.  A HW reset unaware to the
device driver is not wanted.  Assuming that the userspace could control
every access to device makes no sense.

For your case, there is no garantee userspace could block every access
to "other PF" initiated by "other PF" driver.  There is also no
notification to "other PF" driver that userspace is doing reset to
"other PF" via "management PF" interface.  "other PF" driver just break
on reset.

> 
> > 
> > > image. I don't think the driver performing the port_reset() can know all the
> > 
> > Other PF drivers should know their own components. They should be aware
> > that their devices are being reset.
> 
> The other PF drivers depend on the actual FPGA image being run.
> 
> > 
> > > components to be able to provide any meaningful management.
> > 
> > If the reset provider and reset consumer are not in the same driver,
> > they should interact with each other. IIRC, some reset controller class
> > works for this purpose.
> 
> The other PFs in many cases can present as standard devices with existing
> drivers like virtio-net or virtio-blk. It does not seem desireable to have
> to change existing drivers for a particular FPGA implementation

If you have to use a specific method for reset, it is not a standard virtio
pci device, and you have to make some change.

Thanks,
Yilun

> 
> Thanks,
> Matthew
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
> > > > > 
> > > > > Do you want me to update the commit message with this information?
> > > > > 
> > > > > Thanks,
> > > > > Matthew
> > > > 
> > > > 
> > 
> > 

