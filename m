Return-Path: <linux-kernel+bounces-103960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D7387C70A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7A41F2226B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23A613D;
	Fri, 15 Mar 2024 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MeAC9nCE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AA17C8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465447; cv=none; b=kuiX9jrLqBeRYXQ9KaAfvjkMNcElYo34Je75smbfUsneFKDtYhLogjW/7hlKZAeaQFCjf0iIh1S6yrp2yNY39l0+MMg7NvXhqfSTjVNMwCANx+fGDLQwdax+HlvSW4pV+jEPm73QIUjvG/0SKCNFC/VbiZb/S+yA0qnKnYOIP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465447; c=relaxed/simple;
	bh=RINii3wGGnlUbE3ZLF3vQV3MCY+kCa38spzuhHObNjs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iYSdae/M/TjW+M9tpOH5w3ueyYfFxCtZutA7+5fd6+/NYW9UcArfaYkj3vEGRTMwf/cUoalcFrvzH1sLJh8AQVFaDfdeTC/8T/cW5wX5FaB4ATjRdELu7px+sHReHIbkYF1uJPMtCfKvn7WrUlr9HkJQpjRiByVdLe6L6bD/HHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MeAC9nCE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710465446; x=1742001446;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RINii3wGGnlUbE3ZLF3vQV3MCY+kCa38spzuhHObNjs=;
  b=MeAC9nCECWlGJBKO4FZmZNb2/k2ImDeJ95+EULFVo1+NdDbidkVtOpmx
   IaVnTBv5CVhfcklNLJS5YeUN1wl5rt1Mclge/5+2ld0NundhS5NxJYdNJ
   /mcWZIH+6o1PcaIGIGIDz8uOJn5102HUkFJkXfIRjELHfkl3KnhRevdKD
   ZraYlxrjieKFWB7d3gpxwK5e/t2khbW+yb9oSWiqOCSAgLMtMlHXuECOe
   KFWYEicfkag2zFLANHRwmPr6CY1tB+laq3JGPP7rzbWx0Ov7B2/ndO7rw
   v4AXdy2bJQUhL1fhJJ5ah2BjDuHb88mJMzZhQ+6OvuoPzk6nDBVhEAl9n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5175577"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5175577"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12947095"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 14 Mar 2024 18:17:21 -0700
Message-ID: <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
Date: Fri, 15 Mar 2024 09:16:43 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308190539.GY9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
> 
>> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>>    * @__reserved: Must be 0
>>    * @data_type: One of enum iommu_hwpt_data_type
>>    * @data_len: Length of the type specific data
>> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
>> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>>    * @data_uptr: User pointer to the type specific data
>>    *
>>    * Explicitly allocate a hardware page table object. This is the same object
>> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>>   	__u32 __reserved;
>>   	__u32 data_type;
>>   	__u32 data_len;
>> +	__u32 fault_id;
>>   	__aligned_u64 data_uptr;
>>   };
> 
> ?? We can't add fault_id in the middle of the struct??

Yes. I should add the new field at the end.

By the way, with a __u32 added, this data structure is not 64-byte-
aligned anymore. Do we need to add another unused u32 entry, or just let
the compiler handle it?

> 
>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>> +		struct iommufd_fault *fault;
>> +
>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>> +		if (IS_ERR(fault)) {
>> +			rc = PTR_ERR(fault);
>> +			goto out_hwpt;
>> +		}
>> +		hwpt->fault = fault;
>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>> +		hwpt->domain->fault_data = hwpt;
>> +		hwpt->fault_capable = true;
> 
> I wonder if there should be an iommu API to make a domain fault
> capable?

The iommu core identifies a fault-capable domain by checking its
domain->iopf_handler. Anyway, what's the difference between a fault or
non-fault capable domain from iommu core's point of view?

Best regards,
baolu

