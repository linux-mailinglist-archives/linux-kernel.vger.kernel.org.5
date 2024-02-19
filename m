Return-Path: <linux-kernel+bounces-70692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCCC859B36
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4558EB216F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCA3C8FD;
	Mon, 19 Feb 2024 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOJIgNWA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58F3BA42
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315504; cv=none; b=uaLSFFsjUhkXs1RnIxt0VVA2kR+/xcDXwYleOQ5SgnDGpz0KWOwOqeDGJgrD9EE7RwdEru8X2h9AteJJgYC7zbC29n8UY+aNG3JGYmMSZJxmU356YiDhfLBCn3R13UWw8BpgOtyJYdeY4PrioVxOlOIx/JXqOqvTKxZyqHBWsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315504; c=relaxed/simple;
	bh=zQLU0AJCd4C7+v44PoIiipR1r/7I/88ZFX633zuwJL4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m4krlNpMLWOry2/ipCy9FEc1keOa2go60KZqul84yshehD/FKlC15LxyYPczQRokkIunci0h1BhWAxsWGcIis87tUzCjeRlRXXY7MZPK4Rp5xnaxULwCEhZxX6C/1ACyRXnz91UMN2o8v5wj4aYmlSFQD+quNOR4PnxTngJjUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOJIgNWA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708315503; x=1739851503;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQLU0AJCd4C7+v44PoIiipR1r/7I/88ZFX633zuwJL4=;
  b=aOJIgNWAMvvkwwkNVWdLiEShO4zl8lVTawqZYUl2zcKqme+GV9ILfEtJ
   h82gIcAhU+O8HnvO6W4O3+k6jJXeFuqSKn70H8+vOIHF9D7e7x9Y0ELnh
   P11CV5P3YAvWFiKn/Ecsf4vSB8GCDa2mfzHDnWBupnD6JQu9rEcb5JPuX
   d4E8PxJ2BrV5bSxpGnjVxaTT5k65jnmgZNGFPXnxYugGHFoMzVkFJnhe1
   m0DEg7aLO2jto6Y3bcnELsKJ2AogvZKJ7gFSJXNKz2sdRxBnIUAjUShg3
   SKzSHIOxgsC5iB03LxXqn8vXcOrwcwBj7qxC4AhKs3IrLSWLc1K+rPQTq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2506862"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2506862"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 20:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4766394"
Received: from kaiwang3-ivm.ccr.corp.intel.com (HELO [10.254.215.112]) ([10.254.215.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 20:04:59 -0800
Message-ID: <942dd645-7475-4c43-99c6-304601fb09eb@linux.intel.com>
Date: Mon, 19 Feb 2024 12:04:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Huang Jiaqing <jiaqing.huang@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Use rbtree to track iommu probed devices
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240215072249.4465-1-baolu.lu@linux.intel.com>
 <20240215072249.4465-2-baolu.lu@linux.intel.com>
 <eace2ec0-0b8b-450d-b05f-7b7ca3e473a7@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <eace2ec0-0b8b-450d-b05f-7b7ca3e473a7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/19 10:45, Ethan Zhao wrote:
>> @@ -4264,25 +4313,34 @@ static struct iommu_device 
>> *intel_iommu_probe_device(struct device *dev)
>>       }
>>       dev_iommu_priv_set(dev, info);
>> +    ret = device_rbtree_insert(iommu, info);
>> +    if (ret)
>> +        goto free;
>>       if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>>           ret = intel_pasid_alloc_table(dev);
>>           if (ret) {
>>               dev_err(dev, "PASID table allocation failed\n");
>> -            kfree(info);
>> -            return ERR_PTR(ret);
>> +            goto clear_rbtree;
>>           }
>>       }
>>       intel_iommu_debugfs_create_dev(info);
>>       return &iommu->iommu;
>> +clear_rbtree:
>> +    device_rbtree_remove(info);
>> +free:
>> +    kfree(info);
>> +
>> +    return ERR_PTR(ret);
>>   }
>>   static void intel_iommu_release_device(struct device *dev)
>>   {
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +    device_rbtree_remove(info);
> 
> Perhpas too early here to remove dev from the rbtree, if it is wanted in
> devTLB invalidation steps in intel_pasid_tear_down_entry().

Perhaps the caller of device_rbtree_find() should not depend on the
order in the release_device callback. For the device TLB invalidation
timed-out case, probably it could be checked in this way:

     struct device *dev = device_rbtree_find(iommu, ite_sid);
     if (!dev || !pci_device_is_present(to_pci_dev(dev)))
         return -ETIMEDOUT;

Best regards,
baolu

