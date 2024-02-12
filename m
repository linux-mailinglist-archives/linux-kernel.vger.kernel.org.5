Return-Path: <linux-kernel+bounces-62001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877048519E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446A628414A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D1F3D38D;
	Mon, 12 Feb 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAs2AQsD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466643C699
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756175; cv=none; b=lKZNvhR073+oiX7F2PRsqtT8i4cgjHGXmiVdbcQeNaarp9rtaT9yWo4n3Y9pBsLtJKLOpoOIgDc3kLSUqVQYhHTCfEcLfqk7O+42StFkSZZ5e/7Teqcg3CsaBAUa8vzuypsjTv3Bm5oHqTUiiGHH7jn8FqgxPpuuYSv17+zFVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756175; c=relaxed/simple;
	bh=skewU5rkJStvOlhKIZ1HeGr5vTl2dNfvJDizEvtwRnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHSrn/QbpAJdZZZjGC2QF/t/liLE+t26enREL7+4+ZOtX5OVQl5tIn4JKhwLqKxJdJ6J/aUTYSRnUJYL6g1p6NNZt8Hxg0td8nuoyB8y1qbmCZvEc3YnPt5gIr78qY72YVJJW2492WxkyF97m26HDOxw2ZAjk9oUCDHayZCFz7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAs2AQsD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707756173; x=1739292173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=skewU5rkJStvOlhKIZ1HeGr5vTl2dNfvJDizEvtwRnM=;
  b=GAs2AQsDKBAJziv6MmHq+Q0ekTql4BaFnmzQ52SuInGmfFSB9CDj/kPR
   GBSyBbxyVzDvPjQ81h9ykobmNAoMxlnGrjA/UmTcv3t6zypC/NcRwAAeh
   1UeAG8UMofdDtsR0Awwn32PQwdYncy84m9yUn5czElspwdoptLFgk2eAD
   lvMmGy/k+qd7+7zI8qNVAuyi/jJXCL2cl1FXvyIidk3B4MfWwMq1gZume
   ifWhMdkZ6qhAhFlM07u+8XmiYelgcFNCNxwiOwlXBXH+jhhvj7QT3EyL5
   hV2bhz/JMGRF2/GmhMlIBRn7CyZsvSzNZcQQmddJFda69gB4VO2w/mZwT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19246321"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19246321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:42:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911538408"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911538408"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:42:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZZOK-00000003x0V-16Xn;
	Mon, 12 Feb 2024 18:42:48 +0200
Date: Mon, 12 Feb 2024 18:42:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 05:33:39PM +0100, Thomas Zimmermann wrote:
> (cc'ing Javier Martinez Canillas)
> 
> Hi
> 
> Am 12.02.24 um 14:23 schrieb Andy Shevchenko:
> > I have no time for this, but since it looks like I'm the main
> > contributor for the last few years to the subsystem, I'll take
> > it for now. Geert agreed to help me with as a designated reviwer.
> > Let's see how it will go...
> 
> A few days ago, I talked to Javier about how auxdisplay is a hotchpodge of
> various drivers that seem to belong into other subsystems. Could we attempt
> to move all drivers into other places and then remove the auxdisplay
> subsystem?

Can you be more precise on how it can be done? We have at least two clusters of
the displays: line-display and HD44780-based ones. Moreover, the latter might
use the former in the future (in some cases).

-- 
With Best Regards,
Andy Shevchenko



