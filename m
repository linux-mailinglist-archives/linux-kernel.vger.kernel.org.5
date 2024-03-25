Return-Path: <linux-kernel+bounces-116468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EAF88A202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A6BA5347
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6C2F2D;
	Mon, 25 Mar 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPOMWbjP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA06EC7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338781; cv=none; b=h9pi9jrYl8pvmxZXoFSCTiawl6EVl70RnR03wpp4lXc9owICvK4VJXNSMsTuDSwpODYygs05hV56WcRgA/iGT6XWJp/FjTFaXLEhiYlKAh3afvawO+5WLHiJUfDEs/IJMyrmQIKsja9nxHAnoUR5SPdOBLDDVkWqVPGME/INveY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338781; c=relaxed/simple;
	bh=fm/ErcL7W49rS5AmQMWHiVhN2nRexSlcv3UfZogZWnk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VChrBmoEAdSHTcvLy1DL8inKJwLsokyGe1R9VbGLOIrO9YQeHJrRzZPd+1D6XZrRyYBnjYiM9POC1P4x7yOumCg/egYgVAijRHxm+2yXQY6GCn+7N/0qsLZvBpm8Q0SCWBZCPUptJpvILypb4q6DQA0s5NH0ObRJhW6DLj0lAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPOMWbjP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711338780; x=1742874780;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fm/ErcL7W49rS5AmQMWHiVhN2nRexSlcv3UfZogZWnk=;
  b=WPOMWbjPRmN/eLqR6OU8Ksj08ghAzXII61kN4QRPiNscP5IexGgAwUpv
   1qjKZCbIlc6tuginF08hhL8VKcJZRPN9x0MuvzS7WeLQYo6nKO0Y9Nco5
   LW9/ugcg/kwoy7WKzIz5VxVwB8qAsdOaZpuCTT8TIgnuSXtwEokFvMwB5
   dOS5rMMPw/HY7FQHaIYm8Dyp1u/yqGYhSyTJBTroiPgOGqxVqwYh/OpXZ
   k5gnxJmcY8/nznNWLmvHZgt6xX2n36l+lFIRrPWZZ4U2fFkDT9bQBtXVO
   yovy7hbk3cDWMMNt4G/UbRQb3dQqUdGBtUul6MgNvGZV4yqWiBEOoICWn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10093989"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10093989"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20033103"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 24 Mar 2024 20:52:55 -0700
Message-ID: <0d12a5f4-0380-4e00-8c23-b4f63e3b93e7@linux.intel.com>
Date: Mon, 25 Mar 2024 11:52:05 +0800
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
Subject: Re: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-3-baolu.lu@linux.intel.com>
 <20240308174605.GV9225@ziepe.ca>
 <b33bf29b-2fe5-4a2a-a2ce-9fd8d67c5f6f@linux.intel.com>
 <20240322165927.GG66976@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322165927.GG66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/24 12:59 AM, Jason Gunthorpe wrote:
> On Thu, Mar 14, 2024 at 03:41:23PM +0800, Baolu Lu wrote:
> 
>> The whole cookie mechanism aims to address two things:
>>
>> - Extend the domain lifetime until all pending page faults are
>> resolved.
> Like you answered, I think the flush is a simpler scheme..

Yeah! Let me head this direction.

> 
>> - Associate information about the iommu device with each attachment of
>>    the domain so that the iommufd device object ID could be quickly
>>    retrieved in the fault delivering path.
>   
>>> I see we also need to stick a pointer in the domain for iommufd to get
>>> back to the hwpt, but that doesn't seem to need such a big system to
>>> accomplish - just add a void *. It would make sense for the domain to
>>> have some optional pointer to a struct for all the fault related data
>>> that becomes allocated when a PRI domain is created..
>> It's not getting back hwpt from domain, just getting the iommufd_device
>> in the fault delivering path. The iommufd_device is not per-domain, but
>> per-domain-attachment.
> It does make sense you'd need that, but I think something like this is
> a more direct way to get it. Caller allocates the handle struct. The
> iopf will provide the handle from the XA to the
> callback. container_of() not void * is used to in the caller's API.

Your code looks attractive to me. It's much simpler. Thank you!

Best regards,
baolu

