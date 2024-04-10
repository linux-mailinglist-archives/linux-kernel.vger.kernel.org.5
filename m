Return-Path: <linux-kernel+bounces-137913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7689E978
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EB01F23C24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3811170D;
	Wed, 10 Apr 2024 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ajd4XDUW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8198F44;
	Wed, 10 Apr 2024 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725857; cv=none; b=JYtclgxOQp1QzkUlV+g3xCziSi0CvSgtDxAL8DyUzcWaVJh70dYXbh0W4mt7UYsg73Q6XCxS0toMt0iplSDgDmdTPP36VsbJmN6kn9r86qPEv21NFkT8/8kW3U+tlzeY9MV0pP/a67nreoT0NEti0d3k7/2BT3DpzviNIwwOZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725857; c=relaxed/simple;
	bh=Ev66Q3yLfKaQHYAO5YNQ46lKeOiioLbkndZx5BAZRRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZY6C+j92b+Gt1zCyCuBIg2Fqv7evKEpMsQUz3wiQqkI/qRJYQWh2TRKcoHGdwQr2tT4VHGcES5zDi7CnG01menV1/EzWeIZd+1D2JOrjpGWGT7wAItnkDQnBJ2+cjvxsvFg4esw/7NGk2e7WFAQTkz/LyHMxkPWmU6T3OuqiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ajd4XDUW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712725856; x=1744261856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ev66Q3yLfKaQHYAO5YNQ46lKeOiioLbkndZx5BAZRRQ=;
  b=Ajd4XDUWQbxUnLiI3YutJXJoRHRAGJuKYcebrKiW0REbZbljasx5RbQT
   Sxxh4vrPtjRw8Hbk8JyldWeI+Gb0gl+tQT2M2uwxF4zko+/5tvcCEp+wK
   8SnS45haZVesKMoXFoUPz6J23UHLEWDKfFSoCgqdGG+0On7ettPrROsDO
   hdMnyya38+aVqWIg33wLTKUbf9jserXyyYRQnK92/7lR+Mrns6n3ATHDa
   ZW61L3QSxaUBKU6ApSOBR7WOhbpfz64+T8loE2t3A7CJNn5RipGmn5F3A
   hj4tHQchViYPuf4VJSBG2Li93wirPcmNk0I4PQzq+aYHSwnoQYLzEjqY/
   Q==;
X-CSE-ConnectionGUID: Jy0MYAgVSnGy9jRgU9tc7w==
X-CSE-MsgGUID: r4tTlUwMRSaSmPH+J+yMUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11909951"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11909951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:10:55 -0700
X-CSE-ConnectionGUID: JhtbbJM5Q8Wuqpfs+SP14A==
X-CSE-MsgGUID: kUWyeqd3SU6MCCUMZY10rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43692927"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2024 22:10:52 -0700
Date: Wed, 10 Apr 2024 13:05:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: lkp <lkp@intel.com>,
	"enno.luebbers@intel.com" <enno.luebbers@intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"luwei.kang@intel.com" <luwei.kang@intel.com>,
	"Wu, Hao" <hao.wu@intel.com>, "atull@kernel.org" <atull@kernel.org>,
	"shiva.rao@intel.com" <shiva.rao@intel.com>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Rix, Tom" <trix@redhat.com>, "Pagani, Marco" <marpagan@redhat.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] fpga: dfl: fme: revise kernel-doc comments for some
 functions
Message-ID: <ZhYeLvVJ49Bq1QCu@yilunxu-OptiPlex-7050>
References: <20240402204743.1069624-1-peter.colberg@intel.com>
 <ZhS4fuijYnstZ6Rt@yilunxu-OptiPlex-7050>
 <5106eb7c65599eca583f146bd18a5fd1836e9600.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5106eb7c65599eca583f146bd18a5fd1836e9600.camel@intel.com>

On Tue, Apr 09, 2024 at 06:30:45PM +0000, Colberg, Peter wrote:
> On Tue, 2024-04-09 at 11:39 +0800, Xu Yilun wrote:
> > On Tue, Apr 02, 2024 at 04:47:43PM -0400, Peter Colberg wrote:
> > > From: Xu Yilun <yilun.xu@intel.com>
> > > 
> > > This amends commit 782d8e61b5d6 ("fpga: dfl: kernel-doc corrections"),
> > > which separately addressed the kernel-doc warnings below. Add a more
> > > precise description of the feature argument to dfl_fme_create_mgr(),
> > > and also use plural in the description of dfl_fme_destroy_bridges().
> > > 
> > > lkp reported 2 build warnings:
> > > 
> > >    drivers/fpga/dfl/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'
> > > 
> > > > > drivers/fpga/dfl/dfl-fme-pr.c:280: warning: expecting prototype for
> > > > > dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges()
> > > > > instead
> > 
> > Why still list the 2 warnings here? Do they still exsit even with commit
> > 782d8e61b5d6 ("fpga: dfl: kernel-doc corrections") ?
> > 
> > > 
> > > Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
> > 
> > You are still trying to fix this commit?
> 
> I included the commit message from your original patch in full to show
> the initial motivation for the patch. As described, the issue has been

The out-of-date initial motivation, the commit 782d8e61b5d6, the listed
logs are not related to your change. It shouldn't appear in this patch.

Remember the commit message goes into git if the patch is merged. People
get confused about these information.

> addressed already; your patch merely polishes the the doc strings.

When you decide to submit a patch public, it is *YOUR* patch. You should
not list all the history and expect the original author decides what to
do.

> 
> > I'm sorry, but please do check and test your patches before submit.
> > Re-submitting quickly but full of errors makes people doubt if you are
> > really serious about your patches. At least, I do have doubt if you did
> > tests for all your patches, or if your test could sufficiently prove the
> > issue exists or fixed.
> 
> Apologies for sending the v1 patch, which had been rebased incorrectly.

This is not about the v1 patch, every new comer makes mistake. I just
don't like that you sent patches too quickly but didn't address the
previous concern.

Thanks,
Yilun

