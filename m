Return-Path: <linux-kernel+bounces-52673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC072849B46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB7280F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F4822F07;
	Mon,  5 Feb 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8mdbkBY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B61210E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137914; cv=none; b=KGm868XWGuZzMwDo+YdleNQsL9HOG6IOgsXYJvms7sYyckULpzuL+qz+q4SdUQ+9jrOkSiukFR2EuyMRBUJqf0PGoohnVZRcdxbNWgXFw+gxkHhyGfG2KWdNuwMn17bs21g60q9Ig223KIOrkmKkmYe+ZDmF/uxy7EUNa78gWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137914; c=relaxed/simple;
	bh=/avHX/ak9lI7o2Ivm96oIKLl8Fvy6Rro7BostTDJ+QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzKGeaU3DYU794BfDSUjC/qgYUASJgc3AzJFF7cz6Y1qdhvzHvPM6NxZ1aHdrffSSRWfBlWjAbXSvhBLdZVq9c/71qC0QChdDjoOcYeQA5mwvMayY873mBQ57RBdNaRBPovcZD0jrUy8LPKNmtV8yrm/xzgNbmedCZXgDjv+5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8mdbkBY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707137912; x=1738673912;
  h=resent-from:resent-date:resent-message-id:resent-to:date:
   from:to:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=/avHX/ak9lI7o2Ivm96oIKLl8Fvy6Rro7BostTDJ+QI=;
  b=Z8mdbkBY7BZhk3F/9NtVn7juf2CPJbakCxh/O9XJet71BSz89LxLW16G
   KFA3szF9QLQU78sSsXwxoxzCqjzNmcII4hwQZLSlc6uJyoE/6j0hvniHe
   kblCUEnx4cqPPTOpkX/HGfkN+jKQWmou63Pg6QqVSJ5H6hXLPEFQGckvK
   CY5VmxNWjX3NMBj14Gy+JvROOTuObq2uqOuE8rKsyPSuy88I1sNIFXZpP
   RzHSzvybjV0ZLqe4DMC02D8QZ1XNRy36U+gsa1x7lgZqw1rZOSy7YJNVZ
   +uNOsyebU1L5elDmtHrFZ/PDmQb2QE1WhhVuK6Z1pa6K0OSBcQCYak71k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="406151"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="406151"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:58:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933149299"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933149299"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:58:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rWyUK-000000024cP-0Ze6;
	Mon, 05 Feb 2024 14:54:16 +0200
Resent-From: Andy Shevchenko <andriy.shevchenko@intel.com>
Resent-Date: Mon, 5 Feb 2024 14:54:15 +0200
Resent-Message-ID: <ZcDad7MYTNp2GaAS@smile.fi.intel.com>
Resent-To: howardyen@google.com, hch@lst.de, m.szyprowski@samsung.com,
	robin.murphy@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Date: Mon, 5 Feb 2024 14:08:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <ZcDPn5eLvMwpb7N1@smile.fi.intel.com>
References: <20240205072312.2342188-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205072312.2342188-1-howardyen@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:
> Add support for multiple coherent rmems per device. This patch replaces
> original dma_mem with dma_mems list in device structure to store multiple
> rmems.
> 
> These multiple rmems can be assigned to the device one by one by
> of_reserved_mem_device_init_by_idx() with the memory-region
> declaration in device tree as below and store the rmem to the dma_mems
> list.
> 
> 	device1@0 {
> 		...
> 		memory-region = <&reserved_mem0>, <&reserved_mem1>;
> 		...
> 	};
> 
> When driver tries to allocate memory from the rmems, looks for the first
> available rmem and allocates the memory from this rmem.
> 
> Then if driver removed, of_reserved_mem_device_release() needs to be
> invoked to release all the rmems assigned to the device.

..

> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -18,15 +18,9 @@ struct dma_coherent_mem {
>  	unsigned long	*bitmap;
>  	spinlock_t	spinlock;
>  	bool		use_dev_dma_pfn_offset;
> +	struct list_head	node;

Have you run `pahole`? Here I see wasted bytes for nothing.

>  };

..

>  void dma_release_coherent_memory(struct device *dev)
>  {
> +	struct dma_coherent_mem *mem_tmp, *q;
> +
>  	if (dev) {

While at it, perhaps

	if (!dev)
		return;

?

> -		_dma_release_coherent_memory(dev->dma_mem);
> -		dev->dma_mem = NULL;
> +		list_for_each_entry_safe(mem_tmp, q, &dev->dma_mems, node) {
> +			list_del_init(&mem_tmp->node);
> +			_dma_release_coherent_memory(mem_tmp);
> +		}
>  	}
>  }

..

>  int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
>  {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp;
> +	int ret = 0;

'ret' (1)

> -	return __dma_release_from_coherent(mem, order, vaddr);
> +	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> +		ret = __dma_release_from_coherent(mem_tmp, order, vaddr);
> +		if (ret == 1)
> +			break;
> +	}
> +
> +	return ret;
>  }

..

>  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>  			   void *vaddr, size_t size, int *ret)
>  {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp;
> +	int retval = 0;

'retval' (2)

Can we be consistent, please? (See (1) and (2) above.)

> +	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> +		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
> +		if (retval == 1)
> +			break;
> +	}
>  
> -	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
> +	return retval;
>  }

..

>  static void rmem_dma_device_release(struct reserved_mem *rmem,
>  				    struct device *dev)
>  {
> -	if (dev)
> -		dev->dma_mem = NULL;
> +	struct dma_coherent_mem *mem_tmp, *q;

> +	if (dev) {

As per above, esp. taking into account that you touch this line. With proposed
modification you won't need to.

> +		list_for_each_entry_safe(mem_tmp, q, &dev->dma_mems, node) {
> +			if (mem_tmp == rmem->priv) {
> +				list_del_init(&mem_tmp->node);
> +				break;
> +			}
> +		}
> +	}
>  }

Better question, do we really need the dev check (at least in static functions)
or it can be ommitted?

-- 
With Best Regards,
Andy Shevchenko



