Return-Path: <linux-kernel+bounces-98992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D9878203
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33B1F21AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45344371;
	Mon, 11 Mar 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzapdPd8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6243ABC;
	Mon, 11 Mar 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168523; cv=none; b=M/Vp7Jq7g1XqsjsoSZwIYbuj84vp1fc/rShWdkxH2PpSzxlf66FQy8kAxP/2dafXX86J+qh+BAXe2a2KVBEdQP6FqeqrTCM7iNtjLPMJpkmZYEFjv7WT/ZoX21XK96lnD5xRO1RoJAmCERod1DwnvyXSVon3IEHAJBTjmWNbM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168523; c=relaxed/simple;
	bh=QaXQgU7muHqiotjvDVVrFztSpl2LwqcnGS/d6VSbSu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqvbfjqd4J7JSftYjvWSUmxgSvUWCh1eIBwzsAuhTar2xO+fy336UaFuVZzsUGg50IpZVq/Zmp/ttmlL3n0Ay1QVb+Ku1R2XZpSzArUJNPs5+NXtpjLL+6RJ8ZTNRD2TcdXe/jiXl7UvFv6QIXUVW4oPL377HS0K1AhTYrhQ5I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzapdPd8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710168522; x=1741704522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QaXQgU7muHqiotjvDVVrFztSpl2LwqcnGS/d6VSbSu0=;
  b=VzapdPd89g6VslGHU+Jh6PigKQAtvJPfd1H9usrhDg9SFGLsaDazvfgb
   47JMPbtPddEUkyWtRvW80lD1g8MC8MrAE9c5DSSUQ6XvLx2GoiKrGnNBz
   wYMjAMyzopxyASad5ydQF7axYBFQEmILVpsCpV2zsHujBAV9zaPosVEof
   rgZXjNNgzDmb4Lvc1Wmshxmq2leoaIWzXnNZNWXbyqVQYRoCl6+dWPjbH
   qWPNZe36DZdajlxzk9PeaX/z8+UTHF5I5S4ciCyB6uroS7pifcYVrajri
   GPtsIILpFVD4WVdvJNFBXuaFRB5GubDP7gCE8vlzed0KEzzp6ittMkuR4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4688623"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4688623"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914361903"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="914361903"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:48:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjgwu-0000000Bedm-0Iat;
	Mon, 11 Mar 2024 16:48:20 +0200
Date: Mon, 11 Mar 2024 16:48:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: rc: gpio-ir-recv: Remove unused of_gpio.h
Message-ID: <Ze8Zs1VA3G8BpxCb@smile.fi.intel.com>
References: <20240304180510.1201042-1-andriy.shevchenko@linux.intel.com>
 <Ze8Ubb5YQ4DzNHTt@smile.fi.intel.com>
 <Ze8WvTnlay4mDhgi@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze8WvTnlay4mDhgi@gofer.mess.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 02:35:41PM +0000, Sean Young wrote:
> On Mon, Mar 11, 2024 at 04:25:49PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 04, 2024 at 08:05:10PM +0200, Andy Shevchenko wrote:
> > > of_gpio.h is deprecated and subject to remove.
> > > The driver doesn't use it, simply remove the unused header.
> > 
> > Sean, are you okay with this change?
> 
> Looks great, I've applied it my branch.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



