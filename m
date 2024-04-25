Return-Path: <linux-kernel+bounces-158621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B048B2323
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672A61C21649
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D9149DE3;
	Thu, 25 Apr 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBeNTQ2N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7212BE8C;
	Thu, 25 Apr 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052956; cv=none; b=ueq/eLwH47+lmJzS5reHilaNbY1YDEO74EJs/xP01/WOjUsP4Fca79sbdp6W2+JBaSeyjGjq66Eef8L4Cz+Mer8/52yCF6+e2EztxieUzsoQPVc9O0F3DefzhoCFf3S7pkdqQy7ET7HMBh8CW1WlyZiogawfU2p15TsGY4AeWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052956; c=relaxed/simple;
	bh=UABaLNDUohCl0645e4BmsPLeNTsTr5PF33yT0Dxpmv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J02WhJf3Rcioxbikn/FXc1s6y3o8dkkqcOug6O8MYAk6vHcYUSnhfE0AZyfiaa7mprh3XSnM8kYGIJvPUwYYg1geXnDvlmAvCtENCBVTKxqeSgLAzN/9YtYkaVmkqg86n+J2V3cz7zmK9lUogsbFR4b2yIJnrrh0kwSl0aZJsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBeNTQ2N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714052954; x=1745588954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UABaLNDUohCl0645e4BmsPLeNTsTr5PF33yT0Dxpmv4=;
  b=TBeNTQ2NoY4ldsXfcZP4uPVFv6fHLxisohYXMS7483LtYmMsxx30/bRx
   lAAELsOwA0KA0pWMh+44DZTlkSmAKWTicszmzjfACAWmbumrANGDwIlbL
   BGDp3xPtAPRUPLdjz4/RkkUsKpl7Aelo4ykGXEEi0QzAXZGSCVyk+FOCW
   eDUGsDvqFXGnE0YxHuMEIXHFreOCGNhjlaeTlRKvR0Wi48MX2lGbR2YWo
   vOIUC3WYicTHJ5P3DlTMwO7FPMU2NdddAip/4XhNbCQcQ0DnT2vzZL67B
   Z7mwu+Hd1oq0fLgf44r33AxgKgI5WJ42tQRNwdtwCQNkKYa/bzn9IQrjo
   A==;
X-CSE-ConnectionGUID: KXbpwhvXSj6F/ypU38mOdw==
X-CSE-MsgGUID: ZflvdNCOQWGaV/CrztfM3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="12677354"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="12677354"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 06:49:13 -0700
X-CSE-ConnectionGUID: HdfkPoJMRjC8j34JKqhd+A==
X-CSE-MsgGUID: OnWENRT+Q26p2Cz5NM4pgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="25061843"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 06:49:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzzTH-000000010uZ-42lL;
	Thu, 25 Apr 2024 16:49:07 +0300
Date: Thu, 25 Apr 2024 16:49:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <ZipfU50mWIuRQpzy@smile.fi.intel.com>
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com>
 <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <ZikE4qOVO7rgIs9a@smile.fi.intel.com>
 <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
 <Zikck2FJb4-PgXX0@smile.fi.intel.com>
 <kucey3jsydjye3ndflns3cqolcpizhnxgzz3fkmcatlnpbnwrk@22ulsqfh2vf6>
 <Zik3AjiWkytSVn-1@smile.fi.intel.com>
 <c81f770b-5fe4-4212-bfce-fedb3fced94e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c81f770b-5fe4-4212-bfce-fedb3fced94e@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 25, 2024 at 09:42:53PM +0800, Sui Jingfeng wrote:
> On 2024/4/25 00:44, Andy Shevchenko wrote:
> > On Wed, Apr 24, 2024 at 07:34:54PM +0300, Dmitry Baryshkov wrote:
> > > On Wed, Apr 24, 2024 at 05:52:03PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 24, 2024 at 04:34:39PM +0300, Dmitry Baryshkov wrote:
> > > > > On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
> > > > > > > On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> > > > > > > > On 2024/4/23 21:28, Andy Shevchenko wrote:
> > > > > > > > > On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrote:

..

> > > > > > > But let me throw an argument why this patch (or something similar) looks
> > > > > > > to be necessary.
> > > > > > > 
> > > > > > > Both on DT and non-DT systems the kernel allows using the non-OF based
> > > > > > > matching. For the platform devices there is platform_device_id-based
> > > > > > > matching.
> > > > > > > 
> > > > > > > Currently handling the data coming from such device_ids requires using
> > > > > > > special bits of code, e.g. platform_get_device_id(pdev)->driver_data to
> > > > > > > get the data from the platform_device_id. Having such codepaths goes
> > > > > > > against the goal of unifying DT and non-DT paths via generic property /
> > > > > > > fwnode code.
> > > > > > > 
> > > > > > > As such, I support Sui's idea of being able to use device_get_match_data
> > > > > > > for non-DT, non-ACPI platform devices.
> > > > > > I'm not sure I buy this. We have a special helpers based on the bus type to
> > > > > > combine device_get_match_data() with the respective ID table crawling, see
> > > > > > the SPI and I²C cases as the examples.
> > > > > I was thinking that we might be able to deprecate these helpers and
> > > > > always use device_get_match_data().
> > > > True, but that is orthogonal to swnode match_data support, right?
> > > > There even was (still is?) a patch series to do something like a new
> > > > member to struct device_driver (? don't remember) to achieve that.
> > > Maybe the scenario was not properly described in the commit message, or
> > > maybe I missed something. The usecase that I understood from the commit
> > > message was to use instatiated i2c / spi devices, which means
> > > i2c_device_id / spi_device_id. The commit message should describe why
> > > the usecase requires using 'compatible' property and swnode. Ideally it
> > > should describe how these devices are instantiated at the first place.
> > Yep. I also do not clearly understand the use case and why we need to have
> > a board file, because the swnodes all are about board files that we must not
> > use for the new platforms.
> 
> Would you like to tell us what's the 'board file'?
> 
> I am asking because I can not understand those two words at all.
> I'm really don't know what's the meanings of 'board file'.

Hmm... This is very well established term meaning the hard coded platform
description (you may consider that as "device tree" written in C inside
the Linux kernel). There are plenty of legacy platforms still exist in
the Linux kernel source tree, you may find examples, like (first comes
to mind) arch/arm/mach-pxa/spitz.c.

> Do you means that board file is something like the dts, or
> somethings describe the stuff on the motherboard but outside
> the CPU?
> 
> Does the hardware IP core belong to the "board file"?
> 
> Can we using more concrete vocabulary instead of the vague
> vocabulary to communicate?

Most of (I though 100% before this message) the Linux kernel developers
_know_ this term, sorry that you maybe young enough :-)

-- 
With Best Regards,
Andy Shevchenko



