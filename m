Return-Path: <linux-kernel+bounces-119998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E0188CFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CAD1C6174C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCCD13D617;
	Tue, 26 Mar 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATyO/1oC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE41E51D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488142; cv=none; b=ES5W093eI6JpKY6dbe/+FwD7DfBMSADVpqhEhZxdX3kVmXfFyVIjRnhN0/n3637lbxsj/IZEww/4Dc6B/2+h66B6iW95dZCRlbzxBD6ejok/eFBC4yeZ5vKw/j6eUsUjgtQWswSoocswzIaU5Qo2dMi9DG06XoSdK69JMfmlb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488142; c=relaxed/simple;
	bh=hNqS0RGch8RfVXZ1IqBRgaamMKDkNkj5JtNHm+6QImU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp9dUjolcvrB8XyzFKEp1FqOt4HSqxtoHiHZQBa1JBLkylaOaA3aoaLwO/+UAiDI6rRMYywvDYK6EC4QNBenD8m/vVjvkO1td0wUQp/O5UR47Gw5XD7nPt57CRhR4PVIcR5UYsEw6cJ/l1TU1qaWGOLh2WtYCUMEWnRmda/JeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATyO/1oC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711488141; x=1743024141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNqS0RGch8RfVXZ1IqBRgaamMKDkNkj5JtNHm+6QImU=;
  b=ATyO/1oCBw/dhWcAkSA9nziZwBpiHqWepAvmKF9hrT0OcZ6JPp8OLX4W
   m6iu4BLFFOZYShz4ifIq0aozS4Xw8V4HXotFn1FhDIcyrqrWkS1t0Rt/r
   oWFEi+3TeVEYSCNhlnzW9XIyUkNbVXc8kLWm6TmQVi4IsAB5oYE2w/UmU
   6eJ/01t/asbifQqTER2OStFRZ+g+s8RaxZT/PeZeJN9cNkFGfR2X6ukZV
   WFqcQPpJ4/NsGF7uF4oK6lZQdCyAsHvBaxeae2z+KoSSdzn5YVbFHkHp9
   P2tMdoJZ8idY70ATayC3hKD1QtYVcQQr5Nrm1jHQUCaMwINQ7i3jYWrqx
   Q==;
X-CSE-ConnectionGUID: fvKm26HtQIywUvO5WyWGoA==
X-CSE-MsgGUID: iSuefi9QRsK7C4UhCWOmPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10366096"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="10366096"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914891038"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="914891038"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 14:22:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpEFM-0000000GT1g-3B71;
	Tue, 26 Mar 2024 23:22:16 +0200
Date: Tue, 26 Mar 2024 23:22:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgM8iExkz5S6reeq@smile.fi.intel.com>
References: <ZgL2G4ItkFlQ7cqS@smile.fi.intel.com>
 <20240326210107.GA1496865@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326210107.GA1496865@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 04:01:07PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2024 at 06:21:47PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2024 at 04:19:15PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:

..

> > > > -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > 
> > > I guess at least some of these devices do support INTx, since we
> > > always used INTx previously, right?
> > > 
> > > There are a bunch of bug reports complaining about a lack of _PRT
> > > entries for them, e.g., these from
> > > https://bugzilla.kernel.org/show_bug.cgi?id=212261#c24:
> > 
> > But this is not related to my patch, and the mentioned bug report seems about
> > all AMD and Intel platforms.
> > 
> > Can you, please, elaborate what the relation to my patch?
> 
> Right, sorry I didn't make that clear; I didn't mean that it was
> related to your patch.  I was just looking at this old bug report
> about not being able to figure out INTx routing.
> 
> Your patch had to do with interrupts, so I just wondered whether you
> had insight into whether these devices actually used INTx.  My guess
> is that at least some of them *do* use INTx, because prior to your
> patch, the driver *only* tried to use INTx.
> 
> If it happend that they never use INTx, but advertise INTA via
> Interrupt Pin, I think that would be a device defect that we might
> consider a quirk for.
> 
> If they *do* use INTx, and the _PRT doesn't tell us how it's routed, I
> think that would be a firmware defect, and ... I dunno what we would
> do.  I guess just avoid using INTx because we don't know where the
> interupt goes.

Okay, so the revert after all is not required, do you agree?

-- 
With Best Regards,
Andy Shevchenko



