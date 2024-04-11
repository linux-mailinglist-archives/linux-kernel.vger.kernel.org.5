Return-Path: <linux-kernel+bounces-140491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21718A1562
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201FA1C210C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FE14C5B3;
	Thu, 11 Apr 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wm57eC+0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08710335BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841483; cv=none; b=D5NCKiFGODkVjJfZ1JE8jVb5mAmKvgr4aff6eVU3a9cXGFwK3CY1xXqOteZrq+/zGAyN4QY8T2OajnepONO2au6/+iDonzjfCZ2DK1JsQWFoifjWFYt25kb7+sAK8UXFC/B5UQJ0XTqOUA1KmXv355W83rDNYXwbozEyRE47YBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841483; c=relaxed/simple;
	bh=Q6x1T1BSMrCr5eyuBNqAuNAVMxGpPKsZvY0wjxFuhwE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TBGj/8aMF2xl+RjjGK91kP2iepR1o+6F/Ms75c+QwfFA4QykDLUgEWM0kZ67RHRFdD6c90HCQu4nF3W7QNF784NFKvygqWdmekmRVAXig6DLzzSceV5W9MQj7u3oRgnm3+mYBMbYNkDqcxU2TKCWT+44mdG6RMU5zu54XdqS0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wm57eC+0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712841483; x=1744377483;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q6x1T1BSMrCr5eyuBNqAuNAVMxGpPKsZvY0wjxFuhwE=;
  b=Wm57eC+0CeFNYnxY2encVTC2xzyxL6Gd55NseNIgWJ+D/0tQ3v3ZnZqo
   +h/mo2VYbz0O3Qf1CCWQiHvmZRrm3HJm/zE8tvFLDhStUtdSHXrutd6XR
   cUeGPnb+HPeDYW8EFITYQxJvZQhESnSJJC3DgQ2i2/FDgLnqbwvOdlY2k
   52mDxVZIrEezBXLFptHeZFavu34kUpROJ4+66/5I0yIwNzOzd5g7vXAvE
   9kO6LVGIQa7V1P1sTy9Z1RF8wp+Yyx9CxDvEVaORGm8aEG8Ogq2QuL39B
   7o/+8zK1CNr8lX+fCZ2jw3JDQqv1QovW0aw7vJEd7oY0L48lsiyvLwSbe
   w==;
X-CSE-ConnectionGUID: ldODU5BWSjS76P+GCRpGUQ==
X-CSE-MsgGUID: gMQE23pNRii4ngdE36m8JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8166104"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8166104"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:17:47 -0700
X-CSE-ConnectionGUID: Cr0FifIJRyOtGhUiap4YEg==
X-CSE-MsgGUID: oFlnFjwMQ+muWFNBNdGYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25691493"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.86]) ([10.124.237.86])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 06:17:44 -0700
Message-ID: <4e47aff7-aa65-4c60-a5dc-b7e0f2737a3e@linux.intel.com>
Date: Thu, 11 Apr 2024 21:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/12] iommu/vt-d: Add cache tag assignment interface
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-2-baolu.lu@linux.intel.com>
 <20240410154134.GG223006@ziepe.ca>
 <BN9PR11MB5276B57D6E72870C9B1798838C062@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276B57D6E72870C9B1798838C062@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/11 7:14, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Wednesday, April 10, 2024 11:42 PM
>>
>> On Mon, Mar 25, 2024 at 10:16:54AM +0800, Lu Baolu wrote:
>>> +static int __cache_tag_assign_parent_domain(struct dmar_domain
>> *domain, u16 did,
>>> +					    struct device *dev, ioasid_t pasid)
>>> +{
>>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +	int ret;
>>> +
>>> +	ret = cache_tag_assign(domain, did, dev, pasid,
>> CACHE_TAG_TYPE_PARENT_IOTLB);
>>> +	if (ret || !info->ats_enabled)
>>> +		return ret;
>>
>> I'm not sure I understood the point of PARENT_IOTLB? I didn't see any
>> different implementation?
>>
>> Isn't this backwards though? Each domain should have a list of things
>> to invalidate if the domain itself changes.
>>
>> So the nesting parent should have a list of CHILD_DEVTLB's that need
>> cleaning. That list is changed when the nesting domains are attached
>> to something.
>>
> 
> probably just a naming confusion. it's called PARENT_IOTLB from the
> angle that this domain is used as a parent domain but actually it
> tracks the child tags in nested attach.

Is NESTING_IOTLB more readable?

Best regards,
baolu

