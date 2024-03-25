Return-Path: <linux-kernel+bounces-117165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22488A833
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D465341B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C4132818;
	Mon, 25 Mar 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blHrDxOm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35412F36E;
	Mon, 25 Mar 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374112; cv=none; b=HnyfMmEr89LyTardrsdW0WXVk7q3pyGxEJhAWjgtKVEfJt6KHxfOiNmnMy5DAkaUrcCzPL4dclm8YLOxGpnOyz2zVSzEZ+toaTyPShFmSlGf+AwToliynlMYzgcl5eJlStc9XKMENnGrdE6xUzBJ+2HnCAQYeNcreqlxuXE57v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374112; c=relaxed/simple;
	bh=Q50oreO5/tOU0HVDRwYJo9YrBA4CBym6hJeFokjz93U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0vZsjEX/8jfp5zMLPaI7M1BsMKnaNlqQ5G2QFvxRb6Zp7FM1k7plR1maf4Ro+3xI8RFkf4veiClREEDz76US54OlitBXkYriXsR0y0fZSRy+frKNXPzCaH1ANhJNYYbo44ThsdipyXTV8eOdyuIA1H1AwHlDT/AfkSPoMs4368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blHrDxOm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711374111; x=1742910111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q50oreO5/tOU0HVDRwYJo9YrBA4CBym6hJeFokjz93U=;
  b=blHrDxOmuj7R6Jmwjyow/fFjGstrbF9hb0BSlhNnlmKK2JpmYoE75j4W
   f2p5etpnpJhoLj74VV9ShjZLvLehbw42XUgkSoeGZSFeTa30XrFn4b91Y
   +LoY/NNcHFi/pj/cpM6VxpE1mLhpJKNmn4H2jz0G56J9/YqOlDuFdyXKa
   Qq9yK/5kH0/gY5tUmMMT28ytCxxz11kovVr4juOAsQ/5Ftll/5cOZ3e8o
   potsKrd4ALdoSFRvBWyLWA3v/GZQlTpNFOZOVREYqV7AQLDca/D+5fH2j
   AmN8nt+ojF+j7UHOT0cyTAe1L/JEid0mtLqjWHkjVfBioC3+eWW/SgMYr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="23860694"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="23860694"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914843837"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914843837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:41:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1roka9-0000000FzrR-3avd;
	Mon, 25 Mar 2024 15:41:45 +0200
Date: Mon, 25 Mar 2024 15:41:45 +0200
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
Message-ID: <ZgF_GRPHcdiDyxvX@smile.fi.intel.com>
References: <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
 <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
 <Zf2uUwcMgIpo6rVh@smile.fi.intel.com>
 <6bf102a4-6419-4083-8918-4f7c76cfa9a1@linux.dev>
 <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
 <8afe3f27-fc8e-4c20-ba28-74a0a2937e55@linux.dev>
 <Zf3LBvJEJF9xr2fv@smile.fi.intel.com>
 <839a7448-b958-402e-862a-fc3f7d86e797@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839a7448-b958-402e-862a-fc3f7d86e797@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 23, 2024 at 02:30:08AM +0800, Sui Jingfeng wrote:
> On 2024/3/23 02:16, Andy Shevchenko wrote:
> > On Sat, Mar 23, 2024 at 02:12:14AM +0800, Sui Jingfeng wrote:
> > > On 2024/3/23 02:05, Andy Shevchenko wrote:
> > > >    Besides that, the kernel project rule is "we do not add
> > > > the dead (unused) code".
> > > This rule is good an correct and I admit.
> > > 
> > > But the problem is that it is chicken-and-egg problem,
> > > it probably have at least two user now.
> > Then show them! Convert in the same series and show that.
> 
> I believe that Vladimir has show enough to you. I have read that thread,
> I think Vladimit have explained very well.

Let's continue there. I replied there just now.

-- 
With Best Regards,
Andy Shevchenko



