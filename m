Return-Path: <linux-kernel+bounces-73932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AB85CDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F17A1F2327A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9085235;
	Wed, 21 Feb 2024 02:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fb65mywo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653646BF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481195; cv=none; b=srp6ziouvP7uZZ1sg/uSPiG1UZCtZ03wAPMk4sRoONmqaDTqT5EoQ6WKJbffm/CX0/JGrNxFc4vN3mQia3uejX1+RBlBgEUedz2aqa6XfbloCwJh6+88Sc7FWpRykCqtFFTQp90hXiMYCAL32eNbQ01yQ9g3EWwbjfDlNdKB2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481195; c=relaxed/simple;
	bh=JSiLSOQicijItMCNe1a7ey0ZDSxnOiBGEs2FFWp8fjk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vhf09jREmaLQjp6+//pXfyrI+Uf6hNRJMvam8bSPHTyltNpyy6xMRoG3ii299MzmpFDHLNdK+bfReDhtK83SGIiYa70b15fJHBZP47YMe6xYsggA0285grAikJMqCYGVo2Np9Hduze7FTEyIXD+Fmm5ptyUyeI7+r5QOW/K4z84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fb65mywo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708481194; x=1740017194;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JSiLSOQicijItMCNe1a7ey0ZDSxnOiBGEs2FFWp8fjk=;
  b=Fb65mywo3q+d82ydOBplHSjoB6v7zc5sPNb2BrfEgGG8IQvG6MnPzXeT
   /FESUSxipzI7WXQtysIHTy9s7dfAGnLKpvbwEQWkiQbAJsxTHomVCU6x7
   3yZXwQk0V7Aez8S6Ge0GMeymHK+JHwTYlUYj6X92TsWlNXoMfYdscQrau
   26TdOi+BzYx0eClAvsuhCDQcyHfX/lXuOnd5zfSxhz32H2k1DVlP16YIZ
   Apc/DluZRswDPiM3vqgoQhEoJ7TV9+Xi+NJEAvYqaNiNZmCm075lxMOQ2
   8u4AFPU/IZ5oQvGO/RKNzthE2znTCZkE2wYUW4TL/AHK/UQT75S8oUJdg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2744325"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2744325"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5211699"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:06:29 -0800
Message-ID: <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com>
Date: Wed, 21 Feb 2024 10:06:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
To: Zhangfei Gao <zhangfei.gao@linaro.org>, "Zhang, Tina"
 <tina.zhang@intel.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com>
 <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 9:28, Zhangfei Gao wrote:
> On Wed, 21 Feb 2024 at 07:58, Zhang, Tina<tina.zhang@intel.com>  wrote:
> 
>>>>   struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>>>> mm_struct *mm)  {
>>>> +       struct iommu_mm_data *iommu_mm;
>>>>          struct iommu_domain *domain;
>>>>          struct iommu_sva *handle;
>>>>          int ret;
>>>>
>>>> +       mutex_lock(&iommu_sva_lock);
>>>> +
>>>>          /* Allocate mm->pasid if necessary. */
>>>> -       ret = iommu_sva_alloc_pasid(mm, dev);
>>>> -       if (ret)
>>>> -               return ERR_PTR(ret);
>>>> +       iommu_mm = iommu_alloc_mm_data(mm, dev);
>>>> +       if (IS_ERR(iommu_mm)) {
>>>> +               ret = PTR_ERR(iommu_mm);
>>>> +               goto out_unlock;
>>>> +       }
>>>>
>>>>          handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>>>> -       if (!handle)
>>>> -               return ERR_PTR(-ENOMEM);
>>>> -
>>>> -       mutex_lock(&iommu_sva_lock);
>>>> -       /* Search for an existing domain. */
>>>> -       domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
>>>> -                                               IOMMU_DOMAIN_SVA);
>>>> -       if (IS_ERR(domain)) {
>>>> -               ret = PTR_ERR(domain);
>>>> +       if (!handle) {
>>>> +               ret = -ENOMEM;
>>>>                  goto out_unlock;
>>>>          }
>>>>
>>>> -       if (domain) {
>>>> -               domain->users++;
>>>> -               goto out;
>>> Our multi bind test case broke since 6.8-rc1.
>>> The test case can use same domain & pasid, return different handle,
>>> 6.7 simply  domain->users ++ and return.
>>>
>>>> +       /* Search for an existing domain. */
>>>> +       list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next)
>>> {
>>>> +               ret = iommu_attach_device_pasid(domain, dev,
>>>> + iommu_mm->pasid);
>>> Now iommu_attach_device_pasid return BUSY since the same pasid.
>>> And then iommu_sva_bind_device attach ret=-16
>> Sounds like the test case tries to bind a device to a same mm multiple times without unbinding the device and the expectation is that it can always return a valid handle to pass the test. Right?
> Yes
> 
> The device can bind to the same mm multi-times and return different handle,
> Since the refcount, no need to unbind and bind sequently,
> The unbind can happen later with the handle.

Is there any real use case to bind an mm to the pasid of a device
multiple times? If there are cases, is it better to handle this in the
uacce driver?

 From iommu core's perspective, it doesn't make sense to attach the same
domain to the same device (or pasid) multiple times.

Best regards,
baolu

