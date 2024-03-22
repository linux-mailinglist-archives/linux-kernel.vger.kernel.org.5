Return-Path: <linux-kernel+bounces-111767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56E8870AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF371F247A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541959147;
	Fri, 22 Mar 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcnBUbjn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B4482CF;
	Fri, 22 Mar 2024 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124095; cv=none; b=L9DKTdeGUHhZnoaWQx1uNWK90MrmCtTADORh5mOLcvxdCu46LBjMMwapUfSaNPefirLb4bNazwEfUwKyrJ5CwYFnDUye2etwErs2ah1t/zdMc+joZWijAVwDyEtYwCc+9b7cxnOUzLnCwgxbk17szo+hnIQMDRhTQOobCXUnThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124095; c=relaxed/simple;
	bh=9clx4xMKo6TTUmWWEwbubFYNBTdT7l8M7ma/medzlo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCnbcfYx4QPA0oWNDgL3NoHvDPspH/vQB9fuEYVCkuvVD/dGz34E6J4jb47NDHEaoi/6qvQlOqZybKBYYcFjTJ/ONedheJt9V0bCvkl2fjifFuh7/QKJAd4+nem182tzFk42pBlh8oJaAYuPRdgSWt0qvdr343+VMRxJJa9oY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcnBUbjn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711124094; x=1742660094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9clx4xMKo6TTUmWWEwbubFYNBTdT7l8M7ma/medzlo8=;
  b=CcnBUbjn72n75OJ16B4lusVmLNfbn1z3u4rDNFrgiKQC+eeQXHCpHLIX
   bN7nD0EsQSDcT6AJ19aGqFOfCvwhBDKbG0vQiYoRzaDfGgRqPQ7EfgF1k
   ribsjgMdWUBb0J8akDxUxUJwhlwwD7AKXDZWM4/v9E6anAsxOBHGa35FV
   RCwNOV00FMKj/p8Vqq6n8tfjmkf6gomI6gAvMfngdeP6V6CvURMT4Ku3c
   AmIZJEReSOrKPlNIg+afjeouIX27SRgH2lB8LjMVh2/foSJfw7fpPfyjD
   HWrFgQn6oisEDbSS+aqe5ARxgDHyPoFnW/nBUXYzN2UQmiHgi9hoxWgLK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6080429"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6080429"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:14:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="914748094"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="914748094"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:14:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rnhX1-0000000FCWi-3ZGk;
	Fri, 22 Mar 2024 18:14:11 +0200
Date: Fri, 22 Mar 2024 18:14:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <Zf2uUwcMgIpo6rVh@smile.fi.intel.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
 <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
 <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 22, 2024 at 05:00:05PM +0800, Sui Jingfeng wrote:
> On 2024/3/21 04:28, Andy Shevchenko wrote:

..

> > > > > By replacing it with device_get_match_data() and creating a software
> > > > > graph that mimics the OF graph, everything else works fine, except that
> > > > > there isn't an out-of-box replacement for the of_device_get_match_data()
> > > > > function. Because the software node backend of the fwnode framework lacks
> > > > > an implementation for the device_get_match_data callback.
> > > > .device_get_match_data
> > > > 
> > > > > Implement device_get_match_data fwnode callback fwnode callback to fill
> > > > .device_get_match_data
> > > OK, thanks a lot.
> > > 
> > > > > this gap. Device drivers or platform setup codes are expected to provide
> > > > > a "compatible" string property. The value of this string property is used
> > > > > to match against the compatible entries in the of_device_id table. Which
> > > > > is consistent with the original usage style.
> > > > Why do you need to implement the graph in the board file?
> > > It can be inside the chip, there is no clear cut.\
> > Which chip? Flash memory / ROM or you meant something like FPGA here?
> > For the latter there is another discussion on how to use DT overlays
> > in ACPI-enabled environments for the FPGA configurations.
> 
> There are some hardware resource or software entity is created on the
> driver runtime. But DT or DT overlays are compiled before device driver
> get loaded. GPIO-emulated-I2C is just an example, this is kind of driver
> level knowledge on the runtime. With the GPIO or programmable some
> hardware IP unit, device driver authors can change the connection relationship
> at their will at the runtime. While with DT, every thing has to be sure
> before the compile time.
> 
> DT overlays can be a alternative solution, but this doesn't conflict with
> this patch. This patch won't assume how device drives go to use it, and
> allow device driver creating device instead enumerating by DT. In one
> word: "flexibility".

Software nodes in general for the device driver / platform quirks.
They are not designed for what you are talking about here.

Consider using SSDT / DT overlays instead.

-- 
With Best Regards,
Andy Shevchenko



