Return-Path: <linux-kernel+bounces-74038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7B985CF27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D5E1C22A93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0036120;
	Wed, 21 Feb 2024 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4iHpw+s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C923C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487577; cv=none; b=OY8Gu9SPfC9rZTjQvYbCVoWj+NOJ32jlnBqoeClwjGohSlzueiEB8E4bT8MAl3MvB9rIm6a70YsRB9WPKW+ZKGrUBlQxu7YYYWfU89OkQ2+s7tnkyabEeyYkQEHTOat4HQnVfjC6jUCXxl1hRBU1DnpPp4kKtl7XZnYuUEsuxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487577; c=relaxed/simple;
	bh=wMXkiqGzzQswodcAtPpqIN0/SQsqU1RmoTmUsVBlmzo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ocSO4FNLFmcBr/HIFROkupIf8BjjLOi+Z9Z0SUDQF6P+nQ3mtk1VgVfUzNcM7irnoc5IaiB/pwXDajTCW4OH8GiVgPoF9RHLCdnkg0pNzfEe9LJ1xiY3sG3+G39svC1qIfbuFxCMnM/oN3NS6RFOh2EtiR9GuPYM0vf+1vsPi9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4iHpw+s; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708487576; x=1740023576;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wMXkiqGzzQswodcAtPpqIN0/SQsqU1RmoTmUsVBlmzo=;
  b=c4iHpw+s3ZLXAQktVxlhttA6MGW8ZMgPe9iFDZZVmPzPs2eodx2/ewb/
   YhHYQw8tCUvEvgWpD8RatmNirCHjI09LMmuPg1S8u9fXRjFJLyu3p5Kxb
   vCe+V6cPssMdOu6K/gbrStXIB1irzaq+A9yhbmEskjmyqtYGakGV/PCl0
   oW6I+fpBMTLa7ZVhtkUq6Pj5bTYfQLhTJbID/Nzd2CET4RPuUD6iJORYI
   fYZO4ulAXDXou6oGW3LZB3qT60oFb/Z75nt656OGBqSX6v4E0/vh3RJXG
   Wl5NIRRxfiBxQLlWNXBuyRKGoCjY5D+U8hrp+eLLxHIwP5+jpj7aGzVKh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2742510"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2742510"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9620072"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:52:51 -0800
Message-ID: <55a4b5e5-e0ad-4aa4-a29b-5fff4ef69063@linux.intel.com>
Date: Wed, 21 Feb 2024 11:52:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Zhang, Tina" <tina.zhang@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Hao Fang <fanghao11@huawei.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com>
 <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
 <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com>
 <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 10:45, Zhangfei Gao wrote:
> On Wed, 21 Feb 2024 at 10:06, Baolu Lu<baolu.lu@linux.intel.com> 
> wrote:
>> On 2024/2/21 9:28, Zhangfei Gao wrote:
>>> On Wed, 21 Feb 2024 at 07:58, Zhang, Tina<tina.zhang@intel.com> 
>>> wrote:
>>> 
>>>>>> struct iommu_sva *iommu_sva_bind_device(struct device
>>>>>> *dev, struct mm_struct *mm)  { +       struct
>>>>>> iommu_mm_data *iommu_mm; struct iommu_domain *domain;
>>>>>> struct iommu_sva *handle; int ret;
>>>>>> 
>>>>>> +       mutex_lock(&iommu_sva_lock); + /* Allocate 
>>>>>> mm->pasid if necessary. */ -       ret = 
>>>>>> iommu_sva_alloc_pasid(mm, dev); -       if (ret) - return
>>>>>> ERR_PTR(ret); +       iommu_mm = iommu_alloc_mm_data(mm,
>>>>>> dev); +       if (IS_ERR(iommu_mm)) { +               ret =
>>>>>> PTR_ERR(iommu_mm); + goto out_unlock; +       }
>>>>>> 
>>>>>> handle = kzalloc(sizeof(*handle), GFP_KERNEL); -       if 
>>>>>> (!handle) -               return ERR_PTR(-ENOMEM); - - 
>>>>>> mutex_lock(&iommu_sva_lock); -       /* Search for an 
>>>>>> existing domain. */ -       domain = 
>>>>>> iommu_get_domain_for_dev_pasid(dev, mm->pasid, - 
>>>>>> IOMMU_DOMAIN_SVA); -       if (IS_ERR(domain)) { - ret =
>>>>>> PTR_ERR(domain); +       if (!handle) { + ret = -ENOMEM;
>>>>>> goto out_unlock; }
>>>>>> 
>>>>>> -       if (domain) { -               domain->users++; - 
>>>>>> goto out;
>>>>> Our multi bind test case broke since 6.8-rc1. The test case 
>>>>> can use same domain & pasid, return different handle, 6.7 
>>>>> simply  domain->users ++ and return.
>>>>> 
>>>>>> +       /* Search for an existing domain. */ + 
>>>>>> list_for_each_entry(domain, &mm->iommu_mm->sva_domains, 
>>>>>> next)
>>>>> {
>>>>>> +               ret = iommu_attach_device_pasid(domain, 
>>>>>> dev, + iommu_mm->pasid);
>>>>> Now iommu_attach_device_pasid return BUSY since the same 
>>>>> pasid. And then iommu_sva_bind_device attach ret=-16
>>>> Sounds like the test case tries to bind a device to a same mm 
>>>> multiple times without unbinding the device and the
>>>> expectation is that it can always return a valid handle to pass
>>>> the test. Right?
>>> Yes
>>> 
>>> The device can bind to the same mm multi-times and return 
>>> different handle, Since the refcount, no need to unbind and bind 
>>> sequently, The unbind can happen later with the handle.
>> Is there any real use case to bind an mm to the pasid of a device 
>> multiple times? If there are cases, is it better to handle this in 
>> the uacce driver?
> Yes, it is required for multi-thread, the device can provide 
> multi-queue to speed up.
> 
>> From iommu core's perspective, it doesn't make sense to attach the 
>> same domain to the same device (or pasid) multiple times.
> But is it the refcount domain->user++ used for? Is there any reason 
> not doing this.

I was just thinking about whether to do this in the iommu core, or in
the upper layers, like uacce or iommufd. It seems that there is no need
to attach a domain to a device or pasid again if it has already been
attached.

Best regards,
baolu

