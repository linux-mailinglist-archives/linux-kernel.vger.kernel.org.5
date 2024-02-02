Return-Path: <linux-kernel+bounces-50017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C284730F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E160C1F2C0AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454BF1468EE;
	Fri,  2 Feb 2024 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRKhDbVF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2A145B07
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887314; cv=none; b=hQbUeKMTEE3UsYp1Dw2M4XjNYmH+3rfxeFX72cnK/yvrmbUwYwxq3Ewpfm+djZrGAqr6LD+6o7VZ7E4051RVv+JLtsNCzuPXXYN9tf5BjDymjraKb+sgG+0MvtE6PKKxGDE7N+uMZ0VH/6Yq5JfYXEjigiDb89dg2ZNfQ8jD3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887314; c=relaxed/simple;
	bh=OHzDeyprsO4Ikj8LZKs0XiL2LcvBfyP0eAmz3bYx7Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRzvdc6ZmwlxIS2Gu54uJTB5lKIF8MV1DlGqp/KKvE2UYmPrJjS/BnnYoPgeuzrlac80/a0GEzcI52vp5gG48yU0Ik/th4fcYWNs/6IGv0eFOSmjVG5BdV7/f6Q9FgKljQzGWJiA/ZxAOvOda016ehQpWl+yssXb+q9sucop6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRKhDbVF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706887313; x=1738423313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OHzDeyprsO4Ikj8LZKs0XiL2LcvBfyP0eAmz3bYx7Ms=;
  b=aRKhDbVFOjh5hgJ8KzW3bUwi5N+nbNJlumbjAP06qjoSdSjO8Rqyj1x+
   DZjmD9b4Ssoy+2iSywp5dm8RduXmCq2cNBrRkh/RYhoJWMt9gzd1lyABt
   6eWTeqHhVLsJ14YkKuQVU3wysId9rdCJ0Om3yjFeNr6hrYfnfVOp2bW7b
   zT2ODv+qu+XXh6gwcGEC80Vtz/Mz8VJ/AgO5YAq+fk5jw0RiQXDkpSn5D
   kPLGuvBXLaugWG0yBH6rako2c5zI7qb/I2nHTo9+k5cqrTad4gkUZXubi
   4XBJbK1CBq1ZwscxEtC2xJNV1FzowebjWGWa2912swE08wseILdJNUkGj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="403355"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="403355"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="908599841"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="908599841"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:21:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVvAN-00000001IhH-1eWB;
	Fri, 02 Feb 2024 17:09:19 +0200
Date: Fri, 2 Feb 2024 17:09:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Robin Murphy <robin.murphy@arm.com>, hch@lst.de,
	m.szyprowski@samsung.com, petr.tesarik.ext@huawei.com,
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-coherent: add support for multi coherent rmems per
 dev
Message-ID: <Zb0Fng6g-PjNznCH@smile.fi.intel.com>
References: <20240201093515.849873-1-howardyen@google.com>
 <f5b626ae-bda1-479f-bc14-b1fd7ba043cf@arm.com>
 <2024020156-reshuffle-salvaging-8161@gregkh>
 <CAJDAHvZ=XVZ-Ea1LVqfTnDXJ+J=PLbZNCZkuSpvdOtEsreguWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDAHvZ=XVZ-Ea1LVqfTnDXJ+J=PLbZNCZkuSpvdOtEsreguWw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 02, 2024 at 12:40:59PM +0800, Howard Yen wrote:
> On Thu, Feb 1, 2024 at 11:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Thu, Feb 01, 2024 at 10:45:30AM +0000, Robin Murphy wrote:
> > > On 2024-02-01 9:35 am, Howard Yen wrote:

..

> I'm considering to modify the change to
> 
> 1. Move it into the dma_coherent_mem structure, like
> 
>      HEAD
> mem0->node
> 
> This case, if I check list_empty(mem0->node), it would give me the
> list is empty, but actually there is one rmem.
> 
> 2. Replace the pointer to a list_head.
> 
>     HEAD
> dma_mems ---> mem0->node
> 
> This case, if I check list_empty(dma_mems), it would give me the list
> is non-empty, it matches the actual status.
> 
> So, the 2nd looks reasonable, I'm going to upload a v2 patch with the
> 2nd approach, does that make sense?

I believe this is exactly what Robin told about "list to replace the pointer".

-- 
With Best Regards,
Andy Shevchenko



