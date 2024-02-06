Return-Path: <linux-kernel+bounces-55266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8484B9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720FF1C24B83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DDA133996;
	Tue,  6 Feb 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M9qQ5/y4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E413341F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234201; cv=none; b=nTCUqvcWHMofeV0FtYaOMX79oGIxmucR85odPsiOcYMHDAURo2QWx115bPW/oIyzI+KQ0dvKfT9d43SCyZBxm+u2J2XBmiDIIgj0aaMvTFqkm+FoXGOxLi1GGa8Q/KWB+HMcPA/Ra8ut3J/R9OoblE+6vDhpSxjxZgJ0fC44RKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234201; c=relaxed/simple;
	bh=9fIinZxSvn4YC+YvnnE0vky1r5Ak+JQQc6a7PntCvFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjU+OBhyyZLlKBThKn8YC3LS+eRlK9Jvos4lNwTtapOt5/WcIiSLunwGHu5MzH1yfFY5cCeLFMgsnvMOFB4AZnXhHZGqm2k7fb+Wooo4NCTxXMDQ9boOVRFRASbD3CFaLLHvOJpFJ6zyo5GH/uvuz4csdJwP2ziLCHKUIdo7+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M9qQ5/y4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707234200; x=1738770200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9fIinZxSvn4YC+YvnnE0vky1r5Ak+JQQc6a7PntCvFM=;
  b=M9qQ5/y4NsHw8okcHNrDYpJucnVjzvUF4CQWyve/lyLiX+UZohOyiWxS
   pYk1CNh2EC1xiy6+a6AYkBNWdDxT9xwhsOv2dD1rrPCC5+BnnlZm9k/El
   OT8WgGzYqdva3Eesv1msmhww4Pf++v2aijBNLCWF9h4Uca+e2VPBfJnPD
   g5MRreoENPGGzTMATJlNShoAaL/kcq61f11A+uY6ug0AXtvTyaBWSSnQV
   UWgF5IuFWFZJcrbccxDt1TF93/xp0+2bywgauK2KYGLdQ31P6E5cYbz5V
   dlgRgjVP9Ptr11Fb9bMh9rAyaZ4cAERJ1Wp5H6RHLElDjoOssGB+k5I3Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="660859"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="660859"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909670418"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909670418"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:43:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXNbN-00000002NUO-332q;
	Tue, 06 Feb 2024 17:43:13 +0200
Date: Tue, 6 Feb 2024 17:43:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
References: <20240205072312.2342188-1-howardyen@google.com>
 <ZcDPn5eLvMwpb7N1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcDPn5eLvMwpb7N1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 02:08:00PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:

..

> > @@ -18,15 +18,9 @@ struct dma_coherent_mem {
> >  	unsigned long	*bitmap;
> >  	spinlock_t	spinlock;
> >  	bool		use_dev_dma_pfn_offset;
> > +	struct list_head	node;
> 
> Have you run `pahole`? Here I see wasted bytes for nothing.

On top of that one may make container_of() to be no-op, by placing this member
to be the first one. But, double check this with bloat-o-meter (that it indeed
does better code generation) and on the other hand check if the current first
member is not performance critical and having additional pointer arithmetics is
okay.

> >  };


-- 
With Best Regards,
Andy Shevchenko



