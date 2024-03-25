Return-Path: <linux-kernel+bounces-117391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0388AACE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B84A1C372C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C041369BC;
	Mon, 25 Mar 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csp5AAhd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFA373182;
	Mon, 25 Mar 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381153; cv=none; b=ZsOqHykRwS8d8RSp8ES/TpBKzqRYu005Lg5BIl/ZA3OtyM3l56COdPOBV9OcPZuCz9514RrPOjYZFdXA8pUpgGHIGYEp/sZmwyBJ0lUykSiwgwvXtybFi+xKTHzXoqygDfXFGUVYJ41EN5/OiAAAjRgf3SWzwTZG2UsKSosjR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381153; c=relaxed/simple;
	bh=kjiOFnnK2KAkS3F7YdoMKW2eCLYhz7QSkvDvxyeUUFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg0w6zO6iRpi6hnUd75hI21NuqrZgKi/9WBGscZMj6DjChjNXmGAXU5QwyRJypaTwq6mYVDABE20nS6nQ18a7wFZSeQAvGGoyTa9TmeL6j3gKrmQjOb+YLKzGDAvFHmgnyM74dI2Zj7/rPmUEWCQUfPiXaEmBrhtV/UJO135R/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csp5AAhd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711381151; x=1742917151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kjiOFnnK2KAkS3F7YdoMKW2eCLYhz7QSkvDvxyeUUFU=;
  b=csp5AAhd001+f9Z3scwQD+xt2v97acACNcQC154M3NfaakssHHmDhJQq
   fnbvx51mBzBM5XX5avW+jVokANXnOxP+zQqyY4N+Z2cum79sANCrtxxD3
   Uz+bCty7Z/H0jfxpJHY1FbfJWuosr4MdLekKuSMWLgiYmMCPleppTyRHl
   tnTuJIrTfAloybYPIvDFj5N1sGtsAsg0c2QIz68UOqME9vB7Nnb4DEF/X
   pbcP5Bkq4QQDOS4oY+Sd2IL73UMqopxOOEXwryOmQ/UUOpEcFl+9VDljj
   ifBBJ2XqYSVMZyiG479SkRPy5Wx3VymxNI0rzfbxBf3qQq2wpOGBAphxW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="31828621"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="31828621"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914846848"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914846848"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:39:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1romPg-0000000G1ib-03Rx;
	Mon, 25 Mar 2024 17:39:04 +0200
Date: Mon, 25 Mar 2024 17:39:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: Implementation of fwnode_operations :: device_get_match_data()
 for software nodes?
Message-ID: <ZgGal-SJGWvn80Uk@smile.fi.intel.com>
References: <Y/9iLBWAO37y6lZZ@smile.fi.intel.com>
 <20230301143625.7kdnzujlv4psbhla@skbuf>
 <Y/9qtT0vckSikOKJ@smile.fi.intel.com>
 <20230301152527.khyzifds4w3rkebt@skbuf>
 <Y/9wlDkuh39auAgF@smile.fi.intel.com>
 <20230301171845.oliqbso7v2vmyqr3@skbuf>
 <Y/+MaRO4vrCRFXE8@smile.fi.intel.com>
 <20230301174309.5nqul7vg5uygwtpy@skbuf>
 <ZgF-_ww5k3h9pvEm@smile.fi.intel.com>
 <20240325161627.1c0fc955@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325161627.1c0fc955@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 04:16:27PM +0100, Herve Codina wrote:
> On Mon, 25 Mar 2024 15:41:19 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

..

> > > I agree we don't want to have multiple approaches of doing the same thing,
> > > but I debate whether I am really doing the same thing?
> > > 
> > > If software nodes are not designed to be a good fit for my kind of use
> > > case, then what are they designed for?  
> > 
> > I think the hardware should be described in the respective format. Yet, you
> > have a point that it's too verbose to the cases when we know the layout of
> > the attached (not-hotpluggable) devices.
> > 
> > There are discussions [1,2] on how to enable DT for the cases when
> > non-discoverable HW needs to be detected and enumerated.
> > 
> > I don't know which solution will eventually be accepted, but my personal
> > opinion here that we would like to distantiate from board files as much
> > as possible.
> > 
> > Btw, for the internal (board files) code we may also use property to
> > go with (see how spi-pxa2xx uses that) to distinguish configurations.
> > But it might be not that straight as with driver data.
> > 
> > So far, I haven't seen the code (am I mistaken?) which makes use of driver data
> > for software nodes.
> > 
> > [1]: https://lore.kernel.org/lkml/20231128084236.157152-1-wenst@chromium.org/
> > [2]: https://lore.kernel.org/lkml/1692120000-46900-1-git-send-email-lizhi.hou@amd.com/
> > 
> > Aux topics which might not directly be related (in order of declining relevance
> > from my p.o.v.):
> > https://lore.kernel.org/lkml/20231130165700.685764-1-herve.codina@bootlin.com/
> > https://lore.kernel.org/lkml/DM6PR12MB3993D5ECA50B27682AEBE19FCD67A@DM6PR12MB3993.namprd12.prod.outlook.com/
> > https://lore.kernel.org/lkml/20240217010557.2381548-1-sboyd@kernel.org/
> > 
> 
> I work on PCI DT overlay support.
> The idea is to have a PCI driver that loads a DT overlay to describe the
> hardware embedded in the related PCI device. Some features related to this
> topic are already upstream.
> 
> Rob did a presentation of this topic at the Linux Plumber conference last
> year (https://www.youtube.com/watch?v=MVGElnZW7BQ).
> 
> IMHO, your use-case is pretty much the same. Of course it is not a PCI
> device but a SPI device. Even if the device beyond the SPI bus cannot be
> memory mapped, the idea seems pretty much the same: describe the hardware
> embedded in a specific device.
> 
> You mentioned that you need the '-@' option when you compile your base dtb.
> In fact, it depends on the resources you need to reference from your overlay.
> On my case (DT overlay to describe a PCI device), I don't need any references
> to a base dtb from the overlay. I don't need to use the '-@' option.
> Even more, I started (not yet upstream) to use all of this feature on an ACPI
> base system and it works.
> 
> My PCI device is a Microchip LAN9662 PCI device.
> The Microchip LAN9962 can be a "traditional" SoC with CPU cores and several
> IPs but also a PCI device.
> When provided as a PCI device, the internal CPU cores are no more available
> and replaced by a PCI endpoint IP.
> All the accesses done by the SoC CPU cores are replaced by accesses done by
> the host PCI system through the PCI endpoint.
> Drivers were already present upstream (traditional SoC platform driver such
> as i2c mdio, clock, switch, ...) and are used without any modifications for
> the PCI device.
> All the wiring (mapping) between the PCI world and the internal device
> hardware is done using a DT overlay.

Thank you, Herve, for looking into this. As far as I understood, slowly but
successfully the required changes for your use case are being landed. If so,
it makes driver data for software nodes approach even lower priority.

-- 
With Best Regards,
Andy Shevchenko



