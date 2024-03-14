Return-Path: <linux-kernel+bounces-103312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B887BDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33471C2154F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949546AFAC;
	Thu, 14 Mar 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2PLnj96"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF995A4CB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423713; cv=none; b=d9Seu7Mwa9lfM/j3AbWmQxL7kcMvMMJwwtXmC3xZyZccCEQyKuW7yz7pXVaK2KXB0MT91YkIe8YWCKvvKjaGsLKOaJlWTe6GaOmL25ms9mKU+2dAPVXoezTuStbNES2uY7BJviGYs4wb+iWK9rIjUn7/XxhN/XPckaVEjXuI7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423713; c=relaxed/simple;
	bh=FghQcZsR6VC2YmekzMAzZOpVy/lU5ooLVH+PhXP0tmI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aKbFZIiRE8/5PSrwlK0DgmRFYe6BB0kt12wqP7sdpb/hZSGH/KjcW5nbBu64xpuuHxInkP8QcKPdn7X78txpqJUUroTDWQWVMpIhOmHaP/elR0JnPdZlQH82UsggoGEkNFx3rfdJVkA1N1sY9DkOYaIho2B04Rw3ORvaV6sNG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2PLnj96; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710423712; x=1741959712;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FghQcZsR6VC2YmekzMAzZOpVy/lU5ooLVH+PhXP0tmI=;
  b=Q2PLnj96YYqO42GlxFsrx197PlPgiVvvL+KKeoWO+l8FqKBHIt0ovjxO
   SbX7s1xbqSdRlOF7uP21x2Oqj/ykLM0Io5NTcPuXmBTrCo74qSLuH4ERf
   W47Mmi4a3pxN/Z+1K+EglNF72vLSa32xKSKhR8JNPvpbhiWeiw6VtVo6i
   8J9ajefeGt4eSoPz/idtEsZKNOXUe8xNtCDCTkQkRzVul+iqnl1UesNma
   slrf1Ngz2NAeYKEj+vZx58Xq6jdlBvHCrecjTdY+IX78hK6vIa8zFYWvR
   S6irw1G/DBmkaDeQZyFC6TPsDaRbOW7kkRbTL6YKict1Og0IQ4sBdHy6d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="30679638"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="30679638"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="17023702"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.29.38]) ([10.255.29.38])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 06:41:48 -0700
Message-ID: <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>
Date: Thu, 14 Mar 2024 21:41:45 +0800
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
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
 <20240308175007.GW9225@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308175007.GW9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/9 1:50, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:38:58PM +0800, Lu Baolu wrote:
> 
>> +/**
>> + * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
>> + * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
>> + *                                   valid.
>> + * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
>> + */
>> +enum iommu_hwpt_pgfault_flags {
>> +	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
>> +	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
>> +};
>> +
>> +/**
>> + * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
>> + * @IOMMU_PGFAULT_PERM_READ: request for read permission
>> + * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
>> + * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
>> + * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission
> 
> You are going to have to elaborate what PRIV is for.. We don't have
> any concept of this in the UAPI for iommufd so what is a userspace
> supposed to do if it hits this? EXEC is similar, we can't actually
> enable exec permissions from userspace IIRC..

The PCIe spec, section "10.4.1 Page Request Message" and "6.20.2 PASID
Information Layout":

The PCI PASID TLP Prefix defines "Execute Requested" and "Privileged
Mode Requested" bits.

PERM_EXEC indicates a page request with a PASID that has the "Execute
Requested" bit set. Similarly, PERM_PRIV indicates a page request with a
  PASID that has "Privileged Mode Requested" bit set.

> 
>> +enum iommu_hwpt_pgfault_perm {
>> +	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
>> +	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
>> +	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
>> +	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
>> +};
>> +
>> +/**
>> + * struct iommu_hwpt_pgfault - iommu page fault data
>> + * @size: sizeof(struct iommu_hwpt_pgfault)
>> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
>> + * @dev_id: id of the originated device
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
>> + * @addr: page address
>> + */
>> +struct iommu_hwpt_pgfault {
>> +	__u32 size;
>> +	__u32 flags;
>> +	__u32 dev_id;
>> +	__u32 pasid;
>> +	__u32 grpid;
>> +	__u32 perm;
>> +	__u64 addr;
>> +};
> 
> Do we need an addr + size here? I've seen a few things where I wonder
> if that might become an enhancment someday.

I am not sure. The page size is not part of ATS/PRI. Can you please
elaborate a bit about how the size could be used? Perhaps I
misunderstood here?

> 
>> +/**
>> + * struct iommu_hwpt_page_response - IOMMU page fault response
>> + * @size: sizeof(struct iommu_hwpt_page_response)
>> + * @flags: Must be set to 0
>> + * @dev_id: device ID of target device for the response
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @code: response code. The supported codes include:
>> + *        0: Successful; 1: Response Failure; 2: Invalid Request.
> 
> This should be an enum

Sure.

> 
>> + * @addr: The fault address. Must match the addr field of the
>> + *        last iommu_hwpt_pgfault of a reported iopf group.
>> + */
>> +struct iommu_hwpt_page_response {
>> +	__u32 size;
>> +	__u32 flags;
>> +	__u32 dev_id;
>> +	__u32 pasid;
>> +	__u32 grpid;
>> +	__u32 code;
>> +	__u64 addr;
>> +};
> 
> Do we want some kind of opaque ID value from the kernel here to match
> request with response exactly? Or is the plan to search on the addr?

I am using the "addr" as the opaque data to search request in this
series. Is it enough?

Best regards,
baolu

