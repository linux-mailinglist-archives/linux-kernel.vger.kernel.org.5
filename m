Return-Path: <linux-kernel+bounces-75090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7E85E2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951741C245AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9F81759;
	Wed, 21 Feb 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsQXC7qO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D26994A;
	Wed, 21 Feb 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532288; cv=none; b=dz6uVdB7lI46DjQO6YMW6KT31PcvwSaTAz+iqIx8Yw0KMJUGksjWGEcUShvMBiSBTSlxYU2PUEA7z9xcVQR68ERtKHhjRGAB4He1NyOIfIcwhmUpm2erxrHPYMkLTE8ud0GOjZXDWNPHp/GLVkRsw2NKEhMqnRnBeIaPLqtGvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532288; c=relaxed/simple;
	bh=BOE7ZLv14uGTlO6KAsv6/doL9GayurXClMerkYD0HBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4vz5TlBLlrba7LXPaQ5GLoD+1eFmnzRfat4UaI4KuMh8Osq0D6hrIChXygxKeT1lFQLZUT5ykJ0BFlr5DyYMS8euwr4oXV26JZrJ7LpAkzs4VB7hB2gUUk2WHUT0T7D+ObF1y1+0nvZqmnWhyVrnzaVzB7ZV4gpigMwVTvRpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsQXC7qO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708532287; x=1740068287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BOE7ZLv14uGTlO6KAsv6/doL9GayurXClMerkYD0HBg=;
  b=CsQXC7qOTfRXkppOUhzCfOJqGH80ywuHsZ5vFMxr5RwaSrH8PCYtdIli
   809kjJTatsyhkFnxvZs0MjKYv4qdNfk0licjwD5rJi+yKlN6jAcnefAfj
   BkaRl692EYg1pXot/XtK1ItoQs316KyRnPfe/YcWPVEfmEO/vnBin2Tje
   zzz4v18oBHf+eGvpuDzEzQpYoIpqYQgJTSlpqi61iySmlAH/B6fVo8zrV
   YPoMzycKUzNrgnegxhth9lFpLBgDtuB7QFxHQY6CItPaGnJ9xmBLGpQkZ
   RSHNx4oH6IY5YRRPIE2igjEqGqIi2O7X4JcNQP0ns2t7a6gFV8a2QsvJm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="3183909"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="3183909"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5344100"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 21 Feb 2024 08:18:04 -0800
Date: Thu, 22 Feb 2024 00:14:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Message-ID: <ZdYhUK5yFFlhVV62@yilunxu-OptiPlex-7050>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>
 <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>
 <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
 <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2402051600190.122158@sj-4150-psse-sw-opae-dev2>
 <ZdF4JvYQQL8irnbW@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2402201658400.191484@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2402201658400.191484@sj-4150-psse-sw-opae-dev2>

