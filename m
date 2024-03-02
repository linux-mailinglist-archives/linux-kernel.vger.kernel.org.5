Return-Path: <linux-kernel+bounces-89435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23586F04F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35979284BC4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF41754E;
	Sat,  2 Mar 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKD7pmZR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AE15E9C;
	Sat,  2 Mar 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709379853; cv=none; b=p+0LepFMWpyE8Tw3o09gYvEgS7IiYWy97ac1tw4MNlXCYWV4WMtafFB3BZbg23ytlaQueoWZm3W9d7fnci+DnTgt/EiVrCtwIeTrsBIbjJRXBWUs+ShCwxlgkYIYjtwN5dTrhiuDx5QGjXlV9C7hcfxxvzQZAmWIWykIJsCSRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709379853; c=relaxed/simple;
	bh=TNT3Rx25q+66RksmLIf8H3eVPQJ5mFxDycrmZ1FMbNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZwjoMeH8kWy1hOFAy3BY0USNm8LcHSdpAQdpnCmYz+WEVTU3tU3HnVnIuphF3FomdEp6EVa203xa9gJN/galPVT3D5xrD57iM6syWeMzvmyabinvnzB8W8NlOiRzp6d7NKh1dN+3ZAzNWotTKG+m40vCtkAb/RMlaoGFg2Wagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKD7pmZR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709379851; x=1740915851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNT3Rx25q+66RksmLIf8H3eVPQJ5mFxDycrmZ1FMbNU=;
  b=lKD7pmZRIdXmq05J8qAewl2p2IHr1/0Mt6OMQ7sxR9dDmTirVITFgv5R
   cWSQWFl6Xt+7mPyafI8Lw/SotXTzD6Ns3mb+nK2oLPEqhVwsQKmODHSdb
   tIXjchQVn5KSpv+UahRSowox8kKVUZX3OPTFTRPVknoGqs5ZZyAlwdQss
   BBikFc7DN6yq/SuSibmZsS/hTdo4g6tR1laAR2vI3yEbKYiMBxQAwzRwa
   b6jvDNvZNvAOL8RcEOU+E7rYQb76K18EF1SjkqODvBTU7mt11ync4J3oP
   /srhXXD0qEPsSneMMlaatKufywVN643cyXCzCiABW88/7B0/KMMqsoSnW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15364420"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="15364420"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 03:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="12990824"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 02 Mar 2024 03:44:08 -0800
Date: Sat, 2 Mar 2024 19:39:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Message-ID: <ZeMQD+PH8lUfbVKa@yilunxu-OptiPlex-7050>
References: <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>
 <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401311610020.112016@sj-4150-psse-sw-opae-dev2>
 <ZcBIjcFJjGKf0qcO@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2402051600190.122158@sj-4150-psse-sw-opae-dev2>
 <ZdF4JvYQQL8irnbW@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2402201658400.191484@sj-4150-psse-sw-opae-dev2>
 <ZdYhUK5yFFlhVV62@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2403011142350.240045@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2403011142350.240045@sj-4150-psse-sw-opae-dev2>

On Fri, Mar 01, 2024 at 12:39:24PM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> [snip]
> 
> > > 
> > > Hi Yilun,
> > > 
> > > I think this conversation has gotten a little off track. This patch only
> > > changes the port reset behavior at driver initialization for revision 2 of
> > > the port IP. The behavior and the requirements of port reset during run time
> > > have not changed. The existing implementation requires the user performing
> > > the port reset to ensure appropriate SW was quiesced. This patch does not
> > > change this requirement.
> > 
> > You are actually adding support to the new devices behavior defined by
> > revision 2.  Previously the user requires the management PF driver to do port
> > reset, and this only affects some logic in the PF itself and the impact could
> > be handled inside the driver.  The current PF driver doesn't actually do anything
> > because it (or any kernel component) never touches the disabled logic, and the
> > user accessing of the mmapped but disabled logic won't cause system issues.
> 
> I'm wondering about the use case when Virtual Functions (VFs) are enabled
> with the current driver. If partial reconfiguration of the port occurs,
> which includes a reset, what happens to the user software attached to the
> VFs when the hardware has changed out from under it? While the current port

Ah, yes. That may be the problem for user, you can fix it.  But the fix
could actually be easier, cause the port driver is fully aware of the
reset request and the reset flow is under its control.

> implementation won't cause PCIe errors when the logic is disable, something
> has to notify the user software that the hardware changed. I think the user
> space software would be typically notified of the change by the
> orchestration software performing the partial reconfiguration. I think the
> use case of VFs with the original port implementation is logically
> equivalent to the new port implementation with multiple PFs/VFs.

The difference is that, the original port driver is fully responsible for the
reset flow and the AFU mapping, while the new port implementation has no
control to the to-be-resetted logic, it blindly does the reset.

> 
> > 
> > But the new management PF does port reset and affect other PFs, and may
> > cause disorder in other drivers. so you need extra code to support the
> > behavior.
> 
> I think the real problem is that the new port is not doing as good of a job
> preventing PCIe errors during port reset as the previous version.

Even if the reset won't cause PCIe errors, the other PF/VF drivers may
still meet HW access issues not understandable by themselves and cause
kernel level panic.

Thanks,
Yilun

> 
> Matthew
> > 
> > This patch does make some progress, as you said, "With revision 2,the
> > initial state of the logic inside the port is guaranteed to be valid, and
> > a port reset is not required during driver initialization".  But it
> > should not be the only patch to enable the new port reset behavior.
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > > image. I don't think the driver performing the port_reset() can know all the
> > > > > > 
> > > > > > Other PF drivers should know their own components. They should be aware
> > > > > > that their devices are being reset.
> > > > > 
> > > > > The other PF drivers depend on the actual FPGA image being run.
> > > > > 
> > > > > > 
> > > > > > > components to be able to provide any meaningful management.
> > > > > > 
> > > > > > If the reset provider and reset consumer are not in the same driver,
> > > > > > they should interact with each other. IIRC, some reset controller class
> > > > > > works for this purpose.
> > > > > 
> > > > > The other PFs in many cases can present as standard devices with existing
> > > > > drivers like virtio-net or virtio-blk. It does not seem desireable to have
> > > > > to change existing drivers for a particular FPGA implementation
> > > > 
> > > > If you have to use a specific method for reset, it is not a standard virtio
> > > > pci device, and you have to make some change.
> > > 
> > > From the perspective of the PCI PF/VF implementing the virtio or other
> > > standard device, the pci endpoint is completely compliant to the standard,
> > > and no driver changes should be required. As mentioned above, this patch
> > > does nothing to change any of this behavior. Consider a port reset that is
> > > part of a partial configuration flow. The virtio endpoint can become
> > > something completely different with a completely different driver. This
> > 
> > Then how could the virtio driver stop and remove itself to avoid crashing the
> > kernel, and how could the new driver be probed.  If the answer is still
> > userspace responsible for everything, that's not good to me.
> > 
> > Thanks,
> > Yilun
> > 
> > > patch does not affect this flow either.
> > > 
> > > Thanks,
> > > Matthew
> > > 
> > > > 
> > > > Thanks,
> > > > Yilun
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Matthew
> > > > > > 
> > > > > > Thanks,
> > > > > > Yilun
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Matthew
> > > > > > > 
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Yilun
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Do you want me to update the commit message with this information?
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Matthew
> > > > > > > > 
> > > > > > > > 
> > > > > > 
> > > > > > 
> > > > 
> > 

