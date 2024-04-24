Return-Path: <linux-kernel+bounces-156156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221AF8AFE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B351C2242A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ED083CC4;
	Wed, 24 Apr 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJlY2TZ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8783C138
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926765; cv=none; b=oI+rvObvgfI/7Rbipjzw+OgMEQNnhnLZDjZ5lTzu76RhINzFi+n/0p52oK6L2eP8LAYYwnGN2+yWj635oqhf3jyBpOiijObUxr8wOxk6C7r/zZvNsp3TynrfcqnJHK5k7HP0tflf1Ff7x8d/GF609pVO3bca4fR9ICxBRfVo9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926765; c=relaxed/simple;
	bh=MiyHAf01++BUbs/aPGIknIWZ43yNcPC8sNtReIepA/s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ngvQhml/beXmejM7LV8bXIyqlov8CyS9otpq+aRlMIiwHqcnG90us3zU1XlcXsWdRrSyCqn5pRFGwc4w5FGOtIfijkvVF8D3EoCCR+/UxkRPU2BttpJWjXcT7SNr49ga+iCcA6saXdzhPa5CgmMJ2RFI8lceHSRGXi9QjFFCqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJlY2TZ8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713926764; x=1745462764;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MiyHAf01++BUbs/aPGIknIWZ43yNcPC8sNtReIepA/s=;
  b=HJlY2TZ8rb6XIUnnbBf2wHxMCmBZYntaQBu4K8gTb6Q7EJCCCT118ugz
   dQ2bfkfBt2BENqgHENEhCMB/+ekOCYpUbhTlGOzyXJUt5TRLmPZ2uIqJR
   R0xnHQBakG8hh/IZ9G0cMBkmAiyEycj15Lcpa3pc+yChbSLohHVLZqCR8
   IwCNwz31hG2f2RLjtul/kHHmL4tqZefPBpiIU3BR/3+i29B4YSfC/8r8h
   oAyNzNZ/XeplT61/8gztd96KOrpsT/VE31mC2/JTIovhlcSeOqR9pRLlR
   KTaCswpzTZlOGpFl7d2600eG3yVyJPCPsXD0JXEjTXY4SbjMF+rsEpxP4
   Q==;
X-CSE-ConnectionGUID: P7MDZ+c7SeWi2NrUjVeMsw==
X-CSE-MsgGUID: QJEANZJFSZuvQu5q+mqEjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12473034"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="12473034"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 19:46:03 -0700
X-CSE-ConnectionGUID: YAkqvKlzSJKFctxgTNGymg==
X-CSE-MsgGUID: xcsF7COYTyCRv1Cu3acPyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24449651"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 23 Apr 2024 19:46:00 -0700
Message-ID: <05d0d9bf-2a33-487f-bbf2-5d7780cbabb9@linux.intel.com>
Date: Wed, 24 Apr 2024 10:44:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A1920E24BE91CF1FD2098C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A1920E24BE91CF1FD2098C112@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 5:01 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 16, 2024 4:07 PM
>>
>> @@ -1757,6 +1759,9 @@ int domain_attach_iommu(struct dmar_domain
>> *domain, struct intel_iommu *iommu)
>>   	unsigned long ndomains;
>>   	int num, ret = -ENOSPC;
>>
>> +	if (domain->domain.type == IOMMU_DOMAIN_SVA)
>> +		return 0;
>> +
>>   	info = kzalloc(sizeof(*info), GFP_KERNEL);
>>   	if (!info)
>>   		return -ENOMEM;
>> @@ -1804,6 +1809,9 @@ void domain_detach_iommu(struct dmar_domain
>> *domain, struct intel_iommu *iommu)
>>   {
>>   	struct iommu_domain_info *info;
>>
>> +	if (domain->domain.type == IOMMU_DOMAIN_SVA)
>> +		return;
>> +
>>   	spin_lock(&iommu->lock);
>>   	info = xa_load(&domain->iommu_array, iommu->seq_id);
>>   	if (--info->refcnt == 0) {
> 
> above two are not called for SVA. Why do they start checking
> SVA type now?

domain_detach_iommu() is called in remove_dev_pasid path which covers
SVA domain as well.

I am moving the check to the domain_attach/detach_iommu() helpers so
that the call sites could be generic. I will later move the domain ID
management to the cache tag code, this kind of check will be dropped
then.

Best regards,
baolu