On Tue, Feb 20, 2024 at 05:49:04PM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Sun, 18 Feb 2024, Xu Yilun wrote:
> 
> > On Wed, Feb 07, 2024 at 08:40:55AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > 
> > > 
> > > On Mon, 5 Feb 2024, Xu Yilun wrote:
> > > 
> > > > On Wed, Jan 31, 2024 at 04:26:27PM -0800, matthew.gerlach@linux.intel.com wrote:
> > > > > 
> > > > > 
> > > > > On Wed, 31 Jan 2024, Xu Yilun wrote:
> > > > > 
> > > > > > On Tue, Jan 30, 2024 at 10:00:16AM -0800, matthew.gerlach@linux.intel.com wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On Tue, 30 Jan 2024, Xu Yilun wrote:
> > > > > > > 
> > > > > > > > On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
> > > > > > > > > Revision 2 of the Device Feature List (DFL) Port feature
> > > > > > > > > adds support for connecting the contents of the port to
> > > > > > > > > multiple PCIe Physical Functions (PF).
> > > > > > > > > 
> > > > > > > > > This new functionality requires changing the port reset
> > > > > > > > > behavior during FPGA and software initialization from
> > > > > > > > > revision 1 of the port feature. With revision 1, the initial
> > > > > > > > > state of the logic inside the port was not guaranteed to
> > > > > > > > > be valid until a port reset was performed by software during
> > > > > > > > > driver initialization. With revision 2, the initial state
> > > > > > > > > of the logic inside the port is guaranteed to be valid,
> > > > > > > > > and a port reset is not required during driver initialization.
> > > > > > > > > 
> > > > > > > > > This change in port reset behavior avoids a potential race
> > > > > > > > > condition during PCI enumeration when a port is connected to
> > > > > > > > > multiple PFs. Problems can occur if the driver attached to
> > > > > > > > > the PF managing the port asserts reset in its probe function
> > > > > > > > > when a driver attached to another PF accesses the port in its
> > > > > > > > > own probe function. The potential problems include failed or hung
> > > > > > > > 
> > > > > > > > Only racing during probe functions? I assume any time port_reset()
> > > > > > > > would fail TLPs for the other PF. And port_reset() could be triggered
> > > > > > > > at runtime by ioctl().
> > > > > > > 
> > > > > > > Yes, a port_reset() triggered by ioctl could result in failed TLP for the
> > > > > > > other PFs. The user space SW performing the ioctl needs to ensure all PFs
> > > > > > > involved are properly quiesced before the port_reset is performed.
> > > > > > 
> > > > > > How would user get an insight into other PF drivers to know everything
> > > > > > is quiesced?  I mean do we need driver level management for this?
> > > > > 
> > > > > Since this is an FPGA, the number of other PFs and the drivers bound to
> > > > > those PFs depends on the FPGA image. There would also be user space software
> > > > > stacks involved with the other PFs as well. The user would have to ensure
> > > > > all the SW stacks and drivers are quiesced as appropriate for the FPGA
> > > > 
> > > > User may not know everything about the device, they only get part of the
> > > > controls that drivers grant. This is still true for vfio + userspace
> > > > drivers.
> > > 
> > > A user performing a port reset would have to know the impact to the specific
> > > FPGA image being run in order to ensure all SW stacks are ready for the
> > > reset.
> > 
> > We are not going to change the logic of the whole driver model just
> > because the device is backed up by an FPGA image.  The *driver* should be
> > fully responsible for matched devices.  A HW reset unaware to the
> > device driver is not wanted.  Assuming that the userspace could control
> > every access to device makes no sense.
> > 
> > For your case, there is no garantee userspace could block every access
> > to "other PF" initiated by "other PF" driver.  There is also no
> > notification to "other PF" driver that userspace is doing reset to
> > "other PF" via "management PF" interface.  "other PF" driver just break
> > on reset.
> 
> Hi Yilun,
> 
> I think this conversation has gotten a little off track. This patch only
> changes the port reset behavior at driver initialization for revision 2 of
> the port IP. The behavior and the requirements of port reset during run time
> have not changed. The existing implementation requires the user performing
> the port reset to ensure appropriate SW was quiesced. This patch does not
> change this requirement.

You are actually adding support to the new devices behavior defined by
revision 2.  Previously the user requires the management PF driver to do port
reset, and this only affects some logic in the PF itself and the impact could
be handled inside the driver.  The current PF driver doesn't actually do anything
because it (or any kernel component) never touches the disabled logic, and the
user accessing of the mmapped but disabled logic won't cause system issues.

But the new management PF does port reset and affect other PFs, and may
cause disorder in other drivers. so you need extra code to support the
behavior.

This patch does make some progress, as you said, "With revision 2,the
initial state of the logic inside the port is guaranteed to be valid, and
a port reset is not required during driver initialization".  But it
should not be the only patch to enable the new port reset behavior.

> 
> > 
> > > 
> > > > 
> > > > > image. I don't think the driver performing the port_reset() can know all the
> > > > 
> > > > Other PF drivers should know their own components. They should be aware
> > > > that their devices are being reset.
> > > 
> > > The other PF drivers depend on the actual FPGA image being run.
> > > 
> > > > 
> > > > > components to be able to provide any meaningful management.
> > > > 
> > > > If the reset provider and reset consumer are not in the same driver,
> > > > they should interact with each other. IIRC, some reset controller class
> > > > works for this purpose.
> > > 
> > > The other PFs in many cases can present as standard devices with existing
> > > drivers like virtio-net or virtio-blk. It does not seem desireable to have
> > > to change existing drivers for a particular FPGA implementation
> > 
> > If you have to use a specific method for reset, it is not a standard virtio
> > pci device, and you have to make some change.
> 
> From the perspective of the PCI PF/VF implementing the virtio or other
> standard device, the pci endpoint is completely compliant to the standard,
> and no driver changes should be required. As mentioned above, this patch
> does nothing to change any of this behavior. Consider a port reset that is
> part of a partial configuration flow. The virtio endpoint can become
> something completely different with a completely different driver. This

Then how could the virtio driver stop and remove itself to avoid crashing the
kernel, and how could the new driver be probed.  If the answer is still
userspace responsible for everything, that's not good to me.

Thanks,
Yilun

> patch does not affect this flow either.
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
> > > > 
> > > > Thanks,
> > > > Yilun
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Matthew
> > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > Yilun
> > > > > > 
> > > > > > > 
> > > > > > > Do you want me to update the commit message with this information?
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Matthew
> > > > > > 
> > > > > > 
> > > > 
> > > > 
> > 

