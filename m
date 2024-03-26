Return-Path: <linux-kernel+bounces-120041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F188D0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1669320C35
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC5913DBBB;
	Tue, 26 Mar 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7L47YIn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E671CAAE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491918; cv=none; b=H+p4GSbg2NJ9WbMmUcwmjMEgOwNZPNkujMbxKD+BEFLA2yqbg+RCZqB27sXzfrRURGTp8Ix1WDlHzuOe5AJYRTubIHRpQpsxbAaMpKz+QJh0tg+G2BEHtjWJHsL1jxKexvzOuzbQcgOFWedO9d9K9KIsr40iaoyzhsFEudpK1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491918; c=relaxed/simple;
	bh=g/XFiAjpJDcqX2pvn3G29NxVuZNTNPhMT9fmGzwmC7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh5WO8Qp10DJhHtbl8a5qwzWKNAVAwARp/YEQFBMEv7loE84OtC2G/Di1HFjrbuWbly7QNQK8/4I4lgUYuhafJrTfj8VIAytWg4i+gdjQMHstY3zBL9vKSjMghFJbTq3rgL2Fy6vra8lYGtfGKFOnWo3KDStSC7QDGIw1xb8ZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7L47YIn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711491917; x=1743027917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g/XFiAjpJDcqX2pvn3G29NxVuZNTNPhMT9fmGzwmC7U=;
  b=O7L47YInZuugX6v2a28d9PAkdP0Q++x3rGZqO8YhSrlkDzE0pP6cGIsb
   yOVGHhl7Mn1kucxkxVznPLPie4lIHG2i/YWQuhV8gYxjM/TdlHOt9+sPa
   gmZZMF+NNJ98mHmBHnDvbYR1obVU7a/ZFYiHDZRzDZEzgQ1r8kd5WFL8V
   0GDOqAgmCgKrhgCrzxIJfEJAYNTQXAjNdFNkoMMRLo/+JLwPZZy7aCGT0
   FHAPQMCDExzXcV2WmjwADrZenXq2lcn1fDAmWRZ05/e2Z5BFONL46r9Ws
   ZhwnKp5nm+x5ojgZVZegXJSCDSFWm3zgfS6j9COSs96xw+XQk7DoK1wGN
   A==;
X-CSE-ConnectionGUID: M/bZNXQdR/um8TYH0HOBoA==
X-CSE-MsgGUID: O3dOXhcWRO2elBRgmD0KTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="9534553"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="9534553"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 15:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914892709"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="914892709"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 15:25:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpFEG-0000000GU7u-3r9h;
	Wed, 27 Mar 2024 00:25:12 +0200
Date: Wed, 27 Mar 2024 00:25:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgNLSFqgZOvwDrUQ@smile.fi.intel.com>
References: <ZgM8iExkz5S6reeq@smile.fi.intel.com>
 <20240326220953.GA1498942@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326220953.GA1498942@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 05:09:53PM -0500, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2024 at 11:22:16PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 04:01:07PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Mar 26, 2024 at 06:21:47PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Mar 25, 2024 at 04:19:15PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Mar 12, 2024 at 06:59:05PM +0200, Andy Shevchenko wrote:

..

> > > > > > -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> > > > > > +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > > > > >  	if (ret < 0)
> > > > > >  		return ret;
> > > > > 
> > > > > I guess at least some of these devices do support INTx, since we
> > > > > always used INTx previously, right?
> > > > > 
> > > > > There are a bunch of bug reports complaining about a lack of _PRT
> > > > > entries for them, e.g., these from
> > > > > https://bugzilla.kernel.org/show_bug.cgi?id=212261#c24:
> > > > 
> > > > But this is not related to my patch, and the mentioned bug report seems about
> > > > all AMD and Intel platforms.
> > > > 
> > > > Can you, please, elaborate what the relation to my patch?
> > > 
> > > Right, sorry I didn't make that clear; I didn't mean that it was
> > > related to your patch.  I was just looking at this old bug report
> > > about not being able to figure out INTx routing.
> > > 
> > > Your patch had to do with interrupts, so I just wondered whether you
> > > had insight into whether these devices actually used INTx.  My guess
> > > is that at least some of them *do* use INTx, because prior to your
> > > patch, the driver *only* tried to use INTx.
> > > 
> > > If it happend that they never use INTx, but advertise INTA via
> > > Interrupt Pin, I think that would be a device defect that we might
> > > consider a quirk for.
> > > 
> > > If they *do* use INTx, and the _PRT doesn't tell us how it's routed, I
> > > think that would be a firmware defect, and ... I dunno what we would
> > > do.  I guess just avoid using INTx because we don't know where the
> > > interupt goes.
> > 
> > Okay, so the revert after all is not required, do you agree?
> 
> Yes, I agree!  No indication of problems with your patch, AFAICS.
> 
> If you have any opinions or ideas on the "can't derive routing for PCI
> INT A" stuff, I'd still be interested, because it really annoys users.

Got it, thank you for clarification!

-- 
With Best Regards,
Andy Shevchenko



