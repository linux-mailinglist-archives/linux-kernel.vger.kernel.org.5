Return-Path: <linux-kernel+bounces-97098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE9876582
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64B2280FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1243BBE0;
	Fri,  8 Mar 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPiYGXzR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC917EF;
	Fri,  8 Mar 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905290; cv=none; b=uzFUQPkPcrKXhzLKQCtULYMS1J1xiTRIijM6Ik6HJMUnOZQmlCsDmMKKnjrgARlQI2Nm9uNwuq/6TeXyOzcKeqv2GrxTDaG8guziloJoj3lsWVrEU6uA0oZS86CJlgHGmSGwI5o6BDeXySi4dMx0pnmET5dOXLH0d/jYFe3FtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905290; c=relaxed/simple;
	bh=+t1ETm8CzkM9ZXH1uUmD6NmBHPg3pT1jV+G0NVp2IPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ5v78pQQ6A9C/0Z2lizwGIU2cgIrogFhTGR4SWvOYbRz/A2lBpSvHxCJKODS++fbkKdAxC3sdy9y3fBoWlJ25yU1e1/q3TlqDR4fpQCMiXGLRQIG1FHcJNe4dY/INygI11vybG396LUvj1/8H060eoxsRDHx5xaDCzcJ4x1108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPiYGXzR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709905289; x=1741441289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+t1ETm8CzkM9ZXH1uUmD6NmBHPg3pT1jV+G0NVp2IPU=;
  b=SPiYGXzRIoAdLwWc52JLCY8D5XJL0FMo6yiOJug8b1qESCwf2ttNFbqV
   BSvGKno3cRDRI4n0jYsdX9YDJ1makS8HKimZ1f3hvX8xf+Gn65JFnzqKY
   ZKtlaH2Z+nAAvP0HicFOeVDMNzgxG9KzqZ2tFT7ReckQMtP+pB0TCKRMi
   hKc8Z85Q/Wwq6MbIsvkLxYZLTfCN9R6Q6hwIuvnpMN8Gw4fryyj9su6Mz
   tt9VqqWBnT8WfClfZT2vuCqV9JYi9W0zc5vE7MFgfColISNm4ZBmfsLlL
   SnIF5kchtVZ+PpzRh4c0hjhCBJFjQxZMSe7WAu24hr6B0Kb75HpafGpXG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4493989"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4493989"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:41:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914246852"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914246852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:41:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riaTR-0000000AqtQ-48QB;
	Fri, 08 Mar 2024 15:41:21 +0200
Date: Fri, 8 Mar 2024 15:41:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v4 1/2] dma-coherent: add support for multi coherent
 rmems per dev
Message-ID: <ZesVgXi9xBFvDL4O@smile.fi.intel.com>
References: <20240308095320.1961469-1-howardyen@google.com>
 <20240308095320.1961469-2-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308095320.1961469-2-howardyen@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 09:53:19AM +0000, Howard Yen wrote:
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

> +#endif
> +#ifdef CONFIG_DMA_DECLARE_COHERENT
> +	INIT_LIST_HEAD(&dev->dma_mems);
>  #endif

Side note: Have you used --histogram diff algo? If no, use it in the future.

-- 
With Best Regards,
Andy Shevchenko



