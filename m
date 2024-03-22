Return-Path: <linux-kernel+bounces-111926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A58872D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23361C227BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00024633EC;
	Fri, 22 Mar 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axSqTKNk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB363137;
	Fri, 22 Mar 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131407; cv=none; b=bEYyYRYGZ3gjm/zAif5Jq9Qi51xTaHIDiAMRbUonv91J7y9kn0vW0Ufu0QgmX4M9a+37354vI3Se2U97neA6aqt9AINzXQj3fx+g3O40ke++Rh+0p7P9FiwwfDaJ+EXGgPZwS9sIctYRO7Vus4HxASgDu2vRzWuldaaL2HSFVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131407; c=relaxed/simple;
	bh=CSb/2Xd0kjyrzXVz+VuBtqsWEMSEE9CK8ZtmpNce0Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkwSFl9fTlBbt1FGDZC/nRtD6IlIYTdBNzHszXuah7tJK0vdGrz408pZuqibHPn/E4SN+CRrXYD0cjIJEl4LgMo1Nda5ilg6U0aK/Xjctb2y7JjvrZ8nkv0Hu8DdKw/Ctao5sg6aQoEM1jy60a2leeGZtA3zoy53yaC9HjX8DcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axSqTKNk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711131406; x=1742667406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CSb/2Xd0kjyrzXVz+VuBtqsWEMSEE9CK8ZtmpNce0Hw=;
  b=axSqTKNkTnEVbovQV5wPy2pEYWljKjAVmd1nu4G+XVERUIL9KwuuMXIw
   UWcio8egxcmzvTO5JuYxx6rLWEsOTjkjHXzoEDo4rpsQaGeBo2WYQ+VlC
   kwSprKDIeAj9pklpZDD3oBiwIrrEUqKsgr71lLchnG68JSLzuOpVLYGJK
   WZ+HkuLM+YrR3JOFe+ws2ysdqKxj6sq7Wr4AjK+5lCBQJnuyDrwOqi5YI
   hztT38hmECrTpLcl0DRFSzMID4JeYWEsWnA4iQe/n+BK1lWQIGto7P/vr
   pF9TVrZK75fjbCeueOUxcs1xJ99FWuwG7mxm+RyKTYg5yjA50vxfXOLSO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28671897"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28671897"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 11:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="914750928"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="914750928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 11:16:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rnjRW-0000000FEYM-2S1Q;
	Fri, 22 Mar 2024 20:16:38 +0200
Date: Fri, 22 Mar 2024 20:16:38 +0200
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
Message-ID: <Zf3LBvJEJF9xr2fv@smile.fi.intel.com>
References: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
 <Zfq85f-Dp1S3CKuG@smile.fi.intel.com>
 <9ced20e0-dfbd-4337-b5df-223b7baffd9e@linux.dev>
 <ZftG6Q5AaG71dhWq@smile.fi.intel.com>
 <9644da91-f367-4083-a3e4-4d0677c8cbca@linux.dev>
 <Zf2uUwcMgIpo6rVh@smile.fi.intel.com>
 <6bf102a4-6419-4083-8918-4f7c76cfa9a1@linux.dev>
 <Zf3IWyrW8IZLTg4x@smile.fi.intel.com>
 <8afe3f27-fc8e-4c20-ba28-74a0a2937e55@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afe3f27-fc8e-4c20-ba28-74a0a2937e55@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 23, 2024 at 02:12:14AM +0800, Sui Jingfeng wrote:
> On 2024/3/23 02:05, Andy Shevchenko wrote:
> >   Besides that, the kernel project rule is "we do not add
> > the dead (unused) code".
> 
> This rule is good an correct and I admit.
> 
> But the problem is that it is chicken-and-egg problem,
> it probably have at least two user now.

Then show them! Convert in the same series and show that.

> it's possible that it will gain more users in the future.
> 
> But if you reject everybody from now, then it is zero.

As a no-user patch, yes, I reject this.

-- 
With Best Regards,
Andy Shevchenko



