Return-Path: <linux-kernel+bounces-58503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C144484E73D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFC31C2485C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D87B3C2;
	Thu,  8 Feb 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XA9aUMSv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081482D6E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415369; cv=none; b=PssAeMR3SKkNlTqzNaCuwS4/aCqzzHPrvskZB79Cw7l9drQrPTcfGE9LPIk9TUS6xBsRLIBGwppQnKkrOgsrX8SGPXk/lbFwpPoY3t6pqlDckUpklEYLfIXSqJMBZxHhey1WOHtC3Wtm4B1C9KFPABOfo5Yfol87FWyKiN2q+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415369; c=relaxed/simple;
	bh=FuQ27L0U872pyEj2Fitay1U8Ho3dI8X/cvhNZEhe4Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocaHtHvzaJpq84k3CZSTRMbv5MWzatSHCOAomor1Rt1D4Eg2t4F/P58MYCpk4/j6iWxj5nsEbPjvcfoxt9wdfGEyfyzDTZWlUnji8kTGJ2wfdukU6ywF20YHw3BwIUekAlMV6fbBZwGKsmt/slzIMGFarw9qJFmvAwgnFRmFDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XA9aUMSv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707415367; x=1738951367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FuQ27L0U872pyEj2Fitay1U8Ho3dI8X/cvhNZEhe4Lg=;
  b=XA9aUMSvXUAUPCQMKCx2BFxxgADZIREzcf2oZ6TkhxOBQc938UAoTi8D
   1rE/Jz++CGYGnlnGcAt5xGxqxFqVUcZfMxNXGJ37XwpNYgl+XRQjrNZ9p
   OWhrpd+jvTrqfiUcAgQmnSQ/cw4ZVHHR2kPZyMQ4M54p3Nw6exo/5IocJ
   frXBRKfJ0UtK38y6qIXWNQo1dKYNGJMTA1t+smo5ko+Ww9LOKECAo8f+w
   Bvm2tu6tNrRqZT0vZcUYLdlEhe6zz96nNdQbykc5xEQ36ZRgXP3ze0WUe
   XG0IRwPVl3LnI+4CzzigzKVqXWRVksB2G2gvVlUp7H9R6YFH5JFrb6D7Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1436673"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1436673"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:02:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910449233"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910449233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:02:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY8jQ-00000002wZp-0qwz;
	Thu, 08 Feb 2024 20:02:40 +0200
Date: Thu, 8 Feb 2024 20:02:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <ZcUXP14Ng8g5vw1j@smile.fi.intel.com>
References: <20240208152808.3712149-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208152808.3712149-1-howardyen@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 03:28:05PM +0000, Howard Yen wrote:
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

>  	struct dma_coherent_mem *mem;
> -	int ret;
> +	int retval;
>  
>  	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
>  	if (IS_ERR(mem))
>  		return PTR_ERR(mem);
>  
> -	ret = dma_assign_coherent_memory(dev, mem);
> -	if (ret)
> +	retval = dma_assign_coherent_memory(dev, mem);
> +	if (retval)
>  		_dma_release_coherent_memory(mem);
> -	return ret;
> +	return retval;

This is unrelated change.

But why? Do you have retval in the _existing_ code elsewhere?


..

>  int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>  		dma_addr_t *dma_handle, void **ret)
>  {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp;
>  
> -	if (!mem)
> +	if (list_empty(&dev->dma_mems))
>  		return 0;
>  
> -	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
> +	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> +		*ret = __dma_alloc_from_coherent(dev, mem_tmp, size, dma_handle);
> +		if (*ret)
> +			break;

This bails out on the first success. Moreover, if one calls this function
again, it will rewrite the existing allocation. Is this all expected?

OTOH, if you add multiple entries and bailing out on error condition it should
be clear if the previous allocations have to be released.

> +	}

>  	return 1;

>  }

..

>  int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
>  {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp;
> +	int retval = 0;
> +
> +	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> +		retval = __dma_release_from_coherent(mem_tmp, order, vaddr);
> +		if (retval == 1)
> +			break;

Same Q here.

> +	}
>  
> -	return __dma_release_from_coherent(mem, order, vaddr);
> +	return retval;
>  }

..

>  int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>  			   void *vaddr, size_t size, int *ret)
>  {
> -	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
> +	struct dma_coherent_mem *mem_tmp;
> +	int retval = 0;
>  
> -	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
> +	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
> +		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
> +		if (retval == 1)
> +			break;

And here.

> +	}
> +
> +	return retval;
>  }

..

With the above Q in mind, here is another one: Why can't we allocate all at once?

-- 
With Best Regards,
Andy Shevchenko



