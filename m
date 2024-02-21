Return-Path: <linux-kernel+bounces-74133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E29F85D04D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4711C23A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408239FFE;
	Wed, 21 Feb 2024 06:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eloji9zY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED239FD7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496133; cv=none; b=rpOPy7k3kcuCkR7vAzriZY3QCjh+oOYjiyxNCx7gPRu/IvUd4dfG3WuXj7tLM+I5/S9JI0J8qJpCtsIYkEetdD6EW7qtNIwRF7fEAm7Ineq30TERHzywHKTAqFQxhM52QwHpoDA4DNZbZshMGyw6JDNau5uFCoJioSIqe0XVgH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496133; c=relaxed/simple;
	bh=SDe3bR6/TlqWOlbdFv3L2ztVWoTT66bjZktzp3aZjLc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jCl84/pCN3e2iOQd6UIIY4UBgX7/1rDUdJh/p2z6A//Au2fQFtE7ldQjAV1LH1BwKrF6mNffcpdw7ocm4wjOeKIgwyDhDXCK9Wh2r09fTOOXXWpAEU6CKATKBmhAcmNwCHKmH7ghQs1L+EkHy+TGl+diYppiWiO/uF4dVGXUpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eloji9zY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708496131; x=1740032131;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SDe3bR6/TlqWOlbdFv3L2ztVWoTT66bjZktzp3aZjLc=;
  b=Eloji9zYefCPAUwJFkwmrOgdsLWkcmZk6zueuEkK3TeUfwcXR6H2QAbr
   I28cs5IpQ5Ep/g39E0Xek/CwvTSxXbN3MYKI4tHDw64F15V/Pgud7iohN
   KziNiWOfwDe3guFYXwQyVN2QL8Qo9EaavXQCaK72z6Zb4IdQwRNO4ctuq
   +nchksMTNGj477vV9H5Yiu9kViZhreX1ptz+tiNEaDfjRKXjJru/j+aC4
   O/a4jm4T2ayFU9ZfetCA+mhFwZksB1b/QoMOpiYjxqYBIHYOD8GsB2ss+
   Lnc5ULwv7TzfcWt9CnQ4zb48hplGDvA6lHvgkDs6FNHwFOdtK2S20GqQZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20177488"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20177488"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5391553"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:15:27 -0800
Message-ID: <5f23b7b7-c76f-4076-b12d-909ddddd7905@linux.intel.com>
Date: Wed, 21 Feb 2024 14:15:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iommufd: IOPF-capable hw page table
 attach/detach/replace
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-7-baolu.lu@linux.intel.com>
 <CGME20240220135755eucas1p24e882cb5a735caed4bbfedb22a811442@eucas1p2.samsung.com>
 <20240220135752.vksznb4rdj73ln6c@joelS2.panther.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240220135752.vksznb4rdj73ln6c@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/20 21:57, Joel Granados wrote:
>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
>> index e752d1c49dde..a4a49f3cd4c2 100644
>> --- a/drivers/iommu/iommufd/fault.c
>> +++ b/drivers/iommu/iommufd/fault.c
>> @@ -267,3 +267,125 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
>>   
>>   	return 0;
>>   }
>> +
>> +static void release_attach_cookie(struct iopf_attach_cookie *cookie)
>> +{
>> +	struct iommufd_hw_pagetable *hwpt = cookie->domain->fault_data;
> There is a possibility here of cookie->domain being NULL. When you call
> release_attach_cookie from iommufd_fault_domain_attach_dev if
> idev->iopf_enabled is false. In this case, you have not set the domain
> yet.

Yes. Good catch!

> 
>> +	struct iommufd_device *idev = cookie->private;
>> +
>> +	refcount_dec(&idev->obj.users);
>> +	refcount_dec(&hwpt->obj.users);
> You should decrease this ref count only if the cookie actually had a
> domain.
> 
> This function could be something like this:
> 
> 	static void release_attach_cookie(struct iopf_attach_cookie *cookie)
> 	{
> 		struct iommufd_hw_pagetable *hwpt;
> 		struct iommufd_device *idev = cookie->private;
> 
> 		refcount_dec(&idev->obj.users);
> 		if (cookie->domain) {
> 			hwpt = cookie->domain->fault_data;
> 			refcount_dec(&hwpt->obj.users);
> 		}
> 		kfree(cookie);
> 	}

Yeah, fixed.

>> +	kfree(cookie);
>> +}
>> +
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	int ret;
>> +
>> +	if (idev->iopf_enabled)
>> +		return 0;
>> +
>> +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
>> +	if (ret)
>> +		return ret;
>> +
>> +	idev->iopf_enabled = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
>> +{
>> +	if (!idev->iopf_enabled)
>> +		return;
>> +
>> +	iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
>> +	idev->iopf_enabled = false;
>> +}
>> +
>> +int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
>> +				    struct iommufd_device *idev)
>> +{
>> +	struct iopf_attach_cookie *cookie;
>> +	int ret;
>> +
>> +	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
>> +	if (!cookie)
>> +		return -ENOMEM;
>> +
>> +	refcount_inc(&hwpt->obj.users);
>> +	refcount_inc(&idev->obj.users);
>> +	cookie->release = release_attach_cookie;
>> +	cookie->private = idev;
>> +
>> +	if (!idev->iopf_enabled) {
>> +		ret = iommufd_fault_iopf_enable(idev);
>> +		if (ret)
>> +			goto out_put_cookie;
> You have not set domain here and release_attach_cookie will try to
> access a null address.

Fixed as above.

Best regards,
baolu

