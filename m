Return-Path: <linux-kernel+bounces-45781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D28C84362F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A971F2670C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F123DB81;
	Wed, 31 Jan 2024 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLy1WTDj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF943D986;
	Wed, 31 Jan 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680004; cv=none; b=XWIabctwAGOo//vFCaDojLmpL8Av9fCgDSnNzjen8yfKH4qriy3ULkbMdsgCErkW7gjfXaLxzsymm3uI+NpFeWEB6wozKP6xsMOsbqshZ4KtvFvpt9QkpxLz0Rov7o5MibI8rDu2QaJKUkZsFjl1m68TUpfVrYrFHFKdXE5RKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680004; c=relaxed/simple;
	bh=zYKdxbeD/BiYZ6iSuprMc52VLxxA+Qn+5DDM5o6EiaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv05S0pNskxdeXXmzHSnT4GfvV/EveRWFypCOlQNZ2WfhpUEmhmXbeogVlEqVDvcORDwibYNcRSOve+JkAvMbs5C35AJKEnTAwkrMQek3oFDvFAvYx9/5h5engkxkHGsoAUbnMxbdTT3NipKUXRL9s3ykLu+1TAEk5LCyXWEu2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLy1WTDj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706680003; x=1738216003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zYKdxbeD/BiYZ6iSuprMc52VLxxA+Qn+5DDM5o6EiaE=;
  b=nLy1WTDjof/2gGaS1fsyrCgvgBV1f+Up/Cvuypg2Qefh2hwURWdo/+q6
   nMwqNxUeOHUXkmLzGtA23hf1hhoR/pNStFo0ucWlOY+8wycefNd3dPuT9
   NvDvFWwAcl92OoRGfVGigVMzlgHBklNhF2L2gKLMECtz2MIUr6dLCg44v
   wZbYgRPlWAUZrQ+q/lOWCs0+5GrnG1TeYAXVgwEvGWYG2KpRL7aDKOn77
   ShB3wpvRwm3JT0s26kRe1ZyO05GlL8jefCRD0nW9zb2LT1WZQNbY3bOgR
   RvYooBRIcWDlk8OQmRB4eLe0xBFGMPDIWkWMIESDdIyRKYGM6mr/lZwuS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17030298"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17030298"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961512432"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="961512432"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2024 21:46:40 -0800
Date: Wed, 31 Jan 2024 13:43:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: matthew.gerlach@linux.intel.com
Cc: hao.wu@intel.com, trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: support Rev 2 of DFL Port feature
Message-ID: <Zbnd8W1ciTKeoKc4@yilunxu-OptiPlex-7050>
References: <20240125233715.861883-1-matthew.gerlach@linux.intel.com>
 <ZbjHl8ptQG5FdHvC@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2401300948590.112016@sj-4150-psse-sw-opae-dev2>

On Tue, Jan 30, 2024 at 10:00:16AM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 30 Jan 2024, Xu Yilun wrote:
> 
> > On Thu, Jan 25, 2024 at 03:37:15PM -0800, Matthew Gerlach wrote:
> > > Revision 2 of the Device Feature List (DFL) Port feature
> > > adds support for connecting the contents of the port to
> > > multiple PCIe Physical Functions (PF).
> > > 
> > > This new functionality requires changing the port reset
> > > behavior during FPGA and software initialization from
> > > revision 1 of the port feature. With revision 1, the initial
> > > state of the logic inside the port was not guaranteed to
> > > be valid until a port reset was performed by software during
> > > driver initialization. With revision 2, the initial state
> > > of the logic inside the port is guaranteed to be valid,
> > > and a port reset is not required during driver initialization.
> > > 
> > > This change in port reset behavior avoids a potential race
> > > condition during PCI enumeration when a port is connected to
> > > multiple PFs. Problems can occur if the driver attached to
> > > the PF managing the port asserts reset in its probe function
> > > when a driver attached to another PF accesses the port in its
> > > own probe function. The potential problems include failed or hung
> > 
> > Only racing during probe functions? I assume any time port_reset()
> > would fail TLPs for the other PF. And port_reset() could be triggered
> > at runtime by ioctl().
> 
> Yes, a port_reset() triggered by ioctl could result in failed TLP for the
> other PFs. The user space SW performing the ioctl needs to ensure all PFs
> involved are properly quiesced before the port_reset is performed.

How would user get an insight into other PF drivers to know everything
is quiesced?  I mean do we need driver level management for this?

Thanks,
Yilun

> 
> Do you want me to update the commit message with this information?
> 
> Thanks,
> Matthew

