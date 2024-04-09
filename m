Return-Path: <linux-kernel+bounces-136125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510B89D049
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F50283F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BD34F1EE;
	Tue,  9 Apr 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0JpQGOq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD47C4E1C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628762; cv=none; b=BOgEeFrYjDV4zH3qfq94nR2OQo+sypZxGRtWyB9xbM0O9JLhBWJXXcn9M7JPl4f7eWpUxjUMnuZ1KOtDiGFKjBxVJH5IwbdX2IcFLGJNvVqqsf8dkCCAjOu9G1v4awpcusEPsQCEqvO+etmzq9QPsKQnCpgk2HcG0uK10S5JDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628762; c=relaxed/simple;
	bh=8eK+10VMJe90oRq0AJ/aDRfzlyzRnsxQ71/YrliutVo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TkWPDaYgiaswRzhW548/1U5UKDWZw4UfNWo7By1LPb1NZusEz9ubqJMRfB4BPHqdLRkgpsCKY+LcnzMXDvowBLMGnrM9N6JLzwFsTyHfbh3kkR8xarY7zwjBCspmzVvgdn9w1ntyh0Bbq5JWrzg0z8QapjRVSGoPx3In6KMFiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0JpQGOq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712628761; x=1744164761;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8eK+10VMJe90oRq0AJ/aDRfzlyzRnsxQ71/YrliutVo=;
  b=L0JpQGOqc7kvtzMjn02KqoOMcAOU9I5//3EQVkBx2b7tpKe3HaPzXlZB
   oI+K7DFIcN/mNcWMtKKVyl+r5RXe4MVzyqg8llTikBPabaCdSbE954zMa
   7Mj8D3lv7cu9uxcid9VNn0mtr/eEfyiz4wFv/dK2iBuzodSH9r6Ff2nNv
   roKcdSaMcp4bH9ty219YCWJvyRhROjD0BsploFn8OBG4YJxdQfOCvTXcB
   EdzYESHV86QQH3geKsP4meZX0ORp5dTcDR72YvzWgYV//PC8UFNxosTFE
   ZbsBwy7yEdjzVj2i94FgB+/8UPHcUAbhbX1k0NIoXghzuK3bATWnBP7HA
   w==;
X-CSE-ConnectionGUID: 8QbiNpYjSBGgGPLzSP9ENA==
X-CSE-MsgGUID: MCIZbFrWRjyyxaE5+VC8bQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11709434"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="11709434"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 19:12:40 -0700
X-CSE-ConnectionGUID: w4k0UXTzRUS7xxPqU7gLjA==
X-CSE-MsgGUID: hT9REQAWQjW3sSHkLMgkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20105232"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 08 Apr 2024 19:12:37 -0700
Message-ID: <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
Date: Tue, 9 Apr 2024 10:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240408141946.GB223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>> +	/* A bond already exists, just take a reference`. */
>>>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>>> +	if (handle) {
>>>> +		mutex_unlock(&iommu_sva_lock);
>>>> +		return handle;
>>>>    	}
>>> At least in this context this is not enough we need to ensure that the
>>> domain on the PASID is actually an SVA domain and it was installed by
>>> this mechanism, not an iommufd domain for instance.
>>>
>>> ie you probably need a type field in the iommu_attach_handle to tell
>>> what the priv is.
>>>
>>> Otherwise this seems like a great idea!
>> Yes, you are right. For the SVA case, I will add the following changes.
>> The IOMMUFD path will also need such enhancement. I will update it in
>> the next version.
> The only use for this is the PRI callbacks right? Maybe instead of
> adding a handle type let's just check domain->iopf_handler  ?
> 
> Ie SVA will pass &ommu_sva_iopf_handler as its "type"

Sorry that I don't fully understand the proposal here.

We need to get the attach handle at least in below cases:

1. In the iommu_sva_bind_device() path so that the existing bind could
    be reused.

2. In the iommu_report_device_fault() path so that the context-specific
    data could be used in the fault handler.

The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
sure that the attach handle is really what it has installed during
domain attachment. The context code needs some mechanism to include some
kind of "owner cookie" in the attach handle, so that it could check
against it later for valid use.

Best regards,
baolu

