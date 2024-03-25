Return-Path: <linux-kernel+bounces-116530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE788A4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC1CBA1836
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C2763FD;
	Mon, 25 Mar 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwGChg5O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1F1C68BB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342798; cv=none; b=ZyewnyGCb8K4IjwZkDL7A+UPkAKn0ioLOryzEmrbU0ohKbLhGmCP02EmfyRfWvEJeiKmMvfGFeKDZ6//e3Ad9oH/pGtSfjM5N/j/Q5xsRAgx34FhsmvA/kNQOPEripPwLme62BuWhXGwoMRp2jtQHDCzG851nNZID69k5EqKv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342798; c=relaxed/simple;
	bh=JPIFdOVVVlbXRwS1CVptMVqz9h//vSxocpBlOd35dic=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X78m6AffaSwVdFimbVWmM7jgTIPD/dO5HgqaCwVH84K/7hmCS/KR0cPK2CslnlOcB8GOQkf5FkltR28VRsZQPV1n4BteLqVrUAd+qBZkAsJ4w0mEjkvWh5TzHxeRaA7LcH0O/cIWqnH8Y/Aa58um0zKcqUp9/sOTy9Yw1vNA3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwGChg5O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711342796; x=1742878796;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JPIFdOVVVlbXRwS1CVptMVqz9h//vSxocpBlOd35dic=;
  b=fwGChg5OGovLLmVajgibfdupHyEr0bDtD2YkZ5tp2Vq1RyUG2YSapcJ8
   M7A1KvZRxbkvtzqtXEmblCJ5O9xngRtx2wDhi87kxTINxAFMQtvMKtsk/
   18LPxBkyNDCHV9a+hOWT6iIvE++uBy9u2vfkfaqXL3PpXL9j/TiYLACkV
   /1KBAlRzB1sIkq2QaWeZiX+kcp208h4adEQDTA/rV1UeJq96vGYaWy70x
   1HVt729isZ+ce+3fEJaXMDuQv+8j+h+d0SUNulsTNPVX1sSdmWm3dPQkm
   bFwarBh99bWJJRQiHYq4UlCEylVrnTkINLi3YzH7e3U9llNkj+PMN5fBx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6259981"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6259981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 21:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="46493985"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.86]) ([10.254.209.86])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 21:59:49 -0700
Message-ID: <d296d43f-6835-43b3-a5ba-cbbf8b580a27@linux.intel.com>
Date: Mon, 25 Mar 2024 12:59:46 +0800
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
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <20240308190539.GY9225@ziepe.ca>
 <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
 <20240322170613.GI66976@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322170613.GI66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/23 1:06, Jason Gunthorpe wrote:
> On Fri, Mar 15, 2024 at 09:16:43AM +0800, Baolu Lu wrote:
>> On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
>>> On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
>>>
>>>> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>>>>     * @__reserved: Must be 0
>>>>     * @data_type: One of enum iommu_hwpt_data_type
>>>>     * @data_len: Length of the type specific data
>>>> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
>>>> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>>>>     * @data_uptr: User pointer to the type specific data
>>>>     *
>>>>     * Explicitly allocate a hardware page table object. This is the same object
>>>> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>>>>    	__u32 __reserved;
>>>>    	__u32 data_type;
>>>>    	__u32 data_len;
>>>> +	__u32 fault_id;
>>>>    	__aligned_u64 data_uptr;
>>>>    };
>>>
>>> ?? We can't add fault_id in the middle of the struct??
>>
>> Yes. I should add the new field at the end.
>>
>> By the way, with a __u32 added, this data structure is not 64-byte-
>> aligned anymore. Do we need to add another unused u32 entry, or just let
>> the compiler handle it?
> 
> Yes, add a reserved u32 to ensure the structs is always without
> implicit padding.

Sure.

> 
>>>
>>>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>>>> +		struct iommufd_fault *fault;
>>>> +
>>>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>>>> +		if (IS_ERR(fault)) {
>>>> +			rc = PTR_ERR(fault);
>>>> +			goto out_hwpt;
>>>> +		}
>>>> +		hwpt->fault = fault;
>>>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>>>> +		hwpt->domain->fault_data = hwpt;
>>>> +		hwpt->fault_capable = true;
>>>
>>> I wonder if there should be an iommu API to make a domain fault
>>> capable?
>>
>> The iommu core identifies a fault-capable domain by checking its
>> domain->iopf_handler. Anyway, what's the difference between a fault or
>> non-fault capable domain from iommu core's point of view?
> 
>  From the core? Nothing. I'm just wondering from an API perspective if
> we should have a little inline to indicate it.

I have no objection if there's a consumer for it.

Best regards,
baolu


