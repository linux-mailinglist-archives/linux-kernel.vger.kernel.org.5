Return-Path: <linux-kernel+bounces-108794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F088100F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7FF282D93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3447B335C7;
	Wed, 20 Mar 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eN6GOwGn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2329B20DCC;
	Wed, 20 Mar 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931180; cv=none; b=aGgxQzdA7UDVvbN3TdrpJ2Y7t0juvJqQpyS19biE8EnSCiueDUTLWASv6JnmH6UikqvYKmX0bZd5q8HziOD3Nx5/rSUGkusDZkfJwpSopIRojLCFoDkJHcTfrzcdejTOsDidFMgvn4F4HTkLDdJQ6dUG+Pq01LIgN2eeCrvk/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931180; c=relaxed/simple;
	bh=NXyshRl6EibK8Fv9ThYhsEZH4LzWv/DjUpaMXHd7ofA=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8KWu1ariZFtOWeb0M1Aw8LvMqy46zUMUFSxXSCUZyeRIWmmv4s6l4Y+axHJlcuy9sQRHFXLJJaw77gJ2bFiC3o3LalAVmgvUfcyAm7Qi+ok0nh59kE3CIp+bbnnNnGPBZKNcF7gY82rJNK38R7eIdheum8jMU4fnkdFCpDSwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eN6GOwGn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710931179; x=1742467179;
  h=date:from:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=NXyshRl6EibK8Fv9ThYhsEZH4LzWv/DjUpaMXHd7ofA=;
  b=eN6GOwGnZJ+7ccX7zWvCBTdyRLeh3jAkhkuZrcKoWcSpdTMsTHuDSGqc
   ezcDyoOR7o3G19zut3EDESalWrmQ/sSZSXEDlU4qXcdUmf+sDVAYxETAC
   NGtstZd2yKMU4xNRX1ETNXbBtk8CnAMJRc5I9W4Y94nc35Nz4qXgdlVis
   VBmOxfTccRzQLuFcsCk/jB2GyInBfFvQ5YWFRDyAMzluTdCHUpNWaTFob
   iBv9vlnTQQSy89rkYWhsFkgUw26CWzBsnQqtw9IjKsCLaazvvgPrNK4We
   zKp656cG7qzoTTOX0hM3nKeO2szlGx12HnFyVrJlvzI+CiK9zBFPYAby2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23304768"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="23304768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662247"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="914662247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:39:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtM5-0000000EXk2-2icX;
	Wed, 20 Mar 2024 12:39:33 +0200
Date: Wed, 20 Mar 2024 12:39:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: Implement device_get_match_data fwnode
 callback
Message-ID: <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Vladimir

On Tue, Mar 19, 2024 at 07:42:22AM +0800, Sui Jingfeng wrote:
> This makes it possible to support (and/or test) a few drivers that
> originates from DT World on the x86-64 platform. Originally, those
> drivers using the of_device_get_match_data() function to get match
> data. For example, drivers/gpu/drm/bridge/simple-bridge.c and
> drivers/gpu/drm/bridge/display-connector.c. Those drivers works very
> well in the DT world, however, there is no counterpart to
> of_device_get_match_data() when porting them to the x86 platform,
> because x86 CPUs lack DT support.

This is not true.

First of all, there is counter part that called device_get_match_data().
Second, there *is* DT support for the _selected_ x86 based platforms.

> By replacing it with device_get_match_data() and creating a software
> graph that mimics the OF graph, everything else works fine, except that
> there isn't an out-of-box replacement for the of_device_get_match_data()
> function. Because the software node backend of the fwnode framework lacks
> an implementation for the device_get_match_data callback.

device_get_match_data

> Implement device_get_match_data fwnode callback fwnode callback to fill

device_get_match_data

> this gap. Device drivers or platform setup codes are expected to provide
> a "compatible" string property. The value of this string property is used
> to match against the compatible entries in the of_device_id table. Which
> is consistent with the original usage style.

Why do you need to implement the graph in the board file?

..

Have you seen this discussion?
https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/

-- 
With Best Regards,
Andy Shevchenko



