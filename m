Return-Path: <linux-kernel+bounces-48031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DC84567B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292B4B24BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07C15DBA1;
	Thu,  1 Feb 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdCfsK5F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CE15D5BD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788181; cv=none; b=Y6RcS3Z08V8U1OtYJjGyPhWxWeNMyqbz8S4nkNa9HffvdlNQrMx930d45rtKTz6ogqfnF0+Sy9MbeZ5vb5Fjls91DHwPk4JOP7Tacx6q+8Nf5pIl6Ap7buneOSyOiT9YDvZFSUx5YWWF1Li64JwHaUbJYO8f12kGGEtzeBHFEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788181; c=relaxed/simple;
	bh=LW71KuuAIUVJWedR4aaeNff0Yio4Rtb4Pgs9MRUCuiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5rQfwJ+OjXmBJ3Jo+A3nzNOI5B8oPsC2AYqoB40RaefOAlJ94eW8j1dussyX85YbakHtj/akN+JiGmp4MNPQsWSvVrFDMSW72b5H1+W+InVRa4ah2+vMjzFvvs7XBM9U8YZ9P0oC7r3N4XkNQPff/fWCjwFOe7Blzw9PwRDNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdCfsK5F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788180; x=1738324180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW71KuuAIUVJWedR4aaeNff0Yio4Rtb4Pgs9MRUCuiw=;
  b=WdCfsK5FmNG9PaRAFTkdniPUQXNxFGXZVZIKTfN4yZIUWP3SyaGwGip8
   qbeidG7+0K59eTpuqt9B7FT6BwRLyH2raNP1ZFSMOCwFORG6Kg3jz20QC
   IGhzYBec9b7nnvOnrjRReHmp6pBk5JV6ed0eJlJgBj2Pe78kqSlAzBgij
   XQIHnJpla6lpVJRFNIW472pXlZTykV20IFo6M7iDbYCX+5vfmKzFFrr3c
   2CikybXQAXHbFqWBm6jzT26LUtqb1sml4G69D9lNwlF6/JBdNecnmjzD+
   fniTIyUPLbIEE0pFj0JBBLGWr1NtJKhK0TxCR63FT87ZtQ1k/rkBOLOSh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3709678"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3709678"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119923610"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119923610"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:49:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVVQ-00000000oza-0W5b;
	Thu, 01 Feb 2024 13:45:20 +0200
Date: Thu, 1 Feb 2024 13:45:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Howard Yen <howardyen@google.com>, hch@lst.de, m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org, petr.tesarik.ext@huawei.com,
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per
 dev
Message-ID: <ZbuETxd_MfFN45C8@smile.fi.intel.com>
References: <20240201093515.849873-1-howardyen@google.com>
 <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 10:45:30AM +0000, Robin Murphy wrote:
> On 2024-02-01 9:35 am, Howard Yen wrote:

..

> >   	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
> >   					     override */
> > +	struct list_head	dma_mem_list;
> 
> I'm not necessarily against the idea, but only if it's implemented sensibly.
> If we're going to have a list of these it should *replace* the existing
> pointer, not do this weird thing with both.

+1 on the comment.

-- 
With Best Regards,
Andy Shevchenko



